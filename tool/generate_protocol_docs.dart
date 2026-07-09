/// Generates two Markdown documents:
///
/// 1. `doc/protocol_api.md`  — Playwright protocol reference, auto-fetched
///    from the upstream GitHub repo and regenerated from the cached YAML.
///
/// 2. `doc/dart_api.md`      — Dart public API reference, extracted from
///    `/// ` doc-comments in `lib/src/`.
///
/// Run with:
///   dart tool/generate_protocol_docs.dart
///
/// Pass `--no-fetch` to skip the GitHub fetch and use the local cache as-is.
library;

import 'dart:convert';
import 'dart:io';

import 'package:yaml/yaml.dart';
import 'package:playwright_dart/src/utils/version.dart';
import 'get_all_protocol_yml.dart';

// ============================================================================
// Entry point
// ============================================================================

void main(List<String> args) async {
  final noFetch = args.contains('--no-fetch');

  final version = await getPlaywrightVersion();
  print('Playwright version: $version');

  // ------------------------------------------------------------------
  // 1. Fetch / refresh protocol YAML from GitHub
  // ------------------------------------------------------------------
  if (!noFetch) {
    await _fetchProtocol(version);
  } else {
    print('Skipping GitHub fetch (--no-fetch).');
  }

  // ------------------------------------------------------------------
  // 2. Load merged protocol
  // ------------------------------------------------------------------
  final protocol = _loadProtocol(version);

  // ------------------------------------------------------------------
  // 3. Generate protocol API doc
  // ------------------------------------------------------------------
  final protocolDoc = _buildProtocolDoc(protocol, version);
  final protocolOut = File('doc/protocol_api.md');
  Directory('doc').createSync();
  protocolOut.writeAsStringSync(protocolDoc);
  print('Generated ${protocolOut.path} (${protocolOut.lengthSync()} bytes)');

  // ------------------------------------------------------------------
  // 4. Generate Dart API doc
  // ------------------------------------------------------------------
  final dartDoc = _buildDartApiDoc();
  final dartOut = File('doc/dart_api.md');
  dartOut.writeAsStringSync(dartDoc);
  print('Generated ${dartOut.path} (${dartOut.lengthSync()} bytes)');
}

// ============================================================================
// Protocol fetch
// ============================================================================

Future<void> _fetchProtocol(String version) async {
  final cacheDir = Directory('.protocol_cache/$version');
  cacheDir.createSync(recursive: true);

  print('Fetching protocol spec list from GitHub (v$version)...');
  final files = await getAllProtocolYml(version);

  for (final file in files) {
    final name = file['name'].toString();
    if (!name.endsWith('.yml')) continue;

    final cachedYml = File('.protocol_cache/$version/$name');
    if (cachedYml.existsSync()) {
      // Already cached — skip download but still report
      stdout.write('  cached  $name\n');
      continue;
    }

    final downloadUrl = file['download_url'].toString();
    stdout.write('  fetch   $name ... ');
    final req = await HttpClient().getUrl(Uri.parse(downloadUrl));
    final res = await req.close();
    final content = await res.transform(const Utf8Decoder()).join();
    cachedYml.writeAsStringSync(content);
    stdout.write('done\n');
  }
}

// ============================================================================
// Protocol load
// ============================================================================

Map<String, dynamic> _loadProtocol(String version) {
  final cacheDir = Directory('.protocol_cache/$version');
  if (!cacheDir.existsSync()) {
    print('Protocol cache not found for version $version.');
    exit(1);
  }

  final protocol = <String, dynamic>{};
  final ymlFiles =
      cacheDir
          .listSync()
          .whereType<File>()
          .where((f) => f.path.endsWith('.yml'))
          .toList()
        ..sort((a, b) => a.path.compareTo(b.path));

  for (final file in ymlFiles) {
    final yaml = loadYaml(file.readAsStringSync()) as YamlMap;
    for (final key in yaml.keys) {
      protocol[key.toString()] = yaml[key];
    }
  }
  return protocol;
}

// ============================================================================
// Protocol doc builder
// ============================================================================

