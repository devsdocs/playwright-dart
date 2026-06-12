import 'frame.dart';
import 'serialization.dart';

class Locator {
  final Frame frame;
  final String selector;

  Locator(this.frame, this.selector);

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

  Future<void> click({bool? force, double? timeout}) async {
    await frame.channel_click(
      selector: selector,
      force: force,
      timeout: timeout ?? 30000.0,
    );
  }

  Future<void> fill(String value, {bool? force, double? timeout}) async {
    await frame.channel_fill(
      selector: selector,
      value: value,
      force: force,
      timeout: timeout ?? 30000.0,
    );
  }

  Future<void> check({bool? force, double? timeout}) async {
    await frame.channel_check(
      selector: selector,
      force: force,
      timeout: timeout ?? 30000.0,
    );
  }

  Future<void> uncheck({bool? force, double? timeout}) async {
    await frame.channel_uncheck(
      selector: selector,
      force: force,
      timeout: timeout ?? 30000.0,
    );
  }

  Future<String> innerText({double? timeout}) async {
    final result = await frame.channel_innerText(
      selector: selector,
      timeout: timeout ?? 30000.0,
    );
    return result['value'] as String;
  }

  Future<String> textContent({double? timeout}) async {
    final result = await frame.channel_textContent(
      selector: selector,
      timeout: timeout ?? 30000.0,
    );
    return result['value'] as String;
  }

  Future<void> hover({bool? force, double? timeout}) async {
    await frame.channel_hover(
      selector: selector,
      force: force,
      timeout: timeout ?? 30000.0,
    );
  }

  Future<void> focus({double? timeout}) async {
    await frame.channel_focus(selector: selector, timeout: timeout ?? 30000.0);
  }

  Future<void> blur({double? timeout}) async {
    await frame.channel_blur(selector: selector, timeout: timeout ?? 30000.0);
  }

  Future<void> dblclick({bool? force, double? timeout}) async {
    await frame.channel_dblclick(
      selector: selector,
      force: force,
      timeout: timeout ?? 30000.0,
    );
  }

  Future<String?> getAttribute(String name, {double? timeout}) async {
    final result = await frame.channel_getAttribute(
      selector: selector,
      name: name,
      timeout: timeout ?? 30000.0,
    );
    return result['value'] as String?;
  }

  Future<String> inputValue({double? timeout}) async {
    final result = await frame.channel_inputValue(
      selector: selector,
      timeout: timeout ?? 30000.0,
    );
    return result['value'] as String;
  }

  Future<bool> isVisible() async {
    final result = await frame.channel_isVisible(selector: selector);
    return result['value'] as bool;
  }

  Future<String> innerHTML({double? timeout}) async {
    final result = await frame.channel_innerHTML(
      selector: selector,
      timeout: timeout ?? 30000.0,
    );
    return result['value'] as String;
  }

  Future<bool> isEditable({double? timeout}) async {
    final result = await frame.channel_isEditable(
      selector: selector,
      timeout: timeout ?? 30000.0,
    );
    return result['value'] as bool;
  }

  Future<bool> isHidden() async {
    final result = await frame.channel_isHidden(selector: selector);
    return result['value'] as bool;
  }

  Future<bool> isEnabled({double? timeout}) async {
    final result = await frame.channel_isEnabled(
      selector: selector,
      timeout: timeout ?? 30000.0,
    );
    return result['value'] as bool;
  }

  Future<bool> isDisabled({double? timeout}) async {
    final result = await frame.channel_isDisabled(
      selector: selector,
      timeout: timeout ?? 30000.0,
    );
    return result['value'] as bool;
  }

  Future<bool> isChecked({double? timeout}) async {
    final result = await frame.channel_isChecked(
      selector: selector,
      timeout: timeout ?? 30000.0,
    );
    return result['value'] as bool;
  }

  Future<dynamic> evaluateAll(String expression, [dynamic arg]) async {
    return frame.evalOnSelectorAll(selector, expression, arg);
  }

  Future<void> type(String text, {double? delay, double? timeout}) async {
    await frame.channel_type(
      selector: selector,
      text: text,
      delay: delay,
      timeout: timeout ?? 30000.0,
    );
  }

  Future<void> press(String key, {double? delay, double? timeout}) async {
    await frame.channel_press(
      selector: selector,
      key: key,
      delay: delay,
      timeout: timeout ?? 30000.0,
    );
  }

  Future<void> tap({bool? force, double? timeout}) async {
    await frame.channel_tap(
      selector: selector,
      force: force,
      timeout: timeout ?? 30000.0,
    );
  }

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
    await frame.channel_dispatchEvent(
      selector: selector,
      type: type,
      eventInit: serializeArgument(eventInit),
      timeout: timeout ?? 30000.0,
    );
  }

  Future<void> highlight() async {
    await frame.channel_highlight(selector: selector);
  }

  Future<void> hideHighlight() async {
    await frame.channel_hideHighlight(selector: selector);
  }

  Future<void> drop({dynamic data, bool? force, double? timeout}) async {
    throw UnimplementedError('drop not fully mapped yet');
  }

  Future<String?> resolveSelector() async {
    throw UnimplementedError('resolveSelector not fully mapped yet');
  }

  Future<dynamic> ariaSnapshot() async {
    throw UnimplementedError('ariaSnapshot not fully mapped yet');
  }

  Locator querySelector(String subSelector) {
    return locator(subSelector);
  }

  Future<List<Locator>> querySelectorAll(String subSelector) async {
    // This requires counting elements and returning an array of locators
    throw UnimplementedError('querySelectorAll not fully mapped yet');
  }

  Future<int> queryCount(String subSelector) async {
    throw UnimplementedError('queryCount not fully mapped yet');
  }

  Future<dynamic> evaluate(String expression, [dynamic arg]) async {
    // Locator evaluation in Playwright takes the element as the first arg.
    // For simplicity, we just use the frame evaluate and pass the selector,
    // or rely on evalOnSelector which evaluates in the context of the element.
    final result = await frame.channel_evalOnSelector(
      selector: selector,
      expression: expression,
      arg: serializeArgument(arg),
    );
    return parseSerializedValue(result['value'] as Map<String, dynamic>);
  }

  Future<void> waitFor({String? state, double? timeout}) async {
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
