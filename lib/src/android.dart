import 'generated/channels.dart';

class Android extends AndroidBase {
  Android(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  Future<Map<String, dynamic>> devices({
    String? host,
    int? port,
    bool? omitDriverInstall,
  }) async {
    return await channel_devices(
      host: host,
      port: port,
      omitDriverInstall: omitDriverInstall,
    );
  }
}
