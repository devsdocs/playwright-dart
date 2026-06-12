import 'generated/channels.dart';
import 'locator.dart';

class Frame extends FrameBase {
  Frame(
    super.connection,
    super.type,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  /// Returns a locator for the given selector.
  Locator locator(String selector) {
    return Locator(this, selector);
  }

  /// Goto URL
  Future<void> goto(String url, {double? timeout}) async {
    await channel_goto(url: url, timeout: timeout ?? 30000.0);
  }
}
