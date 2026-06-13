import '../generated/channels.dart';
import 'android_device.dart';

/// Interface for Android
abstract interface class Android {
  Future<List<AndroidDevice>> devices({
    String? host,
    int? port,
    bool? omitDriverInstall,
  });
}

class AndroidImpl extends AndroidBase implements Android {
  AndroidImpl(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  @override
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
