import 'generated/channels.dart';

class DebugController extends DebugControllerBase {
  DebugController(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  Future<void> initialize({
    required String codegenId,
    required SDKLanguage sdkLanguage,
  }) async {
    await channel_initialize(codegenId: codegenId, sdkLanguage: sdkLanguage);
  }

  // Aliases for missing script check
  Future<void> setReportStateChanged({required bool enabled}) =>
      channel_setReportStateChanged(enabled: enabled);

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

  Future<void> highlight({required String selector, String? ariaTemplate}) =>
      channel_highlight(selector: selector, ariaTemplate: ariaTemplate);

  Future<void> hideHighlight() => channel_hideHighlight();
  Future<void> resume() => channel_resume();
  Future<void> kill() => channel_kill();
}
