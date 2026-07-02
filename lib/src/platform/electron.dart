import '../generated/channels.dart';

/// Interface for Electron
abstract interface class Electron {
  /// Launches electron application specified with the [executablePath].
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await electron.launch();
  /// await electron.launch(options);
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `acceptDownloads` ElectronLaunchAcceptDownloadsEnum *(optional)*
  ///
  ///     Whether to automatically download all the attachments. Defaults to `true` where all the downloads are accepted.
  ///   - `args` List&lt;String&gt; *(optional)*
  ///
  ///     Additional arguments to pass to the application when launching. You typically pass the main script name here.
  ///   - `artifactsDir` String *(optional)*
  ///
  ///     If specified, artifacts (traces, videos, downloads, HAR files, etc.) are saved into this directory. The directory is not cleaned up when the browser closes. If not specified, a temporary directory is used and cleaned up when the browser closes.
  ///   - `bypassCSP` bool *(optional)*
  ///
  ///     Toggles bypassing page's Content-Security-Policy. Defaults to `false`.
  ///   - `chromiumSandbox` bool *(optional)*
  ///
  ///     Enable Chromium sandboxing. Defaults to `false`.
  ///   - `colorScheme` ElectronLaunchColorSchemeEnum *(optional)*
  ///
  ///     Emulates [prefers-colors-scheme] media feature, supported values are `'light'` and `'dark'`. See [page.emulateMedia()] for more details. Passing `null` resets emulation to system defaults. Defaults to `'light'`.
  ///   - `cwd` String *(optional)*
  ///
  ///     Current working directory to launch application from.
  ///   - `env` List&lt;NameValue&gt; *(optional)*
  ///
  ///     Specifies environment variables that will be visible to Electron. Defaults to `process.env`.
  ///   - `executablePath` String *(optional)*
  ///
  ///     Launches given Electron application. If not specified, launches the default Electron executable installed in this package, located at `node_modules/.bin/electron`.
  ///   - `extraHTTPHeaders` List&lt;NameValue&gt; *(optional)*
  ///
  ///     An object containing additional HTTP headers to be sent with every request. Defaults to none.
  ///   - `geolocation` Map&lt;String, dynamic&gt; *(optional)*
  ///     - `latitude` num
  ///
  ///       Latitude between -90 and 90.
  ///     - `longitude` num
  ///
  ///       Longitude between -180 and 180.
  ///     - `accuracy` num *(optional)*
  ///
  ///       Non-negative accuracy value. Defaults to `0`.
  ///   - `httpCredentials` Map&lt;String, dynamic&gt; *(optional)*
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
  ///   - `locale` String *(optional)*
  ///
  ///     Specify user locale, for example `en-GB`, `de-DE`, etc. Locale will affect `navigator.language` value, `Accept-Language` request header value as well as number and date formatting rules. Defaults to the system default locale. Learn more about emulation in our [emulation guide].
  ///   - `offline` bool *(optional)*
  ///
  ///     Whether to emulate network being offline. Defaults to `false`. Learn more about [network emulation].
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
  ///   - `recordVideo` Map&lt;String, dynamic&gt; *(optional)*
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
  ///
  ///       If specified, enables visual annotations on interacted elements during video recording.
  ///
  ///     Enables video recording for all pages into `recordVideo.dir` directory. If not specified videos are not recorded. Make sure to await [browserContext.close()] for videos to be saved.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds to wait for the application to start. Defaults to `30000` (30 seconds). Pass `0` to disable timeout.
  ///   - `timezoneId` String *(optional)*
  ///
  ///     Changes the timezone of the context. See [ICU's metaZones.txt] for a list of supported timezone IDs. Defaults to the system timezone.
  ///   - `tracesDir` String *(optional)*
  ///
  ///     If specified, traces are saved into this directory.
  ///
  /// **Returns**
  /// - Future&lt;[ElectronApplication]&gt;
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
  Future<ElectronLaunchResult> launch({
    String? executablePath,
    List<String>? args,
    bool? chromiumSandbox,
    String? cwd,
    List<NameValue>? env,
    required double timeout,
    ElectronLaunchAcceptDownloadsEnum? acceptDownloads,
    bool? bypassCSP,
    ElectronLaunchColorSchemeEnum? colorScheme,
    List<NameValue>? extraHTTPHeaders,
    Map<String, dynamic>? geolocation,
    Map<String, dynamic>? httpCredentials,
    bool? ignoreHTTPSErrors,
    String? locale,
    bool? offline,
    Map<String, dynamic>? recordVideo,
    bool? strictSelectors,
    String? timezoneId,
    String? tracesDir,
    String? artifactsDir,
    List<SelectorEngine>? selectorEngines,
    String? testIdAttributeName,
  });
}

class ElectronImpl extends ElectronBase implements Electron {
  ElectronImpl(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  @override
  Future<ElectronLaunchResult> launch({
    String? executablePath,
    List<String>? args,
    bool? chromiumSandbox,
    String? cwd,
    List<NameValue>? env,
    required double timeout,
    ElectronLaunchAcceptDownloadsEnum? acceptDownloads,
    bool? bypassCSP,
    ElectronLaunchColorSchemeEnum? colorScheme,
    List<NameValue>? extraHTTPHeaders,
    Map<String, dynamic>? geolocation,
    Map<String, dynamic>? httpCredentials,
    bool? ignoreHTTPSErrors,
    String? locale,
    bool? offline,
    Map<String, dynamic>? recordVideo,
    bool? strictSelectors,
    String? timezoneId,
    String? tracesDir,
    String? artifactsDir,
    List<SelectorEngine>? selectorEngines,
    String? testIdAttributeName,
  }) async {
    return await channel_launch(
      executablePath: executablePath,
      args: args,
      chromiumSandbox: chromiumSandbox,
      cwd: cwd,
      env: env,
      timeout: timeout,
      acceptDownloads: acceptDownloads,
      bypassCSP: bypassCSP,
      colorScheme: colorScheme,
      extraHTTPHeaders: extraHTTPHeaders,
      geolocation: geolocation == null
          ? null
          : ElectronLaunchGeolocation.fromJson(geolocation),
      httpCredentials: httpCredentials == null
          ? null
          : ElectronLaunchHttpCredentials.fromJson(httpCredentials),
      ignoreHTTPSErrors: ignoreHTTPSErrors,
      locale: locale,
      offline: offline,
      recordVideo: recordVideo == null
          ? null
          : ElectronLaunchRecordVideo.fromJson(recordVideo),
      strictSelectors: strictSelectors,
      timezoneId: timezoneId,
      tracesDir: tracesDir,
      artifactsDir: artifactsDir,
      selectorEngines: selectorEngines,
      testIdAttributeName: testIdAttributeName,
    );
  }
}