String _buildProtocolDoc(Map<String, dynamic> protocol, String version) {
  final enums = <String, dynamic>{};
  final mixinsAndObjects = <String, dynamic>{};
  final interfaces = <String, dynamic>{};

  for (final entry in protocol.entries) {
    final def = entry.value as Map?;
    if (def == null) continue;
    switch (def['type']?.toString()) {
      case 'enum':
        enums[entry.key] = def;
      case 'mixin':
      case 'object':
        mixinsAndObjects[entry.key] = def;
      case 'interface':
        interfaces[entry.key] = def;
    }
  }

  final buf = StringBuffer();

  buf.writeln('# Playwright Protocol API Reference');
  buf.writeln();
  buf.writeln('> Auto-generated from Playwright protocol **v$version**.');
  buf.writeln('> Source: `.protocol_cache/$version/*.yml`');
  buf.writeln('> Regenerate: `dart tool/generate_protocol_docs.dart`');
  buf.writeln();

  // TOC
  buf.writeln('## Contents');
  buf.writeln();
  buf.writeln('- [Interfaces](#interfaces)');
  final sortedInterfaceNames = interfaces.keys.toList()..sort();
  for (final name in sortedInterfaceNames) {
    buf.writeln('  - [`$name`](#${_anchor(name)})');
  }
  buf.writeln('- [Mixins & Objects](#mixins--objects)');
  buf.writeln('- [Enums](#enums)');
  buf.writeln();
  buf.writeln('---');
  buf.writeln();

  // Interfaces
  buf.writeln('# Interfaces');
  buf.writeln();
  for (final name in sortedInterfaceNames) {
    _writeInterface(
      buf,
      name,
      Map<String, dynamic>.from(interfaces[name] as Map),
    );
  }

  // Mixins & Objects
  buf.writeln('---');
  buf.writeln();
  buf.writeln('# Mixins & Objects');
  buf.writeln();
  for (final name in mixinsAndObjects.keys.toList()..sort()) {
    final def = mixinsAndObjects[name] as Map;
    final kind = def['type']?.toString() ?? 'object';
    final props = Map<String, dynamic>.from((def['properties'] as Map?) ?? {});
    _writeMixinOrObject(buf, name, kind, props);
  }

  // Enums
  buf.writeln('---');
  buf.writeln();
  buf.writeln('# Enums');
  buf.writeln();
  for (final name in enums.keys.toList()..sort()) {
    final def = enums[name] as Map;
    final literals = (def['literals'] as List?) ?? [];
    _writeProtocolEnum(buf, name, literals);
  }

  return buf.toString();
}

// ---------------------------------------------------------------------------
// Protocol doc helpers
// ---------------------------------------------------------------------------

String _anchor(String name) =>
    name.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '-');

String _typeName(dynamic typeDef) {
  if (typeDef == null) return 'void';
  if (typeDef is String) return typeDef;
  if (typeDef is Map) {
    final typeStr = (typeDef['type'] as String?) ?? '';
    final optional = typeStr.endsWith('?');
    final base = typeStr.replaceAll('?', '');

    if (typeDef.containsKey(r'$ref')) {
      final ref = typeDef[r'$ref'] as String;
      return optional ? '$ref?' : ref;
    }
    if (base == 'array') {
      final itemType = _typeName(typeDef['items']);
      return optional ? 'Array<$itemType>?' : 'Array<$itemType>';
    }
    if (base == 'object') {
      final props = typeDef['properties'] as Map?;
      if (props == null || props.isEmpty) {
        return optional ? 'Object?' : 'Object';
      }
      final fields = props.entries
          .map((e) => '${e.key}: ${_typeName(e.value)}')
          .join(', ');
      return optional ? '{$fields}?' : '{$fields}';
    }
    if (base == 'enum') {
      final literals =
          (typeDef['literals'] as List?)?.map((e) => '"$e"').join(' | ') ?? '';
      return optional ? '($literals)?' : '($literals)';
    }
    return optional ? '$base?' : base;
  }
  return 'unknown';
}

void _writeProtocolEnum(StringBuffer buf, String name, List literals) {
  buf.writeln('### `$name`');
  buf.writeln();
  buf.writeln('| Value |');
  buf.writeln('|-------|');
  for (final lit in literals) {
    buf.writeln('| `$lit` |');
  }
  buf.writeln();
}

void _writeMixinOrObject(
  StringBuffer buf,
  String name,
  String kind,
  Map<String, dynamic> props,
) {
  buf.writeln('### `$name` *($kind)*');
  buf.writeln();
  if (props.isNotEmpty) {
    buf.writeln('| Property | Type |');
    buf.writeln('|----------|------|');
    for (final entry in props.entries) {
      buf.writeln('| `${entry.key}` | `${_typeName(entry.value)}` |');
    }
  }
  buf.writeln();
}

