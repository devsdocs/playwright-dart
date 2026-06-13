import '../test_helper.dart';

void main() {
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
      await page.keyboard.down('Shift');
      expect(await page.evaluate('() => shiftDown'), isTrue);
      await page.keyboard.up('Shift');
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
      await page.keyboard.press('Enter');
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
  });
}
