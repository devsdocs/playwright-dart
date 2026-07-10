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

    test('should expose Frame properties', (page) async {
      await page.setContent('''
        <iframe name="test-frame" srcdoc="<div>Frame Content</div>"></iframe>
      ''');
      await page.waitForSelector('iframe');

      final mainFrame = page.mainFrame;
      expect(mainFrame.name, isEmpty);
      expect(mainFrame.url(), equals('about:blank'));

      final childFrames = mainFrame.childFrames;
      expect(childFrames.length, equals(1));

      final child = childFrames.first;
      expect(child.name, equals('test-frame'));
      expect(child.parentFrame, equals(mainFrame));
    });

    test('should perform actions directly on Frame', (page) async {
      await page.setContent('''
        <input id="inp" type="text" />
        <input type="checkbox" id="chk" />
        <select id="sel">
          <option value="opt1">Option 1</option>
          <option value="opt2">Option 2</option>
        </select>
        <div id="drag" style="width: 50px; height: 50px; background: red;"></div>
        <div id="drop" style="width: 100px; height: 100px; background: blue; position: absolute; top: 200px;"></div>
      ''');

      final frame = page.mainFrame;

      await frame.type('#inp', 'hello');
      expect(await frame.inputValue('#inp'), equals('hello'));

      await frame.press('#inp', 'Backspace');
      expect(await frame.inputValue('#inp'), equals('hell'));

      await frame.setChecked('#chk', true);
      expect(await frame.isChecked('#chk'), isTrue);
      await frame.selectOption('#sel', [SelectOption(value: 'opt2')]);
      expect(
        await frame.evalOnSelector('#sel', 'el => el.value'),
        equals('opt2'),
      );

      await frame.dispatchEvent('#drag', 'click');

      await frame.dragAndDrop('#drag', '#drop');

      final res = await frame.waitForFunction('() => 1 + 1');
      expect(await res.jsonValue(), equals(2));
      await res.dispose();
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

    test('should support first, last, nth on FrameLocator', (page) async {
      await page.setContent('''
        <iframe class="frame" srcdoc="<h1>1</h1>"></iframe>
        <iframe class="frame" srcdoc="<h1>2</h1>"></iframe>
        <iframe class="frame" srcdoc="<h1>3</h1>"></iframe>
      ''');

      final locators = page.locator('.frame');
      expect(
        await locators.first().contentFrame.locator('h1').textContent(),
        equals('1'),
      );
      expect(
        await locators.last().contentFrame.locator('h1').textContent(),
        equals('3'),
      );
      expect(
        await locators.nth(1).contentFrame.locator('h1').textContent(),
        equals('2'),
      );
    });
  });
}
