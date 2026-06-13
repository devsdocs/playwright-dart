import 'channel_owner.dart';
import 'browser.dart';
import 'browser_context.dart';
import 'driver_downloader.dart';
import 'generated/channels.dart';
import 'worker.dart';

class BrowserType extends BrowserTypeBase {
  BrowserType(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  Future<Browser> launch() async {
    await ensureBrowsersInstalled();
    final result = await super.channel_launch(
      mixin: LaunchOptions(timeout: 30000.0),
    );
    return result.browser as Browser;
  }

  Future<BrowserContext> launchPersistentContext(
    String userDataDir, {
    LaunchOptions? launchOptions,
    ContextOptions? contextOptions,
    double? slowMo,
  }) async {
    await ensureBrowsersInstalled();
    final result = await super.channel_launchPersistentContext(
      mixin1: launchOptions ?? LaunchOptions(timeout: 30000.0),
      mixin2: contextOptions ?? ContextOptions(),
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
}
