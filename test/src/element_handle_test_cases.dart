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
  });
}
