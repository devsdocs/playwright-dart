import 'dart:io';

String capitalize(String s) =>
    s.isEmpty ? '' : s[0].toUpperCase() + s.substring(1);

void main(List<String> args) {
  final mdxDir = Directory(
    args.isEmpty ? r'D:\Devs\App8\playwright.dev\nodejs\docs\api' : args[0],
  );
  if (!mdxDir.existsSync()) {
    print('MDX directory not found: ${mdxDir.path}');
    return;
  }

  // Parse MDX
  final docs = <String, Map<String, String>>{};

  for (final file in mdxDir.listSync().whereType<File>()) {
    if (!file.path.endsWith('.mdx')) continue;

    final lines = file.readAsLinesSync();
    String className = '';

    for (final line in lines) {
      if (line.startsWith('title: "')) {
        className = line.substring(8, line.length - 1);
        break;
      }
    }

    if (className.isEmpty) continue;

    docs[className] = {};

    String currentMethod = 'class';
    List<String> currentDesc = [];

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];

      if (line.startsWith('## Methods') || line.startsWith('## Properties')) {
        if (currentDesc.isNotEmpty) {
          docs[className]![currentMethod] = _cleanMdx(currentDesc.join('\n'));
          currentDesc = [];
        }
        continue;
      }

      if (line.startsWith('### ')) {
        if (currentDesc.isNotEmpty) {
          docs[className]![currentMethod] = _cleanMdx(currentDesc.join('\n'));
          currentDesc = [];
        }

        final match = RegExp(r'^### (\w+)').firstMatch(line);
        if (match != null) {
          currentMethod = match.group(1)!;
        } else {
          currentMethod = line.replaceAll('### ', '').split(' ').first;
        }
        continue;
      }

      if (line.startsWith('---') && currentMethod != 'class') {
        if (currentDesc.isNotEmpty) {
          docs[className]![currentMethod] = _cleanMdx(currentDesc.join('\n'));
          currentDesc = [];
        }
        currentMethod = '';
        continue;
      }

      if (currentMethod.isNotEmpty) {
        currentDesc.add(line);
      }
    }

    if (currentDesc.isNotEmpty && currentMethod.isNotEmpty) {
      docs[className]![currentMethod] = _cleanMdx(currentDesc.join('\n'));
    }
  }

  print('Parsed MDX documentation for ${docs.length} classes.');

  // Inject into Dart
  final dartDir = Directory('lib/src');
  int modifiedFiles = 0;
  for (final file in dartDir.listSync(recursive: true).whereType<File>()) {
    if (!file.path.endsWith('.dart')) continue;
    if (file.path.contains('generated')) continue;

    final lines = file.readAsLinesSync();
    final entries = _parseDartFile(lines);

    if (entries.isEmpty) continue;

    // Sort entries by insert position descending so replacements don't shift line numbers of earlier entries
    entries.sort((a, b) {
      int posA = a.docStart != -1 ? a.docStart : a.insertLine;
      int posB = b.docStart != -1 ? b.docStart : b.insertLine;
      return posB.compareTo(posA);
    });

    bool changed = false;
    for (final entry in entries) {
      if (entry.className.isEmpty) continue;

      // If it is an Impl or private class, strip its doc comments to rely on interface docs.
      final isImpl =
          entry.className.endsWith('Impl') ||
          entry.className.endsWith('Base') ||
          entry.className.startsWith('_');
      if (isImpl) {
        if (entry.docStart != -1) {
          lines.removeRange(entry.docStart, entry.docEnd + 1);
          changed = true;
        }
        continue;
      }

      final docMap = docs[entry.className];
      if (docMap == null) continue;

      String? newDoc =
          docMap[entry.methodName.isEmpty ? 'class' : entry.methodName];
      if (newDoc != null && newDoc.isNotEmpty) {
        final params = _parseDartParams(lines, entry.insertLine);
        if (params.isNotEmpty) {
          final docLines = newDoc.split('\n');
          for (int j = 0; j < docLines.length; j++) {
            final docLine = docLines[j];
            final match = RegExp(
              r'^\s*-\s+`(\w+)`\s+([^`*\n]+)',
            ).firstMatch(docLine);
            if (match != null) {
              final paramName = match.group(1)!;
              if (params.containsKey(paramName)) {
                final actualType = params[paramName]!
                    .replaceAll('<', '&lt;')
                    .replaceAll('>', '&gt;');
                final oldType = match.group(2)!.trim();
                docLines[j] = docLine.replaceFirst(
                  '`$paramName` $oldType',
                  '`$paramName` $actualType',
                );
              }
            }
          }
          newDoc = docLines.join('\n');
        }

        // If it's a getter/property, strip `()` from its usage in the doc
        if (entry.isProperty) {
          newDoc = newDoc.replaceAll(
            '.${entry.methodName}()',
            '.${entry.methodName}',
          );
        }

        final docLines = newDoc
            .split('\n')
            .map((l) => '  /// $l'.trimRight())
            .toList();
        // Remove empty comments at end
        while (docLines.isNotEmpty && docLines.last == '  ///') {
          docLines.removeLast();
        }

        final insertPos = entry.docStart != -1
            ? entry.docStart
            : entry.insertLine;

        if (entry.docStart != -1) {
          lines.removeRange(entry.docStart, entry.docEnd + 1);
        }
        lines.insertAll(insertPos, docLines);
        changed = true;
      }
    }

    if (changed) {
      file.writeAsStringSync('${lines.join('\n')}\n');
      modifiedFiles++;
    }
  }

  print('Injected docs into $modifiedFiles Dart files.');
}

