import '../test_helper.dart';

void main() {
  group('Network Interception', () {
    test('should abort request', (page) async {
      await page.route('**/*.png', (route) async {
        await route.abort();
      });

      await page.setContent(
        '<img src="https://playwright.dev/img/playwright-logo.png" />',
      );
      final result = await page.evaluate('''() => {
        return new Promise(resolve => {
          const img = document.querySelector('img');
          if (img.complete) {
            resolve(img.naturalWidth === 0 ? 'error' : 'success');
          } else {
            img.onerror = () => resolve('error');
            img.onload = () => resolve('success');
          }
        });
      }''');
      expect(result, equals('error'));
    });

    test('should fulfill request with custom content', (page) async {
      await page.route('**/api/data', (route) async {
        await route.fulfill(
          status: 200,
          headers: [
            NameValue(name: 'content-type', value: 'application/json'),
            NameValue(name: 'access-control-allow-origin', value: '*'),
          ],
          body: '{"message":"mocked"}',
        );
      });

      // Navigate to a real page first so same-origin fetches are allowed.
      await page.goto('https://example.com');

      final result = await page.evaluate('''async () => {
        const res = await fetch('https://example.com/api/data');
        return await res.json();
      }''');

      expect(result['message'], equals('mocked'));
    });
  });

  group('Response API', () {
    test('should return basic properties', (page) async {
      await page.route('**/*', (route) async {
        await route.fulfill(
          status: 200,
          headers: [NameValue(name: 'content-type', value: 'text/html')],
          body: '<html><body>hello</body></html>',
        );
      });

      final responseFuture = page.waitForResponse(
        (Response r) => r.url.contains('example.com'),
      );
      await page.goto('https://example.com/test');
      final response = await responseFuture;

      expect(response, isNotNull);
      expect(response.ok, isTrue);
      expect(response.status, equals(200));
      expect(response.url, contains('example.com'));
    });

    test('should return response body and headers', (page) async {
      await page.route('**/api/data', (route) async {
        await route.fulfill(
          status: 201,
          headers: [
            NameValue(name: 'content-type', value: 'application/json'),
            NameValue(name: 'x-custom', value: 'my-value'),
            NameValue(name: 'access-control-allow-origin', value: '*'),
          ],
          body: '{"message":"mocked"}',
        );
      });

      // Navigate to real site first (no catch-all route needed).
      await page.goto('https://example.com');

      final responseFuture = page.waitForResponse(
        (Response r) => r.url.contains('/api/data'),
      );
      await page.evaluate(
        'async () => { await fetch("https://example.com/api/data"); }',
      );
      final response = await responseFuture;

      expect(response.status, equals(201));

      final text = await response.text();
      expect(text, equals('{"message":"mocked"}'));

      final json = await response.json();
      expect(json['message'], equals('mocked'));

      final body = await response.body();
      expect(body, isNotEmpty);

      final headers = response.headers;
      expect(headers['content-type'], equals('application/json'));
      expect(headers['x-custom'], equals('my-value'));

      final allHeaders = await response.allHeaders();
      expect(allHeaders['content-type'], equals('application/json'));
    });
  });
}
