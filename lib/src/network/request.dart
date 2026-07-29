import 'response.dart';

import 'dart:convert';

import '../infrastructure/channel_owner.dart';

import '../generated/channels.dart';

import '../core/frame.dart';

/// Whenever the page sends a request for a network resource the following sequence of events are emitted by Page:

/// - `page.on('request')` emitted when the request is issued by the page.

/// Interface for Request

abstract interface class Request {
  /// URL of the request.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// request.url;
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
  /// [TestRun]: /api/class-testrun.mdx "TestRun"
  /// [TestStep]: /api/class-teststep.mdx "TestStep"
  /// [EvaluationArgument]: /evaluating.mdx#evaluation-argument "EvaluationArgument"
  /// [UIEvent.detail]: https://developer.mozilla.org/en-US/docs/Web/API/UIEvent/detail "UIEvent.detail"
  ///
  ///
  /// [all available image tags]: https://mcr.microsoft.com/en-us/product/playwright/about "all available image tags"
  /// [Microsoft Artifact Registry]: https://mcr.microsoft.com/en-us/product/playwright/about "Microsoft Artifact Registry"
  /// [Dockerfile.noble]: https://github.com/microsoft/playwright/blob/main/utils/docker/Dockerfile.noble "Dockerfile.noble"
  String get url;

  /// Returns the [Frame] that initiated this request.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// final frameUrl = request.frame.url();
  /// ```
  ///
  /// **Returns**
  /// - [Frame]
  ///
  /// **Details**
  ///
  /// Note that in some cases the frame is not available, and this method will throw.
  /// * When request originates in the Service Worker. You can use `request.serviceWorker()` to check that.
  /// * When navigation request is issued before the corresponding frame is created. You can use [request.isNavigationRequest()] to check that.
  ///
  /// Here is an example that handles all the cases:
  ///
  /// ```dart
  /// if (request.serviceWorker())
  ///   print(`request ${request.url()} from a service worker`);
  /// else if (request.isNavigationRequest())
  ///   print(`request ${request.url()} is a navigation request`);
  /// else
  ///   print(`request ${request.url()} from a frame ${request.frame.url()}`);
  /// ```
  Frame get frame;

  /// Contains the request's resource type as it was perceived by the rendering engine. ResourceType will be one of the following: `document`, `stylesheet`, `image`, `media`, `font`, `script`, `texttrack`, `xhr`, `fetch`, `eventsource`, `websocket`, `manifest`, `other`.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// request.resourceType;
  /// ```
  ///
  /// **Returns**
  /// - String
  String get resourceType;

  /// Request's method (GET, POST, etc.)
  ///
  /// **Usage**
  ///
  /// ```dart
  /// request.method;
  /// ```
  ///
  /// **Returns**
  /// - String
  String get method;

  /// Request's post body, if any.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// request.postData;
  /// ```
  ///
  /// **Returns**
  /// - [String]?
  String? get postData;

  /// An object with the request HTTP headers. The header names are lower-cased. Note that this method does not return security-related headers, including cookie-related ones. You can use [request.allHeaders()] for complete list of headers that include `cookie` information.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// request.headers;
  /// ```
  ///
  /// **Returns**
  /// - Map&lt;String, String&gt;
  Map<String, dynamic> get headers;

  /// Whether this request is driving frame's navigation.
  ///
  /// Some navigation requests are issued before the corresponding frame is created, and therefore do not have [request.frame()] available.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// request.isNavigationRequest;
  /// ```
  ///
  /// **Returns**
  /// - bool
  bool get isNavigationRequest;

