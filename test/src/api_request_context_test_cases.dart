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

    test('should perform PUT request', () async {
      final request = await playwright.newRequest();

      final response = await request.put(
        'https://jsonplaceholder.typicode.com/posts/1',
        jsonData: '{"id":1,"title":"foo","body":"bar","userId":1}',
      );

      expect(response.status, equals(200)); // OK

      await request.dispose();
    });

    test('should perform DELETE request', () async {
      final request = await playwright.newRequest();

      final response = await request.delete(
        'https://jsonplaceholder.typicode.com/posts/1',
      );

      expect(response.status, equals(200)); // OK

      await request.dispose();
    });

    test('should perform PATCH request', () async {
      final request = await playwright.newRequest();

      final response = await request.patch(
        'https://jsonplaceholder.typicode.com/posts/1',
        jsonData: '{"title":"foo"}',
      );

      expect(response.status, equals(200)); // OK

      await request.dispose();
    });

    test('should perform HEAD request', () async {
      final request = await playwright.newRequest();

      final response = await request.head('https://example.com');

      expect(response.status, equals(200));

      await request.dispose();
    });

    test('should get storage state', () async {
      final request = await playwright.newRequest();
      
      final state = await request.storageState();
      expect(state.cookies, isA<List>());

      await request.dispose();
    });
  });
}
