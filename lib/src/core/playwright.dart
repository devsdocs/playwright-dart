import '../infrastructure/channel_owner.dart';

import 'browser_type.dart';

import '../infrastructure/local_utils.dart';

import '../generated/channels.dart';

import '../infrastructure/driver.dart';

import '../infrastructure/transport.dart';

import '../infrastructure/connection.dart';

import '../utils/logger.dart';

import '../network/api_request_context.dart';

import '../platform/android.dart';

import '../platform/electron.dart';

import 'selectors.dart';

/// The main Playwright module. Provides access to browser types (Chromium, Firefox, WebKit).

/// Interface for Playwright

abstract interface class Playwright {
  /// Provides access to the Chromium browser type.
  BrowserType get chromium;

  /// Provides access to the Firefox browser type.
  BrowserType get firefox;

  /// Provides access to the WebKit browser type.
  BrowserType get webkit;

  /// Android automation API.
  Android get android;

  /// Electron automation API.
  Electron get electron;

  /// Predefined device descriptors.
  Map<String, Map<String, dynamic>> get devices;

  /// Custom selectors API.
  Selectors get selectors;

  /// Creates a new API request context.
  Future<APIRequestContext> newRequest({
    String? baseURL,

    String? userAgent,

    bool? ignoreHTTPSErrors,

    List<NameValue>? extraHTTPHeaders,

    bool? failOnStatusCode,

    List<PlaywrightNewRequestClientCertificatesItems>? clientCertificates,

    int? maxRedirects,

    PlaywrightNewRequestHttpCredentials? httpCredentials,

    PlaywrightNewRequestProxy? proxy,

    PlaywrightNewRequestStorageState? storageState,

    String? tracesDir,
  });

  /// Stops the Playwright driver and closes the connection.
  Future<void> stop();
}

class PlaywrightImpl extends PlaywrightBase implements Playwright {
  @override
  late final BrowserType chromium;

  @override
  late final BrowserType firefox;

  @override
  late final BrowserType webkit;

  late final LocalUtils utils;

  @override
  late final Selectors selectors;

  @override
  late final Android android;

  @override
  late final Electron electron;

  PlaywrightImpl(
    super.connection,

    super.channelType,

    super.guid,

    super.initializer, [

    super.parent,
  ]) {
    if (initializer['chromium'] != null) {
      chromium = ChannelOwner.from<BrowserTypeImpl>(
        connection,
        initializer['chromium'],
      );
    }

    if (initializer['firefox'] != null) {
      firefox = ChannelOwner.from<BrowserTypeImpl>(
        connection,
        initializer['firefox'],
      );
    }

    if (initializer['webkit'] != null) {
      webkit = ChannelOwner.from<BrowserTypeImpl>(
        connection,
        initializer['webkit'],
      );
    }

    if (initializer['utils'] != null) {
      utils = ChannelOwner.from<LocalUtilsImpl>(
        connection,
        initializer['utils'],
      );
    }

    selectors = Selectors(this);

    if (initializer['android'] != null) {
      android = ChannelOwner.from<AndroidImpl>(
        connection,
        initializer['android'],
      );
    }

    if (initializer['electron'] != null) {
      electron = ChannelOwner.from<ElectronImpl>(
        connection,
        initializer['electron'],
      );
    }
  }

  @override
  Map<String, Map<String, dynamic>> get devices {
    final utilsImpl = utils as LocalUtilsImpl;

    final descriptors = utilsImpl.typedInitializer.deviceDescriptors;

    return {
      for (final item in descriptors)
        item.name: Map<String, dynamic>.from(item.descriptor.toJson()),
    };
  }

  @override
  Future<APIRequestContext> newRequest({
    String? baseURL,

    String? userAgent,

    bool? ignoreHTTPSErrors,

    List<NameValue>? extraHTTPHeaders,

    bool? failOnStatusCode,

    List<PlaywrightNewRequestClientCertificatesItems>? clientCertificates,

    int? maxRedirects,

    PlaywrightNewRequestHttpCredentials? httpCredentials,

    PlaywrightNewRequestProxy? proxy,

    PlaywrightNewRequestStorageState? storageState,

    String? tracesDir,
  }) async {
    Logger.debug(
      'newRequest${baseURL != null ? ' (baseURL: $baseURL)' : ''}',
      name: 'playwright',
    );
    final result = await super.channel.newRequest(
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

  @override
  Future<void> stop() async {
    Logger.info('Stopping Playwright...');
    connection.close();
    Logger.info('Playwright stopped.');
  }
}

class PlaywrightDart {
  /// Launches the background Playwright driver and connects to it, returning the
  /// root [Playwright] API instance.
  ///
  /// [autoClose] — when `true` (default), the driver process shuts down
  /// automatically when the last browser is closed.
  ///
  /// [logLevel] — controls how verbose the logger is. Defaults to
  /// [LogLevel.info] which prints startup/shutdown milestones. Use
  /// [LogLevel.debug] to see navigation and action calls, [LogLevel.trace]
  /// for raw protocol messages, or [LogLevel.none] to silence everything.
  static Future<Playwright> create({
    bool autoClose = true,

    LogLevel logLevel = LogLevel.info,
  }) async {
    Logger.level = logLevel;

    Logger.info('Initializing Playwright Dart...');
    final process = await Driver.run();

    final transport = StdioTransport(process);

    final connection = Connection(transport);

    connection.isAutoCloseEnabled = autoClose;

    final result = await connection.sendMessageToServer('', 'initialize', {
      'sdkLanguage': 'javascript',
    });

    final playwright = ChannelOwner.from<PlaywrightImpl>(
      connection,

      result['playwright'] as Map<String, dynamic>,
    );

    Logger.info('Playwright ready.');
    return playwright;
  }
}
