import 'browser_context.dart';

import '../utils/cdp_session.dart';

import 'page.dart';

import '../generated/channels.dart';

import '../utils/artifact.dart';

import '../infrastructure/stream.dart';

import 'playwright.dart';

import 'browser_type.dart';

import '../utils/logger.dart';

/// A Browser is created via [BrowserType.launch].

///

/// An example of using a Browser to create a Page:

/// ```dart

/// final browser = await playwright.chromium.launch();

/// final page = await browser.newPage();

/// await page.goto('https://example.com');

/// await browser.close();

/// ```

/// Interface for Browser

abstract interface class Browser {
  /// Returns an array of all open browser contexts. In a newly created browser, this will return zero browser contexts.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// final browser = await pw.webkit.launch();
  /// print(browser.contexts.length); // prints `0`
  ///
  /// final context = await browser.newContext();
  /// print(browser.contexts.length); // prints `1`
  /// ```
  ///
  /// **Returns**
  /// - List&lt;[BrowserContext]&gt;
  List<BrowserContext> get contexts;

  /// Returns the browser version.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// browser.version;
  /// ```
  ///
  /// **Returns**
  /// - String
  String get version;

  /// The browser type name: `chromium`, `firefox`, or `webkit`.

  String get browserName;

  /// Indicates that the browser is connected.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// browser.isConnected;
  /// ```
  ///
  /// **Returns**
  /// - bool
  bool get isConnected;

  /// Get the browser type (chromium, firefox or webkit) that the browser belongs to.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// browser.browserType;
  /// ```
  ///
  /// **Returns**
  /// - [BrowserType]
  BrowserType? get browserType;

  Stream<Browser> get onClose;

  Stream<BrowserContext> get onContext;

  /// Creates a new browser context. It won't share cookies/cache with other browser contexts.
  ///
  /// **NOTE**
  /// If directly using this method to create [BrowserContext]s, it is best practice to explicitly close the returned context via [browserContext.close()] when your code is done with the [BrowserContext], and before calling [browser.close()]. This will ensure the `context` is closed gracefully and any artifacts—like HARs and videos—are fully flushed and saved.
  /// **Usage**
  ///
  /// ```dart
  /// (() async {
  ///   final browser = await playwright.firefox.launch();  // Or 'chromium' or 'webkit'.
  ///   // Create a new incognito browser context.
  ///   final context = await browser.newContext();
  ///   // Create a new page in a pristine context.
  ///   final page = await context.newPage();
  ///   await page.goto('https://example.com');
  ///
  ///   // Gracefully close up everything
  ///   await context.close();
  ///   await browser.close();
  /// }
  /// ```
  ///
  /// **Arguments**
  /// - `options` ContextOptions *(optional)*
  ///   - `acceptDownloads` bool *(optional)*
  ///
  ///     Whether to automatically download all the attachments. Defaults to `true` where all the downloads are accepted.
  ///   - `baseURL` String *(optional)*
  ///
  ///     When using [page.goto()], [page.route()], [page.waitForURL()], [page.waitForRequest()], or [page.waitForResponse()] it takes the base URL in consideration by using the [`URL()`] constructor for building the corresponding URL. Unset by default. Examples:
  ///     * baseURL: `http://localhost:3000` and navigating to `/bar.html` results in `http://localhost:3000/bar.html`
  ///     * baseURL: `http://localhost:3000/foo/` and navigating to `./bar.html` results in `http://localhost:3000/foo/bar.html`
  ///     * baseURL: `http://localhost:3000/foo` (without trailing slash) and navigating to `./bar.html` results in `http://localhost:3000/bar.html`
  ///   - `bypassCSP` bool *(optional)*
  ///
  ///     Toggles bypassing page's Content-Security-Policy. Defaults to `false`.
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
  ///   - `proxy` BrowserNewContextProxy *(optional)*
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
  ///     Network proxy settings to use with this context. Defaults to none.
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
  ///   - `storageState` BrowserNewContextStorageState *(optional)*
  ///     - `cookies` List&lt;Map&gt;
  ///       - `name` String
  ///
  ///
  ///       - `value` String
  ///
  ///
  ///       - `domain` String
  ///
  ///         Domain and path are required. For the cookie to apply to all subdomains as well, prefix domain with a dot, like this: ".example.com"
  ///       - `path` String
  ///
  ///         Domain and path are required
  ///       - `expires` num
  ///
  ///         Unix time in seconds.
  ///       - `httpOnly` bool
  ///
  ///
  ///       - `secure` bool
  ///
  ///
  ///       - `sameSite` "Strict" | "Lax" | "None"
  ///
  ///         sameSite flag
  ///
  ///       Cookies to set for context
  ///     - `origins` List&lt;Map&gt;
  ///       - `origin` String
  ///
  ///
  ///       - `localStorage` List&lt;Map&gt;
  ///         - `name` String
  ///
  ///
  ///         - `value` String
  ///
  ///
  ///         localStorage to set for context
  ///
  ///
  ///     Learn more about [storage state and auth].
  ///
  ///     Populates context with given storage state. This option can be used to initialize context with logged-in information obtained via [browserContext.storageState()].
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
  Future<BrowserContext> newContext({
    ContextOptions? options,

    BrowserNewContextProxy? proxy,

    BrowserNewContextStorageState? storageState,
  });

