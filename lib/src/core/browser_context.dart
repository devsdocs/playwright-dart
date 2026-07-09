import '../debugging/binding_call.dart';

import '../interaction/dialog.dart';

import '../network/websocket_route.dart';

import '../utils/worker.dart';

import '../utils/cdp_session.dart';

import '../utils/tracing.dart';

import '../utils/clock.dart';

import '../network/api_request_context.dart';

import '../network/route_handler.dart';

import '../infrastructure/channel_owner.dart';

import 'frame.dart';

import 'page.dart';

import 'browser.dart';

import '../generated/channels.dart';

import '../network/route.dart';

import '../network/route_from_har.dart';

import '../network/request.dart';

import 'browser_permission.dart';

import '../utils/logger.dart';

/// BrowserContexts provide a way to operate multiple independent browser sessions.

///

/// If a page opens another page, e.g. with a `window.open` call, the popup will belong to the parent page's browser context.

/// Interface for BrowserContext

abstract interface class BrowserContext {
  /// Gets the browser instance that owns the context. Returns `null` if the context is created outside of normal browser, e.g. Android or Electron.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// browserContext.browser;
  /// ```
  ///
  /// **Returns**
  /// - [Browser]?
  Browser? get browser;

  /// **Usage**
  ///
  /// ```dart
  /// browserContext.tracing
  /// ```
  ///
  /// **Type**
  /// - [Tracing]
  Tracing get tracing;

  /// API testing helper associated with this context. Requests made with this API will use context cookies.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// browserContext.request
  /// ```
  ///
  /// **Type**
  /// - [APIRequestContext]
  APIRequestContext get request;

  /// Playwright has ability to mock clock and passage of time.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// browserContext.clock
  /// ```
  ///
  /// **Type**
  /// - [Clock]
  Clock get clock;

  /// Stream that emits recorder events.
  Stream<Map<String, dynamic>> get onRecorderEvent;

  /// Stream that emits when a response is received.
  Stream<Map<String, dynamic>> get onResponse;

  /// Stream that emits when a request finishes.
  Stream<Map<String, dynamic>> get onRequestFinished;

  /// Stream that emits when a request fails.
  Stream<Map<String, dynamic>> get onRequestFailed;

  /// Stream that emits when a request is made.
  Stream<Map<String, dynamic>> get onRequest;

  /// Stream that emits when a service worker is created.
  Stream<Worker> get onServiceWorker;

  /// Stream that emits when a WebSocket route is created.
  Stream<WebSocketRoute> get onWebSocketRoute;

  /// Stream that emits when a route is created.
  Stream<Route> get onRoute;

  /// Stream that emits when a page error occurs.
  Stream<Map<String, dynamic>> get onPageError;

  /// Stream that emits when a new page is created.
  Stream<Page> get onPage;

  /// Stream that emits when a dialog is shown.
  Stream<Dialog> get onDialog;

  /// Stream that emits when the context is closed.
  Stream<BrowserContext> get onClose;

  /// Stream that emits when a console message is logged.
  Stream<Map<String, dynamic>> get onConsole;

  /// Stream that emits when a binding call is made.
  Stream<BindingCall> get onBindingCall;

  /// Returns all open pages in the context.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// browserContext.pages;
  /// ```
  ///
  /// **Returns**
  /// - List&lt;[Page]&gt;
  List<Page> get pages;

  /// Creates a new page in the browser context.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await browserContext.newPage();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;[Page]&gt;
  Future<Page> newPage();

  /// Adds cookies into this browser context. All pages within this context will have these cookies installed. Cookies can be obtained via [browserContext.cookies()].
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await browserContext.addCookies([cookieObject1, cookieObject2]);
  /// ```
  ///
  /// **Arguments**
  /// - `cookies` List&lt;SetNetworkCookie&gt;
  ///   - `name` String
  ///
  ///
  ///   - `value` String
  ///
  ///
  ///   - `url` String *(optional)*
  ///
  ///     Either `url` or both `domain` and `path` are required. Optional.
  ///   - `domain` String *(optional)*
  ///
  ///     For the cookie to apply to all subdomains as well, prefix domain with a dot, like this: ".example.com". Either `url` or both `domain` and `path` are required. Optional.
  ///   - `path` String *(optional)*
  ///
  ///     Either `url` or both `domain` and `path` are required. Optional.
  ///   - `expires` num *(optional)*
  ///
  ///     Unix time in seconds. Optional.
  ///   - `httpOnly` bool *(optional)*
  ///
  ///     Optional.
  ///   - `secure` bool *(optional)*
  ///
  ///     Optional.
  ///   - `sameSite` "Strict" | "Lax" | "None" *(optional)*
  ///
  ///     Optional.
  ///   - `partitionKey` String *(optional)*
  ///
  ///     For partitioned third-party cookies (aka [CHIPS]), the partition key. Optional.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> addCookies(List<SetNetworkCookie> cookies);

  /// Removes cookies from context. Accepts optional filter.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await context.clearCookies();
  /// await context.clearCookies( name: 'session-id' );
  /// await context.clearCookies( domain: 'my-origin.com' );
  /// await context.clearCookies( domain: /.*my-origin\.com/ );
  /// await context.clearCookies( path: '/api/v1' );
  /// await context.clearCookies( name: 'session-id', domain: 'my-origin.com' );
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `domain` String *(optional)*
  ///
  ///     Only removes cookies with the given domain.
  ///   - `name` String *(optional)*
  ///
  ///     Only removes cookies with the given name.
  ///   - `path` String *(optional)*
  ///
  ///     Only removes cookies with the given path.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> clearCookies({
    String? name,

    String? domain,

    String? path,

    String? nameRegexSource,

    String? nameRegexFlags,

    String? domainRegexSource,

    String? domainRegexFlags,

    String? pathRegexSource,

