import '../infrastructure/channel_owner.dart';
import '../generated/channels.dart';
import 'jshandle.dart';
import '../infrastructure/serialization.dart';
// Re-exports Node, Element, etc. from package:html/dom.dart
import '../infrastructure/html_node.dart';
import '../core/frame.dart';
import 'dart:convert';

/// A handle to a DOM element in the browser page.
///
/// The optional type parameter [T] mirrors the TypeScript SDK's
/// `ElementHandle<T extends Node = Node>` generic, where [Node] is
/// `package:html`'s DOM [Node] class.  It carries type information about
/// the underlying DOM element kind without impacting runtime behaviour.
///
/// [ElementHandle] extends [JSHandle] because every DOM element is also a
/// JavaScript value — the same relationship as in the TypeScript SDK where
/// `ElementHandle<T extends Node> extends JSHandle<T>`.
///
/// ```dart
/// import 'package:html/dom.dart' show Element;
///
/// // Default: any DOM node
/// final ElementHandle<Node> handle = await page.querySelector('div');
///
/// // Narrowed to Element (any HTML element):
/// final ElementHandle<Element> el = handle as ElementHandle<Element>;
/// await el.click();
/// ```
abstract interface class ElementHandle<T extends Node> implements JSHandle<T> {
  Future<dynamic> evalOnSelector(
    String selector,
    String expression, [
    dynamic arg,
    bool? strict,
    bool? isFunction,
  ]);
  Future<dynamic> evalOnSelectorAll(
    String selector,
    String expression, [
    dynamic arg,
    bool? isFunction,
  ]);
  Future<void> click({
    bool? force,
    double? timeout,
    bool? trial,
    bool? noWaitAfter,
    List<ElementHandleClickModifiersEnum>? modifiers,
    Point? position,
    double? delay,
    ElementHandleClickButtonEnum? button,
    int? clickCount,
    int? steps,
  });
  Future<void> dblclick({
    bool? force,
    double? timeout,
    bool? trial,
    List<ElementHandleDblclickModifiersEnum>? modifiers,
    Point? position,
    double? delay,
    ElementHandleDblclickButtonEnum? button,
    int? steps,
  });
  Future<void> fill(String value, {bool? force, double? timeout});
  Future<void> hover({
    bool? force,
    double? timeout,
    bool? trial,
    List<ElementHandleHoverModifiersEnum>? modifiers,
    Point? position,
  });
  Future<void> focus();
  Future<void> type(String text, {double? delay, double? timeout});
  Future<void> press(
    String key, {
    double? delay,
    double? timeout,
    bool? noWaitAfter,
  });
  Future<void> tap({
    bool? force,
    double? timeout,
    bool? trial,
    List<ElementHandleTapModifiersEnum>? modifiers,
    Point? position,
  });
  Future<void> check({
    bool? force,
    double? timeout,
    bool? trial,
    Point? position,
  });
  Future<void> uncheck({
    bool? force,
    double? timeout,
    bool? trial,
    Point? position,
  });
  Future<void> scrollIntoViewIfNeeded({double? timeout});
  Future<String?> getAttribute(String name);
  Future<String> innerHTML();
  Future<String> innerText();
  Future<String> inputValue();
  Future<String> textContent();
  Future<bool> isChecked();
  Future<bool> isDisabled();
  Future<bool> isEditable();
  Future<bool> isEnabled();
  Future<bool> isHidden();
  Future<bool> isVisible();
  Future<Rect?> boundingBox();
  Future<Frame?> contentFrame();
  Future<Frame?> ownerFrame();
  Future<ElementHandle?> querySelector(String selector, {bool? strict});
  Future<List<ElementHandle>> querySelectorAll(String selector);
  Future<void> dispatchEvent(String type, {dynamic eventInit});
  Future<List<int>> screenshot({
    CommonScreenshotOptions? options,
    required double timeout,
    String? type,
    int? quality,
  });
  Future<List<String>> selectOption({
    dynamic values,
    bool? force,
    double? timeout,
    List<ElementHandle>? elements,
    List<ElementHandleSelectOptionOptionsItems>? options,
  });
  Future<void> selectText({bool? force, double? timeout});
  Future<void> setInputFiles(
    List<String> files, {
    double? timeout,
    List<ElementHandleSetInputFilesPayloadsItems>? payloads,
    String? localDirectory,
    ChannelOwner? directoryStream,
    List<String>? localPaths,
    List<ChannelOwner>? streams,
  });
  Future<void> waitForElementState(
    ElementHandleWaitForElementStateStateEnum state, {
    double? timeout,
  });
  Future<ElementHandle?> waitForSelector(
    String selector, {
    bool? strict,
    ElementHandleWaitForSelectorStateEnum? state,
    double? timeout,
  });
}

