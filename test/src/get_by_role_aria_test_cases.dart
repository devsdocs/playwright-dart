import '../test_helper.dart';

void main() {
  group('getByRole ARIA filter options', () {
    test('getByRole with checked filter finds checked checkbox', (page) async {
      await page.setContent('''
        <input type="checkbox" checked aria-label="Accept">
        <input type="checkbox" aria-label="Decline">
      ''');
      final checked = page.getByRole('checkbox', checked: true);
      final count = await checked.count();
      expect(count, 1);
    });

    test('getByRole with disabled filter finds disabled button', (page) async {
      await page.setContent('''
        <button disabled>Disabled</button>
        <button>Enabled</button>
      ''');
      final disabled = page.getByRole('button', disabled: true);
      final count = await disabled.count();
      expect(count, 1);
    });

    test('getByRole with level filter finds heading at specific level', (
      page,
    ) async {
      await page.setContent('''
        <h1>Heading 1</h1>
        <h2>Heading 2</h2>
        <h3>Heading 3</h3>
      ''');
      final h2 = page.getByRole('heading', level: 2);
      final count = await h2.count();
      expect(count, 1);
      final text = await h2.innerText();
      expect(text, 'Heading 2');
    });

    test('getByRole with expanded filter finds expanded element', (page) async {
      await page.setContent('''
        <div role="button" aria-expanded="true">Open</div>
        <div role="button" aria-expanded="false">Closed</div>
      ''');
      final expanded = page.getByRole('button', expanded: true);
      final count = await expanded.count();
      expect(count, 1);
    });

    test('getByRole with name and checked combined', (page) async {
      await page.setContent('''
        <input type="checkbox" checked aria-label="Subscribe">
        <input type="checkbox" aria-label="Subscribe">
      ''');
      // Only the checked one should match
      final loc = page.getByRole('checkbox', name: 'Subscribe', checked: true);
      final count = await loc.count();
      expect(count, 1);
    });

    test('Locator.getByRole with ARIA filters', (page) async {
      await page.setContent('''
        <div id="container">
          <button disabled>No</button>
          <button>Yes</button>
        </div>
      ''');
      final container = page.locator('#container');
      final disabled = container.getByRole('button', disabled: true);
      final count = await disabled.count();
      expect(count, 1);
    });

    test('Frame.getByRole with level filter', (page) async {
      await page.setContent('<h2>Frame heading</h2>');
      final h2 = page.mainFrame.getByRole('heading', level: 2);
      final count = await h2.count();
      expect(count, 1);
    });
  });
}
