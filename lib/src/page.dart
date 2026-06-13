import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'generated/channels.dart';
import 'frame.dart';
import 'locator.dart';
import 'keyboard.dart';
import 'mouse.dart';
import 'route.dart';

class Page extends PageBase {
  late final Keyboard keyboard;
  late final Mouse mouse;

  Page(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]) {
    keyboard = Keyboard(this);
    mouse = Mouse(this);
  }

  String get _mainFrameGuid => initializer['mainFrame']['guid'];

  Frame get mainFrame => connection.objects[_mainFrameGuid] as Frame;

  Future<void> goto(String url) async {
    await mainFrame.goto(url);
  }

  Future<String> title() async {
    final result = await connection.sendMessageToServer(
      _mainFrameGuid,
      'title',
      {},
    );
    return result['value'] as String;
  }

  /// Returns a locator for the given selector.
  Locator locator(String selector) {
    return mainFrame.locator(selector);
  }

  Future<dynamic> evaluate(String expression, [dynamic arg]) async {
    return mainFrame.evaluate(expression, arg);
  }

  Future<void> waitForSelector(
    String selector, {
    String? state,
    double? timeout,
  }) async {
    return mainFrame.waitForSelector(selector, state: state, timeout: timeout);
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

  /// Returns a locator by text.
  Locator getByText(String text, {bool exact = false}) {
    if (exact) {
      return locator('internal:text="$text"');
    }
    // Substring match
    return locator('internal:text=$text');
  }

  /// Returns a locator by role.
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

  Future<void> setViewportSize(int width, int height) async {
    await channel_setViewportSize(
      viewportSize: {'width': width, 'height': height},
    );
  }

  Future<Uint8List> screenshot({
    String? path,
    bool? fullPage,
    String? type,
    int? quality,
    double? timeout,
  }) async {
    final result = await channel_screenshot(
      timeout: timeout ?? 30000.0,
      type: type,
      quality: quality,
      fullPage: fullPage,
      mixin: CommonScreenshotOptions(),
    );
    final buffer = base64Decode(result['binary']);
    if (path != null) {
      await File(path).writeAsBytes(buffer);
    }
    return buffer;
  }

  Future<Uint8List> pdf({String? path, String? format, bool? landscape}) async {
    final result = await channel_pdf(format: format, landscape: landscape);
    final buffer = base64Decode(result['pdf']);
    if (path != null) {
      await File(path).writeAsBytes(buffer);
    }
    return buffer;
  }

  Future<void> reload({double? timeout}) async {
    await channel_reload(timeout: timeout ?? 30000.0);
  }

  Future<void> goBack({double? timeout}) async {
    await channel_goBack(timeout: timeout ?? 30000.0);
  }

  Future<void> goForward({double? timeout}) async {
    await channel_goForward(timeout: timeout ?? 30000.0);
  }

  Future<void> addInitScript(String source) async {
    await channel_addInitScript(source: source);
  }

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
      media: media,
      colorScheme: colorScheme,
      reducedMotion: reducedMotion,
      forcedColors: forcedColors,
      contrast: contrast,
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
    return mainFrame.waitForFunction(expression, arg, timeout, pollingInterval);
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

  Future<Map<String, dynamic>> ariaSnapshot(
    String selector, {
    String? mode,
    String? track,
    int? depth,
    bool? boxes,
    double? timeout,
  }) {
    return mainFrame.ariaSnapshot(
      selector,
      mode: mode,
      track: track,
      depth: depth,
      boxes: boxes,
      timeout: timeout,
    );
  }

  Future<Map<String, dynamic>> expect(
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

  Future<Map<String, dynamic>> registerLocatorHandler(
    Locator locator, {
    bool? noWaitAfter,
  }) async {
    return await channel_registerLocatorHandler(
      selector: locator.selector,
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

  Future<void> touchscreenTap(double x, double y) async {
    await channel_touchscreenTap(x: x, y: y);
  }

  Future<void> bringToFront() async {
    await channel_bringToFront();
  }

  Future<Map<String, dynamic>> pickLocator() async {
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

  Future<Map<String, dynamic>> consoleMessages({
    ConsoleMessagesFilter? filter,
  }) async {
    return await channel_consoleMessages(filter: filter);
  }

  // --- Page Errors ---

  Future<void> clearPageErrors() async {
    await channel_clearPageErrors();
  }

  Future<Map<String, dynamic>> pageErrors({
    ConsoleMessagesFilter? filter,
  }) async {
    return await channel_pageErrors(filter: filter);
  }

  // --- Requests ---

  Future<Map<String, dynamic>> requests() async {
    return await channel_requests();
  }

  // --- Locator Handler ---

  Future<void> resolveLocatorHandlerNoReply(int uid, {bool? remove}) async {
    await channel_resolveLocatorHandlerNoReply(uid: uid, remove: remove);
  }

  // --- Screenshot Expect ---

  Future<Map<String, dynamic>> expectScreenshot({
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
      mixin: screenshotOptions,
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

  Future<Map<String, dynamic>> stopJSCoverage() async {
    return await channel_stopJSCoverage();
  }

  Future<void> startCSSCoverage({bool? resetOnNavigation}) async {
    await channel_startCSSCoverage(resetOnNavigation: resetOnNavigation);
  }

  Future<Map<String, dynamic>> stopCSSCoverage() async {
    return await channel_stopCSSCoverage();
  }

  // --- Screencast ---

  Future<Map<String, dynamic>> screencastShowOverlay(
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
    await channel_screencastShowActions(mixin: options);
  }

  Future<void> screencastHideActions() async {
    await channel_screencastHideActions();
  }

  // --- Subscription ---

  Future<void> updateSubscription({
    required String event,
    required bool enabled,
  }) async {
    await channel_updateSubscription(event: event, enabled: enabled);
  }
}
