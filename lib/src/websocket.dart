import 'generated/channels.dart';

/// Represents a WebSocket connection created by the page.
/// Interface for PlaywrightWebSocket
abstract interface class PlaywrightWebSocket {
  Stream<PlaywrightWebSocket> get onClose;
  Stream<dynamic> get onSocketError;
  Stream<Map<String, dynamic>> get onFrameReceived;
  Stream<Map<String, dynamic>> get onFrameSent;
  Stream<PlaywrightWebSocket> get onOpen;
  String get url;
  bool get isClosed;
}

class PlaywrightWebSocketImpl extends WebSocketBase
    implements PlaywrightWebSocket {
  bool _isClosed = false;

  @override
  bool get isClosed => _isClosed;

  @override
  Stream<PlaywrightWebSocket> get onClose {
    return onEvent.where((e) => e['event'] == 'close').map((e) => this);
  }

  @override
  Stream<dynamic> get onSocketError {
    return onEvent
        .where((e) => e['event'] == 'socketError')
        .map((e) => e['params']['error']);
  }

  @override
  Stream<Map<String, dynamic>> get onFrameReceived {
    return onEvent
        .where((e) => e['event'] == 'frameReceived')
        .map((e) => e['params']);
  }

  @override
  Stream<Map<String, dynamic>> get onFrameSent {
    return onEvent
        .where((e) => e['event'] == 'frameSent')
        .map((e) => e['params']);
  }

  @override
  Stream<PlaywrightWebSocket> get onOpen {
    return onEvent.where((e) => e['event'] == 'open').map((e) => this);
  }

  PlaywrightWebSocketImpl(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]) {
    onEvent.where((e) => e['event'] == 'close').listen((_) => _isClosed = true);
  }

  @override
  String get url => initializer['url'] as String;
}
