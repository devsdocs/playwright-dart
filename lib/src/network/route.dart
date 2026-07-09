import '../generated/channels.dart';
import 'route_error_code.dart';

import 'request.dart';

/// Whenever a network route is set up with `page.route()` or `browserContext.route()`, the `Route` object allows to handle the route.

/// Interface for Route

abstract interface class Route {
  /// A request to be routed.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// route.request;
  /// ```
  ///
  /// **Returns**
  /// - [Request]
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
  Request get request;

  /// Aborts the route's request.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await route.abort();
  /// await route.abort(errorCode);
  /// ```
  ///
  /// **Arguments**
  /// - `errorCode` String *(optional)*
  ///
  ///   Optional error code. Defaults to `failed`, could be one of the following:
  ///   * `'aborted'` - An operation was aborted (due to user action)
  ///   * `'accessdenied'` - Permission to access a resource, other than the network, was denied
  ///   * `'addressunreachable'` - The IP address is unreachable. This usually means that there is no route to the specified host or network.
  ///   * `'blockedbyclient'` - The client chose to block the request.
  ///   * `'blockedbyresponse'` - The request failed because the response was delivered along with requirements which are not met ('X-Frame-Options' and 'Content-Security-Policy' ancestor checks, for instance).
  ///   * `'connectionaborted'` - A connection timed out as a result of not receiving an ACK for data sent.
  ///   * `'connectionclosed'` - A connection was closed (corresponding to a TCP FIN).
  ///   * `'connectionfailed'` - A connection attempt failed.
  ///   * `'connectionrefused'` - A connection attempt was refused.
  ///   * `'connectionreset'` - A connection was reset (corresponding to a TCP RST).
  ///   * `'internetdisconnected'` - The Internet connection has been lost.
  ///   * `'namenotresolved'` - The host name could not be resolved.
  ///   * `'timedout'` - An operation timed out.
  ///   * `'failed'` - A generic failure occurred.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> abort({RouteErrorCode? errorCode});

  /// Fulfills route's request with given response.
  ///
  /// **Usage**
  ///
  /// An example of fulfilling all requests with 404 responses:
  ///
  /// ```dart
  /// await page.route('**/*', (route) async {
  ///   await route.fulfill(
  ///     status: 404,
  ///     contentType: 'text/plain',
  ///     body: 'Not Found!'
  ///   );
  /// );
  /// ```
  ///
  /// An example of serving static file:
  ///
  /// ```dart
  /// await page.route('**/xhr_endpoint', (route) => route.fulfill( path: 'mock_data.json' ));
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `body` String *(optional)*
  ///
  ///     Response body.
  ///   - `contentType` String *(optional)*
  ///
  ///     If set, equals to setting `Content-Type` response header.
  ///   - `headers` List&lt;NameValue&gt; *(optional)*
  ///
  ///     Response headers. Header values will be converted to a string.
  ///   - `json` [Serializable] *(optional)*
  ///
  ///     JSON response. This method will set the content type to `application/json` if not set.
  ///   - `path` String *(optional)*
  ///
  ///     File path to respond with. The content type will be inferred from file extension. If `path` is a relative path, then it is resolved relative to the current working directory.
  ///   - `response` [APIResponse] *(optional)*
  ///
  ///     [APIResponse] to fulfill route's request with. Individual fields of the response (such as headers) can be overridden using fulfill options.
  ///   - `status` int *(optional)*
  ///
  ///     Response status code, defaults to `200`.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> fulfill({
    int? status,

    List<NameValue>? headers,

    String? body,

    bool? isBase64,

    String? contentType,

