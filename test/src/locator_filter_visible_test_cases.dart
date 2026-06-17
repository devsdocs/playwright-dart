import '../test_helper.dart';

void main() {
  group('Locator.filter({ visible })', () {
    test('filter visible=true returns only visible elements', (page) async {
      await page.setContent('''
        <div class="item">Visible 1</div>
        <div class="item" style="display:none">Hidden</div>
        <div class="item">Visible 2</div>
      ''');
      final visible = page.locator('.item').filter(visible: true);
      final count = await visible.count();
      expect(count, 2);
    });

    test('filter visible=false returns only hidden elements', (page) async {
      await page.setContent('''
        <div class="item">Visible</div>
        <div class="item" style="display:none">Hidden 1</div>
        <div class="item" style="visibility:hidden">Hidden 2</div>
      ''');
      final hidden = page.locator('.item').filter(visible: false);
      final count = await hidden.count();
      expect(count, greaterThanOrEqualTo(1));
    });

    test('filter visible can be combined with hasText', (page) async {
      await page.setContent('''
        <div class="item">Match</div>
        <div class="item" style="display:none">Match hidden</div>
      ''');
      final visibleMatch = page
          .locator('.item')
          .filter(visible: true, hasText: 'Match');
      final count = await visibleMatch.count();
      expect(count, 1);
    });
  });

  group('FrameLocator.owner()', () {
    test('owner returns locator for iframe element', (page) async {
      await page.setContent('''
        <iframe id="myFrame" src="about:blank"></iframe>
      ''');
      final frameLocator = page.frameLocator('#myFrame');
      final ownerLocator = frameLocator.owner();
      final count = await ownerLocator.count();
      expect(count, 1);
    });
  });

  group('Locator.description() and toString()', () {
    test('description returns null for plain locator', (page) async {
      await page.setContent('<div>content</div>');
      final loc = page.locator('div');
      expect(loc.description(), isNull);
    });

    test('description returns the description string', (page) async {
      await page.setContent('<div>content</div>');
      final loc = page.locator('div').describe('My awesome div');
      expect(loc.description(), equals('My awesome div'));
    });

    test('toString uses description when set', (page) async {
      await page.setContent('<div>content</div>');
      final loc = page.locator('div').describe('submit button');
      expect(loc.toString(), equals('submit button'));
    });

    test('toString falls back to selector when no description', (page) async {
      await page.setContent('<div>content</div>');
      final loc = page.locator('div');
      expect(loc.toString(), startsWith('Locator@'));
    });
  });
}
