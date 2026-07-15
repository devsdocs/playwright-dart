import 'package:test/test.dart';
import 'package:playwright_dart/src/core/playwright.dart';
import 'package:playwright_dart/src/core/browser_type.dart';
import 'package:playwright_dart/src/platform/android.dart';
import 'package:playwright_dart/src/platform/electron.dart';
import 'infrastructure/mock_transport.dart';

void main() {
  group('PlaywrightImpl Unit Tests', () {
    late TestConnection testConn;

    setUp(() {
      testConn = TestConnection(
        handler: (req) {
          if (req['method'] == 'newRequest') {
            return <String, dynamic>{
              'id': req['id'],
              'result': <String, dynamic>{
                'request': {'guid': 'APIRequestContext_1'},
              },
            };
          }
          return <String, dynamic>{
            'id': req['id'],
            'result': <String, dynamic>{},
          };
        },
      );

      testConn.dispatchCreate('BrowserType', 'BrowserType_chromium', {});
      testConn.dispatchCreate('BrowserType', 'BrowserType_firefox', {});
      testConn.dispatchCreate('BrowserType', 'BrowserType_webkit', {});
      testConn.dispatchCreate('Android', 'Android_1', {});
      testConn.dispatchCreate('Electron', 'Electron_1', {});
      testConn.dispatchCreate('LocalUtils', 'LocalUtils_1', {
        'deviceDescriptors': [
          {
            'name': 'Pixel 5',
            'descriptor': {
              'userAgent': 'Mozilla/5.0 Pixel 5',
              'viewport': {'width': 393, 'height': 851},
              'deviceScaleFactor': 2.75,
              'isMobile': true,
              'hasTouch': true,
              'defaultBrowserType': 'chromium',
            },
          },
        ],
      });

      testConn.dispatchCreate('Playwright', 'Playwright_1', {
        'chromium': {'guid': 'BrowserType_chromium'},
        'firefox': {'guid': 'BrowserType_firefox'},
        'webkit': {'guid': 'BrowserType_webkit'},
        'android': {'guid': 'Android_1'},
        'electron': {'guid': 'Electron_1'},
        'utils': {'guid': 'LocalUtils_1'},
      });
    });

    test('PlaywrightImpl is created from dispatchCreate', () {
      expect(testConn.getObject('Playwright_1'), isA<Playwright>());
    });

    test('chromium returns BrowserType instance', () {
      final pw = testConn.getObject('Playwright_1') as Playwright;
      expect(pw.chromium, isA<BrowserType>());
    });

    test('firefox returns BrowserType instance', () {
      final pw = testConn.getObject('Playwright_1') as Playwright;
      expect(pw.firefox, isA<BrowserType>());
    });

    test('webkit returns BrowserType instance', () {
      final pw = testConn.getObject('Playwright_1') as Playwright;
      expect(pw.webkit, isA<BrowserType>());
    });

    test('android returns Android instance', () {
      final pw = testConn.getObject('Playwright_1') as Playwright;
      expect(pw.android, isA<Android>());
    });

    test('electron returns Electron instance', () {
      final pw = testConn.getObject('Playwright_1') as Playwright;
      expect(pw.electron, isA<Electron>());
    });

    test('devices returns mapped device descriptors', () {
      final pw = testConn.getObject('Playwright_1') as Playwright;
      final devices = pw.devices;
      expect(devices, contains('Pixel 5'));
      expect(devices['Pixel 5']!['userAgent'], equals('Mozilla/5.0 Pixel 5'));
    });

    test('newRequest sends newRequest message and returns context', () async {
      testConn.dispatchCreate('APIRequestContext', 'APIRequestContext_1', {});

      final pw = testConn.getObject('Playwright_1') as Playwright;
      final request = await pw.newRequest(baseURL: 'https://example.com');

      expect(request, isNotNull);
      final msg = testConn.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'newRequest',
      );
      expect(msg['params']['baseURL'], equals('https://example.com'));
    });

    test('PlaywrightImpl handles missing optional initializers gracefully', () {
      testConn.dispatchCreate('Playwright', 'Playwright_2', {
        'chromium': {'guid': 'BrowserType_chromium'},
        // Omitting firefox, webkit, android, electron, utils
      });

      final pw = testConn.getObject('Playwright_2') as Playwright;
      expect(pw.chromium, isA<BrowserType>());

      // Accessing an uninitialized late field should throw StateError/LateInitializationError
      expect(() => pw.firefox, throwsA(isA<Error>()));
    });
  });
}
