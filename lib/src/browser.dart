import 'channel_owner.dart';
import 'browser_context.dart';
import 'page.dart';
import 'generated/channels.dart';
import 'artifact.dart';
import 'stream.dart';

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
    return result.context as BrowserContext;
  }

  Future<void> close({String? reason}) async {
    await channel_close(reason: reason);
  }

  Future<dynamic> newBrowserCDPSession() async {
    final result = await channel_newBrowserCDPSession();
    return ChannelOwner.from(
      connection,
      result.session as Map<String, dynamic>,
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
    final artifact = result.artifact as Artifact;
    final streamResult = await artifact.stream();
    final stream = streamResult.stream as PlaywrightStream;

    final buffer = <int>[];
    while (true) {
      final chunk = await stream.read();
      if (chunk.isEmpty) break;
      buffer.addAll(chunk);
    }
    await artifact.delete();
    return buffer;
  }

  Future<BrowserStartServerResult> startServer({
    required String title,
    String? workspaceDir,
    Map<String, dynamic>? metadata,
    String? host,
    int? port,
  }) async {
    return await channel_startServer(
      title: title,
      workspaceDir: workspaceDir,
      metadata: metadata,
      host: host,
      port: port,
    );
  }

  Future<void> stopServer() async {
    await channel_stopServer();
  }

  Future<void> killForTests() async {
    await channel_killForTests();
  }

  Future<String> defaultUserAgentForTest() async {
    final result = await channel_defaultUserAgentForTest();
    return result.userAgent;
  }

  Future<BrowserContext> newContextForReuse({
    Map<String, dynamic>? proxy,
    Map<String, dynamic>? storageState,
  }) async {
    final result = await channel_newContextForReuse(
      mixin: ContextOptions(),
      proxy: proxy,
      storageState: storageState,
    );
    return result.context as BrowserContext;
  }

  Future<void> disconnectFromReusedContext({String reason = ''}) async {
    await channel_disconnectFromReusedContext(reason: reason);
  }

  Future<Page> newPage() async {
    final context = await newContext();
    return await context.newPage();
  }
}
