import 'package:playwright_dart/playwright_dart.dart';
import 'package:test/test.dart';

void main() {
  late Playwright playwright;

  setUpAll(() async {
    playwright = await PlaywrightDart.create();
  });

  tearDownAll(() async {
    await playwright.stop();
  });

  group('APIRequestContext API', () {
    test('should perform GET request', () async {
      final request = await playwright.newRequest();
      
      final response = await request.get('https://example.com');
      
      expect(response.status, equals(200));
      expect(response.statusText, equals('OK'));
      expect(response.url, equals('https://example.com/'));
      
      await request.dispose();
    });

    test('should perform POST request with JSON', () async {
      final request = await playwright.newRequest();
      
      final response = await request.post(
        'https://jsonplaceholder.typicode.com/posts',
        jsonData: '{"title":"foo","body":"bar","userId":1}',
      );
      
      expect(response.status, equals(201)); // Created
      
      await request.dispose();
    });
  });
}
