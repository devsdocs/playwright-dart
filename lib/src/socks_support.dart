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

  Future<void> socksFailed(String uid, String errorCode) async {
    await channel_socksFailed(uid: uid, errorCode: errorCode);
  }

  Future<void> socksData(String uid, String data) async {
    await channel_socksData(uid: uid, data: data);
  }

  Future<void> socksError(String uid, String error) async {
    await channel_socksError(uid: uid, error: error);
  }

  Future<void> socksEnd(String uid) async {
    await channel_socksEnd(uid: uid);
  }
}
