import 'frame.dart';
import 'generated/channels.dart';
import 'serialization.dart';
import 'locator_assertions.dart';

/// Locators are the central piece of Playwright's auto-waiting and retry-ability.
///
/// In a nutshell, locators represent a way to find element(s) on the page at any moment.
class Locator {
  /// The frame this locator belongs to.
  final Frame frame;
  final String selector;

  Locator(this.frame, this.selector);

  /// Returns an assertions object that provides web-first assertions for this locator.
  LocatorAssertions expect({double? timeout}) =>
      LocatorAssertions(this, false, timeout);

  /// Creates a locator that matches both this locator and the given selector.
  Locator locator(String selectorOrLocator) {
    return Locator(frame, '$selector >> $selectorOrLocator');
  }

  Locator getByText(String text, {bool exact = false}) {
    return exact
        ? locator('internal:text="$text"')
        : locator('internal:text=$text');
  }

  Locator getByRole(String role, {String? name}) {
    var sel = 'internal:role=$role';
    if (name != null) sel += '[name="$name"i]';
    return locator(sel);
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

  /// Click an element.
  ///
  /// It will wait for the element to be visible, enabled and stable.
  Future<void> click({bool? force, double? timeout}) async {
    await (frame as FrameImpl).channel_click(
      selector: selector,
      force: force,
      timeout: timeout ?? 30000.0,
    );
  }

  /// Fills an `<input>`, `<textarea>` or `[contenteditable]` element with the provided value.
  Future<void> fill(String value, {bool? force, double? timeout}) async {
    await (frame as FrameImpl).channel_fill(
      selector: selector,
      value: value,
      force: force,
      timeout: timeout ?? 30000.0,
    );
  }

  Future<void> check({bool? force, double? timeout}) async {
    await (frame as FrameImpl).channel_check(
      selector: selector,
      force: force,
      timeout: timeout ?? 30000.0,
    );
  }

  Future<void> uncheck({bool? force, double? timeout}) async {
    await (frame as FrameImpl).channel_uncheck(
      selector: selector,
      force: force,
      timeout: timeout ?? 30000.0,
    );
  }

  Future<String> innerText({double? timeout}) async {
    final result = await (frame as FrameImpl).channel_innerText(
      selector: selector,
      timeout: timeout ?? 30000.0,
    );
    return result.value;
  }

  Future<String> textContent({double? timeout}) async {
    final result = await (frame as FrameImpl).channel_textContent(
      selector: selector,
      timeout: timeout ?? 30000.0,
    );
    return result.value as String;
  }

  /// Hovers over the element.
  Future<void> hover({bool? force, double? timeout}) async {
    await (frame as FrameImpl).channel_hover(
      selector: selector,
      force: force,
      timeout: timeout ?? 30000.0,
    );
  }

  Future<void> focus({double? timeout}) async {
    await (frame as FrameImpl).channel_focus(
      selector: selector,
      timeout: timeout ?? 30000.0,
    );
  }

  Future<void> blur({double? timeout}) async {
    await (frame as FrameImpl).channel_blur(
      selector: selector,
      timeout: timeout ?? 30000.0,
    );
  }

  Future<void> dblclick({bool? force, double? timeout}) async {
    await (frame as FrameImpl).channel_dblclick(
      selector: selector,
      force: force,
      timeout: timeout ?? 30000.0,
    );
  }

  Future<String?> getAttribute(String name, {double? timeout}) async {
    final result = await (frame as FrameImpl).channel_getAttribute(
      selector: selector,
      name: name,
      timeout: timeout ?? 30000.0,
    );
    return result.value;
  }

  Future<String> inputValue({double? timeout}) async {
    final result = await (frame as FrameImpl).channel_inputValue(
      selector: selector,
      timeout: timeout ?? 30000.0,
    );
    return result.value;
  }

  /// Returns whether the element is visible.
  Future<bool> isVisible() async {
    final result = await (frame as FrameImpl).channel_isVisible(
      selector: selector,
    );
    return result.value;
  }

  Future<String> innerHTML({double? timeout}) async {
    final result = await (frame as FrameImpl).channel_innerHTML(
      selector: selector,
      timeout: timeout ?? 30000.0,
    );
    return result.value;
  }

  Future<bool> isEditable({double? timeout}) async {
    final result = await (frame as FrameImpl).channel_isEditable(
      selector: selector,
      timeout: timeout ?? 30000.0,
    );
    return result.value;
  }

  Future<bool> isHidden() async {
    final result = await (frame as FrameImpl).channel_isHidden(
      selector: selector,
    );
    return result.value;
  }

  /// Returns whether the element is enabled.
  Future<bool> isEnabled({double? timeout}) async {
    final result = await (frame as FrameImpl).channel_isEnabled(
      selector: selector,
      timeout: timeout ?? 30000.0,
    );
    return result.value;
  }

  Future<bool> isDisabled({double? timeout}) async {
    final result = await (frame as FrameImpl).channel_isDisabled(
      selector: selector,
      timeout: timeout ?? 30000.0,
    );
    return result.value;
  }

  Future<bool> isChecked({double? timeout}) async {
    final result = await (frame as FrameImpl).channel_isChecked(
      selector: selector,
      timeout: timeout ?? 30000.0,
    );
    return result.value;
  }

  Future<dynamic> evaluateAll(String expression, [dynamic arg]) async {
    return frame.evalOnSelectorAll(selector, expression, arg);
  }

  Future<void> type(String text, {double? delay, double? timeout}) async {
    await (frame as FrameImpl).channel_type(
      selector: selector,
      text: text,
      delay: delay,
      timeout: timeout ?? 30000.0,
    );
  }

  /// Focuses the element, and then uses keyboard to press the given key.
  Future<void> press(String key, {double? delay, double? timeout}) async {
    await (frame as FrameImpl).channel_press(
      selector: selector,
      key: key,
      delay: delay,
      timeout: timeout ?? 30000.0,
    );
  }

  Future<void> tap({bool? force, double? timeout}) async {
    await (frame as FrameImpl).channel_tap(
      selector: selector,
      force: force,
      timeout: timeout ?? 30000.0,
    );
  }

  /// Selects one or multiple options in the `<select>` element.
  Future<List<String>> selectOption(
    dynamic values, {
    bool? force,
    double? timeout,
  }) async {
    return frame.selectOption(selector, values, force: force, timeout: timeout);
  }

  Future<void> setInputFiles(
    dynamic files, {
    bool? noWaitAfter,
    double? timeout,
  }) async {
    await frame.setInputFiles(
      selector,
      files,
      noWaitAfter: noWaitAfter,
      timeout: timeout,
    );
  }

  Future<void> dispatchEvent(
    String type, {
    dynamic eventInit,
    double? timeout,
  }) async {
    await (frame as FrameImpl).channel_dispatchEvent(
      selector: selector,
      type: type,
      eventInit: serializeArgument(eventInit),
      timeout: timeout ?? 30000.0,
    );
  }

  Future<void> highlight() async {
    await (frame as FrameImpl).channel_highlight(selector: selector);
  }

  Future<void> hideHighlight() async {
    await (frame as FrameImpl).channel_hideHighlight(selector: selector);
  }

  Future<void> drop({
    List<FrameDropPayloadsItems>? payloads,
    List<String>? localPaths,
    List<FrameDropDataItems>? data,
    double? timeout,
  }) async {
    await frame.drop(
      selector,
      payloads: payloads,
      localPaths: localPaths,
      data: data,
      timeout: timeout,
    );
  }

  Future<FrameResolveSelectorResult> resolveSelector() async {
    return await frame.resolveSelector(selector);
  }

  Future<FrameAriaSnapshotResult> ariaSnapshot({
    FrameAriaSnapshotModeEnum? mode,
    String? track,
    int? depth,
    bool? boxes,
    double? timeout,
  }) async {
    return await frame.ariaSnapshot(
      selector,
      mode: mode,
      track: track,
      depth: depth,
      boxes: boxes,
      timeout: timeout,
    );
  }

  Locator querySelector(String subSelector) {
    return locator(subSelector);
  }

  Future<List<Locator>> querySelectorAll(String subSelector) async {
    final count = await frame.queryCount('$selector >> $subSelector');
    return List.generate(count, (i) => locator('$subSelector >> nth=$i'));
  }

  Future<int> queryCount(String subSelector) async {
    return await frame.queryCount('$selector >> $subSelector');
  }

  Future<dynamic> evaluate(String expression, [dynamic arg]) async {
    // Locator evaluation in Playwright takes the element as the first arg.
    // For simplicity, we just use the frame evaluate and pass the selector,
    // or rely on evalOnSelector which evaluates in the context of the element.
    final result = await (frame as FrameImpl).channel_evalOnSelector(
      selector: selector,
      expression: expression,
      arg: serializeArgument(arg),
    );
    return parseSerializedValue(result.value);
  }

  Future<void> waitFor({
    FrameWaitForSelectorStateEnum? state,
    double? timeout,
  }) async {
    await frame.waitForSelector(selector, state: state, timeout: timeout);
  }

  Future<void> dragTo(Locator target, {bool? force, double? timeout}) async {
    await frame.dragAndDrop(
      selector,
      target.selector,
      force: force,
      timeout: timeout,
    );
  }
}
