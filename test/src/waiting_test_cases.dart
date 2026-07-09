import '../test_helper.dart';

void main() {
  setUpAll(() async {
    await setupBrowser();
  });

  tearDownAll(() async {
    await teardownBrowser();
  });

  group('Waiting API', () {
    test('should wait for selector', (page) async {
      await page.setContent('''
        <div id="delayed"></div>
        <script>
          setTimeout(() => {
            const el = document.createElement('div');
            el.id = 'target';
            el.textContent = 'Hello';
            document.body.appendChild(el);
          }, 500);
        </script>
      ''');

      await page.waitForSelector('#target');
      final text = await page.locator('#target').innerText();
      expect(text, equals('Hello'));
    });

    test('should wait for function', (page) async {
      await page.setContent('''
        <script>
          window.myVar = false;
          setTimeout(() => { window.myVar = true; }, 500);
        </script>
      ''');

      final result = await page.waitForFunction('() => window.myVar === true');
      expect(result, isNotNull);
    });

    test('should wait for timeout', (page) async {
      final startTime = DateTime.now();
      await page.waitForTimeout(500);
      final endTime = DateTime.now();
      expect(
        endTime.difference(startTime).inMilliseconds,
        greaterThanOrEqualTo(450),
      );
    });

    test('should wait for request', (page) async {
      page.onRequest.listen((req) => print('REQ: \${req.url}'));

      final requestFuture = page.waitForRequest(
        RouteMatcher.string('http://localhost/dummy-endpoint'),
      );

      await Future.delayed(Duration(milliseconds: 100));

      await page.evaluate('''() => {
        fetch('http://localhost/dummy-endpoint');
      }''');

      final request = await requestFuture;
      expect(request.url, contains('dummy-endpoint'));
      expect(request.method, equals('GET'));
    });
  });
}
