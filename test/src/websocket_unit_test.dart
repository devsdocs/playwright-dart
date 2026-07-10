import 'package:test/test.dart';
import 'package:playwright_dart/src/network/websocket.dart';
import 'package:playwright_dart/src/network/websocket_route.dart';
import 'infrastructure/mock_transport.dart';

void main() {
  group('WebSocket and WebSocketRoute Unit Tests', () {
    test(
      'PlaywrightWebSocketImpl should map streams and url correctly',
      () async {
        final testConnection = TestConnection();

        testConnection.dispatchCreate('WebSocket', 'WebSocket_1', {
          'url': 'wss://example.com/ws',
        });
        final ws =
            testConnection.getObject('WebSocket_1') as PlaywrightWebSocketImpl;

        expect(ws.url, 'wss://example.com/ws');
        expect(ws.isClosed, isFalse);

        var onCloseCalled = false;
        var onSocketErrorCalled = false;
        var onFrameReceivedCalled = false;
        var onFrameSentCalled = false;
        var onOpenCalled = false;

        ws.onClose.listen((_) => onCloseCalled = true);
        ws.onSocketError.listen((_) => onSocketErrorCalled = true);
        ws.onFrameReceived.listen((_) => onFrameReceivedCalled = true);
        ws.onFrameSent.listen((_) => onFrameSentCalled = true);
        ws.onOpen.listen((_) => onOpenCalled = true);

        testConnection.dispatchEvent('WebSocket_1', 'close', {});
        testConnection.dispatchEvent('WebSocket_1', 'socketError', {
          'error': 'connection failed',
        });
        testConnection.dispatchEvent('WebSocket_1', 'frameReceived', {
          'data': 'hello',
        });
        testConnection.dispatchEvent('WebSocket_1', 'frameSent', {
          'data': 'ping',
        });
        testConnection.dispatchEvent('WebSocket_1', 'open', {});

        // Small delay to allow streams to process
        await Future.delayed(Duration(milliseconds: 50));

        expect(onCloseCalled, isTrue);
        expect(ws.isClosed, isTrue); // should be updated via listener
        expect(onSocketErrorCalled, isTrue);
        expect(onFrameReceivedCalled, isTrue);
        expect(onFrameSentCalled, isTrue);
        expect(onOpenCalled, isTrue);
      },
    );

    test('WebSocketRouteImpl should call correct channel methods', () async {
      final testConnection = TestConnection(
        handler: (request) {
          return <String, dynamic>{
            'id': request['id'],
            'result': <String, dynamic>{},
          };
        },
      );

      testConnection.dispatchCreate('WebSocketRoute', 'WebSocketRoute_1', {
        'url': 'wss://example.com/route',
      });
      final route =
          testConnection.getObject('WebSocketRoute_1') as WebSocketRouteImpl;

      await route.connect();
      expect(
        testConnection.transport.sentMessages.any(
          (m) => m['method'] == 'connect',
        ),
        isTrue,
      );

      await route.ensureOpened();
      expect(
        testConnection.transport.sentMessages.any(
          (m) => m['method'] == 'ensureOpened',
        ),
        isTrue,
      );

      await route.sendToPage('hello page', isBase64: true);
      var req = testConnection.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'sendToPage',
      );
      expect(req['params']['message'], 'hello page');
      expect(req['params']['isBase64'], true);

      await route.sendToServer('hello server');
      req = testConnection.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'sendToServer',
      );
      expect(req['params']['message'], 'hello server');
      expect(req['params']['isBase64'], false); // default

      await route.closePage(code: 1000, reason: 'done', wasClean: true);
      req = testConnection.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'closePage',
      );
      expect(req['params']['code'], 1000);
      expect(req['params']['reason'], 'done');
      expect(req['params']['wasClean'], true);

      await route.closeServer(code: 1001, reason: 'error', wasClean: false);
      req = testConnection.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'closeServer',
      );
      expect(req['params']['code'], 1001);
      expect(req['params']['reason'], 'error');
      expect(req['params']['wasClean'], false);
    });
  });
}
