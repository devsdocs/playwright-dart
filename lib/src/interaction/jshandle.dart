import '../infrastructure/channel_owner.dart';
import 'element_handle.dart';
import '../generated/channels.dart';
import '../infrastructure/serialization.dart';

/// Interface for JSHandle
abstract interface class JSHandle {
  Stream<dynamic> get onPreviewUpdated;
  Future<dynamic> evaluate(String expression, [dynamic arg, bool? isFunction]);
  Future<JSHandle> evaluateHandle(
    String expression, [
    dynamic arg,
    bool? isFunction,
  ]);
  Future<dynamic> evaluateExpression(
    String expression, [
    dynamic arg,
    bool? isFunction,
  ]);
  Future<JSHandle> evaluateExpressionHandle(
    String expression, [
    dynamic arg,
    bool? isFunction,
  ]);
  Future<JSHandle> getProperty(String name);
  Future<Map<String, JSHandle>> getProperties();
  Future<Map<String, JSHandle>> getPropertyList();
  Future<dynamic> jsonValue();
  ElementHandle? asElement();
  Future<void> dispose();
}

class JSHandleImpl extends JSHandleBase implements JSHandle {
  @override
  Future<void> dispose() async {
    await channel_dispose();
  }

  @override
  ElementHandle? asElement() =>
      this is ElementHandle ? this as ElementHandle : null;

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
  Future<JSHandle> evaluateHandle(
    String expression, [
    dynamic arg,
    bool? isFunction,
  ]) async {
    final result = await channel_evaluateExpressionHandle(
      expression: expression,
      arg: serializeArgument(arg),
      isFunction: isFunction,
    );
    return ChannelOwner.from(connection, result.handle as Map<String, dynamic>);
  }

  @override
  Future<dynamic> evaluateExpression(
    String expression, [
    dynamic arg,
    bool? isFunction,
  ]) => evaluate(expression, arg, isFunction);
  @override
  Future<JSHandle> evaluateExpressionHandle(
    String expression, [
    dynamic arg,
    bool? isFunction,
  ]) => evaluateHandle(expression, arg, isFunction);

  @override
  Future<JSHandle> getProperty(String name) async {
    final result = await super.channel_getProperty(name: name);
    return ChannelOwner.from<JSHandleImpl>(
      connection,
      result.handle as Map<String, dynamic>,
    );
  }

  @override
  Future<Map<String, JSHandle>> getProperties() async {
    final result = await super.channel_getPropertyList();
    final map = <String, JSHandle>{};
    for (final property in result.properties as List) {
      map[property['name'] as String] = ChannelOwner.from<JSHandleImpl>(
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
    final result = await super.channel_jsonValue();
    return parseSerializedValue(result.value);
  }
}
