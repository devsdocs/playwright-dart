import 'generated/channels.dart';

/// Interface for DebugController
abstract interface class DebugController {
  Stream<dynamic> get onPaused;
  Stream<Map<String, dynamic>> get onSourceChanged;
  Stream<dynamic> get onStateChanged;
  Stream<dynamic> get onSetModeRequested;
  Stream<Map<String, dynamic>> get onInspectRequested;
  Future<void> initialize({
    required String codegenId,
    required SDKLanguage sdkLanguage,
  });
  Future<void> setReportStateChanged({required bool enabled});
  Future<void> setRecorderMode({
    DebugControllerSetRecorderModeModeEnum mode,
    String? testIdAttributeName,
    bool? generateAutoExpect,
  });
  Future<void> highlight({required String selector, String? ariaTemplate});
  Future<void> hideHighlight();
  Future<void> resume();
  Future<void> kill();
}

class DebugControllerImpl extends DebugControllerBase
    implements DebugController {
  @override
  Stream<dynamic> get onPaused {
    return onEvent
        .where((e) => e['event'] == 'paused')
        .map((e) => e['params']['paused']);
  }

  @override
  Stream<Map<String, dynamic>> get onSourceChanged {
    return onEvent
        .where((e) => e['event'] == 'sourceChanged')
        .map((e) => e['params']);
  }

  @override
  Stream<dynamic> get onStateChanged {
    return onEvent
        .where((e) => e['event'] == 'stateChanged')
        .map((e) => e['params']['pageCount']);
  }

  @override
  Stream<dynamic> get onSetModeRequested {
    return onEvent
        .where((e) => e['event'] == 'setModeRequested')
        .map((e) => e['params']['mode']);
  }

  @override
  Stream<Map<String, dynamic>> get onInspectRequested {
    return onEvent
        .where((e) => e['event'] == 'inspectRequested')
        .map((e) => e['params']);
  }

  DebugControllerImpl(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  @override
  Future<void> initialize({
    required String codegenId,
    required SDKLanguage sdkLanguage,
  }) async {
    await channel_initialize(codegenId: codegenId, sdkLanguage: sdkLanguage);
  }

  // Aliases for missing script check
  @override
  Future<void> setReportStateChanged({required bool enabled}) =>
      channel_setReportStateChanged(enabled: enabled);

  @override
  Future<void> setRecorderMode({
    DebugControllerSetRecorderModeModeEnum mode =
        DebugControllerSetRecorderModeModeEnum.none,
    String? testIdAttributeName,
    bool? generateAutoExpect,
  }) => channel_setRecorderMode(
    mode: mode,
    testIdAttributeName: testIdAttributeName,
    generateAutoExpect: generateAutoExpect,
  );

  @override
  Future<void> highlight({required String selector, String? ariaTemplate}) =>
      channel_highlight(selector: selector, ariaTemplate: ariaTemplate);

  @override
  Future<void> hideHighlight() => channel_hideHighlight();
  @override
  Future<void> resume() => channel_resume();
  @override
  Future<void> kill() => channel_kill();
}
