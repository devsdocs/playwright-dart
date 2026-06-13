import 'generated/channels.dart';

class EventTarget extends EventTargetBase {
  EventTarget(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  Future<void> waitForEventInfo(Map<String, dynamic> info) async {
    await channel_waitForEventInfo(
      info: EventTargetWaitForEventInfoInfo.fromJson(info),
    );
  }
}