    String? pathRegexFlags,
  });

  /// If no URLs are specified, this method returns all cookies. If URLs are specified, only cookies that affect those URLs are returned.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await browserContext.cookies();
  /// await browserContext.cookies(urls);
  /// ```
  ///
  /// **Arguments**
  /// - `urls` List&lt;String&gt; *(optional)*
  ///
  ///   Optional list of URLs.
  ///
  /// **Returns**
  /// - Future&lt;List&lt;Map&gt;&gt;
  ///   - `name` String
  ///
  ///
  ///   - `value` String
  ///
  ///
  ///   - `domain` String
  ///
  ///
  ///   - `path` String
  ///
  ///
  ///   - `expires` num
  ///
  ///     Unix time in seconds.
  ///   - `httpOnly` bool
  ///
  ///
  ///   - `secure` bool
  ///
  ///
  ///   - `sameSite` "Strict" | "Lax" | "None"
  ///
  ///
  ///   - `partitionKey` String *(optional)*
  Future<List<NetworkCookie>> cookies({List<String>? urls});

  /// Grants specified permissions to the browser context. Only grants corresponding permissions to the given origin if specified.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await browserContext.grantPermissions(permissions);
  /// await browserContext.grantPermissions(permissions, options);
  /// ```
  ///
  /// **Arguments**
  /// - `permissions` List&lt;String&gt;
  ///
  ///   A list of permissions to grant.
  ///
  ///   **DANGER**
  /// Supported permissions differ between browsers, and even between different versions of the same browser. Any permission may stop working after an update.
  ///   Here are some permissions that may be supported by some browsers:
  ///   * `'accelerometer'`
  ///   * `'ambient-light-sensor'`
  ///   * `'background-sync'`
  ///   * `'camera'`
  ///   * `'clipboard-read'`
  ///   * `'clipboard-write'`
  ///   * `'geolocation'`
  ///   * `'gyroscope'`
  ///   * `'local-fonts'`
  ///   * `'local-network-access'`
  ///   * `'magnetometer'`
  ///   * `'microphone'`
  ///   * `'midi-sysex'` (system-exclusive midi)
  ///   * `'midi'`
  ///   * `'notifications'`
  ///   * `'payment-handler'`
  ///   * `'storage-access'`
  ///   * `'screen-wake-lock'`
  /// - `options` Map *(optional)*
  ///   - `origin` String *(optional)*
  ///
  ///     The [origin] to grant permissions to, e.g. "https://example.com".
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> grantPermissions(
    List<BrowserPermission> permissions, {
    String? origin,
  });

  /// The extra HTTP headers will be sent with every request initiated by any page in the context. These headers are merged with page-specific extra HTTP headers set with [page.setExtraHTTPHeaders()]. If page overrides a particular header, page-specific header value will be used instead of the browser context header value.
  ///
  /// **NOTE**
  /// [browserContext.setExtraHTTPHeaders()] does not guarantee the order of headers in the outgoing requests.
  /// **Usage**
  ///
  /// ```dart
  /// await browserContext.setExtraHTTPHeaders(headers);
  /// ```
  ///
  /// **Arguments**
  /// - `headers` List&lt;NameValue&gt;
  ///
  ///   An object containing additional HTTP headers to be sent with every request. All header values must be strings.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> setExtraHTTPHeaders(List<NameValue> headers);

  /// Clears all permission overrides for the browser context.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// final context = await browser.newContext();
  /// await context.grantPermissions(['clipboard-read']);
  /// // do stuff ..
  /// context.clearPermissions();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> clearPermissions();

  /// Sets the context's geolocation. Passing `null` or `undefined` emulates position unavailable.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await browserContext.setGeolocation( latitude: 59.95, longitude: 30.31667 );
  /// ```
  ///
  /// **NOTE**
  /// Consider using [browserContext.grantPermissions()] to grant permissions for the browser context pages to read its geolocation.
  /// **Arguments**
  /// - `geolocation` BrowserContextSetGeolocationGeolocation
  ///   - `latitude` num
  ///
  ///     Latitude between -90 and 90.
  ///   - `longitude` num
  ///
  ///     Longitude between -180 and 180.
  ///   - `accuracy` num *(optional)*
  ///
  ///     Non-negative accuracy value. Defaults to `0`.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> setGeolocation(
    BrowserContextSetGeolocationGeolocation? geolocation,
  );

  /// **WARNING**
  /// [Deprecated]
  ///
  /// Browsers may cache credentials after successful authentication. Create a new browser context instead.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await browserContext.setHTTPCredentials(httpCredentials);
  /// ```
  ///
  /// **Arguments**
  /// - `httpCredentials` BrowserContextSetHTTPCredentialsHttpCredentials
  ///   - `username` String
  ///
  ///
  ///   - `password` String
  ///
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
  Future<void> setHTTPCredentials(
    BrowserContextSetHTTPCredentialsHttpCredentials? httpCredentials,
  );

  /// **Usage**
  ///
  /// ```dart
  /// await browserContext.setOffline(offline);
  /// ```
  ///
  /// **Arguments**
  /// - `offline` bool
  ///
  ///   Whether to emulate network being offline for the browser context.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> setOffline(bool offline);

  /// Returns storage state for this browser context, contains current cookies, local storage snapshot and IndexedDB snapshot.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await browserContext.storageState();
  /// await browserContext.storageState(options);
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `indexedDB` bool *(optional)*
  ///
  ///     Set to `true` to include [IndexedDB] in the storage state snapshot. If your application uses IndexedDB to store authentication tokens, like Firebase Authentication, enable this.
  ///   - `path` String *(optional)*
  ///
  ///     The file path to save the storage state to. If [path] is a relative path, then it is resolved relative to current working directory. If no path is provided, storage state is still returned, but won't be saved to the disk.
  ///
  /// **Returns**
  /// - Future&lt;Map&gt;
  ///   - `cookies` List&lt;Map&gt;
  ///     - `name` String
  ///
  ///
  ///     - `value` String
  ///
  ///
  ///     - `domain` String
  ///
  ///
  ///     - `path` String
  ///
  ///
  ///     - `expires` num
  ///
  ///       Unix time in seconds.
  ///     - `httpOnly` bool
  ///
  ///
  ///     - `secure` bool
  ///
  ///
  ///     - `sameSite` "Strict" | "Lax" | "None"
  ///
  ///
  ///
  ///   - `origins` List&lt;Map&gt;
  ///     - `origin` String
  ///
  ///
  ///     - `localStorage` List&lt;Map&gt;
  ///       - `name` String
  ///
  ///
  ///       - `value` String
  Future<BrowserContextStorageStateResult> storageState({bool? indexedDB});

  /// Clears the existing cookies, local storage and IndexedDB entries for all origins and sets the new storage state.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// // Load storage state from a file and apply it to the context.
  /// await context.setStorageState('state.json');
  /// ```
  ///
  /// **Arguments**
  /// - `storageState` BrowserContextSetStorageStateStorageState
  ///   - `cookies` List&lt;Map&gt;
  ///     - `name` String
  ///
  ///
  ///     - `value` String
  ///
  ///
  ///     - `domain` String
  ///
  ///       Domain and path are required. For the cookie to apply to all subdomains as well, prefix domain with a dot, like this: ".example.com"
  ///     - `path` String
  ///
  ///       Domain and path are required
  ///     - `expires` num
  ///
  ///       Unix time in seconds.
  ///     - `httpOnly` bool
  ///
  ///
  ///     - `secure` bool
  ///
  ///
  ///     - `sameSite` "Strict" | "Lax" | "None"
  ///
  ///       sameSite flag
  ///
  ///     Cookies to set for context
  ///   - `origins` List&lt;Map&gt;
  ///     - `origin` String
  ///
  ///
  ///     - `localStorage` List&lt;Map&gt;
  ///       - `name` String
  ///
  ///
  ///       - `value` String
  ///
  ///
  ///       localStorage to set for context
  ///
  ///
  ///   Learn more about [storage state and auth].
  ///
  ///   Populates context with given storage state. This option can be used to initialize context with logged-in information obtained via [browserContext.storageState()].
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> setStorageState(
    BrowserContextSetStorageStateStorageState storageState,
  );

  /// Adds a script which would be evaluated in one of the following scenarios:
  /// * Whenever a page is created in the browser context or is navigated.
  /// * Whenever a child frame is attached or navigated in any page in the browser context. In this case, the script is evaluated in the context of the newly attached frame.
  ///
  /// The script is evaluated after the document was created but before any of its scripts were run. This is useful to amend the JavaScript environment, e.g. to seed `Math.random`.
  ///
  /// **Usage**
  ///
  /// An example of overriding `Math.random` before the page loads:
  ///
  /// ```dart
  /// // preload.js
  /// Math.random = () => 42;
  /// ```
  ///
  /// ```dart
  /// // In your playwright script, assuming the preload.js file is in same directory.
  /// await browserContext.addInitScript(
  ///   path: 'preload.js'
  /// );
  /// ```
  ///
  /// **NOTE**
  /// The order of evaluation of multiple scripts installed via [browserContext.addInitScript()] and [page.addInitScript()] is not defined.
  /// **Arguments**
  /// - `script` Function | String | Map
  ///   - `path` String *(optional)*
  ///
  ///     Path to the JavaScript file. If `path` is a relative path, then it is resolved relative to the current working directory. Optional.
  ///   - `content` String *(optional)*
  ///
  ///     Raw script content. Optional.
  ///
  ///   Script to be evaluated in all pages in the browser context.
  /// - `arg` [Serializable] *(optional)*
  ///
  ///   Optional argument to pass to [script] (only supported when passing a function).
  ///
  /// **Returns**
  /// - Future&lt;[Disposable]&gt;
  Future<void> addInitScript(String source);

  /// Indicates that the browser context is in the process of closing or has already been closed.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// browserContext.isClosed;
  /// ```
  ///
  /// **Returns**
  /// - bool
  bool get isClosed;

  /// **WARNING**
  /// [Deprecated]
  ///
  /// Background pages have been removed from Chromium together with Manifest V2 extensions.
  ///
  /// Returns an empty list.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// browserContext.backgroundPages;
  /// ```
  ///
  /// **Returns**
  /// - List&lt;[Page]&gt;
  List<Page> get backgroundPages;

  /// **NOTE**
  /// Service workers are only supported on Chromium-based browsers.
  /// All existing service workers in the context.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// browserContext.serviceWorkers;
  /// ```
  ///
  /// **Returns**
  /// - List&lt;[Worker]&gt;
  List<Worker> get serviceWorkers;

  /// This setting will change the default maximum time for all the methods accepting [timeout] option.
  ///
  /// **NOTE**
  /// [page.setDefaultNavigationTimeout()], [page.setDefaultTimeout()] and [browserContext.setDefaultNavigationTimeout()] take priority over [browserContext.setDefaultTimeout()].
  /// **Usage**
  ///
  /// ```dart
  /// browserContext.setDefaultTimeout(timeout);
  /// ```
  ///
  /// **Arguments**
  /// - `timeout` double
  ///
  ///   Maximum time in milliseconds. Pass `0` to disable timeout.
  void setDefaultTimeout(double timeout);

  /// This setting will change the default maximum navigation time for the following methods and related shortcuts:
  /// * [page.goBack()]
  /// * [page.goForward()]
  /// * [page.goto()]
  /// * [page.reload()]
  /// * [page.setContent()]
  /// * [page.waitForNavigation()]
  ///
  /// **NOTE**
  /// [page.setDefaultNavigationTimeout()] and [page.setDefaultTimeout()] take priority over [browserContext.setDefaultNavigationTimeout()].
  /// **Usage**
  ///
  /// ```dart
  /// browserContext.setDefaultNavigationTimeout(timeout);
  /// ```
  ///
  /// **Arguments**
  /// - `timeout` double
  ///
  ///   Maximum navigation time in milliseconds
  void setDefaultNavigationTimeout(double timeout);

  /// Closes the browser context. All the pages that belong to the browser context will be closed.
  ///
  /// **NOTE**
  /// The default browser context cannot be closed.
  /// **Usage**
  ///
  /// ```dart
  /// await browserContext.close();
  /// await browserContext.close(options);
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `reason` String *(optional)*
  ///
  ///     The reason to be reported to the operations interrupted by the context closure.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> close({String? reason});

  /// Sets network interception patterns for this context.
  Future<void> setNetworkInterceptionPatterns(
    List<BrowserContextSetNetworkInterceptionPatternsPatternsItems> patterns,
  );

  /// Pauses the context for debugging.
  Future<void> pause();

  /// Fast forwards the clock.
  Future<void> clockFastForward({double? ticksNumber, String? ticksString});

  /// Installs the clock.
  Future<void> clockInstall({double? timeNumber, String? timeString});

  /// Pauses the clock at a specific time.
  Future<void> clockPauseAt({double? timeNumber, String? timeString});

  /// Resumes the clock.
  Future<void> clockResume();

  /// Runs the clock for a specific duration.
  Future<void> clockRunFor({double? ticksNumber, String? ticksString});

  /// Sets a fixed time for the clock.
  Future<void> clockSetFixedTime({double? timeNumber, String? timeString});

  /// Sets the system time for the clock.
  Future<void> clockSetSystemTime({double? timeNumber, String? timeString});

  /// The method adds a function called [name] on the `window` object of every frame in every page in the context. When called, the function executes [callback] and returns a Future which resolves to the return value of [callback]. If the [callback] returns a Future, it will be awaited.
  ///
  /// The first argument of the [callback] function contains information about the caller: `{ browserContext: BrowserContext, page: Page, frame: Frame }`.
  ///
  /// See [page.exposeBinding()] for page-only version.
  ///
  /// **Usage**
  ///
  /// An example of exposing page URL to all frames in all pages in the context:
  ///
  /// ```dart
  ///   // Or 'chromium' or 'firefox'.
  ///
  /// (() async {
  ///   final browser = await webkit.launch( headless: false );
  ///   final context = await browser.newContext();
  ///   await context.exposeBinding('pageURL', ( page ) => page.url());
  ///   final page = await context.newPage();
  ///   await page.setContent(`
  ///     <script>
  ///       async function onClick() {
  ///         document.querySelector('div').textContent = await window.pageURL();
  ///       }
  ///     </script>
  ///     <button onclick="onClick()">Click me</button>
  ///     <div></div>
  ///   `);
  ///   await page.getByRole('button').click();
  /// }
  /// ```
  ///
  /// **Arguments**
  /// - `name` String
  ///
  ///   Name of the function on the window object.
  /// - `callback` Function
  ///
  ///   Callback function that will be called in the Playwright's context.
  ///
  /// **Returns**
  /// - Future&lt;[Disposable]&gt;
  Future<void> exposeBinding(String name);

  /// The method adds a function called [name] on the `window` object of every frame in every page in the context. When called, the function executes [callback] and returns a Future which resolves to the return value of [callback].
  ///
  /// If the [callback] returns a Future, it will be awaited.
  ///
  /// See [page.exposeFunction()] for page-only version.
  ///
  /// **Usage**
  ///
  /// An example of adding a `sha256` function to all pages in the context:
  ///
  /// ```dart
  ///   // Or 'chromium' or 'firefox'.
  ///
  /// (() async {
  ///   final browser = await webkit.launch( headless: false );
  ///   final context = await browser.newContext();
  ///   await context.exposeFunction('sha256', (text) =>
  ///     crypto.createHash('sha256').update(text).digest('hex'),
  ///   );
  ///   final page = await context.newPage();
  ///   await page.setContent(`
  ///     <script>
  ///       async function onClick() {
  ///         document.querySelector('div').textContent = await window.sha256('PLAYWRIGHT');
  ///       }
  ///     </script>
  ///     <button onclick="onClick()">Click me</button>
  ///     <div></div>
  ///   `);
  ///   await page.getByRole('button').click();
  /// }
  /// ```
  ///
  /// **Arguments**
  /// - `name` String
  ///
  ///   Name of the function on the window object.
  /// - `callback` Function
  ///
  ///   Callback function that will be called in the Playwright's context.
  ///
  /// **Returns**
  /// - Future&lt;[Disposable]&gt;
  Future<void> exposeFunction(String name);

  // ── WebAuthn / Virtual Authenticator ─────────────────────────────────────

  /// Installs a virtual authenticator into this browser context.

  ///

  /// After calling this, the context can create and use virtual credentials

  /// for WebAuthn flows. Call once before [addVirtualCredential].

  Future<void> installVirtualAuthenticator();

  /// Creates a new virtual credential on the installed authenticator.

  Future<BrowserContextCredentialsCreateResult> addVirtualCredential({
    String? id,

    String? privateKey,

    String? publicKey,

    required String rpId,

    String? userHandle,
  });

  /// Returns all virtual credentials matching the optional filters.

  Future<List<VirtualCredential>> getVirtualCredentials({
    String? id,

    String? rpId,
  });

  /// Removes a virtual credential by its [id].

  Future<void> removeVirtualCredential(String id);

  // ── Channel Method Aliases ────────────────────────────────────────────────

  // These provide direct access to channel methods for compatibility

  /// Creates a virtual credential (alias for addVirtualCredential).

  Future<BrowserContextCredentialsCreateResult> credentialsCreate({
    String? id,

    String? privateKey,

    String? publicKey,

    required String rpId,

    String? userHandle,
  });

  /// Deletes a virtual credential (alias for removeVirtualCredential).

  Future<void> credentialsDelete({required String id});

  /// Gets virtual credentials (alias for getVirtualCredentials).

  Future<BrowserContextCredentialsGetResult> credentialsGet({
    String? id,

    String? rpId,
  });

  /// Installs virtual authenticator (alias for installVirtualAuthenticator).

  Future<void> credentialsInstall();

  /// Registers a custom selector engine.
  Future<void> registerSelectorEngine(
    String name,

    String source, {

    bool? contentScript,

    SelectorEngine? selectorEngine,
  });

  /// Sets the test ID attribute name.
  Future<void> setTestIdAttributeName(String testIdAttributeName);

  /// Sets WebSocket interception patterns.
  Future<void> setWebSocketInterceptionPatterns(
    List<BrowserContextSetWebSocketInterceptionPatternsPatternsItems> patterns,
  );

  /// Enables the recorder.
  Future<void> enableRecorder({
    String? language,

    BrowserContextEnableRecorderModeEnum? mode,

    BrowserContextEnableRecorderRecorderModeEnum? recorderMode,

    bool? pauseOnNextStatement,

    String? testIdAttributeName,

    Map<String, dynamic>? launchOptions,

    Map<String, dynamic>? contextOptions,

    String? device,

    String? saveStorage,

    String? outputFile,

    bool? handleSIGINT,

    bool? omitCallTracking,
  });

  /// Disables the recorder.
  Future<void> disableRecorder();

  /// Exposes the console API to the page.
  Future<void> exposeConsoleApi();

  /// **NOTE**
  /// CDP sessions are only supported on Chromium-based browsers.
  /// Returns the newly created session.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await browserContext.newCDPSession(page);
  /// ```
  ///
  /// **Arguments**
  /// - `page` Page
  ///
  ///   Target to create new session for. For backwards-compatibility, this parameter is named `page`, but it can be a `Page` or `Frame` type.
  ///
  /// **Returns**
  /// - Future&lt;[CDPSession]&gt;
  Future<CDPSession> newCDPSession({Page? page, Frame? frame});

  /// Creates temporary files.
  Future<BrowserContextCreateTempFilesResult> createTempFiles({
    String? rootDirName,

    required List<BrowserContextCreateTempFilesItemsItems> items,
  });

  /// Updates the subscription for events.
  Future<void> updateSubscription({
    required BrowserContextUpdateSubscriptionEventEnum event,

    required bool enabled,
  });

  /// Routing provides the capability to modify network requests that are made by any page in the browser context. Once route is enabled, every request matching the url pattern will stall unless it's continued, fulfilled or aborted.
  ///
  /// **NOTE**
  /// [browserContext.route()] will not intercept requests intercepted by Service Worker. See [this] issue. We recommend disabling Service Workers when using request interception by setting [serviceWorkers] to `'block'`.
  /// **Usage**
  ///
  /// An example of a naive handler that aborts all image requests:
  ///
  /// ```dart
  /// final context = await browser.newContext();
  /// await context.route('**/*.{png,jpg,jpeg}', (route) => route.abort());
  /// final page = await context.newPage();
  /// await page.goto('https://example.com');
  /// await browser.close();
  /// ```
  ///
  /// or the same snippet using a regex pattern instead:
  ///
  /// ```dart
  /// final context = await browser.newContext();
  /// await context.route(/(\.png$)|(\.jpg$)/, (route) => route.abort());
  /// final page = await context.newPage();
  /// await page.goto('https://example.com');
  /// await browser.close();
  /// ```
  ///
  /// It is possible to examine the request to decide the route action. For example, mocking all requests that contain some post data, and leaving all other requests as is:
  ///
  /// ```dart
  /// await context.route('/api/**', (route) async {
  ///   if (route.request().postData().includes('my-string'))
  ///     await route.fulfill( body: 'mocked-data' );
  ///   else
  ///     await route.continue();
  /// );
  /// ```
  ///
  /// Page routes (set up with [page.route()]) take precedence over browser context routes when request matches both handlers.
  ///
  /// To remove a route with its handler you can use [browserContext.unroute()].
  ///
  /// **NOTE**
  /// Enabling routing disables http cache.
  /// **Arguments**
  /// - `url` String
  ///
  ///   A glob pattern, regex pattern, URL pattern, or predicate that receives a [URL] to match during routing. If [baseURL] is set in the context options and the provided URL is a string that does not start with `*`, it is resolved using the [`new URL()`] constructor.
  /// - `handler` Future&lt;void&gt; Function(Route)
  ///
  ///   handler function to route the request.
  /// - `options` Map *(optional)*
  ///   - `times` num *(optional)*
  ///
  ///     How often a route should be used. By default it will be used every time.
  ///
  /// **Returns**
  /// - Future&lt;[Disposable]&gt;
  Future<void> route(String url, Future<void> Function(Route) handler);

  /// Removes a route created with [browserContext.route()]. When [handler] is not specified, removes all routes for the [url].
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await browserContext.unroute(url);
  /// await browserContext.unroute(url, handler);
  /// ```
  ///
  /// **Arguments**
  /// - `url` String
  ///
  ///   A glob pattern, regex pattern, URL pattern, or predicate receiving [URL] used to register a routing with [browserContext.route()].
  /// - `handler` Future&lt;void&gt; Function(Route route) *(optional)*
  ///
  ///   Optional handler function used to register a routing with [browserContext.route()].
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> unroute(
    String url, {

    Future<void> Function(Route route)? handler,
  });

  /// Removes all routes created with [browserContext.route()] and [browserContext.routeFromHAR()].
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await browserContext.unrouteAll();
  /// await browserContext.unrouteAll(options);
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `behavior` "wait" | "ignoreErrors" | "default" *(optional)*
  ///
  ///     Specifies whether to wait for already running handlers and what to do if they throw errors:
  ///     * `'default'` - do not wait for current handler calls (if any) to finish, if unrouted handler throws, it may result in unhandled error
  ///     * `'wait'` - wait for current handler calls (if any) to finish
  ///     * `'ignoreErrors'` - do not wait for current handler calls (if any) to finish, all errors thrown by the handlers after unrouting are silently caught
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> unrouteAll();

  /// If specified the network requests that are made in the context will be served from the HAR file. Read more about [Replaying from HAR].
  ///
  /// Playwright will not serve requests intercepted by Service Worker from the HAR file. See [this] issue. We recommend disabling Service Workers when using request interception by setting [serviceWorkers] to `'block'`.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await browserContext.routeFromHAR(har);
  /// await browserContext.routeFromHAR(har, options);
  /// ```
  ///
  /// **Arguments**
  /// - `har` String
  ///
  ///   Path to a [HAR] file with prerecorded network data. If `path` is a relative path, then it is resolved relative to the current working directory.
  /// - `options` Map *(optional)*
  ///   - `notFound` "abort" | "fallback" *(optional)*
  ///     * If set to 'abort' any request not found in the HAR file will be aborted.
  ///     * If set to 'fallback' falls through to the next route handler in the handler chain.
  ///
  ///     Defaults to abort.
  ///   - `update` bool *(optional)*
  ///
  ///     If specified, updates the given HAR with the actual network information instead of serving from file. The file is written to disk when [browserContext.close()] is called.
  ///   - `updateContent` "embed" | "attach" *(optional)*
  ///
  ///     Optional setting to control resource content management. If `attach` is specified, resources are persisted as separate files or entries in the ZIP archive. If `embed` is specified, content is stored inline the HAR file.
  ///   - `updateMode` "full" | "minimal" *(optional)*
  ///
  ///     When set to `minimal`, only record information necessary for routing from HAR. This omits sizes, timing, page, cookies, security and other types of HAR information that are not used when replaying from HAR. Defaults to `minimal`.
  ///   - `url` String *(optional)*
  ///
  ///     A glob pattern, regular expression or predicate to match the request URL. Only requests with URL matching the pattern will be served from the HAR file. If not specified, all requests are served from the HAR file.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> routeFromHAR(
    String harPath, {

    String? url,

    bool notFoundFallback,
  });
}

