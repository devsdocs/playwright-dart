import 'browser.dart';

import '../infrastructure/channel_owner.dart';

import '../infrastructure/local_utils.dart';

import 'browser_context.dart';

import '../infrastructure/driver_downloader.dart';

import '../generated/channels.dart';

import '../utils/worker.dart';

import 'playwright.dart';

import '../infrastructure/connection.dart';

import '../infrastructure/transport.dart';

import '../infrastructure/json_pipe.dart';

import '../utils/logger.dart';

/// BrowserType provides methods to launch a specific browser instance or connect to an existing one.

///

/// Playwright dart exposes three browser types: [Playwright.chromium], [Playwright.firefox], and [Playwright.webkit].

/// Interface for BrowserType

abstract interface class BrowserType {
  /// Returns browser name. For example: `'chromium'`, `'webkit'` or `'firefox'`.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// browserType.name;
  /// ```
  ///
  /// **Returns**
  /// - String
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
  String get name;

  /// A path where Playwright expects to find a bundled browser executable.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// browserType.executablePath;
  /// ```
  ///
  /// **Returns**
  /// - String
  String get executablePath;

  /// Returns the browser instance.
  ///
  /// **Usage**
  ///
  /// You can use [ignoreDefaultArgs] to filter out `--mute-audio` from default arguments:
  ///
  /// ```dart
  /// final browser = await chromium.launch(  // Or 'firefox' or 'webkit'.
  ///   ignoreDefaultArgs: ['--mute-audio']
  /// );
  /// ```
  ///
  /// > **Chromium-only** Playwright can also be used to control the Google Chrome or Microsoft Edge browsers, but it works best with the version of Chromium it is bundled with. There is no guarantee it will work with any other version. Use [executablePath] option with extreme caution.
  /// >
  /// > If Google Chrome (rather than Chromium) is preferred, a [Chrome Canary] or [Dev Channel] build is suggested.
  /// >
  /// > Stock browsers like Google Chrome and Microsoft Edge are suitable for tests that require proprietary media codecs for video playback. See [this article] for other differences between Chromium and Chrome. [This article] describes some differences for Linux users.
  ///
  /// **Arguments**
  /// - `options` LaunchOptions *(optional)*
  ///   - `args` List&lt;String&gt; *(optional)*
  ///
  ///     **WARNING**
  /// Use custom browser args at your own risk, as some of them may break Playwright functionality.
  ///     Additional arguments to pass to the browser instance. The list of Chromium flags can be found [here].
  ///   - `artifactsDir` String *(optional)*
  ///
  ///     If specified, artifacts (traces, videos, downloads, HAR files, etc.) are saved into this directory. The directory is not cleaned up when the browser closes. If not specified, a temporary directory is used and cleaned up when the browser closes.
  ///   - `channel` String *(optional)*
  ///
  ///     Browser distribution channel.
  ///
  ///     Use "chromium" to [opt in to new headless mode].
  ///
  ///     Use "chrome", "chrome-beta", "chrome-dev", "chrome-canary", "msedge", "msedge-beta", "msedge-dev", or "msedge-canary" to use branded [Google Chrome and Microsoft Edge].
  ///   - `chromiumSandbox` bool *(optional)*
  ///
  ///     Enable Chromium sandboxing. Defaults to `false`.
  ///   - `downloadsPath` String *(optional)*
  ///
  ///     If specified, accepted downloads are downloaded into this directory. Otherwise, temporary directory is created and is deleted when browser is closed. In either case, the downloads are deleted when the browser context they were created in is closed.
  ///   - `env` Map&lt;String, String | [undefined]&gt; *(optional)*
  ///   - `executablePath` String *(optional)*
  ///
  ///     Path to a browser executable to run instead of the bundled one. If [executablePath] is a relative path, then it is resolved relative to the current working directory. Note that Playwright only works with the bundled Chromium, Firefox or WebKit, use at your own risk.
  ///   - `firefoxUserPrefs` Map&lt;String, String | num | bool&gt; *(optional)*
  ///
  ///     Firefox user preferences. Learn more about the Firefox user preferences at [`about:config`].
  ///
  ///     You can also provide a path to a custom [`policies.json` file] via `PLAYWRIGHT_FIREFOX_POLICIES_JSON` environment variable.
  ///   - `handleSIGHUP` bool *(optional)*
  ///
  ///     Close the browser process on SIGHUP. Defaults to `true`.
  ///   - `handleSIGINT` bool *(optional)*
  ///
  ///     Close the browser process on Ctrl-C. Defaults to `true`.
  ///   - `handleSIGTERM` bool *(optional)*
  ///
  ///     Close the browser process on SIGTERM. Defaults to `true`.
  ///   - `headless` bool *(optional)*
  ///
  ///     Whether to run browser in headless mode. More details for [Chromium] and [Firefox]. Defaults to `true`.
  ///   - `ignoreDefaultArgs` bool | List&lt;String&gt; *(optional)*
  ///
  ///     If `true`, Playwright does not pass its own configurations args and only uses the ones from [args]. If an array is given, then filters out the given default arguments. Dangerous option; use with care. Defaults to `false`.
  ///   - `logger` [Logger] *(optional)*
  ///
  ///     **WARNING**
  /// [Deprecated]
  ///     The logs received by the logger are incomplete. Please use tracing instead.
  ///     Logger sink for Playwright logging.
  ///   - `proxy` Map *(optional)*
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
  ///   - `slowMo` double *(optional)*
  ///
  ///     Slows down Playwright operations by the specified amount of milliseconds. Useful so that you can see what is going on.
  ///   - `timeout` num *(optional)*
  ///
  ///     Maximum time in milliseconds to wait for the browser instance to start. Defaults to `30000` (30 seconds). Pass `0` to disable timeout.
  ///   - `tracesDir` String *(optional)*
  ///
  ///     If specified, traces are saved into this directory.
  ///
  /// **Returns**
  /// - Future&lt;[Browser]&gt;
  Future<Browser> launch({LaunchOptions? options, double? slowMo});

