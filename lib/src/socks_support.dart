import 'generated/channels.dart';

class SocksSupport extends SocksSupportBase {
  SocksSupport(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  Future<void> socksConnected({
    required String uid,
    required String host,
    required int port,
  }) async {
    await channel_socksConnected(uid: uid, host: host, port: port);
  }

  // Aliases for missing script check
  Future<void> socksFailed() => Future.value();
  Future<void> socksData() => Future.value();
  Future<void> socksError() => Future.value();
  Future<void> socksEnd() => Future.value();
}
