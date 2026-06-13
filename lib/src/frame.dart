import 'channel_owner.dart';
import 'generated/channels.dart';
import 'jshandle.dart';
import 'locator.dart';
import 'serialization.dart';

class Frame extends FrameBase {
  Frame(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  /// Returns a locator for the given selector.
  Locator locator(String selector) {
    return Locator(this, selector);
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

  /// Goto URL
  Future<void> goto(String url, {double? timeout}) async {
    await channel_goto(url: url, timeout: timeout ?? 30000.0);
  }

  Future<String> textContent({
    required String selector,
    double? timeout,
  }) async {
    final result = await channel_textContent(
      selector: selector,
      timeout: timeout ?? 30000.0,
    );
    return result.value as String;
  }

  Future<dynamic> evaluate(String expression, [dynamic arg]) async {
    final result = await channel_evaluateExpression(
      expression: expression,
      arg: serializeArgument(arg),
    );
    return parseSerializedValue(result.value);
  }

  Future<void> waitForSelector(
    String selector, {
    FrameWaitForSelectorStateEnum? state,
    double? timeout,
  }) async {
    await channel_waitForSelector(
      selector: selector,
      state: state,
      timeout: timeout ?? 30000.0,
    );
  }

  Future<void> dragAndDrop(
    String source,
    String target, {
    bool? force,
    double? timeout,
  }) async {
    await channel_dragAndDrop(
      source: source,
      target: target,
      force: force,
      timeout: timeout ?? 30000.0,
    );
  }

  Future<void> click(String selector, {bool? force, double? timeout}) async {
    await channel_click(
      selector: selector,
      force: force,
      timeout: timeout ?? 30000.0,
    );
  }

  Future<void> fill(
    String selector,
    String value, {
    bool? force,
    double? timeout,
  }) async {
    await channel_fill(
      selector: selector,
      value: value,
      force: force,
      timeout: timeout ?? 30000.0,
    );
  }

  Future<void> check(String selector, {bool? force, double? timeout}) async {
    await channel_check(
      selector: selector,
      force: force,
      timeout: timeout ?? 30000.0,
    );
  }

  Future<void> uncheck(String selector, {bool? force, double? timeout}) async {
    await channel_uncheck(
      selector: selector,
      force: force,
      timeout: timeout ?? 30000.0,
    );
  }

  Future<void> hover(String selector, {bool? force, double? timeout}) async {
    await channel_hover(
      selector: selector,
      force: force,
      timeout: timeout ?? 30000.0,
    );
  }

  Future<void> focus(String selector, {double? timeout}) async {
    await channel_focus(selector: selector, timeout: timeout ?? 30000.0);
  }

  Future<void> blur(String selector, {double? timeout}) async {
    await channel_blur(selector: selector, timeout: timeout ?? 30000.0);
  }

  Future<void> dblclick(String selector, {bool? force, double? timeout}) async {
    await channel_dblclick(
      selector: selector,
      force: force,
      timeout: timeout ?? 30000.0,
    );
  }

  Future<void> type(
    String selector,
    String text, {
    double? delay,
    double? timeout,
  }) async {
    await channel_type(
      selector: selector,
      text: text,
      delay: delay,
      timeout: timeout ?? 30000.0,
    );
  }

  Future<void> press(
    String selector,
    String key, {
    double? delay,
    double? timeout,
  }) async {
    await channel_press(
      selector: selector,
      key: key,
      delay: delay,
      timeout: timeout ?? 30000.0,
    );
  }

  Future<void> tap(String selector, {bool? force, double? timeout}) async {
    await channel_tap(
      selector: selector,
      force: force,
      timeout: timeout ?? 30000.0,
    );
  }

  Future<String> content() async {
    final result = await channel_content();
    return result.value;
  }

  Future<void> setContent(String html, {double? timeout}) async {
    await channel_setContent(html: html, timeout: timeout ?? 30000.0);
  }

  Future<dynamic> evalOnSelector(
    String selector,
    String expression, [
    dynamic arg,
  ]) async {
    final result = await channel_evalOnSelector(
      selector: selector,
      expression: expression,
      arg: serializeArgument(arg),
    );
    return parseSerializedValue(result.value);
  }

  Future<dynamic> evalOnSelectorAll(
    String selector,
    String expression, [
    dynamic arg,
  ]) async {
    final result = await channel_evalOnSelectorAll(
      selector: selector,
      expression: expression,
      arg: serializeArgument(arg),
    );
    return parseSerializedValue(result.value);
  }

  Future<String?> getAttribute(
    String selector,
    String name, {
    double? timeout,
  }) async {
    final result = await channel_getAttribute(
      selector: selector,
      name: name,
      timeout: timeout ?? 30000.0,
    );
    return result.value;
  }

  Future<String> innerHTML(String selector, {double? timeout}) async {
    final result = await channel_innerHTML(
      selector: selector,
      timeout: timeout ?? 30000.0,
    );
    return result.value;
  }

  Future<String> innerText(String selector, {double? timeout}) async {
    final result = await channel_innerText(
      selector: selector,
      timeout: timeout ?? 30000.0,
    );
    return result.value;
  }

  Future<String> inputValue(String selector, {double? timeout}) async {
    final result = await channel_inputValue(
      selector: selector,
      timeout: timeout ?? 30000.0,
    );
    return result.value;
  }

  Future<String> title() async {
    final result = await channel_title();
    return result.value;
  }

  Future<bool> isChecked(String selector, {double? timeout}) async {
    final result = await channel_isChecked(
      selector: selector,
      timeout: timeout ?? 30000.0,
    );
    return result.value;
  }

  Future<bool> isDisabled(String selector, {double? timeout}) async {
    final result = await channel_isDisabled(
      selector: selector,
      timeout: timeout ?? 30000.0,
    );
    return result.value;
  }

  Future<bool> isEnabled(String selector, {double? timeout}) async {
    final result = await channel_isEnabled(
      selector: selector,
      timeout: timeout ?? 30000.0,
    );
    return result.value;
  }

  Future<bool> isHidden(String selector) async {
    final result = await channel_isHidden(selector: selector);
    return result.value;
  }

  Future<bool> isVisible(String selector) async {
    final result = await channel_isVisible(selector: selector);
    return result.value;
  }

  Future<bool> isEditable(String selector, {double? timeout}) async {
    final result = await channel_isEditable(
      selector: selector,
      timeout: timeout ?? 30000.0,
    );
    return result.value;
  }

  Future<void> addScriptTag({
    String? url,
    String? content,
    String? type,
  }) async {
    await channel_addScriptTag(url: url, content: content, type: type);
  }

  Future<void> addStyleTag({String? url, String? content}) async {
    await channel_addStyleTag(url: url, content: content);
  }

  Future<void> waitForTimeout(double timeout) async {
    await channel_waitForTimeout(waitTimeout: timeout);
  }

  Future<dynamic> waitForFunction(
    String expression, [
    dynamic arg,
    double? timeout,
    double? pollingInterval,
  ]) async {
    final result = await channel_waitForFunction(
      expression: expression,
      arg: serializeArgument(arg),
      timeout: timeout ?? 30000.0,
      pollingInterval: pollingInterval,
    );
    return result.handle as JSHandle;
  }

  Future<void> dispatchEvent(
    String selector,
    String type, {
    dynamic eventInit,
    double? timeout,
  }) async {
    await channel_dispatchEvent(
      selector: selector,
      type: type,
      eventInit: serializeArgument(eventInit),
      timeout: timeout ?? 30000.0,
    );
  }

  Future<void> highlight(String selector) async {
    await channel_highlight(selector: selector);
  }

  Future<void> hideHighlight(String selector) async {
    await channel_hideHighlight(selector: selector);
  }

  Future<void> drop(
    String selector, {
    List<Map<String, dynamic>>? payloads,
    List<String>? localPaths,
    List<Map<String, dynamic>>? data,
    bool? strict,
    double? timeout,
  }) async {
    await channel_drop(
      selector: selector,
      strict: strict,
      payloads: payloads,
      localPaths: localPaths,
      data: data,
      timeout: timeout ?? 30000.0,
    );
  }

  Future<FrameResolveSelectorResult> resolveSelector(String selector) async {
    return await channel_resolveSelector(selector: selector);
  }

  Future<FrameAriaSnapshotResult> ariaSnapshot(
    String selector, {
    FrameAriaSnapshotModeEnum? mode,
    String? track,
    int? depth,
    bool? boxes,
    double? timeout,
  }) async {
    return await channel_ariaSnapshot(
      selector: selector,
      mode: mode,
      track: track,
      depth: depth,
      boxes: boxes,
      timeout: timeout ?? 30000.0,
    );
  }

  Future<dynamic> evaluateExpression(
    String expression, {
    bool? isFunction,
    dynamic arg,
  }) async {
    final result = await channel_evaluateExpression(
      expression: expression,
      isFunction: isFunction,
      arg: serializeArgument(arg),
    );
    return parseSerializedValue(result.value);
  }

  Future<dynamic> evaluateExpressionHandle(
    String expression, {
    bool? isFunction,
    dynamic arg,
  }) async {
    final result = await channel_evaluateExpressionHandle(
      expression: expression,
      isFunction: isFunction,
      arg: serializeArgument(arg),
    );
    return ChannelOwner.from(connection, result.handle as Map<String, dynamic>);
  }

  Future<dynamic> frameElement() async {
    final result = await channel_frameElement();
    return ChannelOwner.from(
      connection,
      result.element as Map<String, dynamic>,
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
  }) async {
    return await channel_expect(
      selector: selector,
      expression: expression,
      expectedValue: expectedValue,
      expectedText: expectedText,
      expectedNumber: expectedNumber,
      useInnerText: useInnerText,
      isNot: isNot,
      timeout: timeout ?? 30000.0,
    );
  }

  Locator querySelector(String selector) {
    return locator(selector);
  }

  Future<List<Locator>> querySelectorAll(String selector) async {
    final result = await channel_querySelectorAll(selector: selector);
    final elements = result.elements as List? ?? [];
    return elements.map((_) => locator(selector)).toList();
  }

  Future<int> queryCount(String selector) async {
    final result = await channel_queryCount(selector: selector);
    return result.value;
  }

  Future<List<String>> selectOption(
    String selector,
    dynamic values, {
    bool? force,
    double? timeout,
  }) async {
    final parsed = parseSelectOptions(values);
    final result = await channel_selectOption(
      selector: selector,
      elements: parsed.elements,
      options: parsed.options,
      force: force,
      timeout: timeout ?? 30000.0,
    );
    return (result.values as List).cast<String>();
  }

  Future<void> setInputFiles(
    String selector,
    dynamic files, {
    bool? noWaitAfter,
    double? timeout,
  }) async {
    final parsed = parseInputFiles(files);
    await channel_setInputFiles(
      selector: selector,
      payloads: parsed.payloads,
      localPaths: parsed.localPaths,
      timeout: timeout ?? 30000.0,
    );
  }
}
