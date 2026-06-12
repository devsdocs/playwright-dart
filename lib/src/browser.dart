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

  Future<void> close({String? reason}) async {
    await channel_close(reason: reason);
  }

  Future<dynamic> newBrowserCDPSession() async {
    final result = await channel_newBrowserCDPSession();
    return ChannelOwner.from(
      connection,
      result['session'] as Map<String, dynamic>,
    );
  }

  Future<void> startTracing({
    Page? page,
    bool? screenshots,
    List<String>? categories,
  }) async {
    await channel_startTracing(
      page: page,
      screenshots: screenshots,
      categories: categories,
    );
  }

  Future<List<int>> stopTracing() async {
    final result = await channel_stopTracing();
    return (result['binary'] as String).codeUnits;
  }

  Future<void> startServer() async {
    throw UnimplementedError();
  }

  Future<void> stopServer() async {
    throw UnimplementedError();
  }

  Future<void> killForTests() async {
    throw UnimplementedError();
  }

  Future<String> defaultUserAgentForTest() async {
    throw UnimplementedError();
  }

  Future<dynamic> newContextForReuse(Map<String, dynamic> options) async {
    throw UnimplementedError();
  }

  Future<void> disconnectFromReusedContext() async {
    throw UnimplementedError();
  }

  Future<Page> newPage() async {
    final context = await newContext();
    return await context.newPage();
  }
}
