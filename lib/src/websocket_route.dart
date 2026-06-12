import 'generated/channels.dart';

class WebSocketRoute extends WebSocketRouteBase {
  WebSocketRoute(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  Future<void> connect() async {
    await channel_connect();
  }

  Future<void> ensureOpened() async {
    await channel_ensureOpened();
  }

  Future<void> sendToPage(String message, {bool isBase64 = false}) async {
    await channel_sendToPage(message: message, isBase64: isBase64);
  }

  Future<void> sendToServer(String message, {bool isBase64 = false}) async {
    await channel_sendToServer(message: message, isBase64: isBase64);
  }

  Future<void> closePage({int? code, String? reason, bool wasClean = true}) async {
    await channel_closePage(code: code, reason: reason, wasClean: wasClean);
  }

  Future<void> closeServer({int? code, String? reason, bool wasClean = true}) async {
    await channel_closeServer(code: code, reason: reason, wasClean: wasClean);
  }
}
