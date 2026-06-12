import 'generated/channels.dart';

class Electron extends ElectronBase {
  Electron(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  Future<Map<String, dynamic>> launch({
    String? executablePath,
    List<String>? args,
    bool? chromiumSandbox,
    String? cwd,
    List<NameValue>? env,
    required double timeout,
    String? acceptDownloads,
    bool? bypassCSP,
    String? colorScheme,
    List<NameValue>? extraHTTPHeaders,
    Map<String, dynamic>? geolocation,
  }) async {
    return await channel_launch(
      executablePath: executablePath,
      args: args,
      chromiumSandbox: chromiumSandbox,
      cwd: cwd,
      env: env,
      timeout: timeout,
      acceptDownloads: acceptDownloads,
      bypassCSP: bypassCSP,
      colorScheme: colorScheme,
      extraHTTPHeaders: extraHTTPHeaders,
      geolocation: geolocation,
    );
  }
}