String _cleanMdx(String mdx) {
  var s = mdx;
  if (s.startsWith('---')) {
    final endIdx = s.indexOf('---', 3);
    if (endIdx != -1) {
      s = s.substring(endIdx + 3).trim();
    }
  }

  s = s.replaceAll(RegExp(r"import .*?;\n"), '');
  s = s.replaceAll(RegExp(r'<font[^>]*>.*?</font>'), '');
  s = s.replaceAll(RegExp(r'<x-search>.*?</x-search>'), '');
  s = s.replaceAll(RegExp(r'<a aria-hidden="true".*?</a>'), '');

  // Convert MDX links [text](/api/...) to just text or [text]
  s = s.replaceAllMapped(
    RegExp(r'\[([^\]]+)\]\([^)]+\)'),
    (match) => '[${match.group(1)}]',
  );

  // Convert JS terms to Dart terms
  s = s.replaceAll('[Promise]&lt;', 'Future&lt;');
  s = s.replaceAll('[Promise]', 'Future');
  s = s.replaceAll('[string]', 'String');
  s = s.replaceAll('[boolean]', 'bool');
  s = s.replaceAll('[number]', 'num');
  s = s.replaceAll('[Array]', 'List');
  s = s.replaceAll('[Object]', 'Map');
  s = s.replaceAll('[function]', 'Function');
  s = s.replaceAll('[void]', 'void');
  s = s.replaceAll('[any]', 'dynamic');
  s = s.replaceAll('[null]', 'null');

  // Convert basic type unions like `null | Map` or `null | [Browser]`
  s = s.replaceAllMapped(
    RegExp(r'null\s*\|\s*\[?([a-zA-Z_&;]+)\]?'),
    (m) => '[${m.group(1)}]?',
  );
  s = s.replaceAllMapped(
    RegExp(r'\[?([a-zA-Z_&;]+)\]?\s*\|\s*null'),
    (m) => '[${m.group(1)}]?',
  );

  // Convert Docusaurus admonitions
  s = s.replaceAll(RegExp(r':::note\s*', caseSensitive: false), '**NOTE**\n');
  s = s.replaceAll(
    RegExp(r':::warning\s*', caseSensitive: false),
    '**WARNING**\n',
  );
  s = s.replaceAll(
    RegExp(r':::danger\s*', caseSensitive: false),
    '**DANGER**\n',
  );
  s = s.replaceAll(RegExp(r':::\w*\s*'), '');

  // Remove MDN reference links
  s = s.replaceAll(
    RegExp(r'^\[?[a-zA-Z0-9_]+\]?:\s*https?://.*$\n?', multiLine: true),
    '',
  );

  s = s.replaceAllMapped(RegExp(r'\b([a-zA-Z]*)Promise(s?)\b'), (m) {
    final prefix = m.group(1)!;
    return '${prefix}Future${m.group(2)}';
  });
  s = s.replaceAllMapped(RegExp(r'\b([a-zA-Z]*)promise(s?)\b'), (m) {
    final prefix = m.group(1)!;
    if (prefix.toLowerCase().endsWith('com')) return m.group(0)!;
    return '${prefix}future${m.group(2)}';
  });
  s = s.replaceAll(
    'wait for the future to resolve',
    'wait for the future to complete',
  );
  s = s.replaceAll('Future.resolve', 'Future.value');

  s = s.replaceAll('Buffer.from', 'utf8.encode');
  s = s.replaceAll('[Buffer]', 'List&lt;int&gt;');

  s = s.replaceAll(' === ', ' == ');
  s = s.replaceAll(' !== ', ' != ');

  // Event translation
  const eventMap = {
    'requestfailed': 'onRequestFailed',
    'requestfinished': 'onRequestFinished',
    'filechooser': 'onFileChooser',
    'framenavigated': 'onFrameNavigated',
    'framedetached': 'onFrameDetached',
    'frameattached': 'onFrameAttached',
    'pageerror': 'onPageError',
    'websocket': 'onWebSocket',
    'worker': 'onWorker',
    'page': 'onPage',
  };

  s = s.replaceAllMapped(RegExp(r'\.on\(([\047"])([a-zA-Z]+)\1,\s*'), (m) {
    final eventName = m.group(2)!.toLowerCase();
    final mapped =
        eventMap[eventName] ??
        'on${eventName[0].toUpperCase()}${eventName.substring(1)}';
    return '.$mapped.listen(';
  });

  s = s.replaceAllMapped(RegExp(r'\.waitForEvent\(([\047"])([a-zA-Z]+)\1\)'), (
    m,
  ) {
    final eventName = m.group(2)!.toLowerCase();
    final mapped =
        eventMap[eventName] ??
        'on${eventName[0].toUpperCase()}${eventName.substring(1)}';
    return '.$mapped.first';
  });

  // JS arrow functions to Dart
  s = s.replaceAllMapped(
    RegExp(r'\basync\s*\(([^)]*)\)\s*=>\s*\{'),
    (m) => '(${m.group(1)}) async {',
  );
  s = s.replaceAllMapped(
    RegExp(r'\basync\s*\(([^)]*)\)\s*=>'),
    (m) => '(${m.group(1)}) async =>',
  );
  s = s.replaceAllMapped(
    RegExp(r'\basync\s+([a-zA-Z0-9_]+)\s*=>\s*\{'),
    (m) => '(${m.group(1)}) async {',
  );
  s = s.replaceAllMapped(
    RegExp(r'\basync\s+([a-zA-Z0-9_]+)\s*=>'),
    (m) => '(${m.group(1)}) async =>',
  );
  s = s.replaceAllMapped(
    RegExp(r'\(([^)]*)\)\s*=>\s*\{'),
    (m) => '(${m.group(1)}) {',
  );
  s = s.replaceAllMapped(
    RegExp(r'\b([a-zA-Z0-9_]+)\s*=>\s*\{'),
    (m) => '(${m.group(1)}) {',
  );
  s = s.replaceAllMapped(
    RegExp(r'\b([a-zA-Z0-9_]+)\s*=>'),
    (m) => '(${m.group(1)}) =>',
  );

  // Convert JS code blocks to dart code blocks
  s = s.replaceAllMapped(RegExp(r'```js([\s\S]*?)```'), (match) {
    var code = match.group(1)!;
    code = code.replaceAll(
      RegExp(
        r"const\s+\{\s*(webkit|chromium|firefox)\s*\}\s*=\s*require\('playwright'\);\n?",
      ),
      '',
    );
    code = code.replaceAll(
      RegExp(r"const\s+\w+\s*=\s*require\('[^']+'\);\n?"),
      '',
    );
    code = code.replaceAll('const ', 'final ');
    code = code.replaceAll('let ', 'var ');
    code = code.replaceAll('console.log', 'print');
    code = code.replaceAll('(async () => {', 'void main() async {');
    code = code.replaceAll('})();', '}');
    code = code.replaceAll('({', '(');
    code = code.replaceAll('})', ')');
    return '```dart$code```';
  });

  // Convert inline JS object arguments to Dart named arguments
  // e.g. `page.pdf({width: 100})` -> `page.pdf(width: 100)`
  // and `page.click('btn', {timeout: 100})` -> `page.click('btn', timeout: 100)`
  s = s.replaceAllMapped(
    RegExp(r'\(\s*\{([^}]+)\}\s*\)'),
    (m) => '(${m.group(1)})',
  );
  s = s.replaceAllMapped(
    RegExp(r',\s*\{([^}]+)\}\s*\)'),
    (m) => ', ${m.group(1)})',
  );

  return s.trim();
}

