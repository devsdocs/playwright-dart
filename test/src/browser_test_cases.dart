import '../test_helper.dart';

void main() {
  setUpAll(() async {
    await setupBrowser();
  });

  tearDownAll(() async {
    await teardownBrowser();
  });

  group('Browser API', () {
    test('should get browser version', (page) async {
      final version = browser.version;
      expect(version, isNotNull);
      expect(version, isNotEmpty);
    });

    test('should get browser name', (page) async {
      final browserName = browser.browserName;
      expect(browserName, equals('chromium'));
    });

    test('should check if browser is connected', (page) async {
      expect(browser.isConnected, isTrue);
    });

    test('should get browser type', (page) async {
      final browserType = browser.browserType;
      expect(browserType, isNotNull);
      expect(browserType?.name, equals('chromium'));
    });

    test('should get contexts list', (page) async {
      final contexts = browser.contexts;
      expect(contexts, isNotNull);
      expect(contexts, isList);
    });

    test('should create new context', (page) async {
      final context = await browser.newContext();
      try {
        expect(context.isClosed, isFalse);
        expect(context.browser, equals(browser));
      } finally {
        await context.close();
      }
    });

    test('should create new context with options', (page) async {
      final context = await browser.newContext(
        options: ContextOptions(
          viewport: ContextOptionsViewport(width: 1280, height: 720),
        ),
      );
      try {
        expect(context.isClosed, isFalse);
      } finally {
        await context.close();
      }
    });

    test('should create new page', (page) async {
      final newPage = await browser.newPage();
      try {
        expect(newPage, isNotNull);
      } finally {
        await newPage.close();
      }
    });

    test('should close browser with reason', (page) async {
      final testBrowser = await playwright.chromium.launch(
        options: LaunchOptions(timeout: 30000.0),
      );
      await testBrowser.close(reason: 'Test cleanup');
      expect(testBrowser.isConnected, isFalse);
    });

    test('should create new browser CDPSession', (page) async {
      final session = await browser.newBrowserCDPSession();
      expect(session, isNotNull);
    });

    test('should get default user agent for test', (page) async {
      final userAgent = await browser.defaultUserAgentForTest();
      expect(userAgent, isNotNull);
      expect(userAgent, isNotEmpty);
    });

    test('should handle context creation with proxy', (page) async {
      final context = await browser.newContext(
        proxy: BrowserNewContextProxy(server: 'http://proxy.example.com:8080'),
      );
      try {
        expect(context.isClosed, isFalse);
      } finally {
        await context.close();
      }
    });

    test('should handle context creation with storage state', (page) async {
      final context = await browser.newContext(
        storageState: BrowserNewContextStorageState(cookies: [], origins: []),
      );
      try {
        expect(context.isClosed, isFalse);
      } finally {
        await context.close();
      }
    });

    test('should create context for reuse', (page) async {
      final context = await browser.newContextForReuse(
        proxy: BrowserNewContextForReuseProxy(
          server: 'http://proxy.example.com:8080',
        ),
      );
      try {
        expect(context, isNotNull);
      } finally {
        await browser.disconnectFromReusedContext(reason: 'Test cleanup');
      }
    });

    test('should disconnect from reused context', (page) async {
      await browser.disconnectFromReusedContext(reason: 'Test');
    });

    test('should handle multiple contexts', (page) async {
      final ctx1 = await browser.newContext();
      final ctx2 = await browser.newContext();
      final ctx3 = await browser.newContext();

      try {
        final contexts = browser.contexts;
        expect(contexts.length, greaterThanOrEqualTo(3));
      } finally {
        await ctx1.close();
        await ctx2.close();
        await ctx3.close();
      }
    });

    test('should get browser type reference', (page) async {
      final browserType = browser.browserType;
      expect(browserType, isNotNull);
      expect(browserType?.name, equals('chromium'));
    });

    test('should handle kill for tests', (page) async {
      final testBrowser = await playwright.chromium.launch(
        options: LaunchOptions(timeout: 30000.0),
      );
      await testBrowser.killForTests();
    });
  });
}
