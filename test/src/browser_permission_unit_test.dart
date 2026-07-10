import 'package:test/test.dart';
import 'package:playwright_dart/src/core/browser_permission.dart';

void main() {
  group('BrowserPermission', () {
    test('has correct wire values for all permissions', () {
      expect(BrowserPermission.accelerometer.value, equals('accelerometer'));
      expect(
        BrowserPermission.ambientLightSensor.value,
        equals('ambient-light-sensor'),
      );
      expect(BrowserPermission.backgroundSync.value, equals('background-sync'));
      expect(BrowserPermission.camera.value, equals('camera'));
      expect(BrowserPermission.clipboardRead.value, equals('clipboard-read'));
      expect(BrowserPermission.clipboardWrite.value, equals('clipboard-write'));
      expect(BrowserPermission.geolocation.value, equals('geolocation'));
      expect(BrowserPermission.gyroscope.value, equals('gyroscope'));
      expect(BrowserPermission.localFonts.value, equals('local-fonts'));
      expect(
        BrowserPermission.localNetworkAccess.value,
        equals('local-network-access'),
      );
      expect(BrowserPermission.magnetometer.value, equals('magnetometer'));
      expect(BrowserPermission.microphone.value, equals('microphone'));
      expect(BrowserPermission.midiSysex.value, equals('midi-sysex'));
      expect(BrowserPermission.midi.value, equals('midi'));
      expect(BrowserPermission.notifications.value, equals('notifications'));
      expect(BrowserPermission.paymentHandler.value, equals('payment-handler'));
      expect(BrowserPermission.storageAccess.value, equals('storage-access'));
      expect(
        BrowserPermission.screenWakeLock.value,
        equals('screen-wake-lock'),
      );
    });

    test('contains 18 permissions', () {
      expect(BrowserPermission.values, hasLength(18));
    });

    test('all values are unique', () {
      final wireValues = BrowserPermission.values.map((p) => p.value).toList();
      expect(wireValues.toSet().length, equals(wireValues.length));
    });

    test('values can be looked up by wire string', () {
      final target = BrowserPermission.values.firstWhere(
        (p) => p.value == 'geolocation',
      );
      expect(target, equals(BrowserPermission.geolocation));
    });

    test('common permissions are available', () {
      expect(BrowserPermission.values, contains(BrowserPermission.camera));
      expect(BrowserPermission.values, contains(BrowserPermission.microphone));
      expect(BrowserPermission.values, contains(BrowserPermission.geolocation));
      expect(
        BrowserPermission.values,
        contains(BrowserPermission.notifications),
      );
    });
  });
}