Map<String, String> _parseDartParams(List<String> lines, int declStart) {
  final params = <String, String>{};
  if (declStart < 0 || declStart >= lines.length) return params;

  String sig = '';
  int openParen = 0;
  bool started = false;

  for (int i = declStart; i < lines.length; i++) {
    final line = lines[i];
    sig += '$line ';

    for (int j = 0; j < line.length; j++) {
      if (line[j] == '(') {
        openParen++;
        started = true;
      } else if (line[j] == ')') {
        openParen--;
      }
    }

    if (started && openParen == 0) {
      break;
    }
  }

  final start = sig.indexOf('(');
  final end = sig.lastIndexOf(')');
  if (start == -1 || end == -1 || start >= end) return params;

  final argsStr = sig.substring(start + 1, end);

  final args = <String>[];
  int angleBrackets = 0;
  int parenCount = 0;
  int lastComma = 0;
  for (int i = 0; i < argsStr.length; i++) {
    if (argsStr[i] == '<') {
      angleBrackets++;
    } else if (argsStr[i] == '>') {
      angleBrackets--;
    } else if (argsStr[i] == '(') {
      parenCount++;
    } else if (argsStr[i] == ')') {
      parenCount--;
    } else if (argsStr[i] == ',' && angleBrackets == 0 && parenCount == 0) {
      args.add(argsStr.substring(lastComma, i));
      lastComma = i + 1;
    }
  }
  args.add(argsStr.substring(lastComma));

  for (String arg in args) {
    arg = arg.trim();
    if (arg.isEmpty) continue;

    arg = arg
        .replaceAll('{', '')
        .replaceAll('}', '')
        .replaceAll('[', '')
        .replaceAll(']', '')
        .trim();
    if (arg.isEmpty) continue;

    if (arg.startsWith('required ')) {
      arg = arg.substring('required '.length).trim();
    }

    final eqIndex = arg.indexOf('=');
    if (eqIndex != -1) {
      arg = arg.substring(0, eqIndex).trim();
    }

    final parts = arg.split(RegExp(r'\s+'));
    if (parts.length >= 2) {
      final name = parts.last;
      final typeWords = parts
          .sublist(0, parts.length - 1)
          .where((w) => !w.startsWith('@'))
          .toList();
      String type = typeWords.join(' ').trim();

      if (type.endsWith('?')) {
        type = type.substring(0, type.length - 1);
      }

      params[name] = type;
    }
  }

  return params;
}

