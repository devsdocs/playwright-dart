import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:playwright_dart/src/utils/version.dart';
import 'package:test/test.dart';

void main() {
  group('getPlaywrightVersion', () {
    test('returns version from npm registry on success', () async {
      final mockClient = MockClient((request) async {
        expect(
          request.url.toString(),
          'https://registry.npmjs.org/playwright-core/latest',
        );
        return http.Response(jsonEncode({'version': '1.2.3'}), 200);
      });

      final version = await getPlaywrightVersion(client: mockClient);
      expect(version, '1.2.3');
    });

    test('returns fallback version on network error', () async {
      final mockClient = MockClient((request) async {
        throw Exception('Network error');
      });

      final version = await getPlaywrightVersion(client: mockClient);
      expect(version, fallbackPlaywrightVersion);
    });

    test('returns fallback version on non-200 status code', () async {
      final mockClient = MockClient((request) async {
        return http.Response('Not Found', 404);
      });

      final version = await getPlaywrightVersion(client: mockClient);
      expect(version, fallbackPlaywrightVersion);
    });

    test('returns fallback version on invalid JSON', () async {
      final mockClient = MockClient((request) async {
        return http.Response('invalid json', 200);
      });

      final version = await getPlaywrightVersion(client: mockClient);
      expect(version, fallbackPlaywrightVersion);
    });

    test(
      'returns fallback version if version is null or missing in JSON',
      () async {
        final mockClient = MockClient((request) async {
          return http.Response(jsonEncode({'other_key': 'value'}), 200);
        });

        final version = await getPlaywrightVersion(client: mockClient);
        expect(version, fallbackPlaywrightVersion);
      },
    );

    test('returns fallback version if version is not a string', () async {
      final mockClient = MockClient((request) async {
        return http.Response(jsonEncode({'version': 123}), 200);
      });

      final version = await getPlaywrightVersion(client: mockClient);
      expect(version, fallbackPlaywrightVersion);
    });
  });
}
