import '../generated/channels.dart';
import 'android_device.dart';

/// Interface for Android
abstract interface class Android {
  /// Returns the list of detected Android devices.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await android.devices();
  /// await android.devices(options);
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `host` String *(optional)*
  ///
  ///     Optional host to establish ADB server connection. Default to `127.0.0.1`.
  ///   - `omitDriverInstall` bool *(optional)*
  ///
  ///     Prevents automatic playwright driver installation on attach. Assumes that the drivers have been installed already.
  ///   - `port` int *(optional)*
  ///
  ///     Optional port to establish ADB server connection. Default to `5037`.
  ///
  /// **Returns**
  /// - Future&lt;List&lt;[AndroidDevice]&gt;&gt;
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
