import 'generated/channels.dart';

/// Interface for SocksSupport
abstract interface class SocksSupport {
  Stream<dynamic> get onSocksClosed;
  Stream<Map<String, dynamic>> get onSocksData;
  Stream<Map<String, dynamic>> get onSocksRequested;
  Future<void> socksConnected({
    required String uid,
    required String host,
    required int port,
  });
  Future<void> socksFailed(String uid, String errorCode);
  Future<void> socksData(String uid, String data);
  Future<void> socksError(String uid, String error);
  Future<void> socksEnd(String uid);
}

class SocksSupportImpl extends SocksSupportBase implements SocksSupport {
  @override
  Stream<dynamic> get onSocksClosed {
    return onEvent
        .where((e) => e['event'] == 'socksClosed')
        .map((e) => e['params']['uid']);
  }

  @override
  Stream<Map<String, dynamic>> get onSocksData {
    return onEvent
        .where((e) => e['event'] == 'socksData')
        .map((e) => e['params']);
  }

  @override
  Stream<Map<String, dynamic>> get onSocksRequested {
    return onEvent
        .where((e) => e['event'] == 'socksRequested')
        .map((e) => e['params']);
  }

  SocksSupportImpl(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  @override
  Future<void> socksConnected({
    required String uid,
    required String host,
    required int port,
  }) async {
    await channel_socksConnected(uid: uid, host: host, port: port);
  }

  @override
  Future<void> socksFailed(String uid, String errorCode) async {
    await channel_socksFailed(uid: uid, errorCode: errorCode);
  }

  @override
  Future<void> socksData(String uid, String data) async {
    await channel_socksData(uid: uid, data: data);
  }

  @override
  Future<void> socksError(String uid, String error) async {
    await channel_socksError(uid: uid, error: error);
  }

  @override
  Future<void> socksEnd(String uid) async {
    await channel_socksEnd(uid: uid);
  }
}
