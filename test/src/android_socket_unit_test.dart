import 'package:test/test.dart';
import 'package:playwright_dart/src/platform/android_socket.dart';
import 'infrastructure/mock_transport.dart';

void main() {
  group('AndroidSocket Unit Tests', () {
    test(
      'AndroidSocketImpl should map streams and call correct methods',
      () async {
        final testConnection = TestConnection(
          handler: (request) {
            return <String, dynamic>{
              'id': request['id'],
              'result': <String, dynamic>{},
            };
          },
        );

        testConnection.dispatchCreate('AndroidSocket', 'AndroidSocket_1', {});
        final socket =
            testConnection.getObject('AndroidSocket_1') as AndroidSocketImpl;

        var onCloseCalled = false;
        var onDataCalled = false;

        socket.onClose.listen((s) {
          expect(s, socket);
          onCloseCalled = true;
        });

        socket.onData.listen((event) {
          expect(event.data, 'socket_data');
          onDataCalled = true;
        });

        // Dispatch events
        testConnection.dispatchEvent('AndroidSocket_1', 'close', {});
        testConnection.dispatchEvent('AndroidSocket_1', 'data', {
          'data': 'socket_data',
        });

        await Future.delayed(Duration(milliseconds: 50));

        expect(onCloseCalled, isTrue);
        expect(onDataCalled, isTrue);

        // Call methods
        await socket.write('hello');
        var req = testConnection.transport.sentMessages.lastWhere(
          (m) => m['method'] == 'write',
        );
        expect(req['params']['data'], 'hello');

        await socket.close();
        req = testConnection.transport.sentMessages.lastWhere(
          (m) => m['method'] == 'close',
        );
        expect(req['params'], isEmpty);
      },
    );
  });
}
