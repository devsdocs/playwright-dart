import 'dart:io';
import '../test_helper.dart';

void main() {
  setUpAll(() async {
    await setupBrowser();
  });

  tearDownAll(() async {
    await teardownBrowser();
  });

  group('Route from HAR API', () {
    test('should route from HAR file', (page) async {
      final harPath = '${Directory.current.path}/test_network.har';
      final harJson = '''{
        "log": {
          "version": "1.2",
          "creator": {"name": "Playwright", "version": "1.0"},
          "entries": [
            {
              "request": {
                "method": "GET",
                "url": "https://example.com/api/data",
                "headers": []
              },
              "response": {
                "status": 200,
                "statusText": "OK",
                "headers": [
                  {"name": "content-type", "value": "application/json"}
                ],
                "content": {
                  "size": 34,
                  "mimeType": "application/json",
                  "text": "{\\"message\\": \\"recorded response\\"}"
                }
              }
            }
          ]
        }
      }''';

      File(harPath).writeAsStringSync(harJson);

      try {
        // Create a dedicated context for HAR replay
        final replayContext = await browser.newContext();
        final replayPage = await replayContext.newPage();

        try {
          // Use routeFromHAR API
          await replayPage.routeFromHAR(harPath, notFoundFallback: true);

          // Navigate and fetch
          await replayPage.goto('about:blank');
          final responseText = await replayPage.evaluate('''async () => {
            const res = await fetch('https://example.com/api/data');
            return await res.text();
          }''');

          expect(responseText, contains('recorded response'));
        } finally {
          await replayContext.close();
        }
      } finally {
        if (File(harPath).existsSync()) {
          File(harPath).deleteSync();
        }
      }
    });
  });
}
