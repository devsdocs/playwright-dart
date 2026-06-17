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
  });
}
