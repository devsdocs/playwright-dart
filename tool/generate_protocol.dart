import 'dart:io';

import 'dart:convert';

import 'package:yaml/yaml.dart';

import 'package:playwright_dart/src/utils/version.dart';

import 'get_all_protocol_yml.dart';

void main() async {
  final Map<String, dynamic> protocol = {};

  final Map<String, List<String>> protocolGroups = {};

  final version = await getPlaywrightVersion();

  print('Generating protocol for Playwright version $version...');

  final cacheDir = Directory('.protocol_cache/$version');

  if (!cacheDir.existsSync()) {
    cacheDir.createSync(recursive: true);
  }

  List<dynamic> files = await getAllProtocolYml(version);

  print('Fetching ${files.length} spec files...');

  for (final file in files) {
    if (file['name'].toString().endsWith('.yml')) {
      final name = file['name'].toString();

      final cachedYml = File('.protocol_cache/$version/$name');

      String content;

      if (cachedYml.existsSync()) {
        content = cachedYml.readAsStringSync();
      } else {
        final downloadUrl = file['download_url'].toString();

        final fileReq = await HttpClient().getUrl(Uri.parse(downloadUrl));

        final fileRes = await fileReq.close();

        content = await fileRes.transform(const Utf8Decoder()).join();

        cachedYml.writeAsStringSync(content);
      }

      final yaml = loadYaml(content) as YamlMap;

      for (final key in yaml.keys) {
        protocol[key.toString()] = yaml[key];
      }

      final groupName = name.split('.').first;

      final groupFiles = protocolGroups[groupName] ?? [];

      groupFiles.add(name);

      protocolGroups[groupName] = groupFiles;
    }
  }

  // Deep clone to make mutable

  dynamic deepClone(dynamic obj) {
    if (obj is YamlMap || obj is Map) {
      return (obj as Map).map((k, v) => MapEntry(k.toString(), deepClone(v)));
    } else if (obj is YamlList || obj is List) {
      return (obj as List).map((e) => deepClone(e)).toList();
    }

    return obj;
  }

  final mutableProtocol = deepClone(protocol) as Map<String, dynamic>;

  // Inject recordHar into ContextOptions

  if (mutableProtocol.containsKey('ContextOptions')) {
    final ctxOpts = mutableProtocol['ContextOptions'] as Map<String, dynamic>;

    if (ctxOpts.containsKey('properties')) {
      final props = ctxOpts['properties'] as Map<String, dynamic>;

      if (!props.containsKey('recordHar')) {
        props['recordHar'] = {'type': 'object?', '\$ref': 'RecordHarOptions'};
      }
    }
  }

  final interfaces = <String>{};

  for (final entry in mutableProtocol.entries) {
    if (entry.value['type'] == 'interface') {
      interfaces.add(entry.key);
    }
  }

  final List<Map<String, dynamic>> syntheticEnums = [];

  final List<Map<String, dynamic>> syntheticStructs = [];

  final Set<String> knownEnums = {};

  void extractEnumsRecursive(dynamic node, String prefix) {
    if (node is Map) {
      final typeStr = node['type']?.toString().replaceAll('?', '');

      if (typeStr == 'enum' && node.containsKey('literals')) {
        String enumName = '${prefix}Enum';

        enumName = enumName.replaceAll(
          'ItemsEnum',

          'Enum',
        ); // Clean up array item enums

        syntheticEnums.add({'name': enumName, 'literals': node['literals']});

        knownEnums.add(enumName);

        node['type'] = node['type'].toString().endsWith('?')
            ? '$enumName?'
            : enumName;
      } else if (typeStr == 'object' && node.containsKey('properties')) {
        String structName = prefix;

        final props = node['properties'] as Map;

        for (final key in props.keys.toList()) {
          extractEnumsRecursive(
            props[key],

            '$structName${capitalize(toCamelCase(key.toString()))}',
          );
        }

        syntheticStructs.add({'name': structName, 'properties': props});

        node['type'] = node['type'].toString().endsWith('?')
            ? '$structName?'
            : structName;

        node.remove('properties');
      } else {
        for (final key in node.keys.toList()) {
          extractEnumsRecursive(
            node[key],

            '$prefix${capitalize(toCamelCase(key.toString()))}',
          );
        }
      }
    } else if (node is List) {
      for (var i = 0; i < node.length; i++) {
        extractEnumsRecursive(node[i], '${prefix}Item');
      }
    }
  }

  // Populate top-level enums

  for (final entry in mutableProtocol.entries) {
    if (entry.value['type'] == 'enum') {
      knownEnums.add(entry.key);
    }
  }

  // Pre-pass: collect inline enums and returns structs

  for (final entry in mutableProtocol.entries) {
    final name = entry.key;

    final def = entry.value as Map<String, dynamic>;

    if (def['type'] == 'object' || def['type'] == 'mixin') {
      if (def.containsKey('properties')) {
        extractEnumsRecursive(def['properties'], name);
      }
    } else if (def['type'] == 'interface') {
      // Generate initializer struct for interfaces
      if (def.containsKey('initializer')) {
        final initializer = def['initializer'] as Map<String, dynamic>;
        final initializerName = '${name}Initializer';
        extractEnumsRecursive(initializer, initializerName);
        syntheticStructs.add({
          'name': initializerName,
          'properties': initializer,
        });
        def['initializerType'] = initializerName;
      }

      if (def.containsKey('commands')) {
        final commands = def['commands'] as Map<String, dynamic>;

        for (final cmdEntry in commands.entries) {
          final cmdName = cmdEntry.key;

          final cmdDef = cmdEntry.value as Map<String, dynamic>?;

          if (cmdDef != null) {
            if (cmdDef.containsKey('parameters')) {
              extractEnumsRecursive(
                cmdDef['parameters'],

                '$name${capitalize(toCamelCase(cmdName))}',
              );
            }

            if (cmdDef.containsKey('returns')) {
              final returnsMap = cmdDef['returns'] as Map<String, dynamic>;

              if (returnsMap.isNotEmpty) {
                final resultName =
                    '$name${capitalize(toCamelCase(cmdName))}Result';

                extractEnumsRecursive(returnsMap, resultName);

                syntheticStructs.add({
                  'name': resultName,

                  'properties': returnsMap,
                });

                cmdDef['returnsType'] = resultName;
              }
            }
          }
        }
      }

      if (def.containsKey('events')) {
        final events = def['events'] as Map<String, dynamic>;

        for (final evEntry in events.entries) {
          final evName = evEntry.key;

          final evDef = evEntry.value as Map<String, dynamic>?;

          if (evDef != null && evDef.containsKey('parameters')) {
            final eventName = '$name${capitalize(toCamelCase(evName))}Event';

            final paramsMap = evDef['parameters'] as Map<String, dynamic>;

            extractEnumsRecursive(paramsMap, eventName);

            syntheticStructs.add({'name': eventName, 'properties': paramsMap});
          }
        }
      }
    }
  }

  final buffer = StringBuffer();

  buffer.writeln(
    '// ignore_for_file: unused_local_variable, unnecessary_null_comparison, unused_field, annotate_overrides, non_constant_identifier_names, unnecessary_cast, invalid_null_aware_operator, curly_braces_in_flow_control_structures',
  );

  buffer.writeln('// AUTO-GENERATED FILE. DO NOT MODIFY.');

  buffer.writeln('// Generated from Playwright protocol.');

  buffer.writeln();

  buffer.writeln('import \'../infrastructure/channel_owner.dart\';');

  buffer.writeln('import \'../infrastructure/connection.dart\';');

  buffer.writeln();

  buffer.writeln();

  buffer.writeln(
    '/// Arbitrary JSON value (Playwright protocol type `json` / `any`).',
  );

  buffer.writeln('typedef JsonValue = Object?;');

  buffer.writeln();

  bool isJsonProtocolType(dynamic typeDef) {
    if (typeDef == null) return false;

    if (typeDef is String) {
      return typeDef.replaceAll('?', '') == 'json' ||
          typeDef.replaceAll('?', '') == 'any';
    }

    if (typeDef is Map) {
      final typeStr = typeDef['type']?.toString().replaceAll('?', '');

      return typeStr == 'json' || typeStr == 'any';
    }

    return false;
  }

  String resolveDartType(
    dynamic typeDef, {
    bool isOptional = false,
    String? fieldName,
  }) {
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
    } else if (typeDef is Map) {
      final typeStr = typeDef['type'] as String?;

      if (typeStr != null) {
        if (typeStr.endsWith('?')) {
          nullable = true;

          baseType = typeStr.substring(0, typeStr.length - 1);
        } else {
          baseType = typeStr;
        }
      }

      if (typeDef.containsKey(r'$ref')) {
        baseType = typeDef[r'$ref'] as String;
      }

      if (baseType == 'array') {
        final items = typeDef['items'];

        final itemType = resolveDartType(items);

        return 'List<$itemType>${nullable || isOptional ? '?' : ''}';
      }
    }

    String dartType;

    // Special handling for selector and locator fields
    if (fieldName == 'selector' || fieldName == 'locator') {
      if (baseType == 'string' || baseType == 'object') {
        dartType = 'Pattern';
      } else {
        dartType = baseType;
      }
    } else {
      switch (baseType) {
        case 'Channel':
          dartType = 'ChannelOwner';

          break;

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
          dartType = 'JsonValue';

          break;

        case 'object':
          dartType = 'Map<String, dynamic>';

          break;

        case 'binary':
          dartType = 'String';

          break;

        case 'json':
          dartType = 'JsonValue';

          break;

        default:
          dartType = baseType;

          if (interfaces.contains(dartType)) {
            dartType += 'Base';
          }

          break;
      }
    }

    if (dartType != 'JsonValue' && (nullable || isOptional)) {
      dartType += '?';
    }

    return dartType;
  }

  bool isPassThroughType(String type) {
    return type == 'dynamic' ||
        type == 'dynamic?' ||
        type == 'JsonValue' ||
        type == 'Map<String, dynamic>' ||
        type == 'Map<String, dynamic>?';
  }

  void generateProperties(
    StringBuffer out,

    String className,

    Map<String, dynamic> properties,
  ) {
    final fields = [];

    final sortedKeys = properties.keys.toList()..sort();

    for (final key in sortedKeys) {
      final propName = sanitizeName(key);

      final safeName = propName == 'enum'
          ? 'enumValue'
          : (propName == r'$mixin' ? r'\$mixin' : propName);

      final propDef = properties[key];

      final type = resolveDartType(propDef, fieldName: key);
      final description = propDef is Map
          ? propDef['description'] as String?
          : null;

      writeDocComment(out, description);
      out.writeln('  final $type $safeName;');

      fields.add({
        'name': safeName,

        'wireName': key,

        'nullable':
            type.endsWith('?') || type == 'dynamic' || type == 'JsonValue',

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

      out.writeln(
        '  factory $className.fromJson(Map<String, dynamic> json, {Connection? connection}) {',
      );

      out.writeln('    return $className(');

      for (final f in fields) {
        final name = f['name'];

        final wireName = f['wireName'];

        final type = f['type'] as String;

        String parser = 'json[r\'$wireName\']';

        if (type == 'dynamic' || type == 'dynamic?' || type == 'JsonValue') {
          // just map directly
        } else if (type == 'double' || type == 'double?') {
          parser = '(json[r\'$wireName\'] as num?)?.toDouble()';
        } else if (type.startsWith('Pattern')) {
          parser = 'json[r\'$wireName\'] as String?';
        } else if (type.startsWith('List<')) {
          final innerType = type.substring(
            5,

            type.length - (type.endsWith('?') ? 2 : 1),
          );

          if (innerType == 'double') {
            parser =
                '(json[r\'$wireName\'] as List?)?.map((e) => (e as num).toDouble()).toList()';
          } else if (innerType == 'String' ||
              innerType == 'int' ||
              innerType == 'bool' ||
              innerType == 'dynamic' ||
              innerType == 'JsonValue' ||
              innerType == 'Map<String, dynamic>') {
            parser = '(json[r\'$wireName\'] as List?)?.cast<$innerType>()';
          } else {
            // Enum or Object or Interface

            if (interfaces.contains(innerType.replaceAll('Base', '')) ||
                innerType == 'ChannelOwner' ||
                innerType == 'Channel') {
              final baseType = innerType == 'Channel'
                  ? 'ChannelOwner'
                  : innerType;

              parser =
                  'connection != null ? (json[r\'$wireName\'] as List?)?.map((e) => ChannelOwner.from<$baseType>(connection, e)).toList() : null';
            } else if (knownEnums.contains(innerType)) {
              parser =
                  '(json[r\'$wireName\'] as List?)?.map((e) => $innerType.values.firstWhere((v) => v.value == e)).toList()';
            } else {
              parser =
                  '(json[r\'$wireName\'] as List?)?.map((e) => $innerType.fromJson(e, connection: connection)).toList()';
            }
          }
        } else if (interfaces.contains(
              type.replaceAll('Base', '').replaceAll('?', ''),
            ) ||
            type.replaceAll('?', '') == 'ChannelOwner' ||
            type.replaceAll('?', '') == 'Channel') {
          final base =
              (type.replaceAll('?', '') == 'Channel' ||
                  type.replaceAll('?', '') == 'ChannelOwner')
              ? 'ChannelOwner'
              : type.replaceAll('?', '');

          parser =
              'connection != null && json[r\'$wireName\'] != null ? ChannelOwner.from<$base>(connection, json[r\'$wireName\']) : null';
        } else if (knownEnums.contains(type.replaceAll('?', ''))) {
          final enumBase = type.replaceAll('?', '');

          parser =
              'json[r\'$wireName\'] == null ? null : $enumBase.values.firstWhere((e) => e.value == json[r\'$wireName\'])';
        } else if (!type.startsWith('String') &&
            !type.startsWith('int') &&
            !type.startsWith('double') &&
            !type.startsWith('bool') &&
            !type.startsWith('Map') &&
            !type.startsWith('dynamic') &&
            type != 'JsonValue') {
          final objBase = type.replaceAll('?', '');

          parser =
              'json[r\'$wireName\'] == null ? null : $objBase.fromJson(json[r\'$wireName\'], connection: connection)';
        }

        if (!f['nullable']) {
          if (type.startsWith('List')) {
            parser = '($parser) ?? []';
          } else {
            parser = '($parser)!';
          }
        }

        out.writeln('      $name: $parser,');
      }

      out.writeln('    );');

      out.writeln('  }');

      out.writeln();

      out.writeln('  Map<String, dynamic> toJson() {');

      out.writeln('    return {');

      for (final f in fields) {
        final name = f['name'];

        final wireName = f['wireName'];

        final type = f['type'] as String;

        final nullable = f['nullable'] as bool;

        String valStr = name;

        if (type.startsWith('List<') &&
            !type.contains('dynamic') &&
            !type.contains('String') &&
            !type.contains('int') &&
            !type.contains('double') &&
            !type.contains('bool') &&
            !type.contains('Map')) {
          final innerType = type.substring(
            5,

            type.length - (type.endsWith('?') ? 2 : 1),
          );

          if (type.contains('Base') || type.contains('ChannelOwner')) {
            valStr =
                '$name${nullable ? "?" : ""}.map((e) => {\'guid\': e.guid}).toList()';
          } else if (knownEnums.contains(innerType)) {
            valStr = '$name${nullable ? "?" : ""}.map((e) => e.value).toList()';
          } else {
            valStr =
                '$name${nullable ? "?" : ""}.map((e) => e.toJson()).toList()';
          }
        } else if (!type.startsWith('List') &&
            !isPassThroughType(type) &&
            !type.startsWith('String') &&
            !type.startsWith('int') &&
            !type.startsWith('double') &&
            !type.startsWith('bool')) {
          if (knownEnums.contains(type.replaceAll('?', ''))) {
            valStr = '$name${nullable ? "?" : ""}.value';
          } else if (type.contains('Base') || type.contains('ChannelOwner')) {
            valStr = '{\'guid\': $name${nullable ? "?" : ""}.guid}';
          } else if (type.startsWith('Pattern')) {
            valStr = '$name${nullable ? "?" : ""}.toString()';
          } else {
            valStr = '$name${nullable ? "?" : ""}.toJson()';
          }
        }

        if (nullable) {
          out.writeln('      if ($name != null) r\'$wireName\': $valStr,');
        } else {
          out.writeln('      r\'$wireName\': $valStr,');
        }
      }

      out.writeln('    };');

      out.writeln('  }');
    } else {
      out.writeln('  $className();');

      out.writeln(
        '  factory $className.fromJson(Map<String, dynamic> json, {Connection? connection}) => $className();',
      );

      out.writeln('  Map<String, dynamic> toJson() => {};');
    }
  }

  // ALPHABETICAL SORTING

  // 1. Enums

  final allEnums = <Map<String, dynamic>>[];

  for (final entry in mutableProtocol.entries) {
    if (entry.value['type'] == 'enum') {
      allEnums.add({
        'name': entry.key,
        'literals': entry.value['literals'],
        'description': entry.value['description'],
      });
    }
  }

  allEnums.addAll(syntheticEnums);

  allEnums.sort((a, b) => a['name'].compareTo(b['name']));

  for (final en in allEnums) {
    final name = en['name'];
    final description = en['description'] as String?;

    writeDocComment(buffer, description);
    buffer.writeln('enum $name {');

    final literals = en['literals'] as List;

    for (var i = 0; i < literals.length; i++) {
      final literal = literals[i].toString();

      String dartName = toCamelCase(literal.replaceAll('-', '_'));

      if (dartName == 'default') {
        dartName = 'defaultValue';
      } else if (dartName == 'null') {
        dartName = 'nullValue';
      } else if (literal == 'Infinity') {
        dartName = 'infinity';
      } else if (literal == '-Infinity') {
        dartName = 'minusInfinity';
      } else if (literal == 'NaN') {
        dartName = 'nan';
      } else if (literal == '-0') {
        dartName = 'minusZero';
      }

      buffer.writeln(
        '  $dartName(\'$literal\')${i == literals.length - 1 ? ';' : ','}',
      );
    }

    buffer.writeln('  final String value;');

    buffer.writeln('  const $name(this.value);');

    buffer.writeln('}');

    buffer.writeln();
  }

  // 2. Structs

  final allStructs = <Map<String, dynamic>>[];

  for (final entry in mutableProtocol.entries) {
    if (entry.value['type'] == 'object' || entry.value['type'] == 'mixin') {
      allStructs.add({
        'name': entry.key,
        'properties': entry.value['properties'] ?? <String, dynamic>{},
        'description': entry.value['description'],
      });
    }
  }

  allStructs.addAll(syntheticStructs);

  allStructs.sort((a, b) => a['name'].compareTo(b['name']));

  for (final st in allStructs) {
    final name = st['name'];
    final description = st['description'] as String?;

    writeDocComment(buffer, description);
    buffer.writeln('class $name {');

    generateProperties(buffer, name, st['properties']);

    buffer.writeln('}');

    buffer.writeln();
  }

  // 3. Interfaces

  final allInterfaces = <Map<String, dynamic>>[];

  for (final entry in mutableProtocol.entries) {
    if (entry.value['type'] == 'interface') {
      allInterfaces.add({
        'name': entry.key,
        'def': entry.value,
        'description': entry.value['description'],
      });
    }
  }

  allInterfaces.sort((a, b) => a['name'].compareTo(b['name']));

  for (final intf in allInterfaces) {
    final name = intf['name'];
    final description = intf['description'] as String?;
    final def = intf['def'];

    final extendsYml = def['extends'] as String?;

    final extendsClause = extendsYml != null
        ? ' extends ${extendsYml}Base'
        : ' extends ChannelOwner';

    final channelExtendsClause = extendsYml != null
        ? ' extends ${extendsYml}Channel'
        : ' extends Channel';

    final covariantKeyword = extendsYml != null ? 'covariant ' : '';

    final initializerType = def['initializerType'] as String?;

    writeDocComment(buffer, description);
    buffer.writeln('abstract class ${name}Base$extendsClause {');

    if (def.containsKey('commands')) {
      if (extendsYml != null) {
        buffer.writeln('  // ignore: overridden_fields');
      }
      buffer.writeln(
        '  ${covariantKeyword}late ${name}Channel channel = ${name}Channel(this);',
      );
    }

    buffer.writeln(
      '  ${name}Base(super.connection, super.channelType, super.guid, super.initializer, [super.parent]);',
    );

    buffer.writeln();

    if (initializerType != null) {
      buffer.writeln(
        '  $initializerType get typedInitializer => $initializerType.fromJson(super.initializer, connection: connection);',
      );
    }

    buffer.writeln();
    buffer.writeln('}');
    buffer.writeln();

    if (def.containsKey('commands')) {
      buffer.writeln('class ${name}Channel$channelExtendsClause {');
      buffer.writeln('  ${name}Channel(super.owner);');
      buffer.writeln();
      final commands = def['commands'] as Map<String, dynamic>;

      final sortedCmds = commands.keys.toList()..sort();

      for (final cmdWireName in sortedCmds) {
        final cmdName = sanitizeName(cmdWireName);

        final cmdDef = commands[cmdWireName] as Map<String, dynamic>?;
        final cmdTitle = cmdDef?['title'] as String?;

        String paramsStr = '';

        final paramList = [];

        if (cmdDef != null && cmdDef.containsKey('parameters')) {
          final params = cmdDef['parameters'] as Map<String, dynamic>;

          final sortedParams = params.keys.toList()..sort();

          for (final pKey in sortedParams) {
            final pType = resolveDartType(params[pKey], fieldName: pKey);

            var pName = sanitizeName(pKey);

            if (pKey.startsWith(r'$mixin')) {
              final baseType = pType.replaceAll('?', '');

              pName =
                  baseType.substring(0, 1).toLowerCase() +
                  baseType.substring(1);
            }

            paramList.add({
              'name': pName,

              'type': pType,

              'wireName': pKey,

              'nullable':
                  pType.endsWith('?') ||
                  pType == 'dynamic' ||
                  pType == 'JsonValue',

              'isJson': isJsonProtocolType(params[pKey]),
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

        if (cmdDef != null && cmdDef.containsKey('returnsType')) {
          returnType = cmdDef['returnsType'];
        }

        writeDocComment(buffer, cmdTitle);
        buffer.writeln('  Future<$returnType> $cmdName($paramsStr) async {');

        if (paramList.isEmpty) {
          buffer.writeln(
            '    final response = await owner.connection.sendMessageToServer(owner.guid, \'$cmdWireName\', {});',
          );
        } else {
          buffer.writeln('    final payload = <String, dynamic>{};');

          for (final p in paramList) {
            final pName = p['name'];

            final pWire = p['wireName'];

            String val = pName;

            if (isPassThroughType(p['type'] as String) || p['isJson'] == true) {
              // Keep as is
            } else if (p['type'].startsWith('Pattern')) {
              val = '$pName${p['nullable'] ? '?' : ''}.toString()';
            } else if (!p['type'].startsWith('String') &&
                !p['type'].startsWith('int') &&
                !p['type'].startsWith('double') &&
                !p['type'].startsWith('bool') &&
                !p['type'].startsWith('List')) {
              final baseType = p['type']
                  .replaceAll('?', '')
                  .replaceAll('Base', '');

              if (interfaces.contains(baseType)) {
                val = '{\'guid\': $pName.guid}';
              } else if (knownEnums.contains(baseType)) {
                val = '$pName${p['nullable'] ? '?' : ''}.value';
              } else if (p['type'].endsWith('?')) {
                val = '$pName?.toJson()';
              } else {
                val = '$pName.toJson()';
              }
            }

            if (p['wireName'].startsWith(r'$')) {
              buffer.writeln(
                '    payload.addAll($val as Map<String, dynamic>);',
              );
            } else if (p['nullable']) {
              buffer.writeln(
                '    if ($pName != null) payload[\'$pWire\'] = $val;',
              );
            } else {
              buffer.writeln('    payload[\'$pWire\'] = $val;');
            }
          }

          buffer.writeln(
            '    final response = await owner.connection.sendMessageToServer(owner.guid, \'$cmdWireName\', payload);',
          );
        }

        if (returnType == 'void') {
          buffer.writeln('    return;');
        } else {
          buffer.writeln(
            '    return $returnType.fromJson(response, connection: owner.connection);',
          );
        }

        buffer.writeln('  }');
      }
    }

    if (def.containsKey('commands')) {
      buffer.writeln('}');
    }

    buffer.writeln();
  }

  final outDir = Directory('lib/src/generated');

  if (!outDir.existsSync()) outDir.createSync(recursive: true);

  final outFile = File('lib/src/generated/channels.dart');

  outFile.writeAsStringSync(buffer.toString());

  print('Generated ${outFile.path}');
}

String toCamelCase(String s) {
  if (s.isEmpty) return s;

  final parts = s.split('_');

  String result = parts[0];

  if (result.isNotEmpty) {
    result = result[0].toLowerCase() + result.substring(1);
  }

  return result +
      parts
          .skip(1)
          .map((w) => w.isEmpty ? '' : w[0].toUpperCase() + w.substring(1))
          .join('');
}

String capitalize(String s) =>
    s.isEmpty ? '' : '${s[0].toUpperCase()}${s.substring(1)}';

String sanitizeName(String name) {
  String cleanName = name;

  if (cleanName.startsWith(r'$')) cleanName = cleanName.substring(1);

  if (cleanName.startsWith('_')) cleanName = cleanName.substring(1);

  if (cleanName == 'return') return 'returnValue';

  if (cleanName == 'default') return 'defaultValue';

  if (cleanName == 'continue') return 'continueValue';

  if (cleanName == 'switch') return 'switchValue';

  if (cleanName == 'class') return 'classValue';

  if (cleanName == 'bool') return 'boolValue';

  if (cleanName == 'mixin') return 'mixinValue';

  if (cleanName == 'mixin1') return 'mixin1Value';

  if (cleanName == 'mixin2') return 'mixin2Value';

  return cleanName;
}

/// Generates Dart-style /// doc comment from YAML metadata.
void writeDocComment(StringBuffer out, String? description) {
  if (description != null && description.isNotEmpty) {
    final lines = description.split('\n');
    for (final line in lines) {
      out.writeln('/// $line');
    }
  }
}
