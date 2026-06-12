import 'channel_owner.dart';
import 'browser_type.dart';
import 'local_utils.dart';
import 'generated/channels.dart';

class Playwright extends PlaywrightBase {
  late final BrowserType chromium;
  late final BrowserType firefox;
  late final BrowserType webkit;
  late final LocalUtils utils;

  Playwright(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]) {
    chromium = ChannelOwner.from<BrowserType>(
      connection,
      initializer['chromium'],
    );
    firefox = ChannelOwner.from<BrowserType>(
      connection,
      initializer['firefox'],
    );
    webkit = ChannelOwner.from<BrowserType>(connection, initializer['webkit']);
    utils = ChannelOwner.from<LocalUtils>(connection, initializer['utils']);
  }
}