  /// Returns the persistent browser context instance.
  ///
  /// Launches browser that uses persistent storage located at [userDataDir] and returns the only context. Closing this context will automatically close the browser.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await browserType.launchPersistentContext(userDataDir);
  /// await browserType.launchPersistentContext(userDataDir, options);
  /// ```
  ///
  /// **Arguments**
  /// - `userDataDir` String
  ///
  ///   Path to a User Data Directory, which stores browser session data like cookies and local storage. Pass an empty string to create a temporary directory.
  ///
  ///   More details for [Chromium] and [Firefox]. Chromium's user data directory is the **parent** directory of the "Profile Path" seen at `chrome://version`.
  ///
  ///   Note that browsers do not allow launching multiple instances with the same User Data Directory.
  ///
  ///   **WARNING**
  /// Chromium/Chrome: Due to recent Chrome policy changes, automating the default Chrome user profile is not supported. Pointing `userDataDir` to Chrome's main "User Data" directory (the profile used for your regular browsing) may result in pages not loading or the browser exiting. Create and use a separate directory (for example, an empty folder) as your automation profile instead. See https://developer.chrome.com/blog/remote-debugging-port for details.
  ///   - `options` Map *(optional)*
  ///   - `acceptDownloads` bool *(optional)*
  ///
  ///     Whether to automatically download all the attachments. Defaults to `true` where all the downloads are accepted.
  ///   - `args` List&lt;String&gt; *(optional)*
  ///
  ///     **WARNING**
  /// Use custom browser args at your own risk, as some of them may break Playwright functionality.
  ///     Additional arguments to pass to the browser instance. The list of Chromium flags can be found [here].
  ///   - `artifactsDir` String *(optional)*
  ///
  ///     If specified, artifacts (traces, videos, downloads, HAR files, etc.) are saved into this directory. The directory is not cleaned up when the browser closes. If not specified, a temporary directory is used and cleaned up when the browser closes.
  ///   - `baseURL` String *(optional)*
  ///
  ///     When using [page.goto()], [page.route()], [page.waitForURL()], [page.waitForRequest()], or [page.waitForResponse()] it takes the base URL in consideration by using the [`URL()`] constructor for building the corresponding URL. Unset by default. Examples:
  ///     * baseURL: `http://localhost:3000` and navigating to `/bar.html` results in `http://localhost:3000/bar.html`
  ///     * baseURL: `http://localhost:3000/foo/` and navigating to `./bar.html` results in `http://localhost:3000/foo/bar.html`
  ///     * baseURL: `http://localhost:3000/foo` (without trailing slash) and navigating to `./bar.html` results in `http://localhost:3000/bar.html`
  ///   - `bypassCSP` bool *(optional)*
  ///
  ///     Toggles bypassing page's Content-Security-Policy. Defaults to `false`.
  ///   - `channel` String *(optional)*
  ///
  ///     Browser distribution channel.
  ///
  ///     Use "chromium" to [opt in to new headless mode].
  ///
  ///     Use "chrome", "chrome-beta", "chrome-dev", "chrome-canary", "msedge", "msedge-beta", "msedge-dev", or "msedge-canary" to use branded [Google Chrome and Microsoft Edge].
  ///   - `chromiumSandbox` bool *(optional)*
  ///
  ///     Enable Chromium sandboxing. Defaults to `false`.
  ///   - `clientCertificates` List&lt;Map&gt; *(optional)*
  ///     - `origin` String
  ///
  ///       Exact origin that the certificate is valid for. Origin includes `https` protocol, a hostname and optionally a port.
  ///     - `certPath` String *(optional)*
  ///
  ///       Path to the file with the certificate in PEM format.
  ///     - `cert` List&lt;int&gt; *(optional)*
  ///
  ///       Direct value of the certificate in PEM format.
  ///     - `keyPath` String *(optional)*
  ///
  ///       Path to the file with the private key in PEM format.
  ///     - `key` List&lt;int&gt; *(optional)*
  ///
  ///       Direct value of the private key in PEM format.
  ///     - `pfxPath` String *(optional)*
  ///
  ///       Path to the PFX or PKCS12 encoded private key and certificate chain.
  ///     - `pfx` List&lt;int&gt; *(optional)*
  ///
  ///       Direct value of the PFX or PKCS12 encoded private key and certificate chain.
  ///     - `passphrase` String *(optional)*
  ///
  ///       Passphrase for the private key (PEM or PFX).
  ///
  ///     TLS Client Authentication allows the server to request a client certificate and verify it.
  ///
  ///     **Details**
  ///
  ///     An array of client certificates to be used. Each certificate object must have either both `certPath` and `keyPath`, a single `pfxPath`, or their corresponding direct value equivalents (`cert` and `key`, or `pfx`). Optionally, `passphrase` property should be provided if the certificate is encrypted. The `origin` property should be provided with an exact match to the request origin that the certificate is valid for.
  ///
  ///     Client certificate authentication is only active when at least one client certificate is provided. If you want to reject all client certificates sent by the server, you need to provide a client certificate with an `origin` that does not match any of the domains you plan to visit.
  ///
  ///     **NOTE**
  /// When using WebKit on macOS, accessing `localhost` will not pick up client certificates. You can make it work by replacing `localhost` with `local.playwright`.
  ///     - `colorScheme` null | "light" | "dark" | "no-preference" *(optional)*
  ///
  ///     Emulates [prefers-colors-scheme] media feature, supported values are `'light'` and `'dark'`. See [page.emulateMedia()] for more details. Passing `null` resets emulation to system defaults. Defaults to `'light'`.
  ///   - `contrast` null | "no-preference" | "more" *(optional)*
  ///
  ///     Emulates `'prefers-contrast'` media feature, supported values are `'no-preference'`, `'more'`. See [page.emulateMedia()] for more details. Passing `null` resets emulation to system defaults. Defaults to `'no-preference'`.
  ///   - `deviceScaleFactor` num *(optional)*
  ///
  ///     Specify device scale factor (can be thought of as dpr). Defaults to `1`. Learn more about [emulating devices with device scale factor].
  ///   - `downloadsPath` String *(optional)*
  ///
  ///     If specified, accepted downloads are downloaded into this directory. Otherwise, temporary directory is created and is deleted when browser is closed. In either case, the downloads are deleted when the browser context they were created in is closed.
  ///   - `env` Map&lt;String, String | [undefined]&gt; *(optional)*
  ///   - `executablePath` String *(optional)*
  ///
  ///     Path to a browser executable to run instead of the bundled one. If [executablePath] is a relative path, then it is resolved relative to the current working directory. Note that Playwright only works with the bundled Chromium, Firefox or WebKit, use at your own risk.
  ///   - `extraHTTPHeaders` Map&lt;String, String&gt; *(optional)*
  ///
  ///     An object containing additional HTTP headers to be sent with every request. Defaults to none.
  ///   - `firefoxUserPrefs` Map&lt;String, String | num | bool&gt; *(optional)*
  ///
  ///     Firefox user preferences. Learn more about the Firefox user preferences at [`about:config`].
  ///
  ///     You can also provide a path to a custom [`policies.json` file] via `PLAYWRIGHT_FIREFOX_POLICIES_JSON` environment variable.
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
  ///   - `handleSIGHUP` bool *(optional)*
  ///
  ///     Close the browser process on SIGHUP. Defaults to `true`.
  ///   - `handleSIGINT` bool *(optional)*
  ///
  ///     Close the browser process on Ctrl-C. Defaults to `true`.
  ///   - `handleSIGTERM` bool *(optional)*
  ///
  ///     Close the browser process on SIGTERM. Defaults to `true`.
  ///   - `hasTouch` bool *(optional)*
  ///
  ///     Specifies if viewport supports touch events. Defaults to false. Learn more about [mobile emulation].
  ///   - `headless` bool *(optional)*
  ///
  ///     Whether to run browser in headless mode. More details for [Chromium] and [Firefox]. Defaults to `true`.
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
  ///   - `ignoreDefaultArgs` bool | List&lt;String&gt; *(optional)*
  ///
  ///     If `true`, Playwright does not pass its own configurations args and only uses the ones from [args]. If an array is given, then filters out the given default arguments. Dangerous option; use with care. Defaults to `false`.
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
  ///   - `proxy` Map *(optional)*
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
  ///   - `slowMo` double *(optional)*
  ///
  ///     Slows down Playwright operations by the specified amount of milliseconds. Useful so that you can see what is going on.
  ///   - `strictSelectors` bool *(optional)*
  ///
  ///     If set to true, enables strict selectors mode for this context. In the strict selectors mode all operations on selectors that imply single target DOM element will throw when more than one element matches the selector. This option does not affect any Locator APIs (Locators are always strict). Defaults to `false`. See [Locator] to learn more about the strict mode.
  ///   - `timeout` num *(optional)*
  ///
  ///     Maximum time in milliseconds to wait for the browser instance to start. Defaults to `30000` (30 seconds). Pass `0` to disable timeout.
  ///   - `timezoneId` String *(optional)*
  ///
  ///     Changes the timezone of the context. See [ICU's metaZones.txt] for a list of supported timezone IDs. Defaults to the system timezone.
  ///   - `tracesDir` String *(optional)*
  ///
  ///     If specified, traces are saved into this directory.
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
  Future<BrowserContext> launchPersistentContext(
    String userDataDir, {

    LaunchOptions? launchOptions,

    ContextOptions? contextOptions,

    double? slowMo,
  });

