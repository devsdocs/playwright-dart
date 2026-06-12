import 'generated/channels.dart';

class JsonPipe extends JsonPipeBase {
  JsonPipe(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  Future<void> send(Map<String, dynamic> message) async {
    await channel_send(message: message);
  }

  Future<void> close() async {
    await channel_close();
  }
}
