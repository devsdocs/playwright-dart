import '../generated/channels.dart';
import '../core/browser_context.dart';

/// Interface for AndroidDevice
abstract interface class AndroidDevice {
  Stream<AndroidDeviceWebViewRemovedEvent> get onWebViewRemoved;
  Stream<AndroidDeviceWebViewAddedEvent> get onWebViewAdded;
  Stream<AndroidDevice> get onClose;
  Future<void> wait(
    AndroidSelector androidSelector, {
    AndroidDeviceWaitStateEnum? state,
    required double timeout,
  });
  Future<void> fill(
    AndroidSelector androidSelector,
    String text, {
    double timeout,
  });
  Future<void> tap(
    AndroidSelector androidSelector, {
    double? duration,
    double timeout,
  });
  Future<void> drag(
    AndroidSelector androidSelector,
    Point dest, {
    double? speed,
    double timeout,
  });
  Future<void> fling(
    AndroidSelector androidSelector,
    AndroidDeviceFlingDirectionEnum direction, {
    double? speed,
    double timeout,
  });
  Future<void> longTap(AndroidSelector androidSelector, {double timeout});
  Future<void> pinchClose(
    AndroidSelector androidSelector,
    double percent, {
    double? speed,
    double timeout,
  });
  Future<void> pinchOpen(
    AndroidSelector androidSelector,
    double percent, {
    double? speed,
    double timeout,
  });
  Future<void> scroll(
    AndroidSelector androidSelector,
    AndroidDeviceScrollDirectionEnum direction,
    double percent, {
    double? speed,
    double timeout,
  });
  Future<void> swipe(
    AndroidSelector androidSelector,
    AndroidDeviceSwipeDirectionEnum direction,
    double percent, {
    double? speed,
    double timeout,
  });
  Future<AndroidDeviceInfoResult> info(AndroidSelector androidSelector);
  Future<AndroidDeviceScreenshotResult> screenshot();
  Future<void> inputType(String text);
  Future<void> inputPress(String key);
  Future<void> inputTap(Point point);
  Future<void> inputSwipe(List<Point> segments, int steps);
  Future<void> inputDrag(Point from, Point to, int steps);
  Future<BrowserContext> launchBrowser({
    required ContextOptions contextOptions,
    String? pkg,
    List<String>? args,
    AndroidDeviceLaunchBrowserProxy? proxy,
  });
  Future<AndroidDeviceOpenResult> open(String command);
  Future<AndroidDeviceShellResult> shell(String command);
  Future<void> installApk(String file, {List<String>? args});
  Future<void> push(String file, String path, {int? mode});
  Future<AndroidDeviceConnectToWebViewResult> connectToWebView(
    String socketName,
  );
  Future<void> close();
}

class AndroidDeviceImpl extends AndroidDeviceBase implements AndroidDevice {
  @override
  Stream<AndroidDeviceWebViewRemovedEvent> get onWebViewRemoved {
    return onEvent
        .where((e) => e['event'] == 'webViewRemoved')
        .map((e) => AndroidDeviceWebViewRemovedEvent.fromJson(e['params']));
  }

  @override
  Stream<AndroidDeviceWebViewAddedEvent> get onWebViewAdded {
    return onEvent
        .where((e) => e['event'] == 'webViewAdded')
        .map((e) => AndroidDeviceWebViewAddedEvent.fromJson(e['params']));
  }

  @override
  Stream<AndroidDevice> get onClose {
    return onEvent.where((e) => e['event'] == 'close').map((e) => this);
  }

  AndroidDeviceImpl(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  @override
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

  @override
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

  @override
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

  @override
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

  @override
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

  @override
  Future<void> longTap(
    AndroidSelector androidSelector, {
    double timeout = 30000.0,
  }) async {
    await channel_longTap(androidSelector: androidSelector, timeout: timeout);
  }

  @override
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

  @override
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

  @override
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

  @override
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

  @override
  Future<AndroidDeviceInfoResult> info(AndroidSelector androidSelector) async {
    return await channel_info(androidSelector: androidSelector);
  }

  @override
  Future<AndroidDeviceScreenshotResult> screenshot() async {
    return await channel_screenshot();
  }

  @override
  Future<void> inputType(String text) async {
    await channel_inputType(text: text);
  }

  @override
  Future<void> inputPress(String key) async {
    await channel_inputPress(key: key);
  }

  @override
  Future<void> inputTap(Point point) async {
    await channel_inputTap(point: point);
  }

  @override
  Future<void> inputSwipe(List<Point> segments, int steps) async {
    await channel_inputSwipe(segments: segments, steps: steps);
  }

  @override
  Future<void> inputDrag(Point from, Point to, int steps) async {
    await channel_inputDrag(from: from, to: to, steps: steps);
  }

  @override
  Future<BrowserContext> launchBrowser({
    required ContextOptions contextOptions,
    String? pkg,
    List<String>? args,
    AndroidDeviceLaunchBrowserProxy? proxy,
  }) async {
    final result = await channel_launchBrowser(
      contextOptions: contextOptions,
      pkg: pkg,
      args: args,
      proxy: proxy,
    );
    return result.context as BrowserContext;
  }

  @override
  Future<AndroidDeviceOpenResult> open(String command) async {
    return await channel_open(command: command);
  }

  @override
  Future<AndroidDeviceShellResult> shell(String command) async {
    return await channel_shell(command: command);
  }

  @override
  Future<void> installApk(String file, {List<String>? args}) async {
    await channel_installApk(file: file, args: args);
  }

  @override
  Future<void> push(String file, String path, {int? mode}) async {
    await channel_push(file: file, path: path, mode: mode);
  }

  @override
  Future<AndroidDeviceConnectToWebViewResult> connectToWebView(
    String socketName,
  ) async {
    return await channel_connectToWebView(socketName: socketName);
  }

  @override
  Future<void> close() async {
    await channel_close();
  }
}
