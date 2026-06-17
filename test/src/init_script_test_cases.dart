import '../test_helper.dart';

void main() {
  setUpAll(() async {
    await setupBrowser();
  });

  tearDownAll(() async {
    await teardownBrowser();
  });

  group('Init Scripts API', () {
    test('should add init script to page', (page) async {
      await page.addInitScript('window.injectedVar = "hello page";');
      await page.goto('https://example.com');

      final injected = await page.evaluate('window.injectedVar');
      expect(injected, equals('hello page'));
    });

    test('should add init script to browser context', (page) async {
      final context = await browser.newContext();
      await context.addInitScript('window.contextVar = "hello context";');

      final newPage = await context.newPage();
      await newPage.goto('https://example.com');

      final injected = await newPage.evaluate('window.contextVar');
      expect(injected, equals('hello context'));
      await context.close();
    });
  });
}
