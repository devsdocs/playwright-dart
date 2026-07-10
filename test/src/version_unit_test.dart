import 'dart:convert';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:playwright_dart/src/utils/version.dart';

void main() {
  group('getPlaywrightVersion', () {
    test('returns version from NPM registry on success', () async {
      final client = MockClient((req) async {
        expect(req.url.toString(), contains('playwright-core'));
        return http.Response(
          jsonEncode({'version': '1.50.0'}),
          200,
          headers: {'content-type': 'application/json'},
        );
      });

      final version = await getPlaywrightVersion(client: client);
      expect(version, equals('1.50.0'));
    });

    test('returns fallback when response is non-200', () async {
      final client = MockClient((_) async => http.Response('Not Found', 404));
      final version = await getPlaywrightVersion(client: client);
      expect(version, equals(fallbackPlaywrightVersion));
    });

    test('returns fallback when response body has no version key', () async {
      final client = MockClient(
        (_) async => http.Response(
          jsonEncode({'name': 'playwright-core'}),
          200,
          headers: {'content-type': 'application/json'},
        ),
      );
      final version = await getPlaywrightVersion(client: client);
      expect(version, equals(fallbackPlaywrightVersion));
    });

    test('returns fallback when version value is not a string', () async {
      final client = MockClient(
        (_) async => http.Response(
          jsonEncode({'version': 123}),
          200,
          headers: {'content-type': 'application/json'},
        ),
      );
      final version = await getPlaywrightVersion(client: client);
      expect(version, equals(fallbackPlaywrightVersion));
    });

    test('returns fallback when network throws', () async {
      final client = MockClient((_) async => throw Exception('network error'));
      final version = await getPlaywrightVersion(client: client);
      expect(version, equals(fallbackPlaywrightVersion));
    });

    test('returns fallback when response body is invalid JSON', () async {
      final client = MockClient((_) async => http.Response('not-json', 200));
      final version = await getPlaywrightVersion(client: client);
      expect(version, equals(fallbackPlaywrightVersion));
    });

    test('fallbackPlaywrightVersion is a valid semver string', () {
      final parts = fallbackPlaywrightVersion.split('.');
      expect(parts.length, equals(3));
      for (final part in parts) {
        expect(int.tryParse(part), isNotNull);
      }
    });
  });
}
