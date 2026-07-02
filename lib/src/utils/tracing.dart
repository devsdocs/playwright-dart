import '../generated/channels.dart';
import '../core/page.dart';

/// Interface for Tracing
abstract interface class Tracing {
  /// Start tracing.
  ///
  /// **NOTE**
  /// You probably want to [enable tracing in your config file] instead of using `Tracing.start`.
  ///
  /// The `context.tracing` API captures browser operations and network activity, but it doesn't record test assertions (like `expect` calls). We recommend [enabling tracing through Playwright Test configuration], which includes those assertions and provides a more complete trace for debugging test failures.
  /// **Usage**
  ///
  /// ```dart
  /// await context.tracing.start( screenshots: true, snapshots: true );
  /// final page = await context.newPage();
  /// await page.goto('https://playwright.dev');
  /// expect(page.url()).toBe('https://playwright.dev');
  /// await context.tracing.stop( path: 'trace.zip' );
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `live` bool *(optional)*
  ///
  ///     When enabled, the trace is written to an unarchived file that is updated in real time as actions occur, instead of caching changes and archiving them into a zip file at the end. This is useful for live trace viewing during test execution.
  ///   - `name` String *(optional)*
  ///
  ///     If specified, intermediate trace files are going to be saved into the files with the given name prefix inside the [tracesDir] directory specified in [browserType.launch()]. To specify the final trace zip file name, you need to pass `path` option to [tracing.stop()] instead.
  ///   - `screenshots` bool *(optional)*
  ///
  ///     Whether to capture screenshots during tracing. Screenshots are used to build a timeline preview.
  ///   - `snapshots` bool *(optional)*
  ///
  ///     If this option is true tracing will
  ///     * capture DOM snapshot on every action
  ///     * record network activity
  ///   - `sources` bool *(optional)*
  ///
  ///     Whether to include source files for trace actions.
  ///   - `title` String *(optional)*
  ///
  ///     Trace name to be shown in the Trace Viewer.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> start({
    String? name,
    bool? snapshots,
    bool? screenshots,
    bool? live,
  });

  /// Start a new trace chunk. If you'd like to record multiple traces on the same [BrowserContext], use [tracing.start()] once, and then create multiple trace chunks with [tracing.startChunk()] and [tracing.stopChunk()].
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await context.tracing.start( screenshots: true, snapshots: true );
  /// final page = await context.newPage();
  /// await page.goto('https://playwright.dev');
  ///
  /// await context.tracing.startChunk();
  /// await page.getByText('Get Started').click();
  /// // Everything between startChunk and stopChunk will be recorded in the trace.
  /// await context.tracing.stopChunk( path: 'trace1.zip' );
  ///
  /// await context.tracing.startChunk();
  /// await page.goto('http://example.com');
  /// // Save a second trace file with different actions.
  /// await context.tracing.stopChunk( path: 'trace2.zip' );
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `name` String *(optional)*
  ///
  ///     If specified, intermediate trace files are going to be saved into the files with the given name prefix inside the [tracesDir] directory specified in [browserType.launch()]. To specify the final trace zip file name, you need to pass `path` option to [tracing.stopChunk()] instead.
  ///   - `title` String *(optional)*
  ///
  ///     Trace name to be shown in the Trace Viewer.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<TracingTracingStartChunkResult> startChunk({
    String? name,
    String? title,
  });

  /// Use `test.step` instead when available.
  /// Creates a new group within the trace, assigning any subsequent API calls to this group, until [tracing.groupEnd()] is called. Groups can be nested and will be visible in the trace viewer.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// // use test.step instead
  /// await test.step('Log in', () async {
  ///   // ...
  /// );
  /// ```
  ///
  /// **Arguments**
  /// - `name` String
  ///
  ///   Group name shown in the trace viewer.
  /// - `options` Map *(optional)*
  ///   - `location` TracingTracingGroupLocation *(optional)*
  ///     - `file` String
  ///
  ///
  ///     - `line` num *(optional)*
  ///
  ///
  ///     - `column` num *(optional)*
  ///
  ///
  ///     Specifies a custom location for the group to be shown in the trace viewer. Defaults to the location of the [tracing.group()] call.
  ///
  /// **Returns**
  /// - Future&lt;[Disposable]&gt;
  Future<void> group(String name, {TracingTracingGroupLocation? location});

  /// Closes the last group created by [tracing.group()].
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await tracing.groupEnd();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> groupEnd();

  /// Stop the trace chunk. See [tracing.startChunk()] for more details about multiple trace chunks.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await tracing.stopChunk();
  /// await tracing.stopChunk(options);
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `path` String *(optional)*
  ///
  ///     Export trace collected since the last [tracing.startChunk()] call into the file with the given path.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<TracingTracingStopChunkResult> stopChunk({
    TracingTracingStopChunkModeEnum mode,
  });

  /// Stop tracing.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await tracing.stop();
  /// await tracing.stop(options);
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `path` String *(optional)*
  ///
  ///     Export trace into the file with the given path.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
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
