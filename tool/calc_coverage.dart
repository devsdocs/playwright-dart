import 'dart:io';

void main() {
  final file = File('coverage/lcov.info');
  if (!file.existsSync()) {
    print('Coverage file not found');
    return;
  }
  int total = 0;
  int hit = 0;
  for (final line in file.readAsLinesSync()) {
    if (line.startsWith('DA:')) {
      final parts = line.substring(3).split(',');
      if (parts.length >= 2) {
        total++;
        if (int.parse(parts[1]) > 0) {
          hit++;
        }
      }
    }
  }
  if (total > 0) {
    print('Coverage: ${((hit * 100) / total).toStringAsFixed(2)}% ($hit/$total)');
  } else {
    print('No coverage data found.');
  }
}
