import 'browser.dart';
import 'channel_owner.dart';
import 'connection.dart';
import 'websocket_transport.dart';

Future<Browser> connectRemotePlaywright(
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

  final preconnectedBrowser = result['preconnectedBrowser'];
  if (preconnectedBrowser != null) {
    return ChannelOwner.from<Browser>(newConnection, preconnectedBrowser);
  }

  throw Exception(
    'No preconnected browser found on the remote Playwright server.',
  );
}
