import '../generated/channels.dart';

/// Interface for WritableStream
abstract interface class WritableStream {
  Future<void> write(String binary);
  Future<void> close();
}

class WritableStreamImpl extends WritableStreamBase implements WritableStream {
  WritableStreamImpl(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  @override
  Future<void> write(String binary) async {
    await channel.write(binary: binary);
  }

  @override
  Future<void> close() async {
    await channel.close();
  }
}
