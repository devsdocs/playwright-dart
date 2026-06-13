import '../generated/channels.dart';

/// Interface for JsonPipe
abstract interface class JsonPipe {
  Stream<dynamic> get onClosed;
  Stream<dynamic> get onMessage;
  Future<void> send(Map<String, dynamic> message);
  Future<void> close();
}

class JsonPipeImpl extends JsonPipeBase implements JsonPipe {
  @override
  Stream<dynamic> get onClosed {
    return onEvent
        .where((e) => e['event'] == 'closed')
        .map((e) => e['params']['reason']);
  }

  @override
  Stream<dynamic> get onMessage {
    return onEvent
        .where((e) => e['event'] == 'message')
        .map((e) => e['params']['message']);
  }

  JsonPipeImpl(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  @override
  Future<void> send(Map<String, dynamic> message) async {
    await channel_send(message: message);
  }

  @override
  Future<void> close() async {
    await channel_close();
  }
}
