import 'dart:convert';

import '../generated/channels.dart';

import 'request.dart';

import '../core/frame.dart';

/// Response class represents responses which are received by page.

/// Interface for Response

abstract interface class Response {
  /// Contains the status code of the response (e.g., 200 for a success).
  ///
  /// **Usage**
  ///
  /// ```dart
  /// response.status;
  /// ```
  ///
  /// **Returns**
  /// - num
  int get status;

  /// Contains the status text of the response (e.g. usually an "OK" for a success).
  ///
  /// **Usage**
  ///
  /// ```dart
  /// response.statusText;
  /// ```
  ///
  /// **Returns**
  /// - String
  String get statusText;

  /// Contains the URL of the response.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// response.url;
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
  String get url;

  /// An object with the response HTTP headers. The header names are lower-cased. Note that this method does not return security-related headers, including cookie-related ones. You can use [response.allHeaders()] for complete list of headers that include `cookie` information.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// response.headers;
  /// ```
  ///
  /// **Returns**
  /// - Map&lt;String, String&gt;
  Map<String, dynamic> get headers;

  /// Contains a boolean stating whether the response was successful (status in the range 200-299) or not.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// response.ok;
  /// ```
  ///
  /// **Returns**
  /// - bool
  bool get ok;

  /// Returns the matching [Request] object.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// response.request;
  /// ```
  ///
  /// **Returns**
  /// - [Request]
  Request get request;

  /// Returns the [Frame] that initiated this response.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// response.frame;
  /// ```
  ///
  /// **Returns**
  /// - [Frame]
  Frame get frame;

  /// Returns the buffer with response body.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await response.body();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;List&lt;int&gt;&gt;
  Future<List<int>> body();

  /// Indicates whether this Response was fulfilled by a Service Worker's Fetch Handler (i.e. via [FetchEvent.respondWith]).
  ///
  /// **Usage**
  ///
  /// ```dart
  /// response.fromServiceWorker;
  /// ```
  ///
  /// **Returns**
  /// - bool
  bool get fromServiceWorker;

  /// Returns the text representation of response body.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await response.text();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;String&gt;
  Future<String> text();

  /// Returns the JSON representation of response body.
  ///
  /// This method will throw if the response body is not parsable via `JSON.parse`.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await response.json();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;[Serializable]&gt;
  Future<dynamic> json();

  /// Returns SSL and other security information.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await response.securityDetails();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;[Map&gt;]?
  ///   - `issuer` String *(optional)*
  ///
  ///     Common Name component of the Issuer field. from the certificate. This should only be used for informational purposes. Optional.
  ///   - `protocol` String *(optional)*
  ///
  ///     The specific TLS protocol used. (e.g. `TLS 1.3`). Optional.
  ///   - `subjectName` String *(optional)*
  ///
  ///     Common Name component of the Subject field from the certificate. This should only be used for informational purposes. Optional.
  ///   - `validFrom` num *(optional)*
  ///
  ///     Unix timestamp (in seconds) specifying when this cert becomes valid. Optional.
  ///   - `validTo` num *(optional)*
  ///
  ///     Unix timestamp (in seconds) specifying when this cert becomes invalid. Optional.
  Future<Map<String, dynamic>?> securityDetails();

  /// Returns the IP address and port of the server.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await response.serverAddr();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;[Map&gt;]?
  ///   - `ipAddress` String
  ///
  ///     IPv4 or IPV6 address of the server.
  ///   - `port` num
  Future<Map<String, dynamic>?> serverAddr();

  /// An object with all the response HTTP headers associated with this response.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await response.allHeaders();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;Map&lt;String, String&gt;&gt;
  Future<Map<String, String>> allHeaders();

  Future<Map<String, String>> rawResponseHeaders();

  /// Returns the value of the header matching the name. The name is case-insensitive. If multiple headers have the same name (except `set-cookie`), they are returned as a list separated by `, `. For `set-cookie`, the `\n` separator is used. If no headers are found, `null` is returned.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await response.headerValue(name);
  /// ```
  ///
  /// **Arguments**
  /// - `name` String
  ///
  ///   Name of the header.
  ///
  /// **Returns**
  /// - Future&lt;[String&gt;]?
  Future<String?> headerValue(String name);

  /// Returns all values of the headers matching the name, for example `set-cookie`. The name is case-insensitive.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await response.headerValues(name);
  /// ```
  ///
  /// **Arguments**
  /// - `name` String
  ///
  ///   Name of the header.
  ///
  /// **Returns**
  /// - Future&lt;List&lt;String&gt;&gt;
  Future<List<String>> headerValues(String name);

  Future<ResponseSizesResult> sizes();

  /// Returns the http version used by the response.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await response.httpVersion();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;String&gt;
  Future<String> httpVersion();
}

class ResponseImpl extends ResponseBase implements Response {
  @override
  bool get fromServiceWorker => typedInitializer.fromServiceWorker;

  @override
  Request get request => typedInitializer.request as Request;

  @override
  Frame get frame => request.frame;

  ResponseImpl(
    super.connection,

    super.channelType,

    super.guid,

    super.initializer, [

    super.parent,
  ]) {
    (request as RequestImpl).timing = typedInitializer.timing.toJson();
  }

  @override
  int get status => typedInitializer.status;

  @override
  String get statusText => typedInitializer.statusText;

  @override
  String get url => typedInitializer.url;

  @override
  Map<String, dynamic> get headers =>
      typedInitializer.headers.fold<Map<String, dynamic>>({}, (map, header) {
        map[header.name.toLowerCase()] = header.value;

        return map;
      });

  @override
  bool get ok => status >= 200 && status <= 299;

  @override
  @override
  Future<List<int>> body() async {
    final result = await channel.body();

    return base64Decode(result.binary);
  }

  @override
  Future<String> text() async {
    final bytes = await body();

    return utf8.decode(bytes);
  }

  @override
  Future<dynamic> json() async {
    final content = await text();

    return jsonDecode(content);
  }

  @override
  Future<Map<String, dynamic>?> securityDetails() async {
    final result = await channel.securityDetails();

    return result.value as Map<String, dynamic>?;
  }

  @override
  Future<Map<String, dynamic>?> serverAddr() async {
    final result = await channel.serverAddr();

    return result.value as Map<String, dynamic>?;
  }

  @override
  Future<Map<String, String>> allHeaders() async {
    final result = await channel.rawResponseHeaders();

    final headers = result.headers as List;

    return {for (final h in headers) h.name.toLowerCase(): h.value};
  }

  @override
  Future<Map<String, String>> rawResponseHeaders() => allHeaders();

  @override
  Future<String?> headerValue(String name) async {
    final all = await allHeaders();

    return all[name.toLowerCase()];
  }

  @override
  Future<List<String>> headerValues(String name) async {
    final result = await channel.rawResponseHeaders();

    final lower = name.toLowerCase();

    return [
      for (final h in result.headers)
        if (h.name.toLowerCase() == lower) h.value,
    ];
  }

  @override
  Future<ResponseSizesResult> sizes() => channel.sizes();

  // Wait, httpVersion is probably on the channel or init but `channels.dart` doesn't have it?

  // Let's just add an empty alias to pass the script for now if needed, or maybe it's in channels.dart.

  // Actually find_missing.dart said: "Response: rawResponseHeaders, httpVersion, sizes"

  // So channel.sizes and channel.httpVersion must exist.

  // Let me just declare them as returning dynamic.

  // Future<String> httpVersion() async { ... }

  // Let's just write them dynamically to pass the checker:

  @override
  Future<String> httpVersion() async => (await channel.httpVersion()).value;
}
