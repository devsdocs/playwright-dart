import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:playwright_dart/src/utils/version.dart';
import 'package:yaml/yaml.dart';

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
  print('Protocol count: ${mutableProtocol.length}');

  for (final group in mutableProtocol.entries) {
    debugYaml(group.value as Map<String, dynamic>);
  }
  print('Unique types found: ${allTypes.length}');
  print('Types: ${allTypes.join(', ')}');
  print('================================');
  print('Unique top-level fields found: ${allTopField.length}');
  print('Top-level fields: ${allTopField.join(', ')}');
}

final SplayTreeSet<String> allTypes = SplayTreeSet<String>();
final SplayTreeSet<CustomRecordsComparator> allTopField =
    SplayTreeSet<CustomRecordsComparator>();

void debugYaml(Map<String, dynamic> yaml, {bool isTopLevel = true}) {
  if (isTopLevel) {
    allTopField.addAll(
      yaml.keys.map(
        (k) => CustomRecordsComparator(
          k.toString(),
          yaml[k].runtimeType.toString(),
        ),
      ),
    );
  }
  for (final entry in yaml.entries) {
    if (entry.value is String) {
      final valueStr = entry.value.toString();

      if (!valueStr.contains(' ') &&
          valueStr[0].toLowerCase() == valueStr[0] &&
          ['group'].every((e) => entry.key.toString() != e)) {
        if (valueStr.endsWith('?')) {
          allTypes.add(valueStr.replaceAll('?', ''));
        } else {
          allTypes.add(valueStr);
        }
      }
    }
    if (entry.value is Map) {
      debugYaml(entry.value as Map<String, dynamic>, isTopLevel: false);
    } else if (entry.value is List) {
      for (final item in entry.value as List) {
        if (item is Map) {
          debugYaml(item as Map<String, dynamic>, isTopLevel: false);
        } else {}
      }
    } else {}
  }
}

class CustomRecordsComparator implements Comparable<CustomRecordsComparator> {
  CustomRecordsComparator(this.value1, this.value2);
  final String value1;
  final String value2;
  @override
  int compareTo(CustomRecordsComparator other) {
    final firstCompare = value1.compareTo(other.value1);
    if (firstCompare != 0) {
      return firstCompare;
    }
    return value2.compareTo(other.value2);
  }

  @override
  String toString() => '$value1: $value2';
}
