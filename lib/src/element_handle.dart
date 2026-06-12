import 'channel_owner.dart';
import 'generated/channels.dart';
import 'jshandle.dart';
import 'serialization.dart';

class ElementHandle extends ElementHandleBase implements JSHandle {
  ElementHandle(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  @override
  Future<dynamic> evaluate(String expression, [dynamic arg]) async {
    final result = await channel_evaluateExpression(
      expression: expression,
      arg: serializeArgument(arg),
    );
    return parseSerializedValue(result['value'] as Map<String, dynamic>);
  }

  @override
  Future<JSHandle> evaluateHandle(String expression, [dynamic arg]) async {
    final result = await channel_evaluateExpressionHandle(
      expression: expression,
      arg: serializeArgument(arg),
    );
    return ChannelOwner.from(
      connection,
      result['handle'] as Map<String, dynamic>,
    );
  }

  @override
  Future<void> dispose() async {
    await channel_dispose();
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
    return parseSerializedValue(result['value'] as Map<String, dynamic>);
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
    return parseSerializedValue(result['value'] as Map<String, dynamic>);
  }

  // Element actions
  Future<void> click({bool? force, double? timeout}) async {
    await channel_click(force: force, timeout: timeout ?? 30000.0);
  }

  Future<void> dblclick({bool? force, double? timeout}) async {
    await channel_dblclick(force: force, timeout: timeout ?? 30000.0);
  }

  Future<void> fill(String value, {bool? force, double? timeout}) async {
    await channel_fill(value: value, force: force, timeout: timeout ?? 30000.0);
  }

  Future<void> hover({bool? force, double? timeout}) async {
    await channel_hover(force: force, timeout: timeout ?? 30000.0);
  }

  Future<void> focus() async {
    await channel_focus();
  }

  Future<void> type(String text, {double? delay, double? timeout}) async {
    await channel_type(text: text, delay: delay, timeout: timeout ?? 30000.0);
  }

  Future<void> press(String key, {double? delay, double? timeout}) async {
    await channel_press(key: key, delay: delay, timeout: timeout ?? 30000.0);
  }

  Future<void> tap({bool? force, double? timeout}) async {
    await channel_tap(force: force, timeout: timeout ?? 30000.0);
  }

  Future<void> check({bool? force, double? timeout}) async {
    await channel_check(force: force, timeout: timeout ?? 30000.0);
  }

  Future<void> uncheck({bool? force, double? timeout}) async {
    await channel_uncheck(force: force, timeout: timeout ?? 30000.0);
  }

  Future<void> scrollIntoViewIfNeeded({double? timeout}) async {
    await channel_scrollIntoViewIfNeeded(timeout: timeout ?? 30000.0);
  }

  // State
  Future<String?> getAttribute(String name) async {
    final result = await channel_getAttribute(name: name);
    return result['value'] as String?;
  }

  Future<String> innerHTML() async {
    final result = await channel_innerHTML();
    return result['value'] as String;
  }

  Future<String> innerText() async {
    final result = await channel_innerText();
    return result['value'] as String;
  }

  Future<String> inputValue() async {
    final result = await channel_inputValue();
    return result['value'] as String;
  }

  Future<String> textContent() async {
    final result = await channel_textContent();
    return result['value'] as String;
  }

  Future<bool> isChecked() async {
    final result = await channel_isChecked();
    return result['value'] as bool;
  }

  Future<bool> isDisabled() async {
    final result = await channel_isDisabled();
    return result['value'] as bool;
  }

  Future<bool> isEditable() async {
    final result = await channel_isEditable();
    return result['value'] as bool;
  }

  Future<bool> isEnabled() async {
    final result = await channel_isEnabled();
    return result['value'] as bool;
  }

  Future<bool> isHidden() async {
    final result = await channel_isHidden();
    return result['value'] as bool;
  }

  Future<bool> isVisible() async {
    final result = await channel_isVisible();
    return result['value'] as bool;
  }

  Future<Map<String, dynamic>?> boundingBox() async {
    final result = await channel_boundingBox();
    return result['boundingBox'] as Map<String, dynamic>?;
  }
}
