import '../test_helper.dart';

void main() {
  setUpAll(() async {
    await setupBrowser();
  });

  tearDownAll(() async {
    await teardownBrowser();
  });

  group('Page Navigation API', () {
    test('should reload page', (page) async {
      await page.goto('https://example.com');
      final titleBefore = await page.title();
      expect(titleBefore, equals('Example Domain'));

      // Mutate the DOM
      await page.evaluate('() => document.title = "Modified"');
      expect(await page.title(), equals('Modified'));

      // Reload should restore original
      await page.reload();
      final titleAfter = await page.title();
      expect(titleAfter, equals('Example Domain'));
    });

    test('should go back and forward', (page) async {
      await page.goto('https://example.com');
      await page.goto('https://example.com/nonexistent');

      await page.goBack();
      final urlAfterBack = await page.evaluate('() => window.location.href');
      expect(urlAfterBack, contains('example.com'));
      expect(urlAfterBack, isNot(contains('nonexistent')));

      await page.goForward();
      final urlAfterForward = await page.evaluate('() => window.location.href');
      expect(urlAfterForward, contains('nonexistent'));
    });

    test('should get page content', (page) async {
      await page.setContent('<h1>Hello</h1><p>World</p>');
      final content = await page.content();
      expect(content, contains('<h1>Hello</h1>'));
      expect(content, contains('<p>World</p>'));
    });

    test('should add init script', (page) async {
      await page.addInitScript('window.__injected = 42;');
      await page.goto('about:blank');
      final result = await page.evaluate('() => window.__injected');
      expect(result, equals(42));
    });

    test('should bring to front', (page) async {
      final context = await browser.newContext();
      final page1 = await context.newPage();

      // page2 is currently focused
      await page1.bringToFront();

      // Verify page1 is front (document.visibilityState == 'visible' usually)
      final state = await page1.evaluate('document.visibilityState');
      expect(state, equals('visible'));

      await context.close();
    });
  });

  group('Page Emulate Media API', () {
    test('should emulate dark color scheme', (page) async {
      await page.emulateMedia(colorScheme: Scheme.dark);
      final isDark = await page.evaluate(
        '() => window.matchMedia("(prefers-color-scheme: dark)").matches',
      );
      expect(isDark, isTrue);
    });

    test('should emulate light color scheme', (page) async {
      await page.emulateMedia(colorScheme: Scheme.light);
      final isLight = await page.evaluate(
        '() => window.matchMedia("(prefers-color-scheme: light)").matches',
      );
      expect(isLight, isTrue);
    });

    test('should emulate reduced motion', (page) async {
      await page.emulateMedia(reducedMotion: Motion.reduce);
      final isReduced = await page.evaluate(
        '() => window.matchMedia("(prefers-reduced-motion: reduce)").matches',
      );
      expect(isReduced, isTrue);
    });

    test('should emulate print media', (page) async {
      await page.emulateMedia(media: Media.print);
      final isPrint = await page.evaluate(
        '() => window.matchMedia("print").matches',
      );
      expect(isPrint, isTrue);
    });
  });

  group('Page Selector API', () {
    test('should evaluate on selector', (page) async {
      await page.setContent('''
        <div class="item">First</div>
        <div class="item">Second</div>
        <div class="item">Third</div>
      ''');

      final text = await page.evalOnSelector('.item', 'el => el.textContent');
      expect(text, equals('First'));
    });

    test('should evaluate on all selectors', (page) async {
      await page.setContent('''
        <div class="item">A</div>
        <div class="item">B</div>
        <div class="item">C</div>
      ''');

      final count = await page.evalOnSelectorAll('.item', 'els => els.length');
      expect(count, equals(3));
    });

    test('should get attribute', (page) async {
      await page.setContent(
        '<a href="https://example.com" id="link">Click</a>',
      );
      final href = await page.getAttribute('#link', 'href');
      expect(href, equals('https://example.com'));
    });

    test('should get innerHTML', (page) async {
      await page.setContent('<div id="container"><span>inner</span></div>');
      final html = await page.innerHTML('#container');
      expect(html, equals('<span>inner</span>'));
    });

    test('should get innerText', (page) async {
      await page.setContent('<div id="text">Hello World</div>');
      final text = await page.innerText('#text');
      expect(text, equals('Hello World'));
    });

    test('should get inputValue', (page) async {
      await page.setContent('<input id="input" value="prefilled" />');
      final value = await page.inputValue('#input');
      expect(value, equals('prefilled'));
    });

    test('should check visibility', (page) async {
      await page.setContent('''
        <div id="visible">I am visible</div>
        <div id="hidden" style="display:none">I am hidden</div>
      ''');
      expect(await page.isVisible('#visible'), isTrue);
      expect(await page.isVisible('#hidden'), isFalse);
      expect(await page.isHidden('#hidden'), isTrue);
      expect(await page.isHidden('#visible'), isFalse);
    });

    test('should check enabled/disabled state', (page) async {
      await page.setContent('''
        <button id="enabled">Click</button>
        <button id="disabled" disabled>Click</button>
      ''');
      expect(await page.isEnabled('#enabled'), isTrue);
      expect(await page.isEnabled('#disabled'), isFalse);
      expect(await page.isDisabled('#disabled'), isTrue);
    });
  });
}
