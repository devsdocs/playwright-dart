import 'generated/channels.dart';

/// Interface for Electron
abstract interface class Electron {
  Future<ElectronLaunchResult> launch({
    String? executablePath,
    List<String>? args,
    bool? chromiumSandbox,
    String? cwd,
    List<NameValue>? env,
    required double timeout,
    ElectronLaunchAcceptDownloadsEnum? acceptDownloads,
    bool? bypassCSP,
    ElectronLaunchColorSchemeEnum? colorScheme,
    List<NameValue>? extraHTTPHeaders,
    Map<String, dynamic>? geolocation,
    Map<String, dynamic>? httpCredentials,
    bool? ignoreHTTPSErrors,
    String? locale,
    bool? offline,
    Map<String, dynamic>? recordVideo,
    bool? strictSelectors,
    String? timezoneId,
    String? tracesDir,
    String? artifactsDir,
    List<SelectorEngine>? selectorEngines,
    String? testIdAttributeName,
  });
}

class ElectronImpl extends ElectronBase implements Electron {
  ElectronImpl(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  @override
  Future<ElectronLaunchResult> launch({
    String? executablePath,
    List<String>? args,
    bool? chromiumSandbox,
    String? cwd,
    List<NameValue>? env,
    required double timeout,
    ElectronLaunchAcceptDownloadsEnum? acceptDownloads,
    bool? bypassCSP,
    ElectronLaunchColorSchemeEnum? colorScheme,
    List<NameValue>? extraHTTPHeaders,
    Map<String, dynamic>? geolocation,
    Map<String, dynamic>? httpCredentials,
    bool? ignoreHTTPSErrors,
    String? locale,
    bool? offline,
    Map<String, dynamic>? recordVideo,
    bool? strictSelectors,
    String? timezoneId,
    String? tracesDir,
    String? artifactsDir,
    List<SelectorEngine>? selectorEngines,
    String? testIdAttributeName,
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
      geolocation: geolocation == null
          ? null
          : ElectronLaunchGeolocation.fromJson(geolocation),
      httpCredentials: httpCredentials == null
          ? null
          : ElectronLaunchHttpCredentials.fromJson(httpCredentials),
      ignoreHTTPSErrors: ignoreHTTPSErrors,
      locale: locale,
      offline: offline,
      recordVideo: recordVideo == null
          ? null
          : ElectronLaunchRecordVideo.fromJson(recordVideo),
      strictSelectors: strictSelectors,
      timezoneId: timezoneId,
      tracesDir: tracesDir,
      artifactsDir: artifactsDir,
      selectorEngines: selectorEngines,
      testIdAttributeName: testIdAttributeName,
    );
  }
}
