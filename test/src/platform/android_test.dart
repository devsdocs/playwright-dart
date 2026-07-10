import 'package:test/test.dart';
import 'package:playwright_dart/src/platform/android.dart';
import '../infrastructure/mock_transport.dart';

void main() {
  group('Android API', () {
    test('devices sends command and returns devices list', () async {
      final testConnection = TestConnection(
        handler: (request) {
          if (request['method'] == 'devices') {
            return {
              'id': request['id'],
              'result': {
                'devices': [
                  {'guid': 'AndroidDevice_1'},
                ],
              },
            };
          }
          return {};
        },
      );

      testConnection.dispatchCreate('Android', 'Android_1', {});
      final android = testConnection.getObject('Android_1') as AndroidImpl;

      testConnection.dispatchCreate('AndroidDevice', 'AndroidDevice_1', {
        'model': 'Pixel 4',
        'serial': 'emulator-5554',
      });

      final devices = await android.devices(host: '127.0.0.1', port: 5037);

      expect(devices, isNotEmpty);
      expect(devices.length, 1);

      final req = testConnection.transport.sentMessages.firstWhere(
        (m) => m['method'] == 'devices',
      );
      expect(req['params']['host'], '127.0.0.1');
      expect(req['params']['port'], 5037);
    });
  });
}
