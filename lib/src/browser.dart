import 'channel_owner.dart';
import 'browser_context.dart';
import 'page.dart';
import 'generated/channels.dart';

class Browser extends BrowserBase {
  Browser(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  Future<BrowserContext> newContext() async {
    final result = await super.channel_newContext(mixin: ContextOptions());
    return ChannelOwner.from<BrowserContext>(connection, result['context']);
  }

  Future<void> close() async {
    await super.channel_close();
  }

  Future<Page> newPage() async {
    final context = await newContext();
    return await context.newPage();
  }
}
