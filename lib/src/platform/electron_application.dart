import '../interaction/jshandle.dart';
import '../generated/channels.dart';
import '../infrastructure/serialization.dart';

/// Interface for ElectronApplication
abstract interface class ElectronApplication {
  Stream<ConsoleMessage> get onConsole;
  Stream<ElectronApplication> get onClose;

  /// Returns the BrowserWindow object that corresponds to the given Playwright page.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await electronApplication.browserWindow(page);
  /// ```
  ///
  /// **Arguments**
  /// - `page` PageBase
  ///
  ///   Page to retrieve the window for.
  ///
  /// **Returns**
  /// - Future&lt;[JSHandle]&gt;
  Future<ElectronApplicationBrowserWindowResult> browserWindow(PageBase page);
  Future<dynamic> evaluateExpression(
    String expression, {
    bool? isFunction,
    Object? arg,
  });
  Future<JSHandle> evaluateExpressionHandle(
    String expression, {
    bool? isFunction,
    Object? arg,
  });
  Future<void> updateSubscription(
    ElectronApplicationUpdateSubscriptionEventEnum event,
    bool enabled,
  );
}

class ElectronApplicationImpl extends ElectronApplicationBase
    implements ElectronApplication {
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

  @override
  Stream<ElectronApplication> get onClose {
    return onEvent.where((e) => e['event'] == 'close').map((e) => this);
  }

  ElectronApplicationImpl(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  @override
  Future<ElectronApplicationBrowserWindowResult> browserWindow(
    PageBase page,
  ) async {
    return await channel_browserWindow(page: page);
  }

  @override
  Future<dynamic> evaluateExpression(
    String expression, {
    bool? isFunction,
    Object? arg,
  }) async {
    final result = await channel_evaluateExpression(
      expression: expression,
      isFunction: isFunction,
      arg: serializeArgument(arg),
    );
    return parseSerializedValue(result.value);
  }

  @override
  Future<JSHandle> evaluateExpressionHandle(
    String expression, {
    bool? isFunction,
    Object? arg,
  }) async {
    final result = await channel_evaluateExpressionHandle(
      expression: expression,
      isFunction: isFunction,
      arg: serializeArgument(arg),
    );
    return result.handle as JSHandle;
  }

  @override
  Future<void> updateSubscription(
    ElectronApplicationUpdateSubscriptionEventEnum event,
    bool enabled,
  ) async {
    await channel_updateSubscription(event: event, enabled: enabled);
  }
}