  /// Connects to an existing worker.
  Future<Worker> connectToWorker(String endpoint, {double? timeout});

  /// This method attaches Playwright to an existing browser instance using the Chrome DevTools Protocol.
  ///
  /// The default browser context is accessible via [browser.contexts()].
  ///
  /// **NOTE**
  /// Connecting over the Chrome DevTools Protocol is only supported for Chromium-based browsers.
  /// **NOTE**
  /// This connection is significantly lower fidelity than the Playwright protocol connection via [browserType.connect()]. If you are experiencing issues or attempting to use advanced functionality, you probably want to use [browserType.connect()].
  /// **WARNING**
  /// Playwright maintains a curated list of arguments for launching the browser. If you launch the browser without Playwright and do not pass the exact same arguments, some of Playwright functionality may be broken upon connecting to the browser.
  /// **Usage**
  ///
  /// ```dart
  /// final browser = await playwright.chromium.connectOverCDP('http://localhost:9222');
  /// final defaultContext = browser.contexts()[0];
  /// final page = defaultContext.pages()[0];
  /// ```
  ///
  /// **Arguments**
  /// - `endpointURL` String
  ///
  ///   A CDP websocket endpoint or http url to connect to. For example `http://localhost:9222/` or `ws://127.0.0.1:9222/devtools/browser/387adf4c-243f-4051-a181-46798f4a46f4`.
  /// - `options` Map *(optional)*
  ///   - `artifactsDir` String *(optional)*
  ///
  ///     If specified, browser artifacts (such as traces and downloads) are saved into this directory.
  ///   - `endpointURL` String *(optional)*
  ///
  ///     **WARNING**
  /// [Deprecated]
  ///     Use the first argument instead.
  ///     - `headers` List&lt;NameValue&gt; *(optional)*
  ///
  ///     Additional HTTP headers to be sent with connect request. Optional.
  ///   - `isLocal` bool *(optional)*
  ///
  ///     Tells Playwright that it runs on the same host as the CDP server. It will enable certain optimizations that rely upon the file system being the same between Playwright and the Browser.
  ///   - `noDefaults` bool *(optional)*
  ///
  ///     When true, Playwright will not apply its default overrides to the existing default browser context. Specifically, [acceptDownloads] is left at the browser's setting, focus emulation is not enabled, and media emulation options (such as [colorScheme], [reducedMotion], [forcedColors], and [contrast]) are not applied. Useful when attaching to a user's daily-driver browser where these overrides would interfere with existing browser state. New contexts created via [browser.newContext()] are not affected. Defaults to `false`.
  ///   - `slowMo` double *(optional)*
  ///
  ///     Slows down Playwright operations by the specified amount of milliseconds. Useful so that you can see what is going on. Defaults to 0.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds to wait for the connection to be established. Defaults to `30000` (30 seconds). Pass `0` to disable timeout.
  ///
  /// **Returns**
  /// - Future&lt;[Browser]&gt;
  Future<Browser> connectOverCDP({
    required String endpointURL,

    List<NameValue>? headers,

    bool? isLocal,

    bool? noDefaults,

    double? slowMo,

    double timeout,
  });