  /// In case this browser is obtained using [browserType.launch()], closes the browser and all of its pages (if any were opened).
  ///
  /// In case this browser is connected to, clears all created contexts belonging to this browser and disconnects from the browser server.
  ///
  /// **NOTE**
  /// This is similar to force-quitting the browser. To close pages gracefully and ensure you receive page close events, call [browserContext.close()] on any [BrowserContext] instances you explicitly created earlier using [browser.newContext()] **before** calling [browser.close()].
  /// The [Browser] object itself is considered to be disposed and cannot be used anymore.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await browser.close();
  /// await browser.close(options);
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `reason` String *(optional)*
  ///
  ///     The reason to be reported to the operations interrupted by the browser closure.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> close({String? reason});

  /// **NOTE**
  /// CDP Sessions are only supported on Chromium-based browsers.
  /// Returns the newly created browser session.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await browser.newBrowserCDPSession();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;[CDPSession]&gt;
  Future<CDPSession> newBrowserCDPSession();

  /// **NOTE**
  /// This API controls [Chromium Tracing] which is a low-level chromium-specific debugging tool. API to control [Playwright Tracing] could be found [here].
  /// You can use [browser.startTracing()] and [browser.stopTracing()] to create a trace file that can be opened in Chrome DevTools performance panel.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await browser.startTracing(page, { path: 'trace.json' );
  /// await page.goto('https://www.google.com');
  /// await browser.stopTracing();
  /// ```
  ///
  /// **Arguments**
  /// - `page` Page *(optional)*
  ///
  ///   Optional, if specified, tracing includes screenshots of the given page.
  /// - `options` Map *(optional)*
  ///   - `categories` List&lt;String&gt; *(optional)*
  ///
  ///     specify custom categories to use instead of default.
  ///   - `path` String *(optional)*
  ///
  ///     A path to write the trace file to.
  ///   - `screenshots` bool *(optional)*
  ///
  ///     captures screenshots in the trace.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> startTracing({
    Page? page,

    bool? screenshots,

