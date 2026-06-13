import 'channel_owner.dart';
import 'browser.dart';
import 'browser_context.dart';
import 'driver_downloader.dart';
import 'generated/channels.dart';
import 'worker.dart';
import 'playwright.dart';
import 'connection.dart';
import 'transport.dart';
import 'json_pipe.dart';

/// BrowserType provides methods to launch a specific browser instance or connect to an existing one.
///
/// Playwright dart exposes three browser types: [Playwright.chromium], [Playwright.firefox], and [Playwright.webkit].
class BrowserType extends BrowserTypeBase {
  BrowserType(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  /// Launches a new local browser instance.
  ///
  /// Automatically downloads the browser binary if it is not already installed.
  Future<Browser> launch() async {
    await ensureBrowsersInstalled();
    final result = await super.channel_launch(
      mixinValue: LaunchOptions(timeout: 30000.0),
    );
    return result.browser as Browser;
  }

  /// Launches a browser that uses a persistent local profile directory.
  ///
  /// A persistent context allows cookies, local storage, and caches to be preserved
  /// across sessions.
  Future<BrowserContext> launchPersistentContext(
    String userDataDir, {
    LaunchOptions? launchOptions,
    ContextOptions? contextOptions,
    double? slowMo,
  }) async {
    await ensureBrowsersInstalled();
    final result = await super.channel_launchPersistentContext(
      mixin1Value: launchOptions ?? LaunchOptions(timeout: 30000.0),
      mixin2Value: contextOptions ?? ContextOptions(),
      userDataDir: userDataDir,
      slowMo: slowMo,
    );
    return result.context as BrowserContext;
  }

  // We are missing the Worker wrapper for now, but we can implement the method returning ChannelOwner
  // and type it dynamically for now, or just leave it returning the map.
  // wait, Phase 8 will create the Worker wrapper. Let's assume Worker is created and import it.
  Future<dynamic> connectToWorker(String endpoint, {double? timeout}) async {
    final result = await super.channel_connectToWorker(
      endpoint: endpoint,
      timeout: timeout ?? 30000.0,
    );
    return ChannelOwner.from<Worker>(
      connection,
      result.worker as Map<String, dynamic>,
    );
  }

  /// Connects to a remote Browserless or CDP endpoint.
  ///
  /// This method is highly optimized for interacting with cloud-hosted browsers.
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
  /// Typically used when connecting to an instance launched via `BrowserType.launchServer`.
  Future<Browser> connect(
    String wsEndpoint, {
    Map<String, String>? headers,
    String? exposeNetwork,
    double? slowMo,
    double timeout = 30000.0,
  }) async {
    final playwright = connection.objects.values.whereType<Playwright>().first;

    // The driver connects over websocket and gives us a JsonPipe
    final result = await playwright.utils.channel_connect(
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

    final remotePlaywright = ChannelOwner.from<Playwright>(
      remoteConnection,
      initResult['playwright'] as Map<String, dynamic>,
    );

    final preLaunchedBrowser =
        remotePlaywright.initializer['preLaunchedBrowser'];
    if (preLaunchedBrowser == null) {
      throw Exception(
        'Malformed endpoint. Did you use BrowserType.launchServer method?',
      );
    }

    final browser = ChannelOwner.from<Browser>(
      remoteConnection,
      preLaunchedBrowser as Map<String, dynamic>,
    );

    // When browser is disconnected, close the remote connection
    // For now we just return the browser
    return browser;
  }
}