class BrowserContextImpl extends BrowserContextBase implements BrowserContext {
  bool _isClosed = false;

  final RouteManager _routeManager = RouteManager();

  late final RouteListener _routeListener = RouteListener(_routeManager);

  @override
  late final Tracing tracing;

  @override
  late final APIRequestContext request;

  @override
  late final Clock clock;

  @override
  bool get isClosed => _isClosed;

  @override
  List<Page> get backgroundPages => objects.values
      .whereType<PageImpl>()
      .where((p) => p.initializer['isBackgroundPage'] == true)
      .toList();

  @override
  List<Worker> get serviceWorkers =>
      objects.values.whereType<Worker>().toList();

  double? _timeout;

  double? _navigationTimeout;

  double? get defaultTimeout => _timeout;

  double? get defaultNavigationTimeout => _navigationTimeout;

  @override
  void setDefaultTimeout(double timeout) {
    _timeout = timeout;

    connection
        .sendMessageToServer(guid, 'setDefaultTimeoutNoReply', {
          'timeout': timeout,
        })
        .catchError((_) => <String, dynamic>{});
  }

  @override
  void setDefaultNavigationTimeout(double timeout) {
    _navigationTimeout = timeout;

    connection
        .sendMessageToServer(guid, 'setDefaultNavigationTimeoutNoReply', {
          'timeout': timeout,
        })
        .catchError((_) => <String, dynamic>{});
  }

