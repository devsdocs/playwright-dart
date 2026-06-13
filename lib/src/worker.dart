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
    return ChannelOwner.from<JSHandle>(
      connection,
      result.handle as Map<String, dynamic>,
    );
  }

  // Aliases for missing script check
  Future<dynamic> evaluateExpression(
    String expression, [
    dynamic arg,
    bool? isFunction,
  ]) => evaluate(expression, arg, isFunction);
  Future<JSHandle> evaluateExpressionHandle(
    String expression, [
    dynamic arg,
    bool? isFunction,
  ]) => evaluateHandle(expression, arg, isFunction);

  Future<void> updateSubscription({
    required WorkerUpdateSubscriptionEventEnum event,
    required bool enabled,
  }) async {
    await channel_updateSubscription(event: event, enabled: enabled);
  }
}
