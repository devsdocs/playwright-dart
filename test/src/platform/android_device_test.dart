import 'package:test/test.dart';
import 'package:playwright_dart/src/platform/android_device.dart';
import 'package:playwright_dart/src/generated/channels.dart';
import '../infrastructure/mock_transport.dart';

void main() {
  group('AndroidDevice', () {
    test('AndroidDeviceImpl should call correct channel methods', () async {
      final testConnection = TestConnection(
        handler: (request) {
          if (request['method'] == 'shell') {
            return <String, dynamic>{
              'id': request['id'],
              'result': <String, dynamic>{'result': 'YmFzZTY0'}, // base64
            };
          }
          return <String, dynamic>{
            'id': request['id'],
            'result': <String, dynamic>{},
          };
        },
      );
      testConnection.dispatchCreate('AndroidDevice', 'AndroidDevice_1', {
        'model': 'Pixel 4',
        'serial': 'emulator-5554',
      });
      final device =
          testConnection.getObject('AndroidDevice_1') as AndroidDeviceImpl;

      await device.fill(AndroidSelector(res: 'input'), 'test_text');
      final fillReq = testConnection.transport.sentMessages.firstWhere(
        (m) => m['method'] == 'fill',
      );
      expect(fillReq['params']['text'], 'test_text');
      expect(fillReq['params']['androidSelector'], {'res': 'input'});

      await device.tap(AndroidSelector(text: 'Submit'), duration: 100);
      final tapReq = testConnection.transport.sentMessages.firstWhere(
        (m) => m['method'] == 'tap',
      );
      expect(tapReq['params']['duration'], 100);

      await device.drag(
        AndroidSelector(desc: 'Item'),
        Point(x: 10, y: 20),
        speed: 50,
      );
      final dragReq = testConnection.transport.sentMessages.firstWhere(
        (m) => m['method'] == 'drag',
      );
      expect(dragReq['params']['dest'], {'x': 10, 'y': 20});
      expect(dragReq['params']['speed'], 50);

      await device.fling(AndroidSelector(checkable: true), Direction.down);
      final flingReq = testConnection.transport.sentMessages.firstWhere(
        (m) => m['method'] == 'fling',
      );
      expect(flingReq['params']['direction'], 'down');

      await device.longTap(AndroidSelector(checked: false));
      expect(
        testConnection.transport.sentMessages.any(
          (m) => m['method'] == 'longTap',
        ),
        isTrue,
      );

      await device.pinchClose(AndroidSelector(clickable: true), 50.0);
      final pinchCloseReq = testConnection.transport.sentMessages.firstWhere(
        (m) => m['method'] == 'pinchClose',
      );
      expect(pinchCloseReq['params']['percent'], 50.0);

      await device.pinchOpen(AndroidSelector(enabled: true), 75.0);
      final pinchOpenReq = testConnection.transport.sentMessages.firstWhere(
        (m) => m['method'] == 'pinchOpen',
      );
      expect(pinchOpenReq['params']['percent'], 75.0);

      await device.scroll(
        AndroidSelector(focusable: true),
        Direction.left,
        20.0,
      );
      final scrollReq = testConnection.transport.sentMessages.firstWhere(
        (m) => m['method'] == 'scroll',
      );
      expect(scrollReq['params']['direction'], 'left');

      await device.swipe(AndroidSelector(focused: true), Direction.right, 30.0);
      final swipeReq = testConnection.transport.sentMessages.firstWhere(
        (m) => m['method'] == 'swipe',
      );
      expect(swipeReq['params']['direction'], 'right');

      await device.shell('ls -l');
      final shellReq = testConnection.transport.sentMessages.firstWhere(
        (m) => m['method'] == 'shell',
      );
      expect(shellReq['params']['command'], 'ls -l');

      await device.installApk('/path/to/app.apk');
      expect(
        testConnection.transport.sentMessages.any(
          (m) => m['method'] == 'installApk',
        ),
        isTrue,
      );

      await device.push('/local/file', '/remote/file');
      final pushReq = testConnection.transport.sentMessages.firstWhere(
        (m) => m['method'] == 'push',
      );
      expect(pushReq['params']['path'], '/remote/file');

      await device.close();
      expect(
        testConnection.transport.sentMessages.any(
          (m) => m['method'] == 'close',
        ),
        isTrue,
      );
    });
  });
}
