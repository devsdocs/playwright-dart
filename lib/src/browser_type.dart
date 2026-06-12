import 'channel_owner.dart';
import 'browser.dart';
import 'generated/channels.dart';

class BrowserType extends BrowserTypeBase {
  BrowserType(
    super.connection,
    super.type,
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
}