  /// This method attaches Playwright to an existing browser instance created via `BrowserType.launchServer` in Node.js.
  ///
  /// **NOTE**
  /// The major and minor version of the Playwright instance that connects needs to match the version of Playwright that launches the browser (1.2.3 → is compatible with 1.2.x).
  /// **Usage**
  ///
  /// ```dart
  /// await browserType.connect(endpoint);
  /// await browserType.connect(endpoint, options);
  /// ```
  ///
  /// **Arguments**
  /// - `endpoint` String
  ///
  ///   A Playwright browser websocket endpoint to connect to. You obtain this endpoint via `BrowserServer.wsEndpoint`.
  /// - `options` Map *(optional)*
  ///   - `exposeNetwork` String *(optional)*
  ///
  ///     This option exposes network available on the connecting client to the browser being connected to. Consists of a list of rules separated by comma.
  ///
  ///     Available rules:
  ///     1. Hostname pattern, for example: `example.com`, `*.org:99`, `x.*.y.com`, `*foo.org`.
  ///     1. IP literal, for example: `127.0.0.1`, `0.0.0.0:99`, `[::1]`, `[0:0::1]:99`.
  ///     1. `<loopback>` that matches local loopback interfaces: `localhost`, `*.localhost`, `127.0.0.1`, `[::1]`.
  ///
  ///     Some common examples:
  ///     1. `"*"` to expose all network.
  ///     1. `"<loopback>"` to expose localhost network.
  ///     1. `"*.test.internal-domain,*.staging.internal-domain,<loopback>"` to expose test/staging deployments and localhost.
  ///   - `headers` Map&lt;String, String&gt; *(optional)*
  ///
  ///     Additional HTTP headers to be sent with web socket connect request. Optional.
  ///   - `slowMo` double *(optional)*
  ///
  ///     Slows down Playwright operations by the specified amount of milliseconds. Useful so that you can see what is going on. Defaults to 0.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds to wait for the connection to be established. Defaults to `0` (no timeout).
  ///
  /// **Returns**
  /// - Future&lt;[Browser]&gt;
  Future<Browser> connect(
    String wsEndpoint, {

    Map<String, String>? headers,

    String? exposeNetwork,

    double? slowMo,

    double timeout,
  });
}

