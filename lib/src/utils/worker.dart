import '../infrastructure/channel_owner.dart';

import '../generated/channels.dart';

import '../interaction/jshandle.dart';

import '../infrastructure/serialization.dart';

/// Interface for Worker

abstract interface class Worker {
  Stream<Worker> get onClose;

  Stream<ConsoleMessage> get onConsole;

  String get url;

  Future<void> disconnect({String? reason});

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

  Future<void> updateSubscription({
    required WorkerUpdateSubscriptionEventEnum event,

    required bool enabled,
  });
}

class WorkerImpl extends WorkerBase implements Worker {
  @override
  Stream<Worker> get onClose {
    return onEvent.where((e) => e['event'] == 'close').map((e) => this);
  }

  @override
  Stream<ConsoleMessage> get onConsole {
    return onEvent
        .where((e) => e['event'] == 'console')
        .map(
          (e) =>
              connection.objects[e['params'][r'$mixin']['guid']]
                  as ConsoleMessage,
        );
  }

  WorkerImpl(
    super.connection,

    super.channelType,

    super.guid,

    super.initializer, [

    super.parent,
  ]);

  @override
  String get url => typedInitializer.url;

  @override
  Future<void> disconnect({String? reason}) async {
    await channel_disconnect(reason: reason);
  }

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

    return ChannelOwner.from<JSHandleImpl>(
      connection,

      result.handle as Map<String, dynamic>,
    );
  }

  // Aliases for missing script check

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
  Future<void> updateSubscription({
    required WorkerUpdateSubscriptionEventEnum event,

    required bool enabled,
  }) async {
    await channel_updateSubscription(event: event, enabled: enabled);
  }
}
