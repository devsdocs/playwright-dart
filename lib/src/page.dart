import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'browser_context.dart';
import 'generated/channels.dart' as channels;
import 'generated/channels.dart' hide ConsoleMessage;
import 'frame.dart';
import 'locator.dart';
import 'keyboard.dart';
import 'mouse.dart';
import 'touchscreen.dart';
import 'route.dart';
import 'video.dart';
import 'console_message.dart';
import 'file_chooser.dart';
import 'dialog.dart';
import 'worker.dart';
import 'artifact.dart';
import 'route_from_har.dart';
import 'request.dart';
import 'response.dart';
import 'element_handle.dart';

/// Page provides methods to interact with a single tab or extension background page in a browser.
///
/// One Browser instance might have multiple Page instances.
/// Interface for Page
abstract interface class Page {
  Stream<dynamic> get onWebSocketRoute;
  Stream<Map<String, dynamic>> get onScreencastFrame;
  Stream<dynamic> get onRoute;
  Stream<dynamic> get onLocatorHandlerTriggered;
  Stream<dynamic> get onFrameDetached;
  Stream<dynamic> get onFrameAttached;
  Stream<Map<String, dynamic>> get onViewportSizeChanged;
  Stream<dynamic> get onBindingCall;
  Keyboard get keyboard;
  Mouse get mouse;
  Touchscreen get touchscreen;
  BrowserContext get context;
  Frame get mainFrame;
  Stream<ConsoleMessage> get onConsole;
  Stream<FileChooser> get onFileChooser;
  Stream<Dialog> get onDialog;
  Stream<Request> get onRequest;
  Stream<Response> get onResponse;
  Stream<Request> get onRequestFinished;
  Stream<Request> get onRequestFailed;
  Stream<WebSocket> get onWebSocket;
  Stream<Page> get onClose;
  Stream<Page> get onCrash;
  Stream<Exception> get onPageError;
  Video? video();
  Stream<Page> get onPopup;
  Stream<Worker> get onWorker;
  Future<Request> waitForRequest(dynamic urlOrPredicate, {double? timeout});
  Future<Response> waitForResponse(dynamic urlOrPredicate, {double? timeout});
  Future<T> _waitForNetworkEvent<T>(
    Stream<T> stream,
    dynamic urlOrPredicate, {
    double? timeout,
  });
  Stream<Artifact> get onDownload;
  Future<void> goto(
    String url, {
    double? timeout,
    LifecycleEvent? waitUntil,
    String? referer,
  });
  Future<void> waitForLoadState({LifecycleEvent state, double? timeout});
  Future<void> waitForURL(
    dynamic urlOrPredicate, {
    double? timeout,
    LifecycleEvent? waitUntil,
  });
  Future<void> waitForNavigation({
    String? url,
    LifecycleEvent? waitUntil,
    double? timeout,
  });
  Future<String> title();
  Locator locator(String selector);
  Future<dynamic> evaluate(String expression, [dynamic arg]);
  Future<FrameWaitForSelectorResult> waitForSelector(
    String selector, {
    FrameWaitForSelectorStateEnum? state,
    double? timeout,
  });
  Future<void> routeFromHAR(
    String harPath, {
    String? url,
    bool notFoundFallback,
  });
  Future<void> route(String url, Future<void> Function(Route) handler);
  Locator getByText(String text, {bool exact});
  Locator getByRole(String role, {String? name});
  Locator getByLabel(String text, {bool exact});
  Locator getByPlaceholder(String text, {bool exact});
  Locator getByAltText(String text, {bool exact});
  Locator getByTitle(String text, {bool exact});
  Locator getByTestId(String testId);
  Future<void> setViewportSize(PageSetViewportSizeViewportSize viewportSize);
  Future<Uint8List> screenshot({
    String? path,
    bool? fullPage,
    String? type,
    int? quality,
    double? timeout,
    Map<String, dynamic>? clip,
  });
  Future<Uint8List> pdf({
    String? path,
    String? format,
    bool? landscape,
    double? scale,
    bool? displayHeaderFooter,
    String? headerTemplate,
    String? footerTemplate,
    bool? printBackground,
    String? pageRanges,
    dynamic width,
    dynamic height,
    bool? preferCSSPageSize,
    PagePdfMargin? margin,
    bool? tagged,
    bool? outline,
  });
  Future<void> reload({double? timeout, LifecycleEvent? waitUntil});
  Future<void> goBack({double? timeout, LifecycleEvent? waitUntil});
  Future<void> goForward({double? timeout, LifecycleEvent? waitUntil});
  Future<void> addInitScript(String source);
  Future<void> close({bool? runBeforeUnload, String? reason});
  Future<void> emulateMedia({
    PageEmulateMediaMediaEnum? media,
    PageEmulateMediaColorSchemeEnum? colorScheme,
    PageEmulateMediaReducedMotionEnum? reducedMotion,
    PageEmulateMediaForcedColorsEnum? forcedColors,
    PageEmulateMediaContrastEnum? contrast,
  });
  Future<void> click(String selector, {bool? force, double? timeout});
  Future<void> fill(
    String selector,
    String value, {
    bool? force,
    double? timeout,
  });
  Future<void> check(String selector, {bool? force, double? timeout});
  Future<void> uncheck(String selector, {bool? force, double? timeout});
  Future<void> hover(String selector, {bool? force, double? timeout});
  Future<void> focus(String selector, {double? timeout});
  Future<void> blur(String selector, {double? timeout});
  Future<void> dblclick(String selector, {bool? force, double? timeout});
  Future<void> type(
    String selector,
    String text, {
    double? delay,
    double? timeout,
  });
  Future<void> press(
    String selector,
    String key, {
    double? delay,
    double? timeout,
  });
  Future<void> tap(String selector, {bool? force, double? timeout});
  Future<String> content();
  Future<void> setContent(String html, {double? timeout});
  Future<dynamic> evalOnSelector(
    String selector,
    String expression, [
    dynamic arg,
  ]);
  Future<dynamic> evalOnSelectorAll(
    String selector,
    String expression, [
    dynamic arg,
  ]);
  Future<String?> getAttribute(String selector, String name, {double? timeout});
  Future<String> innerHTML(String selector, {double? timeout});
  Future<String> innerText(String selector, {double? timeout});
  Future<String> inputValue(String selector, {double? timeout});
  Future<bool> isChecked(String selector, {double? timeout});
  Future<bool> isDisabled(String selector, {double? timeout});
  Future<bool> isEnabled(String selector, {double? timeout});
  Future<bool> isHidden(String selector);
  Future<bool> isVisible(String selector);
  Future<bool> isEditable(String selector, {double? timeout});
  Future<void> addScriptTag({String? url, String? content, String? type});
  Future<void> addStyleTag({String? url, String? content});
  Future<void> waitForTimeout(double timeout);
  Future<dynamic> waitForFunction(
    String expression, [
    dynamic arg,
    double? timeout,
    double? pollingInterval,
  ]);
  Future<void> dispatchEvent(
    String selector,
    String type, {
    dynamic eventInit,
    double? timeout,
  });
  Future<void> highlight(String selector);
  Future<void> hideHighlight();
  Future<void> drop(
    String selector, {
    List<FrameDropPayloadsItems>? payloads,
    List<String>? localPaths,
    List<FrameDropDataItems>? data,
    bool? strict,
    double? timeout,
  });
  Locator querySelector(String selector);
  Future<List<Locator>> querySelectorAll(String selector);
  Future<int> queryCount(String selector);
  Future<List<String>> selectOption(
    String selector,
    dynamic values, {
    bool? force,
    double? timeout,
  });
  Future<void> setInputFiles(
    String selector,
    dynamic files, {
    bool? noWaitAfter,
    double? timeout,
  });
  Future<FrameAriaSnapshotResult> ariaSnapshot(
    String selector, {
    String? mode,
    String? track,
    int? depth,
    bool? boxes,
    double? timeout,
  });
  Future<FrameExpectResult> expect(
    String selector,
    String expression, {
    SerializedArgument? expectedValue,
    List<ExpectedTextValue>? expectedText,
    double? expectedNumber,
    bool? useInnerText,
    required bool isNot,
    double? timeout,
  });
  Future<void> exposeBinding(String name);
  Future<void> requestGC();
  Future<PageRegisterLocatorHandlerResult> registerLocatorHandler(
    Locator selector, {
    bool? noWaitAfter,
  });
  Future<void> unregisterLocatorHandler(int uid);
  Future<void> setExtraHTTPHeaders(List<NameValue> headers);
  Future<void> setNetworkInterceptionPatterns(
    List<PageSetNetworkInterceptionPatternsPatternsItems> patterns,
  );
  Future<void> touchscreenTap(double x, double y);
  Future<void> bringToFront();
  Future<PagePickLocatorResult> pickLocator();
  Future<void> cancelPickLocator();
  Future<void> screencastStart({
    PageScreencastStartSize? size,
    int? quality,
    bool? sendFrames,
    bool? record,
  });
  Future<void> screencastStop();
  Future<void> setDockTile(String image);
  Future<void> clearConsoleMessages();
  Future<PageConsoleMessagesResult> consoleMessages({
    ConsoleMessagesFilter? filter,
  });
  Future<void> clearPageErrors();
  Future<PagePageErrorsResult> pageErrors({ConsoleMessagesFilter? filter});
  Future<PageRequestsResult> requests();
  Future<void> resolveLocatorHandlerNoReply(int uid, {bool? remove});
  Future<PageExpectScreenshotResult> expectScreenshot({
    String? expected,
    required double timeout,
    required bool isNot,
    PageExpectScreenshotLocator? locator,
    String? comparator,
    int? maxDiffPixels,
    double? maxDiffPixelRatio,
    double? threshold,
    bool? fullPage,
    Rect? clip,
    required CommonScreenshotOptions screenshotOptions,
  });
  Future<void> setWebSocketInterceptionPatterns(
    List<PageSetWebSocketInterceptionPatternsPatternsItems> patterns,
  );
  Future<void> startJSCoverage({
    bool? resetOnNavigation,
    bool? reportAnonymousScripts,
  });
  Future<PageStopJSCoverageResult> stopJSCoverage();
  Future<void> startCSSCoverage({bool? resetOnNavigation});
  Future<PageStopCSSCoverageResult> stopCSSCoverage();
  Future<PageScreencastShowOverlayResult> screencastShowOverlay(
    String html, {
    double? duration,
  });
  Future<void> screencastRemoveOverlay(String id);
  Future<void> screencastChapter(
    String title, {
    String? description,
    double? duration,
  });
  Future<void> screencastSetOverlayVisible(bool visible);
  Future<void> screencastShowActions(ShowActionsOptions options);
  Future<void> screencastHideActions();
  Future<void> updateSubscription({
    required PageUpdateSubscriptionEventEnum event,
    required bool enabled,
  });
}

