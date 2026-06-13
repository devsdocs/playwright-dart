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
  int missingClasses = 0;
  int missingCommands = 0;

  for (final entry in protocol.entries) {
    final name = entry.key;
    final def = entry.value as Map;

    if (def['type'] == 'interface') {
      if (!dartContent.contains('abstract class ${name}Base extends')) {
        print('MISSING INTERFACE: $name');
        missingClasses++;
      }

      if (def.containsKey('commands')) {
        final commands = def['commands'] as Map;
        for (final cmdKey in commands.keys) {
          final cmdName = _sanitizeName(cmdKey.toString());
          if (!dartContent.contains('channel_$cmdName(')) {
            print('MISSING COMMAND: $name.$cmdName');
            missingCommands++;
          }
        }
      }
    } else if (def['type'] == 'object') {
      if (!dartContent.contains('class $name {')) {
        print('MISSING STRUCT: $name');
        missingClasses++;
      }
    } else if (def['type'] == 'enum') {
      if (!dartContent.contains('enum $name {')) {
        print('MISSING ENUM: $name');
        missingClasses++;
      }
    }
  }

  print('Cross-check complete.');
  if (missingClasses > 0 || missingCommands > 0) {
    print(
      'Found $missingClasses missing classes/structs and $missingCommands missing commands.',
    );
    exit(1);
  } else {
    print('All YML types map successfully to Dart types in channels.dart!');
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
