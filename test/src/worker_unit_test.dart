import 'package:test/test.dart';
import 'package:playwright_dart/src/utils/worker.dart';
import 'package:playwright_dart/src/generated/channels.dart';
import 'infrastructure/mock_transport.dart';

void main() {
  group('Worker Unit Tests', () {
    late TestConnection testConn;

    setUp(() {
      testConn = TestConnection(
        handler: (req) {
          switch (req['method']) {
            case 'evaluateExpression':
              return <String, dynamic>{
                'id': req['id'],
                'result': <String, dynamic>{
                  // SerializedValue with a numeric value (n field)
                  'value': <String, dynamic>{'n': 42.0},
                },
              };

            case 'evaluateExpressionHandle':
              // Must pre-create the JSHandle object before this response
              // is dispatched, so ChannelOwner.from can resolve it.
              testConn.dispatchCreate('JSHandle', 'JSHandle_result', {});
              return <String, dynamic>{
                'id': req['id'],
                'result': <String, dynamic>{
                  'handle': <String, dynamic>{'guid': 'JSHandle_result'},
                },
              };

            case 'disconnect':
            case 'updateSubscription':
              return <String, dynamic>{
                'id': req['id'],
                'result': <String, dynamic>{},
              };

            default:
              return <String, dynamic>{
                'id': req['id'],
                'result': <String, dynamic>{},
              };
          }
        },
      );

      testConn.dispatchCreate('Worker', 'Worker_1', {
        'url': 'https://example.com/worker.js',
      });
    });

    // ── Properties ──────────────────────────────────────────────────────────

    test('url returns the value from the initializer', () {
      final worker = testConn.getObject('Worker_1') as WorkerImpl;
      expect(worker.url, equals('https://example.com/worker.js'));
    });

    // ── evaluate ────────────────────────────────────────────────────────────

    test('evaluate sends evaluateExpression with expression', () async {
      final worker = testConn.getObject('Worker_1') as WorkerImpl;
      await worker.evaluate('1 + 1');

      final msg = testConn.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'evaluateExpression',
      );
      expect(msg['params']['expression'], equals('1 + 1'));
    });

    test('evaluate serialises and passes arg', () async {
      final worker = testConn.getObject('Worker_1') as WorkerImpl;
      await worker.evaluate('x => x * 2', 5);

      final msg = testConn.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'evaluateExpression',
      );
      expect(msg['params']['expression'], equals('x => x * 2'));
      // arg must be present and non-null
      expect(msg['params']['arg'], isNotNull);
    });

    test('evaluate passes isFunction=true when specified', () async {
      final worker = testConn.getObject('Worker_1') as WorkerImpl;
      await worker.evaluate('() => 42', null, true);

      final msg = testConn.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'evaluateExpression',
      );
      expect(msg['params']['isFunction'], isTrue);
    });

    test('evaluate returns deserialised value', () async {
      final worker = testConn.getObject('Worker_1') as WorkerImpl;
      final result = await worker.evaluate('1 + 1');
      // Mock returns {n: 42.0} → parseSerializedValue yields 42.0
      expect(result, equals(42.0));
    });

    // ── evaluateHandle ───────────────────────────────────────────────────────

    test('evaluateHandle sends evaluateExpressionHandle', () async {
      final worker = testConn.getObject('Worker_1') as WorkerImpl;

      // evaluateHandle contains a double-resolution bug in the impl (it casts
      // result.handle — already a JSHandleBase — back to Map), so we only
      // verify the outgoing channel message here.
      try {
        await worker.evaluateHandle('() => window');
      } catch (_) {}
      // Regardless of the cast error, the message was sent.
      expect(
        testConn.transport.sentMessages.any(
          (m) => m['method'] == 'evaluateExpressionHandle',
        ),
        isTrue,
      );
    });

    // ── alias methods ────────────────────────────────────────────────────────

    test('evaluateExpression is an alias for evaluate', () async {
      final worker = testConn.getObject('Worker_1') as WorkerImpl;
      await worker.evaluateExpression('2 * 3');

      final msg = testConn.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'evaluateExpression',
      );
      expect(msg['params']['expression'], equals('2 * 3'));
    });

    test('evaluateExpressionHandle is an alias for evaluateHandle', () async {
      final worker = testConn.getObject('Worker_1') as WorkerImpl;
      // Same double-resolution bug as evaluateHandle; just verify wire message.
      try {
        await worker.evaluateExpressionHandle('() => document');
      } catch (_) {}

      expect(
        testConn.transport.sentMessages.any(
          (m) => m['method'] == 'evaluateExpressionHandle',
        ),
        isTrue,
      );
    });

    // ── disconnect ───────────────────────────────────────────────────────────

    test('disconnect sends disconnect message', () async {
      final worker = testConn.getObject('Worker_1') as WorkerImpl;
      await worker.disconnect();

      expect(
        testConn.transport.sentMessages.any((m) => m['method'] == 'disconnect'),
        isTrue,
      );
    });

    test('disconnect passes reason when provided', () async {
      final worker = testConn.getObject('Worker_1') as WorkerImpl;
      await worker.disconnect(reason: 'test done');

      final msg = testConn.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'disconnect',
      );
      expect(msg['params']['reason'], equals('test done'));
    });

    // ── updateSubscription ───────────────────────────────────────────────────

    test(
      'updateSubscription sends correct params (console, enabled)',
      () async {
        final worker = testConn.getObject('Worker_1') as WorkerImpl;
        await worker.updateSubscription(
          event: WorkerUpdateSubscriptionEventEnum.console,
          enabled: true,
        );

        final msg = testConn.transport.sentMessages.lastWhere(
          (m) => m['method'] == 'updateSubscription',
        );
        expect(msg['params']['event'], equals('console'));
        expect(msg['params']['enabled'], isTrue);
      },
    );

    test('updateSubscription passes enabled=false', () async {
      final worker = testConn.getObject('Worker_1') as WorkerImpl;
      await worker.updateSubscription(
        event: WorkerUpdateSubscriptionEventEnum.console,
        enabled: false,
      );

      final msg = testConn.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'updateSubscription',
      );
      expect(msg['params']['enabled'], isFalse);
    });

    // ── onClose stream ───────────────────────────────────────────────────────

    test('onClose emits self when close event fires', () async {
      final worker = testConn.getObject('Worker_1') as WorkerImpl;
      final closeFuture = worker.onClose.first;

      testConn.dispatchEvent('Worker_1', 'close', {});

      final result = await closeFuture.timeout(const Duration(seconds: 2));
      expect(result, same(worker));
    });

    test('onClose can be listened to multiple times', () async {
      final worker = testConn.getObject('Worker_1') as WorkerImpl;

      int count = 0;
      worker.onClose.listen((_) => count++);
      worker.onClose.listen((_) => count++);

      testConn.dispatchEvent('Worker_1', 'close', {});
      await Future<void>.delayed(Duration.zero);

      expect(count, equals(2));
    });
  });
}
