import 'package:playwright_dart/playwright_dart.dart';
import 'package:test/test.dart';

void main() {
  group('Playwright Lifecycle API', () {
    test('Node.js pattern (auto shutdown)', () async {
      final playwright = await PlaywrightDart.create(autoClose: true);
      final browser = await playwright.chromium.launch();
      
      // Closing the only browser should automatically shut down the playwright driver.
      await browser.close();
      
      // Verify that the connection is now closed by attempting to launch again
      // It should throw an exception.
      expect(
        () => playwright.chromium.launch(),
        throwsA(isA<Exception>().having((e) => e.toString(), 'message', contains('Connection is closed'))),
      );
    });

    test('Python/Java pattern (manual stop)', () async {
      final playwright = await PlaywrightDart.create(autoClose: false);
      
      final browser1 = await playwright.chromium.launch();
      await browser1.close();
      
      // Auto close is false, so the driver should still be alive,
      // allowing us to launch a second browser.
      final browser2 = await playwright.chromium.launch();
      await browser2.close();

      // We must manually stop it
      await playwright.stop();

      // After explicit stop, connection is closed
      expect(
        () => playwright.chromium.launch(),
        throwsA(isA<Exception>().having((e) => e.toString(), 'message', contains('Connection is closed'))),
      );
    });
  });
}
