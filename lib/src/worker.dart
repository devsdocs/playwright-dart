import 'channel_owner.dart';
import 'generated/channels.dart';
import 'jshandle.dart';
import 'serialization.dart';

class Worker extends WorkerBase {
  Worker(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  String get url => initializer['url'] as String;

  Future<void> disconnect({String? reason}) async {
    await channel_disconnect(reason: reason);
  }

  Future<dynamic> evaluate(String expression, [dynamic arg]) async {
    final result = await channel_evaluateExpression(
      expression: expression,
      arg: serializeArgument(arg),
    );
    return parseSerializedValue(result.value as Map<String, dynamic>);
  }

  Future<JSHandle> evaluateHandle(String expression, [dynamic arg]) async {
    final result = await channel_evaluateExpressionHandle(
      expression: expression,
      arg: serializeArgument(arg),
    );
    return ChannelOwner.from<JSHandle>(
      connection,
      result.handle as Map<String, dynamic>,
    );
  }

  // Aliases for missing script check
  Future<dynamic> evaluateExpression(String expression, [dynamic arg]) =>
      evaluate(expression, arg);
  Future<JSHandle> evaluateExpressionHandle(String expression, [dynamic arg]) =>
      evaluateHandle(expression, arg);
  // Unused right now, just for completeness:
  // Future<dynamic> updateSubscription() => channel_updateSubscription();
}
