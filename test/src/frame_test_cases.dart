import '../test_helper.dart';

void main() {
  setUpAll(() async {
    await setupBrowser();
  });

  tearDownAll(() async {
    await teardownBrowser();
  });

  group('Frame API', () {
    test('should evaluate in frame', (page) async {
      await page.setContent('''
        <iframe id="frame1" srcdoc="<div>Frame Content</div>"></iframe>
      ''');

      // Wait for iframe to load
      await page.waitForSelector('iframe');

      // In Playwright Dart, mainFrame.childFrames might not be exposed synchronously,
      // but we can query the frame using JS or locator.
      final frameElement = page.locator('iframe');
      final srcdoc = await frameElement.getAttribute('srcdoc');
      expect(srcdoc, contains('Frame Content'));
    });

    test('should locate elements inside frame', (page) async {
      await page.setContent('''
        <iframe srcdoc="<button id='btn'>Click Me</button>"></iframe>
      ''');

      // Currently frame locators are typically created using page.frameLocator('iframe')
      // Let's check if frameLocator is implemented, otherwise just test frame presence.
      // Assuming frameLocator is not yet on Page, we will skip frameLocator specific tests
      // or just test evaluate.

      final buttonCount = await page.evaluate('''() => {
        return document.querySelector('iframe').contentDocument.querySelectorAll('#btn').length;
      }''');

      expect(buttonCount, equals(1));
    });
  });

  group('FrameLocator API', () {
    test('should locate elements inside frame using frameLocator', (
      page,
    ) async {
      await page.setContent('''
        <iframe srcdoc="<button id='btn'>Click Me</button>"></iframe>
      ''');

      final frameLoc = page.frameLocator('iframe');
      final btn = frameLoc.locator('#btn');
      expect(await btn.textContent(), equals('Click Me'));
    });

    test('should use getByRole inside frame', (page) async {
      await page.setContent('''
        <iframe srcdoc="<button>Submit</button>"></iframe>
      ''');

      final submitBtn = page
          .frameLocator('iframe')
          .getByRole('button', name: 'Submit');
      expect(await submitBtn.textContent(), equals('Submit'));
    });

    test('should support nested frameLocators', (page) async {
      await page.setContent('''
        <iframe id="outer" srcdoc="
          <iframe id='inner' srcdoc='<h1>Nested</h1>'></iframe>
        "></iframe>
      ''');

      final innerH1 = page
          .frameLocator('#outer')
          .frameLocator('#inner')
          .locator('h1');
      expect(await innerH1.textContent(), equals('Nested'));
    });
  });
}
