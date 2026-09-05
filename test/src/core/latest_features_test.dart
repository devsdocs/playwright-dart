import 'package:test/test.dart';
import 'package:playwright_dart/playwright_dart.dart';
import '../infrastructure/mock_transport.dart';

void main() {
  group('Latest Protocol v1.63.0 Features', () {
    late TestConnection testConnection;

    setUp(() {
      testConnection = TestConnection(
        handler: (request) {
          if (request['method'] == 'ariaSnapshotJSON') {
            return {
              'id': request['id'],
              'result': {
                'snapshot': {
                  'role': 'heading',
                  'name': 'Title',
                  'level': 1,
                },
              },
            };
          }
          return {'id': request['id'], 'result': <String, dynamic>{}};
        },
      );
    });

    test('Frame.ariaSnapshotJSON sends ariaSnapshotJSON command with options', () async {
      testConnection.dispatchCreate('Frame', 'Frame_1', {
        'url': 'https://example.com',
        'name': 'main',
        'parentFrame': null,
      });

      final frame = testConnection.getObject('Frame_1') as FrameImpl;

      final result = await frame.ariaSnapshotJSON(
        selector: 'h1',
        mode: SnapshotMode.ai,
        depth: 3,
        boxes: true,
        timeout: 5000,
      );

      expect(result.snapshot, isNotNull);
      final req = testConnection.transport.sentMessages.firstWhere(
        (m) => m['method'] == 'ariaSnapshotJSON',
      );
      expect(req['guid'], 'Frame_1');
      expect(req['params']['selector'], 'h1');
      expect(req['params']['mode'], 'ai');
      expect(req['params']['depth'], 3);
      expect(req['params']['boxes'], isTrue);
      expect(req['params']['timeout'], 5000);
    });

    test('Page.ariaSnapshotJSON delegates to mainFrame', () async {
      testConnection.dispatchCreate('Frame', 'Frame_1', {
        'url': 'https://example.com',
        'name': 'main',
        'parentFrame': null,
      });
      testConnection.dispatchCreate('Page', 'Page_1', {
        'mainFrame': {'guid': 'Frame_1'},
        'isClosed': false,
      });

      final page = testConnection.getObject('Page_1') as PageImpl;
      final result = await page.ariaSnapshotJSON(
        mode: SnapshotMode.defaultValue,
      );

      expect(result.snapshot, isNotNull);
      final req = testConnection.transport.sentMessages.firstWhere(
        (m) => m['method'] == 'ariaSnapshotJSON',
      );
      expect(req['guid'], 'Frame_1');
      expect(req['params']['mode'], 'default');
    });

    test('Locator.ariaSnapshotJSON passes locator selector to frame', () async {
      testConnection.dispatchCreate('Frame', 'Frame_1', {
        'url': 'https://example.com',
        'name': 'main',
        'parentFrame': null,
      });
      testConnection.dispatchCreate('Page', 'Page_1', {
        'mainFrame': {'guid': 'Frame_1'},
        'isClosed': false,
      });

      final page = testConnection.getObject('Page_1') as PageImpl;
      final locator = page.locator('button.submit');
      final result = await locator.ariaSnapshotJSON(depth: 2);

      expect(result.snapshot, isNotNull);
      final req = testConnection.transport.sentMessages.firstWhere(
        (m) => m['method'] == 'ariaSnapshotJSON',
      );
      expect(req['guid'], 'Frame_1');
      expect(req['params']['selector'], 'button.submit');
      expect(req['params']['depth'], 2);
    });

    test('Page.screencastFrameAck sends frameId to channel', () async {
      testConnection.dispatchCreate('Frame', 'Frame_1', {
        'url': 'https://example.com',
        'name': 'main',
        'parentFrame': null,
      });
      testConnection.dispatchCreate('Page', 'Page_1', {
        'mainFrame': {'guid': 'Frame_1'},
        'isClosed': false,
      });

      final page = testConnection.getObject('Page_1') as PageImpl;
      await page.screencastFrameAck(frameId: 101, timeout: 2000);

      final req = testConnection.transport.sentMessages.firstWhere(
        (m) => m['method'] == 'screencastFrameAck',
      );
      expect(req['guid'], 'Page_1');
      expect(req['params']['frameId'], 101);
      expect(req['params']['timeout'], 2000);
    });

    test('Debugger.enable sends enable command to channel', () async {
      testConnection.dispatchCreate('Debugger', 'Debugger_1', {});
      final debugger = testConnection.getObject('Debugger_1') as DebuggerImpl;

      await debugger.enable(timeout: 3000);

      final req = testConnection.transport.sentMessages.firstWhere(
        (m) => m['method'] == 'enable',
      );
      expect(req['guid'], 'Debugger_1');
      expect(req['params']['timeout'], 3000);
    });

    test('Tracing.start translates snapshots/screenshots to granular protocol params', () async {
      testConnection.dispatchCreate('Tracing', 'Tracing_1', {});
      final tracing = testConnection.getObject('Tracing_1') as TracingImpl;

      await tracing.start(
        name: 'my-trace',
        snapshots: true,
        screenshots: true,
        live: false,
      );

      final req = testConnection.transport.sentMessages.firstWhere(
        (m) => m['method'] == 'tracingStart',
      );
      expect(req['guid'], 'Tracing_1');
      expect(req['params']['name'], 'my-trace');
      expect(req['params']['snapshotDom'], isTrue);
      expect(req['params']['snapshotAria'], isTrue);
      expect(req['params']['snapshotScreen'], isTrue);
      expect(req['params']['screencast'], isTrue);
      expect(req['params']['live'], isFalse);
    });

    test('BrowserContext.setHTTPCredentials wraps credentials into list', () async {
      testConnection.dispatchCreate('Browser', 'Browser_1', {
        'name': 'chromium',
        'version': '123.0',
      });
      testConnection.dispatchCreate('Tracing', 'Tracing_1', {});
      testConnection.dispatchCreate('APIRequestContext', 'APIRequestContext_1', {});
      testConnection.dispatchCreate('BrowserContext', 'BrowserContext_1', {
        'isChromium': true,
        'tracing': {'guid': 'Tracing_1'},
        'requestContext': {'guid': 'APIRequestContext_1'},
      }, parentGuid: 'Browser_1');

      final ctx = testConnection.getObject('BrowserContext_1') as BrowserContextImpl;

      await ctx.setHTTPCredentials(
        HttpCredentials(username: 'admin', password: 'secretpassword'),
      );

      final req = testConnection.transport.sentMessages.firstWhere(
        (m) => m['method'] == 'setHTTPCredentials',
      );
      expect(req['guid'], 'BrowserContext_1');
      expect(req['params']['httpCredentials'], isA<List>());
      final list = req['params']['httpCredentials'] as List;
      expect(list.length, 1);
      expect(list.first.username, 'admin');
      expect(list.first.password, 'secretpassword');
    });
  });
}