  @override
  Browser? get browser => parent is Browser ? parent as Browser : null;

  @override
  Stream<Map<String, dynamic>> get onRecorderEvent {
    return onEvent
        .where((e) => e['event'] == 'recorderEvent')
        .map((e) => e['params']);
  }

  @override
  Stream<Map<String, dynamic>> get onResponse {
    return onEvent
        .where((e) => e['event'] == 'response')
        .map((e) => e['params']);
  }

  @override
  Stream<Map<String, dynamic>> get onRequestFinished {
    return onEvent
        .where((e) => e['event'] == 'requestFinished')
        .map((e) => e['params']);
  }

  @override
  Stream<Map<String, dynamic>> get onRequestFailed {
    return onEvent
        .where((e) => e['event'] == 'requestFailed')
        .map((e) => e['params']);
  }

  @override
  Stream<Map<String, dynamic>> get onRequest {
    return onEvent
        .where((e) => e['event'] == 'request')
        .map((e) => e['params']);
  }

  @override
  Stream<Worker> get onServiceWorker {
    return onEvent
        .where((e) => e['event'] == 'serviceWorker')
        .map((e) => e['params']['worker']);
  }

  @override
  Stream<WebSocketRoute> get onWebSocketRoute {
    return onEvent
        .where((e) => e['event'] == 'webSocketRoute')
        .map((e) => e['params']['webSocketRoute']);
  }

