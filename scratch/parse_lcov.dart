import 'dart:io';

void main() async {
  final file = File('coverage/lcov.info');
  final lines = await file.readAsLines();

  String currentFile = '';
  int totalLines = 0;
  int coveredLines = 0;

  for (final line in lines) {
    if (line.startsWith('SF:')) {
      if (currentFile.isNotEmpty && totalLines > 0) {
        final coverage = coveredLines / totalLines;
        if (coverage < 0.9) {
          print('$currentFile: ${(coverage * 100).toStringAsFixed(2)}% ($coveredLines/$totalLines)');
        }
      }
      currentFile = line.substring(3);
      totalLines = 0;
      coveredLines = 0;
    } else if (line.startsWith('DA:')) {
      final parts = line.substring(3).split(',');
      if (parts.length >= 2) {
        totalLines++;
        if (int.parse(parts[1]) > 0) {
          coveredLines++;
        }
      }
    }
  }

  if (currentFile.isNotEmpty && totalLines > 0) {
    final coverage = coveredLines / totalLines;
    if (coverage < 0.9) {
      print('$currentFile: ${(coverage * 100).toStringAsFixed(2)}% ($coveredLines/$totalLines)');
    }
  }
}