  /// Returns resource timing information for given request. Most of the timing values become available upon the response, `responseEnd` becomes available when request finishes. Find more information at [Resource Timing API].
  ///
  /// **Usage**
  ///
  /// ```dart
  /// final requestFinishedFuture = page.onRequestFinished.first;
  /// await page.goto('http://example.com');
  /// final request = await requestFinishedFuture;
  /// print(request.timing);
  /// ```
  ///
  /// **Returns**
  /// - Map
  ///   - `startTime` num
  ///
  ///     Request start time in milliseconds elapsed since January 1, 1970 00:00:00 UTC
  ///   - `domainLookupStart` num
  ///
  ///     Time immediately before the client starts the domain name lookup for the resource. The value is given in milliseconds relative to `startTime`, -1 if not available.
  ///   - `domainLookupEnd` num
  ///
  ///     Time immediately after the client ends the domain name lookup for the resource. The value is given in milliseconds relative to `startTime`, -1 if not available.
  ///   - `connectStart` num
  ///
  ///     Time immediately before the client starts establishing the connection to the server to retrieve the resource. The value is given in milliseconds relative to `startTime`, -1 if not available.
  ///   - `secureConnectionStart` num
  ///
  ///     Time immediately before the client starts the handshake process to secure the current connection. The value is given in milliseconds relative to `startTime`, -1 if not available.
  ///   - `connectEnd` num
  ///
  ///     Time immediately after the client establishes the connection to the server to retrieve the resource. The value is given in milliseconds relative to `startTime`, -1 if not available.
  ///   - `requestStart` num
  ///
  ///     Time immediately before the client starts requesting the resource from the server, cache, or local resource. The value is given in milliseconds relative to `startTime`, -1 if not available.
  ///   - `responseStart` num
  ///
  ///     Time immediately after the client receives the first byte of the response from the server, cache, or local resource. The value is given in milliseconds relative to `startTime`, -1 if not available.
  ///   - `responseEnd` num
  ///
  ///     Time immediately after the client receives the last byte of the resource or immediately before the transport connection is closed, whichever comes first. The value is given in milliseconds relative to `startTime`, -1 if not available.
  Map<String, dynamic> get timing;

  /// Request that was redirected by the server to this one, if any.
  ///
  /// When the server responds with a redirect, Playwright creates a new [Request] object. The two requests are connected by `redirectedFrom()` and `redirectedTo()` methods. When multiple server redirects has happened, it is possible to construct the whole redirect chain by repeatedly calling `redirectedFrom()`.
  ///
  /// **Usage**
  ///
  /// For example, if the website `http://example.com` redirects to `https://example.com`:
  ///
  /// ```dart
  /// final response = await page.goto('http://example.com');
  /// print(response.request().redirectedFrom.url()); // 'http://example.com'
  /// ```
  ///
  /// If the website `https://google.com` has no redirects:
  ///
  /// ```dart
  /// final response = await page.goto('https://google.com');
  /// print(response.request().redirectedFrom); // null
  /// ```
  ///
  /// **Returns**
  /// - [Request]?
  Request? get redirectedFrom;

  /// New request issued by the browser if the server responded with redirect.
  ///
  /// **Usage**
  ///
  /// This method is the opposite of [request.redirectedFrom()]:
  ///
  /// ```dart
  /// print(request.redirectedFrom().redirectedTo == request); // true
  /// ```
  ///
  /// **Returns**
  /// - [Request]?
  Request? get redirectedTo;

  /// The method returns `null` unless this request has failed, as reported by `requestfailed` event.
  ///
  /// **Usage**
  ///
  /// Example of logging of all the failed requests:
  ///
  /// ```dart
  /// page.onRequestFailed.listen((request) {
  ///   print(request.url() + ' ' + request.failure.errorText);
  /// );
  /// ```
  ///
  /// **Returns**
  /// - [Map]?
  ///   - `errorText` String
  ///
  ///     Human-readable error message, e.g. `'net::ERR_FAILED'`.
  String? get failure;

  /// Returns parsed request's body for `form-urlencoded` and JSON as a fallback if any.
  ///
  /// When the response is `application/x-www-form-urlencoded` then a key/value object of the values will be returned. Otherwise it will be parsed as JSON.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// request.postDataJSON;
  /// ```
  ///
  /// **Returns**
  /// - [Serializable]?
  dynamic get postDataJSON;

