# Playwright Dart — API Reference

> Auto-generated from `/// ` doc comments in `lib/src/`.
> Regenerate: `dart tool/generate_protocol_docs.dart`

## Contents

- [Core](#core)
  - [`Browser`](#browser)
  - [`BrowserContext`](#browsercontext)
  - [`BrowserType`](#browsertype)
  - [`ExpectReceived`](#expectreceived)
  - [`ExpectResult`](#expectresult)
  - [`Frame`](#frame)
  - [`FrameLocator`](#framelocator)
  - [`Locator`](#locator)
  - [`Page`](#page)
  - [`PdfDimension`](#pdfdimension)
  - [`Playwright`](#playwright)
  - [`PlaywrightDart`](#playwrightdart)
  - [`RouteMatcher`](#routematcher)
  - [`StringRouteMatcher`](#stringroutematcher)
  - [`RegExpRouteMatcher`](#regexproutematcher)
  - [`FunctionRouteMatcher`](#functionroutematcher)
  - [`Selectors`](#selectors)
- [Interaction](#interaction)
  - [`APIResponseAssertions`](#apiresponseassertions)
  - [`Dialog`](#dialog)
  - [`ElementHandle`](#elementhandle)
  - [`FileChooser`](#filechooser)
  - [`SelectOption`](#selectoption)
  - [`InputFile`](#inputfile)
  - [`JSHandle`](#jshandle)
  - [`Keyboard`](#keyboard)
  - [`LocatorAssertions`](#locatorassertions)
  - [`Mouse`](#mouse)
  - [`PageAssertions`](#pageassertions)
  - [`Touchscreen`](#touchscreen)
- [Network](#network)
  - [`APIRequestContext`](#apirequestcontext)
  - [`Request`](#request)
  - [`Response`](#response)
  - [`Route`](#route)
  - [`RouteHandlerEntry`](#routehandlerentry)
  - [`RouteManager`](#routemanager)
  - [`RouteListener`](#routelistener)
  - [`SocksSupport`](#sockssupport)
  - [`PlaywrightWebSocket`](#playwrightwebsocket)
  - [`WebSocketRoute`](#websocketroute)
- [Platform](#platform)
  - [`Android`](#android)
  - [`AndroidDevice`](#androiddevice)
  - [`AndroidSocket`](#androidsocket)
  - [`Electron`](#electron)
  - [`ElectronApplication`](#electronapplication)
- [Utilities](#utilities)
  - [`Artifact`](#artifact)
  - [`CDPSession`](#cdpsession)
  - [`Clock`](#clock)
  - [`ConsoleMessage`](#consolemessage)
  - [`Download`](#download)
  - [`Logger`](#logger)
  - [`Tracing`](#tracing)
  - [`Video`](#video)
  - [`Worker`](#worker)
- [Debugging](#debugging)
  - [`BindingCall`](#bindingcall)
  - [`DebugController`](#debugcontroller)
  - [`Debugger`](#debugger)
  - [`Disposable`](#disposable)
  - [`EventTarget`](#eventtarget)
- [Infrastructure](#infrastructure)
  - [`ChannelOwner`](#channelowner)
  - [`RootChannelOwner`](#rootchannelowner)
  - [`Channel`](#channel)
  - [`Connection`](#connection)
  - [`Driver`](#driver)
  - [`NodePlatform`](#nodeplatform)
  - [`EventEmitter`](#eventemitter)
  - [`FilePayload`](#filepayload)
  - [`JsonPipe`](#jsonpipe)
  - [`LocalUtils`](#localutils)
  - [`PlaywrightError`](#playwrighterror)
  - [`TimeoutError`](#timeouterror)
  - [`TargetClosedError`](#targetclosederror)
  - [`Root`](#root)
  - [`SelectOptionParams`](#selectoptionparams)
  - [`InputFilesParams`](#inputfilesparams)
  - [`PlaywrightStream`](#playwrightstream)
  - [`Transport`](#transport)
  - [`StdioTransport`](#stdiotransport)
  - [`JsonPipeTransport`](#jsonpipetransport)
  - [`Waiter`](#waiter)
  - [`WebSocketTransport`](#websockettransport)
  - [`WritableStream`](#writablestream)

---

# Core

## `Browser`

```dart
abstract interface class Browser
```

### `contexts`

*📦 Property*

Returns an array of all open browser contexts. In a newly created browser, this will return zero browser contexts.

**Usage**

```dart
final browser = await pw.webkit.launch();
print(browser.contexts.length); // prints `0`

final context = await browser.newContext();
print(browser.contexts.length); // prints `1`
```

**Returns**
- List&lt;[BrowserContext]&gt;

```dart
List<BrowserContext> get contexts
```

### `version`

*📦 Property*

Returns the browser version.

**Usage**

```dart
browser.version;
```

**Returns**
- String

```dart
String get version
```

### `isConnected`

*📦 Property*

Indicates that the browser is connected.

**Usage**

```dart
browser.isConnected;
```

**Returns**
- bool

```dart
bool get isConnected
```

### `browserType`

*📦 Property*

Get the browser type (chromium, firefox or webkit) that the browser belongs to.

**Usage**

```dart
browser.browserType;
```

**Returns**
- [BrowserType]

```dart
BrowserType? get browserType
```

### `newContext`

*⚙️ Method*

Creates a new browser context. It won't share cookies/cache with other browser contexts.

**NOTE**
If directly using this method to create [BrowserContext]s, it is best practice to explicitly close the returned context via [browserContext.close()] when your code is done with the [BrowserContext], and before calling [browser.close()]. This will ensure the `context` is closed gracefully and any artifacts—like HARs and videos—are fully flushed and saved.
**Usage**

```dart
(() async {
final browser = await playwright.firefox.launch();  // Or 'chromium' or 'webkit'.
// Create a new incognito browser context.
final context = await browser.newContext();
// Create a new page in a pristine context.
final page = await context.newPage();
await page.goto('https://example.com');

// Gracefully close up everything
await context.close();
await browser.close();
}
```

**Arguments**
- `options` ContextOptions *(optional)*
- `acceptDownloads` bool *(optional)*

Whether to automatically download all the attachments. Defaults to `true` where all the downloads are accepted.
- `baseURL` String *(optional)*

When using [page.goto()], [page.route()], [page.waitForURL()], [page.waitForRequest()], or [page.waitForResponse()] it takes the base URL in consideration by using the [`URL()`] constructor for building the corresponding URL. Unset by default. Examples:
* baseURL: `http://localhost:3000` and navigating to `/bar.html` results in `http://localhost:3000/bar.html`
* baseURL: `http://localhost:3000/foo/` and navigating to `./bar.html` results in `http://localhost:3000/foo/bar.html`
* baseURL: `http://localhost:3000/foo` (without trailing slash) and navigating to `./bar.html` results in `http://localhost:3000/bar.html`
- `bypassCSP` bool *(optional)*

Toggles bypassing page's Content-Security-Policy. Defaults to `false`.
- `clientCertificates` List&lt;Map&gt; *(optional)*
- `origin` String

Exact origin that the certificate is valid for. Origin includes `https` protocol, a hostname and optionally a port.
- `certPath` String *(optional)*

Path to the file with the certificate in PEM format.
- `cert` List&lt;int&gt; *(optional)*

Direct value of the certificate in PEM format.
- `keyPath` String *(optional)*

Path to the file with the private key in PEM format.
- `key` List&lt;int&gt; *(optional)*

Direct value of the private key in PEM format.
- `pfxPath` String *(optional)*

Path to the PFX or PKCS12 encoded private key and certificate chain.
- `pfx` List&lt;int&gt; *(optional)*

Direct value of the PFX or PKCS12 encoded private key and certificate chain.
- `passphrase` String *(optional)*

Passphrase for the private key (PEM or PFX).

TLS Client Authentication allows the server to request a client certificate and verify it.

**Details**

An array of client certificates to be used. Each certificate object must have either both `certPath` and `keyPath`, a single `pfxPath`, or their corresponding direct value equivalents (`cert` and `key`, or `pfx`). Optionally, `passphrase` property should be provided if the certificate is encrypted. The `origin` property should be provided with an exact match to the request origin that the certificate is valid for.

Client certificate authentication is only active when at least one client certificate is provided. If you want to reject all client certificates sent by the server, you need to provide a client certificate with an `origin` that does not match any of the domains you plan to visit.

**NOTE**
When using WebKit on macOS, accessing `localhost` will not pick up client certificates. You can make it work by replacing `localhost` with `local.playwright`.
- `colorScheme` null | "light" | "dark" | "no-preference" *(optional)*

Emulates [prefers-colors-scheme] media feature, supported values are `'light'` and `'dark'`. See [page.emulateMedia()] for more details. Passing `null` resets emulation to system defaults. Defaults to `'light'`.
- `contrast` null | "no-preference" | "more" *(optional)*

Emulates `'prefers-contrast'` media feature, supported values are `'no-preference'`, `'more'`. See [page.emulateMedia()] for more details. Passing `null` resets emulation to system defaults. Defaults to `'no-preference'`.
- `deviceScaleFactor` num *(optional)*

Specify device scale factor (can be thought of as dpr). Defaults to `1`. Learn more about [emulating devices with device scale factor].
- `extraHTTPHeaders` Map&lt;String, String&gt; *(optional)*

An object containing additional HTTP headers to be sent with every request. Defaults to none.
- `forcedColors` null | "active" | "none" *(optional)*

Emulates `'forced-colors'` media feature, supported values are `'active'`, `'none'`. See [page.emulateMedia()] for more details. Passing `null` resets emulation to system defaults. Defaults to `'none'`.
- `geolocation` Map *(optional)*
- `latitude` num

Latitude between -90 and 90.
- `longitude` num

Longitude between -180 and 180.
- `accuracy` num *(optional)*

Non-negative accuracy value. Defaults to `0`.
- `hasTouch` bool *(optional)*

Specifies if viewport supports touch events. Defaults to false. Learn more about [mobile emulation].
- `httpCredentials` Map *(optional)*
- `username` String


- `password` String


- `origin` String *(optional)*

Restrain sending http credentials on specific origin (scheme://host:port).
- `send` "unauthorized" | "always" *(optional)*

This option only applies to the requests sent from corresponding [APIRequestContext] and does not affect requests sent from the browser. `'always'` - `Authorization` header with basic authentication credentials will be sent with the each API request. `'unauthorized` - the credentials are only sent when 401 (Unauthorized) response with `WWW-Authenticate` header is received. Defaults to `'unauthorized'`.

Credentials for [HTTP authentication]. If no origin is specified, the username and password are sent to any servers upon unauthorized responses.
- `ignoreHTTPSErrors` bool *(optional)*

Whether to ignore HTTPS errors when sending network requests. Defaults to `false`.
- `isMobile` bool *(optional)*

Whether the `meta viewport` tag is taken into account and touch events are enabled. isMobile is a part of device, so you don't actually need to set it manually. Defaults to `false` and is not supported in Firefox. Learn more about [mobile emulation].
- `javaScriptEnabled` bool *(optional)*

Whether or not to enable JavaScript in the context. Defaults to `true`. Learn more about [disabling JavaScript].
- `locale` String *(optional)*

Specify user locale, for example `en-GB`, `de-DE`, etc. Locale will affect `navigator.language` value, `Accept-Language` request header value as well as number and date formatting rules. Defaults to the system default locale. Learn more about emulation in our [emulation guide].
- `logger` [Logger] *(optional)*

**WARNING**
[Deprecated]
The logs received by the logger are incomplete. Please use tracing instead.
Logger sink for Playwright logging.
- `offline` bool *(optional)*

Whether to emulate network being offline. Defaults to `false`. Learn more about [network emulation].
- `permissions` List&lt;String&gt; *(optional)*

A list of permissions to grant to all pages in this context. See [browserContext.grantPermissions()] for more details. Defaults to none.
- `proxy` BrowserNewContextProxy *(optional)*
- `server` String

Proxy to be used for all requests. HTTP and SOCKS proxies are supported, for example `http://myproxy.com:3128` or `socks5://myproxy.com:3128`. Short form `myproxy.com:3128` is considered an HTTP proxy.
- `bypass` String *(optional)*

Optional comma-separated domains to bypass proxy, for example `".com, chromium.org, .domain.com"`.
- `username` String *(optional)*

Optional username to use if HTTP proxy requires authentication.
- `password` String *(optional)*

Optional password to use if HTTP proxy requires authentication.

Network proxy settings to use with this context. Defaults to none.
- `recordHar` Map *(optional)*
- `omitContent` bool *(optional)*

Optional setting to control whether to omit request content from the HAR. Defaults to `false`. Deprecated, use `content` policy instead.
- `content` "omit" | "embed" | "attach" *(optional)*

Optional setting to control resource content management. If `omit` is specified, content is not persisted. If `attach` is specified, resources are persisted as separate files or entries in the ZIP archive. If `embed` is specified, content is stored inline the HAR file as per HAR specification. Defaults to `attach` for `.zip` output files and to `embed` for all other file extensions.
- `path` String

Path on the filesystem to write the HAR file to. If the file name ends with `.zip`, `content: 'attach'` is used by default.
- `mode` "full" | "minimal" *(optional)*

When set to `minimal`, only record information necessary for routing from HAR. This omits sizes, timing, page, cookies, security and other types of HAR information that are not used when replaying from HAR. Defaults to `full`.
- `urlFilter` String | [RegExp] *(optional)*

A glob or regex pattern to filter requests that are stored in the HAR. When a [baseURL] via the context options was provided and the passed URL is a path, it gets merged via the [`new URL()`] constructor. Defaults to none.

Enables [HAR] recording for all pages into `recordHar.path` file. If not specified, the HAR is not recorded. Make sure to await [browserContext.close()] for the HAR to be saved.
- `recordVideo` Map *(optional)*
- `dir` String *(optional)*

Path to the directory to put videos into. If not specified, the videos will be stored in `artifactsDir` (see [browserType.launch()] options).
- `size` Map *(optional)*
- `width` num

Video frame width.
- `height` num

Video frame height.

Optional dimensions of the recorded videos. If not specified the size will be equal to `viewport` scaled down to fit into 800x800. If `viewport` is not configured explicitly the video size defaults to 800x450. Actual picture of each page will be scaled down if necessary to fit the specified size.
- `showActions` Map *(optional)*
- `duration` num *(optional)*

How long each annotation is displayed in milliseconds. Defaults to `500`.
- `position` "top-left" | "top" | "top-right" | "bottom-left" | "bottom" | "bottom-right" *(optional)*

Position of the action title overlay. Defaults to `"top-right"`.
- `fontSize` num *(optional)*

Font size of the action title in pixels. Defaults to `24`.

If specified, enables visual annotations on interacted elements during video recording.

Enables video recording for all pages into `recordVideo.dir` directory. If not specified videos are not recorded. Make sure to await [browserContext.close()] for videos to be saved.
- `reducedMotion` null | "reduce" | "no-preference" *(optional)*

Emulates `'prefers-reduced-motion'` media feature, supported values are `'reduce'`, `'no-preference'`. See [page.emulateMedia()] for more details. Passing `null` resets emulation to system defaults. Defaults to `'no-preference'`.
- `screen` Map *(optional)*
- `width` num

page width in pixels.
- `height` num

page height in pixels.

Emulates consistent window screen size available inside web page via `window.screen`. Is only used when the [viewport] is set.
- `serviceWorkers` "allow" | "block" *(optional)*

Whether to allow sites to register Service workers. Defaults to `'allow'`.
* `'allow'`: [Service Workers] can be registered.
* `'block'`: Playwright will block all registration of Service Workers.
- `storageState` BrowserNewContextStorageState *(optional)*
- `cookies` List&lt;Map&gt;
- `name` String


- `value` String


- `domain` String

Domain and path are required. For the cookie to apply to all subdomains as well, prefix domain with a dot, like this: ".example.com"
- `path` String

Domain and path are required
- `expires` num

Unix time in seconds.
- `httpOnly` bool


- `secure` bool


- `sameSite` "Strict" | "Lax" | "None"

sameSite flag

Cookies to set for context
- `origins` List&lt;Map&gt;
- `origin` String


- `localStorage` List&lt;Map&gt;
- `name` String


- `value` String


localStorage to set for context


Learn more about [storage state and auth].

Populates context with given storage state. This option can be used to initialize context with logged-in information obtained via [browserContext.storageState()].
- `strictSelectors` bool *(optional)*

If set to true, enables strict selectors mode for this context. In the strict selectors mode all operations on selectors that imply single target DOM element will throw when more than one element matches the selector. This option does not affect any Locator APIs (Locators are always strict). Defaults to `false`. See [Locator] to learn more about the strict mode.
- `timezoneId` String *(optional)*

Changes the timezone of the context. See [ICU's metaZones.txt] for a list of supported timezone IDs. Defaults to the system timezone.
- `userAgent` String *(optional)*

Specific user agent to use in this context.
- `viewport` [Map]? *(optional)*
- `width` num

page width in pixels.
- `height` num

page height in pixels.

Emulates consistent viewport for each page. Defaults to an 1280x720 viewport. Use `null` to disable the consistent viewport emulation. Learn more about [viewport emulation].

**NOTE**
The `null` value opts out from the default presets, makes viewport depend on the host window size defined by the operating system. It makes the execution of the tests non-deterministic.
**Returns**
- Future&lt;[BrowserContext]&gt;

```dart
Future<BrowserContext> newContext(
```

### `close`

*⚙️ Method*

In case this browser is obtained using [browserType.launch()], closes the browser and all of its pages (if any were opened).

In case this browser is connected to, clears all created contexts belonging to this browser and disconnects from the browser server.

**NOTE**
This is similar to force-quitting the browser. To close pages gracefully and ensure you receive page close events, call [browserContext.close()] on any [BrowserContext] instances you explicitly created earlier using [browser.newContext()] **before** calling [browser.close()].
The [Browser] object itself is considered to be disposed and cannot be used anymore.

**Usage**

```dart
await browser.close();
await browser.close(options);
```

**Arguments**
- `options` Map *(optional)*
- `reason` String *(optional)*

The reason to be reported to the operations interrupted by the browser closure.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> close(
```

### `newBrowserCDPSession`

*⚙️ Method*

**NOTE**
CDP Sessions are only supported on Chromium-based browsers.
Returns the newly created browser session.

**Usage**

```dart
await browser.newBrowserCDPSession();
```

**Returns**
- Future&lt;[CDPSession]&gt;

```dart
Future<CDPSession> newBrowserCDPSession()
```

### `startTracing`

*⚙️ Method*

**NOTE**
This API controls [Chromium Tracing] which is a low-level chromium-specific debugging tool. API to control [Playwright Tracing] could be found [here].
You can use [browser.startTracing()] and [browser.stopTracing()] to create a trace file that can be opened in Chrome DevTools performance panel.

**Usage**

```dart
await browser.startTracing(page, { path: 'trace.json' );
await page.goto('https://www.google.com');
await browser.stopTracing();
```

**Arguments**
- `page` Page *(optional)*

Optional, if specified, tracing includes screenshots of the given page.
- `options` Map *(optional)*
- `categories` List&lt;String&gt; *(optional)*

specify custom categories to use instead of default.
- `path` String *(optional)*

A path to write the trace file to.
- `screenshots` bool *(optional)*

captures screenshots in the trace.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> startTracing(
```

### `stopTracing`

*⚙️ Method*

**NOTE**
This API controls [Chromium Tracing] which is a low-level chromium-specific debugging tool. API to control [Playwright Tracing] could be found [here].
Returns the buffer with trace data.

**Usage**

```dart
await browser.stopTracing();
```

**Returns**
- Future&lt;List&lt;int&gt;&gt;

```dart
Future<List<int>> stopTracing()
```

### `newPage`

*⚙️ Method*

Creates a new page in a new browser context. Closing this page will close the context as well.

This is a convenience API that should only be used for the single-page scenarios and short snippets. Production code and testing frameworks should explicitly create [browser.newContext()] followed by the [browserContext.newPage()] to control their exact life times.

**Usage**

```dart
await browser.newPage();
await browser.newPage(options);
```

**Arguments**
- `options` Map *(optional)*
- `acceptDownloads` bool *(optional)*

Whether to automatically download all the attachments. Defaults to `true` where all the downloads are accepted.
- `baseURL` String *(optional)*

When using [page.goto()], [page.route()], [page.waitForURL()], [page.waitForRequest()], or [page.waitForResponse()] it takes the base URL in consideration by using the [`URL()`] constructor for building the corresponding URL. Unset by default. Examples:
* baseURL: `http://localhost:3000` and navigating to `/bar.html` results in `http://localhost:3000/bar.html`
* baseURL: `http://localhost:3000/foo/` and navigating to `./bar.html` results in `http://localhost:3000/foo/bar.html`
* baseURL: `http://localhost:3000/foo` (without trailing slash) and navigating to `./bar.html` results in `http://localhost:3000/bar.html`
- `bypassCSP` bool *(optional)*

Toggles bypassing page's Content-Security-Policy. Defaults to `false`.
- `clientCertificates` List&lt;Map&gt; *(optional)*
- `origin` String

Exact origin that the certificate is valid for. Origin includes `https` protocol, a hostname and optionally a port.
- `certPath` String *(optional)*

Path to the file with the certificate in PEM format.
- `cert` List&lt;int&gt; *(optional)*

Direct value of the certificate in PEM format.
- `keyPath` String *(optional)*

Path to the file with the private key in PEM format.
- `key` List&lt;int&gt; *(optional)*

Direct value of the private key in PEM format.
- `pfxPath` String *(optional)*

Path to the PFX or PKCS12 encoded private key and certificate chain.
- `pfx` List&lt;int&gt; *(optional)*

Direct value of the PFX or PKCS12 encoded private key and certificate chain.
- `passphrase` String *(optional)*

Passphrase for the private key (PEM or PFX).

TLS Client Authentication allows the server to request a client certificate and verify it.

**Details**

An array of client certificates to be used. Each certificate object must have either both `certPath` and `keyPath`, a single `pfxPath`, or their corresponding direct value equivalents (`cert` and `key`, or `pfx`). Optionally, `passphrase` property should be provided if the certificate is encrypted. The `origin` property should be provided with an exact match to the request origin that the certificate is valid for.

Client certificate authentication is only active when at least one client certificate is provided. If you want to reject all client certificates sent by the server, you need to provide a client certificate with an `origin` that does not match any of the domains you plan to visit.

**NOTE**
When using WebKit on macOS, accessing `localhost` will not pick up client certificates. You can make it work by replacing `localhost` with `local.playwright`.
- `colorScheme` null | "light" | "dark" | "no-preference" *(optional)*

Emulates [prefers-colors-scheme] media feature, supported values are `'light'` and `'dark'`. See [page.emulateMedia()] for more details. Passing `null` resets emulation to system defaults. Defaults to `'light'`.
- `contrast` null | "no-preference" | "more" *(optional)*

Emulates `'prefers-contrast'` media feature, supported values are `'no-preference'`, `'more'`. See [page.emulateMedia()] for more details. Passing `null` resets emulation to system defaults. Defaults to `'no-preference'`.
- `deviceScaleFactor` num *(optional)*

Specify device scale factor (can be thought of as dpr). Defaults to `1`. Learn more about [emulating devices with device scale factor].
- `extraHTTPHeaders` Map&lt;String, String&gt; *(optional)*

An object containing additional HTTP headers to be sent with every request. Defaults to none.
- `forcedColors` null | "active" | "none" *(optional)*

Emulates `'forced-colors'` media feature, supported values are `'active'`, `'none'`. See [page.emulateMedia()] for more details. Passing `null` resets emulation to system defaults. Defaults to `'none'`.
- `geolocation` Map *(optional)*
- `latitude` num

Latitude between -90 and 90.
- `longitude` num

Longitude between -180 and 180.
- `accuracy` num *(optional)*

Non-negative accuracy value. Defaults to `0`.
- `hasTouch` bool *(optional)*

Specifies if viewport supports touch events. Defaults to false. Learn more about [mobile emulation].
- `httpCredentials` Map *(optional)*
- `username` String


- `password` String


- `origin` String *(optional)*

Restrain sending http credentials on specific origin (scheme://host:port).
- `send` "unauthorized" | "always" *(optional)*

This option only applies to the requests sent from corresponding [APIRequestContext] and does not affect requests sent from the browser. `'always'` - `Authorization` header with basic authentication credentials will be sent with the each API request. `'unauthorized` - the credentials are only sent when 401 (Unauthorized) response with `WWW-Authenticate` header is received. Defaults to `'unauthorized'`.

Credentials for [HTTP authentication]. If no origin is specified, the username and password are sent to any servers upon unauthorized responses.
- `ignoreHTTPSErrors` bool *(optional)*

Whether to ignore HTTPS errors when sending network requests. Defaults to `false`.
- `isMobile` bool *(optional)*

Whether the `meta viewport` tag is taken into account and touch events are enabled. isMobile is a part of device, so you don't actually need to set it manually. Defaults to `false` and is not supported in Firefox. Learn more about [mobile emulation].
- `javaScriptEnabled` bool *(optional)*

Whether or not to enable JavaScript in the context. Defaults to `true`. Learn more about [disabling JavaScript].
- `locale` String *(optional)*

Specify user locale, for example `en-GB`, `de-DE`, etc. Locale will affect `navigator.language` value, `Accept-Language` request header value as well as number and date formatting rules. Defaults to the system default locale. Learn more about emulation in our [emulation guide].
- `logger` [Logger] *(optional)*

**WARNING**
[Deprecated]
The logs received by the logger are incomplete. Please use tracing instead.
Logger sink for Playwright logging.
- `offline` bool *(optional)*

Whether to emulate network being offline. Defaults to `false`. Learn more about [network emulation].
- `permissions` List&lt;String&gt; *(optional)*

A list of permissions to grant to all pages in this context. See [browserContext.grantPermissions()] for more details. Defaults to none.
- `proxy` Map *(optional)*
- `server` String

Proxy to be used for all requests. HTTP and SOCKS proxies are supported, for example `http://myproxy.com:3128` or `socks5://myproxy.com:3128`. Short form `myproxy.com:3128` is considered an HTTP proxy.
- `bypass` String *(optional)*

Optional comma-separated domains to bypass proxy, for example `".com, chromium.org, .domain.com"`.
- `username` String *(optional)*

Optional username to use if HTTP proxy requires authentication.
- `password` String *(optional)*

Optional password to use if HTTP proxy requires authentication.

Network proxy settings to use with this context. Defaults to none.
- `recordHar` Map *(optional)*
- `omitContent` bool *(optional)*

Optional setting to control whether to omit request content from the HAR. Defaults to `false`. Deprecated, use `content` policy instead.
- `content` "omit" | "embed" | "attach" *(optional)*

Optional setting to control resource content management. If `omit` is specified, content is not persisted. If `attach` is specified, resources are persisted as separate files or entries in the ZIP archive. If `embed` is specified, content is stored inline the HAR file as per HAR specification. Defaults to `attach` for `.zip` output files and to `embed` for all other file extensions.
- `path` String

Path on the filesystem to write the HAR file to. If the file name ends with `.zip`, `content: 'attach'` is used by default.
- `mode` "full" | "minimal" *(optional)*

When set to `minimal`, only record information necessary for routing from HAR. This omits sizes, timing, page, cookies, security and other types of HAR information that are not used when replaying from HAR. Defaults to `full`.
- `urlFilter` String | [RegExp] *(optional)*

A glob or regex pattern to filter requests that are stored in the HAR. When a [baseURL] via the context options was provided and the passed URL is a path, it gets merged via the [`new URL()`] constructor. Defaults to none.

Enables [HAR] recording for all pages into `recordHar.path` file. If not specified, the HAR is not recorded. Make sure to await [browserContext.close()] for the HAR to be saved.
- `recordVideo` Map *(optional)*
- `dir` String *(optional)*

Path to the directory to put videos into. If not specified, the videos will be stored in `artifactsDir` (see [browserType.launch()] options).
- `size` Map *(optional)*
- `width` num

Video frame width.
- `height` num

Video frame height.

Optional dimensions of the recorded videos. If not specified the size will be equal to `viewport` scaled down to fit into 800x800. If `viewport` is not configured explicitly the video size defaults to 800x450. Actual picture of each page will be scaled down if necessary to fit the specified size.
- `showActions` Map *(optional)*
- `duration` num *(optional)*

How long each annotation is displayed in milliseconds. Defaults to `500`.
- `position` "top-left" | "top" | "top-right" | "bottom-left" | "bottom" | "bottom-right" *(optional)*

Position of the action title overlay. Defaults to `"top-right"`.
- `fontSize` num *(optional)*

Font size of the action title in pixels. Defaults to `24`.

If specified, enables visual annotations on interacted elements during video recording.

Enables video recording for all pages into `recordVideo.dir` directory. If not specified videos are not recorded. Make sure to await [browserContext.close()] for videos to be saved.
- `reducedMotion` null | "reduce" | "no-preference" *(optional)*

Emulates `'prefers-reduced-motion'` media feature, supported values are `'reduce'`, `'no-preference'`. See [page.emulateMedia()] for more details. Passing `null` resets emulation to system defaults. Defaults to `'no-preference'`.
- `screen` Map *(optional)*
- `width` num

page width in pixels.
- `height` num

page height in pixels.

Emulates consistent window screen size available inside web page via `window.screen`. Is only used when the [viewport] is set.
- `serviceWorkers` "allow" | "block" *(optional)*

Whether to allow sites to register Service workers. Defaults to `'allow'`.
* `'allow'`: [Service Workers] can be registered.
* `'block'`: Playwright will block all registration of Service Workers.
- `storageState` String | Map *(optional)*
- `cookies` List&lt;Map&gt;
- `name` String


- `value` String


- `domain` String

Domain and path are required. For the cookie to apply to all subdomains as well, prefix domain with a dot, like this: ".example.com"
- `path` String

Domain and path are required
- `expires` num

Unix time in seconds.
- `httpOnly` bool


- `secure` bool


- `sameSite` "Strict" | "Lax" | "None"

sameSite flag

Cookies to set for context
- `origins` List&lt;Map&gt;
- `origin` String


- `localStorage` List&lt;Map&gt;
- `name` String


- `value` String


localStorage to set for context


Learn more about [storage state and auth].

Populates context with given storage state. This option can be used to initialize context with logged-in information obtained via [browserContext.storageState()].
- `strictSelectors` bool *(optional)*

If set to true, enables strict selectors mode for this context. In the strict selectors mode all operations on selectors that imply single target DOM element will throw when more than one element matches the selector. This option does not affect any Locator APIs (Locators are always strict). Defaults to `false`. See [Locator] to learn more about the strict mode.
- `timezoneId` String *(optional)*

Changes the timezone of the context. See [ICU's metaZones.txt] for a list of supported timezone IDs. Defaults to the system timezone.
- `userAgent` String *(optional)*

Specific user agent to use in this context.
- `viewport` [Map]? *(optional)*
- `width` num

page width in pixels.
- `height` num

page height in pixels.

Emulates consistent viewport for each page. Defaults to an 1280x720 viewport. Use `null` to disable the consistent viewport emulation. Learn more about [viewport emulation].

**NOTE**
The `null` value opts out from the default presets, makes viewport depend on the host window size defined by the operating system. It makes the execution of the tests non-deterministic.
**Returns**
- Future&lt;[Page]&gt;

```dart
Future<Page> newPage()
```

## `BrowserContext`

```dart
abstract interface class BrowserContext
```

### `browser`

*📦 Property*

Gets the browser instance that owns the context. Returns `null` if the context is created outside of normal browser, e.g. Android or Electron.

**Usage**

```dart
browserContext.browser;
```

**Returns**
- [Browser]?

```dart
Browser? get browser
```

### `tracing`

*📦 Property*

**Usage**

```dart
browserContext.tracing
```

**Type**
- [Tracing]

```dart
Tracing get tracing
```

### `request`

*📦 Property*

API testing helper associated with this context. Requests made with this API will use context cookies.

**Usage**

```dart
browserContext.request
```

**Type**
- [APIRequestContext]

```dart
APIRequestContext get request
```

### `clock`

*📦 Property*

Playwright has ability to mock clock and passage of time.

**Usage**

```dart
browserContext.clock
```

**Type**
- [Clock]

```dart
Clock get clock
```

### `onRecorderEvent`

*📦 Property*

Stream that emits recorder events.

```dart
Stream<Map<String, dynamic>> get onRecorderEvent
```

### `onResponse`

*📦 Property*

Stream that emits when a response is received.

```dart
Stream<Map<String, dynamic>> get onResponse
```

### `onRequestFinished`

*📦 Property*

Stream that emits when a request finishes.

```dart
Stream<Map<String, dynamic>> get onRequestFinished
```

### `onRequestFailed`

*📦 Property*

Stream that emits when a request fails.

```dart
Stream<Map<String, dynamic>> get onRequestFailed
```

### `onRequest`

*📦 Property*

Stream that emits when a request is made.

```dart
Stream<Map<String, dynamic>> get onRequest
```

### `onServiceWorker`

*📦 Property*

Stream that emits when a service worker is created.

```dart
Stream<Worker> get onServiceWorker
```

### `onWebSocketRoute`

*📦 Property*

Stream that emits when a WebSocket route is created.

```dart
Stream<WebSocketRoute> get onWebSocketRoute
```

### `onRoute`

*📦 Property*

Stream that emits when a route is created.

```dart
Stream<Route> get onRoute
```

### `onPageError`

*📦 Property*

Stream that emits when a page error occurs.

```dart
Stream<Map<String, dynamic>> get onPageError
```

### `onPage`

*📦 Property*

Stream that emits when a new page is created.

```dart
Stream<Page> get onPage
```

### `onDialog`

*📦 Property*

Stream that emits when a dialog is shown.

```dart
Stream<Dialog> get onDialog
```

### `onClose`

*📦 Property*

Stream that emits when the context is closed.

```dart
Stream<BrowserContext> get onClose
```

### `onConsole`

*📦 Property*

Stream that emits when a console message is logged.

```dart
Stream<Map<String, dynamic>> get onConsole
```

### `onBindingCall`

*📦 Property*

Stream that emits when a binding call is made.

```dart
Stream<BindingCall> get onBindingCall
```

### `pages`

*📦 Property*

Returns all open pages in the context.

**Usage**

```dart
browserContext.pages;
```

**Returns**
- List&lt;[Page]&gt;

```dart
List<Page> get pages
```

### `newPage`

*⚙️ Method*

Creates a new page in the browser context.

**Usage**

```dart
await browserContext.newPage();
```

**Returns**
- Future&lt;[Page]&gt;

```dart
Future<Page> newPage()
```

### `addCookies`

*⚙️ Method*

Adds cookies into this browser context. All pages within this context will have these cookies installed. Cookies can be obtained via [browserContext.cookies()].

**Usage**

```dart
await browserContext.addCookies([cookieObject1, cookieObject2]);
```

**Arguments**
- `cookies` List&lt;SetNetworkCookie&gt;
- `name` String


- `value` String


- `url` String *(optional)*

Either `url` or both `domain` and `path` are required. Optional.
- `domain` String *(optional)*

For the cookie to apply to all subdomains as well, prefix domain with a dot, like this: ".example.com". Either `url` or both `domain` and `path` are required. Optional.
- `path` String *(optional)*

Either `url` or both `domain` and `path` are required. Optional.
- `expires` num *(optional)*

Unix time in seconds. Optional.
- `httpOnly` bool *(optional)*

Optional.
- `secure` bool *(optional)*

Optional.
- `sameSite` "Strict" | "Lax" | "None" *(optional)*

Optional.
- `partitionKey` String *(optional)*

For partitioned third-party cookies (aka [CHIPS]), the partition key. Optional.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> addCookies(List<SetNetworkCookie> cookies)
```

### `clearCookies`

*⚙️ Method*

Removes cookies from context. Accepts optional filter.

**Usage**

```dart
await context.clearCookies();
await context.clearCookies( name: 'session-id' );
await context.clearCookies( domain: 'my-origin.com' );
await context.clearCookies( domain: /.*my-origin\.com/ );
await context.clearCookies( path: '/api/v1' );
await context.clearCookies( name: 'session-id', domain: 'my-origin.com' );
```

**Arguments**
- `options` Map *(optional)*
- `domain` String *(optional)*

Only removes cookies with the given domain.
- `name` String *(optional)*

Only removes cookies with the given name.
- `path` String *(optional)*

Only removes cookies with the given path.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> clearCookies(
```

### `cookies`

*⚙️ Method*

If no URLs are specified, this method returns all cookies. If URLs are specified, only cookies that affect those URLs are returned.

**Usage**

```dart
await browserContext.cookies();
await browserContext.cookies(urls);
```

**Arguments**
- `urls` List&lt;String&gt; *(optional)*

Optional list of URLs.

**Returns**
- Future&lt;List&lt;Map&gt;&gt;
- `name` String


- `value` String


- `domain` String


- `path` String


- `expires` num

Unix time in seconds.
- `httpOnly` bool


- `secure` bool


- `sameSite` "Strict" | "Lax" | "None"


- `partitionKey` String *(optional)*

```dart
Future<List<NetworkCookie>> cookies(
```

### `grantPermissions`

*⚙️ Method*

Grants specified permissions to the browser context. Only grants corresponding permissions to the given origin if specified.

**Usage**

```dart
await browserContext.grantPermissions(permissions);
await browserContext.grantPermissions(permissions, options);
```

**Arguments**
- `permissions` List&lt;String&gt;

A list of permissions to grant.

**DANGER**
Supported permissions differ between browsers, and even between different versions of the same browser. Any permission may stop working after an update.
Here are some permissions that may be supported by some browsers:
* `'accelerometer'`
* `'ambient-light-sensor'`
* `'background-sync'`
* `'camera'`
* `'clipboard-read'`
* `'clipboard-write'`
* `'geolocation'`
* `'gyroscope'`
* `'local-fonts'`
* `'local-network-access'`
* `'magnetometer'`
* `'microphone'`
* `'midi-sysex'` (system-exclusive midi)
* `'midi'`
* `'notifications'`
* `'payment-handler'`
* `'storage-access'`
* `'screen-wake-lock'`
- `options` Map *(optional)*
- `origin` String *(optional)*

The [origin] to grant permissions to, e.g. "https://example.com".

**Returns**
- Future&lt;void&gt;

```dart
Future<void> grantPermissions( List<BrowserPermission> permissions,
```

### `setExtraHTTPHeaders`

*⚙️ Method*

The extra HTTP headers will be sent with every request initiated by any page in the context. These headers are merged with page-specific extra HTTP headers set with [page.setExtraHTTPHeaders()]. If page overrides a particular header, page-specific header value will be used instead of the browser context header value.

**NOTE**
[browserContext.setExtraHTTPHeaders()] does not guarantee the order of headers in the outgoing requests.
**Usage**

```dart
await browserContext.setExtraHTTPHeaders(headers);
```

**Arguments**
- `headers` List&lt;NameValue&gt;

An object containing additional HTTP headers to be sent with every request. All header values must be strings.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> setExtraHTTPHeaders(List<NameValue> headers)
```

### `clearPermissions`

*⚙️ Method*

Clears all permission overrides for the browser context.

**Usage**

```dart
final context = await browser.newContext();
await context.grantPermissions(['clipboard-read']);
// do stuff ..
context.clearPermissions();
```

**Returns**
- Future&lt;void&gt;

```dart
Future<void> clearPermissions()
```

### `setGeolocation`

*⚙️ Method*

Sets the context's geolocation. Passing `null` or `undefined` emulates position unavailable.

**Usage**

```dart
await browserContext.setGeolocation( latitude: 59.95, longitude: 30.31667 );
```

**NOTE**
Consider using [browserContext.grantPermissions()] to grant permissions for the browser context pages to read its geolocation.
**Arguments**
- `geolocation` BrowserContextSetGeolocation
- `latitude` num

Latitude between -90 and 90.
- `longitude` num

Longitude between -180 and 180.
- `accuracy` num *(optional)*

Non-negative accuracy value. Defaults to `0`.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> setGeolocation( BrowserContextSetGeolocation? geolocation, )
```

### `setHTTPCredentials`

*⚙️ Method*

**WARNING**
[Deprecated]

Browsers may cache credentials after successful authentication. Create a new browser context instead.

**Usage**

```dart
await browserContext.setHTTPCredentials(httpCredentials);
```

**Arguments**
- `httpCredentials` BrowserContextSetHTTPCredentialsHttpCredentials
- `username` String


- `password` String


**Returns**
- Future&lt;void&gt;


[APIRequest]: /api/class-apirequest.mdx "APIRequest"
[APIRequestContext]: /api/class-apirequestcontext.mdx "APIRequestContext"
[APIResponse]: /api/class-apiresponse.mdx "APIResponse"
[APIResponseAssertions]: /api/class-apiresponseassertions.mdx "APIResponseAssertions"
[Browser]: /api/class-browser.mdx "Browser"
[BrowserContext]: /api/class-browsercontext.mdx "BrowserContext"
[BrowserServer]: /api/class-browserserver.mdx "BrowserServer"
[BrowserType]: /api/class-browsertype.mdx "BrowserType"
[CDPSession]: /api/class-cdpsession.mdx "CDPSession"
[Clock]: /api/class-clock.mdx "Clock"
[ConsoleMessage]: /api/class-consolemessage.mdx "ConsoleMessage"
[Coverage]: /api/class-coverage.mdx "Coverage"
[Credentials]: /api/class-credentials.mdx "Credentials"
[Debugger]: /api/class-debugger.mdx "Debugger"
[Dialog]: /api/class-dialog.mdx "Dialog"
[Disposable]: /api/class-disposable.mdx "Disposable"
[Download]: /api/class-download.mdx "Download"
[ElementHandle]: /api/class-elementhandle.mdx "ElementHandle"
[FileChooser]: /api/class-filechooser.mdx "FileChooser"
[Frame]: /api/class-frame.mdx "Frame"
[FrameLocator]: /api/class-framelocator.mdx "FrameLocator"
[GenericAssertions]: /api/class-genericassertions.mdx "GenericAssertions"
[JSHandle]: /api/class-jshandle.mdx "JSHandle"
[Keyboard]: /api/class-keyboard.mdx "Keyboard"
[Locator]: /api/class-locator.mdx "Locator"
[LocatorAssertions]: /api/class-locatorassertions.mdx "LocatorAssertions"
[Logger]: /api/class-logger.mdx "Logger"
[Mouse]: /api/class-mouse.mdx "Mouse"
[Page]: /api/class-page.mdx "Page"
[PageAssertions]: /api/class-pageassertions.mdx "PageAssertions"
[Playwright]: /api/class-playwright.mdx "Playwright"
[PlaywrightAssertions]: /api/class-playwrightassertions.mdx "PlaywrightAssertions"
[Request]: /api/class-request.mdx "Request"
[Response]: /api/class-response.mdx "Response"
[Route]: /api/class-route.mdx "Route"
[Screencast]: /api/class-screencast.mdx "Screencast"
[Selectors]: /api/class-selectors.mdx "Selectors"
[SnapshotAssertions]: /api/class-snapshotassertions.mdx "SnapshotAssertions"
[TimeoutError]: /api/class-timeouterror.mdx "TimeoutError"
[Touchscreen]: /api/class-touchscreen.mdx "Touchscreen"
[Tracing]: /api/class-tracing.mdx "Tracing"
[Video]: /api/class-video.mdx "Video"
[WebError]: /api/class-weberror.mdx "WebError"
[WebSocket]: /api/class-websocket.mdx "WebSocket"
[WebSocketRoute]: /api/class-websocketroute.mdx "WebSocketRoute"
[WebStorage]: /api/class-webstorage.mdx "WebStorage"
[Worker]: /api/class-worker.mdx "Worker"
[Electron]: /api/class-electron.mdx "Electron"
[ElectronApplication]: /api/class-electronapplication.mdx "ElectronApplication"
[Android]: /api/class-android.mdx "Android"
[AndroidDevice]: /api/class-androiddevice.mdx "AndroidDevice"
[AndroidInput]: /api/class-androidinput.mdx "AndroidInput"
[AndroidSocket]: /api/class-androidsocket.mdx "AndroidSocket"
[AndroidWebView]: /api/class-androidwebview.mdx "AndroidWebView"
[Fixtures]: /api/class-fixtures.mdx "Fixtures"
[FullConfig]: /api/class-fullconfig.mdx "FullConfig"
[FullProject]: /api/class-fullproject.mdx "FullProject"
[Location]: /api/class-location.mdx "Location"
[Test]: /api/class-test.mdx "Test"
[TestConfig]: /api/class-testconfig.mdx "TestConfig"
[TestInfo]: /api/class-testinfo.mdx "TestInfo"
[TestInfoError]: /api/class-testinfoerror.mdx "TestInfoError"
[TestOptions]: /api/class-testoptions.mdx "TestOptions"
[TestProject]: /api/class-testproject.mdx "TestProject"
[TestStepInfo]: /api/class-teststepinfo.mdx "TestStepInfo"
[WorkerInfo]: /api/class-workerinfo.mdx "WorkerInfo"
[Reporter]: /api/class-reporter.mdx "Reporter"
[Suite]: /api/class-suite.mdx "Suite"
[TestCase]: /api/class-testcase.mdx "TestCase"
[TestError]: /api/class-testerror.mdx "TestError"
[TestResult]: /api/class-testresult.mdx "TestResult"
[TestStep]: /api/class-teststep.mdx "TestStep"
[EvaluationArgument]: /evaluating.mdx#evaluation-argument "EvaluationArgument"
[UIEvent.detail]: https://developer.mozilla.org/en-US/docs/Web/API/UIEvent/detail "UIEvent.detail"


[all available image tags]: https://mcr.microsoft.com/en-us/product/playwright/about "all available image tags"
[Microsoft Artifact Registry]: https://mcr.microsoft.com/en-us/product/playwright/about "Microsoft Artifact Registry"
[Dockerfile.noble]: https://github.com/microsoft/playwright/blob/main/utils/docker/Dockerfile.noble "Dockerfile.noble"

```dart
Future<void> setHTTPCredentials( BrowserContextSetHTTPCredentialsHttpCredentials? httpCredentials, )
```

### `setOffline`

*⚙️ Method*

**Usage**

```dart
await browserContext.setOffline(offline);
```

**Arguments**
- `offline` bool

Whether to emulate network being offline for the browser context.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> setOffline(bool offline)
```

### `storageState`

*⚙️ Method*

Returns storage state for this browser context, contains current cookies, local storage snapshot and IndexedDB snapshot.

**Usage**

```dart
await browserContext.storageState();
await browserContext.storageState(options);
```

**Arguments**
- `options` Map *(optional)*
- `indexedDB` bool *(optional)*

Set to `true` to include [IndexedDB] in the storage state snapshot. If your application uses IndexedDB to store authentication tokens, like Firebase Authentication, enable this.
- `path` String *(optional)*

The file path to save the storage state to. If [path] is a relative path, then it is resolved relative to current working directory. If no path is provided, storage state is still returned, but won't be saved to the disk.

**Returns**
- Future&lt;Map&gt;
- `cookies` List&lt;Map&gt;
- `name` String


- `value` String


- `domain` String


- `path` String


- `expires` num

Unix time in seconds.
- `httpOnly` bool


- `secure` bool


- `sameSite` "Strict" | "Lax" | "None"



- `origins` List&lt;Map&gt;
- `origin` String


- `localStorage` List&lt;Map&gt;
- `name` String


- `value` String

```dart
Future<BrowserContextStorageStateResult> storageState(
```

### `setStorageState`

*⚙️ Method*

Clears the existing cookies, local storage and IndexedDB entries for all origins and sets the new storage state.

**Usage**

```dart
// Load storage state from a file and apply it to the context.
await context.setStorageState('state.json');
```

**Arguments**
- `storageState` BrowserContextSetStorageState
- `cookies` List&lt;Map&gt;
- `name` String


- `value` String


- `domain` String

Domain and path are required. For the cookie to apply to all subdomains as well, prefix domain with a dot, like this: ".example.com"
- `path` String

Domain and path are required
- `expires` num

Unix time in seconds.
- `httpOnly` bool


- `secure` bool


- `sameSite` "Strict" | "Lax" | "None"

sameSite flag

Cookies to set for context
- `origins` List&lt;Map&gt;
- `origin` String


- `localStorage` List&lt;Map&gt;
- `name` String


- `value` String


localStorage to set for context


Learn more about [storage state and auth].

Populates context with given storage state. This option can be used to initialize context with logged-in information obtained via [browserContext.storageState()].

**Returns**
- Future&lt;void&gt;

```dart
Future<void> setStorageState( BrowserContextSetStorageState storageState, )
```

### `addInitScript`

*⚙️ Method*

Adds a script which would be evaluated in one of the following scenarios:
* Whenever a page is created in the browser context or is navigated.
* Whenever a child frame is attached or navigated in any page in the browser context. In this case, the script is evaluated in the context of the newly attached frame.

The script is evaluated after the document was created but before any of its scripts were run. This is useful to amend the JavaScript environment, e.g. to seed `Math.random`.

**Usage**

An example of overriding `Math.random` before the page loads:

```dart
// preload.js
Math.random = () => 42;
```

```dart
// In your playwright script, assuming the preload.js file is in same directory.
await browserContext.addInitScript(
path: 'preload.js'
);
```

**NOTE**
The order of evaluation of multiple scripts installed via [browserContext.addInitScript()] and [page.addInitScript()] is not defined.
**Arguments**
- `script` Function | String | Map
- `path` String *(optional)*

Path to the JavaScript file. If `path` is a relative path, then it is resolved relative to the current working directory. Optional.
- `content` String *(optional)*

Raw script content. Optional.

Script to be evaluated in all pages in the browser context.
- `arg` [Serializable] *(optional)*

Optional argument to pass to [script] (only supported when passing a function).

**Returns**
- Future&lt;[Disposable]&gt;

```dart
Future<void> addInitScript(String source)
```

### `isClosed`

*📦 Property*

Indicates that the browser context is in the process of closing or has already been closed.

**Usage**

```dart
browserContext.isClosed;
```

**Returns**
- bool

```dart
bool get isClosed
```

### `backgroundPages`

*📦 Property*

**WARNING**
[Deprecated]

Background pages have been removed from Chromium together with Manifest V2 extensions.

Returns an empty list.

**Usage**

```dart
browserContext.backgroundPages;
```

**Returns**
- List&lt;[Page]&gt;

```dart
List<Page> get backgroundPages
```

### `serviceWorkers`

*📦 Property*

**NOTE**
Service workers are only supported on Chromium-based browsers.
All existing service workers in the context.

**Usage**

```dart
browserContext.serviceWorkers;
```

**Returns**
- List&lt;[Worker]&gt;

```dart
List<Worker> get serviceWorkers
```

### `setDefaultTimeout`

*⚙️ Method*

This setting will change the default maximum time for all the methods accepting [timeout] option.

**NOTE**
[page.setDefaultNavigationTimeout()], [page.setDefaultTimeout()] and [browserContext.setDefaultNavigationTimeout()] take priority over [browserContext.setDefaultTimeout()].
**Usage**

```dart
browserContext.setDefaultTimeout(timeout);
```

**Arguments**
- `timeout` double

Maximum time in milliseconds. Pass `0` to disable timeout.

```dart
void setDefaultTimeout(double timeout)
```

### `setDefaultNavigationTimeout`

*⚙️ Method*

This setting will change the default maximum navigation time for the following methods and related shortcuts:
* [page.goBack()]
* [page.goForward()]
* [page.goto()]
* [page.reload()]
* [page.setContent()]
* [page.waitForNavigation()]

**NOTE**
[page.setDefaultNavigationTimeout()] and [page.setDefaultTimeout()] take priority over [browserContext.setDefaultNavigationTimeout()].
**Usage**

```dart
browserContext.setDefaultNavigationTimeout(timeout);
```

**Arguments**
- `timeout` double

Maximum navigation time in milliseconds

```dart
void setDefaultNavigationTimeout(double timeout)
```

### `close`

*⚙️ Method*

Closes the browser context. All the pages that belong to the browser context will be closed.

**NOTE**
The default browser context cannot be closed.
**Usage**

```dart
await browserContext.close();
await browserContext.close(options);
```

**Arguments**
- `options` Map *(optional)*
- `reason` String *(optional)*

The reason to be reported to the operations interrupted by the context closure.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> close(
```

### `setNetworkInterceptionPatterns`

*⚙️ Method*

Sets network interception patterns for this context.

```dart
Future<void> setNetworkInterceptionPatterns( List<BrowserContextSetNetworkInterceptionPatternsItems> patterns, )
```

### `pause`

*⚙️ Method*

Pauses the context for debugging.

```dart
Future<void> pause()
```

### `clockFastForward`

*⚙️ Method*

Fast forwards the clock.

```dart
Future<void> clockFastForward(
```

### `clockInstall`

*⚙️ Method*

Installs the clock.

```dart
Future<void> clockInstall(
```

### `clockPauseAt`

*⚙️ Method*

Pauses the clock at a specific time.

```dart
Future<void> clockPauseAt(
```

### `clockResume`

*⚙️ Method*

Resumes the clock.

```dart
Future<void> clockResume()
```

### `clockRunFor`

*⚙️ Method*

Runs the clock for a specific duration.

```dart
Future<void> clockRunFor(
```

### `clockSetFixedTime`

*⚙️ Method*

Sets a fixed time for the clock.

```dart
Future<void> clockSetFixedTime(
```

### `clockSetSystemTime`

*⚙️ Method*

Sets the system time for the clock.

```dart
Future<void> clockSetSystemTime(
```

### `exposeBinding`

*⚙️ Method*

The method adds a function called [name] on the `window` object of every frame in every page in the context. When called, the function executes [callback] and returns a Future which resolves to the return value of [callback]. If the [callback] returns a Future, it will be awaited.

The first argument of the [callback] function contains information about the caller: `{ browserContext: BrowserContext, page: Page, frame: Frame }`.

See [page.exposeBinding()] for page-only version.

**Usage**

An example of exposing page URL to all frames in all pages in the context:

```dart
// Or 'chromium' or 'firefox'.

(() async {
final browser = await webkit.launch( headless: false );
final context = await browser.newContext();
await context.exposeBinding('pageURL', ( page ) => page.url());
final page = await context.newPage();
await page.setContent(`
<script>
async function onClick() {
document.querySelector('div').textContent = await window.pageURL();
}
</script>
<button onclick="onClick()">Click me</button>
<div></div>
`);
await page.getByRole('button').click();
}
```

**Arguments**
- `name` String

Name of the function on the window object.
- `callback` Function

Callback function that will be called in the Playwright's context.

**Returns**
- Future&lt;[Disposable]&gt;

```dart
Future<void> exposeBinding(String name)
```

### `exposeFunction`

*⚙️ Method*

The method adds a function called [name] on the `window` object of every frame in every page in the context. When called, the function executes [callback] and returns a Future which resolves to the return value of [callback].

If the [callback] returns a Future, it will be awaited.

See [page.exposeFunction()] for page-only version.

**Usage**

An example of adding a `sha256` function to all pages in the context:

```dart
// Or 'chromium' or 'firefox'.

(() async {
final browser = await webkit.launch( headless: false );
final context = await browser.newContext();
await context.exposeFunction('sha256', (text) =>
crypto.createHash('sha256').update(text).digest('hex'),
);
final page = await context.newPage();
await page.setContent(`
<script>
async function onClick() {
document.querySelector('div').textContent = await window.sha256('PLAYWRIGHT');
}
</script>
<button onclick="onClick()">Click me</button>
<div></div>
`);
await page.getByRole('button').click();
}
```

**Arguments**
- `name` String

Name of the function on the window object.
- `callback` Function

Callback function that will be called in the Playwright's context.

**Returns**
- Future&lt;[Disposable]&gt;

```dart
Future<void> exposeFunction(String name)
```

### `registerSelectorEngine`

*⚙️ Method*

Registers a custom selector engine.

```dart
Future<void> registerSelectorEngine( String name, String source,
```

### `setTestIdAttributeName`

*⚙️ Method*

Sets the test ID attribute name.

```dart
Future<void> setTestIdAttributeName(String testIdAttributeName)
```

### `setWebSocketInterceptionPatterns`

*⚙️ Method*

Sets WebSocket interception patterns.

```dart
Future<void> setWebSocketInterceptionPatterns( List<BrowserContextSetWebSocketInterceptionPatternsItems> patterns, )
```

### `enableRecorder`

*⚙️ Method*

Enables the recorder.

```dart
Future<void> enableRecorder(
```

### `disableRecorder`

*⚙️ Method*

Disables the recorder.

```dart
Future<void> disableRecorder()
```

### `exposeConsoleApi`

*⚙️ Method*

Exposes the console API to the page.

```dart
Future<void> exposeConsoleApi()
```

### `newCDPSession`

*⚙️ Method*

**NOTE**
CDP sessions are only supported on Chromium-based browsers.
Returns the newly created session.

**Usage**

```dart
await browserContext.newCDPSession(page);
```

**Arguments**
- `page` Page

Target to create new session for. For backwards-compatibility, this parameter is named `page`, but it can be a `Page` or `Frame` type.

**Returns**
- Future&lt;[CDPSession]&gt;

```dart
Future<CDPSession> newCDPSession(
```

### `createTempFiles`

*⚙️ Method*

Creates temporary files.

```dart
Future<BrowserContextCreateTempFilesResult> createTempFiles(
```

### `updateSubscription`

*⚙️ Method*

Updates the subscription for events.

```dart
Future<void> updateSubscription(
```

### `route`

*⚙️ Method*

Routing provides the capability to modify network requests that are made by any page in the browser context. Once route is enabled, every request matching the url pattern will stall unless it's continued, fulfilled or aborted.

**NOTE**
[browserContext.route()] will not intercept requests intercepted by Service Worker. See [this] issue. We recommend disabling Service Workers when using request interception by setting [serviceWorkers] to `'block'`.
**Usage**

An example of a naive handler that aborts all image requests:

```dart
final context = await browser.newContext();
await context.route('**/*.{png,jpg,jpeg}', (route) => route.abort());
final page = await context.newPage();
await page.goto('https://example.com');
await browser.close();
```

or the same snippet using a regex pattern instead:

```dart
final context = await browser.newContext();
await context.route(/(\.png$)|(\.jpg$)/, (route) => route.abort());
final page = await context.newPage();
await page.goto('https://example.com');
await browser.close();
```

It is possible to examine the request to decide the route action. For example, mocking all requests that contain some post data, and leaving all other requests as is:

```dart
await context.route('/api/**', (route) async {
if (route.request().postData().includes('my-string'))
await route.fulfill( body: 'mocked-data' );
else
await route.continue();
);
```

Page routes (set up with [page.route()]) take precedence over browser context routes when request matches both handlers.

To remove a route with its handler you can use [browserContext.unroute()].

**NOTE**
Enabling routing disables http cache.
**Arguments**
- `url` String

A glob pattern, regex pattern, URL pattern, or predicate that receives a [URL] to match during routing. If [baseURL] is set in the context options and the provided URL is a string that does not start with `*`, it is resolved using the [`new URL()`] constructor.
- `handler` Future&lt;void&gt; Function(Route)

handler function to route the request.
- `options` Map *(optional)*
- `times` num *(optional)*

How often a route should be used. By default it will be used every time.

**Returns**
- Future&lt;[Disposable]&gt;

```dart
Future<void> route(String url, Future<void> Function(Route) handler)
```

### `unroute`

*⚙️ Method*

Removes a route created with [browserContext.route()]. When [handler] is not specified, removes all routes for the [url].

**Usage**

```dart
await browserContext.unroute(url);
await browserContext.unroute(url, handler);
```

**Arguments**
- `url` String

A glob pattern, regex pattern, URL pattern, or predicate receiving [URL] used to register a routing with [browserContext.route()].
- `handler` Future&lt;void&gt; Function(Route route) *(optional)*

Optional handler function used to register a routing with [browserContext.route()].

**Returns**
- Future&lt;void&gt;

```dart
Future<void> unroute( String url,
```

### `unrouteAll`

*⚙️ Method*

Removes all routes created with [browserContext.route()] and [browserContext.routeFromHAR()].

**Usage**

```dart
await browserContext.unrouteAll();
await browserContext.unrouteAll(options);
```

**Arguments**
- `options` Map *(optional)*
- `behavior` "wait" | "ignoreErrors" | "default" *(optional)*

Specifies whether to wait for already running handlers and what to do if they throw errors:
* `'default'` - do not wait for current handler calls (if any) to finish, if unrouted handler throws, it may result in unhandled error
* `'wait'` - wait for current handler calls (if any) to finish
* `'ignoreErrors'` - do not wait for current handler calls (if any) to finish, all errors thrown by the handlers after unrouting are silently caught

**Returns**
- Future&lt;void&gt;

```dart
Future<void> unrouteAll()
```

### `routeFromHAR`

*⚙️ Method*

If specified the network requests that are made in the context will be served from the HAR file. Read more about [Replaying from HAR].

Playwright will not serve requests intercepted by Service Worker from the HAR file. See [this] issue. We recommend disabling Service Workers when using request interception by setting [serviceWorkers] to `'block'`.

**Usage**

```dart
await browserContext.routeFromHAR(har);
await browserContext.routeFromHAR(har, options);
```

**Arguments**
- `har` String

Path to a [HAR] file with prerecorded network data. If `path` is a relative path, then it is resolved relative to the current working directory.
- `options` Map *(optional)*
- `notFound` "abort" | "fallback" *(optional)*
* If set to 'abort' any request not found in the HAR file will be aborted.
* If set to 'fallback' falls through to the next route handler in the handler chain.

Defaults to abort.
- `update` bool *(optional)*

If specified, updates the given HAR with the actual network information instead of serving from file. The file is written to disk when [browserContext.close()] is called.
- `updateContent` "embed" | "attach" *(optional)*

Optional setting to control resource content management. If `attach` is specified, resources are persisted as separate files or entries in the ZIP archive. If `embed` is specified, content is stored inline the HAR file.
- `updateMode` "full" | "minimal" *(optional)*

When set to `minimal`, only record information necessary for routing from HAR. This omits sizes, timing, page, cookies, security and other types of HAR information that are not used when replaying from HAR. Defaults to `minimal`.
- `url` String *(optional)*

A glob pattern, regular expression or predicate to match the request URL. Only requests with URL matching the pattern will be served from the HAR file. If not specified, all requests are served from the HAR file.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> routeFromHAR( String harPath,
```

## `BrowserType`

```dart
abstract interface class BrowserType
```

### `name`

*📦 Property*

Returns browser name. For example: `'chromium'`, `'webkit'` or `'firefox'`.

**Usage**

```dart
browserType.name;
```

**Returns**
- String


[APIRequest]: /api/class-apirequest.mdx "APIRequest"
[APIRequestContext]: /api/class-apirequestcontext.mdx "APIRequestContext"
[APIResponse]: /api/class-apiresponse.mdx "APIResponse"
[APIResponseAssertions]: /api/class-apiresponseassertions.mdx "APIResponseAssertions"
[Browser]: /api/class-browser.mdx "Browser"
[BrowserContext]: /api/class-browsercontext.mdx "BrowserContext"
[BrowserServer]: /api/class-browserserver.mdx "BrowserServer"
[BrowserType]: /api/class-browsertype.mdx "BrowserType"
[CDPSession]: /api/class-cdpsession.mdx "CDPSession"
[Clock]: /api/class-clock.mdx "Clock"
[ConsoleMessage]: /api/class-consolemessage.mdx "ConsoleMessage"
[Coverage]: /api/class-coverage.mdx "Coverage"
[Credentials]: /api/class-credentials.mdx "Credentials"
[Debugger]: /api/class-debugger.mdx "Debugger"
[Dialog]: /api/class-dialog.mdx "Dialog"
[Disposable]: /api/class-disposable.mdx "Disposable"
[Download]: /api/class-download.mdx "Download"
[ElementHandle]: /api/class-elementhandle.mdx "ElementHandle"
[FileChooser]: /api/class-filechooser.mdx "FileChooser"
[Frame]: /api/class-frame.mdx "Frame"
[FrameLocator]: /api/class-framelocator.mdx "FrameLocator"
[GenericAssertions]: /api/class-genericassertions.mdx "GenericAssertions"
[JSHandle]: /api/class-jshandle.mdx "JSHandle"
[Keyboard]: /api/class-keyboard.mdx "Keyboard"
[Locator]: /api/class-locator.mdx "Locator"
[LocatorAssertions]: /api/class-locatorassertions.mdx "LocatorAssertions"
[Logger]: /api/class-logger.mdx "Logger"
[Mouse]: /api/class-mouse.mdx "Mouse"
[Page]: /api/class-page.mdx "Page"
[PageAssertions]: /api/class-pageassertions.mdx "PageAssertions"
[Playwright]: /api/class-playwright.mdx "Playwright"
[PlaywrightAssertions]: /api/class-playwrightassertions.mdx "PlaywrightAssertions"
[Request]: /api/class-request.mdx "Request"
[Response]: /api/class-response.mdx "Response"
[Route]: /api/class-route.mdx "Route"
[Screencast]: /api/class-screencast.mdx "Screencast"
[Selectors]: /api/class-selectors.mdx "Selectors"
[SnapshotAssertions]: /api/class-snapshotassertions.mdx "SnapshotAssertions"
[TimeoutError]: /api/class-timeouterror.mdx "TimeoutError"
[Touchscreen]: /api/class-touchscreen.mdx "Touchscreen"
[Tracing]: /api/class-tracing.mdx "Tracing"
[Video]: /api/class-video.mdx "Video"
[WebError]: /api/class-weberror.mdx "WebError"
[WebSocket]: /api/class-websocket.mdx "WebSocket"
[WebSocketRoute]: /api/class-websocketroute.mdx "WebSocketRoute"
[WebStorage]: /api/class-webstorage.mdx "WebStorage"
[Worker]: /api/class-worker.mdx "Worker"
[Electron]: /api/class-electron.mdx "Electron"
[ElectronApplication]: /api/class-electronapplication.mdx "ElectronApplication"
[Android]: /api/class-android.mdx "Android"
[AndroidDevice]: /api/class-androiddevice.mdx "AndroidDevice"
[AndroidInput]: /api/class-androidinput.mdx "AndroidInput"
[AndroidSocket]: /api/class-androidsocket.mdx "AndroidSocket"
[AndroidWebView]: /api/class-androidwebview.mdx "AndroidWebView"
[Fixtures]: /api/class-fixtures.mdx "Fixtures"
[FullConfig]: /api/class-fullconfig.mdx "FullConfig"
[FullProject]: /api/class-fullproject.mdx "FullProject"
[Location]: /api/class-location.mdx "Location"
[Test]: /api/class-test.mdx "Test"
[TestConfig]: /api/class-testconfig.mdx "TestConfig"
[TestInfo]: /api/class-testinfo.mdx "TestInfo"
[TestInfoError]: /api/class-testinfoerror.mdx "TestInfoError"
[TestOptions]: /api/class-testoptions.mdx "TestOptions"
[TestProject]: /api/class-testproject.mdx "TestProject"
[TestStepInfo]: /api/class-teststepinfo.mdx "TestStepInfo"
[WorkerInfo]: /api/class-workerinfo.mdx "WorkerInfo"
[Reporter]: /api/class-reporter.mdx "Reporter"
[Suite]: /api/class-suite.mdx "Suite"
[TestCase]: /api/class-testcase.mdx "TestCase"
[TestError]: /api/class-testerror.mdx "TestError"
[TestResult]: /api/class-testresult.mdx "TestResult"
[TestStep]: /api/class-teststep.mdx "TestStep"
[EvaluationArgument]: /evaluating.mdx#evaluation-argument "EvaluationArgument"
[UIEvent.detail]: https://developer.mozilla.org/en-US/docs/Web/API/UIEvent/detail "UIEvent.detail"


[all available image tags]: https://mcr.microsoft.com/en-us/product/playwright/about "all available image tags"
[Microsoft Artifact Registry]: https://mcr.microsoft.com/en-us/product/playwright/about "Microsoft Artifact Registry"
[Dockerfile.noble]: https://github.com/microsoft/playwright/blob/main/utils/docker/Dockerfile.noble "Dockerfile.noble"

```dart
String get name
```

### `executablePath`

*📦 Property*

A path where Playwright expects to find a bundled browser executable.

**Usage**

```dart
browserType.executablePath;
```

**Returns**
- String

```dart
String get executablePath
```

### `launch`

*⚙️ Method*

Returns the browser instance.

**Usage**

You can use [ignoreDefaultArgs] to filter out `--mute-audio` from default arguments:

```dart
final browser = await chromium.launch(  // Or 'firefox' or 'webkit'.
ignoreDefaultArgs: ['--mute-audio']
);
```

> **Chromium-only** Playwright can also be used to control the Google Chrome or Microsoft Edge browsers, but it works best with the version of Chromium it is bundled with. There is no guarantee it will work with any other version. Use [executablePath] option with extreme caution.
>
> If Google Chrome (rather than Chromium) is preferred, a [Chrome Canary] or [Dev Channel] build is suggested.
>
> Stock browsers like Google Chrome and Microsoft Edge are suitable for tests that require proprietary media codecs for video playback. See [this article] for other differences between Chromium and Chrome. [This article] describes some differences for Linux users.

**Arguments**
- `options` LaunchOptions *(optional)*
- `args` List&lt;String&gt; *(optional)*

**WARNING**
Use custom browser args at your own risk, as some of them may break Playwright functionality.
Additional arguments to pass to the browser instance. The list of Chromium flags can be found [here].
- `artifactsDir` String *(optional)*

If specified, artifacts (traces, videos, downloads, HAR files, etc.) are saved into this directory. The directory is not cleaned up when the browser closes. If not specified, a temporary directory is used and cleaned up when the browser closes.
- `channel` String *(optional)*

Browser distribution channel.

Use "chromium" to [opt in to new headless mode].

Use "chrome", "chrome-beta", "chrome-dev", "chrome-canary", "msedge", "msedge-beta", "msedge-dev", or "msedge-canary" to use branded [Google Chrome and Microsoft Edge].
- `chromiumSandbox` bool *(optional)*

Enable Chromium sandboxing. Defaults to `false`.
- `downloadsPath` String *(optional)*

If specified, accepted downloads are downloaded into this directory. Otherwise, temporary directory is created and is deleted when browser is closed. In either case, the downloads are deleted when the browser context they were created in is closed.
- `env` Map&lt;String, String | [undefined]&gt; *(optional)*
- `executablePath` String *(optional)*

Path to a browser executable to run instead of the bundled one. If [executablePath] is a relative path, then it is resolved relative to the current working directory. Note that Playwright only works with the bundled Chromium, Firefox or WebKit, use at your own risk.
- `firefoxUserPrefs` Map&lt;String, String | num | bool&gt; *(optional)*

Firefox user preferences. Learn more about the Firefox user preferences at [`about:config`].

You can also provide a path to a custom [`policies.json` file] via `PLAYWRIGHT_FIREFOX_POLICIES_JSON` environment variable.
- `handleSIGHUP` bool *(optional)*

Close the browser process on SIGHUP. Defaults to `true`.
- `handleSIGINT` bool *(optional)*

Close the browser process on Ctrl-C. Defaults to `true`.
- `handleSIGTERM` bool *(optional)*

Close the browser process on SIGTERM. Defaults to `true`.
- `headless` bool *(optional)*

Whether to run browser in headless mode. More details for [Chromium] and [Firefox]. Defaults to `true`.
- `ignoreDefaultArgs` bool | List&lt;String&gt; *(optional)*

If `true`, Playwright does not pass its own configurations args and only uses the ones from [args]. If an array is given, then filters out the given default arguments. Dangerous option; use with care. Defaults to `false`.
- `logger` [Logger] *(optional)*

**WARNING**
[Deprecated]
The logs received by the logger are incomplete. Please use tracing instead.
Logger sink for Playwright logging.
- `proxy` Map *(optional)*
- `server` String

Proxy to be used for all requests. HTTP and SOCKS proxies are supported, for example `http://myproxy.com:3128` or `socks5://myproxy.com:3128`. Short form `myproxy.com:3128` is considered an HTTP proxy.
- `bypass` String *(optional)*

Optional comma-separated domains to bypass proxy, for example `".com, chromium.org, .domain.com"`.
- `username` String *(optional)*

Optional username to use if HTTP proxy requires authentication.
- `password` String *(optional)*

Optional password to use if HTTP proxy requires authentication.

Network proxy settings.
- `slowMo` double *(optional)*

Slows down Playwright operations by the specified amount of milliseconds. Useful so that you can see what is going on.
- `timeout` num *(optional)*

Maximum time in milliseconds to wait for the browser instance to start. Defaults to `30000` (30 seconds). Pass `0` to disable timeout.
- `tracesDir` String *(optional)*

If specified, traces are saved into this directory.

**Returns**
- Future&lt;[Browser]&gt;

```dart
Future<Browser> launch(
```

### `launchPersistentContext`

*⚙️ Method*

Returns the persistent browser context instance.

Launches browser that uses persistent storage located at [userDataDir] and returns the only context. Closing this context will automatically close the browser.

**Usage**

```dart
await browserType.launchPersistentContext(userDataDir);
await browserType.launchPersistentContext(userDataDir, options);
```

**Arguments**
- `userDataDir` String

Path to a User Data Directory, which stores browser session data like cookies and local storage. Pass an empty string to create a temporary directory.

More details for [Chromium] and [Firefox]. Chromium's user data directory is the **parent** directory of the "Profile Path" seen at `chrome://version`.

Note that browsers do not allow launching multiple instances with the same User Data Directory.

**WARNING**
Chromium/Chrome: Due to recent Chrome policy changes, automating the default Chrome user profile is not supported. Pointing `userDataDir` to Chrome's main "User Data" directory (the profile used for your regular browsing) may result in pages not loading or the browser exiting. Create and use a separate directory (for example, an empty folder) as your automation profile instead. See https://developer.chrome.com/blog/remote-debugging-port for details.
- `options` Map *(optional)*
- `acceptDownloads` bool *(optional)*

Whether to automatically download all the attachments. Defaults to `true` where all the downloads are accepted.
- `args` List&lt;String&gt; *(optional)*

**WARNING**
Use custom browser args at your own risk, as some of them may break Playwright functionality.
Additional arguments to pass to the browser instance. The list of Chromium flags can be found [here].
- `artifactsDir` String *(optional)*

If specified, artifacts (traces, videos, downloads, HAR files, etc.) are saved into this directory. The directory is not cleaned up when the browser closes. If not specified, a temporary directory is used and cleaned up when the browser closes.
- `baseURL` String *(optional)*

When using [page.goto()], [page.route()], [page.waitForURL()], [page.waitForRequest()], or [page.waitForResponse()] it takes the base URL in consideration by using the [`URL()`] constructor for building the corresponding URL. Unset by default. Examples:
* baseURL: `http://localhost:3000` and navigating to `/bar.html` results in `http://localhost:3000/bar.html`
* baseURL: `http://localhost:3000/foo/` and navigating to `./bar.html` results in `http://localhost:3000/foo/bar.html`
* baseURL: `http://localhost:3000/foo` (without trailing slash) and navigating to `./bar.html` results in `http://localhost:3000/bar.html`
- `bypassCSP` bool *(optional)*

Toggles bypassing page's Content-Security-Policy. Defaults to `false`.
- `channel` String *(optional)*

Browser distribution channel.

Use "chromium" to [opt in to new headless mode].

Use "chrome", "chrome-beta", "chrome-dev", "chrome-canary", "msedge", "msedge-beta", "msedge-dev", or "msedge-canary" to use branded [Google Chrome and Microsoft Edge].
- `chromiumSandbox` bool *(optional)*

Enable Chromium sandboxing. Defaults to `false`.
- `clientCertificates` List&lt;Map&gt; *(optional)*
- `origin` String

Exact origin that the certificate is valid for. Origin includes `https` protocol, a hostname and optionally a port.
- `certPath` String *(optional)*

Path to the file with the certificate in PEM format.
- `cert` List&lt;int&gt; *(optional)*

Direct value of the certificate in PEM format.
- `keyPath` String *(optional)*

Path to the file with the private key in PEM format.
- `key` List&lt;int&gt; *(optional)*

Direct value of the private key in PEM format.
- `pfxPath` String *(optional)*

Path to the PFX or PKCS12 encoded private key and certificate chain.
- `pfx` List&lt;int&gt; *(optional)*

Direct value of the PFX or PKCS12 encoded private key and certificate chain.
- `passphrase` String *(optional)*

Passphrase for the private key (PEM or PFX).

TLS Client Authentication allows the server to request a client certificate and verify it.

**Details**

An array of client certificates to be used. Each certificate object must have either both `certPath` and `keyPath`, a single `pfxPath`, or their corresponding direct value equivalents (`cert` and `key`, or `pfx`). Optionally, `passphrase` property should be provided if the certificate is encrypted. The `origin` property should be provided with an exact match to the request origin that the certificate is valid for.

Client certificate authentication is only active when at least one client certificate is provided. If you want to reject all client certificates sent by the server, you need to provide a client certificate with an `origin` that does not match any of the domains you plan to visit.

**NOTE**
When using WebKit on macOS, accessing `localhost` will not pick up client certificates. You can make it work by replacing `localhost` with `local.playwright`.
- `colorScheme` null | "light" | "dark" | "no-preference" *(optional)*

Emulates [prefers-colors-scheme] media feature, supported values are `'light'` and `'dark'`. See [page.emulateMedia()] for more details. Passing `null` resets emulation to system defaults. Defaults to `'light'`.
- `contrast` null | "no-preference" | "more" *(optional)*

Emulates `'prefers-contrast'` media feature, supported values are `'no-preference'`, `'more'`. See [page.emulateMedia()] for more details. Passing `null` resets emulation to system defaults. Defaults to `'no-preference'`.
- `deviceScaleFactor` num *(optional)*

Specify device scale factor (can be thought of as dpr). Defaults to `1`. Learn more about [emulating devices with device scale factor].
- `downloadsPath` String *(optional)*

If specified, accepted downloads are downloaded into this directory. Otherwise, temporary directory is created and is deleted when browser is closed. In either case, the downloads are deleted when the browser context they were created in is closed.
- `env` Map&lt;String, String | [undefined]&gt; *(optional)*
- `executablePath` String *(optional)*

Path to a browser executable to run instead of the bundled one. If [executablePath] is a relative path, then it is resolved relative to the current working directory. Note that Playwright only works with the bundled Chromium, Firefox or WebKit, use at your own risk.
- `extraHTTPHeaders` Map&lt;String, String&gt; *(optional)*

An object containing additional HTTP headers to be sent with every request. Defaults to none.
- `firefoxUserPrefs` Map&lt;String, String | num | bool&gt; *(optional)*

Firefox user preferences. Learn more about the Firefox user preferences at [`about:config`].

You can also provide a path to a custom [`policies.json` file] via `PLAYWRIGHT_FIREFOX_POLICIES_JSON` environment variable.
- `forcedColors` null | "active" | "none" *(optional)*

Emulates `'forced-colors'` media feature, supported values are `'active'`, `'none'`. See [page.emulateMedia()] for more details. Passing `null` resets emulation to system defaults. Defaults to `'none'`.
- `geolocation` Map *(optional)*
- `latitude` num

Latitude between -90 and 90.
- `longitude` num

Longitude between -180 and 180.
- `accuracy` num *(optional)*

Non-negative accuracy value. Defaults to `0`.
- `handleSIGHUP` bool *(optional)*

Close the browser process on SIGHUP. Defaults to `true`.
- `handleSIGINT` bool *(optional)*

Close the browser process on Ctrl-C. Defaults to `true`.
- `handleSIGTERM` bool *(optional)*

Close the browser process on SIGTERM. Defaults to `true`.
- `hasTouch` bool *(optional)*

Specifies if viewport supports touch events. Defaults to false. Learn more about [mobile emulation].
- `headless` bool *(optional)*

Whether to run browser in headless mode. More details for [Chromium] and [Firefox]. Defaults to `true`.
- `httpCredentials` Map *(optional)*
- `username` String


- `password` String


- `origin` String *(optional)*

Restrain sending http credentials on specific origin (scheme://host:port).
- `send` "unauthorized" | "always" *(optional)*

This option only applies to the requests sent from corresponding [APIRequestContext] and does not affect requests sent from the browser. `'always'` - `Authorization` header with basic authentication credentials will be sent with the each API request. `'unauthorized` - the credentials are only sent when 401 (Unauthorized) response with `WWW-Authenticate` header is received. Defaults to `'unauthorized'`.

Credentials for [HTTP authentication]. If no origin is specified, the username and password are sent to any servers upon unauthorized responses.
- `ignoreDefaultArgs` bool | List&lt;String&gt; *(optional)*

If `true`, Playwright does not pass its own configurations args and only uses the ones from [args]. If an array is given, then filters out the given default arguments. Dangerous option; use with care. Defaults to `false`.
- `ignoreHTTPSErrors` bool *(optional)*

Whether to ignore HTTPS errors when sending network requests. Defaults to `false`.
- `isMobile` bool *(optional)*

Whether the `meta viewport` tag is taken into account and touch events are enabled. isMobile is a part of device, so you don't actually need to set it manually. Defaults to `false` and is not supported in Firefox. Learn more about [mobile emulation].
- `javaScriptEnabled` bool *(optional)*

Whether or not to enable JavaScript in the context. Defaults to `true`. Learn more about [disabling JavaScript].
- `locale` String *(optional)*

Specify user locale, for example `en-GB`, `de-DE`, etc. Locale will affect `navigator.language` value, `Accept-Language` request header value as well as number and date formatting rules. Defaults to the system default locale. Learn more about emulation in our [emulation guide].
- `logger` [Logger] *(optional)*

**WARNING**
[Deprecated]
The logs received by the logger are incomplete. Please use tracing instead.
Logger sink for Playwright logging.
- `offline` bool *(optional)*

Whether to emulate network being offline. Defaults to `false`. Learn more about [network emulation].
- `permissions` List&lt;String&gt; *(optional)*

A list of permissions to grant to all pages in this context. See [browserContext.grantPermissions()] for more details. Defaults to none.
- `proxy` Map *(optional)*
- `server` String

Proxy to be used for all requests. HTTP and SOCKS proxies are supported, for example `http://myproxy.com:3128` or `socks5://myproxy.com:3128`. Short form `myproxy.com:3128` is considered an HTTP proxy.
- `bypass` String *(optional)*

Optional comma-separated domains to bypass proxy, for example `".com, chromium.org, .domain.com"`.
- `username` String *(optional)*

Optional username to use if HTTP proxy requires authentication.
- `password` String *(optional)*

Optional password to use if HTTP proxy requires authentication.

Network proxy settings.
- `recordHar` Map *(optional)*
- `omitContent` bool *(optional)*

Optional setting to control whether to omit request content from the HAR. Defaults to `false`. Deprecated, use `content` policy instead.
- `content` "omit" | "embed" | "attach" *(optional)*

Optional setting to control resource content management. If `omit` is specified, content is not persisted. If `attach` is specified, resources are persisted as separate files or entries in the ZIP archive. If `embed` is specified, content is stored inline the HAR file as per HAR specification. Defaults to `attach` for `.zip` output files and to `embed` for all other file extensions.
- `path` String

Path on the filesystem to write the HAR file to. If the file name ends with `.zip`, `content: 'attach'` is used by default.
- `mode` "full" | "minimal" *(optional)*

When set to `minimal`, only record information necessary for routing from HAR. This omits sizes, timing, page, cookies, security and other types of HAR information that are not used when replaying from HAR. Defaults to `full`.
- `urlFilter` String | [RegExp] *(optional)*

A glob or regex pattern to filter requests that are stored in the HAR. When a [baseURL] via the context options was provided and the passed URL is a path, it gets merged via the [`new URL()`] constructor. Defaults to none.

Enables [HAR] recording for all pages into `recordHar.path` file. If not specified, the HAR is not recorded. Make sure to await [browserContext.close()] for the HAR to be saved.
- `recordVideo` Map *(optional)*
- `dir` String *(optional)*

Path to the directory to put videos into. If not specified, the videos will be stored in `artifactsDir` (see [browserType.launch()] options).
- `size` Map *(optional)*
- `width` num

Video frame width.
- `height` num

Video frame height.

Optional dimensions of the recorded videos. If not specified the size will be equal to `viewport` scaled down to fit into 800x800. If `viewport` is not configured explicitly the video size defaults to 800x450. Actual picture of each page will be scaled down if necessary to fit the specified size.
- `showActions` Map *(optional)*
- `duration` num *(optional)*

How long each annotation is displayed in milliseconds. Defaults to `500`.
- `position` "top-left" | "top" | "top-right" | "bottom-left" | "bottom" | "bottom-right" *(optional)*

Position of the action title overlay. Defaults to `"top-right"`.
- `fontSize` num *(optional)*

Font size of the action title in pixels. Defaults to `24`.

If specified, enables visual annotations on interacted elements during video recording.

Enables video recording for all pages into `recordVideo.dir` directory. If not specified videos are not recorded. Make sure to await [browserContext.close()] for videos to be saved.
- `reducedMotion` null | "reduce" | "no-preference" *(optional)*

Emulates `'prefers-reduced-motion'` media feature, supported values are `'reduce'`, `'no-preference'`. See [page.emulateMedia()] for more details. Passing `null` resets emulation to system defaults. Defaults to `'no-preference'`.
- `screen` Map *(optional)*
- `width` num

page width in pixels.
- `height` num

page height in pixels.

Emulates consistent window screen size available inside web page via `window.screen`. Is only used when the [viewport] is set.
- `serviceWorkers` "allow" | "block" *(optional)*

Whether to allow sites to register Service workers. Defaults to `'allow'`.
* `'allow'`: [Service Workers] can be registered.
* `'block'`: Playwright will block all registration of Service Workers.
- `slowMo` double *(optional)*

Slows down Playwright operations by the specified amount of milliseconds. Useful so that you can see what is going on.
- `strictSelectors` bool *(optional)*

If set to true, enables strict selectors mode for this context. In the strict selectors mode all operations on selectors that imply single target DOM element will throw when more than one element matches the selector. This option does not affect any Locator APIs (Locators are always strict). Defaults to `false`. See [Locator] to learn more about the strict mode.
- `timeout` num *(optional)*

Maximum time in milliseconds to wait for the browser instance to start. Defaults to `30000` (30 seconds). Pass `0` to disable timeout.
- `timezoneId` String *(optional)*

Changes the timezone of the context. See [ICU's metaZones.txt] for a list of supported timezone IDs. Defaults to the system timezone.
- `tracesDir` String *(optional)*

If specified, traces are saved into this directory.
- `userAgent` String *(optional)*

Specific user agent to use in this context.
- `viewport` [Map]? *(optional)*
- `width` num

page width in pixels.
- `height` num

page height in pixels.

Emulates consistent viewport for each page. Defaults to an 1280x720 viewport. Use `null` to disable the consistent viewport emulation. Learn more about [viewport emulation].

**NOTE**
The `null` value opts out from the default presets, makes viewport depend on the host window size defined by the operating system. It makes the execution of the tests non-deterministic.
**Returns**
- Future&lt;[BrowserContext]&gt;

```dart
Future<BrowserContext> launchPersistentContext( String userDataDir,
```

### `connectToWorker`

*⚙️ Method*

Connects to an existing worker.

```dart
Future<Worker> connectToWorker(String endpoint,
```

### `connectOverCDP`

*⚙️ Method*

This method attaches Playwright to an existing browser instance using the Chrome DevTools Protocol.

The default browser context is accessible via [browser.contexts()].

**NOTE**
Connecting over the Chrome DevTools Protocol is only supported for Chromium-based browsers.
**NOTE**
This connection is significantly lower fidelity than the Playwright protocol connection via [browserType.connect()]. If you are experiencing issues or attempting to use advanced functionality, you probably want to use [browserType.connect()].
**WARNING**
Playwright maintains a curated list of arguments for launching the browser. If you launch the browser without Playwright and do not pass the exact same arguments, some of Playwright functionality may be broken upon connecting to the browser.
**Usage**

```dart
final browser = await playwright.chromium.connectOverCDP('http://localhost:9222');
final defaultContext = browser.contexts()[0];
final page = defaultContext.pages()[0];
```

**Arguments**
- `endpointURL` String

A CDP websocket endpoint or http url to connect to. For example `http://localhost:9222/` or `ws://127.0.0.1:9222/devtools/browser/387adf4c-243f-4051-a181-46798f4a46f4`.
- `options` Map *(optional)*
- `artifactsDir` String *(optional)*

If specified, browser artifacts (such as traces and downloads) are saved into this directory.
- `endpointURL` String *(optional)*

**WARNING**
[Deprecated]
Use the first argument instead.
- `headers` List&lt;NameValue&gt; *(optional)*

Additional HTTP headers to be sent with connect request. Optional.
- `isLocal` bool *(optional)*

Tells Playwright that it runs on the same host as the CDP server. It will enable certain optimizations that rely upon the file system being the same between Playwright and the Browser.
- `noDefaults` bool *(optional)*

When true, Playwright will not apply its default overrides to the existing default browser context. Specifically, [acceptDownloads] is left at the browser's setting, focus emulation is not enabled, and media emulation options (such as [colorScheme], [reducedMotion], [forcedColors], and [contrast]) are not applied. Useful when attaching to a user's daily-driver browser where these overrides would interfere with existing browser state. New contexts created via [browser.newContext()] are not affected. Defaults to `false`.
- `slowMo` double *(optional)*

Slows down Playwright operations by the specified amount of milliseconds. Useful so that you can see what is going on. Defaults to 0.
- `timeout` double *(optional)*

Maximum time in milliseconds to wait for the connection to be established. Defaults to `30000` (30 seconds). Pass `0` to disable timeout.

**Returns**
- Future&lt;[Browser]&gt;

```dart
Future<Browser> connectOverCDP(
```

### `connect`

*⚙️ Method*

This method attaches Playwright to an existing browser instance created via `BrowserType.launchServer` in Node.js.

**NOTE**
The major and minor version of the Playwright instance that connects needs to match the version of Playwright that launches the browser (1.2.3 → is compatible with 1.2.x).
**Usage**

```dart
await browserType.connect(endpoint);
await browserType.connect(endpoint, options);
```

**Arguments**
- `endpoint` String

A Playwright browser websocket endpoint to connect to. You obtain this endpoint via `BrowserServer.wsEndpoint`.
- `options` Map *(optional)*
- `exposeNetwork` String *(optional)*

This option exposes network available on the connecting client to the browser being connected to. Consists of a list of rules separated by comma.

Available rules:
1. Hostname pattern, for example: `example.com`, `*.org:99`, `x.*.y.com`, `*foo.org`.
1. IP literal, for example: `127.0.0.1`, `0.0.0.0:99`, `[::1]`, `[0:0::1]:99`.
1. `<loopback>` that matches local loopback interfaces: `localhost`, `*.localhost`, `127.0.0.1`, `[::1]`.

Some common examples:
1. `"*"` to expose all network.
1. `"<loopback>"` to expose localhost network.
1. `"*.test.internal-domain,*.staging.internal-domain,<loopback>"` to expose test/staging deployments and localhost.
- `headers` Map&lt;String, String&gt; *(optional)*

Additional HTTP headers to be sent with web socket connect request. Optional.
- `slowMo` double *(optional)*

Slows down Playwright operations by the specified amount of milliseconds. Useful so that you can see what is going on. Defaults to 0.
- `timeout` double *(optional)*

Maximum time in milliseconds to wait for the connection to be established. Defaults to `0` (no timeout).

**Returns**
- Future&lt;[Browser]&gt;

```dart
Future<Browser> connect( String wsEndpoint,
```

## `ExpectReceived`

```dart
class ExpectReceived
```

## `ExpectResult`

```dart
class ExpectResult
```

## `Frame`

```dart
abstract interface class Frame
```

### `parentFrame`

*📦 Property*

Parent frame, if any. Detached frames and main frames return `null`.

**Usage**

```dart
frame.parentFrame;
```

**Returns**
- [Frame]?

```dart
Frame? get parentFrame
```

### `childFrames`

*📦 Property*

**Usage**

```dart
frame.childFrames;
```

**Returns**
- List&lt;[Frame]&gt;

```dart
List<Frame> get childFrames
```

### `name`

*📦 Property*

Returns frame's name attribute as specified in the tag.

If the name is empty, returns the id attribute instead.

**NOTE**
This value is calculated once when the frame is created, and will not update if the attribute is changed later.
**Usage**

```dart
frame.name;
```

**Returns**
- String

```dart
String get name
```

### `onNavigated`

*📦 Property*

Stream that emits when the frame navigates.

```dart
Stream<Map<String, dynamic>> get onNavigated
```

### `onLoadstate`

*📦 Property*

Stream that emits when the frame load state changes.

```dart
Stream<Map<String, dynamic>> get onLoadstate
```

### `url`

*⚙️ Method*

Returns frame's url.

**Usage**

```dart
frame.url();
```

**Returns**
- String

```dart
String url()
```

### `page`

*📦 Property*

Returns the page containing this frame.

**Usage**

```dart
frame.page;
```

**Returns**
- [Page]

```dart
Page get page
```

### `frameLocator`

*⚙️ Method*

When working with iframes, you can create a frame locator that will enter the iframe and allow selecting elements in that iframe.

**Usage**

Following snippet locates element with text "Submit" in the iframe with id `my-frame`, like `<iframe id="my-frame">`:

```dart
final locator = frame.frameLocator('#my-iframe').getByText('Submit');
await locator.click();
```

**Arguments**
- `selector` String

A selector to use when resolving DOM element.

**Returns**
- [FrameLocator]

```dart
FrameLocator frameLocator(String selector)
```

### `locator`

*⚙️ Method*

The method returns an element locator that can be used to perform actions on this page / frame. Locator is resolved to the element immediately before performing an action, so a series of actions on the same locator can in fact be performed on different DOM elements. That would happen if the DOM structure between those actions has changed.

[Learn more about locators].

[Learn more about locators].

**Usage**

```dart
frame.locator(selector);
frame.locator(selector, options);
```

**Arguments**
- `selector` String

A selector to use when resolving DOM element.
- `options` Map *(optional)*
- `has` [Locator] *(optional)*

Narrows down the results of the method to those which contain elements matching this relative locator. For example, `article` that has `text=Playwright` matches `<article><div>Playwright</div></article>`.

Inner locator **must be relative** to the outer locator and is queried starting with the outer locator match, not the document root. For example, you can find `content` that has `div` in `<article><content><div>Playwright</div></content></article>`. However, looking for `content` that has `article div` will fail, because the inner locator must be relative and should not use any elements outside the `content`.

Note that outer and inner locators must belong to the same frame. Inner locator must not contain [FrameLocator]s.
- `hasNot` [Locator] *(optional)*

Matches elements that do not contain an element that matches an inner locator. Inner locator is queried against the outer one. For example, `article` that does not have `div` matches `<article><span>Playwright</span></article>`.

Note that outer and inner locators must belong to the same frame. Inner locator must not contain [FrameLocator]s.
- `hasNotText` String | [RegExp] *(optional)*

Matches elements that do not contain specified text somewhere inside, possibly in a child or a descendant element. When passed a String, matching is case-insensitive and searches for a substring.
- `hasText` String | [RegExp] *(optional)*

Matches elements containing specified text somewhere inside, possibly in a child or a descendant element. When passed a String, matching is case-insensitive and searches for a substring. For example, `"Playwright"` matches `<article><div>Playwright</div></article>`.

**Returns**
- [Locator]

```dart
Locator locator(String selector)
```

### `getByText`

*⚙️ Method*

Allows locating elements that contain given text.

See also [locator.filter()] that allows to match by another criteria, like an accessible role, and then filter by the text content.

**Usage**

Consider the following DOM structure:

```html
<div>Hello <span>world</span></div>
<div>Hello</div>
```

You can locate by text substring, exact string, or a regular expression:

```dart
// Matches <span>
page.getByText('world');

// Matches first <div>
page.getByText('Hello world');

// Matches second <div>
page.getByText('Hello', { exact: true );

// Matches both <div>s
page.getByText(/Hello/);

// Matches second <div>
page.getByText(/^hello$/i);
```

**Arguments**
- `text` Pattern

Text to locate the element for.
- `options` Map *(optional)*
- `exact` bool *(optional)*

Whether to find an exact match: case-sensitive and whole-string. Default to false. Ignored when locating by a regular expression. Note that exact match still trims whitespace.

**Returns**
- [Locator]

**Details**

Matching by text always normalizes whitespace, even with exact match. For example, it turns multiple spaces into one, turns line breaks into spaces and ignores leading and trailing whitespace.

Input elements of the type `button` and `submit` are matched by their `value` instead of the text content. For example, locating by text `"Log in"` matches `<input type=button value="Log in">`.

```dart
Locator getByText(Pattern text,
```

### `getByRole`

*⚙️ Method*

Allows locating elements by their [ARIA role], [ARIA attributes] and [accessible name].

**Usage**

Consider the following DOM structure.

```html
<h3>Sign up</h3>
<label>
<input type="checkbox" /> Subscribe
</label>
<br/>
<button>Submit</button>
```

You can locate each element by its implicit role:

```dart
await expect(page.getByRole('heading', { name: 'Sign up' )).toBeVisible();

await page.getByRole('checkbox', { name: 'Subscribe' ).check();

await page.getByRole('button', { name: /submit/i ).click();
```

**Arguments**
- `role` String

Required aria role.
- `options` Map *(optional)*
- `checked` bool *(optional)*

An attribute that is usually set by `aria-checked` or native `<input type=checkbox>` controls.

Learn more about [`aria-checked`].
- `description` Pattern *(optional)*

Option to match the [accessible description]. By default, matching is case-insensitive and searches for a substring, use [exact] to control this behavior.

Learn more about [accessible description].
- `disabled` bool *(optional)*

An attribute that is usually set by `aria-disabled` or `disabled`.

**NOTE**
Unlike most other attributes, `disabled` is inherited through the DOM hierarchy. Learn more about [`aria-disabled`].
- `exact` bool *(optional)*

Whether [name] and [description] are matched exactly: case-sensitive and whole-string. Defaults to false. Ignored when the value is a regular expression. Note that exact match still trims whitespace.
- `expanded` bool *(optional)*

An attribute that is usually set by `aria-expanded`.

Learn more about [`aria-expanded`].
- `includeHidden` bool *(optional)*

Option that controls whether hidden elements are matched. By default, only non-hidden elements, as [defined by ARIA], are matched by role selector.

Learn more about [`aria-hidden`].
- `level` int *(optional)*

A number attribute that is usually present for roles `heading`, `listitem`, `row`, `treeitem`, with default values for `<h1>-<h6>` elements.

Learn more about [`aria-level`].
- `name` Pattern *(optional)*

Option to match the [accessible name]. By default, matching is case-insensitive and searches for a substring, use [exact] to control this behavior.

Learn more about [accessible name].
- `pressed` bool *(optional)*

An attribute that is usually set by `aria-pressed`.

Learn more about [`aria-pressed`].
- `selected` bool *(optional)*

An attribute that is usually set by `aria-selected`.

Learn more about [`aria-selected`].

**Returns**
- [Locator]

**Details**

Role selector **does not replace** accessibility audits and conformance tests, but rather gives early feedback about the ARIA guidelines.

Many html elements have an implicitly [defined role] that is recognized by the role selector. You can find all the [supported roles here]. ARIA guidelines **do not recommend** duplicating implicit roles and attributes by setting `role` and/or `aria-*` attributes to default values.

```dart
Locator getByRole( String role,
```

### `getByLabel`

*⚙️ Method*

Allows locating input elements by the text of the associated `<label>` or `aria-labelledby` element, or by the `aria-label` attribute.

**Usage**

For example, this method will find inputs by label "Username" and "Password" in the following DOM:

```html
<input aria-label="Username">
<label for="password-input">Password:</label>
<input id="password-input">
```

```dart
await page.getByLabel('Username').fill('john');
await page.getByLabel('Password').fill('secret');
```

**Arguments**
- `text` Pattern

Text to locate the element for.
- `options` Map *(optional)*
- `exact` bool *(optional)*

Whether to find an exact match: case-sensitive and whole-string. Default to false. Ignored when locating by a regular expression. Note that exact match still trims whitespace.

**Returns**
- [Locator]

```dart
Locator getByLabel(Pattern text,
```

### `getByPlaceholder`

*⚙️ Method*

Allows locating input elements by the placeholder text.

**Usage**

For example, consider the following DOM structure.

```html
<input type="email" placeholder="name@example.com" />
```

You can fill the input after locating it by the placeholder text:

```dart
await page
.getByPlaceholder('name@example.com')
.fill('playwright@microsoft.com');
```

**Arguments**
- `text` Pattern

Text to locate the element for.
- `options` Map *(optional)*
- `exact` bool *(optional)*

Whether to find an exact match: case-sensitive and whole-string. Default to false. Ignored when locating by a regular expression. Note that exact match still trims whitespace.

**Returns**
- [Locator]

```dart
Locator getByPlaceholder(Pattern text,
```

### `getByAltText`

*⚙️ Method*

Allows locating elements by their alt text.

**Usage**

For example, this method will find the image by alt text "Playwright logo":

```html
<img alt='Playwright logo'>
```

```dart
await page.getByAltText('Playwright logo').click();
```

**Arguments**
- `text` Pattern

Text to locate the element for.
- `options` Map *(optional)*
- `exact` bool *(optional)*

Whether to find an exact match: case-sensitive and whole-string. Default to false. Ignored when locating by a regular expression. Note that exact match still trims whitespace.

**Returns**
- [Locator]

```dart
Locator getByAltText(Pattern text,
```

### `getByTitle`

*⚙️ Method*

Allows locating elements by their title attribute.

**Usage**

Consider the following DOM structure.

```html
<span title='Issues count'>25 issues</span>
```

You can check the issues count after locating it by the title text:

```dart
await expect(page.getByTitle('Issues count')).toHaveText('25 issues');
```

**Arguments**
- `text` Pattern

Text to locate the element for.
- `options` Map *(optional)*
- `exact` bool *(optional)*

Whether to find an exact match: case-sensitive and whole-string. Default to false. Ignored when locating by a regular expression. Note that exact match still trims whitespace.

**Returns**
- [Locator]

```dart
Locator getByTitle(Pattern text,
```

### `getByTestId`

*⚙️ Method*

Locate element by the test id.

**Usage**

Consider the following DOM structure.

```html
<button data-testid="directions">Itinéraire</button>
```

You can locate the element by its test id:

```dart
await page.getByTestId('directions').click();
```

**Arguments**
- `testId` String

Id to locate the element by.

**Returns**
- [Locator]

**Details**

By default, the `data-testid` attribute is used as a test id. Use [selectors.setTestIdAttribute()] to configure a different test id attribute if necessary.

```dart
// Set custom test id attribute from @playwright/test config:

export default defineConfig(
use: {
testIdAttribute: 'data-pw'
},
);
```

```dart
Locator getByTestId(String testId)
```

### `goto`

*⚙️ Method*

Returns the main resource response. In case of multiple redirects, the navigation will resolve with the response of the last redirect.

The method will throw an error if:
* there's an SSL error (e.g. in case of self-signed certificates).
* target URL is invalid.
* the [timeout] is exceeded during navigation.
* the remote server does not respond or is unreachable.
* the main resource failed to load.

The method will not throw an error when any valid HTTP status code is returned by the remote server, including 404 "Not Found" and 500 "Internal Server Error".  The status code for such responses can be retrieved by calling [response.status()].

**NOTE**
The method either throws an error or returns a main resource response. The only exceptions are navigation to `about:blank` or navigation to the same URL with a different hash, which would succeed and return `null`.
**NOTE**
Headless mode doesn't support navigation to a PDF document. See the [upstream issue].
**Usage**

```dart
await frame.goto(url);
await frame.goto(url, options);
```

**Arguments**
- `url` String

URL to navigate frame to. The url should include scheme, e.g. `https://`.
- `options` Map *(optional)*
- `referer` String *(optional)*

Referer header value. If provided it will take preference over the referer header value set by [page.setExtraHTTPHeaders()].
- `timeout` double *(optional)*

Maximum operation time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `navigationTimeout` option in the config, or by using the [browserContext.setDefaultNavigationTimeout()], [browserContext.setDefaultTimeout()], [page.setDefaultNavigationTimeout()] or [page.setDefaultTimeout()] methods.
- `waitUntil` LifecycleEvent *(optional)*

When to consider operation succeeded, defaults to `load`. Events can be either:
* `'domcontentloaded'` - consider operation to be finished when the `DOMContentLoaded` event is fired.
* `'load'` - consider operation to be finished when the `load` event is fired.
* `'networkidle'` - **DISCOURAGED** consider operation to be finished when there are no network connections for at least `500` ms. Don't use this method for testing, rely on web assertions to assess readiness instead.
* `'commit'` - consider operation to be finished when network response is received and the document started loading.

**Returns**
- Future&lt;[Response]?&gt;

```dart
Future<void> goto( String url,
```

### `textContent`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.textContent()] instead. Read more about [locators].

Returns `element.textContent`.

**Usage**

```dart
await frame.textContent(selector);
await frame.textContent(selector, options);
```

**Arguments**
- `selector` String

A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
- `options` Map *(optional)*
- `strict` bool *(optional)*

When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;[String&gt;]?

```dart
Future<String> textContent(
```

### `evaluate`

*⚙️ Method*

Returns the return value of [pageFunction].

If the function passed to the [frame.evaluate()] returns a Future, then [frame.evaluate()] would wait for the future to complete and return its value.

If the function passed to the [frame.evaluate()] returns a non-[Serializable] value, then [frame.evaluate()] returns `undefined`. Playwright also supports transferring some additional values that are not serializable by `JSON`: `-0`, `NaN`, `Infinity`, `-Infinity`.

**Usage**

```dart
final result = await frame.evaluate(([x, y]) {
return Future.value(x * y);
}, [7, 8]);
print(result); // prints "56"
```

A string can also be passed in instead of a function.

```dart
print(await frame.evaluate('1 + 2')); // prints "3"
```

[ElementHandle] instances can be passed as an argument to the [frame.evaluate()]:

```dart
final bodyHandle = await frame.evaluateHandle('document.body');
final html = await frame.evaluate(([body, suffix]) =>
body.innerHTML + suffix, [bodyHandle, 'hello'],
);
await bodyHandle.dispose();
```

**Arguments**
- `pageFunction` Function | String

Function to be evaluated in the page context.
- `arg` dynamic *(optional)*

Optional argument to pass to [pageFunction].

**Returns**
- Future&lt;[Serializable]&gt;

```dart
Future<T> evaluate<T>(String expression, [Object? arg])
```

### `waitForSelector`

*⚙️ Method*

**WARNING**
[Discouraged]

Use web assertions that assert visibility or a locator-based [locator.waitFor()] instead. Read more about [locators].

Returns when element specified by selector satisfies [state] option. Returns `null` if waiting for `hidden` or `detached`.

**NOTE**
Playwright automatically waits for element to be ready before performing an action. Using [Locator] objects and web-first assertions make the code wait-for-selector-free.
Wait for the [selector] to satisfy [state] option (either appear/disappear from dom, or become visible/hidden). If at the moment of calling the method [selector] already satisfies the condition, the method will return immediately. If the selector doesn't satisfy the condition for the [timeout] milliseconds, the function will throw.

**Usage**

This method works across navigations:

```dart
// Or 'firefox' or 'webkit'.

(() async {
final browser = await chromium.launch();
final page = await browser.newPage();
for (final currentURL of ['https://google.com', 'https://bbc.com']) {
await page.goto(currentURL);
final element = await page.mainFrame().waitForSelector('img');
print('Loaded image: ' + await element.getAttribute('src'));
}
await browser.close();
}
```

**Arguments**
- `selector` String

A selector to query for.
- `options` Map *(optional)*
- `state` SelectorState *(optional)*

Defaults to `'visible'`. Can be either:
* `'attached'` - wait for element to be present in DOM.
* `'detached'` - wait for element to not be present in DOM.
* `'visible'` - wait for element to have non-empty bounding box and no `visibility:hidden`. Note that element without any content or with `display:none` has an empty bounding box and is not considered visible.
* `'hidden'` - wait for element to be either detached from DOM, or have an empty bounding box or `visibility:hidden`. This is opposite to the `'visible'` option.
- `strict` bool *(optional)*

When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;[ElementHandle]?&gt;

```dart
Future<FrameWaitForSelectorResult> waitForSelector( String selector,
```

### `waitForLoadState`

*⚙️ Method*

Waits for the required load state to be reached.

This returns when the frame reaches a required load state, `load` by default. The navigation must have been committed when this method is called. If current document has already reached the required state, resolves immediately.

**NOTE**
Most of the time, this method is not needed because Playwright [auto-waits before every action].
**Usage**

```dart
await frame.click('button'); // Click triggers navigation.
await frame.waitForLoadState(); // Waits for 'load' state by default.
```

**Arguments**
- `state` LifecycleEvent *(optional)*

Optional load state to wait for, defaults to `load`. If the state has been already reached while loading current document, the method resolves immediately. Can be one of:
* `'load'` - wait for the `load` event to be fired.
* `'domcontentloaded'` - wait for the `DOMContentLoaded` event to be fired.
* `'networkidle'` - **DISCOURAGED** wait until there are no network connections for at least `500` ms. Don't use this method for testing, rely on web assertions to assess readiness instead.
- `options` Map *(optional)*
- `signal` [AbortSignal] *(optional)*

Allows to cancel the waiting using an [`AbortSignal`]. If the signal is aborted, the waiting will be aborted and the operation will throw an error. Note that providing a signal does not disable the default timeout; pass `timeout: 0` to disable the timeout entirely.
- `timeout` double *(optional)*

Maximum operation time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `navigationTimeout` option in the config, or by using the [browserContext.setDefaultNavigationTimeout()], [browserContext.setDefaultTimeout()], [page.setDefaultNavigationTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> waitForLoadState(
```

### `waitForURL`

*⚙️ Method*

Waits for the frame to navigate to the given URL.

**Usage**

```dart
await frame.click('a.delayed-navigation'); // Clicking the link will indirectly cause a navigation
await frame.waitForURL('**/target.html');
```

**Arguments**
- `url` String | [RegExp] | [URLPattern] | Function\([URL]\):bool

A glob pattern, regex pattern, URL pattern, or predicate receiving [URL] to match while waiting for the navigation. Note that if the parameter is a string without wildcard characters, the method will wait for navigation to URL that is exactly equal to the string.
- `options` Map *(optional)*
- `signal` [AbortSignal] *(optional)*

Allows to cancel the waiting using an [`AbortSignal`]. If the signal is aborted, the waiting will be aborted and the operation will throw an error. Note that providing a signal does not disable the default timeout; pass `timeout: 0` to disable the timeout entirely.
- `timeout` double *(optional)*

Maximum operation time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `navigationTimeout` option in the config, or by using the [browserContext.setDefaultNavigationTimeout()], [browserContext.setDefaultTimeout()], [page.setDefaultNavigationTimeout()] or [page.setDefaultTimeout()] methods.
- `waitUntil` LifecycleEvent *(optional)*

When to consider operation succeeded, defaults to `load`. Events can be either:
* `'domcontentloaded'` - consider operation to be finished when the `DOMContentLoaded` event is fired.
* `'load'` - consider operation to be finished when the `load` event is fired.
* `'networkidle'` - **DISCOURAGED** consider operation to be finished when there are no network connections for at least `500` ms. Don't use this method for testing, rely on web assertions to assess readiness instead.
* `'commit'` - consider operation to be finished when network response is received and the document started loading.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> waitForURL( RouteMatcher urlOrPredicate,
```

### `waitForNavigation`

*⚙️ Method*

**WARNING**
[Deprecated]

This method is inherently racy, please use [frame.waitForURL()] instead.

Waits for the frame navigation and returns the main resource response. In case of multiple redirects, the navigation will resolve with the response of the last redirect. In case of navigation to a different anchor or navigation due to History API usage, the navigation will resolve with `null`.

**Usage**

This method waits for the frame to navigate to a new URL. It is useful for when you run code which will indirectly cause the frame to navigate. Consider this example:

```dart
// Start waiting for navigation before clicking. Note no await.
final navigationFuture = page.waitForNavigation();
await page.getByText('Navigate after timeout').click();
await navigationFuture;
```

**NOTE**
Usage of the [History API] to change the URL is considered a navigation.
**Arguments**
- `options` Map *(optional)*
- `signal` [AbortSignal] *(optional)*

Allows to cancel the waiting using an [`AbortSignal`]. If the signal is aborted, the waiting will be aborted and the operation will throw an error. Note that providing a signal does not disable the default timeout; pass `timeout: 0` to disable the timeout entirely.
- `timeout` double *(optional)*

Maximum operation time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `navigationTimeout` option in the config, or by using the [browserContext.setDefaultNavigationTimeout()], [browserContext.setDefaultTimeout()], [page.setDefaultNavigationTimeout()] or [page.setDefaultTimeout()] methods.
- `url` String *(optional)*

A glob pattern, regex pattern, URL pattern, or predicate receiving [URL] to match while waiting for the navigation. Note that if the parameter is a string without wildcard characters, the method will wait for navigation to URL that is exactly equal to the string.
- `waitUntil` LifecycleEvent *(optional)*

When to consider operation succeeded, defaults to `load`. Events can be either:
* `'domcontentloaded'` - consider operation to be finished when the `DOMContentLoaded` event is fired.
* `'load'` - consider operation to be finished when the `load` event is fired.
* `'networkidle'` - **DISCOURAGED** consider operation to be finished when there are no network connections for at least `500` ms. Don't use this method for testing, rely on web assertions to assess readiness instead.
* `'commit'` - consider operation to be finished when network response is received and the document started loading.

**Returns**
- Future&lt;[Response]?&gt;

```dart
Future<void> waitForNavigation(
```

### `dragAndDrop`

*⚙️ Method*

**Usage**

```dart
await frame.dragAndDrop(source, target);
await frame.dragAndDrop(source, target, options);
```

**Arguments**
- `source` String

A selector to search for an element to drag. If there are multiple elements satisfying the selector, the first will be used.
- `target` String

A selector to search for an element to drop onto. If there are multiple elements satisfying the selector, the first will be used.
- `options` Map *(optional)*
- `force` bool *(optional)*

Whether to bypass the [actionability] checks. Defaults to `false`.
- `noWaitAfter` bool *(optional)*

**WARNING**
[Deprecated]
This option has no effect.
This option has no effect.
- `sourcePosition` Point *(optional)*
- `x` num


- `y` num


Clicks on the source element at this point relative to the top-left corner of the element's padding box. If not specified, some visible point of the element is used.
- `steps` int *(optional)*

Defaults to 1. Sends `n` interpolated `mousemove` events to represent travel between the `mousedown` and `mouseup` of the drag. When set to 1, emits a single `mousemove` event at the destination location.
- `strict` bool *(optional)*

When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
- `targetPosition` Point *(optional)*
- `x` num


- `y` num


Drops on the target element at this point relative to the top-left corner of the element's padding box. If not specified, some visible point of the element is used.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
- `trial` bool *(optional)*

When set, this method only performs the [actionability] checks and skips the action. Defaults to `false`. Useful to wait until the element is ready for the action without performing it.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> dragAndDrop( String source, String target,
```

### `click`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.click()] instead. Read more about [locators].

This method clicks an element matching [selector] by performing the following steps:
1. Find an element matching [selector]. If there is none, wait until a matching element is attached to the DOM.
1. Wait for [actionability] checks on the matched element, unless [force] option is set. If the element is detached during the checks, the whole action is retried.
1. Scroll the element into view if needed.
1. Use [page.mouse] to click in the center of the element, or the specified [position].
1. Wait for initiated navigations to either succeed or fail, unless [noWaitAfter] option is set.

When all steps combined have not finished during the specified [timeout], this method throws a [TimeoutError]. Passing zero timeout disables this.

**Usage**

```dart
await frame.click(selector);
await frame.click(selector, options);
```

**Arguments**
- `selector` String

A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
- `options` Map *(optional)*
- `button` Button *(optional)*

Defaults to `left`.
- `clickCount` int *(optional)*

defaults to 1. See [UIEvent.detail].
- `delay` double *(optional)*

Time to wait between `mousedown` and `mouseup` in milliseconds. Defaults to 0.
- `force` bool *(optional)*

Whether to bypass the [actionability] checks. Defaults to `false`.
- `modifiers` List&lt;Modifiers&gt; *(optional)*

Modifier keys to press. Ensures that only these modifiers are pressed during the operation, and then restores current modifiers back. If not specified, currently pressed modifiers are used. "ControlOrMeta" resolves to "Control" on Windows and Linux and to "Meta" on macOS.
- `noWaitAfter` bool *(optional)*

**WARNING**
[Deprecated]
This option will default to `true` in the future.
Actions that initiate navigations are waiting for these navigations to happen and for pages to start loading. You can opt out of waiting via setting this flag. You would only need this option in the exceptional cases such as navigating to inaccessible pages. Defaults to `false`.
- `position` Point *(optional)*
- `x` num


- `y` num


A point to use relative to the top-left corner of element padding box. If not specified, uses some visible point of the element.
- `strict` bool *(optional)*

When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
- `trial` bool *(optional)*

When set, this method only performs the [actionability] checks and skips the action. Defaults to `false`. Useful to wait until the element is ready for the action without performing it. Note that keyboard `modifiers` will be pressed regardless of `trial` to allow testing elements which are only visible when those keys are pressed.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> click( String selector,
```

### `fill`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.fill()] instead. Read more about [locators].

This method waits for an element matching [selector], waits for [actionability] checks, focuses the element, fills it and triggers an `input` event after filling. Note that you can pass an empty string to clear the input field.

If the target element is not an `<input>`, `<textarea>` or `[contenteditable]` element, this method throws an error. However, if the element is inside the `<label>` element that has an associated [control], the control will be filled instead.

To send fine-grained keyboard events, use [locator.pressSequentially()].

**Usage**

```dart
await frame.fill(selector, value);
await frame.fill(selector, value, options);
```

**Arguments**
- `selector` String

A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
- `value` String

Value to fill for the `<input>`, `<textarea>` or `[contenteditable]` element.
- `options` Map *(optional)*
- `force` bool *(optional)*

Whether to bypass the [actionability] checks. Defaults to `false`.
- `noWaitAfter` bool *(optional)*

**WARNING**
[Deprecated]
This option has no effect.
This option has no effect.
- `strict` bool *(optional)*

When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> fill( String selector, String value,
```

### `check`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.check()] instead. Read more about [locators].

This method checks an element matching [selector] by performing the following steps:
1. Find an element matching [selector]. If there is none, wait until a matching element is attached to the DOM.
1. Ensure that matched element is a checkbox or a radio input. If not, this method throws. If the element is already checked, this method returns immediately.
1. Wait for [actionability] checks on the matched element, unless [force] option is set. If the element is detached during the checks, the whole action is retried.
1. Scroll the element into view if needed.
1. Use [page.mouse] to click in the center of the element.
1. Ensure that the element is now checked. If not, this method throws.

When all steps combined have not finished during the specified [timeout], this method throws a [TimeoutError]. Passing zero timeout disables this.

**Usage**

```dart
await frame.check(selector);
await frame.check(selector, options);
```

**Arguments**
- `selector` String

A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
- `options` Map *(optional)*
- `force` bool *(optional)*

Whether to bypass the [actionability] checks. Defaults to `false`.
- `noWaitAfter` bool *(optional)*

**WARNING**
[Deprecated]
This option has no effect.
This option has no effect.
- `position` Point *(optional)*
- `x` num


- `y` num


A point to use relative to the top-left corner of element padding box. If not specified, uses some visible point of the element.
- `strict` bool *(optional)*

When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
- `trial` bool *(optional)*

When set, this method only performs the [actionability] checks and skips the action. Defaults to `false`. Useful to wait until the element is ready for the action without performing it.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> check( String selector,
```

### `uncheck`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.uncheck()] instead. Read more about [locators].

This method checks an element matching [selector] by performing the following steps:
1. Find an element matching [selector]. If there is none, wait until a matching element is attached to the DOM.
1. Ensure that matched element is a checkbox or a radio input. If not, this method throws. If the element is already unchecked, this method returns immediately.
1. Wait for [actionability] checks on the matched element, unless [force] option is set. If the element is detached during the checks, the whole action is retried.
1. Scroll the element into view if needed.
1. Use [page.mouse] to click in the center of the element.
1. Ensure that the element is now unchecked. If not, this method throws.

When all steps combined have not finished during the specified [timeout], this method throws a [TimeoutError]. Passing zero timeout disables this.

**Usage**

```dart
await frame.uncheck(selector);
await frame.uncheck(selector, options);
```

**Arguments**
- `selector` String

A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
- `options` Map *(optional)*
- `force` bool *(optional)*

Whether to bypass the [actionability] checks. Defaults to `false`.
- `noWaitAfter` bool *(optional)*

**WARNING**
[Deprecated]
This option has no effect.
This option has no effect.
- `position` Point *(optional)*
- `x` num


- `y` num


A point to use relative to the top-left corner of element padding box. If not specified, uses some visible point of the element.
- `strict` bool *(optional)*

When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
- `trial` bool *(optional)*

When set, this method only performs the [actionability] checks and skips the action. Defaults to `false`. Useful to wait until the element is ready for the action without performing it.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> uncheck( String selector,
```

### `setChecked`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.setChecked()] instead. Read more about [locators].

This method checks or unchecks an element matching [selector] by performing the following steps:
1. Find an element matching [selector]. If there is none, wait until a matching element is attached to the DOM.
1. Ensure that matched element is a checkbox or a radio input. If not, this method throws.
1. If the element already has the right checked state, this method returns immediately.
1. Wait for [actionability] checks on the matched element, unless [force] option is set. If the element is detached during the checks, the whole action is retried.
1. Scroll the element into view if needed.
1. Use [page.mouse] to click in the center of the element.
1. Ensure that the element is now checked or unchecked. If not, this method throws.

When all steps combined have not finished during the specified [timeout], this method throws a [TimeoutError]. Passing zero timeout disables this.

**Usage**

```dart
await frame.setChecked(selector, checked);
await frame.setChecked(selector, checked, options);
```

**Arguments**
- `selector` String

A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
- `checked` bool

Whether to check or uncheck the checkbox.
- `options` Map *(optional)*
- `force` bool *(optional)*

Whether to bypass the [actionability] checks. Defaults to `false`.
- `noWaitAfter` bool *(optional)*

**WARNING**
[Deprecated]
This option has no effect.
This option has no effect.
- `position` Point *(optional)*
- `x` num


- `y` num


A point to use relative to the top-left corner of element padding box. If not specified, uses some visible point of the element.
- `strict` bool *(optional)*

When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
- `trial` bool *(optional)*

When set, this method only performs the [actionability] checks and skips the action. Defaults to `false`. Useful to wait until the element is ready for the action without performing it.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> setChecked( String selector, bool checked,
```

### `hover`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.hover()] instead. Read more about [locators].

This method hovers over an element matching [selector] by performing the following steps:
1. Find an element matching [selector]. If there is none, wait until a matching element is attached to the DOM.
1. Wait for [actionability] checks on the matched element, unless [force] option is set. If the element is detached during the checks, the whole action is retried.
1. Scroll the element into view if needed.
1. Use [page.mouse] to hover over the center of the element, or the specified [position].

When all steps combined have not finished during the specified [timeout], this method throws a [TimeoutError]. Passing zero timeout disables this.

**Usage**

```dart
await frame.hover(selector);
await frame.hover(selector, options);
```

**Arguments**
- `selector` String

A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
- `options` Map *(optional)*
- `force` bool *(optional)*

Whether to bypass the [actionability] checks. Defaults to `false`.
- `modifiers` List&lt;Modifiers&gt; *(optional)*

Modifier keys to press. Ensures that only these modifiers are pressed during the operation, and then restores current modifiers back. If not specified, currently pressed modifiers are used. "ControlOrMeta" resolves to "Control" on Windows and Linux and to "Meta" on macOS.
- `noWaitAfter` bool *(optional)*

**WARNING**
[Deprecated]
This option has no effect.
This option has no effect.
- `position` Point *(optional)*
- `x` num


- `y` num


A point to use relative to the top-left corner of element padding box. If not specified, uses some visible point of the element.
- `strict` bool *(optional)*

When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
- `trial` bool *(optional)*

When set, this method only performs the [actionability] checks and skips the action. Defaults to `false`. Useful to wait until the element is ready for the action without performing it. Note that keyboard `modifiers` will be pressed regardless of `trial` to allow testing elements which are only visible when those keys are pressed.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> hover( String selector,
```

### `focus`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.focus()] instead. Read more about [locators].

This method fetches an element with [selector] and focuses it. If there's no element matching [selector], the method waits until a matching element appears in the DOM.

**Usage**

```dart
await frame.focus(selector);
await frame.focus(selector, options);
```

**Arguments**
- `selector` String

A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
- `options` Map *(optional)*
- `strict` bool *(optional)*

When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> focus(String selector,
```

### `blur`

*⚙️ Method*

Removes focus from an element matching the selector.

```dart
Future<void> blur(String selector,
```

### `dblclick`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.dblclick()] instead. Read more about [locators].

This method double clicks an element matching [selector] by performing the following steps:
1. Find an element matching [selector]. If there is none, wait until a matching element is attached to the DOM.
1. Wait for [actionability] checks on the matched element, unless [force] option is set. If the element is detached during the checks, the whole action is retried.
1. Scroll the element into view if needed.
1. Use [page.mouse] to double click in the center of the element, or the specified [position]. if the first click of the `dblclick()` triggers a navigation event, this method will throw.

When all steps combined have not finished during the specified [timeout], this method throws a [TimeoutError]. Passing zero timeout disables this.

**NOTE**
`frame.dblclick()` dispatches two `click` events and a single `dblclick` event.
**Usage**

```dart
await frame.dblclick(selector);
await frame.dblclick(selector, options);
```

**Arguments**
- `selector` String

A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
- `options` Map *(optional)*
- `button` Button *(optional)*

Defaults to `left`.
- `delay` double *(optional)*

Time to wait between `mousedown` and `mouseup` in milliseconds. Defaults to 0.
- `force` bool *(optional)*

Whether to bypass the [actionability] checks. Defaults to `false`.
- `modifiers` List&lt;Modifiers&gt; *(optional)*

Modifier keys to press. Ensures that only these modifiers are pressed during the operation, and then restores current modifiers back. If not specified, currently pressed modifiers are used. "ControlOrMeta" resolves to "Control" on Windows and Linux and to "Meta" on macOS.
- `noWaitAfter` bool *(optional)*

**WARNING**
[Deprecated]
This option has no effect.
This option has no effect.
- `position` Point *(optional)*
- `x` num


- `y` num


A point to use relative to the top-left corner of element padding box. If not specified, uses some visible point of the element.
- `strict` bool *(optional)*

When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
- `trial` bool *(optional)*

When set, this method only performs the [actionability] checks and skips the action. Defaults to `false`. Useful to wait until the element is ready for the action without performing it. Note that keyboard `modifiers` will be pressed regardless of `trial` to allow testing elements which are only visible when those keys are pressed.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> dblclick( String selector,
```

### `type`

*⚙️ Method*

**WARNING**
[Deprecated]

In most cases, you should use [locator.fill()] instead. You only need to press keys one by one if there is special keyboard handling on the page - in this case use [locator.pressSequentially()].

Sends a `keydown`, `keypress`/`input`, and `keyup` event for each character in the text. `frame.type` can be used to send fine-grained keyboard events. To fill values in form fields, use [frame.fill()].

To press a special key, like `Control` or `ArrowDown`, use [keyboard.press()].

**Usage**

**Arguments**
- `selector` String

A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
- `text` String

A text to type into a focused element.
- `options` Map *(optional)*
- `delay` double *(optional)*

Time to wait between key presses in milliseconds. Defaults to 0.
- `noWaitAfter` bool *(optional)*

**WARNING**
[Deprecated]
This option has no effect.
This option has no effect.
- `strict` bool *(optional)*

When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> type( String selector, String text,
```

### `press`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.press()] instead. Read more about [locators].

[key] can specify the intended [keyboardEvent.key] value or a single character to generate the text for. A superset of the [key] values can be found [here]. Examples of the keys are:

`F1` - `F12`, `Digit0`- `Digit9`, `KeyA`- `KeyZ`, `Backquote`, `Minus`, `Equal`, `Backslash`, `Backspace`, `Tab`, `Delete`, `Escape`, `ArrowDown`, `End`, `Enter`, `Home`, `Insert`, `PageDown`, `PageUp`, `ArrowRight`, `ArrowUp`, etc.

Following modification shortcuts are also supported: `Shift`, `Control`, `Alt`, `Meta`, `ShiftLeft`, `ControlOrMeta`. `ControlOrMeta` resolves to `Control` on Windows and Linux and to `Meta` on macOS.

Holding down `Shift` will type the text that corresponds to the [key] in the upper case.

If [key] is a single character, it is case-sensitive, so the values `a` and `A` will generate different respective texts.

Shortcuts such as `key: "Control+o"`, `key: "Control++` or `key: "Control+Shift+T"` are supported as well. When specified with the modifier, modifier is pressed and being held while the subsequent key is being pressed.

**Usage**

```dart
await frame.press(selector, key);
await frame.press(selector, key, options);
```

**Arguments**
- `selector` String

A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
- `key` String

Name of the key to press or a character to generate, such as `ArrowLeft` or `a`.
- `options` Map *(optional)*
- `delay` double *(optional)*

Time to wait between `keydown` and `keyup` in milliseconds. Defaults to 0.
- `noWaitAfter` bool *(optional)*

**WARNING**
[Deprecated]
This option will default to `true` in the future.
Actions that initiate navigations are waiting for these navigations to happen and for pages to start loading. You can opt out of waiting via setting this flag. You would only need this option in the exceptional cases such as navigating to inaccessible pages. Defaults to `false`.
- `strict` bool *(optional)*

When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> press( String selector, String key,
```

### `tap`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.tap()] instead. Read more about [locators].

This method taps an element matching [selector] by performing the following steps:
1. Find an element matching [selector]. If there is none, wait until a matching element is attached to the DOM.
1. Wait for [actionability] checks on the matched element, unless [force] option is set. If the element is detached during the checks, the whole action is retried.
1. Scroll the element into view if needed.
1. Use [page.touchscreen] to tap the center of the element, or the specified [position].

When all steps combined have not finished during the specified [timeout], this method throws a [TimeoutError]. Passing zero timeout disables this.

**NOTE**
`frame.tap()` requires that the `hasTouch` option of the browser context be set to true.
**Usage**

```dart
await frame.tap(selector);
await frame.tap(selector, options);
```

**Arguments**
- `selector` String

A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
- `options` Map *(optional)*
- `force` bool *(optional)*

Whether to bypass the [actionability] checks. Defaults to `false`.
- `modifiers` List&lt;Modifiers&gt; *(optional)*

Modifier keys to press. Ensures that only these modifiers are pressed during the operation, and then restores current modifiers back. If not specified, currently pressed modifiers are used. "ControlOrMeta" resolves to "Control" on Windows and Linux and to "Meta" on macOS.
- `noWaitAfter` bool *(optional)*

**WARNING**
[Deprecated]
This option has no effect.
This option has no effect.
- `position` Point *(optional)*
- `x` num


- `y` num


A point to use relative to the top-left corner of element padding box. If not specified, uses some visible point of the element.
- `strict` bool *(optional)*

When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
- `trial` bool *(optional)*

When set, this method only performs the [actionability] checks and skips the action. Defaults to `false`. Useful to wait until the element is ready for the action without performing it. Note that keyboard `modifiers` will be pressed regardless of `trial` to allow testing elements which are only visible when those keys are pressed.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> tap( String selector,
```

### `content`

*⚙️ Method*

Gets the full HTML contents of the frame, including the doctype.

**Usage**

```dart
await frame.content();
```

**Returns**
- Future&lt;String&gt;

```dart
Future<String> content()
```

### `setContent`

*⚙️ Method*

This method internally calls [document.write()], inheriting all its specific characteristics and behaviors.

**Usage**

```dart
await frame.setContent(html);
await frame.setContent(html, options);
```

**Arguments**
- `html` String

HTML markup to assign to the page.
- `options` Map *(optional)*
- `timeout` double *(optional)*

Maximum operation time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `navigationTimeout` option in the config, or by using the [browserContext.setDefaultNavigationTimeout()], [browserContext.setDefaultTimeout()], [page.setDefaultNavigationTimeout()] or [page.setDefaultTimeout()] methods.
- `waitUntil` LifecycleEvent *(optional)*

When to consider operation succeeded, defaults to `load`. Events can be either:
* `'domcontentloaded'` - consider operation to be finished when the `DOMContentLoaded` event is fired.
* `'load'` - consider operation to be finished when the `load` event is fired.
* `'networkidle'` - **DISCOURAGED** consider operation to be finished when there are no network connections for at least `500` ms. Don't use this method for testing, rely on web assertions to assess readiness instead.
* `'commit'` - consider operation to be finished when network response is received and the document started loading.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> setContent( String html,
```

### `evalOnSelector`

*⚙️ Method*

Evaluates JavaScript on the element matching the selector.

```dart
Future<T> evalOnSelector<T>( String selector, String expression, [ Object? arg, bool? strict, bool? isFunction, ])
```

### `evalOnSelectorAll`

*⚙️ Method*

Evaluates JavaScript on all elements matching the selector.

```dart
Future<T> evalOnSelectorAll<T>( String selector, String expression, [ Object? arg, bool? isFunction, ])
```

### `getAttribute`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.getAttribute()] instead. Read more about [locators].

Returns element attribute value.

**Usage**

```dart
await frame.getAttribute(selector, name);
await frame.getAttribute(selector, name, options);
```

**Arguments**
- `selector` String

A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
- `name` String

Attribute name to get the value for.
- `options` Map *(optional)*
- `strict` bool *(optional)*

When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;[String&gt;]?

```dart
Future<String?> getAttribute( String selector, String name,
```

### `innerHTML`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.innerHTML()] instead. Read more about [locators].

Returns `element.innerHTML`.

**Usage**

```dart
await frame.innerHTML(selector);
await frame.innerHTML(selector, options);
```

**Arguments**
- `selector` String

A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
- `options` Map *(optional)*
- `strict` bool *(optional)*

When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;String&gt;

```dart
Future<String> innerHTML(String selector,
```

### `innerText`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.innerText()] instead. Read more about [locators].

Returns `element.innerText`.

**Usage**

```dart
await frame.innerText(selector);
await frame.innerText(selector, options);
```

**Arguments**
- `selector` String

A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
- `options` Map *(optional)*
- `strict` bool *(optional)*

When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;String&gt;

```dart
Future<String> innerText(String selector,
```

### `inputValue`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.inputValue()] instead. Read more about [locators].

Returns `input.value` for the selected `<input>` or `<textarea>` or `<select>` element.

Throws for non-input elements. However, if the element is inside the `<label>` element that has an associated [control], returns the value of the control.

**Usage**

```dart
await frame.inputValue(selector);
await frame.inputValue(selector, options);
```

**Arguments**
- `selector` String

A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
- `options` Map *(optional)*
- `strict` bool *(optional)*

When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;String&gt;

```dart
Future<String> inputValue(String selector,
```

### `title`

*⚙️ Method*

Returns the page title.

**Usage**

```dart
await frame.title();
```

**Returns**
- Future&lt;String&gt;

```dart
Future<String> title()
```

### `isChecked`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.isChecked()] instead. Read more about [locators].

Returns whether the element is checked. Throws if the element is not a checkbox or radio input.

**Usage**

```dart
await frame.isChecked(selector);
await frame.isChecked(selector, options);
```

**Arguments**
- `selector` String

A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
- `options` Map *(optional)*
- `strict` bool *(optional)*

When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;bool&gt;

```dart
Future<bool> isChecked(String selector,
```

### `isDisabled`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.isDisabled()] instead. Read more about [locators].

Returns whether the element is disabled, the opposite of [enabled].

**Usage**

```dart
await frame.isDisabled(selector);
await frame.isDisabled(selector, options);
```

**Arguments**
- `selector` String

A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
- `options` Map *(optional)*
- `strict` bool *(optional)*

When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;bool&gt;

```dart
Future<bool> isDisabled(String selector,
```

### `isEnabled`

*⚙️ Method*

Returns whether the element is [enabled].

**Usage**

```dart
await frame.isEnabled(selector);
await frame.isEnabled(selector, options);
```

**Arguments**
- `selector` String

A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
- `options` Map *(optional)*
- `strict` bool *(optional)*

When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;bool&gt;

```dart
Future<bool> isEnabled(String selector,
```

### `isHidden`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.isHidden()] instead. Read more about [locators].

Returns whether the element is hidden, the opposite of [visible].  [selector] that does not match any elements is considered hidden.

**Usage**

```dart
await frame.isHidden(selector);
await frame.isHidden(selector, options);
```

**Arguments**
- `selector` String

A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
- `options` Map *(optional)*
- `strict` bool *(optional)*

When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
- `timeout` num *(optional)*

**WARNING**
[Deprecated]
This option is ignored. [frame.isHidden()] does not wait for the element to become hidden and returns immediately.
**Returns**
- Future&lt;bool&gt;

```dart
Future<bool> isHidden(String selector,
```

### `isVisible`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.isVisible()] instead. Read more about [locators].

Returns whether the element is [visible]. [selector] that does not match any elements is considered not visible.

**Usage**

```dart
await frame.isVisible(selector);
await frame.isVisible(selector, options);
```

**Arguments**
- `selector` String

A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
- `options` Map *(optional)*
- `strict` bool *(optional)*

When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
- `timeout` num *(optional)*

**WARNING**
[Deprecated]
This option is ignored. [frame.isVisible()] does not wait for the element to become visible and returns immediately.
**Returns**
- Future&lt;bool&gt;

```dart
Future<bool> isVisible(String selector,
```

### `isEditable`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.isEditable()] instead. Read more about [locators].

Returns whether the element is [editable].

**Usage**

```dart
await frame.isEditable(selector);
await frame.isEditable(selector, options);
```

**Arguments**
- `selector` String

A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
- `options` Map *(optional)*
- `strict` bool *(optional)*

When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;bool&gt;

```dart
Future<bool> isEditable(String selector,
```

### `addScriptTag`

*⚙️ Method*

Returns the added tag when the script's onload fires or when the script content was injected into frame.

Adds a `<script>` tag into the page with the desired url or content.

**Usage**

```dart
await frame.addScriptTag();
await frame.addScriptTag(options);
```

**Arguments**
- `options` Map *(optional)*
- `content` String *(optional)*

Raw JavaScript content to be injected into frame.
- `path` String *(optional)*

Path to the JavaScript file to be injected into frame. If `path` is a relative path, then it is resolved relative to the current working directory.
- `type` String *(optional)*

Script type. Use 'module' in order to load a JavaScript ES6 module. See [script] for more details.
- `url` String *(optional)*

URL of a script to be added.

**Returns**
- Future&lt;[ElementHandle]&gt;

```dart
Future<void> addScriptTag(
```

### `addStyleTag`

*⚙️ Method*

Returns the added tag when the stylesheet's onload fires or when the CSS content was injected into frame.

Adds a `<link rel="stylesheet">` tag into the page with the desired url or a `<style type="text/css">` tag with the content.

**Usage**

```dart
await frame.addStyleTag();
await frame.addStyleTag(options);
```

**Arguments**
- `options` Map *(optional)*
- `content` String *(optional)*

Raw CSS content to be injected into frame.
- `path` String *(optional)*

Path to the CSS file to be injected into frame. If `path` is a relative path, then it is resolved relative to the current working directory.
- `url` String *(optional)*

URL of the `<link>` tag.

**Returns**
- Future&lt;[ElementHandle]&gt;

```dart
Future<void> addStyleTag(
```

### `waitForTimeout`

*⚙️ Method*

**WARNING**
[Discouraged]

Never wait for timeout in production. Tests that wait for time are inherently flaky. Use [Locator] actions and web assertions that wait automatically.

Waits for the given [timeout] in milliseconds.

Note that `frame.waitForTimeout()` should only be used for debugging. Tests using the timer in production are going to be flaky. Use signals such as network events, selectors becoming visible and others instead.

**Usage**

```dart
await frame.waitForTimeout(timeout);
```

**Arguments**
- `timeout` num

A timeout to wait for

**Returns**
- Future&lt;void&gt;


[APIRequest]: /api/class-apirequest.mdx "APIRequest"
[APIRequestContext]: /api/class-apirequestcontext.mdx "APIRequestContext"
[APIResponse]: /api/class-apiresponse.mdx "APIResponse"
[APIResponseAssertions]: /api/class-apiresponseassertions.mdx "APIResponseAssertions"
[Browser]: /api/class-browser.mdx "Browser"
[BrowserContext]: /api/class-browsercontext.mdx "BrowserContext"
[BrowserServer]: /api/class-browserserver.mdx "BrowserServer"
[BrowserType]: /api/class-browsertype.mdx "BrowserType"
[CDPSession]: /api/class-cdpsession.mdx "CDPSession"
[Clock]: /api/class-clock.mdx "Clock"
[ConsoleMessage]: /api/class-consolemessage.mdx "ConsoleMessage"
[Coverage]: /api/class-coverage.mdx "Coverage"
[Credentials]: /api/class-credentials.mdx "Credentials"
[Debugger]: /api/class-debugger.mdx "Debugger"
[Dialog]: /api/class-dialog.mdx "Dialog"
[Disposable]: /api/class-disposable.mdx "Disposable"
[Download]: /api/class-download.mdx "Download"
[ElementHandle]: /api/class-elementhandle.mdx "ElementHandle"
[FileChooser]: /api/class-filechooser.mdx "FileChooser"
[Frame]: /api/class-frame.mdx "Frame"
[FrameLocator]: /api/class-framelocator.mdx "FrameLocator"
[GenericAssertions]: /api/class-genericassertions.mdx "GenericAssertions"
[JSHandle]: /api/class-jshandle.mdx "JSHandle"
[Keyboard]: /api/class-keyboard.mdx "Keyboard"
[Locator]: /api/class-locator.mdx "Locator"
[LocatorAssertions]: /api/class-locatorassertions.mdx "LocatorAssertions"
[Logger]: /api/class-logger.mdx "Logger"
[Mouse]: /api/class-mouse.mdx "Mouse"
[Page]: /api/class-page.mdx "Page"
[PageAssertions]: /api/class-pageassertions.mdx "PageAssertions"
[Playwright]: /api/class-playwright.mdx "Playwright"
[PlaywrightAssertions]: /api/class-playwrightassertions.mdx "PlaywrightAssertions"
[Request]: /api/class-request.mdx "Request"
[Response]: /api/class-response.mdx "Response"
[Route]: /api/class-route.mdx "Route"
[Screencast]: /api/class-screencast.mdx "Screencast"
[Selectors]: /api/class-selectors.mdx "Selectors"
[SnapshotAssertions]: /api/class-snapshotassertions.mdx "SnapshotAssertions"
[TimeoutError]: /api/class-timeouterror.mdx "TimeoutError"
[Touchscreen]: /api/class-touchscreen.mdx "Touchscreen"
[Tracing]: /api/class-tracing.mdx "Tracing"
[Video]: /api/class-video.mdx "Video"
[WebError]: /api/class-weberror.mdx "WebError"
[WebSocket]: /api/class-websocket.mdx "WebSocket"
[WebSocketRoute]: /api/class-websocketroute.mdx "WebSocketRoute"
[WebStorage]: /api/class-webstorage.mdx "WebStorage"
[Worker]: /api/class-worker.mdx "Worker"
[Electron]: /api/class-electron.mdx "Electron"
[ElectronApplication]: /api/class-electronapplication.mdx "ElectronApplication"
[Android]: /api/class-android.mdx "Android"
[AndroidDevice]: /api/class-androiddevice.mdx "AndroidDevice"
[AndroidInput]: /api/class-androidinput.mdx "AndroidInput"
[AndroidSocket]: /api/class-androidsocket.mdx "AndroidSocket"
[AndroidWebView]: /api/class-androidwebview.mdx "AndroidWebView"
[Fixtures]: /api/class-fixtures.mdx "Fixtures"
[FullConfig]: /api/class-fullconfig.mdx "FullConfig"
[FullProject]: /api/class-fullproject.mdx "FullProject"
[Location]: /api/class-location.mdx "Location"
[Test]: /api/class-test.mdx "Test"
[TestConfig]: /api/class-testconfig.mdx "TestConfig"
[TestInfo]: /api/class-testinfo.mdx "TestInfo"
[TestInfoError]: /api/class-testinfoerror.mdx "TestInfoError"
[TestOptions]: /api/class-testoptions.mdx "TestOptions"
[TestProject]: /api/class-testproject.mdx "TestProject"
[TestStepInfo]: /api/class-teststepinfo.mdx "TestStepInfo"
[WorkerInfo]: /api/class-workerinfo.mdx "WorkerInfo"
[Reporter]: /api/class-reporter.mdx "Reporter"
[Suite]: /api/class-suite.mdx "Suite"
[TestCase]: /api/class-testcase.mdx "TestCase"
[TestError]: /api/class-testerror.mdx "TestError"
[TestResult]: /api/class-testresult.mdx "TestResult"
[TestStep]: /api/class-teststep.mdx "TestStep"
[EvaluationArgument]: /evaluating.mdx#evaluation-argument "EvaluationArgument"
[UIEvent.detail]: https://developer.mozilla.org/en-US/docs/Web/API/UIEvent/detail "UIEvent.detail"


[all available image tags]: https://mcr.microsoft.com/en-us/product/playwright/about "all available image tags"
[Microsoft Artifact Registry]: https://mcr.microsoft.com/en-us/product/playwright/about "Microsoft Artifact Registry"
[Dockerfile.noble]: https://github.com/microsoft/playwright/blob/main/utils/docker/Dockerfile.noble "Dockerfile.noble"

```dart
Future<void> waitForTimeout(double waitTimeout)
```

### `waitForFunction`

*⚙️ Method*

Returns when the [pageFunction] returns a truthy value, returns that value.

**Usage**

The [frame.waitForFunction()] can be used to observe viewport size change:

```dart
// Or 'chromium' or 'webkit'.

(() async {
final browser = await firefox.launch();
final page = await browser.newPage();
final watchDog = page.mainFrame().waitForFunction('window.innerWidth < 100');
await page.setViewportSize( width: 50, height: 50 );
await watchDog;
await browser.close();
}
```

To pass an argument to the predicate of `frame.waitForFunction` function:

```dart
final selector = '.foo';
await frame.waitForFunction((selector) => !!document.querySelector(selector), selector);
```

**Arguments**
- `pageFunction` Function | String

Function to be evaluated in the page context.
- `arg` dynamic *(optional)*

Optional argument to pass to [pageFunction].
- `options` Map *(optional)*
- `polling` num | "raf" *(optional)*

If [polling] is `'raf'`, then [pageFunction] is constantly executed in `requestAnimationFrame` callback. If [polling] is a number, then it is treated as an interval in milliseconds at which the function would be executed. Defaults to `raf`.
- `timeout` double *(optional)*

Maximum time to wait for in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;[JSHandle]&gt;

```dart
Future<JSHandle> waitForFunction( String expression,
```

### `dispatchEvent`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.dispatchEvent()] instead. Read more about [locators].

The snippet below dispatches the `click` event on the element. Regardless of the visibility state of the element, `click` is dispatched. This is equivalent to calling [element.click()].

**Usage**

```dart
await frame.dispatchEvent('button#submit', 'click');
```

Under the hood, it creates an instance of an event based on the given [type], initializes it with [eventInit] properties and dispatches it on the element. Events are `composed`, `cancelable` and bubble by default.

Since [eventInit] is event-specific, please refer to the events documentation for the lists of initial properties:
* [DeviceMotionEvent]
* [DeviceOrientationEvent]
* [DragEvent]
* [Event]
* [FocusEvent]
* [KeyboardEvent]
* [MouseEvent]
* [PointerEvent]
* [TouchEvent]
* [WheelEvent]

You can also specify `JSHandle` as the property value if you want live objects to be passed into the event:

```dart
// Note you can only create DataTransfer in Chromium and Firefox
final dataTransfer = await frame.evaluateHandle(() => new DataTransfer());
await frame.dispatchEvent('#source', 'dragstart', { dataTransfer );
```

**Arguments**
- `selector` String

A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
- `type` String

DOM event type: `"click"`, `"dragstart"`, etc.
- `eventInit` dynamic *(optional)*

Optional event-specific initialization properties.
- `options` Map *(optional)*
- `strict` bool *(optional)*

When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> dispatchEvent( String selector, String type,
```

### `highlight`

*⚙️ Method*

Highlights the element matching the selector.

```dart
Future<void> highlight(String selector,
```

### `hideHighlight`

*⚙️ Method*

Hides the highlight on the element matching the selector.

```dart
Future<void> hideHighlight(String selector)
```

### `drop`

*⚙️ Method*

Drops files on the element matching the selector.

```dart
Future<void> drop( String selector,
```

### `frameElement`

*⚙️ Method*

Returns the `frame` or `iframe` element handle which corresponds to this frame.

This is an inverse of [elementHandle.contentFrame()]. Note that returned handle actually belongs to the parent frame.

This method throws an error if the frame has been detached before `frameElement()` returns.

**Usage**

```dart
final frameElement = await frame.frameElement();
final contentFrame = await frameElement.contentFrame();
print(frame == contentFrame);  // -> true
```

**Returns**
- Future&lt;[ElementHandle]&gt;

```dart
Future<ElementHandle> frameElement()
```

### `selectOption`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.selectOption()] instead. Read more about [locators].

This method waits for an element matching [selector], waits for [actionability] checks, waits until all specified options are present in the `<select>` element and selects these options.

If the target element is not a `<select>` element, this method throws an error. However, if the element is inside the `<label>` element that has an associated [control], the control will be used instead.

Returns the array of option values that have been successfully selected.

Triggers a `change` and `input` event once all the provided options have been selected.

**Usage**

```dart
// Single selection matching the value or label
frame.selectOption('select#colors', 'blue');

// single selection matching both the value and the label
frame.selectOption('select#colors', { label: 'Blue' );

// multiple selection
frame.selectOption('select#colors', 'red', 'green', 'blue');
```

**Arguments**
- `selector` String

A selector to query for.
- `values` dynamic
- `value` String *(optional)*

Matches by `option.value`. Optional.
- `label` String *(optional)*

Matches by `option.label`. Optional.
- `index` num *(optional)*

Matches by the index. Optional.

Options to select. If the `<select>` has the `multiple` attribute, all matching options are selected, otherwise only the first option matching one of the passed options is selected. String values are matching both values and labels. Option is considered matching if all specified properties match.
- `options` List&lt;ElementHandleSelectOptionOptionsItems&gt; *(optional)*
- `force` bool *(optional)*

Whether to bypass the [actionability] checks. Defaults to `false`.
- `noWaitAfter` bool *(optional)*

**WARNING**
[Deprecated]
This option has no effect.
This option has no effect.
- `strict` bool *(optional)*

When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;List&lt;String&gt;&gt;

```dart
Future<List<String>> selectOption( String selector, List<SelectOption>? values,
```

### `setInputFiles`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.setInputFiles()] instead. Read more about [locators].

Sets the value of the file input to these file paths or files. If some of the `filePaths` are relative paths, then they are resolved relative to the current working directory. For empty array, clears the selected files.

This method expects [selector] to point to an [input element]. However, if the element is inside the `<label>` element that has an associated [control], targets the control instead.

**Usage**

```dart
await frame.setInputFiles(selector, files);
await frame.setInputFiles(selector, files, options);
```

**Arguments**
- `selector` String

A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
- `files` dynamic
- `name` String

File name
- `mimeType` String

File type
- `buffer` List&lt;int&gt;

File content
- `options` Map *(optional)*
- `noWaitAfter` bool *(optional)*

**WARNING**
[Deprecated]
This option has no effect.
This option has no effect.
- `strict` bool *(optional)*

When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> setInputFiles( String selector, List<InputFile>? files,
```

## `FrameLocator`

```dart
class FrameLocator
```

### `owner`

*⚙️ Method*

Returns a [Locator] object pointing to the same `iframe` as this frame locator.

Useful when you have a [FrameLocator] object obtained somewhere, and later on would like to interact with the `iframe` element.

For a reverse operation, use [locator.contentFrame()].

**Usage**

```dart
final frameLocator = page.locator('iframe[name="embedded"]').contentFrame();
// ...
final locator = frameLocator.owner();
await expect(locator).toBeVisible();
```

**Returns**
- [Locator]

```dart
Locator owner()
```

### `locator`

*⚙️ Method*

The method finds an element matching the specified selector in the locator's subtree. It also accepts filter options, similar to [locator.filter()] method.

[Learn more about locators].

**Usage**

```dart
frameLocator.locator(selectorOrLocator);
frameLocator.locator(selectorOrLocator, options);
```

**Arguments**
- `selectorOrLocator` String | [Locator]

A selector or locator to use when resolving DOM element.
- `options` Map *(optional)*
- `has` [Locator] *(optional)*

Narrows down the results of the method to those which contain elements matching this relative locator. For example, `article` that has `text=Playwright` matches `<article><div>Playwright</div></article>`.

Inner locator **must be relative** to the outer locator and is queried starting with the outer locator match, not the document root. For example, you can find `content` that has `div` in `<article><content><div>Playwright</div></content></article>`. However, looking for `content` that has `article div` will fail, because the inner locator must be relative and should not use any elements outside the `content`.

Note that outer and inner locators must belong to the same frame. Inner locator must not contain [FrameLocator]s.
- `hasNot` [Locator] *(optional)*

Matches elements that do not contain an element that matches an inner locator. Inner locator is queried against the outer one. For example, `article` that does not have `div` matches `<article><span>Playwright</span></article>`.

Note that outer and inner locators must belong to the same frame. Inner locator must not contain [FrameLocator]s.
- `hasNotText` String | [RegExp] *(optional)*

Matches elements that do not contain specified text somewhere inside, possibly in a child or a descendant element. When passed a String, matching is case-insensitive and searches for a substring.
- `hasText` String | [RegExp] *(optional)*

Matches elements containing specified text somewhere inside, possibly in a child or a descendant element. When passed a String, matching is case-insensitive and searches for a substring. For example, `"Playwright"` matches `<article><div>Playwright</div></article>`.

**Returns**
- [Locator]

```dart
Locator locator(String selector)
```

### `frameLocator`

*⚙️ Method*

When working with iframes, you can create a frame locator that will enter the iframe and allow selecting elements in that iframe.

**Usage**

```dart
frameLocator.frameLocator(selector);
```

**Arguments**
- `selector` String

A selector to use when resolving DOM element.

**Returns**
- [FrameLocator]

```dart
FrameLocator frameLocator(String selector)
```

### `first`

*⚙️ Method*

**WARNING**
[Deprecated]

Use [locator.first()] followed by [locator.contentFrame()] instead.

Returns locator to the first matching frame.

**Usage**

```dart
frameLocator.first();
```

**Returns**
- [FrameLocator]

```dart
Locator first()
```

### `last`

*⚙️ Method*

**WARNING**
[Deprecated]

Use [locator.last()] followed by [locator.contentFrame()] instead.

Returns locator to the last matching frame.

**Usage**

```dart
frameLocator.last();
```

**Returns**
- [FrameLocator]

```dart
Locator last()
```

### `nth`

*⚙️ Method*

**WARNING**
[Deprecated]

Use [locator.nth()] followed by [locator.contentFrame()] instead.

Returns locator to the n-th matching frame. It's zero based, `nth(0)` selects the first frame.

**Usage**

```dart
frameLocator.nth(index);
```

**Arguments**
- `index` num

**Returns**
- [FrameLocator]


[APIRequest]: /api/class-apirequest.mdx "APIRequest"
[APIRequestContext]: /api/class-apirequestcontext.mdx "APIRequestContext"
[APIResponse]: /api/class-apiresponse.mdx "APIResponse"
[APIResponseAssertions]: /api/class-apiresponseassertions.mdx "APIResponseAssertions"
[Browser]: /api/class-browser.mdx "Browser"
[BrowserContext]: /api/class-browsercontext.mdx "BrowserContext"
[BrowserServer]: /api/class-browserserver.mdx "BrowserServer"
[BrowserType]: /api/class-browsertype.mdx "BrowserType"
[CDPSession]: /api/class-cdpsession.mdx "CDPSession"
[Clock]: /api/class-clock.mdx "Clock"
[ConsoleMessage]: /api/class-consolemessage.mdx "ConsoleMessage"
[Coverage]: /api/class-coverage.mdx "Coverage"
[Credentials]: /api/class-credentials.mdx "Credentials"
[Debugger]: /api/class-debugger.mdx "Debugger"
[Dialog]: /api/class-dialog.mdx "Dialog"
[Disposable]: /api/class-disposable.mdx "Disposable"
[Download]: /api/class-download.mdx "Download"
[ElementHandle]: /api/class-elementhandle.mdx "ElementHandle"
[FileChooser]: /api/class-filechooser.mdx "FileChooser"
[Frame]: /api/class-frame.mdx "Frame"
[FrameLocator]: /api/class-framelocator.mdx "FrameLocator"
[GenericAssertions]: /api/class-genericassertions.mdx "GenericAssertions"
[JSHandle]: /api/class-jshandle.mdx "JSHandle"
[Keyboard]: /api/class-keyboard.mdx "Keyboard"
[Locator]: /api/class-locator.mdx "Locator"
[LocatorAssertions]: /api/class-locatorassertions.mdx "LocatorAssertions"
[Logger]: /api/class-logger.mdx "Logger"
[Mouse]: /api/class-mouse.mdx "Mouse"
[Page]: /api/class-page.mdx "Page"
[PageAssertions]: /api/class-pageassertions.mdx "PageAssertions"
[Playwright]: /api/class-playwright.mdx "Playwright"
[PlaywrightAssertions]: /api/class-playwrightassertions.mdx "PlaywrightAssertions"
[Request]: /api/class-request.mdx "Request"
[Response]: /api/class-response.mdx "Response"
[Route]: /api/class-route.mdx "Route"
[Screencast]: /api/class-screencast.mdx "Screencast"
[Selectors]: /api/class-selectors.mdx "Selectors"
[SnapshotAssertions]: /api/class-snapshotassertions.mdx "SnapshotAssertions"
[TimeoutError]: /api/class-timeouterror.mdx "TimeoutError"
[Touchscreen]: /api/class-touchscreen.mdx "Touchscreen"
[Tracing]: /api/class-tracing.mdx "Tracing"
[Video]: /api/class-video.mdx "Video"
[WebError]: /api/class-weberror.mdx "WebError"
[WebSocket]: /api/class-websocket.mdx "WebSocket"
[WebSocketRoute]: /api/class-websocketroute.mdx "WebSocketRoute"
[WebStorage]: /api/class-webstorage.mdx "WebStorage"
[Worker]: /api/class-worker.mdx "Worker"
[Electron]: /api/class-electron.mdx "Electron"
[ElectronApplication]: /api/class-electronapplication.mdx "ElectronApplication"
[Android]: /api/class-android.mdx "Android"
[AndroidDevice]: /api/class-androiddevice.mdx "AndroidDevice"
[AndroidInput]: /api/class-androidinput.mdx "AndroidInput"
[AndroidSocket]: /api/class-androidsocket.mdx "AndroidSocket"
[AndroidWebView]: /api/class-androidwebview.mdx "AndroidWebView"
[Fixtures]: /api/class-fixtures.mdx "Fixtures"
[FullConfig]: /api/class-fullconfig.mdx "FullConfig"
[FullProject]: /api/class-fullproject.mdx "FullProject"
[Location]: /api/class-location.mdx "Location"
[Test]: /api/class-test.mdx "Test"
[TestConfig]: /api/class-testconfig.mdx "TestConfig"
[TestInfo]: /api/class-testinfo.mdx "TestInfo"
[TestInfoError]: /api/class-testinfoerror.mdx "TestInfoError"
[TestOptions]: /api/class-testoptions.mdx "TestOptions"
[TestProject]: /api/class-testproject.mdx "TestProject"
[TestStepInfo]: /api/class-teststepinfo.mdx "TestStepInfo"
[WorkerInfo]: /api/class-workerinfo.mdx "WorkerInfo"
[Reporter]: /api/class-reporter.mdx "Reporter"
[Suite]: /api/class-suite.mdx "Suite"
[TestCase]: /api/class-testcase.mdx "TestCase"
[TestError]: /api/class-testerror.mdx "TestError"
[TestResult]: /api/class-testresult.mdx "TestResult"
[TestStep]: /api/class-teststep.mdx "TestStep"
[EvaluationArgument]: /evaluating.mdx#evaluation-argument "EvaluationArgument"
[UIEvent.detail]: https://developer.mozilla.org/en-US/docs/Web/API/UIEvent/detail "UIEvent.detail"


[all available image tags]: https://mcr.microsoft.com/en-us/product/playwright/about "all available image tags"
[Microsoft Artifact Registry]: https://mcr.microsoft.com/en-us/product/playwright/about "Microsoft Artifact Registry"
[Dockerfile.noble]: https://github.com/microsoft/playwright/blob/main/utils/docker/Dockerfile.noble "Dockerfile.noble"

```dart
Locator nth(int index)
```

### `getByText`

*⚙️ Method*

Allows locating elements that contain given text.

See also [locator.filter()] that allows to match by another criteria, like an accessible role, and then filter by the text content.

**Usage**

Consider the following DOM structure:

```html
<div>Hello <span>world</span></div>
<div>Hello</div>
```

You can locate by text substring, exact string, or a regular expression:

```dart
// Matches <span>
page.getByText('world');

// Matches first <div>
page.getByText('Hello world');

// Matches second <div>
page.getByText('Hello', { exact: true );

// Matches both <div>s
page.getByText(/Hello/);

// Matches second <div>
page.getByText(/^hello$/i);
```

**Arguments**
- `text` Pattern

Text to locate the element for.
- `options` Map *(optional)*
- `exact` bool *(optional)*

Whether to find an exact match: case-sensitive and whole-string. Default to false. Ignored when locating by a regular expression. Note that exact match still trims whitespace.

**Returns**
- [Locator]

**Details**

Matching by text always normalizes whitespace, even with exact match. For example, it turns multiple spaces into one, turns line breaks into spaces and ignores leading and trailing whitespace.

Input elements of the type `button` and `submit` are matched by their `value` instead of the text content. For example, locating by text `"Log in"` matches `<input type=button value="Log in">`.

```dart
Locator getByText(Pattern text,
```

### `locator`

*⚙️ Method*

The method finds an element matching the specified selector in the locator's subtree. It also accepts filter options, similar to [locator.filter()] method.

[Learn more about locators].

**Usage**

```dart
frameLocator.locator(selectorOrLocator);
frameLocator.locator(selectorOrLocator, options);
```

**Arguments**
- `selectorOrLocator` String | [Locator]

A selector or locator to use when resolving DOM element.
- `options` Map *(optional)*
- `has` [Locator] *(optional)*

Narrows down the results of the method to those which contain elements matching this relative locator. For example, `article` that has `text=Playwright` matches `<article><div>Playwright</div></article>`.

Inner locator **must be relative** to the outer locator and is queried starting with the outer locator match, not the document root. For example, you can find `content` that has `div` in `<article><content><div>Playwright</div></content></article>`. However, looking for `content` that has `article div` will fail, because the inner locator must be relative and should not use any elements outside the `content`.

Note that outer and inner locators must belong to the same frame. Inner locator must not contain [FrameLocator]s.
- `hasNot` [Locator] *(optional)*

Matches elements that do not contain an element that matches an inner locator. Inner locator is queried against the outer one. For example, `article` that does not have `div` matches `<article><span>Playwright</span></article>`.

Note that outer and inner locators must belong to the same frame. Inner locator must not contain [FrameLocator]s.
- `hasNotText` String | [RegExp] *(optional)*

Matches elements that do not contain specified text somewhere inside, possibly in a child or a descendant element. When passed a String, matching is case-insensitive and searches for a substring.
- `hasText` String | [RegExp] *(optional)*

Matches elements containing specified text somewhere inside, possibly in a child or a descendant element. When passed a String, matching is case-insensitive and searches for a substring. For example, `"Playwright"` matches `<article><div>Playwright</div></article>`.

**Returns**
- [Locator]

```dart
return locator( 'internal:text=$
```

### `getByRole`

*⚙️ Method*

Allows locating elements by their [ARIA role], [ARIA attributes] and [accessible name].

**Usage**

Consider the following DOM structure.

```html
<h3>Sign up</h3>
<label>
<input type="checkbox" /> Subscribe
</label>
<br/>
<button>Submit</button>
```

You can locate each element by its implicit role:

```dart
await expect(page.getByRole('heading', { name: 'Sign up' )).toBeVisible();

await page.getByRole('checkbox', { name: 'Subscribe' ).check();

await page.getByRole('button', { name: /submit/i ).click();
```

**Arguments**
- `role` `"Playwright"` matches `&lt;article&gt;&lt;div&gt;Playwright&lt;/div&gt;&lt;/article&gt;`. /// /// **Returns** /// - Locator String

Required aria role.
- `options` /// The method finds an element matching the specified selector in the locator's subtree. It also accepts filter *(optional)*
- `checked` bool *(optional)*

An attribute that is usually set by `aria-checked` or native `<input type=checkbox>` controls.

Learn more about [`aria-checked`].
- `description` Pattern *(optional)*

Option to match the [accessible description]. By default, matching is case-insensitive and searches for a substring, use [exact] to control this behavior.

Learn more about [accessible description].
- `disabled` bool *(optional)*

An attribute that is usually set by `aria-disabled` or `disabled`.

**NOTE**
Unlike most other attributes, `disabled` is inherited through the DOM hierarchy. Learn more about [`aria-disabled`].
- `exact` bool *(optional)*

Whether [name] and [description] are matched exactly: case-sensitive and whole-string. Defaults to false. Ignored when the value is a regular expression. Note that exact match still trims whitespace.
- `expanded` bool *(optional)*

An attribute that is usually set by `aria-expanded`.

Learn more about [`aria-expanded`].
- `includeHidden` bool *(optional)*

Option that controls whether hidden elements are matched. By default, only non-hidden elements, as [defined by ARIA], are matched by role selector.

Learn more about [`aria-hidden`].
- `level` int *(optional)*

A number attribute that is usually present for roles `heading`, `listitem`, `row`, `treeitem`, with default values for `<h1>-<h6>` elements.

Learn more about [`aria-level`].
- `name` Pattern *(optional)*

Option to match the [accessible name]. By default, matching is case-insensitive and searches for a substring, use [exact] to control this behavior.

Learn more about [accessible name].
- `pressed` bool *(optional)*

An attribute that is usually set by `aria-pressed`.

Learn more about [`aria-pressed`].
- `selected` bool *(optional)*

An attribute that is usually set by `aria-selected`.

Learn more about [`aria-selected`].

**Returns**
- [Locator]

**Details**

Role selector **does not replace** accessibility audits and conformance tests, but rather gives early feedback about the ARIA guidelines.

Many html elements have an implicitly [defined role] that is recognized by the role selector. You can find all the [supported roles here]. ARIA guidelines **do not recommend** duplicating implicit roles and attributes by setting `role` and/or `aria-*` attributes to default values.

```dart
Locator getByRole( /// The method finds an element matching the specified selector in the locator's subtree. It also accepts filter options, similar to [locator.filter()] method. /// /// [Learn more about locators]. /// /// **Usage** /// /// ```dart /// frameLocator.locator(selectorOrLocator)
```

### `getByLabel`

*⚙️ Method*

Allows locating input elements by the text of the associated `<label>` or `aria-labelledby` element, or by the `aria-label` attribute.

**Usage**

For example, this method will find inputs by label "Username" and "Password" in the following DOM:

```html
<input aria-label="Username">
<label for="password-input">Password:</label>
<input id="password-input">
```

```dart
await page.getByLabel('Username').fill('john');
await page.getByLabel('Password').fill('secret');
```

**Arguments**
- `text` Pattern

Text to locate the element for.
- `options` Map *(optional)*
- `exact` bool *(optional)*

Whether to find an exact match: case-sensitive and whole-string. Default to false. Ignored when locating by a regular expression. Note that exact match still trims whitespace.

**Returns**
- [Locator]

```dart
Locator getByLabel(Pattern text,
```

### `locator`

*⚙️ Method*

The method finds an element matching the specified selector in the locator's subtree. It also accepts filter options, similar to [locator.filter()] method.

[Learn more about locators].

**Usage**

```dart
frameLocator.locator(selectorOrLocator);
frameLocator.locator(selectorOrLocator, options);
```

**Arguments**
- `selectorOrLocator` String | [Locator]

A selector or locator to use when resolving DOM element.
- `options` Map *(optional)*
- `has` [Locator] *(optional)*

Narrows down the results of the method to those which contain elements matching this relative locator. For example, `article` that has `text=Playwright` matches `<article><div>Playwright</div></article>`.

Inner locator **must be relative** to the outer locator and is queried starting with the outer locator match, not the document root. For example, you can find `content` that has `div` in `<article><content><div>Playwright</div></content></article>`. However, looking for `content` that has `article div` will fail, because the inner locator must be relative and should not use any elements outside the `content`.

Note that outer and inner locators must belong to the same frame. Inner locator must not contain [FrameLocator]s.
- `hasNot` [Locator] *(optional)*

Matches elements that do not contain an element that matches an inner locator. Inner locator is queried against the outer one. For example, `article` that does not have `div` matches `<article><span>Playwright</span></article>`.

Note that outer and inner locators must belong to the same frame. Inner locator must not contain [FrameLocator]s.
- `hasNotText` String | [RegExp] *(optional)*

Matches elements that do not contain specified text somewhere inside, possibly in a child or a descendant element. When passed a String, matching is case-insensitive and searches for a substring.
- `hasText` String | [RegExp] *(optional)*

Matches elements containing specified text somewhere inside, possibly in a child or a descendant element. When passed a String, matching is case-insensitive and searches for a substring. For example, `"Playwright"` matches `<article><div>Playwright</div></article>`.

**Returns**
- [Locator]

```dart
return locator( 'internal:label=$
```

### `getByPlaceholder`

*⚙️ Method*

Allows locating input elements by the placeholder text.

**Usage**

For example, consider the following DOM structure.

```html
<input type="email" placeholder="name@example.com" />
```

You can fill the input after locating it by the placeholder text:

```dart
await page
.getByPlaceholder('name@example.com')
.fill('playwright@microsoft.com');
```

**Arguments**
- `text` Pattern

Text to locate the element for.
- `options` Map *(optional)*
- `exact` bool *(optional)*

Whether to find an exact match: case-sensitive and whole-string. Default to false. Ignored when locating by a regular expression. Note that exact match still trims whitespace.

**Returns**
- [Locator]

```dart
Locator getByPlaceholder(Pattern text,
```

### `locator`

*⚙️ Method*

The method finds an element matching the specified selector in the locator's subtree. It also accepts filter options, similar to [locator.filter()] method.

[Learn more about locators].

**Usage**

```dart
frameLocator.locator(selectorOrLocator);
frameLocator.locator(selectorOrLocator, options);
```

**Arguments**
- `selectorOrLocator` String | [Locator]

A selector or locator to use when resolving DOM element.
- `options` Map *(optional)*
- `has` [Locator] *(optional)*

Narrows down the results of the method to those which contain elements matching this relative locator. For example, `article` that has `text=Playwright` matches `<article><div>Playwright</div></article>`.

Inner locator **must be relative** to the outer locator and is queried starting with the outer locator match, not the document root. For example, you can find `content` that has `div` in `<article><content><div>Playwright</div></content></article>`. However, looking for `content` that has `article div` will fail, because the inner locator must be relative and should not use any elements outside the `content`.

Note that outer and inner locators must belong to the same frame. Inner locator must not contain [FrameLocator]s.
- `hasNot` [Locator] *(optional)*

Matches elements that do not contain an element that matches an inner locator. Inner locator is queried against the outer one. For example, `article` that does not have `div` matches `<article><span>Playwright</span></article>`.

Note that outer and inner locators must belong to the same frame. Inner locator must not contain [FrameLocator]s.
- `hasNotText` String | [RegExp] *(optional)*

Matches elements that do not contain specified text somewhere inside, possibly in a child or a descendant element. When passed a String, matching is case-insensitive and searches for a substring.
- `hasText` String | [RegExp] *(optional)*

Matches elements containing specified text somewhere inside, possibly in a child or a descendant element. When passed a String, matching is case-insensitive and searches for a substring. For example, `"Playwright"` matches `<article><div>Playwright</div></article>`.

**Returns**
- [Locator]

```dart
return locator( 'internal:attr=[placeholder=$
```

### `getByAltText`

*⚙️ Method*

Allows locating elements by their alt text.

**Usage**

For example, this method will find the image by alt text "Playwright logo":

```html
<img alt='Playwright logo'>
```

```dart
await page.getByAltText('Playwright logo').click();
```

**Arguments**
- `text` Pattern

Text to locate the element for.
- `options` Map *(optional)*
- `exact` bool *(optional)*

Whether to find an exact match: case-sensitive and whole-string. Default to false. Ignored when locating by a regular expression. Note that exact match still trims whitespace.

**Returns**
- [Locator]

```dart
Locator getByAltText(Pattern text,
```

### `locator`

*⚙️ Method*

The method finds an element matching the specified selector in the locator's subtree. It also accepts filter options, similar to [locator.filter()] method.

[Learn more about locators].

**Usage**

```dart
frameLocator.locator(selectorOrLocator);
frameLocator.locator(selectorOrLocator, options);
```

**Arguments**
- `selectorOrLocator` String | [Locator]

A selector or locator to use when resolving DOM element.
- `options` Map *(optional)*
- `has` [Locator] *(optional)*

Narrows down the results of the method to those which contain elements matching this relative locator. For example, `article` that has `text=Playwright` matches `<article><div>Playwright</div></article>`.

Inner locator **must be relative** to the outer locator and is queried starting with the outer locator match, not the document root. For example, you can find `content` that has `div` in `<article><content><div>Playwright</div></content></article>`. However, looking for `content` that has `article div` will fail, because the inner locator must be relative and should not use any elements outside the `content`.

Note that outer and inner locators must belong to the same frame. Inner locator must not contain [FrameLocator]s.
- `hasNot` [Locator] *(optional)*

Matches elements that do not contain an element that matches an inner locator. Inner locator is queried against the outer one. For example, `article` that does not have `div` matches `<article><span>Playwright</span></article>`.

Note that outer and inner locators must belong to the same frame. Inner locator must not contain [FrameLocator]s.
- `hasNotText` String | [RegExp] *(optional)*

Matches elements that do not contain specified text somewhere inside, possibly in a child or a descendant element. When passed a String, matching is case-insensitive and searches for a substring.
- `hasText` String | [RegExp] *(optional)*

Matches elements containing specified text somewhere inside, possibly in a child or a descendant element. When passed a String, matching is case-insensitive and searches for a substring. For example, `"Playwright"` matches `<article><div>Playwright</div></article>`.

**Returns**
- [Locator]

```dart
return locator( 'internal:attr=[alt=$
```

### `getByTitle`

*⚙️ Method*

Allows locating elements by their title attribute.

**Usage**

Consider the following DOM structure.

```html
<span title='Issues count'>25 issues</span>
```

You can check the issues count after locating it by the title text:

```dart
await expect(page.getByTitle('Issues count')).toHaveText('25 issues');
```

**Arguments**
- `text` Pattern

Text to locate the element for.
- `options` Map *(optional)*
- `exact` bool *(optional)*

Whether to find an exact match: case-sensitive and whole-string. Default to false. Ignored when locating by a regular expression. Note that exact match still trims whitespace.

**Returns**
- [Locator]

```dart
Locator getByTitle(Pattern text,
```

### `locator`

*⚙️ Method*

The method finds an element matching the specified selector in the locator's subtree. It also accepts filter options, similar to [locator.filter()] method.

[Learn more about locators].

**Usage**

```dart
frameLocator.locator(selectorOrLocator);
frameLocator.locator(selectorOrLocator, options);
```

**Arguments**
- `selectorOrLocator` String | [Locator]

A selector or locator to use when resolving DOM element.
- `options` Map *(optional)*
- `has` [Locator] *(optional)*

Narrows down the results of the method to those which contain elements matching this relative locator. For example, `article` that has `text=Playwright` matches `<article><div>Playwright</div></article>`.

Inner locator **must be relative** to the outer locator and is queried starting with the outer locator match, not the document root. For example, you can find `content` that has `div` in `<article><content><div>Playwright</div></content></article>`. However, looking for `content` that has `article div` will fail, because the inner locator must be relative and should not use any elements outside the `content`.

Note that outer and inner locators must belong to the same frame. Inner locator must not contain [FrameLocator]s.
- `hasNot` [Locator] *(optional)*

Matches elements that do not contain an element that matches an inner locator. Inner locator is queried against the outer one. For example, `article` that does not have `div` matches `<article><span>Playwright</span></article>`.

Note that outer and inner locators must belong to the same frame. Inner locator must not contain [FrameLocator]s.
- `hasNotText` String | [RegExp] *(optional)*

Matches elements that do not contain specified text somewhere inside, possibly in a child or a descendant element. When passed a String, matching is case-insensitive and searches for a substring.
- `hasText` String | [RegExp] *(optional)*

Matches elements containing specified text somewhere inside, possibly in a child or a descendant element. When passed a String, matching is case-insensitive and searches for a substring. For example, `"Playwright"` matches `<article><div>Playwright</div></article>`.

**Returns**
- [Locator]

```dart
return locator( 'internal:attr=[title=$
```

### `getByTestId`

*⚙️ Method*

Locate element by the test id.

**Usage**

Consider the following DOM structure.

```html
<button data-testid="directions">Itinéraire</button>
```

You can locate the element by its test id:

```dart
await page.getByTestId('directions').click();
```

**Arguments**
- `testId` String

Id to locate the element by.

**Returns**
- [Locator]

**Details**

By default, the `data-testid` attribute is used as a test id. Use [selectors.setTestIdAttribute()] to configure a different test id attribute if necessary.

```dart
// Set custom test id attribute from @playwright/test config:

export default defineConfig(
use: {
testIdAttribute: 'data-pw'
},
);
```

```dart
Locator getByTestId(String testId)
```

### `locator`

*⚙️ Method*

The method finds an element matching the specified selector in the locator's subtree. It also accepts filter options, similar to [locator.filter()] method.

[Learn more about locators].

**Usage**

```dart
frameLocator.locator(selectorOrLocator);
frameLocator.locator(selectorOrLocator, options);
```

**Arguments**
- `selectorOrLocator` String | [Locator]

A selector or locator to use when resolving DOM element.
- `options` Map *(optional)*
- `has` [Locator] *(optional)*

Narrows down the results of the method to those which contain elements matching this relative locator. For example, `article` that has `text=Playwright` matches `<article><div>Playwright</div></article>`.

Inner locator **must be relative** to the outer locator and is queried starting with the outer locator match, not the document root. For example, you can find `content` that has `div` in `<article><content><div>Playwright</div></content></article>`. However, looking for `content` that has `article div` will fail, because the inner locator must be relative and should not use any elements outside the `content`.

Note that outer and inner locators must belong to the same frame. Inner locator must not contain [FrameLocator]s.
- `hasNot` [Locator] *(optional)*

Matches elements that do not contain an element that matches an inner locator. Inner locator is queried against the outer one. For example, `article` that does not have `div` matches `<article><span>Playwright</span></article>`.

Note that outer and inner locators must belong to the same frame. Inner locator must not contain [FrameLocator]s.
- `hasNotText` String | [RegExp] *(optional)*

Matches elements that do not contain specified text somewhere inside, possibly in a child or a descendant element. When passed a String, matching is case-insensitive and searches for a substring.
- `hasText` String | [RegExp] *(optional)*

Matches elements containing specified text somewhere inside, possibly in a child or a descendant element. When passed a String, matching is case-insensitive and searches for a substring. For example, `"Playwright"` matches `<article><div>Playwright</div></article>`.

**Returns**
- [Locator]

```dart
return locator(getByTestIdSelector(testId))
```

## `Locator`

```dart
class Locator
```

### `Locator()`

*🔨 Constructor*

Creates a new locator for the given [frame] and [selector].

```dart
Locator(this.frame, this.selector)
```

### `first`

*⚙️ Method*

Returns locator to the first matching element.

**Usage**

```dart
locator.first();
```

**Returns**
- [Locator]

```dart
Locator first()
```

### `last`

*⚙️ Method*

Returns locator to the last matching element.

**Usage**

```dart
final banana = await page.getByRole('listitem').last();
```

**Returns**
- [Locator]

```dart
Locator last()
```

### `nth`

*⚙️ Method*

Returns locator to the n-th matching element. It's zero based, `nth(0)` selects the first element.

**Usage**

```dart
final banana = await page.getByRole('listitem').nth(2);
```

**Arguments**
- `index` num

**Returns**
- [Locator]

```dart
Locator nth(int index)
```

### `and`

*⚙️ Method*

Creates a locator that matches both this locator and the argument locator.

**Usage**

The following example finds a button with a specific title.

```dart
final button = page.getByRole('button').and(page.getByTitle('Subscribe'));
```

**Arguments**
- `locator` [Locator]

Additional locator to match.

**Returns**
- [Locator]

```dart
Locator and(Locator other)
```

### `or`

*⚙️ Method*

Creates a locator matching all elements that match one or both of the two locators.

Note that when both locators match something, the resulting locator will have multiple matches, potentially causing a [locator strictness] violation.

**Usage**

Consider a scenario where you'd like to click on a "New email" button, but sometimes a security settings dialog shows up instead. In this case, you can wait for either a "New email" button, or a dialog and act accordingly.

**NOTE**
If both "New email" button and security dialog appear on screen, the "or" locator will match both of them, possibly throwing the ["strict mode violation" error]. In this case, you can use [locator.first()] to only match one of them.
```dart
final newEmail = page.getByRole('button', { name: 'New' );
final dialog = page.getByText('Confirm security settings');
await expect(newEmail.or(dialog).first()).toBeVisible();
if (await dialog.isVisible())
await page.getByRole('button', { name: 'Dismiss' ).click();
await newEmail.click();
```

**Arguments**
- `locator` [Locator]

Alternative locator to match.

**Returns**
- [Locator]

```dart
Locator or(Locator other)
```

### `filter`

*⚙️ Method*

This method narrows existing locator according to the options, for example filters by text. It can be chained to filter multiple times.

**Usage**

```dart
final rowLocator = page.locator('tr');
// ...
await rowLocator
.filter( hasText: 'text in column 1' )
.filter( has: page.getByRole('button', { name: 'column 2 button' ) )
.screenshot();
```

**Arguments**
- `options` Map *(optional)*
- `has` Locator *(optional)*

Narrows down the results of the method to those which contain elements matching this relative locator. For example, `article` that has `text=Playwright` matches `<article><div>Playwright</div></article>`.

Inner locator **must be relative** to the outer locator and is queried starting with the outer locator match, not the document root. For example, you can find `content` that has `div` in `<article><content><div>Playwright</div></content></article>`. However, looking for `content` that has `article div` will fail, because the inner locator must be relative and should not use any elements outside the `content`.

Note that outer and inner locators must belong to the same frame. Inner locator must not contain [FrameLocator]s.
- `hasNot` Locator *(optional)*

Matches elements that do not contain an element that matches an inner locator. Inner locator is queried against the outer one. For example, `article` that does not have `div` matches `<article><span>Playwright</span></article>`.

Note that outer and inner locators must belong to the same frame. Inner locator must not contain [FrameLocator]s.
- `hasNotText` Pattern *(optional)*

Matches elements that do not contain specified text somewhere inside, possibly in a child or a descendant element. When passed a String, matching is case-insensitive and searches for a substring.
- `hasText` Pattern *(optional)*

Matches elements containing specified text somewhere inside, possibly in a child or a descendant element. When passed a String, matching is case-insensitive and searches for a substring. For example, `"Playwright"` matches `<article><div>Playwright</div></article>`.
- `visible` bool *(optional)*

Only matches visible or invisible elements.

**Returns**
- [Locator]

```dart
Locator filter(
```

### `contentFrame`

*📦 Property*

Returns a [FrameLocator] object pointing to the same `iframe` as this locator.

Useful when you have a [Locator] object obtained somewhere, and later on would like to interact with the content inside the frame.

For a reverse operation, use [frameLocator.owner()].

**Usage**

```dart
final locator = page.locator('iframe[name="embedded"]');
// ...
final frameLocator = locator.contentFrame;
await frameLocator.getByRole('button').click();
```

**Returns**
- [FrameLocator]

```dart
FrameLocator get contentFrame
```

### `frameLocator`

*⚙️ Method*

When working with iframes, you can create a frame locator that will enter the iframe and allow locating elements in that iframe:

**Usage**

```dart
final locator = page.frameLocator('iframe').getByText('Submit');
await locator.click();
```

**Arguments**
- `selector` String

A selector to use when resolving DOM element.

**Returns**
- [FrameLocator]

```dart
FrameLocator frameLocator(String selectorOrLocator)
```

### `page`

*📦 Property*

A page this locator belongs to.

**Usage**

```dart
locator.page;
```

**Returns**
- [Page]

```dart
Page get page
```

### `describe`

*⚙️ Method*

Describes the locator, description is used in the trace viewer and reports. Returns the locator pointing to the same element.

**Usage**

```dart
final button = page.getByTestId('btn-sub').describe('Subscribe button');
await button.click();
```

**Arguments**
- `description` String

Locator description.

**Returns**
- [Locator]

```dart
Locator describe(String description)
```

### `description`

*⚙️ Method*

Returns locator description previously set with [locator.describe()]. Returns `null` if no custom description has been set. Prefer [locator.toString()] for a human-readable representation, as it uses the description when available.

**Usage**

```dart
final button = page.getByRole('button').describe('Subscribe button');
print(button.description()); // "Subscribe button"

final input = page.getByRole('textbox');
print(input.description()); // null
```

**Returns**
- [String]?

```dart
String? description()
```

### `toString`

*⚙️ Method*

Returns a human-readable representation of the locator, using the [locator.description()] if one exists; otherwise, it generates a string based on the locator's selector.

**Usage**

```dart
locator.toString();
```

**Returns**
- String

```dart
String toString()
```

### `normalize`

*⚙️ Method*

Returns a new locator that uses best practices for referencing the matched element, prioritizing test ids, aria roles, and other user-facing attributes over CSS selectors. This is useful for converting implementation-detail selectors into more resilient, human-readable locators.

**Usage**

```dart
await locator.normalize();
```

**Returns**
- Future&lt;[Locator]&gt;

```dart
Future<Locator> normalize() async
```

### `locator`

*⚙️ Method*

The method finds an element matching the specified selector in the locator's subtree. It also accepts filter options, similar to [locator.filter()] method.

[Learn more about locators].

**Usage**

```dart
locator.locator(selectorOrLocator);
locator.locator(selectorOrLocator, options);
```

**Arguments**
- `selectorOrLocator` String

A selector or locator to use when resolving DOM element.
- `options` Map *(optional)*
- `has` [Locator] *(optional)*

Narrows down the results of the method to those which contain elements matching this relative locator. For example, `article` that has `text=Playwright` matches `<article><div>Playwright</div></article>`.

Inner locator **must be relative** to the outer locator and is queried starting with the outer locator match, not the document root. For example, you can find `content` that has `div` in `<article><content><div>Playwright</div></content></article>`. However, looking for `content` that has `article div` will fail, because the inner locator must be relative and should not use any elements outside the `content`.

Note that outer and inner locators must belong to the same frame. Inner locator must not contain [FrameLocator]s.
- `hasNot` [Locator] *(optional)*

Matches elements that do not contain an element that matches an inner locator. Inner locator is queried against the outer one. For example, `article` that does not have `div` matches `<article><span>Playwright</span></article>`.

Note that outer and inner locators must belong to the same frame. Inner locator must not contain [FrameLocator]s.
- `hasNotText` String | [RegExp] *(optional)*

Matches elements that do not contain specified text somewhere inside, possibly in a child or a descendant element. When passed a String, matching is case-insensitive and searches for a substring.
- `hasText` String | [RegExp] *(optional)*

Matches elements containing specified text somewhere inside, possibly in a child or a descendant element. When passed a String, matching is case-insensitive and searches for a substring. For example, `"Playwright"` matches `<article><div>Playwright</div></article>`.

**Returns**
- [Locator]

```dart
Locator locator(String selectorOrLocator)
```

### `getByText`

*⚙️ Method*

Allows locating elements that contain given text.

See also [locator.filter()] that allows to match by another criteria, like an accessible role, and then filter by the text content.

**Usage**

Consider the following DOM structure:

```html
<div>Hello <span>world</span></div>
<div>Hello</div>
```

You can locate by text substring, exact string, or a regular expression:

```dart
// Matches <span>
page.getByText('world');

// Matches first <div>
page.getByText('Hello world');

// Matches second <div>
page.getByText('Hello', { exact: true );

// Matches both <div>s
page.getByText(/Hello/);

// Matches second <div>
page.getByText(/^hello$/i);
```

**Arguments**
- `text` Pattern

Text to locate the element for.
- `options` Map *(optional)*
- `exact` bool *(optional)*

Whether to find an exact match: case-sensitive and whole-string. Default to false. Ignored when locating by a regular expression. Note that exact match still trims whitespace.

**Returns**
- [Locator]

**Details**

Matching by text always normalizes whitespace, even with exact match. For example, it turns multiple spaces into one, turns line breaks into spaces and ignores leading and trailing whitespace.

Input elements of the type `button` and `submit` are matched by their `value` instead of the text content. For example, locating by text `"Log in"` matches `<input type=button value="Log in">`.

```dart
Locator getByText(Pattern text,
```

### `locator`

*⚙️ Method*

The method finds an element matching the specified selector in the locator's subtree. It also accepts filter options, similar to [locator.filter()] method.

[Learn more about locators].

**Usage**

```dart
locator.locator(selectorOrLocator);
locator.locator(selectorOrLocator, options);
```

**Arguments**
- `selectorOrLocator` String | [Locator]

A selector or locator to use when resolving DOM element.
- `options` Map *(optional)*
- `has` [Locator] *(optional)*

Narrows down the results of the method to those which contain elements matching this relative locator. For example, `article` that has `text=Playwright` matches `<article><div>Playwright</div></article>`.

Inner locator **must be relative** to the outer locator and is queried starting with the outer locator match, not the document root. For example, you can find `content` that has `div` in `<article><content><div>Playwright</div></content></article>`. However, looking for `content` that has `article div` will fail, because the inner locator must be relative and should not use any elements outside the `content`.

Note that outer and inner locators must belong to the same frame. Inner locator must not contain [FrameLocator]s.
- `hasNot` [Locator] *(optional)*

Matches elements that do not contain an element that matches an inner locator. Inner locator is queried against the outer one. For example, `article` that does not have `div` matches `<article><span>Playwright</span></article>`.

Note that outer and inner locators must belong to the same frame. Inner locator must not contain [FrameLocator]s.
- `hasNotText` String | [RegExp] *(optional)*

Matches elements that do not contain specified text somewhere inside, possibly in a child or a descendant element. When passed a String, matching is case-insensitive and searches for a substring.
- `hasText` String | [RegExp] *(optional)*

Matches elements containing specified text somewhere inside, possibly in a child or a descendant element. When passed a String, matching is case-insensitive and searches for a substring. For example, `"Playwright"` matches `<article><div>Playwright</div></article>`.

**Returns**
- [Locator]

```dart
return locator( 'internal:text=$
```

### `getByRole`

*⚙️ Method*

Allows locating elements by their [ARIA role], [ARIA attributes] and [accessible name].

**Usage**

Consider the following DOM structure.

```html
<h3>Sign up</h3>
<label>
<input type="checkbox" /> Subscribe
</label>
<br/>
<button>Submit</button>
```

You can locate each element by its implicit role:

```dart
await expect(page.getByRole('heading', { name: 'Sign up' )).toBeVisible();

await page.getByRole('checkbox', { name: 'Subscribe' ).check();

await page.getByRole('button', { name: /submit/i ).click();
```

**Arguments**
- `role` `"Playwright"` matches `&lt;article&gt;&lt;div&gt;Playwright&lt;/div&gt;&lt;/article&gt;`. /// /// **Returns** /// - Locator String

Required aria role.
- `options` /// The method finds an element matching the specified selector in the locator's subtree. It also accepts filter *(optional)*
- `checked` bool *(optional)*

An attribute that is usually set by `aria-checked` or native `<input type=checkbox>` controls.

Learn more about [`aria-checked`].
- `description` Pattern *(optional)*

Option to match the [accessible description]. By default, matching is case-insensitive and searches for a substring, use [exact] to control this behavior.

Learn more about [accessible description].
- `disabled` bool *(optional)*

An attribute that is usually set by `aria-disabled` or `disabled`.

**NOTE**
Unlike most other attributes, `disabled` is inherited through the DOM hierarchy. Learn more about [`aria-disabled`].
- `exact` bool *(optional)*

Whether [name] and [description] are matched exactly: case-sensitive and whole-string. Defaults to false. Ignored when the value is a regular expression. Note that exact match still trims whitespace.
- `expanded` bool *(optional)*

An attribute that is usually set by `aria-expanded`.

Learn more about [`aria-expanded`].
- `includeHidden` bool *(optional)*

Option that controls whether hidden elements are matched. By default, only non-hidden elements, as [defined by ARIA], are matched by role selector.

Learn more about [`aria-hidden`].
- `level` int *(optional)*

A number attribute that is usually present for roles `heading`, `listitem`, `row`, `treeitem`, with default values for `<h1>-<h6>` elements.

Learn more about [`aria-level`].
- `name` Pattern *(optional)*

Option to match the [accessible name]. By default, matching is case-insensitive and searches for a substring, use [exact] to control this behavior.

Learn more about [accessible name].
- `pressed` bool *(optional)*

An attribute that is usually set by `aria-pressed`.

Learn more about [`aria-pressed`].
- `selected` bool *(optional)*

An attribute that is usually set by `aria-selected`.

Learn more about [`aria-selected`].

**Returns**
- [Locator]

**Details**

Role selector **does not replace** accessibility audits and conformance tests, but rather gives early feedback about the ARIA guidelines.

Many html elements have an implicitly [defined role] that is recognized by the role selector. You can find all the [supported roles here]. ARIA guidelines **do not recommend** duplicating implicit roles and attributes by setting `role` and/or `aria-*` attributes to default values.

```dart
Locator getByRole( /// The method finds an element matching the specified selector in the locator's subtree. It also accepts filter options, similar to [locator.filter()] method. /// /// [Learn more about locators]. /// /// **Usage** /// /// ```dart /// locator.locator(selectorOrLocator)
```

### `getByLabel`

*⚙️ Method*

Allows locating input elements by the text of the associated `<label>` or `aria-labelledby` element, or by the `aria-label` attribute.

**Usage**

For example, this method will find inputs by label "Username" and "Password" in the following DOM:

```html
<input aria-label="Username">
<label for="password-input">Password:</label>
<input id="password-input">
```

```dart
await page.getByLabel('Username').fill('john');
await page.getByLabel('Password').fill('secret');
```

**Arguments**
- `text` Pattern

Text to locate the element for.
- `options` Map *(optional)*
- `exact` bool *(optional)*

Whether to find an exact match: case-sensitive and whole-string. Default to false. Ignored when locating by a regular expression. Note that exact match still trims whitespace.

**Returns**
- [Locator]

```dart
Locator getByLabel(Pattern text,
```

### `locator`

*⚙️ Method*

The method finds an element matching the specified selector in the locator's subtree. It also accepts filter options, similar to [locator.filter()] method.

[Learn more about locators].

**Usage**

```dart
locator.locator(selectorOrLocator);
locator.locator(selectorOrLocator, options);
```

**Arguments**
- `selectorOrLocator` String | [Locator]

A selector or locator to use when resolving DOM element.
- `options` Map *(optional)*
- `has` [Locator] *(optional)*

Narrows down the results of the method to those which contain elements matching this relative locator. For example, `article` that has `text=Playwright` matches `<article><div>Playwright</div></article>`.

Inner locator **must be relative** to the outer locator and is queried starting with the outer locator match, not the document root. For example, you can find `content` that has `div` in `<article><content><div>Playwright</div></content></article>`. However, looking for `content` that has `article div` will fail, because the inner locator must be relative and should not use any elements outside the `content`.

Note that outer and inner locators must belong to the same frame. Inner locator must not contain [FrameLocator]s.
- `hasNot` [Locator] *(optional)*

Matches elements that do not contain an element that matches an inner locator. Inner locator is queried against the outer one. For example, `article` that does not have `div` matches `<article><span>Playwright</span></article>`.

Note that outer and inner locators must belong to the same frame. Inner locator must not contain [FrameLocator]s.
- `hasNotText` String | [RegExp] *(optional)*

Matches elements that do not contain specified text somewhere inside, possibly in a child or a descendant element. When passed a String, matching is case-insensitive and searches for a substring.
- `hasText` String | [RegExp] *(optional)*

Matches elements containing specified text somewhere inside, possibly in a child or a descendant element. When passed a String, matching is case-insensitive and searches for a substring. For example, `"Playwright"` matches `<article><div>Playwright</div></article>`.

**Returns**
- [Locator]

```dart
return locator( 'internal:label=$
```

### `getByPlaceholder`

*⚙️ Method*

Allows locating input elements by the placeholder text.

**Usage**

For example, consider the following DOM structure.

```html
<input type="email" placeholder="name@example.com" />
```

You can fill the input after locating it by the placeholder text:

```dart
await page
.getByPlaceholder('name@example.com')
.fill('playwright@microsoft.com');
```

**Arguments**
- `text` Pattern

Text to locate the element for.
- `options` Map *(optional)*
- `exact` bool *(optional)*

Whether to find an exact match: case-sensitive and whole-string. Default to false. Ignored when locating by a regular expression. Note that exact match still trims whitespace.

**Returns**
- [Locator]

```dart
Locator getByPlaceholder(Pattern text,
```

### `locator`

*⚙️ Method*

The method finds an element matching the specified selector in the locator's subtree. It also accepts filter options, similar to [locator.filter()] method.

[Learn more about locators].

**Usage**

```dart
locator.locator(selectorOrLocator);
locator.locator(selectorOrLocator, options);
```

**Arguments**
- `selectorOrLocator` String | [Locator]

A selector or locator to use when resolving DOM element.
- `options` Map *(optional)*
- `has` [Locator] *(optional)*

Narrows down the results of the method to those which contain elements matching this relative locator. For example, `article` that has `text=Playwright` matches `<article><div>Playwright</div></article>`.

Inner locator **must be relative** to the outer locator and is queried starting with the outer locator match, not the document root. For example, you can find `content` that has `div` in `<article><content><div>Playwright</div></content></article>`. However, looking for `content` that has `article div` will fail, because the inner locator must be relative and should not use any elements outside the `content`.

Note that outer and inner locators must belong to the same frame. Inner locator must not contain [FrameLocator]s.
- `hasNot` [Locator] *(optional)*

Matches elements that do not contain an element that matches an inner locator. Inner locator is queried against the outer one. For example, `article` that does not have `div` matches `<article><span>Playwright</span></article>`.

Note that outer and inner locators must belong to the same frame. Inner locator must not contain [FrameLocator]s.
- `hasNotText` String | [RegExp] *(optional)*

Matches elements that do not contain specified text somewhere inside, possibly in a child or a descendant element. When passed a String, matching is case-insensitive and searches for a substring.
- `hasText` String | [RegExp] *(optional)*

Matches elements containing specified text somewhere inside, possibly in a child or a descendant element. When passed a String, matching is case-insensitive and searches for a substring. For example, `"Playwright"` matches `<article><div>Playwright</div></article>`.

**Returns**
- [Locator]

```dart
return locator( 'internal:attr=[placeholder=$
```

### `getByAltText`

*⚙️ Method*

Allows locating elements by their alt text.

**Usage**

For example, this method will find the image by alt text "Playwright logo":

```html
<img alt='Playwright logo'>
```

```dart
await page.getByAltText('Playwright logo').click();
```

**Arguments**
- `text` Pattern

Text to locate the element for.
- `options` Map *(optional)*
- `exact` bool *(optional)*

Whether to find an exact match: case-sensitive and whole-string. Default to false. Ignored when locating by a regular expression. Note that exact match still trims whitespace.

**Returns**
- [Locator]

```dart
Locator getByAltText(Pattern text,
```

### `locator`

*⚙️ Method*

The method finds an element matching the specified selector in the locator's subtree. It also accepts filter options, similar to [locator.filter()] method.

[Learn more about locators].

**Usage**

```dart
locator.locator(selectorOrLocator);
locator.locator(selectorOrLocator, options);
```

**Arguments**
- `selectorOrLocator` String | [Locator]

A selector or locator to use when resolving DOM element.
- `options` Map *(optional)*
- `has` [Locator] *(optional)*

Narrows down the results of the method to those which contain elements matching this relative locator. For example, `article` that has `text=Playwright` matches `<article><div>Playwright</div></article>`.

Inner locator **must be relative** to the outer locator and is queried starting with the outer locator match, not the document root. For example, you can find `content` that has `div` in `<article><content><div>Playwright</div></content></article>`. However, looking for `content` that has `article div` will fail, because the inner locator must be relative and should not use any elements outside the `content`.

Note that outer and inner locators must belong to the same frame. Inner locator must not contain [FrameLocator]s.
- `hasNot` [Locator] *(optional)*

Matches elements that do not contain an element that matches an inner locator. Inner locator is queried against the outer one. For example, `article` that does not have `div` matches `<article><span>Playwright</span></article>`.

Note that outer and inner locators must belong to the same frame. Inner locator must not contain [FrameLocator]s.
- `hasNotText` String | [RegExp] *(optional)*

Matches elements that do not contain specified text somewhere inside, possibly in a child or a descendant element. When passed a String, matching is case-insensitive and searches for a substring.
- `hasText` String | [RegExp] *(optional)*

Matches elements containing specified text somewhere inside, possibly in a child or a descendant element. When passed a String, matching is case-insensitive and searches for a substring. For example, `"Playwright"` matches `<article><div>Playwright</div></article>`.

**Returns**
- [Locator]

```dart
return locator( 'internal:attr=[alt=$
```

### `getByTitle`

*⚙️ Method*

Allows locating elements by their title attribute.

**Usage**

Consider the following DOM structure.

```html
<span title='Issues count'>25 issues</span>
```

You can check the issues count after locating it by the title text:

```dart
await expect(page.getByTitle('Issues count')).toHaveText('25 issues');
```

**Arguments**
- `text` Pattern

Text to locate the element for.
- `options` Map *(optional)*
- `exact` bool *(optional)*

Whether to find an exact match: case-sensitive and whole-string. Default to false. Ignored when locating by a regular expression. Note that exact match still trims whitespace.

**Returns**
- [Locator]

```dart
Locator getByTitle(Pattern text,
```

### `locator`

*⚙️ Method*

The method finds an element matching the specified selector in the locator's subtree. It also accepts filter options, similar to [locator.filter()] method.

[Learn more about locators].

**Usage**

```dart
locator.locator(selectorOrLocator);
locator.locator(selectorOrLocator, options);
```

**Arguments**
- `selectorOrLocator` String | [Locator]

A selector or locator to use when resolving DOM element.
- `options` Map *(optional)*
- `has` [Locator] *(optional)*

Narrows down the results of the method to those which contain elements matching this relative locator. For example, `article` that has `text=Playwright` matches `<article><div>Playwright</div></article>`.

Inner locator **must be relative** to the outer locator and is queried starting with the outer locator match, not the document root. For example, you can find `content` that has `div` in `<article><content><div>Playwright</div></content></article>`. However, looking for `content` that has `article div` will fail, because the inner locator must be relative and should not use any elements outside the `content`.

Note that outer and inner locators must belong to the same frame. Inner locator must not contain [FrameLocator]s.
- `hasNot` [Locator] *(optional)*

Matches elements that do not contain an element that matches an inner locator. Inner locator is queried against the outer one. For example, `article` that does not have `div` matches `<article><span>Playwright</span></article>`.

Note that outer and inner locators must belong to the same frame. Inner locator must not contain [FrameLocator]s.
- `hasNotText` String | [RegExp] *(optional)*

Matches elements that do not contain specified text somewhere inside, possibly in a child or a descendant element. When passed a String, matching is case-insensitive and searches for a substring.
- `hasText` String | [RegExp] *(optional)*

Matches elements containing specified text somewhere inside, possibly in a child or a descendant element. When passed a String, matching is case-insensitive and searches for a substring. For example, `"Playwright"` matches `<article><div>Playwright</div></article>`.

**Returns**
- [Locator]

```dart
return locator( 'internal:attr=[title=$
```

### `getByTestId`

*⚙️ Method*

Locate element by the test id.

**Usage**

Consider the following DOM structure.

```html
<button data-testid="directions">Itinéraire</button>
```

You can locate the element by its test id:

```dart
await page.getByTestId('directions').click();
```

**Arguments**
- `testId` String

Id to locate the element by.

**Returns**
- [Locator]

**Details**

By default, the `data-testid` attribute is used as a test id. Use [selectors.setTestIdAttribute()] to configure a different test id attribute if necessary.

```dart
// Set custom test id attribute from @playwright/test config:

export default defineConfig(
use: {
testIdAttribute: 'data-pw'
},
);
```

```dart
Locator getByTestId(String testId)
```

### `locator`

*⚙️ Method*

The method finds an element matching the specified selector in the locator's subtree. It also accepts filter options, similar to [locator.filter()] method.

[Learn more about locators].

**Usage**

```dart
locator.locator(selectorOrLocator);
locator.locator(selectorOrLocator, options);
```

**Arguments**
- `selectorOrLocator` String | [Locator]

A selector or locator to use when resolving DOM element.
- `options` Map *(optional)*
- `has` [Locator] *(optional)*

Narrows down the results of the method to those which contain elements matching this relative locator. For example, `article` that has `text=Playwright` matches `<article><div>Playwright</div></article>`.

Inner locator **must be relative** to the outer locator and is queried starting with the outer locator match, not the document root. For example, you can find `content` that has `div` in `<article><content><div>Playwright</div></content></article>`. However, looking for `content` that has `article div` will fail, because the inner locator must be relative and should not use any elements outside the `content`.

Note that outer and inner locators must belong to the same frame. Inner locator must not contain [FrameLocator]s.
- `hasNot` [Locator] *(optional)*

Matches elements that do not contain an element that matches an inner locator. Inner locator is queried against the outer one. For example, `article` that does not have `div` matches `<article><span>Playwright</span></article>`.

Note that outer and inner locators must belong to the same frame. Inner locator must not contain [FrameLocator]s.
- `hasNotText` String | [RegExp] *(optional)*

Matches elements that do not contain specified text somewhere inside, possibly in a child or a descendant element. When passed a String, matching is case-insensitive and searches for a substring.
- `hasText` String | [RegExp] *(optional)*

Matches elements containing specified text somewhere inside, possibly in a child or a descendant element. When passed a String, matching is case-insensitive and searches for a substring. For example, `"Playwright"` matches `<article><div>Playwright</div></article>`.

**Returns**
- [Locator]

```dart
return locator(getByTestIdSelector(testId))
```

### `click`

*⚙️ Method*

Click an element.

**Usage**

Click a button:

```dart
await page.getByRole('button').click();
```

Shift-right-click at a specific position on a canvas:

```dart
await page.locator('canvas').click(
button: 'right',
modifiers: ['Shift'],
position: { x: 23, y: 32 },
);
```

**Arguments**
- `options` Map *(optional)*
- `button` "left" | "right" | "middle" *(optional)*

Defaults to `left`.
- `clickCount` num *(optional)*

defaults to 1. See [UIEvent.detail].
- `delay` num *(optional)*

Time to wait between `mousedown` and `mouseup` in milliseconds. Defaults to 0.
- `force` bool *(optional)*

Whether to bypass the [actionability] checks. Defaults to `false`.
- `modifiers` List&lt;"Alt" | "Control" | "ControlOrMeta" | "Meta" | "Shift"&gt; *(optional)*

Modifier keys to press. Ensures that only these modifiers are pressed during the operation, and then restores current modifiers back. If not specified, currently pressed modifiers are used. "ControlOrMeta" resolves to "Control" on Windows and Linux and to "Meta" on macOS.
- `noWaitAfter` bool *(optional)*

**WARNING**
[Deprecated]
This option will default to `true` in the future.
Actions that initiate navigations are waiting for these navigations to happen and for pages to start loading. You can opt out of waiting via setting this flag. You would only need this option in the exceptional cases such as navigating to inaccessible pages. Defaults to `false`.
- `position` Map *(optional)*
- `x` num


- `y` num


A point to use relative to the top-left corner of element padding box. If not specified, uses some visible point of the element.
- `steps` num *(optional)*

Defaults to 1. Sends `n` interpolated `mousemove` events to represent travel between Playwright's current cursor position and the provided destination. When set to 1, emits a single `mousemove` event at the destination location.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
- `trial` bool *(optional)*

When set, this method only performs the [actionability] checks and skips the action. Defaults to `false`. Useful to wait until the element is ready for the action without performing it. Note that keyboard `modifiers` will be pressed regardless of `trial` to allow testing elements which are only visible when those keys are pressed.

**Returns**
- Future&lt;void&gt;

**Details**

This method clicks the element by performing the following steps:
1. Wait for [actionability] checks on the element, unless [force] option is set.
1. Scroll the element into view if needed.
1. Use [page.mouse] to click in the center of the element, or the specified [position].
1. Wait for initiated navigations to either succeed or fail, unless [noWaitAfter] option is set.

If the element is detached from the DOM at any moment during the action, this method throws.

When all steps combined have not finished during the specified [timeout], this method throws a [TimeoutError]. Passing zero timeout disables this.

```dart
Future<void> click(
```

### `fill`

*⚙️ Method*

Set a value to the input field.

**Usage**

```dart
await page.getByRole('textbox').fill('example value');
```

**Arguments**
- `value` String

Value to set for the `<input>`, `<textarea>` or `[contenteditable]` element.
- `options` Map *(optional)*
- `force` bool *(optional)*

Whether to bypass the [actionability] checks. Defaults to `false`.
- `noWaitAfter` bool *(optional)*

**WARNING**
[Deprecated]
This option has no effect.
This option has no effect.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;void&gt;

**Details**

This method waits for [actionability] checks, focuses the element, fills it and triggers an `input` event after filling. Note that you can pass an empty string to clear the input field.

If the target element is not an `<input>`, `<textarea>` or `[contenteditable]` element, this method throws an error. However, if the element is inside the `<label>` element that has an associated [control], the control will be filled instead.

To send fine-grained keyboard events, use [locator.pressSequentially()].

```dart
Future<void> fill(String value,
```

### `clear`

*⚙️ Method*

Clear the input field.

**Usage**

```dart
await page.getByRole('textbox').clear();
```

**Arguments**
- `options` Map *(optional)*
- `force` bool *(optional)*

Whether to bypass the [actionability] checks. Defaults to `false`.
- `noWaitAfter` bool *(optional)*

**WARNING**
[Deprecated]
This option has no effect.
This option has no effect.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;void&gt;

**Details**

This method waits for [actionability] checks, focuses the element, clears it and triggers an `input` event after clearing.

If the target element is not an `<input>`, `<textarea>` or `[contenteditable]` element, this method throws an error. However, if the element is inside the `<label>` element that has an associated [control], the control will be cleared instead.

```dart
Future<void> clear(
```

### `fill`

*⚙️ Method*

Set a value to the input field.

**Usage**

```dart
await page.getByRole('textbox').fill('example value');
```

**Arguments**
- `value` String

Value to set for the `<input>`, `<textarea>` or `[contenteditable]` element.
- `options` Map *(optional)*
- `force` force: *(optional)*

Whether to bypass the [actionability] checks. Defaults to `false`.
- `noWaitAfter` bool *(optional)*

**WARNING**
[Deprecated]
This option has no effect.
This option has no effect.
- `timeout` timeout: *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;void&gt;

**Details**

This method waits for [actionability] checks, focuses the element, fills it and triggers an `input` event after filling. Note that you can pass an empty string to clear the input field.

If the target element is not an `<input>`, `<textarea>` or `[contenteditable]` element, this method throws an error. However, if the element is inside the `<label>` element that has an associated [control], the control will be filled instead.

To send fine-grained keyboard events, use [locator.pressSequentially()].

```dart
fill('', force: force, timeout: timeout)
```

### `setChecked`

*⚙️ Method*

Set the state of a checkbox or a radio element.

**Usage**

```dart
await page.getByRole('checkbox').setChecked(true);
```

**Arguments**
- `checked` bool

Whether to check or uncheck the checkbox.
- `options` Map *(optional)*
- `force` bool *(optional)*

Whether to bypass the [actionability] checks. Defaults to `false`.
- `noWaitAfter` bool *(optional)*

**WARNING**
[Deprecated]
This option has no effect.
This option has no effect.
- `position` Map *(optional)*
- `x` num


- `y` num


A point to use relative to the top-left corner of element padding box. If not specified, uses some visible point of the element.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
- `trial` bool *(optional)*

When set, this method only performs the [actionability] checks and skips the action. Defaults to `false`. Useful to wait until the element is ready for the action without performing it.

**Returns**
- Future&lt;void&gt;

**Details**

This method checks or unchecks an element by performing the following steps:
1. Ensure that matched element is a checkbox or a radio input. If not, this method throws.
1. If the element already has the right checked state, this method returns immediately.
1. Wait for [actionability] checks on the matched element, unless [force] option is set. If the element is detached during the checks, the whole action is retried.
1. Scroll the element into view if needed.
1. Use [page.mouse] to click in the center of the element.
1. Ensure that the element is now checked or unchecked. If not, this method throws.

When all steps combined have not finished during the specified [timeout], this method throws a [TimeoutError]. Passing zero timeout disables this.

```dart
Future<void> setChecked(bool checked,
```

### `check`

*⚙️ Method*

Ensure that checkbox or radio element is checked.

**Usage**

```dart
await page.getByRole('checkbox').check();
```

**Arguments**
- `options` Map *(optional)*
- `force` force: *(optional)*

Whether to bypass the [actionability] checks. Defaults to `false`.
- `noWaitAfter` bool *(optional)*

**WARNING**
[Deprecated]
This option has no effect.
This option has no effect.
- `position` Map *(optional)*
- `x` num


- `y` num


A point to use relative to the top-left corner of element padding box. If not specified, uses some visible point of the element.
- `timeout` timeout: *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
- `trial` bool *(optional)*

When set, this method only performs the [actionability] checks and skips the action. Defaults to `false`. Useful to wait until the element is ready for the action without performing it.

**Returns**
- Future&lt;void&gt;

**Details**

Performs the following steps:
1. Ensure that element is a checkbox or a radio input. If not, this method throws. If the element is already checked, this method returns immediately.
1. Wait for [actionability] checks on the element, unless [force] option is set.
1. Scroll the element into view if needed.
1. Use [page.mouse] to click in the center of the element.
1. Ensure that the element is now checked. If not, this method throws.

If the element is detached from the DOM at any moment during the action, this method throws.

When all steps combined have not finished during the specified [timeout], this method throws a [TimeoutError]. Passing zero timeout disables this.

```dart
await check(force: force, timeout: timeout)
```

### `check`

*⚙️ Method*

Ensure that checkbox or radio element is checked.

**Usage**

```dart
await page.getByRole('checkbox').check();
```

**Arguments**
- `options` Map *(optional)*
- `force` bool *(optional)*

Whether to bypass the [actionability] checks. Defaults to `false`.
- `noWaitAfter` bool *(optional)*

**WARNING**
[Deprecated]
This option has no effect.
This option has no effect.
- `position` Map *(optional)*
- `x` num


- `y` num


A point to use relative to the top-left corner of element padding box. If not specified, uses some visible point of the element.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
- `trial` bool *(optional)*

When set, this method only performs the [actionability] checks and skips the action. Defaults to `false`. Useful to wait until the element is ready for the action without performing it.

**Returns**
- Future&lt;void&gt;

**Details**

Performs the following steps:
1. Ensure that element is a checkbox or a radio input. If not, this method throws. If the element is already checked, this method returns immediately.
1. Wait for [actionability] checks on the element, unless [force] option is set.
1. Scroll the element into view if needed.
1. Use [page.mouse] to click in the center of the element.
1. Ensure that the element is now checked. If not, this method throws.

If the element is detached from the DOM at any moment during the action, this method throws.

When all steps combined have not finished during the specified [timeout], this method throws a [TimeoutError]. Passing zero timeout disables this.

```dart
Future<void> check(
```

### `uncheck`

*⚙️ Method*

Ensure that checkbox or radio element is unchecked.

**Usage**

```dart
await page.getByRole('checkbox').uncheck();
```

**Arguments**
- `options` Map *(optional)*
- `force` bool *(optional)*

Whether to bypass the [actionability] checks. Defaults to `false`.
- `noWaitAfter` bool *(optional)*

**WARNING**
[Deprecated]
This option has no effect.
This option has no effect.
- `position` Map *(optional)*
- `x` num


- `y` num


A point to use relative to the top-left corner of element padding box. If not specified, uses some visible point of the element.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
- `trial` bool *(optional)*

When set, this method only performs the [actionability] checks and skips the action. Defaults to `false`. Useful to wait until the element is ready for the action without performing it.

**Returns**
- Future&lt;void&gt;

**Details**

This method unchecks the element by performing the following steps:
1. Ensure that element is a checkbox or a radio input. If not, this method throws. If the element is already unchecked, this method returns immediately.
1. Wait for [actionability] checks on the element, unless [force] option is set.
1. Scroll the element into view if needed.
1. Use [page.mouse] to click in the center of the element.
1. Ensure that the element is now unchecked. If not, this method throws.

If the element is detached from the DOM at any moment during the action, this method throws.

When all steps combined have not finished during the specified [timeout], this method throws a [TimeoutError]. Passing zero timeout disables this.

```dart
Future<void> uncheck(
```

### `innerText`

*⚙️ Method*

Returns the [`element.innerText`].

**WARNING**
[Asserting text]

If you need to assert text on the page, prefer [expect(locator).toHaveText()] with [useInnerText] option to avoid flakiness. See [assertions guide] for more details.
**Usage**

```dart
await locator.innerText();
await locator.innerText(options);
```

**Arguments**
- `options` Map *(optional)*
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;String&gt;

```dart
Future<String> innerText(
```

### `textContent`

*⚙️ Method*

Returns the [`node.textContent`].

**WARNING**
[Asserting text]

If you need to assert text on the page, prefer [expect(locator).toHaveText()] to avoid flakiness. See [assertions guide] for more details.
**Usage**

```dart
await locator.textContent();
await locator.textContent(options);
```

**Arguments**
- `options` Map *(optional)*
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;[String&gt;]?

```dart
Future<String> textContent(
```

### `hover`

*⚙️ Method*

Hover over the matching element.

**Usage**

```dart
await page.getByRole('link').hover();
```

**Arguments**
- `options` Map *(optional)*
- `force` bool *(optional)*

Whether to bypass the [actionability] checks. Defaults to `false`.
- `modifiers` List&lt;"Alt" | "Control" | "ControlOrMeta" | "Meta" | "Shift"&gt; *(optional)*

Modifier keys to press. Ensures that only these modifiers are pressed during the operation, and then restores current modifiers back. If not specified, currently pressed modifiers are used. "ControlOrMeta" resolves to "Control" on Windows and Linux and to "Meta" on macOS.
- `noWaitAfter` bool *(optional)*

**WARNING**
[Deprecated]
This option has no effect.
This option has no effect.
- `position` Map *(optional)*
- `x` num


- `y` num


A point to use relative to the top-left corner of element padding box. If not specified, uses some visible point of the element.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
- `trial` bool *(optional)*

When set, this method only performs the [actionability] checks and skips the action. Defaults to `false`. Useful to wait until the element is ready for the action without performing it. Note that keyboard `modifiers` will be pressed regardless of `trial` to allow testing elements which are only visible when those keys are pressed.

**Returns**
- Future&lt;void&gt;

**Details**

This method hovers over the element by performing the following steps:
1. Wait for [actionability] checks on the element, unless [force] option is set.
1. Scroll the element into view if needed.
1. Use [page.mouse] to hover over the center of the element, or the specified [position].

If the element is detached from the DOM at any moment during the action, this method throws.

When all steps combined have not finished during the specified [timeout], this method throws a [TimeoutError]. Passing zero timeout disables this.

```dart
Future<void> hover(
```

### `focus`

*⚙️ Method*

Calls [focus] on the matching element.

**Usage**

```dart
await locator.focus();
await locator.focus(options);
```

**Arguments**
- `options` Map *(optional)*
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> focus(
```

### `blur`

*⚙️ Method*

Calls [blur] on the element.

**Usage**

```dart
await locator.blur();
await locator.blur(options);
```

**Arguments**
- `options` Map *(optional)*
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> blur(
```

### `dblclick`

*⚙️ Method*

Double-click an element.

**Usage**

```dart
await locator.dblclick();
await locator.dblclick(options);
```

**Arguments**
- `options` Map *(optional)*
- `button` "left" | "right" | "middle" *(optional)*

Defaults to `left`.
- `delay` num *(optional)*

Time to wait between `mousedown` and `mouseup` in milliseconds. Defaults to 0.
- `force` bool *(optional)*

Whether to bypass the [actionability] checks. Defaults to `false`.
- `modifiers` List&lt;"Alt" | "Control" | "ControlOrMeta" | "Meta" | "Shift"&gt; *(optional)*

Modifier keys to press. Ensures that only these modifiers are pressed during the operation, and then restores current modifiers back. If not specified, currently pressed modifiers are used. "ControlOrMeta" resolves to "Control" on Windows and Linux and to "Meta" on macOS.
- `noWaitAfter` bool *(optional)*

**WARNING**
[Deprecated]
This option has no effect.
This option has no effect.
- `position` Map *(optional)*
- `x` num


- `y` num


A point to use relative to the top-left corner of element padding box. If not specified, uses some visible point of the element.
- `steps` num *(optional)*

Defaults to 1. Sends `n` interpolated `mousemove` events to represent travel between Playwright's current cursor position and the provided destination. When set to 1, emits a single `mousemove` event at the destination location.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
- `trial` bool *(optional)*

When set, this method only performs the [actionability] checks and skips the action. Defaults to `false`. Useful to wait until the element is ready for the action without performing it. Note that keyboard `modifiers` will be pressed regardless of `trial` to allow testing elements which are only visible when those keys are pressed.

**Returns**
- Future&lt;void&gt;

**Details**

This method double clicks the element by performing the following steps:
1. Wait for [actionability] checks on the element, unless [force] option is set.
1. Scroll the element into view if needed.
1. Use [page.mouse] to double click in the center of the element, or the specified [position].

If the element is detached from the DOM at any moment during the action, this method throws.

When all steps combined have not finished during the specified [timeout], this method throws a [TimeoutError]. Passing zero timeout disables this.

**NOTE**
`element.dblclick()` dispatches two `click` events and a single `dblclick` event.

```dart
Future<void> dblclick(
```

### `getAttribute`

*⚙️ Method*

Returns the matching element's attribute value.

**WARNING**
[Asserting attributes]

If you need to assert an element's attribute, prefer [expect(locator).toHaveAttribute()] to avoid flakiness. See [assertions guide] for more details.
**Usage**

```dart
await locator.getAttribute(name);
await locator.getAttribute(name, options);
```

**Arguments**
- `name` String

Attribute name to get the value for.
- `options` Map *(optional)*
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;[String&gt;]?

```dart
Future<String?> getAttribute(String name,
```

### `inputValue`

*⚙️ Method*

Returns the value for the matching `<input>` or `<textarea>` or `<select>` element.

**WARNING**
[Asserting value]

If you need to assert input value, prefer [expect(locator).toHaveValue()] to avoid flakiness. See [assertions guide] for more details.
**Usage**

```dart
final value = await page.getByRole('textbox').inputValue();
```

**Arguments**
- `options` Map *(optional)*
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;String&gt;

**Details**

Throws elements that are not an input, textarea or a select. However, if the element is inside the `<label>` element that has an associated [control], returns the value of the control.

```dart
Future<String> inputValue(
```

### `isVisible`

*⚙️ Method*

Returns whether the element is [visible].

**WARNING**
[Asserting visibility]

If you need to assert that element is visible, prefer [expect(locator).toBeVisible()] to avoid flakiness. See [assertions guide] for more details.
**Usage**

```dart
final visible = await page.getByRole('button').isVisible();
```

**Arguments**
- `options` Map *(optional)*
- `timeout` num *(optional)*

**WARNING**
[Deprecated]
This option is ignored. [locator.isVisible()] does not wait for the element to become visible and returns immediately.
**Returns**
- Future&lt;bool&gt;

```dart
Future<bool> isVisible() async
```

### `innerHTML`

*⚙️ Method*

Returns the [`element.innerHTML`].

**Usage**

```dart
await locator.innerHTML();
await locator.innerHTML(options);
```

**Arguments**
- `options` Map *(optional)*
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;String&gt;

```dart
Future<String> innerHTML(
```

### `isEditable`

*⚙️ Method*

Returns whether the element is [editable]. If the target element is not an `<input>`, `<textarea>`, `<select>`, `[contenteditable]` and does not have a role allowing `[aria-readonly]`, this method throws an error.

**WARNING**
[Asserting editable state]

If you need to assert that an element is editable, prefer [expect(locator).toBeEditable()] to avoid flakiness. See [assertions guide] for more details.
**Usage**

```dart
final editable = await page.getByRole('textbox').isEditable();
```

**Arguments**
- `options` Map *(optional)*
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;bool&gt;

```dart
Future<bool> isEditable(
```

### `isHidden`

*⚙️ Method*

Returns whether the element is hidden, the opposite of [visible].

**WARNING**
[Asserting visibility]

If you need to assert that element is hidden, prefer [expect(locator).toBeHidden()] to avoid flakiness. See [assertions guide] for more details.
**Usage**

```dart
final hidden = await page.getByRole('button').isHidden();
```

**Arguments**
- `options` Map *(optional)*
- `timeout` num *(optional)*

**WARNING**
[Deprecated]
This option is ignored. [locator.isHidden()] does not wait for the element to become hidden and returns immediately.
**Returns**
- Future&lt;bool&gt;

```dart
Future<bool> isHidden() async
```

### `isEnabled`

*⚙️ Method*

Returns whether the element is [enabled].

**WARNING**
[Asserting enabled state]

If you need to assert that an element is enabled, prefer [expect(locator).toBeEnabled()] to avoid flakiness. See [assertions guide] for more details.
**Usage**

```dart
final enabled = await page.getByRole('button').isEnabled();
```

**Arguments**
- `options` Map *(optional)*
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;bool&gt;

```dart
Future<bool> isEnabled(
```

### `isDisabled`

*⚙️ Method*

Returns whether the element is disabled, the opposite of [enabled].

**WARNING**
[Asserting disabled state]

If you need to assert that an element is disabled, prefer [expect(locator).toBeDisabled()] to avoid flakiness. See [assertions guide] for more details.
**Usage**

```dart
final disabled = await page.getByRole('button').isDisabled();
```

**Arguments**
- `options` Map *(optional)*
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;bool&gt;

```dart
Future<bool> isDisabled(
```

### `isChecked`

*⚙️ Method*

Returns whether the element is checked. Throws if the element is not a checkbox or radio input.

**WARNING**
[Asserting checked state]

If you need to assert that checkbox is checked, prefer [expect(locator).toBeChecked()] to avoid flakiness. See [assertions guide] for more details.
**Usage**

```dart
final checked = await page.getByRole('checkbox').isChecked();
```

**Arguments**
- `options` Map *(optional)*
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;bool&gt;

```dart
Future<bool> isChecked(
```

### `evaluateAll`

*⚙️ Method*

Execute JavaScript code in the page, taking all matching elements as an argument.

**Usage**

```dart
final locator = page.locator('div');
final moreThanTen = await locator.evaluateAll((divs, min) => divs.length > min, 10);
```

**Arguments**
- `pageFunction` Function | String

Function to be evaluated in the page context.
- `arg` dynamic *(optional)*

Optional argument to pass to [pageFunction].

**Returns**
- Future&lt;[Serializable]&gt;

**Details**

Returns the return value of [pageFunction], called with an array of all matching elements as a first argument, and [arg] as a second argument.

If [pageFunction] returns a Future, this method will wait for the future to complete and return its value.

If [pageFunction] throws or rejects, this method throws.

```dart
Future<T> evaluateAll<T>(String expression, [Object? arg]) async
```

### `type`

*⚙️ Method*

**WARNING**
[Deprecated]

In most cases, you should use [locator.fill()] instead. You only need to press keys one by one if there is special keyboard handling on the page - in this case use [locator.pressSequentially()].

Focuses the element, and then sends a `keydown`, `keypress`/`input`, and `keyup` event for each character in the text.

To press a special key, like `Control` or `ArrowDown`, use [locator.press()].

**Usage**

**Arguments**
- `text` String

A text to type into a focused element.
- `options` Map *(optional)*
- `delay` double *(optional)*

Time to wait between key presses in milliseconds. Defaults to 0.
- `noWaitAfter` bool *(optional)*

**WARNING**
[Deprecated]
This option has no effect.
This option has no effect.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;void&gt;


[APIRequest]: /api/class-apirequest.mdx "APIRequest"
[APIRequestContext]: /api/class-apirequestcontext.mdx "APIRequestContext"
[APIResponse]: /api/class-apiresponse.mdx "APIResponse"
[APIResponseAssertions]: /api/class-apiresponseassertions.mdx "APIResponseAssertions"
[Browser]: /api/class-browser.mdx "Browser"
[BrowserContext]: /api/class-browsercontext.mdx "BrowserContext"
[BrowserServer]: /api/class-browserserver.mdx "BrowserServer"
[BrowserType]: /api/class-browsertype.mdx "BrowserType"
[CDPSession]: /api/class-cdpsession.mdx "CDPSession"
[Clock]: /api/class-clock.mdx "Clock"
[ConsoleMessage]: /api/class-consolemessage.mdx "ConsoleMessage"
[Coverage]: /api/class-coverage.mdx "Coverage"
[Credentials]: /api/class-credentials.mdx "Credentials"
[Debugger]: /api/class-debugger.mdx "Debugger"
[Dialog]: /api/class-dialog.mdx "Dialog"
[Disposable]: /api/class-disposable.mdx "Disposable"
[Download]: /api/class-download.mdx "Download"
[ElementHandle]: /api/class-elementhandle.mdx "ElementHandle"
[FileChooser]: /api/class-filechooser.mdx "FileChooser"
[Frame]: /api/class-frame.mdx "Frame"
[FrameLocator]: /api/class-framelocator.mdx "FrameLocator"
[GenericAssertions]: /api/class-genericassertions.mdx "GenericAssertions"
[JSHandle]: /api/class-jshandle.mdx "JSHandle"
[Keyboard]: /api/class-keyboard.mdx "Keyboard"
[Locator]: /api/class-locator.mdx "Locator"
[LocatorAssertions]: /api/class-locatorassertions.mdx "LocatorAssertions"
[Logger]: /api/class-logger.mdx "Logger"
[Mouse]: /api/class-mouse.mdx "Mouse"
[Page]: /api/class-page.mdx "Page"
[PageAssertions]: /api/class-pageassertions.mdx "PageAssertions"
[Playwright]: /api/class-playwright.mdx "Playwright"
[PlaywrightAssertions]: /api/class-playwrightassertions.mdx "PlaywrightAssertions"
[Request]: /api/class-request.mdx "Request"
[Response]: /api/class-response.mdx "Response"
[Route]: /api/class-route.mdx "Route"
[Screencast]: /api/class-screencast.mdx "Screencast"
[Selectors]: /api/class-selectors.mdx "Selectors"
[SnapshotAssertions]: /api/class-snapshotassertions.mdx "SnapshotAssertions"
[TimeoutError]: /api/class-timeouterror.mdx "TimeoutError"
[Touchscreen]: /api/class-touchscreen.mdx "Touchscreen"
[Tracing]: /api/class-tracing.mdx "Tracing"
[Video]: /api/class-video.mdx "Video"
[WebError]: /api/class-weberror.mdx "WebError"
[WebSocket]: /api/class-websocket.mdx "WebSocket"
[WebSocketRoute]: /api/class-websocketroute.mdx "WebSocketRoute"
[WebStorage]: /api/class-webstorage.mdx "WebStorage"
[Worker]: /api/class-worker.mdx "Worker"
[Electron]: /api/class-electron.mdx "Electron"
[ElectronApplication]: /api/class-electronapplication.mdx "ElectronApplication"
[Android]: /api/class-android.mdx "Android"
[AndroidDevice]: /api/class-androiddevice.mdx "AndroidDevice"
[AndroidInput]: /api/class-androidinput.mdx "AndroidInput"
[AndroidSocket]: /api/class-androidsocket.mdx "AndroidSocket"
[AndroidWebView]: /api/class-androidwebview.mdx "AndroidWebView"
[Fixtures]: /api/class-fixtures.mdx "Fixtures"
[FullConfig]: /api/class-fullconfig.mdx "FullConfig"
[FullProject]: /api/class-fullproject.mdx "FullProject"
[Location]: /api/class-location.mdx "Location"
[Test]: /api/class-test.mdx "Test"
[TestConfig]: /api/class-testconfig.mdx "TestConfig"
[TestInfo]: /api/class-testinfo.mdx "TestInfo"
[TestInfoError]: /api/class-testinfoerror.mdx "TestInfoError"
[TestOptions]: /api/class-testoptions.mdx "TestOptions"
[TestProject]: /api/class-testproject.mdx "TestProject"
[TestStepInfo]: /api/class-teststepinfo.mdx "TestStepInfo"
[WorkerInfo]: /api/class-workerinfo.mdx "WorkerInfo"
[Reporter]: /api/class-reporter.mdx "Reporter"
[Suite]: /api/class-suite.mdx "Suite"
[TestCase]: /api/class-testcase.mdx "TestCase"
[TestError]: /api/class-testerror.mdx "TestError"
[TestResult]: /api/class-testresult.mdx "TestResult"
[TestStep]: /api/class-teststep.mdx "TestStep"
[EvaluationArgument]: /evaluating.mdx#evaluation-argument "EvaluationArgument"
[UIEvent.detail]: https://developer.mozilla.org/en-US/docs/Web/API/UIEvent/detail "UIEvent.detail"


[all available image tags]: https://mcr.microsoft.com/en-us/product/playwright/about "all available image tags"
[Microsoft Artifact Registry]: https://mcr.microsoft.com/en-us/product/playwright/about "Microsoft Artifact Registry"
[Dockerfile.noble]: https://github.com/microsoft/playwright/blob/main/utils/docker/Dockerfile.noble "Dockerfile.noble"

```dart
Future<void> type(String text,
```

### `pressSequentially`

*⚙️ Method*

In most cases, you should use [locator.fill()] instead. You only need to press keys one by one if there is special keyboard handling on the page.
Focuses the element, and then sends a `keydown`, `keypress`/`input`, and `keyup` event for each character in the text.

To press a special key, like `Control` or `ArrowDown`, use [locator.press()].

**Usage**

```dart
await locator.pressSequentially('Hello'); // Types instantly
await locator.pressSequentially('World', { delay: 100 ); // Types slower, like a user
```

An example of typing into a text field and then submitting the form:

```dart
final locator = page.getByLabel('Password');
await locator.pressSequentially('my password');
await locator.press('Enter');
```

**Arguments**
- `text` String

String of characters to sequentially press into a focused element.
- `options` Map *(optional)*
- `delay` double *(optional)*

Time to wait between key presses in milliseconds. Defaults to 0.
- `noWaitAfter` bool *(optional)*

**WARNING**
[Deprecated]
This option has no effect.
This option has no effect.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> pressSequentially( String text,
```

### `press`

*⚙️ Method*

Focuses the matching element and presses a combination of the keys.

**Usage**

```dart
await page.getByRole('textbox').press('Backspace');
```

**Arguments**
- `key` String

Name of the key to press or a character to generate, such as `ArrowLeft` or `a`.
- `options` Map *(optional)*
- `delay` double *(optional)*

Time to wait between `keydown` and `keyup` in milliseconds. Defaults to 0.
- `noWaitAfter` bool *(optional)*

**WARNING**
[Deprecated]
This option will default to `true` in the future.
Actions that initiate navigations are waiting for these navigations to happen and for pages to start loading. You can opt out of waiting via setting this flag. You would only need this option in the exceptional cases such as navigating to inaccessible pages. Defaults to `false`.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;void&gt;

**Details**

Focuses the element, and then uses [keyboard.down()] and [keyboard.up()].

[key] can specify the intended [keyboardEvent.key] value or a single character to generate the text for. A superset of the [key] values can be found [here]. Examples of the keys are:

`F1` - `F12`, `Digit0`- `Digit9`, `KeyA`- `KeyZ`, `Backquote`, `Minus`, `Equal`, `Backslash`, `Backspace`, `Tab`, `Delete`, `Escape`, `ArrowDown`, `End`, `Enter`, `Home`, `Insert`, `PageDown`, `PageUp`, `ArrowRight`, `ArrowUp`, etc.

Following modification shortcuts are also supported: `Shift`, `Control`, `Alt`, `Meta`, `ShiftLeft`, `ControlOrMeta`. `ControlOrMeta` resolves to `Control` on Windows and Linux and to `Meta` on macOS.

Holding down `Shift` will type the text that corresponds to the [key] in the upper case.

If [key] is a single character, it is case-sensitive, so the values `a` and `A` will generate different respective texts.

Shortcuts such as `key: "Control+o"`, `key: "Control++` or `key: "Control+Shift+T"` are supported as well. When specified with the modifier, modifier is pressed and being held while the subsequent key is being pressed.

```dart
Future<void> press(String key,
```

### `tap`

*⚙️ Method*

Perform a tap gesture on the element matching the locator. For examples of emulating other gestures by manually dispatching touch events, see the [emulating legacy touch events] page.

**Usage**

```dart
await locator.tap();
await locator.tap(options);
```

**Arguments**
- `options` Map *(optional)*
- `force` bool *(optional)*

Whether to bypass the [actionability] checks. Defaults to `false`.
- `modifiers` List&lt;"Alt" | "Control" | "ControlOrMeta" | "Meta" | "Shift"&gt; *(optional)*

Modifier keys to press. Ensures that only these modifiers are pressed during the operation, and then restores current modifiers back. If not specified, currently pressed modifiers are used. "ControlOrMeta" resolves to "Control" on Windows and Linux and to "Meta" on macOS.
- `noWaitAfter` bool *(optional)*

**WARNING**
[Deprecated]
This option has no effect.
This option has no effect.
- `position` Map *(optional)*
- `x` num


- `y` num


A point to use relative to the top-left corner of element padding box. If not specified, uses some visible point of the element.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
- `trial` bool *(optional)*

When set, this method only performs the [actionability] checks and skips the action. Defaults to `false`. Useful to wait until the element is ready for the action without performing it. Note that keyboard `modifiers` will be pressed regardless of `trial` to allow testing elements which are only visible when those keys are pressed.

**Returns**
- Future&lt;void&gt;

**Details**

This method taps the element by performing the following steps:
1. Wait for [actionability] checks on the element, unless [force] option is set.
1. Scroll the element into view if needed.
1. Use [page.touchscreen] to tap the center of the element, or the specified [position].

If the element is detached from the DOM at any moment during the action, this method throws.

When all steps combined have not finished during the specified [timeout], this method throws a [TimeoutError]. Passing zero timeout disables this.

**NOTE**
`element.tap()` requires that the `hasTouch` option of the browser context be set to true.

```dart
Future<void> tap(
```

### `selectOption`

*⚙️ Method*

Selects option or options in `<select>`.

**Usage**

```html
<select multiple>
<option value="red">Red</option>
<option value="green">Green</option>
<option value="blue">Blue</option>
</select>
```

```dart
// single selection matching the value or label
element.selectOption('blue');

// single selection matching the label
element.selectOption( label: 'Blue' );

// multiple selection for red, green and blue options
element.selectOption(['red', 'green', 'blue']);
```

**Arguments**
- `values` dynamic
- `value` String *(optional)*

Matches by `option.value`. Optional.
- `label` String *(optional)*

Matches by `option.label`. Optional.
- `index` num *(optional)*

Matches by the index. Optional.

Options to select. If the `<select>` has the `multiple` attribute, all matching options are selected, otherwise only the first option matching one of the passed options is selected. String values are matching both values and labels. Option is considered matching if all specified properties match.
- `options` Map *(optional)*
- `force` bool *(optional)*

Whether to bypass the [actionability] checks. Defaults to `false`.
- `noWaitAfter` bool *(optional)*

**WARNING**
[Deprecated]
This option has no effect.
This option has no effect.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;List&lt;String&gt;&gt;

**Details**

This method waits for [actionability] checks, waits until all specified options are present in the `<select>` element and selects these options.

If the target element is not a `<select>` element, this method throws an error. However, if the element is inside the `<label>` element that has an associated [control], the control will be used instead.

Returns the array of option values that have been successfully selected.

Triggers a `change` and `input` event once all the provided options have been selected.

```dart
Future<List<String>> selectOption( List<SelectOption>? values,
```

### `setInputFiles`

*⚙️ Method*

Upload file or multiple files into `<input type=file>`. For inputs with a `[webkitdirectory]` attribute, only a single directory path is supported.

**Usage**

```dart
// Select one file
await page.getByLabel('Upload file').setInputFiles(path.join(__dirname, 'myfile.pdf'));

// Select multiple files
await page.getByLabel('Upload files').setInputFiles([
path.join(__dirname, 'file1.txt'),
path.join(__dirname, 'file2.txt'),
]);

// Select a directory
await page.getByLabel('Upload directory').setInputFiles(path.join(__dirname, 'mydir'));

// Remove all the selected files
await page.getByLabel('Upload file').setInputFiles([]);

// Upload buffer from memory
await page.getByLabel('Upload file').setInputFiles(
name: 'file.txt',
mimeType: 'text/plain',
buffer: utf8.encode('this is test')
);
```

**Arguments**
- `files` dynamic
- `name` String

File name
- `mimeType` String

File type
- `buffer` List&lt;int&gt;

File content
- `options` Map *(optional)*
- `noWaitAfter` bool *(optional)*

**WARNING**
[Deprecated]
This option has no effect.
This option has no effect.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;void&gt;

**Details**

Sets the value of the file input to these file paths or files. If some of the `filePaths` are relative paths, then they are resolved relative to the current working directory. For empty array, clears the selected files.

This method expects [Locator] to point to an [input element]. However, if the element is inside the `<label>` element that has an associated [control], targets the control instead.

```dart
Future<void> setInputFiles( List<InputFile>? files,
```

### `dispatchEvent`

*⚙️ Method*

Programmatically dispatch an event on the matching element.

**Usage**

```dart
await locator.dispatchEvent('click');
```

**Arguments**
- `type` String

DOM event type: `"click"`, `"dragstart"`, etc.
- `eventInit` dynamic *(optional)*

Optional event-specific initialization properties.
- `options` Map *(optional)*
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;void&gt;

**Details**

The snippet above dispatches the `click` event on the element. Regardless of the visibility state of the element, `click` is dispatched. This is equivalent to calling [element.click()].

Under the hood, it creates an instance of an event based on the given [type], initializes it with [eventInit] properties and dispatches it on the element. Events are `composed`, `cancelable` and bubble by default.

Since [eventInit] is event-specific, please refer to the events documentation for the lists of initial properties:
* [DeviceMotionEvent]
* [DeviceOrientationEvent]
* [DragEvent]
* [Event]
* [FocusEvent]
* [KeyboardEvent]
* [MouseEvent]
* [PointerEvent]
* [TouchEvent]
* [WheelEvent]

You can also specify [JSHandle] as the property value if you want live objects to be passed into the event:

```dart
final dataTransfer = await page.evaluateHandle(() => new DataTransfer());
await locator.dispatchEvent('dragstart', { dataTransfer );
```

```dart
Future<void> dispatchEvent( String type,
```

### `highlight`

*⚙️ Method*

Highlight the corresponding element(s) on the screen. Useful for debugging, don't commit the code that uses [locator.highlight()].

**Usage**

```dart
await locator.highlight();
await locator.highlight(options);
```

**Arguments**
- `options` Map *(optional)*
- `style` String | Map&lt;String, String | num&gt; *(optional)*

Inline CSS applied to the highlight overlay, e.g.

```dart
await locator.highlight( style: 'outline: 2px dashed red' );
await locator.highlight( style: { color: 'red' } );
```

**Returns**
- Future&lt;[Disposable]&gt;

```dart
Future<void> highlight() async
```

### `hideHighlight`

*⚙️ Method*

Hides the element highlight previously added by [locator.highlight()].

**Usage**

```dart
await locator.hideHighlight();
```

**Returns**
- Future&lt;void&gt;

```dart
Future<void> hideHighlight() async
```

### `drop`

*⚙️ Method*

Simulate an external drag-and-drop of files or clipboard-like data onto this locator.

**Usage**

Drop a file buffer onto an upload area:

```dart
await page.locator('#dropzone').drop(
files: { name: 'note.txt', mimeType: 'text/plain', buffer: utf8.encode('hello') },
);
```

Drop plain text and a URL together:

```dart
await page.locator('#dropzone').drop(
data: {
'text/plain': 'hello world',
'text/uri-list': 'https://example.com',
},
);
```

**Arguments**
- `payload` Map
- `files` String | List&lt;String&gt; | Map | List&lt;Map&gt; *(optional)*
- `name` String

File name
- `mimeType` String

File type
- `buffer` List&lt;int&gt;

File content


- `data` List&lt;FrameDropDataItems&gt; *(optional)*


Data to drop onto the target. Provide `files` (file paths or in-memory buffers), `data` (a mime-type → string map for clipboard-like content such as `text/plain`, `text/html`, `text/uri-list`), or both.
- `options` Map *(optional)*
- `position` Map *(optional)*
- `x` num


- `y` num


A point to use relative to the top-left corner of element padding box. If not specified, uses some visible point of the element.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;void&gt;

**Details**

Dispatches the native `dragenter`, `dragover`, and `drop` events at the center of the target element with a synthetic [DataTransfer] carrying the provided files and/or data entries. Works cross-browser by constructing the [DataTransfer] in the page context.

If the target element's `dragover` listener does not call `preventDefault()`, the target is considered to have rejected the drop: Playwright dispatches `dragleave` and this method throws.

```dart
Future<void> drop(
```

### `ariaSnapshot`

*⚙️ Method*

Captures the aria snapshot of the given element. Read more about [aria snapshots] and [expect(locator).toMatchAriaSnapshot()] for the corresponding assertion.

**Usage**

```dart
await page.getByRole('link').ariaSnapshot();
```

**Arguments**
- `options` Map *(optional)*
- `boxes` bool *(optional)*

When `true`, appends each element's bounding box as `[box=x,y,width,height]` to the snapshot. Coordinates are relative to the viewport, in CSS pixels, as returned by [`Element.getBoundingClientRect()`]. Defaults to `false`.
- `depth` int *(optional)*

When specified, limits the depth of the snapshot.
- `mode` SnapshotMode *(optional)*

When set to `"ai"`, returns a snapshot optimized for AI consumption. Defaults to `"default"`. See details for more information.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;String&gt;

**Details**

This method captures the aria snapshot of the given element. The snapshot is a string that represents the state of the element and its children. The snapshot can be used to assert the state of the element in the test, or to compare it to state in the future.

The ARIA snapshot is represented using [YAML] markup language:
* The keys of the objects are the roles and optional accessible names of the elements.
* The values are either text content or an array of child elements.
* Generic static text can be represented with the `text` key.

Below is the HTML markup and the respective ARIA snapshot:

```html
<ul aria-label="Links">
<li><a href="/">Home</a></li>
<li><a href="/about">About</a></li>
<ul>
```

```yml
- list "Links":
- listitem:
- link "Home"
- listitem:
- link "About"
```

An AI-optimized snapshot, controlled by [mode], is different from a default snapshot:
1. Includes element references `[ref=e2]`. 2. Does not wait for an element matching the locator, and throws when no elements match. 3. Includes snapshots of `<iframe>`s inside the target.

```dart
Future<FrameAriaSnapshotResult> ariaSnapshot(
```

### `locator`

*⚙️ Method*

The method finds an element matching the specified selector in the locator's subtree. It also accepts filter options, similar to [locator.filter()] method.

[Learn more about locators].

**Usage**

```dart
locator.locator(selectorOrLocator);
locator.locator(selectorOrLocator, options);
```

**Arguments**
- `selectorOrLocator` String | [Locator]

A selector or locator to use when resolving DOM element.
- `options` Map *(optional)*
- `has` [Locator] *(optional)*

Narrows down the results of the method to those which contain elements matching this relative locator. For example, `article` that has `text=Playwright` matches `<article><div>Playwright</div></article>`.

Inner locator **must be relative** to the outer locator and is queried starting with the outer locator match, not the document root. For example, you can find `content` that has `div` in `<article><content><div>Playwright</div></content></article>`. However, looking for `content` that has `article div` will fail, because the inner locator must be relative and should not use any elements outside the `content`.

Note that outer and inner locators must belong to the same frame. Inner locator must not contain [FrameLocator]s.
- `hasNot` [Locator] *(optional)*

Matches elements that do not contain an element that matches an inner locator. Inner locator is queried against the outer one. For example, `article` that does not have `div` matches `<article><span>Playwright</span></article>`.

Note that outer and inner locators must belong to the same frame. Inner locator must not contain [FrameLocator]s.
- `hasNotText` String | [RegExp] *(optional)*

Matches elements that do not contain specified text somewhere inside, possibly in a child or a descendant element. When passed a String, matching is case-insensitive and searches for a substring.
- `hasText` String | [RegExp] *(optional)*

Matches elements containing specified text somewhere inside, possibly in a child or a descendant element. When passed a String, matching is case-insensitive and searches for a substring. For example, `"Playwright"` matches `<article><div>Playwright</div></article>`.

**Returns**
- [Locator]

```dart
return locator(subSelector)
```

### `evaluate`

*⚙️ Method*

Execute JavaScript code in the page, taking the matching element as an argument.

**Usage**

Passing argument to [pageFunction]:

```dart
final result = await page.getByTestId('myId').evaluate((element, [x, y]) {
return element.textContent + ' ' + x * y;
}, [7, 8]);
print(result); // prints "myId text 56"
```

**Arguments**
- `pageFunction` Function | String

Function to be evaluated in the page context.
- `arg` dynamic *(optional)*

Optional argument to pass to [pageFunction].
- `options` Map *(optional)*
- `timeout` num *(optional)*

Maximum time in milliseconds to wait for the locator before evaluating. Note that after locator is resolved, evaluation itself is not limited by the timeout. Defaults to `0` - no timeout.

**Returns**
- Future&lt;[Serializable]&gt;

**Details**

Returns the return value of [pageFunction], called with the matching element as a first argument, and [arg] as a second argument.

If [pageFunction] returns a Future, this method will wait for the future to complete and return its value.

If [pageFunction] throws or rejects, this method throws.

```dart
Future<T> evaluate<T>(String expression, [Object? arg]) async
```

### `waitFor`

*⚙️ Method*

Returns when element specified by locator satisfies the [state] option.

If target element already satisfies the condition, the method returns immediately. Otherwise, waits for up to [timeout] milliseconds until the condition is met.

**Usage**

```dart
final orderSent = page.locator('#order-sent');
await orderSent.waitFor();
```

**Arguments**
- `options` Map *(optional)*
- `state` SelectorState *(optional)*

Defaults to `'visible'`. Can be either:
* `'attached'` - wait for element to be present in DOM.
* `'detached'` - wait for element to not be present in DOM.
* `'visible'` - wait for element to have non-empty bounding box and no `visibility:hidden`. Note that element without any content or with `display:none` has an empty bounding box and is not considered visible.
* `'hidden'` - wait for element to be either detached from DOM, or have an empty bounding box or `visibility:hidden`. This is opposite to the `'visible'` option.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> waitFor(
```

### `dragTo`

*⚙️ Method*

Drag the source element towards the target element and drop it.

**Usage**

```dart
final source = page.locator('#source');
final target = page.locator('#target');

await source.dragTo(target);
// or specify exact positions relative to the top-left corners of the elements:
await source.dragTo(target, {
sourcePosition: { x: 34, y: 7 },
targetPosition: { x: 10, y: 20 },
);
```

**Arguments**
- `target` Locator

Locator of the element to drag to.
- `options` Map *(optional)*
- `force` bool *(optional)*

Whether to bypass the [actionability] checks. Defaults to `false`.
- `noWaitAfter` bool *(optional)*

**WARNING**
[Deprecated]
This option has no effect.
This option has no effect.
- `sourcePosition` Map *(optional)*
- `x` num


- `y` num


Clicks on the source element at this point relative to the top-left corner of the element's padding box. If not specified, some visible point of the element is used.
- `steps` num *(optional)*

Defaults to 1. Sends `n` interpolated `mousemove` events to represent travel between the `mousedown` and `mouseup` of the drag. When set to 1, emits a single `mousemove` event at the destination location.
- `targetPosition` Map *(optional)*
- `x` num


- `y` num


Drops on the target element at this point relative to the top-left corner of the element's padding box. If not specified, some visible point of the element is used.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
- `trial` bool *(optional)*

When set, this method only performs the [actionability] checks and skips the action. Defaults to `false`. Useful to wait until the element is ready for the action without performing it.

**Returns**
- Future&lt;void&gt;

**Details**

This method drags the locator to another target locator or target position. It will first move to the source element, perform a `mousedown`, then move to the target element or position and perform a `mouseup`.

```dart
Future<void> dragTo(Locator target,
```

### `count`

*⚙️ Method*

Returns the number of elements matching the locator.

**WARNING**
[Asserting count]

If you need to assert the number of elements on the page, prefer [expect(locator).toHaveCount()] to avoid flakiness. See [assertions guide] for more details.
**Usage**

```dart
final count = await page.getByRole('listitem').count();
```

**Returns**
- Future&lt;num&gt;

```dart
Future<int> count()
```

### `all`

*⚙️ Method*

When the locator points to a list of elements, this returns an array of locators, pointing to their respective elements.

**NOTE**
[locator.all()] does not wait for elements to match the locator, and instead immediately returns whatever is present in the page.

When the list of elements changes dynamically, [locator.all()] will produce unpredictable and flaky results.

When the list of elements is stable, but loaded dynamically, wait for the full list to finish loading before calling [locator.all()].
**Usage**

```dart
for (final li of await page.getByRole('listitem').all())
await li.click();
```

**Returns**
- Future&lt;List&lt;[Locator]&gt;&gt;

```dart
Future<List<Locator>> all() async
```

### `allInnerTexts`

*⚙️ Method*

Returns an array of `node.innerText` values for all matching nodes.

**WARNING**
[Asserting text]

If you need to assert text on the page, prefer [expect(locator).toHaveText()] with [useInnerText] option to avoid flakiness. See [assertions guide] for more details.
**Usage**

```dart
final texts = await page.getByRole('link').allInnerTexts();
```

**Returns**
- Future&lt;List&lt;String&gt;&gt;

```dart
Future<List<String>> allInnerTexts() async
```

### `allTextContents`

*⚙️ Method*

Returns an array of `node.textContent` values for all matching nodes.

**WARNING**
[Asserting text]

If you need to assert text on the page, prefer [expect(locator).toHaveText()] to avoid flakiness. See [assertions guide] for more details.
**Usage**

```dart
final texts = await page.getByRole('link').allTextContents();
```

**Returns**
- Future&lt;List&lt;String&gt;&gt;

```dart
Future<List<String>> allTextContents() async
```

### `elementHandle`

*⚙️ Method*

**WARNING**
[Discouraged]

Always prefer using [Locator]s and web assertions over [ElementHandle]s because latter are inherently racy.

Resolves given locator to the first matching DOM element. If there are no matching elements, waits for one. If multiple elements match the locator, throws.

**Usage**

```dart
await locator.elementHandle();
await locator.elementHandle(options);
```

**Arguments**
- `options` Map *(optional)*
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;[ElementHandle]&gt;

```dart
Future<ElementHandle> elementHandle(
```

### `elementHandles`

*⚙️ Method*

**WARNING**
[Discouraged]

Always prefer using [Locator]s and web assertions over [ElementHandle]s because latter are inherently racy.

Resolves given locator to all matching DOM elements. If there are no matching elements, returns an empty list.

**Usage**

```dart
await locator.elementHandles();
```

**Returns**
- Future&lt;List&lt;[ElementHandle]&gt;&gt;

```dart
Future<List<ElementHandle>> elementHandles() async
```

### `boundingBox`

*⚙️ Method*

This method returns the bounding box of the element matching the locator, or `null` if the element is not visible. The bounding box is calculated relative to the main frame viewport - which is usually the same as the browser window.

**Usage**

```dart
final box = await page.getByRole('button').boundingBox();
await page.mouse.click(box.x + box.width / 2, box.y + box.height / 2);
```

**Arguments**
- `options` Map *(optional)*
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;[Map&gt;]?
- `x` num

the x coordinate of the element in pixels.
- `y` num

the y coordinate of the element in pixels.
- `width` num

the width of the element in pixels.
- `height` num

the height of the element in pixels.

**Details**

Scrolling affects the returned bounding box, similarly to [Element.getBoundingClientRect]. That means `x` and/or `y` may be negative.

Elements from child frames return the bounding box relative to the main frame, unlike the [Element.getBoundingClientRect].

Assuming the page is static, it is safe to use bounding box coordinates to perform input. For example, the following snippet should click the center of the element.

```dart
Future<Rect?> boundingBox(
```

### `screenshot`

*⚙️ Method*

Take a screenshot of the element matching the locator.

**Usage**

```dart
await page.getByRole('link').screenshot();
```

Disable animations and save screenshot to a file:

```dart
await page.getByRole('link').screenshot( animations: 'disabled', path: 'link.png' );
```

**Arguments**
- `options` CommonScreenshotOptions *(optional)*
- `animations` "disabled" | "allow" *(optional)*

When set to `"disabled"`, stops CSS animations, CSS transitions and Web Animations. Animations get different treatment depending on their duration:
* finite animations are fast-forwarded to completion, so they'll fire `transitionend` event.
* infinite animations are canceled to initial state, and then played over after the screenshot.

Defaults to `"allow"` that leaves animations untouched.
- `caret` "hide" | "initial" *(optional)*

When set to `"hide"`, screenshot will hide text caret. When set to `"initial"`, text caret behavior will not be changed.  Defaults to `"hide"`.
- `mask` List&lt;[Locator]&gt; *(optional)*

Specify locators that should be masked when the screenshot is taken. Masked elements will be overlaid with a pink box `#FF00FF` (customized by [maskColor]) that completely covers its bounding box. The mask is also applied to invisible elements, see [Matching only visible elements] to disable that.
- `maskColor` String *(optional)*

Specify the color of the overlay box for masked elements, in [CSS color format]. Default color is pink `#FF00FF`.
- `omitBackground` bool *(optional)*

Hides default white background and allows capturing screenshots with transparency. Not applicable to `jpeg` images. Defaults to `false`.
- `path` String *(optional)*

The file path to save the image to. The screenshot type will be inferred from file extension. If [path] is a relative path, then it is resolved relative to the current working directory. If no path is provided, the image won't be saved to the disk.
- `quality` int *(optional)*

The quality of the image, between 0-100. Not applicable to `png` images.
- `scale` "css" | "device" *(optional)*

When set to `"css"`, screenshot will have a single pixel per each css pixel on the page. For high-dpi devices, this will keep screenshots small. Using `"device"` option will produce a single pixel per each device pixel, so screenshots of high-dpi devices will be twice as large or even larger.

Defaults to `"device"`.
- `style` String *(optional)*

Text of the stylesheet to apply while making the screenshot. This is where you can hide dynamic elements, make elements invisible or change their properties to help you creating repeatable screenshots. This stylesheet pierces the Shadow DOM and applies to the inner frames.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
- `type` String *(optional)*

Specify screenshot type, defaults to `png`.

**Returns**
- Future&lt;List&lt;int&gt;&gt;

**Details**

This method captures a screenshot of the page, clipped to the size and position of a particular element matching the locator. If the element is covered by other elements, it will not be actually visible on the screenshot. If the element is a scrollable container, only the currently scrolled content will be visible on the screenshot.

This method waits for the [actionability] checks, then scrolls element into view before taking a screenshot. If the element is detached from DOM, the method throws an error.

Returns the buffer with the captured screenshot.

```dart
Future<Uint8List> screenshot(
```

## `Page`

```dart
abstract interface class Page
```

### `frames`

*📦 Property*

An array of all frames attached to the page.

**Usage**

```dart
page.frames;
```

**Returns**
- List&lt;[Frame]&gt;

```dart
List<Frame> get frames
```

### `workers`

*📦 Property*

This method returns all of the dedicated [WebWorkers] associated with the page.

**NOTE**
This does not contain ServiceWorkers
**Usage**

```dart
page.workers;
```

**Returns**
- List&lt;[Worker]&gt;

```dart
List<Worker> get workers
```

### `onWebSocketRoute`

*📦 Property*

Stream that emits when a WebSocket route is created.

```dart
Stream<WebSocketRoute> get onWebSocketRoute
```

### `onScreencastFrame`

*📦 Property*

Stream that emits when a screencast frame is available.

```dart
Stream<Map<String, dynamic>> get onScreencastFrame
```

### `onRoute`

*📦 Property*

Stream that emits when a route is created.

```dart
Stream<Route> get onRoute
```

### `onLocatorHandlerTriggered`

*📦 Property*

Stream that emits when a locator handler is triggered.

```dart
Stream<dynamic> get onLocatorHandlerTriggered
```

### `onFrameDetached`

*📦 Property*

Stream that emits when a frame is detached.

```dart
Stream<Frame> get onFrameDetached
```

### `onFrameAttached`

*📦 Property*

Stream that emits when a frame is attached.

```dart
Stream<Frame> get onFrameAttached
```

### `onViewportSizeChanged`

*📦 Property*

Stream that emits when the viewport size changes.

```dart
Stream<Map<String, dynamic>> get onViewportSizeChanged
```

### `onBindingCall`

*📦 Property*

Stream that emits when a binding call is made.

```dart
Stream<BindingCall> get onBindingCall
```

### `keyboard`

*📦 Property*

**Usage**

```dart
page.keyboard
```

**Type**
- [Keyboard]

```dart
Keyboard get keyboard
```

### `mouse`

*📦 Property*

**Usage**

```dart
page.mouse
```

**Type**
- [Mouse]

```dart
Mouse get mouse
```

### `touchscreen`

*📦 Property*

**Usage**

```dart
page.touchscreen
```

**Type**
- [Touchscreen]

```dart
Touchscreen get touchscreen
```

### `context`

*📦 Property*

Get the browser context that the page belongs to.

**Usage**

```dart
page.context;
```

**Returns**
- [BrowserContext]

```dart
BrowserContext get context
```

### `request`

*📦 Property*

API testing helper associated with this page. This method returns the same instance as [browserContext.request] on the page's context. See [browserContext.request] for more details.

**Usage**

```dart
page.request
```

**Type**
- [APIRequestContext]

```dart
APIRequestContext get request
```

### `clock`

*📦 Property*

Playwright has ability to mock clock and passage of time.

**Usage**

```dart
page.clock
```

**Type**
- [Clock]

```dart
Clock get clock
```

### `mainFrame`

*📦 Property*

The page's main frame. Page is guaranteed to have a main frame which persists during navigations.

**Usage**

```dart
page.mainFrame;
```

**Returns**
- [Frame]

```dart
Frame get mainFrame
```

### `onConsole`

*📦 Property*

Stream that emits when a console message is logged.

```dart
Stream<ConsoleMessage> get onConsole
```

### `onFileChooser`

*📦 Property*

Stream that emits when a file chooser is shown.

```dart
Stream<FileChooser> get onFileChooser
```

### `onDialog`

*📦 Property*

Stream that emits when a dialog is shown.

```dart
Stream<Dialog> get onDialog
```

### `onRequest`

*📦 Property*

Stream that emits when a request is made.

```dart
Stream<Request> get onRequest
```

### `onResponse`

*📦 Property*

Stream that emits when a response is received.

```dart
Stream<Response> get onResponse
```

### `onRequestFinished`

*📦 Property*

Stream that emits when a request finishes.

```dart
Stream<Request> get onRequestFinished
```

### `onRequestFailed`

*📦 Property*

Stream that emits when a request fails.

```dart
Stream<Request> get onRequestFailed
```

### `onWebSocket`

*📦 Property*

Stream that emits when a WebSocket is created.

```dart
Stream<WebSocket> get onWebSocket
```

### `onClose`

*📦 Property*

Stream that emits when the page closes.

```dart
Stream<Page> get onClose
```

### `onCrash`

*📦 Property*

Stream that emits when the page crashes.

```dart
Stream<Page> get onCrash
```

### `onPageError`

*📦 Property*

Stream that emits when a page error occurs.

```dart
Stream<Exception> get onPageError
```

### `video`

*⚙️ Method*

Video object associated with this page. Can be used to access the video file when using the `recordVideo` context option.

**Usage**

```dart
page.video();
```

**Returns**
- [Video]?

```dart
Video? video()
```

### `onPopup`

*📦 Property*

Stream that emits when a popup page is created.

```dart
Stream<Page> get onPopup
```

### `onWorker`

*📦 Property*

Stream that emits when a worker is created.

```dart
Stream<Worker> get onWorker
```

### `waitForRequest`

*⚙️ Method*

Waits for the matching request and returns it. See [waiting for event] for more details about events.

**Usage**

```dart
// Start waiting for request before clicking. Note no await.
final requestFuture = page.waitForRequest('https://example.com/resource');
await page.getByText('trigger request').click();
final request = await requestFuture;

// Alternative way with a predicate. Note no await.
final requestFuture = page.waitForRequest((request) =>
request.url() == 'https://example.com' && request.method() == 'GET',
);
await page.getByText('trigger request').click();
final request = await requestFuture;
```

**Arguments**
- `urlOrPredicate` dynamic

Request URL string, regex or predicate receiving [Request] object.
- `options` Map *(optional)*
- `signal` [AbortSignal] *(optional)*

Allows to cancel the waiting using an [`AbortSignal`]. If the signal is aborted, the waiting will be aborted and the operation will throw an error. Note that providing a signal does not disable the default timeout; pass `timeout: 0` to disable the timeout entirely.
- `timeout` double *(optional)*

Maximum wait time in milliseconds, defaults to 30 seconds, pass `0` to disable the timeout. The default value can be changed by using the [page.setDefaultTimeout()] method.

**Returns**
- Future&lt;[Request]&gt;

```dart
Future<Request> waitForRequest( RouteMatcher urlOrPredicate,
```

### `waitForResponse`

*⚙️ Method*

Returns the matched response. See [waiting for event] for more details about events.

**Usage**

```dart
// Start waiting for response before clicking. Note no await.
final responseFuture = page.waitForResponse('https://example.com/resource');
await page.getByText('trigger response').click();
final response = await responseFuture;

// Alternative way with a predicate. Note no await.
final responseFuture = page.waitForResponse((response) =>
response.url() == 'https://example.com' && response.status() == 200
&& response.request().method() == 'GET'
);
await page.getByText('trigger response').click();
final response = await responseFuture;
```

**Arguments**
- `urlOrPredicate` dynamic

Request URL string, regex or predicate receiving [Response] object. When a [baseURL] via the context options was provided and the passed URL is a path, it gets merged via the [`new URL()`] constructor.
- `options` Map *(optional)*
- `signal` [AbortSignal] *(optional)*

Allows to cancel the waiting using an [`AbortSignal`]. If the signal is aborted, the waiting will be aborted and the operation will throw an error. Note that providing a signal does not disable the default timeout; pass `timeout: 0` to disable the timeout entirely.
- `timeout` double *(optional)*

Maximum wait time in milliseconds, defaults to 30 seconds, pass `0` to disable the timeout. The default value can be changed by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;[Response]&gt;

```dart
Future<Response> waitForResponse( RouteMatcher urlOrPredicate,
```

### `isClosed`

*📦 Property*

Indicates that the page has been closed.

**Usage**

```dart
page.isClosed;
```

**Returns**
- bool

```dart
bool get isClosed
```

### `url`

*⚙️ Method*

**Usage**

```dart
page.url();
```

**Returns**
- String

```dart
String url()
```

### `viewportSize`

*📦 Property*

**Usage**

```dart
page.viewportSize;
```

**Returns**
- [Map]?
- `width` num

page width in pixels.
- `height` num

page height in pixels.

```dart
PageSetViewportSize? get viewportSize
```

### `setDefaultTimeout`

*⚙️ Method*

This setting will change the default maximum time for all the methods accepting [timeout] option.

**NOTE**
[page.setDefaultNavigationTimeout()] takes priority over [page.setDefaultTimeout()].
**Usage**

```dart
page.setDefaultTimeout(timeout);
```

**Arguments**
- `timeout` double

Maximum time in milliseconds. Pass `0` to disable timeout.

```dart
void setDefaultTimeout(double timeout)
```

### `setDefaultNavigationTimeout`

*⚙️ Method*

This setting will change the default maximum navigation time for the following methods and related shortcuts:
* [page.goBack()]
* [page.goForward()]
* [page.goto()]
* [page.reload()]
* [page.setContent()]
* [page.waitForNavigation()]
* [page.waitForURL()]

**NOTE**
[page.setDefaultNavigationTimeout()] takes priority over [page.setDefaultTimeout()], [browserContext.setDefaultTimeout()] and [browserContext.setDefaultNavigationTimeout()].
**Usage**

```dart
page.setDefaultNavigationTimeout(timeout);
```

**Arguments**
- `timeout` double

Maximum navigation time in milliseconds

```dart
void setDefaultNavigationTimeout(double timeout)
```

### `onDownload`

*📦 Property*

Stream that emits when a download starts.

```dart
Stream<Download> get onDownload
```

### `goto`

*⚙️ Method*

Returns the main resource response. In case of multiple redirects, the navigation will resolve with the first non-redirect response.

The method will throw an error if:
* there's an SSL error (e.g. in case of self-signed certificates).
* target URL is invalid.
* the [timeout] is exceeded during navigation.
* the remote server does not respond or is unreachable.
* the main resource failed to load.

The method will not throw an error when any valid HTTP status code is returned by the remote server, including 404 "Not Found" and 500 "Internal Server Error".  The status code for such responses can be retrieved by calling [response.status()].

**NOTE**
The method either throws an error or returns a main resource response. The only exceptions are navigation to `about:blank` or navigation to the same URL with a different hash, which would succeed and return `null`.
**NOTE**
Headless mode doesn't support navigation to a PDF document. See the [upstream issue].
**Usage**

```dart
await page.goto(url);
await page.goto(url, options);
```

**Arguments**
- `url` String

URL to navigate page to. The url should include scheme, e.g. `https://`. When a [baseURL] via the context options was provided and the passed URL is a path, it gets merged via the [`new URL()`] constructor.
- `options` Map *(optional)*
- `referer` String *(optional)*

Referer header value. If provided it will take preference over the referer header value set by [page.setExtraHTTPHeaders()].
- `timeout` double *(optional)*

Maximum operation time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `navigationTimeout` option in the config, or by using the [browserContext.setDefaultNavigationTimeout()], [browserContext.setDefaultTimeout()], [page.setDefaultNavigationTimeout()] or [page.setDefaultTimeout()] methods.
- `waitUntil` LifecycleEvent *(optional)*

When to consider operation succeeded, defaults to `load`. Events can be either:
* `'domcontentloaded'` - consider operation to be finished when the `DOMContentLoaded` event is fired.
* `'load'` - consider operation to be finished when the `load` event is fired.
* `'networkidle'` - **DISCOURAGED** consider operation to be finished when there are no network connections for at least `500` ms. Don't use this method for testing, rely on web assertions to assess readiness instead.
* `'commit'` - consider operation to be finished when network response is received and the document started loading.

**Returns**
- Future&lt;[Response]?&gt;

```dart
Future<void> goto( String url,
```

### `waitForLoadState`

*⚙️ Method*

Returns when the required load state has been reached.

This resolves when the page reaches a required load state, `load` by default. The navigation must have been committed when this method is called. If current document has already reached the required state, resolves immediately.

**NOTE**
Most of the time, this method is not needed because Playwright [auto-waits before every action].
**Usage**

```dart
await page.getByRole('button').click(); // Click triggers navigation.
await page.waitForLoadState(); // The future resolves after 'load' event.
```

```dart
final popupFuture = page.onPopup.first;
await page.getByRole('button').click(); // Click triggers a popup.
final popup = await popupFuture;
await popup.waitForLoadState('domcontentloaded'); // Wait for the 'DOMContentLoaded' event.
print(await popup.title()); // Popup is ready to use.
```

**Arguments**
- `state` LifecycleEvent *(optional)*

Optional load state to wait for, defaults to `load`. If the state has been already reached while loading current document, the method resolves immediately. Can be one of:
* `'load'` - wait for the `load` event to be fired.
* `'domcontentloaded'` - wait for the `DOMContentLoaded` event to be fired.
* `'networkidle'` - **DISCOURAGED** wait until there are no network connections for at least `500` ms. Don't use this method for testing, rely on web assertions to assess readiness instead.
- `options` Map *(optional)*
- `signal` [AbortSignal] *(optional)*

Allows to cancel the waiting using an [`AbortSignal`]. If the signal is aborted, the waiting will be aborted and the operation will throw an error. Note that providing a signal does not disable the default timeout; pass `timeout: 0` to disable the timeout entirely.
- `timeout` double *(optional)*

Maximum operation time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `navigationTimeout` option in the config, or by using the [browserContext.setDefaultNavigationTimeout()], [browserContext.setDefaultTimeout()], [page.setDefaultNavigationTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> waitForLoadState(
```

### `waitForURL`

*⚙️ Method*

Waits for the main frame to navigate to the given URL.

**Usage**

```dart
await page.click('a.delayed-navigation'); // Clicking the link will indirectly cause a navigation
await page.waitForURL('**/target.html');
```

**Arguments**
- `url` String | [RegExp] | [URLPattern] | Function\([URL]\):bool

A glob pattern, regex pattern, URL pattern, or predicate receiving [URL] to match while waiting for the navigation. Note that if the parameter is a string without wildcard characters, the method will wait for navigation to URL that is exactly equal to the string.
- `options` Map *(optional)*
- `signal` [AbortSignal] *(optional)*

Allows to cancel the waiting using an [`AbortSignal`]. If the signal is aborted, the waiting will be aborted and the operation will throw an error. Note that providing a signal does not disable the default timeout; pass `timeout: 0` to disable the timeout entirely.
- `timeout` double *(optional)*

Maximum operation time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `navigationTimeout` option in the config, or by using the [browserContext.setDefaultNavigationTimeout()], [browserContext.setDefaultTimeout()], [page.setDefaultNavigationTimeout()] or [page.setDefaultTimeout()] methods.
- `waitUntil` LifecycleEvent *(optional)*

When to consider operation succeeded, defaults to `load`. Events can be either:
* `'domcontentloaded'` - consider operation to be finished when the `DOMContentLoaded` event is fired.
* `'load'` - consider operation to be finished when the `load` event is fired.
* `'networkidle'` - **DISCOURAGED** consider operation to be finished when there are no network connections for at least `500` ms. Don't use this method for testing, rely on web assertions to assess readiness instead.
* `'commit'` - consider operation to be finished when network response is received and the document started loading.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> waitForURL( RouteMatcher urlOrPredicate,
```

### `waitForNavigation`

*⚙️ Method*

**WARNING**
[Deprecated]

This method is inherently racy, please use [page.waitForURL()] instead.

Waits for the main frame navigation and returns the main resource response. In case of multiple redirects, the navigation will resolve with the response of the last redirect. In case of navigation to a different anchor or navigation due to History API usage, the navigation will resolve with `null`.

**Usage**

This resolves when the page navigates to a new URL or reloads. It is useful for when you run code which will indirectly cause the page to navigate. e.g. The click target has an `onclick` handler that triggers navigation from a `setTimeout`. Consider this example:

```dart
// Start waiting for navigation before clicking. Note no await.
final navigationFuture = page.waitForNavigation();
await page.getByText('Navigate after timeout').click();
await navigationFuture;
```

**NOTE**
Usage of the [History API] to change the URL is considered a navigation.
**Arguments**
- `options` Map *(optional)*
- `signal` [AbortSignal] *(optional)*

Allows to cancel the waiting using an [`AbortSignal`]. If the signal is aborted, the waiting will be aborted and the operation will throw an error. Note that providing a signal does not disable the default timeout; pass `timeout: 0` to disable the timeout entirely.
- `timeout` double *(optional)*

Maximum operation time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `navigationTimeout` option in the config, or by using the [browserContext.setDefaultNavigationTimeout()], [browserContext.setDefaultTimeout()], [page.setDefaultNavigationTimeout()] or [page.setDefaultTimeout()] methods.
- `url` String *(optional)*

A glob pattern, regex pattern, URL pattern, or predicate receiving [URL] to match while waiting for the navigation. Note that if the parameter is a string without wildcard characters, the method will wait for navigation to URL that is exactly equal to the string.
- `waitUntil` LifecycleEvent *(optional)*

When to consider operation succeeded, defaults to `load`. Events can be either:
* `'domcontentloaded'` - consider operation to be finished when the `DOMContentLoaded` event is fired.
* `'load'` - consider operation to be finished when the `load` event is fired.
* `'networkidle'` - **DISCOURAGED** consider operation to be finished when there are no network connections for at least `500` ms. Don't use this method for testing, rely on web assertions to assess readiness instead.
* `'commit'` - consider operation to be finished when network response is received and the document started loading.

**Returns**
- Future&lt;[Response]?&gt;

```dart
Future<void> waitForNavigation(
```

### `title`

*⚙️ Method*

Returns the page's title.

**Usage**

```dart
await page.title();
```

**Returns**
- Future&lt;String&gt;

```dart
Future<String> title()
```

### `locator`

*⚙️ Method*

The method returns an element locator that can be used to perform actions on this page / frame. Locator is resolved to the element immediately before performing an action, so a series of actions on the same locator can in fact be performed on different DOM elements. That would happen if the DOM structure between those actions has changed.

[Learn more about locators].

**Usage**

```dart
page.locator(selector);
page.locator(selector, options);
```

**Arguments**
- `selector` String

A selector to use when resolving DOM element.
- `options` Map *(optional)*
- `has` [Locator] *(optional)*

Narrows down the results of the method to those which contain elements matching this relative locator. For example, `article` that has `text=Playwright` matches `<article><div>Playwright</div></article>`.

Inner locator **must be relative** to the outer locator and is queried starting with the outer locator match, not the document root. For example, you can find `content` that has `div` in `<article><content><div>Playwright</div></content></article>`. However, looking for `content` that has `article div` will fail, because the inner locator must be relative and should not use any elements outside the `content`.

Note that outer and inner locators must belong to the same frame. Inner locator must not contain [FrameLocator]s.
- `hasNot` [Locator] *(optional)*

Matches elements that do not contain an element that matches an inner locator. Inner locator is queried against the outer one. For example, `article` that does not have `div` matches `<article><span>Playwright</span></article>`.

Note that outer and inner locators must belong to the same frame. Inner locator must not contain [FrameLocator]s.
- `hasNotText` String | [RegExp] *(optional)*

Matches elements that do not contain specified text somewhere inside, possibly in a child or a descendant element. When passed a String, matching is case-insensitive and searches for a substring.
- `hasText` String | [RegExp] *(optional)*

Matches elements containing specified text somewhere inside, possibly in a child or a descendant element. When passed a String, matching is case-insensitive and searches for a substring. For example, `"Playwright"` matches `<article><div>Playwright</div></article>`.

**Returns**
- [Locator]

```dart
Locator locator(String selector)
```

### `frameLocator`

*⚙️ Method*

When working with iframes, you can create a frame locator that will enter the iframe and allow selecting elements in that iframe.

**Usage**

Following snippet locates element with text "Submit" in the iframe with id `my-frame`, like `<iframe id="my-frame">`:

```dart
final locator = page.frameLocator('#my-iframe').getByText('Submit');
await locator.click();
```

**Arguments**
- `selector` String

A selector to use when resolving DOM element.

**Returns**
- [FrameLocator]

```dart
FrameLocator frameLocator(String selector)
```

### `evaluate`

*⚙️ Method*

Returns the value of the [pageFunction] invocation.

If the function passed to the [page.evaluate()] returns a Future, then [page.evaluate()] would wait for the future to complete and return its value.

If the function passed to the [page.evaluate()] returns a non-[Serializable] value, then [page.evaluate()] resolves to `undefined`. Playwright also supports transferring some additional values that are not serializable by `JSON`: `-0`, `NaN`, `Infinity`, `-Infinity`.

**Usage**

Passing argument to [pageFunction]:

```dart
final result = await page.evaluate(([x, y]) {
return Future.value(x * y);
}, [7, 8]);
print(result); // prints "56"
```

A string can also be passed in instead of a function:

```dart
print(await page.evaluate('1 + 2')); // prints "3"
final x = 10;
print(await page.evaluate(`1 + ${x}`)); // prints "11"
```

[ElementHandle] instances can be passed as an argument to the [page.evaluate()]:

```dart
final bodyHandle = await page.evaluateHandle('document.body');
final html = await page.evaluate<string, HTMLElement>(([body, suffix]) =>
body.innerHTML + suffix, [bodyHandle, 'hello']
);
await bodyHandle.dispose();
```

**Arguments**
- `pageFunction` Function | String

Function to be evaluated in the page context.
- `arg` dynamic *(optional)*

Optional argument to pass to [pageFunction].

**Returns**
- Future&lt;[Serializable]&gt;

```dart
Future<T> evaluate<T>(String expression, [Object? arg])
```

### `waitForSelector`

*⚙️ Method*

**WARNING**
[Discouraged]

Use web assertions that assert visibility or a locator-based [locator.waitFor()] instead. Read more about [locators].

Returns when element specified by selector satisfies [state] option. Returns `null` if waiting for `hidden` or `detached`.

**NOTE**
Playwright automatically waits for element to be ready before performing an action. Using [Locator] objects and web-first assertions makes the code wait-for-selector-free.
Wait for the [selector] to satisfy [state] option (either appear/disappear from dom, or become visible/hidden). If at the moment of calling the method [selector] already satisfies the condition, the method will return immediately. If the selector doesn't satisfy the condition for the [timeout] milliseconds, the function will throw.

**Usage**

This method works across navigations:

```dart
// Or 'firefox' or 'webkit'.

(() async {
final browser = await chromium.launch();
final page = await browser.newPage();
for (final currentURL of ['https://google.com', 'https://bbc.com']) {
await page.goto(currentURL);
final element = await page.waitForSelector('img');
print('Loaded image: ' + await element.getAttribute('src'));
}
await browser.close();
}
```

**Arguments**
- `selector` String

A selector to query for.
- `options` Map *(optional)*
- `state` SelectorState *(optional)*

Defaults to `'visible'`. Can be either:
* `'attached'` - wait for element to be present in DOM.
* `'detached'` - wait for element to not be present in DOM.
* `'visible'` - wait for element to have non-empty bounding box and no `visibility:hidden`. Note that element without any content or with `display:none` has an empty bounding box and is not considered visible.
* `'hidden'` - wait for element to be either detached from DOM, or have an empty bounding box or `visibility:hidden`. This is opposite to the `'visible'` option.
- `strict` bool *(optional)*

When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;[ElementHandle]?&gt;

```dart
Future<FrameWaitForSelectorResult> waitForSelector( String selector,
```

### `routeFromHAR`

*⚙️ Method*

If specified the network requests that are made in the page will be served from the HAR file. Read more about [Replaying from HAR].

Playwright will not serve requests intercepted by Service Worker from the HAR file. See [this] issue. We recommend disabling Service Workers when using request interception by setting [serviceWorkers] to `'block'`.

**Usage**

```dart
await page.routeFromHAR(har);
await page.routeFromHAR(har, options);
```

**Arguments**
- `har` String

Path to a [HAR] file with prerecorded network data. If `path` is a relative path, then it is resolved relative to the current working directory.
- `options` Map *(optional)*
- `notFound` "abort" | "fallback" *(optional)*
* If set to 'abort' any request not found in the HAR file will be aborted.
* If set to 'fallback' missing requests will be sent to the network.

Defaults to abort.
- `update` bool *(optional)*

If specified, updates the given HAR with the actual network information instead of serving from file. The file is written to disk when [browserContext.close()] is called.
- `updateContent` "embed" | "attach" *(optional)*

Optional setting to control resource content management. If `attach` is specified, resources are persisted as separate files or entries in the ZIP archive. If `embed` is specified, content is stored inline the HAR file.
- `updateMode` "full" | "minimal" *(optional)*

When set to `minimal`, only record information necessary for routing from HAR. This omits sizes, timing, page, cookies, security and other types of HAR information that are not used when replaying from HAR. Defaults to `minimal`.
- `url` String *(optional)*

A glob pattern, regular expression or predicate to match the request URL. Only requests with URL matching the pattern will be served from the HAR file. If not specified, all requests are served from the HAR file.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> routeFromHAR( String harPath,
```

### `route`

*⚙️ Method*

Routing provides the capability to modify network requests that are made by a page.

Once routing is enabled, every request matching the url pattern will stall unless it's continued, fulfilled or aborted.

**NOTE**
The handler will only be called for the first url if the response is a redirect.
**NOTE**
[page.route()] will not intercept requests intercepted by Service Worker. See [this] issue. We recommend disabling Service Workers when using request interception by setting [serviceWorkers] to `'block'`.
**NOTE**
[page.route()] will not intercept the first request of a popup page. Use [browserContext.route()] instead.
**Usage**

An example of a naive handler that aborts all image requests:

```dart
final page = await browser.newPage();
await page.route('**/*.{png,jpg,jpeg}', (route) => route.abort());
await page.goto('https://example.com');
await browser.close();
```

or the same snippet using a regex pattern instead:

```dart
final page = await browser.newPage();
await page.route(/(\.png$)|(\.jpg$)/, (route) => route.abort());
await page.goto('https://example.com');
await browser.close();
```

It is possible to examine the request to decide the route action. For example, mocking all requests that contain some post data, and leaving all other requests as is:

```dart
await page.route('/api/**', (route) async {
if (route.request().postData().includes('my-string'))
await route.fulfill( body: 'mocked-data' );
else
await route.continue();
);
```

If a request matches multiple registered routes, the most recently registered route takes precedence.

Page routes take precedence over browser context routes (set up with [browserContext.route()]) when request matches both handlers.

To remove a route with its handler you can use [page.unroute()].

**NOTE**
Enabling routing disables http cache.
**Arguments**
- `url` String

A glob pattern, regex pattern, URL pattern, or predicate that receives a [URL] to match during routing. If [baseURL] is set in the context options and the provided URL is a string that does not start with `*`, it is resolved using the [`new URL()`] constructor.
- `handler` Future&lt;void&gt; Function(Route)

handler function to route the request.
- `options` Map *(optional)*
- `times` num *(optional)*

How often a route should be used. By default it will be used every time.

**Returns**
- Future&lt;[Disposable]&gt;

```dart
Future<void> route(String url, Future<void> Function(Route) handler)
```

### `unroute`

*⚙️ Method*

Removes a route created with [page.route()]. When [handler] is not specified, removes all routes for the [url].

**Usage**

```dart
await page.unroute(url);
await page.unroute(url, handler);
```

**Arguments**
- `url` String

A glob pattern, regex pattern, URL pattern, or predicate receiving [URL] to match while routing.
- `handler` Future&lt;void&gt; Function(Route route) *(optional)*

Optional handler function to route the request.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> unroute( String url,
```

### `unrouteAll`

*⚙️ Method*

Removes all routes created with [page.route()] and [page.routeFromHAR()].

**Usage**

```dart
await page.unrouteAll();
await page.unrouteAll(options);
```

**Arguments**
- `options` Map *(optional)*
- `behavior` "wait" | "ignoreErrors" | "default" *(optional)*

Specifies whether to wait for already running handlers and what to do if they throw errors:
* `'default'` - do not wait for current handler calls (if any) to finish, if unrouted handler throws, it may result in unhandled error
* `'wait'` - wait for current handler calls (if any) to finish
* `'ignoreErrors'` - do not wait for current handler calls (if any) to finish, all errors thrown by the handlers after unrouting are silently caught

**Returns**
- Future&lt;void&gt;

```dart
Future<void> unrouteAll()
```

### `frame`

*⚙️ Method*

Returns frame matching the specified criteria. Either `name` or `url` must be specified.

**Usage**

```dart
final frame = page.frame('frame-name');
```

```dart
final frame = page.frame( url: /.*domain.*/ );
```

**Arguments**
- `frameSelector` String | Map
- `name` String *(optional)*

Frame name specified in the `iframe`'s `name` attribute. Optional.
- `url` String *(optional)*

A glob pattern, regex pattern, URL pattern, or predicate receiving frame's `url` as a [URL] object. Optional.

Frame name or other frame lookup options.

**Returns**
- [Frame]?

```dart
Frame? frame(
```

### `getByText`

*⚙️ Method*

Allows locating elements that contain given text.

See also [locator.filter()] that allows to match by another criteria, like an accessible role, and then filter by the text content.

**Usage**

Consider the following DOM structure:

```html
<div>Hello <span>world</span></div>
<div>Hello</div>
```

You can locate by text substring, exact string, or a regular expression:

```dart
// Matches <span>
page.getByText('world');

// Matches first <div>
page.getByText('Hello world');

// Matches second <div>
page.getByText('Hello', { exact: true );

// Matches both <div>s
page.getByText(/Hello/);

// Matches second <div>
page.getByText(/^hello$/i);
```

**Arguments**
- `text` Pattern

Text to locate the element for.
- `options` Map *(optional)*
- `exact` bool *(optional)*

Whether to find an exact match: case-sensitive and whole-string. Default to false. Ignored when locating by a regular expression. Note that exact match still trims whitespace.

**Returns**
- [Locator]

**Details**

Matching by text always normalizes whitespace, even with exact match. For example, it turns multiple spaces into one, turns line breaks into spaces and ignores leading and trailing whitespace.

Input elements of the type `button` and `submit` are matched by their `value` instead of the text content. For example, locating by text `"Log in"` matches `<input type=button value="Log in">`.

```dart
Locator getByText(Pattern text,
```

### `getByRole`

*⚙️ Method*

Allows locating elements by their [ARIA role], [ARIA attributes] and [accessible name].

**Usage**

Consider the following DOM structure.

```html
<h3>Sign up</h3>
<label>
<input type="checkbox" /> Subscribe
</label>
<br/>
<button>Submit</button>
```

You can locate each element by its implicit role:

```dart
await expect(page.getByRole('heading', { name: 'Sign up' )).toBeVisible();

await page.getByRole('checkbox', { name: 'Subscribe' ).check();

await page.getByRole('button', { name: /submit/i ).click();
```

**Arguments**
- `role` String

Required aria role.
- `options` Map *(optional)*
- `checked` bool *(optional)*

An attribute that is usually set by `aria-checked` or native `<input type=checkbox>` controls.

Learn more about [`aria-checked`].
- `description` Pattern *(optional)*

Option to match the [accessible description]. By default, matching is case-insensitive and searches for a substring, use [exact] to control this behavior.

Learn more about [accessible description].
- `disabled` bool *(optional)*

An attribute that is usually set by `aria-disabled` or `disabled`.

**NOTE**
Unlike most other attributes, `disabled` is inherited through the DOM hierarchy. Learn more about [`aria-disabled`].
- `exact` bool *(optional)*

Whether [name] and [description] are matched exactly: case-sensitive and whole-string. Defaults to false. Ignored when the value is a regular expression. Note that exact match still trims whitespace.
- `expanded` bool *(optional)*

An attribute that is usually set by `aria-expanded`.

Learn more about [`aria-expanded`].
- `includeHidden` bool *(optional)*

Option that controls whether hidden elements are matched. By default, only non-hidden elements, as [defined by ARIA], are matched by role selector.

Learn more about [`aria-hidden`].
- `level` int *(optional)*

A number attribute that is usually present for roles `heading`, `listitem`, `row`, `treeitem`, with default values for `<h1>-<h6>` elements.

Learn more about [`aria-level`].
- `name` Pattern *(optional)*

Option to match the [accessible name]. By default, matching is case-insensitive and searches for a substring, use [exact] to control this behavior.

Learn more about [accessible name].
- `pressed` bool *(optional)*

An attribute that is usually set by `aria-pressed`.

Learn more about [`aria-pressed`].
- `selected` bool *(optional)*

An attribute that is usually set by `aria-selected`.

Learn more about [`aria-selected`].

**Returns**
- [Locator]

**Details**

Role selector **does not replace** accessibility audits and conformance tests, but rather gives early feedback about the ARIA guidelines.

Many html elements have an implicitly [defined role] that is recognized by the role selector. You can find all the [supported roles here]. ARIA guidelines **do not recommend** duplicating implicit roles and attributes by setting `role` and/or `aria-*` attributes to default values.

```dart
Locator getByRole( String role,
```

### `getByLabel`

*⚙️ Method*

Allows locating input elements by the text of the associated `<label>` or `aria-labelledby` element, or by the `aria-label` attribute.

**Usage**

For example, this method will find inputs by label "Username" and "Password" in the following DOM:

```html
<input aria-label="Username">
<label for="password-input">Password:</label>
<input id="password-input">
```

```dart
await page.getByLabel('Username').fill('john');
await page.getByLabel('Password').fill('secret');
```

**Arguments**
- `text` Pattern

Text to locate the element for.
- `options` Map *(optional)*
- `exact` bool *(optional)*

Whether to find an exact match: case-sensitive and whole-string. Default to false. Ignored when locating by a regular expression. Note that exact match still trims whitespace.

**Returns**
- [Locator]

```dart
Locator getByLabel(Pattern text,
```

### `getByPlaceholder`

*⚙️ Method*

Allows locating input elements by the placeholder text.

**Usage**

For example, consider the following DOM structure.

```html
<input type="email" placeholder="name@example.com" />
```

You can fill the input after locating it by the placeholder text:

```dart
await page
.getByPlaceholder('name@example.com')
.fill('playwright@microsoft.com');
```

**Arguments**
- `text` Pattern

Text to locate the element for.
- `options` Map *(optional)*
- `exact` bool *(optional)*

Whether to find an exact match: case-sensitive and whole-string. Default to false. Ignored when locating by a regular expression. Note that exact match still trims whitespace.

**Returns**
- [Locator]

```dart
Locator getByPlaceholder(Pattern text,
```

### `getByAltText`

*⚙️ Method*

Allows locating elements by their alt text.

**Usage**

For example, this method will find the image by alt text "Playwright logo":

```html
<img alt='Playwright logo'>
```

```dart
await page.getByAltText('Playwright logo').click();
```

**Arguments**
- `text` Pattern

Text to locate the element for.
- `options` Map *(optional)*
- `exact` bool *(optional)*

Whether to find an exact match: case-sensitive and whole-string. Default to false. Ignored when locating by a regular expression. Note that exact match still trims whitespace.

**Returns**
- [Locator]

```dart
Locator getByAltText(Pattern text,
```

### `getByTitle`

*⚙️ Method*

Allows locating elements by their title attribute.

**Usage**

Consider the following DOM structure.

```html
<span title='Issues count'>25 issues</span>
```

You can check the issues count after locating it by the title text:

```dart
await expect(page.getByTitle('Issues count')).toHaveText('25 issues');
```

**Arguments**
- `text` Pattern

Text to locate the element for.
- `options` Map *(optional)*
- `exact` bool *(optional)*

Whether to find an exact match: case-sensitive and whole-string. Default to false. Ignored when locating by a regular expression. Note that exact match still trims whitespace.

**Returns**
- [Locator]

```dart
Locator getByTitle(Pattern text,
```

### `getByTestId`

*⚙️ Method*

Locate element by the test id.

**Usage**

Consider the following DOM structure.

```html
<button data-testid="directions">Itinéraire</button>
```

You can locate the element by its test id:

```dart
await page.getByTestId('directions').click();
```

**Arguments**
- `testId` String

Id to locate the element by.

**Returns**
- [Locator]

**Details**

By default, the `data-testid` attribute is used as a test id. Use [selectors.setTestIdAttribute()] to configure a different test id attribute if necessary.

```dart
// Set custom test id attribute from @playwright/test config:

export default defineConfig(
use: {
testIdAttribute: 'data-pw'
},
);
```

```dart
Locator getByTestId(String testId)
```

### `pageExpect`

*⚙️ Method*

Returns web-first page-level assertions for this page.

Usage:
```dart
await page.pageExpect().toHaveTitle('My Title');
await page.pageExpect().not.toHaveURL('/login');
```

```dart
PageAssertions pageExpect(
```

### `setViewportSize`

*⚙️ Method*

In the case of multiple pages in a single browser, each page can have its own viewport size. However, [browser.newContext()] allows to set viewport size (and more) for all pages in the context at once.

[page.setViewportSize()] will resize the page. A lot of websites don't expect phones to change size, so you should set the viewport size before navigating to the page. [page.setViewportSize()] will also reset `screen` size, use [browser.newContext()] with `screen` and `viewport` parameters if you need better control of these properties.

**Usage**

```dart
final page = await browser.newPage();
await page.setViewportSize(
width: 640,
height: 480,
);
await page.goto('https://example.com');
```

**Arguments**
- `viewportSize` PageSetViewportSize
- `width` num

page width in pixels.
- `height` num

page height in pixels.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> setViewportSize(PageSetViewportSize viewportSize)
```

### `screenshot`

*⚙️ Method*

Returns the buffer with the captured screenshot.

**Usage**

```dart
await page.screenshot();
await page.screenshot(options);
```

**Arguments**
- `options` Map *(optional)*
- `animations` "disabled" | "allow" *(optional)*

When set to `"disabled"`, stops CSS animations, CSS transitions and Web Animations. Animations get different treatment depending on their duration:
* finite animations are fast-forwarded to completion, so they'll fire `transitionend` event.
* infinite animations are canceled to initial state, and then played over after the screenshot.

Defaults to `"allow"` that leaves animations untouched.
- `caret` "hide" | "initial" *(optional)*

When set to `"hide"`, screenshot will hide text caret. When set to `"initial"`, text caret behavior will not be changed.  Defaults to `"hide"`.
- `clip` Map&lt;String, dynamic&gt; *(optional)*
- `x` num

x-coordinate of top-left corner of clip area
- `y` num

y-coordinate of top-left corner of clip area
- `width` num

width of clipping area
- `height` num

height of clipping area

An object which specifies clipping of the resulting image.
- `fullPage` bool *(optional)*

When true, takes a screenshot of the full scrollable page, instead of the currently visible viewport. Defaults to `false`.
- `mask` List&lt;[Locator]&gt; *(optional)*

Specify locators that should be masked when the screenshot is taken. Masked elements will be overlaid with a pink box `#FF00FF` (customized by [maskColor]) that completely covers its bounding box. The mask is also applied to invisible elements, see [Matching only visible elements] to disable that.
- `maskColor` String *(optional)*

Specify the color of the overlay box for masked elements, in [CSS color format]. Default color is pink `#FF00FF`.
- `omitBackground` bool *(optional)*

Hides default white background and allows capturing screenshots with transparency. Not applicable to `jpeg` images. Defaults to `false`.
- `path` String *(optional)*

The file path to save the image to. The screenshot type will be inferred from file extension. If [path] is a relative path, then it is resolved relative to the current working directory. If no path is provided, the image won't be saved to the disk.
- `quality` int *(optional)*

The quality of the image, between 0-100. Not applicable to `png` images.
- `scale` "css" | "device" *(optional)*

When set to `"css"`, screenshot will have a single pixel per each css pixel on the page. For high-dpi devices, this will keep screenshots small. Using `"device"` option will produce a single pixel per each device pixel, so screenshots of high-dpi devices will be twice as large or even larger.

Defaults to `"device"`.
- `style` String *(optional)*

Text of the stylesheet to apply while making the screenshot. This is where you can hide dynamic elements, make elements invisible or change their properties to help you creating repeatable screenshots. This stylesheet pierces the Shadow DOM and applies to the inner frames.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
- `type` String *(optional)*

Specify screenshot type, defaults to `png`.

**Returns**
- Future&lt;List&lt;int&gt;&gt;

```dart
Future<Uint8List> screenshot(
```

### `pdf`

*⚙️ Method*

Returns the PDF buffer.

`page.pdf()` generates a pdf of the page with `print` css media. To generate a pdf with `screen` media, call [page.emulateMedia()] before calling `page.pdf()`:

**NOTE**
By default, `page.pdf()` generates a pdf with modified colors for printing. Use the [`-webkit-print-color-adjust`] property to force rendering of exact colors.
**Usage**

```dart
// Generates a PDF with 'screen' media type.
await page.emulateMedia( media: 'screen' );
await page.pdf( path: 'page.pdf' );
```

The [width], [height], and [margin] options accept values labeled with units. Unlabeled values are treated as pixels.

A few examples:
* `page.pdf(width: 100)` - prints with width set to 100 pixels
* `page.pdf(width: '100px')` - prints with width set to 100 pixels
* `page.pdf(width: '10cm')` - prints with width set to 10 centimeters.

All possible units are:
* `px` - pixel
* `in` - inch
* `cm` - centimeter
* `mm` - millimeter

The [format] options are:
* `Letter`: 8.5in x 11in
* `Legal`: 8.5in x 14in
* `Tabloid`: 11in x 17in
* `Ledger`: 17in x 11in
* `A0`: 33.1in x 46.8in
* `A1`: 23.4in x 33.1in
* `A2`: 16.54in x 23.4in
* `A3`: 11.7in x 16.54in
* `A4`: 8.27in x 11.7in
* `A5`: 5.83in x 8.27in
* `A6`: 4.13in x 5.83in

**NOTE**
[headerTemplate] and [footerTemplate] markup have the following limitations: > 1. Script tags inside templates are not evaluated. > 2. Page styles are not visible inside templates.
**Arguments**
- `options` Map *(optional)*
- `displayHeaderFooter` bool *(optional)*

Display header and footer. Defaults to `false`.
- `footerTemplate` String *(optional)*

HTML template for the print footer. Should use the same format as the [headerTemplate].
- `format` String *(optional)*

Paper format. If set, takes priority over [width] or [height] options. Defaults to 'Letter'.
- `headerTemplate` String *(optional)*

HTML template for the print header. Should be valid HTML markup with following classes used to inject printing values into them:
* `'date'` formatted print date
* `'title'` document title
* `'url'` document location
* `'pageNumber'` current page number
* `'totalPages'` total pages in the document
- `height` dynamic *(optional)*

Paper height, accepts values labeled with units.
- `landscape` bool *(optional)*

Paper orientation. Defaults to `false`.
- `margin` PagePdfMargin *(optional)*
- `top` String | num *(optional)*

Top margin, accepts values labeled with units. Defaults to `0`.
- `right` String | num *(optional)*

Right margin, accepts values labeled with units. Defaults to `0`.
- `bottom` String | num *(optional)*

Bottom margin, accepts values labeled with units. Defaults to `0`.
- `left` String | num *(optional)*

Left margin, accepts values labeled with units. Defaults to `0`.

Paper margins, defaults to none.
- `outline` bool *(optional)*

Whether or not to embed the document outline into the PDF. Defaults to `false`.
- `pageRanges` String *(optional)*

Paper ranges to print, e.g., '1-5, 8, 11-13'. Defaults to the empty string, which means print all pages.
- `path` String *(optional)*

The file path to save the PDF to. If [path] is a relative path, then it is resolved relative to the current working directory. If no path is provided, the PDF won't be saved to the disk.
- `preferCSSPageSize` bool *(optional)*

Give any CSS `@page` size declared in the page priority over what is declared in [width] and [height] or [format] options. Defaults to `false`, which will scale the content to fit the paper size.
- `printBackground` bool *(optional)*

Print background graphics. Defaults to `false`.
- `scale` double *(optional)*

Scale of the webpage rendering. Defaults to `1`. Scale amount must be between 0.1 and 2.
- `tagged` bool *(optional)*

Whether or not to generate tagged (accessible) PDF. Defaults to `false`.
- `width` dynamic *(optional)*

Paper width, accepts values labeled with units.

**Returns**
- Future&lt;List&lt;int&gt;&gt;

```dart
Future<Uint8List> pdf(
```

### `reload`

*⚙️ Method*

This method reloads the current page, in the same way as if the user had triggered a browser refresh. Returns the main resource response. In case of multiple redirects, the navigation will resolve with the response of the last redirect.

**Usage**

```dart
await page.reload();
await page.reload(options);
```

**Arguments**
- `options` Map *(optional)*
- `timeout` double *(optional)*

Maximum operation time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `navigationTimeout` option in the config, or by using the [browserContext.setDefaultNavigationTimeout()], [browserContext.setDefaultTimeout()], [page.setDefaultNavigationTimeout()] or [page.setDefaultTimeout()] methods.
- `waitUntil` LifecycleEvent *(optional)*

When to consider operation succeeded, defaults to `load`. Events can be either:
* `'domcontentloaded'` - consider operation to be finished when the `DOMContentLoaded` event is fired.
* `'load'` - consider operation to be finished when the `load` event is fired.
* `'networkidle'` - **DISCOURAGED** consider operation to be finished when there are no network connections for at least `500` ms. Don't use this method for testing, rely on web assertions to assess readiness instead.
* `'commit'` - consider operation to be finished when network response is received and the document started loading.

**Returns**
- Future&lt;[Response]?&gt;

```dart
Future<void> reload(
```

### `goBack`

*⚙️ Method*

Returns the main resource response. In case of multiple redirects, the navigation will resolve with the response of the last redirect. If cannot go back, returns `null`.

Navigate to the previous page in history.

**Usage**

```dart
await page.goBack();
await page.goBack(options);
```

**Arguments**
- `options` Map *(optional)*
- `timeout` double *(optional)*

Maximum operation time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `navigationTimeout` option in the config, or by using the [browserContext.setDefaultNavigationTimeout()], [browserContext.setDefaultTimeout()], [page.setDefaultNavigationTimeout()] or [page.setDefaultTimeout()] methods.
- `waitUntil` LifecycleEvent *(optional)*

When to consider operation succeeded, defaults to `load`. Events can be either:
* `'domcontentloaded'` - consider operation to be finished when the `DOMContentLoaded` event is fired.
* `'load'` - consider operation to be finished when the `load` event is fired.
* `'networkidle'` - **DISCOURAGED** consider operation to be finished when there are no network connections for at least `500` ms. Don't use this method for testing, rely on web assertions to assess readiness instead.
* `'commit'` - consider operation to be finished when network response is received and the document started loading.

**Returns**
- Future&lt;[Response]?&gt;

```dart
Future<void> goBack(
```

### `goForward`

*⚙️ Method*

Returns the main resource response. In case of multiple redirects, the navigation will resolve with the response of the last redirect. If cannot go forward, returns `null`.

Navigate to the next page in history.

**Usage**

```dart
await page.goForward();
await page.goForward(options);
```

**Arguments**
- `options` Map *(optional)*
- `timeout` double *(optional)*

Maximum operation time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `navigationTimeout` option in the config, or by using the [browserContext.setDefaultNavigationTimeout()], [browserContext.setDefaultTimeout()], [page.setDefaultNavigationTimeout()] or [page.setDefaultTimeout()] methods.
- `waitUntil` LifecycleEvent *(optional)*

When to consider operation succeeded, defaults to `load`. Events can be either:
* `'domcontentloaded'` - consider operation to be finished when the `DOMContentLoaded` event is fired.
* `'load'` - consider operation to be finished when the `load` event is fired.
* `'networkidle'` - **DISCOURAGED** consider operation to be finished when there are no network connections for at least `500` ms. Don't use this method for testing, rely on web assertions to assess readiness instead.
* `'commit'` - consider operation to be finished when network response is received and the document started loading.

**Returns**
- Future&lt;[Response]?&gt;

```dart
Future<void> goForward(
```

### `addInitScript`

*⚙️ Method*

Adds a script which would be evaluated in one of the following scenarios:
* Whenever the page is navigated.
* Whenever the child frame is attached or navigated. In this case, the script is evaluated in the context of the newly attached frame.

The script is evaluated after the document was created but before any of its scripts were run. This is useful to amend the JavaScript environment, e.g. to seed `Math.random`.

**Usage**

An example of overriding `Math.random` before the page loads:

```dart
// preload.js
Math.random = () => 42;
```

```dart
// In your playwright script, assuming the preload.js file is in same directory
await page.addInitScript( path: './preload.js' );
```

```dart
await page.addInitScript((mock) {
window.mock = mock;
}, mock);
```

**NOTE**
The order of evaluation of multiple scripts installed via [browserContext.addInitScript()] and [page.addInitScript()] is not defined.
**Arguments**
- `script` Function | String | Map
- `path` String *(optional)*

Path to the JavaScript file. If `path` is a relative path, then it is resolved relative to the current working directory. Optional.
- `content` String *(optional)*

Raw script content. Optional.

Script to be evaluated in the page.
- `arg` [Serializable] *(optional)*

Optional argument to pass to [script] (only supported when passing a function).

**Returns**
- Future&lt;[Disposable]&gt;

```dart
Future<void> addInitScript(String source)
```

### `close`

*⚙️ Method*

If [runBeforeUnload] is `false`, does not run any unload handlers and waits for the page to be closed. If [runBeforeUnload] is `true` the method will run unload handlers, but will **not** wait for the page to close.

By default, `page.close()` **does not** run `beforeunload` handlers.

**NOTE**
if [runBeforeUnload] is passed as true, a `beforeunload` dialog might be summoned and should be handled manually via [page.on('dialog')] event.
**Usage**

```dart
await page.close();
await page.close(options);
```

**Arguments**
- `options` Map *(optional)*
- `reason` String *(optional)*

The reason to be reported to the operations interrupted by the page closure.
- `runBeforeUnload` bool *(optional)*

Defaults to `false`. Whether to run the [before unload] page handlers.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> close(
```

### `emulateMedia`

*⚙️ Method*

This method changes the `CSS media type` through the `media` argument, and/or the `'prefers-colors-scheme'` media feature, using the `colorScheme` argument.

**Usage**

```dart
await page.evaluate(() => matchMedia('screen').matches);
// → true
await page.evaluate(() => matchMedia('print').matches);
// → false

await page.emulateMedia( media: 'print' );
await page.evaluate(() => matchMedia('screen').matches);
// → false
await page.evaluate(() => matchMedia('print').matches);
// → true

await page.emulateMedia();
await page.evaluate(() => matchMedia('screen').matches);
// → true
await page.evaluate(() => matchMedia('print').matches);
// → false
```

```dart
await page.emulateMedia( colorScheme: 'dark' );
await page.evaluate(() => matchMedia('(prefers-color-scheme: dark)').matches);
// → true
await page.evaluate(() => matchMedia('(prefers-color-scheme: light)').matches);
// → false
```

**Arguments**
- `options` Map *(optional)*
- `colorScheme` Scheme *(optional)*

Emulates [prefers-colors-scheme] media feature, supported values are `'light'` and `'dark'`. Passing `null` disables color scheme emulation. `'no-preference'` is deprecated.
- `contrast` Contrast *(optional)*

Emulates `'prefers-contrast'` media feature, supported values are `'no-preference'`, `'more'`. Passing `null` disables contrast emulation.
- `forcedColors` Colors *(optional)*

Emulates `'forced-colors'` media feature, supported values are `'active'` and `'none'`. Passing `null` disables forced colors emulation.
- `media` Media *(optional)*

Changes the CSS media type of the page. The only allowed values are `'screen'`, `'print'` and `null`. Passing `null` disables CSS media emulation.
- `reducedMotion` Motion *(optional)*

Emulates `'prefers-reduced-motion'` media feature, supported values are `'reduce'`, `'no-preference'`. Passing `null` disables reduced motion emulation.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> emulateMedia(
```

### `click`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.click()] instead. Read more about [locators].

This method clicks an element matching [selector] by performing the following steps:
1. Find an element matching [selector]. If there is none, wait until a matching element is attached to the DOM.
1. Wait for [actionability] checks on the matched element, unless [force] option is set. If the element is detached during the checks, the whole action is retried.
1. Scroll the element into view if needed.
1. Use [page.mouse] to click in the center of the element, or the specified [position].
1. Wait for initiated navigations to either succeed or fail, unless [noWaitAfter] option is set.

When all steps combined have not finished during the specified [timeout], this method throws a [TimeoutError]. Passing zero timeout disables this.

**Usage**

```dart
await page.click(selector);
await page.click(selector, options);
```

**Arguments**
- `selector` String

A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
- `options` Map *(optional)*
- `button` "left" | "right" | "middle" *(optional)*

Defaults to `left`.
- `clickCount` num *(optional)*

defaults to 1. See [UIEvent.detail].
- `delay` num *(optional)*

Time to wait between `mousedown` and `mouseup` in milliseconds. Defaults to 0.
- `force` bool *(optional)*

Whether to bypass the [actionability] checks. Defaults to `false`.
- `modifiers` List&lt;"Alt" | "Control" | "ControlOrMeta" | "Meta" | "Shift"&gt; *(optional)*

Modifier keys to press. Ensures that only these modifiers are pressed during the operation, and then restores current modifiers back. If not specified, currently pressed modifiers are used. "ControlOrMeta" resolves to "Control" on Windows and Linux and to "Meta" on macOS.
- `noWaitAfter` bool *(optional)*

**WARNING**
[Deprecated]
This option will default to `true` in the future.
Actions that initiate navigations are waiting for these navigations to happen and for pages to start loading. You can opt out of waiting via setting this flag. You would only need this option in the exceptional cases such as navigating to inaccessible pages. Defaults to `false`.
- `position` Map *(optional)*
- `x` num


- `y` num


A point to use relative to the top-left corner of element padding box. If not specified, uses some visible point of the element.
- `strict` bool *(optional)*

When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
- `trial` bool *(optional)*

When set, this method only performs the [actionability] checks and skips the action. Defaults to `false`. Useful to wait until the element is ready for the action without performing it. Note that keyboard `modifiers` will be pressed regardless of `trial` to allow testing elements which are only visible when those keys are pressed.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> click(String selector,
```

### `fill`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.fill()] instead. Read more about [locators].

This method waits for an element matching [selector], waits for [actionability] checks, focuses the element, fills it and triggers an `input` event after filling. Note that you can pass an empty string to clear the input field.

If the target element is not an `<input>`, `<textarea>` or `[contenteditable]` element, this method throws an error. However, if the element is inside the `<label>` element that has an associated [control], the control will be filled instead.

To send fine-grained keyboard events, use [locator.pressSequentially()].

**Usage**

```dart
await page.fill(selector, value);
await page.fill(selector, value, options);
```

**Arguments**
- `selector` String

A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
- `value` String

Value to fill for the `<input>`, `<textarea>` or `[contenteditable]` element.
- `options` Map *(optional)*
- `force` bool *(optional)*

Whether to bypass the [actionability] checks. Defaults to `false`.
- `noWaitAfter` bool *(optional)*

**WARNING**
[Deprecated]
This option has no effect.
This option has no effect.
- `strict` bool *(optional)*

When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> fill( String selector, String value,
```

### `check`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.check()] instead. Read more about [locators].

This method checks an element matching [selector] by performing the following steps:
1. Find an element matching [selector]. If there is none, wait until a matching element is attached to the DOM.
1. Ensure that matched element is a checkbox or a radio input. If not, this method throws. If the element is already checked, this method returns immediately.
1. Wait for [actionability] checks on the matched element, unless [force] option is set. If the element is detached during the checks, the whole action is retried.
1. Scroll the element into view if needed.
1. Use [page.mouse] to click in the center of the element.
1. Ensure that the element is now checked. If not, this method throws.

When all steps combined have not finished during the specified [timeout], this method throws a [TimeoutError]. Passing zero timeout disables this.

**Usage**

```dart
await page.check(selector);
await page.check(selector, options);
```

**Arguments**
- `selector` String

A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
- `options` Map *(optional)*
- `force` bool *(optional)*

Whether to bypass the [actionability] checks. Defaults to `false`.
- `noWaitAfter` bool *(optional)*

**WARNING**
[Deprecated]
This option has no effect.
This option has no effect.
- `position` Map *(optional)*
- `x` num


- `y` num


A point to use relative to the top-left corner of element padding box. If not specified, uses some visible point of the element.
- `strict` bool *(optional)*

When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
- `trial` bool *(optional)*

When set, this method only performs the [actionability] checks and skips the action. Defaults to `false`. Useful to wait until the element is ready for the action without performing it.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> check(String selector,
```

### `uncheck`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.uncheck()] instead. Read more about [locators].

This method unchecks an element matching [selector] by performing the following steps:
1. Find an element matching [selector]. If there is none, wait until a matching element is attached to the DOM.
1. Ensure that matched element is a checkbox or a radio input. If not, this method throws. If the element is already unchecked, this method returns immediately.
1. Wait for [actionability] checks on the matched element, unless [force] option is set. If the element is detached during the checks, the whole action is retried.
1. Scroll the element into view if needed.
1. Use [page.mouse] to click in the center of the element.
1. Ensure that the element is now unchecked. If not, this method throws.

When all steps combined have not finished during the specified [timeout], this method throws a [TimeoutError]. Passing zero timeout disables this.

**Usage**

```dart
await page.uncheck(selector);
await page.uncheck(selector, options);
```

**Arguments**
- `selector` String

A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
- `options` Map *(optional)*
- `force` bool *(optional)*

Whether to bypass the [actionability] checks. Defaults to `false`.
- `noWaitAfter` bool *(optional)*

**WARNING**
[Deprecated]
This option has no effect.
This option has no effect.
- `position` Map *(optional)*
- `x` num


- `y` num


A point to use relative to the top-left corner of element padding box. If not specified, uses some visible point of the element.
- `strict` bool *(optional)*

When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
- `trial` bool *(optional)*

When set, this method only performs the [actionability] checks and skips the action. Defaults to `false`. Useful to wait until the element is ready for the action without performing it.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> uncheck(String selector,
```

### `setChecked`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.setChecked()] instead. Read more about [locators].

This method checks or unchecks an element matching [selector] by performing the following steps:
1. Find an element matching [selector]. If there is none, wait until a matching element is attached to the DOM.
1. Ensure that matched element is a checkbox or a radio input. If not, this method throws.
1. If the element already has the right checked state, this method returns immediately.
1. Wait for [actionability] checks on the matched element, unless [force] option is set. If the element is detached during the checks, the whole action is retried.
1. Scroll the element into view if needed.
1. Use [page.mouse] to click in the center of the element.
1. Ensure that the element is now checked or unchecked. If not, this method throws.

When all steps combined have not finished during the specified [timeout], this method throws a [TimeoutError]. Passing zero timeout disables this.

**Usage**

```dart
await page.setChecked(selector, checked);
await page.setChecked(selector, checked, options);
```

**Arguments**
- `selector` String

A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
- `checked` bool

Whether to check or uncheck the checkbox.
- `options` Map *(optional)*
- `force` bool *(optional)*

Whether to bypass the [actionability] checks. Defaults to `false`.
- `noWaitAfter` bool *(optional)*

**WARNING**
[Deprecated]
This option has no effect.
This option has no effect.
- `position` Map *(optional)*
- `x` num


- `y` num


A point to use relative to the top-left corner of element padding box. If not specified, uses some visible point of the element.
- `strict` bool *(optional)*

When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
- `trial` bool *(optional)*

When set, this method only performs the [actionability] checks and skips the action. Defaults to `false`. Useful to wait until the element is ready for the action without performing it.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> setChecked( String selector, bool checked,
```

### `hover`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.hover()] instead. Read more about [locators].

This method hovers over an element matching [selector] by performing the following steps:
1. Find an element matching [selector]. If there is none, wait until a matching element is attached to the DOM.
1. Wait for [actionability] checks on the matched element, unless [force] option is set. If the element is detached during the checks, the whole action is retried.
1. Scroll the element into view if needed.
1. Use [page.mouse] to hover over the center of the element, or the specified [position].

When all steps combined have not finished during the specified [timeout], this method throws a [TimeoutError]. Passing zero timeout disables this.

**Usage**

```dart
await page.hover(selector);
await page.hover(selector, options);
```

**Arguments**
- `selector` String

A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
- `options` Map *(optional)*
- `force` bool *(optional)*

Whether to bypass the [actionability] checks. Defaults to `false`.
- `modifiers` List&lt;"Alt" | "Control" | "ControlOrMeta" | "Meta" | "Shift"&gt; *(optional)*

Modifier keys to press. Ensures that only these modifiers are pressed during the operation, and then restores current modifiers back. If not specified, currently pressed modifiers are used. "ControlOrMeta" resolves to "Control" on Windows and Linux and to "Meta" on macOS.
- `noWaitAfter` bool *(optional)*

**WARNING**
[Deprecated]
This option has no effect.
This option has no effect.
- `position` Map *(optional)*
- `x` num


- `y` num


A point to use relative to the top-left corner of element padding box. If not specified, uses some visible point of the element.
- `strict` bool *(optional)*

When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
- `trial` bool *(optional)*

When set, this method only performs the [actionability] checks and skips the action. Defaults to `false`. Useful to wait until the element is ready for the action without performing it. Note that keyboard `modifiers` will be pressed regardless of `trial` to allow testing elements which are only visible when those keys are pressed.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> hover(String selector,
```

### `focus`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.focus()] instead. Read more about [locators].

This method fetches an element with [selector] and focuses it. If there's no element matching [selector], the method waits until a matching element appears in the DOM.

**Usage**

```dart
await page.focus(selector);
await page.focus(selector, options);
```

**Arguments**
- `selector` String

A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
- `options` Map *(optional)*
- `strict` bool *(optional)*

When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> focus(String selector,
```

### `blur`

*⚙️ Method*

Removes focus from an element matching the selector.

```dart
Future<void> blur(String selector,
```

### `dblclick`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.dblclick()] instead. Read more about [locators].

This method double clicks an element matching [selector] by performing the following steps:
1. Find an element matching [selector]. If there is none, wait until a matching element is attached to the DOM.
1. Wait for [actionability] checks on the matched element, unless [force] option is set. If the element is detached during the checks, the whole action is retried.
1. Scroll the element into view if needed.
1. Use [page.mouse] to double click in the center of the element, or the specified [position].

When all steps combined have not finished during the specified [timeout], this method throws a [TimeoutError]. Passing zero timeout disables this.

**NOTE**
`page.dblclick()` dispatches two `click` events and a single `dblclick` event.
**Usage**

```dart
await page.dblclick(selector);
await page.dblclick(selector, options);
```

**Arguments**
- `selector` String

A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
- `options` Map *(optional)*
- `button` "left" | "right" | "middle" *(optional)*

Defaults to `left`.
- `delay` num *(optional)*

Time to wait between `mousedown` and `mouseup` in milliseconds. Defaults to 0.
- `force` bool *(optional)*

Whether to bypass the [actionability] checks. Defaults to `false`.
- `modifiers` List&lt;"Alt" | "Control" | "ControlOrMeta" | "Meta" | "Shift"&gt; *(optional)*

Modifier keys to press. Ensures that only these modifiers are pressed during the operation, and then restores current modifiers back. If not specified, currently pressed modifiers are used. "ControlOrMeta" resolves to "Control" on Windows and Linux and to "Meta" on macOS.
- `noWaitAfter` bool *(optional)*

**WARNING**
[Deprecated]
This option has no effect.
This option has no effect.
- `position` Map *(optional)*
- `x` num


- `y` num


A point to use relative to the top-left corner of element padding box. If not specified, uses some visible point of the element.
- `strict` bool *(optional)*

When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
- `trial` bool *(optional)*

When set, this method only performs the [actionability] checks and skips the action. Defaults to `false`. Useful to wait until the element is ready for the action without performing it. Note that keyboard `modifiers` will be pressed regardless of `trial` to allow testing elements which are only visible when those keys are pressed.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> dblclick(String selector,
```

### `type`

*⚙️ Method*

**WARNING**
[Deprecated]

In most cases, you should use [locator.fill()] instead. You only need to press keys one by one if there is special keyboard handling on the page - in this case use [locator.pressSequentially()].

Sends a `keydown`, `keypress`/`input`, and `keyup` event for each character in the text. `page.type` can be used to send fine-grained keyboard events. To fill values in form fields, use [page.fill()].

To press a special key, like `Control` or `ArrowDown`, use [keyboard.press()].

**Usage**

**Arguments**
- `selector` String

A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
- `text` String

A text to type into a focused element.
- `options` Map *(optional)*
- `delay` double *(optional)*

Time to wait between key presses in milliseconds. Defaults to 0.
- `noWaitAfter` bool *(optional)*

**WARNING**
[Deprecated]
This option has no effect.
This option has no effect.
- `strict` bool *(optional)*

When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> type( String selector, String text,
```

### `press`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.press()] instead. Read more about [locators].

Focuses the element, and then uses [keyboard.down()] and [keyboard.up()].

[key] can specify the intended [keyboardEvent.key] value or a single character to generate the text for. A superset of the [key] values can be found [here]. Examples of the keys are:

`F1` - `F12`, `Digit0`- `Digit9`, `KeyA`- `KeyZ`, `Backquote`, `Minus`, `Equal`, `Backslash`, `Backspace`, `Tab`, `Delete`, `Escape`, `ArrowDown`, `End`, `Enter`, `Home`, `Insert`, `PageDown`, `PageUp`, `ArrowRight`, `ArrowUp`, etc.

Following modification shortcuts are also supported: `Shift`, `Control`, `Alt`, `Meta`, `ShiftLeft`, `ControlOrMeta`. `ControlOrMeta` resolves to `Control` on Windows and Linux and to `Meta` on macOS.

Holding down `Shift` will type the text that corresponds to the [key] in the upper case.

If [key] is a single character, it is case-sensitive, so the values `a` and `A` will generate different respective texts.

Shortcuts such as `key: "Control+o"`, `key: "Control++` or `key: "Control+Shift+T"` are supported as well. When specified with the modifier, modifier is pressed and being held while the subsequent key is being pressed.

**Usage**

```dart
final page = await browser.newPage();
await page.goto('https://keycode.info');
await page.press('body', 'A');
await page.screenshot( path: 'A.png' );
await page.press('body', 'ArrowLeft');
await page.screenshot( path: 'ArrowLeft.png' );
await page.press('body', 'Shift+O');
await page.screenshot( path: 'O.png' );
await browser.close();
```

**Arguments**
- `selector` String

A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
- `key` String

Name of the key to press or a character to generate, such as `ArrowLeft` or `a`.
- `options` Map *(optional)*
- `delay` double *(optional)*

Time to wait between `keydown` and `keyup` in milliseconds. Defaults to 0.
- `noWaitAfter` bool *(optional)*

**WARNING**
[Deprecated]
This option will default to `true` in the future.
Actions that initiate navigations are waiting for these navigations to happen and for pages to start loading. You can opt out of waiting via setting this flag. You would only need this option in the exceptional cases such as navigating to inaccessible pages. Defaults to `false`.
- `strict` bool *(optional)*

When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> press( String selector, String key,
```

### `tap`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.tap()] instead. Read more about [locators].

This method taps an element matching [selector] by performing the following steps:
1. Find an element matching [selector]. If there is none, wait until a matching element is attached to the DOM.
1. Wait for [actionability] checks on the matched element, unless [force] option is set. If the element is detached during the checks, the whole action is retried.
1. Scroll the element into view if needed.
1. Use [page.touchscreen] to tap the center of the element, or the specified [position].

When all steps combined have not finished during the specified [timeout], this method throws a [TimeoutError]. Passing zero timeout disables this.

**NOTE**
[page.tap()] will throw if the [hasTouch] option of the browser context is false.
**Usage**

```dart
await page.tap(selector);
await page.tap(selector, options);
```

**Arguments**
- `selector` String

A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
- `options` Map *(optional)*
- `force` bool *(optional)*

Whether to bypass the [actionability] checks. Defaults to `false`.
- `modifiers` List&lt;"Alt" | "Control" | "ControlOrMeta" | "Meta" | "Shift"&gt; *(optional)*

Modifier keys to press. Ensures that only these modifiers are pressed during the operation, and then restores current modifiers back. If not specified, currently pressed modifiers are used. "ControlOrMeta" resolves to "Control" on Windows and Linux and to "Meta" on macOS.
- `noWaitAfter` bool *(optional)*

**WARNING**
[Deprecated]
This option has no effect.
This option has no effect.
- `position` Map *(optional)*
- `x` num


- `y` num


A point to use relative to the top-left corner of element padding box. If not specified, uses some visible point of the element.
- `strict` bool *(optional)*

When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
- `trial` bool *(optional)*

When set, this method only performs the [actionability] checks and skips the action. Defaults to `false`. Useful to wait until the element is ready for the action without performing it. Note that keyboard `modifiers` will be pressed regardless of `trial` to allow testing elements which are only visible when those keys are pressed.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> tap(String selector,
```

### `content`

*⚙️ Method*

Gets the full HTML contents of the page, including the doctype.

**Usage**

```dart
await page.content();
```

**Returns**
- Future&lt;String&gt;

```dart
Future<String> content()
```

### `setContent`

*⚙️ Method*

This method internally calls [document.write()], inheriting all its specific characteristics and behaviors.

**Usage**

```dart
await page.setContent(html);
await page.setContent(html, options);
```

**Arguments**
- `html` String

HTML markup to assign to the page.
- `options` Map *(optional)*
- `timeout` double *(optional)*

Maximum operation time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `navigationTimeout` option in the config, or by using the [browserContext.setDefaultNavigationTimeout()], [browserContext.setDefaultTimeout()], [page.setDefaultNavigationTimeout()] or [page.setDefaultTimeout()] methods.
- `waitUntil` "load" | "domcontentloaded" | "networkidle" | "commit" *(optional)*

When to consider operation succeeded, defaults to `load`. Events can be either:
* `'domcontentloaded'` - consider operation to be finished when the `DOMContentLoaded` event is fired.
* `'load'` - consider operation to be finished when the `load` event is fired.
* `'networkidle'` - **DISCOURAGED** consider operation to be finished when there are no network connections for at least `500` ms. Don't use this method for testing, rely on web assertions to assess readiness instead.
* `'commit'` - consider operation to be finished when network response is received and the document started loading.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> setContent(String html,
```

### `evalOnSelector`

*⚙️ Method*

Evaluates JavaScript on the element matching the selector.

```dart
Future<T> evalOnSelector<T>( String selector, String expression, [ Object? arg, ])
```

### `evalOnSelectorAll`

*⚙️ Method*

Evaluates JavaScript on all elements matching the selector.

```dart
Future<T> evalOnSelectorAll<T>( String selector, String expression, [ Object? arg, ])
```

### `getAttribute`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.getAttribute()] instead. Read more about [locators].

Returns element attribute value.

**Usage**

```dart
await page.getAttribute(selector, name);
await page.getAttribute(selector, name, options);
```

**Arguments**
- `selector` String

A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
- `name` String

Attribute name to get the value for.
- `options` Map *(optional)*
- `strict` bool *(optional)*

When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;[String&gt;]?

```dart
Future<String?> getAttribute(String selector, String name,
```

### `innerHTML`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.innerHTML()] instead. Read more about [locators].

Returns `element.innerHTML`.

**Usage**

```dart
await page.innerHTML(selector);
await page.innerHTML(selector, options);
```

**Arguments**
- `selector` String

A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
- `options` Map *(optional)*
- `strict` bool *(optional)*

When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;String&gt;

```dart
Future<String> innerHTML(String selector,
```

### `innerText`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.innerText()] instead. Read more about [locators].

Returns `element.innerText`.

**Usage**

```dart
await page.innerText(selector);
await page.innerText(selector, options);
```

**Arguments**
- `selector` String

A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
- `options` Map *(optional)*
- `strict` bool *(optional)*

When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;String&gt;

```dart
Future<String> innerText(String selector,
```

### `inputValue`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.inputValue()] instead. Read more about [locators].

Returns `input.value` for the selected `<input>` or `<textarea>` or `<select>` element.

Throws for non-input elements. However, if the element is inside the `<label>` element that has an associated [control], returns the value of the control.

**Usage**

```dart
await page.inputValue(selector);
await page.inputValue(selector, options);
```

**Arguments**
- `selector` String

A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
- `options` Map *(optional)*
- `strict` bool *(optional)*

When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;String&gt;

```dart
Future<String> inputValue(String selector,
```

### `isChecked`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.isChecked()] instead. Read more about [locators].

Returns whether the element is checked. Throws if the element is not a checkbox or radio input.

**Usage**

```dart
await page.isChecked(selector);
await page.isChecked(selector, options);
```

**Arguments**
- `selector` String

A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
- `options` Map *(optional)*
- `strict` bool *(optional)*

When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;bool&gt;

```dart
Future<bool> isChecked(String selector,
```

### `isDisabled`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.isDisabled()] instead. Read more about [locators].

Returns whether the element is disabled, the opposite of [enabled].

**Usage**

```dart
await page.isDisabled(selector);
await page.isDisabled(selector, options);
```

**Arguments**
- `selector` String

A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
- `options` Map *(optional)*
- `strict` bool *(optional)*

When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;bool&gt;

```dart
Future<bool> isDisabled(String selector,
```

### `isEnabled`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.isEnabled()] instead. Read more about [locators].

Returns whether the element is [enabled].

**Usage**

```dart
await page.isEnabled(selector);
await page.isEnabled(selector, options);
```

**Arguments**
- `selector` String

A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
- `options` Map *(optional)*
- `strict` bool *(optional)*

When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;bool&gt;

```dart
Future<bool> isEnabled(String selector,
```

### `isHidden`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.isHidden()] instead. Read more about [locators].

Returns whether the element is hidden, the opposite of [visible].  [selector] that does not match any elements is considered hidden.

**Usage**

```dart
await page.isHidden(selector);
await page.isHidden(selector, options);
```

**Arguments**
- `selector` String

A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
- `options` Map *(optional)*
- `strict` bool *(optional)*

When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
- `timeout` num *(optional)*

**WARNING**
[Deprecated]
This option is ignored. [page.isHidden()] does not wait for the element to become hidden and returns immediately.
**Returns**
- Future&lt;bool&gt;

```dart
Future<bool> isHidden(String selector)
```

### `isVisible`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.isVisible()] instead. Read more about [locators].

Returns whether the element is [visible]. [selector] that does not match any elements is considered not visible.

**Usage**

```dart
await page.isVisible(selector);
await page.isVisible(selector, options);
```

**Arguments**
- `selector` String

A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
- `options` Map *(optional)*
- `strict` bool *(optional)*

When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
- `timeout` num *(optional)*

**WARNING**
[Deprecated]
This option is ignored. [page.isVisible()] does not wait for the element to become visible and returns immediately.
**Returns**
- Future&lt;bool&gt;

```dart
Future<bool> isVisible(String selector)
```

### `isEditable`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.isEditable()] instead. Read more about [locators].

Returns whether the element is [editable].

**Usage**

```dart
await page.isEditable(selector);
await page.isEditable(selector, options);
```

**Arguments**
- `selector` String

A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
- `options` Map *(optional)*
- `strict` bool *(optional)*

When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;bool&gt;

```dart
Future<bool> isEditable(String selector,
```

### `addScriptTag`

*⚙️ Method*

Adds a `<script>` tag into the page with the desired url or content. Returns the added tag when the script's onload fires or when the script content was injected into frame.

**Usage**

```dart
await page.addScriptTag();
await page.addScriptTag(options);
```

**Arguments**
- `options` Map *(optional)*
- `content` String *(optional)*

Raw JavaScript content to be injected into frame.
- `path` String *(optional)*

Path to the JavaScript file to be injected into frame. If `path` is a relative path, then it is resolved relative to the current working directory.
- `type` String *(optional)*

Script type. Use 'module' in order to load a JavaScript ES6 module. See [script] for more details.
- `url` String *(optional)*

URL of a script to be added.

**Returns**
- Future&lt;[ElementHandle]&gt;

```dart
Future<void> addScriptTag(
```

### `addStyleTag`

*⚙️ Method*

Adds a `<link rel="stylesheet">` tag into the page with the desired url or a `<style type="text/css">` tag with the content. Returns the added tag when the stylesheet's onload fires or when the CSS content was injected into frame.

**Usage**

```dart
await page.addStyleTag();
await page.addStyleTag(options);
```

**Arguments**
- `options` Map *(optional)*
- `content` String *(optional)*

Raw CSS content to be injected into frame.
- `path` String *(optional)*

Path to the CSS file to be injected into frame. If `path` is a relative path, then it is resolved relative to the current working directory.
- `url` String *(optional)*

URL of the `<link>` tag.

**Returns**
- Future&lt;[ElementHandle]&gt;

```dart
Future<void> addStyleTag(
```

### `waitForTimeout`

*⚙️ Method*

**WARNING**
[Discouraged]

Never wait for timeout in production. Tests that wait for time are inherently flaky. Use [Locator] actions and web assertions that wait automatically.

Waits for the given [timeout] in milliseconds.

Note that `page.waitForTimeout()` should only be used for debugging. Tests using the timer in production are going to be flaky. Use signals such as network events, selectors becoming visible and others instead.

**Usage**

```dart
// wait for 1 second
await page.waitForTimeout(1000);
```

**Arguments**
- `timeout` double

A timeout to wait for

**Returns**
- Future&lt;void&gt;


[APIRequest]: /api/class-apirequest.mdx "APIRequest"
[APIRequestContext]: /api/class-apirequestcontext.mdx "APIRequestContext"
[APIResponse]: /api/class-apiresponse.mdx "APIResponse"
[APIResponseAssertions]: /api/class-apiresponseassertions.mdx "APIResponseAssertions"
[Browser]: /api/class-browser.mdx "Browser"
[BrowserContext]: /api/class-browsercontext.mdx "BrowserContext"
[BrowserServer]: /api/class-browserserver.mdx "BrowserServer"
[BrowserType]: /api/class-browsertype.mdx "BrowserType"
[CDPSession]: /api/class-cdpsession.mdx "CDPSession"
[Clock]: /api/class-clock.mdx "Clock"
[ConsoleMessage]: /api/class-consolemessage.mdx "ConsoleMessage"
[Coverage]: /api/class-coverage.mdx "Coverage"
[Credentials]: /api/class-credentials.mdx "Credentials"
[Debugger]: /api/class-debugger.mdx "Debugger"
[Dialog]: /api/class-dialog.mdx "Dialog"
[Disposable]: /api/class-disposable.mdx "Disposable"
[Download]: /api/class-download.mdx "Download"
[ElementHandle]: /api/class-elementhandle.mdx "ElementHandle"
[FileChooser]: /api/class-filechooser.mdx "FileChooser"
[Frame]: /api/class-frame.mdx "Frame"
[FrameLocator]: /api/class-framelocator.mdx "FrameLocator"
[GenericAssertions]: /api/class-genericassertions.mdx "GenericAssertions"
[JSHandle]: /api/class-jshandle.mdx "JSHandle"
[Keyboard]: /api/class-keyboard.mdx "Keyboard"
[Locator]: /api/class-locator.mdx "Locator"
[LocatorAssertions]: /api/class-locatorassertions.mdx "LocatorAssertions"
[Logger]: /api/class-logger.mdx "Logger"
[Mouse]: /api/class-mouse.mdx "Mouse"
[Page]: /api/class-page.mdx "Page"
[PageAssertions]: /api/class-pageassertions.mdx "PageAssertions"
[Playwright]: /api/class-playwright.mdx "Playwright"
[PlaywrightAssertions]: /api/class-playwrightassertions.mdx "PlaywrightAssertions"
[Request]: /api/class-request.mdx "Request"
[Response]: /api/class-response.mdx "Response"
[Route]: /api/class-route.mdx "Route"
[Screencast]: /api/class-screencast.mdx "Screencast"
[Selectors]: /api/class-selectors.mdx "Selectors"
[SnapshotAssertions]: /api/class-snapshotassertions.mdx "SnapshotAssertions"
[TimeoutError]: /api/class-timeouterror.mdx "TimeoutError"
[Touchscreen]: /api/class-touchscreen.mdx "Touchscreen"
[Tracing]: /api/class-tracing.mdx "Tracing"
[Video]: /api/class-video.mdx "Video"
[WebError]: /api/class-weberror.mdx "WebError"
[WebSocket]: /api/class-websocket.mdx "WebSocket"
[WebSocketRoute]: /api/class-websocketroute.mdx "WebSocketRoute"
[WebStorage]: /api/class-webstorage.mdx "WebStorage"
[Worker]: /api/class-worker.mdx "Worker"
[Electron]: /api/class-electron.mdx "Electron"
[ElectronApplication]: /api/class-electronapplication.mdx "ElectronApplication"
[Android]: /api/class-android.mdx "Android"
[AndroidDevice]: /api/class-androiddevice.mdx "AndroidDevice"
[AndroidInput]: /api/class-androidinput.mdx "AndroidInput"
[AndroidSocket]: /api/class-androidsocket.mdx "AndroidSocket"
[AndroidWebView]: /api/class-androidwebview.mdx "AndroidWebView"
[Fixtures]: /api/class-fixtures.mdx "Fixtures"
[FullConfig]: /api/class-fullconfig.mdx "FullConfig"
[FullProject]: /api/class-fullproject.mdx "FullProject"
[Location]: /api/class-location.mdx "Location"
[Test]: /api/class-test.mdx "Test"
[TestConfig]: /api/class-testconfig.mdx "TestConfig"
[TestInfo]: /api/class-testinfo.mdx "TestInfo"
[TestInfoError]: /api/class-testinfoerror.mdx "TestInfoError"
[TestOptions]: /api/class-testoptions.mdx "TestOptions"
[TestProject]: /api/class-testproject.mdx "TestProject"
[TestStepInfo]: /api/class-teststepinfo.mdx "TestStepInfo"
[WorkerInfo]: /api/class-workerinfo.mdx "WorkerInfo"
[Reporter]: /api/class-reporter.mdx "Reporter"
[Suite]: /api/class-suite.mdx "Suite"
[TestCase]: /api/class-testcase.mdx "TestCase"
[TestError]: /api/class-testerror.mdx "TestError"
[TestResult]: /api/class-testresult.mdx "TestResult"
[TestStep]: /api/class-teststep.mdx "TestStep"
[EvaluationArgument]: /evaluating.mdx#evaluation-argument "EvaluationArgument"
[UIEvent.detail]: https://developer.mozilla.org/en-US/docs/Web/API/UIEvent/detail "UIEvent.detail"


[all available image tags]: https://mcr.microsoft.com/en-us/product/playwright/about "all available image tags"
[Microsoft Artifact Registry]: https://mcr.microsoft.com/en-us/product/playwright/about "Microsoft Artifact Registry"
[Dockerfile.noble]: https://github.com/microsoft/playwright/blob/main/utils/docker/Dockerfile.noble "Dockerfile.noble"

```dart
Future<void> waitForTimeout(double timeout)
```

### `waitForFunction`

*⚙️ Method*

Returns when the [pageFunction] returns a truthy value. It resolves to a JSHandle of the truthy value.

**Usage**

The [page.waitForFunction()] can be used to observe viewport size change:

```dart
// Or 'chromium' or 'firefox'.

(() async {
final browser = await webkit.launch();
final page = await browser.newPage();
final watchDog = page.waitForFunction(() => window.innerWidth < 100);
await page.setViewportSize( width: 50, height: 50 );
await watchDog;
await browser.close();
}
```

To pass an argument to the predicate of [page.waitForFunction()] function:

```dart
final selector = '.foo';
await page.waitForFunction((selector) => !!document.querySelector(selector), selector);
```

**Arguments**
- `pageFunction` Function | String

Function to be evaluated in the page context.
- `arg` dynamic *(optional)*

Optional argument to pass to [pageFunction].
- `options` Map *(optional)*
- `polling` num | "raf" *(optional)*

If [polling] is `'raf'`, then [pageFunction] is constantly executed in `requestAnimationFrame` callback. If [polling] is a number, then it is treated as an interval in milliseconds at which the function would be executed. Defaults to `raf`.
- `timeout` double *(optional)*

Maximum time to wait for in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;[JSHandle]&gt;

```dart
Future<JSHandle> waitForFunction( String expression, [ Object? arg, double? timeout, double? pollingInterval, ])
```

### `dispatchEvent`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.dispatchEvent()] instead. Read more about [locators].

The snippet below dispatches the `click` event on the element. Regardless of the visibility state of the element, `click` is dispatched. This is equivalent to calling [element.click()].

**Usage**

```dart
await page.dispatchEvent('button#submit', 'click');
```

Under the hood, it creates an instance of an event based on the given [type], initializes it with [eventInit] properties and dispatches it on the element. Events are `composed`, `cancelable` and bubble by default.

Since [eventInit] is event-specific, please refer to the events documentation for the lists of initial properties:
* [DeviceMotionEvent]
* [DeviceOrientationEvent]
* [DragEvent]
* [Event]
* [FocusEvent]
* [KeyboardEvent]
* [MouseEvent]
* [PointerEvent]
* [TouchEvent]
* [WheelEvent]

You can also specify `JSHandle` as the property value if you want live objects to be passed into the event:

```dart
// Note you can only create DataTransfer in Chromium and Firefox
final dataTransfer = await page.evaluateHandle(() => new DataTransfer());
await page.dispatchEvent('#source', 'dragstart', { dataTransfer );
```

**Arguments**
- `selector` String

A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
- `type` String

DOM event type: `"click"`, `"dragstart"`, etc.
- `eventInit` dynamic *(optional)*

Optional event-specific initialization properties.
- `options` Map *(optional)*
- `strict` bool *(optional)*

When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> dispatchEvent( String selector, String type,
```

### `highlight`

*⚙️ Method*

Highlights the element matching the selector.

```dart
Future<void> highlight(String selector)
```

### `hideHighlight`

*⚙️ Method*

Hide all locator highlight overlays previously added by [locator.highlight()] on this page.

**Usage**

```dart
await page.hideHighlight();
```

**Returns**
- Future&lt;void&gt;

```dart
Future<void> hideHighlight()
```

### `drop`

*⚙️ Method*

Drops files on the element matching the selector.

```dart
Future<void> drop( String selector,
```

### `querySelector`

*⚙️ Method*

Queries for the first element matching the selector.

```dart
Locator querySelector(String selector)
```

### `querySelectorAll`

*⚙️ Method*

Queries for all elements matching the selector.

```dart
Future<List<Locator>> querySelectorAll(String selector)
```

### `queryCount`

*⚙️ Method*

Returns the count of elements matching the selector.

```dart
Future<int> queryCount(String selector)
```

### `selectOption`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.selectOption()] instead. Read more about [locators].

This method waits for an element matching [selector], waits for [actionability] checks, waits until all specified options are present in the `<select>` element and selects these options.

If the target element is not a `<select>` element, this method throws an error. However, if the element is inside the `<label>` element that has an associated [control], the control will be used instead.

Returns the array of option values that have been successfully selected.

Triggers a `change` and `input` event once all the provided options have been selected.

**Usage**

```dart
// Single selection matching the value or label
page.selectOption('select#colors', 'blue');

// single selection matching the label
page.selectOption('select#colors', { label: 'Blue' );

// multiple selection
page.selectOption('select#colors', ['red', 'green', 'blue']);

```

**Arguments**
- `selector` String

A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
- `values` dynamic
- `value` String *(optional)*

Matches by `option.value`. Optional.
- `label` String *(optional)*

Matches by `option.label`. Optional.
- `index` num *(optional)*

Matches by the index. Optional.

Options to select. If the `<select>` has the `multiple` attribute, all matching options are selected, otherwise only the first option matching one of the passed options is selected. String values are matching both values and labels. Option is considered matching if all specified properties match.
- `options` Map *(optional)*
- `force` bool *(optional)*

Whether to bypass the [actionability] checks. Defaults to `false`.
- `noWaitAfter` bool *(optional)*

**WARNING**
[Deprecated]
This option has no effect.
This option has no effect.
- `strict` bool *(optional)*

When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;List&lt;String&gt;&gt;

```dart
Future<List<String>> selectOption( String selector, List<SelectOption>? values,
```

### `setInputFiles`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.setInputFiles()] instead. Read more about [locators].

Sets the value of the file input to these file paths or files. If some of the `filePaths` are relative paths, then they are resolved relative to the current working directory. For empty array, clears the selected files. For inputs with a `[webkitdirectory]` attribute, only a single directory path is supported.

This method expects [selector] to point to an [input element]. However, if the element is inside the `<label>` element that has an associated [control], targets the control instead.

**Usage**

```dart
await page.setInputFiles(selector, files);
await page.setInputFiles(selector, files, options);
```

**Arguments**
- `selector` String

A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
- `files` dynamic
- `name` String

File name
- `mimeType` String

File type
- `buffer` List&lt;int&gt;

File content
- `options` Map *(optional)*
- `noWaitAfter` bool *(optional)*

**WARNING**
[Deprecated]
This option has no effect.
This option has no effect.
- `strict` bool *(optional)*

When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> setInputFiles( String selector, List<InputFile>? files,
```

### `ariaSnapshot`

*⚙️ Method*

Captures the aria snapshot of the page. Read more about [aria snapshots].

**Usage**

```dart
await page.ariaSnapshot();
await page.ariaSnapshot(options);
```

**Arguments**
- `options` Map *(optional)*
- `boxes` bool *(optional)*

When `true`, appends each element's bounding box as `[box=x,y,width,height]` to the snapshot. Coordinates are relative to the viewport, in CSS pixels, as returned by [`Element.getBoundingClientRect()`]. Defaults to `false`.
- `depth` int *(optional)*

When specified, limits the depth of the snapshot.
- `mode` String *(optional)*

When set to `"ai"`, returns a snapshot optimized for AI consumption: including element references like `[ref=e2]` and snapshots of `<iframe>`s. Defaults to `"default"`.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;String&gt;

```dart
Future<FrameAriaSnapshotResult> ariaSnapshot( String selector,
```

### `expect`

*⚙️ Method*

Performs an assertion on the element matching the selector.

```dart
Future<ExpectResult> expect( String selector, String expression,
```

### `exposeBinding`

*⚙️ Method*

The method adds a function called [name] on the `window` object of every frame in this page. When called, the function executes [callback] and returns a Future which resolves to the return value of [callback]. If the [callback] returns a Future, it will be awaited.

The first argument of the [callback] function contains information about the caller: `{ browserContext: BrowserContext, page: Page, frame: Frame }`.

See [browserContext.exposeBinding()] for the context-wide version.

**NOTE**
Functions installed via [page.exposeBinding()] survive navigations.
**Usage**

An example of exposing page URL to all frames in a page:

```dart
// Or 'chromium' or 'firefox'.

(() async {
final browser = await webkit.launch( headless: false );
final context = await browser.newContext();
final page = await context.newPage();
await page.exposeBinding('pageURL', ( page ) => page.url());
await page.setContent(`
<script>
async function onClick() {
document.querySelector('div').textContent = await window.pageURL();
}
</script>
<button onclick="onClick()">Click me</button>
<div></div>
`);
await page.click('button');
}
```

**Arguments**
- `name` String

Name of the function on the window object.
- `callback` Function

Callback function that will be called in the Playwright's context.

**Returns**
- Future&lt;[Disposable]&gt;

```dart
Future<void> exposeBinding(String name)
```

### `exposeFunction`

*⚙️ Method*

The method adds a function called [name] on the `window` object of every frame in the page. When called, the function executes [callback] and returns a Future which resolves to the return value of [callback].

If the [callback] returns a Future, it will be awaited.

See [browserContext.exposeFunction()] for context-wide exposed function.

**NOTE**
Functions installed via [page.exposeFunction()] survive navigations.
**Usage**

An example of adding a `sha256` function to the page:

```dart
// Or 'chromium' or 'firefox'.

(() async {
final browser = await webkit.launch( headless: false );
final page = await browser.newPage();
await page.exposeFunction('sha256', (text) =>
crypto.createHash('sha256').update(text).digest('hex'),
);
await page.setContent(`
<script>
async function onClick() {
document.querySelector('div').textContent = await window.sha256('PLAYWRIGHT');
}
</script>
<button onclick="onClick()">Click me</button>
<div></div>
`);
await page.click('button');
}
```

**Arguments**
- `name` String

Name of the function on the window object
- `callback` Function

Callback function which will be called in Playwright's context.

**Returns**
- Future&lt;[Disposable]&gt;

```dart
Future<void> exposeFunction(String name)
```

### `opener`

*⚙️ Method*

Returns the opener for popup pages and `null` for others. If the opener has been closed already the returns `null`.

**Usage**

```dart
await page.opener();
```

**Returns**
- Future&lt;[Page]?&gt;

```dart
Page? opener()
```

### `requestGC`

*⚙️ Method*

Request the page to perform garbage collection. Note that there is no guarantee that all unreachable objects will be collected.

This is useful to help detect memory leaks. For example, if your page has a large object `'suspect'` that might be leaked, you can check that it does not leak by using a [`WeakRef`].

```dart
// 1. In your page, save a WeakRef for the "suspect".
await page.evaluate(() => globalThis.suspectWeakRef = new WeakRef(suspect));
// 2. Request garbage collection.
await page.requestGC();
// 3. Check that weak ref does not deref to the original object.
expect(await page.evaluate(() => !globalThis.suspectWeakRef.deref())).toBe(true);
```

**Usage**

```dart
await page.requestGC();
```

**Returns**
- Future&lt;void&gt;

```dart
Future<void> requestGC()
```

### `registerLocatorHandler`

*⚙️ Method*

Registers a locator handler.

```dart
Future<PageRegisterLocatorHandlerResult> registerLocatorHandler( Locator selector,
```

### `unregisterLocatorHandler`

*⚙️ Method*

Unregisters a locator handler.

```dart
Future<void> unregisterLocatorHandler(int uid)
```

### `addLocatorHandler`

*⚙️ Method*

When testing a web page, sometimes unexpected overlays like a "Sign up" dialog appear and block actions you want to automate, e.g. clicking a button. These overlays don't always show up in the same way or at the same time, making them tricky to handle in automated tests.

This method lets you set up a special function, called a handler, that activates when it detects that overlay is visible. The handler's job is to remove the overlay, allowing your test to continue as if the overlay wasn't there.

Things to keep in mind:
* When an overlay is shown predictably, we recommend explicitly waiting for it in your test and dismissing it as a part of your normal test flow, instead of using [page.addLocatorHandler()].
* Playwright checks for the overlay every time before executing or retrying an action that requires an [actionability check], or before performing an auto-waiting assertion check. When overlay is visible, Playwright calls the handler first, and then proceeds with the action/assertion. Note that the handler is only called when you perform an action/assertion - if the overlay becomes visible but you don't perform any actions, the handler will not be triggered.
* After executing the handler, Playwright will ensure that overlay that triggered the handler is not visible anymore. You can opt-out of this behavior with [noWaitAfter].
* The execution time of the handler counts towards the timeout of the action/assertion that executed the handler. If your handler takes too long, it might cause timeouts.
* You can register multiple handlers. However, only a single handler will be running at a time. Make sure the actions within a handler don't depend on another handler.

**WARNING**
Running the handler will alter your page state mid-test. For example it will change the currently focused element and move the mouse. Make sure that actions that run after the handler are self-contained and do not rely on the focus and mouse state being unchanged.

For example, consider a test that calls [locator.focus()] followed by [keyboard.press()]. If your handler clicks a button between these two actions, the focused element most likely will be wrong, and key press will happen on the unexpected element. Use [locator.press()] instead to avoid this problem.

Another example is a series of mouse actions, where [mouse.move()] is followed by [mouse.down()]. Again, when the handler runs between these two actions, the mouse position will be wrong during the mouse down. Prefer self-contained actions like [locator.click()] that do not rely on the state being unchanged by a handler.
**Usage**

An example that closes a "Sign up to the newsletter" dialog when it appears:

```dart
// Setup the handler.
await page.addLocatorHandler(page.getByText('Sign up to the newsletter'), () async {
await page.getByRole('button', { name: 'No thanks' ).click();
);

// Write the test as usual.
await page.goto('https://example.com');
await page.getByRole('button', { name: 'Start here' ).click();
```

An example that skips the "Confirm your security details" page when it is shown:

```dart
// Setup the handler.
await page.addLocatorHandler(page.getByText('Confirm your security details'), () async {
await page.getByRole('button', { name: 'Remind me later' ).click();
);

// Write the test as usual.
await page.goto('https://example.com');
await page.getByRole('button', { name: 'Start here' ).click();
```

An example with a custom callback on every actionability check. It uses a `<body>` locator that is always visible, so the handler is called before every actionability check. It is important to specify [noWaitAfter], because the handler does not hide the `<body>` element.

```dart
// Setup the handler.
await page.addLocatorHandler(page.locator('body'), () async {
await page.evaluate(() => window.removeObstructionsForTestIfNeeded());
}, { noWaitAfter: true );

// Write the test as usual.
await page.goto('https://example.com');
await page.getByRole('button', { name: 'Start here' ).click();
```

Handler takes the original locator as an argument. You can also automatically remove the handler after a number of invocations by setting [times]:

```dart
await page.addLocatorHandler(page.getByLabel('Close'), (locator) async {
await locator.click();
}, { times: 1 );
```

**Arguments**
- `locator` Locator

Locator that triggers the handler.
- `handler` Future&lt;void&gt; Function(Locator)

Function that should be run once [locator] appears. This function should get rid of the element that blocks actions like click.
- `options` Map *(optional)*
- `noWaitAfter` bool *(optional)*

By default, after calling the handler Playwright will wait until the overlay becomes hidden, and only then Playwright will continue with the action/assertion that triggered the handler. This option allows to opt-out of this behavior, so that overlay can stay visible after the handler has run.
- `times` int *(optional)*

Specifies the maximum number of times this handler should be called. Unlimited by default.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> addLocatorHandler( Locator locator, Future<void> Function(Locator) handler,
```

### `removeLocatorHandler`

*⚙️ Method*

Removes all locator handlers added by [page.addLocatorHandler()] for a specific locator.

**Usage**

```dart
await page.removeLocatorHandler(locator);
```

**Arguments**
- `locator` Locator

Locator passed to [page.addLocatorHandler()].

**Returns**
- Future&lt;void&gt;

```dart
Future<void> removeLocatorHandler(Locator locator)
```

### `setExtraHTTPHeaders`

*⚙️ Method*

The extra HTTP headers will be sent with every request the page initiates.

**NOTE**
[page.setExtraHTTPHeaders()] does not guarantee the order of headers in the outgoing requests.
**Usage**

```dart
await page.setExtraHTTPHeaders(headers);
```

**Arguments**
- `headers` List&lt;NameValue&gt;

An object containing additional HTTP headers to be sent with every request. All header values must be strings.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> setExtraHTTPHeaders(List<NameValue> headers)
```

### `setNetworkInterceptionPatterns`

*⚙️ Method*

Sets network interception patterns for the page.

```dart
Future<void> setNetworkInterceptionPatterns( List<PageSetNetworkInterceptionPatternsItems> patterns, )
```

### `routeWebSocket`

*⚙️ Method*

This method allows to modify websocket connections that are made by the page.

Note that only `WebSocket`s created after this method was called will be routed. It is recommended to call this method before navigating the page.

**Usage**

Below is an example of a simple mock that responds to a single message. See [WebSocketRoute] for more details and examples.

```dart
await page.routeWebSocket('/ws', (ws) {
ws.onMessage((message) {
if (message == 'request')
ws.send('response');
);
);
```

**Arguments**
- `url` Pattern

Only WebSockets with the url matching this pattern will be routed. A string pattern can be relative to the [baseURL] context option.
- `handler` Future&lt;void&gt; Function(WebSocketRoute)

Handler function to route the WebSocket.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> routeWebSocket( Pattern url, Future<void> Function(WebSocketRoute) handler, )
```

### `touchscreenTap`

*⚙️ Method*

Taps the touchscreen at the given coordinates.

```dart
Future<void> touchscreenTap(double x, double y)
```

### `bringToFront`

*⚙️ Method*

Brings page to front (activates tab).

**Usage**

```dart
await page.bringToFront();
```

**Returns**
- Future&lt;void&gt;

```dart
Future<void> bringToFront()
```

### `pickLocator`

*⚙️ Method*

Enters pick locator mode where hovering over page elements highlights them and shows the corresponding locator. Once the user clicks an element, the mode is deactivated and the [Locator] for the picked element is returned.

**Usage**

```dart
final locator = await page.pickLocator();
print(locator);
```

**Returns**
- Future&lt;[Locator]&gt;

```dart
Future<PagePickLocatorResult> pickLocator()
```

### `cancelPickLocator`

*⚙️ Method*

Cancels an ongoing [page.pickLocator()] call by deactivating pick locator mode. If no pick locator mode is active, this method is a no-op.

**Usage**

```dart
await page.cancelPickLocator();
```

**Returns**
- Future&lt;void&gt;

```dart
Future<void> cancelPickLocator()
```

### `screencastStart`

*⚙️ Method*

Starts screencasting the page.

```dart
Future<void> screencastStart(
```

### `screencastStop`

*⚙️ Method*

Stops screencasting the page.

```dart
Future<void> screencastStop()
```

### `setDockTile`

*⚙️ Method*

Sets the dock tile image.

```dart
Future<void> setDockTile(String image)
```

### `clearConsoleMessages`

*⚙️ Method*

Clears all stored console messages from this page. Subsequent calls to [page.consoleMessages()] will only return messages logged after the clear.

**Usage**

```dart
await page.clearConsoleMessages();
```

**Returns**
- Future&lt;void&gt;

```dart
Future<void> clearConsoleMessages()
```

### `consoleMessages`

*⚙️ Method*

Returns up to (currently) 200 last console messages from this page. See [page.on('console')] for more details.

**Usage**

```dart
await page.consoleMessages();
await page.consoleMessages(options);
```

**Arguments**
- `options` Map *(optional)*
- `filter` ConsoleMessagesFilter *(optional)*

Controls which messages are returned:

**Returns**
- Future&lt;List&lt;[ConsoleMessage]&gt;&gt;

```dart
Future<PageConsoleMessagesResult> consoleMessages(
```

### `clearPageErrors`

*⚙️ Method*

Clears all stored page errors from this page. Subsequent calls to [page.pageErrors()] will only return errors thrown after the clear.

**Usage**

```dart
await page.clearPageErrors();
```

**Returns**
- Future&lt;void&gt;

```dart
Future<void> clearPageErrors()
```

### `pageErrors`

*⚙️ Method*

Returns up to (currently) 200 last page errors from this page. See [page.on('pageerror')] for more details.

**Usage**

```dart
await page.pageErrors();
await page.pageErrors(options);
```

**Arguments**
- `options` Map *(optional)*
- `filter` ConsoleMessagesFilter *(optional)*

Controls which errors are returned:

**Returns**
- Future&lt;List&lt;[Error]&gt;&gt;

```dart
Future<PagePageErrorsResult> pageErrors(
```

### `requests`

*⚙️ Method*

Returns up to (currently) 100 last network request from this page. See [page.on('request')] for more details.

Returned requests should be accessed immediately, otherwise they might be collected to prevent unbounded memory growth as new requests come in. Once collected, retrieving most information about the request is impossible.

Note that requests reported through the [page.on('request')] request are not collected, so there is a trade off between efficient memory usage with [page.requests()] and the amount of available information reported through [page.on('request')].

**Usage**

```dart
await page.requests();
```

**Returns**
- Future&lt;List&lt;[Request]&gt;&gt;

```dart
Future<PageRequestsResult> requests()
```

## `PdfDimension`

```dart
class PdfDimension
```

## `Playwright`

```dart
abstract interface class Playwright
```

### `chromium`

*📦 Property*

Provides access to the Chromium browser type.

```dart
BrowserType get chromium
```

### `firefox`

*📦 Property*

Provides access to the Firefox browser type.

```dart
BrowserType get firefox
```

### `webkit`

*📦 Property*

Provides access to the WebKit browser type.

```dart
BrowserType get webkit
```

### `android`

*📦 Property*

Android automation API.

```dart
Android get android
```

### `electron`

*📦 Property*

Electron automation API.

```dart
Electron get electron
```

### `devices`

*📦 Property*

Predefined device descriptors.

```dart
Map<String, Map<String, dynamic>> get devices
```

### `selectors`

*📦 Property*

Custom selectors API.

```dart
Selectors get selectors
```

### `newRequest`

*⚙️ Method*

Creates a new API request context.

```dart
Future<APIRequestContext> newRequest(
```

### `stop`

*⚙️ Method*

Stops the Playwright driver and closes the connection.

```dart
Future<void> stop()
```

## `PlaywrightDart`

```dart
class PlaywrightDart
```

### `create`

*⚙️ Method*

Launches the background Playwright driver and connects to it, returning the
root [Playwright] API instance.

[autoClose] — when `true` (default), the driver process shuts down
automatically when the last browser is closed.

[logLevel] — controls how verbose the logger is. Defaults to
[LogLevel.info] which prints startup/shutdown milestones. Use
[LogLevel.debug] to see navigation and action calls, [LogLevel.trace]
for raw protocol messages, or [LogLevel.none] to silence everything.

```dart
static Future<Playwright> create(
```

## `RouteMatcher`

A matcher for a route URL or a network event predicate.

```dart
abstract class RouteMatcher
```

### `function`

*⚙️ Method*

Matches any network event (e.g. Request, Response, Uri) that satisfies the [predicate].

You can use the generic type parameter `<T>` to get type safety and
auto-filtering based on the network event type.

```dart
final request = await page.waitForRequest(
RouteMatcher.function<Request>((req) => req.url.contains('/api') && req.method == 'POST')
);
```

```dart
static RouteMatcher function<T>(bool Function(T) predicate)
```

## `StringRouteMatcher`

```dart
class StringRouteMatcher extends RouteMatcher
```

## `RegExpRouteMatcher`

```dart
class RegExpRouteMatcher extends RouteMatcher
```

## `FunctionRouteMatcher`

```dart
class FunctionRouteMatcher<T> extends RouteMatcher
```

## `Selectors`

Selectors can be used to install custom selector engines.

```dart
class Selectors
```

### `register`

*⚙️ Method*

Selectors must be registered before creating the page.

**Usage**

An example of registering selector engine that queries elements based on a tag name:

```dart
final { selectors, firefox } = require('@playwright/test');  // Or 'chromium' or 'webkit'.

(() async {
// Must be a function that evaluates to a selector engine instance.
final createTagNameEngine = () => (
// Returns the first element matching given selector in the root's subtree.
query(root, selector) {
return root.querySelector(selector);
},

// Returns all elements matching given selector in the root's subtree.
queryAll(root, selector) {
return Array.from(root.querySelectorAll(selector));
}
);

// Register the engine. Selectors will be prefixed with "tag=".
await selectors.register('tag', createTagNameEngine);

final browser = await firefox.launch();
final page = await browser.newPage();
await page.setContent(`<div><button>Click me</button></div>`);

// Use the selector prefixed with its name.
final button = page.locator('tag=button');
// We can combine it with built-in locators.
await page.locator('tag=div').getByText('Click me').click();
// Can use it in any methods supporting selectors.
final buttonCount = await page.locator('tag=button').count();

await browser.close();
}
```

**Arguments**
- `name` String

Name that is used in selectors as a prefix, e.g. `{name: 'foo'}` enables `foo=myselectorbody` selectors. May only contain `[a-zA-Z0-9_]` characters.
- `script` String
- `path` String *(optional)*

Path to the JavaScript file. If `path` is a relative path, then it is resolved relative to the current working directory. Optional.
- `content` String *(optional)*

Raw script content. Optional.

Script that evaluates to a selector engine instance. The script is evaluated in the page context.
- `options` Map *(optional)*
- `contentScript` bool *(optional)*

Whether to run this selector engine in isolated JavaScript environment. This environment has access to the same DOM, but not any JavaScript objects from the frame's scripts. Defaults to `false`. Note that running as a content script is not guaranteed when this engine is used together with other registered engines.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> register( String name, String script,
```

### `setTestIdAttribute`

*⚙️ Method*

Defines custom attribute name to be used in [page.getByTestId()]. `data-testid` is used by default.

**Usage**

```dart
selectors.setTestIdAttribute(attributeName);
```

**Arguments**
- `attributeName` String

Test id attribute name. To match elements with any of several attributes, pass them as a comma-separated list, e.g. `"data-pw,data-ti"`.


[APIRequest]: /api/class-apirequest.mdx "APIRequest"
[APIRequestContext]: /api/class-apirequestcontext.mdx "APIRequestContext"
[APIResponse]: /api/class-apiresponse.mdx "APIResponse"
[APIResponseAssertions]: /api/class-apiresponseassertions.mdx "APIResponseAssertions"
[Browser]: /api/class-browser.mdx "Browser"
[BrowserContext]: /api/class-browsercontext.mdx "BrowserContext"
[BrowserServer]: /api/class-browserserver.mdx "BrowserServer"
[BrowserType]: /api/class-browsertype.mdx "BrowserType"
[CDPSession]: /api/class-cdpsession.mdx "CDPSession"
[Clock]: /api/class-clock.mdx "Clock"
[ConsoleMessage]: /api/class-consolemessage.mdx "ConsoleMessage"
[Coverage]: /api/class-coverage.mdx "Coverage"
[Credentials]: /api/class-credentials.mdx "Credentials"
[Debugger]: /api/class-debugger.mdx "Debugger"
[Dialog]: /api/class-dialog.mdx "Dialog"
[Disposable]: /api/class-disposable.mdx "Disposable"
[Download]: /api/class-download.mdx "Download"
[ElementHandle]: /api/class-elementhandle.mdx "ElementHandle"
[FileChooser]: /api/class-filechooser.mdx "FileChooser"
[Frame]: /api/class-frame.mdx "Frame"
[FrameLocator]: /api/class-framelocator.mdx "FrameLocator"
[GenericAssertions]: /api/class-genericassertions.mdx "GenericAssertions"
[JSHandle]: /api/class-jshandle.mdx "JSHandle"
[Keyboard]: /api/class-keyboard.mdx "Keyboard"
[Locator]: /api/class-locator.mdx "Locator"
[LocatorAssertions]: /api/class-locatorassertions.mdx "LocatorAssertions"
[Logger]: /api/class-logger.mdx "Logger"
[Mouse]: /api/class-mouse.mdx "Mouse"
[Page]: /api/class-page.mdx "Page"
[PageAssertions]: /api/class-pageassertions.mdx "PageAssertions"
[Playwright]: /api/class-playwright.mdx "Playwright"
[PlaywrightAssertions]: /api/class-playwrightassertions.mdx "PlaywrightAssertions"
[Request]: /api/class-request.mdx "Request"
[Response]: /api/class-response.mdx "Response"
[Route]: /api/class-route.mdx "Route"
[Screencast]: /api/class-screencast.mdx "Screencast"
[Selectors]: /api/class-selectors.mdx "Selectors"
[SnapshotAssertions]: /api/class-snapshotassertions.mdx "SnapshotAssertions"
[TimeoutError]: /api/class-timeouterror.mdx "TimeoutError"
[Touchscreen]: /api/class-touchscreen.mdx "Touchscreen"
[Tracing]: /api/class-tracing.mdx "Tracing"
[Video]: /api/class-video.mdx "Video"
[WebError]: /api/class-weberror.mdx "WebError"
[WebSocket]: /api/class-websocket.mdx "WebSocket"
[WebSocketRoute]: /api/class-websocketroute.mdx "WebSocketRoute"
[WebStorage]: /api/class-webstorage.mdx "WebStorage"
[Worker]: /api/class-worker.mdx "Worker"
[Electron]: /api/class-electron.mdx "Electron"
[ElectronApplication]: /api/class-electronapplication.mdx "ElectronApplication"
[Android]: /api/class-android.mdx "Android"
[AndroidDevice]: /api/class-androiddevice.mdx "AndroidDevice"
[AndroidInput]: /api/class-androidinput.mdx "AndroidInput"
[AndroidSocket]: /api/class-androidsocket.mdx "AndroidSocket"
[AndroidWebView]: /api/class-androidwebview.mdx "AndroidWebView"
[Fixtures]: /api/class-fixtures.mdx "Fixtures"
[FullConfig]: /api/class-fullconfig.mdx "FullConfig"
[FullProject]: /api/class-fullproject.mdx "FullProject"
[Location]: /api/class-location.mdx "Location"
[Test]: /api/class-test.mdx "Test"
[TestConfig]: /api/class-testconfig.mdx "TestConfig"
[TestInfo]: /api/class-testinfo.mdx "TestInfo"
[TestInfoError]: /api/class-testinfoerror.mdx "TestInfoError"
[TestOptions]: /api/class-testoptions.mdx "TestOptions"
[TestProject]: /api/class-testproject.mdx "TestProject"
[TestStepInfo]: /api/class-teststepinfo.mdx "TestStepInfo"
[WorkerInfo]: /api/class-workerinfo.mdx "WorkerInfo"
[Reporter]: /api/class-reporter.mdx "Reporter"
[Suite]: /api/class-suite.mdx "Suite"
[TestCase]: /api/class-testcase.mdx "TestCase"
[TestError]: /api/class-testerror.mdx "TestError"
[TestResult]: /api/class-testresult.mdx "TestResult"
[TestStep]: /api/class-teststep.mdx "TestStep"
[EvaluationArgument]: /evaluating.mdx#evaluation-argument "EvaluationArgument"
[UIEvent.detail]: https://developer.mozilla.org/en-US/docs/Web/API/UIEvent/detail "UIEvent.detail"


[all available image tags]: https://mcr.microsoft.com/en-us/product/playwright/about "all available image tags"
[Microsoft Artifact Registry]: https://mcr.microsoft.com/en-us/product/playwright/about "Microsoft Artifact Registry"
[Dockerfile.noble]: https://github.com/microsoft/playwright/blob/main/utils/docker/Dockerfile.noble "Dockerfile.noble"

```dart
Future<void> setTestIdAttribute(String name) async
```

### `addContext`

*⚙️ Method*

Internal method called by [Browser.newContext] when a new [BrowserContext]
is created.

Applies any pending testId attribute name and registered selector engines
to the freshly-created context **before** it is returned to the caller,
so that every operation on the new context already uses the correct
configuration.

```dart
Future<void> addContext(BrowserContext context) async
```

---

# Interaction

## `APIResponseAssertions`

Web-first assertions for an [APIResponse].

Obtain via [APIResponseAssertions]:
```dart
final response = await apiRequestContext.get('https://example.com/api');
final assertions = APIResponseAssertions(response);
await assertions.toBeOK();
```

```dart
class APIResponseAssertions
```

### `not`

*📦 Property*

Makes the assertion check for the opposite condition.

**Usage**

For example, this code tests that the response status is not successful:

```dart
await expect(response).not.toBeOK();
```

**Type**
- [APIResponseAssertions]


[APIRequest]: /api/class-apirequest.mdx "APIRequest"
[APIRequestContext]: /api/class-apirequestcontext.mdx "APIRequestContext"
[APIResponse]: /api/class-apiresponse.mdx "APIResponse"
[APIResponseAssertions]: /api/class-apiresponseassertions.mdx "APIResponseAssertions"
[Browser]: /api/class-browser.mdx "Browser"
[BrowserContext]: /api/class-browsercontext.mdx "BrowserContext"
[BrowserServer]: /api/class-browserserver.mdx "BrowserServer"
[BrowserType]: /api/class-browsertype.mdx "BrowserType"
[CDPSession]: /api/class-cdpsession.mdx "CDPSession"
[Clock]: /api/class-clock.mdx "Clock"
[ConsoleMessage]: /api/class-consolemessage.mdx "ConsoleMessage"
[Coverage]: /api/class-coverage.mdx "Coverage"
[Credentials]: /api/class-credentials.mdx "Credentials"
[Debugger]: /api/class-debugger.mdx "Debugger"
[Dialog]: /api/class-dialog.mdx "Dialog"
[Disposable]: /api/class-disposable.mdx "Disposable"
[Download]: /api/class-download.mdx "Download"
[ElementHandle]: /api/class-elementhandle.mdx "ElementHandle"
[FileChooser]: /api/class-filechooser.mdx "FileChooser"
[Frame]: /api/class-frame.mdx "Frame"
[FrameLocator]: /api/class-framelocator.mdx "FrameLocator"
[GenericAssertions]: /api/class-genericassertions.mdx "GenericAssertions"
[JSHandle]: /api/class-jshandle.mdx "JSHandle"
[Keyboard]: /api/class-keyboard.mdx "Keyboard"
[Locator]: /api/class-locator.mdx "Locator"
[LocatorAssertions]: /api/class-locatorassertions.mdx "LocatorAssertions"
[Logger]: /api/class-logger.mdx "Logger"
[Mouse]: /api/class-mouse.mdx "Mouse"
[Page]: /api/class-page.mdx "Page"
[PageAssertions]: /api/class-pageassertions.mdx "PageAssertions"
[Playwright]: /api/class-playwright.mdx "Playwright"
[PlaywrightAssertions]: /api/class-playwrightassertions.mdx "PlaywrightAssertions"
[Request]: /api/class-request.mdx "Request"
[Response]: /api/class-response.mdx "Response"
[Route]: /api/class-route.mdx "Route"
[Screencast]: /api/class-screencast.mdx "Screencast"
[Selectors]: /api/class-selectors.mdx "Selectors"
[SnapshotAssertions]: /api/class-snapshotassertions.mdx "SnapshotAssertions"
[TimeoutError]: /api/class-timeouterror.mdx "TimeoutError"
[Touchscreen]: /api/class-touchscreen.mdx "Touchscreen"
[Tracing]: /api/class-tracing.mdx "Tracing"
[Video]: /api/class-video.mdx "Video"
[WebError]: /api/class-weberror.mdx "WebError"
[WebSocket]: /api/class-websocket.mdx "WebSocket"
[WebSocketRoute]: /api/class-websocketroute.mdx "WebSocketRoute"
[WebStorage]: /api/class-webstorage.mdx "WebStorage"
[Worker]: /api/class-worker.mdx "Worker"
[Electron]: /api/class-electron.mdx "Electron"
[ElectronApplication]: /api/class-electronapplication.mdx "ElectronApplication"
[Android]: /api/class-android.mdx "Android"
[AndroidDevice]: /api/class-androiddevice.mdx "AndroidDevice"
[AndroidInput]: /api/class-androidinput.mdx "AndroidInput"
[AndroidSocket]: /api/class-androidsocket.mdx "AndroidSocket"
[AndroidWebView]: /api/class-androidwebview.mdx "AndroidWebView"
[Fixtures]: /api/class-fixtures.mdx "Fixtures"
[FullConfig]: /api/class-fullconfig.mdx "FullConfig"
[FullProject]: /api/class-fullproject.mdx "FullProject"
[Location]: /api/class-location.mdx "Location"
[Test]: /api/class-test.mdx "Test"
[TestConfig]: /api/class-testconfig.mdx "TestConfig"
[TestInfo]: /api/class-testinfo.mdx "TestInfo"
[TestInfoError]: /api/class-testinfoerror.mdx "TestInfoError"
[TestOptions]: /api/class-testoptions.mdx "TestOptions"
[TestProject]: /api/class-testproject.mdx "TestProject"
[TestStepInfo]: /api/class-teststepinfo.mdx "TestStepInfo"
[WorkerInfo]: /api/class-workerinfo.mdx "WorkerInfo"
[Reporter]: /api/class-reporter.mdx "Reporter"
[Suite]: /api/class-suite.mdx "Suite"
[TestCase]: /api/class-testcase.mdx "TestCase"
[TestError]: /api/class-testerror.mdx "TestError"
[TestResult]: /api/class-testresult.mdx "TestResult"
[TestStep]: /api/class-teststep.mdx "TestStep"
[EvaluationArgument]: /evaluating.mdx#evaluation-argument "EvaluationArgument"
[UIEvent.detail]: https://developer.mozilla.org/en-US/docs/Web/API/UIEvent/detail "UIEvent.detail"


[all available image tags]: https://mcr.microsoft.com/en-us/product/playwright/about "all available image tags"
[Microsoft Artifact Registry]: https://mcr.microsoft.com/en-us/product/playwright/about "Microsoft Artifact Registry"
[Dockerfile.noble]: https://github.com/microsoft/playwright/blob/main/utils/docker/Dockerfile.noble "Dockerfile.noble"

```dart
APIResponseAssertions get not
```

### `toBeOK`

*⚙️ Method*

Ensures the response status code is within `200..299` range.

**Usage**

```dart
await expect(response).toBeOK();
```

**Returns**
- Future&lt;void&gt;

```dart
Future<void> toBeOK() async
```

### `toHaveStatus`

*⚙️ Method*

Checks that the response has the expected status code.

```dart
Future<void> toHaveStatus(int expected) async
```

### `toHaveStatusInRange`

*⚙️ Method*

Checks that the response has a status code in the expected range.

```dart
Future<void> toHaveStatusInRange(int min, int max) async
```

### `toHaveStatusText`

*⚙️ Method*

Checks that the response has the expected status text.

```dart
Future<void> toHaveStatusText(String expected) async
```

### `toHaveURL`

*⚙️ Method*

Checks that the response has the expected URL.

```dart
Future<void> toHaveURL(Pattern expected) async
```

### `toHaveHeader`

*⚙️ Method*

Checks that the response has the expected header.

```dart
Future<void> toHaveHeader(String name, String? value) async
```

### `toBeSuccessful`

*⚙️ Method*

Checks that the response is successful (status code 2xx or 3xx).

```dart
Future<void> toBeSuccessful() async
```

### `toBeClientError`

*⚙️ Method*

Checks that the response is a client error (status code 4xx).

```dart
Future<void> toBeClientError() async
```

### `toBeServerError`

*⚙️ Method*

Checks that the response is a server error (status code 5xx).

```dart
Future<void> toBeServerError() async
```

## `Dialog`

```dart
abstract interface class Dialog
```

### `page`

*📦 Property*

The page that initiated this dialog, if available.

**Usage**

```dart
dialog.page;
```

**Returns**
- [Page]?

```dart
Page get page
```

### `type`

*📦 Property*

Returns dialog's type, can be one of `alert`, `beforeunload`, `confirm` or `prompt`.

**Usage**

```dart
dialog.type;
```

**Returns**
- String


[APIRequest]: /api/class-apirequest.mdx "APIRequest"
[APIRequestContext]: /api/class-apirequestcontext.mdx "APIRequestContext"
[APIResponse]: /api/class-apiresponse.mdx "APIResponse"
[APIResponseAssertions]: /api/class-apiresponseassertions.mdx "APIResponseAssertions"
[Browser]: /api/class-browser.mdx "Browser"
[BrowserContext]: /api/class-browsercontext.mdx "BrowserContext"
[BrowserServer]: /api/class-browserserver.mdx "BrowserServer"
[BrowserType]: /api/class-browsertype.mdx "BrowserType"
[CDPSession]: /api/class-cdpsession.mdx "CDPSession"
[Clock]: /api/class-clock.mdx "Clock"
[ConsoleMessage]: /api/class-consolemessage.mdx "ConsoleMessage"
[Coverage]: /api/class-coverage.mdx "Coverage"
[Credentials]: /api/class-credentials.mdx "Credentials"
[Debugger]: /api/class-debugger.mdx "Debugger"
[Dialog]: /api/class-dialog.mdx "Dialog"
[Disposable]: /api/class-disposable.mdx "Disposable"
[Download]: /api/class-download.mdx "Download"
[ElementHandle]: /api/class-elementhandle.mdx "ElementHandle"
[FileChooser]: /api/class-filechooser.mdx "FileChooser"
[Frame]: /api/class-frame.mdx "Frame"
[FrameLocator]: /api/class-framelocator.mdx "FrameLocator"
[GenericAssertions]: /api/class-genericassertions.mdx "GenericAssertions"
[JSHandle]: /api/class-jshandle.mdx "JSHandle"
[Keyboard]: /api/class-keyboard.mdx "Keyboard"
[Locator]: /api/class-locator.mdx "Locator"
[LocatorAssertions]: /api/class-locatorassertions.mdx "LocatorAssertions"
[Logger]: /api/class-logger.mdx "Logger"
[Mouse]: /api/class-mouse.mdx "Mouse"
[Page]: /api/class-page.mdx "Page"
[PageAssertions]: /api/class-pageassertions.mdx "PageAssertions"
[Playwright]: /api/class-playwright.mdx "Playwright"
[PlaywrightAssertions]: /api/class-playwrightassertions.mdx "PlaywrightAssertions"
[Request]: /api/class-request.mdx "Request"
[Response]: /api/class-response.mdx "Response"
[Route]: /api/class-route.mdx "Route"
[Screencast]: /api/class-screencast.mdx "Screencast"
[Selectors]: /api/class-selectors.mdx "Selectors"
[SnapshotAssertions]: /api/class-snapshotassertions.mdx "SnapshotAssertions"
[TimeoutError]: /api/class-timeouterror.mdx "TimeoutError"
[Touchscreen]: /api/class-touchscreen.mdx "Touchscreen"
[Tracing]: /api/class-tracing.mdx "Tracing"
[Video]: /api/class-video.mdx "Video"
[WebError]: /api/class-weberror.mdx "WebError"
[WebSocket]: /api/class-websocket.mdx "WebSocket"
[WebSocketRoute]: /api/class-websocketroute.mdx "WebSocketRoute"
[WebStorage]: /api/class-webstorage.mdx "WebStorage"
[Worker]: /api/class-worker.mdx "Worker"
[Electron]: /api/class-electron.mdx "Electron"
[ElectronApplication]: /api/class-electronapplication.mdx "ElectronApplication"
[Android]: /api/class-android.mdx "Android"
[AndroidDevice]: /api/class-androiddevice.mdx "AndroidDevice"
[AndroidInput]: /api/class-androidinput.mdx "AndroidInput"
[AndroidSocket]: /api/class-androidsocket.mdx "AndroidSocket"
[AndroidWebView]: /api/class-androidwebview.mdx "AndroidWebView"
[Fixtures]: /api/class-fixtures.mdx "Fixtures"
[FullConfig]: /api/class-fullconfig.mdx "FullConfig"
[FullProject]: /api/class-fullproject.mdx "FullProject"
[Location]: /api/class-location.mdx "Location"
[Test]: /api/class-test.mdx "Test"
[TestConfig]: /api/class-testconfig.mdx "TestConfig"
[TestInfo]: /api/class-testinfo.mdx "TestInfo"
[TestInfoError]: /api/class-testinfoerror.mdx "TestInfoError"
[TestOptions]: /api/class-testoptions.mdx "TestOptions"
[TestProject]: /api/class-testproject.mdx "TestProject"
[TestStepInfo]: /api/class-teststepinfo.mdx "TestStepInfo"
[WorkerInfo]: /api/class-workerinfo.mdx "WorkerInfo"
[Reporter]: /api/class-reporter.mdx "Reporter"
[Suite]: /api/class-suite.mdx "Suite"
[TestCase]: /api/class-testcase.mdx "TestCase"
[TestError]: /api/class-testerror.mdx "TestError"
[TestResult]: /api/class-testresult.mdx "TestResult"
[TestStep]: /api/class-teststep.mdx "TestStep"
[EvaluationArgument]: /evaluating.mdx#evaluation-argument "EvaluationArgument"
[UIEvent.detail]: https://developer.mozilla.org/en-US/docs/Web/API/UIEvent/detail "UIEvent.detail"


[all available image tags]: https://mcr.microsoft.com/en-us/product/playwright/about "all available image tags"
[Microsoft Artifact Registry]: https://mcr.microsoft.com/en-us/product/playwright/about "Microsoft Artifact Registry"
[Dockerfile.noble]: https://github.com/microsoft/playwright/blob/main/utils/docker/Dockerfile.noble "Dockerfile.noble"

```dart
String get type
```

### `message`

*📦 Property*

A message displayed in the dialog.

**Usage**

```dart
dialog.message;
```

**Returns**
- String

```dart
String get message
```

### `defaultValue`

*📦 Property*

If dialog is prompt, returns default prompt value. Otherwise, returns empty string.

**Usage**

```dart
dialog.defaultValue;
```

**Returns**
- String

```dart
String get defaultValue
```

### `accept`

*⚙️ Method*

Returns when the dialog has been accepted.

**Usage**

```dart
await dialog.accept();
await dialog.accept(promptText);
```

**Arguments**
- `promptText` String *(optional)*

A text to enter in prompt. Does not cause any effects if the dialog's `type` is not prompt. Optional.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> accept(
```

### `dismiss`

*⚙️ Method*

Returns when the dialog has been dismissed.

**Usage**

```dart
await dialog.dismiss();
```

**Returns**
- Future&lt;void&gt;

```dart
Future<void> dismiss()
```

## `ElementHandle`

A handle to a DOM element in the browser page.

The optional type parameter [T] mirrors the TypeScript SDK's
`ElementHandle<T extends Node = Node>` generic, where [Node] is
`package:html`'s DOM [Node] class.  It carries type information about
the underlying DOM element kind without impacting runtime behaviour.

[ElementHandle] extends [JSHandle] because every DOM element is also a
JavaScript value — the same relationship as in the TypeScript SDK where
`ElementHandle<T extends Node> extends JSHandle<T>`.

```dart
import 'package:html/dom.dart' show Element;

// Default: any DOM node
final ElementHandle<Node> handle = await page.querySelector('div');

// Narrowed to Element (any HTML element):
final ElementHandle<Element> el = handle as ElementHandle<Element>;
await el.click();
```

```dart
abstract interface class ElementHandle<T extends Node> implements JSHandle<T>
```

### `click`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.click()] instead. Read more about [locators].

This method clicks the element by performing the following steps:
1. Wait for [actionability] checks on the element, unless [force] option is set.
1. Scroll the element into view if needed.
1. Use [page.mouse] to click in the center of the element, or the specified [position].
1. Wait for initiated navigations to either succeed or fail, unless [noWaitAfter] option is set.

If the element is detached from the DOM at any moment during the action, this method throws.

When all steps combined have not finished during the specified [timeout], this method throws a [TimeoutError]. Passing zero timeout disables this.

**Usage**

```dart
await elementHandle.click();
await elementHandle.click(options);
```

**Arguments**
- `options` Map *(optional)*
- `button` Button *(optional)*

Defaults to `left`.
- `clickCount` int *(optional)*

defaults to 1. See [UIEvent.detail].
- `delay` double *(optional)*

Time to wait between `mousedown` and `mouseup` in milliseconds. Defaults to 0.
- `force` bool *(optional)*

Whether to bypass the [actionability] checks. Defaults to `false`.
- `modifiers` List&lt;Modifiers&gt; *(optional)*

Modifier keys to press. Ensures that only these modifiers are pressed during the operation, and then restores current modifiers back. If not specified, currently pressed modifiers are used. "ControlOrMeta" resolves to "Control" on Windows and Linux and to "Meta" on macOS.
- `noWaitAfter` bool *(optional)*

**WARNING**
[Deprecated]
This option will default to `true` in the future.
Actions that initiate navigations are waiting for these navigations to happen and for pages to start loading. You can opt out of waiting via setting this flag. You would only need this option in the exceptional cases such as navigating to inaccessible pages. Defaults to `false`.
- `position` Point *(optional)*
- `x` num


- `y` num


A point to use relative to the top-left corner of element padding box. If not specified, uses some visible point of the element.
- `steps` int *(optional)*

Defaults to 1. Sends `n` interpolated `mousemove` events to represent travel between Playwright's current cursor position and the provided destination. When set to 1, emits a single `mousemove` event at the destination location.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
- `trial` bool *(optional)*

When set, this method only performs the [actionability] checks and skips the action. Defaults to `false`. Useful to wait until the element is ready for the action without performing it.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> click(
```

### `dblclick`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.dblclick()] instead. Read more about [locators].

This method double clicks the element by performing the following steps:
1. Wait for [actionability] checks on the element, unless [force] option is set.
1. Scroll the element into view if needed.
1. Use [page.mouse] to double click in the center of the element, or the specified [position].

If the element is detached from the DOM at any moment during the action, this method throws.

When all steps combined have not finished during the specified [timeout], this method throws a [TimeoutError]. Passing zero timeout disables this.

**NOTE**
`elementHandle.dblclick()` dispatches two `click` events and a single `dblclick` event.
**Usage**

```dart
await elementHandle.dblclick();
await elementHandle.dblclick(options);
```

**Arguments**
- `options` Map *(optional)*
- `button` Button *(optional)*

Defaults to `left`.
- `delay` double *(optional)*

Time to wait between `mousedown` and `mouseup` in milliseconds. Defaults to 0.
- `force` bool *(optional)*

Whether to bypass the [actionability] checks. Defaults to `false`.
- `modifiers` List&lt;Modifiers&gt; *(optional)*

Modifier keys to press. Ensures that only these modifiers are pressed during the operation, and then restores current modifiers back. If not specified, currently pressed modifiers are used. "ControlOrMeta" resolves to "Control" on Windows and Linux and to "Meta" on macOS.
- `noWaitAfter` bool *(optional)*

**WARNING**
[Deprecated]
This option has no effect.
This option has no effect.
- `position` Point *(optional)*
- `x` num


- `y` num


A point to use relative to the top-left corner of element padding box. If not specified, uses some visible point of the element.
- `steps` int *(optional)*

Defaults to 1. Sends `n` interpolated `mousemove` events to represent travel between Playwright's current cursor position and the provided destination. When set to 1, emits a single `mousemove` event at the destination location.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
- `trial` bool *(optional)*

When set, this method only performs the [actionability] checks and skips the action. Defaults to `false`. Useful to wait until the element is ready for the action without performing it.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> dblclick(
```

### `fill`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.fill()] instead. Read more about [locators].

This method waits for [actionability] checks, focuses the element, fills it and triggers an `input` event after filling. Note that you can pass an empty string to clear the input field.

If the target element is not an `<input>`, `<textarea>` or `[contenteditable]` element, this method throws an error. However, if the element is inside the `<label>` element that has an associated [control], the control will be filled instead.

To send fine-grained keyboard events, use [locator.pressSequentially()].

**Usage**

```dart
await elementHandle.fill(value);
await elementHandle.fill(value, options);
```

**Arguments**
- `value` String

Value to set for the `<input>`, `<textarea>` or `[contenteditable]` element.
- `options` Map *(optional)*
- `force` bool *(optional)*

Whether to bypass the [actionability] checks. Defaults to `false`.
- `noWaitAfter` bool *(optional)*

**WARNING**
[Deprecated]
This option has no effect.
This option has no effect.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> fill(String value,
```

### `hover`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.hover()] instead. Read more about [locators].

This method hovers over the element by performing the following steps:
1. Wait for [actionability] checks on the element, unless [force] option is set.
1. Scroll the element into view if needed.
1. Use [page.mouse] to hover over the center of the element, or the specified [position].

If the element is detached from the DOM at any moment during the action, this method throws.

When all steps combined have not finished during the specified [timeout], this method throws a [TimeoutError]. Passing zero timeout disables this.

**Usage**

```dart
await elementHandle.hover();
await elementHandle.hover(options);
```

**Arguments**
- `options` Map *(optional)*
- `force` bool *(optional)*

Whether to bypass the [actionability] checks. Defaults to `false`.
- `modifiers` List&lt;Modifiers&gt; *(optional)*

Modifier keys to press. Ensures that only these modifiers are pressed during the operation, and then restores current modifiers back. If not specified, currently pressed modifiers are used. "ControlOrMeta" resolves to "Control" on Windows and Linux and to "Meta" on macOS.
- `noWaitAfter` bool *(optional)*

**WARNING**
[Deprecated]
This option has no effect.
This option has no effect.
- `position` Point *(optional)*
- `x` num


- `y` num


A point to use relative to the top-left corner of element padding box. If not specified, uses some visible point of the element.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
- `trial` bool *(optional)*

When set, this method only performs the [actionability] checks and skips the action. Defaults to `false`. Useful to wait until the element is ready for the action without performing it.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> hover(
```

### `focus`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.focus()] instead. Read more about [locators].

Calls [focus] on the element.

**Usage**

```dart
await elementHandle.focus();
```

**Returns**
- Future&lt;void&gt;

```dart
Future<void> focus()
```

### `type`

*⚙️ Method*

**WARNING**
[Deprecated]

In most cases, you should use [locator.fill()] instead. You only need to press keys one by one if there is special keyboard handling on the page - in this case use [locator.pressSequentially()].

Focuses the element, and then sends a `keydown`, `keypress`/`input`, and `keyup` event for each character in the text.

To press a special key, like `Control` or `ArrowDown`, use [elementHandle.press()].

**Usage**

**Arguments**
- `text` String

A text to type into a focused element.
- `options` Map *(optional)*
- `delay` double *(optional)*

Time to wait between key presses in milliseconds. Defaults to 0.
- `noWaitAfter` bool *(optional)*

**WARNING**
[Deprecated]
This option has no effect.
This option has no effect.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> type(String text,
```

### `press`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.press()] instead. Read more about [locators].

Focuses the element, and then uses [keyboard.down()] and [keyboard.up()].

[key] can specify the intended [keyboardEvent.key] value or a single character to generate the text for. A superset of the [key] values can be found [here]. Examples of the keys are:

`F1` - `F12`, `Digit0`- `Digit9`, `KeyA`- `KeyZ`, `Backquote`, `Minus`, `Equal`, `Backslash`, `Backspace`, `Tab`, `Delete`, `Escape`, `ArrowDown`, `End`, `Enter`, `Home`, `Insert`, `PageDown`, `PageUp`, `ArrowRight`, `ArrowUp`, etc.

Following modification shortcuts are also supported: `Shift`, `Control`, `Alt`, `Meta`, `ShiftLeft`, `ControlOrMeta`.

Holding down `Shift` will type the text that corresponds to the [key] in the upper case.

If [key] is a single character, it is case-sensitive, so the values `a` and `A` will generate different respective texts.

Shortcuts such as `key: "Control+o"`, `key: "Control++` or `key: "Control+Shift+T"` are supported as well. When specified with the modifier, modifier is pressed and being held while the subsequent key is being pressed.

**Usage**

```dart
await elementHandle.press(key);
await elementHandle.press(key, options);
```

**Arguments**
- `key` String

Name of the key to press or a character to generate, such as `ArrowLeft` or `a`.
- `options` Map *(optional)*
- `delay` double *(optional)*

Time to wait between `keydown` and `keyup` in milliseconds. Defaults to 0.
- `noWaitAfter` bool *(optional)*

**WARNING**
[Deprecated]
This option will default to `true` in the future.
Actions that initiate navigations are waiting for these navigations to happen and for pages to start loading. You can opt out of waiting via setting this flag. You would only need this option in the exceptional cases such as navigating to inaccessible pages. Defaults to `false`.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> press( String key,
```

### `tap`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.tap()] instead. Read more about [locators].

This method taps the element by performing the following steps:
1. Wait for [actionability] checks on the element, unless [force] option is set.
1. Scroll the element into view if needed.
1. Use [page.touchscreen] to tap the center of the element, or the specified [position].

If the element is detached from the DOM at any moment during the action, this method throws.

When all steps combined have not finished during the specified [timeout], this method throws a [TimeoutError]. Passing zero timeout disables this.

**NOTE**
`elementHandle.tap()` requires that the `hasTouch` option of the browser context be set to true.
**Usage**

```dart
await elementHandle.tap();
await elementHandle.tap(options);
```

**Arguments**
- `options` Map *(optional)*
- `force` bool *(optional)*

Whether to bypass the [actionability] checks. Defaults to `false`.
- `modifiers` List&lt;Modifiers&gt; *(optional)*

Modifier keys to press. Ensures that only these modifiers are pressed during the operation, and then restores current modifiers back. If not specified, currently pressed modifiers are used. "ControlOrMeta" resolves to "Control" on Windows and Linux and to "Meta" on macOS.
- `noWaitAfter` bool *(optional)*

**WARNING**
[Deprecated]
This option has no effect.
This option has no effect.
- `position` Point *(optional)*
- `x` num


- `y` num


A point to use relative to the top-left corner of element padding box. If not specified, uses some visible point of the element.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
- `trial` bool *(optional)*

When set, this method only performs the [actionability] checks and skips the action. Defaults to `false`. Useful to wait until the element is ready for the action without performing it.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> tap(
```

### `check`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.check()] instead. Read more about [locators].

This method checks the element by performing the following steps:
1. Ensure that element is a checkbox or a radio input. If not, this method throws. If the element is already checked, this method returns immediately.
1. Wait for [actionability] checks on the element, unless [force] option is set.
1. Scroll the element into view if needed.
1. Use [page.mouse] to click in the center of the element.
1. Ensure that the element is now checked. If not, this method throws.

If the element is detached from the DOM at any moment during the action, this method throws.

When all steps combined have not finished during the specified [timeout], this method throws a [TimeoutError]. Passing zero timeout disables this.

**Usage**

```dart
await elementHandle.check();
await elementHandle.check(options);
```

**Arguments**
- `options` Map *(optional)*
- `force` bool *(optional)*

Whether to bypass the [actionability] checks. Defaults to `false`.
- `noWaitAfter` bool *(optional)*

**WARNING**
[Deprecated]
This option has no effect.
This option has no effect.
- `position` Point *(optional)*
- `x` num


- `y` num


A point to use relative to the top-left corner of element padding box. If not specified, uses some visible point of the element.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
- `trial` bool *(optional)*

When set, this method only performs the [actionability] checks and skips the action. Defaults to `false`. Useful to wait until the element is ready for the action without performing it.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> check(
```

### `uncheck`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.uncheck()] instead. Read more about [locators].

This method checks the element by performing the following steps:
1. Ensure that element is a checkbox or a radio input. If not, this method throws. If the element is already unchecked, this method returns immediately.
1. Wait for [actionability] checks on the element, unless [force] option is set.
1. Scroll the element into view if needed.
1. Use [page.mouse] to click in the center of the element.
1. Ensure that the element is now unchecked. If not, this method throws.

If the element is detached from the DOM at any moment during the action, this method throws.

When all steps combined have not finished during the specified [timeout], this method throws a [TimeoutError]. Passing zero timeout disables this.

**Usage**

```dart
await elementHandle.uncheck();
await elementHandle.uncheck(options);
```

**Arguments**
- `options` Map *(optional)*
- `force` bool *(optional)*

Whether to bypass the [actionability] checks. Defaults to `false`.
- `noWaitAfter` bool *(optional)*

**WARNING**
[Deprecated]
This option has no effect.
This option has no effect.
- `position` Point *(optional)*
- `x` num


- `y` num


A point to use relative to the top-left corner of element padding box. If not specified, uses some visible point of the element.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
- `trial` bool *(optional)*

When set, this method only performs the [actionability] checks and skips the action. Defaults to `false`. Useful to wait until the element is ready for the action without performing it.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> uncheck(
```

### `scrollIntoViewIfNeeded`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.scrollIntoViewIfNeeded()] instead. Read more about [locators].

This method waits for [actionability] checks, then tries to scroll element into view, unless it is completely visible as defined by [IntersectionObserver]'s `ratio`.

Throws when `elementHandle` does not point to an element [connected] to a Document or a ShadowRoot.

See [scrolling] for alternative ways to scroll.

**Usage**

```dart
await elementHandle.scrollIntoViewIfNeeded();
await elementHandle.scrollIntoViewIfNeeded(options);
```

**Arguments**
- `options` Map *(optional)*
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> scrollIntoViewIfNeeded(
```

### `getAttribute`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.getAttribute()] instead. Read more about [locators].

Returns element attribute value.

**Usage**

```dart
await elementHandle.getAttribute(name);
```

**Arguments**
- `name` String

Attribute name to get the value for.

**Returns**
- Future&lt;[String&gt;]?

```dart
Future<String?> getAttribute(String name)
```

### `innerHTML`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.innerHTML()] instead. Read more about [locators].

Returns the `element.innerHTML`.

**Usage**

```dart
await elementHandle.innerHTML();
```

**Returns**
- Future&lt;String&gt;

```dart
Future<String> innerHTML()
```

### `innerText`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.innerText()] instead. Read more about [locators].

Returns the `element.innerText`.

**Usage**

```dart
await elementHandle.innerText();
```

**Returns**
- Future&lt;String&gt;

```dart
Future<String> innerText()
```

### `inputValue`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.inputValue()] instead. Read more about [locators].

Returns `input.value` for the selected `<input>` or `<textarea>` or `<select>` element.

Throws for non-input elements. However, if the element is inside the `<label>` element that has an associated [control], returns the value of the control.

**Usage**

```dart
await elementHandle.inputValue();
await elementHandle.inputValue(options);
```

**Arguments**
- `options` Map *(optional)*
- `timeout` num *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;String&gt;

```dart
Future<String> inputValue()
```

### `textContent`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.textContent()] instead. Read more about [locators].

Returns the `node.textContent`.

**Usage**

```dart
await elementHandle.textContent();
```

**Returns**
- Future&lt;[String&gt;]?

```dart
Future<String> textContent()
```

### `isChecked`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.isChecked()] instead. Read more about [locators].

Returns whether the element is checked. Throws if the element is not a checkbox or radio input.

**Usage**

```dart
await elementHandle.isChecked();
```

**Returns**
- Future&lt;bool&gt;

```dart
Future<bool> isChecked()
```

### `isDisabled`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.isDisabled()] instead. Read more about [locators].

Returns whether the element is disabled, the opposite of [enabled].

**Usage**

```dart
await elementHandle.isDisabled();
```

**Returns**
- Future&lt;bool&gt;

```dart
Future<bool> isDisabled()
```

### `isEditable`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.isEditable()] instead. Read more about [locators].

Returns whether the element is [editable].

**Usage**

```dart
await elementHandle.isEditable();
```

**Returns**
- Future&lt;bool&gt;

```dart
Future<bool> isEditable()
```

### `isEnabled`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.isEnabled()] instead. Read more about [locators].

Returns whether the element is [enabled].

**Usage**

```dart
await elementHandle.isEnabled();
```

**Returns**
- Future&lt;bool&gt;

```dart
Future<bool> isEnabled()
```

### `isHidden`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.isHidden()] instead. Read more about [locators].

Returns whether the element is hidden, the opposite of [visible].

**Usage**

```dart
await elementHandle.isHidden();
```

**Returns**
- Future&lt;bool&gt;

```dart
Future<bool> isHidden()
```

### `isVisible`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.isVisible()] instead. Read more about [locators].

Returns whether the element is [visible].

**Usage**

```dart
await elementHandle.isVisible();
```

**Returns**
- Future&lt;bool&gt;

```dart
Future<bool> isVisible()
```

### `boundingBox`

*⚙️ Method*

This method returns the bounding box of the element, or `null` if the element is not visible. The bounding box is calculated relative to the main frame viewport - which is usually the same as the browser window.

Scrolling affects the returned bounding box, similarly to [Element.getBoundingClientRect]. That means `x` and/or `y` may be negative.

Elements from child frames return the bounding box relative to the main frame, unlike the [Element.getBoundingClientRect].

Assuming the page is static, it is safe to use bounding box coordinates to perform input. For example, the following snippet should click the center of the element.

**Usage**

```dart
final box = await elementHandle.boundingBox();
await page.mouse.click(box.x + box.width / 2, box.y + box.height / 2);
```

**Returns**
- Future&lt;[Map&gt;]?
- `x` num

the x coordinate of the element in pixels.
- `y` num

the y coordinate of the element in pixels.
- `width` num

the width of the element in pixels.
- `height` num

the height of the element in pixels.

```dart
Future<Rect?> boundingBox()
```

### `contentFrame`

*⚙️ Method*

Returns the content frame for element handles referencing iframe nodes, or `null` otherwise

**Usage**

```dart
await elementHandle.contentFrame();
```

**Returns**
- Future&lt;[Frame]?&gt;

```dart
Future<Frame?> contentFrame()
```

### `ownerFrame`

*⚙️ Method*

Returns the frame containing the given element.

**Usage**

```dart
await elementHandle.ownerFrame();
```

**Returns**
- Future&lt;[Frame]?&gt;

```dart
Future<Frame?> ownerFrame()
```

### `dispatchEvent`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.dispatchEvent()] instead. Read more about [locators].

The snippet below dispatches the `click` event on the element. Regardless of the visibility state of the element, `click` is dispatched. This is equivalent to calling [element.click()].

**Usage**

```dart
await elementHandle.dispatchEvent('click');
```

Under the hood, it creates an instance of an event based on the given [type], initializes it with [eventInit] properties and dispatches it on the element. Events are `composed`, `cancelable` and bubble by default.

Since [eventInit] is event-specific, please refer to the events documentation for the lists of initial properties:
* [DeviceMotionEvent]
* [DeviceOrientationEvent]
* [DragEvent]
* [Event]
* [FocusEvent]
* [KeyboardEvent]
* [MouseEvent]
* [PointerEvent]
* [TouchEvent]
* [WheelEvent]

You can also specify `JSHandle` as the property value if you want live objects to be passed into the event:

```dart
// Note you can only create DataTransfer in Chromium and Firefox
final dataTransfer = await page.evaluateHandle(() => new DataTransfer());
await elementHandle.dispatchEvent('dragstart', { dataTransfer );
```

**Arguments**
- `type` String

DOM event type: `"click"`, `"dragstart"`, etc.
- `eventInit` dynamic *(optional)*

Optional event-specific initialization properties.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> dispatchEvent(String type,
```

### `screenshot`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.screenshot()] instead. Read more about [locators].

This method captures a screenshot of the page, clipped to the size and position of this particular element. If the element is covered by other elements, it will not be actually visible on the screenshot. If the element is a scrollable container, only the currently scrolled content will be visible on the screenshot.

This method waits for the [actionability] checks, then scrolls element into view before taking a screenshot. If the element is detached from DOM, the method throws an error.

Returns the buffer with the captured screenshot.

**Usage**

```dart
await elementHandle.screenshot();
await elementHandle.screenshot(options);
```

**Arguments**
- `options` CommonScreenshotOptions *(optional)*
- `animations` "disabled" | "allow" *(optional)*

When set to `"disabled"`, stops CSS animations, CSS transitions and Web Animations. Animations get different treatment depending on their duration:
* finite animations are fast-forwarded to completion, so they'll fire `transitionend` event.
* infinite animations are canceled to initial state, and then played over after the screenshot.

Defaults to `"allow"` that leaves animations untouched.
- `caret` "hide" | "initial" *(optional)*

When set to `"hide"`, screenshot will hide text caret. When set to `"initial"`, text caret behavior will not be changed.  Defaults to `"hide"`.
- `mask` List&lt;[Locator]&gt; *(optional)*

Specify locators that should be masked when the screenshot is taken. Masked elements will be overlaid with a pink box `#FF00FF` (customized by [maskColor]) that completely covers its bounding box. The mask is also applied to invisible elements, see [Matching only visible elements] to disable that.
- `maskColor` String *(optional)*

Specify the color of the overlay box for masked elements, in [CSS color format]. Default color is pink `#FF00FF`.
- `omitBackground` bool *(optional)*

Hides default white background and allows capturing screenshots with transparency. Not applicable to `jpeg` images. Defaults to `false`.
- `path` String *(optional)*

The file path to save the image to. The screenshot type will be inferred from file extension. If [path] is a relative path, then it is resolved relative to the current working directory. If no path is provided, the image won't be saved to the disk.
- `quality` int *(optional)*

The quality of the image, between 0-100. Not applicable to `png` images.
- `scale` "css" | "device" *(optional)*

When set to `"css"`, screenshot will have a single pixel per each css pixel on the page. For high-dpi devices, this will keep screenshots small. Using `"device"` option will produce a single pixel per each device pixel, so screenshots of high-dpi devices will be twice as large or even larger.

Defaults to `"device"`.
- `style` String *(optional)*

Text of the stylesheet to apply while making the screenshot. This is where you can hide dynamic elements, make elements invisible or change their properties to help you creating repeatable screenshots. This stylesheet pierces the Shadow DOM and applies to the inner frames.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
- `type` String *(optional)*

Specify screenshot type, defaults to `png`.

**Returns**
- Future&lt;List&lt;int&gt;&gt;

```dart
Future<List<int>> screenshot(
```

### `selectOption`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.selectOption()] instead. Read more about [locators].

This method waits for [actionability] checks, waits until all specified options are present in the `<select>` element and selects these options.

If the target element is not a `<select>` element, this method throws an error. However, if the element is inside the `<label>` element that has an associated [control], the control will be used instead.

Returns the array of option values that have been successfully selected.

Triggers a `change` and `input` event once all the provided options have been selected.

**Usage**

```dart
// Single selection matching the value or label
handle.selectOption('blue');

// single selection matching the label
handle.selectOption( label: 'Blue' );

// multiple selection
handle.selectOption(['red', 'green', 'blue']);
```

**Arguments**
- `values` dynamic
- `value` String *(optional)*

Matches by `option.value`. Optional.
- `label` String *(optional)*

Matches by `option.label`. Optional.
- `index` num *(optional)*

Matches by the index. Optional.

Options to select. If the `<select>` has the `multiple` attribute, all matching options are selected, otherwise only the first option matching one of the passed options is selected. String values are matching both values and labels. Option is considered matching if all specified properties match.
- `options` List&lt;ElementHandleSelectOptionOptionsItems&gt; *(optional)*
- `force` bool *(optional)*

Whether to bypass the [actionability] checks. Defaults to `false`.
- `noWaitAfter` bool *(optional)*

**WARNING**
[Deprecated]
This option has no effect.
This option has no effect.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;List&lt;String&gt;&gt;

```dart
Future<List<String>> selectOption(
```

### `selectText`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.selectText()] instead. Read more about [locators].

This method waits for [actionability] checks, then focuses the element and selects all its text content.

If the element is inside the `<label>` element that has an associated [control], focuses and selects text in the control instead.

**Usage**

```dart
await elementHandle.selectText();
await elementHandle.selectText(options);
```

**Arguments**
- `options` Map *(optional)*
- `force` bool *(optional)*

Whether to bypass the [actionability] checks. Defaults to `false`.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> selectText(
```

### `setInputFiles`

*⚙️ Method*

**WARNING**
[Discouraged]

Use locator-based [locator.setInputFiles()] instead. Read more about [locators].

Sets the value of the file input to these file paths or files. If some of the `filePaths` are relative paths, then they are resolved relative to the current working directory. For empty array, clears the selected files. For inputs with a `[webkitdirectory]` attribute, only a single directory path is supported.

This method expects [ElementHandle] to point to an [input element]. However, if the element is inside the `<label>` element that has an associated [control], targets the control instead.

**Usage**

```dart
await elementHandle.setInputFiles(files);
await elementHandle.setInputFiles(files, options);
```

**Arguments**
- `files` List&lt;String&gt;
- `name` String

File name
- `mimeType` String

File type
- `buffer` List&lt;int&gt;

File content
- `options` Map *(optional)*
- `noWaitAfter` bool *(optional)*

**WARNING**
[Deprecated]
This option has no effect.
This option has no effect.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> setInputFiles( List<String> files,
```

### `waitForElementState`

*⚙️ Method*

Returns when the element satisfies the [state].

Depending on the [state] parameter, this method waits for one of the [actionability] checks to pass. This method throws when the element is detached while waiting, unless waiting for the `"hidden"` state.
* `"visible"` Wait until the element is [visible].
* `"hidden"` Wait until the element is [not visible] or not attached. Note that waiting for hidden does not throw when the element detaches.
* `"stable"` Wait until the element is both [visible] and [stable].
* `"enabled"` Wait until the element is [enabled].
* `"disabled"` Wait until the element is [not enabled].
* `"editable"` Wait until the element is [editable].

If the element does not satisfy the condition for the [timeout] milliseconds, this method will throw.

**Usage**

```dart
await elementHandle.waitForElementState(state);
await elementHandle.waitForElementState(state, options);
```

**Arguments**
- `state` ElementState

A state to wait for, see below for more details.
- `options` Map *(optional)*
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> waitForElementState( ElementState state,
```

### `waitForSelector`

*⚙️ Method*

**WARNING**
[Discouraged]

Use web assertions that assert visibility or a locator-based [locator.waitFor()] instead.

Returns element specified by selector when it satisfies [state] option. Returns `null` if waiting for `hidden` or `detached`.

Wait for the [selector] relative to the element handle to satisfy [state] option (either appear/disappear from dom, or become visible/hidden). If at the moment of calling the method [selector] already satisfies the condition, the method will return immediately. If the selector doesn't satisfy the condition for the [timeout] milliseconds, the function will throw.

**Usage**

```dart
await page.setContent(`<div><span></span></div>`);
final div = await page.$('div');
// Waiting for the 'span' selector relative to the div.
final span = await div.waitForSelector('span', { state: 'attached' );
```

**NOTE**
This method does not work across navigations, use [page.waitForSelector()] instead.
**Arguments**
- `selector` String

A selector to query for.
- `options` Map *(optional)*
- `state` SelectorState *(optional)*

Defaults to `'visible'`. Can be either:
* `'attached'` - wait for element to be present in DOM.
* `'detached'` - wait for element to not be present in DOM.
* `'visible'` - wait for element to have non-empty bounding box and no `visibility:hidden`. Note that element without any content or with `display:none` has an empty bounding box and is not considered visible.
* `'hidden'` - wait for element to be either detached from DOM, or have an empty bounding box or `visibility:hidden`. This is opposite to the `'visible'` option.
- `strict` bool *(optional)*

When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;[ElementHandle]?&gt;


[APIRequest]: /api/class-apirequest.mdx "APIRequest"
[APIRequestContext]: /api/class-apirequestcontext.mdx "APIRequestContext"
[APIResponse]: /api/class-apiresponse.mdx "APIResponse"
[APIResponseAssertions]: /api/class-apiresponseassertions.mdx "APIResponseAssertions"
[Browser]: /api/class-browser.mdx "Browser"
[BrowserContext]: /api/class-browsercontext.mdx "BrowserContext"
[BrowserServer]: /api/class-browserserver.mdx "BrowserServer"
[BrowserType]: /api/class-browsertype.mdx "BrowserType"
[CDPSession]: /api/class-cdpsession.mdx "CDPSession"
[Clock]: /api/class-clock.mdx "Clock"
[ConsoleMessage]: /api/class-consolemessage.mdx "ConsoleMessage"
[Coverage]: /api/class-coverage.mdx "Coverage"
[Credentials]: /api/class-credentials.mdx "Credentials"
[Debugger]: /api/class-debugger.mdx "Debugger"
[Dialog]: /api/class-dialog.mdx "Dialog"
[Disposable]: /api/class-disposable.mdx "Disposable"
[Download]: /api/class-download.mdx "Download"
[ElementHandle]: /api/class-elementhandle.mdx "ElementHandle"
[FileChooser]: /api/class-filechooser.mdx "FileChooser"
[Frame]: /api/class-frame.mdx "Frame"
[FrameLocator]: /api/class-framelocator.mdx "FrameLocator"
[GenericAssertions]: /api/class-genericassertions.mdx "GenericAssertions"
[JSHandle]: /api/class-jshandle.mdx "JSHandle"
[Keyboard]: /api/class-keyboard.mdx "Keyboard"
[Locator]: /api/class-locator.mdx "Locator"
[LocatorAssertions]: /api/class-locatorassertions.mdx "LocatorAssertions"
[Logger]: /api/class-logger.mdx "Logger"
[Mouse]: /api/class-mouse.mdx "Mouse"
[Page]: /api/class-page.mdx "Page"
[PageAssertions]: /api/class-pageassertions.mdx "PageAssertions"
[Playwright]: /api/class-playwright.mdx "Playwright"
[PlaywrightAssertions]: /api/class-playwrightassertions.mdx "PlaywrightAssertions"
[Request]: /api/class-request.mdx "Request"
[Response]: /api/class-response.mdx "Response"
[Route]: /api/class-route.mdx "Route"
[Screencast]: /api/class-screencast.mdx "Screencast"
[Selectors]: /api/class-selectors.mdx "Selectors"
[SnapshotAssertions]: /api/class-snapshotassertions.mdx "SnapshotAssertions"
[TimeoutError]: /api/class-timeouterror.mdx "TimeoutError"
[Touchscreen]: /api/class-touchscreen.mdx "Touchscreen"
[Tracing]: /api/class-tracing.mdx "Tracing"
[Video]: /api/class-video.mdx "Video"
[WebError]: /api/class-weberror.mdx "WebError"
[WebSocket]: /api/class-websocket.mdx "WebSocket"
[WebSocketRoute]: /api/class-websocketroute.mdx "WebSocketRoute"
[WebStorage]: /api/class-webstorage.mdx "WebStorage"
[Worker]: /api/class-worker.mdx "Worker"
[Electron]: /api/class-electron.mdx "Electron"
[ElectronApplication]: /api/class-electronapplication.mdx "ElectronApplication"
[Android]: /api/class-android.mdx "Android"
[AndroidDevice]: /api/class-androiddevice.mdx "AndroidDevice"
[AndroidInput]: /api/class-androidinput.mdx "AndroidInput"
[AndroidSocket]: /api/class-androidsocket.mdx "AndroidSocket"
[AndroidWebView]: /api/class-androidwebview.mdx "AndroidWebView"
[Fixtures]: /api/class-fixtures.mdx "Fixtures"
[FullConfig]: /api/class-fullconfig.mdx "FullConfig"
[FullProject]: /api/class-fullproject.mdx "FullProject"
[Location]: /api/class-location.mdx "Location"
[Test]: /api/class-test.mdx "Test"
[TestConfig]: /api/class-testconfig.mdx "TestConfig"
[TestInfo]: /api/class-testinfo.mdx "TestInfo"
[TestInfoError]: /api/class-testinfoerror.mdx "TestInfoError"
[TestOptions]: /api/class-testoptions.mdx "TestOptions"
[TestProject]: /api/class-testproject.mdx "TestProject"
[TestStepInfo]: /api/class-teststepinfo.mdx "TestStepInfo"
[WorkerInfo]: /api/class-workerinfo.mdx "WorkerInfo"
[Reporter]: /api/class-reporter.mdx "Reporter"
[Suite]: /api/class-suite.mdx "Suite"
[TestCase]: /api/class-testcase.mdx "TestCase"
[TestError]: /api/class-testerror.mdx "TestError"
[TestResult]: /api/class-testresult.mdx "TestResult"
[TestStep]: /api/class-teststep.mdx "TestStep"
[EvaluationArgument]: /evaluating.mdx#evaluation-argument "EvaluationArgument"
[UIEvent.detail]: https://developer.mozilla.org/en-US/docs/Web/API/UIEvent/detail "UIEvent.detail"


[all available image tags]: https://mcr.microsoft.com/en-us/product/playwright/about "all available image tags"
[Microsoft Artifact Registry]: https://mcr.microsoft.com/en-us/product/playwright/about "Microsoft Artifact Registry"
[Dockerfile.noble]: https://github.com/microsoft/playwright/blob/main/utils/docker/Dockerfile.noble "Dockerfile.noble"

```dart
Future<ElementHandle?> waitForSelector( String selector,
```

## `FileChooser`

`FileChooser` objects are dispatched by the page in the `page.onFileChooser` event.

```dart
class FileChooser
```

### `setFiles`

*⚙️ Method*

Sets the value of the file input this chooser is associated with. If some of the `filePaths` are relative paths, then they are resolved relative to the current working directory. For empty array, clears the selected files.

**Usage**

```dart
await fileChooser.setFiles(files);
await fileChooser.setFiles(files, options);
```

**Arguments**
- `files` List&lt;String&gt;
- `name` String

File name
- `mimeType` String

File type
- `buffer` List&lt;int&gt;

File content
- `options` Map *(optional)*
- `noWaitAfter` bool *(optional)*

**WARNING**
[Deprecated]
This option has no effect.
This option has no effect.
- `timeout` double *(optional)*

Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.

**Returns**
- Future&lt;void&gt;


[APIRequest]: /api/class-apirequest.mdx "APIRequest"
[APIRequestContext]: /api/class-apirequestcontext.mdx "APIRequestContext"
[APIResponse]: /api/class-apiresponse.mdx "APIResponse"
[APIResponseAssertions]: /api/class-apiresponseassertions.mdx "APIResponseAssertions"
[Browser]: /api/class-browser.mdx "Browser"
[BrowserContext]: /api/class-browsercontext.mdx "BrowserContext"
[BrowserServer]: /api/class-browserserver.mdx "BrowserServer"
[BrowserType]: /api/class-browsertype.mdx "BrowserType"
[CDPSession]: /api/class-cdpsession.mdx "CDPSession"
[Clock]: /api/class-clock.mdx "Clock"
[ConsoleMessage]: /api/class-consolemessage.mdx "ConsoleMessage"
[Coverage]: /api/class-coverage.mdx "Coverage"
[Credentials]: /api/class-credentials.mdx "Credentials"
[Debugger]: /api/class-debugger.mdx "Debugger"
[Dialog]: /api/class-dialog.mdx "Dialog"
[Disposable]: /api/class-disposable.mdx "Disposable"
[Download]: /api/class-download.mdx "Download"
[ElementHandle]: /api/class-elementhandle.mdx "ElementHandle"
[FileChooser]: /api/class-filechooser.mdx "FileChooser"
[Frame]: /api/class-frame.mdx "Frame"
[FrameLocator]: /api/class-framelocator.mdx "FrameLocator"
[GenericAssertions]: /api/class-genericassertions.mdx "GenericAssertions"
[JSHandle]: /api/class-jshandle.mdx "JSHandle"
[Keyboard]: /api/class-keyboard.mdx "Keyboard"
[Locator]: /api/class-locator.mdx "Locator"
[LocatorAssertions]: /api/class-locatorassertions.mdx "LocatorAssertions"
[Logger]: /api/class-logger.mdx "Logger"
[Mouse]: /api/class-mouse.mdx "Mouse"
[Page]: /api/class-page.mdx "Page"
[PageAssertions]: /api/class-pageassertions.mdx "PageAssertions"
[Playwright]: /api/class-playwright.mdx "Playwright"
[PlaywrightAssertions]: /api/class-playwrightassertions.mdx "PlaywrightAssertions"
[Request]: /api/class-request.mdx "Request"
[Response]: /api/class-response.mdx "Response"
[Route]: /api/class-route.mdx "Route"
[Screencast]: /api/class-screencast.mdx "Screencast"
[Selectors]: /api/class-selectors.mdx "Selectors"
[SnapshotAssertions]: /api/class-snapshotassertions.mdx "SnapshotAssertions"
[TimeoutError]: /api/class-timeouterror.mdx "TimeoutError"
[Touchscreen]: /api/class-touchscreen.mdx "Touchscreen"
[Tracing]: /api/class-tracing.mdx "Tracing"
[Video]: /api/class-video.mdx "Video"
[WebError]: /api/class-weberror.mdx "WebError"
[WebSocket]: /api/class-websocket.mdx "WebSocket"
[WebSocketRoute]: /api/class-websocketroute.mdx "WebSocketRoute"
[WebStorage]: /api/class-webstorage.mdx "WebStorage"
[Worker]: /api/class-worker.mdx "Worker"
[Electron]: /api/class-electron.mdx "Electron"
[ElectronApplication]: /api/class-electronapplication.mdx "ElectronApplication"
[Android]: /api/class-android.mdx "Android"
[AndroidDevice]: /api/class-androiddevice.mdx "AndroidDevice"
[AndroidInput]: /api/class-androidinput.mdx "AndroidInput"
[AndroidSocket]: /api/class-androidsocket.mdx "AndroidSocket"
[AndroidWebView]: /api/class-androidwebview.mdx "AndroidWebView"
[Fixtures]: /api/class-fixtures.mdx "Fixtures"
[FullConfig]: /api/class-fullconfig.mdx "FullConfig"
[FullProject]: /api/class-fullproject.mdx "FullProject"
[Location]: /api/class-location.mdx "Location"
[Test]: /api/class-test.mdx "Test"
[TestConfig]: /api/class-testconfig.mdx "TestConfig"
[TestInfo]: /api/class-testinfo.mdx "TestInfo"
[TestInfoError]: /api/class-testinfoerror.mdx "TestInfoError"
[TestOptions]: /api/class-testoptions.mdx "TestOptions"
[TestProject]: /api/class-testproject.mdx "TestProject"
[TestStepInfo]: /api/class-teststepinfo.mdx "TestStepInfo"
[WorkerInfo]: /api/class-workerinfo.mdx "WorkerInfo"
[Reporter]: /api/class-reporter.mdx "Reporter"
[Suite]: /api/class-suite.mdx "Suite"
[TestCase]: /api/class-testcase.mdx "TestCase"
[TestError]: /api/class-testerror.mdx "TestError"
[TestResult]: /api/class-testresult.mdx "TestResult"
[TestStep]: /api/class-teststep.mdx "TestStep"
[EvaluationArgument]: /evaluating.mdx#evaluation-argument "EvaluationArgument"
[UIEvent.detail]: https://developer.mozilla.org/en-US/docs/Web/API/UIEvent/detail "UIEvent.detail"


[all available image tags]: https://mcr.microsoft.com/en-us/product/playwright/about "all available image tags"
[Microsoft Artifact Registry]: https://mcr.microsoft.com/en-us/product/playwright/about "Microsoft Artifact Registry"
[Dockerfile.noble]: https://github.com/microsoft/playwright/blob/main/utils/docker/Dockerfile.noble "Dockerfile.noble"

```dart
Future<void> setFiles(List<String> files,
```

## `SelectOption`

```dart
class SelectOption
```

## `InputFile`

```dart
class InputFile
```

## `JSHandle`

A handle to a JavaScript value in the browser page.

The optional type parameter [T] mirrors the TypeScript SDK's
`JSHandle<T = any>` generic.  It acts as a phantom type that carries
information about the underlying JS value without impacting runtime
behaviour.

When [T] is [Node] or a subtype (e.g. [Element]) the handle wraps a DOM
node, and [asElement] will return a non-null [ElementHandle].

```dart
// Untyped handle (equivalent to JSHandle<any>):
final handle = await page.evaluateHandle('() => window');

// Typed as an Element handle:
final JSHandle<Element> el =
await frame.evaluateHandle('() => document.body');
final element = el.asElement(); // non-null because T <: Node
```

```dart
abstract interface class JSHandle<T extends Object?>
```

### `evaluate`

*⚙️ Method*

Returns the return value of [pageFunction].

This method passes this handle as the first argument to [pageFunction].

If [pageFunction] returns a Future, then `handle.evaluate` would wait for the future to complete and return its value.

**Usage**

```dart
final tweetHandle = await page.$('.tweet .retweets');
expect(await tweetHandle.evaluate((node) => node.innerText)).toBe('10 retweets');
```

**Arguments**
- `pageFunction` Function | String

Function to be evaluated in the page context.
- `arg` dynamic *(optional)*

Optional argument to pass to [pageFunction].

**Returns**
- Future&lt;[Serializable]&gt;

```dart
Future<R> evaluate<R>(String expression, [Object? arg, bool? isFunction])
```

### `evaluateHandle`

*⚙️ Method*

Returns the return value of [pageFunction] as a [JSHandle].

This method passes this handle as the first argument to [pageFunction].

The only difference between `jsHandle.evaluate` and `jsHandle.evaluateHandle` is that `jsHandle.evaluateHandle` returns [JSHandle].

If the function passed to the `jsHandle.evaluateHandle` returns a Future, then `jsHandle.evaluateHandle` would wait for the future to complete and return its value.

See [page.evaluateHandle()] for more details.

**Usage**

```dart
await jsHandle.evaluateHandle(pageFunction);
await jsHandle.evaluateHandle(pageFunction, arg);
```

**Arguments**
- `pageFunction` Function | String

Function to be evaluated in the page context.
- `arg` dynamic *(optional)*

Optional argument to pass to [pageFunction].

**Returns**
- Future&lt;[JSHandle]&gt;

```dart
Future<JSHandle<Object?>> evaluateHandle( String expression, [ Object? arg, bool? isFunction, ])
```

### `getProperty`

*⚙️ Method*

Fetches a single property from the referenced object.

**Usage**

```dart
await jsHandle.getProperty(propertyName);
```

**Arguments**
- `propertyName` String

property to get

**Returns**
- Future&lt;[JSHandle]&gt;

```dart
Future<JSHandle<Object?>> getProperty(String name)
```

### `getProperties`

*⚙️ Method*

The method returns a map with **own property names** as keys and JSHandle instances for the property values.

**Usage**

```dart
final handle = await page.evaluateHandle(() => ( window, document ));
final properties = await handle.getProperties();
final windowHandle = properties.get('window');
final documentHandle = properties.get('document');
await handle.dispose();
```

**Returns**
- Future&lt;[Map]&lt;String, [JSHandle]&gt;&gt;

```dart
Future<Map<String, JSHandle<Object?>>> getProperties()
```

### `jsonValue`

*⚙️ Method*

Returns a JSON representation of the object. If the object has a `toJSON` function, it **will not be called**.

**NOTE**
The method will return an empty JSON object if the referenced object is not stringifiable. It will throw an error if the object has circular references.
**Usage**

```dart
await jsHandle.jsonValue();
```

**Returns**
- Future&lt;[Serializable]&gt;


[APIRequest]: /api/class-apirequest.mdx "APIRequest"
[APIRequestContext]: /api/class-apirequestcontext.mdx "APIRequestContext"
[APIResponse]: /api/class-apiresponse.mdx "APIResponse"
[APIResponseAssertions]: /api/class-apiresponseassertions.mdx "APIResponseAssertions"
[Browser]: /api/class-browser.mdx "Browser"
[BrowserContext]: /api/class-browsercontext.mdx "BrowserContext"
[BrowserServer]: /api/class-browserserver.mdx "BrowserServer"
[BrowserType]: /api/class-browsertype.mdx "BrowserType"
[CDPSession]: /api/class-cdpsession.mdx "CDPSession"
[Clock]: /api/class-clock.mdx "Clock"
[ConsoleMessage]: /api/class-consolemessage.mdx "ConsoleMessage"
[Coverage]: /api/class-coverage.mdx "Coverage"
[Credentials]: /api/class-credentials.mdx "Credentials"
[Debugger]: /api/class-debugger.mdx "Debugger"
[Dialog]: /api/class-dialog.mdx "Dialog"
[Disposable]: /api/class-disposable.mdx "Disposable"
[Download]: /api/class-download.mdx "Download"
[ElementHandle]: /api/class-elementhandle.mdx "ElementHandle"
[FileChooser]: /api/class-filechooser.mdx "FileChooser"
[Frame]: /api/class-frame.mdx "Frame"
[FrameLocator]: /api/class-framelocator.mdx "FrameLocator"
[GenericAssertions]: /api/class-genericassertions.mdx "GenericAssertions"
[JSHandle]: /api/class-jshandle.mdx "JSHandle"
[Keyboard]: /api/class-keyboard.mdx "Keyboard"
[Locator]: /api/class-locator.mdx "Locator"
[LocatorAssertions]: /api/class-locatorassertions.mdx "LocatorAssertions"
[Logger]: /api/class-logger.mdx "Logger"
[Mouse]: /api/class-mouse.mdx "Mouse"
[Page]: /api/class-page.mdx "Page"
[PageAssertions]: /api/class-pageassertions.mdx "PageAssertions"
[Playwright]: /api/class-playwright.mdx "Playwright"
[PlaywrightAssertions]: /api/class-playwrightassertions.mdx "PlaywrightAssertions"
[Request]: /api/class-request.mdx "Request"
[Response]: /api/class-response.mdx "Response"
[Route]: /api/class-route.mdx "Route"
[Screencast]: /api/class-screencast.mdx "Screencast"
[Selectors]: /api/class-selectors.mdx "Selectors"
[SnapshotAssertions]: /api/class-snapshotassertions.mdx "SnapshotAssertions"
[TimeoutError]: /api/class-timeouterror.mdx "TimeoutError"
[Touchscreen]: /api/class-touchscreen.mdx "Touchscreen"
[Tracing]: /api/class-tracing.mdx "Tracing"
[Video]: /api/class-video.mdx "Video"
[WebError]: /api/class-weberror.mdx "WebError"
[WebSocket]: /api/class-websocket.mdx "WebSocket"
[WebSocketRoute]: /api/class-websocketroute.mdx "WebSocketRoute"
[WebStorage]: /api/class-webstorage.mdx "WebStorage"
[Worker]: /api/class-worker.mdx "Worker"
[Electron]: /api/class-electron.mdx "Electron"
[ElectronApplication]: /api/class-electronapplication.mdx "ElectronApplication"
[Android]: /api/class-android.mdx "Android"
[AndroidDevice]: /api/class-androiddevice.mdx "AndroidDevice"
[AndroidInput]: /api/class-androidinput.mdx "AndroidInput"
[AndroidSocket]: /api/class-androidsocket.mdx "AndroidSocket"
[AndroidWebView]: /api/class-androidwebview.mdx "AndroidWebView"
[Fixtures]: /api/class-fixtures.mdx "Fixtures"
[FullConfig]: /api/class-fullconfig.mdx "FullConfig"
[FullProject]: /api/class-fullproject.mdx "FullProject"
[Location]: /api/class-location.mdx "Location"
[Test]: /api/class-test.mdx "Test"
[TestConfig]: /api/class-testconfig.mdx "TestConfig"
[TestInfo]: /api/class-testinfo.mdx "TestInfo"
[TestInfoError]: /api/class-testinfoerror.mdx "TestInfoError"
[TestOptions]: /api/class-testoptions.mdx "TestOptions"
[TestProject]: /api/class-testproject.mdx "TestProject"
[TestStepInfo]: /api/class-teststepinfo.mdx "TestStepInfo"
[WorkerInfo]: /api/class-workerinfo.mdx "WorkerInfo"
[Reporter]: /api/class-reporter.mdx "Reporter"
[Suite]: /api/class-suite.mdx "Suite"
[TestCase]: /api/class-testcase.mdx "TestCase"
[TestError]: /api/class-testerror.mdx "TestError"
[TestResult]: /api/class-testresult.mdx "TestResult"
[TestStep]: /api/class-teststep.mdx "TestStep"
[EvaluationArgument]: /evaluating.mdx#evaluation-argument "EvaluationArgument"
[UIEvent.detail]: https://developer.mozilla.org/en-US/docs/Web/API/UIEvent/detail "UIEvent.detail"


[all available image tags]: https://mcr.microsoft.com/en-us/product/playwright/about "all available image tags"
[Microsoft Artifact Registry]: https://mcr.microsoft.com/en-us/product/playwright/about "Microsoft Artifact Registry"
[Dockerfile.noble]: https://github.com/microsoft/playwright/blob/main/utils/docker/Dockerfile.noble "Dockerfile.noble"

```dart
Future<dynamic> jsonValue()
```

### `asElement`

*⚙️ Method*

Returns either `null` or the object handle itself, if the object handle is an instance of [ElementHandle].

**Usage**

```dart
jsHandle.asElement();
```

**Returns**
- [ElementHandle]?

```dart
ElementHandle<Node>? asElement()
```

### `dispose`

*⚙️ Method*

The `jsHandle.dispose` method stops referencing the element handle.

**Usage**

```dart
await jsHandle.dispose();
```

**Returns**
- Future&lt;void&gt;

```dart
Future<void> dispose()
```

## `Keyboard`

```dart
class Keyboard
```

### `down`

*⚙️ Method*

Dispatches a `keydown` event.

[key] can specify the intended [keyboardEvent.key] value or a single character to generate the text for. A superset of the [key] values can be found [here]. Examples of the keys are:

`F1` - `F12`, `Digit0`- `Digit9`, `KeyA`- `KeyZ`, `Backquote`, `Minus`, `Equal`, `Backslash`, `Backspace`, `Tab`, `Delete`, `Escape`, `ArrowDown`, `End`, `Enter`, `Home`, `Insert`, `PageDown`, `PageUp`, `ArrowRight`, `ArrowUp`, etc.

Following modification shortcuts are also supported: `Shift`, `Control`, `Alt`, `Meta`, `ShiftLeft`, `ControlOrMeta`. `ControlOrMeta` resolves to `Control` on Windows and Linux and to `Meta` on macOS.

Holding down `Shift` will type the text that corresponds to the [key] in the upper case.

If [key] is a single character, it is case-sensitive, so the values `a` and `A` will generate different respective texts.

If [key] is a modifier key, `Shift`, `Meta`, `Control`, or `Alt`, subsequent key presses will be sent with that modifier active. To release the modifier key, use [keyboard.up()].

After the key is pressed once, subsequent calls to [keyboard.down()] will have [repeat] set to true. To release the key, use [keyboard.up()].

**NOTE**
Modifier keys DO influence `keyboard.down`. Holding down `Shift` will type the text in upper case.
**Usage**

```dart
await keyboard.down(key);
```

**Arguments**
- `key` String

Name of the key to press or a character to generate, such as `ArrowLeft` or `a`.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> down(String key) async
```

### `downKey`

*⚙️ Method*

Typesafe version of [down] that accepts a [KeyboardKey] enum.

```dart
Future<void> downKey(KeyboardKey key) async
```

### `down`

*⚙️ Method*

Dispatches a `keydown` event.

[key] can specify the intended [keyboardEvent.key] value or a single character to generate the text for. A superset of the [key] values can be found [here]. Examples of the keys are:

`F1` - `F12`, `Digit0`- `Digit9`, `KeyA`- `KeyZ`, `Backquote`, `Minus`, `Equal`, `Backslash`, `Backspace`, `Tab`, `Delete`, `Escape`, `ArrowDown`, `End`, `Enter`, `Home`, `Insert`, `PageDown`, `PageUp`, `ArrowRight`, `ArrowUp`, etc.

Following modification shortcuts are also supported: `Shift`, `Control`, `Alt`, `Meta`, `ShiftLeft`, `ControlOrMeta`. `ControlOrMeta` resolves to `Control` on Windows and Linux and to `Meta` on macOS.

Holding down `Shift` will type the text that corresponds to the [key] in the upper case.

If [key] is a single character, it is case-sensitive, so the values `a` and `A` will generate different respective texts.

If [key] is a modifier key, `Shift`, `Meta`, `Control`, or `Alt`, subsequent key presses will be sent with that modifier active. To release the modifier key, use [keyboard.up()].

After the key is pressed once, subsequent calls to [keyboard.down()] will have [repeat] set to true. To release the key, use [keyboard.up()].

**NOTE**
Modifier keys DO influence `keyboard.down`. Holding down `Shift` will type the text in upper case.
**Usage**

```dart
await keyboard.down(key);
```

**Arguments**
- `key` String

Name of the key to press or a character to generate, such as `ArrowLeft` or `a`.

**Returns**
- Future&lt;void&gt;

```dart
await down(key.value)
```

### `up`

*⚙️ Method*

Dispatches a `keyup` event.

**Usage**

```dart
await keyboard.up(key);
```

**Arguments**
- `key` String

Name of the key to press or a character to generate, such as `ArrowLeft` or `a`.

**Returns**
- Future&lt;void&gt;


[APIRequest]: /api/class-apirequest.mdx "APIRequest"
[APIRequestContext]: /api/class-apirequestcontext.mdx "APIRequestContext"
[APIResponse]: /api/class-apiresponse.mdx "APIResponse"
[APIResponseAssertions]: /api/class-apiresponseassertions.mdx "APIResponseAssertions"
[Browser]: /api/class-browser.mdx "Browser"
[BrowserContext]: /api/class-browsercontext.mdx "BrowserContext"
[BrowserServer]: /api/class-browserserver.mdx "BrowserServer"
[BrowserType]: /api/class-browsertype.mdx "BrowserType"
[CDPSession]: /api/class-cdpsession.mdx "CDPSession"
[Clock]: /api/class-clock.mdx "Clock"
[ConsoleMessage]: /api/class-consolemessage.mdx "ConsoleMessage"
[Coverage]: /api/class-coverage.mdx "Coverage"
[Credentials]: /api/class-credentials.mdx "Credentials"
[Debugger]: /api/class-debugger.mdx "Debugger"
[Dialog]: /api/class-dialog.mdx "Dialog"
[Disposable]: /api/class-disposable.mdx "Disposable"
[Download]: /api/class-download.mdx "Download"
[ElementHandle]: /api/class-elementhandle.mdx "ElementHandle"
[FileChooser]: /api/class-filechooser.mdx "FileChooser"
[Frame]: /api/class-frame.mdx "Frame"
[FrameLocator]: /api/class-framelocator.mdx "FrameLocator"
[GenericAssertions]: /api/class-genericassertions.mdx "GenericAssertions"
[JSHandle]: /api/class-jshandle.mdx "JSHandle"
[Keyboard]: /api/class-keyboard.mdx "Keyboard"
[Locator]: /api/class-locator.mdx "Locator"
[LocatorAssertions]: /api/class-locatorassertions.mdx "LocatorAssertions"
[Logger]: /api/class-logger.mdx "Logger"
[Mouse]: /api/class-mouse.mdx "Mouse"
[Page]: /api/class-page.mdx "Page"
[PageAssertions]: /api/class-pageassertions.mdx "PageAssertions"
[Playwright]: /api/class-playwright.mdx "Playwright"
[PlaywrightAssertions]: /api/class-playwrightassertions.mdx "PlaywrightAssertions"
[Request]: /api/class-request.mdx "Request"
[Response]: /api/class-response.mdx "Response"
[Route]: /api/class-route.mdx "Route"
[Screencast]: /api/class-screencast.mdx "Screencast"
[Selectors]: /api/class-selectors.mdx "Selectors"
[SnapshotAssertions]: /api/class-snapshotassertions.mdx "SnapshotAssertions"
[TimeoutError]: /api/class-timeouterror.mdx "TimeoutError"
[Touchscreen]: /api/class-touchscreen.mdx "Touchscreen"
[Tracing]: /api/class-tracing.mdx "Tracing"
[Video]: /api/class-video.mdx "Video"
[WebError]: /api/class-weberror.mdx "WebError"
[WebSocket]: /api/class-websocket.mdx "WebSocket"
[WebSocketRoute]: /api/class-websocketroute.mdx "WebSocketRoute"
[WebStorage]: /api/class-webstorage.mdx "WebStorage"
[Worker]: /api/class-worker.mdx "Worker"
[Electron]: /api/class-electron.mdx "Electron"
[ElectronApplication]: /api/class-electronapplication.mdx "ElectronApplication"
[Android]: /api/class-android.mdx "Android"
[AndroidDevice]: /api/class-androiddevice.mdx "AndroidDevice"
[AndroidInput]: /api/class-androidinput.mdx "AndroidInput"
[AndroidSocket]: /api/class-androidsocket.mdx "AndroidSocket"
[AndroidWebView]: /api/class-androidwebview.mdx "AndroidWebView"
[Fixtures]: /api/class-fixtures.mdx "Fixtures"
[FullConfig]: /api/class-fullconfig.mdx "FullConfig"
[FullProject]: /api/class-fullproject.mdx "FullProject"
[Location]: /api/class-location.mdx "Location"
[Test]: /api/class-test.mdx "Test"
[TestConfig]: /api/class-testconfig.mdx "TestConfig"
[TestInfo]: /api/class-testinfo.mdx "TestInfo"
[TestInfoError]: /api/class-testinfoerror.mdx "TestInfoError"
[TestOptions]: /api/class-testoptions.mdx "TestOptions"
[TestProject]: /api/class-testproject.mdx "TestProject"
[TestStepInfo]: /api/class-teststepinfo.mdx "TestStepInfo"
[WorkerInfo]: /api/class-workerinfo.mdx "WorkerInfo"
[Reporter]: /api/class-reporter.mdx "Reporter"
[Suite]: /api/class-suite.mdx "Suite"
[TestCase]: /api/class-testcase.mdx "TestCase"
[TestError]: /api/class-testerror.mdx "TestError"
[TestResult]: /api/class-testresult.mdx "TestResult"
[TestStep]: /api/class-teststep.mdx "TestStep"
[EvaluationArgument]: /evaluating.mdx#evaluation-argument "EvaluationArgument"
[UIEvent.detail]: https://developer.mozilla.org/en-US/docs/Web/API/UIEvent/detail "UIEvent.detail"


[all available image tags]: https://mcr.microsoft.com/en-us/product/playwright/about "all available image tags"
[Microsoft Artifact Registry]: https://mcr.microsoft.com/en-us/product/playwright/about "Microsoft Artifact Registry"
[Dockerfile.noble]: https://github.com/microsoft/playwright/blob/main/utils/docker/Dockerfile.noble "Dockerfile.noble"

```dart
Future<void> up(String key) async
```

### `upKey`

*⚙️ Method*

Typesafe version of [up] that accepts a [KeyboardKey] enum.

```dart
Future<void> upKey(KeyboardKey key) async
```

### `up`

*⚙️ Method*

Dispatches a `keyup` event.

**Usage**

```dart
await keyboard.up(key);
```

**Arguments**
- `key` String

Name of the key to press or a character to generate, such as `ArrowLeft` or `a`.

**Returns**
- Future&lt;void&gt;


[APIRequest]: /api/class-apirequest.mdx "APIRequest"
[APIRequestContext]: /api/class-apirequestcontext.mdx "APIRequestContext"
[APIResponse]: /api/class-apiresponse.mdx "APIResponse"
[APIResponseAssertions]: /api/class-apiresponseassertions.mdx "APIResponseAssertions"
[Browser]: /api/class-browser.mdx "Browser"
[BrowserContext]: /api/class-browsercontext.mdx "BrowserContext"
[BrowserServer]: /api/class-browserserver.mdx "BrowserServer"
[BrowserType]: /api/class-browsertype.mdx "BrowserType"
[CDPSession]: /api/class-cdpsession.mdx "CDPSession"
[Clock]: /api/class-clock.mdx "Clock"
[ConsoleMessage]: /api/class-consolemessage.mdx "ConsoleMessage"
[Coverage]: /api/class-coverage.mdx "Coverage"
[Credentials]: /api/class-credentials.mdx "Credentials"
[Debugger]: /api/class-debugger.mdx "Debugger"
[Dialog]: /api/class-dialog.mdx "Dialog"
[Disposable]: /api/class-disposable.mdx "Disposable"
[Download]: /api/class-download.mdx "Download"
[ElementHandle]: /api/class-elementhandle.mdx "ElementHandle"
[FileChooser]: /api/class-filechooser.mdx "FileChooser"
[Frame]: /api/class-frame.mdx "Frame"
[FrameLocator]: /api/class-framelocator.mdx "FrameLocator"
[GenericAssertions]: /api/class-genericassertions.mdx "GenericAssertions"
[JSHandle]: /api/class-jshandle.mdx "JSHandle"
[Keyboard]: /api/class-keyboard.mdx "Keyboard"
[Locator]: /api/class-locator.mdx "Locator"
[LocatorAssertions]: /api/class-locatorassertions.mdx "LocatorAssertions"
[Logger]: /api/class-logger.mdx "Logger"
[Mouse]: /api/class-mouse.mdx "Mouse"
[Page]: /api/class-page.mdx "Page"
[PageAssertions]: /api/class-pageassertions.mdx "PageAssertions"
[Playwright]: /api/class-playwright.mdx "Playwright"
[PlaywrightAssertions]: /api/class-playwrightassertions.mdx "PlaywrightAssertions"
[Request]: /api/class-request.mdx "Request"
[Response]: /api/class-response.mdx "Response"
[Route]: /api/class-route.mdx "Route"
[Screencast]: /api/class-screencast.mdx "Screencast"
[Selectors]: /api/class-selectors.mdx "Selectors"
[SnapshotAssertions]: /api/class-snapshotassertions.mdx "SnapshotAssertions"
[TimeoutError]: /api/class-timeouterror.mdx "TimeoutError"
[Touchscreen]: /api/class-touchscreen.mdx "Touchscreen"
[Tracing]: /api/class-tracing.mdx "Tracing"
[Video]: /api/class-video.mdx "Video"
[WebError]: /api/class-weberror.mdx "WebError"
[WebSocket]: /api/class-websocket.mdx "WebSocket"
[WebSocketRoute]: /api/class-websocketroute.mdx "WebSocketRoute"
[WebStorage]: /api/class-webstorage.mdx "WebStorage"
[Worker]: /api/class-worker.mdx "Worker"
[Electron]: /api/class-electron.mdx "Electron"
[ElectronApplication]: /api/class-electronapplication.mdx "ElectronApplication"
[Android]: /api/class-android.mdx "Android"
[AndroidDevice]: /api/class-androiddevice.mdx "AndroidDevice"
[AndroidInput]: /api/class-androidinput.mdx "AndroidInput"
[AndroidSocket]: /api/class-androidsocket.mdx "AndroidSocket"
[AndroidWebView]: /api/class-androidwebview.mdx "AndroidWebView"
[Fixtures]: /api/class-fixtures.mdx "Fixtures"
[FullConfig]: /api/class-fullconfig.mdx "FullConfig"
[FullProject]: /api/class-fullproject.mdx "FullProject"
[Location]: /api/class-location.mdx "Location"
[Test]: /api/class-test.mdx "Test"
[TestConfig]: /api/class-testconfig.mdx "TestConfig"
[TestInfo]: /api/class-testinfo.mdx "TestInfo"
[TestInfoError]: /api/class-testinfoerror.mdx "TestInfoError"
[TestOptions]: /api/class-testoptions.mdx "TestOptions"
[TestProject]: /api/class-testproject.mdx "TestProject"
[TestStepInfo]: /api/class-teststepinfo.mdx "TestStepInfo"
[WorkerInfo]: /api/class-workerinfo.mdx "WorkerInfo"
[Reporter]: /api/class-reporter.mdx "Reporter"
[Suite]: /api/class-suite.mdx "Suite"
[TestCase]: /api/class-testcase.mdx "TestCase"
[TestError]: /api/class-testerror.mdx "TestError"
[TestResult]: /api/class-testresult.mdx "TestResult"
[TestStep]: /api/class-teststep.mdx "TestStep"
[EvaluationArgument]: /evaluating.mdx#evaluation-argument "EvaluationArgument"
[UIEvent.detail]: https://developer.mozilla.org/en-US/docs/Web/API/UIEvent/detail "UIEvent.detail"


[all available image tags]: https://mcr.microsoft.com/en-us/product/playwright/about "all available image tags"
[Microsoft Artifact Registry]: https://mcr.microsoft.com/en-us/product/playwright/about "Microsoft Artifact Registry"
[Dockerfile.noble]: https://github.com/microsoft/playwright/blob/main/utils/docker/Dockerfile.noble "Dockerfile.noble"

```dart
await up(key.value)
```

### `insertText`

*⚙️ Method*

Dispatches only `input` event, does not emit the `keydown`, `keyup` or `keypress` events.

**Usage**

```dart
page.keyboard.insertText('嗨');
```

**NOTE**
Modifier keys DO NOT effect `keyboard.insertText`. Holding down `Shift` will not type the text in upper case.
**Arguments**
- `text` String

Sets input to the specified text value.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> insertText(String text) async
```

### `type`

*⚙️ Method*

In most cases, you should use [locator.fill()] instead. You only need to press keys one by one if there is special keyboard handling on the page - in this case use [locator.pressSequentially()].
Sends a `keydown`, `keypress`/`input`, and `keyup` event for each character in the text.

To press a special key, like `Control` or `ArrowDown`, use [keyboard.press()].

**Usage**

```dart
await page.keyboard.type('Hello'); // Types instantly
await page.keyboard.type('World', { delay: 100 ); // Types slower, like a user
```

**NOTE**
Modifier keys DO NOT effect `keyboard.type`. Holding down `Shift` will not type the text in upper case.
**NOTE**
For characters that are not on a US keyboard, only an `input` event will be sent.
**Arguments**
- `text` String

A text to type into a focused element.
- `options` Map *(optional)*
- `delay` double *(optional)*

Time to wait between key presses in milliseconds. Defaults to 0.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> type(String text,
```

### `press`

*⚙️ Method*

In most cases, you should use [locator.press()] instead.
[key] can specify the intended [keyboardEvent.key] value or a single character to generate the text for. A superset of the [key] values can be found [here]. Examples of the keys are:

`F1` - `F12`, `Digit0`- `Digit9`, `KeyA`- `KeyZ`, `Backquote`, `Minus`, `Equal`, `Backslash`, `Backspace`, `Tab`, `Delete`, `Escape`, `ArrowDown`, `End`, `Enter`, `Home`, `Insert`, `PageDown`, `PageUp`, `ArrowRight`, `ArrowUp`, etc.

Following modification shortcuts are also supported: `Shift`, `Control`, `Alt`, `Meta`, `ShiftLeft`, `ControlOrMeta`. `ControlOrMeta` resolves to `Control` on Windows and Linux and to `Meta` on macOS.

Holding down `Shift` will type the text that corresponds to the [key] in the upper case.

If [key] is a single character, it is case-sensitive, so the values `a` and `A` will generate different respective texts.

Shortcuts such as `key: "Control+o"`, `key: "Control++` or `key: "Control+Shift+T"` are supported as well. When specified with the modifier, modifier is pressed and being held while the subsequent key is being pressed.

**Usage**

```dart
final page = await browser.newPage();
await page.goto('https://keycode.info');
await page.keyboard.press('A');
await page.screenshot( path: 'A.png' );
await page.keyboard.press('ArrowLeft');
await page.screenshot( path: 'ArrowLeft.png' );
await page.keyboard.press('Shift+O');
await page.screenshot( path: 'O.png' );
await browser.close();
```

Shortcut for [keyboard.down()] and [keyboard.up()].

**Arguments**
- `key` String

Name of the key to press or a character to generate, such as `ArrowLeft` or `a`.
- `options` Map *(optional)*
- `delay` double *(optional)*

Time to wait between `keydown` and `keyup` in milliseconds. Defaults to 0.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> press(String key,
```

### `pressKey`

*⚙️ Method*

Typesafe version of [press] that accepts a [KeyboardKey] enum.

```dart
Future<void> pressKey(KeyboardKey key,
```

### `press`

*⚙️ Method*

In most cases, you should use [locator.press()] instead.
[key] can specify the intended [keyboardEvent.key] value or a single character to generate the text for. A superset of the [key] values can be found [here]. Examples of the keys are:

`F1` - `F12`, `Digit0`- `Digit9`, `KeyA`- `KeyZ`, `Backquote`, `Minus`, `Equal`, `Backslash`, `Backspace`, `Tab`, `Delete`, `Escape`, `ArrowDown`, `End`, `Enter`, `Home`, `Insert`, `PageDown`, `PageUp`, `ArrowRight`, `ArrowUp`, etc.

Following modification shortcuts are also supported: `Shift`, `Control`, `Alt`, `Meta`, `ShiftLeft`, `ControlOrMeta`. `ControlOrMeta` resolves to `Control` on Windows and Linux and to `Meta` on macOS.

Holding down `Shift` will type the text that corresponds to the [key] in the upper case.

If [key] is a single character, it is case-sensitive, so the values `a` and `A` will generate different respective texts.

Shortcuts such as `key: "Control+o"`, `key: "Control++` or `key: "Control+Shift+T"` are supported as well. When specified with the modifier, modifier is pressed and being held while the subsequent key is being pressed.

**Usage**

```dart
final page = await browser.newPage();
await page.goto('https://keycode.info');
await page.keyboard.press('A');
await page.screenshot( path: 'A.png' );
await page.keyboard.press('ArrowLeft');
await page.screenshot( path: 'ArrowLeft.png' );
await page.keyboard.press('Shift+O');
await page.screenshot( path: 'O.png' );
await browser.close();
```

Shortcut for [keyboard.down()] and [keyboard.up()].

**Arguments**
- `key` String

Name of the key to press or a character to generate, such as `ArrowLeft` or `a`.
- `options` Map *(optional)*
- `delay` delay: *(optional)*

Time to wait between `keydown` and `keyup` in milliseconds. Defaults to 0.

**Returns**
- Future&lt;void&gt;

```dart
await press(key.value, delay: delay)
```

### `enter`

*⚙️ Method*

Presses the Enter key.

```dart
Future<void> enter(
```

### `escape`

*⚙️ Method*

Presses the Escape key.

```dart
Future<void> escape(
```

### `backspace`

*⚙️ Method*

Presses the Backspace key.

```dart
Future<void> backspace(
```

### `tab`

*⚙️ Method*

Presses the Tab key.

```dart
Future<void> tab(
```

### `delete`

*⚙️ Method*

Presses the Delete key.

```dart
Future<void> delete(
```

### `space`

*⚙️ Method*

Presses the Space key.

```dart
Future<void> space(
```

### `arrowUp`

*⚙️ Method*

Presses the Up arrow key.

```dart
Future<void> arrowUp(
```

### `arrowDown`

*⚙️ Method*

Presses the Down arrow key.

```dart
Future<void> arrowDown(
```

### `arrowLeft`

*⚙️ Method*

Presses the Left arrow key.

```dart
Future<void> arrowLeft(
```

### `arrowRight`

*⚙️ Method*

Presses the Right arrow key.

```dart
Future<void> arrowRight(
```

## `LocatorAssertions`

```dart
class LocatorAssertions
```

### `toBeVisible`

*⚙️ Method*

Ensures that [Locator] points to an attached and [visible] DOM node.

To check that at least one element from the list is visible, use [locator.first()].

**Usage**

```dart
// A specific element is visible.
await expect(page.getByText('Welcome')).toBeVisible();

// At least one item in the list is visible.
await expect(page.getByTestId('todo-item').first()).toBeVisible();

// At least one of the two elements is visible, possibly both.
await expect(
page.getByRole('button', { name: 'Sign in' )
.or(page.getByRole('button', { name: 'Sign up' ))
.first()
).toBeVisible();
```

**Arguments**
- `options` Map *(optional)*
- `timeout` double *(optional)*

Time to retry the assertion for in milliseconds. Defaults to `timeout` in `TestConfig.expect`.
- `visible` bool *(optional)*

**Returns**
- Future&lt;void&gt;

```dart
Future<void> toBeVisible(
```

### `toBeHidden`

*⚙️ Method*

Ensures that [Locator] either does not resolve to any DOM node, or resolves to a [non-visible] one.

**Usage**

```dart
final locator = page.locator('.my-element');
await expect(locator).toBeHidden();
```

**Arguments**
- `options` Map *(optional)*
- `timeout` double *(optional)*

Time to retry the assertion for in milliseconds. Defaults to `timeout` in `TestConfig.expect`.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> toBeHidden(
```

### `toHaveText`

*⚙️ Method*

Ensures the [Locator] points to an element with the given text. All nested elements will be considered when computing the text content of the element. You can use regular expressions for the value as well.

**Usage**

```dart
final locator = page.locator('.title');
await expect(locator).toHaveText(/Welcome, Test User/);
await expect(locator).toHaveText(/Welcome, .*/);
```

If you pass an array as an expected value, the expectations are:
1. Locator resolves to a list of elements.
1. The number of elements equals the number of expected values in the array.
1. Elements from the list have text matching expected array values, one by one, in order.

For example, consider the following list:

```html
<ul>
<li>Text 1</li>
<li>Text 2</li>
<li>Text 3</li>
</ul>
```

Let's see how we can use the assertion:

```dart
// ✓ Has the right items in the right order
await expect(page.locator('ul > li')).toHaveText(['Text 1', 'Text 2', 'Text 3']);

// ✖ Wrong order
await expect(page.locator('ul > li')).toHaveText(['Text 3', 'Text 2', 'Text 1']);

// ✖ Last item does not match
await expect(page.locator('ul > li')).toHaveText(['Text 1', 'Text 2', 'Text']);

// ✖ Locator points to the outer list element, not to the list items
await expect(page.locator('ul')).toHaveText(['Text 1', 'Text 2', 'Text 3']);
```

**Arguments**
- `expected` String

Expected string or RegExp or a list of those.
- `options` Map *(optional)*
- `ignoreCase` bool *(optional)*

Whether to perform case-insensitive match. [ignoreCase] option takes precedence over the corresponding regular expression flag if specified.
- `timeout` double *(optional)*

Time to retry the assertion for in milliseconds. Defaults to `timeout` in `TestConfig.expect`.
- `useInnerText` bool *(optional)*

Whether to use `element.innerText` instead of `element.textContent` when retrieving DOM node text.

**Returns**
- Future&lt;void&gt;

**Details**

When `expected` parameter is a string, Playwright will normalize whitespaces and line breaks both in the actual text and in the expected string before matching. When regular expression is used, the actual text is matched as is.

```dart
Future<void> toHaveText( String expected,
```

### `toContainText`

*⚙️ Method*

Ensures the [Locator] points to an element that contains the given text. All nested elements will be considered when computing the text content of the element. You can use regular expressions for the value as well.

**Usage**

```dart
final locator = page.locator('.title');
await expect(locator).toContainText('substring');
await expect(locator).toContainText(/\d messages/);
```

If you pass an array as an expected value, the expectations are:
1. Locator resolves to a list of elements.
1. Elements from a **subset** of this list contain text from the expected array, respectively.
1. The matching subset of elements has the same order as the expected array.
1. Each text value from the expected array is matched by some element from the list.

For example, consider the following list:

```html
<ul>
<li>Item Text 1</li>
<li>Item Text 2</li>
<li>Item Text 3</li>
</ul>
```

Let's see how we can use the assertion:

```dart
// ✓ Contains the right items in the right order
await expect(page.locator('ul > li')).toContainText(['Text 1', 'Text 3']);

// ✖ Wrong order
await expect(page.locator('ul > li')).toContainText(['Text 3', 'Text 2']);

// ✖ No item contains this text
await expect(page.locator('ul > li')).toContainText(['Some 33']);

// ✖ Locator points to the outer list element, not to the list items
await expect(page.locator('ul')).toContainText(['Text 3']);
```

**Arguments**
- `expected` String

Expected substring or RegExp or a list of those.
- `options` Map *(optional)*
- `ignoreCase` bool *(optional)*

Whether to perform case-insensitive match. [ignoreCase] option takes precedence over the corresponding regular expression flag if specified.
- `timeout` double *(optional)*

Time to retry the assertion for in milliseconds. Defaults to `timeout` in `TestConfig.expect`.
- `useInnerText` bool *(optional)*

Whether to use `element.innerText` instead of `element.textContent` when retrieving DOM node text.

**Returns**
- Future&lt;void&gt;

**Details**

When `expected` parameter is a string, Playwright will normalize whitespaces and line breaks both in the actual text and in the expected string before matching. When regular expression is used, the actual text is matched as is.

```dart
Future<void> toContainText( String expected,
```

### `toBeEnabled`

*⚙️ Method*

Ensures the [Locator] points to an enabled element.

**Usage**

```dart
final locator = page.locator('button.submit');
await expect(locator).toBeEnabled();
```

**Arguments**
- `options` Map *(optional)*
- `enabled` bool *(optional)*
- `timeout` double *(optional)*

Time to retry the assertion for in milliseconds. Defaults to `timeout` in `TestConfig.expect`.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> toBeEnabled(
```

### `toBeDisabled`

*⚙️ Method*

Ensures the [Locator] points to a disabled element. Element is disabled if it has "disabled" attribute or is disabled via ['aria-disabled']. Note that only native control elements such as HTML `button`, `input`, `select`, `textarea`, `option`, `optgroup` can be disabled by setting "disabled" attribute. "disabled" attribute on other elements is ignored by the browser.

**Usage**

```dart
final locator = page.locator('button.submit');
await expect(locator).toBeDisabled();
```

**Arguments**
- `options` Map *(optional)*
- `timeout` double *(optional)*

Time to retry the assertion for in milliseconds. Defaults to `timeout` in `TestConfig.expect`.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> toBeDisabled(
```

### `toHaveAttribute`

*⚙️ Method*

Ensures the [Locator] points to an element with given attribute. The method will assert attribute presence.

```dart
final locator = page.locator('input');
// Assert attribute existence.
await expect(locator).toHaveAttribute('disabled');
await expect(locator).not.toHaveAttribute('open');
```

**Usage**

```dart
await expect(locator).toHaveAttribute(name);
await expect(locator).toHaveAttribute(name, options);
```

**Arguments**
- `name` String

Attribute name.
- `options` Map *(optional)*
- `timeout` double *(optional)*

Time to retry the assertion for in milliseconds. Defaults to `timeout` in `TestConfig.expect`.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> toHaveAttribute( String name, String value,
```

### `toHaveClass`

*⚙️ Method*

Ensures the [Locator] points to an element with given CSS classes. When a string is provided, it must fully match the element's `class` attribute. To match individual classes use [expect(locator).toContainClass()].

**Usage**

```html
<div class='middle selected row' id='component'></div>
```

```dart
final locator = page.locator('#component');
await expect(locator).toHaveClass('middle selected row');
await expect(locator).toHaveClass(/(^|\s)selected(\s|$)/);
```

When an array is passed, the method asserts that the list of elements located matches the corresponding list of expected class values. Each element's class attribute is matched against the corresponding string or regular expression in the array:

```dart
final locator = page.locator('.list > .component');
await expect(locator).toHaveClass(['component', 'component selected', 'component']);
```

**Arguments**
- `expected` String

Expected class or RegExp or a list of those.
- `options` Map *(optional)*
- `timeout` double *(optional)*

Time to retry the assertion for in milliseconds. Defaults to `timeout` in `TestConfig.expect`.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> toHaveClass(String expected,
```

### `toHaveId`

*⚙️ Method*

Ensures the [Locator] points to an element with the given DOM Node ID.

**Usage**

```dart
final locator = page.getByRole('textbox');
await expect(locator).toHaveId('lastname');
```

**Arguments**
- `id` String | [RegExp]

Element id.
- `options` Map *(optional)*
- `timeout` double *(optional)*

Time to retry the assertion for in milliseconds. Defaults to `timeout` in `TestConfig.expect`.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> toHaveId(String expected,
```

### `toHaveValue`

*⚙️ Method*

Ensures the [Locator] points to an element with the given input value. You can use regular expressions for the value as well.

**Usage**

```dart
final locator = page.locator('input[type=number]');
await expect(locator).toHaveValue(/[0-9]/);
```

**Arguments**
- `value` String | [RegExp]

Expected value.
- `options` Map *(optional)*
- `timeout` double *(optional)*

Time to retry the assertion for in milliseconds. Defaults to `timeout` in `TestConfig.expect`.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> toHaveValue(String expected,
```

### `toBeChecked`

*⚙️ Method*

Ensures the [Locator] points to a checked input.

**Usage**

```dart
final locator = page.getByLabel('Subscribe to newsletter');
await expect(locator).toBeChecked();
```

**Arguments**
- `options` Map *(optional)*
- `checked` bool *(optional)*

Provides state to assert for. Asserts for input to be checked by default. This option can't be used when [indeterminate] is set to true.
- `indeterminate` bool *(optional)*

Asserts that the element is in the indeterminate (mixed) state. Only supported for checkboxes and radio buttons. This option can't be true when [checked] is provided.
- `timeout` double *(optional)*

Time to retry the assertion for in milliseconds. Defaults to `timeout` in `TestConfig.expect`.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> toBeChecked(
```

### `toBeAttached`

*⚙️ Method*

Ensures that [Locator] points to an element that is [connected] to a Document or a ShadowRoot.

**Usage**

```dart
await expect(page.getByText('Hidden text')).toBeAttached();
```

**Arguments**
- `options` Map *(optional)*
- `attached` bool *(optional)*
- `timeout` double *(optional)*

Time to retry the assertion for in milliseconds. Defaults to `timeout` in `TestConfig.expect`.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> toBeAttached(
```

### `toBeEditable`

*⚙️ Method*

Ensures the [Locator] points to an editable element.

**Usage**

```dart
final locator = page.getByRole('textbox');
await expect(locator).toBeEditable();
```

**Arguments**
- `options` Map *(optional)*
- `editable` bool *(optional)*
- `timeout` double *(optional)*

Time to retry the assertion for in milliseconds. Defaults to `timeout` in `TestConfig.expect`.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> toBeEditable(
```

### `toBeEmpty`

*⚙️ Method*

Ensures the [Locator] points to an empty editable element or to a DOM node that has no text.

**Usage**

```dart
final locator = page.locator('div.warning');
await expect(locator).toBeEmpty();
```

**Arguments**
- `options` Map *(optional)*
- `timeout` double *(optional)*

Time to retry the assertion for in milliseconds. Defaults to `timeout` in `TestConfig.expect`.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> toBeEmpty(
```

### `toBeFocused`

*⚙️ Method*

Ensures the [Locator] points to a focused DOM node.

**Usage**

```dart
final locator = page.getByRole('textbox');
await expect(locator).toBeFocused();
```

**Arguments**
- `options` Map *(optional)*
- `timeout` double *(optional)*

Time to retry the assertion for in milliseconds. Defaults to `timeout` in `TestConfig.expect`.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> toBeFocused(
```

### `toBeInViewport`

*⚙️ Method*

Ensures the [Locator] points to an element that intersects viewport, according to the [intersection observer API].

**Usage**

```dart
final locator = page.getByRole('button');
// Make sure at least some part of element intersects viewport.
await expect(locator).toBeInViewport();
// Make sure element is fully outside of viewport.
await expect(locator).not.toBeInViewport();
// Make sure that at least half of the element intersects viewport.
await expect(locator).toBeInViewport( ratio: 0.5 );
```

**Arguments**
- `options` Map *(optional)*
- `ratio` double *(optional)*

The minimal ratio of the element to intersect viewport. If equals to `0`, then element should intersect viewport at any positive ratio. Defaults to `0`.
- `timeout` double *(optional)*

Time to retry the assertion for in milliseconds. Defaults to `timeout` in `TestConfig.expect`.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> toBeInViewport(
```

### `toContainClass`

*⚙️ Method*

Ensures the [Locator] points to an element with given CSS classes. All classes from the asserted value, separated by spaces, must be present in the [Element.classList] in any order.

**Usage**

```html
<div class='middle selected row' id='component'></div>
```

```dart
final locator = page.locator('#component');
await expect(locator).toContainClass('middle selected row');
await expect(locator).toContainClass('selected');
await expect(locator).toContainClass('row middle');
```

When an array is passed, the method asserts that the list of elements located matches the corresponding list of expected class lists. Each element's class attribute is matched against the corresponding class in the array:

```html
<div class='list'>
<div class='component inactive'></div>
<div class='component active'></div>
<div class='component inactive'></div>
</div>
```

```dart
final locator = page.locator('.list > .component');
await expect(locator).toContainClass(['inactive', 'active', 'inactive']);
```

**Arguments**
- `expected` dynamic

A string containing expected class names, separated by spaces, or a list of such strings to assert multiple elements.
- `options` Map *(optional)*
- `timeout` double *(optional)*

Time to retry the assertion for in milliseconds. Defaults to `timeout` in `TestConfig.expect`.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> toContainClass(Object expected,
```

### `toHaveAccessibleDescription`

*⚙️ Method*

Ensures the [Locator] points to an element with a given [accessible description].

**Usage**

```dart
final locator = page.getByTestId('save-button');
await expect(locator).toHaveAccessibleDescription('Save results to disk');
```

**Arguments**
- `description` String

Expected accessible description.
- `options` Map *(optional)*
- `ignoreCase` bool *(optional)*

Whether to perform case-insensitive match. [ignoreCase] option takes precedence over the corresponding regular expression flag if specified.
- `timeout` double *(optional)*

Time to retry the assertion for in milliseconds. Defaults to `timeout` in `TestConfig.expect`.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> toHaveAccessibleDescription( String description,
```

### `toHaveAccessibleErrorMessage`

*⚙️ Method*

Ensures the [Locator] points to an element with a given [aria errormessage].

**Usage**

```dart
final locator = page.getByTestId('username-input');
await expect(locator).toHaveAccessibleErrorMessage('Username is required.');
```

**Arguments**
- `errorMessage` String | [RegExp]

Expected accessible error message.
- `options` Map *(optional)*
- `ignoreCase` bool *(optional)*

Whether to perform case-insensitive match. [ignoreCase] option takes precedence over the corresponding regular expression flag if specified.
- `timeout` double *(optional)*

Time to retry the assertion for in milliseconds. Defaults to `timeout` in `TestConfig.expect`.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> toHaveAccessibleErrorMessage( String message,
```

### `toHaveAccessibleName`

*⚙️ Method*

Ensures the [Locator] points to an element with a given [accessible name].

**Usage**

```dart
final locator = page.getByTestId('save-button');
await expect(locator).toHaveAccessibleName('Save to disk');
```

**Arguments**
- `name` String

Expected accessible name.
- `options` Map *(optional)*
- `ignoreCase` bool *(optional)*

Whether to perform case-insensitive match. [ignoreCase] option takes precedence over the corresponding regular expression flag if specified.
- `timeout` double *(optional)*

Time to retry the assertion for in milliseconds. Defaults to `timeout` in `TestConfig.expect`.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> toHaveAccessibleName( String name,
```

### `toHaveCSS`

*⚙️ Method*

Ensures the [Locator] resolves to an element with the given computed CSS style.

**Usage**

```dart
final locator = page.getByRole('button');
await expect(locator).toHaveCSS('display', 'flex');
```

**Arguments**
- `name` String

CSS property name.
- `value` String

CSS property value.
- `options` Map *(optional)*
- `pseudo` String *(optional)*

Pseudo-element to read computed styles from.
- `timeout` double *(optional)*

Time to retry the assertion for in milliseconds. Defaults to `timeout` in `TestConfig.expect`.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> toHaveCSS( String name, String value,
```

### `toHaveJSProperty`

*⚙️ Method*

Ensures the [Locator] points to an element with given JavaScript property. Note that this property can be of a primitive type as well as a plain serializable JavaScript object.

**Usage**

```dart
final locator = page.locator('.component');
await expect(locator).toHaveJSProperty('loaded', true);
```

**Arguments**
- `name` String

Property name.
- `value` dynamic

Property value.
- `options` Map *(optional)*
- `timeout` double *(optional)*

Time to retry the assertion for in milliseconds. Defaults to `timeout` in `TestConfig.expect`.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> toHaveJSProperty( String name, Object? value,
```

### `toHaveRole`

*⚙️ Method*

Ensures the [Locator] points to an element with a given [ARIA role].

Note that role is matched as a string, disregarding the ARIA role hierarchy. For example, asserting  a superclass role `"checkbox"` on an element with a subclass role `"switch"` will fail.

**Usage**

```dart
final locator = page.getByTestId('save-button');
await expect(locator).toHaveRole('button');
```

**Arguments**
- `role` String

Required aria role.
- `options` Map *(optional)*
- `timeout` double *(optional)*

Time to retry the assertion for in milliseconds. Defaults to `timeout` in `TestConfig.expect`.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> toHaveRole(String role,
```

### `toHaveValues`

*⚙️ Method*

Ensures the [Locator] points to multi-select/combobox (i.e. a `select` with the `multiple` attribute) and the specified values are selected.

**Usage**

For example, given the following element:

```html
<select id="favorite-colors" multiple>
<option value="R">Red</option>
<option value="G">Green</option>
<option value="B">Blue</option>
</select>
```

```dart
final locator = page.locator('id=favorite-colors');
await locator.selectOption(['R', 'G']);
await expect(locator).toHaveValues([/R/, /G/]);
```

**Arguments**
- `values` dynamic

Expected options currently selected.
- `options` Map *(optional)*
- `timeout` double *(optional)*

Time to retry the assertion for in milliseconds. Defaults to `timeout` in `TestConfig.expect`.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> toHaveValues(Object values,
```

### `toMatchAriaSnapshot`

*⚙️ Method*

Asserts that the target element matches the given [accessibility snapshot].

Snapshot is stored in a separate `.aria.yml` file in a location configured by `expect.toMatchAriaSnapshot.pathTemplate` and/or `snapshotPathTemplate` properties in the configuration file.

**Usage**

```dart
await expect(page.locator('body')).toMatchAriaSnapshot();
await expect(page.locator('body')).toMatchAriaSnapshot( name: 'body.aria.yml' );
```

**Arguments**
- `options` Map *(optional)*
- `name` String *(optional)*

Name of the snapshot to store in the snapshot folder corresponding to this test. Generates sequential names if not specified.
- `timeout` double *(optional)*

Time to retry the assertion for in milliseconds. Defaults to `timeout` in `TestConfig.expect`.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> toMatchAriaSnapshot(String snapshot,
```

### `toHaveCount`

*⚙️ Method*

Ensures the [Locator] resolves to an exact number of DOM nodes.

**Usage**

```dart
final list = page.locator('list > .component');
await expect(list).toHaveCount(3);
```

**Arguments**
- `count` int

Expected count.
- `options` Map *(optional)*
- `timeout` double *(optional)*

Time to retry the assertion for in milliseconds. Defaults to `timeout` in `TestConfig.expect`.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> toHaveCount(int count,
```

## `Mouse`

```dart
class Mouse
```

### `move`

*⚙️ Method*

Dispatches a `mousemove` event.

**Usage**

```dart
await mouse.move(x, y);
await mouse.move(x, y, options);
```

**Arguments**
- `x` double

X coordinate relative to the main frame's viewport in CSS pixels.
- `y` double

Y coordinate relative to the main frame's viewport in CSS pixels.
- `options` Map *(optional)*
- `steps` int *(optional)*

Defaults to 1. Sends `n` interpolated `mousemove` events to represent travel between Playwright's current cursor position and the provided destination. When set to 1, emits a single `mousemove` event at the destination location.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> move(double x, double y,
```

### `down`

*⚙️ Method*

Dispatches a `mousedown` event.

**Usage**

```dart
await mouse.down();
await mouse.down(options);
```

**Arguments**
- `options` Map *(optional)*
- `button` Button *(optional)*

Defaults to `left`.
- `clickCount` int *(optional)*

defaults to 1. See [UIEvent.detail].

**Returns**
- Future&lt;void&gt;

```dart
Future<void> down(
```

### `up`

*⚙️ Method*

Dispatches a `mouseup` event.

**Usage**

```dart
await mouse.up();
await mouse.up(options);
```

**Arguments**
- `options` Map *(optional)*
- `button` Button *(optional)*

Defaults to `left`.
- `clickCount` int *(optional)*

defaults to 1. See [UIEvent.detail].

**Returns**
- Future&lt;void&gt;

```dart
Future<void> up(
```

### `click`

*⚙️ Method*

Shortcut for [mouse.move()], [mouse.down()], [mouse.up()].

**Usage**

```dart
await mouse.click(x, y);
await mouse.click(x, y, options);
```

**Arguments**
- `x` double

X coordinate relative to the main frame's viewport in CSS pixels.
- `y` double

Y coordinate relative to the main frame's viewport in CSS pixels.
- `options` Map *(optional)*
- `button` Button *(optional)*

Defaults to `left`.
- `clickCount` int *(optional)*

defaults to 1. See [UIEvent.detail].
- `delay` double *(optional)*

Time to wait between `mousedown` and `mouseup` in milliseconds. Defaults to 0.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> click( double x, double y,
```

### `dblclick`

*⚙️ Method*

Shortcut for [mouse.move()], [mouse.down()], [mouse.up()], [mouse.down()] and [mouse.up()].

**Usage**

```dart
await mouse.dblclick(x, y);
await mouse.dblclick(x, y, options);
```

**Arguments**
- `x` mouse.up(). /// /// **Usage** /// /// ```dart /// await mouse.click(x, y); /// await mouse.click(x, y, options); /// ``` /// /// **Arguments** /// - `x` num /// /// X coordinate relative to the main frame's viewport in CSS pixels. /// - `y` num /// /// Y coordinate relative to the main frame's viewport in CSS pixels. /// - `options` Map *(optional)* /// - `button` button: *(optional)* /// /// Defaults to `left`. /// - `clickCount` num *(optional)* /// /// defaults to 1. See UIEvent.detail. /// - `delay` delay: *(optional)* /// /// Time to wait between `mousedown` and `mouseup` in milliseconds. Defaults to 0. /// /// **Returns** /// - Future&lt;void&gt; double

X coordinate relative to the main frame's viewport in CSS pixels.
- `y` double

Y coordinate relative to the main frame's viewport in CSS pixels.
- `options` Map *(optional)*
- `button` Button *(optional)*

Defaults to `left`.
- `delay` double *(optional)*

Time to wait between `mousedown` and `mouseup` in milliseconds. Defaults to 0.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> dblclick( /// Shortcut for [mouse.move()], [mouse.down()], [mouse.up()]. /// /// **Usage** /// /// ```dart /// await mouse.click(x, y)
```

### `wheel`

*⚙️ Method*

Dispatches a `wheel` event. This method is usually used to manually scroll the page. See [scrolling] for alternative ways to scroll.

**NOTE**
Wheel events may cause scrolling if they are not handled, and this method does not wait for the scrolling to finish before returning.
**Usage**

```dart
await mouse.wheel(deltaX, deltaY);
```

**Arguments**
- `deltaX` double

Pixels to scroll horizontally.
- `deltaY` double

Pixels to scroll vertically.

**Returns**
- Future&lt;void&gt;


[APIRequest]: /api/class-apirequest.mdx "APIRequest"
[APIRequestContext]: /api/class-apirequestcontext.mdx "APIRequestContext"
[APIResponse]: /api/class-apiresponse.mdx "APIResponse"
[APIResponseAssertions]: /api/class-apiresponseassertions.mdx "APIResponseAssertions"
[Browser]: /api/class-browser.mdx "Browser"
[BrowserContext]: /api/class-browsercontext.mdx "BrowserContext"
[BrowserServer]: /api/class-browserserver.mdx "BrowserServer"
[BrowserType]: /api/class-browsertype.mdx "BrowserType"
[CDPSession]: /api/class-cdpsession.mdx "CDPSession"
[Clock]: /api/class-clock.mdx "Clock"
[ConsoleMessage]: /api/class-consolemessage.mdx "ConsoleMessage"
[Coverage]: /api/class-coverage.mdx "Coverage"
[Credentials]: /api/class-credentials.mdx "Credentials"
[Debugger]: /api/class-debugger.mdx "Debugger"
[Dialog]: /api/class-dialog.mdx "Dialog"
[Disposable]: /api/class-disposable.mdx "Disposable"
[Download]: /api/class-download.mdx "Download"
[ElementHandle]: /api/class-elementhandle.mdx "ElementHandle"
[FileChooser]: /api/class-filechooser.mdx "FileChooser"
[Frame]: /api/class-frame.mdx "Frame"
[FrameLocator]: /api/class-framelocator.mdx "FrameLocator"
[GenericAssertions]: /api/class-genericassertions.mdx "GenericAssertions"
[JSHandle]: /api/class-jshandle.mdx "JSHandle"
[Keyboard]: /api/class-keyboard.mdx "Keyboard"
[Locator]: /api/class-locator.mdx "Locator"
[LocatorAssertions]: /api/class-locatorassertions.mdx "LocatorAssertions"
[Logger]: /api/class-logger.mdx "Logger"
[Mouse]: /api/class-mouse.mdx "Mouse"
[Page]: /api/class-page.mdx "Page"
[PageAssertions]: /api/class-pageassertions.mdx "PageAssertions"
[Playwright]: /api/class-playwright.mdx "Playwright"
[PlaywrightAssertions]: /api/class-playwrightassertions.mdx "PlaywrightAssertions"
[Request]: /api/class-request.mdx "Request"
[Response]: /api/class-response.mdx "Response"
[Route]: /api/class-route.mdx "Route"
[Screencast]: /api/class-screencast.mdx "Screencast"
[Selectors]: /api/class-selectors.mdx "Selectors"
[SnapshotAssertions]: /api/class-snapshotassertions.mdx "SnapshotAssertions"
[TimeoutError]: /api/class-timeouterror.mdx "TimeoutError"
[Touchscreen]: /api/class-touchscreen.mdx "Touchscreen"
[Tracing]: /api/class-tracing.mdx "Tracing"
[Video]: /api/class-video.mdx "Video"
[WebError]: /api/class-weberror.mdx "WebError"
[WebSocket]: /api/class-websocket.mdx "WebSocket"
[WebSocketRoute]: /api/class-websocketroute.mdx "WebSocketRoute"
[WebStorage]: /api/class-webstorage.mdx "WebStorage"
[Worker]: /api/class-worker.mdx "Worker"
[Electron]: /api/class-electron.mdx "Electron"
[ElectronApplication]: /api/class-electronapplication.mdx "ElectronApplication"
[Android]: /api/class-android.mdx "Android"
[AndroidDevice]: /api/class-androiddevice.mdx "AndroidDevice"
[AndroidInput]: /api/class-androidinput.mdx "AndroidInput"
[AndroidSocket]: /api/class-androidsocket.mdx "AndroidSocket"
[AndroidWebView]: /api/class-androidwebview.mdx "AndroidWebView"
[Fixtures]: /api/class-fixtures.mdx "Fixtures"
[FullConfig]: /api/class-fullconfig.mdx "FullConfig"
[FullProject]: /api/class-fullproject.mdx "FullProject"
[Location]: /api/class-location.mdx "Location"
[Test]: /api/class-test.mdx "Test"
[TestConfig]: /api/class-testconfig.mdx "TestConfig"
[TestInfo]: /api/class-testinfo.mdx "TestInfo"
[TestInfoError]: /api/class-testinfoerror.mdx "TestInfoError"
[TestOptions]: /api/class-testoptions.mdx "TestOptions"
[TestProject]: /api/class-testproject.mdx "TestProject"
[TestStepInfo]: /api/class-teststepinfo.mdx "TestStepInfo"
[WorkerInfo]: /api/class-workerinfo.mdx "WorkerInfo"
[Reporter]: /api/class-reporter.mdx "Reporter"
[Suite]: /api/class-suite.mdx "Suite"
[TestCase]: /api/class-testcase.mdx "TestCase"
[TestError]: /api/class-testerror.mdx "TestError"
[TestResult]: /api/class-testresult.mdx "TestResult"
[TestStep]: /api/class-teststep.mdx "TestStep"
[EvaluationArgument]: /evaluating.mdx#evaluation-argument "EvaluationArgument"
[UIEvent.detail]: https://developer.mozilla.org/en-US/docs/Web/API/UIEvent/detail "UIEvent.detail"


[all available image tags]: https://mcr.microsoft.com/en-us/product/playwright/about "all available image tags"
[Microsoft Artifact Registry]: https://mcr.microsoft.com/en-us/product/playwright/about "Microsoft Artifact Registry"
[Dockerfile.noble]: https://github.com/microsoft/playwright/blob/main/utils/docker/Dockerfile.noble "Dockerfile.noble"

```dart
Future<void> wheel(double deltaX, double deltaY) async
```

### `leftClick`

*⚙️ Method*

Left-clicks at the specified coordinates.

```dart
Future<void> leftClick( /// Shortcut for [mouse.move()], [mouse.down()], [mouse.up()]. /// /// **Usage** /// /// ```dart /// await mouse.click(x, y)
```

### `rightClick`

*⚙️ Method*

Right-clicks at the specified coordinates.

```dart
Future<void> rightClick( /// Shortcut for [mouse.move()], [mouse.down()], [mouse.up()]. /// /// **Usage** /// /// ```dart /// await mouse.click(x, y)
```

### `middleClick`

*⚙️ Method*

Middle-clicks at the specified coordinates.

```dart
Future<void> middleClick( /// Shortcut for [mouse.move()], [mouse.down()], [mouse.up()]. /// /// **Usage** /// /// ```dart /// await mouse.click(x, y)
```

### `leftDblclick`

*⚙️ Method*

Double left-clicks at the specified coordinates.

```dart
Future<void> leftDblclick(double x, double y,
```

### `dblclick`

*⚙️ Method*

Shortcut for [mouse.move()], [mouse.down()], [mouse.up()], [mouse.down()] and [mouse.up()].

**Usage**

```dart
await mouse.dblclick(x, y);
await mouse.dblclick(x, y, options);
```

**Arguments**
- `x` num

X coordinate relative to the main frame's viewport in CSS pixels.
- `y` num

Y coordinate relative to the main frame's viewport in CSS pixels.
- `options` Map *(optional)*
- `button` "left" | "right" | "middle" *(optional)*

Defaults to `left`.
- `delay` delay: *(optional)*

Time to wait between `mousedown` and `mouseup` in milliseconds. Defaults to 0.

**Returns**
- Future&lt;void&gt;

```dart
await dblclick(x, y, delay: delay, button: Button.left)
```

### `rightDblclick`

*⚙️ Method*

Double right-clicks at the specified coordinates.

```dart
Future<void> rightDblclick(double x, double y,
```

### `dblclick`

*⚙️ Method*

Shortcut for [mouse.move()], [mouse.down()], [mouse.up()], [mouse.down()] and [mouse.up()].

**Usage**

```dart
await mouse.dblclick(x, y);
await mouse.dblclick(x, y, options);
```

**Arguments**
- `x` num

X coordinate relative to the main frame's viewport in CSS pixels.
- `y` num

Y coordinate relative to the main frame's viewport in CSS pixels.
- `options` Map *(optional)*
- `button` "left" | "right" | "middle" *(optional)*

Defaults to `left`.
- `delay` delay: *(optional)*

Time to wait between `mousedown` and `mouseup` in milliseconds. Defaults to 0.

**Returns**
- Future&lt;void&gt;

```dart
await dblclick(x, y, delay: delay, button: Button.right)
```

### `middleDblclick`

*⚙️ Method*

Double middle-clicks at the specified coordinates.

```dart
Future<void> middleDblclick(double x, double y,
```

### `dblclick`

*⚙️ Method*

Shortcut for [mouse.move()], [mouse.down()], [mouse.up()], [mouse.down()] and [mouse.up()].

**Usage**

```dart
await mouse.dblclick(x, y);
await mouse.dblclick(x, y, options);
```

**Arguments**
- `x` num

X coordinate relative to the main frame's viewport in CSS pixels.
- `y` num

Y coordinate relative to the main frame's viewport in CSS pixels.
- `options` Map *(optional)*
- `button` "left" | "right" | "middle" *(optional)*

Defaults to `left`.
- `delay` delay: *(optional)*

Time to wait between `mousedown` and `mouseup` in milliseconds. Defaults to 0.

**Returns**
- Future&lt;void&gt;

```dart
await dblclick(x, y, delay: delay, button: Button.middle)
```

### `scrollUp`

*⚙️ Method*

Scrolls up by the specified amount.

```dart
Future<void> scrollUp(double amount) async
```

### `scrollDown`

*⚙️ Method*

Scrolls down by the specified amount.

```dart
Future<void> scrollDown(double amount) async
```

### `scrollLeft`

*⚙️ Method*

Scrolls left by the specified amount.

```dart
Future<void> scrollLeft(double amount) async
```

### `scrollRight`

*⚙️ Method*

Scrolls right by the specified amount.

```dart
Future<void> scrollRight(double amount) async
```

## `PageAssertions`

Web-first assertions for a [Page].

Obtain via [Page.pageExpect]:
```dart
await page.pageExpect().toHaveTitle('My Page');
await page.pageExpect().toHaveURL('https://example.com/login');
```

```dart
class PageAssertions
```

### `toHaveTitle`

*⚙️ Method*

Ensures the page has the given title.

**Usage**

```dart
await expect(page).toHaveTitle(/.*checkout/);
```

**Arguments**
- `titleOrRegExp` String | [RegExp]

Expected title or RegExp.
- `options` Map *(optional)*
- `timeout` double *(optional)*

Time to retry the assertion for in milliseconds. Defaults to `timeout` in `TestConfig.expect`.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> toHaveTitle(Pattern expected,
```

### `toHaveURL`

*⚙️ Method*

Ensures the page is navigated to the given URL.

**Usage**

```dart
// Check for the page URL to be 'https://playwright.dev/docs/intro' (including query string)
await expect(page).toHaveURL('https://playwright.dev/docs/intro');

// Check for the page URL to contain 'doc', followed by an optional 's', followed by '/'
await expect(page).toHaveURL(/docs?\//);

// Check for the page URL to match the URL pattern
await expect(page).toHaveURL(new URLPattern( pathname: '/docs/*' ));

// Check for the predicate to be satisfied
// For example: verify query strings
await expect(page).toHaveURL((url) {
final params = url.searchParams;
return params.has('search') && params.has('options') && params.get('id') == '5';
);
```

**Arguments**
- `url` String | [RegExp] | [URLPattern] | Function\([URL]\):bool

Expected URL string, RegExp, or predicate receiving [URL] to match. When [baseURL] is provided via the context options and the `url` argument is a string, the two values are merged via the [`new URL()`] constructor and used for the comparison against the current browser URL.
- `options` Map *(optional)*
- `ignoreCase` bool *(optional)*

Whether to perform case-insensitive match. [ignoreCase] option takes precedence over the corresponding regular expression parameter if specified. A provided predicate ignores this flag.
- `timeout` double *(optional)*

Time to retry the assertion for in milliseconds. Defaults to `timeout` in `TestConfig.expect`.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> toHaveURL(Pattern expected,
```

## `Touchscreen`

```dart
class Touchscreen
```

### `tap`

*⚙️ Method*

Dispatches a `touchstart` and `touchend` event with a single touch at the position ([x],[y]).

**NOTE**
[touchscreen.tap()] will throw if the [hasTouch] option of the browser context is false.
**Usage**

```dart
await touchscreen.tap(x, y);
```

**Arguments**
- `x` double

X coordinate relative to the main frame's viewport in CSS pixels.
- `y` double

Y coordinate relative to the main frame's viewport in CSS pixels.

**Returns**
- Future&lt;void&gt;


[APIRequest]: /api/class-apirequest.mdx "APIRequest"
[APIRequestContext]: /api/class-apirequestcontext.mdx "APIRequestContext"
[APIResponse]: /api/class-apiresponse.mdx "APIResponse"
[APIResponseAssertions]: /api/class-apiresponseassertions.mdx "APIResponseAssertions"
[Browser]: /api/class-browser.mdx "Browser"
[BrowserContext]: /api/class-browsercontext.mdx "BrowserContext"
[BrowserServer]: /api/class-browserserver.mdx "BrowserServer"
[BrowserType]: /api/class-browsertype.mdx "BrowserType"
[CDPSession]: /api/class-cdpsession.mdx "CDPSession"
[Clock]: /api/class-clock.mdx "Clock"
[ConsoleMessage]: /api/class-consolemessage.mdx "ConsoleMessage"
[Coverage]: /api/class-coverage.mdx "Coverage"
[Credentials]: /api/class-credentials.mdx "Credentials"
[Debugger]: /api/class-debugger.mdx "Debugger"
[Dialog]: /api/class-dialog.mdx "Dialog"
[Disposable]: /api/class-disposable.mdx "Disposable"
[Download]: /api/class-download.mdx "Download"
[ElementHandle]: /api/class-elementhandle.mdx "ElementHandle"
[FileChooser]: /api/class-filechooser.mdx "FileChooser"
[Frame]: /api/class-frame.mdx "Frame"
[FrameLocator]: /api/class-framelocator.mdx "FrameLocator"
[GenericAssertions]: /api/class-genericassertions.mdx "GenericAssertions"
[JSHandle]: /api/class-jshandle.mdx "JSHandle"
[Keyboard]: /api/class-keyboard.mdx "Keyboard"
[Locator]: /api/class-locator.mdx "Locator"
[LocatorAssertions]: /api/class-locatorassertions.mdx "LocatorAssertions"
[Logger]: /api/class-logger.mdx "Logger"
[Mouse]: /api/class-mouse.mdx "Mouse"
[Page]: /api/class-page.mdx "Page"
[PageAssertions]: /api/class-pageassertions.mdx "PageAssertions"
[Playwright]: /api/class-playwright.mdx "Playwright"
[PlaywrightAssertions]: /api/class-playwrightassertions.mdx "PlaywrightAssertions"
[Request]: /api/class-request.mdx "Request"
[Response]: /api/class-response.mdx "Response"
[Route]: /api/class-route.mdx "Route"
[Screencast]: /api/class-screencast.mdx "Screencast"
[Selectors]: /api/class-selectors.mdx "Selectors"
[SnapshotAssertions]: /api/class-snapshotassertions.mdx "SnapshotAssertions"
[TimeoutError]: /api/class-timeouterror.mdx "TimeoutError"
[Touchscreen]: /api/class-touchscreen.mdx "Touchscreen"
[Tracing]: /api/class-tracing.mdx "Tracing"
[Video]: /api/class-video.mdx "Video"
[WebError]: /api/class-weberror.mdx "WebError"
[WebSocket]: /api/class-websocket.mdx "WebSocket"
[WebSocketRoute]: /api/class-websocketroute.mdx "WebSocketRoute"
[WebStorage]: /api/class-webstorage.mdx "WebStorage"
[Worker]: /api/class-worker.mdx "Worker"
[Electron]: /api/class-electron.mdx "Electron"
[ElectronApplication]: /api/class-electronapplication.mdx "ElectronApplication"
[Android]: /api/class-android.mdx "Android"
[AndroidDevice]: /api/class-androiddevice.mdx "AndroidDevice"
[AndroidInput]: /api/class-androidinput.mdx "AndroidInput"
[AndroidSocket]: /api/class-androidsocket.mdx "AndroidSocket"
[AndroidWebView]: /api/class-androidwebview.mdx "AndroidWebView"
[Fixtures]: /api/class-fixtures.mdx "Fixtures"
[FullConfig]: /api/class-fullconfig.mdx "FullConfig"
[FullProject]: /api/class-fullproject.mdx "FullProject"
[Location]: /api/class-location.mdx "Location"
[Test]: /api/class-test.mdx "Test"
[TestConfig]: /api/class-testconfig.mdx "TestConfig"
[TestInfo]: /api/class-testinfo.mdx "TestInfo"
[TestInfoError]: /api/class-testinfoerror.mdx "TestInfoError"
[TestOptions]: /api/class-testoptions.mdx "TestOptions"
[TestProject]: /api/class-testproject.mdx "TestProject"
[TestStepInfo]: /api/class-teststepinfo.mdx "TestStepInfo"
[WorkerInfo]: /api/class-workerinfo.mdx "WorkerInfo"
[Reporter]: /api/class-reporter.mdx "Reporter"
[Suite]: /api/class-suite.mdx "Suite"
[TestCase]: /api/class-testcase.mdx "TestCase"
[TestError]: /api/class-testerror.mdx "TestError"
[TestResult]: /api/class-testresult.mdx "TestResult"
[TestStep]: /api/class-teststep.mdx "TestStep"
[EvaluationArgument]: /evaluating.mdx#evaluation-argument "EvaluationArgument"
[UIEvent.detail]: https://developer.mozilla.org/en-US/docs/Web/API/UIEvent/detail "UIEvent.detail"


[all available image tags]: https://mcr.microsoft.com/en-us/product/playwright/about "all available image tags"
[Microsoft Artifact Registry]: https://mcr.microsoft.com/en-us/product/playwright/about "Microsoft Artifact Registry"
[Dockerfile.noble]: https://github.com/microsoft/playwright/blob/main/utils/docker/Dockerfile.noble "Dockerfile.noble"

```dart
Future<void> tap(double x, double y) async
```

---

# Network

## `APIRequestContext`

Interface for APIRequestContext

```dart
abstract interface class APIRequestContext
```

### `fetch`

*⚙️ Method*

Sends HTTP(S) request and returns its response. The method will populate request cookies from the context and update context cookies from the response. The method will automatically follow redirects.

**Usage**

JSON objects can be passed directly to the request:

```dart
await request.fetch('https://example.com/api/createBook',
method: 'post',
data: {
title: 'Book Title',
author: 'John Doe',
);
```

The common way to send file(s) in the body of a request is to upload them as form fields with `multipart/form-data` encoding, by specifiying the `multipart` parameter:

```dart
final form = new FormData();
form.set('name', 'John');
form.append('name', 'Doe');
// Send two file fields with the same name.
form.append('file', new File(['print(2024);'], 'f1.js', { type: 'text/javascript' ));
form.append('file', new File(['hello'], 'f2.txt', { type: 'text/plain' ));
await request.fetch('https://example.com/api/uploadForm', {
multipart: form
);
```

**Arguments**
- `urlOrRequest` String | [Request]

Target URL or Request to get all parameters from.
- `options` Map *(optional)*
- `data` String | List&lt;int&gt; | [Serializable] *(optional)*

Allows to set post data of the request. If the data parameter is an object, it will be serialized to json string and `content-type` header will be set to `application/json` if not explicitly set. Otherwise the `content-type` header will be set to `application/octet-stream` if not explicitly set.
- `failOnStatusCode` bool *(optional)*

Whether to throw on response codes other than 2xx and 3xx. By default response object is returned for all status codes.
- `form` Map&lt;String, String | num | bool&gt; | [FormData] *(optional)*

Provides an object that will be serialized as html form using `application/x-www-form-urlencoded` encoding and sent as this request body. If this parameter is specified `content-type` header will be set to `application/x-www-form-urlencoded` unless explicitly provided.
- `headers` List&lt;NameValue&gt; *(optional)*

Allows to set HTTP headers. These headers will apply to the fetched request as well as any redirects initiated by it.
- `ignoreHTTPSErrors` bool *(optional)*

Whether to ignore HTTPS errors when sending network requests. Defaults to `false`.
- `maxRedirects` int *(optional)*

Maximum number of request redirects that will be followed automatically. An error will be thrown if the number is exceeded. Defaults to `20`. Pass `0` to not follow redirects.
- `maxRetries` int *(optional)*

Maximum number of times network errors should be retried. Currently only `ECONNRESET` error is retried. Does not retry based on HTTP response codes. An error will be thrown if the limit is exceeded. Defaults to `0` - no retries.
- `method` String *(optional)*

If set changes the fetch method (e.g. [PUT] or [POST]). If not specified, GET method is used.
- `multipart` [FormData] | Map&lt;String, String | num | bool | [ReadStream] | Map&gt; *(optional)*
- `name` String

File name
- `mimeType` String

File type
- `buffer` List&lt;int&gt;

File content

Provides an object that will be serialized as html form using `multipart/form-data` encoding and sent as this request body. If this parameter is specified `content-type` header will be set to `multipart/form-data` unless explicitly provided. File values can be passed either as [`fs.ReadStream`] or as file-like object containing file name, mime-type and its content.
- `params` List&lt;NameValue&gt; *(optional)*

Query parameters to be sent with the URL.
- `timeout` double *(optional)*

Request timeout in milliseconds. Defaults to `30000` (30 seconds). Pass `0` to disable timeout.

**Returns**
- Future&lt;[APIResponse]&gt;

```dart
Future<APIResponse> fetch( String url,
```

### `get`

*⚙️ Method*

Sends HTTP(S) [GET] request and returns its response. The method will populate request cookies from the context and update context cookies from the response. The method will automatically follow redirects.

**Usage**

Request parameters can be configured with `params` option, they will be serialized into the URL search parameters:

```dart
// Passing params as object
await request.get('https://example.com/api/getText',
params: {
'isbn': '1234',
'page': 23,
);

// Passing params as URLSearchParams
final searchParams = new URLSearchParams();
searchParams.set('isbn', '1234');
searchParams.append('page', 23);
searchParams.append('page', 24);
await request.get('https://example.com/api/getText', { params: searchParams );

// Passing params as string
final queryString = 'isbn=1234&page=23&page=24';
await request.get('https://example.com/api/getText', { params: queryString );
```

**Arguments**
- `url` String

Target URL.
- `options` Map *(optional)*
- `data` String | List&lt;int&gt; | [Serializable] *(optional)*

Allows to set post data of the request. If the data parameter is an object, it will be serialized to json string and `content-type` header will be set to `application/json` if not explicitly set. Otherwise the `content-type` header will be set to `application/octet-stream` if not explicitly set.
- `failOnStatusCode` bool *(optional)*

Whether to throw on response codes other than 2xx and 3xx. By default response object is returned for all status codes.
- `form` Map&lt;String, String | num | bool&gt; | [FormData] *(optional)*

Provides an object that will be serialized as html form using `application/x-www-form-urlencoded` encoding and sent as this request body. If this parameter is specified `content-type` header will be set to `application/x-www-form-urlencoded` unless explicitly provided.
- `headers` List&lt;NameValue&gt; *(optional)*

Allows to set HTTP headers. These headers will apply to the fetched request as well as any redirects initiated by it.
- `ignoreHTTPSErrors` bool *(optional)*

Whether to ignore HTTPS errors when sending network requests. Defaults to `false`.
- `maxRedirects` num *(optional)*

Maximum number of request redirects that will be followed automatically. An error will be thrown if the number is exceeded. Defaults to `20`. Pass `0` to not follow redirects.
- `maxRetries` num *(optional)*

Maximum number of times network errors should be retried. Currently only `ECONNRESET` error is retried. Does not retry based on HTTP response codes. An error will be thrown if the limit is exceeded. Defaults to `0` - no retries.
- `multipart` [FormData] | Map&lt;String, String | num | bool | [ReadStream] | Map&gt; *(optional)*
- `name` String

File name
- `mimeType` String

File type
- `buffer` List&lt;int&gt;

File content

Provides an object that will be serialized as html form using `multipart/form-data` encoding and sent as this request body. If this parameter is specified `content-type` header will be set to `multipart/form-data` unless explicitly provided. File values can be passed either as [`fs.ReadStream`] or as file-like object containing file name, mime-type and its content.
- `params` Map&lt;String, String | num | bool&gt; | [URLSearchParams] | String *(optional)*

Query parameters to be sent with the URL.
- `timeout` double *(optional)*

Request timeout in milliseconds. Defaults to `30000` (30 seconds). Pass `0` to disable timeout.

**Returns**
- Future&lt;[APIResponse]&gt;

```dart
Future<APIResponse> get( String url,
```

### `post`

*⚙️ Method*

Sends HTTP(S) [POST] request and returns its response. The method will populate request cookies from the context and update context cookies from the response. The method will automatically follow redirects.

**Usage**

JSON objects can be passed directly to the request:

```dart
await request.post('https://example.com/api/createBook',
data: {
title: 'Book Title',
author: 'John Doe',
);
```

To send form data to the server use `form` option. Its value will be encoded into the request body with `application/x-www-form-urlencoded` encoding (see below how to use `multipart/form-data` form encoding to send files):

```dart
await request.post('https://example.com/api/findBook',
form: {
title: 'Book Title',
author: 'John Doe',
);
```

The common way to send file(s) in the body of a request is to upload them as form fields with `multipart/form-data` encoding. Use [FormData] to construct request body and pass it to the request as `multipart` parameter:

```dart
final form = new FormData();
form.set('name', 'John');
form.append('name', 'Doe');
// Send two file fields with the same name.
form.append('file', new File(['print(2024);'], 'f1.js', { type: 'text/javascript' ));
form.append('file', new File(['hello'], 'f2.txt', { type: 'text/plain' ));
await request.post('https://example.com/api/uploadForm', {
multipart: form
);
```

**Arguments**
- `url` String

Target URL.
- `options` Map *(optional)*
- `data` String | List&lt;int&gt; | [Serializable] *(optional)*

Allows to set post data of the request. If the data parameter is an object, it will be serialized to json string and `content-type` header will be set to `application/json` if not explicitly set. Otherwise the `content-type` header will be set to `application/octet-stream` if not explicitly set.
- `failOnStatusCode` bool *(optional)*

Whether to throw on response codes other than 2xx and 3xx. By default response object is returned for all status codes.
- `form` Map&lt;String, String | num | bool&gt; | [FormData] *(optional)*

Provides an object that will be serialized as html form using `application/x-www-form-urlencoded` encoding and sent as this request body. If this parameter is specified `content-type` header will be set to `application/x-www-form-urlencoded` unless explicitly provided.
- `headers` List&lt;NameValue&gt; *(optional)*

Allows to set HTTP headers. These headers will apply to the fetched request as well as any redirects initiated by it.
- `ignoreHTTPSErrors` bool *(optional)*

Whether to ignore HTTPS errors when sending network requests. Defaults to `false`.
- `maxRedirects` num *(optional)*

Maximum number of request redirects that will be followed automatically. An error will be thrown if the number is exceeded. Defaults to `20`. Pass `0` to not follow redirects.
- `maxRetries` num *(optional)*

Maximum number of times network errors should be retried. Currently only `ECONNRESET` error is retried. Does not retry based on HTTP response codes. An error will be thrown if the limit is exceeded. Defaults to `0` - no retries.
- `multipart` [FormData] | Map&lt;String, String | num | bool | [ReadStream] | Map&gt; *(optional)*
- `name` String

File name
- `mimeType` String

File type
- `buffer` List&lt;int&gt;

File content

Provides an object that will be serialized as html form using `multipart/form-data` encoding and sent as this request body. If this parameter is specified `content-type` header will be set to `multipart/form-data` unless explicitly provided. File values can be passed either as [`fs.ReadStream`] or as file-like object containing file name, mime-type and its content.
- `params` Map&lt;String, String | num | bool&gt; | [URLSearchParams] | String *(optional)*

Query parameters to be sent with the URL.
- `timeout` double *(optional)*

Request timeout in milliseconds. Defaults to `30000` (30 seconds). Pass `0` to disable timeout.

**Returns**
- Future&lt;[APIResponse]&gt;

```dart
Future<APIResponse> post( String url,
```

### `put`

*⚙️ Method*

Sends HTTP(S) [PUT] request and returns its response. The method will populate request cookies from the context and update context cookies from the response. The method will automatically follow redirects.

**Usage**

```dart
await apiRequestContext.put(url);
await apiRequestContext.put(url, options);
```

**Arguments**
- `url` String

Target URL.
- `options` Map *(optional)*
- `data` String | List&lt;int&gt; | [Serializable] *(optional)*

Allows to set post data of the request. If the data parameter is an object, it will be serialized to json string and `content-type` header will be set to `application/json` if not explicitly set. Otherwise the `content-type` header will be set to `application/octet-stream` if not explicitly set.
- `failOnStatusCode` bool *(optional)*

Whether to throw on response codes other than 2xx and 3xx. By default response object is returned for all status codes.
- `form` Map&lt;String, String | num | bool&gt; | [FormData] *(optional)*

Provides an object that will be serialized as html form using `application/x-www-form-urlencoded` encoding and sent as this request body. If this parameter is specified `content-type` header will be set to `application/x-www-form-urlencoded` unless explicitly provided.
- `headers` List&lt;NameValue&gt; *(optional)*

Allows to set HTTP headers. These headers will apply to the fetched request as well as any redirects initiated by it.
- `ignoreHTTPSErrors` bool *(optional)*

Whether to ignore HTTPS errors when sending network requests. Defaults to `false`.
- `maxRedirects` num *(optional)*

Maximum number of request redirects that will be followed automatically. An error will be thrown if the number is exceeded. Defaults to `20`. Pass `0` to not follow redirects.
- `maxRetries` num *(optional)*

Maximum number of times network errors should be retried. Currently only `ECONNRESET` error is retried. Does not retry based on HTTP response codes. An error will be thrown if the limit is exceeded. Defaults to `0` - no retries.
- `multipart` [FormData] | Map&lt;String, String | num | bool | [ReadStream] | Map&gt; *(optional)*
- `name` String

File name
- `mimeType` String

File type
- `buffer` List&lt;int&gt;

File content

Provides an object that will be serialized as html form using `multipart/form-data` encoding and sent as this request body. If this parameter is specified `content-type` header will be set to `multipart/form-data` unless explicitly provided. File values can be passed either as [`fs.ReadStream`] or as file-like object containing file name, mime-type and its content.
- `params` Map&lt;String, String | num | bool&gt; | [URLSearchParams] | String *(optional)*

Query parameters to be sent with the URL.
- `timeout` double *(optional)*

Request timeout in milliseconds. Defaults to `30000` (30 seconds). Pass `0` to disable timeout.

**Returns**
- Future&lt;[APIResponse]&gt;

```dart
Future<APIResponse> put( String url,
```

### `delete`

*⚙️ Method*

Sends HTTP(S) [DELETE] request and returns its response. The method will populate request cookies from the context and update context cookies from the response. The method will automatically follow redirects.

**Usage**

```dart
await apiRequestContext.delete(url);
await apiRequestContext.delete(url, options);
```

**Arguments**
- `url` String

Target URL.
- `options` Map *(optional)*
- `data` String | List&lt;int&gt; | [Serializable] *(optional)*

Allows to set post data of the request. If the data parameter is an object, it will be serialized to json string and `content-type` header will be set to `application/json` if not explicitly set. Otherwise the `content-type` header will be set to `application/octet-stream` if not explicitly set.
- `failOnStatusCode` bool *(optional)*

Whether to throw on response codes other than 2xx and 3xx. By default response object is returned for all status codes.
- `form` Map&lt;String, String | num | bool&gt; | [FormData] *(optional)*

Provides an object that will be serialized as html form using `application/x-www-form-urlencoded` encoding and sent as this request body. If this parameter is specified `content-type` header will be set to `application/x-www-form-urlencoded` unless explicitly provided.
- `headers` List&lt;NameValue&gt; *(optional)*

Allows to set HTTP headers. These headers will apply to the fetched request as well as any redirects initiated by it.
- `ignoreHTTPSErrors` bool *(optional)*

Whether to ignore HTTPS errors when sending network requests. Defaults to `false`.
- `maxRedirects` num *(optional)*

Maximum number of request redirects that will be followed automatically. An error will be thrown if the number is exceeded. Defaults to `20`. Pass `0` to not follow redirects.
- `maxRetries` num *(optional)*

Maximum number of times network errors should be retried. Currently only `ECONNRESET` error is retried. Does not retry based on HTTP response codes. An error will be thrown if the limit is exceeded. Defaults to `0` - no retries.
- `multipart` [FormData] | Map&lt;String, String | num | bool | [ReadStream] | Map&gt; *(optional)*
- `name` String

File name
- `mimeType` String

File type
- `buffer` List&lt;int&gt;

File content

Provides an object that will be serialized as html form using `multipart/form-data` encoding and sent as this request body. If this parameter is specified `content-type` header will be set to `multipart/form-data` unless explicitly provided. File values can be passed either as [`fs.ReadStream`] or as file-like object containing file name, mime-type and its content.
- `params` Map&lt;String, String | num | bool&gt; | [URLSearchParams] | String *(optional)*

Query parameters to be sent with the URL.
- `timeout` double *(optional)*

Request timeout in milliseconds. Defaults to `30000` (30 seconds). Pass `0` to disable timeout.

**Returns**
- Future&lt;[APIResponse]&gt;

```dart
Future<APIResponse> delete( String url,
```

### `patch`

*⚙️ Method*

Sends HTTP(S) [PATCH] request and returns its response. The method will populate request cookies from the context and update context cookies from the response. The method will automatically follow redirects.

**Usage**

```dart
await apiRequestContext.patch(url);
await apiRequestContext.patch(url, options);
```

**Arguments**
- `url` String

Target URL.
- `options` Map *(optional)*
- `data` String | List&lt;int&gt; | [Serializable] *(optional)*

Allows to set post data of the request. If the data parameter is an object, it will be serialized to json string and `content-type` header will be set to `application/json` if not explicitly set. Otherwise the `content-type` header will be set to `application/octet-stream` if not explicitly set.
- `failOnStatusCode` bool *(optional)*

Whether to throw on response codes other than 2xx and 3xx. By default response object is returned for all status codes.
- `form` Map&lt;String, String | num | bool&gt; | [FormData] *(optional)*

Provides an object that will be serialized as html form using `application/x-www-form-urlencoded` encoding and sent as this request body. If this parameter is specified `content-type` header will be set to `application/x-www-form-urlencoded` unless explicitly provided.
- `headers` List&lt;NameValue&gt; *(optional)*

Allows to set HTTP headers. These headers will apply to the fetched request as well as any redirects initiated by it.
- `ignoreHTTPSErrors` bool *(optional)*

Whether to ignore HTTPS errors when sending network requests. Defaults to `false`.
- `maxRedirects` num *(optional)*

Maximum number of request redirects that will be followed automatically. An error will be thrown if the number is exceeded. Defaults to `20`. Pass `0` to not follow redirects.
- `maxRetries` num *(optional)*

Maximum number of times network errors should be retried. Currently only `ECONNRESET` error is retried. Does not retry based on HTTP response codes. An error will be thrown if the limit is exceeded. Defaults to `0` - no retries.
- `multipart` [FormData] | Map&lt;String, String | num | bool | [ReadStream] | Map&gt; *(optional)*
- `name` String

File name
- `mimeType` String

File type
- `buffer` List&lt;int&gt;

File content

Provides an object that will be serialized as html form using `multipart/form-data` encoding and sent as this request body. If this parameter is specified `content-type` header will be set to `multipart/form-data` unless explicitly provided. File values can be passed either as [`fs.ReadStream`] or as file-like object containing file name, mime-type and its content.
- `params` Map&lt;String, String | num | bool&gt; | [URLSearchParams] | String *(optional)*

Query parameters to be sent with the URL.
- `timeout` double *(optional)*

Request timeout in milliseconds. Defaults to `30000` (30 seconds). Pass `0` to disable timeout.

**Returns**
- Future&lt;[APIResponse]&gt;

```dart
Future<APIResponse> patch( String url,
```

### `head`

*⚙️ Method*

Sends HTTP(S) [HEAD] request and returns its response. The method will populate request cookies from the context and update context cookies from the response. The method will automatically follow redirects.

**Usage**

```dart
await apiRequestContext.head(url);
await apiRequestContext.head(url, options);
```

**Arguments**
- `url` String

Target URL.
- `options` Map *(optional)*
- `data` String | List&lt;int&gt; | [Serializable] *(optional)*

Allows to set post data of the request. If the data parameter is an object, it will be serialized to json string and `content-type` header will be set to `application/json` if not explicitly set. Otherwise the `content-type` header will be set to `application/octet-stream` if not explicitly set.
- `failOnStatusCode` bool *(optional)*

Whether to throw on response codes other than 2xx and 3xx. By default response object is returned for all status codes.
- `form` Map&lt;String, String | num | bool&gt; | [FormData] *(optional)*

Provides an object that will be serialized as html form using `application/x-www-form-urlencoded` encoding and sent as this request body. If this parameter is specified `content-type` header will be set to `application/x-www-form-urlencoded` unless explicitly provided.
- `headers` List&lt;NameValue&gt; *(optional)*

Allows to set HTTP headers. These headers will apply to the fetched request as well as any redirects initiated by it.
- `ignoreHTTPSErrors` bool *(optional)*

Whether to ignore HTTPS errors when sending network requests. Defaults to `false`.
- `maxRedirects` num *(optional)*

Maximum number of request redirects that will be followed automatically. An error will be thrown if the number is exceeded. Defaults to `20`. Pass `0` to not follow redirects.
- `maxRetries` num *(optional)*

Maximum number of times network errors should be retried. Currently only `ECONNRESET` error is retried. Does not retry based on HTTP response codes. An error will be thrown if the limit is exceeded. Defaults to `0` - no retries.
- `multipart` [FormData] | Map&lt;String, String | num | bool | [ReadStream] | Map&gt; *(optional)*
- `name` String

File name
- `mimeType` String

File type
- `buffer` List&lt;int&gt;

File content

Provides an object that will be serialized as html form using `multipart/form-data` encoding and sent as this request body. If this parameter is specified `content-type` header will be set to `multipart/form-data` unless explicitly provided. File values can be passed either as [`fs.ReadStream`] or as file-like object containing file name, mime-type and its content.
- `params` Map&lt;String, String | num | bool&gt; | [URLSearchParams] | String *(optional)*

Query parameters to be sent with the URL.
- `timeout` double *(optional)*

Request timeout in milliseconds. Defaults to `30000` (30 seconds). Pass `0` to disable timeout.

**Returns**
- Future&lt;[APIResponse]&gt;

```dart
Future<APIResponse> head( String url,
```

### `storageState`

*⚙️ Method*

Returns storage state for this request context, contains current cookies and local storage snapshot if it was passed to the constructor.

**Usage**

```dart
await apiRequestContext.storageState();
await apiRequestContext.storageState(options);
```

**Arguments**
- `options` Map *(optional)*
- `indexedDB` bool *(optional)*

Set to `true` to include IndexedDB in the storage state snapshot.
- `path` String *(optional)*

The file path to save the storage state to. If [path] is a relative path, then it is resolved relative to current working directory. If no path is provided, storage state is still returned, but won't be saved to the disk.

**Returns**
- Future&lt;Map&gt;
- `cookies` List&lt;Map&gt;
- `name` String


- `value` String


- `domain` String


- `path` String


- `expires` num

Unix time in seconds.
- `httpOnly` bool


- `secure` bool


- `sameSite` "Strict" | "Lax" | "None"



- `origins` List&lt;Map&gt;
- `origin` String


- `localStorage` List&lt;Map&gt;
- `name` String


- `value` String

```dart
Future<APIRequestContextStorageStateResult> storageState(
```

### `dispose`

*⚙️ Method*

All responses returned by [apiRequestContext.get()] and similar methods are stored in the memory, so that you can later call [apiResponse.body()].This method discards all its resources, calling any method on disposed [APIRequestContext] will throw an exception.

**Usage**

```dart
await apiRequestContext.dispose();
await apiRequestContext.dispose(options);
```

**Arguments**
- `options` Map *(optional)*
- `reason` String *(optional)*

The reason to be reported to the operations interrupted by the context disposal.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> dispose(
```

## `Request`

```dart
abstract interface class Request
```

### `url`

*📦 Property*

URL of the request.

**Usage**

```dart
request.url;
```

**Returns**
- String


[APIRequest]: /api/class-apirequest.mdx "APIRequest"
[APIRequestContext]: /api/class-apirequestcontext.mdx "APIRequestContext"
[APIResponse]: /api/class-apiresponse.mdx "APIResponse"
[APIResponseAssertions]: /api/class-apiresponseassertions.mdx "APIResponseAssertions"
[Browser]: /api/class-browser.mdx "Browser"
[BrowserContext]: /api/class-browsercontext.mdx "BrowserContext"
[BrowserServer]: /api/class-browserserver.mdx "BrowserServer"
[BrowserType]: /api/class-browsertype.mdx "BrowserType"
[CDPSession]: /api/class-cdpsession.mdx "CDPSession"
[Clock]: /api/class-clock.mdx "Clock"
[ConsoleMessage]: /api/class-consolemessage.mdx "ConsoleMessage"
[Coverage]: /api/class-coverage.mdx "Coverage"
[Credentials]: /api/class-credentials.mdx "Credentials"
[Debugger]: /api/class-debugger.mdx "Debugger"
[Dialog]: /api/class-dialog.mdx "Dialog"
[Disposable]: /api/class-disposable.mdx "Disposable"
[Download]: /api/class-download.mdx "Download"
[ElementHandle]: /api/class-elementhandle.mdx "ElementHandle"
[FileChooser]: /api/class-filechooser.mdx "FileChooser"
[Frame]: /api/class-frame.mdx "Frame"
[FrameLocator]: /api/class-framelocator.mdx "FrameLocator"
[GenericAssertions]: /api/class-genericassertions.mdx "GenericAssertions"
[JSHandle]: /api/class-jshandle.mdx "JSHandle"
[Keyboard]: /api/class-keyboard.mdx "Keyboard"
[Locator]: /api/class-locator.mdx "Locator"
[LocatorAssertions]: /api/class-locatorassertions.mdx "LocatorAssertions"
[Logger]: /api/class-logger.mdx "Logger"
[Mouse]: /api/class-mouse.mdx "Mouse"
[Page]: /api/class-page.mdx "Page"
[PageAssertions]: /api/class-pageassertions.mdx "PageAssertions"
[Playwright]: /api/class-playwright.mdx "Playwright"
[PlaywrightAssertions]: /api/class-playwrightassertions.mdx "PlaywrightAssertions"
[Request]: /api/class-request.mdx "Request"
[Response]: /api/class-response.mdx "Response"
[Route]: /api/class-route.mdx "Route"
[Screencast]: /api/class-screencast.mdx "Screencast"
[Selectors]: /api/class-selectors.mdx "Selectors"
[SnapshotAssertions]: /api/class-snapshotassertions.mdx "SnapshotAssertions"
[TimeoutError]: /api/class-timeouterror.mdx "TimeoutError"
[Touchscreen]: /api/class-touchscreen.mdx "Touchscreen"
[Tracing]: /api/class-tracing.mdx "Tracing"
[Video]: /api/class-video.mdx "Video"
[WebError]: /api/class-weberror.mdx "WebError"
[WebSocket]: /api/class-websocket.mdx "WebSocket"
[WebSocketRoute]: /api/class-websocketroute.mdx "WebSocketRoute"
[WebStorage]: /api/class-webstorage.mdx "WebStorage"
[Worker]: /api/class-worker.mdx "Worker"
[Electron]: /api/class-electron.mdx "Electron"
[ElectronApplication]: /api/class-electronapplication.mdx "ElectronApplication"
[Android]: /api/class-android.mdx "Android"
[AndroidDevice]: /api/class-androiddevice.mdx "AndroidDevice"
[AndroidInput]: /api/class-androidinput.mdx "AndroidInput"
[AndroidSocket]: /api/class-androidsocket.mdx "AndroidSocket"
[AndroidWebView]: /api/class-androidwebview.mdx "AndroidWebView"
[Fixtures]: /api/class-fixtures.mdx "Fixtures"
[FullConfig]: /api/class-fullconfig.mdx "FullConfig"
[FullProject]: /api/class-fullproject.mdx "FullProject"
[Location]: /api/class-location.mdx "Location"
[Test]: /api/class-test.mdx "Test"
[TestConfig]: /api/class-testconfig.mdx "TestConfig"
[TestInfo]: /api/class-testinfo.mdx "TestInfo"
[TestInfoError]: /api/class-testinfoerror.mdx "TestInfoError"
[TestOptions]: /api/class-testoptions.mdx "TestOptions"
[TestProject]: /api/class-testproject.mdx "TestProject"
[TestStepInfo]: /api/class-teststepinfo.mdx "TestStepInfo"
[WorkerInfo]: /api/class-workerinfo.mdx "WorkerInfo"
[Reporter]: /api/class-reporter.mdx "Reporter"
[Suite]: /api/class-suite.mdx "Suite"
[TestCase]: /api/class-testcase.mdx "TestCase"
[TestError]: /api/class-testerror.mdx "TestError"
[TestResult]: /api/class-testresult.mdx "TestResult"
[TestStep]: /api/class-teststep.mdx "TestStep"
[EvaluationArgument]: /evaluating.mdx#evaluation-argument "EvaluationArgument"
[UIEvent.detail]: https://developer.mozilla.org/en-US/docs/Web/API/UIEvent/detail "UIEvent.detail"


[all available image tags]: https://mcr.microsoft.com/en-us/product/playwright/about "all available image tags"
[Microsoft Artifact Registry]: https://mcr.microsoft.com/en-us/product/playwright/about "Microsoft Artifact Registry"
[Dockerfile.noble]: https://github.com/microsoft/playwright/blob/main/utils/docker/Dockerfile.noble "Dockerfile.noble"

```dart
String get url
```

### `frame`

*📦 Property*

Returns the [Frame] that initiated this request.

**Usage**

```dart
final frameUrl = request.frame.url();
```

**Returns**
- [Frame]

**Details**

Note that in some cases the frame is not available, and this method will throw.
* When request originates in the Service Worker. You can use `request.serviceWorker()` to check that.
* When navigation request is issued before the corresponding frame is created. You can use [request.isNavigationRequest()] to check that.

Here is an example that handles all the cases:

```dart
if (request.serviceWorker())
print(`request ${request.url()} from a service worker`);
else if (request.isNavigationRequest())
print(`request ${request.url()} is a navigation request`);
else
print(`request ${request.url()} from a frame ${request.frame.url()}`);
```

```dart
Frame get frame
```

### `resourceType`

*📦 Property*

Contains the request's resource type as it was perceived by the rendering engine. ResourceType will be one of the following: `document`, `stylesheet`, `image`, `media`, `font`, `script`, `texttrack`, `xhr`, `fetch`, `eventsource`, `websocket`, `manifest`, `other`.

**Usage**

```dart
request.resourceType;
```

**Returns**
- String

```dart
String get resourceType
```

### `method`

*📦 Property*

Request's method (GET, POST, etc.)

**Usage**

```dart
request.method;
```

**Returns**
- String

```dart
String get method
```

### `postData`

*📦 Property*

Request's post body, if any.

**Usage**

```dart
request.postData;
```

**Returns**
- [String]?

```dart
String? get postData
```

### `headers`

*📦 Property*

An object with the request HTTP headers. The header names are lower-cased. Note that this method does not return security-related headers, including cookie-related ones. You can use [request.allHeaders()] for complete list of headers that include `cookie` information.

**Usage**

```dart
request.headers;
```

**Returns**
- Map&lt;String, String&gt;

```dart
Map<String, dynamic> get headers
```

### `isNavigationRequest`

*📦 Property*

Whether this request is driving frame's navigation.

Some navigation requests are issued before the corresponding frame is created, and therefore do not have [request.frame()] available.

**Usage**

```dart
request.isNavigationRequest;
```

**Returns**
- bool

```dart
bool get isNavigationRequest
```

### `timing`

*📦 Property*

Returns resource timing information for given request. Most of the timing values become available upon the response, `responseEnd` becomes available when request finishes. Find more information at [Resource Timing API].

**Usage**

```dart
final requestFinishedFuture = page.onRequestFinished.first;
await page.goto('http://example.com');
final request = await requestFinishedFuture;
print(request.timing);
```

**Returns**
- Map
- `startTime` num

Request start time in milliseconds elapsed since January 1, 1970 00:00:00 UTC
- `domainLookupStart` num

Time immediately before the browser starts the domain name lookup for the resource. The value is given in milliseconds relative to `startTime`, -1 if not available.
- `domainLookupEnd` num

Time immediately after the browser starts the domain name lookup for the resource. The value is given in milliseconds relative to `startTime`, -1 if not available.
- `connectStart` num

Time immediately before the user agent starts establishing the connection to the server to retrieve the resource. The value is given in milliseconds relative to `startTime`, -1 if not available.
- `secureConnectionStart` num

Time immediately before the browser starts the handshake process to secure the current connection. The value is given in milliseconds relative to `startTime`, -1 if not available.
- `connectEnd` num

Time immediately before the user agent starts establishing the connection to the server to retrieve the resource. The value is given in milliseconds relative to `startTime`, -1 if not available.
- `requestStart` num

Time immediately before the browser starts requesting the resource from the server, cache, or local resource. The value is given in milliseconds relative to `startTime`, -1 if not available.
- `responseStart` num

Time immediately after the browser receives the first byte of the response from the server, cache, or local resource. The value is given in milliseconds relative to `startTime`, -1 if not available.
- `responseEnd` num

Time immediately after the browser receives the last byte of the resource or immediately before the transport connection is closed, whichever comes first. The value is given in milliseconds relative to `startTime`, -1 if not available.

```dart
Map<String, dynamic> get timing
```

### `redirectedFrom`

*📦 Property*

Request that was redirected by the server to this one, if any.

When the server responds with a redirect, Playwright creates a new [Request] object. The two requests are connected by `redirectedFrom()` and `redirectedTo()` methods. When multiple server redirects has happened, it is possible to construct the whole redirect chain by repeatedly calling `redirectedFrom()`.

**Usage**

For example, if the website `http://example.com` redirects to `https://example.com`:

```dart
final response = await page.goto('http://example.com');
print(response.request().redirectedFrom.url()); // 'http://example.com'
```

If the website `https://google.com` has no redirects:

```dart
final response = await page.goto('https://google.com');
print(response.request().redirectedFrom); // null
```

**Returns**
- [Request]?

```dart
Request? get redirectedFrom
```

### `redirectedTo`

*📦 Property*

New request issued by the browser if the server responded with redirect.

**Usage**

This method is the opposite of [request.redirectedFrom()]:

```dart
print(request.redirectedFrom().redirectedTo == request); // true
```

**Returns**
- [Request]?

```dart
Request? get redirectedTo
```

### `failure`

*📦 Property*

The method returns `null` unless this request has failed, as reported by `requestfailed` event.

**Usage**

Example of logging of all the failed requests:

```dart
page.onRequestFailed.listen((request) {
print(request.url() + ' ' + request.failure.errorText);
);
```

**Returns**
- [Map]?
- `errorText` String

Human-readable error message, e.g. `'net::ERR_FAILED'`.

```dart
String? get failure
```

### `postDataJSON`

*📦 Property*

Returns parsed request's body for `form-urlencoded` and JSON as a fallback if any.

When the response is `application/x-www-form-urlencoded` then a key/value object of the values will be returned. Otherwise it will be parsed as JSON.

**Usage**

```dart
request.postDataJSON;
```

**Returns**
- [Serializable]?

```dart
dynamic get postDataJSON
```

### `postDataBuffer`

*📦 Property*

Request's post body in a binary form, if any.

**Usage**

```dart
request.postDataBuffer;
```

**Returns**
- List&lt;int&gt;?

```dart
List<int>? get postDataBuffer
```

### `response`

*⚙️ Method*

Returns the matching [Response] object, or `null` if the response was not received due to error.

**Usage**

```dart
await request.response();
```

**Returns**
- Future&lt;[Response]?&gt;

```dart
Future<Response?> response()
```

### `allHeaders`

*⚙️ Method*

An object with all the request HTTP headers associated with this request. The header names are lower-cased.

**Usage**

```dart
await request.allHeaders();
```

**Returns**
- Future&lt;Map&lt;String, String&gt;&gt;

```dart
Future<Map<String, String>> allHeaders()
```

### `headerValue`

*⚙️ Method*

Returns the value of the header matching the name. The name is case-insensitive.

**Usage**

```dart
await request.headerValue(name);
```

**Arguments**
- `name` String

Name of the header.

**Returns**
- Future&lt;[String&gt;]?

```dart
Future<String?> headerValue(String name)
```

## `Response`

```dart
abstract interface class Response
```

### `status`

*📦 Property*

Contains the status code of the response (e.g., 200 for a success).

**Usage**

```dart
response.status;
```

**Returns**
- num

```dart
int get status
```

### `statusText`

*📦 Property*

Contains the status text of the response (e.g. usually an "OK" for a success).

**Usage**

```dart
response.statusText;
```

**Returns**
- String

```dart
String get statusText
```

### `url`

*📦 Property*

Contains the URL of the response.

**Usage**

```dart
response.url;
```

**Returns**
- String


[APIRequest]: /api/class-apirequest.mdx "APIRequest"
[APIRequestContext]: /api/class-apirequestcontext.mdx "APIRequestContext"
[APIResponse]: /api/class-apiresponse.mdx "APIResponse"
[APIResponseAssertions]: /api/class-apiresponseassertions.mdx "APIResponseAssertions"
[Browser]: /api/class-browser.mdx "Browser"
[BrowserContext]: /api/class-browsercontext.mdx "BrowserContext"
[BrowserServer]: /api/class-browserserver.mdx "BrowserServer"
[BrowserType]: /api/class-browsertype.mdx "BrowserType"
[CDPSession]: /api/class-cdpsession.mdx "CDPSession"
[Clock]: /api/class-clock.mdx "Clock"
[ConsoleMessage]: /api/class-consolemessage.mdx "ConsoleMessage"
[Coverage]: /api/class-coverage.mdx "Coverage"
[Credentials]: /api/class-credentials.mdx "Credentials"
[Debugger]: /api/class-debugger.mdx "Debugger"
[Dialog]: /api/class-dialog.mdx "Dialog"
[Disposable]: /api/class-disposable.mdx "Disposable"
[Download]: /api/class-download.mdx "Download"
[ElementHandle]: /api/class-elementhandle.mdx "ElementHandle"
[FileChooser]: /api/class-filechooser.mdx "FileChooser"
[Frame]: /api/class-frame.mdx "Frame"
[FrameLocator]: /api/class-framelocator.mdx "FrameLocator"
[GenericAssertions]: /api/class-genericassertions.mdx "GenericAssertions"
[JSHandle]: /api/class-jshandle.mdx "JSHandle"
[Keyboard]: /api/class-keyboard.mdx "Keyboard"
[Locator]: /api/class-locator.mdx "Locator"
[LocatorAssertions]: /api/class-locatorassertions.mdx "LocatorAssertions"
[Logger]: /api/class-logger.mdx "Logger"
[Mouse]: /api/class-mouse.mdx "Mouse"
[Page]: /api/class-page.mdx "Page"
[PageAssertions]: /api/class-pageassertions.mdx "PageAssertions"
[Playwright]: /api/class-playwright.mdx "Playwright"
[PlaywrightAssertions]: /api/class-playwrightassertions.mdx "PlaywrightAssertions"
[Request]: /api/class-request.mdx "Request"
[Response]: /api/class-response.mdx "Response"
[Route]: /api/class-route.mdx "Route"
[Screencast]: /api/class-screencast.mdx "Screencast"
[Selectors]: /api/class-selectors.mdx "Selectors"
[SnapshotAssertions]: /api/class-snapshotassertions.mdx "SnapshotAssertions"
[TimeoutError]: /api/class-timeouterror.mdx "TimeoutError"
[Touchscreen]: /api/class-touchscreen.mdx "Touchscreen"
[Tracing]: /api/class-tracing.mdx "Tracing"
[Video]: /api/class-video.mdx "Video"
[WebError]: /api/class-weberror.mdx "WebError"
[WebSocket]: /api/class-websocket.mdx "WebSocket"
[WebSocketRoute]: /api/class-websocketroute.mdx "WebSocketRoute"
[WebStorage]: /api/class-webstorage.mdx "WebStorage"
[Worker]: /api/class-worker.mdx "Worker"
[Electron]: /api/class-electron.mdx "Electron"
[ElectronApplication]: /api/class-electronapplication.mdx "ElectronApplication"
[Android]: /api/class-android.mdx "Android"
[AndroidDevice]: /api/class-androiddevice.mdx "AndroidDevice"
[AndroidInput]: /api/class-androidinput.mdx "AndroidInput"
[AndroidSocket]: /api/class-androidsocket.mdx "AndroidSocket"
[AndroidWebView]: /api/class-androidwebview.mdx "AndroidWebView"
[Fixtures]: /api/class-fixtures.mdx "Fixtures"
[FullConfig]: /api/class-fullconfig.mdx "FullConfig"
[FullProject]: /api/class-fullproject.mdx "FullProject"
[Location]: /api/class-location.mdx "Location"
[Test]: /api/class-test.mdx "Test"
[TestConfig]: /api/class-testconfig.mdx "TestConfig"
[TestInfo]: /api/class-testinfo.mdx "TestInfo"
[TestInfoError]: /api/class-testinfoerror.mdx "TestInfoError"
[TestOptions]: /api/class-testoptions.mdx "TestOptions"
[TestProject]: /api/class-testproject.mdx "TestProject"
[TestStepInfo]: /api/class-teststepinfo.mdx "TestStepInfo"
[WorkerInfo]: /api/class-workerinfo.mdx "WorkerInfo"
[Reporter]: /api/class-reporter.mdx "Reporter"
[Suite]: /api/class-suite.mdx "Suite"
[TestCase]: /api/class-testcase.mdx "TestCase"
[TestError]: /api/class-testerror.mdx "TestError"
[TestResult]: /api/class-testresult.mdx "TestResult"
[TestStep]: /api/class-teststep.mdx "TestStep"
[EvaluationArgument]: /evaluating.mdx#evaluation-argument "EvaluationArgument"
[UIEvent.detail]: https://developer.mozilla.org/en-US/docs/Web/API/UIEvent/detail "UIEvent.detail"


[all available image tags]: https://mcr.microsoft.com/en-us/product/playwright/about "all available image tags"
[Microsoft Artifact Registry]: https://mcr.microsoft.com/en-us/product/playwright/about "Microsoft Artifact Registry"
[Dockerfile.noble]: https://github.com/microsoft/playwright/blob/main/utils/docker/Dockerfile.noble "Dockerfile.noble"

```dart
String get url
```

### `headers`

*📦 Property*

An object with the response HTTP headers. The header names are lower-cased. Note that this method does not return security-related headers, including cookie-related ones. You can use [response.allHeaders()] for complete list of headers that include `cookie` information.

**Usage**

```dart
response.headers;
```

**Returns**
- Map&lt;String, String&gt;

```dart
Map<String, dynamic> get headers
```

### `ok`

*📦 Property*

Contains a boolean stating whether the response was successful (status in the range 200-299) or not.

**Usage**

```dart
response.ok;
```

**Returns**
- bool

```dart
bool get ok
```

### `request`

*📦 Property*

Returns the matching [Request] object.

**Usage**

```dart
response.request;
```

**Returns**
- [Request]

```dart
Request get request
```

### `frame`

*📦 Property*

Returns the [Frame] that initiated this response.

**Usage**

```dart
response.frame;
```

**Returns**
- [Frame]

```dart
Frame get frame
```

### `body`

*⚙️ Method*

Returns the buffer with response body.

**Usage**

```dart
await response.body();
```

**Returns**
- Future&lt;List&lt;int&gt;&gt;

```dart
Future<List<int>> body()
```

### `fromServiceWorker`

*📦 Property*

Indicates whether this Response was fulfilled by a Service Worker's Fetch Handler (i.e. via [FetchEvent.respondWith]).

**Usage**

```dart
response.fromServiceWorker;
```

**Returns**
- bool

```dart
bool get fromServiceWorker
```

### `text`

*⚙️ Method*

Returns the text representation of response body.

**Usage**

```dart
await response.text();
```

**Returns**
- Future&lt;String&gt;

```dart
Future<String> text()
```

### `json`

*⚙️ Method*

Returns the JSON representation of response body.

This method will throw if the response body is not parsable via `JSON.parse`.

**Usage**

```dart
await response.json();
```

**Returns**
- Future&lt;[Serializable]&gt;

```dart
Future<T> json<T>()
```

### `securityDetails`

*⚙️ Method*

Returns SSL and other security information.

**Usage**

```dart
await response.securityDetails();
```

**Returns**
- Future&lt;[Map&gt;]?
- `issuer` String *(optional)*

Common Name component of the Issuer field. from the certificate. This should only be used for informational purposes. Optional.
- `protocol` String *(optional)*

The specific TLS protocol used. (e.g. `TLS 1.3`). Optional.
- `subjectName` String *(optional)*

Common Name component of the Subject field from the certificate. This should only be used for informational purposes. Optional.
- `validFrom` num *(optional)*

Unix timestamp (in seconds) specifying when this cert becomes valid. Optional.
- `validTo` num *(optional)*

Unix timestamp (in seconds) specifying when this cert becomes invalid. Optional.

```dart
Future<Map<String, dynamic>?> securityDetails()
```

### `serverAddr`

*⚙️ Method*

Returns the IP address and port of the server.

**Usage**

```dart
await response.serverAddr();
```

**Returns**
- Future&lt;[Map&gt;]?
- `ipAddress` String

IPv4 or IPV6 address of the server.
- `port` num

```dart
Future<Map<String, dynamic>?> serverAddr()
```

### `allHeaders`

*⚙️ Method*

An object with all the response HTTP headers associated with this response.

**Usage**

```dart
await response.allHeaders();
```

**Returns**
- Future&lt;Map&lt;String, String&gt;&gt;

```dart
Future<Map<String, String>> allHeaders()
```

### `headerValue`

*⚙️ Method*

Returns the value of the header matching the name. The name is case-insensitive. If multiple headers have the same name (except `set-cookie`), they are returned as a list separated by `, `. For `set-cookie`, the `\n` separator is used. If no headers are found, `null` is returned.

**Usage**

```dart
await response.headerValue(name);
```

**Arguments**
- `name` String

Name of the header.

**Returns**
- Future&lt;[String&gt;]?

```dart
Future<String?> headerValue(String name)
```

### `headerValues`

*⚙️ Method*

Returns all values of the headers matching the name, for example `set-cookie`. The name is case-insensitive.

**Usage**

```dart
await response.headerValues(name);
```

**Arguments**
- `name` String

Name of the header.

**Returns**
- Future&lt;List&lt;String&gt;&gt;

```dart
Future<List<String>> headerValues(String name)
```

### `httpVersion`

*⚙️ Method*

Returns the http version used by the response.

**Usage**

```dart
await response.httpVersion();
```

**Returns**
- Future&lt;String&gt;

```dart
Future<String> httpVersion()
```

## `Route`

```dart
abstract interface class Route
```

### `request`

*📦 Property*

A request to be routed.

**Usage**

```dart
route.request;
```

**Returns**
- [Request]


[APIRequest]: /api/class-apirequest.mdx "APIRequest"
[APIRequestContext]: /api/class-apirequestcontext.mdx "APIRequestContext"
[APIResponse]: /api/class-apiresponse.mdx "APIResponse"
[APIResponseAssertions]: /api/class-apiresponseassertions.mdx "APIResponseAssertions"
[Browser]: /api/class-browser.mdx "Browser"
[BrowserContext]: /api/class-browsercontext.mdx "BrowserContext"
[BrowserServer]: /api/class-browserserver.mdx "BrowserServer"
[BrowserType]: /api/class-browsertype.mdx "BrowserType"
[CDPSession]: /api/class-cdpsession.mdx "CDPSession"
[Clock]: /api/class-clock.mdx "Clock"
[ConsoleMessage]: /api/class-consolemessage.mdx "ConsoleMessage"
[Coverage]: /api/class-coverage.mdx "Coverage"
[Credentials]: /api/class-credentials.mdx "Credentials"
[Debugger]: /api/class-debugger.mdx "Debugger"
[Dialog]: /api/class-dialog.mdx "Dialog"
[Disposable]: /api/class-disposable.mdx "Disposable"
[Download]: /api/class-download.mdx "Download"
[ElementHandle]: /api/class-elementhandle.mdx "ElementHandle"
[FileChooser]: /api/class-filechooser.mdx "FileChooser"
[Frame]: /api/class-frame.mdx "Frame"
[FrameLocator]: /api/class-framelocator.mdx "FrameLocator"
[GenericAssertions]: /api/class-genericassertions.mdx "GenericAssertions"
[JSHandle]: /api/class-jshandle.mdx "JSHandle"
[Keyboard]: /api/class-keyboard.mdx "Keyboard"
[Locator]: /api/class-locator.mdx "Locator"
[LocatorAssertions]: /api/class-locatorassertions.mdx "LocatorAssertions"
[Logger]: /api/class-logger.mdx "Logger"
[Mouse]: /api/class-mouse.mdx "Mouse"
[Page]: /api/class-page.mdx "Page"
[PageAssertions]: /api/class-pageassertions.mdx "PageAssertions"
[Playwright]: /api/class-playwright.mdx "Playwright"
[PlaywrightAssertions]: /api/class-playwrightassertions.mdx "PlaywrightAssertions"
[Request]: /api/class-request.mdx "Request"
[Response]: /api/class-response.mdx "Response"
[Route]: /api/class-route.mdx "Route"
[Screencast]: /api/class-screencast.mdx "Screencast"
[Selectors]: /api/class-selectors.mdx "Selectors"
[SnapshotAssertions]: /api/class-snapshotassertions.mdx "SnapshotAssertions"
[TimeoutError]: /api/class-timeouterror.mdx "TimeoutError"
[Touchscreen]: /api/class-touchscreen.mdx "Touchscreen"
[Tracing]: /api/class-tracing.mdx "Tracing"
[Video]: /api/class-video.mdx "Video"
[WebError]: /api/class-weberror.mdx "WebError"
[WebSocket]: /api/class-websocket.mdx "WebSocket"
[WebSocketRoute]: /api/class-websocketroute.mdx "WebSocketRoute"
[WebStorage]: /api/class-webstorage.mdx "WebStorage"
[Worker]: /api/class-worker.mdx "Worker"
[Electron]: /api/class-electron.mdx "Electron"
[ElectronApplication]: /api/class-electronapplication.mdx "ElectronApplication"
[Android]: /api/class-android.mdx "Android"
[AndroidDevice]: /api/class-androiddevice.mdx "AndroidDevice"
[AndroidInput]: /api/class-androidinput.mdx "AndroidInput"
[AndroidSocket]: /api/class-androidsocket.mdx "AndroidSocket"
[AndroidWebView]: /api/class-androidwebview.mdx "AndroidWebView"
[Fixtures]: /api/class-fixtures.mdx "Fixtures"
[FullConfig]: /api/class-fullconfig.mdx "FullConfig"
[FullProject]: /api/class-fullproject.mdx "FullProject"
[Location]: /api/class-location.mdx "Location"
[Test]: /api/class-test.mdx "Test"
[TestConfig]: /api/class-testconfig.mdx "TestConfig"
[TestInfo]: /api/class-testinfo.mdx "TestInfo"
[TestInfoError]: /api/class-testinfoerror.mdx "TestInfoError"
[TestOptions]: /api/class-testoptions.mdx "TestOptions"
[TestProject]: /api/class-testproject.mdx "TestProject"
[TestStepInfo]: /api/class-teststepinfo.mdx "TestStepInfo"
[WorkerInfo]: /api/class-workerinfo.mdx "WorkerInfo"
[Reporter]: /api/class-reporter.mdx "Reporter"
[Suite]: /api/class-suite.mdx "Suite"
[TestCase]: /api/class-testcase.mdx "TestCase"
[TestError]: /api/class-testerror.mdx "TestError"
[TestResult]: /api/class-testresult.mdx "TestResult"
[TestStep]: /api/class-teststep.mdx "TestStep"
[EvaluationArgument]: /evaluating.mdx#evaluation-argument "EvaluationArgument"
[UIEvent.detail]: https://developer.mozilla.org/en-US/docs/Web/API/UIEvent/detail "UIEvent.detail"


[all available image tags]: https://mcr.microsoft.com/en-us/product/playwright/about "all available image tags"
[Microsoft Artifact Registry]: https://mcr.microsoft.com/en-us/product/playwright/about "Microsoft Artifact Registry"
[Dockerfile.noble]: https://github.com/microsoft/playwright/blob/main/utils/docker/Dockerfile.noble "Dockerfile.noble"

```dart
Request get request
```

### `abort`

*⚙️ Method*

Aborts the route's request.

**Usage**

```dart
await route.abort();
await route.abort(errorCode);
```

**Arguments**
- `errorCode` String *(optional)*

Optional error code. Defaults to `failed`, could be one of the following:
* `'aborted'` - An operation was aborted (due to user action)
* `'accessdenied'` - Permission to access a resource, other than the network, was denied
* `'addressunreachable'` - The IP address is unreachable. This usually means that there is no route to the specified host or network.
* `'blockedbyclient'` - The client chose to block the request.
* `'blockedbyresponse'` - The request failed because the response was delivered along with requirements which are not met ('X-Frame-Options' and 'Content-Security-Policy' ancestor checks, for instance).
* `'connectionaborted'` - A connection timed out as a result of not receiving an ACK for data sent.
* `'connectionclosed'` - A connection was closed (corresponding to a TCP FIN).
* `'connectionfailed'` - A connection attempt failed.
* `'connectionrefused'` - A connection attempt was refused.
* `'connectionreset'` - A connection was reset (corresponding to a TCP RST).
* `'internetdisconnected'` - The Internet connection has been lost.
* `'namenotresolved'` - The host name could not be resolved.
* `'timedout'` - An operation timed out.
* `'failed'` - A generic failure occurred.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> abort(
```

### `fulfill`

*⚙️ Method*

Fulfills route's request with given response.

**Usage**

An example of fulfilling all requests with 404 responses:

```dart
await page.route('**/*', (route) async {
await route.fulfill(
status: 404,
contentType: 'text/plain',
body: 'Not Found!'
);
);
```

An example of serving static file:

```dart
await page.route('**/xhr_endpoint', (route) => route.fulfill( path: 'mock_data.json' ));
```

**Arguments**
- `options` Map *(optional)*
- `body` String *(optional)*

Response body.
- `contentType` String *(optional)*

If set, equals to setting `Content-Type` response header.
- `headers` List&lt;NameValue&gt; *(optional)*

Response headers. Header values will be converted to a string.
- `json` [Serializable] *(optional)*

JSON response. This method will set the content type to `application/json` if not set.
- `path` String *(optional)*

File path to respond with. The content type will be inferred from file extension. If `path` is a relative path, then it is resolved relative to the current working directory.
- `response` [APIResponse] *(optional)*

[APIResponse] to fulfill route's request with. Individual fields of the response (such as headers) can be overridden using fulfill options.
- `status` int *(optional)*

Response status code, defaults to `200`.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> fulfill(
```

### `fallback`

*⚙️ Method*

Continues route's request with optional overrides. The method is similar to [route.continue()] with the difference that other matching handlers will be invoked before sending the request.

**Usage**

When several routes match the given pattern, they run in the order opposite to their registration. That way the last registered route can always override all the previous ones. In the example below, request will be handled by the bottom-most handler first, then it'll fall back to the previous one and in the end will be aborted by the first registered route.

```dart
await page.route('**/*', (route) async {
// Runs last.
await route.abort();
);
await page.route('**/*', (route) async {
// Runs second.
await route.fallback();
);
await page.route('**/*', (route) async {
// Runs first.
await route.fallback();
);
```

Registering multiple routes is useful when you want separate handlers to handle different kinds of requests, for example API calls vs page resources or GET requests vs POST requests as in the example below.

```dart
// Handle GET requests.
await page.route('**/*', (route) async {
if (route.request().method() != 'GET') {
await route.fallback();
return;
}
// Handling GET only.
// ...
);

// Handle POST requests.
await page.route('**/*', (route) async {
if (route.request().method() != 'POST') {
await route.fallback();
return;
}
// Handling POST only.
// ...
);
```

One can also modify request while falling back to the subsequent handler, that way intermediate route handler can modify url, method, headers and postData of the request.

```dart
await page.route('**/*', (route, request) async {
// Override headers
final headers = {
...request.headers(),
foo: 'foo-value', // set "foo" header
bar: undefined, // remove "bar" header
};
await route.fallback( headers );
);
```

Use [route.continue()] to immediately send the request to the network, other matching handlers won't be invoked in that case.

**Arguments**
- `options` Map *(optional)*
- `headers` List&lt;NameValue&gt; *(optional)*

If set changes the request HTTP headers. Header values will be converted to a string.
- `method` String *(optional)*

If set changes the request method (e.g. GET or POST).
- `postData` String *(optional)*

If set changes the post data of request.
- `url` String *(optional)*

If set changes the request URL. New URL must have same protocol as original one. Changing the URL won't affect the route matching, all the routes are matched using the original request URL.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> fallback(
```

## `RouteHandlerEntry`

```dart
class RouteHandlerEntry
```

## `RouteManager`

Tracks route handlers and dispatches incoming routes to matching handlers.

```dart
class RouteManager
```

## `RouteListener`

Attaches a single route-event listener and forwards events to [manager].

```dart
class RouteListener
```

## `SocksSupport`

Interface for SocksSupport

```dart
abstract interface class SocksSupport
```

## `PlaywrightWebSocket`

```dart
abstract interface class PlaywrightWebSocket
```

## `WebSocketRoute`

Interface for WebSocketRoute

```dart
abstract interface class WebSocketRoute
```

---

# Platform

## `Android`

Interface for Android

```dart
abstract interface class Android
```

### `devices`

*⚙️ Method*

Returns the list of detected Android devices.

**Usage**

```dart
await android.devices();
await android.devices(options);
```

**Arguments**
- `options` Map *(optional)*
- `host` String *(optional)*

Optional host to establish ADB server connection. Default to `127.0.0.1`.
- `omitDriverInstall` bool *(optional)*

Prevents automatic playwright driver installation on attach. Assumes that the drivers have been installed already.
- `port` int *(optional)*

Optional port to establish ADB server connection. Default to `5037`.

**Returns**
- Future&lt;List&lt;[AndroidDevice]&gt;&gt;

```dart
Future<List<AndroidDevice>> devices(
```

## `AndroidDevice`

Interface for AndroidDevice

```dart
abstract interface class AndroidDevice
```

### `wait`

*⚙️ Method*

Waits for the specific [selector] to either appear or disappear, depending on the [state].

**Usage**

```dart
await androidDevice.wait(selector);
await androidDevice.wait(selector, options);
```

**Arguments**
- `selector` [AndroidSelector]

Selector to wait for.
- `options` Map *(optional)*
- `state` WaitState *(optional)*

Optional state. Can be either:
* default - wait for element to be present.
* `'gone'` - wait for element to not be present.
- `timeout` double *(optional)*

Maximum time in milliseconds, defaults to 30 seconds, pass `0` to disable timeout. The default value can be changed by using the [androidDevice.setDefaultTimeout()] method.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> wait( AndroidSelector androidSelector,
```

### `fill`

*⚙️ Method*

Fills the specific [selector] input box with [text].

**Usage**

```dart
await androidDevice.fill(selector, text);
await androidDevice.fill(selector, text, options);
```

**Arguments**
- `selector` [AndroidSelector]

Selector to fill.
- `text` String

Text to be filled in the input box.
- `options` Map *(optional)*
- `timeout` double *(optional)*

Maximum time in milliseconds, defaults to 30 seconds, pass `0` to disable timeout. The default value can be changed by using the [androidDevice.setDefaultTimeout()] method.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> fill( AndroidSelector androidSelector, String text,
```

### `tap`

*⚙️ Method*

Taps on the widget defined by [selector].

**Usage**

```dart
await androidDevice.tap(selector);
await androidDevice.tap(selector, options);
```

**Arguments**
- `selector` [AndroidSelector]

Selector to tap on.
- `options` Map *(optional)*
- `duration` double *(optional)*

Optional duration of the tap in milliseconds.
- `timeout` double *(optional)*

Maximum time in milliseconds, defaults to 30 seconds, pass `0` to disable timeout. The default value can be changed by using the [androidDevice.setDefaultTimeout()] method.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> tap( AndroidSelector androidSelector,
```

### `drag`

*⚙️ Method*

Drags the widget defined by [selector] towards [dest] point.

**Usage**

```dart
await androidDevice.drag(selector, dest);
await androidDevice.drag(selector, dest, options);
```

**Arguments**
- `selector` [AndroidSelector]

Selector to drag.
- `dest` Point
- `x` num


- `y` num


Point to drag to.
- `options` Map *(optional)*
- `speed` double *(optional)*

Optional speed of the drag in pixels per second.
- `timeout` double *(optional)*

Maximum time in milliseconds, defaults to 30 seconds, pass `0` to disable timeout. The default value can be changed by using the [androidDevice.setDefaultTimeout()] method.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> drag( AndroidSelector androidSelector, Point dest,
```

### `fling`

*⚙️ Method*

Flings the widget defined by [selector] in  the specified [direction].

**Usage**

```dart
await androidDevice.fling(selector, direction);
await androidDevice.fling(selector, direction, options);
```

**Arguments**
- `selector` [AndroidSelector]

Selector to fling.
- `direction` Direction

Fling direction.
- `options` Map *(optional)*
- `speed` double *(optional)*

Optional speed of the fling in pixels per second.
- `timeout` double *(optional)*

Maximum time in milliseconds, defaults to 30 seconds, pass `0` to disable timeout. The default value can be changed by using the [androidDevice.setDefaultTimeout()] method.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> fling( AndroidSelector androidSelector, Direction direction,
```

### `longTap`

*⚙️ Method*

Performs a long tap on the widget defined by [selector].

**Usage**

```dart
await androidDevice.longTap(selector);
await androidDevice.longTap(selector, options);
```

**Arguments**
- `selector` [AndroidSelector]

Selector to tap on.
- `options` Map *(optional)*
- `timeout` double *(optional)*

Maximum time in milliseconds, defaults to 30 seconds, pass `0` to disable timeout. The default value can be changed by using the [androidDevice.setDefaultTimeout()] method.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> longTap(AndroidSelector androidSelector,
```

### `pinchClose`

*⚙️ Method*

Pinches the widget defined by [selector] in the closing direction.

**Usage**

```dart
await androidDevice.pinchClose(selector, percent);
await androidDevice.pinchClose(selector, percent, options);
```

**Arguments**
- `selector` [AndroidSelector]

Selector to pinch close.
- `percent` double

The size of the pinch as a percentage of the widget's size.
- `options` Map *(optional)*
- `speed` double *(optional)*

Optional speed of the pinch in pixels per second.
- `timeout` double *(optional)*

Maximum time in milliseconds, defaults to 30 seconds, pass `0` to disable timeout. The default value can be changed by using the [androidDevice.setDefaultTimeout()] method.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> pinchClose( AndroidSelector androidSelector, double percent,
```

### `pinchOpen`

*⚙️ Method*

Pinches the widget defined by [selector] in the open direction.

**Usage**

```dart
await androidDevice.pinchOpen(selector, percent);
await androidDevice.pinchOpen(selector, percent, options);
```

**Arguments**
- `selector` [AndroidSelector]

Selector to pinch open.
- `percent` double

The size of the pinch as a percentage of the widget's size.
- `options` Map *(optional)*
- `speed` double *(optional)*

Optional speed of the pinch in pixels per second.
- `timeout` double *(optional)*

Maximum time in milliseconds, defaults to 30 seconds, pass `0` to disable timeout. The default value can be changed by using the [androidDevice.setDefaultTimeout()] method.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> pinchOpen( AndroidSelector androidSelector, double percent,
```

### `scroll`

*⚙️ Method*

Scrolls the widget defined by [selector] in  the specified [direction].

**Usage**

```dart
await androidDevice.scroll(selector, direction, percent);
await androidDevice.scroll(selector, direction, percent, options);
```

**Arguments**
- `selector` [AndroidSelector]

Selector to scroll.
- `direction` Direction

Scroll direction.
- `percent` double

Distance to scroll as a percentage of the widget's size.
- `options` Map *(optional)*
- `speed` double *(optional)*

Optional speed of the scroll in pixels per second.
- `timeout` double *(optional)*

Maximum time in milliseconds, defaults to 30 seconds, pass `0` to disable timeout. The default value can be changed by using the [androidDevice.setDefaultTimeout()] method.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> scroll( AndroidSelector androidSelector, Direction direction, double percent,
```

### `swipe`

*⚙️ Method*

Swipes the widget defined by [selector] in  the specified [direction].

**Usage**

```dart
await androidDevice.swipe(selector, direction, percent);
await androidDevice.swipe(selector, direction, percent, options);
```

**Arguments**
- `selector` [AndroidSelector]

Selector to swipe.
- `direction` Direction

Swipe direction.
- `percent` double

Distance to swipe as a percentage of the widget's size.
- `options` Map *(optional)*
- `speed` double *(optional)*

Optional speed of the swipe in pixels per second.
- `timeout` double *(optional)*

Maximum time in milliseconds, defaults to 30 seconds, pass `0` to disable timeout. The default value can be changed by using the [androidDevice.setDefaultTimeout()] method.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> swipe( AndroidSelector androidSelector, Direction direction, double percent,
```

### `info`

*⚙️ Method*

Returns information about a widget defined by [selector].

**Usage**

```dart
await androidDevice.info(selector);
```

**Arguments**
- `selector` [AndroidSelector]

Selector to return information about.

**Returns**
- Future&lt;[AndroidElementInfo]&gt;

```dart
Future<AndroidDeviceInfoResult> info(AndroidSelector androidSelector)
```

### `screenshot`

*⚙️ Method*

Returns the buffer with the captured screenshot of the device.

**Usage**

```dart
await androidDevice.screenshot();
await androidDevice.screenshot(options);
```

**Arguments**
- `options` Map *(optional)*
- `path` String *(optional)*

The file path to save the image to. If [path] is a relative path, then it is resolved relative to the current working directory. If no path is provided, the image won't be saved to the disk.

**Returns**
- Future&lt;List&lt;int&gt;&gt;

```dart
Future<AndroidDeviceScreenshotResult> screenshot()
```

### `launchBrowser`

*⚙️ Method*

Launches Chrome browser on the device, and returns its persistent context.

**Usage**

```dart
await androidDevice.launchBrowser();
await androidDevice.launchBrowser(options);
```

**Arguments**
- `options` Map *(optional)*
- `acceptDownloads` bool *(optional)*

Whether to automatically download all the attachments. Defaults to `true` where all the downloads are accepted.
- `args` List&lt;String&gt; *(optional)*

**WARNING**
Use custom browser args at your own risk, as some of them may break Playwright functionality.
Additional arguments to pass to the browser instance. The list of Chromium flags can be found [here].
- `baseURL` String *(optional)*

When using [page.goto()], [page.route()], [page.waitForURL()], [page.waitForRequest()], or [page.waitForResponse()] it takes the base URL in consideration by using the [`URL()`] constructor for building the corresponding URL. Unset by default. Examples:
* baseURL: `http://localhost:3000` and navigating to `/bar.html` results in `http://localhost:3000/bar.html`
* baseURL: `http://localhost:3000/foo/` and navigating to `./bar.html` results in `http://localhost:3000/foo/bar.html`
* baseURL: `http://localhost:3000/foo` (without trailing slash) and navigating to `./bar.html` results in `http://localhost:3000/bar.html`
- `bypassCSP` bool *(optional)*

Toggles bypassing page's Content-Security-Policy. Defaults to `false`.
- `colorScheme` null | "light" | "dark" | "no-preference" *(optional)*

Emulates [prefers-colors-scheme] media feature, supported values are `'light'` and `'dark'`. See [page.emulateMedia()] for more details. Passing `null` resets emulation to system defaults. Defaults to `'light'`.
- `contrast` null | "no-preference" | "more" *(optional)*

Emulates `'prefers-contrast'` media feature, supported values are `'no-preference'`, `'more'`. See [page.emulateMedia()] for more details. Passing `null` resets emulation to system defaults. Defaults to `'no-preference'`.
- `deviceScaleFactor` num *(optional)*

Specify device scale factor (can be thought of as dpr). Defaults to `1`. Learn more about [emulating devices with device scale factor].
- `extraHTTPHeaders` Map&lt;String, String&gt; *(optional)*

An object containing additional HTTP headers to be sent with every request. Defaults to none.
- `forcedColors` null | "active" | "none" *(optional)*

Emulates `'forced-colors'` media feature, supported values are `'active'`, `'none'`. See [page.emulateMedia()] for more details. Passing `null` resets emulation to system defaults. Defaults to `'none'`.
- `geolocation` Map *(optional)*
- `latitude` num

Latitude between -90 and 90.
- `longitude` num

Longitude between -180 and 180.
- `accuracy` num *(optional)*

Non-negative accuracy value. Defaults to `0`.
- `hasTouch` bool *(optional)*

Specifies if viewport supports touch events. Defaults to false. Learn more about [mobile emulation].
- `httpCredentials` Map *(optional)*
- `username` String


- `password` String


- `origin` String *(optional)*

Restrain sending http credentials on specific origin (scheme://host:port).
- `send` "unauthorized" | "always" *(optional)*

This option only applies to the requests sent from corresponding [APIRequestContext] and does not affect requests sent from the browser. `'always'` - `Authorization` header with basic authentication credentials will be sent with the each API request. `'unauthorized` - the credentials are only sent when 401 (Unauthorized) response with `WWW-Authenticate` header is received. Defaults to `'unauthorized'`.

Credentials for [HTTP authentication]. If no origin is specified, the username and password are sent to any servers upon unauthorized responses.
- `ignoreHTTPSErrors` bool *(optional)*

Whether to ignore HTTPS errors when sending network requests. Defaults to `false`.
- `isMobile` bool *(optional)*

Whether the `meta viewport` tag is taken into account and touch events are enabled. isMobile is a part of device, so you don't actually need to set it manually. Defaults to `false` and is not supported in Firefox. Learn more about [mobile emulation].
- `javaScriptEnabled` bool *(optional)*

Whether or not to enable JavaScript in the context. Defaults to `true`. Learn more about [disabling JavaScript].
- `locale` String *(optional)*

Specify user locale, for example `en-GB`, `de-DE`, etc. Locale will affect `navigator.language` value, `Accept-Language` request header value as well as number and date formatting rules. Defaults to the system default locale. Learn more about emulation in our [emulation guide].
- `logger` [Logger] *(optional)*

**WARNING**
[Deprecated]
The logs received by the logger are incomplete. Please use tracing instead.
Logger sink for Playwright logging.
- `offline` bool *(optional)*

Whether to emulate network being offline. Defaults to `false`. Learn more about [network emulation].
- `permissions` List&lt;String&gt; *(optional)*

A list of permissions to grant to all pages in this context. See [browserContext.grantPermissions()] for more details. Defaults to none.
- `pkg` String *(optional)*

Optional package name to launch instead of default Chrome for Android.
- `proxy` AndroidDeviceLaunchBrowserProxy *(optional)*
- `server` String

Proxy to be used for all requests. HTTP and SOCKS proxies are supported, for example `http://myproxy.com:3128` or `socks5://myproxy.com:3128`. Short form `myproxy.com:3128` is considered an HTTP proxy.
- `bypass` String *(optional)*

Optional comma-separated domains to bypass proxy, for example `".com, chromium.org, .domain.com"`.
- `username` String *(optional)*

Optional username to use if HTTP proxy requires authentication.
- `password` String *(optional)*

Optional password to use if HTTP proxy requires authentication.

Network proxy settings.
- `recordHar` Map *(optional)*
- `omitContent` bool *(optional)*

Optional setting to control whether to omit request content from the HAR. Defaults to `false`. Deprecated, use `content` policy instead.
- `content` "omit" | "embed" | "attach" *(optional)*

Optional setting to control resource content management. If `omit` is specified, content is not persisted. If `attach` is specified, resources are persisted as separate files or entries in the ZIP archive. If `embed` is specified, content is stored inline the HAR file as per HAR specification. Defaults to `attach` for `.zip` output files and to `embed` for all other file extensions.
- `path` String

Path on the filesystem to write the HAR file to. If the file name ends with `.zip`, `content: 'attach'` is used by default.
- `mode` "full" | "minimal" *(optional)*

When set to `minimal`, only record information necessary for routing from HAR. This omits sizes, timing, page, cookies, security and other types of HAR information that are not used when replaying from HAR. Defaults to `full`.
- `urlFilter` String | [RegExp] *(optional)*

A glob or regex pattern to filter requests that are stored in the HAR. When a [baseURL] via the context options was provided and the passed URL is a path, it gets merged via the [`new URL()`] constructor. Defaults to none.

Enables [HAR] recording for all pages into `recordHar.path` file. If not specified, the HAR is not recorded. Make sure to await [browserContext.close()] for the HAR to be saved.
- `recordVideo` Map *(optional)*
- `dir` String *(optional)*

Path to the directory to put videos into. If not specified, the videos will be stored in `artifactsDir` (see [browserType.launch()] options).
- `size` Map *(optional)*
- `width` num

Video frame width.
- `height` num

Video frame height.

Optional dimensions of the recorded videos. If not specified the size will be equal to `viewport` scaled down to fit into 800x800. If `viewport` is not configured explicitly the video size defaults to 800x450. Actual picture of each page will be scaled down if necessary to fit the specified size.
- `showActions` Map *(optional)*
- `duration` num *(optional)*

How long each annotation is displayed in milliseconds. Defaults to `500`.
- `position` "top-left" | "top" | "top-right" | "bottom-left" | "bottom" | "bottom-right" *(optional)*

Position of the action title overlay. Defaults to `"top-right"`.
- `fontSize` num *(optional)*

Font size of the action title in pixels. Defaults to `24`.

If specified, enables visual annotations on interacted elements during video recording.

Enables video recording for all pages into `recordVideo.dir` directory. If not specified videos are not recorded. Make sure to await [browserContext.close()] for videos to be saved.
- `reducedMotion` null | "reduce" | "no-preference" *(optional)*

Emulates `'prefers-reduced-motion'` media feature, supported values are `'reduce'`, `'no-preference'`. See [page.emulateMedia()] for more details. Passing `null` resets emulation to system defaults. Defaults to `'no-preference'`.
- `screen` Map *(optional)*
- `width` num

page width in pixels.
- `height` num

page height in pixels.

Emulates consistent window screen size available inside web page via `window.screen`. Is only used when the [viewport] is set.
- `serviceWorkers` "allow" | "block" *(optional)*

Whether to allow sites to register Service workers. Defaults to `'allow'`.
* `'allow'`: [Service Workers] can be registered.
* `'block'`: Playwright will block all registration of Service Workers.
- `strictSelectors` bool *(optional)*

If set to true, enables strict selectors mode for this context. In the strict selectors mode all operations on selectors that imply single target DOM element will throw when more than one element matches the selector. This option does not affect any Locator APIs (Locators are always strict). Defaults to `false`. See [Locator] to learn more about the strict mode.
- `timezoneId` String *(optional)*

Changes the timezone of the context. See [ICU's metaZones.txt] for a list of supported timezone IDs. Defaults to the system timezone.
- `userAgent` String *(optional)*

Specific user agent to use in this context.
- `viewport` [Map]? *(optional)*
- `width` num

page width in pixels.
- `height` num

page height in pixels.

Emulates consistent viewport for each page. Defaults to an 1280x720 viewport. Use `null` to disable the consistent viewport emulation. Learn more about [viewport emulation].

**NOTE**
The `null` value opts out from the default presets, makes viewport depend on the host window size defined by the operating system. It makes the execution of the tests non-deterministic.
**Returns**
- Future&lt;[BrowserContext]&gt;

```dart
Future<BrowserContext> launchBrowser(
```

### `open`

*⚙️ Method*

Launches a process in the shell on the device and returns a socket to communicate with the launched process.

**Usage**

```dart
await androidDevice.open(command);
```

**Arguments**
- `command` String

Shell command to execute.

**Returns**
- Future&lt;[AndroidSocket]&gt;

```dart
Future<AndroidDeviceOpenResult> open(String command)
```

### `shell`

*⚙️ Method*

Executes a shell command on the device and returns its output.

**Usage**

```dart
await androidDevice.shell(command);
```

**Arguments**
- `command` String

Shell command to execute.

**Returns**
- Future&lt;List&lt;int&gt;&gt;

```dart
Future<AndroidDeviceShellResult> shell(String command)
```

### `installApk`

*⚙️ Method*

Installs an apk on the device.

**Usage**

```dart
await androidDevice.installApk(file);
await androidDevice.installApk(file, options);
```

**Arguments**
- `file` String

Either a path to the apk file, or apk file content.
- `options` Map *(optional)*
- `args` List&lt;String&gt; *(optional)*

Optional arguments to pass to the `shell:cmd package install` call. Defaults to `-r -t -S`.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> installApk(String file,
```

### `push`

*⚙️ Method*

Copies a file to the device.

**Usage**

```dart
await androidDevice.push(file, path);
await androidDevice.push(file, path, options);
```

**Arguments**
- `file` String

Either a path to the file, or file content.
- `path` String

Path to the file on the device.
- `options` Map *(optional)*
- `mode` int *(optional)*

Optional file mode, defaults to `644` (`rw-r--r--`).

**Returns**
- Future&lt;void&gt;

```dart
Future<void> push(String file, String path,
```

### `close`

*⚙️ Method*

Disconnects from the device.

**Usage**

```dart
await androidDevice.close();
```

**Returns**
- Future&lt;void&gt;

```dart
Future<void> close()
```

## `AndroidSocket`

Interface for AndroidSocket

```dart
abstract interface class AndroidSocket
```

### `write`

*⚙️ Method*

Writes some [data] to the socket.

**Usage**

```dart
await androidSocket.write(data);
```

**Arguments**
- `data` String

Data to write.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> write(String data)
```

### `close`

*⚙️ Method*

Closes the socket.

**Usage**

```dart
await androidSocket.close();
```

**Returns**
- Future&lt;void&gt;

```dart
Future<void> close()
```

## `Electron`

Interface for Electron

```dart
abstract interface class Electron
```

### `launch`

*⚙️ Method*

Launches electron application specified with the [executablePath].

**Usage**

```dart
await electron.launch();
await electron.launch(options);
```

**Arguments**
- `options` Map *(optional)*
- `acceptDownloads` Downloads *(optional)*

Whether to automatically download all the attachments. Defaults to `true` where all the downloads are accepted.
- `args` List&lt;String&gt; *(optional)*

Additional arguments to pass to the application when launching. You typically pass the main script name here.
- `artifactsDir` String *(optional)*

If specified, artifacts (traces, videos, downloads, HAR files, etc.) are saved into this directory. The directory is not cleaned up when the browser closes. If not specified, a temporary directory is used and cleaned up when the browser closes.
- `bypassCSP` bool *(optional)*

Toggles bypassing page's Content-Security-Policy. Defaults to `false`.
- `chromiumSandbox` bool *(optional)*

Enable Chromium sandboxing. Defaults to `false`.
- `colorScheme` Scheme *(optional)*

Emulates [prefers-colors-scheme] media feature, supported values are `'light'` and `'dark'`. See [page.emulateMedia()] for more details. Passing `null` resets emulation to system defaults. Defaults to `'light'`.
- `cwd` String *(optional)*

Current working directory to launch application from.
- `env` List&lt;NameValue&gt; *(optional)*

Specifies environment variables that will be visible to Electron. Defaults to `process.env`.
- `executablePath` String *(optional)*

Launches given Electron application. If not specified, launches the default Electron executable installed in this package, located at `node_modules/.bin/electron`.
- `extraHTTPHeaders` List&lt;NameValue&gt; *(optional)*

An object containing additional HTTP headers to be sent with every request. Defaults to none.
- `geolocation` Map&lt;String, dynamic&gt; *(optional)*
- `latitude` num

Latitude between -90 and 90.
- `longitude` num

Longitude between -180 and 180.
- `accuracy` num *(optional)*

Non-negative accuracy value. Defaults to `0`.
- `httpCredentials` Map&lt;String, dynamic&gt; *(optional)*
- `username` String


- `password` String


- `origin` String *(optional)*

Restrain sending http credentials on specific origin (scheme://host:port).
- `send` "unauthorized" | "always" *(optional)*

This option only applies to the requests sent from corresponding [APIRequestContext] and does not affect requests sent from the browser. `'always'` - `Authorization` header with basic authentication credentials will be sent with the each API request. `'unauthorized` - the credentials are only sent when 401 (Unauthorized) response with `WWW-Authenticate` header is received. Defaults to `'unauthorized'`.

Credentials for [HTTP authentication]. If no origin is specified, the username and password are sent to any servers upon unauthorized responses.
- `ignoreHTTPSErrors` bool *(optional)*

Whether to ignore HTTPS errors when sending network requests. Defaults to `false`.
- `locale` String *(optional)*

Specify user locale, for example `en-GB`, `de-DE`, etc. Locale will affect `navigator.language` value, `Accept-Language` request header value as well as number and date formatting rules. Defaults to the system default locale. Learn more about emulation in our [emulation guide].
- `offline` bool *(optional)*

Whether to emulate network being offline. Defaults to `false`. Learn more about [network emulation].
- `recordHar` Map *(optional)*
- `omitContent` bool *(optional)*

Optional setting to control whether to omit request content from the HAR. Defaults to `false`. Deprecated, use `content` policy instead.
- `content` "omit" | "embed" | "attach" *(optional)*

Optional setting to control resource content management. If `omit` is specified, content is not persisted. If `attach` is specified, resources are persisted as separate files or entries in the ZIP archive. If `embed` is specified, content is stored inline the HAR file as per HAR specification. Defaults to `attach` for `.zip` output files and to `embed` for all other file extensions.
- `path` String

Path on the filesystem to write the HAR file to. If the file name ends with `.zip`, `content: 'attach'` is used by default.
- `mode` "full" | "minimal" *(optional)*

When set to `minimal`, only record information necessary for routing from HAR. This omits sizes, timing, page, cookies, security and other types of HAR information that are not used when replaying from HAR. Defaults to `full`.
- `urlFilter` String | [RegExp] *(optional)*

A glob or regex pattern to filter requests that are stored in the HAR. When a [baseURL] via the context options was provided and the passed URL is a path, it gets merged via the [`new URL()`] constructor. Defaults to none.

Enables [HAR] recording for all pages into `recordHar.path` file. If not specified, the HAR is not recorded. Make sure to await [browserContext.close()] for the HAR to be saved.
- `recordVideo` Map&lt;String, dynamic&gt; *(optional)*
- `dir` String *(optional)*

Path to the directory to put videos into. If not specified, the videos will be stored in `artifactsDir` (see [browserType.launch()] options).
- `size` Map *(optional)*
- `width` num

Video frame width.
- `height` num

Video frame height.

Optional dimensions of the recorded videos. If not specified the size will be equal to `viewport` scaled down to fit into 800x800. If `viewport` is not configured explicitly the video size defaults to 800x450. Actual picture of each page will be scaled down if necessary to fit the specified size.
- `showActions` Map *(optional)*
- `duration` num *(optional)*

How long each annotation is displayed in milliseconds. Defaults to `500`.
- `position` "top-left" | "top" | "top-right" | "bottom-left" | "bottom" | "bottom-right" *(optional)*

Position of the action title overlay. Defaults to `"top-right"`.
- `fontSize` num *(optional)*

Font size of the action title in pixels. Defaults to `24`.

If specified, enables visual annotations on interacted elements during video recording.

Enables video recording for all pages into `recordVideo.dir` directory. If not specified videos are not recorded. Make sure to await [browserContext.close()] for videos to be saved.
- `timeout` double *(optional)*

Maximum time in milliseconds to wait for the application to start. Defaults to `30000` (30 seconds). Pass `0` to disable timeout.
- `timezoneId` String *(optional)*

Changes the timezone of the context. See [ICU's metaZones.txt] for a list of supported timezone IDs. Defaults to the system timezone.
- `tracesDir` String *(optional)*

If specified, traces are saved into this directory.

**Returns**
- Future&lt;[ElectronApplication]&gt;


[APIRequest]: /api/class-apirequest.mdx "APIRequest"
[APIRequestContext]: /api/class-apirequestcontext.mdx "APIRequestContext"
[APIResponse]: /api/class-apiresponse.mdx "APIResponse"
[APIResponseAssertions]: /api/class-apiresponseassertions.mdx "APIResponseAssertions"
[Browser]: /api/class-browser.mdx "Browser"
[BrowserContext]: /api/class-browsercontext.mdx "BrowserContext"
[BrowserServer]: /api/class-browserserver.mdx "BrowserServer"
[BrowserType]: /api/class-browsertype.mdx "BrowserType"
[CDPSession]: /api/class-cdpsession.mdx "CDPSession"
[Clock]: /api/class-clock.mdx "Clock"
[ConsoleMessage]: /api/class-consolemessage.mdx "ConsoleMessage"
[Coverage]: /api/class-coverage.mdx "Coverage"
[Credentials]: /api/class-credentials.mdx "Credentials"
[Debugger]: /api/class-debugger.mdx "Debugger"
[Dialog]: /api/class-dialog.mdx "Dialog"
[Disposable]: /api/class-disposable.mdx "Disposable"
[Download]: /api/class-download.mdx "Download"
[ElementHandle]: /api/class-elementhandle.mdx "ElementHandle"
[FileChooser]: /api/class-filechooser.mdx "FileChooser"
[Frame]: /api/class-frame.mdx "Frame"
[FrameLocator]: /api/class-framelocator.mdx "FrameLocator"
[GenericAssertions]: /api/class-genericassertions.mdx "GenericAssertions"
[JSHandle]: /api/class-jshandle.mdx "JSHandle"
[Keyboard]: /api/class-keyboard.mdx "Keyboard"
[Locator]: /api/class-locator.mdx "Locator"
[LocatorAssertions]: /api/class-locatorassertions.mdx "LocatorAssertions"
[Logger]: /api/class-logger.mdx "Logger"
[Mouse]: /api/class-mouse.mdx "Mouse"
[Page]: /api/class-page.mdx "Page"
[PageAssertions]: /api/class-pageassertions.mdx "PageAssertions"
[Playwright]: /api/class-playwright.mdx "Playwright"
[PlaywrightAssertions]: /api/class-playwrightassertions.mdx "PlaywrightAssertions"
[Request]: /api/class-request.mdx "Request"
[Response]: /api/class-response.mdx "Response"
[Route]: /api/class-route.mdx "Route"
[Screencast]: /api/class-screencast.mdx "Screencast"
[Selectors]: /api/class-selectors.mdx "Selectors"
[SnapshotAssertions]: /api/class-snapshotassertions.mdx "SnapshotAssertions"
[TimeoutError]: /api/class-timeouterror.mdx "TimeoutError"
[Touchscreen]: /api/class-touchscreen.mdx "Touchscreen"
[Tracing]: /api/class-tracing.mdx "Tracing"
[Video]: /api/class-video.mdx "Video"
[WebError]: /api/class-weberror.mdx "WebError"
[WebSocket]: /api/class-websocket.mdx "WebSocket"
[WebSocketRoute]: /api/class-websocketroute.mdx "WebSocketRoute"
[WebStorage]: /api/class-webstorage.mdx "WebStorage"
[Worker]: /api/class-worker.mdx "Worker"
[Electron]: /api/class-electron.mdx "Electron"
[ElectronApplication]: /api/class-electronapplication.mdx "ElectronApplication"
[Android]: /api/class-android.mdx "Android"
[AndroidDevice]: /api/class-androiddevice.mdx "AndroidDevice"
[AndroidInput]: /api/class-androidinput.mdx "AndroidInput"
[AndroidSocket]: /api/class-androidsocket.mdx "AndroidSocket"
[AndroidWebView]: /api/class-androidwebview.mdx "AndroidWebView"
[Fixtures]: /api/class-fixtures.mdx "Fixtures"
[FullConfig]: /api/class-fullconfig.mdx "FullConfig"
[FullProject]: /api/class-fullproject.mdx "FullProject"
[Location]: /api/class-location.mdx "Location"
[Test]: /api/class-test.mdx "Test"
[TestConfig]: /api/class-testconfig.mdx "TestConfig"
[TestInfo]: /api/class-testinfo.mdx "TestInfo"
[TestInfoError]: /api/class-testinfoerror.mdx "TestInfoError"
[TestOptions]: /api/class-testoptions.mdx "TestOptions"
[TestProject]: /api/class-testproject.mdx "TestProject"
[TestStepInfo]: /api/class-teststepinfo.mdx "TestStepInfo"
[WorkerInfo]: /api/class-workerinfo.mdx "WorkerInfo"
[Reporter]: /api/class-reporter.mdx "Reporter"
[Suite]: /api/class-suite.mdx "Suite"
[TestCase]: /api/class-testcase.mdx "TestCase"
[TestError]: /api/class-testerror.mdx "TestError"
[TestResult]: /api/class-testresult.mdx "TestResult"
[TestStep]: /api/class-teststep.mdx "TestStep"
[EvaluationArgument]: /evaluating.mdx#evaluation-argument "EvaluationArgument"
[UIEvent.detail]: https://developer.mozilla.org/en-US/docs/Web/API/UIEvent/detail "UIEvent.detail"


[all available image tags]: https://mcr.microsoft.com/en-us/product/playwright/about "all available image tags"
[Microsoft Artifact Registry]: https://mcr.microsoft.com/en-us/product/playwright/about "Microsoft Artifact Registry"
[Dockerfile.noble]: https://github.com/microsoft/playwright/blob/main/utils/docker/Dockerfile.noble "Dockerfile.noble"

```dart
Future<ElectronLaunchResult> launch(
```

## `ElectronApplication`

Interface for ElectronApplication

```dart
abstract interface class ElectronApplication
```

### `browserWindow`

*⚙️ Method*

Returns the BrowserWindow object that corresponds to the given Playwright page.

**Usage**

```dart
await electronApplication.browserWindow(page);
```

**Arguments**
- `page` PageBase

Page to retrieve the window for.

**Returns**
- Future&lt;[JSHandle]&gt;

```dart
Future<ElectronApplicationBrowserWindowResult> browserWindow(PageBase page)
```

---

# Utilities

## `Artifact`

Interface for Artifact

```dart
abstract interface class Artifact
```

## `CDPSession`

Interface for CDPSession

```dart
abstract interface class CDPSession
```

### `send`

*⚙️ Method*

**Usage**

```dart
await cdpSession.send(method);
await cdpSession.send(method, params);
```

**Arguments**
- `method` String

Protocol method name.
- `params` Map&lt;String, dynamic&gt; *(optional)*

Optional method parameters.

**Returns**
- Future&lt;Map&gt;

```dart
Future<Map<String, dynamic>> send( String method,
```

### `detach`

*⚙️ Method*

Detaches the CDPSession from the target. Once detached, the CDPSession object won't emit any events and can't be used to send messages.

**Usage**

```dart
await cdpSession.detach();
```

**Returns**
- Future&lt;void&gt;

```dart
Future<void> detach()
```

## `Clock`

Clock API for mocking time in browser contexts.

```dart
abstract interface class Clock
```

### `install`

*⚙️ Method*

Install fake implementations for the following time-related functions:
* `Date`
* `setTimeout`
* `clearTimeout`
* `setInterval`
* `clearInterval`
* `requestAnimationFrame`
* `cancelAnimationFrame`
* `requestIdleCallback`
* `cancelIdleCallback`
* `performance`

Fake timers are used to manually control the flow of time in tests. They allow you to advance time, fire timers, and control the behavior of time-dependent functions. See [clock.runFor()] and [clock.fastForward()] for more information.

**Usage**

```dart
await clock.install();
await clock.install(options);
```

**Arguments**
- `options` Map *(optional)*
- `time` num | String | [Date] *(optional)*

Time to initialize with, current system time by default.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> install(
```

### `fastForward`

*⚙️ Method*

Advance the clock by jumping forward in time. Only fires due timers at most once. This is equivalent to user closing the laptop lid for a while and reopening it later, after given time.

**Usage**

```dart
await page.clock.fastForward(1000);
await page.clock.fastForward('30:00');
```

**Arguments**
- `ticks` num | String

Time may be the number of milliseconds to advance the clock by or a human-readable string. Valid string formats are "08" for eight seconds, "01:00" for one minute and "02:34:10" for two hours, 34 minutes and ten seconds.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> fastForward(
```

### `pauseAt`

*⚙️ Method*

Advance the clock by jumping forward in time and pause the time. Once this method is called, no timers are fired unless [clock.runFor()], [clock.fastForward()], [clock.pauseAt()] or [clock.resume()] is called.

Only fires due timers at most once. This is equivalent to user closing the laptop lid for a while and reopening it at the specified time and pausing.

**Usage**

```dart
await page.clock.pauseAt(new Date('2020-02-02'));
await page.clock.pauseAt('2020-02-02');
```

For best results, install the clock before navigating the page and set it to a time slightly before the intended test time. This ensures that all timers run normally during page loading, preventing the page from getting stuck. Once the page has fully loaded, you can safely use [clock.pauseAt()] to pause the clock.

```dart
// Initialize clock with some time before the test time and var the page load
// naturally. `Date.now` will progress as the timers fire.
await page.clock.install( time: new Date('2024-12-10T08:00:00') );
await page.goto('http://localhost:3333');
await page.clock.pauseAt(new Date('2024-12-10T10:00:00'));
```

**Arguments**
- `time` num | String | [Date]

Time to pause at.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> pauseAt(
```

### `resume`

*⚙️ Method*

Resumes timers. Once this method is called, time resumes flowing, timers are fired as usual.

**Usage**

```dart
await clock.resume();
```

**Returns**
- Future&lt;void&gt;

```dart
Future<void> resume()
```

### `runFor`

*⚙️ Method*

Advance the clock, firing all the time-related callbacks.

**Usage**

```dart
await page.clock.runFor(1000);
await page.clock.runFor('30:00');
```

**Arguments**
- `ticks` num | String

Time may be the number of milliseconds to advance the clock by or a human-readable string. Valid string formats are "08" for eight seconds, "01:00" for one minute and "02:34:10" for two hours, 34 minutes and ten seconds.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> runFor(
```

### `setFixedTime`

*⚙️ Method*

Makes `Date.now` and `new Date()` return fixed fake time at all times, keeps all the timers running.

Use this method for simple scenarios where you only need to test with a predefined time. For more advanced scenarios, use [clock.install()] instead. Read docs on [clock emulation] to learn more.

**Usage**

```dart
await page.clock.setFixedTime(Date.now());
await page.clock.setFixedTime(new Date('2020-02-02'));
await page.clock.setFixedTime('2020-02-02');
```

**Arguments**
- `time` num | String | [Date]

Time to be set in milliseconds.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> setFixedTime(
```

### `setSystemTime`

*⚙️ Method*

Sets system time, but does not trigger any timers. Use this to test how the web page reacts to a time shift, for example switching from summer to winter time, or changing time zones.

**Usage**

```dart
await page.clock.setSystemTime(Date.now());
await page.clock.setSystemTime(new Date('2020-02-02'));
await page.clock.setSystemTime('2020-02-02');
```

**Arguments**
- `time` num | String | [Date]

Time to be set in milliseconds.

**Returns**
- Future&lt;void&gt;


[APIRequest]: /api/class-apirequest.mdx "APIRequest"
[APIRequestContext]: /api/class-apirequestcontext.mdx "APIRequestContext"
[APIResponse]: /api/class-apiresponse.mdx "APIResponse"
[APIResponseAssertions]: /api/class-apiresponseassertions.mdx "APIResponseAssertions"
[Browser]: /api/class-browser.mdx "Browser"
[BrowserContext]: /api/class-browsercontext.mdx "BrowserContext"
[BrowserServer]: /api/class-browserserver.mdx "BrowserServer"
[BrowserType]: /api/class-browsertype.mdx "BrowserType"
[CDPSession]: /api/class-cdpsession.mdx "CDPSession"
[Clock]: /api/class-clock.mdx "Clock"
[ConsoleMessage]: /api/class-consolemessage.mdx "ConsoleMessage"
[Coverage]: /api/class-coverage.mdx "Coverage"
[Credentials]: /api/class-credentials.mdx "Credentials"
[Debugger]: /api/class-debugger.mdx "Debugger"
[Dialog]: /api/class-dialog.mdx "Dialog"
[Disposable]: /api/class-disposable.mdx "Disposable"
[Download]: /api/class-download.mdx "Download"
[ElementHandle]: /api/class-elementhandle.mdx "ElementHandle"
[FileChooser]: /api/class-filechooser.mdx "FileChooser"
[Frame]: /api/class-frame.mdx "Frame"
[FrameLocator]: /api/class-framelocator.mdx "FrameLocator"
[GenericAssertions]: /api/class-genericassertions.mdx "GenericAssertions"
[JSHandle]: /api/class-jshandle.mdx "JSHandle"
[Keyboard]: /api/class-keyboard.mdx "Keyboard"
[Locator]: /api/class-locator.mdx "Locator"
[LocatorAssertions]: /api/class-locatorassertions.mdx "LocatorAssertions"
[Logger]: /api/class-logger.mdx "Logger"
[Mouse]: /api/class-mouse.mdx "Mouse"
[Page]: /api/class-page.mdx "Page"
[PageAssertions]: /api/class-pageassertions.mdx "PageAssertions"
[Playwright]: /api/class-playwright.mdx "Playwright"
[PlaywrightAssertions]: /api/class-playwrightassertions.mdx "PlaywrightAssertions"
[Request]: /api/class-request.mdx "Request"
[Response]: /api/class-response.mdx "Response"
[Route]: /api/class-route.mdx "Route"
[Screencast]: /api/class-screencast.mdx "Screencast"
[Selectors]: /api/class-selectors.mdx "Selectors"
[SnapshotAssertions]: /api/class-snapshotassertions.mdx "SnapshotAssertions"
[TimeoutError]: /api/class-timeouterror.mdx "TimeoutError"
[Touchscreen]: /api/class-touchscreen.mdx "Touchscreen"
[Tracing]: /api/class-tracing.mdx "Tracing"
[Video]: /api/class-video.mdx "Video"
[WebError]: /api/class-weberror.mdx "WebError"
[WebSocket]: /api/class-websocket.mdx "WebSocket"
[WebSocketRoute]: /api/class-websocketroute.mdx "WebSocketRoute"
[WebStorage]: /api/class-webstorage.mdx "WebStorage"
[Worker]: /api/class-worker.mdx "Worker"
[Electron]: /api/class-electron.mdx "Electron"
[ElectronApplication]: /api/class-electronapplication.mdx "ElectronApplication"
[Android]: /api/class-android.mdx "Android"
[AndroidDevice]: /api/class-androiddevice.mdx "AndroidDevice"
[AndroidInput]: /api/class-androidinput.mdx "AndroidInput"
[AndroidSocket]: /api/class-androidsocket.mdx "AndroidSocket"
[AndroidWebView]: /api/class-androidwebview.mdx "AndroidWebView"
[Fixtures]: /api/class-fixtures.mdx "Fixtures"
[FullConfig]: /api/class-fullconfig.mdx "FullConfig"
[FullProject]: /api/class-fullproject.mdx "FullProject"
[Location]: /api/class-location.mdx "Location"
[Test]: /api/class-test.mdx "Test"
[TestConfig]: /api/class-testconfig.mdx "TestConfig"
[TestInfo]: /api/class-testinfo.mdx "TestInfo"
[TestInfoError]: /api/class-testinfoerror.mdx "TestInfoError"
[TestOptions]: /api/class-testoptions.mdx "TestOptions"
[TestProject]: /api/class-testproject.mdx "TestProject"
[TestStepInfo]: /api/class-teststepinfo.mdx "TestStepInfo"
[WorkerInfo]: /api/class-workerinfo.mdx "WorkerInfo"
[Reporter]: /api/class-reporter.mdx "Reporter"
[Suite]: /api/class-suite.mdx "Suite"
[TestCase]: /api/class-testcase.mdx "TestCase"
[TestError]: /api/class-testerror.mdx "TestError"
[TestResult]: /api/class-testresult.mdx "TestResult"
[TestStep]: /api/class-teststep.mdx "TestStep"
[EvaluationArgument]: /evaluating.mdx#evaluation-argument "EvaluationArgument"
[UIEvent.detail]: https://developer.mozilla.org/en-US/docs/Web/API/UIEvent/detail "UIEvent.detail"


[all available image tags]: https://mcr.microsoft.com/en-us/product/playwright/about "all available image tags"
[Microsoft Artifact Registry]: https://mcr.microsoft.com/en-us/product/playwright/about "Microsoft Artifact Registry"
[Dockerfile.noble]: https://github.com/microsoft/playwright/blob/main/utils/docker/Dockerfile.noble "Dockerfile.noble"

```dart
Future<void> setSystemTime(
```

## `ConsoleMessage`

`ConsoleMessage` objects are dispatched by page via the `page.onConsole` event.

```dart
class ConsoleMessage
```

## `Download`

Represents a download triggered by the page.

```dart
class Download
```

## `Logger`

Central logger for Playwright Dart.

The active level is set via [Logger.level] (defaults to [LogLevel.info]).
Use [PlaywrightDart.create] to pass a [LogLevel] at startup.

```dart
class Logger
```

### `Function`

*⚙️ Method*

Optional custom sink for testing or custom log redirection.

```dart
static void Function( String message,
```

### `trace`

*⚙️ Method*

Low-level protocol trace — only emitted at [LogLevel.trace].

```dart
static void trace(String message,
```

### `debug`

*⚙️ Method*

Debug message — emitted at [LogLevel.debug] and below.

```dart
static void debug(String message,
```

### `info`

*⚙️ Method*

Informational milestone — emitted at [LogLevel.info] and below.

```dart
static void info(String message)
```

### `warn`

*⚙️ Method*

Warning — always emitted unless level is [LogLevel.none].

```dart
static void warn(String message)
```

### `error`

*⚙️ Method*

Error — always emitted unless level is [LogLevel.none].

```dart
static void error(String message, [Object? error, StackTrace? stackTrace])
```

## `Tracing`

Interface for Tracing

```dart
abstract interface class Tracing
```

### `start`

*⚙️ Method*

Start tracing.

**NOTE**
You probably want to [enable tracing in your config file] instead of using `Tracing.start`.

The `context.tracing` API captures browser operations and network activity, but it doesn't record test assertions (like `expect` calls). We recommend [enabling tracing through Playwright Test configuration], which includes those assertions and provides a more complete trace for debugging test failures.
**Usage**

```dart
await context.tracing.start( screenshots: true, snapshots: true );
final page = await context.newPage();
await page.goto('https://playwright.dev');
expect(page.url()).toBe('https://playwright.dev');
await context.tracing.stop( path: 'trace.zip' );
```

**Arguments**
- `options` Map *(optional)*
- `live` bool *(optional)*

When enabled, the trace is written to an unarchived file that is updated in real time as actions occur, instead of caching changes and archiving them into a zip file at the end. This is useful for live trace viewing during test execution.
- `name` String *(optional)*

If specified, intermediate trace files are going to be saved into the files with the given name prefix inside the [tracesDir] directory specified in [browserType.launch()]. To specify the final trace zip file name, you need to pass `path` option to [tracing.stop()] instead.
- `screenshots` bool *(optional)*

Whether to capture screenshots during tracing. Screenshots are used to build a timeline preview.
- `snapshots` bool *(optional)*

If this option is true tracing will
* capture DOM snapshot on every action
* record network activity
- `sources` bool *(optional)*

Whether to include source files for trace actions.
- `title` String *(optional)*

Trace name to be shown in the Trace Viewer.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> start(
```

### `startChunk`

*⚙️ Method*

Start a new trace chunk. If you'd like to record multiple traces on the same [BrowserContext], use [tracing.start()] once, and then create multiple trace chunks with [tracing.startChunk()] and [tracing.stopChunk()].

**Usage**

```dart
await context.tracing.start( screenshots: true, snapshots: true );
final page = await context.newPage();
await page.goto('https://playwright.dev');

await context.tracing.startChunk();
await page.getByText('Get Started').click();
// Everything between startChunk and stopChunk will be recorded in the trace.
await context.tracing.stopChunk( path: 'trace1.zip' );

await context.tracing.startChunk();
await page.goto('http://example.com');
// Save a second trace file with different actions.
await context.tracing.stopChunk( path: 'trace2.zip' );
```

**Arguments**
- `options` Map *(optional)*
- `name` String *(optional)*

If specified, intermediate trace files are going to be saved into the files with the given name prefix inside the [tracesDir] directory specified in [browserType.launch()]. To specify the final trace zip file name, you need to pass `path` option to [tracing.stopChunk()] instead.
- `title` String *(optional)*

Trace name to be shown in the Trace Viewer.

**Returns**
- Future&lt;void&gt;

```dart
Future<TracingTracingStartChunkResult> startChunk(
```

### `group`

*⚙️ Method*

Use `test.step` instead when available.
Creates a new group within the trace, assigning any subsequent API calls to this group, until [tracing.groupEnd()] is called. Groups can be nested and will be visible in the trace viewer.

**Usage**

```dart
// use test.step instead
await test.step('Log in', () async {
// ...
);
```

**Arguments**
- `name` String

Group name shown in the trace viewer.
- `options` Map *(optional)*
- `location` TracingTracingGroupLocation *(optional)*
- `file` String


- `line` num *(optional)*


- `column` num *(optional)*


Specifies a custom location for the group to be shown in the trace viewer. Defaults to the location of the [tracing.group()] call.

**Returns**
- Future&lt;[Disposable]&gt;

```dart
Future<void> group(String name,
```

### `groupEnd`

*⚙️ Method*

Closes the last group created by [tracing.group()].

**Usage**

```dart
await tracing.groupEnd();
```

**Returns**
- Future&lt;void&gt;

```dart
Future<void> groupEnd()
```

### `stopChunk`

*⚙️ Method*

Stop the trace chunk. See [tracing.startChunk()] for more details about multiple trace chunks.

**Usage**

```dart
await tracing.stopChunk();
await tracing.stopChunk(options);
```

**Arguments**
- `options` Map *(optional)*
- `path` String *(optional)*

Export trace collected since the last [tracing.startChunk()] call into the file with the given path.

**Returns**
- Future&lt;void&gt;

```dart
Future<TracingTracingStopChunkResult> stopChunk(
```

### `stop`

*⚙️ Method*

Stop tracing.

**Usage**

```dart
await tracing.stop();
await tracing.stop(options);
```

**Arguments**
- `options` Map *(optional)*
- `path` String *(optional)*

Export trace into the file with the given path.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> stop()
```

## `Video`

Video objects are returned by `page.video`.

```dart
class Video
```

### `path`

*⚙️ Method*

Returns the file system path this video will be recorded to. The video is guaranteed to be written to the filesystem upon closing the browser context. This method throws when connected remotely.

**Usage**

```dart
await video.path();
```

**Returns**
- Future&lt;String&gt;

```dart
Future<String> path() async
```

### `saveAs`

*⚙️ Method*

Saves the video to a user-specified path. It is safe to call this method while the video is still in progress, or after the page has closed. This method waits until the page is closed and the video is fully saved.

**Usage**

```dart
await video.saveAs(path);
```

**Arguments**
- `path` String

Path where the video should be saved.

**Returns**
- Future&lt;void&gt;


[APIRequest]: /api/class-apirequest.mdx "APIRequest"
[APIRequestContext]: /api/class-apirequestcontext.mdx "APIRequestContext"
[APIResponse]: /api/class-apiresponse.mdx "APIResponse"
[APIResponseAssertions]: /api/class-apiresponseassertions.mdx "APIResponseAssertions"
[Browser]: /api/class-browser.mdx "Browser"
[BrowserContext]: /api/class-browsercontext.mdx "BrowserContext"
[BrowserServer]: /api/class-browserserver.mdx "BrowserServer"
[BrowserType]: /api/class-browsertype.mdx "BrowserType"
[CDPSession]: /api/class-cdpsession.mdx "CDPSession"
[Clock]: /api/class-clock.mdx "Clock"
[ConsoleMessage]: /api/class-consolemessage.mdx "ConsoleMessage"
[Coverage]: /api/class-coverage.mdx "Coverage"
[Credentials]: /api/class-credentials.mdx "Credentials"
[Debugger]: /api/class-debugger.mdx "Debugger"
[Dialog]: /api/class-dialog.mdx "Dialog"
[Disposable]: /api/class-disposable.mdx "Disposable"
[Download]: /api/class-download.mdx "Download"
[ElementHandle]: /api/class-elementhandle.mdx "ElementHandle"
[FileChooser]: /api/class-filechooser.mdx "FileChooser"
[Frame]: /api/class-frame.mdx "Frame"
[FrameLocator]: /api/class-framelocator.mdx "FrameLocator"
[GenericAssertions]: /api/class-genericassertions.mdx "GenericAssertions"
[JSHandle]: /api/class-jshandle.mdx "JSHandle"
[Keyboard]: /api/class-keyboard.mdx "Keyboard"
[Locator]: /api/class-locator.mdx "Locator"
[LocatorAssertions]: /api/class-locatorassertions.mdx "LocatorAssertions"
[Logger]: /api/class-logger.mdx "Logger"
[Mouse]: /api/class-mouse.mdx "Mouse"
[Page]: /api/class-page.mdx "Page"
[PageAssertions]: /api/class-pageassertions.mdx "PageAssertions"
[Playwright]: /api/class-playwright.mdx "Playwright"
[PlaywrightAssertions]: /api/class-playwrightassertions.mdx "PlaywrightAssertions"
[Request]: /api/class-request.mdx "Request"
[Response]: /api/class-response.mdx "Response"
[Route]: /api/class-route.mdx "Route"
[Screencast]: /api/class-screencast.mdx "Screencast"
[Selectors]: /api/class-selectors.mdx "Selectors"
[SnapshotAssertions]: /api/class-snapshotassertions.mdx "SnapshotAssertions"
[TimeoutError]: /api/class-timeouterror.mdx "TimeoutError"
[Touchscreen]: /api/class-touchscreen.mdx "Touchscreen"
[Tracing]: /api/class-tracing.mdx "Tracing"
[Video]: /api/class-video.mdx "Video"
[WebError]: /api/class-weberror.mdx "WebError"
[WebSocket]: /api/class-websocket.mdx "WebSocket"
[WebSocketRoute]: /api/class-websocketroute.mdx "WebSocketRoute"
[WebStorage]: /api/class-webstorage.mdx "WebStorage"
[Worker]: /api/class-worker.mdx "Worker"
[Electron]: /api/class-electron.mdx "Electron"
[ElectronApplication]: /api/class-electronapplication.mdx "ElectronApplication"
[Android]: /api/class-android.mdx "Android"
[AndroidDevice]: /api/class-androiddevice.mdx "AndroidDevice"
[AndroidInput]: /api/class-androidinput.mdx "AndroidInput"
[AndroidSocket]: /api/class-androidsocket.mdx "AndroidSocket"
[AndroidWebView]: /api/class-androidwebview.mdx "AndroidWebView"
[Fixtures]: /api/class-fixtures.mdx "Fixtures"
[FullConfig]: /api/class-fullconfig.mdx "FullConfig"
[FullProject]: /api/class-fullproject.mdx "FullProject"
[Location]: /api/class-location.mdx "Location"
[Test]: /api/class-test.mdx "Test"
[TestConfig]: /api/class-testconfig.mdx "TestConfig"
[TestInfo]: /api/class-testinfo.mdx "TestInfo"
[TestInfoError]: /api/class-testinfoerror.mdx "TestInfoError"
[TestOptions]: /api/class-testoptions.mdx "TestOptions"
[TestProject]: /api/class-testproject.mdx "TestProject"
[TestStepInfo]: /api/class-teststepinfo.mdx "TestStepInfo"
[WorkerInfo]: /api/class-workerinfo.mdx "WorkerInfo"
[Reporter]: /api/class-reporter.mdx "Reporter"
[Suite]: /api/class-suite.mdx "Suite"
[TestCase]: /api/class-testcase.mdx "TestCase"
[TestError]: /api/class-testerror.mdx "TestError"
[TestResult]: /api/class-testresult.mdx "TestResult"
[TestStep]: /api/class-teststep.mdx "TestStep"
[EvaluationArgument]: /evaluating.mdx#evaluation-argument "EvaluationArgument"
[UIEvent.detail]: https://developer.mozilla.org/en-US/docs/Web/API/UIEvent/detail "UIEvent.detail"


[all available image tags]: https://mcr.microsoft.com/en-us/product/playwright/about "all available image tags"
[Microsoft Artifact Registry]: https://mcr.microsoft.com/en-us/product/playwright/about "Microsoft Artifact Registry"
[Dockerfile.noble]: https://github.com/microsoft/playwright/blob/main/utils/docker/Dockerfile.noble "Dockerfile.noble"

```dart
Future<void> saveAs(String path) async
```

### `delete`

*⚙️ Method*

Deletes the video file. Will wait for the video to finish if necessary.

**Usage**

```dart
await video.delete();
```

**Returns**
- Future&lt;void&gt;

```dart
Future<void> delete() async
```

## `Worker`

```dart
abstract interface class Worker
```

### `url`

*📦 Property*

**Usage**

```dart
worker.url;
```

**Returns**
- String

```dart
String get url
```

### `evaluate`

*⚙️ Method*

Returns the return value of [pageFunction].

If the function passed to the [worker.evaluate()] returns a Future, then [worker.evaluate()] would wait for the future to complete and return its value.

If the function passed to the [worker.evaluate()] returns a non-[Serializable] value, then [worker.evaluate()] returns `undefined`. Playwright also supports transferring some additional values that are not serializable by `JSON`: `-0`, `NaN`, `Infinity`, `-Infinity`.

**Usage**

```dart
await worker.evaluate(pageFunction);
await worker.evaluate(pageFunction, arg);
```

**Arguments**
- `pageFunction` Function | String

Function to be evaluated in the worker context.
- `arg` dynamic *(optional)*

Optional argument to pass to [pageFunction].

**Returns**
- Future&lt;[Serializable]&gt;

```dart
Future<T> evaluate<T>(String expression, [Object? arg, bool? isFunction])
```

### `evaluateHandle`

*⚙️ Method*

Returns the return value of [pageFunction] as a [JSHandle].

The only difference between [worker.evaluate()] and [worker.evaluateHandle()] is that [worker.evaluateHandle()] returns [JSHandle].

If the function passed to the [worker.evaluateHandle()] returns a Future, then [worker.evaluateHandle()] would wait for the future to complete and return its value.

**Usage**

```dart
await worker.evaluateHandle(pageFunction);
await worker.evaluateHandle(pageFunction, arg);
```

**Arguments**
- `pageFunction` Function | String

Function to be evaluated in the worker context.
- `arg` dynamic *(optional)*

Optional argument to pass to [pageFunction].

**Returns**
- Future&lt;[JSHandle]&gt;

```dart
Future<JSHandle> evaluateHandle( String expression, [ Object? arg, bool? isFunction, ])
```

---

# Debugging

## `BindingCall`

Interface for BindingCall

```dart
abstract interface class BindingCall
```

## `DebugController`

Interface for DebugController

```dart
abstract interface class DebugController
```

## `Debugger`

Interface for Debugger

```dart
abstract interface class Debugger
```

### `requestPause`

*⚙️ Method*

Configures the debugger to pause before the next action is executed.

Throws if the debugger is already paused. Use [debugger.next()] or [debugger.runTo()] to step while paused.

Note that [page.pause()] is equivalent to a "debugger" statement — it pauses execution at the call site immediately. On the contrary, [debugger.requestPause()] is equivalent to "pause on next statement" — it configures the debugger to pause before the next action is executed.

**Usage**

```dart
await debugger.requestPause();
```

**Returns**
- Future&lt;void&gt;

```dart
Future<void> requestPause()
```

### `resume`

*⚙️ Method*

Resumes script execution. Throws if the debugger is not paused.

**Usage**

```dart
await debugger.resume();
```

**Returns**
- Future&lt;void&gt;

```dart
Future<void> resume()
```

### `next`

*⚙️ Method*

Resumes script execution and pauses again before the next action. Throws if the debugger is not paused.

**Usage**

```dart
await debugger.next();
```

**Returns**
- Future&lt;void&gt;

```dart
Future<void> next()
```

### `runTo`

*⚙️ Method*

Resumes script execution and pauses when an action originates from the given source location. Throws if the debugger is not paused.

**Usage**

```dart
await debugger.runTo(location);
```

**Arguments**
- `location` DebuggerRunToLocation
- `file` String


- `line` num *(optional)*


- `column` num *(optional)*


The source location to pause at.

**Returns**
- Future&lt;void&gt;

```dart
Future<void> runTo(DebuggerRunToLocation location)
```

## `Disposable`

Interface for Disposable

```dart
abstract interface class Disposable
```

### `dispose`

*⚙️ Method*

Removes the associated resource. For example, removes the init script installed via [page.addInitScript()] or [browserContext.addInitScript()].

**Usage**

```dart
await disposable.dispose();
```

**Returns**
- Future&lt;void&gt;


[APIRequest]: /api/class-apirequest.mdx "APIRequest"
[APIRequestContext]: /api/class-apirequestcontext.mdx "APIRequestContext"
[APIResponse]: /api/class-apiresponse.mdx "APIResponse"
[APIResponseAssertions]: /api/class-apiresponseassertions.mdx "APIResponseAssertions"
[Browser]: /api/class-browser.mdx "Browser"
[BrowserContext]: /api/class-browsercontext.mdx "BrowserContext"
[BrowserServer]: /api/class-browserserver.mdx "BrowserServer"
[BrowserType]: /api/class-browsertype.mdx "BrowserType"
[CDPSession]: /api/class-cdpsession.mdx "CDPSession"
[Clock]: /api/class-clock.mdx "Clock"
[ConsoleMessage]: /api/class-consolemessage.mdx "ConsoleMessage"
[Coverage]: /api/class-coverage.mdx "Coverage"
[Credentials]: /api/class-credentials.mdx "Credentials"
[Debugger]: /api/class-debugger.mdx "Debugger"
[Dialog]: /api/class-dialog.mdx "Dialog"
[Disposable]: /api/class-disposable.mdx "Disposable"
[Download]: /api/class-download.mdx "Download"
[ElementHandle]: /api/class-elementhandle.mdx "ElementHandle"
[FileChooser]: /api/class-filechooser.mdx "FileChooser"
[Frame]: /api/class-frame.mdx "Frame"
[FrameLocator]: /api/class-framelocator.mdx "FrameLocator"
[GenericAssertions]: /api/class-genericassertions.mdx "GenericAssertions"
[JSHandle]: /api/class-jshandle.mdx "JSHandle"
[Keyboard]: /api/class-keyboard.mdx "Keyboard"
[Locator]: /api/class-locator.mdx "Locator"
[LocatorAssertions]: /api/class-locatorassertions.mdx "LocatorAssertions"
[Logger]: /api/class-logger.mdx "Logger"
[Mouse]: /api/class-mouse.mdx "Mouse"
[Page]: /api/class-page.mdx "Page"
[PageAssertions]: /api/class-pageassertions.mdx "PageAssertions"
[Playwright]: /api/class-playwright.mdx "Playwright"
[PlaywrightAssertions]: /api/class-playwrightassertions.mdx "PlaywrightAssertions"
[Request]: /api/class-request.mdx "Request"
[Response]: /api/class-response.mdx "Response"
[Route]: /api/class-route.mdx "Route"
[Screencast]: /api/class-screencast.mdx "Screencast"
[Selectors]: /api/class-selectors.mdx "Selectors"
[SnapshotAssertions]: /api/class-snapshotassertions.mdx "SnapshotAssertions"
[TimeoutError]: /api/class-timeouterror.mdx "TimeoutError"
[Touchscreen]: /api/class-touchscreen.mdx "Touchscreen"
[Tracing]: /api/class-tracing.mdx "Tracing"
[Video]: /api/class-video.mdx "Video"
[WebError]: /api/class-weberror.mdx "WebError"
[WebSocket]: /api/class-websocket.mdx "WebSocket"
[WebSocketRoute]: /api/class-websocketroute.mdx "WebSocketRoute"
[WebStorage]: /api/class-webstorage.mdx "WebStorage"
[Worker]: /api/class-worker.mdx "Worker"
[Electron]: /api/class-electron.mdx "Electron"
[ElectronApplication]: /api/class-electronapplication.mdx "ElectronApplication"
[Android]: /api/class-android.mdx "Android"
[AndroidDevice]: /api/class-androiddevice.mdx "AndroidDevice"
[AndroidInput]: /api/class-androidinput.mdx "AndroidInput"
[AndroidSocket]: /api/class-androidsocket.mdx "AndroidSocket"
[AndroidWebView]: /api/class-androidwebview.mdx "AndroidWebView"
[Fixtures]: /api/class-fixtures.mdx "Fixtures"
[FullConfig]: /api/class-fullconfig.mdx "FullConfig"
[FullProject]: /api/class-fullproject.mdx "FullProject"
[Location]: /api/class-location.mdx "Location"
[Test]: /api/class-test.mdx "Test"
[TestConfig]: /api/class-testconfig.mdx "TestConfig"
[TestInfo]: /api/class-testinfo.mdx "TestInfo"
[TestInfoError]: /api/class-testinfoerror.mdx "TestInfoError"
[TestOptions]: /api/class-testoptions.mdx "TestOptions"
[TestProject]: /api/class-testproject.mdx "TestProject"
[TestStepInfo]: /api/class-teststepinfo.mdx "TestStepInfo"
[WorkerInfo]: /api/class-workerinfo.mdx "WorkerInfo"
[Reporter]: /api/class-reporter.mdx "Reporter"
[Suite]: /api/class-suite.mdx "Suite"
[TestCase]: /api/class-testcase.mdx "TestCase"
[TestError]: /api/class-testerror.mdx "TestError"
[TestResult]: /api/class-testresult.mdx "TestResult"
[TestStep]: /api/class-teststep.mdx "TestStep"
[EvaluationArgument]: /evaluating.mdx#evaluation-argument "EvaluationArgument"
[UIEvent.detail]: https://developer.mozilla.org/en-US/docs/Web/API/UIEvent/detail "UIEvent.detail"


[all available image tags]: https://mcr.microsoft.com/en-us/product/playwright/about "all available image tags"
[Microsoft Artifact Registry]: https://mcr.microsoft.com/en-us/product/playwright/about "Microsoft Artifact Registry"
[Dockerfile.noble]: https://github.com/microsoft/playwright/blob/main/utils/docker/Dockerfile.noble "Dockerfile.noble"

```dart
Future<void> dispose()
```

## `EventTarget`

Interface for EventTarget.

NOTE: The `EventTarget` protocol channel was removed in Playwright v1.61+.
The class is retained as a stub so that the object factory in [Connection]
can still handle any legacy `__create__` messages without crashing.

```dart
abstract interface class EventTarget
```

---

# Infrastructure

## `ChannelOwner`

```dart
abstract class ChannelOwner
```

### `fromNullable`

*⚙️ Method*

Resolves an optional wire-format object reference to a typed [ChannelOwner].

```dart
static T? fromNullable<T extends ChannelOwner>( Connection connection, Map<String, dynamic>? wire, )
```

## `RootChannelOwner`

```dart
class RootChannelOwner extends ChannelOwner
```

## `Channel`

```dart
abstract class Channel
```

## `Connection`

```dart
class Connection
```

## `Driver`

```dart
class Driver
```

### `Function`

*⚙️ Method*

Exposed for testing to override Process.start behavior

```dart
static Future<Process> Function(String, List<String>) processStart = Process.start
```

### `Function`

*⚙️ Method*

Exposed for testing to override driver download behavior

```dart
static Future<String> Function() getDriverPath = downloadDriver
```

## `NodePlatform`

```dart
class NodePlatform
```

## `EventEmitter`

A typed event emitter that mirrors the Playwright Node.js [EventEmitter] API.

Unlike Dart's built-in [Stream] / [StreamController], this class provides
the familiar `on` / `off` / `once` / `emit` surface that matches the
JavaScript Playwright client, while mapping each named event to a
[StreamController.broadcast] under the hood.

## Usage

```dart
final emitter = EventEmitter();

void handler(Object? args) => print('got: $args');
emitter.on('data', handler);
emitter.emit('data', 'hello');   // prints "got: hello"
emitter.off('data', handler);
```

```dart
class EventEmitter
```

### `on`

*⚙️ Method*

Adds a persistent [handler] for [event].

```dart
void on(String event, void Function(dynamic) handler)
```

### `addListener`

*⚙️ Method*

Alias for [on].

```dart
void addListener(String event, void Function(dynamic) handler)
```

### `off`

*⚙️ Method*

Removes a previously registered [handler] for [event].

```dart
void off(String event, void Function(dynamic) handler)
```

### `removeListener`

*⚙️ Method*

Alias for [off].

```dart
void removeListener(String event, void Function(dynamic) handler)
```

### `once`

*⚙️ Method*

Adds a [handler] that fires only **once** for [event] and then
automatically removes itself.

```dart
void once(String event, void Function(dynamic) handler)
```

### `removeAllListeners`

*⚙️ Method*

Removes all listeners for [event], or all listeners when [event] is null.

```dart
void removeAllListeners([String? event])
```

### `emit`

*⚙️ Method*

Emits [event] synchronously, calling all registered listeners with [args].

Returns `true` if any listeners were registered for this event.

```dart
bool emit(String event, [Object? args])
```

### `stream`

*⚙️ Method*

Returns a [Stream] that emits values whenever [event] is fired via
[emit].  Each call returns a new broadcast stream backed by a controller
added to [event]'s listener list.

```dart
Stream<dynamic> stream(String event)
```

## `FilePayload`

```dart
class FilePayload
```

## `JsonPipe`

Interface for JsonPipe

```dart
abstract interface class JsonPipe
```

## `LocalUtils`

Interface for LocalUtils

```dart
abstract interface class LocalUtils
```

## `PlaywrightError`

Base class for all Playwright errors.

```dart
class PlaywrightError implements Exception
```

## `TimeoutError`

* extends: [Error]

TimeoutError is emitted whenever certain operations are terminated due to timeout, e.g. [locator.waitFor()] or [browserType.launch()].

```dart

(() async {
final browser = await playwright.chromium.launch();
final context = await browser.newContext();
final page = await context.newPage();
try {
await page.locator('text=Foo').click(
timeout: 100,
);
} catch (error) {
if (error instanceof playwright.errors.TimeoutError)
print('Timeout!');
}
await browser.close();
}
```



[APIRequest]: /api/class-apirequest.mdx "APIRequest"
[APIRequestContext]: /api/class-apirequestcontext.mdx "APIRequestContext"
[APIResponse]: /api/class-apiresponse.mdx "APIResponse"
[APIResponseAssertions]: /api/class-apiresponseassertions.mdx "APIResponseAssertions"
[Browser]: /api/class-browser.mdx "Browser"
[BrowserContext]: /api/class-browsercontext.mdx "BrowserContext"
[BrowserServer]: /api/class-browserserver.mdx "BrowserServer"
[BrowserType]: /api/class-browsertype.mdx "BrowserType"
[CDPSession]: /api/class-cdpsession.mdx "CDPSession"
[Clock]: /api/class-clock.mdx "Clock"
[ConsoleMessage]: /api/class-consolemessage.mdx "ConsoleMessage"
[Coverage]: /api/class-coverage.mdx "Coverage"
[Credentials]: /api/class-credentials.mdx "Credentials"
[Debugger]: /api/class-debugger.mdx "Debugger"
[Dialog]: /api/class-dialog.mdx "Dialog"
[Disposable]: /api/class-disposable.mdx "Disposable"
[Download]: /api/class-download.mdx "Download"
[ElementHandle]: /api/class-elementhandle.mdx "ElementHandle"
[FileChooser]: /api/class-filechooser.mdx "FileChooser"
[Frame]: /api/class-frame.mdx "Frame"
[FrameLocator]: /api/class-framelocator.mdx "FrameLocator"
[GenericAssertions]: /api/class-genericassertions.mdx "GenericAssertions"
[JSHandle]: /api/class-jshandle.mdx "JSHandle"
[Keyboard]: /api/class-keyboard.mdx "Keyboard"
[Locator]: /api/class-locator.mdx "Locator"
[LocatorAssertions]: /api/class-locatorassertions.mdx "LocatorAssertions"
[Logger]: /api/class-logger.mdx "Logger"
[Mouse]: /api/class-mouse.mdx "Mouse"
[Page]: /api/class-page.mdx "Page"
[PageAssertions]: /api/class-pageassertions.mdx "PageAssertions"
[Playwright]: /api/class-playwright.mdx "Playwright"
[PlaywrightAssertions]: /api/class-playwrightassertions.mdx "PlaywrightAssertions"
[Request]: /api/class-request.mdx "Request"
[Response]: /api/class-response.mdx "Response"
[Route]: /api/class-route.mdx "Route"
[Screencast]: /api/class-screencast.mdx "Screencast"
[Selectors]: /api/class-selectors.mdx "Selectors"
[SnapshotAssertions]: /api/class-snapshotassertions.mdx "SnapshotAssertions"
[TimeoutError]: /api/class-timeouterror.mdx "TimeoutError"
[Touchscreen]: /api/class-touchscreen.mdx "Touchscreen"
[Tracing]: /api/class-tracing.mdx "Tracing"
[Video]: /api/class-video.mdx "Video"
[WebError]: /api/class-weberror.mdx "WebError"
[WebSocket]: /api/class-websocket.mdx "WebSocket"
[WebSocketRoute]: /api/class-websocketroute.mdx "WebSocketRoute"
[WebStorage]: /api/class-webstorage.mdx "WebStorage"
[Worker]: /api/class-worker.mdx "Worker"
[Electron]: /api/class-electron.mdx "Electron"
[ElectronApplication]: /api/class-electronapplication.mdx "ElectronApplication"
[Android]: /api/class-android.mdx "Android"
[AndroidDevice]: /api/class-androiddevice.mdx "AndroidDevice"
[AndroidInput]: /api/class-androidinput.mdx "AndroidInput"
[AndroidSocket]: /api/class-androidsocket.mdx "AndroidSocket"
[AndroidWebView]: /api/class-androidwebview.mdx "AndroidWebView"
[Fixtures]: /api/class-fixtures.mdx "Fixtures"
[FullConfig]: /api/class-fullconfig.mdx "FullConfig"
[FullProject]: /api/class-fullproject.mdx "FullProject"
[Location]: /api/class-location.mdx "Location"
[Test]: /api/class-test.mdx "Test"
[TestConfig]: /api/class-testconfig.mdx "TestConfig"
[TestInfo]: /api/class-testinfo.mdx "TestInfo"
[TestInfoError]: /api/class-testinfoerror.mdx "TestInfoError"
[TestOptions]: /api/class-testoptions.mdx "TestOptions"
[TestProject]: /api/class-testproject.mdx "TestProject"
[TestStepInfo]: /api/class-teststepinfo.mdx "TestStepInfo"
[WorkerInfo]: /api/class-workerinfo.mdx "WorkerInfo"
[Reporter]: /api/class-reporter.mdx "Reporter"
[Suite]: /api/class-suite.mdx "Suite"
[TestCase]: /api/class-testcase.mdx "TestCase"
[TestError]: /api/class-testerror.mdx "TestError"
[TestResult]: /api/class-testresult.mdx "TestResult"
[TestStep]: /api/class-teststep.mdx "TestStep"
[EvaluationArgument]: /evaluating.mdx#evaluation-argument "EvaluationArgument"
[UIEvent.detail]: https://developer.mozilla.org/en-US/docs/Web/API/UIEvent/detail "UIEvent.detail"


[all available image tags]: https://mcr.microsoft.com/en-us/product/playwright/about "all available image tags"
[Microsoft Artifact Registry]: https://mcr.microsoft.com/en-us/product/playwright/about "Microsoft Artifact Registry"
[Dockerfile.noble]: https://github.com/microsoft/playwright/blob/main/utils/docker/Dockerfile.noble "Dockerfile.noble"

```dart
class TimeoutError extends PlaywrightError
```

## `TargetClosedError`

Thrown when the target page, context or browser has been closed.

```dart
class TargetClosedError extends PlaywrightError
```

### `isTargetClosedError`

*⚙️ Method*

Returns `true` when [error] is a [TargetClosedError].

```dart
bool isTargetClosedError(Object error)
```

### `isTimeoutError`

*⚙️ Method*

Returns `true` when [error] is a [TimeoutError].

```dart
bool isTimeoutError(Object error)
```

### `parseServerError`

*⚙️ Method*

Parses an error message string from the server and returns the appropriate
typed [PlaywrightError] subclass.

```dart
PlaywrightError parseServerError(String message)
```

## `Root`

Interface for Root

```dart
abstract interface class Root
```

## `SelectOptionParams`

```dart
class SelectOptionParams
```

## `InputFilesParams`

```dart
class InputFilesParams
```

## `PlaywrightStream`

Interface for PlaywrightStream

```dart
abstract interface class PlaywrightStream
```

## `Transport`

```dart
abstract class Transport
```

## `StdioTransport`

```dart
class StdioTransport implements Transport
```

## `JsonPipeTransport`

```dart
class JsonPipeTransport implements Transport
```

## `Waiter`

Utility that waits for a named event on a [ChannelOwner] with support for
race conditions (timeout, reject-on-another-event).

This mirrors the Playwright Node.js `Waiter` class, which is used
internally to implement `page.waitForEvent(...)` and similar APIs.

## Example

```dart
final waiter = Waiter(page, 'load');
waiter.rejectOnTimeout(30000, 'Timeout waiting for load event');
waiter.rejectOnEvent(page, 'close', TargetClosedError('Page was closed'));
final result = await waiter.waitForEvent<void>(page, 'load');
waiter.dispose();
```

```dart
class Waiter<T>
```

### `createForEvent`

*⚙️ Method*

Creates a [Waiter] for a named event on [channelOwner].

```dart
static Waiter<T> createForEvent<T>(ChannelOwner channelOwner, String event)
```

### `rejectOnTimeout`

*⚙️ Method*

Rejects the waiter with a [TimeoutError] after [timeoutMs] milliseconds.

Pass 0 to disable the timeout.

```dart
void rejectOnTimeout(double timeoutMs, String message)
```

### `rejectOnEvent`

*⚙️ Method*

Rejects the waiter when [event] fires on [emitter].

```dart
void rejectOnEvent( ChannelOwner emitter, String event, PlaywrightError error, [ bool Function(dynamic)? predicate, ])
```

### `rejectImmediately`

*⚙️ Method*

Rejects the waiter immediately with [error].

```dart
void rejectImmediately(PlaywrightError error)
```

### `waitForEvent`

*⚙️ Method*

Waits for [event] on [emitter], subject to any reject conditions.

An optional [predicate] filters which event payloads are accepted.

```dart
Future<T> waitForEvent( ChannelOwner emitter, String event, [ bool Function(dynamic)? predicate, ])
```

### `waitForPromise`

*⚙️ Method*

Waits for [promise], racing it against all registered reject conditions.

```dart
Future<R> waitForPromise<R>(Future<R> promise) async
```

### `dispose`

*⚙️ Method*

Cancels all registered timers and subscriptions.

```dart
void dispose()
```

## `WebSocketTransport`

```dart
class WebSocketTransport implements Transport
```

## `WritableStream`

Interface for WritableStream

```dart
abstract interface class WritableStream
```

---

