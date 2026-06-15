import '../infrastructure/channel_owner.dart';
import 'browser.dart';
import '../infrastructure/local_utils.dart';
import 'browser_context.dart';
import '../infrastructure/driver_downloader.dart';
import '../generated/channels.dart';
import '../utils/worker.dart';
import 'playwright.dart';
import '../infrastructure/connection.dart';
import '../infrastructure/transport.dart';
import '../infrastructure/json_pipe.dart';

/// BrowserType provides methods to launch a specific browser instance or connect to an existing one.
///
/// Playwright dart exposes three browser types: [Playwright.chromium], [Playwright.firefox], and [Playwright.webkit].
/// Interface for BrowserType
abstract interface class BrowserType {
  Future<Browser> launch({LaunchOptions? options, double? slowMo});
  Future<BrowserContext> launchPersistentContext(
    String userDataDir, {
    LaunchOptions? launchOptions,
    ContextOptions? contextOptions,
    double? slowMo,
  });
  Future<Worker> connectToWorker(String endpoint, {double? timeout});
  Future<Browser> connectOverCDP({
    required String endpointURL,
    List<NameValue>? headers,
    bool? isLocal,
    bool? noDefaults,
    double? slowMo,
    double timeout,
  });
  Future<Browser> connect(
    String wsEndpoint, {
    Map<String, String>? headers,
    String? exposeNetwork,
    double? slowMo,
    double timeout,
  });
}

class BrowserTypeImpl extends BrowserTypeBase implements BrowserType {
  BrowserTypeImpl(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  /// Launches a new local browser instance.
  ///
  /// Automatically downloads the browser binary if it is not already installed.
  @override
  Future<Browser> launch({LaunchOptions? options, double? slowMo}) async {
    await ensureBrowsersInstalled();
    final result = await super.channel_launch(
      launchOptions: options ?? LaunchOptions(timeout: 30000.0),
      slowMo: slowMo,
    );
    return result.browser as Browser;
  }

  /// Launches a browser that uses a persistent local profile directory.
  ///
  /// A persistent context allows cookies, local storage, and caches to be preserved
  /// across sessions.
  @override
  Future<BrowserContext> launchPersistentContext(
    String userDataDir, {
    LaunchOptions? launchOptions,
    ContextOptions? contextOptions,
    double? slowMo,
  }) async {
    await ensureBrowsersInstalled();
    final result = await super.channel_launchPersistentContext(
      userDataDir: userDataDir,
      launchOptions: launchOptions ?? LaunchOptions(timeout: 30000.0),
      contextOptions: contextOptions ?? ContextOptions(),
      slowMo: slowMo,
    );
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
    final result = await super.channel_connectOverCDP(
      endpointURL: endpointURL,
      headers: headers,
      isLocal: isLocal,
      noDefaults: noDefaults,
      slowMo: slowMo,
      timeout: timeout,
    );
    return result.browser as Browser;
  }

  /// Connects to a standard Playwright server over WebSockets.
  ///
  /// Typically used when connecting to an instance launched via `BrowserTypeImpl.launchServer`.
  @override
  Future<Browser> connect(
    String wsEndpoint, {
    Map<String, String>? headers,
    String? exposeNetwork,
    double? slowMo,
    double timeout = 30000.0,
  }) async {
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
        remotePlaywright.initializer['preLaunchedBrowser'];
    if (preLaunchedBrowser == null) {
      throw Exception(
        'Malformed endpoint. Did you use BrowserTypeImpl.launchServer method?',
      );
    }

    final browser = ChannelOwner.from<BrowserImpl>(
      remoteConnection,
      preLaunchedBrowser as Map<String, dynamic>,
    );

    // When browser is disconnected, close the remote connection
    // For now we just return the browser
    return browser;
  }
}
