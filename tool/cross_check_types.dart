import 'dart:io';
import 'package:yaml/yaml.dart';

void main() async {
  print('Loading cached protocol YML files...');
  final cacheDir = Directory('.protocol_cache');
  if (!cacheDir.existsSync()) {
    print('Please run generate_protocol.dart first to cache YML files.');
    exit(1);
  }

  final protocol = <String, dynamic>{};
  for (final entity in cacheDir.listSync()) {
    if (entity is File && entity.path.endsWith('.yml')) {
      final content = entity.readAsStringSync();
      final yaml = loadYaml(content) as YamlMap;
      for (final key in yaml.keys) {
        protocol[key.toString()] = yaml[key];
      }
    }
  }

  final dartFile = File('lib/src/generated/channels.dart');
  if (!dartFile.existsSync()) {
    print('Generated file not found.');
    exit(1);
  }
  final dartContent = dartFile.readAsStringSync();

  String allSrcContent = '';
  final srcDir = Directory('lib/src');
  for (final entity in srcDir.listSync(recursive: true)) {
    if (entity is File &&
        entity.path.endsWith('.dart') &&
        !entity.path.contains('generated')) {
      allSrcContent += '${entity.readAsStringSync()}\n';
    }
  }

  String? extractClassBody(String content, String className) {
    final regex = RegExp('class\\s+$className\\b');
    final match = regex.firstMatch(content);
    if (match == null) return null;

    int braceStartIndex = content.indexOf('{', match.start);
    if (braceStartIndex == -1) return null;

    int braceCount = 1;
    int endIndex = braceStartIndex + 1;
    while (braceCount > 0 && endIndex < content.length) {
      if (content[endIndex] == '{') braceCount++;
      if (content[endIndex] == '}') braceCount--;
      endIndex++;
    }

    return content.substring(braceStartIndex, endIndex);
  }

  int missingClasses = 0;
  int missingCommands = 0;
  int missingWrapperClasses = 0;
  int missingWrapperCommands = 0;

  for (final entry in protocol.entries) {
    final name = entry.key;
    final def = entry.value as Map;

    if (def['type'] == 'interface') {
      if (!dartContent.contains('abstract class ${name}Base extends')) {
        print('MISSING IN CHANNELS: Interface $name');
        missingClasses++;
      }

      // Wrapper check
      String wrapperClassName = name;
      if (name == 'Stream') wrapperClassName = 'PlaywrightStream';
      if (name == 'WebSocket') wrapperClassName = 'PlaywrightWebSocket';

      final wrapperClassBody = extractClassBody(
        allSrcContent,
        wrapperClassName,
      );
      if (wrapperClassBody == null) {
        print('MISSING IN WRAPPER: Class $wrapperClassName (YAML: $name)');
        missingWrapperClasses++;
        continue;
      }

      if (def.containsKey('commands')) {
        final commands = def['commands'] as Map;
        for (final cmdKey in commands.keys) {
          final cmdName = _sanitizeName(cmdKey.toString());
          if (!dartContent.contains('channel_$cmdName(')) {
            print('MISSING IN CHANNELS: Command $name.$cmdName');
            missingCommands++;
          }

          String targetClassName = wrapperClassName;
          String targetCmdName = cmdName;

          if (name == 'Page') {
            if (cmdName.startsWith('keyboard')) {
              targetClassName = 'Keyboard';
              targetCmdName = cmdName.replaceFirst('keyboard', '');
            } else if (cmdName.startsWith('mouse')) {
              targetClassName = 'Mouse';
              targetCmdName = cmdName.replaceFirst('mouse', '');
            } else if (cmdName.startsWith('touchscreen')) {
              targetClassName = 'Touchscreen';
              targetCmdName = cmdName.replaceFirst('touchscreen', '');
            }
          } else if (name == 'BrowserContext' &&
              cmdName.startsWith('tracing')) {
            targetClassName = 'Tracing';
            targetCmdName = cmdName.replaceFirst('tracing', '');
          }

          if (targetCmdName.isNotEmpty && targetCmdName != cmdName) {
            targetCmdName =
                targetCmdName[0].toLowerCase() + targetCmdName.substring(1);
          }

          final targetClassBody = targetClassName == wrapperClassName
              ? wrapperClassBody
              : extractClassBody(allSrcContent, targetClassName);
          if (targetClassBody == null) {
            print(
              'MISSING IN WRAPPER: Target Class $targetClassName for mapped command $name.$cmdName',
            );
            missingWrapperClasses++;
            continue;
          }

          if (!targetClassBody.contains(RegExp('\\b$targetCmdName\\(')) &&
              !targetClassBody.contains(RegExp('get\\s+$targetCmdName\\b'))) {
            print(
              'MISSING IN WRAPPER: Command $name.$cmdName (expected in $targetClassName as $targetCmdName)',
            );
            missingWrapperCommands++;
          }
        }
      }
    } else if (def['type'] == 'object') {
      if (!dartContent.contains('class $name {')) {
        print('MISSING IN CHANNELS: Struct $name');
        missingClasses++;
      }
    } else if (def['type'] == 'enum') {
      if (!dartContent.contains('enum $name {')) {
        print('MISSING IN CHANNELS: Enum $name');
        missingClasses++;
      }
    }
  }

  print('Cross-check complete.');
  if (missingClasses > 0 ||
      missingCommands > 0 ||
      missingWrapperClasses > 0 ||
      missingWrapperCommands > 0) {
    print(
      'Found $missingClasses missing classes/structs and $missingCommands missing commands in generated channels.',
    );
    print(
      'Found $missingWrapperClasses missing interface wrappers and $missingWrapperCommands missing wrapper commands in lib/src.',
    );
    exit(1);
  } else {
    print(
      'All YML types map successfully to Dart types in channels.dart and wrapper classes!',
    );
  }
}

String _sanitizeName(String name) {
  if (name == 'return') return 'returnValue';
  if (name == 'default') return 'defaultValue';
  if (name == 'continue') return 'continueValue';
  if (name == 'switch') return 'switchValue';
  if (name == 'class') return 'classValue';
  if (name == 'bool') return 'boolValue';
  if (name.startsWith(r'$')) return name.substring(1);
  if (name.startsWith('_')) return name.substring(1);
  return name;
}
