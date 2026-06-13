import 'package:test/test.dart';
import 'package:playwright_dart/playwright_dart.dart';
import 'dart:io';

void main() {
  group('WebSocket Connect API', () {
    test('should connect to remote browser and navigate', () async {
      // Connect to the remote browserless instance using the provided token
      final playwright = await PlaywrightDart.create();

      final wsEndpoint = Platform.environment['PLAYWRIGHT_WS_ENDPOINT'];
      if (wsEndpoint == null) {
        print(
          'Skipping WebSocket connect test since PLAYWRIGHT_WS_ENDPOINT is not set',
        );
        return;
      }

      try {
        final remoteBrowser = await playwright.chromium.connectOverCDP(
          endpointURL: wsEndpoint,
        );

        final context = await remoteBrowser.newContext();
        final page = await context.newPage();

        await page.goto('https://example.com');
        final title = await page.title();
        expect(title, equals('Example Domain'));

        await remoteBrowser.close();
      } finally {
        await playwright.stop();
      }
    });
  });
}
