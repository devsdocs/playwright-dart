import '../test_helper.dart';

void main() {
  group('Touchscreen API', () {
    test('should tap on element', (defaultPage) async {
      final context = await browser.newContext(options: ContextOptions(hasTouch: true));
      final page = await context.newPage();
      
      await page.setContent('''
        <div id="target" style="width: 100px; height: 100px; background: red;"></div>
        <script>
          let tapped = false;
          document.getElementById('target').addEventListener('touchstart', (e) => {
            tapped = true;
          });
        </script>
      ''');
      
      final box = await page.evaluate('''() => {
        const rect = document.getElementById('target').getBoundingClientRect();
        return {x: rect.x, y: rect.y, width: rect.width, height: rect.height};
      }''') as Map;
      expect(box, isNotNull);
      
      // Simulate tap on the center of the element
      await page.touchscreen.tap((box['x'] + box['width'] / 2).toDouble(), (box['y'] + box['height'] / 2).toDouble());
      
      final tapped = await page.evaluate('() => tapped');
      expect(tapped, isTrue);
      
      await context.close();
    });
  });
}
