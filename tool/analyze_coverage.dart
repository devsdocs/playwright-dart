import 'dart:io';

void main() {
  final file = File('coverage/lcov.info');
  if (!file.existsSync()) {
    print('Coverage file not found');
    return;
  }

  Map<String, FileCoverage> fileCoverage = {};
  String? currentFile;

  for (final line in file.readAsLinesSync()) {
    if (line.startsWith('SF:D:\\Devs\\App8\\playwright-dart\\lib')) {
      currentFile = line.substring(3);
      fileCoverage[currentFile] = FileCoverage();
    } else if (line.startsWith('SF:')) {
      currentFile = null;
    } else if (currentFile != null && line.startsWith('DA:')) {
      final parts = line.substring(3).split(',');
      if (parts.length >= 2) {
        final count = int.parse(parts[1]);
        fileCoverage[currentFile]!.total++;
        if (count > 0) {
          fileCoverage[currentFile]!.hit++;
        }
      }
    }
  }

  // Sort by coverage percentage (lowest first)
  final sorted = fileCoverage.entries.toList()
    ..sort(
      (a, b) =>
          (a.value.hit / a.value.total).compareTo(b.value.hit / b.value.total),
    );

  print('Lowest coverage files:');
  print('========================================');
  for (final entry in sorted.take(15)) {
    final coverage = (entry.value.hit / entry.value.total * 100)
        .toStringAsFixed(1);
    final fileName = entry.key.split('\\').last;
    print('$fileName: $coverage% (${entry.value.hit}/${entry.value.total})');
  }
}

class FileCoverage {
  int total = 0;
  int hit = 0;
}
