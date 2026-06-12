import 'generated/channels.dart';

/// Represents a WebSocket connection created by the page.
class PlaywrightWebSocket extends WebSocketBase {
  PlaywrightWebSocket(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  String get url => initializer['url'] as String;
}
