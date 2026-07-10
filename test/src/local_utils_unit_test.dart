import 'package:test/test.dart';
import 'package:playwright_dart/src/infrastructure/local_utils.dart';
import 'package:playwright_dart/src/generated/channels.dart';
import 'infrastructure/mock_transport.dart';

void main() {
  group('LocalUtilsImpl Unit Tests', () {
    late TestConnection testConn;

    setUp(() {
      testConn = TestConnection(
        handler: (req) {
          switch (req['method']) {
            case 'harOpen':
              return <String, dynamic>{
                'id': req['id'],
                'result': <String, dynamic>{'harId': 'har_abc123'},
              };

            case 'harLookup':
              return <String, dynamic>{
                'id': req['id'],
                'result': <String, dynamic>{
                  'action': 'fulfill',
                  'status': 200,
                  'body': 'response body',
                  'headers': <dynamic>[],
                },
              };

            case 'harClose':
            case 'harUnzip':
            case 'zip':
            case 'traceDiscarded':
            case 'addStackToTracingNoReply':
              return <String, dynamic>{
                'id': req['id'],
                'result': <String, dynamic>{},
              };

            case 'tracingStarted':
              return <String, dynamic>{
                'id': req['id'],
                'result': <String, dynamic>{'stacksId': 'stacks_xyz'},
              };

            case 'globToRegex':
              final glob = req['params']['glob'] as String? ?? '';
              return <String, dynamic>{
                'id': req['id'],
                'result': <String, dynamic>{
                  'regex': glob.replaceAll('*', '.*'),
                },
              };

            default:
              return <String, dynamic>{
                'id': req['id'],
                'result': <String, dynamic>{},
              };
          }
        },
      );

      testConn.dispatchCreate('LocalUtils', 'LocalUtils_1', {
        'deviceDescriptors': <dynamic>[],
      });
    });

    // ── harOpen ────────────────────────────────────────────────────────────

    test('harOpen sends harOpen message and returns harId', () async {
      final lu = testConn.getObject('LocalUtils_1') as LocalUtilsImpl;
      final harId = await lu.harOpen('trace.har');

      final msg = testConn.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'harOpen',
      );
      expect(msg['params']['file'], equals('trace.har'));
      expect(harId, equals('har_abc123'));
    });

    // ── harLookup ──────────────────────────────────────────────────────────

    test('harLookup sends harLookup with all params', () async {
      final lu = testConn.getObject('LocalUtils_1') as LocalUtilsImpl;
      final result = await lu.harLookup(
        'har_abc123',
        'https://example.com/api',
        'GET',
        [],
        false,
      );

      final msg = testConn.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'harLookup',
      );
      expect(msg['params']['harId'], equals('har_abc123'));
      expect(msg['params']['url'], equals('https://example.com/api'));
      expect(msg['params']['method'], equals('GET'));
      expect(msg['params']['isNavigationRequest'], isFalse);

      expect(result, isA<LocalUtilsHarLookupResult>());
      expect(
        result.action,
        equals(LocalUtilsHarLookupResultActionEnum.fulfill),
      );
      expect(result.status, equals(200));
    });

    test('harLookup passes postData when provided', () async {
      final lu = testConn.getObject('LocalUtils_1') as LocalUtilsImpl;
      await lu.harLookup(
        'har_001',
        'https://example.com/post',
        'POST',
        [],
        false,
        postData: '{"key":"value"}',
      );

      final msg = testConn.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'harLookup',
      );
      expect(msg['params']['postData'], equals('{"key":"value"}'));
    });

    // ── harClose ───────────────────────────────────────────────────────────

    test('harClose sends harClose with harId', () async {
      final lu = testConn.getObject('LocalUtils_1') as LocalUtilsImpl;
      await lu.harClose('har_abc123');

      final msg = testConn.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'harClose',
      );
      expect(msg['params']['harId'], equals('har_abc123'));
    });

    // ── harUnzip ───────────────────────────────────────────────────────────

    test('harUnzip sends harUnzip with zipFile and harFile', () async {
      final lu = testConn.getObject('LocalUtils_1') as LocalUtilsImpl;
      await lu.harUnzip('trace.zip', 'trace.har');

      final msg = testConn.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'harUnzip',
      );
      expect(msg['params']['zipFile'], equals('trace.zip'));
      expect(msg['params']['harFile'], equals('trace.har'));
    });

    test('harUnzip passes resourcesDir when provided', () async {
      final lu = testConn.getObject('LocalUtils_1') as LocalUtilsImpl;
      await lu.harUnzip('trace.zip', 'trace.har', resourcesDir: '/tmp/res');

      final msg = testConn.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'harUnzip',
      );
      expect(msg['params']['resourcesDir'], equals('/tmp/res'));
    });

    // ── zip ────────────────────────────────────────────────────────────────

    test('zip sends zip message with required params', () async {
      final lu = testConn.getObject('LocalUtils_1') as LocalUtilsImpl;
      await lu.zip(
        'output.zip',
        [],
        mode: LocalUtilsZipModeEnum.write,
        includeSources: true,
      );

      final msg = testConn.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'zip',
      );
      expect(msg['params']['zipFile'], equals('output.zip'));
      expect(msg['params']['mode'], equals('write'));
      expect(msg['params']['includeSources'], isTrue);
    });

    test('zip passes stacksId when provided', () async {
      final lu = testConn.getObject('LocalUtils_1') as LocalUtilsImpl;
      await lu.zip(
        'output.zip',
        [],
        mode: LocalUtilsZipModeEnum.append,
        includeSources: false,
        stacksId: 'stacks_001',
      );

      final msg = testConn.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'zip',
      );
      expect(msg['params']['stacksId'], equals('stacks_001'));
      expect(msg['params']['mode'], equals('append'));
    });

    // ── tracingStarted ────────────────────────────────────────────────────

    test('tracingStarted sends tracingStarted and returns stacksId', () async {
      final lu = testConn.getObject('LocalUtils_1') as LocalUtilsImpl;
      final stacksId = await lu.tracingStarted('my-trace');

      final msg = testConn.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'tracingStarted',
      );
      expect(msg['params']['traceName'], equals('my-trace'));
      expect(stacksId, equals('stacks_xyz'));
    });

    test('tracingStarted passes optional params', () async {
      final lu = testConn.getObject('LocalUtils_1') as LocalUtilsImpl;
      await lu.tracingStarted(
        'live-trace',
        tracesDir: '/tmp/traces',
        live: true,
      );

      final msg = testConn.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'tracingStarted',
      );
      expect(msg['params']['tracesDir'], equals('/tmp/traces'));
      expect(msg['params']['live'], isTrue);
    });

    // ── traceDiscarded ────────────────────────────────────────────────────

    test('traceDiscarded sends traceDiscarded with stacksId', () async {
      final lu = testConn.getObject('LocalUtils_1') as LocalUtilsImpl;
      await lu.traceDiscarded('stacks_xyz');

      final msg = testConn.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'traceDiscarded',
      );
      expect(msg['params']['stacksId'], equals('stacks_xyz'));
    });

    // ── globToRegex ───────────────────────────────────────────────────────

    test('globToRegex sends globToRegex and returns regex', () async {
      final lu = testConn.getObject('LocalUtils_1') as LocalUtilsImpl;
      final regex = await lu.globToRegex('**/api/**');

      final msg = testConn.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'globToRegex',
      );
      expect(msg['params']['glob'], equals('**/api/**'));
      expect(regex, equals('.*.*/api/.*.*'));
    });

    test('globToRegex passes baseURL when provided', () async {
      final lu = testConn.getObject('LocalUtils_1') as LocalUtilsImpl;
      await lu.globToRegex('**/api/**', baseURL: 'https://example.com');

      final msg = testConn.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'globToRegex',
      );
      expect(msg['params']['baseURL'], equals('https://example.com'));
    });

    test('globToRegex passes webSocketUrl when provided', () async {
      final lu = testConn.getObject('LocalUtils_1') as LocalUtilsImpl;
      await lu.globToRegex('wss://*', webSocketUrl: true);

      final msg = testConn.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'globToRegex',
      );
      expect(msg['params']['webSocketUrl'], isTrue);
    });

    // ── addStackToTracingNoReply ───────────────────────────────────────────

    test('addStackToTracingNoReply sends message', () async {
      final lu = testConn.getObject('LocalUtils_1') as LocalUtilsImpl;
      final callData = ClientSideCallMetadata(id: 42);
      await lu.addStackToTracingNoReply(callData);

      expect(
        testConn.transport.sentMessages.any(
          (m) => m['method'] == 'addStackToTracingNoReply',
        ),
        isTrue,
      );
    });
  });
}