class ElementHandleImpl extends ElementHandleBase
    implements ElementHandle<Node>, JSHandle<Node> {
  @override
  ElementHandle<Node>? asElement() => this;

  @override
  Stream<dynamic> get onPreviewUpdated {
    return onEvent
        .where((e) => e['event'] == 'previewUpdated')
        .map((e) => e['params']['preview']);
  }

  ElementHandleImpl(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  @override
  Future<dynamic> evaluate(
    String expression, [
    dynamic arg,
    bool? isFunction,
  ]) async {
    final result = await channel_evaluateExpression(
      expression: expression,
      arg: serializeArgument(arg),
      isFunction: isFunction,
    );
    return parseSerializedValue(result.value);
  }

  @override
  Future<JSHandle<Object?>> evaluateHandle(
    String expression, [
    dynamic arg,
    bool? isFunction,
  ]) async {
    final result = await channel_evaluateExpressionHandle(
      expression: expression,
      arg: serializeArgument(arg),
      isFunction: isFunction,
    );
    return result.handle as JSHandle<Object?>;
  }

  @override
  Future<dynamic> evaluateExpression(
    String expression, [
    dynamic arg,
    bool? isFunction,
  ]) => evaluate(expression, arg, isFunction);

  @override
  Future<JSHandle<Object?>> evaluateExpressionHandle(
    String expression, [
    dynamic arg,
    bool? isFunction,
  ]) => evaluateHandle(expression, arg, isFunction);

  @override
  Future<JSHandle<Object?>> getProperty(String name) async {
    final result = await channel_getProperty(name: name);
    return ChannelOwner.from<JSHandleImpl>(
      connection,
      result.handle as Map<String, dynamic>,
    );
  }

  @override
  Future<Map<String, JSHandle<Object?>>> getProperties() async {
    final result = await channel_getPropertyList();
    final map = <String, JSHandle<Object?>>{};
    for (final property in result.properties as List) {
      map[property['name'] as String] = ChannelOwner.from<JSHandleImpl>(
        connection,
        property['value'] as Map<String, dynamic>,
      );
    }
    return map;
  }

  @override
  Future<Map<String, JSHandle<Object?>>> getPropertyList() => getProperties();

  @override
  Future<dynamic> jsonValue() async {
    final result = await channel_jsonValue();
    return parseSerializedValue(result.value);
  }

  @override
  Future<void> dispose() async {
    await channel_dispose();
  }

  @override
  Future<dynamic> evalOnSelector(
    String selector,
    String expression, [
    dynamic arg,
    bool? strict,
    bool? isFunction,
  ]) async {
    final result = await channel_evalOnSelector(
      selector: selector,
      expression: expression,
      arg: serializeArgument(arg),
      strict: strict,
      isFunction: isFunction,
    );
    return parseSerializedValue(result.value);
  }

  @override
  Future<dynamic> evalOnSelectorAll(
    String selector,
    String expression, [
    dynamic arg,
    bool? isFunction,
  ]) async {
    final result = await channel_evalOnSelectorAll(
      selector: selector,
      expression: expression,
      arg: serializeArgument(arg),
      isFunction: isFunction,
    );
    return parseSerializedValue(result.value);
  }

  // Element actions
  @override
  Future<void> click({
    bool? force,
    double? timeout,
    bool? trial,
    bool? noWaitAfter,
    List<ElementHandleClickModifiersEnum>? modifiers,
    Point? position,
    double? delay,
    ElementHandleClickButtonEnum? button,
    int? clickCount,
    int? steps,
  }) async {
    await channel_click(
      force: force,
      timeout: timeout ?? 30000.0,
      trial: trial,
      noWaitAfter: noWaitAfter,
      modifiers: modifiers,
      position: position,
      delay: delay,
      button: button,
      clickCount: clickCount,
      steps: steps,
    );
  }

  @override
  Future<void> dblclick({
    bool? force,
    double? timeout,
    bool? trial,
    List<ElementHandleDblclickModifiersEnum>? modifiers,
    Point? position,
    double? delay,
    ElementHandleDblclickButtonEnum? button,
    int? steps,
  }) async {
    await channel_dblclick(
      force: force,
      timeout: timeout ?? 30000.0,
      trial: trial,
      modifiers: modifiers,
      position: position,
      delay: delay,
      button: button,
      steps: steps,
    );
  }

  @override
  Future<void> fill(String value, {bool? force, double? timeout}) async {
    await channel_fill(value: value, force: force, timeout: timeout ?? 30000.0);
  }

  @override
  Future<void> hover({
    bool? force,
    double? timeout,
    bool? trial,
    List<ElementHandleHoverModifiersEnum>? modifiers,
    Point? position,
  }) async {
    await channel_hover(
      force: force,
      timeout: timeout ?? 30000.0,
      trial: trial,
      modifiers: modifiers,
      position: position,
    );
  }

  @override
  Future<void> focus() async {
    await channel_focus();
  }

  @override
  Future<void> type(String text, {double? delay, double? timeout}) async {
    await channel_type(text: text, delay: delay, timeout: timeout ?? 30000.0);
  }

  @override
  Future<void> press(
    String key, {
    double? delay,
    double? timeout,
    bool? noWaitAfter,
  }) async {
    await channel_press(
      key: key,
      delay: delay,
      timeout: timeout ?? 30000.0,
      noWaitAfter: noWaitAfter,
    );
  }

  @override
  Future<void> tap({
    bool? force,
    double? timeout,
    bool? trial,
    List<ElementHandleTapModifiersEnum>? modifiers,
    Point? position,
  }) async {
    await channel_tap(
      force: force,
      timeout: timeout ?? 30000.0,
      trial: trial,
      modifiers: modifiers,
      position: position,
    );
  }

  @override
  Future<void> check({
    bool? force,
    double? timeout,
    bool? trial,
    Point? position,
  }) async {
    await channel_check(
      force: force,
      timeout: timeout ?? 30000.0,
      trial: trial,
      position: position,
    );
  }

  @override
  Future<void> uncheck({
    bool? force,
    double? timeout,
    bool? trial,
    Point? position,
  }) async {
    await channel_uncheck(
      force: force,
      timeout: timeout ?? 30000.0,
      trial: trial,
      position: position,
    );
  }

  @override
  Future<void> scrollIntoViewIfNeeded({double? timeout}) async {
    await channel_scrollIntoViewIfNeeded(timeout: timeout ?? 30000.0);
  }

  // State
  @override
  Future<String?> getAttribute(String name) async {
    final result = await channel_getAttribute(name: name);
    return result.value;
  }

  @override
  Future<String> innerHTML() async {
    final result = await channel_innerHTML();
    return result.value;
  }

  @override
  Future<String> innerText() async {
    final result = await channel_innerText();
    return result.value;
  }

  @override
  Future<String> inputValue() async {
    final result = await channel_inputValue();
    return result.value;
  }

  @override
  Future<String> textContent() async {
    final result = await channel_textContent();
    return result.value as String;
  }

  @override
  Future<bool> isChecked() async {
    final result = await channel_isChecked();
    return result.value;
  }

  @override
  Future<bool> isDisabled() async {
    final result = await channel_isDisabled();
    return result.value;
  }

  @override
  Future<bool> isEditable() async {
    final result = await channel_isEditable();
    return result.value;
  }

  @override
  Future<bool> isEnabled() async {
    final result = await channel_isEnabled();
    return result.value;
  }

  @override
  Future<bool> isHidden() async {
    final result = await channel_isHidden();
    return result.value;
  }

  @override
  Future<bool> isVisible() async {
    final result = await channel_isVisible();
    return result.value;
  }

  @override
  Future<Rect?> boundingBox() async {
    final result = await channel_boundingBox();
    return result.value;
  }

  @override
  Future<Frame?> contentFrame() async {
    final result = await channel_contentFrame();
    return result.frame as Frame?;
  }

  @override
  Future<Frame?> ownerFrame() async {
    final result = await channel_ownerFrame();
    return result.frame as Frame?;
  }

  @override
  Future<ElementHandle?> querySelector(String selector, {bool? strict}) async {
    final result = await channel_querySelector(
      selector: selector,
      strict: strict,
    );
    return result.element as ElementHandle?;
  }

  @override
  Future<List<ElementHandle>> querySelectorAll(String selector) async {
    final result = await channel_querySelectorAll(selector: selector);
    final elements = result.elements as List;
    return elements.cast<ElementHandle>();
  }

  @override
  Future<void> dispatchEvent(String type, {dynamic eventInit}) async {
    await channel_dispatchEvent(
      type: type,
      eventInit: serializeArgument(eventInit),
    );
  }

  @override
  Future<List<int>> screenshot({
    CommonScreenshotOptions? options,
    required double timeout,
    String? type,
    int? quality,
  }) async {
    final result = await channel_screenshot(
      commonScreenshotOptions: options ?? CommonScreenshotOptions(),
      timeout: timeout,
      type: type != null
          ? ElementHandleScreenshotTypeEnum.values.firstWhere(
              (e) => e.value == type,
            )
          : null,
      quality: quality,
    );
    return base64Decode(result.binary);
  }

  @override
  Future<List<String>> selectOption({
    dynamic values,
    bool? force,
    double? timeout,
    List<ElementHandle>? elements,
    List<ElementHandleSelectOptionOptionsItems>? options,
  }) async {
    List<ElementHandleSelectOptionOptionsItems>? finalOptions = options;
    if (finalOptions == null && values != null) {
      finalOptions = [];
      if (values is String) {
        finalOptions.add(
          ElementHandleSelectOptionOptionsItems(valueOrLabel: values),
        );
      } else if (values is List) {
        finalOptions.addAll(
          values.map(
            (v) => ElementHandleSelectOptionOptionsItems(
              valueOrLabel: v.toString(),
            ),
          ),
        );
      }
    }

    final result = await channel_selectOption(
      elements: elements?.cast<ElementHandleImpl>(),
      options: finalOptions?.isNotEmpty == true ? finalOptions : null,
      force: force,
      timeout: timeout ?? 30000.0,
    );
    return (result.values as List).cast<String>();
  }

  @override
  Future<void> selectText({bool? force, double? timeout}) async {
    await channel_selectText(force: force, timeout: timeout ?? 30000.0);
  }

  @override
  Future<void> setInputFiles(
    List<String> files, {
    double? timeout,
    List<ElementHandleSetInputFilesPayloadsItems>? payloads,
    String? localDirectory,
    ChannelOwner? directoryStream,
    List<String>? localPaths,
    List<ChannelOwner>? streams,
  }) async {
    await channel_setInputFiles(
      localPaths: localPaths ?? files,
      timeout: timeout ?? 30000.0,
      payloads: payloads,
      localDirectory: localDirectory,
      directoryStream: directoryStream as WritableStreamBase?,
      streams: streams?.map((s) => s as WritableStreamBase).toList(),
    );
  }

  @override
  Future<void> waitForElementState(
    ElementHandleWaitForElementStateStateEnum state, {
    double? timeout,
  }) async {
    await channel_waitForElementState(
      state: state,
      timeout: timeout ?? 30000.0,
    );
  }

  @override
  Future<ElementHandle?> waitForSelector(
    String selector, {
    bool? strict,
    ElementHandleWaitForSelectorStateEnum? state,
    double? timeout,
  }) async {
    final result = await channel_waitForSelector(
      selector: selector,
      strict: strict,
      state: state,
      timeout: timeout ?? 30000.0,
    );
    return result.element as ElementHandle?;
  }
}