  /// Request's post body in a binary form, if any.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// request.postDataBuffer;
  /// ```
  ///
  /// **Returns**
  /// - List&lt;int&gt;?
  List<int>? get postDataBuffer;

  /// Returns the matching [Response] object, or `null` if the response was not received due to error.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await request.response();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;[Response]?&gt;
  Future<Response?> response();

  /// An object with all the request HTTP headers associated with this request. The header names are lower-cased.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await request.allHeaders();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;Map&lt;String, String&gt;&gt;
  Future<Map<String, String>> allHeaders();

  Future<Map<String, String>> rawRequestHeaders();

  /// Returns the value of the header matching the name. The name is case-insensitive.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await request.headerValue(name);
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

  Future<List<String>> headerValues(String name);
}

class RequestImpl extends RequestBase implements Request {
  Map<String, dynamic>? _timing;

  @override
  Map<String, dynamic> get timing {
    if (_timing != null) return _timing!;

    _timing = {
      'startTime': 0,

      'domainLookupStart': -1,

      'domainLookupEnd': -1,

      'connectStart': -1,

      'secureConnectionStart': -1,

      'connectEnd': -1,

      'requestStart': -1,

      'responseStart': -1,

      'responseEnd': -1,
    };

    return _timing!;
  }

  set timing(Map<String, dynamic> value) {
    _timing = value;
  }

  @override
  Request? get redirectedFrom => typedInitializer.redirectedFrom as Request?;

  RequestImpl? _redirectedTo;

  @override
  Request? get redirectedTo => _redirectedTo;

  String? _failureText;

  @override
  String? get failure => _failureText;

  set failureText(String? value) {
    _failureText = value;
  }

  @override
  dynamic get postDataJSON {
    final data = postData;

    if (data == null) return null;

    try {
      return jsonDecode(data);
    } catch (_) {
      return null;
    }
  }

  @override
  List<int>? get postDataBuffer {
    final b64 = typedInitializer.postData;

    if (b64 == null) return null;

    return base64Decode(b64);
  }

  RequestImpl(
    super.connection,

    super.channelType,

    super.guid,

    super.initializer, [

    super.parent,
  ]) {
    // Wire the redirectedFrom → redirectedTo back-reference so that
    // request.redirectedTo returns the redirect chain correctly.
    final from = typedInitializer.redirectedFrom;
    if (from != null && from is RequestImpl) {
      from._redirectedTo = this;
    }
  }

  @override
  String get url => typedInitializer.url;

  @override
  Frame get frame => typedInitializer.frame as Frame;

  @override
  String get resourceType => typedInitializer.resourceType;

  @override
  String get method => typedInitializer.method;

  @override
  String? get postData {
    final b64 = typedInitializer.postData;

    if (b64 == null) return null;

    return utf8.decode(base64Decode(b64));
  }

  @override
  Map<String, dynamic> get headers =>
      typedInitializer.headers.fold<Map<String, dynamic>>({}, (map, header) {
        map[header.name.toLowerCase()] = header.value;

        return map;
      });

  @override
  bool get isNavigationRequest => typedInitializer.isNavigationRequest;

  @override
  Future<Response?> response() async {
    final result = await channel.response();

    final resp = result.response;

    if (resp == null) return null;

    return ChannelOwner.from(connection, resp as Map<String, dynamic>);
  }

  @override
  Future<Map<String, String>> allHeaders() async {
    final result = await channel.rawRequestHeaders();

    final headers = result.headers as List;

    return {
      for (final h in headers)
        (h['name'] as String).toLowerCase(): h['value'] as String,
    };
  }

  @override
  Future<Map<String, String>> rawRequestHeaders() => allHeaders();

  @override
  Future<String?> headerValue(String name) async {
    final all = await allHeaders();

    return all[name.toLowerCase()];
  }

  @override
  Future<List<String>> headerValues(String name) async {
    final result = await channel.rawRequestHeaders();

    final lower = name.toLowerCase();

    return [
      for (final h in result.headers)
        if (h.name.toLowerCase() == lower) h.value,
    ];
  }
}
