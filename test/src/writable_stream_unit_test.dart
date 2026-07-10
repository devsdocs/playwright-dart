import 'package:test/test.dart';
import 'package:playwright_dart/src/infrastructure/writable_stream.dart';
import 'infrastructure/mock_transport.dart';

void main() {
  group('WritableStream Unit Tests', () {
    test('WritableStreamImpl should call correct channel methods', () async {
      final testConnection = TestConnection(
        handler: (request) {
          return <String, dynamic>{
            'id': request['id'],
            'result': <String, dynamic>{},
          };
        },
      );

      testConnection.dispatchCreate('WritableStream', 'WritableStream_1', {});
      final stream =
          testConnection.getObject('WritableStream_1') as WritableStreamImpl;

      await stream.write('binary_data');
      var req = testConnection.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'write',
      );
      expect(req['params']['binary'], 'binary_data');

      await stream.close();
      req = testConnection.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'close',
      );
      expect(req['params'], isEmpty);
    });
  });
}
