import 'generated/channels.dart';
import 'page.dart';

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

  Future<TracingTracingStartChunkResult> startChunk({
    String? name,
    String? title,
  }) async {
    return await channel_tracingStartChunk(name: name, title: title);
  }

  Future<void> group(
    String name, {
    TracingTracingGroupLocation? location,
  }) async {
    await channel_tracingGroup(name: name, location: location);
  }

  Future<void> groupEnd() async {
    await channel_tracingGroupEnd();
  }

  Future<TracingTracingStopChunkResult> stopChunk({
    TracingTracingStopChunkModeEnum mode =
        TracingTracingStopChunkModeEnum.discard,
  }) async {
    return await channel_tracingStopChunk(mode: mode);
  }

  Future<void> stop() async {
    await channel_tracingStop();
  }

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
  Future<void> tracingStartChunk({String? name, String? title}) =>
      startChunk(name: name, title: title);
  Future<void> tracingGroup(
    String name, {
    TracingTracingGroupLocation? location,
  }) => group(name, location: location);
  Future<void> tracingGroupEnd() => groupEnd();
  Future<TracingTracingStopChunkResult> tracingStopChunk({
    TracingTracingStopChunkModeEnum mode =
        TracingTracingStopChunkModeEnum.discard,
  }) => stopChunk(mode: mode);
  Future<void> tracingStop() => stop();
  Future<dynamic> harStart({Page? page, RecordHarOptions? options}) =>
      channel_harStart(page: page, options: options ?? RecordHarOptions());
  Future<dynamic> harExport({String? harId, TracingHarExportModeEnum? mode}) =>
      channel_harExport(
        harId: harId,
        mode: mode ?? TracingHarExportModeEnum.archive,
      );
}
