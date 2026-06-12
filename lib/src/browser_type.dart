import 'channel_owner.dart';
import 'browser.dart';
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
