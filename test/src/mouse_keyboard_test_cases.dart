import '../test_helper.dart';

void main() {
  setUpAll(() async {
    await setupBrowser();
  });

  tearDownAll(() async {
    await teardownBrowser();
  });

  group('Mouse & Keyboard API', () {
    test('should click and type', (page) async {
      await page.setContent('''
        <input type="text" id="input" />
        <div id="result"></div>
        <script>
          document.getElementById('input').addEventListener('input', (e) => {
            document.getElementById('result').innerText = e.target.value;
          });
        </script>
      ''');

      await page.focus('#input');
      await page.keyboard.type('Hello World');

      final text = await page.locator('#result').textContent();
      expect(text, equals('Hello World'));
    });

    test('should hover over element', (page) async {
      await page.setContent('''
        <div id="box" style="width: 100px; height: 100px; background: red;"></div>
        <div id="status"></div>
        <script>
          const box = document.getElementById('box');
          box.addEventListener('mouseenter', () => {
            document.getElementById('status').innerText = 'Hovered';
          });
          box.addEventListener('mouseleave', () => {
            document.getElementById('status').innerText = 'Left';
          });
        </script>
      ''');

      await page.hover('#box');
      expect(await page.locator('#status').textContent(), equals('Hovered'));

      await page.mouse.move(200, 200); // move away
      // Give it a small delay to process the event
      await page.waitForTimeout(50);
      expect(await page.locator('#status').textContent(), equals('Left'));
    });

    test('should dblclick, wheel and click with modifiers', (page) async {
      await page.setContent('''
        <div id="target" style="width: 200px; height: 200px; background: blue;"></div>
      ''');

      await page.evaluate('''() => {
        window.logs = [];
        const t = document.getElementById('target');
        t.addEventListener('dblclick', e => window.logs.push('dblclick'));
        t.addEventListener('wheel', e => window.logs.push('wheel:' + e.deltaY));
        t.addEventListener('click', e => window.logs.push('click:shift=' + e.shiftKey));
      }''');

      final target =
          (await page.waitForSelector('#target')).element as ElementHandle;
      final box = await target.boundingBox();

      // Move to center
      await page.mouse.move(box!.x + 100, box.y + 100);

      // Dblclick
      await page.mouse.dblclick(box.x + 100, box.y + 100);

      // Wheel
      await page.mouse.wheel(0, 100);

      // Click with Shift
      await page.keyboard.down('Shift');
      await page.mouse.click(box.x + 100, box.y + 100);
      await page.keyboard.up('Shift');

      final logs = await page.evaluate('() => window.logs');
      expect(logs, contains('dblclick'));
      expect(logs, contains('wheel:100'));
      expect(logs, contains('click:shift=true'));
    });

    test('should support keyboard insertText and modifiers', (page) async {
      await page.setContent('<textarea id="ta"></textarea>');
      await page.focus('#ta');

      // insertText
      await page.keyboard.insertText('Hello');
      expect(await page.locator('#ta').inputValue(), equals('Hello'));

      // Select all and delete (Assuming Mac uses Meta, Win uses Control, let's use Control for standard web inputs when possible, or just backspace repeatedly if Control+A is platform dependent)
      // Actually standard 'a' with control might not select all on Mac, but let's just test that the modifier is passed
      await page.keyboard.down('Shift');
      await page.keyboard.press('ArrowLeft');
      await page.keyboard.press('ArrowLeft');
      await page.keyboard.press('ArrowLeft');
      await page.keyboard.press('ArrowLeft');
      await page.keyboard.press('ArrowLeft');
      await page.keyboard.up('Shift');
      await page.keyboard.press('Backspace');

      expect(await page.locator('#ta').inputValue(), equals(''));

      // Modifiers with type
      await page.keyboard.down('Shift');
      await page.keyboard.press('a');
      await page.keyboard.up('Shift');
      expect(await page.locator('#ta').inputValue(), equals('a'));
    });
  });
}
