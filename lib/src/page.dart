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
class Page extends PageBase {
  late final Keyboard keyboard;
  late final Mouse mouse;
  late final Touchscreen touchscreen;

  Page(
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

  BrowserContext get context => parent as BrowserContext;

  String get _mainFrameGuid => initializer['mainFrame']['guid'];

  Frame get mainFrame => connection.objects[_mainFrameGuid] as Frame;

  Stream<ConsoleMessage> get onConsole {
    channel_updateSubscription(
      enabled: true,
      event: PageUpdateSubscriptionEventEnum.console,
    );
    return context.onEvent
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
  Stream<Request> get onRequest {
    channel_updateSubscription(
      enabled: true,
      event: PageUpdateSubscriptionEventEnum.request,
    );
    return context.onEvent
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
  Stream<Response> get onResponse {
    channel_updateSubscription(
      enabled: true,
      event: PageUpdateSubscriptionEventEnum.response,
    );
    return context.onEvent
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
  Stream<Request> get onRequestFinished {
    channel_updateSubscription(
      enabled: true,
      event: PageUpdateSubscriptionEventEnum.requestFinished,
    );
    return context.onEvent
        .where((e) => e['event'] == 'requestFinished')
        .map((e) {
          final requestGuid = e['params']['request']['guid'];
          return connection.objects[requestGuid] as Request;
        })
        .where((request) => request.frame.page == this);
  }

  /// Emitted when a request fails.
  Stream<Request> get onRequestFailed {
    channel_updateSubscription(
      enabled: true,
      event: PageUpdateSubscriptionEventEnum.requestFailed,
    );
    return context.onEvent
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

  Stream<WebSocket> get onWebSocket {
    return onEvent.where((e) => e['event'] == 'webSocket').map((e) {
      final guid = e['params']['webSocket']['guid'];
      return connection.objects[guid] as WebSocket;
    });
  }

  Stream<Page> get onClose {
    return onEvent.where((e) => e['event'] == 'close').map((e) => this);
  }

  Stream<Page> get onCrash {
    return onEvent.where((e) => e['event'] == 'crash').map((e) => this);
  }

  Stream<Exception> get onPageError {
    return context.onEvent
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

  Video? video() {
    final videoInitializer = initializer['video'];
    if (videoInitializer == null) return null;
    final artifactGuid = videoInitializer['guid'];
    final artifact = connection.objects[artifactGuid] as Artifact;
    return Video(this, artifact);
  }

  Stream<Page> get onPopup {
    return onEvent.where((e) => e['event'] == 'popup').map((e) {
      final guid = e['params']['page']['guid'];
      return connection.objects[guid] as Page;
    });
  }

  Stream<Worker> get onWorker {
    return onEvent.where((e) => e['event'] == 'worker').map((e) {
      final workerGuid = e['params']['worker']['guid'];
      return connection.objects[workerGuid] as Worker;
    });
  }

  /// Waits for the matching request and returns it.
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
  Future<void> goto(String url) async {
    await mainFrame.goto(url);
  }

  /// Waits for the required load state to be reached.
  Future<void> waitForLoadState({
    String state = 'load',
    double? timeout,
  }) async {
    await mainFrame.waitForLoadState(state: state, timeout: timeout);
  }

  /// Waits for the main frame to navigate to the given URL.
  Future<void> waitForURL(
    dynamic urlOrPredicate, {
    double? timeout,
    String waitUntil = 'load',
  }) async {
    await mainFrame.waitForURL(
      urlOrPredicate,
      timeout: timeout,
      waitUntil: waitUntil,
    );
  }

  /// Waits for navigation to complete.
  Future<void> waitForNavigation({
    String? url,
    String waitUntil = 'load',
    double? timeout,
  }) async {
    await mainFrame.waitForNavigation(
      url: url,
      waitUntil: waitUntil,
      timeout: timeout,
    );
  }

  /// Returns the page's title.
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
  Locator locator(String selector) {
    return mainFrame.locator(selector);
  }

  /// Returns the value of the `expression` invocation.
  ///
  /// If the function passed to the `page.evaluate` returns a Promise, then `page.evaluate` would wait for the promise to resolve and return its value.
  /// If the function passed to the `page.evaluate` returns a non-Serializable value, then `page.evaluate` resolves to `undefined`.
  Future<dynamic> evaluate(String expression, [dynamic arg]) async {
    return mainFrame.evaluate(expression, arg);
  }

  Future<void> waitForSelector(
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

  Future<void> route(String url, Future<void> Function(Route) handler) async {
    await channel_setNetworkInterceptionPatterns(
      patterns: [
        {'glob': url},
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
  Locator getByText(String text, {bool exact = false}) {
    if (exact) {
      return locator('internal:text="$text"');
    }
    // Substring match
    return locator('internal:text=$text');
  }

  /// Allows locating elements by their ARIA role, ARIA attributes and accessible name.
  Locator getByRole(String role, {String? name}) {
    var selector = 'internal:role=$role';
    if (name != null) {
      selector +=
          '[name="$name"i]'; // Case-insensitive matching by default in intro
    }
    return locator(selector);
  }

  Locator getByLabel(String text, {bool exact = false}) {
    return exact
        ? locator('internal:label="$text"')
        : locator('internal:label=$text');
  }

  Locator getByPlaceholder(String text, {bool exact = false}) {
    return exact
        ? locator('internal:attr=[placeholder="$text"]')
        : locator('internal:attr=[placeholder="$text"i]');
  }

  Locator getByAltText(String text, {bool exact = false}) {
    return exact
        ? locator('internal:attr=[alt="$text"]')
        : locator('internal:attr=[alt="$text"i]');
  }

  Locator getByTitle(String text, {bool exact = false}) {
    return exact
        ? locator('internal:attr=[title="$text"]')
        : locator('internal:attr=[title="$text"i]');
  }

  Locator getByTestId(String testId) {
    return locator('internal:testid=[data-testid="$testId"]');
  }

  Future<void> setViewportSize(Map<String, dynamic> viewportSize) async {
    await channel_setViewportSize(viewportSize: viewportSize);
  }

  /// Returns the buffer with the captured screenshot.
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
    Map<String, dynamic>? margin,
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

  Future<void> reload({double? timeout, String waitUntil = 'load'}) async {
    await channel_reload(
      timeout: timeout ?? 30000.0,
      waitUntil: LifecycleEvent.values.firstWhere(
        (e) => e.value == waitUntil,
        orElse: () => LifecycleEvent.load,
      ),
    );
  }

  Future<void> goBack({double? timeout, String waitUntil = 'load'}) async {
    await channel_goBack(
      timeout: timeout ?? 30000.0,
      waitUntil: LifecycleEvent.values.firstWhere(
        (e) => e.value == waitUntil,
        orElse: () => LifecycleEvent.load,
      ),
    );
  }

  Future<void> goForward({double? timeout, String waitUntil = 'load'}) async {
    await channel_goForward(
      timeout: timeout ?? 30000.0,
      waitUntil: LifecycleEvent.values.firstWhere(
        (e) => e.value == waitUntil,
        orElse: () => LifecycleEvent.load,
      ),
    );
  }

  Future<void> addInitScript(String source) async {
    await channel_addInitScript(source: source);
  }

  /// Closes the page.
  ///
  /// If `runBeforeUnload` is `true`, a `beforeunload` dialog might be summoned and should be handled manually via `page.onDialog`.
  Future<void> close({bool? runBeforeUnload, String? reason}) async {
    await channel_close(runBeforeUnload: runBeforeUnload, reason: reason);
  }

  Future<void> emulateMedia({
    String? media,
    String? colorScheme,
    String? reducedMotion,
    String? forcedColors,
    String? contrast,
  }) async {
    await channel_emulateMedia(
      media: media != null
          ? PageEmulateMediaMediaEnum.values.firstWhere((e) => e.value == media)
          : null,
      colorScheme: colorScheme != null
          ? PageEmulateMediaColorSchemeEnum.values.firstWhere(
              (e) => e.value == colorScheme,
            )
          : null,
      reducedMotion: reducedMotion != null
          ? PageEmulateMediaReducedMotionEnum.values.firstWhere(
              (e) => e.value == reducedMotion,
            )
          : null,
      forcedColors: forcedColors != null
          ? PageEmulateMediaForcedColorsEnum.values.firstWhere(
              (e) => e.value == forcedColors,
            )
          : null,
      contrast: contrast != null
          ? PageEmulateMediaContrastEnum.values.firstWhere(
              (e) => e.value == contrast,
            )
          : null,
    );
  }

  // --- Frame proxies ---

  Future<void> click(String selector, {bool? force, double? timeout}) {
    return mainFrame.click(selector, force: force, timeout: timeout);
  }

  Future<void> fill(
    String selector,
    String value, {
    bool? force,
    double? timeout,
  }) {
    return mainFrame.fill(selector, value, force: force, timeout: timeout);
  }

  Future<void> check(String selector, {bool? force, double? timeout}) {
    return mainFrame.check(selector, force: force, timeout: timeout);
  }

  Future<void> uncheck(String selector, {bool? force, double? timeout}) {
    return mainFrame.uncheck(selector, force: force, timeout: timeout);
  }

  Future<void> hover(String selector, {bool? force, double? timeout}) {
    return mainFrame.hover(selector, force: force, timeout: timeout);
  }

  Future<void> focus(String selector, {double? timeout}) {
    return mainFrame.focus(selector, timeout: timeout);
  }

  Future<void> blur(String selector, {double? timeout}) {
    return mainFrame.blur(selector, timeout: timeout);
  }

  Future<void> dblclick(String selector, {bool? force, double? timeout}) {
    return mainFrame.dblclick(selector, force: force, timeout: timeout);
  }

  Future<void> type(
    String selector,
    String text, {
    double? delay,
    double? timeout,
  }) {
    return mainFrame.type(selector, text, delay: delay, timeout: timeout);
  }

  Future<void> press(
    String selector,
    String key, {
    double? delay,
    double? timeout,
  }) {
    return mainFrame.press(selector, key, delay: delay, timeout: timeout);
  }

  Future<void> tap(String selector, {bool? force, double? timeout}) {
    return mainFrame.tap(selector, force: force, timeout: timeout);
  }

  Future<String> content() {
    return mainFrame.content();
  }

  Future<void> setContent(String html, {double? timeout}) {
    return mainFrame.setContent(html, timeout: timeout);
  }

  Future<dynamic> evalOnSelector(
    String selector,
    String expression, [
    dynamic arg,
  ]) {
    return mainFrame.evalOnSelector(selector, expression, arg);
  }

  Future<dynamic> evalOnSelectorAll(
    String selector,
    String expression, [
    dynamic arg,
  ]) {
    return mainFrame.evalOnSelectorAll(selector, expression, arg);
  }

  Future<String?> getAttribute(
    String selector,
    String name, {
    double? timeout,
  }) {
    return mainFrame.getAttribute(selector, name, timeout: timeout);
  }

  Future<String> innerHTML(String selector, {double? timeout}) {
    return mainFrame.innerHTML(selector, timeout: timeout);
  }

  Future<String> innerText(String selector, {double? timeout}) {
    return mainFrame.innerText(selector, timeout: timeout);
  }

  Future<String> inputValue(String selector, {double? timeout}) {
    return mainFrame.inputValue(selector, timeout: timeout);
  }

  Future<bool> isChecked(String selector, {double? timeout}) {
    return mainFrame.isChecked(selector, timeout: timeout);
  }

  Future<bool> isDisabled(String selector, {double? timeout}) {
    return mainFrame.isDisabled(selector, timeout: timeout);
  }

  Future<bool> isEnabled(String selector, {double? timeout}) {
    return mainFrame.isEnabled(selector, timeout: timeout);
  }

  Future<bool> isHidden(String selector) {
    return mainFrame.isHidden(selector);
  }

  Future<bool> isVisible(String selector) {
    return mainFrame.isVisible(selector);
  }

  Future<bool> isEditable(String selector, {double? timeout}) {
    return mainFrame.isEditable(selector, timeout: timeout);
  }

  Future<void> addScriptTag({String? url, String? content, String? type}) {
    return mainFrame.addScriptTag(url: url, content: content, type: type);
  }

  Future<void> addStyleTag({String? url, String? content}) {
    return mainFrame.addStyleTag(url: url, content: content);
  }

  Future<void> waitForTimeout(double timeout) {
    return mainFrame.waitForTimeout(timeout);
  }

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

  Future<void> highlight(String selector) {
    return mainFrame.highlight(selector);
  }

  Future<void> hideHighlight() async {
    await channel_hideHighlight();
  }

  Future<void> drop(
    String selector, {
    List<Map<String, dynamic>>? payloads,
    List<String>? localPaths,
    List<Map<String, dynamic>>? data,
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

  Locator querySelector(String selector) {
    return mainFrame.querySelector(selector);
  }

  Future<List<Locator>> querySelectorAll(String selector) {
    return mainFrame.querySelectorAll(selector);
  }

  Future<int> queryCount(String selector) {
    return mainFrame.queryCount(selector);
  }

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

  Future<void> exposeBinding(String name) async {
    await channel_exposeBinding(name: name);
  }

  Future<void> requestGC() async {
    await channel_requestGC();
  }

  Future<PageRegisterLocatorHandlerResult> registerLocatorHandler(
    Locator selector, {
    bool? noWaitAfter,
  }) async {
    return await channel_registerLocatorHandler(
      selector: selector.selector,
      noWaitAfter: noWaitAfter,
    );
  }

  Future<void> unregisterLocatorHandler(int uid) async {
    await channel_unregisterLocatorHandler(uid: uid);
  }

  Future<void> setExtraHTTPHeaders(Map<String, String> headers) async {
    final nameValueHeaders = headers.entries
        .map((e) => NameValue(name: e.key, value: e.value))
        .toList();
    await channel_setExtraHTTPHeaders(headers: nameValueHeaders);
  }

  Future<void> setNetworkInterceptionPatterns(
    List<Map<String, dynamic>> patterns,
  ) async {
    await channel_setNetworkInterceptionPatterns(patterns: patterns);
  }

  /// Touchscreen API also available through [this.touchscreen.tap()]
  Future<void> touchscreenTap(double x, double y) async {
    await channel_touchscreenTap(x: x, y: y);
  }

  Future<void> bringToFront() async {
    await channel_bringToFront();
  }

  Future<PagePickLocatorResult> pickLocator() async {
    return await channel_pickLocator();
  }

  Future<void> cancelPickLocator() async {
    await channel_cancelPickLocator();
  }

  Future<void> screencastStart({
    Map<String, dynamic>? size,
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

  Future<void> screencastStop() async {
    await channel_screencastStop();
  }

  Future<void> setDockTile(String image) async {
    await channel_setDockTile(image: image);
  }

  // --- Console Messages ---

  Future<void> clearConsoleMessages() async {
    await channel_clearConsoleMessages();
  }

  Future<PageConsoleMessagesResult> consoleMessages({
    ConsoleMessagesFilter? filter,
  }) async {
    return await channel_consoleMessages(filter: filter);
  }

  // --- Page Errors ---

  Future<void> clearPageErrors() async {
    await channel_clearPageErrors();
  }

  Future<PagePageErrorsResult> pageErrors({
    ConsoleMessagesFilter? filter,
  }) async {
    return await channel_pageErrors(filter: filter);
  }

  // --- Requests ---

  Future<PageRequestsResult> requests() async {
    return await channel_requests();
  }

  // --- Locator Handler ---

  Future<void> resolveLocatorHandlerNoReply(int uid, {bool? remove}) async {
    await channel_resolveLocatorHandlerNoReply(uid: uid, remove: remove);
  }

  // --- Screenshot Expect ---

  Future<PageExpectScreenshotResult> expectScreenshot({
    String? expected,
    required double timeout,
    required bool isNot,
    Map<String, dynamic>? locator,
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

  Future<void> setWebSocketInterceptionPatterns(
    List<Map<String, dynamic>> patterns,
  ) async {
    await channel_setWebSocketInterceptionPatterns(patterns: patterns);
  }

  // --- JS/CSS Coverage ---

  Future<void> startJSCoverage({
    bool? resetOnNavigation,
    bool? reportAnonymousScripts,
  }) async {
    await channel_startJSCoverage(
      resetOnNavigation: resetOnNavigation,
      reportAnonymousScripts: reportAnonymousScripts,
    );
  }

  Future<PageStopJSCoverageResult> stopJSCoverage() async {
    return await channel_stopJSCoverage();
  }

  Future<void> startCSSCoverage({bool? resetOnNavigation}) async {
    await channel_startCSSCoverage(resetOnNavigation: resetOnNavigation);
  }

  Future<PageStopCSSCoverageResult> stopCSSCoverage() async {
    return await channel_stopCSSCoverage();
  }

  // --- Screencast ---

  Future<PageScreencastShowOverlayResult> screencastShowOverlay(
    String html, {
    double? duration,
  }) async {
    return await channel_screencastShowOverlay(html: html, duration: duration);
  }

  Future<void> screencastRemoveOverlay(String id) async {
    await channel_screencastRemoveOverlay(id: id);
  }

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

  Future<void> screencastSetOverlayVisible(bool visible) async {
    await channel_screencastSetOverlayVisible(visible: visible);
  }

  Future<void> screencastShowActions(ShowActionsOptions options) async {
    await channel_screencastShowActions(showActionsOptions: options);
  }

  Future<void> screencastHideActions() async {
    await channel_screencastHideActions();
  }

  // --- Subscription ---

  Future<void> updateSubscription({
    required String event,
    required bool enabled,
  }) async {
    await channel_updateSubscription(
      event: PageUpdateSubscriptionEventEnum.values.firstWhere(
        (e) => e.value == event,
      ),
      enabled: enabled,
    );
  }
}
