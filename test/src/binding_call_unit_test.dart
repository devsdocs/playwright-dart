import 'package:test/test.dart';
import 'package:playwright_dart/src/debugging/binding_call.dart';
import 'infrastructure/mock_transport.dart';

void main() {
  group('BindingCall Unit Tests', () {
    late TestConnection testConn;

    setUp(() {
      testConn = TestConnection(
        handler: (req) {
          // Respond to any message with an empty success result
          return <String, dynamic>{
            'id': req['id'],
            'result': <String, dynamic>{},
          };
        },
      );

      // BindingCallInitializer needs a frame guid, so pre-create a Frame.
      testConn.dispatchCreate('Frame', 'Frame_1', {
        'url': 'about:blank',
        'name': '',
        'loadStates': [],
      });

      // Now create the BindingCall with a valid initializer.
      testConn.dispatchCreate('BindingCall', 'BindingCall_1', {
        'name': 'myBinding',
        'args': [],
        'frame': {'guid': 'Frame_1'},
      });
    });

    test('BindingCallImpl is created from dispatchCreate', () {
      final bc = testConn.getObject('BindingCall_1');
      expect(bc, isA<BindingCallImpl>());
    });

    test('BindingCallImpl implements BindingCall interface', () {
      final bc = testConn.getObject('BindingCall_1');
      expect(bc, isA<BindingCall>());
    });

    test('resolve sends resolve message with serialized result', () async {
      final bc = testConn.getObject('BindingCall_1') as BindingCallImpl;
      await bc.resolve('hello');

      final msg = testConn.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'resolve',
      );
      expect(msg, isNotNull);
      expect(msg['params']['result'], isNotNull);
    });

    test('resolve sends resolve message with numeric result', () async {
      final bc = testConn.getObject('BindingCall_1') as BindingCallImpl;
      await bc.resolve(42);

      final msg = testConn.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'resolve',
      );
      expect(msg['params']['result'], isNotNull);
    });

    test('resolve sends resolve message with null result', () async {
      final bc = testConn.getObject('BindingCall_1') as BindingCallImpl;
      await bc.resolve(null);

      final msg = testConn.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'resolve',
      );
      expect(msg['params']['result'], isNotNull);
    });

    test('resolve sends resolve message with map result', () async {
      final bc = testConn.getObject('BindingCall_1') as BindingCallImpl;
      await bc.resolve({'key': 'value'});

      final msg = testConn.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'resolve',
      );
      expect(msg['params']['result'], isNotNull);
    });

    test('reject sends reject message with error info', () async {
      final bc = testConn.getObject('BindingCall_1') as BindingCallImpl;
      await bc.reject(Exception('Something went wrong'));

      final msg = testConn.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'reject',
      );
      expect(msg, isNotNull);
      final error = msg['params']['error'] as Map<String, dynamic>;
      expect(error['value'], isNotNull);
    });

    test('reject serializes error message via toString()', () async {
      final bc = testConn.getObject('BindingCall_1') as BindingCallImpl;
      final testError = StateError('test state error');
      await bc.reject(testError);

      final msg = testConn.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'reject',
      );
      final errorPayload =
          msg['params']['error']['value']['e'] as Map<String, dynamic>;
      expect(errorPayload['m'], contains('test state error'));
      expect(errorPayload['n'], equals('Error'));
      expect(errorPayload['s'], equals(''));
    });

    test('reject works with plain string error', () async {
      final bc = testConn.getObject('BindingCall_1') as BindingCallImpl;
      await bc.reject('plain string error');

      final msg = testConn.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'reject',
      );
      expect(msg, isNotNull);
    });

    test('resolve and reject can be called independently', () async {
      final bc = testConn.getObject('BindingCall_1') as BindingCallImpl;

      // In real usage only one is called, but the API allows both — verify
      // both generate independent protocol messages.
      await bc.resolve('result value');
      await bc.reject('some error');

      final resolveMsg = testConn.transport.sentMessages.firstWhere(
        (m) => m['method'] == 'resolve',
      );
      final rejectMsg = testConn.transport.sentMessages.firstWhere(
        (m) => m['method'] == 'reject',
      );
      expect(resolveMsg, isNotNull);
      expect(rejectMsg, isNotNull);
    });
  });
}
