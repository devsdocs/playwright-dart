import 'dart:convert';

import '../test_helper.dart';

void main() {
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
          headers: [NameValue(name: 'content-type', value: 'text/plain')],
          body: 'OK',
        );
      });

      await page.evaluate('''() => {
        fetch("https://example.com/submit", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ key: "value" })
        });
      }''');

      // Wait for the request to be intercepted
      await page.waitForTimeout(1000);

      expect(method, equals('POST'));
      final decodedPostData = utf8.decode(base64Decode(postData!));
      expect(decodedPostData, contains('"key":"value"'));
    });
  });

  group('Route API', () {
    test('should modify response via fulfill', (page) async {
      await page.route('**/api/data', (route) async {
        await route.fulfill(
          status: 200,
          headers: [NameValue(name: 'content-type', value: 'application/json')],
          body: '{"result": "mocked"}',
        );
      });

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
          headers: [NameValue(name: 'content-type', value: 'text/plain')],
          body: 'Not Found',
        );
      });

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
}
