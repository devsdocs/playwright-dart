import 'channel_owner.dart';
import 'browser_type.dart';
import 'local_utils.dart';
import 'generated/channels.dart';
import 'driver.dart';
import 'transport.dart';
import 'connection.dart';
import 'api_request_context.dart';
import 'selectors.dart';

/// The main Playwright module. Provides access to browser types (Chromium, Firefox, WebKit).
class Playwright extends PlaywrightBase {
  /// Provides access to the Chromium browser type.
  late final BrowserType chromium;

  /// Provides access to the Firefox browser type.
  late final BrowserType firefox;

  /// Provides access to the WebKit browser type.
  late final BrowserType webkit;

  /// Utilities related to local file paths and connections.
  late final LocalUtils utils;

  /// Custom selectors API.
  late final Selectors selectors;

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
    selectors = Selectors(this);
  }

  /// Creates an APIRequestContext to send network requests directly from the
  /// Playwright runner without requiring a browser instance.
  Future<APIRequestContext> newRequest({
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
    return result.request as APIRequestContext;
  }

  /// Closes the playwright connection and terminates the driver.
  Future<void> stop() async {
    connection.close();
  }
}

/// The entrypoint for Playwright Dart.
class PlaywrightDart {
  /// Launches the background Playwright driver and connects to it, returning the
  /// root [Playwright] API instance.
  ///
  /// Set [autoClose] to false if you want to manually manage the Playwright
  /// driver lifecycle (Python/Java pattern) instead of auto-shutting down
  /// when the last browser is closed.
  static Future<Playwright> create({bool autoClose = true}) async {
    final process = await Driver.run();
    final transport = StdioTransport(process);
    final connection = Connection(transport);
    connection.isAutoCloseEnabled = autoClose;

    // Initialize the root object to get Playwright
    final result = await connection.sendMessageToServer('', 'initialize', {
      'sdkLanguage': 'javascript',
    });

    return ChannelOwner.from<Playwright>(
      connection,
      result['playwright'] as Map<String, dynamic>,
    );
  }
}
