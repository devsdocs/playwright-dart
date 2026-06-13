import '../generated/channels.dart';

/// Interface for WebSocketRoute
abstract interface class WebSocketRoute {
  Stream<Map<String, dynamic>> get onCloseServer;
  Stream<Map<String, dynamic>> get onClosePage;
  Stream<Map<String, dynamic>> get onMessageFromServer;
  Stream<Map<String, dynamic>> get onMessageFromPage;
  Future<void> connect();
  Future<void> ensureOpened();
  Future<void> sendToPage(String message, {bool isBase64});
  Future<void> sendToServer(String message, {bool isBase64});
  Future<void> closePage({int? code, String? reason, bool wasClean});
  Future<void> closeServer({int? code, String? reason, bool wasClean});
}

class WebSocketRouteImpl extends WebSocketRouteBase implements WebSocketRoute {
  @override
  Stream<Map<String, dynamic>> get onCloseServer {
    return onEvent
        .where((e) => e['event'] == 'closeServer')
        .map((e) => e['params']);
  }

  @override
  Stream<Map<String, dynamic>> get onClosePage {
    return onEvent
        .where((e) => e['event'] == 'closePage')
        .map((e) => e['params']);
  }

  @override
  Stream<Map<String, dynamic>> get onMessageFromServer {
    return onEvent
        .where((e) => e['event'] == 'messageFromServer')
        .map((e) => e['params']);
  }

  @override
  Stream<Map<String, dynamic>> get onMessageFromPage {
    return onEvent
        .where((e) => e['event'] == 'messageFromPage')
        .map((e) => e['params']);
  }

  WebSocketRouteImpl(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  @override
  Future<void> connect() async {
    await channel_connect();
  }

  @override
  Future<void> ensureOpened() async {
    await channel_ensureOpened();
  }

  @override
  Future<void> sendToPage(String message, {bool isBase64 = false}) async {
    await channel_sendToPage(message: message, isBase64: isBase64);
  }

  @override
  Future<void> sendToServer(String message, {bool isBase64 = false}) async {
    await channel_sendToServer(message: message, isBase64: isBase64);
  }

  @override
  Future<void> closePage({
    int? code,
    String? reason,
    bool wasClean = true,
  }) async {
    await channel_closePage(code: code, reason: reason, wasClean: wasClean);
  }

  @override
  Future<void> closeServer({
    int? code,
    String? reason,
    bool wasClean = true,
  }) async {
    await channel_closeServer(code: code, reason: reason, wasClean: wasClean);
  }
}
