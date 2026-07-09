import '../test_helper.dart';

void main() {
  setUpAll(() async {
    await setupBrowser();
  });

  tearDownAll(() async {
    await teardownBrowser();
  });

  group('Locator State API', () {
    test('should check isVisible and isHidden', (page) async {
      await page.setContent('''
        <div id="visible">Visible</div>
        <div id="hidden" style="display:none">Hidden</div>
      ''');

      final visible = page.locator('#visible');
      final hidden = page.locator('#hidden');

      expect(await visible.isVisible(), isTrue);
      expect(await visible.isHidden(), isFalse);
      expect(await hidden.isVisible(), isFalse);
      expect(await hidden.isHidden(), isTrue);
    });

    test('should check isEnabled and isDisabled', (page) async {
      await page.setContent('''
        <button id="enabled">Click</button>
        <button id="disabled" disabled>Click</button>
      ''');

      expect(await page.locator('#enabled').isEnabled(), isTrue);
      expect(await page.locator('#enabled').isDisabled(), isFalse);
      expect(await page.locator('#disabled').isEnabled(), isFalse);
      expect(await page.locator('#disabled').isDisabled(), isTrue);
    });

    test('should check isEditable', (page) async {
      await page.setContent('''
        <input id="editable" />
        <input id="readonly" readonly />
      ''');

      expect(await page.locator('#editable').isEditable(), isTrue);
      expect(await page.locator('#readonly').isEditable(), isFalse);
    });

    test('should get inputValue', (page) async {
      await page.setContent('<input id="inp" value="hello" />');
      expect(await page.locator('#inp').inputValue(), equals('hello'));

      await page.locator('#inp').fill('world');
      expect(await page.locator('#inp').inputValue(), equals('world'));
    });

    test('should get getAttribute', (page) async {
      await page.setContent('<div id="el" data-custom="myvalue"></div>');
      expect(
        await page.locator('#el').getAttribute('data-custom'),
        equals('myvalue'),
      );
    });

    test('should get innerHTML', (page) async {
      await page.setContent('<div id="wrap"><em>emphasized</em></div>');
      expect(
        await page.locator('#wrap').innerHTML(),
        equals('<em>emphasized</em>'),
      );
    });
  });

  group('Locator Action API', () {
    test('should hover', (page) async {
      await page.setContent('''
        <div id="target" style="width:100px;height:100px;">Hover me</div>
        <script>
          document.getElementById('target').addEventListener('mouseenter', () => {
            document.getElementById('target').textContent = 'Hovered!';
          });
        </script>
      ''');

      await page.locator('#target').hover();
      expect(await page.locator('#target').textContent(), equals('Hovered!'));
    });

    test('should focus and blur', (page) async {
      await page.setContent('''
        <input id="inp" />
        <script>
          let focused = false;
          const inp = document.getElementById('inp');
          inp.addEventListener('focus', () => { focused = true; });
          inp.addEventListener('blur', () => { focused = false; });
        </script>
      ''');

      await page.locator('#inp').focus();
      expect(await page.evaluate('() => focused'), isTrue);

      await page.locator('#inp').blur();
      expect(await page.evaluate('() => focused'), isFalse);
    });

    test('should double click', (page) async {
      await page.setContent('''
        <div id="target">Double click me</div>
        <script>
          document.getElementById('target').addEventListener('dblclick', () => {
            document.getElementById('target').textContent = 'Double clicked!';
          });
        </script>
      ''');

      await page.locator('#target').dblclick();
      expect(
        await page.locator('#target').textContent(),
        equals('Double clicked!'),
      );
    });

    test('should type text with delay', (page) async {
      await page.setContent('<input id="inp" />');
      await page.locator('#inp').type('hello');
      expect(await page.locator('#inp').inputValue(), equals('hello'));
    });

    test('should press key', (page) async {
      await page.setContent('''
        <input id="inp" />
        <script>
          let lastKey = '';
          document.getElementById('inp').addEventListener('keydown', (e) => {
            lastKey = e.key;
          });
        </script>
      ''');

      await page.locator('#inp').focus();
      await page.locator('#inp').press('ArrowDown');
      expect(await page.evaluate('() => lastKey'), equals('ArrowDown'));
    });

    test('should select options', (page) async {
      await page.setContent('''
        <select id="sel">
          <option value="a">Alpha</option>
          <option value="b">Beta</option>
          <option value="c">Gamma</option>
        </select>
      ''');

      final selected = await page.locator('#sel').selectOption([
        SelectOption.value('b'),
      ]);
      expect(selected, contains('b'));

      final value = await page.evaluate(
        '() => document.getElementById("sel").value',
      );
      expect(value, equals('b'));
    });

    test('should dispatch event', (page) async {
      await page.setContent('''
        <div id="target">Click me</div>
        <script>
          let customFired = false;
          document.getElementById('target').addEventListener('custom-event', () => {
            customFired = true;
          });
        </script>
      ''');

      await page.locator('#target').dispatchEvent('custom-event');
      expect(await page.evaluate('() => customFired'), isTrue);
    });

    test('should wait for element', (page) async {
      await page.setContent('''
        <script>
          setTimeout(() => {
            const div = document.createElement('div');
            div.id = 'delayed';
            div.textContent = 'Appeared';
            document.body.appendChild(div);
          }, 500);
        </script>
      ''');

      await page.locator('#delayed').waitFor();
      expect(await page.locator('#delayed').textContent(), equals('Appeared'));
    });

    test('should drag and drop', (page) async {
      await page.setContent('''
        <div id="source" draggable="true" style="width:50px;height:50px;background:red;">Source</div>
        <div id="target" style="width:100px;height:100px;background:blue;">Target</div>
        <script>
          let dropped = false;
          const target = document.getElementById('target');
          target.addEventListener('dragover', (e) => e.preventDefault());
          target.addEventListener('drop', (e) => {
            dropped = true;
          });
        </script>
      ''');

      await page.locator('#source').dragTo(page.locator('#target'));
      expect(await page.evaluate('() => dropped'), isTrue);
    });

    test('should highlight element', (page) async {
      await page.setContent('<div id="box">Box</div>');
      await page.locator('#box').highlight();

      final count = await page.evaluate(
        '() => document.querySelectorAll("x-pw-glass").length',
      );
      expect(count, greaterThanOrEqualTo(1));
    });
  });

  group('Locator By* API', () {
    test('should find by text', (page) async {
      await page.setContent('''
        <p>Hello World</p>
        <p>Goodbye World</p>
      ''');

      final loc = page.locator('p').getByText('Hello');
      expect(await loc.textContent(), contains('Hello'));
    });

    test('should find by role', (page) async {
      await page.setContent('''
        <button>Submit</button>
        <button>Cancel</button>
      ''');

      final submit = page.getByRole('button', name: 'Submit');
      expect(await submit.textContent(), equals('Submit'));
    });

    test('should find by label', (page) async {
      await page.setContent('''
        <label for="email">Email</label>
        <input id="email" type="email" />
      ''');

      await page.getByLabel('Email').fill('test@example.com');
      expect(
        await page.locator('#email').inputValue(),
        equals('test@example.com'),
      );
    });

    test('should find by placeholder', (page) async {
      await page.setContent('<input placeholder="Enter name" />');

      await page.getByPlaceholder('Enter name').fill('John');
      expect(await page.locator('input').inputValue(), equals('John'));
    });

    test('should find by test id', (page) async {
      await page.setContent('<div data-testid="hero">Hero content</div>');
      expect(
        await page.getByTestId('hero').textContent(),
        equals('Hero content'),
      );
    });
  });

  group('Locator Chaining API', () {
    test('should use and() and or()', (page) async {
      await page.setContent('''
        <div class="box red">Red Box</div>
        <div class="box blue">Blue Box</div>
      ''');

      final redBox = page.locator('.box').and(page.locator('.red'));
      expect(await redBox.textContent(), equals('Red Box'));

      final anyBox = page.locator('.red').or(page.locator('.blue'));
      expect(await anyBox.evaluateAll('els => els.length'), equals(2));
    });

    test('should use filter()', (page) async {
      await page.setContent('''
        <ul>
          <li>Item 1 <button>Delete</button></li>
          <li>Item 2</li>
          <li>Item 3 <button>Delete</button></li>
        </ul>
      ''');

      final itemsWithButton = page
          .locator('li')
          .filter(has: page.locator('button'));
      expect(await itemsWithButton.evaluateAll('els => els.length'), equals(2));

      final item2 = page.locator('li').filter(hasText: 'Item 2');
      expect(await item2.textContent(), equals('Item 2'));
    });

    test('should use first(), last(), and nth()', (page) async {
      await page.setContent('''
        <div class="item">A</div>
        <div class="item">B</div>
        <div class="item">C</div>
      ''');

      final items = page.locator('.item');
      expect(await items.first().textContent(), equals('A'));
      expect(await items.last().textContent(), equals('C'));
      expect(await items.nth(1).textContent(), equals('B'));
    });

    test('should find by alt text and title', (page) async {
      await page.setContent('''
        <img alt="Logo" src="logo.png" />
        <span title="Tooltip">Hover me</span>
      ''');

      expect(
        await page.getByAltText('Logo').getAttribute('src'),
        equals('logo.png'),
      );
      expect(
        await page.getByTitle('Tooltip').textContent(),
        equals('Hover me'),
      );
    });
  });
}
