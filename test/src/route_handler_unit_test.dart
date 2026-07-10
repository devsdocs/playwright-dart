import 'package:test/test.dart';
import 'package:playwright_dart/src/network/route_handler.dart';
import 'package:playwright_dart/src/network/route.dart';
import 'package:playwright_dart/src/generated/channels.dart';

class MockRoute implements Route {
  bool continued = false;

  @override
  Future<void> continueRoute({
    List<NameValue>? headers,
    String? method,
    dynamic postData,
    String? url,
    bool? isFallback,
  }) async {
    continued = true;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  group('RouteManager Unit Tests', () {
    test('add and remove handlers', () {
      final manager = RouteManager();

      manager.add('https://example.com/api', (route) async {});
      manager.add('https://example.com/*', (route) async {});

      expect(manager.routes.length, 2);
      expect(manager.routes[0].url, 'https://example.com/*');
      expect(manager.routes[1].url, 'https://example.com/api');

      manager.remove('https://example.com/*');
      expect(manager.routes.length, 1);

      manager.clear();
      expect(manager.isEmpty, isTrue);
    });

    test('pattern matching', () async {
      final manager = RouteManager();

      var matchedUrl = '';
      manager.add('**/*.jpg', (route) async {
        matchedUrl = 'jpg';
      });
      manager.add('https://example.com/api/*/user', (route) async {
        matchedUrl = 'user';
      });
      manager.add('https://example.com/exact', (route) async {
        matchedUrl = 'exact';
      });

      final route = MockRoute();

      // Test exact
      await manager.handleRoute(route, 'https://example.com/exact');
      expect(matchedUrl, 'exact');

      // Test glob wildcard
      await manager.handleRoute(route, 'https://example.com/api/123/user');
      expect(matchedUrl, 'user');

      // Test ** wildcard
      await manager.handleRoute(
        route,
        'https://images.example.com/path/to/image.jpg',
      );
      expect(matchedUrl, 'jpg');

      // Test unhandled (should continue route)
      final unhandledRoute = MockRoute();
      await manager.handleRoute(
        unhandledRoute,
        'https://example.com/not-found',
      );
      expect(unhandledRoute.continued, isTrue);
    });

    test('prepareContextPatterns generates proper patterns', () {
      final manager = RouteManager();
      manager.add('https://example.com/api/*', (route) async {});
      manager.add('**/*.jpg', (route) async {});

      final patterns = manager.prepareContextPatterns();
      expect(patterns.length, 2);
      expect(patterns[0].glob, '**/*.jpg');
      expect(patterns[1].glob, 'https://example.com/api/*');
    });

    test('prepareContextPatterns short-circuits on catch-all', () {
      final manager = RouteManager();
      manager.add('https://example.com/api/*', (route) async {});
      manager.add('**/*', (route) async {});

      final patterns = manager.prepareContextPatterns();
      expect(patterns.length, 1);
      expect(patterns[0].glob, '**/*');
    });
  });
}
