import 'browser_context.dart';
import 'cdp_session.dart';
import 'page.dart';
import 'generated/channels.dart';
import 'artifact.dart';
import 'stream.dart';
import 'playwright.dart';

/// A Browser is created via [BrowserType.launch].
///
/// An example of using a Browser to create a Page:
/// ```dart
/// final browser = await playwright.chromium.launch();
/// final page = await browser.newPage();
/// await page.goto('https://example.com');
/// await browser.close();
/// ```
class Browser extends BrowserBase {
  Browser(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  /// Creates a new browser context.
  ///
  /// It won't share cookies/cache with other browser contexts.
  Future<BrowserContext> newContext({ContextOptions? options}) async {
    final result = await super.channel_newContext(
      contextOptions: options ?? ContextOptions(),
    );
    final context = result.context as BrowserContext;
    final playwright =
        connection.objects.values.firstWhere((e) => e is PlaywrightBase)
            as Playwright;
    await playwright.selectors.addContext(context);
    return context;
  }

  /// Closes the browser and all of its pages.
  ///
  /// If [autoClose] was true when initializing Playwright, closing the last
  /// active browser will automatically shut down the underlying driver process.
  Future<void> close({String? reason}) async {
    await channel_close(reason: reason);

    // Auto-shutdown Playwright connection if this was the last active browser.
    // This emulates Node.js unref() behavior where `browser.close()` gracefully exits the application.
    if (connection.isAutoCloseEnabled) {
      try {
        final activeBrowsers = connection.objects.values
            .whereType<Browser>()
            .length;
        if (activeBrowsers <= 1) {
          final playwright = connection.objects.values
              .whereType<Playwright>()
              .firstOrNull;
          if (playwright != null) {
            await playwright.stop();
          }
        }
      } catch (_) {
        // Ignore errors during auto-shutdown
      }
    }
  }

  Future<dynamic> newBrowserCDPSession() async {
    final result = await channel_newBrowserCDPSession();
    return result.session as CDPSession;
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
      contextOptions: ContextOptions(),
      proxy: proxy,
      storageState: storageState,
    );
    return result.context as BrowserContext;
  }

  Future<void> disconnectFromReusedContext({String reason = ''}) async {
    await channel_disconnectFromReusedContext(reason: reason);
  }

  /// Creates a new page in a new browser context.
  ///
  /// Closing this page will close the context as well.
  Future<Page> newPage() async {
    final context = await newContext();
    return await context.newPage();
  }
}
