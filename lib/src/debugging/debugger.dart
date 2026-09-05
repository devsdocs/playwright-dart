import '../generated/channels.dart';

/// Interface for Debugger
abstract interface class Debugger {
  Stream<Map<String, dynamic>> get onPausedStateChanged;

  /// Configures the debugger to pause before the next action is executed.
  ///
  /// Throws if the debugger is already paused. Use [debugger.next()] or [debugger.runTo()] to step while paused.
  ///
  /// Note that [page.pause()] is equivalent to a "debugger" statement — it pauses execution at the call site immediately. On the contrary, [debugger.requestPause()] is equivalent to "pause on next statement" — it configures the debugger to pause before the next action is executed.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await debugger.requestPause();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> requestPause();

  /// Resumes script execution. Throws if the debugger is not paused.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await debugger.resume();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> resume();

  /// Resumes script execution and pauses again before the next action. Throws if the debugger is not paused.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await debugger.next();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> next();

  /// Resumes script execution and pauses when an action originates from the given source location. Throws if the debugger is not paused.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await debugger.runTo(location);
  /// ```
  ///
  /// **Arguments**
  /// - `location` DebuggerRunToLocation
  ///   - `file` String
  ///
  ///
  ///   - `line` num *(optional)*
  ///
  ///
  ///   - `column` num *(optional)*
  ///
  ///
  ///   The source location to pause at.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> runTo(DebuggerRunToLocation location);

  /// Enables the debugger.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await debugger.enable();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> enable({double? timeout});
}

class DebuggerImpl extends DebuggerBase implements Debugger {
  @override
  Stream<Map<String, dynamic>> get onPausedStateChanged {
    return onEvent
        .where((e) => e['event'] == 'pausedStateChanged')
        .map((e) => e['params']['pausedDetails'] as Map<String, dynamic>);
  }

  DebuggerImpl(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  @override
  Future<void> requestPause() async {
    await channel.requestPause();
  }

  @override
  Future<void> resume() async {
    await channel.resume();
  }

  // Aliases for missing script
  @override
  Future<void> next() async {
    await channel.next();
  }

  @override
  Future<void> runTo(DebuggerRunToLocation location) async {
    await channel.runTo(location: location);
  }

  @override
  Future<void> enable({double? timeout}) async {
    await channel.enable(timeout: timeout);
  }
}
