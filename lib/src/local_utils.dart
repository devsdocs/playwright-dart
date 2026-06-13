import 'generated/channels.dart';

class LocalUtils extends LocalUtilsBase {
  LocalUtils(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);
  Future<void> zip(
    String zipFile,
    List<NameValue> entries, {
    String? stacksId,
    required String mode,
    required bool includeSources,
    List<String>? additionalSources,
  }) async {
    await channel_zip(
      zipFile: zipFile,
      entries: entries,
      stacksId: stacksId,
      mode: mode,
      includeSources: includeSources,
      additionalSources: additionalSources,
    );
  }

  Future<String> harOpen(String file) async {
    final result = await channel_harOpen(file: file);
    return result['harId'] as String;
  }

  Future<Map<String, dynamic>> harLookup(
    String harId,
    String url,
    String method,
    List<NameValue> headers,
    bool isNavigationRequest, {
    String? postData,
  }) async {
    return await channel_harLookup(
      harId: harId,
      url: url,
      method: method,
      headers: headers,
      isNavigationRequest: isNavigationRequest,
      postData: postData,
    );
  }

  Future<void> harClose(String harId) async {
    await channel_harClose(harId: harId);
  }

  Future<void> harUnzip(
    String zipFile,
    String harFile, {
    String? resourcesDir,
  }) async {
    await channel_harUnzip(
      zipFile: zipFile,
      harFile: harFile,
      resourcesDir: resourcesDir,
    );
  }

  // Returns JsonPipe, which we don't have a wrapper for yet (Phase 8).
  // Return dynamic for now, or just return the channel owner.
  Future<dynamic> connect(
    String endpoint, {
    Map<String, dynamic>? headers,
    String? exposeNetwork,
    double? slowMo,
    double? timeout,
    int? socksProxyRedirectPortForTest,
  }) async {
    final result = await channel_connect(
      endpoint: endpoint,
      headers: headers,
      exposeNetwork: exposeNetwork,
      slowMo: slowMo,
      timeout: timeout ?? 30000.0,
      socksProxyRedirectPortForTest: socksProxyRedirectPortForTest,
    );
    return result['pipe'];
  }

  Future<String> tracingStarted(
    String traceName, {
    String? tracesDir,
    bool? live,
  }) async {
    final result = await channel_tracingStarted(
      traceName: traceName,
      tracesDir: tracesDir,
      live: live,
    );
    return result['traceId'] as String? ?? '';
  }

  Future<void> addStackToTracingNoReply(ClientSideCallMetadata callData) async {
    await channel_addStackToTracingNoReply(callData: callData);
  }

  Future<void> traceDiscarded(String stacksId) async {
    await channel_traceDiscarded(stacksId: stacksId);
  }

  Future<String> globToRegex(
    String glob, {
    String? baseURL,
    bool? webSocketUrl,
  }) async {
    final result = await channel_globToRegex(
      glob: glob,
      baseURL: baseURL,
      webSocketUrl: webSocketUrl,
    );
    return result['source'] as String;
  }
}