  @override
  Stream<Route> get onRoute {
    return onEvent.where((e) => e['event'] == 'route').map((e) {
      final routeGuid = e['params']['route']['guid'];

      return connection.objects[routeGuid] as Route;
    });
  }

  @override
  Stream<Map<String, dynamic>> get onPageError {
    return onEvent
        .where((e) => e['event'] == 'pageError')
        .map((e) => e['params']);
  }

  @override
  Stream<Page> get onPage {
    return onEvent
        .where((e) => e['event'] == 'page')
        .map((e) => e['params']['page']);
  }

  @override
  Stream<Dialog> get onDialog {
    return onEvent
        .where((e) => e['event'] == 'dialog')
        .map((e) => e['params']['dialog']);
  }

  @override
  Stream<BrowserContext> get onClose {
    return onEvent.where((e) => e['event'] == 'close').map((e) => this);
  }

  @override
  Stream<Map<String, dynamic>> get onConsole {
    return onEvent
        .where((e) => e['event'] == 'console')
        .map((e) => e['params']);
  }

  @override
  Stream<BindingCall> get onBindingCall {
    return onEvent
        .where((e) => e['event'] == 'bindingCall')
        .map((e) => e['params']['binding']);
  }

  @override
  List<Page> get pages => objects.values.whereType<Page>().toList();

