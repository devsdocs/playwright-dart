import 'channel_owner.dart';
import 'generated/channels.dart';
import 'jshandle.dart';
import 'serialization.dart';
import 'frame.dart';
import 'dart:convert';

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
  Future<dynamic> evaluateExpression(String expression, [dynamic arg]) =>
      evaluate(expression, arg);

  @override
  Future<JSHandle> evaluateExpressionHandle(String expression, [dynamic arg]) =>
      evaluateHandle(expression, arg);

  @override
  Future<JSHandle> getProperty(String propertyName) async {
    final result = await channel_getProperty(name: propertyName);
    return ChannelOwner.from<JSHandle>(
      connection,
      result['handle'] as Map<String, dynamic>,
    );
  }

  @override
  Future<Map<String, JSHandle>> getProperties() async {
    final result = await channel_getPropertyList();
    final map = <String, JSHandle>{};
    for (final property in result['properties'] as List) {
      map[property['name'] as String] = ChannelOwner.from<JSHandle>(
        connection,
        property['value'] as Map<String, dynamic>,
      );
    }
    return map;
  }

  @override
  Future<Map<String, JSHandle>> getPropertyList() => getProperties();

  @override
  Future<dynamic> jsonValue() async {
    final result = await channel_jsonValue();
    return parseSerializedValue(result['value'] as Map<String, dynamic>);
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

  Future<Frame?> contentFrame() async {
    final result = await channel_contentFrame();
    final frame = result['frame'];
    if (frame == null) return null;
    return ChannelOwner.from<Frame>(connection, frame as Map<String, dynamic>);
  }

  Future<Frame?> ownerFrame() async {
    final result = await channel_ownerFrame();
    final frame = result['frame'];
    if (frame == null) return null;
    return ChannelOwner.from<Frame>(connection, frame as Map<String, dynamic>);
  }

  Future<ElementHandle?> querySelector(String selector, {bool? strict}) async {
    final result = await channel_querySelector(
      selector: selector,
      strict: strict,
    );
    final element = result['element'];
    if (element == null) return null;
    return ChannelOwner.from<ElementHandle>(
      connection,
      element as Map<String, dynamic>,
    );
  }

  Future<List<ElementHandle>> querySelectorAll(String selector) async {
    final result = await channel_querySelectorAll(selector: selector);
    final elements = result['elements'] as List;
    return elements
        .map(
          (e) => ChannelOwner.from<ElementHandle>(
            connection,
            e as Map<String, dynamic>,
          ),
        )
        .toList();
  }

  Future<void> dispatchEvent(String type, {dynamic eventInit}) async {
    await channel_dispatchEvent(
      type: type,
      eventInit: serializeArgument(eventInit),
    );
  }

  Future<List<int>> screenshot({
    double? timeout,
    String? type,
    int? quality,
    CommonScreenshotOptions? mixin,
  }) async {
    final result = await channel_screenshot(
      timeout: timeout ?? 30000.0,
      type: type,
      quality: quality,
      mixin: mixin ?? CommonScreenshotOptions(),
    );
    return base64Decode(result['binary'] as String);
  }

  Future<List<String>> selectOption({
    dynamic values,
    bool? force,
    double? timeout,
  }) async {
    // For now we map string values to options
    List<Map<String, dynamic>> options = [];
    if (values is String) {
      options.add({'valueOrLabel': values});
    } else if (values is List) {
      options.addAll(values.map((v) => {'valueOrLabel': v.toString()}));
    }

    final result = await channel_selectOption(
      options: options.isNotEmpty ? options : null,
      force: force,
      timeout: timeout ?? 30000.0,
    );
    return (result['values'] as List).cast<String>();
  }

  Future<void> selectText({bool? force, double? timeout}) async {
    await channel_selectText(force: force, timeout: timeout ?? 30000.0);
  }

  Future<void> setInputFiles(List<String> files, {double? timeout}) async {
    await channel_setInputFiles(localPaths: files, timeout: timeout ?? 30000.0);
  }

  Future<void> waitForElementState(String state, {double? timeout}) async {
    await channel_waitForElementState(
      state: state,
      timeout: timeout ?? 30000.0,
    );
  }

  Future<ElementHandle?> waitForSelector(
    String selector, {
    bool? strict,
    String? state,
    double? timeout,
  }) async {
    final result = await channel_waitForSelector(
      selector: selector,
      strict: strict,
      state: state,
      timeout: timeout ?? 30000.0,
    );
    final element = result['element'];
    if (element == null) return null;
    return ChannelOwner.from<ElementHandle>(
      connection,
      element as Map<String, dynamic>,
    );
  }
}
