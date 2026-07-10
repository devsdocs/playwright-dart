import 'package:test/test.dart';
import 'package:playwright_dart/src/core/browser.dart';
import 'package:playwright_dart/src/core/browser_context.dart';
import 'infrastructure/mock_transport.dart';

void main() {
  group('BrowserContextImpl Unit Tests', () {
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

      testConn.dispatchCreate('Tracing', 'Tracing_1', {});
      testConn.dispatchCreate('APIRequestContext', 'APIRequestContext_1', {});
      testConn.dispatchCreate('BrowserContext', 'BrowserContext_1', {
        'isChromium': true,
        'tracing': {'guid': 'Tracing_1'},
        'requestContext': {'guid': 'APIRequestContext_1'},
      }, parentGuid: 'Browser_1');
    });

    test('BrowserContextImpl is created from dispatchCreate', () {
      expect(testConn.getObject('BrowserContext_1'), isA<BrowserContext>());
    });

    test('pages returns an empty list initially', () {
      final context = testConn.getObject('BrowserContext_1') as BrowserContext;
      expect(context.pages, isEmpty);
    });

    test('browser returns the owner browser', () {
      final context = testConn.getObject('BrowserContext_1') as BrowserContext;
      final browser = testConn.getObject('Browser_1') as Browser;
      expect(context.browser, equals(browser));
    });

    test('close sends close message', () async {
      final context = testConn.getObject('BrowserContext_1') as BrowserContext;
      await context.close();

      expect(
        testConn.transport.sentMessages.any((m) => m['method'] == 'close'),
        isTrue,
      );
    });

    test('newPage sends newPage message and returns page', () async {
      testConn = TestConnection(
        handler: (req) {
          if (req['method'] == 'newPage') {
            return <String, dynamic>{
              'id': req['id'],
              'result': <String, dynamic>{
                'page': {'guid': 'Page_1'},
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

      testConn.dispatchCreate('Tracing', 'Tracing_2', {});
      testConn.dispatchCreate('APIRequestContext', 'APIRequestContext_2', {});
      testConn.dispatchCreate('BrowserContext', 'BrowserContext_1', {
        'isChromium': true,
        'tracing': {'guid': 'Tracing_2'},
        'requestContext': {'guid': 'APIRequestContext_2'},
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

      testConn.dispatchCreate('Frame', 'Frame_1', {
        'url': 'about:blank',
        'name': '',
        'loadStates': [],
      });
      testConn.dispatchCreate('Page', 'Page_1', {
        'isClosed': false,
        'mainFrame': {'guid': 'Frame_1'},
      }, parentGuid: 'BrowserContext_1');

      final context = testConn.getObject('BrowserContext_1') as BrowserContext;
      final page = await context.newPage();

      expect(page, isNotNull);
      expect(
        testConn.transport.sentMessages.any((m) => m['method'] == 'newPage'),
        isTrue,
      );
      expect(context.pages, contains(page));
    });

    test('setOffline sends setOffline message', () async {
      final context = testConn.getObject('BrowserContext_1') as BrowserContext;
      await context.setOffline(true);

      expect(
        testConn.transport.sentMessages.any(
          (m) => m['method'] == 'setOffline' && m['params']['offline'] == true,
        ),
        isTrue,
      );
    });

    test('onClose stream emits when context closes', () async {
      final context = testConn.getObject('BrowserContext_1') as BrowserContext;
      final closeFuture = context.onClose.first;

      testConn.dispatchEvent('BrowserContext_1', 'close', {});

      final result = await closeFuture.timeout(const Duration(seconds: 2));
      expect(result, same(context));
    });
  });
}
