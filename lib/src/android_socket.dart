import 'generated/channels.dart';

class AndroidSocket extends AndroidSocketBase {
  AndroidSocket(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  Future<void> write(String data) async {
    await channel_write(data: data);
  }

  Future<void> close() async {
    await channel_close();
  }
}