void _writeInterface(StringBuffer buf, String name, Map<String, dynamic> def) {
  final ext = def['extends'] as String?;
  final extStr = ext != null ? ' *(extends `$ext`)*' : '';
  buf.writeln('## `$name`$extStr');
  buf.writeln();

  // Initializer
  final initializer = def['initializer'] as Map?;
  if (initializer != null && initializer.isNotEmpty) {
    buf.writeln('**Initializer**');
    buf.writeln();
    buf.writeln('| Property | Type |');
    buf.writeln('|----------|------|');
    for (final entry in initializer.entries) {
      buf.writeln('| `${entry.key}` | `${_typeName(entry.value)}` |');
    }
    buf.writeln();
  }

  // Commands
  final commands = def['commands'] as Map?;
  if (commands != null && commands.isNotEmpty) {
    final publicCmds =
        commands.entries
            .where((e) => (e.value as Map?)?.containsKey('internal') != true)
            .toList()
          ..sort((a, b) => a.key.compareTo(b.key));

    if (publicCmds.isNotEmpty) {
      buf.writeln('**Commands**');
      buf.writeln();
      for (final cmdEntry in publicCmds) {
        final cmdName = cmdEntry.key;
        final cmd = cmdEntry.value as Map?;
        if (cmd == null) continue;

        final title = cmd['title'] as String?;
        final group = cmd['group'] as String?;
        final params =
            (cmd['parameters'] as Map?)?.cast<String, dynamic>() ?? {};
        final returns = (cmd['returns'] as Map?)?.cast<String, dynamic>() ?? {};

        // Build signature
        final sigParts = <String>[];
        for (final p in params.entries) {
          if (p.key.startsWith(r'$mixin')) {
            sigParts.add('...\$mixin');
          } else {
            sigParts.add('${p.key}: ${_typeName(p.value)}');
          }
        }
        final sig = sigParts.isEmpty ? '' : sigParts.join(', ');

        buf.writeln('#### `$cmdName`($sig)');
        buf.writeln();
        if (title != null || group != null) {
          final meta = [
            ?title,
            if (group != null) 'group: `$group`',
          ].join(' · ');
          buf.writeln('*$meta*');
          buf.writeln();
        }
        if (returns.isNotEmpty) {
          final retParts = returns.entries
              .map((e) => '`${e.key}`: `${_typeName(e.value)}`')
              .join(', ');
          buf.writeln('→ $retParts');
          buf.writeln();
        }
      }
    }
  }

  // Events
  final events = def['events'] as Map?;
  if (events != null && events.isNotEmpty) {
    buf.writeln('**Events**');
    buf.writeln();
    buf.writeln('| Event | Parameters |');
    buf.writeln('|-------|------------|');
    for (final evName in events.keys.toList()..sort()) {
      final ev = events[evName] as Map?;
      final params = (ev?['parameters'] as Map?)?.cast<String, dynamic>() ?? {};
      final paramsStr = params.isEmpty
          ? '—'
          : params.entries
                .map((e) => '`${e.key}`: `${_typeName(e.value)}`')
                .join(', ');
      buf.writeln('| `$evName` | $paramsStr |');
    }
    buf.writeln();
  }

  buf.writeln('---');
  buf.writeln();
}

// ============================================================================
// Dart API doc builder
// ============================================================================

// Directories to scan (relative to workspace root)
const _dartSourceDirs = [
  'lib/src/core',
  'lib/src/interaction',
  'lib/src/network',
  'lib/src/platform',
  'lib/src/utils',
  'lib/src/debugging',
  'lib/src/infrastructure',
];

// Map subdirectory → section heading
const _sectionNames = {
  'core': 'Core',
  'interaction': 'Interaction',
  'network': 'Network',
  'platform': 'Platform',
  'utils': 'Utilities',
  'debugging': 'Debugging',
  'infrastructure': 'Infrastructure',
};

