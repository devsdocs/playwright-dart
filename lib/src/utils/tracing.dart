import '../generated/channels.dart';
import '../core/page.dart';

/// Interface for Tracing
abstract interface class Tracing {
  Future<void> start({
    String? name,
    bool? snapshots,
    bool? screenshots,
    bool? live,
  });
  Future<TracingTracingStartChunkResult> startChunk({
    String? name,
    String? title,
  });
  Future<void> group(String name, {TracingTracingGroupLocation? location});
  Future<void> groupEnd();
  Future<TracingTracingStopChunkResult> stopChunk({
    TracingTracingStopChunkModeEnum mode,
  });
  Future<void> stop();
  Future<void> tracingStart({
    String? name,
    bool? snapshots,
    bool? screenshots,
    bool? live,
  });
  Future<void> tracingStartChunk({String? name, String? title});
  Future<void> tracingGroup(
    String name, {
    TracingTracingGroupLocation? location,
  });
  Future<void> tracingGroupEnd();
  Future<TracingTracingStopChunkResult> tracingStopChunk({
    TracingTracingStopChunkModeEnum mode,
  });
  Future<void> tracingStop();
  Future<dynamic> harStart({Page? page, RecordHarOptions? options});
  Future<dynamic> harExport({String? harId, TracingHarExportModeEnum? mode});
}

class TracingImpl extends TracingBase implements Tracing {
  TracingImpl(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  @override
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

  @override
  Future<TracingTracingStartChunkResult> startChunk({
    String? name,
    String? title,
  }) async {
    return await channel_tracingStartChunk(name: name, title: title);
  }

  @override
  Future<void> group(
    String name, {
    TracingTracingGroupLocation? location,
  }) async {
    await channel_tracingGroup(name: name, location: location);
  }

  @override
  Future<void> groupEnd() async {
    await channel_tracingGroupEnd();
  }

  @override
  Future<TracingTracingStopChunkResult> stopChunk({
    TracingTracingStopChunkModeEnum mode =
        TracingTracingStopChunkModeEnum.discard,
  }) async {
    return await channel_tracingStopChunk(mode: mode);
  }

  @override
  Future<void> stop() async {
    await channel_tracingStop();
  }

  @override
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
  @override
  Future<void> tracingStartChunk({String? name, String? title}) =>
      startChunk(name: name, title: title);
  @override
  Future<void> tracingGroup(
    String name, {
    TracingTracingGroupLocation? location,
  }) => group(name, location: location);
  @override
  Future<void> tracingGroupEnd() => groupEnd();
  @override
  Future<TracingTracingStopChunkResult> tracingStopChunk({
    TracingTracingStopChunkModeEnum mode =
        TracingTracingStopChunkModeEnum.discard,
  }) => stopChunk(mode: mode);
  @override
  Future<void> tracingStop() => stop();
  @override
  Future<dynamic> harStart({Page? page, RecordHarOptions? options}) =>
      channel_harStart(
        page: page as PageImpl?,
        options: options ?? RecordHarOptions(),
      );
  @override
  Future<dynamic> harExport({String? harId, TracingHarExportModeEnum? mode}) =>
      channel_harExport(
        harId: harId,
        mode: mode ?? TracingHarExportModeEnum.archive,
      );
}
