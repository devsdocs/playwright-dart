import 'generated/channels.dart';

class CDPSession extends CDPSessionBase {
  CDPSession(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  Future<Map<String, dynamic>> send(
    String method, {
    Map<String, dynamic>? params,
  }) async {
    final result = await channel_send(method: method, params: params);
    return result['result'] as Map<String, dynamic>? ?? {};
  }

  Future<void> detach() async {
    await channel_detach();
  }
}
