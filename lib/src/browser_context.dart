import 'channel_owner.dart';
import 'page.dart';
import 'generated/channels.dart';

class BrowserContext extends BrowserContextBase {
  BrowserContext(
    super.connection,
    super.type,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  Future<Page> newPage() async {
    final result = await super.channel_newPage();
    return ChannelOwner.from<Page>(connection, result['page']);
  }
}
