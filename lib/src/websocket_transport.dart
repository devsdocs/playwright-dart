import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'transport.dart';

class WebSocketTransport implements Transport {
  final WebSocket _ws;

  @override
  void Function(Map<String, dynamic> message)? onMessage;

  @override
  set onClose(CloseCallback? callback) {
    _onClose = callback;
  }

  CloseCallback? _onClose;

  WebSocketTransport(this._ws) {
    _ws.listen(
      (data) {
        if (data is String) {
          final message = jsonDecode(data);
          onMessage?.call(message);
        }
      },
      onDone: () => _onClose?.call(),
      onError: (e) => _onClose?.call(),
    );
  }

  @override
  void send(Map<String, dynamic> message) {
    _ws.add(jsonEncode(message));
  }

  @override
  Future<void> close() async {
    await _ws.close();
  }

  static Future<WebSocketTransport> connect(String url) async {
    final ws = await WebSocket.connect(url);
    return WebSocketTransport(ws);
  }
}
