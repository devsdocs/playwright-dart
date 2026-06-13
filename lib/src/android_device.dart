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
    AndroidSelector androidSelector,
    String text, {
    double timeout = 30000.0,
  }) async {
    await channel_fill(
      androidSelector: androidSelector,
      text: text,
      timeout: timeout,
    );
  }

  Future<void> tap(
    AndroidSelector androidSelector, {
    double? duration,
    double timeout = 30000.0,
  }) async {
    await channel_tap(
      androidSelector: androidSelector,
      duration: duration,
      timeout: timeout,
    );
  }

  Future<void> drag(
    AndroidSelector androidSelector,
    Point dest, {
    double? speed,
    double timeout = 30000.0,
  }) async {
    await channel_drag(
      androidSelector: androidSelector,
      dest: dest,
      speed: speed,
      timeout: timeout,
    );
  }

  Future<void> fling(
    AndroidSelector androidSelector,
    AndroidDeviceFlingDirectionEnum direction, {
    double? speed,
    double timeout = 30000.0,
  }) async {
    await channel_fling(
      androidSelector: androidSelector,
      direction: direction,
      speed: speed,
      timeout: timeout,
    );
  }

  Future<void> longTap(
    AndroidSelector androidSelector, {
    double timeout = 30000.0,
  }) async {
    await channel_longTap(androidSelector: androidSelector, timeout: timeout);
  }

  Future<void> pinchClose(
    AndroidSelector androidSelector,
    double percent, {
    double? speed,
    double timeout = 30000.0,
  }) async {
    await channel_pinchClose(
      androidSelector: androidSelector,
      percent: percent,
      speed: speed,
      timeout: timeout,
    );
  }

  Future<void> pinchOpen(
    AndroidSelector androidSelector,
    double percent, {
    double? speed,
    double timeout = 30000.0,
  }) async {
    await channel_pinchOpen(
      androidSelector: androidSelector,
      percent: percent,
      speed: speed,
      timeout: timeout,
    );
  }

  Future<void> scroll(
    AndroidSelector androidSelector,
    AndroidDeviceScrollDirectionEnum direction,
    double percent, {
    double? speed,
    double timeout = 30000.0,
  }) async {
    await channel_scroll(
      androidSelector: androidSelector,
      direction: direction,
      percent: percent,
      speed: speed,
      timeout: timeout,
    );
  }

  Future<void> swipe(
    AndroidSelector androidSelector,
    AndroidDeviceSwipeDirectionEnum direction,
    double percent, {
    double? speed,
    double timeout = 30000.0,
  }) async {
    await channel_swipe(
      androidSelector: androidSelector,
      direction: direction,
      percent: percent,
      speed: speed,
      timeout: timeout,
    );
  }

  Future<AndroidDeviceInfoResult> info(AndroidSelector androidSelector) async {
    return await channel_info(androidSelector: androidSelector);
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
    required ContextOptions contextOptions,
    String? pkg,
    List<String>? args,
    Map<String, dynamic>? proxy,
  }) async {
    final result = await channel_launchBrowser(
      contextOptions: contextOptions,
      pkg: pkg,
      args: args,
      proxy: proxy == null
          ? null
          : AndroidDeviceLaunchBrowserProxy.fromJson(proxy),
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