class BrowserTypeImpl extends BrowserTypeBase implements BrowserType {
  BrowserTypeImpl(
    super.connection,

    super.channelType,

    super.guid,

    super.initializer, [

    super.parent,
  ]);

  @override
  String get name => typedInitializer.name;

  @override
  String get executablePath => typedInitializer.executablePath;

  @override
  Future<Browser> launch({LaunchOptions? options, double? slowMo}) async {
    await ensureBrowsersInstalled();

    Logger.info('Launching $name browser...');
    final result = await super.channel.launch(
      launchOptions: options ?? LaunchOptions(timeout: 30000.0),

      slowMo: slowMo,
    );

    final browser = result.browser as Browser;
    Logger.info('$name browser launched.');
    return browser;
  }

  @override
  Future<BrowserContext> launchPersistentContext(
    String userDataDir, {

    LaunchOptions? launchOptions,

    ContextOptions? contextOptions,

    double? slowMo,
  }) async {
    await ensureBrowsersInstalled();

    Logger.info('Launching $name persistent context at "$userDataDir"...');
    final result = await super.channel.launchPersistentContext(
      userDataDir: userDataDir,

      launchOptions: launchOptions ?? LaunchOptions(timeout: 30000.0),

      contextOptions: contextOptions ?? ContextOptions(),

      slowMo: slowMo,
    );

    Logger.info('$name persistent context launched.');
    return result.context as BrowserContext;
  }

