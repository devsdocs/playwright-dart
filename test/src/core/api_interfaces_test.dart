import 'package:test/test.dart';
import 'package:playwright_dart/src/core/browser_type.dart';
import 'package:playwright_dart/src/core/browser.dart';
import 'package:playwright_dart/src/core/browser_context.dart';
import 'package:playwright_dart/src/core/page.dart';
import 'package:playwright_dart/src/generated/channels.dart';
import '../infrastructure/mock_transport.dart';

void main() {
  group('API Interfaces (channels.dart wrappers)', () {
    test('BrowserType.launch sends launch command and returns Browser', () async {
      final testConnection = TestConnection(
        handler: (request) {
          if (request['method'] == 'launch') {
            return {
              'id': request['id'],
              'result': {
                'browser': {'guid': 'Browser_1'},
              },
            };
          }
          return {};
        },
      );

      // Inject BrowserType
      testConnection.dispatchCreate('BrowserType', 'BrowserType_1', {
        'executablePath': '/bin/chrome',
        'name': 'chromium',
      });
      final browserType =
          testConnection.getObject('BrowserType_1') as BrowserTypeImpl;

      // Inject Browser response object ahead of time so the channel owner is ready
      testConnection.dispatchCreate('Browser', 'Browser_1', {
        'version': '123.0',
      });

      final browser = await browserType.launch(
        options: LaunchOptions(headless: false, timeout: 0),
      );
      expect(browser, isNotNull);
      expect(browser.version, '123.0');

      final launchReq = testConnection.transport.sentMessages.firstWhere(
        (m) => m['method'] == 'launch',
      );
      expect(launchReq['params']['headless'], false);
    });

    test(
      'Browser.newContext sends newContext command and returns BrowserContext',
      () async {
        final testConnection = TestConnection(
          handler: (request) {
            if (request['method'] == 'newContext') {
              return {
                'id': request['id'],
                'result': {
                  'context': {'guid': 'BrowserContext_1'},
                },
              };
            }
            return {};
          },
        );

        testConnection.dispatchCreate('BrowserType', 'BrowserType_chromium', {
          'executablePath': '',
          'name': 'chromium',
        });
        testConnection.dispatchCreate('BrowserType', 'BrowserType_firefox', {
          'executablePath': '',
          'name': 'firefox',
        });
        testConnection.dispatchCreate('BrowserType', 'BrowserType_webkit', {
          'executablePath': '',
          'name': 'webkit',
        });
        testConnection.dispatchCreate('LocalUtils', 'Utils_1', {});
        testConnection.dispatchCreate('Android', 'Android_1', {});
        testConnection.dispatchCreate('Electron', 'Electron_1', {});
        testConnection.dispatchCreate('Playwright', 'Playwright_1', {
          'chromium': {'guid': 'BrowserType_chromium'},
          'firefox': {'guid': 'BrowserType_firefox'},
          'webkit': {'guid': 'BrowserType_webkit'},
          'utils': {'guid': 'Utils_1'},
          'android': {'guid': 'Android_1'},
          'electron': {'guid': 'Electron_1'},
        });

        testConnection.dispatchCreate('Browser', 'Browser_1', {
          'version': '123.0',
        });
        final browser = testConnection.getObject('Browser_1') as BrowserImpl;

        testConnection.dispatchCreate('Tracing', 'Tracing_1', {});
        testConnection.dispatchCreate('APIRequestContext', 'RequestContext_1', {
          'tracing': {'guid': 'Tracing_1'},
        });

        testConnection.dispatchCreate('BrowserContext', 'BrowserContext_1', {
          'isChromium': true,
          'tracing': {'guid': 'Tracing_1'},
          'requestContext': {'guid': 'RequestContext_1'},
        });

        final context = await browser.newContext(
          options: ContextOptions(
            viewport: ContextOptionsViewport(width: 800, height: 600),
          ),
        );
        expect(context, isNotNull);

        final req = testConnection.transport.sentMessages.firstWhere(
          (m) => m['method'] == 'newContext',
        );
        expect(req['params']['viewport']['width'], 800);
        expect(req['params']['viewport']['height'], 600);
      },
    );

    test(
      'BrowserContext.newPage sends newPage command and returns Page',
      () async {
        final testConnection = TestConnection(
          handler: (request) {
            if (request['method'] == 'newPage') {
              return {
                'id': request['id'],
                'result': {
                  'page': {'guid': 'Page_1'},
                },
              };
            }
            return {};
          },
        );

        testConnection.dispatchCreate('Tracing', 'Tracing_1', {});
        testConnection.dispatchCreate('APIRequestContext', 'RequestContext_1', {
          'tracing': {'guid': 'Tracing_1'},
        });
        testConnection.dispatchCreate('BrowserContext', 'BrowserContext_1', {
          'isChromium': true,
          'tracing': {'guid': 'Tracing_1'},
          'requestContext': {'guid': 'RequestContext_1'},
        });
        final context =
            testConnection.getObject('BrowserContext_1') as BrowserContextImpl;

        testConnection.dispatchCreate('Frame', 'Frame_1', {
          'url': 'about:blank',
          'name': '',
          'parentFrame': null,
        });
        testConnection.dispatchCreate('Page', 'Page_1', {
          'mainFrame': {'guid': 'Frame_1'},
          'isClosed': false,
        });

        final page = await context.newPage();
        expect(page, isNotNull);

        final req = testConnection.transport.sentMessages.firstWhere(
          (m) => m['method'] == 'newPage',
        );
        expect(req['guid'], 'BrowserContext_1');
      },
    );

    test('Page.goto sends goto command with URL', () async {
      final testConnection = TestConnection(
        handler: (request) {
          if (request['method'] == 'goto') {
            return {
              'id': request['id'],
              'result': {
                'response': {'guid': 'Response_1'},
              },
            };
          }
          return {};
        },
      );

      testConnection.dispatchCreate('Frame', 'Frame_1', {
        'url': 'about:blank',
        'name': '',
        'parentFrame': null,
      });
      testConnection.dispatchCreate('Page', 'Page_1', {
        'mainFrame': {'guid': 'Frame_1'},
        'isClosed': false,
      });
      final page = testConnection.getObject('Page_1') as PageImpl;

      testConnection.dispatchCreate('Request', 'Request_1', {
        'url': 'https://example.com',
        'method': 'GET',
        'headers': [],
        'postData': null,
        'isNavigationRequest': true,
        'resourceType': 'document',
      });

      testConnection.dispatchCreate('Response', 'Response_1', {
        'url': 'https://example.com',
        'status': 200,
        'statusText': 'OK',
        'headers': [],
        'request': {'guid': 'Request_1'},
        'fromServiceWorker': false,
        'timing': {
          'startTime': 0,
          'domainLookupStart': -1,
          'domainLookupEnd': -1,
          'connectStart': -1,
          'secureConnectionStart': -1,
          'connectEnd': -1,
          'requestStart': -1,
          'responseStart': -1,
          'responseEnd': -1,
        },
      });

      await page.goto('https://example.com', timeout: 5000);

      final req = testConnection.transport.sentMessages.firstWhere(
        (m) => m['method'] == 'goto',
      );
      expect(req['params']['url'], 'https://example.com');
      expect(req['params']['timeout'], 5000);
    });
  });
}
