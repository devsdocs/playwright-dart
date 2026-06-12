import 'channel_owner.dart';
import 'generated/channels.dart';
import 'serialization.dart';

class JSHandle extends JSHandleBase {
  JSHandle(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  Future<dynamic> evaluate(String expression, [dynamic arg]) async {
    final result = await channel_evaluateExpression(
      expression: expression,
      arg: serializeArgument(arg),
    );
    return parseSerializedValue(result['value'] as Map<String, dynamic>);
  }

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

  Future<dynamic> evaluateExpression(String expression, [dynamic arg]) => evaluate(expression, arg);
  Future<JSHandle> evaluateExpressionHandle(String expression, [dynamic arg]) => evaluateHandle(expression, arg);

  Future<JSHandle> getProperty(String propertyName) async {
    final result = await super.channel_getProperty(name: propertyName);
    return ChannelOwner.from<JSHandle>(connection, result['handle'] as Map<String, dynamic>);
  }

  Future<Map<String, JSHandle>> getProperties() async {
    final result = await super.channel_getPropertyList();
    final map = <String, JSHandle>{};
    for (final property in result['properties'] as List) {
      map[property['name'] as String] = ChannelOwner.from<JSHandle>(
        connection,
        property['value'] as Map<String, dynamic>,
      );
    }
    return map;
  }
  
  Future<Map<String, JSHandle>> getPropertyList() => getProperties();

  Future<dynamic> jsonValue() async {
    final result = await super.channel_jsonValue();
    return parseSerializedValue(result['value'] as Map<String, dynamic>);
  }
}
