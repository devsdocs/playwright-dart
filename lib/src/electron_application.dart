import 'generated/channels.dart';
import 'serialization.dart';

class ElectronApplication extends ElectronApplicationBase {
  ElectronApplication(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  Future<ElectronApplicationBrowserWindowResult> browserWindow(
    PageBase page,
  ) async {
    return await channel_browserWindow(page: page);
  }

  Future<dynamic> evaluateExpression(
    String expression, {
    bool? isFunction,
    dynamic arg,
  }) async {
    final result = await channel_evaluateExpression(
      expression: expression,
      isFunction: isFunction,
      arg: serializeArgument(arg),
    );
    return parseSerializedValue(result.value);
  }

  Future<dynamic> evaluateExpressionHandle(
    String expression, {
    bool? isFunction,
    dynamic arg,
  }) async {
    final result = await channel_evaluateExpressionHandle(
      expression: expression,
      isFunction: isFunction,
      arg: serializeArgument(arg),
    );
    return result.handle;
  }

  Future<void> updateSubscription(
    ElectronApplicationUpdateSubscriptionEventEnum event,
    bool enabled,
  ) async {
    await channel_updateSubscription(event: event, enabled: enabled);
  }
}