    List<String>? categories,
  });

  /// **NOTE**
  /// This API controls [Chromium Tracing] which is a low-level chromium-specific debugging tool. API to control [Playwright Tracing] could be found [here].
  /// Returns the buffer with trace data.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await browser.stopTracing();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;List&lt;int&gt;&gt;
  Future<List<int>> stopTracing();

  Future<BrowserStartServerResult> startServer({
    required String title,

    String? workspaceDir,

    Map<String, dynamic>? metadata,

    String? host,

    int? port,
  });

  Future<void> stopServer();

  Future<void> killForTests();

  Future<String> defaultUserAgentForTest();

  Future<BrowserContext> newContextForReuse({
    BrowserNewContextForReuseProxy? proxy,

    BrowserNewContextForReuseStorageState? storageState,
  });

  Future<void> disconnectFromReusedContext({String reason});

  /// Creates a new page in a new browser context. Closing this page will close the context as well.
  ///
  /// This is a convenience API that should only be used for the single-page scenarios and short snippets. Production code and testing frameworks should explicitly create [browser.newContext()] followed by the [browserContext.newPage()] to control their exact life times.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await browser.newPage();
  /// await browser.newPage(options);
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `acceptDownloads` bool *(optional)*
  ///
  ///     Whether to automatically download all the attachments. Defaults to `true` where all the downloads are accepted.
  ///   - `baseURL` String *(optional)*
  ///
  ///     When using [page.goto()], [page.route()], [page.waitForURL()], [page.waitForRequest()], or [page.waitForResponse()] it takes the base URL in consideration by using the [`URL()`] constructor for building the corresponding URL. Unset by default. Examples:
  ///     * baseURL: `http://localhost:3000` and navigating to `/bar.html` results in `http://localhost:3000/bar.html`
  ///     * baseURL: `http://localhost:3000/foo/` and navigating to `./bar.html` results in `http://localhost:3000/foo/bar.html`
  ///     * baseURL: `http://localhost:3000/foo` (without trailing slash) and navigating to `./bar.html` results in `http://localhost:3000/bar.html`
  ///   - `bypassCSP` bool *(optional)*
  ///
  ///     Toggles bypassing page's Content-Security-Policy. Defaults to `false`.
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
  ///     Network proxy settings to use with this context. Defaults to none.
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
  ///   - `storageState` String | Map *(optional)*
  ///     - `cookies` List&lt;Map&gt;
  ///       - `name` String
  ///
  ///
  ///       - `value` String
  ///
  ///
  ///       - `domain` String
  ///
  ///         Domain and path are required. For the cookie to apply to all subdomains as well, prefix domain with a dot, like this: ".example.com"
  ///       - `path` String
  ///
  ///         Domain and path are required
  ///       - `expires` num
  ///
  ///         Unix time in seconds.
  ///       - `httpOnly` bool
  ///
  ///
  ///       - `secure` bool
  ///
  ///
  ///       - `sameSite` "Strict" | "Lax" | "None"
  ///
  ///         sameSite flag
  ///
  ///       Cookies to set for context
  ///     - `origins` List&lt;Map&gt;
  ///       - `origin` String
  ///
  ///
  ///       - `localStorage` List&lt;Map&gt;
  ///         - `name` String
  ///
  ///
  ///         - `value` String
  ///
  ///
  ///         localStorage to set for context
  ///
  ///
  ///     Learn more about [storage state and auth].
  ///
  ///     Populates context with given storage state. This option can be used to initialize context with logged-in information obtained via [browserContext.storageState()].
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
  /// - Future&lt;[Page]&gt;
  Future<Page> newPage();
}

class BrowserImpl extends BrowserBase implements Browser {
  bool _isConnected = true;

  @override
  bool get isConnected => _isConnected;

  @override
  String get browserName =>
      (initializer['browserName'] as String?) ??
      initializer['name'] as String? ??
      'chromium';

  @override
  BrowserType? get browserType =>
      parent is BrowserType ? parent as BrowserType : null;

  @override
  List<BrowserContext> get contexts =>
      objects.values.whereType<BrowserContext>().toList();

  @override
  String get version => initializer['version'] as String;

  @override
  Stream<Browser> get onClose {
    return onEvent.where((e) => e['event'] == 'close').map((e) => this);
  }

  @override
  Stream<BrowserContext> get onContext {
    return onEvent
        .where((e) => e['event'] == 'context')
        .map((e) => e['params']['context']);
  }