class PageImpl extends PageBase implements Page {
  @override
  Stream<dynamic> get onWebSocketRoute {
    return onEvent
        .where((e) => e['event'] == 'webSocketRoute')
        .map((e) => e['params']['webSocketRoute']);
  }

  @override
  Stream<Map<String, dynamic>> get onScreencastFrame {
    return onEvent
        .where((e) => e['event'] == 'screencastFrame')
        .map((e) => e['params']);
  }

  @override
  Stream<dynamic> get onRoute {
    return onEvent
        .where((e) => e['event'] == 'route')
        .map((e) => e['params']['route']);
  }

  @override
  Stream<dynamic> get onLocatorHandlerTriggered {
    return onEvent
        .where((e) => e['event'] == 'locatorHandlerTriggered')
        .map((e) => e['params']['uid']);
  }

  @override
  Stream<dynamic> get onFrameDetached {
    return onEvent
        .where((e) => e['event'] == 'frameDetached')
        .map((e) => e['params']['frame']);
  }

  @override
  Stream<dynamic> get onFrameAttached {
    return onEvent
        .where((e) => e['event'] == 'frameAttached')
        .map((e) => e['params']['frame']);
  }

  @override
  Stream<Map<String, dynamic>> get onViewportSizeChanged {
    return onEvent
        .where((e) => e['event'] == 'viewportSizeChanged')
        .map((e) => e['params']['viewportSize']);
  }

