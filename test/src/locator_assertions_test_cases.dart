import '../test_helper.dart';

void main() {
  setUpAll(() async {
    await setupBrowser();
  });

  tearDownAll(() async {
    await teardownBrowser();
  });

  group('LocatorAssertions', () {
    test('LocatorAssertions should wait for visibility', (page) async {
      await page.setContent('<div id="box" style="display: none;">Hello</div>');
      final locator = page.locator('#box');

      // Evaluate in background
      page.evaluate(
        'setTimeout(() => document.getElementById("box").style.display = "block", 1000)',
      );

      // Should wait and pass
      await locator.expect(timeout: 3000).toBeVisible();
    });

    test('LocatorAssertions should wait for hidden', (page) async {
      await page.setContent('<div id="box">Hello</div>');
      final locator = page.locator('#box');

      // Evaluate in background
      page.evaluate(
        'setTimeout(() => document.getElementById("box").style.display = "none", 1000)',
      );

      // Should wait and pass
      await locator.expect(timeout: 3000).toBeHidden();
    });

    test('LocatorAssertions should assert text', (page) async {
      await page.setContent('<div>Hello World</div>');
      await page.locator('div').expect().toHaveText('Hello World');
      await page.locator('div').expect().toContainText('World');
    });

    test('LocatorAssertions should support not', (page) async {
      await page.setContent('<div>Hello World</div>');
      await page.locator('div').expect().not.toBeHidden();
      await page.locator('div').expect().not.toHaveText('Goodbye');
    });
  });
}
