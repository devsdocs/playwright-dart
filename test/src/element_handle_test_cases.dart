import '../test_helper.dart';

void main() {
  setUpAll(() async {
    await setupBrowser();
  });

  tearDownAll(() async {
    await teardownBrowser();
  });

  group('ElementHandle API', () {
    test('should query bounding box', (page) async {
      await page.setContent('''
        <div id="box" style="width: 100px; height: 50px; position: absolute; left: 10px; top: 20px;"></div>
      ''');

      final jsHandle = await page.waitForFunction(
        '() => document.getElementById("box")',
      );
      final handle = jsHandle.asElement();
      expect(handle, isNotNull);

      final box = await handle!.boundingBox();
      expect(box, isNotNull);
      expect(box!.width, equals(100));
      expect(box.height, equals(50));
      expect(box.x, equals(10));
      expect(box.y, equals(20));

      await jsHandle.dispose();
    });

    test('should return content frame and owner frame', (page) async {
      await page.setContent('''
        <iframe name="test-frame" src="data:text/html,<html><body>Hello</body></html>"></iframe>
      ''');

      final jsHandle = await page.waitForFunction(
        '() => document.querySelector("iframe")',
      );
      final handle = jsHandle.asElement();
      expect(handle, isNotNull);

      final contentFrame = await handle!.contentFrame();
      expect(contentFrame, isNotNull);
      expect(contentFrame!.page, equals(page));

      final ownerFrame = await handle.ownerFrame();
      expect(ownerFrame, isNotNull);
      expect(ownerFrame!.page, equals(page));

      await jsHandle.dispose();
    });

    test('should fill and click', (page) async {
      await page.setContent('''
        <input id="input" type="text" />
        <button id="btn">Submit</button>
      ''');

      final inputJsHandle = await page.waitForFunction(
        '() => document.getElementById("input")',
      );
      final inputHandle = inputJsHandle.asElement();
      await inputHandle!.fill('test value');

      final inputValue = await page.evaluate(
        '() => document.getElementById("input").value',
      );
      expect(inputValue, equals('test value'));

      final btnJsHandle = await page.waitForFunction(
        '() => document.getElementById("btn")',
      );
      final btnHandle = btnJsHandle.asElement();

      await page.evaluate(
        '() => { window.clicked = false; document.getElementById("btn").addEventListener("click", () => window.clicked = true); }',
      );

      await btnHandle!.click();

      final clicked = await page.evaluate('() => window.clicked');
      expect(clicked, isTrue);

      await inputJsHandle.dispose();
      await btnJsHandle.dispose();
    });

    test('should hover and focus', (page) async {
      await page.setContent('''
        <input id="input" type="text" />
      ''');

      final jsHandle = await page.waitForFunction(
        '() => document.getElementById("input")',
      );
      final handle = jsHandle.asElement();

      await handle!.hover();
      await handle.focus();

      final activeElement = await page.evaluate(
        '() => document.activeElement.id',
      );
      expect(activeElement, equals('input'));

      await jsHandle.dispose();
    });

    test('should dblclick and tap', (page) async {
      await page.setContent('''
        <button id="dblbtn">DblClick</button>
        <button id="tapbtn">Tap</button>
      ''');

      final dblbtn =
          (await page.waitForSelector('#dblbtn')).element as ElementHandle?;
      await page.evaluate(
        '() => { window.dbl = false; document.getElementById("dblbtn").addEventListener("dblclick", () => window.dbl = true); }',
      );
      await dblbtn!.dblclick();
      expect(await page.evaluate('() => window.dbl'), isTrue);

      final tapbtn =
          (await page.waitForSelector('#tapbtn')).element as ElementHandle?;
      await page.evaluate(
        '() => { window.tapped = false; document.getElementById("tapbtn").addEventListener("pointerdown", () => window.tapped = true); }',
      );
      await tapbtn!.tap();
      expect(await page.evaluate('() => window.tapped'), isTrue);
    });

    test('should check, uncheck', (page) async {
      await page.setContent('<input type="checkbox" id="chk" />');
      final chk =
          (await page.waitForSelector('#chk')).element as ElementHandle?;

      await chk!.check();
      expect(
        await page.evaluate('() => document.getElementById("chk").checked'),
        isTrue,
      );

      await chk.uncheck();
      expect(
        await page.evaluate('() => document.getElementById("chk").checked'),
        isFalse,
      );
    });

    test('should selectOption', (page) async {
      await page.setContent('''
        <select id="sel">
          <option value="opt1">Option 1</option>
          <option value="opt2">Option 2</option>
        </select>
      ''');
      final sel =
          (await page.waitForSelector('#sel')).element as ElementHandle?;
      final selected = await sel!.selectOption(
        values: [SelectOption(value: 'opt2')],
      );
      expect(selected, equals(['opt2']));
      expect(
        await page.evaluate('() => document.getElementById("sel").value'),
        equals('opt2'),
      );
    });

    test('should get content attributes', (page) async {
      await page.setContent('''
        <div id="content" data-val="123">
          <span>Hello</span>
        </div>
        <input id="inp" value="test input" />
      ''');

      final content =
          (await page.waitForSelector('#content')).element as ElementHandle;
      expect(await content.getAttribute('data-val'), equals('123'));
      expect(await content.innerHTML(), contains('<span>Hello</span>'));
      expect(await content.innerText(), equals('Hello'));
      expect((await content.textContent()).trim(), equals('Hello'));

      final inp = (await page.waitForSelector('#inp')).element as ElementHandle;
      expect(await inp.inputValue(), equals('test input'));
    });

    test('should type and press', (page) async {
      await page.setContent('<input id="inp" type="text" />');
      final inp = (await page.waitForSelector('#inp')).element as ElementHandle;

      await inp.type('hello');
      expect(await inp.inputValue(), equals('hello'));

      await inp.press('Backspace');
      expect(await inp.inputValue(), equals('hell'));
    });

    test('should scrollIntoViewIfNeeded and waitForElementState', (page) async {
      await page.setContent('''
        <div style="height: 2000px;"></div>
        <div id="target">Target</div>
      ''');
      final target =
          (await page.waitForSelector('#target')).element as ElementHandle;
      await target.scrollIntoViewIfNeeded();

      // wait for element state
      await target.waitForElementState(
        ElementHandleWaitForElementStateStateEnum.visible,
      );
    });
  });
}
