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
      // Wait for network idle or error
      // In this case, we just check if it fails to load
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
          headers: [NameValue(name: 'content-type', value: 'application/json')],
          body: '{"message":"mocked"}',
        );
      });

      await page.setContent('''
        <div id="output"></div>
        <script>
          fetch('http://localhost/api/data')
            .then(res => res.json())
            .then(data => {
              document.getElementById('output').innerText = data.message;
            });
        </script>
      ''');

      // Wait a moment for fetch to complete
      await page.waitForSelector('#output:has-text("mocked")');
      final text = await page.locator('#output').textContent();

      expect(text, equals('mocked'));
    });
  });

  group('Response API', () {
    test('should return basic properties', (page) async {
      await page.route('**/test', (route) async {
        await route.fulfill(status: 200, body: 'hello');
      });
      final responseFuture = page.waitForResponse(
        (Response r) => r.url.contains('/test'),
      );
      await page.goto('http://localhost/test');
      final response = await responseFuture;

      expect(response, isNotNull);
      expect(response.ok, isTrue);
      expect(response.status, equals(200));
      expect(response.statusText, equals('OK'));
      expect(response.url, equals('http://localhost/test'));
    });

    test('should return response body and headers', (page) async {
      await page.route('**/api/data', (route) async {
        await route.fulfill(
          status: 201,
          headers: [
            NameValue(name: 'content-type', value: 'application/json'),
            NameValue(name: 'x-custom', value: 'my-value'),
          ],
          body: '{"message":"mocked"}',
        );
      });

      final responseFuture = page.waitForResponse(
        (Response r) => r.url.contains('/api/data'),
      );
      await page.setContent(
        '<script>fetch("http://localhost/api/data");</script>',
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
