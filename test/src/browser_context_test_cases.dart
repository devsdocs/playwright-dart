import '../test_helper.dart';

void main() {
  setUpAll(() async {
    await setupBrowser();
  });

  tearDownAll(() async {
    await teardownBrowser();
  });

  group('BrowserContext API', () {
    test('should add and clear cookies', (page) async {
      final ctx = await browser.newContext();
      try {
        await ctx.addCookies([
          SetNetworkCookie(
            name: 'my-cookie',
            value: 'my-value',
            domain: 'example.com',
            path: '/',
          ),
        ]);

        final cookies = await ctx.cookies(urls: ['https://example.com']);
        expect(cookies, isNotEmpty);
        expect(cookies[0].name, equals('my-cookie'));
        expect(cookies[0].value, equals('my-value'));

        await ctx.clearCookies();
        final emptyCookies = await ctx.cookies(urls: ['https://example.com']);
        expect(emptyCookies, isEmpty);
      } finally {
        await ctx.close();
      }
    });

    test('should keep contexts isolated', (page) async {
      final ctx1 = await browser.newContext();
      final ctx2 = await browser.newContext();

      try {
        await ctx1.addCookies([
          SetNetworkCookie(
            name: 'isolated-cookie',
            value: '123',
            domain: 'example.com',
            path: '/',
          ),
        ]);

        final cookies1 = await ctx1.cookies(urls: ['https://example.com']);
        expect(cookies1, isNotEmpty);

        final cookies2 = await ctx2.cookies(urls: ['https://example.com']);
        expect(cookies2, isEmpty);
      } finally {
        await ctx1.close();
        await ctx2.close();
      }
    });

    test('should grant and clear permissions', (page) async {
      final ctx = await browser.newContext();
      try {
        await ctx.grantPermissions([BrowserPermission.geolocation]);
        await ctx.clearPermissions();
      } finally {
        await ctx.close();
      }
    });

    test('should set extra HTTP headers', (page) async {
      final ctx = await browser.newContext();
      try {
        await ctx.setExtraHTTPHeaders([
          NameValue(name: 'X-Custom-Header', value: 'test-value'),
        ]);
      } finally {
        await ctx.close();
      }
    });

    test('should set geolocation', (page) async {
      final ctx = await browser.newContext();
      try {
        await ctx.setGeolocation(
          BrowserContextSetGeolocationGeolocation(
            latitude: 37.7749,
            longitude: -122.4194,
          ),
        );
      } finally {
        await ctx.close();
      }
    });

    test('should set HTTP credentials', (page) async {
      final ctx = await browser.newContext();
      try {
        await ctx.setHTTPCredentials(
          BrowserContextSetHTTPCredentialsHttpCredentials(
            username: 'test-user',
            password: 'test-pass',
          ),
        );
      } finally {
        await ctx.close();
      }
    });

    test('should set offline mode', (page) async {
      final ctx = await browser.newContext();
      try {
        await ctx.setOffline(true);
        await ctx.setOffline(false);
      } finally {
        await ctx.close();
      }
    });

    test('should get and set storage state', (page) async {
      final ctx = await browser.newContext();
      try {
        final state = await ctx.storageState();
        expect(state, isNotNull);

        await ctx.setStorageState(
          BrowserContextSetStorageStateStorageState(cookies: [], origins: []),
        );
      } finally {
        await ctx.close();
      }
    });

    test('should add init script', (page) async {
      final ctx = await browser.newContext();
      try {
        await ctx.addInitScript('window.customProperty = "test";');
      } finally {
        await ctx.close();
      }
    });

    test('should set default timeout', (page) async {
      final ctx = await browser.newContext();
      try {
        ctx.setDefaultTimeout(5000.0);
        ctx.setDefaultNavigationTimeout(10000.0);
      } finally {
        await ctx.close();
      }
    });

    test('should expose binding', (page) async {
      final ctx = await browser.newContext();
      try {
        await ctx.exposeBinding('testBinding');
      } finally {
        await ctx.close();
      }
    });

    test('should expose function', (page) async {
      final ctx = await browser.newContext();
      try {
        await ctx.exposeFunction('testFunction');
      } finally {
        await ctx.close();
      }
    });

    test('should install virtual authenticator', (page) async {
      final ctx = await browser.newContext();
      try {
        await ctx.installVirtualAuthenticator();
      } finally {
        await ctx.close();
      }
    });

    test('should add virtual credential', (page) async {
      final ctx = await browser.newContext();
      try {
        await ctx.installVirtualAuthenticator();
        await ctx.addVirtualCredential(rpId: 'example.com', id: 'test-id');
      } finally {
        await ctx.close();
      }
    });

    test('should get virtual credentials', (page) async {
      final ctx = await browser.newContext();
      try {
        await ctx.installVirtualAuthenticator();
        final credentials = await ctx.getVirtualCredentials();
        expect(credentials, isNotNull);
      } finally {
        await ctx.close();
      }
    });

    test('should remove virtual credential', (page) async {
      final ctx = await browser.newContext();
      try {
        await ctx.installVirtualAuthenticator();
        await ctx.removeVirtualCredential('test-id');
      } finally {
        await ctx.close();
      }
    });

    test('should use credentials aliases', (page) async {
      final ctx = await browser.newContext();
      try {
        await ctx.credentialsInstall();
        await ctx.credentialsCreate(rpId: 'example.com');
        await ctx.credentialsGet();
        await ctx.credentialsDelete(id: 'test-id');
      } finally {
        await ctx.close();
      }
    });

    test('should register selector engine', (page) async {
      final ctx = await browser.newContext();
      try {
        await ctx.registerSelectorEngine(
          'testEngine',
          '() => {}',
          contentScript: true,
        );
      } finally {
        await ctx.close();
      }
    });

    test('should pause context', (page) async {
      final ctx = await browser.newContext();
      try {
        // Note: pause() is for debugging, we just call it to test coverage
        // In real tests, this would block execution
        // await ctx.pause();
      } finally {
        await ctx.close();
      }
    });

    test('should set network interception patterns', (page) async {
      final ctx = await browser.newContext();
      try {
        await ctx.setNetworkInterceptionPatterns([
          BrowserContextSetNetworkInterceptionPatternsPatternsItems(
            urlPattern: URLPattern(
              hash: '',
              hostname: '',
              password: '',
              pathname: '**/*',
              port: '',
              protocol: '',
              search: '',
              username: '',
            ),
          ),
        ]);
      } finally {
        await ctx.close();
      }
    });

    test('should check if context is closed', (page) async {
      final ctx = await browser.newContext();
      expect(ctx.isClosed, isFalse);
      await ctx.close();
      expect(ctx.isClosed, isTrue);
    });

    test('should get background pages', (page) async {
      final ctx = await browser.newContext();
      try {
        final bgPages = ctx.backgroundPages;
        expect(bgPages, isNotNull);
      } finally {
        await ctx.close();
      }
    });

    test('should get service workers', (page) async {
      final ctx = await browser.newContext();
      try {
        final workers = ctx.serviceWorkers;
        expect(workers, isNotNull);
      } finally {
        await ctx.close();
      }
    });

    test('should get browser reference', (page) async {
      final ctx = await browser.newContext();
      try {
        final browserRef = ctx.browser;
        expect(browserRef, isNotNull);
      } finally {
        await ctx.close();
      }
    });

    test('should get tracing API', (page) async {
      final ctx = await browser.newContext();
      try {
        final tracing = ctx.tracing;
        expect(tracing, isNotNull);
      } finally {
        await ctx.close();
      }
    });

    test('should get request API', (page) async {
      final ctx = await browser.newContext();
      try {
        final request = ctx.request;
        expect(request, isNotNull);
      } finally {
        await ctx.close();
      }
    });

    test('should get clock API', (page) async {
      final ctx = await browser.newContext();
      try {
        final clock = ctx.clock;
        expect(clock, isNotNull);
      } finally {
        await ctx.close();
      }
    });

    test('should get pages list', (page) async {
      final ctx = await browser.newContext();
      try {
        final pages = ctx.pages;
        expect(pages, isNotNull);
      } finally {
        await ctx.close();
      }
    });

    test('should close with reason', (page) async {
      final ctx = await browser.newContext();
      await ctx.close(reason: 'Test cleanup');
    });
  });
}
