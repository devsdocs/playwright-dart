import '../test_helper.dart';

void main() {
  setUpAll(() async {
    await setupBrowser();
  });

  tearDownAll(() async {
    await teardownBrowser();
  });

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

    test('should use toBeAttached assertion', (page) async {
      await page.setContent('<div id="existing">Content</div>');

      final existing = page.locator('#existing');
      await existing.expect().toBeAttached();

      final nonExisting = page.locator('#non-existing');
      await nonExisting.expect().not.toBeAttached();
    });

    test('should use toBeEditable assertion', (page) async {
      await page.setContent('''
        <input type="text" id="editable" value="test" />
        <input type="text" id="disabled" disabled value="test" />
      ''');

      await page.locator('#editable').expect().toBeEditable();
      await page.locator('#disabled').expect().not.toBeEditable();
    });

    test('should use toBeEmpty assertion', (page) async {
      await page.setContent('''
        <input type="text" id="empty" value="" />
        <input type="text" id="filled" value="test" />
      ''');

      await page.locator('#empty').expect().toBeEmpty();
      await page.locator('#filled').expect().not.toBeEmpty();
    });

    test('should use toBeFocused assertion', (page) async {
      await page.setContent('<input type="text" id="input" />');

      final input = page.locator('#input');
      await input.focus();
      await input.expect().toBeFocused();
    });

    test('should use toContainClass assertion', (page) async {
      await page.setContent('<div class="foo bar baz" id="div">Content</div>');

      final div = page.locator('#div');
      await div.expect().toContainClass('foo');
      await div.expect().toContainClass(['foo', 'bar']);
    });

    test('should use toHaveAccessibleName assertion', (page) async {
      await page.setContent(
        '<button aria-label="Submit Button">Click</button>',
      );

      await page
          .locator('button')
          .expect()
          .toHaveAccessibleName('Submit Button');
    });

    test('should use toHaveRole assertion', (page) async {
      await page.setContent('<button>Click</button>');

      await page.locator('button').expect().toHaveRole('button');
    });

    test('should use toHaveCSS assertion', (page) async {
      await page.setContent('<div style="color: red;" id="div">Content</div>');

      await page.locator('#div').expect().toHaveCSS('color', 'rgb(255, 0, 0)');
    });

    test('should use toHaveValues assertion for multi-select', (page) async {
      await page.setContent('''
        <select id="select" multiple>
          <option value="a" selected>A</option>
          <option value="b" selected>B</option>
          <option value="c">C</option>
        </select>
      ''');

      await page.locator('#select').expect().toHaveValues(['a', 'b']);
    });

    test('should use toBeChecked with indeterminate option', (page) async {
      await page.setContent('<input type="checkbox" id="chk" />');

      final chk = page.locator('#chk');
      await chk.evaluate('el => el.indeterminate = true');

      await chk.expect().toBeChecked(indeterminate: true);
    });
    test('querySelectorAll should map locators with nth to target individual elements', (page) async {
      await page.setContent('''
        <div class="list">
          <button id="btn1">Btn 1</button>
          <button id="btn2">Btn 2</button>
          <button id="btn3">Btn 3</button>
        </div>
      ''');

      final buttons = await page.querySelectorAll('button');
      expect(buttons.length, equals(3));

      expect(await buttons[0].innerText(), equals('Btn 1'));
      expect(await buttons[1].innerText(), equals('Btn 2'));
      expect(await buttons[2].innerText(), equals('Btn 3'));
    });
  });
}
