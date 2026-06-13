import 'generated/channels.dart';

/// Interface for EventTarget
abstract interface class EventTarget {
  Future<void> waitForEventInfo(EventTargetWaitForEventInfoInfo info);
}

class EventTargetImpl extends EventTargetBase implements EventTarget {
  EventTargetImpl(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  @override
  Future<void> waitForEventInfo(EventTargetWaitForEventInfoInfo info) async {
    await channel_waitForEventInfo(info: info);
  }
}
