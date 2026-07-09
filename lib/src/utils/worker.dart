import '../infrastructure/channel_owner.dart';

import '../generated/channels.dart';

import '../interaction/jshandle.dart';

import '../infrastructure/serialization.dart';

/// Interface for Worker

abstract interface class Worker {
  Stream<Worker> get onClose;

  Stream<ConsoleMessage> get onConsole;

  /// **Usage**
  ///
  /// ```dart
  /// worker.url;
  /// ```
  ///
  /// **Returns**
  /// - String
  String get url;

  Future<void> disconnect({String? reason});

  /// Returns the return value of [pageFunction].
  ///
  /// If the function passed to the [worker.evaluate()] returns a Future, then [worker.evaluate()] would wait for the future to complete and return its value.
  ///
  /// If the function passed to the [worker.evaluate()] returns a non-[Serializable] value, then [worker.evaluate()] returns `undefined`. Playwright also supports transferring some additional values that are not serializable by `JSON`: `-0`, `NaN`, `Infinity`, `-Infinity`.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await worker.evaluate(pageFunction);
  /// await worker.evaluate(pageFunction, arg);
  /// ```
  ///
  /// **Arguments**
  /// - `pageFunction` Function | String
  ///
  ///   Function to be evaluated in the worker context.
  /// - `arg` dynamic *(optional)*
  ///
  ///   Optional argument to pass to [pageFunction].
  ///
  /// **Returns**
  /// - Future&lt;[Serializable]&gt;
  Future<dynamic> evaluate(String expression, [Object? arg, bool? isFunction]);

  /// Returns the return value of [pageFunction] as a [JSHandle].
  ///
  /// The only difference between [worker.evaluate()] and [worker.evaluateHandle()] is that [worker.evaluateHandle()] returns [JSHandle].
  ///
  /// If the function passed to the [worker.evaluateHandle()] returns a Future, then [worker.evaluateHandle()] would wait for the future to complete and return its value.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await worker.evaluateHandle(pageFunction);
  /// await worker.evaluateHandle(pageFunction, arg);
  /// ```
  ///
  /// **Arguments**
  /// - `pageFunction` Function | String
  ///
  ///   Function to be evaluated in the worker context.
  /// - `arg` dynamic *(optional)*
  ///
  ///   Optional argument to pass to [pageFunction].
  ///
  /// **Returns**
  /// - Future&lt;[JSHandle]&gt;
  Future<JSHandle> evaluateHandle(
    String expression, [

    Object? arg,

    bool? isFunction,
  ]);

  Future<dynamic> evaluateExpression(
    String expression, [

    Object? arg,

    bool? isFunction,
  ]);

  Future<JSHandle> evaluateExpressionHandle(
    String expression, [

    Object? arg,

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
    await channel.disconnect(reason: reason);
  }

  @override
  Future<dynamic> evaluate(
    String expression, [

    Object? arg,

    bool? isFunction,
  ]) async {
    final result = await channel.evaluateExpression(
      expression: expression,

      arg: serializeArgument(arg),

      isFunction: isFunction,
    );

    return parseSerializedValue(result.value);
  }

  @override
  Future<JSHandle> evaluateHandle(
    String expression, [

    Object? arg,

    bool? isFunction,
  ]) async {
    final result = await channel.evaluateExpressionHandle(
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

    Object? arg,

    bool? isFunction,
  ]) => evaluate(expression, arg, isFunction);

  @override
  Future<JSHandle> evaluateExpressionHandle(
    String expression, [

    Object? arg,

    bool? isFunction,
  ]) => evaluateHandle(expression, arg, isFunction);

  @override
  Future<void> updateSubscription({
    required WorkerUpdateSubscriptionEventEnum event,

    required bool enabled,
  }) async {
    await channel.updateSubscription(event: event, enabled: enabled);
  }
}