class _ApiEntry {
  final String className;
  final String methodName;
  final int docStart;
  final int docEnd;
  final int insertLine;
  final bool isProperty;

  _ApiEntry(
    this.className,
    this.methodName,
    this.docStart,
    this.docEnd,
    this.insertLine, {
    this.isProperty = false,
  });
}

List<_ApiEntry> _parseDartFile(List<String> lines) {
  final entries = <_ApiEntry>[];
  int docStart = -1;
  int docEnd = -1;
  int declStart = -1;
  String currentClass = '';

  for (int i = 0; i < lines.length; i++) {
    final line = lines[i].trim();

    if (line.isEmpty) {
      docStart = -1;
      docEnd = -1;
      declStart = -1;
      continue;
    }

    if (line.startsWith('///')) {
      if (docStart == -1) docStart = i;
      docEnd = i;
      continue;
    }

    if (line.startsWith('//')) {
      continue;
    }

    if (line.startsWith('@')) {
      if (declStart == -1) declStart = i;
      continue;
    }

    if (declStart == -1) declStart = i;

    final classMatch = RegExp(
      r'^(?:abstract\s+(?:interface\s+)?)?class\s+(\w+)',
    ).firstMatch(line);
    if (classMatch != null) {
      currentClass = classMatch.group(1)!;
      entries.add(_ApiEntry(currentClass, '', docStart, docEnd, declStart));
      docStart = -1;
      docEnd = -1;
      declStart = -1;
      continue;
    }

    if (currentClass.isNotEmpty) {
      final getterMatch = RegExp(
        r'^(?:[\w<>\[\]?,\s]+\s+)?get\s+(\w+)',
      ).firstMatch(line);
      if (getterMatch != null) {
        final gName = getterMatch.group(1)!;
        if (!gName.startsWith('_')) {
          entries.add(
            _ApiEntry(
              currentClass,
              gName,
              docStart,
              docEnd,
              declStart,
              isProperty: true,
            ),
          );
        }
        docStart = -1;
        docEnd = -1;
        declStart = -1;
        continue;
      }

      final methodMatch = RegExp(
        r'^(?:(?:Future|Stream|List|Map|Set|Locator|Locator\?|void|bool|String|int|double|dynamic|[\w<>\[\]?,\s]+)\s+)?(\w+)\s*(?:<[^>]*>)?\s*\(',
      ).firstMatch(line);
      if (methodMatch != null) {
        final mName = methodMatch.group(1)!;
        if (mName != currentClass &&
            !['if', 'for', 'while', 'switch', 'return'].contains(mName) &&
            !mName.startsWith('_')) {
          entries.add(
            _ApiEntry(currentClass, mName, docStart, docEnd, declStart),
          );
        }
        docStart = -1;
        docEnd = -1;
        declStart = -1;
        continue;
      }
    }

    if (line.endsWith(';') || line.endsWith('}')) {
      docStart = -1;
      docEnd = -1;
      declStart = -1;
    }
  }

  return entries;
}
