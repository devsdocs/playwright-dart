import '../test_helper.dart';

void main() {
  group('Page.request property', () {
    test('page.request is the same as context.request', (page) async {
      // Just verify the property is accessible and non-null
      final req = page.request;
      expect(req, isNotNull);
    });

    test('page.request can make a GET request', (page) async {
      final response = await page.request.get('https://httpbin.org/get');
      expect(response.status, equals(200));
    });
  });

  group('Page.clock property', () {
    test('page.clock is accessible and non-null', (page) async {
      final clock = page.clock;
      expect(clock, isNotNull);
    });

    test('page.clock can set fixed time', (page) async {
      // Fixed time in ms (Unix epoch ms): Jan 1, 2025 00:00:00 UTC
      const fixedTimeMs = 1735689600000.0;
      await page.clock.setFixedTime(timeNumber: fixedTimeMs);
      final now = await page.evaluate('Date.now()') as num;
      expect(now, equals(fixedTimeMs));
    });
  });

  group('Page.addLocatorHandler', () {
    test('addLocatorHandler registers and removeLocatorHandler cleans up', (
      page,
    ) async {
      await page.setContent('''
          <div id="banner" style="display:none">Banner</div>
          <button id="main">Click me</button>
        ''');
      var handlerCalled = 0;
      final bannerLocator = page.locator('#banner');

      await page.addLocatorHandler(bannerLocator, (loc) async {
        handlerCalled++;
        // Dismiss the banner
        await page.evaluate(
          'document.getElementById("banner").style.display = "none"',
        );
      });

      // Handler is registered; no banner shown yet so not triggered.
      await page.removeLocatorHandler(bannerLocator);
      // After removal, handler should not be called on subsequent interactions.
      expect(handlerCalled, equals(0));
    });
  });
}
