import 'test_helper.dart';

void main() {
  group('Network Interception', () {
    test('should abort request', (page) async {
      await page.route('**/*.png', (route) async {
        await route.abort();
      });

      await page.setContent('<img src="https://playwright.dev/img/playwright-logo.png" />');
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
          headers: {'content-type': 'application/json'},
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
}
