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

  // Properties like getProperty, getProperties, jsonValue, etc. can be added here
}
