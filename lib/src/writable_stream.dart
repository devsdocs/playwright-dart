import 'generated/channels.dart';

class WritableStream extends WritableStreamBase {
  WritableStream(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  Future<void> write(String binary) async {
    await channel_write(binary: binary);
  }

  Future<void> close() async {
    await channel_close();
  }
}