    String? fetchResponseUid,
  });

  Future<void> continueRoute({
    String? url,

    String? method,

    List<NameValue>? headers,

    String? postData,

    bool isFallback,
  });

  /// Continues route's request with optional overrides. The method is similar to [route.continue()] with the difference that other matching handlers will be invoked before sending the request.
  ///
  /// **Usage**
  ///
  /// When several routes match the given pattern, they run in the order opposite to their registration. That way the last registered route can always override all the previous ones. In the example below, request will be handled by the bottom-most handler first, then it'll fall back to the previous one and in the end will be aborted by the first registered route.
  ///
  /// ```dart
  /// await page.route('**/*', (route) async {
  ///   // Runs last.
  ///   await route.abort();
  /// );
  /// await page.route('**/*', (route) async {
  ///   // Runs second.
  ///   await route.fallback();
  /// );
  /// await page.route('**/*', (route) async {
  ///   // Runs first.
  ///   await route.fallback();
  /// );
  /// ```
  ///
  /// Registering multiple routes is useful when you want separate handlers to handle different kinds of requests, for example API calls vs page resources or GET requests vs POST requests as in the example below.
  ///
  /// ```dart
  /// // Handle GET requests.
  /// await page.route('**/*', (route) async {
  ///   if (route.request().method() != 'GET') {
  ///     await route.fallback();
  ///     return;
  ///   }
  ///   // Handling GET only.
  ///   // ...
  /// );
  ///
  /// // Handle POST requests.
  /// await page.route('**/*', (route) async {
  ///   if (route.request().method() != 'POST') {
  ///     await route.fallback();
  ///     return;
  ///   }
  ///   // Handling POST only.
  ///   // ...
  /// );
  /// ```
  ///
  /// One can also modify request while falling back to the subsequent handler, that way intermediate route handler can modify url, method, headers and postData of the request.
  ///
  /// ```dart
  /// await page.route('**/*', (route, request) async {
  ///   // Override headers
  ///   final headers = {
  ///     ...request.headers(),
  ///     foo: 'foo-value', // set "foo" header
  ///     bar: undefined, // remove "bar" header
  ///   };
  ///   await route.fallback( headers );
  /// );
  /// ```
  ///
  /// Use [route.continue()] to immediately send the request to the network, other matching handlers won't be invoked in that case.
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `headers` List&lt;NameValue&gt; *(optional)*
  ///
  ///     If set changes the request HTTP headers. Header values will be converted to a string.
  ///   - `method` String *(optional)*
  ///
  ///     If set changes the request method (e.g. GET or POST).
  ///   - `postData` String *(optional)*
  ///
  ///     If set changes the post data of request.
  ///   - `url` String *(optional)*
  ///
  ///     If set changes the request URL. New URL must have same protocol as original one. Changing the URL won't affect the route matching, all the routes are matched using the original request URL.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> fallback({
    String? url,

    String? method,

    List<NameValue>? headers,

    String? postData,
  });

  Future<void> redirectNavigationRequest(String url);

  Future<void> continueValue({
    String? url,

    String? method,

    List<NameValue>? headers,

    String? postData,

    bool isFallback,
  });
}

class RouteImpl extends RouteBase implements Route {
  RouteImpl(
    super.connection,

    super.channelType,

    super.guid,

    super.initializer, [

    super.parent,
  ]);

  @override
  Request get request => typedInitializer.request as Request;

  @override
  Future<void> abort({RouteErrorCode? errorCode}) async {
    await channel.abort(errorCode: errorCode?.value);
  }

  @override
  Future<void> fulfill({
    int? status,

    List<NameValue>? headers,

    String? body,

    bool? isBase64,

    String? contentType,

    String? fetchResponseUid,
  }) async {
    final mappedHeaders = headers ?? [];

    if (contentType != null) {
      mappedHeaders.add(NameValue(name: 'content-type', value: contentType));
    }

    await channel.fulfill(
      status: status,

      headers: mappedHeaders,

      body: body,

      isBase64: isBase64,

      fetchResponseUid: fetchResponseUid,
    );
  }

  @override
  Future<void> continueRoute({
    String? url,

    String? method,

    List<NameValue>? headers,

    String? postData,

    bool isFallback = false,
  }) async {
    await channel.continueValue(
      url: url,

      method: method,

      headers: headers,

      postData: postData,

      isFallback: isFallback,
    );
  }

  @override
  Future<void> fallback({
    String? url,

    String? method,

    List<NameValue>? headers,

    String? postData,
  }) => continueRoute(
    url: url,

    method: method,

    headers: headers,

    postData: postData,

    isFallback: true,
  );

  @override
  Future<void> redirectNavigationRequest(String url) async {
    await channel.redirectNavigationRequest(url: url);
  }

  @override
  Future<void> continueValue({
    String? url,

    String? method,

    List<NameValue>? headers,

    String? postData,

    bool isFallback = false,
  }) => continueRoute(
    url: url,

    method: method,

    headers: headers,

    postData: postData,

    isFallback: isFallback,
  );
}
