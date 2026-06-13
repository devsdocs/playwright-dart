import '../generated/channels.dart';

/// Interface for Debugger
abstract interface class Debugger {
  Stream<Map<String, dynamic>> get onPausedStateChanged;
  Future<void> requestPause();
  Future<void> resume();
  Future<void> next();
  Future<void> runTo(DebuggerRunToLocation location);
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
    await channel_requestPause();
  }

  @override
  Future<void> resume() async {
    await channel_resume();
  }

  // Aliases for missing script
  @override
  Future<void> next() async {
    await channel_next();
  }

  @override
  Future<void> runTo(DebuggerRunToLocation location) async {
    await channel_runTo(location: location);
  }
}