  BrowserImpl(
    super.connection,

    super.channelType,

    super.guid,

    super.initializer, [

    super.parent,
  ]) {
    onEvent.where((e) => e['event'] == 'close').listen((_) {
      _isConnected = false;
      Logger.info('Browser closed ($browserName).');
    });
  }

  @override
  Future<BrowserContext> newContext({
    ContextOptions? options,

    BrowserNewContextProxy? proxy,

    BrowserNewContextStorageState? storageState,
  }) async {
    if (proxy != null) {
      options ??= ContextOptions();
    }

    final result = await super.channel_newContext(
      contextOptions: options ?? ContextOptions(),

      proxy: proxy,

      storageState: storageState,
    );

    final context = result.context as BrowserContext;

    final playwright =
        connection.objects.values.firstWhere((e) => e is PlaywrightBase)
            as Playwright;

    await playwright.selectors.addContext(context);

    Logger.debug(
      'New browser context created ($browserName).',
      name: 'playwright.browser',
    );
    return context;
  }

  @override
  Future<void> close({String? reason}) async {
    Logger.debug(
      'Closing browser ($browserName)${reason != null ? ': $reason' : ''}.',
      name: 'playwright.browser',
    );
    await channel_close(reason: reason);

    // Auto-shutdown Playwright connection if this was the last active browser.

    if (connection.isAutoCloseEnabled) {
      try {
        final activeBrowsers = connection.objects.values
            .whereType<Browser>()
            .length;

        if (activeBrowsers <= 1) {
          final playwright = connection.objects.values
              .whereType<Playwright>()
              .firstOrNull;

          if (playwright != null) {
            await playwright.stop();
          }
        }
      } catch (_) {
        // Ignore errors during auto-shutdown
      }
    }
  }

  @override
  Future<CDPSession> newBrowserCDPSession() async {
    final result = await channel_newBrowserCDPSession();

    return result.session as CDPSession;
  }

  @override
  Future<void> startTracing({
    Page? page,

    bool? screenshots,

    List<String>? categories,
  }) async {
    await channel_startTracing(
      page: page as PageImpl?,

      screenshots: screenshots,

      categories: categories,
    );
  }

  @override
  Future<List<int>> stopTracing() async {
    final result = await channel_stopTracing();

    final artifact = result.artifact as Artifact;

    final streamResult = await artifact.stream();

    final stream = streamResult.stream as PlaywrightStream;

    final buffer = <int>[];

    while (true) {
      final chunk = await stream.read();

      if (chunk.isEmpty) break;

      buffer.addAll(chunk);
    }

    await artifact.delete();

    return buffer;
  }

  @override
  Future<BrowserStartServerResult> startServer({
    required String title,

    String? workspaceDir,

    Map<String, dynamic>? metadata,

    String? host,

    int? port,
  }) async {
    return await channel_startServer(
      title: title,

      workspaceDir: workspaceDir,

      metadata: metadata,

      host: host,

      port: port,
    );
  }

  @override
  Future<void> stopServer() async {
    await channel_stopServer();
  }

  @override
  Future<void> killForTests() async {
    await channel_killForTests();
  }

  @override
  Future<String> defaultUserAgentForTest() async {
    final result = await channel_defaultUserAgentForTest();

    return result.userAgent;
  }

  @override
  Future<BrowserContext> newContextForReuse({
    BrowserNewContextForReuseProxy? proxy,

    BrowserNewContextForReuseStorageState? storageState,
  }) async {
    final result = await channel_newContextForReuse(
      contextOptions: ContextOptions(),

      proxy: proxy,

      storageState: storageState,
    );

    return result.context as BrowserContext;
  }

  @override
  Future<void> disconnectFromReusedContext({String reason = ''}) async {
    await channel_disconnectFromReusedContext(reason: reason);
  }

  @override
  Future<Page> newPage() async {
    Logger.debug('newPage', name: 'playwright.browser');
    final context = await newContext();

    return await context.newPage();
  }
}
