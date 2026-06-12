import 'generated/channels.dart';

class Debugger extends DebuggerBase {
  Debugger(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  Future<void> requestPause() async {
    await channel_requestPause();
  }

  Future<void> resume() async {
    await channel_resume();
  }

  // Aliases for missing script
  Future<void> next() async {
    await channel_next();
  }

  Future<void> runTo(Map<String, dynamic> location) async {
    await channel_runTo(location: location);
  }
}