  BrowserContextImpl(
    super.connection,

    super.channelType,

    super.guid,

    super.initializer, [

    super.parent,
  ]) {
    tracing = ChannelOwner.from<TracingImpl>(
      connection,

      initializer['tracing'],
    );

    request = ChannelOwner.from<APIRequestContextImpl>(
      connection,

      initializer['requestContext'],
    );

    clock = ClockImpl(this);

    onEvent.where((e) => e['event'] == 'close').listen((_) => _isClosed = true);

    onEvent.where((e) => e['event'] == 'requestFailed').listen((e) {
      final requestGuid = e['params']['request']['guid'];

      final request = connection.objects[requestGuid] as RequestImpl?;

      if (request != null) {
        request.failureText = e['params']['failureText'];

        if (e['params']['responseEndTiming'] != null) {
          final t = request.timing;

          t['responseEnd'] = e['params']['responseEndTiming'];

          request.timing = t;
        }
      }
    });

    onEvent.where((e) => e['event'] == 'requestFinished').listen((e) {
      final requestGuid = e['params']['request']['guid'];

      final request = connection.objects[requestGuid] as RequestImpl?;

      if (request != null && e['params']['responseEndTiming'] != null) {
        final t = request.timing;

        t['responseEnd'] = e['params']['responseEndTiming'];

        request.timing = t;
      }
    });
  }

