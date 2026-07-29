import '../test_helper.dart';
import 'package:playwright_dart/src/interaction/keyboard_key.dart';

void main() {
  setUpAll(() async {
    await setupBrowser();
  });

  tearDownAll(() async {
    await teardownBrowser();
  });

  group('Keyboard API', () {
    test('should insert text directly', (page) async {
      await page.setContent('<input id="inp" />');
      await page.focus('#inp');
      await page.keyboard.insertText('inserted text');
      expect(await page.inputValue('#inp'), equals('inserted text'));
    });

    test('should handle key combinations with down/up', (page) async {
      await page.setContent('''
        <input id="inp" value="hello world" />
        <script>
          let shiftDown = false;
          document.getElementById("inp").addEventListener("keydown", (e) => {
            if (e.key === "Shift") shiftDown = true;
          });
          document.getElementById("inp").addEventListener("keyup", (e) => {
            if (e.key === "Shift") shiftDown = false;
          });
        </script>
      ''');

      await page.focus('#inp');
      await page.keyboard.downKey(KeyboardKey.shift);
      expect(await page.evaluate('() => shiftDown'), isTrue);
      await page.keyboard.upKey(KeyboardKey.shift);
      expect(await page.evaluate('() => shiftDown'), isFalse);
    });

    test('should type text with keyboard', (page) async {
      await page.setContent('<textarea id="area"></textarea>');
      await page.focus('#area');
      await page.keyboard.type('Hello World');
      expect(
        await page.evaluate('() => document.getElementById("area").value'),
        equals('Hello World'),
      );
    });

    test('should press key with keyboard', (page) async {
      await page.setContent('''
        <input id="inp" />
        <script>
          let enterPressed = false;
          document.getElementById("inp").addEventListener("keydown", (e) => {
            if (e.key === "Enter") enterPressed = true;
          });
        </script>
      ''');

      await page.focus('#inp');
      await page.keyboard.pressKey(KeyboardKey.enter);
      expect(await page.evaluate('() => enterPressed'), isTrue);
    });
  });

  group('Mouse API', () {
    test('should move mouse', (page) async {
      await page.setContent('''
        <div id="target" style="width:200px;height:200px;"></div>
        <script>
          let mouseX = 0, mouseY = 0;
          document.addEventListener("mousemove", (e) => {
            mouseX = e.clientX;
            mouseY = e.clientY;
          });
        </script>
      ''');

      await page.mouse.move(100, 100);
      final x = await page.evaluate('() => mouseX');
      final y = await page.evaluate('() => mouseY');
      expect(x, equals(100));
      expect(y, equals(100));
    });

    test('should click at coordinates', (page) async {
      await page.setContent('''
        <div id="target" style="width:200px;height:200px;"></div>
        <script>
          let clickX = 0, clickY = 0;
          document.addEventListener("click", (e) => {
            clickX = e.clientX;
            clickY = e.clientY;
          });
        </script>
      ''');

      await page.mouse.click(50, 50);
      final x = await page.evaluate('() => clickX');
      final y = await page.evaluate('() => clickY');
      expect(x, equals(50));
      expect(y, equals(50));
    });

    test('should double click at coordinates', (page) async {
      await page.setContent('''
        <div style="width:200px;height:200px;"></div>
        <script>
          let dblClicked = false;
          document.addEventListener("dblclick", () => { dblClicked = true; });
        </script>
      ''');

      await page.mouse.dblclick(50, 50);
      expect(await page.evaluate('() => dblClicked'), isTrue);
    });

    test('should mouse down and up', (page) async {
      await page.setContent('''
        <div style="width:200px;height:200px;"></div>
        <script>
          let mouseIsDown = false;
          document.addEventListener("mousedown", () => { mouseIsDown = true; });
          document.addEventListener("mouseup", () => { mouseIsDown = false; });
        </script>
      ''');

      await page.mouse.move(50, 50);
      await page.mouse.down();
      expect(await page.evaluate('() => mouseIsDown'), isTrue);
      await page.mouse.up();
      expect(await page.evaluate('() => mouseIsDown'), isFalse);
    });

    test('should click with button options', (page) async {
      await page.setContent('''
        <div style="width:200px;height:200px;"></div>
        <script>
          let rightClicked = false;
          document.addEventListener("contextmenu", () => { rightClicked = true; });
        </script>
      ''');

      await page.mouse.click(50, 50, button: Button.right);
      expect(await page.evaluate('() => rightClicked'), isTrue);
    });

    test('should click with delay', (page) async {
      await page.setContent('''
        <div style="width:200px;height:200px;"></div>
        <script>
          let clickCount = 0;
          document.addEventListener("click", () => { clickCount++; });
        </script>
      ''');

      await page.mouse.click(50, 50, delay: 100);
      expect(await page.evaluate('() => clickCount'), equals(1));
    });
  });

  group('Touchscreen API', () {
    test('should tap at coordinates', (page) async {
      // Create a new context with hasTouch enabled
      final context = await browser.newContext(
        options: ContextOptions(hasTouch: true),
      );
      final touchPage = await context.newPage();

      try {
        await touchPage.setContent('''
          <div style="width:200px;height:200px;"></div>
          <script>
            let tapped = false;
            document.addEventListener("click", () => { tapped = true; });
          </script>
        ''');

        await touchPage.touchscreen.tap(50, 50);
        expect(await touchPage.evaluate('() => tapped'), isTrue);
      } finally {
        await touchPage.close();
        await context.close();
      }
    });
  });

  group('Advanced Keyboard', () {
    test('should handle multiple key presses', (page) async {
      await page.setContent('<input id="inp" />');
      await page.focus('#inp');
      await page.keyboard.pressKey(KeyboardKey.keyA);
      await page.keyboard.pressKey(KeyboardKey.keyB);
      await page.keyboard.pressKey(KeyboardKey.keyC);
      expect(await page.inputValue('#inp'), equals('abc'));
    });

    test('should handle modifier keys', (page) async {
      await page.setContent('<input id="inp" />');
      await page.focus('#inp');
      await page.keyboard.downKey(KeyboardKey.shift);
      await page.keyboard.pressKey(KeyboardKey.keyA);
      await page.keyboard.upKey(KeyboardKey.shift);
      expect(await page.inputValue('#inp'), equals('A'));
    });

    test('should handle backspace', (page) async {
      await page.setContent('<input id="inp" value="hello" />');
      await page.focus('#inp');
      // Move cursor to end and press backspace
      await page.keyboard.pressKey(KeyboardKey.end);
      await page.keyboard.pressKey(KeyboardKey.backspace);
      expect(await page.inputValue('#inp'), equals('hell'));
    });
  });
}
