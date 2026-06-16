import 'dart:convert';

import 'dart:typed_data';

import 'frame_locator.dart';

import 'frame.dart';

import 'page.dart';

import '../generated/channels.dart';

import '../infrastructure/serialization.dart';

import '../interaction/element_handle.dart';

import '../interaction/locator_assertions.dart';

import '../utils/locator_utils.dart';

import '../utils/logger.dart';

/// Locators are the central piece of Playwright's auto-waiting and retry-ability.

///

/// In a nutshell, locators represent a way to find element(s) on the page at any moment.

class Locator {
  /// The frame this locator belongs to.

  final Frame frame;

  /// The selector string for this locator.
  final String selector;

  /// Creates a new locator for the given [frame] and [selector].
  Locator(this.frame, this.selector);

  /// Returns an assertions object that provides web-first assertions for this locator.

  LocatorAssertions expect({double? timeout}) =>
      LocatorAssertions(this, false, timeout);

  /// Returns the first matching locator.
  Locator first() => locator('nth=0');

  /// Returns the last matching locator.
  Locator last() => locator('nth=-1');

  /// Returns the nth matching locator.
  Locator nth(int index) => locator('nth=$index');

  /// Creates a locator that matches both this locator and the given [other] locator.
  Locator and(Locator other) {
    if (other.frame != frame) {
      throw Exception('Locators must belong to the same frame.');
    }

    return Locator(
      frame,

      '$selector >> internal:and=${jsonEncode(other.selector)}',
    );
  }

  /// Creates a locator that matches either this locator or the given [other] locator.
  Locator or(Locator other) {
    if (other.frame != frame) {
      throw Exception('Locators must belong to the same frame.');
    }

    return Locator(
      frame,

      '$selector >> internal:or=${jsonEncode(other.selector)}',
    );
  }

  /// Creates a locator that filters this locator by the given criteria.
  Locator filter({
    Pattern? hasText,

    Locator? has,

    Pattern? hasNotText,

    Locator? hasNot,
  }) {
    var sel = selector;

    if (hasText != null) {
      if (hasText is RegExp) {
        sel += ' >> internal:has-text=${regExpToString(hasText)}';
      } else {
        sel += ' >> internal:has-text=${jsonEncode(hasText as String)}';
      }
    }

    if (has != null) {
      sel += ' >> internal:has=${jsonEncode(has.selector)}';
    }

    if (hasNotText != null) {
      if (hasNotText is RegExp) {
        sel += ' >> internal:has-not-text=${regExpToString(hasNotText)}';
      } else {
        sel += ' >> internal:has-not-text=${jsonEncode(hasNotText as String)}';
      }
    }

    if (hasNot != null) {
      sel += ' >> internal:has-not=${jsonEncode(hasNot.selector)}';
    }

    return Locator(frame, sel);
  }

  /// Returns a frame locator for the content frame of this locator.
  FrameLocator get contentFrame => FrameLocator(frame, selector);

  /// Creates a frame locator for the given selector within this locator.
  FrameLocator frameLocator(String selectorOrLocator) =>
      FrameLocator(frame, '$selector >> $selectorOrLocator');

  /// Returns the page this locator belongs to.
  Page get page => frame.page;

  /// Creates a locator with a description for debugging.
  Locator describe(String description) => Locator(
    frame,

    '$selector >> internal:describe=${jsonEncode(description)}',
  );

  Future<Locator> normalize() async {
    final result = await resolveSelector();

    return Locator(frame, result.resolvedSelector);
  }

  Future<R> _withElement<R>(
    Future<R> Function(ElementHandle handle) task, {

    double? timeout,
  }) async {
    final result = await (frame as FrameImpl).channel_waitForSelector(
      selector: selector,

      state: FrameWaitForSelectorStateEnum.attached,

      strict: true,

      timeout: timeout ?? 30000.0,
    );

    final handle = result.element;

    if (handle == null) {
      throw Exception('Could not resolve $selector to DOM Element');
    }

    try {
      return await task(handle as ElementHandle);
    } finally {
      await (handle as ElementHandleImpl).dispose();
    }
  }

  Locator locator(String selectorOrLocator) {
    return Locator(frame, '$selector >> $selectorOrLocator');
  }

  Locator getByText(Pattern text, {bool exact = false}) {
    return locator(
      'internal:text=${encodePatternForTextSelector(text, exact: exact)}',
    );
  }

  Locator getByRole(String role, {Pattern? name, bool exact = false}) {
    var sel = 'internal:role=$role';

    if (name != null) {
      sel += '[name=${encodePatternForRoleName(name, exact: exact)}]';
    }

    return locator(sel);
  }

  Locator getByLabel(Pattern text, {bool exact = false}) {
    return locator(
      'internal:label=${encodePatternForLabelSelector(text, exact: exact)}',
    );
  }

  Locator getByPlaceholder(Pattern text, {bool exact = false}) {
    return locator(
      'internal:attr=[placeholder=${encodePatternForAttrSelector(text, exact: exact)}]',
    );
  }

  Locator getByAltText(Pattern text, {bool exact = false}) {
    return locator(
      'internal:attr=[alt=${encodePatternForAttrSelector(text, exact: exact)}]',
    );
  }

  Locator getByTitle(Pattern text, {bool exact = false}) {
    return locator(
      'internal:attr=[title=${encodePatternForAttrSelector(text, exact: exact)}]',
    );
  }

  Locator getByTestId(String testId) {
    return locator(getByTestIdSelector(testId));
  }

  /// Click an element.

  ///

  /// It will wait for the element to be visible, enabled and stable.

