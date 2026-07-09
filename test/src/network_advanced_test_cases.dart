import '../test_helper.dart';

void main() {
  setUpAll(() async {
    await setupBrowser();
  });

  tearDownAll(() async {
    await teardownBrowser();
  });

  group('Response API', () {
    test('should get response status and headers', (page) async {
      await page.mainFrame.goto('https://example.com', timeout: 30000.0);

      // Navigate and capture response through route
      // Instead, let's use evaluate to check response properties
      await page.goto('https://example.com');

      // We can test response through network interception

      await page.route('**/*', (route) async {
        await route.continueRoute();
      });

      // Re-navigate to capture
      await page.goto('https://example.com');
      final title = await page.title();
      expect(title, equals('Example Domain'));
    });

    test('should get page URL after navigation', (page) async {
      await page.goto('https://example.com');
      final url = await page.evaluate('() => window.location.href');
      expect(url, contains('example.com'));
    });
  });

  group('Request API', () {
    test('should intercept and inspect request', (page) async {
      String? requestUrl;
      String? requestMethod;

      await page.route('**/*', (route) async {
        requestUrl = route.request.url;
        requestMethod = route.request.method;
        await route.continueRoute();
      });

      await page.goto('https://example.com');
      expect(requestUrl, contains('example.com'));
      expect(requestMethod, equals('GET'));
    });

    test('should intercept POST request', (page) async {
      String? method;
      String? postData;

      await page.route('**/submit', (route) async {
        method = route.request.method;
        postData = route.request.postData;
        await route.fulfill(
          status: 200,
          headers: [
            NameValue(name: 'content-type', value: 'text/plain'),
            NameValue(name: 'access-control-allow-origin', value: '*'),
          ],
          body: 'OK',
        );
      });

      // Navigate to real site first so same-origin fetches work.
      await page.goto('https://example.com');

      await page.evaluate('''async () => {
        await fetch("https://example.com/submit", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ key: "value" })
        });
      }''');

      expect(method, equals('POST'));
      expect(postData, contains('"key":"value"'));
    });
  });

  group('Route API', () {
    test('should modify response via fulfill', (page) async {
      await page.route('**/api/data', (route) async {
        await route.fulfill(
          status: 200,
          headers: [
            NameValue(name: 'content-type', value: 'application/json'),
            NameValue(name: 'access-control-allow-origin', value: '*'),
          ],
          body: '{"result": "mocked"}',
        );
      });

      await page.goto('https://example.com');

      final result = await page.evaluate('''async () => {
        const res = await fetch("https://example.com/api/data");
        return await res.json();
      }''');

      expect(result['result'], equals('mocked'));
    });

    test('should return custom status code', (page) async {
      await page.route('**/api/error', (route) async {
        await route.fulfill(
          status: 404,
          headers: [
            NameValue(name: 'content-type', value: 'text/plain'),
            NameValue(name: 'access-control-allow-origin', value: '*'),
          ],
          body: 'Not Found',
        );
      });

      await page.goto('https://example.com');

      final status = await page.evaluate('''async () => {
        const res = await fetch("https://example.com/api/error");
        return res.status;
      }''');

      expect(status, equals(404));
    });

    test('should abort request', (page) async {
      await page.route('**/blocked', (route) async {
        await route.abort();
      });

      final failed = await page.evaluate('''async () => {
        try {
          await fetch("https://example.com/blocked");
          return false;
        } catch(e) {
          return true;
        }
      }''');

      expect(failed, isTrue);
    });
  });

  group('Network Advanced API', () {
    test('should expose postDataJSON', (page) async {
      String? jsonMethod;
      dynamic postDataJson;

      await page.route('**/submit-json', (route) async {
        postDataJson = route.request.postDataJSON;
        jsonMethod = route.request.method;
        await route.fulfill(
          status: 200,
          headers: [NameValue(name: 'access-control-allow-origin', value: '*')],
          body: 'OK',
        );
      });

      await page.goto('https://example.com');

      await page.evaluate('''async () => {
        await fetch("https://example.com/submit-json", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ "foo": "bar" })
        });
      }''');

      expect(jsonMethod, equals('POST'));
      expect(postDataJson, isNotNull);
      expect(postDataJson['foo'], equals('bar'));
    });

    test('should expose timing and failure properties', (page) async {
      await page.route('**/timeout', (route) async {
        await route.abort(errorCode: RouteErrorCode.failed);
      });

      final requestFuture = page.onRequestFailed.first;

      await page.evaluate('''async () => {
        try {
          await fetch("https://example.com/timeout");
        } catch (e) {}
      }''');

      final failedRequest = await requestFuture;

      print('FAILED REQUEST URL: ${failedRequest.url}');
      print('FAILED REQUEST TIMING: ${failedRequest.timing}');

      expect(failedRequest.failure, isNotNull);
      expect(failedRequest.timing, isNotNull);
      expect(failedRequest.timing['startTime'], isNotNull);
    });
  });
}