  @override
  Future<Page> newPage() async {
    final result = await super.channel.newPage();

    final page = result.page as Page;
    Logger.debug('New page created.', name: 'playwright.context');
    return page;
  }

  @override
  Future<void> addCookies(List<SetNetworkCookie> cookies) async {
    Logger.debug(
      'addCookies (${cookies.length} cookies)',
      name: 'playwright.context',
    );
    await super.channel.addCookies(cookies: cookies);
  }

  @override
  Future<void> clearCookies({
    String? name,

    String? domain,

    String? path,

    String? nameRegexSource,

    String? nameRegexFlags,

    String? domainRegexSource,

    String? domainRegexFlags,

    String? pathRegexSource,

    String? pathRegexFlags,
  }) async {
    await super.channel.clearCookies(
      name: name,

      domain: domain,

      path: path,

      nameRegexSource: nameRegexSource,

      nameRegexFlags: nameRegexFlags,

      domainRegexSource: domainRegexSource,

      domainRegexFlags: domainRegexFlags,

      pathRegexSource: pathRegexSource,

      pathRegexFlags: pathRegexFlags,
    );
  }

  @override
  Future<List<NetworkCookie>> cookies({List<String>? urls}) async {
    final result = await super.channel.cookies(urls: urls ?? []);

    return result.cookies;
  }

  @override
  Future<void> grantPermissions(
    List<BrowserPermission> permissions, {
    String? origin,
  }) async {
    Logger.debug(
      'grantPermissions ${permissions.map((e) => e.value).toList()}${origin != null ? ' (origin: $origin)' : ''}',
      name: 'playwright.browserContext',
    );
    await super.channel.grantPermissions(
      permissions: permissions.map((e) => e.value).toList(),
      origin: origin,
    );
  }

  @override
  Future<void> setExtraHTTPHeaders(List<NameValue> headers) async {
    Logger.debug(
      'setExtraHTTPHeaders (${headers.length} headers)',
      name: 'playwright.context',
    );
    await super.channel.setExtraHTTPHeaders(headers: headers);
  }

  @override
  Future<void> clearPermissions() async {
    await channel.clearPermissions();
  }

  @override
  Future<void> setGeolocation(
    BrowserContextSetGeolocationGeolocation? geolocation,
  ) async {
    Logger.debug('setGeolocation', name: 'playwright.context');
    await channel.setGeolocation(geolocation: geolocation);
  }

  @override
  Future<void> setHTTPCredentials(
    BrowserContextSetHTTPCredentialsHttpCredentials? httpCredentials,
  ) async {
    Logger.debug('setHTTPCredentials', name: 'playwright.context');
    await channel.setHTTPCredentials(httpCredentials: httpCredentials);
  }

  @override
  Future<void> setOffline(bool offline) async {
    Logger.debug('setOffline ($offline)', name: 'playwright.context');
    await channel.setOffline(offline: offline);
  }

  @override
  Future<BrowserContextStorageStateResult> storageState({
    bool? indexedDB,
  }) async {
    final result = await channel.storageState(indexedDB: indexedDB);

    return result;
  }

  @override
  Future<void> setStorageState(
    BrowserContextSetStorageStateStorageState storageState,
  ) async {
    await channel.setStorageState(storageState: storageState);
  }

  @override
  Future<void> addInitScript(String source) async {
    Logger.debug('addInitScript', name: 'playwright.context');
    await channel.addInitScript(source: source);
  }

  @override
  Future<void> close({String? reason}) async {
    Logger.debug(
      'Closing browser context${reason != null ? ': $reason' : ''}.',
      name: 'playwright.context',
    );
    await channel.close(reason: reason);
  }

  @override
  Future<void> setNetworkInterceptionPatterns(
    List<BrowserContextSetNetworkInterceptionPatternsPatternsItems> patterns,
  ) async {
    await channel.setNetworkInterceptionPatterns(patterns: patterns);
  }

  @override
  Future<void> pause() async {
    await channel.pause();
  }

  @override
  Future<void> clockFastForward({
    double? ticksNumber,

    String? ticksString,
  }) async {
    await channel.clockFastForward(
      ticksNumber: ticksNumber,

      ticksString: ticksString,
    );
  }

  @override
  Future<void> clockInstall({double? timeNumber, String? timeString}) async {
    await channel.clockInstall(timeNumber: timeNumber, timeString: timeString);
  }

  @override
  Future<void> clockPauseAt({double? timeNumber, String? timeString}) async {
    await channel.clockPauseAt(timeNumber: timeNumber, timeString: timeString);
  }

  @override
  Future<void> clockResume() async {
    await channel.clockResume();
  }

  @override
  Future<void> clockRunFor({double? ticksNumber, String? ticksString}) async {
    await channel.clockRunFor(
      ticksNumber: ticksNumber,

      ticksString: ticksString,
    );
  }

  @override
  Future<void> clockSetFixedTime({
    double? timeNumber,

    String? timeString,
  }) async {
    await channel.clockSetFixedTime(
      timeNumber: timeNumber,

      timeString: timeString,
    );
  }

