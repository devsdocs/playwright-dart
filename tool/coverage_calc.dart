import 'dart:io';

void main() {
  final lines = File('coverage/lcov.info').readAsLinesSync();
  int hit = 0;
  int found = 0;
  for (final line in lines) {
    if (line.startsWith('DA:')) {
      final parts = line.split(',');
      if (parts.length > 1) {
        found++;
        if (int.parse(parts[1]) > 0) {
          hit++;
        }
      }
    }
  }
  if (found > 0) {
    print('Coverage: ${((hit / found) * 100).toStringAsFixed(2)}%');
  } else {
    print('Coverage: 0%');
  }
}
