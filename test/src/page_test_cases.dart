import '../test_helper.dart';

void main() {
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
      // Set to 1ms to ensure it throws a timeout error immediately
      page.setDefaultTimeout(1);

      try {
        await page.waitForSelector('.does-not-exist');
        fail('Should have timed out');
      } on TestFailure catch (_) {
        rethrow;
      } catch (e) {
        expect(e.toString(), contains('Timeout'));
      }

      page.setDefaultNavigationTimeout(1);
      try {
        await page.goto('https://example.com');
        fail('Should have timed out');
      } on TestFailure catch (_) {
        rethrow;
      } catch (e) {
        expect(e.toString(), contains('Timeout'));
      }
    });
  });
}