  @override
  Future<void> clockSetSystemTime({
    double? timeNumber,

    String? timeString,
  }) async {
    await channel.clockSetSystemTime(
      timeNumber: timeNumber,

      timeString: timeString,
    );
  }

  @override
  Future<void> exposeBinding(String name) async {
    await channel.exposeBinding(name: name);
  }

  @override
  Future<void> exposeFunction(String name) async {
    await channel.exposeBinding(name: name);
  }

  // ── WebAuthn / Virtual Authenticator ─────────────────────────────────────

  @override
  Future<void> installVirtualAuthenticator() async {
    await channel.credentialsInstall();
  }

  @override
  Future<BrowserContextCredentialsCreateResult> addVirtualCredential({
    String? id,

    String? privateKey,

    String? publicKey,

    required String rpId,

    String? userHandle,
  }) async {
    return await channel.credentialsCreate(
      id: id,

      privateKey: privateKey,

      publicKey: publicKey,

      rpId: rpId,

      userHandle: userHandle,
    );
  }

  @override
  Future<List<VirtualCredential>> getVirtualCredentials({
    String? id,

    String? rpId,
  }) async {
    final result = await channel.credentialsGet(id: id, rpId: rpId);

    return result.credentials;
  }

  @override
  Future<void> removeVirtualCredential(String id) async {
    await channel.credentialsDelete(id: id);
  }

  // ── Channel Method Aliases ────────────────────────────────────────────────

  @override
  Future<BrowserContextCredentialsCreateResult> credentialsCreate({
    String? id,

    String? privateKey,

    String? publicKey,

    required String rpId,

    String? userHandle,
  }) async {
    return await channel.credentialsCreate(
      id: id,

      privateKey: privateKey,

      publicKey: publicKey,

      rpId: rpId,

      userHandle: userHandle,
    );
  }

  @override
  Future<void> credentialsDelete({required String id}) async {
    await channel.credentialsDelete(id: id);
  }

  @override
  Future<BrowserContextCredentialsGetResult> credentialsGet({
    String? id,

    String? rpId,
  }) async {
    return await channel.credentialsGet(id: id, rpId: rpId);
  }

  @override
  Future<void> credentialsInstall() async {
    await channel.credentialsInstall();
  }

  @override
  Future<void> registerSelectorEngine(
    String name,

    String source, {

    bool? contentScript,

    SelectorEngine? selectorEngine,
  }) async {
    await channel.registerSelectorEngine(
      selectorEngine:
          selectorEngine ??
          SelectorEngine(
            name: name,

            source: source,

            contentScript: contentScript,
          ),
    );
  }

  @override
  Future<void> setTestIdAttributeName(String testIdAttributeName) async {
    await channel.setTestIdAttributeName(
      testIdAttributeName: testIdAttributeName,
    );
  }

  @override
  Future<void> setWebSocketInterceptionPatterns(
    List<BrowserContextSetWebSocketInterceptionPatternsPatternsItems> patterns,
  ) async {
    await channel.setWebSocketInterceptionPatterns(patterns: patterns);
  }

  @override
  Future<void> enableRecorder({
    String? language,

    BrowserContextEnableRecorderModeEnum? mode,

    BrowserContextEnableRecorderRecorderModeEnum? recorderMode,

    bool? pauseOnNextStatement,

    String? testIdAttributeName,

    Map<String, dynamic>? launchOptions,

    Map<String, dynamic>? contextOptions,

    String? device,

    String? saveStorage,

    String? outputFile,

    bool? handleSIGINT,

    bool? omitCallTracking,
  }) async {
    await channel.enableRecorder(
      language: language,

      mode: mode,

      recorderMode: recorderMode,

      pauseOnNextStatement: pauseOnNextStatement,

      testIdAttributeName: testIdAttributeName,

      launchOptions: launchOptions,

      contextOptions: contextOptions,

      device: device,

      saveStorage: saveStorage,

      outputFile: outputFile,

      handleSIGINT: handleSIGINT,

      omitCallTracking: omitCallTracking,
    );
  }

  @override
  Future<void> disableRecorder() async {
    await channel.disableRecorder();
  }

  @override
  Future<void> exposeConsoleApi() async {
    await channel.exposeConsoleApi();
  }

  @override
  Future<CDPSession> newCDPSession({Page? page, Frame? frame}) async {
    final result = await channel.newCDPSession(
      page: page as PageImpl?,

      frame: frame as FrameImpl?,
    );

    return result.session as CDPSession;
  }

  @override
  Future<BrowserContextCreateTempFilesResult> createTempFiles({
    String? rootDirName,

    required List<BrowserContextCreateTempFilesItemsItems> items,
  }) async {
    return await channel.createTempFiles(
      rootDirName: rootDirName,

      items: items,
    );
  }

  @override
  Future<void> updateSubscription({
    required BrowserContextUpdateSubscriptionEventEnum event,

    required bool enabled,
  }) async {
    await channel.updateSubscription(event: event, enabled: enabled);
  }

  @override
  Future<void> route(String url, Future<void> Function(Route) handler) async {
    _routeManager.add(url, handler);

    _routeListener.attach(onRoute);

    await channel.setNetworkInterceptionPatterns(
      patterns: _routeManager.prepareContextPatterns(),
    );
  }

  @override
  Future<void> unroute(
    String url, {

    Future<void> Function(Route route)? handler,
  }) async {
    _routeManager.remove(url, handler);

    await channel.setNetworkInterceptionPatterns(
      patterns: _routeManager.prepareContextPatterns(),
    );
  }

  @override
  Future<void> unrouteAll() async {
    _routeManager.clear();

    await channel.setNetworkInterceptionPatterns(patterns: []);
  }

  @override
  Future<void> routeFromHAR(
    String harPath, {

    String? url,

    bool notFoundFallback = false,
  }) async {
    await sharedRouteFromHAR(
      this,

      harPath,

      url: url,

      notFoundFallback: notFoundFallback,
    );
  }
}
