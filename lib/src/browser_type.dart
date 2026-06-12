import 'channel_owner.dart';
import 'browser.dart';
import 'browser_context.dart';
import 'connection.dart';
import 'websocket_transport.dart';
import 'generated/channels.dart';

class BrowserType extends BrowserTypeBase {
  BrowserType(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  Future<Browser> launch() async {
    final result = await super.channel_launch(
      mixin: LaunchOptions(timeout: 30000.0),
    );
    return ChannelOwner.from<Browser>(connection, result['browser']);
  }

  Future<BrowserContext> launchPersistentContext(
    String userDataDir, {
    LaunchOptions? launchOptions,
    ContextOptions? contextOptions,
    double? slowMo,
  }) async {
    final result = await super.channel_launchPersistentContext(
      mixin1: launchOptions ?? LaunchOptions(timeout: 30000.0),
      mixin2: contextOptions ?? ContextOptions(),
      userDataDir: userDataDir,
      slowMo: slowMo,
    );
    return ChannelOwner.from<BrowserContext>(connection, result['context']);
  }

  // We are missing the Worker wrapper for now, but we can implement the method returning ChannelOwner
  // and type it dynamically for now, or just leave it returning the map.
  // wait, Phase 8 will create the Worker wrapper. Let's assume Worker is created and import it.
  Future<dynamic> connectToWorker(String endpoint, {double? timeout}) async {
    final result = await super.channel_connectToWorker(
      endpoint: endpoint,
      timeout: timeout ?? 30000.0,
    );
    // TODO: return Worker once it's implemented
    return result['worker'];
  }

  Future<Browser> connectOverCDP({required String endpointURL}) async {
    final result = await super.channel_connectOverCDP(
      endpointURL: endpointURL,
      timeout: 30000.0,
    );
    return ChannelOwner.from<Browser>(connection, result['browser']);
  }

  Future<Browser> connect(
    String wsEndpoint, {
    Map<String, dynamic>? headers,
    double? timeout,
  }) async {
    final wsTransport = await WebSocketTransport.connect(
      wsEndpoint,
      headers: headers,
    );
    final newConnection = Connection(wsTransport);

    final result = await newConnection.sendMessageToServer('', 'initialize', {
      'sdkLanguage': 'javascript',
    });

    // The server returns a playwright object, which contains a preconnected browser
    final preconnectedBrowser = result['preconnectedBrowser'];
    if (preconnectedBrowser != null) {
      return ChannelOwner.from<Browser>(newConnection, preconnectedBrowser);
    }

    throw Exception(
      'No preconnected browser found on the remote Playwright server.',
    );
  }
}
