import 'dart:io';
import 'dart:convert';
import 'package:yaml/yaml.dart';
import 'package:playwright_dart/src/version.dart';

void main() async {
  final Map<String, dynamic> protocol = {};

  List<dynamic> files = await getAllProtocolYml();

  print('Fetching ${files.length} spec files from GitHub...');
  for (final file in files) {
    if (file['name'].toString().endsWith('.yml')) {
      final downloadUrl = file['download_url'];
      final fileReq = await HttpClient().getUrl(Uri.parse(downloadUrl));
      final fileRes = await fileReq.close();
      final content = await fileRes.transform(const Utf8Decoder()).join();
      final yaml = loadYaml(content) as YamlMap;
      for (final key in yaml.keys) {
        protocol[key.toString()] = yaml[key];
      }
    }
  }

  final interfaces = <String>{};
  for (final entry in protocol.entries) {
    if ((entry.value as YamlMap)['type'] == 'interface') {
      interfaces.add(entry.key);
    }
  }

  final buffer = StringBuffer();
  buffer.writeln(
    '// ignore_for_file: unused_local_variable, unnecessary_null_comparison, unused_field, annotate_overrides, non_constant_identifier_names',
  );
  buffer.writeln('// AUTO-GENERATED FILE. DO NOT MODIFY.');
  buffer.writeln('// Generated from Playwright protocol.');
  buffer.writeln();
  buffer.writeln('import \'../channel_owner.dart\';');
  buffer.writeln();
  buffer.writeln('abstract class Channel {}');
  buffer.writeln();

  String resolveDartType(dynamic typeDef, {bool isOptional = false}) {
    if (typeDef == null) return 'dynamic';

    String baseType = 'dynamic';
    bool nullable = false;

    if (typeDef is String) {
      if (typeDef.endsWith('?')) {
        nullable = true;
        baseType = typeDef.substring(0, typeDef.length - 1);
      } else {
        baseType = typeDef;
      }
    } else if (typeDef is YamlMap) {
      final typeStr = typeDef['type'] as String?;
      if (typeStr != null) {
        if (typeStr.endsWith('?')) {
          nullable = true;
          baseType = typeStr.substring(0, typeStr.length - 1);
        } else {
          baseType = typeStr;
        }
      }

      if (baseType == 'array') {
        final items = typeDef['items'];
        final itemType = resolveDartType(items);
        return 'List<$itemType>${nullable || isOptional ? '?' : ''}';
      }
    }

    String dartType;
    switch (baseType) {
      case 'string':
        dartType = 'String';
        break;
      case 'int':
        dartType = 'int';
        break;
      case 'float':
        dartType = 'double';
        break;
      case 'boolean':
        dartType = 'bool';
        break;
      case 'any':
        dartType = 'dynamic';
        break;
      case 'object':
        dartType = 'Map<String, dynamic>';
        break;
      case 'binary':
        dartType = 'String';
        break;
      case 'json':
        dartType = 'Map<String, dynamic>';
        break;
      case 'enum':
        dartType = 'String';
        break;
      default:
        dartType = baseType;
        if (interfaces.contains(dartType)) {
          dartType += 'Base';
        }
        break;
    }

    if (dartType != 'dynamic' && (nullable || isOptional)) {
      dartType += '?';
    }
    return dartType;
  }

  String sanitizeName(String name) {
    if (name == 'return') return 'returnValue';
    if (name == 'default') return 'defaultValue';
    if (name == 'continue') return 'continueValue';
    if (name == 'switch') return 'switchValue';
    if (name == 'class') return 'classValue';
    if (name.startsWith(r'$')) return name.substring(1);
    return name;
  }

  String toCamelCase(String s) {
    final parts = s.split('_');
    if (parts.length == 1) return parts[0];
    return parts[0] +
        parts
            .skip(1)
            .map((w) => w.isEmpty ? '' : w[0].toUpperCase() + w.substring(1))
            .join('');
  }

  void generateProperties(
    StringBuffer out,
    String className,
    YamlMap properties,
  ) {
    final fields = [];
    for (final entry in properties.entries) {
      final propName = sanitizeName(entry.key.toString());
      final safeName = propName == 'enum' ? 'enumValue' : propName;
      final propDef = entry.value;
      final type = resolveDartType(propDef);
      out.writeln('  final $type $safeName;');
      fields.add({
        'name': safeName,
        'wireName': entry.key.toString(),
        'nullable': type.endsWith('?') || type == 'dynamic',
        'type': type,
      });
    }
    out.writeln();
    if (fields.isNotEmpty) {
      out.writeln('  $className({');
      for (final f in fields) {
        if (f['nullable']) {
          out.writeln('    this.${f['name']},');
        } else {
          out.writeln('    required this.${f['name']},');
        }
      }
      out.writeln('  });');
      out.writeln();

      out.writeln('  Map<String, dynamic> toJson() {');
      out.writeln('    return {');
      for (final f in fields) {
        final name = f['name'];
        final wireName = f['wireName'];
        if (f['nullable']) {
          out.writeln('      if ($name != null) \'$wireName\': $name,');
        } else {
          out.writeln('      \'$wireName\': $name,');
        }
      }
      out.writeln('    };');
      out.writeln('  }');
    } else {
      out.writeln('  $className();');
      out.writeln('  Map<String, dynamic> toJson() => {};');
    }
  }

  // 1. Generate Enums
  for (final entry in protocol.entries) {
    final name = entry.key;
    final def = entry.value as YamlMap;
    if (def['type'] == 'enum') {
      buffer.writeln('enum $name {');
      final literals = def['literals'] as YamlList;
      for (var i = 0; i < literals.length; i++) {
        final literal = literals[i].toString();
        String dartName = toCamelCase(literal.replaceAll('-', '_'));
        if (dartName == 'default') dartName = 'defaultValue';
        buffer.writeln(
          '  $dartName(\'$literal\')${i == literals.length - 1 ? ';' : ','}',
        );
      }
      buffer.writeln('  final String value;');
      buffer.writeln('  const $name(this.value);');
      buffer.writeln('}');
      buffer.writeln();
    }
  }

  // 2. Generate Structs and Mixins
  for (final entry in protocol.entries) {
    final name = entry.key;
    final def = entry.value as YamlMap;
    if (def['type'] == 'object' || def['type'] == 'mixin') {
      buffer.writeln('class $name {');
      if (def.containsKey('properties')) {
        generateProperties(buffer, name, def['properties'] as YamlMap);
      } else {
        buffer.writeln('  $name();');
        buffer.writeln('  Map<String, dynamic> toJson() => {};');
      }
      buffer.writeln('}');
      buffer.writeln();
    }
  }

  // 3. Generate Interfaces (as Base classes extending ChannelOwner)
  for (final entry in protocol.entries) {
    final name = entry.key;
    final def = entry.value as YamlMap;
    if (def['type'] == 'interface') {
      final ext = def['extends'] as String?;
      final extendsClause = ext != null
          ? ' extends ${ext}Base'
          : ' extends ChannelOwner';

      buffer.writeln('abstract class ${name}Base$extendsClause {');
      buffer.writeln(
        '  ${name}Base(super.connection, super.channelType, super.guid, super.initializer, [super.parent]);',
      );
      buffer.writeln();

      if (def.containsKey('commands')) {
        final commands = def['commands'] as YamlMap;
        for (final cmdEntry in commands.entries) {
          final cmdWireName = cmdEntry.key.toString();
          final cmdName = sanitizeName(cmdWireName);
          final cmdDef = cmdEntry.value as YamlMap?;

          String paramsStr = '';
          final paramList = [];
          if (cmdDef != null && cmdDef.containsKey('parameters')) {
            final params = cmdDef['parameters'] as YamlMap;
            for (final p in params.entries) {
              var pName = sanitizeName(p.key.toString());
              final pType = resolveDartType(p.value);
              paramList.add({
                'name': pName,
                'type': pType,
                'wireName': p.key.toString(),
                'nullable': pType.endsWith('?') || pType == 'dynamic',
              });
            }
            if (paramList.isNotEmpty) {
              final sigParams = paramList.map(
                (p) =>
                    '${p['nullable'] ? '' : 'required '}${p['type']} ${p['name']}',
              );
              paramsStr = '{${sigParams.join(', ')}}';
            }
          }

          String returnType = 'void';
          if (cmdDef != null && cmdDef.containsKey('returns')) {
            returnType = 'Map<String, dynamic>';
          }

          buffer.writeln(
            '  Future<$returnType> channel_$cmdName($paramsStr) async {',
          );
          if (paramList.isEmpty) {
            buffer.writeln(
              '    final response = await connection.sendMessageToServer(guid, \'$cmdWireName\', {});',
            );
          } else {
            buffer.writeln('    final params = <String, dynamic>{};');
            for (final p in paramList) {
              final pName = p['name'];
              final pWire = p['wireName'];

              String val = pName;
              if (p['type'] == 'Map<String, dynamic>' ||
                  p['type'] == 'Map<String, dynamic>?') {
                // Keep as is
              } else if (!p['type'].startsWith('String') &&
                  !p['type'].startsWith('int') &&
                  !p['type'].startsWith('double') &&
                  !p['type'].startsWith('bool') &&
                  !p['type'].startsWith('List')) {
                if (interfaces.contains(
                  p['type'].replaceAll('?', '').replaceAll('Base', ''),
                )) {
                  val = '$pName${p['nullable'] ? '?' : ''}.guid';
                } else if (p['type'].contains('Base')) {
                  val = '$pName${p['nullable'] ? '?' : ''}.guid';
                } else if (p['type'].endsWith('?') &&
                    !p['type'].contains('List')) {
                  if (p['type'] == 'dynamic') {
                  } else {
                    val = '$pName?.toJson() ?? $pName?.value'; // naive fallback
                  }
                } else if (!p['type'].contains('List')) {
                  val = '($pName as dynamic).toJson()';
                }
              }

              String toAssign = val;
              if (!p['type'].startsWith('String') &&
                  !p['type'].startsWith('int') &&
                  !p['type'].startsWith('double') &&
                  !p['type'].startsWith('bool') &&
                  !p['type'].startsWith('List') &&
                  p['type'] != 'dynamic') {
                final baseT = p['type'].replaceAll('?', '');
                if (interfaces.contains(baseT.replaceAll('Base', ''))) {
                  toAssign = '$pName${p['nullable'] ? '?' : ''}.guid';
                } else {
                  toAssign =
                      '((v) => v is Enum ? (v as dynamic).value : (v is Map ? v : (v as dynamic).toJson()))($pName)';
                }
              }

              if (p['wireName'].startsWith('\$')) {
                buffer.writeln(
                  '    params.addAll($toAssign as Map<String, dynamic>);',
                );
              } else if (p['nullable']) {
                buffer.writeln(
                  '    if ($pName != null) params[\'$pWire\'] = $toAssign;',
                );
              } else {
                buffer.writeln('    params[\'$pWire\'] = $toAssign;');
              }
            }
            buffer.writeln(
              '    final response = await connection.sendMessageToServer(guid, \'$cmdWireName\', params);',
            );
          }
          if (returnType == 'void') {
            buffer.writeln('    return;');
          } else {
            buffer.writeln('    return response;');
          }
          buffer.writeln('  }');
        }
      }
      buffer.writeln('}');
      buffer.writeln();
    }
  }

  final outDir = Directory('lib/src/generated');
  if (!outDir.existsSync()) outDir.createSync(recursive: true);

  final outFile = File('lib/src/generated/channels.dart');
  outFile.writeAsStringSync(buffer.toString());
  print('Generated ${outFile.path}');
}

Future<List<dynamic>> getAllProtocolYml() async {
  final version = await getPlaywrightVersion();
  print('Resolving Playwright protocol for version $version...');

  final response = await HttpClient().getUrl(
    Uri.parse(
      'https://api.github.com/repos/microsoft/playwright/contents/packages/protocol/spec?ref=v$version',
    ),
  );
  final request = await response.close();
  final body = await request.transform(const Utf8Decoder()).join();

  if (request.statusCode != 200) {
    print('Failed to fetch protocol specs from GitHub: $body');
    exit(1);
  }

  final List<dynamic> files = jsonDecode(body);
  return files;
}
