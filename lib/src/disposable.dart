import 'generated/channels.dart';

class Disposable extends DisposableBase {
  Disposable(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  @override
  Future<void> dispose() async {
    await channel_dispose();
  }
}
