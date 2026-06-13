import 'generated/channels.dart';
import 'browser_context.dart';

class AndroidDevice extends AndroidDeviceBase {
  AndroidDevice(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  Future<void> wait(
    AndroidSelector androidSelector, {
    AndroidDeviceWaitStateEnum? state,
    required double timeout,
  }) async {
    await channel_wait(
      androidSelector: androidSelector,
      state: state,
      timeout: timeout,
    );
  }

  Future<void> fill(
    AndroidSelector selector,
    String text, {
    double timeout = 30000.0,
  }) async {
    await channel_fill(androidSelector: selector, text: text, timeout: timeout);
  }

  Future<void> tap(
    AndroidSelector selector, {
    double? duration,
    double timeout = 30000.0,
  }) async {
    await channel_tap(
      androidSelector: selector,
      duration: duration,
      timeout: timeout,
    );
  }

  Future<void> drag(
    AndroidSelector selector,
    Point dest, {
    double? speed,
    double timeout = 30000.0,
  }) async {
    await channel_drag(
      androidSelector: selector,
      dest: dest,
      speed: speed,
      timeout: timeout,
    );
  }

  Future<void> fling(
    AndroidSelector selector,
    AndroidDeviceFlingDirectionEnum direction, {
    double? speed,
    double timeout = 30000.0,
  }) async {
    await channel_fling(
      androidSelector: selector,
      direction: direction,
      speed: speed,
      timeout: timeout,
    );
  }

  Future<void> longTap(
    AndroidSelector selector, {
    double timeout = 30000.0,
  }) async {
    await channel_longTap(androidSelector: selector, timeout: timeout);
  }

  Future<void> pinchClose(
    AndroidSelector selector,
    double percent, {
    double? speed,
    double timeout = 30000.0,
  }) async {
    await channel_pinchClose(
      androidSelector: selector,
      percent: percent,
      speed: speed,
      timeout: timeout,
    );
  }

  Future<void> pinchOpen(
    AndroidSelector selector,
    double percent, {
    double? speed,
    double timeout = 30000.0,
  }) async {
    await channel_pinchOpen(
      androidSelector: selector,
      percent: percent,
      speed: speed,
      timeout: timeout,
    );
  }

  Future<void> scroll(
    AndroidSelector selector,
    AndroidDeviceScrollDirectionEnum direction,
    double percent, {
    double? speed,
    double timeout = 30000.0,
  }) async {
    await channel_scroll(
      androidSelector: selector,
      direction: direction,
      percent: percent,
      speed: speed,
      timeout: timeout,
    );
  }

  Future<void> swipe(
    AndroidSelector selector,
    AndroidDeviceSwipeDirectionEnum direction,
    double percent, {
    double? speed,
    double timeout = 30000.0,
  }) async {
    await channel_swipe(
      androidSelector: selector,
      direction: direction,
      percent: percent,
      speed: speed,
      timeout: timeout,
    );
  }

  Future<AndroidDeviceInfoResult> info(AndroidSelector selector) async {
    return await channel_info(androidSelector: selector);
  }

  Future<AndroidDeviceScreenshotResult> screenshot() async {
    return await channel_screenshot();
  }

  Future<void> inputType(String text) async {
    await channel_inputType(text: text);
  }

  Future<void> inputPress(String key) async {
    await channel_inputPress(key: key);
  }

  Future<void> inputTap(Point point) async {
    await channel_inputTap(point: point);
  }

  Future<void> inputSwipe(List<Point> segments, int steps) async {
    await channel_inputSwipe(segments: segments, steps: steps);
  }

  Future<void> inputDrag(Point from, Point to, int steps) async {
    await channel_inputDrag(from: from, to: to, steps: steps);
  }

  Future<BrowserContext> launchBrowser({
    required ContextOptions mixin,
    String? pkg,
    List<String>? args,
    Map<String, dynamic>? proxy,
  }) async {
    final result = await channel_launchBrowser(
      mixin: mixin,
      pkg: pkg,
      args: args,
      proxy: proxy,
    );
    return result.context as BrowserContext;
  }

  Future<AndroidDeviceOpenResult> open(String command) async {
    return await channel_open(command: command);
  }

  Future<AndroidDeviceShellResult> shell(String command) async {
    return await channel_shell(command: command);
  }

  Future<void> installApk(String file, {List<String>? args}) async {
    await channel_installApk(file: file, args: args);
  }

  Future<void> push(String file, String path, {int? mode}) async {
    await channel_push(file: file, path: path, mode: mode);
  }

  Future<AndroidDeviceConnectToWebViewResult> connectToWebView(
    String socketName,
  ) async {
    return await channel_connectToWebView(socketName: socketName);
  }

  Future<void> close() async {
    await channel_close();
  }
}
