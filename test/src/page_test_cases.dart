import '../test_helper.dart';

void main() {
  setUpAll(() async {
    await setupBrowser();
  });

  tearDownAll(() async {
    await teardownBrowser();
  });

  group('Page API', () {
    test('should navigate and return title', (page) async {
      await page.goto('https://example.com');
      final title = await page.title();
      expect(title, equals('Example Domain'));
    });

    test('should evaluate JavaScript', (page) async {
      final result = await page.evaluate('1 + 2');
      expect(result, equals(3));
    });

    test('should set content and evaluate', (page) async {
      await page.setContent('<div><h1>Hello World</h1></div>');
      final text = await page.evaluate(
        '() => document.querySelector("h1").innerText',
      );
      expect(text, equals('Hello World'));
    });
  });

  group('Page Lifecycle & Properties API', () {
    test('should expose isClosed property', (page) async {
      expect(page.isClosed, isFalse);
      await page.close();
      expect(page.isClosed, isTrue);
    });

    test('should expose viewportSize', (page) async {
      final viewport = page.viewportSize;
      expect(viewport, isNotNull);
      expect(viewport!.width, greaterThan(0));
      expect(viewport.height, greaterThan(0));
    });

    test('should set default timeouts', (page) async {
      // Test that timeout can be set without throwing errors
      // The actual timeout functionality is tested in integration tests
      page.setDefaultTimeout(5000);
      page.setDefaultNavigationTimeout(5000);

      // Verify the timeout is set by checking it doesn't throw
      expect(() => page.setDefaultTimeout(1000), returnsNormally);
      expect(() => page.setDefaultNavigationTimeout(1000), returnsNormally);

      // Reset to default timeout to avoid affecting other tests
      page.setDefaultTimeout(30000);
      page.setDefaultNavigationTimeout(30000);
    });
  });
}
