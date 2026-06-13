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
  Future<void> setReportStateChanged(bool changed) =>
      channel_setReportStateChanged(enabled: changed);
  Future<void> setRecorderMode(Map<String, dynamic> mode) =>
      channel_setRecorderMode(mode: 'none');
  Future<void> highlight(Map<String, dynamic> selector) =>
      channel_highlight(selector: selector['selector'] as String);
  Future<void> hideHighlight() => channel_hideHighlight();
  Future<void> resume() => channel_resume();
  Future<void> kill() => channel_kill();
}