String _buildDartApiDoc() {
  final buf = StringBuffer();

  buf.writeln('# Playwright Dart — API Reference');
  buf.writeln();
  buf.writeln('> Auto-generated from `/// ` doc comments in `lib/src/`.');
  buf.writeln('> Regenerate: `dart tool/generate_protocol_docs.dart`');
  buf.writeln();
  buf.writeln('## Contents');
  buf.writeln();

  // Collect all sections first so we can build TOC
  final sections = <_Section>[];

  for (final dirPath in _dartSourceDirs) {
    final dir = Directory(dirPath);
    if (!dir.existsSync()) continue;

    final sectionKey = dirPath.split('/').last;
    final sectionTitle =
        _sectionNames[sectionKey] ?? _capitalizeWords(sectionKey);

    final dartFiles =
        dir
            .listSync()
            .whereType<File>()
            .where((f) => f.path.endsWith('.dart'))
            // skip generated code
            .where((f) => !f.path.contains('generated'))
            .toList()
          ..sort((a, b) => a.path.compareTo(b.path));

    final sectionEntries = <_ApiEntry>[];

    for (final file in dartFiles) {
      final entries = _parseDartFile(file);
      sectionEntries.addAll(entries);
    }

    if (sectionEntries.isNotEmpty) {
      sections.add(_Section(sectionTitle, sectionEntries));
    }
  }

  // TOC
  for (final section in sections) {
    buf.writeln('- [${section.title}](#${_anchor(section.title)})');
    final classes = section.entries
        .where((e) => e.kind == _EntryKind.classDecl)
        .toList();
    for (final cls in classes) {
      buf.writeln('  - [`${cls.name}`](#${_anchor(cls.name)})');
    }
  }
  buf.writeln();
  buf.writeln('---');
  buf.writeln();

  // Content
  for (final section in sections) {
    buf.writeln('# ${section.title}');
    buf.writeln();

    _ApiEntry? currentClass;
    final memberBuffer = StringBuffer();

    void flushClass() {
      if (currentClass == null) return;
      buf.write(memberBuffer);
      memberBuffer.clear();
      currentClass = null;
    }

    for (final entry in section.entries) {
      if (entry.kind == _EntryKind.classDecl) {
        flushClass();
        currentClass = entry;

        buf.writeln('## `${entry.name}`');
        buf.writeln();
        if (entry.docs.isNotEmpty) {
          buf.writeln(entry.docs);
          buf.writeln();
        }
        if (entry.signature.isNotEmpty && entry.signature != entry.name) {
          buf.writeln('```dart');
          buf.writeln(entry.signature);
          buf.writeln('```');
          buf.writeln();
        }
      } else {
        // member
        final kind = switch (entry.kind) {
          _EntryKind.constructor => '🔨 Constructor',
          _EntryKind.getter => '📦 Property',
          _EntryKind.method => '⚙️ Method',
          _ => '',
        };

        memberBuffer.writeln('### `${entry.name}`');
        memberBuffer.writeln();
        if (kind.isNotEmpty) {
          memberBuffer.writeln('*$kind*');
          memberBuffer.writeln();
        }
        if (entry.docs.isNotEmpty) {
          memberBuffer.writeln(entry.docs);
          memberBuffer.writeln();
        }
        memberBuffer.writeln('```dart');
        memberBuffer.writeln(entry.signature);
        memberBuffer.writeln('```');
        memberBuffer.writeln();
      }
    }

    flushClass();

    buf.writeln('---');
    buf.writeln();
  }

  return buf.toString();
}

// ============================================================================
// Dart source parser
// ============================================================================

enum _EntryKind { classDecl, constructor, getter, method }

class _ApiEntry {
  final _EntryKind kind;
  final String name;
  final String docs;
  final String signature;

  _ApiEntry({
    required this.kind,
    required this.name,
    required this.docs,
    required this.signature,
  });
}

class _Section {
  final String title;
  final List<_ApiEntry> entries;
  _Section(this.title, this.entries);
}

