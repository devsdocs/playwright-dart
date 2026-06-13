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
/// Interface for Browser
abstract interface class Browser {
  Stream<Browser> get onClose;
  Stream<dynamic> get onContext;
  Future<BrowserContext> newContext({
    ContextOptions? options,
    BrowserNewContextProxy? proxy,
    BrowserNewContextStorageState? storageState,
  });
  Future<void> close({String? reason});
  Future<dynamic> newBrowserCDPSession();
  Future<void> startTracing({
    Page? page,
    bool? screenshots,
    List<String>? categories,
  });
  Future<List<int>> stopTracing();
  Future<BrowserStartServerResult> startServer({
    required String title,
    String? workspaceDir,
    Map<String, dynamic>? metadata,
    String? host,
    int? port,
  });
  Future<void> stopServer();
  Future<void> killForTests();
  Future<String> defaultUserAgentForTest();
  Future<BrowserContext> newContextForReuse({
    BrowserNewContextForReuseProxy? proxy,
    BrowserNewContextForReuseStorageState? storageState,
  });
  Future<void> disconnectFromReusedContext({String reason});
  Future<Page> newPage();
}

class BrowserImpl extends BrowserBase implements Browser {
  @override
  Stream<Browser> get onClose {
    return onEvent.where((e) => e['event'] == 'close').map((e) => this);
  }

  @override
  Stream<dynamic> get onContext {
    return onEvent
        .where((e) => e['event'] == 'context')
        .map((e) => e['params']['context']);
  }

  BrowserImpl(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  /// Creates a new browser context.
  ///
  /// It won't share cookies/cache with other browser contexts.
  @override
  Future<BrowserContext> newContext({
    ContextOptions? options,
    BrowserNewContextProxy? proxy,
    BrowserNewContextStorageState? storageState,
  }) async {
    if (proxy != null) {
      options ??= ContextOptions();
    }
    final result = await super.channel_newContext(
      contextOptions: options ?? ContextOptions(),
      proxy: proxy,
      storageState: storageState,
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
  @override
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

  @override
  Future<dynamic> newBrowserCDPSession() async {
    final result = await channel_newBrowserCDPSession();
    return result.session as CDPSession;
  }

  @override
  Future<void> startTracing({
    Page? page,
    bool? screenshots,
    List<String>? categories,
  }) async {
    await channel_startTracing(
      page: page as PageImpl?,
      screenshots: screenshots,
      categories: categories,
    );
  }

  @override
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

  @override
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

  @override
  Future<void> stopServer() async {
    await channel_stopServer();
  }

  @override
  Future<void> killForTests() async {
    await channel_killForTests();
  }

  @override
  Future<String> defaultUserAgentForTest() async {
    final result = await channel_defaultUserAgentForTest();
    return result.userAgent;
  }

  @override
  Future<BrowserContext> newContextForReuse({
    BrowserNewContextForReuseProxy? proxy,
    BrowserNewContextForReuseStorageState? storageState,
  }) async {
    final result = await channel_newContextForReuse(
      contextOptions: ContextOptions(),
      proxy: proxy,
      storageState: storageState,
    );
    return result.context as BrowserContext;
  }

  @override
  Future<void> disconnectFromReusedContext({String reason = ''}) async {
    await channel_disconnectFromReusedContext(reason: reason);
  }

  /// Creates a new page in a new browser context.
  ///
  /// Closing this page will close the context as well.
  @override
  Future<Page> newPage() async {
    final context = await newContext();
    return await context.newPage();
  }
}
