import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'generated/channels.dart';
import 'frame.dart';
import 'locator.dart';
import 'keyboard.dart';
import 'mouse.dart';

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
    dynamic data,
    bool? force,
    double? timeout,
  }) {
    return mainFrame.drop(selector, data: data, force: force, timeout: timeout);
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

  Future<dynamic> ariaSnapshot(String selector) {
    return mainFrame.ariaSnapshot(selector);
  }

  Future<dynamic> expect(
    String selector,
    String expression, {
    dynamic expectedValue,
    double? timeout,
  }) {
    return mainFrame.expect(
      selector,
      expression,
      expectedValue: expectedValue,
      timeout: timeout,
    );
  }

  Future<void> exposeBinding(
    String name,
    Function callback, {
    bool? handle,
  }) async {
    throw UnimplementedError('exposeBinding not fully mapped yet');
  }

  Future<void> requestGC() async {
    await channel_requestGC();
  }

  Future<void> registerLocatorHandler(Locator locator, Function handler) async {
    throw UnimplementedError('registerLocatorHandler not fully mapped yet');
  }

  Future<void> unregisterLocatorHandler(Locator locator) async {
    throw UnimplementedError('unregisterLocatorHandler not fully mapped yet');
  }

  Future<void> setExtraHTTPHeaders(Map<String, String> headers) async {
    throw UnimplementedError('setExtraHTTPHeaders not fully mapped yet');
  }

  Future<void> setNetworkInterceptionPatterns(List<dynamic> patterns) async {
    throw UnimplementedError(
      'setNetworkInterceptionPatterns not fully mapped yet',
    );
  }

  Future<void> touchscreenTap(double x, double y) async {
    await channel_touchscreenTap(x: x, y: y);
  }

  Future<void> bringToFront() async {
    await channel_bringToFront();
  }

  Future<void> pickLocator() async {
    throw UnimplementedError();
  }

  Future<void> cancelPickLocator() async {
    throw UnimplementedError();
  }

  Future<void> screencastStart() async {
    throw UnimplementedError();
  }

  Future<void> screencastStop() async {
    throw UnimplementedError();
  }

  Future<void> setDockTile() async {
    throw UnimplementedError();
  }
}
