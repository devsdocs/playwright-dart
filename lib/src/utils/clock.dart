import '../core/browser_context.dart';

/// Clock API for mocking time in browser contexts.
abstract interface class Clock {
  /// Install fake implementations for the following time-related functions:
  /// * `Date`
  /// * `setTimeout`
  /// * `clearTimeout`
  /// * `setInterval`
  /// * `clearInterval`
  /// * `requestAnimationFrame`
  /// * `cancelAnimationFrame`
  /// * `requestIdleCallback`
  /// * `cancelIdleCallback`
  /// * `performance`
  ///
  /// Fake timers are used to manually control the flow of time in tests. They allow you to advance time, fire timers, and control the behavior of time-dependent functions. See [clock.runFor()] and [clock.fastForward()] for more information.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await clock.install();
  /// await clock.install(options);
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `time` num | String | [Date] *(optional)*
  ///
  ///     Time to initialize with, current system time by default.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> install({double? timeNumber, String? timeString});

  /// Advance the clock by jumping forward in time. Only fires due timers at most once. This is equivalent to user closing the laptop lid for a while and reopening it later, after given time.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await page.clock.fastForward(1000);
  /// await page.clock.fastForward('30:00');
  /// ```
  ///
  /// **Arguments**
  /// - `ticks` num | String
  ///
  ///   Time may be the number of milliseconds to advance the clock by or a human-readable string. Valid string formats are "08" for eight seconds, "01:00" for one minute and "02:34:10" for two hours, 34 minutes and ten seconds.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> fastForward({double? ticksNumber, String? ticksString});

  /// Advance the clock by jumping forward in time and pause the time. Once this method is called, no timers are fired unless [clock.runFor()], [clock.fastForward()], [clock.pauseAt()] or [clock.resume()] is called.
  ///
  /// Only fires due timers at most once. This is equivalent to user closing the laptop lid for a while and reopening it at the specified time and pausing.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await page.clock.pauseAt(new Date('2020-02-02'));
  /// await page.clock.pauseAt('2020-02-02');
  /// ```
  ///
  /// For best results, install the clock before navigating the page and set it to a time slightly before the intended test time. This ensures that all timers run normally during page loading, preventing the page from getting stuck. Once the page has fully loaded, you can safely use [clock.pauseAt()] to pause the clock.
  ///
  /// ```dart
  /// // Initialize clock with some time before the test time and var the page load
  /// // naturally. `Date.now` will progress as the timers fire.
  /// await page.clock.install( time: new Date('2024-12-10T08:00:00') );
  /// await page.goto('http://localhost:3333');
  /// await page.clock.pauseAt(new Date('2024-12-10T10:00:00'));
  /// ```
  ///
  /// **Arguments**
  /// - `time` num | String | [Date]
  ///
  ///   Time to pause at.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> pauseAt({double? timeNumber, String? timeString});

  /// Resumes timers. Once this method is called, time resumes flowing, timers are fired as usual.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await clock.resume();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> resume();

  /// Advance the clock, firing all the time-related callbacks.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await page.clock.runFor(1000);
  /// await page.clock.runFor('30:00');
  /// ```
  ///
  /// **Arguments**
  /// - `ticks` num | String
  ///
  ///   Time may be the number of milliseconds to advance the clock by or a human-readable string. Valid string formats are "08" for eight seconds, "01:00" for one minute and "02:34:10" for two hours, 34 minutes and ten seconds.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> runFor({double? ticksNumber, String? ticksString});

  /// Makes `Date.now` and `new Date()` return fixed fake time at all times, keeps all the timers running.
  ///
  /// Use this method for simple scenarios where you only need to test with a predefined time. For more advanced scenarios, use [clock.install()] instead. Read docs on [clock emulation] to learn more.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await page.clock.setFixedTime(Date.now());
  /// await page.clock.setFixedTime(new Date('2020-02-02'));
  /// await page.clock.setFixedTime('2020-02-02');
  /// ```
  ///
  /// **Arguments**
  /// - `time` num | String | [Date]
  ///
  ///   Time to be set in milliseconds.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> setFixedTime({double? timeNumber, String? timeString});

  /// Sets system time, but does not trigger any timers. Use this to test how the web page reacts to a time shift, for example switching from summer to winter time, or changing time zones.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await page.clock.setSystemTime(Date.now());
  /// await page.clock.setSystemTime(new Date('2020-02-02'));
  /// await page.clock.setSystemTime('2020-02-02');
  /// ```
  ///
  /// **Arguments**
  /// - `time` num | String | [Date]
  ///
  ///   Time to be set in milliseconds.
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
  Future<void> setSystemTime({double? timeNumber, String? timeString});
}

class ClockImpl implements Clock {
  final BrowserContext _context;

  ClockImpl(this._context);

  @override
  Future<void> install({double? timeNumber, String? timeString}) =>
      _context.clockInstall(timeNumber: timeNumber, timeString: timeString);

  @override
  Future<void> fastForward({double? ticksNumber, String? ticksString}) =>
      _context.clockFastForward(
        ticksNumber: ticksNumber,
        ticksString: ticksString,
      );

  @override
  Future<void> pauseAt({double? timeNumber, String? timeString}) =>
      _context.clockPauseAt(timeNumber: timeNumber, timeString: timeString);

  @override
  Future<void> resume() => _context.clockResume();

  @override
  Future<void> runFor({double? ticksNumber, String? ticksString}) =>
      _context.clockRunFor(ticksNumber: ticksNumber, ticksString: ticksString);

  @override
  Future<void> setFixedTime({double? timeNumber, String? timeString}) =>
      _context.clockSetFixedTime(
        timeNumber: timeNumber,
        timeString: timeString,
      );

  @override
  Future<void> setSystemTime({double? timeNumber, String? timeString}) =>
      _context.clockSetSystemTime(
        timeNumber: timeNumber,
        timeString: timeString,
      );
}
