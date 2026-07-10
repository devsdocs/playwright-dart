import 'package:test/test.dart';
import 'package:playwright_dart/src/core/browser.dart';
import 'package:playwright_dart/src/core/browser_context.dart';
import 'package:playwright_dart/src/core/browser_type.dart';
import 'infrastructure/mock_transport.dart';

void main() {
  group('BrowserTypeImpl Unit Tests', () {
    late TestConnection testConn;

    setUp(() {
      testConn = TestConnection(
        handler: (req) {
          if (req['method'] == 'launch') {
            return <String, dynamic>{
              'id': req['id'],
              'result': <String, dynamic>{
                'browser': {'guid': 'Browser_1'},
              },
            };
          } else if (req['method'] == 'launchPersistentContext') {
            return <String, dynamic>{
              'id': req['id'],
              'result': <String, dynamic>{
                'context': {'guid': 'BrowserContext_1'},
                'browser': {'guid': 'Browser_1'},
              },
            };
          } else if (req['method'] == 'connect') {
            return <String, dynamic>{
              'id': req['id'],
              'result': <String, dynamic>{
                'browser': {'guid': 'Browser_2'},
              },
            };
          }
          return <String, dynamic>{
            'id': req['id'],
            'result': <String, dynamic>{},
          };
        },
      );

      testConn.dispatchCreate('BrowserType', 'BrowserType_1', {
        'name': 'chromium',
        'executablePath': '/usr/bin/google-chrome',
      });

      testConn.dispatchCreate('Browser', 'Browser_1', {
        'name': 'chromium',
        'version': '120.0.6099.0',
      });

      testConn.dispatchCreate('Browser', 'Browser_2', {
        'name': 'chromium',
        'version': '120.0.6099.0',
      });

      testConn.dispatchCreate('Tracing', 'Tracing_1', {});
      testConn.dispatchCreate('APIRequestContext', 'APIRequestContext_1', {});
      testConn.dispatchCreate('BrowserContext', 'BrowserContext_1', {
        'isChromium': true,
        'tracing': {'guid': 'Tracing_1'},
        'requestContext': {'guid': 'APIRequestContext_1'},
      }, parentGuid: 'Browser_1');
    });

    test('BrowserTypeImpl is created from dispatchCreate', () {
      expect(testConn.getObject('BrowserType_1'), isA<BrowserType>());
    });

    test('name returns value from initializer', () {
      final browserType = testConn.getObject('BrowserType_1') as BrowserType;
      expect(browserType.name, equals('chromium'));
    });

    test('executablePath returns value from initializer', () {
      final browserType = testConn.getObject('BrowserType_1') as BrowserType;
      expect(browserType.executablePath, equals('/usr/bin/google-chrome'));
    });

    test('launch sends launch message and returns browser', () async {
      final browserType = testConn.getObject('BrowserType_1') as BrowserType;
      final browser = await browserType.launch();

      expect(browser, isA<Browser>());

      testConn.transport.sentMessages.lastWhere((m) => m['method'] == 'launch');
    });

    test(
      'launchPersistentContext sends launchPersistentContext message',
      () async {
        final browserType = testConn.getObject('BrowserType_1') as BrowserType;
        final context = await browserType.launchPersistentContext(
          'userDataDir',
        );

        expect(context, isA<BrowserContext>());

        final msg = testConn.transport.sentMessages.lastWhere(
          (m) => m['method'] == 'launchPersistentContext',
        );
        expect(msg['params']['userDataDir'], equals('userDataDir'));
      },
    );
  });
}