  // We are missing the Worker wrapper for now, but we can implement the method returning ChannelOwner

  // and type it dynamically for now, or just leave it returning the map.

  // wait, Phase 8 will create the Worker wrapper. Let's assume Worker is created and import it.

  @override
  Future<Worker> connectToWorker(String endpoint, {double? timeout}) async {
    final result = await super.channel.connectToWorker(
      endpoint: endpoint,

      timeout: timeout ?? 30000.0,
    );

    return result.worker as Worker;
  }

  @override
  Future<Browser> connectOverCDP({
    required String endpointURL,

    List<NameValue>? headers,

    bool? isLocal,

    bool? noDefaults,

    double? slowMo,

    double timeout = 30000.0,
  }) async {
    Logger.info('Connecting to browser over CDP: $endpointURL');
    final result = await super.channel.connectOverCDP(
      endpointURL: endpointURL,

      headers: headers,

      isLocal: isLocal,

      noDefaults: noDefaults,

      slowMo: slowMo,

      timeout: timeout,
    );

    Logger.info('Connected to browser via CDP.');
    return result.browser as Browser;
  }

  @override
  Future<Browser> connect(
    String wsEndpoint, {

    Map<String, String>? headers,

    String? exposeNetwork,

    double? slowMo,

    double timeout = 30000.0,
  }) async {
    Logger.info('Connecting to browser at $wsEndpoint');
    final playwright = connection.objects.values.whereType<Playwright>().first;

    // The driver connects over websocket and gives us a JsonPipe

    final result =
        await ((playwright as PlaywrightImpl).utils as LocalUtilsImpl).channel
            .connect(
              endpoint: wsEndpoint,

              headers: headers,

              exposeNetwork: exposeNetwork,

              slowMo: slowMo,

              timeout: timeout,
            );

    final pipe = result.pipe as JsonPipe;

    final transport = JsonPipeTransport(pipe);

    final remoteConnection = Connection(transport);

    // Initialize the remote playwright instance

    final initResult = await remoteConnection.sendMessageToServer(
      '',

      'initialize',

      {'sdkLanguage': 'javascript'},
    );

    final remotePlaywright = ChannelOwner.from<PlaywrightImpl>(
      remoteConnection,

      initResult['playwright'] as Map<String, dynamic>,
    );

    final preLaunchedBrowser =
        remotePlaywright.typedInitializer.preLaunchedBrowser;

    if (preLaunchedBrowser == null) {
      throw Exception(
        'Malformed endpoint. Did you use BrowserTypeImpl.launchServer method? '
        'For remote browser connections via WebSocket, use connectOverCDP() instead.',
      );
    }

    final browser = ChannelOwner.from<BrowserImpl>(
      remoteConnection,

      preLaunchedBrowser as Map<String, dynamic>,
    );

    Logger.info('Connected to browser.');
    // When browser is disconnected, close the remote connection

    // For now we just return the browser

    return browser;
  }
}
