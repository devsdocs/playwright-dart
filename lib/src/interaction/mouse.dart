import '../generated/channels.dart';
import '../core/page.dart';

class Mouse {
  final Page page;

  Mouse(this.page);

  /// Dispatches a `mousemove` event.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await mouse.move(x, y);
  /// await mouse.move(x, y, options);
  /// ```
  ///
  /// **Arguments**
  /// - `x` double
  ///
  ///   X coordinate relative to the main frame's viewport in CSS pixels.
  /// - `y` double
  ///
  ///   Y coordinate relative to the main frame's viewport in CSS pixels.
  /// - `options` Map *(optional)*
  ///   - `steps` int *(optional)*
  ///
  ///     Defaults to 1. Sends `n` interpolated `mousemove` events to represent travel between Playwright's current cursor position and the provided destination. When set to 1, emits a single `mousemove` event at the destination location.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> move(double x, double y, {int? steps}) async {
    await (page as PageImpl).channel_mouseMove(x: x, y: y, steps: steps);
  }

  /// Dispatches a `mousedown` event.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await mouse.down();
  /// await mouse.down(options);
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `button` PageMouseDownButtonEnum *(optional)*
  ///
  ///     Defaults to `left`.
  ///   - `clickCount` int *(optional)*
  ///
  ///     defaults to 1. See [UIEvent.detail].
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> down({PageMouseDownButtonEnum? button, int? clickCount}) async {
    await (page as PageImpl).channel_mouseDown(
      button: button,
      clickCount: clickCount,
    );
  }

  /// Dispatches a `mouseup` event.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await mouse.up();
  /// await mouse.up(options);
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `button` PageMouseUpButtonEnum *(optional)*
  ///
  ///     Defaults to `left`.
  ///   - `clickCount` int *(optional)*
  ///
  ///     defaults to 1. See [UIEvent.detail].
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> up({PageMouseUpButtonEnum? button, int? clickCount}) async {
    await (page as PageImpl).channel_mouseUp(
      button: button,
      clickCount: clickCount,
    );
  }

  /// Shortcut for [mouse.move()], [mouse.down()], [mouse.up()].
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await mouse.click(x, y);
  /// await mouse.click(x, y, options);
  /// ```
  ///
  /// **Arguments**
  /// - `x` double
  ///
  ///   X coordinate relative to the main frame's viewport in CSS pixels.
  /// - `y` double
  ///
  ///   Y coordinate relative to the main frame's viewport in CSS pixels.
  /// - `options` Map *(optional)*
  ///   - `button` PageMouseClickButtonEnum *(optional)*
  ///
  ///     Defaults to `left`.
  ///   - `clickCount` int *(optional)*
  ///
  ///     defaults to 1. See [UIEvent.detail].
  ///   - `delay` double *(optional)*
  ///
  ///     Time to wait between `mousedown` and `mouseup` in milliseconds. Defaults to 0.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> click(
    double x,
    double y, {
    double? delay,
    PageMouseClickButtonEnum? button,
    int? clickCount,
  }) async {
    await (page as PageImpl).channel_mouseClick(
      x: x,
      y: y,
      delay: delay,
      button: button,
      clickCount: clickCount,
    );
  }

  /// Shortcut for [mouse.move()], [mouse.down()], [mouse.up()], [mouse.down()] and [mouse.up()].
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await mouse.dblclick(x, y);
  /// await mouse.dblclick(x, y, options);
  /// ```
  ///
  /// **Arguments**
  /// - `x` mouse.up(). /// /// **Usage** /// /// ```dart /// await mouse.click(x, y); /// await mouse.click(x, y, options); /// ``` /// /// **Arguments** /// - `x` num /// /// X coordinate relative to the main frame's viewport in CSS pixels. /// - `y` num /// /// Y coordinate relative to the main frame's viewport in CSS pixels. /// - `options` Map *(optional)* /// - `button` button: *(optional)* /// /// Defaults to `left`. /// - `clickCount` num *(optional)* /// /// defaults to 1. See UIEvent.detail. /// - `delay` delay: *(optional)* /// /// Time to wait between `mousedown` and `mouseup` in milliseconds. Defaults to 0. /// /// **Returns** /// - Future&lt;void&gt; double
  ///
  ///   X coordinate relative to the main frame's viewport in CSS pixels.
  /// - `y` double
  ///
  ///   Y coordinate relative to the main frame's viewport in CSS pixels.
  /// - `options` Map *(optional)*
  ///   - `button` PageMouseClickButtonEnum *(optional)*
  ///
  ///     Defaults to `left`.
  ///   - `delay` double *(optional)*
  ///
  ///     Time to wait between `mousedown` and `mouseup` in milliseconds. Defaults to 0.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> dblclick(
    /// Shortcut for [mouse.move()], [mouse.down()], [mouse.up()].
    ///
    /// **Usage**
    ///
    /// ```dart
    /// await mouse.click(x, y);
    /// await mouse.click(x, y, options);
    /// ```
    ///
    /// **Arguments**
    /// - `x` num
    ///
    ///   X coordinate relative to the main frame's viewport in CSS pixels.
    /// - `y` num
    ///
    ///   Y coordinate relative to the main frame's viewport in CSS pixels.
    /// - `options` Map *(optional)*
    ///   - `button` button: *(optional)*
    ///
    ///     Defaults to `left`.
    ///   - `clickCount` num *(optional)*
    ///
    ///     defaults to 1. See [UIEvent.detail].
    ///   - `delay` delay: *(optional)*
    ///
    ///     Time to wait between `mousedown` and `mouseup` in milliseconds. Defaults to 0.
    ///
    /// **Returns**
    /// - Future&lt;void&gt;
    double x,
    double y, {
    double? delay,
    PageMouseClickButtonEnum? button,
  }) async {
    await click(x, y, delay: delay, button: button, clickCount: 2);
  }

  /// Dispatches a `wheel` event. This method is usually used to manually scroll the page. See [scrolling] for alternative ways to scroll.
  ///
  /// **NOTE**
  /// Wheel events may cause scrolling if they are not handled, and this method does not wait for the scrolling to finish before returning.
  /// **Usage**
  ///
  /// ```dart
  /// await mouse.wheel(deltaX, deltaY);
  /// ```
  ///
  /// **Arguments**
  /// - `deltaX` double
  ///
  ///   Pixels to scroll horizontally.
  /// - `deltaY` double
  ///
  ///   Pixels to scroll vertically.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  ///
  ///
  /// [APIRequest]: /api/class-apirequest.mdx "APIRequest"
  /// [APIRequestContext]: /api/class-apirequestcontext.mdx "APIRequestContext"
  /// [APIResponse]: /api/class-apiresponse.mdx "APIResponse"
  /// [APIResponseAssertions]: /api/class-apiresponseassertions.mdx "APIResponseAssertions"
  /// [Browser]: /api/class-browser.mdx "Browser"
  /// [BrowserContext]: /api/class-browsercontext.mdx "BrowserContext"
  /// [BrowserServer]: /api/class-browserserver.mdx "BrowserServer"
  /// [BrowserType]: /api/class-browsertype.mdx "BrowserType"
  /// [CDPSession]: /api/class-cdpsession.mdx "CDPSession"
  /// [Clock]: /api/class-clock.mdx "Clock"
  /// [ConsoleMessage]: /api/class-consolemessage.mdx "ConsoleMessage"
  /// [Coverage]: /api/class-coverage.mdx "Coverage"
  /// [Credentials]: /api/class-credentials.mdx "Credentials"
  /// [Debugger]: /api/class-debugger.mdx "Debugger"
  /// [Dialog]: /api/class-dialog.mdx "Dialog"
  /// [Disposable]: /api/class-disposable.mdx "Disposable"
  /// [Download]: /api/class-download.mdx "Download"
  /// [ElementHandle]: /api/class-elementhandle.mdx "ElementHandle"
  /// [FileChooser]: /api/class-filechooser.mdx "FileChooser"
  /// [Frame]: /api/class-frame.mdx "Frame"
  /// [FrameLocator]: /api/class-framelocator.mdx "FrameLocator"
  /// [GenericAssertions]: /api/class-genericassertions.mdx "GenericAssertions"
  /// [JSHandle]: /api/class-jshandle.mdx "JSHandle"
  /// [Keyboard]: /api/class-keyboard.mdx "Keyboard"
  /// [Locator]: /api/class-locator.mdx "Locator"
  /// [LocatorAssertions]: /api/class-locatorassertions.mdx "LocatorAssertions"
  /// [Logger]: /api/class-logger.mdx "Logger"
  /// [Mouse]: /api/class-mouse.mdx "Mouse"
  /// [Page]: /api/class-page.mdx "Page"
  /// [PageAssertions]: /api/class-pageassertions.mdx "PageAssertions"
  /// [Playwright]: /api/class-playwright.mdx "Playwright"
  /// [PlaywrightAssertions]: /api/class-playwrightassertions.mdx "PlaywrightAssertions"
  /// [Request]: /api/class-request.mdx "Request"
  /// [Response]: /api/class-response.mdx "Response"
  /// [Route]: /api/class-route.mdx "Route"
  /// [Screencast]: /api/class-screencast.mdx "Screencast"
  /// [Selectors]: /api/class-selectors.mdx "Selectors"
  /// [SnapshotAssertions]: /api/class-snapshotassertions.mdx "SnapshotAssertions"
  /// [TimeoutError]: /api/class-timeouterror.mdx "TimeoutError"
  /// [Touchscreen]: /api/class-touchscreen.mdx "Touchscreen"
  /// [Tracing]: /api/class-tracing.mdx "Tracing"
  /// [Video]: /api/class-video.mdx "Video"
  /// [WebError]: /api/class-weberror.mdx "WebError"
  /// [WebSocket]: /api/class-websocket.mdx "WebSocket"
  /// [WebSocketRoute]: /api/class-websocketroute.mdx "WebSocketRoute"
  /// [WebStorage]: /api/class-webstorage.mdx "WebStorage"
  /// [Worker]: /api/class-worker.mdx "Worker"
  /// [Electron]: /api/class-electron.mdx "Electron"
  /// [ElectronApplication]: /api/class-electronapplication.mdx "ElectronApplication"
  /// [Android]: /api/class-android.mdx "Android"
  /// [AndroidDevice]: /api/class-androiddevice.mdx "AndroidDevice"
  /// [AndroidInput]: /api/class-androidinput.mdx "AndroidInput"
  /// [AndroidSocket]: /api/class-androidsocket.mdx "AndroidSocket"
  /// [AndroidWebView]: /api/class-androidwebview.mdx "AndroidWebView"
  /// [Fixtures]: /api/class-fixtures.mdx "Fixtures"
  /// [FullConfig]: /api/class-fullconfig.mdx "FullConfig"
  /// [FullProject]: /api/class-fullproject.mdx "FullProject"
  /// [Location]: /api/class-location.mdx "Location"
  /// [Test]: /api/class-test.mdx "Test"
  /// [TestConfig]: /api/class-testconfig.mdx "TestConfig"
  /// [TestInfo]: /api/class-testinfo.mdx "TestInfo"
  /// [TestInfoError]: /api/class-testinfoerror.mdx "TestInfoError"
  /// [TestOptions]: /api/class-testoptions.mdx "TestOptions"
  /// [TestProject]: /api/class-testproject.mdx "TestProject"
  /// [TestStepInfo]: /api/class-teststepinfo.mdx "TestStepInfo"
  /// [WorkerInfo]: /api/class-workerinfo.mdx "WorkerInfo"
  /// [Reporter]: /api/class-reporter.mdx "Reporter"
  /// [Suite]: /api/class-suite.mdx "Suite"
  /// [TestCase]: /api/class-testcase.mdx "TestCase"
  /// [TestError]: /api/class-testerror.mdx "TestError"
  /// [TestResult]: /api/class-testresult.mdx "TestResult"
  /// [TestStep]: /api/class-teststep.mdx "TestStep"
  /// [EvaluationArgument]: /evaluating.mdx#evaluation-argument "EvaluationArgument"
  /// [UIEvent.detail]: https://developer.mozilla.org/en-US/docs/Web/API/UIEvent/detail "UIEvent.detail"
  ///
  ///
  /// [all available image tags]: https://mcr.microsoft.com/en-us/product/playwright/about "all available image tags"
  /// [Microsoft Artifact Registry]: https://mcr.microsoft.com/en-us/product/playwright/about "Microsoft Artifact Registry"
  /// [Dockerfile.noble]: https://github.com/microsoft/playwright/blob/main/utils/docker/Dockerfile.noble "Dockerfile.noble"
  Future<void> wheel(double deltaX, double deltaY) async {
    await (page as PageImpl).channel_mouseWheel(deltaX: deltaX, deltaY: deltaY);
  }

  // Shorthand convenience methods for common mouse operations

  /// Left-clicks at the specified coordinates.
  Future<void> leftClick(
    /// Shortcut for [mouse.move()], [mouse.down()], [mouse.up()].
    ///
    /// **Usage**
    ///
    /// ```dart
    /// await mouse.click(x, y);
    /// await mouse.click(x, y, options);
    /// ```
    ///
    /// **Arguments**
    /// - `x` num
    ///
    ///   X coordinate relative to the main frame's viewport in CSS pixels.
    /// - `y` num
    ///
    ///   Y coordinate relative to the main frame's viewport in CSS pixels.
    /// - `options` Map *(optional)*
    ///   - `button` "left" | "right" | "middle" *(optional)*
    ///
    ///     Defaults to `left`.
    ///   - `clickCount` num *(optional)*
    ///
    ///     defaults to 1. See [UIEvent.detail].
    ///   - `delay` num *(optional)*
    ///
    ///     Time to wait between `mousedown` and `mouseup` in milliseconds. Defaults to 0.
    ///
    /// **Returns**
    /// - Future&lt;void&gt;
    double x,
    double y, {
    double? delay,
    int? clickCount,
  }) async {
    await click(
      x,
      y,
      delay: delay,
      button: PageMouseClickButtonEnum.left,
      clickCount: clickCount,
    );
  }

  /// Right-clicks at the specified coordinates.
  Future<void> rightClick(
    /// Shortcut for [mouse.move()], [mouse.down()], [mouse.up()].
    ///
    /// **Usage**
    ///
    /// ```dart
    /// await mouse.click(x, y);
    /// await mouse.click(x, y, options);
    /// ```
    ///
    /// **Arguments**
    /// - `x` num
    ///
    ///   X coordinate relative to the main frame's viewport in CSS pixels.
    /// - `y` num
    ///
    ///   Y coordinate relative to the main frame's viewport in CSS pixels.
    /// - `options` Map *(optional)*
    ///   - `button` "left" | "right" | "middle" *(optional)*
    ///
    ///     Defaults to `left`.
    ///   - `clickCount` num *(optional)*
    ///
    ///     defaults to 1. See [UIEvent.detail].
    ///   - `delay` num *(optional)*
    ///
    ///     Time to wait between `mousedown` and `mouseup` in milliseconds. Defaults to 0.
    ///
    /// **Returns**
    /// - Future&lt;void&gt;
    double x,
    double y, {
    double? delay,
    int? clickCount,
  }) async {
    await click(
      x,
      y,
      delay: delay,
      button: PageMouseClickButtonEnum.right,
      clickCount: clickCount,
    );
  }

  /// Middle-clicks at the specified coordinates.
  Future<void> middleClick(
    /// Shortcut for [mouse.move()], [mouse.down()], [mouse.up()].
    ///
    /// **Usage**
    ///
    /// ```dart
    /// await mouse.click(x, y);
    /// await mouse.click(x, y, options);
    /// ```
    ///
    /// **Arguments**
    /// - `x` num
    ///
    ///   X coordinate relative to the main frame's viewport in CSS pixels.
    /// - `y` num
    ///
    ///   Y coordinate relative to the main frame's viewport in CSS pixels.
    /// - `options` Map *(optional)*
    ///   - `button` "left" | "right" | "middle" *(optional)*
    ///
    ///     Defaults to `left`.
    ///   - `clickCount` num *(optional)*
    ///
    ///     defaults to 1. See [UIEvent.detail].
    ///   - `delay` num *(optional)*
    ///
    ///     Time to wait between `mousedown` and `mouseup` in milliseconds. Defaults to 0.
    ///
    /// **Returns**
    /// - Future&lt;void&gt;
    double x,
    double y, {
    double? delay,
    int? clickCount,
  }) async {
    await click(
      x,
      y,
      delay: delay,
      button: PageMouseClickButtonEnum.middle,
      clickCount: clickCount,
    );
  }

  /// Double left-clicks at the specified coordinates.
  Future<void> leftDblclick(double x, double y, {double? delay}) async {
    /// Shortcut for [mouse.move()], [mouse.down()], [mouse.up()], [mouse.down()] and [mouse.up()].
    ///
    /// **Usage**
    ///
    /// ```dart
    /// await mouse.dblclick(x, y);
    /// await mouse.dblclick(x, y, options);
    /// ```
    ///
    /// **Arguments**
    /// - `x` num
    ///
    ///   X coordinate relative to the main frame's viewport in CSS pixels.
    /// - `y` num
    ///
    ///   Y coordinate relative to the main frame's viewport in CSS pixels.
    /// - `options` Map *(optional)*
    ///   - `button` "left" | "right" | "middle" *(optional)*
    ///
    ///     Defaults to `left`.
    ///   - `delay` delay: *(optional)*
    ///
    ///     Time to wait between `mousedown` and `mouseup` in milliseconds. Defaults to 0.
    ///
    /// **Returns**
    /// - Future&lt;void&gt;
    await dblclick(x, y, delay: delay, button: PageMouseClickButtonEnum.left);
  }

  /// Double right-clicks at the specified coordinates.
  Future<void> rightDblclick(double x, double y, {double? delay}) async {
    /// Shortcut for [mouse.move()], [mouse.down()], [mouse.up()], [mouse.down()] and [mouse.up()].
    ///
    /// **Usage**
    ///
    /// ```dart
    /// await mouse.dblclick(x, y);
    /// await mouse.dblclick(x, y, options);
    /// ```
    ///
    /// **Arguments**
    /// - `x` num
    ///
    ///   X coordinate relative to the main frame's viewport in CSS pixels.
    /// - `y` num
    ///
    ///   Y coordinate relative to the main frame's viewport in CSS pixels.
    /// - `options` Map *(optional)*
    ///   - `button` "left" | "right" | "middle" *(optional)*
    ///
    ///     Defaults to `left`.
    ///   - `delay` delay: *(optional)*
    ///
    ///     Time to wait between `mousedown` and `mouseup` in milliseconds. Defaults to 0.
    ///
    /// **Returns**
    /// - Future&lt;void&gt;
    await dblclick(x, y, delay: delay, button: PageMouseClickButtonEnum.right);
  }

  /// Double middle-clicks at the specified coordinates.
  Future<void> middleDblclick(double x, double y, {double? delay}) async {
    /// Shortcut for [mouse.move()], [mouse.down()], [mouse.up()], [mouse.down()] and [mouse.up()].
    ///
    /// **Usage**
    ///
    /// ```dart
    /// await mouse.dblclick(x, y);
    /// await mouse.dblclick(x, y, options);
    /// ```
    ///
    /// **Arguments**
    /// - `x` num
    ///
    ///   X coordinate relative to the main frame's viewport in CSS pixels.
    /// - `y` num
    ///
    ///   Y coordinate relative to the main frame's viewport in CSS pixels.
    /// - `options` Map *(optional)*
    ///   - `button` "left" | "right" | "middle" *(optional)*
    ///
    ///     Defaults to `left`.
    ///   - `delay` delay: *(optional)*
    ///
    ///     Time to wait between `mousedown` and `mouseup` in milliseconds. Defaults to 0.
    ///
    /// **Returns**
    /// - Future&lt;void&gt;
    await dblclick(x, y, delay: delay, button: PageMouseClickButtonEnum.middle);
  }

  /// Scrolls up by the specified amount.
  Future<void> scrollUp(double amount) async => wheel(0, -amount);

  /// Scrolls down by the specified amount.
  Future<void> scrollDown(double amount) async => wheel(0, amount);

  /// Scrolls left by the specified amount.
  Future<void> scrollLeft(double amount) async => wheel(-amount, 0);

  /// Scrolls right by the specified amount.
  Future<void> scrollRight(double amount) async => wheel(amount, 0);
}
