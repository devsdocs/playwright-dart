import '../generated/channels.dart';

/// Interface for CDPSession
abstract interface class CDPSession {
  Stream<CDPSession> get onClose;
  Stream<Map<String, dynamic>> get onEvent;
  Future<Map<String, dynamic>> send(
    String method, {
    Map<String, dynamic>? params,
  });
  Future<void> detach();
}

class CDPSessionImpl extends CDPSessionBase implements CDPSession {
  @override
  Stream<CDPSession> get onClose {
    return super.onEvent.where((e) => e['event'] == 'close').map((e) => this);
  }

  @override
  Stream<Map<String, dynamic>> get onEvent {
    return super.onEvent
        .where((e) => e['event'] == 'event')
        .map((e) => e['params']);
  }

  CDPSessionImpl(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  @override
  Future<Map<String, dynamic>> send(
    String method, {
    Map<String, dynamic>? params,
  }) async {
    final result = await channel_send(method: method, params: params);
    return result.result as Map<String, dynamic>? ?? {};
  }

  @override
  Future<void> detach() async {
    await channel_detach();
  }
}
