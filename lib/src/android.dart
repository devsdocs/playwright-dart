import 'generated/channels.dart';
import 'android_device.dart';

class Android extends AndroidBase {
  Android(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  Future<List<AndroidDevice>> devices({
    String? host,
    int? port,
    bool? omitDriverInstall,
  }) async {
    final result = await channel_devices(
      host: host,
      port: port,
      omitDriverInstall: omitDriverInstall,
    );
    return (result.devices as List).cast<AndroidDevice>();
  }
}