  Future<void> click({bool? force, double? timeout}) async {
    Logger.debug('click "$selector"', name: 'playwright.locator');
    await (frame as FrameImpl).channel_click(
      selector: selector,

      force: force,

      timeout: timeout ?? 30000.0,
    );
  }

  /// Fills an `<input>`, `<textarea>` or `[contenteditable]` element with the provided value.

  Future<void> fill(String value, {bool? force, double? timeout}) async {
    Logger.debug('fill "$selector" ← "$value"', name: 'playwright.locator');
    await (frame as FrameImpl).channel_fill(
      selector: selector,

      value: value,

      force: force,

      timeout: timeout ?? 30000.0,
    );
  }

  /// Clears the input element by filling it with an empty string.

  Future<void> clear({bool? force, double? timeout}) =>
      fill('', force: force, timeout: timeout);

  Future<void> setChecked(bool checked, {bool? force, double? timeout}) async {
    if (checked) {
      await check(force: force, timeout: timeout);
    } else {
      await uncheck(force: force, timeout: timeout);
    }
  }

  Future<void> check({bool? force, double? timeout}) async {
    Logger.debug('check "$selector"', name: 'playwright.locator');
    await (frame as FrameImpl).channel_check(
      selector: selector,

      force: force,

      timeout: timeout ?? 30000.0,
    );
  }

  Future<void> uncheck({bool? force, double? timeout}) async {
    Logger.debug('uncheck "$selector"', name: 'playwright.locator');
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
    Logger.debug('hover "$selector"', name: 'playwright.locator');
    await (frame as FrameImpl).channel_hover(
      selector: selector,

      force: force,

      timeout: timeout ?? 30000.0,
    );
  }

  Future<void> focus({double? timeout}) async {
    Logger.debug('focus "$selector"', name: 'playwright.locator');
    await (frame as FrameImpl).channel_focus(
      selector: selector,

      timeout: timeout ?? 30000.0,
    );
  }

  Future<void> blur({double? timeout}) async {
    Logger.debug('blur "$selector"', name: 'playwright.locator');
    await (frame as FrameImpl).channel_blur(
      selector: selector,

      timeout: timeout ?? 30000.0,
    );
  }

  Future<void> dblclick({bool? force, double? timeout}) async {
    Logger.debug('dblclick "$selector"', name: 'playwright.locator');
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
    Logger.debug('type "$selector" ← "$text"', name: 'playwright.locator');
    await (frame as FrameImpl).channel_type(
      selector: selector,

      text: text,

      delay: delay,

      timeout: timeout ?? 30000.0,
    );
  }

  /// Types text character by character. Alias for [type].

  Future<void> pressSequentially(
    String text, {

    double? delay,

    double? timeout,
  }) => type(text, delay: delay, timeout: timeout);

  /// Focuses the element, and then uses keyboard to press the given key.

  Future<void> press(String key, {double? delay, double? timeout}) async {
    Logger.debug('press "$selector" ← "$key"', name: 'playwright.locator');
    await (frame as FrameImpl).channel_press(
      selector: selector,

      key: key,

      delay: delay,

      timeout: timeout ?? 30000.0,
    );
  }

  Future<void> tap({bool? force, double? timeout}) async {
    Logger.debug('tap "$selector"', name: 'playwright.locator');
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

  /// Returns the number of elements matching the locator.

  Future<int> count() => frame.queryCount(selector);

  /// Returns an array of locators, one for each matching element.

  Future<List<Locator>> all() async {
    final n = await count();

    return List.generate(n, nth);
  }

  /// Returns an array of innerText values for all matching elements.

  Future<List<String>> allInnerTexts() async {
    final result = await frame.evalOnSelectorAll(
      selector,

      'elements => elements.map(e => e.innerText)',
    );

    return (result as List).cast<String>();
  }

  /// Returns an array of textContent values for all matching elements.

  Future<List<String>> allTextContents() async {
    final result = await frame.evalOnSelectorAll(
      selector,

      'elements => elements.map(e => e.textContent || "")',
    );

    return (result as List).cast<String>();
  }

  /// Resolves to the first matching element handle.

  Future<ElementHandle> elementHandle({double? timeout}) async {
    final result = await (frame as FrameImpl).channel_waitForSelector(
      selector: selector,

      state: FrameWaitForSelectorStateEnum.attached,

      strict: true,

      timeout: timeout ?? 30000.0,
    );

    final handle = result.element;

    if (handle == null) {
      throw Exception('Could not resolve $selector to DOM Element');
    }

    return handle as ElementHandle;
  }

  /// Resolves to all matching element handles.

  Future<List<ElementHandle>> elementHandles() async {
    final result = await (frame as FrameImpl).channel_querySelectorAll(
      selector: selector,
    );

    return result.elements.cast<ElementHandle>();
  }

  Future<Rect?> boundingBox({double? timeout}) =>
      _withElement((h) => h.boundingBox(), timeout: timeout);

  Future<void> scrollIntoViewIfNeeded({double? timeout}) => _withElement(
    (h) => h.scrollIntoViewIfNeeded(timeout: timeout),

    timeout: timeout,
  );

  Future<void> selectText({bool? force, double? timeout}) => _withElement(
    (h) => h.selectText(force: force, timeout: timeout),

    timeout: timeout,
  );

  Future<Uint8List> screenshot({
    CommonScreenshotOptions? options,

    double? timeout,

    String? type,

    int? quality,
  }) async {
    final bytes = await _withElement(
      (h) => h.screenshot(
        options: options,

        timeout: timeout ?? 30000.0,

        type: type,

        quality: quality,
      ),

      timeout: timeout,
    );

    return Uint8List.fromList(bytes);
  }
}
