import 'package:test/test.dart';
import 'package:playwright_dart/src/interaction/api_response_assertions.dart';
import 'package:playwright_dart/src/generated/channels.dart';

// Helper to build an APIResponse with sensible defaults
APIResponse makeResponse({
  int status = 200,
  String statusText = 'OK',
  String url = 'https://example.com',
  List<NameValue>? headers,
}) => APIResponse(
  fetchUid: 'uid',
  headers: headers ?? [],
  status: status,
  statusText: statusText,
  url: url,
);

void main() {
  group('APIResponseAssertions Unit Tests', () {
    group('toBeOK', () {
      test('should pass for 200 status', () async {
        await APIResponseAssertions(makeResponse(status: 200)).toBeOK();
      });

      test('should pass for 201 status', () async {
        await APIResponseAssertions(makeResponse(status: 201)).toBeOK();
      });

      test('should pass for 299 status', () async {
        await APIResponseAssertions(makeResponse(status: 299)).toBeOK();
      });

      test('should fail for 199 status', () async {
        await expectLater(
          () => APIResponseAssertions(makeResponse(status: 199)).toBeOK(),
          throwsA(isA<AssertionError>()),
        );
      });

      test('should fail for 300 status', () async {
        await expectLater(
          () => APIResponseAssertions(makeResponse(status: 300)).toBeOK(),
          throwsA(isA<AssertionError>()),
        );
      });

      test('should fail for 404 status', () async {
        await expectLater(
          () => APIResponseAssertions(makeResponse(status: 404)).toBeOK(),
          throwsA(isA<AssertionError>()),
        );
      });

      test('.not.toBeOK() should pass for 404', () async {
        await APIResponseAssertions(makeResponse(status: 404)).not.toBeOK();
      });

      test('.not.toBeOK() should fail for 200', () async {
        await expectLater(
          () => APIResponseAssertions(makeResponse(status: 200)).not.toBeOK(),
          throwsA(isA<AssertionError>()),
        );
      });
    });

    group('toHaveStatus', () {
      test('should pass for exact match', () async {
        await APIResponseAssertions(
          makeResponse(status: 201),
        ).toHaveStatus(201);
      });

      test('should fail when status differs', () async {
        await expectLater(
          () => APIResponseAssertions(
            makeResponse(status: 200),
          ).toHaveStatus(404),
          throwsA(isA<AssertionError>()),
        );
      });

      test('.not.toHaveStatus() should pass when different', () async {
        await APIResponseAssertions(
          makeResponse(status: 200),
        ).not.toHaveStatus(404);
      });

      test('.not.toHaveStatus() should fail when matching', () async {
        await expectLater(
          () => APIResponseAssertions(
            makeResponse(status: 200),
          ).not.toHaveStatus(200),
          throwsA(isA<AssertionError>()),
        );
      });
    });

    group('toHaveStatusInRange', () {
      test('should pass for status inside range', () async {
        await APIResponseAssertions(
          makeResponse(status: 250),
        ).toHaveStatusInRange(200, 299);
      });

      test('should pass at lower boundary', () async {
        await APIResponseAssertions(
          makeResponse(status: 200),
        ).toHaveStatusInRange(200, 299);
      });

      test('should pass at upper boundary', () async {
        await APIResponseAssertions(
          makeResponse(status: 299),
        ).toHaveStatusInRange(200, 299);
      });

      test('should fail for status outside range', () async {
        await expectLater(
          () => APIResponseAssertions(
            makeResponse(status: 300),
          ).toHaveStatusInRange(200, 299),
          throwsA(isA<AssertionError>()),
        );
      });

      test('should fail for status below range', () async {
        await expectLater(
          () => APIResponseAssertions(
            makeResponse(status: 199),
          ).toHaveStatusInRange(200, 299),
          throwsA(isA<AssertionError>()),
        );
      });

      test(
        '.not.toHaveStatusInRange() should pass when outside range',
        () async {
          await APIResponseAssertions(
            makeResponse(status: 404),
          ).not.toHaveStatusInRange(200, 299);
        },
      );

      test(
        '.not.toHaveStatusInRange() should fail when inside range',
        () async {
          await expectLater(
            () => APIResponseAssertions(
              makeResponse(status: 200),
            ).not.toHaveStatusInRange(200, 299),
            throwsA(isA<AssertionError>()),
          );
        },
      );
    });

    group('toHaveStatusText', () {
      test('should pass for matching text', () async {
        await APIResponseAssertions(
          makeResponse(statusText: 'OK'),
        ).toHaveStatusText('OK');
      });

      test('should fail for non-matching text', () async {
        await expectLater(
          () => APIResponseAssertions(
            makeResponse(statusText: 'OK'),
          ).toHaveStatusText('Not Found'),
          throwsA(isA<AssertionError>()),
        );
      });

      test('.not.toHaveStatusText() should pass when different', () async {
        await APIResponseAssertions(
          makeResponse(statusText: 'OK'),
        ).not.toHaveStatusText('Not Found');
      });

      test('.not.toHaveStatusText() should fail when matching', () async {
        await expectLater(
          () => APIResponseAssertions(
            makeResponse(statusText: 'OK'),
          ).not.toHaveStatusText('OK'),
          throwsA(isA<AssertionError>()),
        );
      });
    });

    group('toHaveURL', () {
      test('should pass for substring match', () async {
        await APIResponseAssertions(
          makeResponse(url: 'https://example.com/page'),
        ).toHaveURL('example.com');
      });

      test('should pass for exact match', () async {
        await APIResponseAssertions(
          makeResponse(url: 'https://example.com/'),
        ).toHaveURL('https://example.com/');
      });

      test('should pass for regex match', () async {
        await APIResponseAssertions(
          makeResponse(url: 'https://example.com/page'),
        ).toHaveURL(RegExp(r'.*example\.com.*'));
      });

      test('should fail for non-matching string', () async {
        await expectLater(
          () => APIResponseAssertions(
            makeResponse(url: 'https://example.com'),
          ).toHaveURL('google.com'),
          throwsA(isA<AssertionError>()),
        );
      });

      test('should fail for non-matching regex', () async {
        await expectLater(
          () => APIResponseAssertions(
            makeResponse(url: 'https://example.com'),
          ).toHaveURL(RegExp(r'google\.com')),
          throwsA(isA<AssertionError>()),
        );
      });

      test('.not.toHaveURL() should pass when not matching', () async {
        await APIResponseAssertions(
          makeResponse(url: 'https://example.com'),
        ).not.toHaveURL('google.com');
      });

      test('.not.toHaveURL() should fail when matching', () async {
        await expectLater(
          () => APIResponseAssertions(
            makeResponse(url: 'https://example.com'),
          ).not.toHaveURL('example.com'),
          throwsA(isA<AssertionError>()),
        );
      });
    });

    group('toHaveHeader', () {
      test('should pass when header exists (null value check)', () async {
        final headers = [NameValue(name: 'Content-Type', value: 'text/html')];
        await APIResponseAssertions(
          makeResponse(headers: headers),
        ).toHaveHeader('Content-Type', null);
      });

      test('should pass with exact header value', () async {
        final headers = [NameValue(name: 'Content-Type', value: 'text/html')];
        await APIResponseAssertions(
          makeResponse(headers: headers),
        ).toHaveHeader('Content-Type', 'text/html');
      });

      test('should be case-insensitive for header name lookup', () async {
        final headers = [NameValue(name: 'Content-Type', value: 'text/html')];
        await APIResponseAssertions(
          makeResponse(headers: headers),
        ).toHaveHeader('content-type', 'text/html');
      });

      test('should fail when header does not exist', () async {
        await expectLater(
          () => APIResponseAssertions(
            makeResponse(headers: []),
          ).toHaveHeader('X-Custom', null),
          throwsA(isA<AssertionError>()),
        );
      });

      test('should fail when header value does not match', () async {
        final headers = [NameValue(name: 'Content-Type', value: 'text/html')];
        await expectLater(
          () => APIResponseAssertions(
            makeResponse(headers: headers),
          ).toHaveHeader('Content-Type', 'application/json'),
          throwsA(isA<AssertionError>()),
        );
      });

      test('.not.toHaveHeader() should pass when header absent', () async {
        await APIResponseAssertions(
          makeResponse(headers: []),
        ).not.toHaveHeader('X-Custom', null);
      });

      test('.not.toHaveHeader() should fail when header present', () async {
        final headers = [NameValue(name: 'X-Custom', value: 'value')];
        await expectLater(
          () => APIResponseAssertions(
            makeResponse(headers: headers),
          ).not.toHaveHeader('X-Custom', null),
          throwsA(isA<AssertionError>()),
        );
      });

      test(
        '.not.toHaveHeader() should pass when value does not match',
        () async {
          final headers = [NameValue(name: 'Content-Type', value: 'text/html')];
          await APIResponseAssertions(
            makeResponse(headers: headers),
          ).not.toHaveHeader('Content-Type', 'application/json');
        },
      );

      test('.not.toHaveHeader() should fail when value matches', () async {
        final headers = [NameValue(name: 'Content-Type', value: 'text/html')];
        await expectLater(
          () => APIResponseAssertions(
            makeResponse(headers: headers),
          ).not.toHaveHeader('Content-Type', 'text/html'),
          throwsA(isA<AssertionError>()),
        );
      });
    });

    group('toBeSuccessful', () {
      test('should pass for 2xx', () async {
        await APIResponseAssertions(makeResponse(status: 200)).toBeSuccessful();
        await APIResponseAssertions(makeResponse(status: 201)).toBeSuccessful();
        await APIResponseAssertions(makeResponse(status: 299)).toBeSuccessful();
      });

      test('should pass for 3xx', () async {
        await APIResponseAssertions(makeResponse(status: 301)).toBeSuccessful();
        await APIResponseAssertions(makeResponse(status: 302)).toBeSuccessful();
      });

      test('should fail for 4xx', () async {
        await expectLater(
          () =>
              APIResponseAssertions(makeResponse(status: 404)).toBeSuccessful(),
          throwsA(isA<AssertionError>()),
        );
      });

      test('should fail for 5xx', () async {
        await expectLater(
          () =>
              APIResponseAssertions(makeResponse(status: 500)).toBeSuccessful(),
          throwsA(isA<AssertionError>()),
        );
      });

      test('.not.toBeSuccessful() should pass for 4xx', () async {
        await APIResponseAssertions(
          makeResponse(status: 404),
        ).not.toBeSuccessful();
      });

      test('.not.toBeSuccessful() should fail for 2xx', () async {
        await expectLater(
          () => APIResponseAssertions(
            makeResponse(status: 200),
          ).not.toBeSuccessful(),
          throwsA(isA<AssertionError>()),
        );
      });
    });

    group('toBeClientError', () {
      test('should pass for 400 status', () async {
        await APIResponseAssertions(
          makeResponse(status: 400),
        ).toBeClientError();
      });

      test('should pass for 404 status', () async {
        await APIResponseAssertions(
          makeResponse(status: 404),
        ).toBeClientError();
      });

      test('should pass for 499 status', () async {
        await APIResponseAssertions(
          makeResponse(status: 499),
        ).toBeClientError();
      });

      test('should fail for 200 status', () async {
        await expectLater(
          () => APIResponseAssertions(
            makeResponse(status: 200),
          ).toBeClientError(),
          throwsA(isA<AssertionError>()),
        );
      });

      test('should fail for 500 status', () async {
        await expectLater(
          () => APIResponseAssertions(
            makeResponse(status: 500),
          ).toBeClientError(),
          throwsA(isA<AssertionError>()),
        );
      });

      test('.not.toBeClientError() should pass for 200', () async {
        await APIResponseAssertions(
          makeResponse(status: 200),
        ).not.toBeClientError();
      });

      test('.not.toBeClientError() should fail for 404', () async {
        await expectLater(
          () => APIResponseAssertions(
            makeResponse(status: 404),
          ).not.toBeClientError(),
          throwsA(isA<AssertionError>()),
        );
      });
    });

    group('toBeServerError', () {
      test('should pass for 500 status', () async {
        await APIResponseAssertions(
          makeResponse(status: 500),
        ).toBeServerError();
      });

      test('should pass for 503 status', () async {
        await APIResponseAssertions(
          makeResponse(status: 503),
        ).toBeServerError();
      });

      test('should pass for 599 status', () async {
        await APIResponseAssertions(
          makeResponse(status: 599),
        ).toBeServerError();
      });

      test('should fail for 200 status', () async {
        await expectLater(
          () => APIResponseAssertions(
            makeResponse(status: 200),
          ).toBeServerError(),
          throwsA(isA<AssertionError>()),
        );
      });

      test('should fail for 404 status', () async {
        await expectLater(
          () => APIResponseAssertions(
            makeResponse(status: 404),
          ).toBeServerError(),
          throwsA(isA<AssertionError>()),
        );
      });

      test('.not.toBeServerError() should pass for 200', () async {
        await APIResponseAssertions(
          makeResponse(status: 200),
        ).not.toBeServerError();
      });

      test('.not.toBeServerError() should fail for 500', () async {
        await expectLater(
          () => APIResponseAssertions(
            makeResponse(status: 500),
          ).not.toBeServerError(),
          throwsA(isA<AssertionError>()),
        );
      });
    });

    group('.not modifier', () {
      test('not returns a new instance with isNot toggled', () {
        final assertions = APIResponseAssertions(makeResponse(status: 200));
        final notAssertions = assertions.not;
        expect(identical(assertions, notAssertions), isFalse);
      });

      test('double .not negates back to original', () async {
        // .not.not.toBeOK() on a 200 response should pass
        await APIResponseAssertions(makeResponse(status: 200)).not.not.toBeOK();
      });
    });
  });
}