  @override
  Stream<dynamic> get onBindingCall {
    return onEvent
        .where((e) => e['event'] == 'bindingCall')
        .map((e) => e['params']['binding']);
  }

  @override
  late final Keyboard keyboard;
  @override
  late final Mouse mouse;
  @override
  late final Touchscreen touchscreen;

  PageImpl(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]) {
    keyboard = Keyboard(this);
    mouse = Mouse(this);
    touchscreen = Touchscreen(this);
  }

  /// The browser context that the page belongs to.
  @override
  BrowserContext get context => parent as BrowserContext;

  String get _mainFrameGuid => initializer['mainFrame']['guid'];

  /// The page's main frame. Page is guaranteed to have a main frame which
  /// persists during navigations.
  @override
  Frame get mainFrame => connection.objects[_mainFrameGuid] as Frame;

  /// Emitted when a console message is received from the page.
  @override
  Stream<ConsoleMessage> get onConsole {
    channel_updateSubscription(
      enabled: true,
      event: PageUpdateSubscriptionEventEnum.console,
    );
    return (context as BrowserContextImpl).onEvent
        .where(
          (e) =>
              e['event'] == 'console' &&
              e['params']['page'] != null &&
              e['params']['page']['guid'] == guid,
        )
        .map((e) {
          final message = channels.ConsoleMessage.fromJson(
            e['params'],
            connection: connection,
          );
          return ConsoleMessage(this, message);
        });
  }

  /// Emitted when a file chooser is supposed to appear, such as after clicking
  /// an `<input type=file>` element.
  @override
  Stream<FileChooser> get onFileChooser {
    channel_updateSubscription(
      enabled: true,
      event: PageUpdateSubscriptionEventEnum.fileChooser,
    );
    return onEvent.where((e) => e['event'] == 'fileChooser').map((e) {
      final elementGuid = e['params']['element']['guid'];
      final element = connection.objects[elementGuid] as ElementHandle;
      final isMultiple = e['params']['isMultiple'] as bool;
      return FileChooser(this, element, isMultiple);
    });
  }

  /// Emitted when a JavaScript dialog appears, such as `alert`, `prompt`,
  /// `confirm` or `beforeunload`.
  @override
  Stream<Dialog> get onDialog {
    channel_updateSubscription(
      enabled: true,
      event: PageUpdateSubscriptionEventEnum.dialog,
    );
    return onEvent.where((e) => e['event'] == 'dialog').map((e) {
      final dialogGuid = e['params']['dialog']['guid'];
      return connection.objects[dialogGuid] as Dialog;
    });
  }

  /// Emitted when a page issues a request.
  @override
  Stream<Request> get onRequest {
    channel_updateSubscription(
      enabled: true,
      event: PageUpdateSubscriptionEventEnum.request,
    );
    return (context as BrowserContextImpl).onEvent
        .where(
          (e) =>
              e['event'] == 'request' &&
              e['params']['page'] != null &&
              e['params']['page']['guid'] == guid,
        )
        .map((e) {
          final requestGuid = e['params']['request']['guid'];
          return connection.objects[requestGuid] as Request;
        });
  }

  /// Emitted when a response is received.
  @override
  Stream<Response> get onResponse {
    channel_updateSubscription(
      enabled: true,
      event: PageUpdateSubscriptionEventEnum.response,
    );
    return (context as BrowserContextImpl).onEvent
        .where(
          (e) =>
              e['event'] == 'response' &&
              e['params']['page'] != null &&
              e['params']['page']['guid'] == guid,
        )
        .map((e) {
          final responseGuid = e['params']['response']['guid'];
          return connection.objects[responseGuid] as Response;
        });
  }

  /// Emitted when a request finishes successfully.
  @override
  Stream<Request> get onRequestFinished {
    channel_updateSubscription(
      enabled: true,
      event: PageUpdateSubscriptionEventEnum.requestFinished,
    );
    return (context as BrowserContextImpl).onEvent
        .where((e) => e['event'] == 'requestFinished')
        .map((e) {
          final requestGuid = e['params']['request']['guid'];
          return connection.objects[requestGuid] as Request;
        })
        .where((request) => request.frame.page == this);
  }

  /// Emitted when a request fails.
  @override
  Stream<Request> get onRequestFailed {
    channel_updateSubscription(
      enabled: true,
      event: PageUpdateSubscriptionEventEnum.requestFailed,
    );
    return (context as BrowserContextImpl).onEvent
        .where(
          (e) =>
              e['event'] == 'requestFailed' &&
              e['params']['page'] != null &&
              e['params']['page']['guid'] == guid,
        )
        .map((e) {
          final requestGuid = e['params']['request']['guid'];
          return connection.objects[requestGuid] as Request;
        });
  }

  /// Emitted when a [WebSocket] request is issued.
  @override
  Stream<WebSocket> get onWebSocket {
    return onEvent.where((e) => e['event'] == 'webSocket').map((e) {
      final guid = e['params']['webSocket']['guid'];
      return connection.objects[guid] as WebSocket;
    });
  }

  /// Emitted when the page closes.
  @override
  Stream<Page> get onClose {
    return onEvent.where((e) => e['event'] == 'close').map((e) => this);
  }

  /// Emitted when the page crashes. Browser pages might crash if they try to
  /// allocate too much memory.
  @override
  Stream<Page> get onCrash {
    return onEvent.where((e) => e['event'] == 'crash').map((e) => this);
  }

  /// Emitted when an uncaught exception happens within the page.
  @override
  Stream<Exception> get onPageError {
    return (context as BrowserContextImpl).onEvent
        .where(
          (e) =>
              e['event'] == 'pageError' &&
              e['params']['page'] != null &&
              e['params']['page']['guid'] == guid,
        )
        .map((e) {
          final errorPayload = e['params']['error']['error'];
          return Exception(errorPayload['message']);
        });
  }

  /// Returns the [Video] object associated with this page, or `null` if video
  /// recording was not started.
  @override
  Video? video() {
    final videoInitializer = initializer['video'];
    if (videoInitializer == null) return null;
    final artifactGuid = videoInitializer['guid'];
    final artifact = connection.objects[artifactGuid] as Artifact;
    return Video(this, artifact);
  }

  /// Emitted when the page opens a new tab or window.
  @override
  Stream<Page> get onPopup {
    return onEvent.where((e) => e['event'] == 'popup').map((e) {
      final guid = e['params']['page']['guid'];
      return connection.objects[guid] as Page;
    });
  }

  /// Emitted when a dedicated [WebWorker](https://developer.mozilla.org/en-US/docs/Web/API/Web_Workers_API)
  /// is spawned by the page.
  @override
  Stream<Worker> get onWorker {
    return onEvent.where((e) => e['event'] == 'worker').map((e) {
      final workerGuid = e['params']['worker']['guid'];
      return connection.objects[workerGuid] as Worker;
    });
  }

  /// Waits for the matching request and returns it.
  @override
  Future<Request> waitForRequest(
    dynamic urlOrPredicate, {
    double? timeout,
  }) async {
    return await _waitForNetworkEvent(
      onRequest,
      urlOrPredicate,
      timeout: timeout,
    );
  }

  /// Waits for the matching response and returns it.
  @override
  Future<Response> waitForResponse(
    dynamic urlOrPredicate, {
    double? timeout,
  }) async {
    return await _waitForNetworkEvent(
      onResponse,
      urlOrPredicate,
      timeout: timeout,
    );
  }

  @override
  Future<T> _waitForNetworkEvent<T>(
    Stream<T> stream,
    dynamic urlOrPredicate, {
    double? timeout,
  }) async {
    final timeoutDuration = Duration(milliseconds: timeout?.toInt() ?? 30000);
    return await stream
        .firstWhere((event) {
          final url = (event as dynamic).url as String;
          if (urlOrPredicate is String) {
            return url.contains(urlOrPredicate) ||
                RegExp(urlOrPredicate).hasMatch(url);
          } else if (urlOrPredicate is RegExp) {
            return urlOrPredicate.hasMatch(url);
          } else if (urlOrPredicate is bool Function(T)) {
            return urlOrPredicate(event);
          }
          return false;
        })
        .timeout(
          timeoutDuration,
          onTimeout: () => throw Exception(
            'Timeout ${timeoutDuration.inMilliseconds}ms exceeded',
          ),
        );
  }

  /// Emitted when an attachment download is triggered, returning the [Artifact]
  /// representing the downloaded file.
  @override
  Stream<Artifact> get onDownload {
    return onEvent.where((e) => e['event'] == 'download').map((e) {
      final artifactGuid = e['params']['artifact']['guid'];
      return connection.objects[artifactGuid] as Artifact;
    });
  }

  /// Returns the main resource response. In case of multiple redirects, the navigation will resolve with the response of the
  /// last redirect.
  ///
  /// `url` - URL to navigate page to. The url should include scheme, e.g. `https://`.
  @override
  Future<void> goto(
    String url, {
    double? timeout,
    LifecycleEvent? waitUntil,
    String? referer,
  }) async {
    await mainFrame.goto(
      url,
      timeout: timeout,
      waitUntil: waitUntil,
      referer: referer,
    );
  }

  /// Waits for the required load state to be reached.
  @override
  Future<void> waitForLoadState({
    LifecycleEvent state = LifecycleEvent.load,
    double? timeout,
  }) async {
    await mainFrame.waitForLoadState(state: state, timeout: timeout);
  }

  /// Waits for the main frame to navigate to the given URL.
  @override
  Future<void> waitForURL(
    dynamic urlOrPredicate, {
    double? timeout,
    LifecycleEvent? waitUntil,
  }) async {
    await mainFrame.waitForURL(
      urlOrPredicate,
      timeout: timeout,
      waitUntil: waitUntil,
    );
  }

  /// Waits for navigation to complete.
  @override
  Future<void> waitForNavigation({
    String? url,
    LifecycleEvent? waitUntil,
    double? timeout,
  }) async {
    await mainFrame.waitForNavigation(
      url: url,
      waitUntil: waitUntil,
      timeout: timeout,
    );
  }

  /// Returns the page's title.
  @override
  Future<String> title() async {
    final result = await connection.sendMessageToServer(
      _mainFrameGuid,
      'title',
      {},
    );
    return result['value'] as String;
  }

  /// The method returns an element locator that can be used to perform actions on this page/frame.
  /// Locator is resolved to the element immediately before performing an action, so a series of actions on the same locator can in fact be performed on different DOM elements.
  @override
  Locator locator(String selector) {
    return mainFrame.locator(selector);
  }

  /// Returns the value of the `expression` invocation.
  ///
  /// If the function passed to the `page.evaluate` returns a Promise, then `page.evaluate` would wait for the promise to resolve and return its value.
  /// If the function passed to the `page.evaluate` returns a non-Serializable value, then `page.evaluate` resolves to `undefined`.
  @override
  Future<dynamic> evaluate(String expression, [dynamic arg]) async {
    return mainFrame.evaluate(expression, arg);
  }

  /// Returns when element specified by selector satisfies [state] option.
  ///
  /// Resolves to `null` if waiting for `hidden` or `detached`.
  @override
  Future<FrameWaitForSelectorResult> waitForSelector(
    String selector, {
    FrameWaitForSelectorStateEnum? state,
    double? timeout,
  }) async {
    return mainFrame.waitForSelector(selector, state: state, timeout: timeout);
  }

  /// Routing provides the capability to modify network requests that are made by a page.
  ///
  /// Once routing is enabled, every request matching the url pattern will stall unless it's continued, fulfilled or aborted.
  /// Serves all requests matching the given [url] from the HAR file.
  @override
  Future<void> routeFromHAR(
    String harPath, {
    String? url,
    bool notFoundFallback = false,
  }) async {
    await sharedRouteFromHAR(
      this,
      harPath,
      url: url,
      notFoundFallback: notFoundFallback,
    );
  }

  /// Routing provides the capability to modify network requests that are made by a page.
  ///
  /// Once routing is enabled, every request matching the url pattern will stall
  /// unless it's continued, fulfilled or aborted.
  @override
  Future<void> route(String url, Future<void> Function(Route) handler) async {
    await channel_setNetworkInterceptionPatterns(
      patterns: [
        PageSetNetworkInterceptionPatternsPatternsItems.fromJson({'glob': url}),
      ],
    );

    onEvent.listen((event) async {
      if (event['event'] == 'route') {
        final params = event['params'] as Map<String, dynamic>;
        final routeObj = connection.objects[params['route']['guid']] as Route;
        final requestObj = routeObj.request;

        final matches = url == '**/*' || url == '*' || url.contains('*')
            ? true
            : requestObj.url == url;
        if (matches) {
          try {
            await handler(routeObj);
          } catch (e) {
            // Ignore if closed
          }
        } else {
          try {
            await routeObj.continueRoute();
          } catch (e) {
            // Ignore if closed
          }
        }
      }
    });
  }

  /// Allows locating elements that contain given text.
  @override
  Locator getByText(String text, {bool exact = false}) {
    if (exact) {
      return locator('internal:text="$text"');
    }
    // Substring match
    return locator('internal:text=$text');
  }

  /// Allows locating elements by their ARIA role, ARIA attributes and accessible name.
  @override
  Locator getByRole(String role, {String? name}) {
    var selector = 'internal:role=$role';
    if (name != null) {
      selector +=
          '[name="$name"i]'; // Case-insensitive matching by default in intro
    }
    return locator(selector);
  }

  /// Allows locating input elements by the text of the associated `<label>` or
  /// `aria-labelledby` element, or by the `aria-label` attribute.
  @override
  Locator getByLabel(String text, {bool exact = false}) {
    return exact
        ? locator('internal:label="$text"')
        : locator('internal:label=$text');
  }

  /// Allows locating input elements by the placeholder text.
  @override
  Locator getByPlaceholder(String text, {bool exact = false}) {
    return exact
        ? locator('internal:attr=[placeholder="$text"]')
        : locator('internal:attr=[placeholder="$text"i]');
  }

  /// Allows locating elements by their alt text.
  @override
  Locator getByAltText(String text, {bool exact = false}) {
    return exact
        ? locator('internal:attr=[alt="$text"]')
        : locator('internal:attr=[alt="$text"i]');
  }

  /// Allows locating elements by their title attribute.
  @override
  Locator getByTitle(String text, {bool exact = false}) {
    return exact
        ? locator('internal:attr=[title="$text"]')
        : locator('internal:attr=[title="$text"i]');
  }

  /// Locate element by the test id.
  @override
  Locator getByTestId(String testId) {
    return locator('internal:testid=[data-testid="$testId"]');
  }

  /// In the case of multiple pages in a single browser, each page can have its
  /// own viewport size. However, [Browser.newContext] allows to set viewport
  /// size (and more) for all pages in the context at once.
  @override
  Future<void> setViewportSize(
    PageSetViewportSizeViewportSize viewportSize,
  ) async {
    await channel_setViewportSize(viewportSize: viewportSize);
  }

  /// Returns the buffer with the captured screenshot.
  @override
  Future<Uint8List> screenshot({
    String? path,
    bool? fullPage,
    String? type,
    int? quality,
    double? timeout,
    Map<String, dynamic>? clip,
  }) async {
    final result = await channel_screenshot(
      timeout: timeout ?? 30000.0,
      type: type != null
          ? PageScreenshotTypeEnum.values.firstWhere((e) => e.value == type)
          : null,
      quality: quality,
      fullPage: fullPage,
      clip: clip != null ? Rect.fromJson(clip) : null,
      commonScreenshotOptions: CommonScreenshotOptions(),
    );
    final buffer = base64Decode(result.binary);
    if (path != null) {
      await File(path).writeAsBytes(buffer);
    }
    return buffer;
  }

  /// Returns the PDF buffer.
  ///
  /// `path` - The file path to save the PDF to. If `path` is a relative path, then it is resolved relative to the current working directory.
  @override
  Future<Uint8List> pdf({
    String? path,
    String? format,
    bool? landscape,
    double? scale,
    bool? displayHeaderFooter,
    String? headerTemplate,
    String? footerTemplate,
    bool? printBackground,
    String? pageRanges,
    dynamic width,
    dynamic height,
    bool? preferCSSPageSize,
    PagePdfMargin? margin,
    bool? tagged,
    bool? outline,
  }) async {
    final result = await channel_pdf(
      format: format,
      landscape: landscape,
      scale: scale,
      displayHeaderFooter: displayHeaderFooter,
      headerTemplate: headerTemplate,
      footerTemplate: footerTemplate,
      printBackground: printBackground,
      pageRanges: pageRanges,
      width: width,
      height: height,
      preferCSSPageSize: preferCSSPageSize,
      margin: margin,
      tagged: tagged,
      outline: outline,
    );
    final buffer = base64Decode(result.pdf);
    if (path != null) {
      await File(path).writeAsBytes(buffer);
    }
    return buffer;
  }

  /// Reloads the current page.
  @override
  Future<void> reload({double? timeout, LifecycleEvent? waitUntil}) async {
    await channel_reload(
      timeout: timeout ?? 30000.0,
      waitUntil: waitUntil ?? LifecycleEvent.load,
    );
  }

  /// Navigate to the previous page in history.
  @override
  Future<void> goBack({double? timeout, LifecycleEvent? waitUntil}) async {
    await channel_goBack(
      timeout: timeout ?? 30000.0,
      waitUntil: waitUntil ?? LifecycleEvent.load,
    );
  }

  /// Navigate to the next page in history.
  @override
  Future<void> goForward({double? timeout, LifecycleEvent? waitUntil}) async {
    await channel_goForward(
      timeout: timeout ?? 30000.0,
      waitUntil: waitUntil ?? LifecycleEvent.load,
    );
  }

  /// Adds a script which would be evaluated in one of the following scenarios:
  ///
  /// - Whenever the page is navigated.
  /// - Whenever the child frame is attached or navigated.
  @override
  Future<void> addInitScript(String source) async {
    await channel_addInitScript(source: source);
  }

  /// Closes the page.
  ///
  /// If `runBeforeUnload` is `true`, a `beforeunload` dialog might be summoned and should be handled manually via `page.onDialog`.
  @override
  Future<void> close({bool? runBeforeUnload, String? reason}) async {
    await channel_close(runBeforeUnload: runBeforeUnload, reason: reason);
  }

  /// This method changes the CSS `media` type through the `media` argument, and/or
  /// the `prefers-color-scheme`, `prefers-reduced-motion`, `forced-colors`, and
  /// `contrast` media features.
  @override
  Future<void> emulateMedia({
    PageEmulateMediaMediaEnum? media,
    PageEmulateMediaColorSchemeEnum? colorScheme,
    PageEmulateMediaReducedMotionEnum? reducedMotion,
    PageEmulateMediaForcedColorsEnum? forcedColors,
    PageEmulateMediaContrastEnum? contrast,
  }) async {
    await channel_emulateMedia(
      media: media,
      colorScheme: colorScheme,
      reducedMotion: reducedMotion,
      forcedColors: forcedColors,
      contrast: contrast,
    );
  }

  // --- Frame proxies ---

  /// Clicks an element matching [selector].
  @override
  Future<void> click(String selector, {bool? force, double? timeout}) {
    return mainFrame.click(selector, force: force, timeout: timeout);
  }

  /// Fills an `<input>`, `<textarea>` or `[contenteditable]` element with [value].
  @override
  Future<void> fill(
    String selector,
    String value, {
    bool? force,
    double? timeout,
  }) {
    return mainFrame.fill(selector, value, force: force, timeout: timeout);
  }

  /// Checks an element matching [selector] by performing the following steps:
  /// scrolling into view, clicking, and verifying it is checked.
  @override
  Future<void> check(String selector, {bool? force, double? timeout}) {
    return mainFrame.check(selector, force: force, timeout: timeout);
  }

  /// Unchecks an element matching [selector].
  @override
  Future<void> uncheck(String selector, {bool? force, double? timeout}) {
    return mainFrame.uncheck(selector, force: force, timeout: timeout);
  }

  /// Hovers over an element matching [selector].
  @override
  Future<void> hover(String selector, {bool? force, double? timeout}) {
    return mainFrame.hover(selector, force: force, timeout: timeout);
  }

  /// Focuses the element matching [selector].
  @override
  Future<void> focus(String selector, {double? timeout}) {
    return mainFrame.focus(selector, timeout: timeout);
  }

  /// Removes keyboard focus from the element matching [selector].
  @override
  Future<void> blur(String selector, {double? timeout}) {
    return mainFrame.blur(selector, timeout: timeout);
  }

  /// Double-clicks an element matching [selector].
  @override
  Future<void> dblclick(String selector, {bool? force, double? timeout}) {
    return mainFrame.dblclick(selector, force: force, timeout: timeout);
  }

  /// Sends a `keydown`, `keypress`/`input`, and `keyup` event for each character in the text.
  @override
  Future<void> type(
    String selector,
    String text, {
    double? delay,
    double? timeout,
  }) {
    return mainFrame.type(selector, text, delay: delay, timeout: timeout);
  }

  /// Focuses the element matching [selector], and then uses [Keyboard.down] and [Keyboard.up].
  @override
  Future<void> press(
    String selector,
    String key, {
    double? delay,
    double? timeout,
  }) {
    return mainFrame.press(selector, key, delay: delay, timeout: timeout);
  }

  /// Taps an element matching [selector].
  @override
  Future<void> tap(String selector, {bool? force, double? timeout}) {
    return mainFrame.tap(selector, force: force, timeout: timeout);
  }

  /// Gets the full HTML contents of the page, including the doctype.
  @override
  Future<String> content() {
    return mainFrame.content();
  }

  /// Sets the HTML content of the page.
  @override
  Future<void> setContent(String html, {double? timeout}) {
    return mainFrame.setContent(html, timeout: timeout);
  }

  /// Finds an element matching [selector] within the page, and passes it as
  /// the first argument to [expression].
  @override
  Future<dynamic> evalOnSelector(
    String selector,
    String expression, [
    dynamic arg,
  ]) {
    return mainFrame.evalOnSelector(selector, expression, arg);
  }

  /// Finds all elements matching [selector] within the page, and passes the
  /// array of matched elements as the first argument to [expression].
  @override
  Future<dynamic> evalOnSelectorAll(
    String selector,
    String expression, [
    dynamic arg,
  ]) {
    return mainFrame.evalOnSelectorAll(selector, expression, arg);
  }

  /// Returns element attribute value.
  @override
  Future<String?> getAttribute(
    String selector,
    String name, {
    double? timeout,
  }) {
    return mainFrame.getAttribute(selector, name, timeout: timeout);
  }

  /// Returns `element.innerHTML`.
  @override
  Future<String> innerHTML(String selector, {double? timeout}) {
    return mainFrame.innerHTML(selector, timeout: timeout);
  }

  /// Returns `element.innerText`.
  @override
  Future<String> innerText(String selector, {double? timeout}) {
    return mainFrame.innerText(selector, timeout: timeout);
  }

  /// Returns `input.value` for the selected `<input>`, `<textarea>` or `<select>` element.
  @override
  Future<String> inputValue(String selector, {double? timeout}) {
    return mainFrame.inputValue(selector, timeout: timeout);
  }

  /// Returns whether the element is checked. Throws if the element is not a checkbox or radio input.
  @override
  Future<bool> isChecked(String selector, {double? timeout}) {
    return mainFrame.isChecked(selector, timeout: timeout);
  }

  /// Returns whether the element is disabled.
  @override
  Future<bool> isDisabled(String selector, {double? timeout}) {
    return mainFrame.isDisabled(selector, timeout: timeout);
  }

  /// Returns whether the element is enabled.
  @override
  Future<bool> isEnabled(String selector, {double? timeout}) {
    return mainFrame.isEnabled(selector, timeout: timeout);
  }

  /// Returns whether the element is hidden.
  @override
  Future<bool> isHidden(String selector) {
    return mainFrame.isHidden(selector);
  }

  /// Returns whether the element is visible.
  @override
  Future<bool> isVisible(String selector) {
    return mainFrame.isVisible(selector);
  }

  /// Returns whether the element is editable.
  @override
  Future<bool> isEditable(String selector, {double? timeout}) {
    return mainFrame.isEditable(selector, timeout: timeout);
  }

  /// Adds a `<script>` tag into the page with the desired URL or content.
  @override
  Future<void> addScriptTag({String? url, String? content, String? type}) {
    return mainFrame.addScriptTag(url: url, content: content, type: type);
  }

  /// Adds a `<link rel="stylesheet">` tag into the page with the desired URL or a `<style type="text/css">` tag with the content.
  @override
  Future<void> addStyleTag({String? url, String? content}) {
    return mainFrame.addStyleTag(url: url, content: content);
  }

  /// Waits for the given [timeout] in milliseconds.
  @override
  Future<void> waitForTimeout(double timeout) {
    return mainFrame.waitForTimeout(timeout);
  }

  /// Returns when the [expression] returns a truthy value, polling at regular intervals.
  @override
  Future<dynamic> waitForFunction(
    String expression, [
    dynamic arg,
    double? timeout,
    double? pollingInterval,
  ]) {
    return mainFrame.waitForFunction(
      expression,
      arg: arg,
      timeout: timeout,
      pollingInterval: pollingInterval,
    );
  }

  /// Dispatches a [type] event on the element matching [selector].
  @override
  Future<void> dispatchEvent(
    String selector,
    String type, {
    dynamic eventInit,
    double? timeout,
  }) {
    return mainFrame.dispatchEvent(
      selector,
      type,
      eventInit: eventInit,
      timeout: timeout,
    );
  }

  /// Highlights the element(s) matching [selector] in the page.
  @override
  Future<void> highlight(String selector) {
    return mainFrame.highlight(selector);
  }

  /// Removes all highlights created by [highlight].
  @override
  Future<void> hideHighlight() async {
    await channel_hideHighlight();
  }

  /// Performs a drag-and-drop of files onto an element matching [selector].
  @override
  Future<void> drop(
    String selector, {
    List<FrameDropPayloadsItems>? payloads,
    List<String>? localPaths,
    List<FrameDropDataItems>? data,
    bool? strict,
    double? timeout,
  }) {
    return mainFrame.drop(
      selector,
      payloads: payloads,
      localPaths: localPaths,
      data: data,
      strict: strict,
      timeout: timeout,
    );
  }

  /// Returns a [Locator] for the first element matching [selector].
  @override
  Locator querySelector(String selector) {
    return mainFrame.querySelector(selector);
  }

  /// Returns a list of [Locator]s for all elements matching [selector].
  @override
  Future<List<Locator>> querySelectorAll(String selector) {
    return mainFrame.querySelectorAll(selector);
  }

  /// Returns the number of elements matching [selector].
  @override
  Future<int> queryCount(String selector) {
    return mainFrame.queryCount(selector);
  }

  /// Returns the array of option values that have been successfully selected.
  @override
  Future<List<String>> selectOption(
    String selector,
    dynamic values, {
    bool? force,
    double? timeout,
  }) {
    return mainFrame.selectOption(
      selector,
      values,
      force: force,
      timeout: timeout,
    );
  }

  /// Sets the value of the file input to these file paths or files.
  @override
  Future<void> setInputFiles(
    String selector,
    dynamic files, {
    bool? noWaitAfter,
    double? timeout,
  }) {
    return mainFrame.setInputFiles(
      selector,
      files,
      noWaitAfter: noWaitAfter,
      timeout: timeout,
    );
  }

  /// Captures the accessibility tree snapshot of the element matching [selector].
  @override
  Future<FrameAriaSnapshotResult> ariaSnapshot(
    String selector, {
    String? mode,
    String? track,
    int? depth,
    bool? boxes,
    double? timeout,
  }) {
    return mainFrame.ariaSnapshot(
      selector,
      mode: mode != null
          ? FrameAriaSnapshotModeEnum.values.firstWhere((e) => e.value == mode)
          : null,
      track: track,
      depth: depth,
      boxes: boxes,
      timeout: timeout,
    );
  }

  /// Performs an assertion against the element matching [selector].
  @override
  Future<FrameExpectResult> expect(
    String selector,
    String expression, {
    SerializedArgument? expectedValue,
    List<ExpectedTextValue>? expectedText,
    double? expectedNumber,
    bool? useInnerText,
    required bool isNot,
    double? timeout,
  }) {
    return mainFrame.expect(
      selector,
      expression,
      expectedValue: expectedValue,
      expectedText: expectedText,
      expectedNumber: expectedNumber,
      useInnerText: useInnerText,
      isNot: isNot,
      timeout: timeout,
    );
  }

  /// Exposes a binding with the given [name] to the page.
  @override
  Future<void> exposeBinding(String name) async {
    await channel_exposeBinding(name: name);
  }

  /// Requests garbage collection in the page's JavaScript runtime.
  @override
  Future<void> requestGC() async {
    await channel_requestGC();
  }

  /// Registers a handler to be called when a locator matching the given selector appears.
  @override
  Future<PageRegisterLocatorHandlerResult> registerLocatorHandler(
    Locator selector, {
    bool? noWaitAfter,
  }) async {
    return await channel_registerLocatorHandler(
      selector: selector.selector,
      noWaitAfter: noWaitAfter,
    );
  }

  /// Unregisters a locator handler previously registered with [registerLocatorHandler].
  @override
  Future<void> unregisterLocatorHandler(int uid) async {
    await channel_unregisterLocatorHandler(uid: uid);
  }

  /// Sets extra HTTP headers that will be sent with every request the page initiates.
  @override
  Future<void> setExtraHTTPHeaders(List<NameValue> headers) async {
    await channel_setExtraHTTPHeaders(headers: headers);
  }

  /// Sets the network interception patterns for this page.
  @override
  Future<void> setNetworkInterceptionPatterns(
    List<PageSetNetworkInterceptionPatternsPatternsItems> patterns,
  ) async {
    await channel_setNetworkInterceptionPatterns(patterns: patterns);
  }

  /// Touchscreen API also available through [this.touchscreen.tap()]
  @override
  Future<void> touchscreenTap(double x, double y) async {
    await channel_touchscreenTap(x: x, y: y);
  }

  /// Brings page to front (activates tab).
  @override
  Future<void> bringToFront() async {
    await channel_bringToFront();
  }

  /// Opens the element picker for selecting a locator.
  @override
  Future<PagePickLocatorResult> pickLocator() async {
    return await channel_pickLocator();
  }

  /// Cancels the element picker started by [pickLocator].
  @override
  Future<void> cancelPickLocator() async {
    await channel_cancelPickLocator();
  }

  /// Starts screen recording for the page.
  @override
  Future<void> screencastStart({
    PageScreencastStartSize? size,
    int? quality,
    bool? sendFrames,
    bool? record,
  }) async {
    await channel_screencastStart(
      size: size,
      quality: quality,
      sendFrames: sendFrames,
      record: record,
    );
  }

  /// Stops screen recording.
  @override
  Future<void> screencastStop() async {
    await channel_screencastStop();
  }

  /// Sets the dock tile image (macOS specific).
  @override
  Future<void> setDockTile(String image) async {
    await channel_setDockTile(image: image);
  }

  // --- Console Messages ---

  /// Clears all stored console messages.
  @override
  Future<void> clearConsoleMessages() async {
    await channel_clearConsoleMessages();
  }

  /// Returns console messages logged since the last call to [clearConsoleMessages].
  @override
  Future<PageConsoleMessagesResult> consoleMessages({
    ConsoleMessagesFilter? filter,
  }) async {
    return await channel_consoleMessages(filter: filter);
  }

  // --- Page Errors ---

  /// Clears all stored page errors.
  @override
  Future<void> clearPageErrors() async {
    await channel_clearPageErrors();
  }

  /// Returns page errors logged since the last call to [clearPageErrors].
  @override
  Future<PagePageErrorsResult> pageErrors({
    ConsoleMessagesFilter? filter,
  }) async {
    return await channel_pageErrors(filter: filter);
  }

  // --- Requests ---

  /// Returns all requests made by the page.
  @override
  Future<PageRequestsResult> requests() async {
    return await channel_requests();
  }

  // --- Locator Handler ---

  /// Resolves a locator handler registered via [registerLocatorHandler].
  @override
  Future<void> resolveLocatorHandlerNoReply(int uid, {bool? remove}) async {
    await channel_resolveLocatorHandlerNoReply(uid: uid, remove: remove);
  }

  // --- Screenshot Expect ---

  /// Performs a screenshot comparison assertion.
  @override
  Future<PageExpectScreenshotResult> expectScreenshot({
    String? expected,
    required double timeout,
    required bool isNot,
    PageExpectScreenshotLocator? locator,
    String? comparator,
    int? maxDiffPixels,
    double? maxDiffPixelRatio,
    double? threshold,
    bool? fullPage,
    Rect? clip,
    required CommonScreenshotOptions screenshotOptions,
  }) async {
    return await channel_expectScreenshot(
      expected: expected,
      timeout: timeout,
      isNot: isNot,
      locator: locator,
      comparator: comparator,
      maxDiffPixels: maxDiffPixels,
      maxDiffPixelRatio: maxDiffPixelRatio,
      threshold: threshold,
      fullPage: fullPage,
      clip: clip,
      commonScreenshotOptions: screenshotOptions,
    );
  }

  // --- WebSocket Interception ---

  /// Sets WebSocket interception patterns for this page.
  @override
  Future<void> setWebSocketInterceptionPatterns(
    List<PageSetWebSocketInterceptionPatternsPatternsItems> patterns,
  ) async {
    await channel_setWebSocketInterceptionPatterns(patterns: patterns);
  }

  // --- JS/CSS Coverage ---

  /// Starts JavaScript coverage collection.
  @override
  Future<void> startJSCoverage({
    bool? resetOnNavigation,
    bool? reportAnonymousScripts,
  }) async {
    await channel_startJSCoverage(
      resetOnNavigation: resetOnNavigation,
      reportAnonymousScripts: reportAnonymousScripts,
    );
  }

  /// Stops JavaScript coverage collection and returns the coverage report.
  @override
  Future<PageStopJSCoverageResult> stopJSCoverage() async {
    return await channel_stopJSCoverage();
  }

  /// Starts CSS coverage collection.
  @override
  Future<void> startCSSCoverage({bool? resetOnNavigation}) async {
    await channel_startCSSCoverage(resetOnNavigation: resetOnNavigation);
  }

  /// Stops CSS coverage collection and returns the coverage report.
  @override
  Future<PageStopCSSCoverageResult> stopCSSCoverage() async {
    return await channel_stopCSSCoverage();
  }

  // --- Screencast ---

  /// Shows an overlay on the screencast recording.
  @override
  Future<PageScreencastShowOverlayResult> screencastShowOverlay(
    String html, {
    double? duration,
  }) async {
    return await channel_screencastShowOverlay(html: html, duration: duration);
  }

  /// Removes a screencast overlay by [id].
  @override
  Future<void> screencastRemoveOverlay(String id) async {
    await channel_screencastRemoveOverlay(id: id);
  }

  /// Adds a new chapter marker to the screencast recording.
  @override
  Future<void> screencastChapter(
    String title, {
    String? description,
    double? duration,
  }) async {
    await channel_screencastChapter(
      title: title,
      description: description,
      duration: duration,
    );
  }

  /// Sets the visibility of the screencast overlay.
  @override
  Future<void> screencastSetOverlayVisible(bool visible) async {
    await channel_screencastSetOverlayVisible(visible: visible);
  }

  /// Shows action indicators on the screencast.
  @override
  Future<void> screencastShowActions(ShowActionsOptions options) async {
    await channel_screencastShowActions(showActionsOptions: options);
  }

  /// Hides action indicators from the screencast.
  @override
  Future<void> screencastHideActions() async {
    await channel_screencastHideActions();
  }

  // --- Subscription ---

  /// Updates the subscription state for a specific event type.
  @override
  Future<void> updateSubscription({
    required PageUpdateSubscriptionEventEnum event,
    required bool enabled,
  }) async {
    await channel_updateSubscription(event: event, enabled: enabled);
  }
}
