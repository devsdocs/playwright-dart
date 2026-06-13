import '../test_helper.dart';

void main() {
  group('Emulation API', () {
    test('should emulate viewport size', (page) async {
      // Test emulation via page.setViewportSize to keep single browser context simplicity
      await page.setViewportSize({'width': 800, 'height': 600});

      final width = await page.evaluate('() => window.innerWidth');
      final height = await page.evaluate('() => window.innerHeight');

      expect(width, equals(800));
      expect(height, equals(600));
    });

    test('should emulate geolocation', (page) async {
      // Since we use a shared context in tests, it's better to test via page or context directly
      final context = page.parent as BrowserContext;
      await context.setGeolocation({'latitude': 59.3293, 'longitude': 18.0686});
      await context.grantPermissions(['geolocation']);

      // Geolocation requires a secure origin in Chromium (HTTPS or localhost)
      await page.goto('https://example.com');

      final geo = await page.evaluate('''() => {
        return new Promise((resolve, reject) => {
          navigator.geolocation.getCurrentPosition(pos => {
            resolve({
              lat: pos.coords.latitude,
              lon: pos.coords.longitude
            });
          }, err => {
            reject(err.message);
          });
        });
      }''');

      expect(geo, isNotNull);
      expect(geo['lat'], equals(59.3293));
      expect(geo['lon'], equals(18.0686));

      await context.close();
    });
  });
}
