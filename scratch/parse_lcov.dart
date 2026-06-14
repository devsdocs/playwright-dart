import 'dart:io';

void main() async {
  final file = File('coverage/lcov.info');
  final lines = await file.readAsLines();

  int totalLines = 0;
  int coveredLines = 0;

  for (final line in lines) {
    if (line.startsWith('DA:')) {
      final parts = line.substring(3).split(',');
      if (parts.length >= 2) {
        totalLines++;
        if (int.parse(parts[1]) > 0) {
          coveredLines++;
        }
      }
    }
  }

  if (totalLines > 0) {
    final coverage = coveredLines / totalLines;
    print('Total Coverage: ${(coverage * 100).toStringAsFixed(2)}% ($coveredLines/$totalLines)');
  }
}
