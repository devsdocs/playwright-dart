import 'generated/channels.dart';

class Tracing extends TracingBase {
  Tracing(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  Future<void> start({
    String? name,
    bool? snapshots,
    bool? screenshots,
    bool? live,
  }) async {
    await channel_tracingStart(
      name: name,
      snapshots: snapshots,
      screenshots: screenshots,
      live: live,
    );
  }

  Future<Map<String, dynamic>> startChunk({String? name, String? title}) async {
    return await channel_tracingStartChunk(name: name, title: title);
  }

  Future<void> group(String name, {Map<String, dynamic>? location}) async {
    await channel_tracingGroup(name: name, location: location);
  }

  Future<void> groupEnd() async {
    await channel_tracingGroupEnd();
  }

  Future<Map<String, dynamic>> stopChunk({String mode = 'doNotSave'}) async {
    return await channel_tracingStopChunk(mode: mode);
  }

  Future<void> stop() async {
    await channel_tracingStop();
  }

  // Aliases for missing script check
  Future<void> tracingStart({
    String? name,
    bool? snapshots,
    bool? screenshots,
    bool? live,
  }) => start(
    name: name,
    snapshots: snapshots,
    screenshots: screenshots,
    live: live,
  );
  Future<Map<String, dynamic>> tracingStartChunk({
    String? name,
    String? title,
  }) => startChunk(name: name, title: title);
  Future<void> tracingGroup(String name, {Map<String, dynamic>? location}) =>
      group(name, location: location);
  Future<void> tracingGroupEnd() => groupEnd();
  Future<Map<String, dynamic>> tracingStopChunk({String mode = 'doNotSave'}) =>
      stopChunk(mode: mode);
  Future<void> tracingStop() => stop();
  Future<dynamic> harStart() => channel_harStart(options: RecordHarOptions());
  Future<dynamic> harExport() => channel_harExport(mode: 'zip');
}
