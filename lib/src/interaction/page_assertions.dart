import '../core/frame.dart';
import '../core/page.dart';
import '../generated/channels.dart';

/// Web-first assertions for a [Page].
///
/// Obtain via [Page.pageExpect]:
/// ```dart
/// await page.pageExpect().toHaveTitle('My Page');
/// await page.pageExpect().toHaveURL('https://example.com/login');
/// ```
class PageAssertions {
  final Page _page;
  final bool _isNot;
  final double? _timeout;

  PageAssertions(this._page, [this._isNot = false, this._timeout]);

  /// Makes the assertion check for the opposite condition.
  ///
  /// **Usage**
  ///
  /// For example, this code tests that the page URL doesn't contain `"error"`:
  ///
  /// ```dart
  /// await expect(page).not.toHaveURL('error');
  /// ```
  ///
  /// **Type**
  /// - [PageAssertions]
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
  PageAssertions get not => PageAssertions(_page, !_isNot, _timeout);

  /// Ensures the page has the given title.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await expect(page).toHaveTitle(/.*checkout/);
  /// ```
  ///
  /// **Arguments**
  /// - `titleOrRegExp` String | [RegExp]
  ///
  ///   Expected title or RegExp.
  /// - `options` Map *(optional)*
  ///   - `timeout` double *(optional)*
  ///
  ///     Time to retry the assertion for in milliseconds. Defaults to `timeout` in `TestConfig.expect`.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> toHaveTitle(Pattern expected, {double? timeout}) async {
    final text = _patternToExpectedText(expected);
    // Page-level assertions (title, url) must NOT pass a selector; the
    // Playwright Node.js driver resolves these from `document` when no element
    // is resolved (selector absent → element null in the driver).
    await (_page.mainFrame as FrameImpl).channel.expect(
      expression: 'to.have.title',
      expectedText: text,
      isNot: _isNot,
      timeout: timeout ?? _timeout ?? 5000.0,
      // selector intentionally omitted — page assertion, not DOM assertion
    );
  }

  /// Ensures the page is navigated to the given URL.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// // Check for the page URL to be 'https://playwright.dev/docs/intro' (including query string)
  /// await expect(page).toHaveURL('https://playwright.dev/docs/intro');
  ///
  /// // Check for the page URL to contain 'doc', followed by an optional 's', followed by '/'
  /// await expect(page).toHaveURL(/docs?\//);
  ///
  /// // Check for the page URL to match the URL pattern
  /// await expect(page).toHaveURL(new URLPattern( pathname: '/docs/*' ));
  ///
  /// // Check for the predicate to be satisfied
  /// // For example: verify query strings
  /// await expect(page).toHaveURL((url) {
  ///   final params = url.searchParams;
  ///   return params.has('search') && params.has('options') && params.get('id') == '5';
  /// );
  /// ```
  ///
  /// **Arguments**
  /// - `url` String | [RegExp] | [URLPattern] | Function\([URL]\):bool
  ///
  ///   Expected URL string, RegExp, or predicate receiving [URL] to match. When [baseURL] is provided via the context options and the `url` argument is a string, the two values are merged via the [`new URL()`] constructor and used for the comparison against the current browser URL.
  /// - `options` Map *(optional)*
  ///   - `ignoreCase` bool *(optional)*
  ///
  ///     Whether to perform case-insensitive match. [ignoreCase] option takes precedence over the corresponding regular expression parameter if specified. A provided predicate ignores this flag.
  ///   - `timeout` double *(optional)*
  ///
  ///     Time to retry the assertion for in milliseconds. Defaults to `timeout` in `TestConfig.expect`.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> toHaveURL(Pattern expected, {double? timeout}) async {
    final text = _patternToExpectedText(expected);
    await (_page.mainFrame as FrameImpl).channel.expect(
      expression: 'to.have.url',
      expectedText: text,
      isNot: _isNot,
      timeout: timeout ?? _timeout ?? 5000.0,
      // selector intentionally omitted — page assertion, not DOM assertion
    );
  }

  // ---- helpers -------------------------------------------------------

  List<ExpectedTextValue> _patternToExpectedText(Pattern expected) {
    if (expected is RegExp) {
      return [
        ExpectedTextValue(
          regexSource: expected.pattern,
          regexFlags: _regexFlags(expected),
          matchSubstring: false,
        ),
      ];
    }
    return [
      ExpectedTextValue(string: expected as String, matchSubstring: false),
    ];
  }

  String _regexFlags(RegExp re) {
    final flags = StringBuffer();
    if (!re.isCaseSensitive) flags.write('i');
    if (re.isMultiLine) flags.write('m');
    if (re.isDotAll) flags.write('s');
    if (re.isUnicode) flags.write('u');
    return flags.toString();
  }
}
