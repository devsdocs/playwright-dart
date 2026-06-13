import 'test_helper.dart';

void main() {
  group('Locator API', () {
    test('should click and fill', (page) async {
      await page.setContent('''
        <form>
          <input type="text" id="name" />
          <button id="submit">Submit</button>
        </form>
        <div id="result"></div>
        <script>
          document.getElementById('submit').addEventListener('click', (e) => {
            e.preventDefault();
            document.getElementById('result').innerText = document.getElementById('name').value;
          });
        </script>
      ''');

      await page.locator('#name').fill('Playwright Dart');
      await page.locator('#submit').click();
      
      final resultText = await page.locator('#result').textContent();
      expect(resultText, equals('Playwright Dart'));
    });

    test('should use sub-locators correctly', (page) async {
      await page.setContent('''
        <div class="container">
          <button>First</button>
          <button>Second</button>
        </div>
      ''');

      final container = page.locator('.container');
      final secondButton = container.getByText('Second');
      
      expect(await secondButton.textContent(), equals('Second'));
    });

    test('should check and uncheck', (page) async {
      await page.setContent('<input type="checkbox" id="chk" />');
      
      final chk = page.locator('#chk');
      expect(await chk.isChecked(), isFalse);
      
      await chk.check();
      expect(await chk.isChecked(), isTrue);
      
      await chk.uncheck();
      expect(await chk.isChecked(), isFalse);
    });
  });
}
