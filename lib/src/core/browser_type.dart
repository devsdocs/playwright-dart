import 'browser.dart';

import '../infrastructure/channel_owner.dart';

import '../infrastructure/local_utils.dart';

import 'browser_context.dart';

import '../infrastructure/driver_downloader.dart';

import '../generated/channels.dart';

import '../utils/worker.dart';

import 'playwright.dart';

import '../infrastructure/connection.dart';

import '../infrastructure/transport.dart';

import '../infrastructure/json_pipe.dart';

import '../utils/logger.dart';

/// BrowserType provides methods to launch a specific browser instance or connect to an existing one.

///

/// Playwright dart exposes three browser types: [Playwright.chromium], [Playwright.firefox], and [Playwright.webkit].

/// Interface for BrowserType

abstract interface class BrowserType {
  /// The browser type name: `chromium`, `firefox`, or `webkit`.
  String get name;

  /// A path where Playwright expects to find a bundled browser executable.
  String get executablePath;

  /// Launches a new browser instance.
  Future<Browser> launch({LaunchOptions? options, double? slowMo});

  /// Launches a persistent browser context with the given user data directory.
  Future<BrowserContext> launchPersistentContext(
    String userDataDir, {

    LaunchOptions? launchOptions,

    ContextOptions? contextOptions,

    double? slowMo,
  });

  /// Connects to an existing worker.
  Future<Worker> connectToWorker(String endpoint, {double? timeout});

  /// Connects to a browser over Chrome DevTools Protocol.
  Future<Browser> connectOverCDP({
    required String endpointURL,

    List<NameValue>? headers,

    bool? isLocal,

    bool? noDefaults,

    double? slowMo,

    double timeout,
  });

  /// Connects to a browser over WebSocket.
  Future<Browser> connect(
    String wsEndpoint, {

    Map<String, String>? headers,

    String? exposeNetwork,

    double? slowMo,

    double timeout,
  });
}

/// Implementation of the [BrowserType] interface.
class BrowserTypeImpl extends BrowserTypeBase implements BrowserType {
  /// Creates a new browser type instance.
  BrowserTypeImpl(
    super.connection,

    super.channelType,

    super.guid,

    super.initializer, [

    super.parent,
  ]);

  /// The browser type name: `chromium`, `firefox`, or `webkit`.

  @override
  String get name => typedInitializer.name;

  /// A path where Playwright expects to find a bundled browser executable.

  @override
  String get executablePath => typedInitializer.executablePath;

  /// Launches a new local browser instance.

  ///

  /// Automatically downloads the browser binary if it is not already installed.

  @override
  Future<Browser> launch({LaunchOptions? options, double? slowMo}) async {
    await ensureBrowsersInstalled();

    Logger.info('Launching $name browser...');
    final result = await super.channel_launch(
      launchOptions: options ?? LaunchOptions(timeout: 30000.0),

      slowMo: slowMo,
    );

    final browser = result.browser as Browser;
    Logger.info('$name browser launched.');
    return browser;
  }

  @override
  Future<BrowserContext> launchPersistentContext(
    String userDataDir, {

    LaunchOptions? launchOptions,

    ContextOptions? contextOptions,

    double? slowMo,
  }) async {
    await ensureBrowsersInstalled();

    Logger.info('Launching $name persistent context at "$userDataDir"...');
    final result = await super.channel_launchPersistentContext(
      userDataDir: userDataDir,

      launchOptions: launchOptions ?? LaunchOptions(timeout: 30000.0),

      contextOptions: contextOptions ?? ContextOptions(),

      slowMo: slowMo,
    );

    Logger.info('$name persistent context launched.');
    return result.context as BrowserContext;
  }

  // We are missing the Worker wrapper for now, but we can implement the method returning ChannelOwner

  // and type it dynamically for now, or just leave it returning the map.

  // wait, Phase 8 will create the Worker wrapper. Let's assume Worker is created and import it.

  @override
  Future<Worker> connectToWorker(String endpoint, {double? timeout}) async {
    final result = await super.channel_connectToWorker(
      endpoint: endpoint,

      timeout: timeout ?? 30000.0,
    );

    return result.worker as Worker;
  }

  /// Connects to a remote Browserless or CDP endpoint.

  ///

  /// This method is highly optimized for interacting with cloud-hosted browsers.

  @override
  Future<Browser> connectOverCDP({
    required String endpointURL,

    List<NameValue>? headers,

    bool? isLocal,

    bool? noDefaults,

    double? slowMo,

    double timeout = 30000.0,
  }) async {
    Logger.info('Connecting to browser over CDP: $endpointURL');
    final result = await super.channel_connectOverCDP(
      endpointURL: endpointURL,

      headers: headers,

      isLocal: isLocal,

      noDefaults: noDefaults,

      slowMo: slowMo,

      timeout: timeout,
    );

    Logger.info('Connected to browser via CDP.');
    return result.browser as Browser;
  }

  /// Connects to a standard Playwright server over WebSockets.

  ///

  /// Typically used when connecting to an instance launched via `BrowserTypeImpl.launchServer`.

  ///

  /// **Note:** This method is designed for connecting to Playwright servers launched with

  /// `launchServer()`. For remote browser connections via WebSocket (e.g., cloud-hosted browsers),

  /// use [connectOverCDP] instead, as they may not support the Playwright WebSocket protocol.

  @override
  Future<Browser> connect(
    String wsEndpoint, {

    Map<String, String>? headers,

    String? exposeNetwork,

    double? slowMo,

    double timeout = 30000.0,
  }) async {
    Logger.info('Connecting to browser at $wsEndpoint');
    final playwright = connection.objects.values.whereType<Playwright>().first;

    // The driver connects over websocket and gives us a JsonPipe

    final result =
        await ((playwright as PlaywrightImpl).utils as LocalUtilsImpl)
            .channel_connect(
              endpoint: wsEndpoint,

              headers: headers,

              exposeNetwork: exposeNetwork,

              slowMo: slowMo,

              timeout: timeout,
            );

    final pipe = result.pipe as JsonPipe;

    final transport = JsonPipeTransport(pipe);

    final remoteConnection = Connection(transport);

    // Initialize the remote playwright instance

    final initResult = await remoteConnection.sendMessageToServer(
      '',

      'initialize',

      {'sdkLanguage': 'javascript'},
    );

    final remotePlaywright = ChannelOwner.from<PlaywrightImpl>(
      remoteConnection,

      initResult['playwright'] as Map<String, dynamic>,
    );

    final preLaunchedBrowser =
        remotePlaywright.typedInitializer.preLaunchedBrowser;

    if (preLaunchedBrowser == null) {
      throw Exception(
        'Malformed endpoint. Did you use BrowserTypeImpl.launchServer method? '
        'For remote browser connections via WebSocket, use connectOverCDP() instead.',
      );
    }

    final browser = ChannelOwner.from<BrowserImpl>(
      remoteConnection,

      preLaunchedBrowser as Map<String, dynamic>,
    );

    Logger.info('Connected to browser.');
    // When browser is disconnected, close the remote connection

    // For now we just return the browser

    return browser;
  }
}
