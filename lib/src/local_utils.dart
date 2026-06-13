import 'generated/channels.dart';

/// Interface for LocalUtils
abstract interface class LocalUtils {
  Future<void> zip(
    String zipFile,
    List<NameValue> entries, {
    String? stacksId,
    required LocalUtilsZipModeEnum mode,
    required bool includeSources,
    List<String>? additionalSources,
  });
  Future<String> harOpen(String file);
  Future<LocalUtilsHarLookupResult> harLookup(
    String harId,
    String url,
    String method,
    List<NameValue> headers,
    bool isNavigationRequest, {
    String? postData,
  });
  Future<void> harClose(String harId);
  Future<void> harUnzip(String zipFile, String harFile, {String? resourcesDir});
  Future<dynamic> connect(
    String endpoint, {
    Map<String, dynamic>? headers,
    String? exposeNetwork,
    double? slowMo,
    double? timeout,
    int? socksProxyRedirectPortForTest,
  });
  Future<String> tracingStarted(
    String traceName, {
    String? tracesDir,
    bool? live,
  });
  Future<void> addStackToTracingNoReply(ClientSideCallMetadata callData);
  Future<void> traceDiscarded(String stacksId);
  Future<String> globToRegex(
    String glob, {
    String? baseURL,
    bool? webSocketUrl,
  });
}

class LocalUtilsImpl extends LocalUtilsBase implements LocalUtils {
  LocalUtilsImpl(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);
  @override
  Future<void> zip(
    String zipFile,
    List<NameValue> entries, {
    String? stacksId,
    required LocalUtilsZipModeEnum mode,
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

  @override
  Future<String> harOpen(String file) async {
    final result = await channel_harOpen(file: file);
    return result.harId as String;
  }

  @override
  Future<LocalUtilsHarLookupResult> harLookup(
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

  @override
  Future<void> harClose(String harId) async {
    await channel_harClose(harId: harId);
  }

  @override
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
  @override
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
    return result.pipe;
  }

  @override
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
    return result.stacksId;
  }

  @override
  Future<void> addStackToTracingNoReply(ClientSideCallMetadata callData) async {
    await channel_addStackToTracingNoReply(callData: callData);
  }

  @override
  Future<void> traceDiscarded(String stacksId) async {
    await channel_traceDiscarded(stacksId: stacksId);
  }

  @override
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
    return result.regex;
  }
}
