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

  String? extractParamType(String sig, String paramName) {
    int idx = sig.indexOf(RegExp('\\b$paramName\\b'));
    if (idx == -1) return null;
    String before = sig.substring(0, idx).trim();
    int lastComma = -1;
    int openParenCount = 0;
    int openBracketCount = 0;
    for (int i = before.length - 1; i >= 0; i--) {
      if (before[i] == '>') {
        openParenCount++;
      } else if (before[i] == '<') {
        openParenCount--;
      } else if (before[i] == ',' &&
          openParenCount == 0 &&
          openBracketCount == 0) {
        lastComma = i;
        break;
      } else if (before[i] == '{' || before[i] == '[') {
        lastComma = i;
        break;
      }
    }
    String typeAndKeywords = before.substring(lastComma + 1).trim();
    typeAndKeywords = typeAndKeywords
        .replaceAll('required ', '')
        .replaceAll('covariant ', '');
    return typeAndKeywords.isEmpty ? 'dynamic' : typeAndKeywords;
  }

  int missingClasses = 0;
  int missingCommands = 0;
  int missingWrapperClasses = 0;
  int missingWrapperCommands = 0;
  int missingWrapperEvents = 0;
  int missingWrapperParameters = 0;
  int typeMismatches = 0;

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
          } else {
            final cmdDef = commands[cmdKey];
            if (cmdDef != null && cmdDef['parameters'] != null) {
              final params = cmdDef['parameters'] as Map;
              final sigMatch = RegExp(
                '\\b$targetCmdName\\s*\\(([^)]*)\\)',
              ).firstMatch(targetClassBody);
              if (sigMatch != null) {
                final sig = sigMatch.group(1)!;
                for (final paramKey in params.keys) {
                  final keyStr = paramKey.toString();
                  if (keyStr.startsWith(r'$')) {
                    continue; // Ignore mixins and refs
                  }
                  final paramName = _sanitizeName(keyStr);
                  if (!sig.contains(RegExp('\\b$paramName\\b'))) {
                    print(
                      'MISSING IN WRAPPER: Parameter $paramName in command $name.$cmdName ($targetClassName.$targetCmdName)',
                    );
                    missingWrapperParameters++;
                  } else {
                    final channelSigMatch = RegExp(
                      '\\bchannel_$cmdName\\s*\\(([^)]*)\\)',
                    ).firstMatch(dartContent);
                    if (channelSigMatch != null) {
                      String channelSig = channelSigMatch.group(1)!;
                      String? channelParamType = extractParamType(
                        channelSig,
                        paramName,
                      );
                      String? wrapperParamType = extractParamType(
                        sig,
                        paramName,
                      );

                      if (channelParamType != null &&
                          wrapperParamType != null) {
                        String cleanChannelType = channelParamType.replaceAll(
                          '?',
                          '',
                        );
                        String cleanWrapperType = wrapperParamType.replaceAll(
                          '?',
                          '',
                        );

                        bool isNativeType(String t) {
                          if (t == 'Object' || t == 'void') return true;
                          return t == 'String' ||
                              t == 'int' ||
                              t == 'double' ||
                              t == 'num' ||
                              t == 'bool' ||
                              t == 'dynamic' ||
                              t.startsWith('Map<') ||
                              t == 'Map' ||
                              t == 'List<String>' ||
                              t == 'List<int>' ||
                              t == 'List<double>' ||
                              t == 'List<num>' ||
                              t == 'List<bool>' ||
                              t == 'List<dynamic>' ||
                              t.startsWith('List<Map') ||
                              t.startsWith('List<Object>');
                        }

                        if (cleanChannelType == 'SerializedArgument' ||
                            cleanChannelType == 'SerializedError') {
                          // Ignore serialized wrapper arguments
                          continue;
                        }

                        bool channelIsCustom = !isNativeType(cleanChannelType);
                        bool wrapperIsNative = isNativeType(cleanWrapperType);

                        if (channelIsCustom && wrapperIsNative) {
                          print(
                            "PARAMETER TYPE MISMATCH: $name.$cmdName parameter '$paramName' - Wrapper uses native '$wrapperParamType' but Channel expects '$channelParamType'",
                          );
                          typeMismatches++;
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }

      if (def.containsKey('events')) {
        final events = def['events'] as Map;
        for (final eventKey in events.keys) {
          final eventName = _sanitizeName(eventKey.toString());
          String expectedGetterName =
              'on${eventName[0].toUpperCase()}${eventName.substring(1)}';

          if (!wrapperClassBody.contains(
                RegExp('get\\s+$expectedGetterName\\b'),
              ) &&
              !wrapperClassBody.contains(
                RegExp('Stream<.*>\\s+$expectedGetterName\\b'),
              )) {
            print(
              'MISSING IN WRAPPER: Event $eventName (expected getter $expectedGetterName in $wrapperClassName)',
            );
            missingWrapperEvents++;
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
      missingWrapperCommands > 0 ||
      missingWrapperEvents > 0 ||
      missingWrapperParameters > 0 ||
      typeMismatches > 0) {
    print(
      'Found $missingClasses missing classes/structs and $missingCommands missing commands in generated channels.',
    );
    print(
      'Found $missingWrapperClasses missing interface wrappers, $missingWrapperCommands missing wrapper commands, $missingWrapperEvents missing wrapper events, $missingWrapperParameters missing wrapper parameters, and $typeMismatches parameter type mismatches in lib/src.',
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