List<_ApiEntry> _parseDartFile(File file) {
  final lines = file.readAsLinesSync();
  final entries = <_ApiEntry>[];

  // Collect doc-comment block immediately before a declaration
  final docBuffer = <String>[];
  String currentClass = '';

  for (int i = 0; i < lines.length; i++) {
    final line = lines[i].trim();

    // Accumulate doc comment lines
    if (line.startsWith('///')) {
      docBuffer.add(line.substring(line.startsWith('/// ') ? 4 : 3).trim());
      continue;
    }

    // Skip annotation lines like @override
    if (line.startsWith('@')) {
      continue;
    }

    final docs = docBuffer.join('\n').trim();
    docBuffer.clear();

    // Class / abstract class / interface
    final classMatch = RegExp(
      r'^(?:abstract\s+(?:interface\s+)?)?class\s+(\w+)',
    ).firstMatch(line);
    if (classMatch != null) {
      currentClass = classMatch.group(1)!;
      // Skip internal implementation and base classes — only expose public API
      if (currentClass.endsWith('Impl') ||
          currentClass.endsWith('Base') ||
          currentClass.startsWith('_')) {
        docBuffer.clear();
        // Reset so members of this internal class are not attributed to the
        // previous public class
        currentClass = '';
        continue;
      }
      entries.add(
        _ApiEntry(
          kind: _EntryKind.classDecl,
          name: currentClass,
          docs: docs,
          signature: _cleanSignature(line),
        ),
      );
      continue;
    }

    // Skip private / internal
    if (line.startsWith('_') || line.contains(' _') || line.startsWith('//')) {
      continue;
    }

    if (currentClass.isEmpty) continue;

    // Constructor: ClassName(...)
    final ctorMatch = RegExp(r'^(\w+)\s*\(').firstMatch(line);
    if (ctorMatch != null && ctorMatch.group(1) == currentClass) {
      if (docs.isNotEmpty) {
        entries.add(
          _ApiEntry(
            kind: _EntryKind.constructor,
            name: '$currentClass()',
            docs: docs,
            signature: _cleanSignature(_collectSignature(lines, i)),
          ),
        );
      }
      continue;
    }

    // Getter: Type get name
    final getterMatch = RegExp(
      r'^(?:[\w<>\[\]?,\s]+\s+)?get\s+(\w+)',
    ).firstMatch(line);
    if (getterMatch != null && !line.startsWith('//')) {
      final gName = getterMatch.group(1)!;
      if (!gName.startsWith('_') && docs.isNotEmpty) {
        entries.add(
          _ApiEntry(
            kind: _EntryKind.getter,
            name: gName,
            docs: docs,
            signature: _cleanSignature(line),
          ),
        );
      }
      continue;
    }

    // Method / function: returnType name(...)
    final methodMatch = RegExp(
      r'^(?:(?:Future|Stream|List|Map|Set|Locator|Locator\?|void|bool|String|int|double|dynamic|[\w<>\[\]?,\s]+)\s+)?(\w+)\s*(?:<[^>]*>)?\s*\(',
    ).firstMatch(line);
    if (methodMatch != null) {
      final mName = methodMatch.group(1)!;
      // Skip constructors (same name as class), keywords, and privates
      if (mName == currentClass ||
          mName == 'if' ||
          mName == 'for' ||
          mName == 'while' ||
          mName == 'switch' ||
          mName == 'return' ||
          mName.startsWith('_')) {
        continue;
      }
      if (docs.isNotEmpty) {
        entries.add(
          _ApiEntry(
            kind: _EntryKind.method,
            name: mName,
            docs: docs,
            signature: _cleanSignature(_collectSignature(lines, i)),
          ),
        );
      }
      continue;
    }
  }

  return entries;
}

/// Collects a multi-line signature until the opening brace or semicolon.
String _collectSignature(List<String> lines, int startIndex) {
  final parts = <String>[];
  int depth = 0;
  for (int i = startIndex; i < lines.length && i < startIndex + 20; i++) {
    final raw = lines[i];
    final t = raw.trim();
    parts.add(t);
    depth += '{'.allMatches(t).length - '}'.allMatches(t).length;
    if (t.endsWith('{') || t.endsWith(';') || t.endsWith('=>')) {
      break;
    }
    if (t.endsWith(')') && depth == 0) break;
  }
  return parts.join(' ');
}

String _cleanSignature(String sig) {
  // Remove body hints: everything after => or { on the same logical line
  var s = sig
      .replaceAll(RegExp(r'\s+'), ' ')
      .replaceAll(RegExp(r'\s*\{.*'), '')
      .replaceAll(RegExp(r'\s*=>\s*.*'), '')
      .replaceAll('@override', '')
      .trim();
  // Remove trailing semicolon
  if (s.endsWith(';')) s = s.substring(0, s.length - 1).trim();
  return s;
}

String _capitalizeWords(String s) => s
    .split('_')
    .map((w) => w.isEmpty ? '' : w[0].toUpperCase() + w.substring(1))
    .join(' ');
