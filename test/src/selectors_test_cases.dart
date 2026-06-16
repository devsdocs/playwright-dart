import '../test_helper.dart';

void main() {
  // ---------------------------------------------------------------------------
  // Selectors.register — custom engine tests
  // ---------------------------------------------------------------------------
  group('Selectors.register', () {
    test('should register custom selector engine globally', (page) async {
      final script = '''{
        query(root, selector) {
          return root.querySelector(selector);
        },
        queryAll(root, selector) {
          return Array.from(root.querySelectorAll(selector));
        }
      }''';

      await playwright.selectors.register('my-engine', script);
      await page.setContent('<div id="foo">bar</div>');
      await page.locator('my-engine=#foo').expect().toHaveText('bar');
    });

    test('should take java-style string (object literal)', (page) async {
      final script = '''{
        query(root, selector) {
          return root.querySelector(selector);
        },
        queryAll(root, selector) {
          return root.querySelectorAll(selector);
        }
      }''';
      await playwright.selectors.register('objectLiteral', script);
      await page.goto('data:text/html,<div>Hello</div>');
      // Must not throw
      await page.locator('objectLiteral=div').textContent();
    });

    test('textContent should be atomic', (page) async {
      final script = '''{
        query(root, selector) {
          const result = root.querySelector(selector);
          if (result)
            void Promise.resolve().then(() => result.textContent = 'modified');
          return result;
        },
        queryAll(root, selector) {
          const result = Array.from(root.querySelectorAll(selector));
          for (const e of result)
            void Promise.resolve().then(() => e.textContent = 'modified');
          return result;
        }
      }''';
      await playwright.selectors.register('textContentAtomic', script);
      await page.goto('data:text/html,<div>Hello</div>');
      final tc = await page.locator('textContentAtomic=div').textContent();
      expect(tc, equals('Hello'));
      final modified = await page.evaluate(
        '() => document.querySelector("div").textContent',
      );
      expect(modified, equals('modified'));
    });

    test('innerHTML should be atomic', (page) async {
      final script = '''{
        query(root, selector) {
          const result = root.querySelector(selector);
          if (result)
            void Promise.resolve().then(() => result.textContent = 'modified');
          return result;
        },
        queryAll(root, selector) {
          const result = Array.from(root.querySelectorAll(selector));
          for (const e of result)
            void Promise.resolve().then(() => e.textContent = 'modified');
          return result;
        }
      }''';
      await playwright.selectors.register('innerHTMLAtomic', script);
      await page.goto('data:text/html,<div>Hello<span>world</span></div>');
      final html = await page.innerHTML('innerHTMLAtomic=div');
      expect(html, equals('Hello<span>world</span>'));
      final modified = await page.evaluate(
        '() => document.querySelector("div").innerHTML',
      );
      expect(modified, equals('modified'));
    });

    test('getAttribute should be atomic', (page) async {
      final script = '''{
        query(root, selector) {
          const result = root.querySelector(selector);
          if (result)
            void Promise.resolve().then(() => result.setAttribute('foo', 'modified'));
          return result;
        },
        queryAll(root, selector) {
          const result = Array.from(root.querySelectorAll(selector));
          for (const e of result)
            void Promise.resolve().then(() => e.setAttribute('foo', 'modified'));
          return result;
        }
      }''';
      await playwright.selectors.register('getAttributeAtomic', script);
      await page.goto('data:text/html,<div foo=hello></div>');
      final attr = await page.getAttribute('getAttributeAtomic=div', 'foo');
      expect(attr, equals('hello'));
      final modified = await page.evaluate(
        '() => document.querySelector("div").getAttribute("foo")',
      );
      expect(modified, equals('modified'));
    });
  });

  // ---------------------------------------------------------------------------
  // Selectors.setTestIdAttribute
  // ---------------------------------------------------------------------------
  group('Selectors.setTestIdAttribute', () {
    tearDown(() async {
      // Always restore the default so subsequent tests are not affected.
      await playwright.selectors.setTestIdAttribute('data-testid');
    });

    test('should set testIdAttribute globally', (page) async {
      await playwright.selectors.setTestIdAttribute('data-my-custom-id');
      final newContext = await browser.newContext();
      final newPage = await newContext.newPage();
      try {
        await newPage.setContent('<div data-my-custom-id="target">baz</div>');
        await newPage.getByTestId('target').expect().toHaveText('baz');
      } finally {
        await newContext.close();
      }
    });
  });

  // ---------------------------------------------------------------------------
  // getByTestId
  // ---------------------------------------------------------------------------
  group('getByTestId', () {
    setUp(() async {
      // Guard against state leaking from setTestIdAttribute tests.
      await playwright.selectors.setTestIdAttribute('data-testid');
    });
    test('should work', (page) async {
      await page.setContent(
        '<div><div data-testid="Hello">Hello world</div></div>',
      );
      await page.getByTestId('Hello').expect().toHaveText('Hello world');
      await page.mainFrame
          .getByTestId('Hello')
          .expect()
          .toHaveText('Hello world');
      await page
          .locator('div')
          .getByTestId('Hello')
          .expect()
          .toHaveText('Hello world');
    });

    test('should escape id with special chars', (page) async {
      await page.setContent(
        '<div><div data-testid=\'He"llo\'>Hello world</div></div>',
      );
      await page.getByTestId('He"llo').expect().toHaveText('Hello world');
    });

    test('should work with CSS attribute selector for substring match', (
      page,
    ) async {
      // The Dart getByTestId only accepts String; CSS attribute selectors can
      // approximate regex-style matching.
      await page.setContent(
        '<div><div data-testid="Hello">Hello world</div></div>',
      );
      await page
          .locator('[data-testid*="Hell"]')
          .expect()
          .toHaveText('Hello world');
      await page.mainFrame
          .getByTestId('Hello')
          .expect()
          .toHaveText('Hello world');
      await page
          .locator('div')
          .getByTestId('Hello')
          .expect()
          .toHaveText('Hello world');
    });
  });

  // ---------------------------------------------------------------------------
  // getByText
  // ---------------------------------------------------------------------------
  group('getByText', () {
    test('should work — partial and whitespace-normalized match', (page) async {
      await page.setContent('<div>yo</div><div>ya</div><div>\nye  </div>');
      final html1 =
          await page.getByText('ye').evaluate('e => e.outerHTML') as String;
      expect(html1, contains('>\nye  </div>'));

      // regex via text= selector
      final html2 =
          await page.locator('text=/ye/').evaluate('e => e.outerHTML')
              as String;
      expect(html2, contains('>\nye  </div>'));
    });

    test('should match exactly with exact:true', (page) async {
      await page.setContent('<div> ye </div><div>ye</div>');
      final html =
          await page
                  .getByText('ye', exact: true)
                  .first()
                  .evaluate('e => e.outerHTML')
              as String;
      expect(html, contains('> ye </div>'));
    });

    test('should find exact text node only (no partial match)', (page) async {
      await page.setContent('<div>Hello world</div><div>Hello</div>');
      final html =
          await page
                  .getByText('Hello', exact: true)
                  .evaluate('e => e.outerHTML')
              as String;
      expect(html, contains('>Hello</div>'));
    });

    test('getByText exact should match full node text', (page) async {
      await page.setContent(
        '<div id=div1>hello<span>world</span></div><div id=div2>hello</div>',
      );
      await page.getByText('helloworld', exact: true).expect().toHaveId('div1');
      await page.getByText('hello', exact: true).expect().toHaveId('div2');
    });
  });

  // ---------------------------------------------------------------------------
  // getByLabel
  // ---------------------------------------------------------------------------
  group('getByLabel', () {
    test('should work', (page) async {
      await page.setContent(
        '<div><label for=target>Name</label><input id=target type=text></div>',
      );
      final labelNode =
          await page.getByText('Name').evaluate('e => e.nodeName') as String;
      expect(labelNode, equals('LABEL'));

      final inputNode =
          await page.getByLabel('Name').evaluate('e => e.nodeName') as String;
      expect(inputNode, equals('INPUT'));

      final inputNode2 =
          await page.mainFrame.getByLabel('Name').evaluate('e => e.nodeName')
              as String;
      expect(inputNode2, equals('INPUT'));

      final inputNode3 =
          await page
                  .locator('div')
                  .getByLabel('Name')
                  .evaluate('e => e.nodeName')
              as String;
      expect(inputNode3, equals('INPUT'));
    });

    test('should work with nested span inside label', (page) async {
      await page.setContent(
        '<label for=target>Last <span>Name</span></label><input id=target type=text>',
      );
      await page
          .getByLabel('last name')
          .expect()
          .toHaveAttribute('id', 'target');
      await page.getByLabel('st na').expect().toHaveAttribute('id', 'target');
      await page.getByLabel('Name').expect().toHaveAttribute('id', 'target');
      await page
          .getByLabel('Last Name', exact: true)
          .expect()
          .toHaveAttribute('id', 'target');

      // Non-matching exact label
      expect(await page.queryCount('internal:label="Last"'), equals(0));
    });

    test('should work with aria-label', (page) async {
      await page.setContent('<input id=target aria-label="Name">');
      final id = await page.getByLabel('Name').evaluate('e => e.id') as String;
      expect(id, equals('target'));
    });

    test('should work with aria-labelledby', (page) async {
      await page.setContent(
        '<label id=name-label>Name</label>'
        '<button aria-labelledby=name-label>Click me</button>',
      );
      final text =
          await page.getByLabel('Name').evaluate('e => e.textContent')
              as String;
      expect(text, equals('Click me'));
    });

    test('should work with multiply-labelled input', (page) async {
      await page.setContent(
        '<label for=target>Name</label>'
        '<input id=target type=text>'
        '<label for=target>First or Last</label>',
      );
      expect(
        await page.getByLabel('Name').evaluate('e => e.id') as String,
        equals('target'),
      );
      expect(
        await page.getByLabel('First or Last').evaluate('e => e.id') as String,
        equals('target'),
      );
    });
  });

  // ---------------------------------------------------------------------------
  // getByPlaceholder
  // ---------------------------------------------------------------------------
  group('getByPlaceholder', () {
    test('should work', (page) async {
      await page.setContent('''
        <div>
          <input placeholder="Hello">
          <input placeholder="Hello World">
        </div>
      ''');
      // Case-insensitive substring match
      expect(
        await page.queryCount('internal:attr=[placeholder="hello"i]'),
        equals(2),
      );
      // Exact match
      expect(
        await page.queryCount('internal:attr=[placeholder="Hello"]'),
        equals(1),
      );
      // Substring match
      expect(
        await page.queryCount('internal:attr=[placeholder="world"i]'),
        equals(1),
      );

      // Coverage via getByPlaceholder API — use first() to avoid strict-mode error
      await page.getByPlaceholder('hello').first().expect().toBeVisible();
      // mainFrame and scoped locator return the same count
      expect(
        await page.mainFrame.queryCount('internal:attr=[placeholder="hello"i]'),
        equals(2),
      );
      expect(
        await page
            .locator('div')
            .queryCount('internal:attr=[placeholder="hello"i]'),
        equals(2),
      );
    });
  });

  // ---------------------------------------------------------------------------
  // getByAltText
  // ---------------------------------------------------------------------------
  group('getByAltText', () {
    test('should work', (page) async {
      await page.setContent('''
        <div>
          <input alt="Hello">
          <input alt="Hello World">
        </div>
      ''');
      expect(await page.queryCount('internal:attr=[alt="hello"i]'), equals(2));
      expect(await page.queryCount('internal:attr=[alt="Hello"]'), equals(1));
      expect(await page.queryCount('internal:attr=[alt="world"i]'), equals(1));

      await page.getByAltText('hello').first().expect().toBeVisible();
      expect(
        await page.mainFrame.queryCount('internal:attr=[alt="hello"i]'),
        equals(2),
      );
      expect(
        await page.locator('div').queryCount('internal:attr=[alt="hello"i]'),
        equals(2),
      );
    });
  });

  // ---------------------------------------------------------------------------
  // getByTitle
  // ---------------------------------------------------------------------------
  group('getByTitle', () {
    test('should work', (page) async {
      await page.setContent('''
        <div>
          <input title="Hello">
          <input title="Hello World">
        </div>
      ''');
      expect(
        await page.queryCount('internal:attr=[title="hello"i]'),
        equals(2),
      );
      expect(await page.queryCount('internal:attr=[title="Hello"]'), equals(1));
      expect(
        await page.queryCount('internal:attr=[title="world"i]'),
        equals(1),
      );

      await page.getByTitle('hello').first().expect().toBeVisible();
      expect(
        await page.mainFrame.queryCount('internal:attr=[title="hello"i]'),
        equals(2),
      );
      expect(
        await page.locator('div').queryCount('internal:attr=[title="hello"i]'),
        equals(2),
      );
    });
  });

  // ---------------------------------------------------------------------------
  // getByRole
  // ---------------------------------------------------------------------------
  group('getByRole', () {
    test('should match by role', (page) async {
      await page.setContent('''
        <a href="https://playwright.dev">issues 123</a>
        <a href="https://playwright.dev">he llo 56</a>
        <button>Click me</button>
      ''');

      final buttons =
          (await page
                  .getByRole('button')
                  .evaluateAll('els => els.map(e => e.outerHTML)'))
              as List;
      expect(buttons, equals(['<button>Click me</button>']));

      final links =
          (await page
                  .getByRole('link')
                  .evaluateAll('els => els.map(e => e.outerHTML)'))
              as List;
      expect(links.length, equals(2));
    });

    test('should filter by name', (page) async {
      await page.setContent('''
        <a href="https://playwright.dev">issues 123</a>
        <button>Click me</button>
      ''');
      final byName =
          (await page
                  .getByRole('link', name: 'issues 123')
                  .evaluateAll('els => els.map(e => e.outerHTML)'))
              as List;
      expect(byName.length, equals(1));
      expect(byName.first, contains('issues 123'));

      // Partial name match
      final partial =
          (await page
                  .getByRole('link', name: 'sues')
                  .evaluateAll('els => els.map(e => e.outerHTML)'))
              as List;
      expect(partial.length, equals(1));

      // Role mismatch returns nothing
      final empty =
          (await page
                  .getByRole('button', name: 'issues')
                  .evaluateAll('els => els.map(e => e.outerHTML)'))
              as List;
      expect(empty, isEmpty);
    });

    test('should locate button by name', (page) async {
      await page.setContent('<button>Click me</button>');
      final found =
          (await page
                  .getByRole('button', name: 'Click me')
                  .evaluateAll('els => els.map(e => e.outerHTML)'))
              as List;
      expect(found, equals(['<button>Click me</button>']));

      final notFound =
          (await page
                  .getByRole('button', name: 'Does not exist')
                  .evaluateAll('els => els.map(e => e.outerHTML)'))
              as List;
      expect(notFound, isEmpty);
    });
  });

  // ---------------------------------------------------------------------------
  // text= selector
  // ---------------------------------------------------------------------------
  group('text= selector', () {
    test('basic partial and exact text matching', (page) async {
      await page.setContent('<div>yo</div><div>ya</div><div>\nye  </div>');
      expect(
        await page.evalOnSelector('text=ya', 'e => e.outerHTML'),
        equals('<div>ya</div>'),
      );
      expect(
        await page.evalOnSelector('text="ya"', 'e => e.outerHTML'),
        equals('<div>ya</div>'),
      );
      expect(
        await page.evalOnSelector('text=ye', 'e => e.outerHTML'),
        contains('ye'),
      );
    });

    test('should be case-sensitive only when quoted', (page) async {
      await page.setContent('<div>yo</div><div>ya</div>');
      // Unquoted: case-insensitive substring
      expect(
        await page.evalOnSelector('text=yA', 'e => e.outerHTML'),
        equals('<div>ya</div>'),
      );
      // Quoted: case-sensitive — no match for 'yA' when actual value is 'ya'
      expect(await page.queryCount('text="yA"'), equals(0));
    });

    test('should search for substring without quotes', (page) async {
      await page.setContent('<div>textwithsubstring</div>');
      expect(
        await page.evalOnSelector('text=with', 'e => e.outerHTML'),
        equals('<div>textwithsubstring</div>'),
      );
      expect(await page.queryCount('text="with"'), equals(0));
    });

    test('should skip head, script, and style tags', (page) async {
      await page.setContent('''
        <head>
          <title>title</title>
          <script>var script</script>
          <style>.style {}</style>
        </head>
        <body>
          <script>var script</script>
          <style>.style {}</style>
          <div>title script style</div>
        </body>
      ''');
      for (final text in ['title', 'script', 'style']) {
        expect(
          await page.evalOnSelector('text=$text', 'e => e.nodeName'),
          equals('DIV'),
        );
      }
    });

    test('should match input[type=button|submit] value', (page) async {
      await page.setContent(
        '<input type="submit" value="hello">'
        '<input type="button" value="world">',
      );
      expect(
        await page.evalOnSelector('text=hello', 'e => e.outerHTML'),
        equals('<input type="submit" value="hello">'),
      );
      expect(
        await page.evalOnSelector('text=world', 'e => e.outerHTML'),
        equals('<input type="button" value="world">'),
      );
    });
  });

  // ---------------------------------------------------------------------------
  // :has-text selector
  // ---------------------------------------------------------------------------
  group(':has-text selector', () {
    test('should work', (page) async {
      await page.setContent('''
        <input id=input2>
        <div id=div1>
          <span>  Find me  </span>
          or
          <wrap><span id=span2>maybe me  </span></wrap>
          <div><input id=input1></div>
        </div>
      ''');

      expect(
        await page.evalOnSelector(':has-text("find me")', 'e => e.tagName'),
        equals('HTML'),
      );
      expect(
        await page.evalOnSelector(
          'span:has-text("find me")',
          'e => e.outerHTML',
        ),
        equals('<span>  Find me  </span>'),
      );
      expect(
        await page.evalOnSelector('div:has-text("find me")', 'e => e.id'),
        equals('div1'),
      );
      expect(
        await page.evalOnSelector('div:has-text("find me") input', 'e => e.id'),
        equals('input1'),
      );
      expect(await page.queryCount('div:has-text("find noone")'), equals(0));
    });
  });

  // ---------------------------------------------------------------------------
  // :visible / >> visible= selectors
  // ---------------------------------------------------------------------------
  group(':visible selector', () {
    test('should work with :visible', (page) async {
      await page.setContent('''
        <section>
          <div id=target1></div>
          <div id=target2></div>
        </section>
      ''');
      // No visible divs yet (empty divs)
      expect(await page.queryCount('div:visible'), equals(0));

      await page.evalOnSelector(
        '#target2',
        "div => div.textContent = 'Now visible'",
      );

      expect(
        await page.evalOnSelector('div:visible', 'div => div.id'),
        equals('target2'),
      );
    });

    test('should work with >> visible=true', (page) async {
      await page.setContent('''
        <section>
          <div id=target1></div>
          <div id=target2></div>
        </section>
      ''');
      expect(await page.queryCount('div >> visible=true'), equals(0));

      await page.evalOnSelector(
        '#target2',
        "div => div.textContent = 'Now visible'",
      );

      expect(
        await page.evalOnSelector('div >> visible=true', 'div => div.id'),
        equals('target2'),
      );
    });

    test('should work with >> visible=false', (page) async {
      await page.setContent('''
        <section>
          <div id=target1></div>
          <div id=target2></div>
        </section>
      ''');
      expect(await page.queryCount('div >> visible=false'), equals(2));

      await page
          .locator('#target2')
          .evaluate("div => div.textContent = 'Now visible'");

      expect(await page.queryCount('div >> visible=false'), equals(1));
    });
  });

  // ---------------------------------------------------------------------------
  // nth= selector
  // ---------------------------------------------------------------------------
  group('nth= selector', () {
    test('should work', (page) async {
      await page.setContent('''
        <section>
          <div id=target1></div>
          <div id=target2></div>
        </section>
      ''');
      expect(await page.queryCount('div >> nth=2'), equals(0));
      expect(
        await page.evalOnSelector('div >> nth=0', 'e => e.id'),
        equals('target1'),
      );
      expect(
        await page.evalOnSelector('div >> nth=1', 'e => e.id'),
        equals('target2'),
      );
    });

    test('should work with nested chain', (page) async {
      await page.setContent('''
        <div>
          <div>
            <div>
              <span>hi</span>
              <span>hello</span>
            </div>
          </div>
        </div>
      ''');
      expect(
        await page.locator('div >> div >> span >> nth=1').textContent(),
        equals('hello'),
      );
    });
  });

  // ---------------------------------------------------------------------------
  // Selector chaining (>>)
  // ---------------------------------------------------------------------------
  group('Selector chaining', () {
    test('should work with strict mode and chaining', (page) async {
      await page.setContent('''
        <div>
          <div>
            <div>
              <span>hi</span>
            </div>
          </div>
        </div>
      ''');
      expect(
        await page.locator('div >> div >> span').textContent(),
        equals('hi'),
      );
    });

    test('should escape scope with >> xpath=..', (page) async {
      await page.setContent(
        "<div><label>Test</label><input id='myinput'></div>",
      );
      expect(
        await page.evalOnSelector('label >> xpath=.. >> input', 'e => e.id'),
        equals('myinput'),
      );
    });

    test('data-testid selector should be relative to scope', (page) async {
      await page.setContent('''
        <span data-testid="find-me" id=target1>1</span>
        <div>
          <span data-testid="find-me" id=target2>2</span>
        </div>
      ''');
      // Global query returns the first match
      expect(
        await page.evalOnSelector('data-testid=find-me', 'e => e.id'),
        equals('target1'),
      );
      // Scoped via >> combinator resolves to target2 (inside div)
      expect(
        await page.evalOnSelector('div >> data-testid=find-me', 'e => e.id'),
        equals('target2'),
      );
    });
  });
}
