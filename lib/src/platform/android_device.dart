import '../generated/channels.dart';
import '../core/browser_context.dart';

/// Interface for AndroidDevice
abstract interface class AndroidDevice {
  Stream<AndroidDeviceWebViewRemovedEvent> get onWebViewRemoved;
  Stream<AndroidDeviceWebViewAddedEvent> get onWebViewAdded;
  Stream<AndroidDevice> get onClose;

  /// Waits for the specific [selector] to either appear or disappear, depending on the [state].
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await androidDevice.wait(selector);
  /// await androidDevice.wait(selector, options);
  /// ```
  ///
  /// **Arguments**
  /// - `selector` [AndroidSelector]
  ///
  ///   Selector to wait for.
  /// - `options` Map *(optional)*
  ///   - `state` WaitState *(optional)*
  ///
  ///     Optional state. Can be either:
  ///     * default - wait for element to be present.
  ///     * `'gone'` - wait for element to not be present.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds, defaults to 30 seconds, pass `0` to disable timeout. The default value can be changed by using the [androidDevice.setDefaultTimeout()] method.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> wait(
    AndroidSelector androidSelector, {
    WaitState? state,
    required double timeout,
  });

  /// Fills the specific [selector] input box with [text].
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await androidDevice.fill(selector, text);
  /// await androidDevice.fill(selector, text, options);
  /// ```
  ///
  /// **Arguments**
  /// - `selector` [AndroidSelector]
  ///
  ///   Selector to fill.
  /// - `text` String
  ///
  ///   Text to be filled in the input box.
  /// - `options` Map *(optional)*
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds, defaults to 30 seconds, pass `0` to disable timeout. The default value can be changed by using the [androidDevice.setDefaultTimeout()] method.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> fill(
    AndroidSelector androidSelector,
    String text, {
    double timeout,
  });

  /// Taps on the widget defined by [selector].
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await androidDevice.tap(selector);
  /// await androidDevice.tap(selector, options);
  /// ```
  ///
  /// **Arguments**
  /// - `selector` [AndroidSelector]
  ///
  ///   Selector to tap on.
  /// - `options` Map *(optional)*
  ///   - `duration` double *(optional)*
  ///
  ///     Optional duration of the tap in milliseconds.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds, defaults to 30 seconds, pass `0` to disable timeout. The default value can be changed by using the [androidDevice.setDefaultTimeout()] method.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> tap(
    AndroidSelector androidSelector, {
    double? duration,
    double timeout,
  });

  /// Drags the widget defined by [selector] towards [dest] point.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await androidDevice.drag(selector, dest);
  /// await androidDevice.drag(selector, dest, options);
  /// ```
  ///
  /// **Arguments**
  /// - `selector` [AndroidSelector]
  ///
  ///   Selector to drag.
  /// - `dest` Point
  ///   - `x` num
  ///
  ///
  ///   - `y` num
  ///
  ///
  ///   Point to drag to.
  /// - `options` Map *(optional)*
  ///   - `speed` double *(optional)*
  ///
  ///     Optional speed of the drag in pixels per second.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds, defaults to 30 seconds, pass `0` to disable timeout. The default value can be changed by using the [androidDevice.setDefaultTimeout()] method.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> drag(
    AndroidSelector androidSelector,
    Point dest, {
    double? speed,
    double timeout,
  });

  /// Flings the widget defined by [selector] in  the specified [direction].
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await androidDevice.fling(selector, direction);
  /// await androidDevice.fling(selector, direction, options);
  /// ```
  ///
  /// **Arguments**
  /// - `selector` [AndroidSelector]
  ///
  ///   Selector to fling.
  /// - `direction` Direction
  ///
  ///   Fling direction.
  /// - `options` Map *(optional)*
  ///   - `speed` double *(optional)*
  ///
  ///     Optional speed of the fling in pixels per second.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds, defaults to 30 seconds, pass `0` to disable timeout. The default value can be changed by using the [androidDevice.setDefaultTimeout()] method.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> fling(
    AndroidSelector androidSelector,
    Direction direction, {
    double? speed,
    double timeout,
  });

  /// Performs a long tap on the widget defined by [selector].
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await androidDevice.longTap(selector);
  /// await androidDevice.longTap(selector, options);
  /// ```
  ///
  /// **Arguments**
  /// - `selector` [AndroidSelector]
  ///
  ///   Selector to tap on.
  /// - `options` Map *(optional)*
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds, defaults to 30 seconds, pass `0` to disable timeout. The default value can be changed by using the [androidDevice.setDefaultTimeout()] method.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> longTap(AndroidSelector androidSelector, {double timeout});

  /// Pinches the widget defined by [selector] in the closing direction.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await androidDevice.pinchClose(selector, percent);
  /// await androidDevice.pinchClose(selector, percent, options);
  /// ```
  ///
  /// **Arguments**
  /// - `selector` [AndroidSelector]
  ///
  ///   Selector to pinch close.
  /// - `percent` double
  ///
  ///   The size of the pinch as a percentage of the widget's size.
  /// - `options` Map *(optional)*
  ///   - `speed` double *(optional)*
  ///
  ///     Optional speed of the pinch in pixels per second.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds, defaults to 30 seconds, pass `0` to disable timeout. The default value can be changed by using the [androidDevice.setDefaultTimeout()] method.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> pinchClose(
    AndroidSelector androidSelector,
    double percent, {
    double? speed,
    double timeout,
  });

  /// Pinches the widget defined by [selector] in the open direction.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await androidDevice.pinchOpen(selector, percent);
  /// await androidDevice.pinchOpen(selector, percent, options);
  /// ```
  ///
  /// **Arguments**
  /// - `selector` [AndroidSelector]
  ///
  ///   Selector to pinch open.
  /// - `percent` double
  ///
  ///   The size of the pinch as a percentage of the widget's size.
  /// - `options` Map *(optional)*
  ///   - `speed` double *(optional)*
  ///
  ///     Optional speed of the pinch in pixels per second.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds, defaults to 30 seconds, pass `0` to disable timeout. The default value can be changed by using the [androidDevice.setDefaultTimeout()] method.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> pinchOpen(
    AndroidSelector androidSelector,
    double percent, {
    double? speed,
    double timeout,
  });

  /// Scrolls the widget defined by [selector] in  the specified [direction].
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await androidDevice.scroll(selector, direction, percent);
  /// await androidDevice.scroll(selector, direction, percent, options);
  /// ```
  ///
  /// **Arguments**
  /// - `selector` [AndroidSelector]
  ///
  ///   Selector to scroll.
  /// - `direction` Direction
  ///
  ///   Scroll direction.
  /// - `percent` double
  ///
  ///   Distance to scroll as a percentage of the widget's size.
  /// - `options` Map *(optional)*
  ///   - `speed` double *(optional)*
  ///
  ///     Optional speed of the scroll in pixels per second.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds, defaults to 30 seconds, pass `0` to disable timeout. The default value can be changed by using the [androidDevice.setDefaultTimeout()] method.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> scroll(
    AndroidSelector androidSelector,
    Direction direction,
    double percent, {
    double? speed,
    double timeout,
  });

  /// Swipes the widget defined by [selector] in  the specified [direction].
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await androidDevice.swipe(selector, direction, percent);
  /// await androidDevice.swipe(selector, direction, percent, options);
  /// ```
  ///
  /// **Arguments**
  /// - `selector` [AndroidSelector]
  ///
  ///   Selector to swipe.
  /// - `direction` Direction
  ///
  ///   Swipe direction.
  /// - `percent` double
  ///
  ///   Distance to swipe as a percentage of the widget's size.
  /// - `options` Map *(optional)*
  ///   - `speed` double *(optional)*
  ///
  ///     Optional speed of the swipe in pixels per second.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds, defaults to 30 seconds, pass `0` to disable timeout. The default value can be changed by using the [androidDevice.setDefaultTimeout()] method.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> swipe(
    AndroidSelector androidSelector,
    Direction direction,
    double percent, {
    double? speed,
    double timeout,
  });

  /// Returns information about a widget defined by [selector].
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await androidDevice.info(selector);
  /// ```
  ///
  /// **Arguments**
  /// - `selector` [AndroidSelector]
  ///
  ///   Selector to return information about.
  ///
  /// **Returns**
  /// - Future&lt;[AndroidElementInfo]&gt;
  Future<AndroidDeviceInfoResult> info(AndroidSelector androidSelector);

  /// Returns the buffer with the captured screenshot of the device.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await androidDevice.screenshot();
  /// await androidDevice.screenshot(options);
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `path` String *(optional)*
  ///
  ///     The file path to save the image to. If [path] is a relative path, then it is resolved relative to the current working directory. If no path is provided, the image won't be saved to the disk.
  ///
  /// **Returns**
  /// - Future&lt;List&lt;int&gt;&gt;
  Future<AndroidDeviceScreenshotResult> screenshot();
  Future<void> inputType(String text);
  Future<void> inputPress(String key);
  Future<void> inputTap(Point point);
  Future<void> inputSwipe(List<Point> segments, int steps);
  Future<void> inputDrag(Point from, Point to, int steps);

  /// Launches Chrome browser on the device, and returns its persistent context.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await androidDevice.launchBrowser();
  /// await androidDevice.launchBrowser(options);
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `acceptDownloads` bool *(optional)*
  ///
  ///     Whether to automatically download all the attachments. Defaults to `true` where all the downloads are accepted.
  ///   - `args` List&lt;String&gt; *(optional)*
  ///
  ///     **WARNING**
  /// Use custom browser args at your own risk, as some of them may break Playwright functionality.
  ///     Additional arguments to pass to the browser instance. The list of Chromium flags can be found [here].
  ///   - `baseURL` String *(optional)*
  ///
  ///     When using [page.goto()], [page.route()], [page.waitForURL()], [page.waitForRequest()], or [page.waitForResponse()] it takes the base URL in consideration by using the [`URL()`] constructor for building the corresponding URL. Unset by default. Examples:
  ///     * baseURL: `http://localhost:3000` and navigating to `/bar.html` results in `http://localhost:3000/bar.html`
  ///     * baseURL: `http://localhost:3000/foo/` and navigating to `./bar.html` results in `http://localhost:3000/foo/bar.html`
  ///     * baseURL: `http://localhost:3000/foo` (without trailing slash) and navigating to `./bar.html` results in `http://localhost:3000/bar.html`
  ///   - `bypassCSP` bool *(optional)*
  ///
  ///     Toggles bypassing page's Content-Security-Policy. Defaults to `false`.
  ///   - `colorScheme` null | "light" | "dark" | "no-preference" *(optional)*
  ///
  ///     Emulates [prefers-colors-scheme] media feature, supported values are `'light'` and `'dark'`. See [page.emulateMedia()] for more details. Passing `null` resets emulation to system defaults. Defaults to `'light'`.
  ///   - `contrast` null | "no-preference" | "more" *(optional)*
  ///
  ///     Emulates `'prefers-contrast'` media feature, supported values are `'no-preference'`, `'more'`. See [page.emulateMedia()] for more details. Passing `null` resets emulation to system defaults. Defaults to `'no-preference'`.
  ///   - `deviceScaleFactor` num *(optional)*
  ///
  ///     Specify device scale factor (can be thought of as dpr). Defaults to `1`. Learn more about [emulating devices with device scale factor].
  ///   - `extraHTTPHeaders` Map&lt;String, String&gt; *(optional)*
  ///
  ///     An object containing additional HTTP headers to be sent with every request. Defaults to none.
  ///   - `forcedColors` null | "active" | "none" *(optional)*
  ///
  ///     Emulates `'forced-colors'` media feature, supported values are `'active'`, `'none'`. See [page.emulateMedia()] for more details. Passing `null` resets emulation to system defaults. Defaults to `'none'`.
  ///   - `geolocation` Map *(optional)*
  ///     - `latitude` num
  ///
  ///       Latitude between -90 and 90.
  ///     - `longitude` num
  ///
  ///       Longitude between -180 and 180.
  ///     - `accuracy` num *(optional)*
  ///
  ///       Non-negative accuracy value. Defaults to `0`.
  ///   - `hasTouch` bool *(optional)*
  ///
  ///     Specifies if viewport supports touch events. Defaults to false. Learn more about [mobile emulation].
  ///   - `httpCredentials` Map *(optional)*
  ///     - `username` String
  ///
  ///
  ///     - `password` String
  ///
  ///
  ///     - `origin` String *(optional)*
  ///
  ///       Restrain sending http credentials on specific origin (scheme://host:port).
  ///     - `send` "unauthorized" | "always" *(optional)*
  ///
  ///       This option only applies to the requests sent from corresponding [APIRequestContext] and does not affect requests sent from the browser. `'always'` - `Authorization` header with basic authentication credentials will be sent with the each API request. `'unauthorized` - the credentials are only sent when 401 (Unauthorized) response with `WWW-Authenticate` header is received. Defaults to `'unauthorized'`.
  ///
  ///     Credentials for [HTTP authentication]. If no origin is specified, the username and password are sent to any servers upon unauthorized responses.
  ///   - `ignoreHTTPSErrors` bool *(optional)*
  ///
  ///     Whether to ignore HTTPS errors when sending network requests. Defaults to `false`.
  ///   - `isMobile` bool *(optional)*
  ///
  ///     Whether the `meta viewport` tag is taken into account and touch events are enabled. isMobile is a part of device, so you don't actually need to set it manually. Defaults to `false` and is not supported in Firefox. Learn more about [mobile emulation].
  ///   - `javaScriptEnabled` bool *(optional)*
  ///
  ///     Whether or not to enable JavaScript in the context. Defaults to `true`. Learn more about [disabling JavaScript].
  ///   - `locale` String *(optional)*
  ///
  ///     Specify user locale, for example `en-GB`, `de-DE`, etc. Locale will affect `navigator.language` value, `Accept-Language` request header value as well as number and date formatting rules. Defaults to the system default locale. Learn more about emulation in our [emulation guide].
  ///   - `logger` [Logger] *(optional)*
  ///
  ///     **WARNING**
  /// [Deprecated]
  ///     The logs received by the logger are incomplete. Please use tracing instead.
  ///     Logger sink for Playwright logging.
  ///   - `offline` bool *(optional)*
  ///
  ///     Whether to emulate network being offline. Defaults to `false`. Learn more about [network emulation].
  ///   - `permissions` List&lt;String&gt; *(optional)*
  ///
  ///     A list of permissions to grant to all pages in this context. See [browserContext.grantPermissions()] for more details. Defaults to none.
  ///   - `pkg` String *(optional)*
  ///
  ///     Optional package name to launch instead of default Chrome for Android.
  ///   - `proxy` AndroidDeviceLaunchBrowserProxy *(optional)*
  ///     - `server` String
  ///
  ///       Proxy to be used for all requests. HTTP and SOCKS proxies are supported, for example `http://myproxy.com:3128` or `socks5://myproxy.com:3128`. Short form `myproxy.com:3128` is considered an HTTP proxy.
  ///     - `bypass` String *(optional)*
  ///
  ///       Optional comma-separated domains to bypass proxy, for example `".com, chromium.org, .domain.com"`.
  ///     - `username` String *(optional)*
  ///
  ///       Optional username to use if HTTP proxy requires authentication.
  ///     - `password` String *(optional)*
  ///
  ///       Optional password to use if HTTP proxy requires authentication.
  ///
  ///     Network proxy settings.
  ///   - `recordHar` Map *(optional)*
  ///     - `omitContent` bool *(optional)*
  ///
  ///       Optional setting to control whether to omit request content from the HAR. Defaults to `false`. Deprecated, use `content` policy instead.
  ///     - `content` "omit" | "embed" | "attach" *(optional)*
  ///
  ///       Optional setting to control resource content management. If `omit` is specified, content is not persisted. If `attach` is specified, resources are persisted as separate files or entries in the ZIP archive. If `embed` is specified, content is stored inline the HAR file as per HAR specification. Defaults to `attach` for `.zip` output files and to `embed` for all other file extensions.
  ///     - `path` String
  ///
  ///       Path on the filesystem to write the HAR file to. If the file name ends with `.zip`, `content: 'attach'` is used by default.
  ///     - `mode` "full" | "minimal" *(optional)*
  ///
  ///       When set to `minimal`, only record information necessary for routing from HAR. This omits sizes, timing, page, cookies, security and other types of HAR information that are not used when replaying from HAR. Defaults to `full`.
  ///     - `urlFilter` String | [RegExp] *(optional)*
  ///
  ///       A glob or regex pattern to filter requests that are stored in the HAR. When a [baseURL] via the context options was provided and the passed URL is a path, it gets merged via the [`new URL()`] constructor. Defaults to none.
  ///
  ///     Enables [HAR] recording for all pages into `recordHar.path` file. If not specified, the HAR is not recorded. Make sure to await [browserContext.close()] for the HAR to be saved.
  ///   - `recordVideo` Map *(optional)*
  ///     - `dir` String *(optional)*
  ///
  ///       Path to the directory to put videos into. If not specified, the videos will be stored in `artifactsDir` (see [browserType.launch()] options).
  ///     - `size` Map *(optional)*
  ///       - `width` num
  ///
  ///         Video frame width.
  ///       - `height` num
  ///
  ///         Video frame height.
  ///
  ///       Optional dimensions of the recorded videos. If not specified the size will be equal to `viewport` scaled down to fit into 800x800. If `viewport` is not configured explicitly the video size defaults to 800x450. Actual picture of each page will be scaled down if necessary to fit the specified size.
  ///     - `showActions` Map *(optional)*
  ///       - `duration` num *(optional)*
  ///
  ///         How long each annotation is displayed in milliseconds. Defaults to `500`.
  ///       - `position` "top-left" | "top" | "top-right" | "bottom-left" | "bottom" | "bottom-right" *(optional)*
  ///
  ///         Position of the action title overlay. Defaults to `"top-right"`.
  ///       - `fontSize` num *(optional)*
  ///
  ///         Font size of the action title in pixels. Defaults to `24`.
  ///       - `cursor` "none" | "pointer" *(optional)*
  ///
  ///         Cursor decoration shown for pointer actions. `"pointer"` (the default) renders a mouse pointer that animates from the previous action point to the next one. `"none"` disables the cursor decoration.
  ///
  ///       If specified, enables visual annotations on interacted elements during video recording.
  ///
  ///     Enables video recording for all pages into `recordVideo.dir` directory. If not specified videos are not recorded. Make sure to await [browserContext.close()] for videos to be saved.
  ///   - `reducedMotion` null | "reduce" | "no-preference" *(optional)*
  ///
  ///     Emulates `'prefers-reduced-motion'` media feature, supported values are `'reduce'`, `'no-preference'`. See [page.emulateMedia()] for more details. Passing `null` resets emulation to system defaults. Defaults to `'no-preference'`.
  ///   - `screen` Map *(optional)*
  ///     - `width` num
  ///
  ///       page width in pixels.
  ///     - `height` num
  ///
  ///       page height in pixels.
  ///
  ///     Emulates consistent window screen size available inside web page via `window.screen`. Is only used when the [viewport] is set.
  ///   - `serviceWorkers` "allow" | "block" *(optional)*
  ///
  ///     Whether to allow sites to register Service workers. Defaults to `'allow'`.
  ///     * `'allow'`: [Service Workers] can be registered.
  ///     * `'block'`: Playwright will block all registration of Service Workers.
  ///   - `strictSelectors` bool *(optional)*
  ///
  ///     If set to true, enables strict selectors mode for this context. In the strict selectors mode all operations on selectors that imply single target DOM element will throw when more than one element matches the selector. This option does not affect any Locator APIs (Locators are always strict). Defaults to `false`. See [Locator] to learn more about the strict mode.
  ///   - `timezoneId` String *(optional)*
  ///
  ///     Changes the timezone of the context. See [ICU's metaZones.txt] for a list of supported timezone IDs. Defaults to the system timezone.
  ///   - `userAgent` String *(optional)*
  ///
  ///     Specific user agent to use in this context.
  ///   - `viewport` [Map]? *(optional)*
  ///     - `width` num
  ///
  ///       page width in pixels.
  ///     - `height` num
  ///
  ///       page height in pixels.
  ///
  ///     Emulates consistent viewport for each page. Defaults to an 1280x720 viewport. Use `null` to disable the consistent viewport emulation. Learn more about [viewport emulation].
  ///
  ///     **NOTE**
  /// The `null` value opts out from the default presets, makes viewport depend on the host window size defined by the operating system. It makes the execution of the tests non-deterministic.
  ///     **Returns**
  /// - Future&lt;[BrowserContext]&gt;
  Future<BrowserContext> launchBrowser({
    required ContextOptions contextOptions,
    String? pkg,
    List<String>? args,
    AndroidDeviceLaunchBrowserProxy? proxy,
  });

  /// Launches a process in the shell on the device and returns a socket to communicate with the launched process.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await androidDevice.open(command);
  /// ```
  ///
  /// **Arguments**
  /// - `command` String
  ///
  ///   Shell command to execute.
  ///
  /// **Returns**
  /// - Future&lt;[AndroidSocket]&gt;
  Future<AndroidDeviceOpenResult> open(String command);

  /// Executes a shell command on the device and returns its output.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await androidDevice.shell(command);
  /// ```
  ///
  /// **Arguments**
  /// - `command` String
  ///
  ///   Shell command to execute.
  ///
  /// **Returns**
  /// - Future&lt;List&lt;int&gt;&gt;
  Future<AndroidDeviceShellResult> shell(String command);

  /// Installs an apk on the device.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await androidDevice.installApk(file);
  /// await androidDevice.installApk(file, options);
  /// ```
  ///
  /// **Arguments**
  /// - `file` String
  ///
  ///   Either a path to the apk file, or apk file content.
  /// - `options` Map *(optional)*
  ///   - `args` List&lt;String&gt; *(optional)*
  ///
  ///     Optional arguments to pass to the `shell:cmd package install` call. Defaults to `-r -t -S`.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> installApk(String file, {List<String>? args});

  /// Copies a file to the device.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await androidDevice.push(file, path);
  /// await androidDevice.push(file, path, options);
  /// ```
  ///
  /// **Arguments**
  /// - `file` String
  ///
  ///   Either a path to the file, or file content.
  /// - `path` String
  ///
  ///   Path to the file on the device.
  /// - `options` Map *(optional)*
  ///   - `mode` int *(optional)*
  ///
  ///     Optional file mode, defaults to `644` (`rw-r--r--`).
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> push(String file, String path, {int? mode});
  Future<AndroidDeviceConnectToWebViewResult> connectToWebView(
    String socketName,
  );

  /// Disconnects from the device.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await androidDevice.close();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
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
    WaitState? state,
    required double timeout,
  }) async {
    await channel.wait(
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
    await channel.fill(
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
    await channel.tap(
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
    await channel.drag(
      androidSelector: androidSelector,
      dest: dest,
      speed: speed,
      timeout: timeout,
    );
  }

  @override
  Future<void> fling(
    AndroidSelector androidSelector,
    Direction direction, {
    double? speed,
    double timeout = 30000.0,
  }) async {
    await channel.fling(
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
    await channel.longTap(androidSelector: androidSelector, timeout: timeout);
  }

  @override
  Future<void> pinchClose(
    AndroidSelector androidSelector,
    double percent, {
    double? speed,
    double timeout = 30000.0,
  }) async {
    await channel.pinchClose(
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
    await channel.pinchOpen(
      androidSelector: androidSelector,
      percent: percent,
      speed: speed,
      timeout: timeout,
    );
  }

  @override
  Future<void> scroll(
    AndroidSelector androidSelector,
    Direction direction,
    double percent, {
    double? speed,
    double timeout = 30000.0,
  }) async {
    await channel.scroll(
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
    Direction direction,
    double percent, {
    double? speed,
    double timeout = 30000.0,
  }) async {
    await channel.swipe(
      androidSelector: androidSelector,
      direction: direction,
      percent: percent,
      speed: speed,
      timeout: timeout,
    );
  }

  @override
  Future<AndroidDeviceInfoResult> info(AndroidSelector androidSelector) async {
    return await channel.info(androidSelector: androidSelector);
  }

  @override
  Future<AndroidDeviceScreenshotResult> screenshot() async {
    return await channel.screenshot();
  }

  @override
  Future<void> inputType(String text) async {
    await channel.inputType(text: text);
  }

  @override
  Future<void> inputPress(String key) async {
    await channel.inputPress(key: key);
  }

  @override
  Future<void> inputTap(Point point) async {
    await channel.inputTap(point: point);
  }

  @override
  Future<void> inputSwipe(List<Point> segments, int steps) async {
    await channel.inputSwipe(segments: segments, steps: steps);
  }

  @override
  Future<void> inputDrag(Point from, Point to, int steps) async {
    await channel.inputDrag(from: from, to: to, steps: steps);
  }

  @override
  Future<BrowserContext> launchBrowser({
    required ContextOptions contextOptions,
    String? pkg,
    List<String>? args,
    AndroidDeviceLaunchBrowserProxy? proxy,
  }) async {
    final result = await channel.launchBrowser(
      contextOptions: contextOptions,
      pkg: pkg,
      args: args,
      proxy: proxy,
    );
    return result.context as BrowserContext;
  }

  @override
  Future<AndroidDeviceOpenResult> open(String command) async {
    return await channel.open(command: command);
  }

  @override
  Future<AndroidDeviceShellResult> shell(String command) async {
    return await channel.shell(command: command);
  }

  @override
  Future<void> installApk(String file, {List<String>? args}) async {
    await channel.installApk(file: file, args: args);
  }

  @override
  Future<void> push(String file, String path, {int? mode}) async {
    await channel.push(file: file, path: path, mode: mode);
  }

  @override
  Future<AndroidDeviceConnectToWebViewResult> connectToWebView(
    String socketName,
  ) async {
    return await channel.connectToWebView(socketName: socketName);
  }

  @override
  Future<void> close() async {
    await channel.close();
  }
}
