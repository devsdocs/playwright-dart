import '../test_helper.dart';

void main() {
  group('CDPSession API', () {
    test('should create and communicate with CDP session', (page) async {
      final context = page.parent as BrowserContext;
      final client = await context.newCDPSession(page: page);

      // Test sending a simple CDP command
      final response = await client.send('Target.getTargetInfo');
      expect(response, isNotNull);
      expect(response.containsKey('targetInfo'), isTrue);

      await client.detach();
    });

    test('should create browser CDP session', (page) async {
      final client = await browser.newBrowserCDPSession();

      final response = await client.send('Browser.getVersion');
      expect(response, isNotNull);
      expect(response.containsKey('product'), isTrue);

      await client.detach();
    });
  });
}
