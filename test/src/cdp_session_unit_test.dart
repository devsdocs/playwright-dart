import 'package:test/test.dart';
import 'package:playwright_dart/src/utils/cdp_session.dart';
import 'infrastructure/mock_transport.dart';

void main() {
  group('CDPSessionImpl Unit Tests', () {
    late TestConnection testConn;

    setUp(() {
      testConn = TestConnection(
        handler: (req) {
          switch (req['method']) {
            case 'send':
              return <String, dynamic>{
                'id': req['id'],
                'result': <String, dynamic>{
                  'result': <String, dynamic>{'id': 1, 'description': 'body'},
                },
              };
            case 'detach':
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

      testConn.dispatchCreate('CDPSession', 'CDP_1', {});
    });

    test('CDPSessionImpl is created', () {
      expect(testConn.getObject('CDP_1'), isA<CDPSessionImpl>());
    });

    test('implements CDPSession interface', () {
      expect(testConn.getObject('CDP_1'), isA<CDPSession>());
    });

    test('send sends CDP send message with method', () async {
      final cdp = testConn.getObject('CDP_1') as CDPSessionImpl;
      await cdp.send('DOM.getDocument');

      final msg = testConn.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'send',
      );
      expect(msg['params']['method'], equals('DOM.getDocument'));
    });

    test('send passes params when provided', () async {
      final cdp = testConn.getObject('CDP_1') as CDPSessionImpl;
      await cdp.send('Runtime.evaluate', params: {'expression': '1+1'});

      final msg = testConn.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'send',
      );
      expect(msg['params']['params']['expression'], equals('1+1'));
    });

    test('send returns result map', () async {
      final cdp = testConn.getObject('CDP_1') as CDPSessionImpl;
      final result = await cdp.send('DOM.getDocument');
      expect(result, isA<Map<String, dynamic>>());
      expect(result['id'], equals(1));
    });

    test('send with no params sends null params', () async {
      final cdp = testConn.getObject('CDP_1') as CDPSessionImpl;
      await cdp.send('Browser.getVersion');

      final msg = testConn.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'send',
      );
      expect(msg['params'].containsKey('params'), isFalse);
    });

    test('detach sends detach message', () async {
      final cdp = testConn.getObject('CDP_1') as CDPSessionImpl;
      await cdp.detach();

      expect(
        testConn.transport.sentMessages.any((m) => m['method'] == 'detach'),
        isTrue,
      );
    });

    test('onClose emits self when close event fires', () async {
      final cdp = testConn.getObject('CDP_1') as CDPSessionImpl;
      final closeFuture = cdp.onClose.first;

      testConn.dispatchEvent('CDP_1', 'close', {});

      final result = await closeFuture.timeout(const Duration(seconds: 2));
      expect(result, same(cdp));
    });

    test('onEvent emits params when event fires', () async {
      final cdp = testConn.getObject('CDP_1') as CDPSessionImpl;
      final eventFuture = cdp.onEvent.first;

      testConn.dispatchEvent('CDP_1', 'event', {
        'method': 'Network.requestWillBeSent',
        'params': {'requestId': 'req1'},
      });

      final params = await eventFuture.timeout(const Duration(seconds: 2));
      expect(params['method'], equals('Network.requestWillBeSent'));
    });

    test('multiple sends track correct method names', () async {
      final cdp = testConn.getObject('CDP_1') as CDPSessionImpl;
      await cdp.send('Method.A');
      await cdp.send('Method.B');
      await cdp.send('Method.C');

      final methods = testConn.transport.sentMessages
          .where((m) => m['method'] == 'send')
          .map((m) => m['params']['method'])
          .toList();
      expect(methods, containsAllInOrder(['Method.A', 'Method.B', 'Method.C']));
    });
  });
}
