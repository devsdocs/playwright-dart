import 'dart:convert';
import 'generated/channels.dart';

class PlaywrightStream extends StreamBase {
  PlaywrightStream(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  Future<List<int>> read({int? size}) async {
    final result = await channel_read(size: size);
    return base64Decode(result.binary);
  }

  Future<void> close() async {
    await channel_close();
  }
}
