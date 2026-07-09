import 'dart:convert';
import '../generated/channels.dart';

/// Interface for PlaywrightStream
abstract interface class PlaywrightStream {
  Future<List<int>> read({int? size});
  Future<void> close();
}

class PlaywrightStreamImpl extends StreamBase implements PlaywrightStream {
  PlaywrightStreamImpl(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  @override
  Future<List<int>> read({int? size}) async {
    final result = await channel.read(size: size);
    return base64Decode(result.binary);
  }

  @override
  Future<void> close() async {
    await channel.close();
  }
}
