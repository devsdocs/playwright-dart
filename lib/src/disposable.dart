import 'generated/channels.dart';

/// Interface for Disposable
abstract interface class Disposable {
  Future<void> dispose();
}

class DisposableImpl extends DisposableBase implements Disposable {
  DisposableImpl(
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
