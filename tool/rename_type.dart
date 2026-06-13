import 'dart:io';

void main() {
  final files = [
    'lib/src/core/playwright.dart',
    'lib/src/core/page.dart',
    'lib/src/core/browser.dart',
    'lib/src/core/browser_type.dart',
    'lib/src/core/frame.dart',
    'lib/src/core/browser_context.dart',
    'lib/src/infrastructure/connection.dart',
    'tool/generate_protocol.dart',
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
