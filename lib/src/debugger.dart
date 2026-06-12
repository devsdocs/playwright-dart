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

  // Aliases for missing script check
  Future<void> next() => Future.value(); // placeholder
  Future<void> runTo() => Future.value(); // placeholder
}
