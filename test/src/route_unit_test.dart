import 'package:test/test.dart';
import 'package:playwright_dart/src/network/route.dart';
import 'package:playwright_dart/src/network/route_error_code.dart';
import 'package:playwright_dart/src/generated/channels.dart';
import 'infrastructure/mock_transport.dart';

void main() {
  group('RouteImpl Unit Tests', () {
    late TestConnection testConn;

    setUp(() {
      testConn = TestConnection(
        handler: (req) => <String, dynamic>{
          'id': req['id'],
          'result': <String, dynamic>{},
        },
      );

      // Route initializer needs a Request ref.
      testConn.dispatchCreate('Frame', 'Frame_1', {
        'url': 'about:blank',
        'name': '',
        'loadStates': [],
      });
      testConn.dispatchCreate('Request', 'Request_1', {
        'url': 'https://example.com/api',
        'method': 'GET',
        'headers': <dynamic>[],
        'isNavigationRequest': false,
        'resourceType': 'fetch',
        'frame': {'guid': 'Frame_1'},
      });
      testConn.dispatchCreate('Route', 'Route_1', {
        'request': {'guid': 'Request_1'},
      });
    });

    test('RouteImpl is created', () {
      expect(testConn.getObject('Route_1'), isA<RouteImpl>());
    });

    test('implements Route interface', () {
      expect(testConn.getObject('Route_1'), isA<Route>());
    });

    // ── abort ────────────────────────────────────────────────────────────

    test('abort sends abort message with no errorCode', () async {
      final route = testConn.getObject('Route_1') as RouteImpl;
      await route.abort();

      final msg = testConn.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'abort',
      );
      expect(msg['params'].containsKey('errorCode'), isFalse);
    });

    test('abort sends errorCode when provided', () async {
      final route = testConn.getObject('Route_1') as RouteImpl;
      await route.abort(errorCode: RouteErrorCode.failed);

      final msg = testConn.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'abort',
      );
      expect(msg['params']['errorCode'], equals('failed'));
    });

    test('abort with timedout error code', () async {
      final route = testConn.getObject('Route_1') as RouteImpl;
      await route.abort(errorCode: RouteErrorCode.timedOut);

      final msg = testConn.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'abort',
      );
      expect(msg['params']['errorCode'], equals('timedout'));
    });

    // ── fulfill ──────────────────────────────────────────────────────────

    test('fulfill sends fulfill message with status', () async {
      final route = testConn.getObject('Route_1') as RouteImpl;
      await route.fulfill(status: 200);

      final msg = testConn.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'fulfill',
      );
      expect(msg['params']['status'], equals(200));
    });

    test('fulfill sends body when provided', () async {
      final route = testConn.getObject('Route_1') as RouteImpl;
      await route.fulfill(status: 200, body: 'hello world');

      final msg = testConn.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'fulfill',
      );
      expect(msg['params']['body'], equals('hello world'));
    });

    test(
      'fulfill adds content-type header when contentType provided',
      () async {
        final route = testConn.getObject('Route_1') as RouteImpl;
        await route.fulfill(status: 200, contentType: 'application/json');

        final msg = testConn.transport.sentMessages.lastWhere(
          (m) => m['method'] == 'fulfill',
        );
        final headers = msg['params']['headers'] as List;
        expect(
          headers.any(
            (h) =>
                (h as NameValue).name == 'content-type' &&
                h.value == 'application/json',
          ),
          isTrue,
        );
      },
    );

    test('fulfill sends 404 with body', () async {
      final route = testConn.getObject('Route_1') as RouteImpl;
      await route.fulfill(status: 404, body: 'Not Found');

      final msg = testConn.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'fulfill',
      );
      expect(msg['params']['status'], equals(404));
      expect(msg['params']['body'], equals('Not Found'));
    });

    // ── continueRoute ────────────────────────────────────────────────────

    test('continueRoute sends continueValue with no overrides', () async {
      final route = testConn.getObject('Route_1') as RouteImpl;
      await route.continueRoute();

      final msg = testConn.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'continue',
      );
      expect(msg['params']['isFallback'], isFalse);
    });

    test('continueRoute sends url override', () async {
      final route = testConn.getObject('Route_1') as RouteImpl;
      await route.continueRoute(url: 'https://other.com/api');

      final msg = testConn.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'continue',
      );
      expect(msg['params']['url'], equals('https://other.com/api'));
    });

    test('continueRoute sends method override', () async {
      final route = testConn.getObject('Route_1') as RouteImpl;
      await route.continueRoute(method: 'POST');

      final msg = testConn.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'continue',
      );
      expect(msg['params']['method'], equals('POST'));
    });

    test('continueRoute isFallback=true when set', () async {
      final route = testConn.getObject('Route_1') as RouteImpl;
      await route.continueRoute(isFallback: true);

      final msg = testConn.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'continue',
      );
      expect(msg['params']['isFallback'], isTrue);
    });

    // ── fallback ─────────────────────────────────────────────────────────

    test('fallback delegates to continueRoute with isFallback=true', () async {
      final route = testConn.getObject('Route_1') as RouteImpl;
      await route.fallback();

      final msg = testConn.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'continue',
      );
      expect(msg['params']['isFallback'], isTrue);
    });

    test('fallback passes url override', () async {
      final route = testConn.getObject('Route_1') as RouteImpl;
      await route.fallback(url: 'https://fallback.com');

      final msg = testConn.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'continue',
      );
      expect(msg['params']['url'], equals('https://fallback.com'));
      expect(msg['params']['isFallback'], isTrue);
    });

    // ── continueValue alias ───────────────────────────────────────────────

    test('continueValue is an alias for continueRoute', () async {
      final route = testConn.getObject('Route_1') as RouteImpl;
      await route.continueValue(method: 'PATCH');

      final msg = testConn.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'continue',
      );
      expect(msg['params']['method'], equals('PATCH'));
    });

    // ── redirectNavigationRequest ─────────────────────────────────────────

    test('redirectNavigationRequest sends message with url', () async {
      final route = testConn.getObject('Route_1') as RouteImpl;
      await route.redirectNavigationRequest('https://redirected.com');

      final msg = testConn.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'redirectNavigationRequest',
      );
      expect(msg['params']['url'], equals('https://redirected.com'));
    });
  });
}
