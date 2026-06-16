import '../test_helper.dart';

void main() {
  group('Selectors API', () {
    test('should register custom selector engine globally', (page) async {
      final script = '''{
        query(root, selector) {
          return root.querySelector(selector);
        },
        queryAll(root, selector) {
          return Array.from(root.querySelectorAll(selector));
        }
      }''';

      await playwright.selectors.register('my-engine', script);

      await page.setContent('<div id="foo">bar</div>');

      final locator = page.locator('my-engine=#foo');
      await locator.expect().toHaveText('bar');
    });

    test('should set testIdAttribute globally', (page) async {
      await playwright.selectors.setTestIdAttribute('data-my-custom-id');

      // Create a new context to inherit the testIdAttribute
      final newContext = await browser.newContext();
      final newPage = await newContext.newPage();

      try {
        await newPage.setContent('<div data-my-custom-id="target">baz</div>');
        await newPage.getByTestId('target').expect().toHaveText('baz');
      } finally {
        await newContext.close();
      }
    });
  });
}
