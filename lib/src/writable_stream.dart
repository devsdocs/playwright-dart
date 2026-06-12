import 'dart:convert';
import 'generated/channels.dart';

class WritableStream extends WritableStreamBase {
  WritableStream(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  Future<void> write(List<int> data) async {
    await channel_write(binary: base64Encode(data));
  }

  Future<void> close() async {
    await channel_close();
  }
}
