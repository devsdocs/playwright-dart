import 'package:test/test.dart';
import 'package:playwright_dart/src/infrastructure/json_pipe.dart';
import 'infrastructure/mock_transport.dart';

void main() {
  group('JsonPipe Unit Tests', () {
    test('JsonPipeImpl should map streams and call correct methods', () async {
      final testConnection = TestConnection(
        handler: (request) {
          return <String, dynamic>{
            'id': request['id'],
            'result': <String, dynamic>{},
          };
        },
      );

      testConnection.dispatchCreate('JsonPipe', 'JsonPipe_1', {});
      final pipe = testConnection.getObject('JsonPipe_1') as JsonPipeImpl;

      var onClosedCalled = false;
      var onMessageCalled = false;

      pipe.onClosed.listen((reason) {
        expect(reason, 'done');
        onClosedCalled = true;
      });

      pipe.onMessage.listen((msg) {
        expect(msg['foo'], 'bar');
        onMessageCalled = true;
      });

      // Dispatch events
      testConnection.dispatchEvent('JsonPipe_1', 'closed', {'reason': 'done'});
      testConnection.dispatchEvent('JsonPipe_1', 'message', {
        'message': {'foo': 'bar'},
      });

      await Future.delayed(Duration(milliseconds: 50));

      expect(onClosedCalled, isTrue);
      expect(onMessageCalled, isTrue);

      // Call methods
      await pipe.send({'hello': 'world'});
      var req = testConnection.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'send',
      );
      expect(req['params']['message']['hello'], 'world');

      await pipe.close();
      req = testConnection.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'close',
      );
      expect(req['params'], isEmpty);
    });
  });
}
