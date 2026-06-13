import '../test_helper.dart';

void main() {
  group('Page Script/Style Injection', () {
    test('should add script tag with content', (page) async {
      await page.setContent('<div id="target"></div>');
      await page.addScriptTag(
        content: 'document.getElementById("target").textContent = "injected";',
      );
      final text = await page.locator('#target').textContent();
      expect(text, equals('injected'));
    });

    test('should add style tag with content', (page) async {
      await page.setContent('<div id="box">Styled</div>');
      await page.addStyleTag(content: '#box { color: rgb(255, 0, 0); }');
      final color = await page.evaluate(
        '() => getComputedStyle(document.getElementById("box")).color',
      );
      expect(color, equals('rgb(255, 0, 0)'));
    });
  });

  group('Page Extra HTTP Headers', () {
    test('should set extra HTTP headers', (page) async {
      await page.setExtraHTTPHeaders([
        NameValue(name: 'X-Custom-Header', value: 'test-value'),
      ]);

      // Set up route to capture request headers
      String? receivedHeader;
      await page.route('**/*', (route) async {
        receivedHeader = route.request.headers['x-custom-header'];
        await route.continueRoute();
      });

      await page.goto('https://example.com');
      expect(receivedHeader, equals('test-value'));
    });
  });

  group('Page querySelector API', () {
    test('should querySelector', (page) async {
      await page.setContent('''
        <div class="item">First</div>
        <div class="item">Second</div>
      ''');

      final locator = page.querySelector('.item');
      final text = await locator.textContent();
      expect(text, equals('First'));
    });

    test('should queryCount', (page) async {
      await page.setContent('''
        <ul>
          <li>A</li>
          <li>B</li>
          <li>C</li>
          <li>D</li>
        </ul>
      ''');

      final count = await page.queryCount('li');
      expect(count, equals(4));
    });
  });

  group('Page Focus/Blur via selector', () {
    test('should focus element by selector', (page) async {
      await page.setContent('''
        <input id="inp" />
        <script>
          let isFocused = false;
          document.getElementById("inp").addEventListener("focus", () => { isFocused = true; });
        </script>
      ''');

      await page.focus('#inp');
      expect(await page.evaluate('() => isFocused'), isTrue);
    });

    test('should blur element by selector', (page) async {
      await page.setContent('''
        <input id="inp" />
        <script>
          let blurred = false;
          document.getElementById("inp").addEventListener("blur", () => { blurred = true; });
        </script>
      ''');

      await page.focus('#inp');
      await page.blur('#inp');
      expect(await page.evaluate('() => blurred'), isTrue);
    });

    test('should double click by selector', (page) async {
      await page.setContent('''
        <div id="target">Click</div>
        <script>
          let dblClicked = false;
          document.getElementById("target").addEventListener("dblclick", () => { dblClicked = true; });
        </script>
      ''');

      await page.dblclick('#target');
      expect(await page.evaluate('() => dblClicked'), isTrue);
    });

    test('should type by selector', (page) async {
      await page.setContent('<input id="inp" />');
      await page.type('#inp', 'typed text');
      expect(await page.inputValue('#inp'), equals('typed text'));
    });

    test('should press key by selector', (page) async {
      await page.setContent('''
        <input id="inp" />
        <script>
          let pressedKey = '';
          document.getElementById("inp").addEventListener("keydown", (e) => { pressedKey = e.key; });
        </script>
      ''');

      await page.focus('#inp');
      await page.press('#inp', 'Enter');
      expect(await page.evaluate('() => pressedKey'), equals('Enter'));
    });

    test('should click by selector', (page) async {
      await page.setContent('''
        <div id="target" style="width:100px;height:100px;">Tap</div>
        <script>
          let clicked = false;
          document.getElementById("target").addEventListener("click", () => { clicked = true; });
        </script>
      ''');

      await page.click('#target');
      expect(await page.evaluate('() => clicked'), isTrue);
    });
  });

  group('Page dispatchEvent', () {
    test('should dispatch custom event via selector', (page) async {
      await page.setContent('''
        <div id="target">event target</div>
        <script>
          let eventFired = false;
          document.getElementById("target").addEventListener("my-event", () => { eventFired = true; });
        </script>
      ''');

      await page.dispatchEvent('#target', 'my-event');
      expect(await page.evaluate('() => eventFired'), isTrue);
    });
  });

  group('Page selectOption', () {
    test('should select option by value via selector', (page) async {
      await page.setContent('''
        <select id="sel">
          <option value="x">X</option>
          <option value="y">Y</option>
        </select>
      ''');

      final selected = await page.selectOption('#sel', 'y');
      expect(selected, contains('y'));
      expect(
        await page.evaluate('() => document.getElementById("sel").value'),
        equals('y'),
      );
    });
  });

  group('Page setViewportSize', () {
    test('should change viewport size', (page) async {
      await page.setViewportSize(
        PageSetViewportSizeViewportSize(width: 800, height: 600),
      );
      final width = await page.evaluate('() => window.innerWidth');
      final height = await page.evaluate('() => window.innerHeight');
      expect(width, equals(800));
      expect(height, equals(600));
    });
  });
}
