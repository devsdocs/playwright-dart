import 'dart:io';

void main() {
  final files = [
    'lib/src/playwright.dart',
    'lib/src/page.dart',
    'lib/src/browser.dart',
    'lib/src/browser_type.dart',
    'lib/src/frame.dart',
    'lib/src/browser_context.dart',
    'lib/src/connection.dart',
    'tool/generate_protocol.dart'
  ];

  for (final file in files) {
    final f = File(file);
    if (!f.existsSync()) continue;
    var content = f.readAsStringSync();
    content = content.replaceAll('super.type,', 'super.channelType,');
    if (file == 'tool/generate_protocol.dart') {
      content = content.replaceAll('super.type,', 'super.channelType,');
    }
    f.writeAsStringSync(content);
  }
}
