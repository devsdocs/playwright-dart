import '../test_helper.dart';

void main() {
  group('BrowserContext API', () {
    test('should add and clear cookies', (page) async {
      // In Dart test wrapper, we only get page. Let's create our own context.
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
  });
}
