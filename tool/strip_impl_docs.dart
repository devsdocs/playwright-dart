import 'dart:io';

void main() {
  final dartDir = Directory('lib/src');
  int modifiedFiles = 0;

  for (final file in dartDir.listSync(recursive: true).whereType<File>()) {
    if (!file.path.endsWith('.dart')) continue;
    if (file.path.contains('generated')) continue;

    final lines = file.readAsLinesSync();
    final outLines = <String>[];

    bool insideImpl = false;
    bool changed = false;

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];
      final trimmed = line.trim();

      final classMatch = RegExp(
        r'^(?:abstract\s+(?:interface\s+)?)?class\s+(\w+)',
      ).firstMatch(trimmed);
      if (classMatch != null) {
        final className = classMatch.group(1)!;
        if (className.endsWith('Impl') || className.endsWith('Base')) {
          insideImpl = true;
        } else {
          insideImpl = false;
        }
      }

      if (insideImpl && trimmed.startsWith('///')) {
        changed = true;
        continue; // skip doc comments in Impl classes
      }

      outLines.add(line);
    }

    if (changed) {
      file.writeAsStringSync('${outLines.join('\n')}\n');
      modifiedFiles++;
    }
  }

  print('Cleaned docs in $modifiedFiles files.');
}
