import '../infrastructure/channel_owner.dart';

/// Interface for EventTarget.
///
/// NOTE: The `EventTarget` protocol channel was removed in Playwright v1.61+.
/// The class is retained as a stub so that the object factory in [Connection]
/// can still handle any legacy `__create__` messages without crashing.
abstract interface class EventTarget {
  // No protocol methods remain — the EventTarget channel was removed.
}

class EventTargetImpl extends ChannelOwner implements EventTarget {
  EventTargetImpl(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);
}
