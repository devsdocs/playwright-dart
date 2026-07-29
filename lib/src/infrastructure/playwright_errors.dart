/// Playwright typed error hierarchy.
///
/// Mirrors the error classes in the official Playwright Node.js client:
/// - [PlaywrightError] — base class for all Playwright errors.
/// - [TimeoutError] — thrown when an action exceeds its timeout.
/// - [TargetClosedError] — thrown when the target page, context or browser
///   has been closed before the action completes.
library;

/// Base class for all Playwright errors.
class PlaywrightError implements Exception {
  final String message;

  /// Optional log lines collected during the failing operation.
  final List<String> log;

  const PlaywrightError(this.message, {this.log = const []});

  @override
  String toString() {
    final logSection = log.isEmpty ? '' : '\n\n${_formatLog(log)}';
    return 'PlaywrightError: $message$logSection';
  }

  static String _formatLog(List<String> log) {
    const header = ' logs ';
    const width = 60;
    final left = (width - header.length) ~/ 2;
    final right = width - header.length - left;
    final bar = '=' * left + header + '=' * right;
    return '$bar\n${log.join('\n')}\n${'=' * width}';
  }
}

/// * extends: [Error]
///
/// TimeoutError is emitted whenever certain operations are terminated due to timeout, e.g. [locator.waitFor()] or [browserType.launch()].
///
/// ```dart
///
/// (() async {
///   final browser = await playwright.chromium.launch();
///   final context = await browser.newContext();
///   final page = await context.newPage();
///   try {
///     await page.locator('text=Foo').click(
///       timeout: 100,
///     );
///   } catch (error) {
///     if (error instanceof playwright.errors.TimeoutError)
///       print('Timeout!');
///   }
///   await browser.close();
/// }
/// ```
///
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
/// [TestRun]: /api/class-testrun.mdx "TestRun"
/// [TestStep]: /api/class-teststep.mdx "TestStep"
/// [EvaluationArgument]: /evaluating.mdx#evaluation-argument "EvaluationArgument"
/// [UIEvent.detail]: https://developer.mozilla.org/en-US/docs/Web/API/UIEvent/detail "UIEvent.detail"
///
///
/// [all available image tags]: https://mcr.microsoft.com/en-us/product/playwright/about "all available image tags"
/// [Microsoft Artifact Registry]: https://mcr.microsoft.com/en-us/product/playwright/about "Microsoft Artifact Registry"
/// [Dockerfile.noble]: https://github.com/microsoft/playwright/blob/main/utils/docker/Dockerfile.noble "Dockerfile.noble"
class TimeoutError extends PlaywrightError {
  const TimeoutError(super.message, {super.log});

  @override
  String toString() => 'TimeoutError: $message';
}

/// Thrown when the target page, context or browser has been closed.
class TargetClosedError extends PlaywrightError {
  const TargetClosedError([String? cause])
    : super(cause ?? 'Target page, context or browser has been closed');

  @override
  String toString() => 'TargetClosedError: $message';
}

/// Returns `true` when [error] is a [TargetClosedError].
bool isTargetClosedError(Object error) => error is TargetClosedError;

/// Returns `true` when [error] is a [TimeoutError].
bool isTimeoutError(Object error) => error is TimeoutError;

/// Parses an error message string from the server and returns the appropriate
/// typed [PlaywrightError] subclass.
PlaywrightError parseServerError(String message) {
  if (message.contains('TimeoutError') || message.startsWith('TimeoutError:')) {
    return TimeoutError(message);
  }
  if (message.contains('TargetClosedError') ||
      message.contains('Target closed') ||
      message.contains('Browser has been closed') ||
      message.contains('Target page, context or browser has been closed')) {
    return TargetClosedError(message);
  }
  return PlaywrightError(message);
}
