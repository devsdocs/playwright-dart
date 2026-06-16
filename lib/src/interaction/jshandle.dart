import 'element_handle.dart';
import '../generated/channels.dart';
import '../infrastructure/serialization.dart';
// Re-exports Node, Element, etc. from package:html/dom.dart
import '../infrastructure/html_node.dart';

/// A handle to a JavaScript value in the browser page.
///
/// The optional type parameter [T] mirrors the TypeScript SDK's
/// `JSHandle<T = any>` generic.  It acts as a phantom type that carries
/// information about the underlying JS value without impacting runtime
/// behaviour.
///
/// When [T] is [Node] or a subtype (e.g. [Element]) the handle wraps a DOM
/// node, and [asElement] will return a non-null [ElementHandle].
///
/// ```dart
/// // Untyped handle (equivalent to JSHandle<any>):
/// final handle = await page.evaluateHandle('() => window');
///
/// // Typed as an Element handle:
/// final JSHandle<Element> el =
///     await frame.evaluateHandle('() => document.body');
/// final element = el.asElement(); // non-null because T <: Node
/// ```
abstract interface class JSHandle<T extends Object?> {
  Stream<dynamic> get onPreviewUpdated;
  Future<dynamic> evaluate(String expression, [dynamic arg, bool? isFunction]);
  Future<JSHandle<Object?>> evaluateHandle(
    String expression, [
    dynamic arg,
    bool? isFunction,
  ]);
  Future<dynamic> evaluateExpression(
    String expression, [
    dynamic arg,
    bool? isFunction,
  ]);
  Future<JSHandle<Object?>> evaluateExpressionHandle(
    String expression, [
    dynamic arg,
    bool? isFunction,
  ]);
  Future<JSHandle<Object?>> getProperty(String name);
  Future<Map<String, JSHandle<Object?>>> getProperties();
  Future<Map<String, JSHandle<Object?>>> getPropertyList();
  Future<dynamic> jsonValue();

  /// Returns `null` unless the underlying JavaScript value is a DOM [Node],
  /// in which case it returns this handle narrowed to [ElementHandle].
  ///
  /// Mirrors the TypeScript signature:
  /// `asElement(): T extends Node ? ElementHandle<T> : null`
  ElementHandle<Node>? asElement();

  Future<void> dispose();
}

class JSHandleImpl<T extends Object?> extends JSHandleBase
    implements JSHandle<T> {
  @override
  Future<void> dispose() async {
    await channel_dispose();
  }

  @override
  ElementHandle<Node>? asElement() =>
      this is ElementHandle<Node> ? this as ElementHandle<Node> : null;

  @override
  Stream<dynamic> get onPreviewUpdated {
    return onEvent
        .where((e) => e['event'] == 'previewUpdated')
        .map((e) => e['params']['preview']);
  }

  JSHandleImpl(
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
    final result = await super.channel_getProperty(name: name);
    return result.handle as JSHandle<Object?>;
  }

  @override
  Future<Map<String, JSHandle<Object?>>> getProperties() async {
    final result = await super.channel_getPropertyList();
    final map = <String, JSHandle<Object?>>{};
    for (final property in result.properties) {
      map[property.name] = property.value as JSHandle<Object?>;
    }
    return map;
  }

  @override
  Future<Map<String, JSHandle<Object?>>> getPropertyList() => getProperties();

  @override
  Future<dynamic> jsonValue() async {
    final result = await super.channel_jsonValue();
    return parseSerializedValue(result.value);
  }
}
