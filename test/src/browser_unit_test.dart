import 'package:test/test.dart';
import 'package:playwright_dart/src/core/browser.dart';
import 'infrastructure/mock_transport.dart';

void main() {
  group('BrowserImpl Unit Tests', () {
    late TestConnection testConn;

    setUp(() {
      testConn = TestConnection(
        handler: (req) => <String, dynamic>{
          'id': req['id'],
          'result': <String, dynamic>{},
        },
      );

      testConn.dispatchCreate('Browser', 'Browser_1', {
        'name': 'chromium',
        'version': '120.0.6099.0',
      });
    });

    test('BrowserImpl is created from dispatchCreate', () {
      expect(testConn.getObject('Browser_1'), isA<Browser>());
    });

    test('contexts returns an empty list initially', () {
      final browser = testConn.getObject('Browser_1') as Browser;
      expect(browser.contexts, isEmpty);
    });

    test('version returns value from initializer', () {
      final browser = testConn.getObject('Browser_1') as Browser;
      expect(browser.version, equals('120.0.6099.0'));
    });

    test('browserName returns value from initializer', () {
      final browser = testConn.getObject('Browser_1') as Browser;
      expect(browser.browserName, equals('chromium'));
    });

    test('isConnected returns true initially', () {
      final browser = testConn.getObject('Browser_1') as Browser;
      expect(browser.isConnected, isTrue);
    });

    test('close sends close message', () async {
      final browser = testConn.getObject('Browser_1') as Browser;
      await browser.close();

      expect(
        testConn.transport.sentMessages.any((m) => m['method'] == 'close'),
        isTrue,
      );
    });

    test('newContext sends newContext message and returns context', () async {
      testConn = TestConnection(
        handler: (req) {
          if (req['method'] == 'newContext') {
            return <String, dynamic>{
              'id': req['id'],
              'result': <String, dynamic>{
                'context': {'guid': 'BrowserContext_1'},
              },
            };
          }
          return <String, dynamic>{'id': req['id'], 'result': {}};
        },
      );

      testConn.dispatchCreate('Browser', 'Browser_1', {
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
      testConn.dispatchCreate('BrowserType', 'b1', {});
      testConn.dispatchCreate('Android', 'a1', {});
      testConn.dispatchCreate('Electron', 'e1', {});
      testConn.dispatchCreate('LocalUtils', 'l1', {});
      testConn.dispatchCreate('Playwright', 'Playwright_1', {
        'chromium': {'guid': 'b1'},
        'firefox': {'guid': 'b1'},
        'webkit': {'guid': 'b1'},
        'android': {'guid': 'a1'},
        'electron': {'guid': 'e1'},
        'utils': {'guid': 'l1'},
      });

      final browser = testConn.getObject('Browser_1') as Browser;
      final context = await browser.newContext();

      expect(context, isNotNull);
      expect(
        testConn.transport.sentMessages.any((m) => m['method'] == 'newContext'),
        isTrue,
      );
      expect(browser.contexts, contains(context));
    });

    test('onClose stream emits when browser closes', () async {
      final browser = testConn.getObject('Browser_1') as Browser;
      final closeFuture = browser.onClose.first;

      testConn.dispatchEvent('Browser_1', 'close', {});

      final result = await closeFuture.timeout(const Duration(seconds: 2));
      expect(result, same(browser));
      expect(browser.isConnected, isFalse);
    });
  });
}
