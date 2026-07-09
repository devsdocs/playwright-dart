import 'dart:io';

void main() {
  final srcDir = Directory('lib/src');
  final regex = RegExp(r'\bchannel_(?!owner\b)([a-zA-Z0-9_]+)');
  int filesUpdated = 0;

  for (final entity in srcDir.listSync(recursive: true).whereType<File>()) {
    if (entity.path.endsWith('.dart') && !entity.path.contains('generated')) {
      final content = entity.readAsStringSync();
      if (regex.hasMatch(content)) {
        final newContent = content.replaceAllMapped(
          regex,
          (match) => 'channel.${match.group(1)}',
        );
        entity.writeAsStringSync(newContent);
        print('Updated: ${entity.path}');
        filesUpdated++;
      }
    }
  }

  print('Finished updating $filesUpdated files.');
}
