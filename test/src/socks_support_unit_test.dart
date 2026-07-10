import 'package:test/test.dart';
import 'package:playwright_dart/src/network/socks_support.dart';
import 'infrastructure/mock_transport.dart';

void main() {
  group('SocksSupport Unit Tests', () {
    test(
      'SocksSupportImpl should call correct channel methods and map streams',
      () async {
        final testConnection = TestConnection(
          handler: (request) {
            return <String, dynamic>{
              'id': request['id'],
              'result': <String, dynamic>{},
            };
          },
        );

        testConnection.dispatchCreate('SocksSupport', 'SocksSupport_1', {});
        final socks =
            testConnection.getObject('SocksSupport_1') as SocksSupportImpl;

        var onSocksClosedCalled = false;
        var onSocksDataCalled = false;
        var onSocksRequestedCalled = false;

        socks.onSocksClosed.listen((uid) {
          expect(uid, 'uid_123');
          onSocksClosedCalled = true;
        });

        socks.onSocksData.listen((params) {
          expect(params['uid'], 'uid_123');
          expect(params['data'], 'some_data');
          onSocksDataCalled = true;
        });

        socks.onSocksRequested.listen((params) {
          expect(params['uid'], 'uid_123');
          expect(params['host'], 'example.com');
          expect(params['port'], 80);
          onSocksRequestedCalled = true;
        });

        // Dispatch events
        testConnection.dispatchEvent('SocksSupport_1', 'socksClosed', {
          'uid': 'uid_123',
        });
        testConnection.dispatchEvent('SocksSupport_1', 'socksData', {
          'uid': 'uid_123',
          'data': 'some_data',
        });
        testConnection.dispatchEvent('SocksSupport_1', 'socksRequested', {
          'uid': 'uid_123',
          'host': 'example.com',
          'port': 80,
        });

        await Future.delayed(Duration(milliseconds: 50));

        expect(onSocksClosedCalled, isTrue);
        expect(onSocksDataCalled, isTrue);
        expect(onSocksRequestedCalled, isTrue);

        // Call methods
        await socks.socksConnected(uid: 'uid_1', host: 'localhost', port: 1080);
        var req = testConnection.transport.sentMessages.lastWhere(
          (m) => m['method'] == 'socksConnected',
        );
        expect(req['params']['uid'], 'uid_1');
        expect(req['params']['host'], 'localhost');
        expect(req['params']['port'], 1080);

        await socks.socksFailed('uid_2', 'ConnectionRefused');
        req = testConnection.transport.sentMessages.lastWhere(
          (m) => m['method'] == 'socksFailed',
        );
        expect(req['params']['uid'], 'uid_2');
        expect(req['params']['errorCode'], 'ConnectionRefused');

        await socks.socksData('uid_3', 'base64_data');
        req = testConnection.transport.sentMessages.lastWhere(
          (m) => m['method'] == 'socksData',
        );
        expect(req['params']['uid'], 'uid_3');
        expect(req['params']['data'], 'base64_data');

        await socks.socksError('uid_4', 'socket hang up');
        req = testConnection.transport.sentMessages.lastWhere(
          (m) => m['method'] == 'socksError',
        );
        expect(req['params']['uid'], 'uid_4');
        expect(req['params']['error'], 'socket hang up');

        await socks.socksEnd('uid_5');
        req = testConnection.transport.sentMessages.lastWhere(
          (m) => m['method'] == 'socksEnd',
        );
        expect(req['params']['uid'], 'uid_5');
      },
    );
  });
}
