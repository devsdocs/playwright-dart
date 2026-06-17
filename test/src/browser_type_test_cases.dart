import '../test_helper.dart';

void main() {
  setUpAll(() async {
    await setupBrowser();
  });

  tearDownAll(() async {
    await teardownBrowser();
  });

  group('BrowserType API', () {
    test('should get browser type name', (page) async {
      final browserType = playwright.chromium;
      expect(browserType.name, equals('chromium'));
    });

    test('should get executable path', (page) async {
      final browserType = playwright.chromium;
      final path = browserType.executablePath;
      expect(path, isNotNull);
      expect(path, isNotEmpty);
    });

    test('should launch browser with options', (page) async {
      final browserType = playwright.chromium;
      final browser = await browserType.launch(
        options: LaunchOptions(headless: true, timeout: 30000.0),
      );
      try {
        expect(browser.isConnected, isTrue);
        expect(browser.browserName, equals('chromium'));
      } finally {
        await browser.close();
      }
    });

    test('should launch browser with slowMo', (page) async {
      final browserType = playwright.chromium;
      final browser = await browserType.launch(slowMo: 100.0);
      try {
        expect(browser.isConnected, isTrue);
      } finally {
        await browser.close();
      }
    });

    test('should launch persistent context', (page) async {
      final browserType = playwright.chromium;
      // Use a temp directory for user data
      final userDataDir =
          'test_user_data_${DateTime.now().millisecondsSinceEpoch}';
      final context = await browserType.launchPersistentContext(
        userDataDir,
        launchOptions: LaunchOptions(headless: true, timeout: 30000.0),
        contextOptions: ContextOptions(),
      );
      try {
        expect(context.isClosed, isFalse);
      } finally {
        await context.close();
      }
    });

    test('should launch persistent context with slowMo', (page) async {
      final browserType = playwright.chromium;
      final userDataDir =
          'test_user_data_${DateTime.now().millisecondsSinceEpoch}';
      final context = await browserType.launchPersistentContext(
        userDataDir,
        slowMo: 50.0,
      );
      try {
        expect(context.isClosed, isFalse);
      } finally {
        await context.close();
      }
    });

    test('should get browser type properties', (page) async {
      final chromium = playwright.chromium;
      final firefox = playwright.firefox;
      final webkit = playwright.webkit;

      expect(chromium.name, equals('chromium'));
      expect(firefox.name, equals('firefox'));
      expect(webkit.name, equals('webkit'));

      expect(chromium.executablePath, isNotEmpty);
      expect(firefox.executablePath, isNotEmpty);
      expect(webkit.executablePath, isNotEmpty);
    });

    test('should handle multiple browser launches', (page) async {
      final browserType = playwright.chromium;
      final browser1 = await browserType.launch(
        options: LaunchOptions(timeout: 30000.0),
      );
      final browser2 = await browserType.launch(
        options: LaunchOptions(timeout: 30000.0),
      );

      try {
        expect(browser1.isConnected, isTrue);
        expect(browser2.isConnected, isTrue);
        expect(browser1, isNot(equals(browser2)));
      } finally {
        await browser1.close();
        await browser2.close();
      }
    });

    test('should launch with custom timeout', (page) async {
      final browserType = playwright.chromium;
      final browser = await browserType.launch(
        options: LaunchOptions(timeout: 60000.0),
      );
      try {
        expect(browser.isConnected, isTrue);
      } finally {
        await browser.close();
      }
    });
  });
}
