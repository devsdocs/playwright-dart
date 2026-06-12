import 'channel_owner.dart';
import 'browser_type.dart';
import 'local_utils.dart';
import 'generated/channels.dart';

class Playwright extends PlaywrightBase {
  late final BrowserType chromium;
  late final BrowserType firefox;
  late final BrowserType webkit;
  late final LocalUtils utils;

  Playwright(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]) {
    chromium = ChannelOwner.from<BrowserType>(
      connection,
      initializer['chromium'],
    );
    firefox = ChannelOwner.from<BrowserType>(
      connection,
      initializer['firefox'],
    );
    webkit = ChannelOwner.from<BrowserType>(connection, initializer['webkit']);
    utils = ChannelOwner.from<LocalUtils>(connection, initializer['utils']);
  }

  // Returns APIRequestContext, which will be implemented in Phase 8
  Future<dynamic> newRequest({
    String? baseURL,
    String? userAgent,
    bool? ignoreHTTPSErrors,
    List<NameValue>? extraHTTPHeaders,
    bool? failOnStatusCode,
    List<Map<String, dynamic>>? clientCertificates,
    int? maxRedirects,
    Map<String, dynamic>? httpCredentials,
    Map<String, dynamic>? proxy,
    Map<String, dynamic>? storageState,
    String? tracesDir,
  }) async {
    final result = await super.channel_newRequest(
      baseURL: baseURL,
      userAgent: userAgent,
      ignoreHTTPSErrors: ignoreHTTPSErrors,
      extraHTTPHeaders: extraHTTPHeaders,
      failOnStatusCode: failOnStatusCode,
      clientCertificates: clientCertificates,
      maxRedirects: maxRedirects,
      httpCredentials: httpCredentials,
      proxy: proxy,
      storageState: storageState,
      tracesDir: tracesDir,
    );
    return result['request'];
  }
}
