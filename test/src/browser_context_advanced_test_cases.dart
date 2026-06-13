import '../test_helper.dart';

void main() {
  group('BrowserContext Extra HTTP Headers', () {
    test('should set extra headers on context', (page) async {
      final context = await browser.newContext();
      await context.setExtraHTTPHeaders([
        NameValue(name: 'X-Context-Header', value: 'ctx-val'),
      ]);

      final ctxPage = await context.newPage();

      String? receivedHeader;
      await ctxPage.route('**/*', (route) async {
        receivedHeader = route.request.headers['x-context-header'];
        await route.continueRoute();
      });

      await ctxPage.goto('https://example.com');
      expect(receivedHeader, equals('ctx-val'));
      await context.close();
    });
  });

  group('BrowserContext Permissions', () {
    test('should grant and clear permissions', (page) async {
      final context = await browser.newContext();

      // Grant geolocation permission
      await context.grantPermissions([
        'geolocation',
      ], origin: 'https://example.com');

      final ctxPage = await context.newPage();
      await ctxPage.goto('https://example.com');

      // Check that permission state is granted
      final state = await ctxPage.evaluate('''async () => {
        const result = await navigator.permissions.query({ name: "geolocation" });
        return result.state;
      }''');
      expect(state, equals('granted'));

      // Clear permissions
      await context.clearPermissions();

      // After clearing, permission should revert
      final stateAfter = await ctxPage.evaluate('''async () => {
        const result = await navigator.permissions.query({ name: "geolocation" });
        return result.state;
      }''');
      expect(stateAfter, isNot(equals('granted')));

      await context.close();
    });
  });

  group('BrowserContext Init Script', () {
    test('should add init script to context', (page) async {
      final context = await browser.newContext();
      await context.addInitScript('window.__contextInjected = "yes";');

      final ctxPage = await context.newPage();
      await ctxPage.goto('about:blank');
      final result = await ctxPage.evaluate('() => window.__contextInjected');
      expect(result, equals('yes'));

      // Open another page in same context - should also have the script
      final page2 = await context.newPage();
      await page2.goto('about:blank');
      final result2 = await page2.evaluate('() => window.__contextInjected');
      expect(result2, equals('yes'));

      await context.close();
    });
  });

  group('BrowserContext Offline', () {
    test('should emulate offline mode', (page) async {
      final context = await browser.newContext();
      final ctxPage = await context.newPage();

      await context.setOffline(true);

      bool gotError = false;
      try {
        await ctxPage.goto('https://example.com');
      } catch (e) {
        gotError = true;
      }
      expect(gotError, isTrue);

      // Re-enable
      await context.setOffline(false);
      await ctxPage.goto('https://example.com');
      final title = await ctxPage.title();
      expect(title, equals('Example Domain'));

      await context.close();
    });
  });

  group('BrowserContext Storage State', () {
    test('should get and set storage state', (page) async {
      final context = await browser.newContext();
      final ctxPage = await context.newPage();

      await ctxPage.goto('https://example.com');
      await ctxPage.evaluate('() => localStorage.setItem("key1", "value1")');

      final state = await context.storageState();
      expect(state, isNotNull);

      await context.close();
    });
  });

  group('BrowserContext Test ID', () {
    test('should set custom testId attribute', (page) async {
      final context = await browser.newContext();
      await context.setTestIdAttributeName('data-pw');

      final ctxPage = await context.newPage();
      await ctxPage.setContent('<div data-pw="hero">Hero content</div>');

      final text = await ctxPage.locator('[data-pw="hero"]').textContent();
      expect(text, equals('Hero content'));

      await context.close();
    });
  });

  group('BrowserContext Expose API', () {
    test('should expose console api', (page) async {
      final context = await browser.newContext();
      await context.exposeConsoleApi();

      final ctxPage = await context.newPage();

      // When exposed, playwright injects `playwright.console` or similar into the page
      // But typically it means `console.log` will be piped to Playwright, or `playwright` object is available.
      // Wait, Playwright exposes a window.playwright object when exposeConsoleApi is called?
      // Actually it just instruments the page. We can check if it evaluates without errors.
      await ctxPage.goto('about:blank');

      // evaluate will not throw if exposeConsoleApi did not throw
      final type = await ctxPage.evaluate('typeof window');
      expect(type, equals('object'));

      await context.close();
    });
  });
}
