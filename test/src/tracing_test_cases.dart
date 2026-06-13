import 'dart:io';

import '../test_helper.dart';

void main() {
  group('Tracing API', () {
    test('should record and stop tracing, returning bytes', (page) async {
      await browser.startTracing(page: page);

      await page.goto('https://example.com');
      await page.locator('h1').isVisible();

      final traceBytes = await browser.stopTracing();

      expect(traceBytes, isNotEmpty);
      expect(
        traceBytes.length,
        greaterThan(100),
      ); // Zip file should be substantial

      // Optional: Save it temporarily to ensure it writes correctly
      final tempFile = File('test_trace.zip');
      await tempFile.writeAsBytes(traceBytes);
      expect(await tempFile.exists(), isTrue);
      await tempFile.delete();
    });
  });
}
