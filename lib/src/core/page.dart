import '../interaction/interaction_types.dart';
import 'pdf_dimension.dart';
import 'route_matcher.dart';
import '../utils/download.dart';

import '../interaction/jshandle.dart';

import '../debugging/binding_call.dart';

import '../network/websocket_route.dart';

import '../interaction/page_assertions.dart';

import 'dart:async';

import 'dart:convert';

import 'dart:io';

import 'dart:typed_data';

import 'pdf_format.dart';

import 'browser_context.dart';

import '../generated/channels.dart' as channels;

import '../generated/channels.dart' hide ConsoleMessage;

import 'frame.dart';

import 'frame_locator.dart';

import 'locator.dart';

import '../interaction/keyboard.dart';

import '../interaction/mouse.dart';

import '../interaction/touchscreen.dart';

import '../network/route.dart';

import '../utils/video.dart';

import '../utils/console_message.dart';

import '../interaction/file_chooser.dart';

import '../interaction/dialog.dart';

import '../utils/worker.dart';

import '../utils/artifact.dart';

import '../network/route_from_har.dart';

import '../network/route_handler.dart';

import '../network/request.dart';

import '../network/response.dart';

import '../interaction/element_handle.dart';

import '../utils/locator_utils.dart';

import '../utils/logger.dart';

import '../utils/clock.dart';

import '../network/api_request_context.dart';

/// Page provides methods to interact with a single tab or extension background page in a browser.

///

/// One Browser instance might have multiple Page instances.

/// Interface for Page

abstract interface class Page {
  /// An array of all frames attached to the page.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// page.frames;
  /// ```
  ///
  /// **Returns**
  /// - List&lt;[Frame]&gt;
  List<Frame> get frames;

  /// This method returns all of the dedicated [WebWorkers] associated with the page.
  ///
  /// **NOTE**
  /// This does not contain ServiceWorkers
  /// **Usage**
  ///
  /// ```dart
  /// page.workers;
  /// ```
  ///
  /// **Returns**
  /// - List&lt;[Worker]&gt;
  List<Worker> get workers;

  /// Stream that emits when a WebSocket route is created.
  Stream<WebSocketRoute> get onWebSocketRoute;

  /// Stream that emits when a screencast frame is available.
  Stream<Map<String, dynamic>> get onScreencastFrame;

  /// Stream that emits when a route is created.
  Stream<Route> get onRoute;

  /// Stream that emits when a locator handler is triggered.
  Stream<dynamic> get onLocatorHandlerTriggered;

  /// Stream that emits when a frame is detached.
  Stream<Frame> get onFrameDetached;

  /// Stream that emits when a frame is attached.
  Stream<Frame> get onFrameAttached;

  /// Stream that emits when the viewport size changes.
  Stream<Map<String, dynamic>> get onViewportSizeChanged;

  /// Stream that emits when a binding call is made.
  Stream<BindingCall> get onBindingCall;

  /// **Usage**
  ///
  /// ```dart
  /// page.keyboard
  /// ```
  ///
  /// **Type**
  /// - [Keyboard]
  Keyboard get keyboard;

  /// **Usage**
  ///
  /// ```dart
  /// page.mouse
  /// ```
  ///
  /// **Type**
  /// - [Mouse]
  Mouse get mouse;

  /// **Usage**
  ///
  /// ```dart
  /// page.touchscreen
  /// ```
  ///
  /// **Type**
  /// - [Touchscreen]
  Touchscreen get touchscreen;

  /// Get the browser context that the page belongs to.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// page.context;
  /// ```
  ///
  /// **Returns**
  /// - [BrowserContext]
  BrowserContext get context;

  /// API testing helper associated with this page. This method returns the same instance as [browserContext.request] on the page's context. See [browserContext.request] for more details.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// page.request
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
  /// page.clock
  /// ```
  ///
  /// **Type**
  /// - [Clock]
  Clock get clock;

  /// The page's main frame. Page is guaranteed to have a main frame which persists during navigations.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// page.mainFrame;
  /// ```
  ///
  /// **Returns**
  /// - [Frame]
  Frame get mainFrame;

  /// Stream that emits when a console message is logged.
  Stream<ConsoleMessage> get onConsole;

  /// Stream that emits when a file chooser is shown.
  Stream<FileChooser> get onFileChooser;

  /// Stream that emits when a dialog is shown.
  Stream<Dialog> get onDialog;

  /// Stream that emits when a request is made.
  Stream<Request> get onRequest;

  /// Stream that emits when a response is received.
  Stream<Response> get onResponse;

  /// Stream that emits when a request finishes.
  Stream<Request> get onRequestFinished;

  /// Stream that emits when a request fails.
  Stream<Request> get onRequestFailed;

  /// Stream that emits when a WebSocket is created.
  Stream<WebSocket> get onWebSocket;

  /// Stream that emits when the page closes.
  Stream<Page> get onClose;

  /// Stream that emits when the page crashes.
  Stream<Page> get onCrash;

  /// Stream that emits when a page error occurs.
  Stream<Exception> get onPageError;

  /// Video object associated with this page. Can be used to access the video file when using the `recordVideo` context option.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// page.video();
  /// ```
  ///
  /// **Returns**
  /// - [Video]?
  Video? video();

  /// Stream that emits when a popup page is created.
  Stream<Page> get onPopup;

  /// Stream that emits when a worker is created.
  Stream<Worker> get onWorker;

  /// Waits for the matching request and returns it. See [waiting for event] for more details about events.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// // Start waiting for request before clicking. Note no await.
  /// final requestFuture = page.waitForRequest('https://example.com/resource');
  /// await page.getByText('trigger request').click();
  /// final request = await requestFuture;
  ///
  /// // Alternative way with a predicate. Note no await.
  /// final requestFuture = page.waitForRequest((request) =>
  ///   request.url() == 'https://example.com' && request.method() == 'GET',
  /// );
  /// await page.getByText('trigger request').click();
  /// final request = await requestFuture;
  /// ```
  ///
  /// **Arguments**
  /// - `urlOrPredicate` RouteMatcher
  ///
  ///   Request URL string, regex or predicate receiving [Request] object.
  /// - `options` Map *(optional)*
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     Allows to cancel the waiting using an [`AbortSignal`]. If the signal is aborted, the waiting will be aborted and the operation will throw an error. Note that providing a signal does not disable the default timeout, which can be changed using [browserContext.setDefaultTimeout()]; pass `timeout: 0` to disable the timeout entirely.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum wait time in milliseconds, defaults to 30 seconds, pass `0` to disable the timeout. The default value can be changed by using the [page.setDefaultTimeout()] method.
  ///
  /// **Returns**
  /// - Future&lt;[Request]&gt;
  Future<Request> waitForRequest(
    RouteMatcher urlOrPredicate, {
    double? timeout,
  });

  /// Returns the matched response. See [waiting for event] for more details about events.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// // Start waiting for response before clicking. Note no await.
  /// final responseFuture = page.waitForResponse('https://example.com/resource');
  /// await page.getByText('trigger response').click();
  /// final response = await responseFuture;
  ///
  /// // Alternative way with a predicate. Note no await.
  /// final responseFuture = page.waitForResponse((response) =>
  ///   response.url() == 'https://example.com' && response.status() == 200
  ///       && response.request().method() == 'GET'
  /// );
  /// await page.getByText('trigger response').click();
  /// final response = await responseFuture;
  /// ```
  ///
  /// **Arguments**
  /// - `urlOrPredicate` RouteMatcher
  ///
  ///   Request URL string, regex or predicate receiving [Response] object. When a [baseURL] via the context options was provided and the passed URL is a path, it gets merged via the [`new URL()`] constructor.
  /// - `options` Map *(optional)*
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     Allows to cancel the waiting using an [`AbortSignal`]. If the signal is aborted, the waiting will be aborted and the operation will throw an error. Note that providing a signal does not disable the default timeout, which can be changed using [browserContext.setDefaultTimeout()]; pass `timeout: 0` to disable the timeout entirely.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum wait time in milliseconds, defaults to 30 seconds, pass `0` to disable the timeout. The default value can be changed by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;[Response]&gt;
  Future<Response> waitForResponse(
    RouteMatcher urlOrPredicate, {
    double? timeout,
  });

  /// Indicates that the page has been closed.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// page.isClosed;
  /// ```
  ///
  /// **Returns**
  /// - bool
  bool get isClosed;

  /// **Usage**
  ///
  /// ```dart
  /// page.url();
  /// ```
  ///
  /// **Returns**
  /// - String
  String url();

  /// **Usage**
  ///
  /// ```dart
  /// page.viewportSize;
  /// ```
  ///
  /// **Returns**
  /// - [Map]?
  ///   - `width` num
  ///
  ///     page width in pixels.
  ///   - `height` num
  ///
  ///     page height in pixels.
  PageSetViewportSize? get viewportSize;

  /// This setting will change the default maximum time for all the methods accepting [timeout] option.
  ///
  /// **NOTE**
  /// [page.setDefaultNavigationTimeout()] takes priority over [page.setDefaultTimeout()].
  /// **Usage**
  ///
  /// ```dart
  /// page.setDefaultTimeout(timeout);
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
  /// * [page.waitForURL()]
  ///
  /// **NOTE**
  /// [page.setDefaultNavigationTimeout()] takes priority over [page.setDefaultTimeout()], [browserContext.setDefaultTimeout()] and [browserContext.setDefaultNavigationTimeout()].
  /// **Usage**
  ///
  /// ```dart
  /// page.setDefaultNavigationTimeout(timeout);
  /// ```
  ///
  /// **Arguments**
  /// - `timeout` double
  ///
  ///   Maximum navigation time in milliseconds
  void setDefaultNavigationTimeout(double timeout);

  /// Stream that emits when a download starts.
  Stream<Download> get onDownload;

  /// Returns the main resource response. In case of multiple redirects, the navigation will resolve with the first non-redirect response.
  ///
  /// The method will throw an error if:
  /// * there's an SSL error (e.g. in case of self-signed certificates).
  /// * target URL is invalid.
  /// * the [timeout] is exceeded during navigation.
  /// * the remote server does not respond or is unreachable.
  /// * the main resource failed to load.
  ///
  /// The method will not throw an error when any valid HTTP status code is returned by the remote server, including 404 "Not Found" and 500 "Internal Server Error".  The status code for such responses can be retrieved by calling [response.status()].
  ///
  /// **NOTE**
  /// The method either throws an error or returns a main resource response. The only exceptions are navigation to `about:blank` or navigation to the same URL with a different hash, which would succeed and return `null`.
  /// **NOTE**
  /// Headless mode doesn't support navigation to a PDF document. See the [upstream issue].
  /// **Usage**
  ///
  /// ```dart
  /// await page.goto(url);
  /// await page.goto(url, options);
  /// ```
  ///
  /// **Arguments**
  /// - `url` String
  ///
  ///   URL to navigate page to. The url should include scheme, e.g. `https://`. When a [baseURL] via the context options was provided and the passed URL is a path, it gets merged via the [`new URL()`] constructor.
  /// - `options` Map *(optional)*
  ///   - `referer` String *(optional)*
  ///
  ///     Referer header value. If provided it will take preference over the referer header value set by [page.setExtraHTTPHeaders()].
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     Allows to cancel the operation using an [`AbortSignal`]. If the signal is aborted, the operation will be aborted and throw an error. Note that providing a signal does not disable the default timeout, which can be changed using [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()]; pass `timeout: 0` to disable the timeout entirely.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum operation time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `navigationTimeout` option in the config, or by using the [browserContext.setDefaultNavigationTimeout()], [browserContext.setDefaultTimeout()], [page.setDefaultNavigationTimeout()] or [page.setDefaultTimeout()] methods.
  ///   - `waitUntil` LifecycleEvent *(optional)*
  ///
  ///     When to consider operation succeeded, defaults to `load`. Events can be either:
  ///     * `'domcontentloaded'` - consider operation to be finished when the `DOMContentLoaded` event is fired.
  ///     * `'load'` - consider operation to be finished when the `load` event is fired.
  ///     * `'networkidle'` - **DISCOURAGED** consider operation to be finished when there are no network connections for at least `500` ms. Don't use this method for testing, rely on web assertions to assess readiness instead.
  ///     * `'commit'` - consider operation to be finished when network response is received and the document started loading.
  ///
  /// **Returns**
  /// - Future&lt;[Response]?&gt;
  Future<void> goto(
    String url, {

    double? timeout,

    LifecycleEvent? waitUntil,

    String? referer,
  });

  /// Returns when the required load state has been reached.
  ///
  /// This resolves when the page reaches a required load state, `load` by default. The navigation must have been committed when this method is called. If current document has already reached the required state, resolves immediately.
  ///
  /// **NOTE**
  /// Most of the time, this method is not needed because Playwright [auto-waits before every action].
  /// **Usage**
  ///
  /// ```dart
  /// await page.getByRole('button').click(); // Click triggers navigation.
  /// await page.waitForLoadState(); // The future resolves after 'load' event.
  /// ```
  ///
  /// ```dart
  /// final popupFuture = page.onPopup.first;
  /// await page.getByRole('button').click(); // Click triggers a popup.
  /// final popup = await popupFuture;
  /// await popup.waitForLoadState('domcontentloaded'); // Wait for the 'DOMContentLoaded' event.
  /// print(await popup.title()); // Popup is ready to use.
  /// ```
  ///
  /// **Arguments**
  /// - `state` LifecycleEvent *(optional)*
  ///
  ///   Optional load state to wait for, defaults to `load`. If the state has been already reached while loading current document, the method resolves immediately. Can be one of:
  ///   * `'load'` - wait for the `load` event to be fired.
  ///   * `'domcontentloaded'` - wait for the `DOMContentLoaded` event to be fired.
  ///   * `'networkidle'` - **DISCOURAGED** wait until there are no network connections for at least `500` ms. Don't use this method for testing, rely on web assertions to assess readiness instead.
  /// - `options` Map *(optional)*
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     Allows to cancel the waiting using an [`AbortSignal`]. If the signal is aborted, the waiting will be aborted and the operation will throw an error. Note that providing a signal does not disable the default timeout, which can be changed using [browserContext.setDefaultTimeout()]; pass `timeout: 0` to disable the timeout entirely.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum operation time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `navigationTimeout` option in the config, or by using the [browserContext.setDefaultNavigationTimeout()], [browserContext.setDefaultTimeout()], [page.setDefaultNavigationTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> waitForLoadState({LifecycleEvent state, double? timeout});

  /// Waits for the main frame to navigate to the given URL.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await page.click('a.delayed-navigation'); // Clicking the link will indirectly cause a navigation
  /// await page.waitForURL('**/target.html');
  /// ```
  ///
  /// **Arguments**
  /// - `url` String | [RegExp] | [URLPattern] | Function\([URL]\):bool
  ///
  ///   A glob pattern, regex pattern, URL pattern, or predicate receiving [URL] to match while waiting for the navigation. Note that if the parameter is a string without wildcard characters, the method will wait for navigation to URL that is exactly equal to the string.
  /// - `options` Map *(optional)*
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     Allows to cancel the waiting using an [`AbortSignal`]. If the signal is aborted, the waiting will be aborted and the operation will throw an error. Note that providing a signal does not disable the default timeout, which can be changed using [browserContext.setDefaultTimeout()]; pass `timeout: 0` to disable the timeout entirely.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum operation time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `navigationTimeout` option in the config, or by using the [browserContext.setDefaultNavigationTimeout()], [browserContext.setDefaultTimeout()], [page.setDefaultNavigationTimeout()] or [page.setDefaultTimeout()] methods.
  ///   - `waitUntil` LifecycleEvent *(optional)*
  ///
  ///     When to consider operation succeeded, defaults to `load`. Events can be either:
  ///     * `'domcontentloaded'` - consider operation to be finished when the `DOMContentLoaded` event is fired.
  ///     * `'load'` - consider operation to be finished when the `load` event is fired.
  ///     * `'networkidle'` - **DISCOURAGED** consider operation to be finished when there are no network connections for at least `500` ms. Don't use this method for testing, rely on web assertions to assess readiness instead.
  ///     * `'commit'` - consider operation to be finished when network response is received and the document started loading.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> waitForURL(
    RouteMatcher urlOrPredicate, {

    double? timeout,

    LifecycleEvent? waitUntil,
  });

  /// **WARNING**
  /// [Deprecated]
  ///
  /// This method is inherently racy, please use [page.waitForURL()] instead.
  ///
  /// Waits for the main frame navigation and returns the main resource response. In case of multiple redirects, the navigation will resolve with the response of the last redirect. In case of navigation to a different anchor or navigation due to History API usage, the navigation will resolve with `null`.
  ///
  /// **Usage**
  ///
  /// This resolves when the page navigates to a new URL or reloads. It is useful for when you run code which will indirectly cause the page to navigate. e.g. The click target has an `onclick` handler that triggers navigation from a `setTimeout`. Consider this example:
  ///
  /// ```dart
  /// // Start waiting for navigation before clicking. Note no await.
  /// final navigationFuture = page.waitForNavigation();
  /// await page.getByText('Navigate after timeout').click();
  /// await navigationFuture;
  /// ```
  ///
  /// **NOTE**
  /// Usage of the [History API] to change the URL is considered a navigation.
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     Allows to cancel the waiting using an [`AbortSignal`]. If the signal is aborted, the waiting will be aborted and the operation will throw an error. Note that providing a signal does not disable the default timeout, which can be changed using [browserContext.setDefaultTimeout()]; pass `timeout: 0` to disable the timeout entirely.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum operation time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `navigationTimeout` option in the config, or by using the [browserContext.setDefaultNavigationTimeout()], [browserContext.setDefaultTimeout()], [page.setDefaultNavigationTimeout()] or [page.setDefaultTimeout()] methods.
  ///   - `url` RouteMatcher *(optional)*
  ///
  ///     A glob pattern, regex pattern, URL pattern, or predicate receiving [URL] to match while waiting for the navigation. Note that if the parameter is a string without wildcard characters, the method will wait for navigation to URL that is exactly equal to the string.
  ///   - `waitUntil` LifecycleEvent *(optional)*
  ///
  ///     When to consider operation succeeded, defaults to `load`. Events can be either:
  ///     * `'domcontentloaded'` - consider operation to be finished when the `DOMContentLoaded` event is fired.
  ///     * `'load'` - consider operation to be finished when the `load` event is fired.
  ///     * `'networkidle'` - **DISCOURAGED** consider operation to be finished when there are no network connections for at least `500` ms. Don't use this method for testing, rely on web assertions to assess readiness instead.
  ///     * `'commit'` - consider operation to be finished when network response is received and the document started loading.
  ///
  /// **Returns**
  /// - Future&lt;[Response]?&gt;
  Future<void> waitForNavigation({
    RouteMatcher? url,

    LifecycleEvent? waitUntil,

    double? timeout,
  });

  /// Returns the page's title.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await page.title();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;String&gt;
  Future<String> title();

  /// The method returns an element locator that can be used to perform actions on this page / frame. Locator is resolved to the element immediately before performing an action, so a series of actions on the same locator can in fact be performed on different DOM elements. That would happen if the DOM structure between those actions has changed.
  ///
  /// [Learn more about locators].
  ///
  /// **Usage**
  ///
  /// ```dart
  /// page.locator(selector);
  /// page.locator(selector, options);
  /// ```
  ///
  /// **Arguments**
  /// - `selector` String
  ///
  ///   A selector to use when resolving DOM element.
  /// - `options` Map *(optional)*
  ///   - `has` [Locator] *(optional)*
  ///
  ///     Narrows down the results of the method to those which contain elements matching this relative locator. For example, `article` that has `text=Playwright` matches `<article><div>Playwright</div></article>`.
  ///
  ///     Inner locator **must be relative** to the outer locator and is queried starting with the outer locator match, not the document root. For example, you can find `content` that has `div` in `<article><content><div>Playwright</div></content></article>`. However, looking for `content` that has `article div` will fail, because the inner locator must be relative and should not use any elements outside the `content`.
  ///
  ///     Note that outer and inner locators must belong to the same frame. Inner locator must not contain [FrameLocator]s.
  ///   - `hasNot` [Locator] *(optional)*
  ///
  ///     Matches elements that do not contain an element that matches an inner locator. Inner locator is queried against the outer one. For example, `article` that does not have `div` matches `<article><span>Playwright</span></article>`.
  ///
  ///     Note that outer and inner locators must belong to the same frame. Inner locator must not contain [FrameLocator]s.
  ///   - `hasNotText` String | [RegExp] *(optional)*
  ///
  ///     Matches elements that do not contain specified text somewhere inside, possibly in a child or a descendant element. When passed a String, matching is case-insensitive and searches for a substring.
  ///   - `hasText` String | [RegExp] *(optional)*
  ///
  ///     Matches elements containing specified text somewhere inside, possibly in a child or a descendant element. When passed a String, matching is case-insensitive and searches for a substring. For example, `"Playwright"` matches `<article><div>Playwright</div></article>`.
  ///
  /// **Returns**
  /// - [Locator]
  Locator locator(String selector);

  /// When working with iframes, you can create a frame locator that will enter the iframe and allow selecting elements in that iframe.
  ///
  /// **Usage**
  ///
  /// Following snippet locates element with text "Submit" in the iframe with id `my-frame`, like `<iframe id="my-frame">`:
  ///
  /// ```dart
  /// final locator = page.frameLocator('#my-iframe').getByText('Submit');
  /// await locator.click();
  /// ```
  ///
  /// **Arguments**
  /// - `selector` String
  ///
  ///   A selector to use when resolving DOM element.
  ///
  /// **Returns**
  /// - [FrameLocator]
  FrameLocator frameLocator(String selector);

  /// Returns the value of the [pageFunction] invocation.
  ///
  /// If the function passed to the [page.evaluate()] returns a Future, then [page.evaluate()] would wait for the future to complete and return its value.
  ///
  /// If the function passed to the [page.evaluate()] returns a non-[Serializable] value, then [page.evaluate()] resolves to `undefined`. Playwright also supports transferring some additional values that are not serializable by `JSON`: `-0`, `NaN`, `Infinity`, `-Infinity`.
  ///
  /// **Usage**
  ///
  /// Passing argument to [pageFunction]:
  ///
  /// ```dart
  /// final result = await page.evaluate(([x, y]) {
  ///   return Future.value(x * y);
  /// }, [7, 8]);
  /// print(result); // prints "56"
  /// ```
  ///
  /// A string can also be passed in instead of a function:
  ///
  /// ```dart
  /// print(await page.evaluate('1 + 2')); // prints "3"
  /// final x = 10;
  /// print(await page.evaluate(`1 + ${x}`)); // prints "11"
  /// ```
  ///
  /// [ElementHandle] instances can be passed as an argument to the [page.evaluate()]:
  ///
  /// ```dart
  /// final bodyHandle = await page.evaluateHandle('document.body');
  /// final html = await page.evaluate<string, HTMLElement>(([body, suffix]) =>
  ///   body.innerHTML + suffix, [bodyHandle, 'hello']
  /// );
  /// await bodyHandle.dispose();
  /// ```
  ///
  /// **Arguments**
  /// - `pageFunction` Function | String
  ///
  ///   Function to be evaluated in the page context.
  /// - `arg` Object *(optional)*
  ///
  ///   Optional argument to pass to [pageFunction].
  /// - `options` Map *(optional)*
  ///   - `exposeFunctions` bool *(optional)*
  ///
  ///     When set to `true`, functions passed inside [arg] are exposed in the page and can be called from the page function. Calling one returns a Future of its result. Under the hood, each function is exposed via [page.exposeFunction()], so it is technically accessible from all frames and worlds of the page. Exposed functions are cleared upon the top-level navigation. Defaults to `false`, in which case functions are not serializable and passing one throws an error.
  ///
  /// **Returns**
  /// - Future&lt;[Serializable]&gt;
  Future<T> evaluate<T>(String expression, [Object? arg]);

  /// **WARNING**
  /// [Discouraged]
  ///
  /// Use web assertions that assert visibility or a locator-based [locator.waitFor()] instead. Read more about [locators].
  ///
  /// Returns when element specified by selector satisfies [state] option. Returns `null` if waiting for `hidden` or `detached`.
  ///
  /// **NOTE**
  /// Playwright automatically waits for element to be ready before performing an action. Using [Locator] objects and web-first assertions makes the code wait-for-selector-free.
  /// Wait for the [selector] to satisfy [state] option (either appear/disappear from dom, or become visible/hidden). If at the moment of calling the method [selector] already satisfies the condition, the method will return immediately. If the selector doesn't satisfy the condition for the [timeout] milliseconds, the function will throw.
  ///
  /// **Usage**
  ///
  /// This method works across navigations:
  ///
  /// ```dart
  ///   // Or 'firefox' or 'webkit'.
  ///
  /// (() async {
  ///   final browser = await chromium.launch();
  ///   final page = await browser.newPage();
  ///   for (final currentURL of ['https://google.com', 'https://bbc.com']) {
  ///     await page.goto(currentURL);
  ///     final element = await page.waitForSelector('img');
  ///     print('Loaded image: ' + await element.getAttribute('src'));
  ///   }
  ///   await browser.close();
  /// }
  /// ```
  ///
  /// **Arguments**
  /// - `selector` String
  ///
  ///   A selector to query for.
  /// - `options` Map *(optional)*
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     Allows to cancel the operation using an [`AbortSignal`]. If the signal is aborted, the operation will be aborted and throw an error. Note that providing a signal does not disable the default timeout, which can be changed using [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()]; pass `timeout: 0` to disable the timeout entirely.
  ///   - `state` SelectorState *(optional)*
  ///
  ///     Defaults to `'visible'`. Can be either:
  ///     * `'attached'` - wait for element to be present in DOM.
  ///     * `'detached'` - wait for element to not be present in DOM.
  ///     * `'visible'` - wait for element to have non-empty bounding box and no `visibility:hidden`. Note that element without any content or with `display:none` has an empty bounding box and is not considered visible.
  ///     * `'hidden'` - wait for element to be either detached from DOM, or have an empty bounding box or `visibility:hidden`. This is opposite to the `'visible'` option.
  ///   - `strict` bool *(optional)*
  ///
  ///     When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;[ElementHandle]?&gt;
  Future<FrameWaitForSelectorResult> waitForSelector(
    String selector, {

    SelectorState? state,

    double? timeout,
  });

  /// If specified the network requests that are made in the page will be served from the HAR file. Read more about [Replaying from HAR].
  ///
  /// Playwright will not serve requests intercepted by Service Worker from the HAR file. See [this] issue. We recommend disabling Service Workers when using request interception by setting [serviceWorkers] to `'block'`.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await page.routeFromHAR(har);
  /// await page.routeFromHAR(har, options);
  /// ```
  ///
  /// **Arguments**
  /// - `har` String
  ///
  ///   Path to a [HAR] file with prerecorded network data. If `path` is a relative path, then it is resolved relative to the current working directory.
  /// - `options` Map *(optional)*
  ///   - `notFound` "abort" | "fallback" *(optional)*
  ///     * If set to 'abort' any request not found in the HAR file will be aborted.
  ///     * If set to 'fallback' missing requests will be sent to the network.
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

  /// Routing provides the capability to modify network requests that are made by a page.
  ///
  /// Once routing is enabled, every request matching the url pattern will stall unless it's continued, fulfilled or aborted.
  ///
  /// **NOTE**
  /// The handler will only be called for the first url if the response is a redirect.
  /// **NOTE**
  /// [page.route()] will not intercept requests intercepted by Service Worker. See [this] issue. We recommend disabling Service Workers when using request interception by setting [serviceWorkers] to `'block'`.
  /// **NOTE**
  /// [page.route()] will not intercept the first request of a popup page. Use [browserContext.route()] instead.
  /// **Usage**
  ///
  /// An example of a naive handler that aborts all image requests:
  ///
  /// ```dart
  /// final page = await browser.newPage();
  /// await page.route('**/*.{png,jpg,jpeg}', (route) => route.abort());
  /// await page.goto('https://example.com');
  /// await browser.close();
  /// ```
  ///
  /// or the same snippet using a regex pattern instead:
  ///
  /// ```dart
  /// final page = await browser.newPage();
  /// await page.route(/(\.png$)|(\.jpg$)/, (route) => route.abort());
  /// await page.goto('https://example.com');
  /// await browser.close();
  /// ```
  ///
  /// It is possible to examine the request to decide the route action. For example, mocking all requests that contain some post data, and leaving all other requests as is:
  ///
  /// ```dart
  /// await page.route('/api/**', (route) async {
  ///   if (route.request().postData().includes('my-string'))
  ///     await route.fulfill( body: 'mocked-data' );
  ///   else
  ///     await route.continue();
  /// );
  /// ```
  ///
  /// If a request matches multiple registered routes, the most recently registered route takes precedence.
  ///
  /// Page routes take precedence over browser context routes (set up with [browserContext.route()]) when request matches both handlers.
  ///
  /// To remove a route with its handler you can use [page.unroute()].
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

  /// Removes a route created with [page.route()]. When [handler] is not specified, removes all routes for the [url].
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await page.unroute(url);
  /// await page.unroute(url, handler);
  /// ```
  ///
  /// **Arguments**
  /// - `url` String
  ///
  ///   A glob pattern, regex pattern, URL pattern, or predicate receiving [URL] to match while routing.
  /// - `handler` Future&lt;void&gt; Function(Route route) *(optional)*
  ///
  ///   Optional handler function to route the request.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> unroute(
    String url, {

    Future<void> Function(Route route)? handler,
  });

  /// Removes all routes created with [page.route()] and [page.routeFromHAR()].
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await page.unrouteAll();
  /// await page.unrouteAll(options);
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

  /// Returns frame matching the specified criteria. Either `name` or `url` must be specified.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// final frame = page.frame('frame-name');
  /// ```
  ///
  /// ```dart
  /// final frame = page.frame( url: /.*domain.*/ );
  /// ```
  ///
  /// **Arguments**
  /// - `frameSelector` String | Map
  ///   - `name` String *(optional)*
  ///
  ///     Frame name specified in the `iframe`'s `name` attribute. Optional.
  ///   - `url` String *(optional)*
  ///
  ///     A glob pattern, regex pattern, URL pattern, or predicate receiving frame's `url` as a [URL] object. Optional.
  ///
  ///   Frame name or other frame lookup options.
  ///
  /// **Returns**
  /// - [Frame]?
  Frame? frame({String? name, String? url});

  /// Allows locating elements that contain given text.
  ///
  /// See also [locator.filter()] that allows to match by another criteria, like an accessible role, and then filter by the text content.
  ///
  /// **Usage**
  ///
  /// Consider the following DOM structure:
  ///
  /// ```html
  /// <div>Hello <span>world</span></div>
  /// <div>Hello</div>
  /// ```
  ///
  /// You can locate by text substring, exact string, or a regular expression:
  ///
  /// ```dart
  /// // Matches <span>
  /// page.getByText('world');
  ///
  /// // Matches first <div>
  /// page.getByText('Hello world');
  ///
  /// // Matches second <div>
  /// page.getByText('Hello', { exact: true );
  ///
  /// // Matches both <div>s
  /// page.getByText(/Hello/);
  ///
  /// // Matches second <div>
  /// page.getByText(/^hello$/i);
  /// ```
  ///
  /// **Arguments**
  /// - `text` Pattern
  ///
  ///   Text to locate the element for.
  /// - `options` Map *(optional)*
  ///   - `exact` bool *(optional)*
  ///
  ///     Whether to find an exact match: case-sensitive and whole-string. Default to false. Ignored when locating by a regular expression. Note that exact match still trims whitespace.
  ///
  /// **Returns**
  /// - [Locator]
  ///
  /// **Details**
  ///
  /// Matching by text always normalizes whitespace, even with exact match. For example, it turns multiple spaces into one, turns line breaks into spaces and ignores leading and trailing whitespace.
  ///
  /// Input elements of the type `button` and `submit` are matched by their `value` instead of the text content. For example, locating by text `"Log in"` matches `<input type=button value="Log in">`.
  Locator getByText(Pattern text, {bool exact});

  /// Allows locating elements by their [ARIA role], [ARIA attributes] and [accessible name].
  ///
  /// **Usage**
  ///
  /// Consider the following DOM structure.
  ///
  /// ```html
  /// <h3>Sign up</h3>
  /// <label>
  ///   <input type="checkbox" /> Subscribe
  /// </label>
  /// <br/>
  /// <button>Submit</button>
  /// ```
  ///
  /// You can locate each element by its implicit role:
  ///
  /// ```dart
  /// await expect(page.getByRole('heading', { name: 'Sign up' )).toBeVisible();
  ///
  /// await page.getByRole('checkbox', { name: 'Subscribe' ).check();
  ///
  /// await page.getByRole('button', { name: /submit/i ).click();
  /// ```
  ///
  /// **Arguments**
  /// - `role` String
  ///
  ///   Required aria role.
  /// - `options` Map *(optional)*
  ///   - `checked` bool *(optional)*
  ///
  ///     An attribute that is usually set by `aria-checked` or native `<input type=checkbox>` controls.
  ///
  ///     Learn more about [`aria-checked`].
  ///   - `description` Pattern *(optional)*
  ///
  ///     Option to match the [accessible description]. By default, matching is case-insensitive and searches for a substring, use [exact] to control this behavior.
  ///
  ///     Learn more about [accessible description].
  ///   - `disabled` bool *(optional)*
  ///
  ///     An attribute that is usually set by `aria-disabled` or `disabled`.
  ///
  ///     **NOTE**
  /// Unlike most other attributes, `disabled` is inherited through the DOM hierarchy. Learn more about [`aria-disabled`].
  ///     - `exact` bool *(optional)*
  ///
  ///     Whether [name] and [description] are matched exactly: case-sensitive and whole-string. Defaults to false. Ignored when the value is a regular expression. Note that exact match still trims whitespace.
  ///   - `expanded` bool *(optional)*
  ///
  ///     An attribute that is usually set by `aria-expanded`.
  ///
  ///     Learn more about [`aria-expanded`].
  ///   - `includeHidden` bool *(optional)*
  ///
  ///     Option that controls whether hidden elements are matched. By default, only non-hidden elements, as [defined by ARIA], are matched by role selector.
  ///
  ///     Learn more about [`aria-hidden`].
  ///   - `level` int *(optional)*
  ///
  ///     A number attribute that is usually present for roles `heading`, `listitem`, `row`, `treeitem`, with default values for `<h1>-<h6>` elements.
  ///
  ///     Learn more about [`aria-level`].
  ///   - `name` Pattern *(optional)*
  ///
  ///     Option to match the [accessible name]. By default, matching is case-insensitive and searches for a substring, use [exact] to control this behavior.
  ///
  ///     Learn more about [accessible name].
  ///   - `pressed` bool *(optional)*
  ///
  ///     An attribute that is usually set by `aria-pressed`.
  ///
  ///     Learn more about [`aria-pressed`].
  ///   - `selected` bool *(optional)*
  ///
  ///     An attribute that is usually set by `aria-selected`.
  ///
  ///     Learn more about [`aria-selected`].
  ///
  /// **Returns**
  /// - [Locator]
  ///
  /// **Details**
  ///
  /// Role selector **does not replace** accessibility audits and conformance tests, but rather gives early feedback about the ARIA guidelines.
  ///
  /// Many html elements have an implicitly [defined role] that is recognized by the role selector. You can find all the [supported roles here]. ARIA guidelines **do not recommend** duplicating implicit roles and attributes by setting `role` and/or `aria-*` attributes to default values.
  Locator getByRole(
    String role, {
    Pattern? name,
    bool exact,
    bool? checked,
    bool? disabled,
    bool? expanded,
    bool? includeHidden,
    int? level,
    bool? pressed,
    bool? selected,
    Pattern? description,
  });

  /// Allows locating input elements by the text of the associated `<label>` or `aria-labelledby` element, or by the `aria-label` attribute.
  ///
  /// **Usage**
  ///
  /// For example, this method will find inputs by label "Username" and "Password" in the following DOM:
  ///
  /// ```html
  /// <input aria-label="Username">
  /// <label for="password-input">Password:</label>
  /// <input id="password-input">
  /// ```
  ///
  /// ```dart
  /// await page.getByLabel('Username').fill('john');
  /// await page.getByLabel('Password').fill('secret');
  /// ```
  ///
  /// **Arguments**
  /// - `text` Pattern
  ///
  ///   Text to locate the element for.
  /// - `options` Map *(optional)*
  ///   - `exact` bool *(optional)*
  ///
  ///     Whether to find an exact match: case-sensitive and whole-string. Default to false. Ignored when locating by a regular expression. Note that exact match still trims whitespace.
  ///
  /// **Returns**
  /// - [Locator]
  Locator getByLabel(Pattern text, {bool exact});

  /// Allows locating input elements by the placeholder text.
  ///
  /// **Usage**
  ///
  /// For example, consider the following DOM structure.
  ///
  /// ```html
  /// <input type="email" placeholder="name@example.com" />
  /// ```
  ///
  /// You can fill the input after locating it by the placeholder text:
  ///
  /// ```dart
  /// await page
  ///     .getByPlaceholder('name@example.com')
  ///     .fill('playwright@microsoft.com');
  /// ```
  ///
  /// **Arguments**
  /// - `text` Pattern
  ///
  ///   Text to locate the element for.
  /// - `options` Map *(optional)*
  ///   - `exact` bool *(optional)*
  ///
  ///     Whether to find an exact match: case-sensitive and whole-string. Default to false. Ignored when locating by a regular expression. Note that exact match still trims whitespace.
  ///
  /// **Returns**
  /// - [Locator]
  Locator getByPlaceholder(Pattern text, {bool exact});

  /// Allows locating elements by their alt text.
  ///
  /// **Usage**
  ///
  /// For example, this method will find the image by alt text "Playwright logo":
  ///
  /// ```html
  /// <img alt='Playwright logo'>
  /// ```
  ///
  /// ```dart
  /// await page.getByAltText('Playwright logo').click();
  /// ```
  ///
  /// **Arguments**
  /// - `text` Pattern
  ///
  ///   Text to locate the element for.
  /// - `options` Map *(optional)*
  ///   - `exact` bool *(optional)*
  ///
  ///     Whether to find an exact match: case-sensitive and whole-string. Default to false. Ignored when locating by a regular expression. Note that exact match still trims whitespace.
  ///
  /// **Returns**
  /// - [Locator]
  Locator getByAltText(Pattern text, {bool exact});

  /// Allows locating elements by their title attribute.
  ///
  /// **Usage**
  ///
  /// Consider the following DOM structure.
  ///
  /// ```html
  /// <span title='Issues count'>25 issues</span>
  /// ```
  ///
  /// You can check the issues count after locating it by the title text:
  ///
  /// ```dart
  /// await expect(page.getByTitle('Issues count')).toHaveText('25 issues');
  /// ```
  ///
  /// **Arguments**
  /// - `text` Pattern
  ///
  ///   Text to locate the element for.
  /// - `options` Map *(optional)*
  ///   - `exact` bool *(optional)*
  ///
  ///     Whether to find an exact match: case-sensitive and whole-string. Default to false. Ignored when locating by a regular expression. Note that exact match still trims whitespace.
  ///
  /// **Returns**
  /// - [Locator]
  Locator getByTitle(Pattern text, {bool exact});

  /// Locate element by the test id.
  ///
  /// **Usage**
  ///
  /// Consider the following DOM structure.
  ///
  /// ```html
  /// <button data-testid="directions">Itinéraire</button>
  /// ```
  ///
  /// You can locate the element by its test id:
  ///
  /// ```dart
  /// await page.getByTestId('directions').click();
  /// ```
  ///
  /// **Arguments**
  /// - `testId` String
  ///
  ///   Id to locate the element by.
  ///
  /// **Returns**
  /// - [Locator]
  ///
  /// **Details**
  ///
  /// By default, the `data-testid` attribute is used as a test id. Use [selectors.setTestIdAttribute()] to configure a different test id attribute if necessary.
  ///
  /// ```dart
  /// // Set custom test id attribute from @playwright/test config:
  ///
  /// export default defineConfig(
  ///   use: {
  ///     testIdAttribute: 'data-pw'
  ///   },
  /// );
  /// ```
  Locator getByTestId(String testId);

  /// Returns web-first page-level assertions for this page.
  ///
  /// Usage:
  /// ```dart
  /// await page.pageExpect().toHaveTitle('My Title');
  /// await page.pageExpect().not.toHaveURL('/login');
  /// ```
  PageAssertions pageExpect({double? timeout});

  /// In the case of multiple pages in a single browser, each page can have its own viewport size. However, [browser.newContext()] allows to set viewport size (and more) for all pages in the context at once.
  ///
  /// [page.setViewportSize()] will resize the page. A lot of websites don't expect phones to change size, so you should set the viewport size before navigating to the page. [page.setViewportSize()] will also reset `screen` size, use [browser.newContext()] with `screen` and `viewport` parameters if you need better control of these properties.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// final page = await browser.newPage();
  /// await page.setViewportSize(
  ///   width: 640,
  ///   height: 480,
  /// );
  /// await page.goto('https://example.com');
  /// ```
  ///
  /// **Arguments**
  /// - `viewportSize` PageSetViewportSize
  ///   - `width` num
  ///
  ///     page width in pixels.
  ///   - `height` num
  ///
  ///     page height in pixels.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> setViewportSize(PageSetViewportSize viewportSize);

  /// Returns the buffer with the captured screenshot.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await page.screenshot();
  /// await page.screenshot(options);
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `animations` "disabled" | "allow" *(optional)*
  ///
  ///     When set to `"disabled"`, stops CSS animations, CSS transitions and Web Animations. Animations get different treatment depending on their duration:
  ///     * finite animations are fast-forwarded to completion, so they'll fire `transitionend` event.
  ///     * infinite animations are canceled to initial state, and then played over after the screenshot.
  ///
  ///     Defaults to `"allow"` that leaves animations untouched.
  ///   - `caret` "hide" | "initial" *(optional)*
  ///
  ///     When set to `"hide"`, screenshot will hide text caret. When set to `"initial"`, text caret behavior will not be changed.  Defaults to `"hide"`.
  ///   - `clip` Map&lt;String, dynamic&gt; *(optional)*
  ///     - `x` num
  ///
  ///       x-coordinate of top-left corner of clip area
  ///     - `y` num
  ///
  ///       y-coordinate of top-left corner of clip area
  ///     - `width` num
  ///
  ///       width of clipping area
  ///     - `height` num
  ///
  ///       height of clipping area
  ///
  ///     An object which specifies clipping of the resulting image.
  ///   - `fullPage` bool *(optional)*
  ///
  ///     When true, takes a screenshot of the full scrollable page, instead of the currently visible viewport. Defaults to `false`.
  ///   - `mask` List&lt;[Locator]&gt; *(optional)*
  ///
  ///     Specify locators that should be masked when the screenshot is taken. Masked elements will be overlaid with a pink box `#FF00FF` (customized by [maskColor]) that completely covers its bounding box. The mask is also applied to invisible elements, see [Matching only visible elements] to disable that.
  ///   - `maskColor` String *(optional)*
  ///
  ///     Specify the color of the overlay box for masked elements, in [CSS color format]. Default color is pink `#FF00FF`.
  ///   - `omitBackground` bool *(optional)*
  ///
  ///     Hides default white background and allows capturing screenshots with transparency. Not applicable to `jpeg` images. Defaults to `false`.
  ///   - `path` String *(optional)*
  ///
  ///     The file path to save the image to. The screenshot type will be inferred from file extension. If [path] is a relative path, then it is resolved relative to the current working directory. If no path is provided, the image won't be saved to the disk.
  ///   - `quality` int *(optional)*
  ///
  ///     The quality of the image, between 0-100. Not applicable to `png` images. For `jpeg` the default is `80`. For `webp`, a quality of `100` (the default) produces a lossless image, while lower values use lossy compression.
  ///   - `scale` "css" | "device" *(optional)*
  ///
  ///     When set to `"css"`, screenshot will have a single pixel per each css pixel on the page. For high-dpi devices, this will keep screenshots small. Using `"device"` option will produce a single pixel per each device pixel, so screenshots of high-dpi devices will be twice as large or even larger.
  ///
  ///     Defaults to `"device"`.
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     Allows to cancel the operation using an [`AbortSignal`]. If the signal is aborted, the operation will be aborted and throw an error. Note that providing a signal does not disable the default timeout, which can be changed using [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()]; pass `timeout: 0` to disable the timeout entirely.
  ///   - `style` String *(optional)*
  ///
  ///     Text of the stylesheet to apply while making the screenshot. This is where you can hide dynamic elements, make elements invisible or change their properties to help you creating repeatable screenshots. This stylesheet pierces the Shadow DOM and applies to the inner frames.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///   - `type` ElementHandleScreenshotType *(optional)*
  ///
  ///     Specify screenshot type, defaults to `png`.
  ///
  /// **Returns**
  /// - Future&lt;List&lt;int&gt;&gt;
  Future<Uint8List> screenshot({
    String? path,

    bool? fullPage,

    ElementHandleScreenshotType? type,

    int? quality,

    double? timeout,

    Map<String, dynamic>? clip,
  });

  /// Returns the PDF buffer.
  ///
  /// `page.pdf()` generates a pdf of the page with `print` css media. To generate a pdf with `screen` media, call [page.emulateMedia()] before calling `page.pdf()`:
  ///
  /// **NOTE**
  /// By default, `page.pdf()` generates a pdf with modified colors for printing. Use the [`-webkit-print-color-adjust`] property to force rendering of exact colors.
  /// **Usage**
  ///
  /// ```dart
  /// // Generates a PDF with 'screen' media type.
  /// await page.emulateMedia( media: 'screen' );
  /// await page.pdf( path: 'page.pdf' );
  /// ```
  ///
  /// The [width], [height], and [margin] options accept values labeled with units. Unlabeled values are treated as pixels.
  ///
  /// A few examples:
  /// * `page.pdf(width: 100)` - prints with width set to 100 pixels
  /// * `page.pdf(width: '100px')` - prints with width set to 100 pixels
  /// * `page.pdf(width: '10cm')` - prints with width set to 10 centimeters.
  ///
  /// All possible units are:
  /// * `px` - pixel
  /// * `in` - inch
  /// * `cm` - centimeter
  /// * `mm` - millimeter
  ///
  /// The [format] options are:
  /// * `Letter`: 8.5in x 11in
  /// * `Legal`: 8.5in x 14in
  /// * `Tabloid`: 11in x 17in
  /// * `Ledger`: 17in x 11in
  /// * `A0`: 33.1in x 46.8in
  /// * `A1`: 23.4in x 33.1in
  /// * `A2`: 16.54in x 23.4in
  /// * `A3`: 11.7in x 16.54in
  /// * `A4`: 8.27in x 11.7in
  /// * `A5`: 5.83in x 8.27in
  /// * `A6`: 4.13in x 5.83in
  ///
  /// **NOTE**
  /// [headerTemplate] and [footerTemplate] markup have the following limitations: > 1. Script tags inside templates are not evaluated. > 2. Page styles are not visible inside templates.
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `displayHeaderFooter` bool *(optional)*
  ///
  ///     Display header and footer. Defaults to `false`.
  ///   - `footerTemplate` String *(optional)*
  ///
  ///     HTML template for the print footer. Should use the same format as the [headerTemplate].
  ///   - `format` PdfFormat *(optional)*
  ///
  ///     Paper format. If set, takes priority over [width] or [height] options. Defaults to 'Letter'.
  ///   - `headerTemplate` String *(optional)*
  ///
  ///     HTML template for the print header. Should be valid HTML markup with following classes used to inject printing values into them:
  ///     * `'date'` formatted print date
  ///     * `'title'` document title
  ///     * `'url'` document location
  ///     * `'pageNumber'` current page number
  ///     * `'totalPages'` total pages in the document
  ///   - `height` PdfDimension *(optional)*
  ///
  ///     Paper height, accepts values labeled with units.
  ///   - `landscape` bool *(optional)*
  ///
  ///     Paper orientation. Defaults to `false`.
  ///   - `margin` PagePdfMargin *(optional)*
  ///     - `top` String | num *(optional)*
  ///
  ///       Top margin, accepts values labeled with units. Defaults to `0`.
  ///     - `right` String | num *(optional)*
  ///
  ///       Right margin, accepts values labeled with units. Defaults to `0`.
  ///     - `bottom` String | num *(optional)*
  ///
  ///       Bottom margin, accepts values labeled with units. Defaults to `0`.
  ///     - `left` String | num *(optional)*
  ///
  ///       Left margin, accepts values labeled with units. Defaults to `0`.
  ///
  ///     Paper margins, defaults to none.
  ///   - `outline` bool *(optional)*
  ///
  ///     Whether or not to embed the document outline into the PDF. Defaults to `false`.
  ///   - `pageRanges` String *(optional)*
  ///
  ///     Paper ranges to print, e.g., '1-5, 8, 11-13'. Defaults to the empty string, which means print all pages.
  ///   - `path` String *(optional)*
  ///
  ///     The file path to save the PDF to. If [path] is a relative path, then it is resolved relative to the current working directory. If no path is provided, the PDF won't be saved to the disk.
  ///   - `preferCSSPageSize` bool *(optional)*
  ///
  ///     Give any CSS `@page` size declared in the page priority over what is declared in [width] and [height] or [format] options. Defaults to `false`, which will scale the content to fit the paper size.
  ///   - `printBackground` bool *(optional)*
  ///
  ///     Print background graphics. Defaults to `false`.
  ///   - `scale` double *(optional)*
  ///
  ///     Scale of the webpage rendering. Defaults to `1`. Scale amount must be between 0.1 and 2.
  ///   - `tagged` bool *(optional)*
  ///
  ///     Whether or not to generate tagged (accessible) PDF. Defaults to `false`.
  ///   - `width` PdfDimension *(optional)*
  ///
  ///     Paper width, accepts values labeled with units.
  ///
  /// **Returns**
  /// - Future&lt;List&lt;int&gt;&gt;
  Future<Uint8List> pdf({
    String? path,

    PdfFormat? format,

    bool? landscape,

    double? scale,

    bool? displayHeaderFooter,

    String? headerTemplate,

    String? footerTemplate,

    bool? printBackground,

    String? pageRanges,

    PdfDimension? width,

    PdfDimension? height,

    bool? preferCSSPageSize,

    PagePdfMargin? margin,

    bool? tagged,

    bool? outline,
  });

  /// This method reloads the current page, in the same way as if the user had triggered a browser refresh. Returns the main resource response. In case of multiple redirects, the navigation will resolve with the response of the last redirect.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await page.reload();
  /// await page.reload(options);
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     Allows to cancel the operation using an [`AbortSignal`]. If the signal is aborted, the operation will be aborted and throw an error. Note that providing a signal does not disable the default timeout, which can be changed using [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()]; pass `timeout: 0` to disable the timeout entirely.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum operation time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `navigationTimeout` option in the config, or by using the [browserContext.setDefaultNavigationTimeout()], [browserContext.setDefaultTimeout()], [page.setDefaultNavigationTimeout()] or [page.setDefaultTimeout()] methods.
  ///   - `waitUntil` LifecycleEvent *(optional)*
  ///
  ///     When to consider operation succeeded, defaults to `load`. Events can be either:
  ///     * `'domcontentloaded'` - consider operation to be finished when the `DOMContentLoaded` event is fired.
  ///     * `'load'` - consider operation to be finished when the `load` event is fired.
  ///     * `'networkidle'` - **DISCOURAGED** consider operation to be finished when there are no network connections for at least `500` ms. Don't use this method for testing, rely on web assertions to assess readiness instead.
  ///     * `'commit'` - consider operation to be finished when network response is received and the document started loading.
  ///
  /// **Returns**
  /// - Future&lt;[Response]?&gt;
  Future<void> reload({double? timeout, LifecycleEvent? waitUntil});

  /// Returns the main resource response. In case of multiple redirects, the navigation will resolve with the response of the last redirect. If cannot go back, returns `null`.
  ///
  /// Navigate to the previous page in history.
  ///
  /// **WARNING**
  /// **Testing Back/Forward Cache (BFCache) is not supported.**  By default, Playwright disables the Back/Forward Cache across all browsers. Even if explicitly enabled, Playwright's internal state relies on network-level navigation events. Because BFCache restores unfreeze the DOM without firing these events, using `page.goBack()` or `page.goForward()` to trigger a BFCache restore will result in timeouts and a desynchronized `Page` state.
  /// **Usage**
  ///
  /// ```dart
  /// await page.goBack();
  /// await page.goBack(options);
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     Allows to cancel the operation using an [`AbortSignal`]. If the signal is aborted, the operation will be aborted and throw an error. Note that providing a signal does not disable the default timeout, which can be changed using [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()]; pass `timeout: 0` to disable the timeout entirely.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum operation time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `navigationTimeout` option in the config, or by using the [browserContext.setDefaultNavigationTimeout()], [browserContext.setDefaultTimeout()], [page.setDefaultNavigationTimeout()] or [page.setDefaultTimeout()] methods.
  ///   - `waitUntil` LifecycleEvent *(optional)*
  ///
  ///     When to consider operation succeeded, defaults to `load`. Events can be either:
  ///     * `'domcontentloaded'` - consider operation to be finished when the `DOMContentLoaded` event is fired.
  ///     * `'load'` - consider operation to be finished when the `load` event is fired.
  ///     * `'networkidle'` - **DISCOURAGED** consider operation to be finished when there are no network connections for at least `500` ms. Don't use this method for testing, rely on web assertions to assess readiness instead.
  ///     * `'commit'` - consider operation to be finished when network response is received and the document started loading.
  ///
  /// **Returns**
  /// - Future&lt;[Response]?&gt;
  Future<void> goBack({double? timeout, LifecycleEvent? waitUntil});

  /// Returns the main resource response. In case of multiple redirects, the navigation will resolve with the response of the last redirect. If cannot go forward, returns `null`.
  ///
  /// Navigate to the next page in history.
  ///
  /// **WARNING**
  /// **Testing Back/Forward Cache (BFCache) is not supported.**  By default, Playwright disables the Back/Forward Cache across all browsers. Even if explicitly enabled, Playwright's internal state relies on network-level navigation events. Because BFCache restores unfreeze the DOM without firing these events, using `page.goBack()` or `page.goForward()` to trigger a BFCache restore will result in timeouts and a desynchronized `Page` state.
  /// **Usage**
  ///
  /// ```dart
  /// await page.goForward();
  /// await page.goForward(options);
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     Allows to cancel the operation using an [`AbortSignal`]. If the signal is aborted, the operation will be aborted and throw an error. Note that providing a signal does not disable the default timeout, which can be changed using [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()]; pass `timeout: 0` to disable the timeout entirely.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum operation time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `navigationTimeout` option in the config, or by using the [browserContext.setDefaultNavigationTimeout()], [browserContext.setDefaultTimeout()], [page.setDefaultNavigationTimeout()] or [page.setDefaultTimeout()] methods.
  ///   - `waitUntil` LifecycleEvent *(optional)*
  ///
  ///     When to consider operation succeeded, defaults to `load`. Events can be either:
  ///     * `'domcontentloaded'` - consider operation to be finished when the `DOMContentLoaded` event is fired.
  ///     * `'load'` - consider operation to be finished when the `load` event is fired.
  ///     * `'networkidle'` - **DISCOURAGED** consider operation to be finished when there are no network connections for at least `500` ms. Don't use this method for testing, rely on web assertions to assess readiness instead.
  ///     * `'commit'` - consider operation to be finished when network response is received and the document started loading.
  ///
  /// **Returns**
  /// - Future&lt;[Response]?&gt;
  Future<void> goForward({double? timeout, LifecycleEvent? waitUntil});

  /// Adds a script which would be evaluated in one of the following scenarios:
  /// * Whenever the page is navigated.
  /// * Whenever the child frame is attached or navigated. In this case, the script is evaluated in the context of the newly attached frame.
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
  /// // In your playwright script, assuming the preload.js file is in same directory
  /// await page.addInitScript( path: './preload.js' );
  /// ```
  ///
  /// ```dart
  /// await page.addInitScript((mock) {
  ///   window.mock = mock;
  /// }, mock);
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
  ///   Script to be evaluated in the page.
  /// - `arg` [Serializable] *(optional)*
  ///
  ///   Optional argument to pass to [script] (only supported when passing a function).
  /// - `options` Map *(optional)*
  ///   - `exposeFunctions` bool *(optional)*
  ///
  ///     When set to `true`, functions passed inside [arg] are exposed in the page and can be called from the init script. Calling one returns a Future of its result. Under the hood, each function is exposed via [page.exposeFunction()], so it is technically accessible from all frames and worlds of the page. Unlike functions passed to [page.evaluate()], functions passed to an init script are exposed in every new document, so they survive navigations. Defaults to `false`, in which case functions are not serializable and are silently dropped.
  ///
  /// **Returns**
  /// - Future&lt;[Disposable]&gt;
  Future<void> addInitScript(String source);

  /// If [runBeforeUnload] is `false`, does not run any unload handlers and waits for the page to be closed. If [runBeforeUnload] is `true` the method will run unload handlers, but will **not** wait for the page to close.
  ///
  /// By default, `page.close()` **does not** run `beforeunload` handlers.
  ///
  /// **NOTE**
  /// if [runBeforeUnload] is passed as true, a `beforeunload` dialog might be summoned and should be handled manually via [page.on('dialog')] event.
  /// **Usage**
  ///
  /// ```dart
  /// await page.close();
  /// await page.close(options);
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `reason` String *(optional)*
  ///
  ///     The reason to be reported to the operations interrupted by the page closure.
  ///   - `runBeforeUnload` bool *(optional)*
  ///
  ///     Defaults to `false`. Whether to run the [before unload] page handlers.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> close({bool? runBeforeUnload, String? reason});

  /// This method changes the `CSS media type` through the `media` argument, and/or the `'prefers-colors-scheme'` media feature, using the `colorScheme` argument.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await page.evaluate(() => matchMedia('screen').matches);
  /// // → true
  /// await page.evaluate(() => matchMedia('print').matches);
  /// // → false
  ///
  /// await page.emulateMedia( media: 'print' );
  /// await page.evaluate(() => matchMedia('screen').matches);
  /// // → false
  /// await page.evaluate(() => matchMedia('print').matches);
  /// // → true
  ///
  /// await page.emulateMedia();
  /// await page.evaluate(() => matchMedia('screen').matches);
  /// // → true
  /// await page.evaluate(() => matchMedia('print').matches);
  /// // → false
  /// ```
  ///
  /// ```dart
  /// await page.emulateMedia( colorScheme: 'dark' );
  /// await page.evaluate(() => matchMedia('(prefers-color-scheme: dark)').matches);
  /// // → true
  /// await page.evaluate(() => matchMedia('(prefers-color-scheme: light)').matches);
  /// // → false
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `colorScheme` Scheme *(optional)*
  ///
  ///     Emulates [prefers-colors-scheme] media feature, supported values are `'light'` and `'dark'`. Passing `null` disables color scheme emulation. `'no-preference'` is deprecated.
  ///   - `contrast` Contrast *(optional)*
  ///
  ///     Emulates `'prefers-contrast'` media feature, supported values are `'no-preference'`, `'more'`. Passing `null` disables contrast emulation.
  ///   - `forcedColors` Colors *(optional)*
  ///
  ///     Emulates `'forced-colors'` media feature, supported values are `'active'` and `'none'`. Passing `null` disables forced colors emulation.
  ///   - `media` Media *(optional)*
  ///
  ///     Changes the CSS media type of the page. The only allowed values are `'screen'`, `'print'` and `null`. Passing `null` disables CSS media emulation.
  ///   - `reducedMotion` Motion *(optional)*
  ///
  ///     Emulates `'prefers-reduced-motion'` media feature, supported values are `'reduce'`, `'no-preference'`. Passing `null` disables reduced motion emulation.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> emulateMedia({
    Media? media,

    Scheme? colorScheme,

    Motion? reducedMotion,

    Colors? forcedColors,

    Contrast? contrast,
  });

  /// **WARNING**
  /// [Discouraged]
  ///
  /// Use locator-based [locator.click()] instead. Read more about [locators].
  ///
  /// This method clicks an element matching [selector] by performing the following steps:
  /// 1. Find an element matching [selector]. If there is none, wait until a matching element is attached to the DOM.
  /// 1. Wait for [actionability] checks on the matched element, unless [force] option is set. If the element is detached during the checks, the whole action is retried.
  /// 1. Scroll the element into view if needed.
  /// 1. Use [page.mouse] to click in the center of the element, or the specified [position].
  /// 1. Wait for initiated navigations to either succeed or fail, unless [noWaitAfter] option is set.
  ///
  /// When all steps combined have not finished during the specified [timeout], this method throws a [TimeoutError]. Passing zero timeout disables this.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await page.click(selector);
  /// await page.click(selector, options);
  /// ```
  ///
  /// **Arguments**
  /// - `selector` String
  ///
  ///   A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
  /// - `options` Map *(optional)*
  ///   - `button` "left" | "right" | "middle" *(optional)*
  ///
  ///     Defaults to `left`.
  ///   - `clickCount` num *(optional)*
  ///
  ///     defaults to 1. See [UIEvent.detail].
  ///   - `delay` num *(optional)*
  ///
  ///     Time to wait between `mousedown` and `mouseup` in milliseconds. Defaults to 0.
  ///   - `force` bool *(optional)*
  ///
  ///     Whether to bypass the [actionability] checks. Defaults to `false`.
  ///   - `modifiers` List&lt;"Alt" | "Control" | "ControlOrMeta" | "Meta" | "Shift"&gt; *(optional)*
  ///
  ///     Modifier keys to press. Ensures that only these modifiers are pressed during the operation, and then restores current modifiers back. If not specified, currently pressed modifiers are used. "ControlOrMeta" resolves to "Control" on Windows and Linux and to "Meta" on macOS.
  ///   - `noWaitAfter` bool *(optional)*
  ///
  ///     **WARNING**
  /// [Deprecated]
  ///     This option will default to `true` in the future.
  ///     Actions that initiate navigations are waiting for these navigations to happen and for pages to start loading. You can opt out of waiting via setting this flag. You would only need this option in the exceptional cases such as navigating to inaccessible pages. Defaults to `false`.
  ///   - `position` Map *(optional)*
  ///     - `x` num
  ///
  ///
  ///     - `y` num
  ///
  ///
  ///     A point to use relative to the top-left corner of element padding box. If not specified, uses some visible point of the element.
  ///   - `scroll` "auto" | "none" *(optional)*
  ///
  ///     Controls whether Playwright scrolls the element into view before performing the action. Defaults to `"auto"`, which scrolls the element into view when necessary, including scrolling nested scrollable containers. When set to `"none"`, Playwright does not scroll the element and the action fails if the element is not already in the viewport. This is useful to assert that an element is reachable by the user without additional scrolling.
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     Allows to cancel the operation using an [`AbortSignal`]. If the signal is aborted, the operation will be aborted and throw an error. Note that providing a signal does not disable the default timeout, which can be changed using [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()]; pass `timeout: 0` to disable the timeout entirely.
  ///   - `strict` bool *(optional)*
  ///
  ///     When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///   - `trial` bool *(optional)*
  ///
  ///     When set, this method only performs the [actionability] checks and skips the action. Defaults to `false`. Useful to wait until the element is ready for the action without performing it. Note that keyboard `modifiers` will be pressed regardless of `trial` to allow testing elements which are only visible when those keys are pressed.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> click(String selector, {bool? force, double? timeout});

  /// **WARNING**
  /// [Discouraged]
  ///
  /// Use locator-based [locator.fill()] instead. Read more about [locators].
  ///
  /// This method waits for an element matching [selector], waits for [actionability] checks, focuses the element, fills it and triggers an `input` event after filling. Note that you can pass an empty string to clear the input field.
  ///
  /// If the target element is not an `<input>`, `<textarea>` or `[contenteditable]` element, this method throws an error. However, if the element is inside the `<label>` element that has an associated [control], the control will be filled instead.
  ///
  /// To send fine-grained keyboard events, use [locator.pressSequentially()].
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await page.fill(selector, value);
  /// await page.fill(selector, value, options);
  /// ```
  ///
  /// **Arguments**
  /// - `selector` String
  ///
  ///   A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
  /// - `value` String
  ///
  ///   Value to fill for the `<input>`, `<textarea>` or `[contenteditable]` element.
  /// - `options` Map *(optional)*
  ///   - `force` bool *(optional)*
  ///
  ///     Whether to bypass the [actionability] checks. Defaults to `false`.
  ///   - `noWaitAfter` bool *(optional)*
  ///
  ///     **WARNING**
  /// [Deprecated]
  ///     This option has no effect.
  ///     This option has no effect.
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     Allows to cancel the operation using an [`AbortSignal`]. If the signal is aborted, the operation will be aborted and throw an error. Note that providing a signal does not disable the default timeout, which can be changed using [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()]; pass `timeout: 0` to disable the timeout entirely.
  ///   - `strict` bool *(optional)*
  ///
  ///     When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> fill(
    String selector,

    String value, {

    bool? force,

    double? timeout,
  });

  /// **WARNING**
  /// [Discouraged]
  ///
  /// Use locator-based [locator.check()] instead. Read more about [locators].
  ///
  /// This method checks an element matching [selector] by performing the following steps:
  /// 1. Find an element matching [selector]. If there is none, wait until a matching element is attached to the DOM.
  /// 1. Ensure that matched element is a checkbox or a radio input. If not, this method throws. If the element is already checked, this method returns immediately.
  /// 1. Wait for [actionability] checks on the matched element, unless [force] option is set. If the element is detached during the checks, the whole action is retried.
  /// 1. Scroll the element into view if needed.
  /// 1. Use [page.mouse] to click in the center of the element.
  /// 1. Ensure that the element is now checked. If not, this method throws.
  ///
  /// When all steps combined have not finished during the specified [timeout], this method throws a [TimeoutError]. Passing zero timeout disables this.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await page.check(selector);
  /// await page.check(selector, options);
  /// ```
  ///
  /// **Arguments**
  /// - `selector` String
  ///
  ///   A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
  /// - `options` Map *(optional)*
  ///   - `force` bool *(optional)*
  ///
  ///     Whether to bypass the [actionability] checks. Defaults to `false`.
  ///   - `noWaitAfter` bool *(optional)*
  ///
  ///     **WARNING**
  /// [Deprecated]
  ///     This option has no effect.
  ///     This option has no effect.
  ///   - `position` Map *(optional)*
  ///     - `x` num
  ///
  ///
  ///     - `y` num
  ///
  ///
  ///     A point to use relative to the top-left corner of element padding box. If not specified, uses some visible point of the element.
  ///   - `scroll` "auto" | "none" *(optional)*
  ///
  ///     Controls whether Playwright scrolls the element into view before performing the action. Defaults to `"auto"`, which scrolls the element into view when necessary, including scrolling nested scrollable containers. When set to `"none"`, Playwright does not scroll the element and the action fails if the element is not already in the viewport. This is useful to assert that an element is reachable by the user without additional scrolling.
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     Allows to cancel the operation using an [`AbortSignal`]. If the signal is aborted, the operation will be aborted and throw an error. Note that providing a signal does not disable the default timeout, which can be changed using [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()]; pass `timeout: 0` to disable the timeout entirely.
  ///   - `strict` bool *(optional)*
  ///
  ///     When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///   - `trial` bool *(optional)*
  ///
  ///     When set, this method only performs the [actionability] checks and skips the action. Defaults to `false`. Useful to wait until the element is ready for the action without performing it.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> check(String selector, {bool? force, double? timeout});

  /// **WARNING**
  /// [Discouraged]
  ///
  /// Use locator-based [locator.uncheck()] instead. Read more about [locators].
  ///
  /// This method unchecks an element matching [selector] by performing the following steps:
  /// 1. Find an element matching [selector]. If there is none, wait until a matching element is attached to the DOM.
  /// 1. Ensure that matched element is a checkbox or a radio input. If not, this method throws. If the element is already unchecked, this method returns immediately.
  /// 1. Wait for [actionability] checks on the matched element, unless [force] option is set. If the element is detached during the checks, the whole action is retried.
  /// 1. Scroll the element into view if needed.
  /// 1. Use [page.mouse] to click in the center of the element.
  /// 1. Ensure that the element is now unchecked. If not, this method throws.
  ///
  /// When all steps combined have not finished during the specified [timeout], this method throws a [TimeoutError]. Passing zero timeout disables this.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await page.uncheck(selector);
  /// await page.uncheck(selector, options);
  /// ```
  ///
  /// **Arguments**
  /// - `selector` String
  ///
  ///   A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
  /// - `options` Map *(optional)*
  ///   - `force` bool *(optional)*
  ///
  ///     Whether to bypass the [actionability] checks. Defaults to `false`.
  ///   - `noWaitAfter` bool *(optional)*
  ///
  ///     **WARNING**
  /// [Deprecated]
  ///     This option has no effect.
  ///     This option has no effect.
  ///   - `position` Map *(optional)*
  ///     - `x` num
  ///
  ///
  ///     - `y` num
  ///
  ///
  ///     A point to use relative to the top-left corner of element padding box. If not specified, uses some visible point of the element.
  ///   - `scroll` "auto" | "none" *(optional)*
  ///
  ///     Controls whether Playwright scrolls the element into view before performing the action. Defaults to `"auto"`, which scrolls the element into view when necessary, including scrolling nested scrollable containers. When set to `"none"`, Playwright does not scroll the element and the action fails if the element is not already in the viewport. This is useful to assert that an element is reachable by the user without additional scrolling.
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     Allows to cancel the operation using an [`AbortSignal`]. If the signal is aborted, the operation will be aborted and throw an error. Note that providing a signal does not disable the default timeout, which can be changed using [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()]; pass `timeout: 0` to disable the timeout entirely.
  ///   - `strict` bool *(optional)*
  ///
  ///     When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///   - `trial` bool *(optional)*
  ///
  ///     When set, this method only performs the [actionability] checks and skips the action. Defaults to `false`. Useful to wait until the element is ready for the action without performing it.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> uncheck(String selector, {bool? force, double? timeout});

  /// **WARNING**
  /// [Discouraged]
  ///
  /// Use locator-based [locator.setChecked()] instead. Read more about [locators].
  ///
  /// This method checks or unchecks an element matching [selector] by performing the following steps:
  /// 1. Find an element matching [selector]. If there is none, wait until a matching element is attached to the DOM.
  /// 1. Ensure that matched element is a checkbox or a radio input. If not, this method throws.
  /// 1. If the element already has the right checked state, this method returns immediately.
  /// 1. Wait for [actionability] checks on the matched element, unless [force] option is set. If the element is detached during the checks, the whole action is retried.
  /// 1. Scroll the element into view if needed.
  /// 1. Use [page.mouse] to click in the center of the element.
  /// 1. Ensure that the element is now checked or unchecked. If not, this method throws.
  ///
  /// When all steps combined have not finished during the specified [timeout], this method throws a [TimeoutError]. Passing zero timeout disables this.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await page.setChecked(selector, checked);
  /// await page.setChecked(selector, checked, options);
  /// ```
  ///
  /// **Arguments**
  /// - `selector` String
  ///
  ///   A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
  /// - `checked` bool
  ///
  ///   Whether to check or uncheck the checkbox.
  /// - `options` Map *(optional)*
  ///   - `force` bool *(optional)*
  ///
  ///     Whether to bypass the [actionability] checks. Defaults to `false`.
  ///   - `noWaitAfter` bool *(optional)*
  ///
  ///     **WARNING**
  /// [Deprecated]
  ///     This option has no effect.
  ///     This option has no effect.
  ///   - `position` Map *(optional)*
  ///     - `x` num
  ///
  ///
  ///     - `y` num
  ///
  ///
  ///     A point to use relative to the top-left corner of element padding box. If not specified, uses some visible point of the element.
  ///   - `scroll` "auto" | "none" *(optional)*
  ///
  ///     Controls whether Playwright scrolls the element into view before performing the action. Defaults to `"auto"`, which scrolls the element into view when necessary, including scrolling nested scrollable containers. When set to `"none"`, Playwright does not scroll the element and the action fails if the element is not already in the viewport. This is useful to assert that an element is reachable by the user without additional scrolling.
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     Allows to cancel the operation using an [`AbortSignal`]. If the signal is aborted, the operation will be aborted and throw an error. Note that providing a signal does not disable the default timeout, which can be changed using [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()]; pass `timeout: 0` to disable the timeout entirely.
  ///   - `strict` bool *(optional)*
  ///
  ///     When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///   - `trial` bool *(optional)*
  ///
  ///     When set, this method only performs the [actionability] checks and skips the action. Defaults to `false`. Useful to wait until the element is ready for the action without performing it.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> setChecked(
    String selector,

    bool checked, {

    bool? force,

    double? timeout,
  });

  /// **WARNING**
  /// [Discouraged]
  ///
  /// Use locator-based [locator.hover()] instead. Read more about [locators].
  ///
  /// This method hovers over an element matching [selector] by performing the following steps:
  /// 1. Find an element matching [selector]. If there is none, wait until a matching element is attached to the DOM.
  /// 1. Wait for [actionability] checks on the matched element, unless [force] option is set. If the element is detached during the checks, the whole action is retried.
  /// 1. Scroll the element into view if needed.
  /// 1. Use [page.mouse] to hover over the center of the element, or the specified [position].
  ///
  /// When all steps combined have not finished during the specified [timeout], this method throws a [TimeoutError]. Passing zero timeout disables this.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await page.hover(selector);
  /// await page.hover(selector, options);
  /// ```
  ///
  /// **Arguments**
  /// - `selector` String
  ///
  ///   A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
  /// - `options` Map *(optional)*
  ///   - `force` bool *(optional)*
  ///
  ///     Whether to bypass the [actionability] checks. Defaults to `false`.
  ///   - `modifiers` List&lt;"Alt" | "Control" | "ControlOrMeta" | "Meta" | "Shift"&gt; *(optional)*
  ///
  ///     Modifier keys to press. Ensures that only these modifiers are pressed during the operation, and then restores current modifiers back. If not specified, currently pressed modifiers are used. "ControlOrMeta" resolves to "Control" on Windows and Linux and to "Meta" on macOS.
  ///   - `noWaitAfter` bool *(optional)*
  ///
  ///     **WARNING**
  /// [Deprecated]
  ///     This option has no effect.
  ///     This option has no effect.
  ///   - `position` Map *(optional)*
  ///     - `x` num
  ///
  ///
  ///     - `y` num
  ///
  ///
  ///     A point to use relative to the top-left corner of element padding box. If not specified, uses some visible point of the element.
  ///   - `scroll` "auto" | "none" *(optional)*
  ///
  ///     Controls whether Playwright scrolls the element into view before performing the action. Defaults to `"auto"`, which scrolls the element into view when necessary, including scrolling nested scrollable containers. When set to `"none"`, Playwright does not scroll the element and the action fails if the element is not already in the viewport. This is useful to assert that an element is reachable by the user without additional scrolling.
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     Allows to cancel the operation using an [`AbortSignal`]. If the signal is aborted, the operation will be aborted and throw an error. Note that providing a signal does not disable the default timeout, which can be changed using [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()]; pass `timeout: 0` to disable the timeout entirely.
  ///   - `strict` bool *(optional)*
  ///
  ///     When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///   - `trial` bool *(optional)*
  ///
  ///     When set, this method only performs the [actionability] checks and skips the action. Defaults to `false`. Useful to wait until the element is ready for the action without performing it. Note that keyboard `modifiers` will be pressed regardless of `trial` to allow testing elements which are only visible when those keys are pressed.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> hover(String selector, {bool? force, double? timeout});

  /// **WARNING**
  /// [Discouraged]
  ///
  /// Use locator-based [locator.focus()] instead. Read more about [locators].
  ///
  /// This method fetches an element with [selector] and focuses it. If there's no element matching [selector], the method waits until a matching element appears in the DOM.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await page.focus(selector);
  /// await page.focus(selector, options);
  /// ```
  ///
  /// **Arguments**
  /// - `selector` String
  ///
  ///   A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
  /// - `options` Map *(optional)*
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     Allows to cancel the operation using an [`AbortSignal`]. If the signal is aborted, the operation will be aborted and throw an error. Note that providing a signal does not disable the default timeout, which can be changed using [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()]; pass `timeout: 0` to disable the timeout entirely.
  ///   - `strict` bool *(optional)*
  ///
  ///     When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> focus(String selector, {double? timeout});

  /// Removes focus from an element matching the selector.
  Future<void> blur(String selector, {double? timeout});

  /// **WARNING**
  /// [Discouraged]
  ///
  /// Use locator-based [locator.dblclick()] instead. Read more about [locators].
  ///
  /// This method double clicks an element matching [selector] by performing the following steps:
  /// 1. Find an element matching [selector]. If there is none, wait until a matching element is attached to the DOM.
  /// 1. Wait for [actionability] checks on the matched element, unless [force] option is set. If the element is detached during the checks, the whole action is retried.
  /// 1. Scroll the element into view if needed.
  /// 1. Use [page.mouse] to double click in the center of the element, or the specified [position].
  ///
  /// When all steps combined have not finished during the specified [timeout], this method throws a [TimeoutError]. Passing zero timeout disables this.
  ///
  /// **NOTE**
  /// `page.dblclick()` dispatches two `click` events and a single `dblclick` event.
  /// **Usage**
  ///
  /// ```dart
  /// await page.dblclick(selector);
  /// await page.dblclick(selector, options);
  /// ```
  ///
  /// **Arguments**
  /// - `selector` String
  ///
  ///   A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
  /// - `options` Map *(optional)*
  ///   - `button` "left" | "right" | "middle" *(optional)*
  ///
  ///     Defaults to `left`.
  ///   - `delay` num *(optional)*
  ///
  ///     Time to wait between `mousedown` and `mouseup` in milliseconds. Defaults to 0.
  ///   - `force` bool *(optional)*
  ///
  ///     Whether to bypass the [actionability] checks. Defaults to `false`.
  ///   - `modifiers` List&lt;"Alt" | "Control" | "ControlOrMeta" | "Meta" | "Shift"&gt; *(optional)*
  ///
  ///     Modifier keys to press. Ensures that only these modifiers are pressed during the operation, and then restores current modifiers back. If not specified, currently pressed modifiers are used. "ControlOrMeta" resolves to "Control" on Windows and Linux and to "Meta" on macOS.
  ///   - `noWaitAfter` bool *(optional)*
  ///
  ///     **WARNING**
  /// [Deprecated]
  ///     This option has no effect.
  ///     This option has no effect.
  ///   - `position` Map *(optional)*
  ///     - `x` num
  ///
  ///
  ///     - `y` num
  ///
  ///
  ///     A point to use relative to the top-left corner of element padding box. If not specified, uses some visible point of the element.
  ///   - `scroll` "auto" | "none" *(optional)*
  ///
  ///     Controls whether Playwright scrolls the element into view before performing the action. Defaults to `"auto"`, which scrolls the element into view when necessary, including scrolling nested scrollable containers. When set to `"none"`, Playwright does not scroll the element and the action fails if the element is not already in the viewport. This is useful to assert that an element is reachable by the user without additional scrolling.
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     Allows to cancel the operation using an [`AbortSignal`]. If the signal is aborted, the operation will be aborted and throw an error. Note that providing a signal does not disable the default timeout, which can be changed using [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()]; pass `timeout: 0` to disable the timeout entirely.
  ///   - `strict` bool *(optional)*
  ///
  ///     When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///   - `trial` bool *(optional)*
  ///
  ///     When set, this method only performs the [actionability] checks and skips the action. Defaults to `false`. Useful to wait until the element is ready for the action without performing it. Note that keyboard `modifiers` will be pressed regardless of `trial` to allow testing elements which are only visible when those keys are pressed.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> dblclick(String selector, {bool? force, double? timeout});

  /// **WARNING**
  /// [Deprecated]
  ///
  /// In most cases, you should use [locator.fill()] instead. You only need to press keys one by one if there is special keyboard handling on the page - in this case use [locator.pressSequentially()].
  ///
  /// Sends a `keydown`, `keypress`/`input`, and `keyup` event for each character in the text. `page.type` can be used to send fine-grained keyboard events. To fill values in form fields, use [page.fill()].
  ///
  /// To press a special key, like `Control` or `ArrowDown`, use [keyboard.press()].
  ///
  /// **Usage**
  ///
  /// **Arguments**
  /// - `selector` String
  ///
  ///   A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
  /// - `text` String
  ///
  ///   A text to type into a focused element.
  /// - `options` Map *(optional)*
  ///   - `delay` double *(optional)*
  ///
  ///     Time to wait between key presses in milliseconds. Defaults to 0.
  ///   - `noWaitAfter` bool *(optional)*
  ///
  ///     **WARNING**
  /// [Deprecated]
  ///     This option has no effect.
  ///     This option has no effect.
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     Allows to cancel the operation using an [`AbortSignal`]. If the signal is aborted, the operation will be aborted and throw an error. Note that providing a signal does not disable the default timeout, which can be changed using [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()]; pass `timeout: 0` to disable the timeout entirely.
  ///   - `strict` bool *(optional)*
  ///
  ///     When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> type(
    String selector,

    String text, {

    double? delay,

    double? timeout,
  });

  /// **WARNING**
  /// [Discouraged]
  ///
  /// Use locator-based [locator.press()] instead. Read more about [locators].
  ///
  /// Focuses the element, and then uses [keyboard.down()] and [keyboard.up()].
  ///
  /// [key] can specify the intended [keyboardEvent.key] value or a single character to generate the text for. A superset of the [key] values can be found [here]. Examples of the keys are:
  ///
  /// `F1` - `F12`, `Digit0`- `Digit9`, `KeyA`- `KeyZ`, `Backquote`, `Minus`, `Equal`, `Backslash`, `Backspace`, `Tab`, `Delete`, `Escape`, `ArrowDown`, `End`, `Enter`, `Home`, `Insert`, `PageDown`, `PageUp`, `ArrowRight`, `ArrowUp`, etc.
  ///
  /// Following modification shortcuts are also supported: `Shift`, `Control`, `Alt`, `Meta`, `ShiftLeft`, `ControlOrMeta`. `ControlOrMeta` resolves to `Control` on Windows and Linux and to `Meta` on macOS.
  ///
  /// Holding down `Shift` will type the text that corresponds to the [key] in the upper case.
  ///
  /// If [key] is a single character, it is case-sensitive, so the values `a` and `A` will generate different respective texts.
  ///
  /// Shortcuts such as `key: "Control+o"`, `key: "Control++` or `key: "Control+Shift+T"` are supported as well. When specified with the modifier, modifier is pressed and being held while the subsequent key is being pressed.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// final page = await browser.newPage();
  /// await page.goto('https://keycode.info');
  /// await page.press('body', 'A');
  /// await page.screenshot( path: 'A.png' );
  /// await page.press('body', 'ArrowLeft');
  /// await page.screenshot( path: 'ArrowLeft.png' );
  /// await page.press('body', 'Shift+O');
  /// await page.screenshot( path: 'O.png' );
  /// await browser.close();
  /// ```
  ///
  /// **Arguments**
  /// - `selector` String
  ///
  ///   A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
  /// - `key` String
  ///
  ///   Name of the key to press or a character to generate, such as `ArrowLeft` or `a`.
  /// - `options` Map *(optional)*
  ///   - `delay` double *(optional)*
  ///
  ///     Time to wait between `keydown` and `keyup` in milliseconds. Defaults to 0.
  ///   - `noWaitAfter` bool *(optional)*
  ///
  ///     **WARNING**
  /// [Deprecated]
  ///     This option will default to `true` in the future.
  ///     Actions that initiate navigations are waiting for these navigations to happen and for pages to start loading. You can opt out of waiting via setting this flag. You would only need this option in the exceptional cases such as navigating to inaccessible pages. Defaults to `false`.
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     Allows to cancel the operation using an [`AbortSignal`]. If the signal is aborted, the operation will be aborted and throw an error. Note that providing a signal does not disable the default timeout, which can be changed using [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()]; pass `timeout: 0` to disable the timeout entirely.
  ///   - `strict` bool *(optional)*
  ///
  ///     When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> press(
    String selector,

    String key, {

    double? delay,

    double? timeout,
  });

  /// **WARNING**
  /// [Discouraged]
  ///
  /// Use locator-based [locator.tap()] instead. Read more about [locators].
  ///
  /// This method taps an element matching [selector] by performing the following steps:
  /// 1. Find an element matching [selector]. If there is none, wait until a matching element is attached to the DOM.
  /// 1. Wait for [actionability] checks on the matched element, unless [force] option is set. If the element is detached during the checks, the whole action is retried.
  /// 1. Scroll the element into view if needed.
  /// 1. Use [page.touchscreen] to tap the center of the element, or the specified [position].
  ///
  /// When all steps combined have not finished during the specified [timeout], this method throws a [TimeoutError]. Passing zero timeout disables this.
  ///
  /// **NOTE**
  /// [page.tap()] will throw if the [hasTouch] option of the browser context is false.
  /// **Usage**
  ///
  /// ```dart
  /// await page.tap(selector);
  /// await page.tap(selector, options);
  /// ```
  ///
  /// **Arguments**
  /// - `selector` String
  ///
  ///   A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
  /// - `options` Map *(optional)*
  ///   - `force` bool *(optional)*
  ///
  ///     Whether to bypass the [actionability] checks. Defaults to `false`.
  ///   - `modifiers` List&lt;"Alt" | "Control" | "ControlOrMeta" | "Meta" | "Shift"&gt; *(optional)*
  ///
  ///     Modifier keys to press. Ensures that only these modifiers are pressed during the operation, and then restores current modifiers back. If not specified, currently pressed modifiers are used. "ControlOrMeta" resolves to "Control" on Windows and Linux and to "Meta" on macOS.
  ///   - `noWaitAfter` bool *(optional)*
  ///
  ///     **WARNING**
  /// [Deprecated]
  ///     This option has no effect.
  ///     This option has no effect.
  ///   - `position` Map *(optional)*
  ///     - `x` num
  ///
  ///
  ///     - `y` num
  ///
  ///
  ///     A point to use relative to the top-left corner of element padding box. If not specified, uses some visible point of the element.
  ///   - `scroll` "auto" | "none" *(optional)*
  ///
  ///     Controls whether Playwright scrolls the element into view before performing the action. Defaults to `"auto"`, which scrolls the element into view when necessary, including scrolling nested scrollable containers. When set to `"none"`, Playwright does not scroll the element and the action fails if the element is not already in the viewport. This is useful to assert that an element is reachable by the user without additional scrolling.
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     Allows to cancel the operation using an [`AbortSignal`]. If the signal is aborted, the operation will be aborted and throw an error. Note that providing a signal does not disable the default timeout, which can be changed using [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()]; pass `timeout: 0` to disable the timeout entirely.
  ///   - `strict` bool *(optional)*
  ///
  ///     When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///   - `trial` bool *(optional)*
  ///
  ///     When set, this method only performs the [actionability] checks and skips the action. Defaults to `false`. Useful to wait until the element is ready for the action without performing it. Note that keyboard `modifiers` will be pressed regardless of `trial` to allow testing elements which are only visible when those keys are pressed.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> tap(String selector, {bool? force, double? timeout});

  /// Gets the full HTML contents of the page, including the doctype.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await page.content();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;String&gt;
  Future<String> content();

  /// This method internally calls [document.write()], inheriting all its specific characteristics and behaviors.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await page.setContent(html);
  /// await page.setContent(html, options);
  /// ```
  ///
  /// **Arguments**
  /// - `html` String
  ///
  ///   HTML markup to assign to the page.
  /// - `options` Map *(optional)*
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     Allows to cancel the operation using an [`AbortSignal`]. If the signal is aborted, the operation will be aborted and throw an error. Note that providing a signal does not disable the default timeout, which can be changed using [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()]; pass `timeout: 0` to disable the timeout entirely.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum operation time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `navigationTimeout` option in the config, or by using the [browserContext.setDefaultNavigationTimeout()], [browserContext.setDefaultTimeout()], [page.setDefaultNavigationTimeout()] or [page.setDefaultTimeout()] methods.
  ///   - `waitUntil` "load" | "domcontentloaded" | "networkidle" | "commit" *(optional)*
  ///
  ///     When to consider operation succeeded, defaults to `load`. Events can be either:
  ///     * `'domcontentloaded'` - consider operation to be finished when the `DOMContentLoaded` event is fired.
  ///     * `'load'` - consider operation to be finished when the `load` event is fired.
  ///     * `'networkidle'` - **DISCOURAGED** consider operation to be finished when there are no network connections for at least `500` ms. Don't use this method for testing, rely on web assertions to assess readiness instead.
  ///     * `'commit'` - consider operation to be finished when network response is received and the document started loading.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> setContent(String html, {double? timeout});

  /// Evaluates JavaScript on the element matching the selector.
  Future<T> evalOnSelector<T>(
    String selector,

    String expression, [

    Object? arg,
  ]);

  /// Evaluates JavaScript on all elements matching the selector.
  Future<T> evalOnSelectorAll<T>(
    String selector,

    String expression, [

    Object? arg,
  ]);

  /// **WARNING**
  /// [Discouraged]
  ///
  /// Use locator-based [locator.getAttribute()] instead. Read more about [locators].
  ///
  /// Returns element attribute value.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await page.getAttribute(selector, name);
  /// await page.getAttribute(selector, name, options);
  /// ```
  ///
  /// **Arguments**
  /// - `selector` String
  ///
  ///   A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
  /// - `name` String
  ///
  ///   Attribute name to get the value for.
  /// - `options` Map *(optional)*
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     Allows to cancel the operation using an [`AbortSignal`]. If the signal is aborted, the operation will be aborted and throw an error. Note that providing a signal does not disable the default timeout, which can be changed using [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()]; pass `timeout: 0` to disable the timeout entirely.
  ///   - `strict` bool *(optional)*
  ///
  ///     When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;[String&gt;]?
  Future<String?> getAttribute(String selector, String name, {double? timeout});

  /// **WARNING**
  /// [Discouraged]
  ///
  /// Use locator-based [locator.innerHTML()] instead. Read more about [locators].
  ///
  /// Returns `element.innerHTML`.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await page.innerHTML(selector);
  /// await page.innerHTML(selector, options);
  /// ```
  ///
  /// **Arguments**
  /// - `selector` String
  ///
  ///   A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
  /// - `options` Map *(optional)*
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     Allows to cancel the operation using an [`AbortSignal`]. If the signal is aborted, the operation will be aborted and throw an error. Note that providing a signal does not disable the default timeout, which can be changed using [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()]; pass `timeout: 0` to disable the timeout entirely.
  ///   - `strict` bool *(optional)*
  ///
  ///     When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;String&gt;
  Future<String> innerHTML(String selector, {double? timeout});

  /// **WARNING**
  /// [Discouraged]
  ///
  /// Use locator-based [locator.innerText()] instead. Read more about [locators].
  ///
  /// Returns `element.innerText`.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await page.innerText(selector);
  /// await page.innerText(selector, options);
  /// ```
  ///
  /// **Arguments**
  /// - `selector` String
  ///
  ///   A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
  /// - `options` Map *(optional)*
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     Allows to cancel the operation using an [`AbortSignal`]. If the signal is aborted, the operation will be aborted and throw an error. Note that providing a signal does not disable the default timeout, which can be changed using [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()]; pass `timeout: 0` to disable the timeout entirely.
  ///   - `strict` bool *(optional)*
  ///
  ///     When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;String&gt;
  Future<String> innerText(String selector, {double? timeout});

  /// **WARNING**
  /// [Discouraged]
  ///
  /// Use locator-based [locator.inputValue()] instead. Read more about [locators].
  ///
  /// Returns `input.value` for the selected `<input>` or `<textarea>` or `<select>` element.
  ///
  /// Throws for non-input elements. However, if the element is inside the `<label>` element that has an associated [control], returns the value of the control.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await page.inputValue(selector);
  /// await page.inputValue(selector, options);
  /// ```
  ///
  /// **Arguments**
  /// - `selector` String
  ///
  ///   A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
  /// - `options` Map *(optional)*
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     Allows to cancel the operation using an [`AbortSignal`]. If the signal is aborted, the operation will be aborted and throw an error. Note that providing a signal does not disable the default timeout, which can be changed using [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()]; pass `timeout: 0` to disable the timeout entirely.
  ///   - `strict` bool *(optional)*
  ///
  ///     When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;String&gt;
  Future<String> inputValue(String selector, {double? timeout});

  /// **WARNING**
  /// [Discouraged]
  ///
  /// Use locator-based [locator.isChecked()] instead. Read more about [locators].
  ///
  /// Returns whether the element is checked. Throws if the element is not a checkbox or radio input.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await page.isChecked(selector);
  /// await page.isChecked(selector, options);
  /// ```
  ///
  /// **Arguments**
  /// - `selector` String
  ///
  ///   A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
  /// - `options` Map *(optional)*
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     Allows to cancel the operation using an [`AbortSignal`]. If the signal is aborted, the operation will be aborted and throw an error. Note that providing a signal does not disable the default timeout, which can be changed using [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()]; pass `timeout: 0` to disable the timeout entirely.
  ///   - `strict` bool *(optional)*
  ///
  ///     When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;bool&gt;
  Future<bool> isChecked(String selector, {double? timeout});

  /// **WARNING**
  /// [Discouraged]
  ///
  /// Use locator-based [locator.isDisabled()] instead. Read more about [locators].
  ///
  /// Returns whether the element is disabled, the opposite of [enabled].
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await page.isDisabled(selector);
  /// await page.isDisabled(selector, options);
  /// ```
  ///
  /// **Arguments**
  /// - `selector` String
  ///
  ///   A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
  /// - `options` Map *(optional)*
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     Allows to cancel the operation using an [`AbortSignal`]. If the signal is aborted, the operation will be aborted and throw an error. Note that providing a signal does not disable the default timeout, which can be changed using [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()]; pass `timeout: 0` to disable the timeout entirely.
  ///   - `strict` bool *(optional)*
  ///
  ///     When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;bool&gt;
  Future<bool> isDisabled(String selector, {double? timeout});

  /// **WARNING**
  /// [Discouraged]
  ///
  /// Use locator-based [locator.isEnabled()] instead. Read more about [locators].
  ///
  /// Returns whether the element is [enabled].
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await page.isEnabled(selector);
  /// await page.isEnabled(selector, options);
  /// ```
  ///
  /// **Arguments**
  /// - `selector` String
  ///
  ///   A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
  /// - `options` Map *(optional)*
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     Allows to cancel the operation using an [`AbortSignal`]. If the signal is aborted, the operation will be aborted and throw an error. Note that providing a signal does not disable the default timeout, which can be changed using [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()]; pass `timeout: 0` to disable the timeout entirely.
  ///   - `strict` bool *(optional)*
  ///
  ///     When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;bool&gt;
  Future<bool> isEnabled(String selector, {double? timeout});

  /// **WARNING**
  /// [Discouraged]
  ///
  /// Use locator-based [locator.isHidden()] instead. Read more about [locators].
  ///
  /// Returns whether the element is hidden, the opposite of [visible].  [selector] that does not match any elements is considered hidden.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await page.isHidden(selector);
  /// await page.isHidden(selector, options);
  /// ```
  ///
  /// **Arguments**
  /// - `selector` String
  ///
  ///   A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
  /// - `options` Map *(optional)*
  ///   - `strict` bool *(optional)*
  ///
  ///     When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
  ///   - `timeout` num *(optional)*
  ///
  ///     **WARNING**
  /// [Deprecated]
  ///     This option is ignored. [page.isHidden()] does not wait for the element to become hidden and returns immediately.
  ///     **Returns**
  /// - Future&lt;bool&gt;
  Future<bool> isHidden(String selector);

  /// **WARNING**
  /// [Discouraged]
  ///
  /// Use locator-based [locator.isVisible()] instead. Read more about [locators].
  ///
  /// Returns whether the element is [visible]. [selector] that does not match any elements is considered not visible.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await page.isVisible(selector);
  /// await page.isVisible(selector, options);
  /// ```
  ///
  /// **Arguments**
  /// - `selector` String
  ///
  ///   A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
  /// - `options` Map *(optional)*
  ///   - `strict` bool *(optional)*
  ///
  ///     When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
  ///   - `timeout` num *(optional)*
  ///
  ///     **WARNING**
  /// [Deprecated]
  ///     This option is ignored. [page.isVisible()] does not wait for the element to become visible and returns immediately.
  ///     **Returns**
  /// - Future&lt;bool&gt;
  Future<bool> isVisible(String selector);

  /// **WARNING**
  /// [Discouraged]
  ///
  /// Use locator-based [locator.isEditable()] instead. Read more about [locators].
  ///
  /// Returns whether the element is [editable].
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await page.isEditable(selector);
  /// await page.isEditable(selector, options);
  /// ```
  ///
  /// **Arguments**
  /// - `selector` String
  ///
  ///   A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
  /// - `options` Map *(optional)*
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     Allows to cancel the operation using an [`AbortSignal`]. If the signal is aborted, the operation will be aborted and throw an error. Note that providing a signal does not disable the default timeout, which can be changed using [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()]; pass `timeout: 0` to disable the timeout entirely.
  ///   - `strict` bool *(optional)*
  ///
  ///     When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;bool&gt;
  Future<bool> isEditable(String selector, {double? timeout});

  /// Adds a `<script>` tag into the page with the desired url or content. Returns the added tag when the script's onload fires or when the script content was injected into frame.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await page.addScriptTag();
  /// await page.addScriptTag(options);
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `content` String *(optional)*
  ///
  ///     Raw JavaScript content to be injected into frame.
  ///   - `path` String *(optional)*
  ///
  ///     Path to the JavaScript file to be injected into frame. If `path` is a relative path, then it is resolved relative to the current working directory.
  ///   - `type` String *(optional)*
  ///
  ///     Script type. Use 'module' in order to load a JavaScript ES6 module. See [script] for more details.
  ///   - `url` String *(optional)*
  ///
  ///     URL of a script to be added.
  ///
  /// **Returns**
  /// - Future&lt;[ElementHandle]&gt;
  Future<void> addScriptTag({String? url, String? content, String? type});

  /// Adds a `<link rel="stylesheet">` tag into the page with the desired url or a `<style type="text/css">` tag with the content. Returns the added tag when the stylesheet's onload fires or when the CSS content was injected into frame.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await page.addStyleTag();
  /// await page.addStyleTag(options);
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `content` String *(optional)*
  ///
  ///     Raw CSS content to be injected into frame.
  ///   - `path` String *(optional)*
  ///
  ///     Path to the CSS file to be injected into frame. If `path` is a relative path, then it is resolved relative to the current working directory.
  ///   - `url` String *(optional)*
  ///
  ///     URL of the `<link>` tag.
  ///
  /// **Returns**
  /// - Future&lt;[ElementHandle]&gt;
  Future<void> addStyleTag({String? url, String? content});

  /// **WARNING**
  /// [Discouraged]
  ///
  /// Never wait for timeout in production. Tests that wait for time are inherently flaky. Use [Locator] actions and web assertions that wait automatically.
  ///
  /// Waits for the given [timeout] in milliseconds.
  ///
  /// Note that `page.waitForTimeout()` should only be used for debugging. Tests using the timer in production are going to be flaky. Use signals such as network events, selectors becoming visible and others instead.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// // wait for 1 second
  /// await page.waitForTimeout(1000);
  /// ```
  ///
  /// **Arguments**
  /// - `timeout` double
  ///
  ///   A timeout to wait for
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
  /// [TestRun]: /api/class-testrun.mdx "TestRun"
  /// [TestStep]: /api/class-teststep.mdx "TestStep"
  /// [EvaluationArgument]: /evaluating.mdx#evaluation-argument "EvaluationArgument"
  /// [UIEvent.detail]: https://developer.mozilla.org/en-US/docs/Web/API/UIEvent/detail "UIEvent.detail"
  ///
  ///
  /// [all available image tags]: https://mcr.microsoft.com/en-us/product/playwright/about "all available image tags"
  /// [Microsoft Artifact Registry]: https://mcr.microsoft.com/en-us/product/playwright/about "Microsoft Artifact Registry"
  /// [Dockerfile.noble]: https://github.com/microsoft/playwright/blob/main/utils/docker/Dockerfile.noble "Dockerfile.noble"
  Future<void> waitForTimeout(double timeout);

  /// Returns when the [pageFunction] returns a truthy value. It resolves to a JSHandle of the truthy value.
  ///
  /// **Usage**
  ///
  /// The [page.waitForFunction()] can be used to observe viewport size change:
  ///
  /// ```dart
  ///   // Or 'chromium' or 'firefox'.
  ///
  /// (() async {
  ///   final browser = await webkit.launch();
  ///   final page = await browser.newPage();
  ///   final watchDog = page.waitForFunction(() => window.innerWidth < 100);
  ///   await page.setViewportSize( width: 50, height: 50 );
  ///   await watchDog;
  ///   await browser.close();
  /// }
  /// ```
  ///
  /// To pass an argument to the predicate of [page.waitForFunction()] function:
  ///
  /// ```dart
  /// final selector = '.foo';
  /// await page.waitForFunction((selector) => !!document.querySelector(selector), selector);
  /// ```
  ///
  /// **Arguments**
  /// - `pageFunction` Function | String
  ///
  ///   Function to be evaluated in the page context.
  /// - `arg` Object *(optional)*
  ///
  ///   Optional argument to pass to [pageFunction].
  /// - `options` Map *(optional)*
  ///   - `polling` num | "raf" *(optional)*
  ///
  ///     If [polling] is `'raf'`, then [pageFunction] is constantly executed in `requestAnimationFrame` callback. If [polling] is a number, then it is treated as an interval in milliseconds at which the function would be executed. Defaults to `raf`.
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     Allows to cancel the operation using an [`AbortSignal`]. If the signal is aborted, the operation will be aborted and throw an error. Note that providing a signal does not disable the default timeout, which can be changed using [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()]; pass `timeout: 0` to disable the timeout entirely.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time to wait for in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;[JSHandle]&gt;
  Future<JSHandle> waitForFunction(
    String expression, [

    Object? arg,

    double? timeout,

    double? pollingInterval,
  ]);

  /// **WARNING**
  /// [Discouraged]
  ///
  /// Use locator-based [locator.dispatchEvent()] instead. Read more about [locators].
  ///
  /// The snippet below dispatches the `click` event on the element. Regardless of the visibility state of the element, `click` is dispatched. This is equivalent to calling [element.click()].
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await page.dispatchEvent('button#submit', 'click');
  /// ```
  ///
  /// Under the hood, it creates an instance of an event based on the given [type], initializes it with [eventInit] properties and dispatches it on the element. Events are `composed`, `cancelable` and bubble by default.
  ///
  /// Since [eventInit] is event-specific, please refer to the events documentation for the lists of initial properties:
  /// * [DeviceMotionEvent]
  /// * [DeviceOrientationEvent]
  /// * [DragEvent]
  /// * [Event]
  /// * [FocusEvent]
  /// * [KeyboardEvent]
  /// * [MouseEvent]
  /// * [PointerEvent]
  /// * [TouchEvent]
  /// * [WheelEvent]
  ///
  /// You can also specify `JSHandle` as the property value if you want live objects to be passed into the event:
  ///
  /// ```dart
  /// // Note you can only create DataTransfer in Chromium and Firefox
  /// final dataTransfer = await page.evaluateHandle(() => new DataTransfer());
  /// await page.dispatchEvent('#source', 'dragstart', { dataTransfer );
  /// ```
  ///
  /// **Arguments**
  /// - `selector` String
  ///
  ///   A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
  /// - `type` String
  ///
  ///   DOM event type: `"click"`, `"dragstart"`, etc.
  /// - `eventInit` Map&lt;String, dynamic&gt; *(optional)*
  ///
  ///   Optional event-specific initialization properties.
  /// - `options` Map *(optional)*
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     Allows to cancel the operation using an [`AbortSignal`]. If the signal is aborted, the operation will be aborted and throw an error. Note that providing a signal does not disable the default timeout, which can be changed using [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()]; pass `timeout: 0` to disable the timeout entirely.
  ///   - `strict` bool *(optional)*
  ///
  ///     When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> dispatchEvent(
    String selector,

    String type, {

    Map<String, dynamic>? eventInit,

    double? timeout,
  });

  /// Highlights the element matching the selector.
  Future<void> highlight(String selector);

  /// Hide all locator highlight overlays previously added by [locator.highlight()] on this page.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await page.hideHighlight();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> hideHighlight();

  /// Drops files on the element matching the selector.
  Future<void> drop(
    String selector, {

    List<FrameDropPayloadsItems>? payloads,

    List<String>? localPaths,

    List<FrameDropDataItems>? data,

    bool? strict,

    double? timeout,
  });

  /// Queries for the first element matching the selector.
  Locator querySelector(String selector);

  /// Queries for all elements matching the selector.
  Future<List<Locator>> querySelectorAll(String selector);

  /// Returns the count of elements matching the selector.
  Future<int> queryCount(String selector);

  /// **WARNING**
  /// [Discouraged]
  ///
  /// Use locator-based [locator.selectOption()] instead. Read more about [locators].
  ///
  /// This method waits for an element matching [selector], waits for [actionability] checks, waits until all specified options are present in the `<select>` element and selects these options.
  ///
  /// If the target element is not a `<select>` element, this method throws an error. However, if the element is inside the `<label>` element that has an associated [control], the control will be used instead.
  ///
  /// Returns the array of option values that have been successfully selected.
  ///
  /// Triggers a `change` and `input` event once all the provided options have been selected.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// // Single selection matching the value or label
  /// page.selectOption('select#colors', 'blue');
  ///
  /// // single selection matching the label
  /// page.selectOption('select#colors', { label: 'Blue' );
  ///
  /// // multiple selection
  /// page.selectOption('select#colors', ['red', 'green', 'blue']);
  ///
  /// ```
  ///
  /// **Arguments**
  /// - `selector` String
  ///
  ///   A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
  /// - `values` List&lt;SelectOption&gt;
  ///   - `value` String *(optional)*
  ///
  ///     Matches by `option.value`. Optional.
  ///   - `label` String *(optional)*
  ///
  ///     Matches by `option.label`. Optional.
  ///   - `index` num *(optional)*
  ///
  ///     Matches by the index. Optional.
  ///
  ///   Options to select. If the `<select>` has the `multiple` attribute, all matching options are selected, otherwise only the first option matching one of the passed options is selected. String values are matching both values and labels. Option is considered matching if all specified properties match.
  /// - `options` Map *(optional)*
  ///   - `force` bool *(optional)*
  ///
  ///     Whether to bypass the [actionability] checks. Defaults to `false`.
  ///   - `noWaitAfter` bool *(optional)*
  ///
  ///     **WARNING**
  /// [Deprecated]
  ///     This option has no effect.
  ///     This option has no effect.
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     Allows to cancel the operation using an [`AbortSignal`]. If the signal is aborted, the operation will be aborted and throw an error. Note that providing a signal does not disable the default timeout, which can be changed using [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()]; pass `timeout: 0` to disable the timeout entirely.
  ///   - `strict` bool *(optional)*
  ///
  ///     When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;List&lt;String&gt;&gt;
  Future<List<String>> selectOption(
    String selector,

    List<SelectOption>? values, {

    bool? force,

    double? timeout,
  });

  /// **WARNING**
  /// [Discouraged]
  ///
  /// Use locator-based [locator.setInputFiles()] instead. Read more about [locators].
  ///
  /// Sets the value of the file input to these file paths or files. If some of the `filePaths` are relative paths, then they are resolved relative to the current working directory. For empty array, clears the selected files. For inputs with a `[webkitdirectory]` attribute, only a single directory path is supported.
  ///
  /// This method expects [selector] to point to an [input element]. However, if the element is inside the `<label>` element that has an associated [control], targets the control instead.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await page.setInputFiles(selector, files);
  /// await page.setInputFiles(selector, files, options);
  /// ```
  ///
  /// **Arguments**
  /// - `selector` String
  ///
  ///   A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
  /// - `files` List&lt;InputFile&gt;
  ///   - `name` String
  ///
  ///     File name
  ///   - `mimeType` String
  ///
  ///     File type
  ///   - `buffer` List&lt;int&gt;
  ///
  ///     File content
  /// - `options` Map *(optional)*
  ///   - `noWaitAfter` bool *(optional)*
  ///
  ///     **WARNING**
  /// [Deprecated]
  ///     This option has no effect.
  ///     This option has no effect.
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     Allows to cancel the operation using an [`AbortSignal`]. If the signal is aborted, the operation will be aborted and throw an error. Note that providing a signal does not disable the default timeout, which can be changed using [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()]; pass `timeout: 0` to disable the timeout entirely.
  ///   - `strict` bool *(optional)*
  ///
  ///     When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> setInputFiles(
    String selector,

    List<InputFile>? files, {

    bool? noWaitAfter,

    double? timeout,
  });

  /// Captures the aria snapshot of the page. Read more about [aria snapshots].
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await page.ariaSnapshot();
  /// await page.ariaSnapshot(options);
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `boxes` bool *(optional)*
  ///
  ///     When `true`, appends each element's bounding box as `[box=x,y,width,height]` to the snapshot. Coordinates are relative to the viewport, in CSS pixels, as returned by [`Element.getBoundingClientRect()`]. Defaults to `false`.
  ///   - `depth` int *(optional)*
  ///
  ///     When specified, limits the depth of the snapshot.
  ///   - `mode` SnapshotMode *(optional)*
  ///
  ///     When set to `"ai"`, returns a snapshot optimized for AI consumption: including element references like `[ref=e2]` and snapshots of `<iframe>`s. Defaults to `"default"`.
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     Allows to cancel the operation using an [`AbortSignal`]. If the signal is aborted, the operation will be aborted and throw an error. Note that providing a signal does not disable the default timeout, which can be changed using [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()]; pass `timeout: 0` to disable the timeout entirely.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;String&gt;
  Future<FrameAriaSnapshotResult> ariaSnapshot(
    String selector, {

    SnapshotMode? mode,

    String? track,

    int? depth,

    bool? boxes,

    double? timeout,
  });

  /// Returns the ARIA snapshot of the page or element in JSON format.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await page.ariaSnapshotJSON();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;FrameAriaSnapshotJSONResult&gt;
  Future<FrameAriaSnapshotJSONResult> ariaSnapshotJSON({
    Pattern? selector,
    SnapshotMode? mode,
    int? depth,
    bool? boxes,
    double? timeout,
  });

  /// Performs an assertion on the element matching the selector.
  Future<ExpectResult> expect(
    String selector,

    String expression, {

    SerializedArgument? expectedValue,

    List<ExpectedTextValue>? expectedText,

    double? expectedNumber,

    bool? useInnerText,

    required bool isNot,

    double? timeout,
  });

  /// The method adds a function called [name] on the `window` object of every frame in this page. When called, the function executes [callback] and returns a Future which resolves to the return value of [callback]. If the [callback] returns a Future, it will be awaited.
  ///
  /// The first argument of the [callback] function contains information about the caller: `{ browserContext: BrowserContext, page: Page, frame: Frame }`.
  ///
  /// See [browserContext.exposeBinding()] for the context-wide version.
  ///
  /// **NOTE**
  /// Functions installed via [page.exposeBinding()] survive navigations.
  /// **Usage**
  ///
  /// An example of exposing page URL to all frames in a page:
  ///
  /// ```dart
  ///   // Or 'chromium' or 'firefox'.
  ///
  /// (() async {
  ///   final browser = await webkit.launch( headless: false );
  ///   final context = await browser.newContext();
  ///   final page = await context.newPage();
  ///   await page.exposeBinding('pageURL', ( page ) => page.url());
  ///   await page.setContent(`
  ///     <script>
  ///       async function onClick() {
  ///         document.querySelector('div').textContent = await window.pageURL();
  ///       }
  ///     </script>
  ///     <button onclick="onClick()">Click me</button>
  ///     <div></div>
  ///   `);
  ///   await page.click('button');
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

  /// The method adds a function called [name] on the `window` object of every frame in the page. When called, the function executes [callback] and returns a Future which resolves to the return value of [callback].
  ///
  /// If the [callback] returns a Future, it will be awaited.
  ///
  /// See [browserContext.exposeFunction()] for context-wide exposed function.
  ///
  /// **NOTE**
  /// Functions installed via [page.exposeFunction()] survive navigations.
  /// **Usage**
  ///
  /// An example of adding a `sha256` function to the page:
  ///
  /// ```dart
  ///   // Or 'chromium' or 'firefox'.
  ///
  /// (() async {
  ///   final browser = await webkit.launch( headless: false );
  ///   final page = await browser.newPage();
  ///   await page.exposeFunction('sha256', (text) =>
  ///     crypto.createHash('sha256').update(text).digest('hex'),
  ///   );
  ///   await page.setContent(`
  ///     <script>
  ///       async function onClick() {
  ///         document.querySelector('div').textContent = await window.sha256('PLAYWRIGHT');
  ///       }
  ///     </script>
  ///     <button onclick="onClick()">Click me</button>
  ///     <div></div>
  ///   `);
  ///   await page.click('button');
  /// }
  /// ```
  ///
  /// **Arguments**
  /// - `name` String
  ///
  ///   Name of the function on the window object
  /// - `callback` Function
  ///
  ///   Callback function which will be called in Playwright's context.
  ///
  /// **Returns**
  /// - Future&lt;[Disposable]&gt;
  Future<void> exposeFunction(String name);

  /// Returns the opener for popup pages and `null` for others. If the opener has been closed already the returns `null`.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await page.opener();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;[Page]?&gt;
  Page? opener();

  /// Request the page to perform garbage collection. Note that there is no guarantee that all unreachable objects will be collected.
  ///
  /// This is useful to help detect memory leaks. For example, if your page has a large object `'suspect'` that might be leaked, you can check that it does not leak by using a [`WeakRef`].
  ///
  /// ```dart
  /// // 1. In your page, save a WeakRef for the "suspect".
  /// await page.evaluate(() => globalThis.suspectWeakRef = new WeakRef(suspect));
  /// // 2. Request garbage collection.
  /// await page.requestGC();
  /// // 3. Check that weak ref does not deref to the original object.
  /// expect(await page.evaluate(() => !globalThis.suspectWeakRef.deref())).toBe(true);
  /// ```
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await page.requestGC();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> requestGC();

  /// Registers a locator handler.
  Future<PageRegisterLocatorHandlerResult> registerLocatorHandler(
    Locator selector, {

    bool? noWaitAfter,
  });

  /// Unregisters a locator handler.
  Future<void> unregisterLocatorHandler(int uid);

  /// When testing a web page, sometimes unexpected overlays like a "Sign up" dialog appear and block actions you want to automate, e.g. clicking a button. These overlays don't always show up in the same way or at the same time, making them tricky to handle in automated tests.
  ///
  /// This method lets you set up a special function, called a handler, that activates when it detects that overlay is visible. The handler's job is to remove the overlay, allowing your test to continue as if the overlay wasn't there.
  ///
  /// Things to keep in mind:
  /// * When an overlay is shown predictably, we recommend explicitly waiting for it in your test and dismissing it as a part of your normal test flow, instead of using [page.addLocatorHandler()].
  /// * Playwright checks for the overlay every time before executing or retrying an action that requires an [actionability check], or before performing an auto-waiting assertion check. When overlay is visible, Playwright calls the handler first, and then proceeds with the action/assertion. Note that the handler is only called when you perform an action/assertion - if the overlay becomes visible but you don't perform any actions, the handler will not be triggered.
  /// * After executing the handler, Playwright will ensure that overlay that triggered the handler is not visible anymore. You can opt-out of this behavior with [noWaitAfter].
  /// * The execution time of the handler counts towards the timeout of the action/assertion that executed the handler. If your handler takes too long, it might cause timeouts.
  /// * You can register multiple handlers. However, only a single handler will be running at a time. Make sure the actions within a handler don't depend on another handler.
  ///
  /// **WARNING**
  /// Running the handler will alter your page state mid-test. For example it will change the currently focused element and move the mouse. Make sure that actions that run after the handler are self-contained and do not rely on the focus and mouse state being unchanged.
  ///
  /// For example, consider a test that calls [locator.focus()] followed by [keyboard.press()]. If your handler clicks a button between these two actions, the focused element most likely will be wrong, and key press will happen on the unexpected element. Use [locator.press()] instead to avoid this problem.
  ///
  /// Another example is a series of mouse actions, where [mouse.move()] is followed by [mouse.down()]. Again, when the handler runs between these two actions, the mouse position will be wrong during the mouse down. Prefer self-contained actions like [locator.click()] that do not rely on the state being unchanged by a handler.
  /// **Usage**
  ///
  /// An example that closes a "Sign up to the newsletter" dialog when it appears:
  ///
  /// ```dart
  /// // Setup the handler.
  /// await page.addLocatorHandler(page.getByText('Sign up to the newsletter'), () async {
  ///   await page.getByRole('button', { name: 'No thanks' ).click();
  /// );
  ///
  /// // Write the test as usual.
  /// await page.goto('https://example.com');
  /// await page.getByRole('button', { name: 'Start here' ).click();
  /// ```
  ///
  /// An example that skips the "Confirm your security details" page when it is shown:
  ///
  /// ```dart
  /// // Setup the handler.
  /// await page.addLocatorHandler(page.getByText('Confirm your security details'), () async {
  ///   await page.getByRole('button', { name: 'Remind me later' ).click();
  /// );
  ///
  /// // Write the test as usual.
  /// await page.goto('https://example.com');
  /// await page.getByRole('button', { name: 'Start here' ).click();
  /// ```
  ///
  /// An example with a custom callback on every actionability check. It uses a `<body>` locator that is always visible, so the handler is called before every actionability check. It is important to specify [noWaitAfter], because the handler does not hide the `<body>` element.
  ///
  /// ```dart
  /// // Setup the handler.
  /// await page.addLocatorHandler(page.locator('body'), () async {
  ///   await page.evaluate(() => window.removeObstructionsForTestIfNeeded());
  /// }, { noWaitAfter: true );
  ///
  /// // Write the test as usual.
  /// await page.goto('https://example.com');
  /// await page.getByRole('button', { name: 'Start here' ).click();
  /// ```
  ///
  /// Handler takes the original locator as an argument. You can also automatically remove the handler after a number of invocations by setting [times]:
  ///
  /// ```dart
  /// await page.addLocatorHandler(page.getByLabel('Close'), (locator) async {
  ///   await locator.click();
  /// }, { times: 1 );
  /// ```
  ///
  /// **Arguments**
  /// - `locator` Locator
  ///
  ///   Locator that triggers the handler.
  /// - `handler` Future&lt;void&gt; Function(Locator)
  ///
  ///   Function that should be run once [locator] appears. This function should get rid of the element that blocks actions like click.
  /// - `options` Map *(optional)*
  ///   - `noWaitAfter` bool *(optional)*
  ///
  ///     By default, after calling the handler Playwright will wait until the overlay becomes hidden, and only then Playwright will continue with the action/assertion that triggered the handler. This option allows to opt-out of this behavior, so that overlay can stay visible after the handler has run.
  ///   - `times` int *(optional)*
  ///
  ///     Specifies the maximum number of times this handler should be called. Unlimited by default.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> addLocatorHandler(
    Locator locator,
    Future<void> Function(Locator) handler, {
    bool? noWaitAfter,
    int? times,
  });

  /// Removes all locator handlers added by [page.addLocatorHandler()] for a specific locator.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await page.removeLocatorHandler(locator);
  /// ```
  ///
  /// **Arguments**
  /// - `locator` Locator
  ///
  ///   Locator passed to [page.addLocatorHandler()].
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> removeLocatorHandler(Locator locator);

  /// The extra HTTP headers will be sent with every request the page initiates.
  ///
  /// **NOTE**
  /// [page.setExtraHTTPHeaders()] does not guarantee the order of headers in the outgoing requests.
  /// **Usage**
  ///
  /// ```dart
  /// await page.setExtraHTTPHeaders(headers);
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

  /// Sets network interception patterns for the page.
  Future<void> setNetworkInterceptionPatterns(
    List<PageSetNetworkInterceptionPatternsItems> patterns,
  );

  /// This method allows to modify websocket connections that are made by the page.
  ///
  /// Note that only `WebSocket`s created after this method was called will be routed. It is recommended to call this method before navigating the page.
  ///
  /// **Usage**
  ///
  /// Below is an example of a simple mock that responds to a single message. See [WebSocketRoute] for more details and examples.
  ///
  /// ```dart
  /// await page.routeWebSocket('/ws', (ws) {
  ///   ws.onMessage((message) {
  ///     if (message == 'request')
  ///       ws.send('response');
  ///   );
  /// );
  /// ```
  ///
  /// **Arguments**
  /// - `url` Pattern
  ///
  ///   Only WebSockets with the url matching this pattern will be routed. A string pattern can be relative to the [baseURL] context option.
  /// - `handler` Future&lt;void&gt; Function(WebSocketRoute)
  ///
  ///   Handler function to route the WebSocket.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> routeWebSocket(
    Pattern url,
    Future<void> Function(WebSocketRoute) handler,
  );

  /// Taps the touchscreen at the given coordinates.
  Future<void> touchscreenTap(double x, double y);

  /// Brings page to front (activates tab).
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await page.bringToFront();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> bringToFront();

  /// Enters pick locator mode where hovering over page elements highlights them and shows the corresponding locator. Once the user clicks an element, the mode is deactivated and the [Locator] for the picked element is returned.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// final locator = await page.pickLocator();
  /// print(locator);
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;[Locator]&gt;
  Future<PagePickLocatorResult> pickLocator();

  /// Cancels an ongoing [page.pickLocator()] call by deactivating pick locator mode. If no pick locator mode is active, this method is a no-op.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await page.cancelPickLocator();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> cancelPickLocator();

  /// Starts screencasting the page.
  Future<void> screencastStart({
    PageScreencastStartSize? size,

    int? quality,

    bool? sendFrames,

    bool? record,
  });

  /// Stops screencasting the page.
  Future<void> screencastStop();

  /// Sets the dock tile image.
  Future<void> setDockTile(String image);

  /// Clears all stored console messages from this page. Subsequent calls to [page.consoleMessages()] will only return messages logged after the clear.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await page.clearConsoleMessages();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> clearConsoleMessages();

  /// Returns up to (currently) 200 last console messages from this page. See [page.on('console')] for more details.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await page.consoleMessages();
  /// await page.consoleMessages(options);
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `filter` ConsoleMessagesFilter *(optional)*
  ///
  ///     Controls which messages are returned:
  ///
  /// **Returns**
  /// - Future&lt;List&lt;[ConsoleMessage]&gt;&gt;
  Future<PageConsoleMessagesResult> consoleMessages({
    ConsoleMessagesFilter? filter,
  });

  /// Clears all stored page errors from this page. Subsequent calls to [page.pageErrors()] will only return errors thrown after the clear.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await page.clearPageErrors();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> clearPageErrors();

  /// Returns up to (currently) 200 last page errors from this page. See [page.on('pageerror')] for more details.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await page.pageErrors();
  /// await page.pageErrors(options);
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `filter` ConsoleMessagesFilter *(optional)*
  ///
  ///     Controls which errors are returned:
  ///
  /// **Returns**
  /// - Future&lt;List&lt;[Error]&gt;&gt;
  Future<PagePageErrorsResult> pageErrors({ConsoleMessagesFilter? filter});

  /// Returns up to (currently) 100 last network request from this page. See [page.on('request')] for more details.
  ///
  /// Returned requests should be accessed immediately, otherwise they might be collected to prevent unbounded memory growth as new requests come in. Once collected, retrieving most information about the request is impossible.
  ///
  /// Note that requests reported through the [page.on('request')] request are not collected, so there is a trade off between efficient memory usage with [page.requests()] and the amount of available information reported through [page.on('request')].
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await page.requests();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;List&lt;[Request]&gt;&gt;
  Future<PageRequestsResult> requests();

  Future<void> resolveLocatorHandlerNoReply(int uid, {bool? remove});

  Future<PageExpectScreenshotResult> expectScreenshot({
    String? expected,

    required double timeout,

    required bool isNot,

    PageExpectScreenshotLocator? locator,

    String? comparator,

    int? maxDiffPixels,

    double? maxDiffPixelRatio,

    double? threshold,

    bool? fullPage,

    Rect? clip,

    required CommonScreenshotOptions screenshotOptions,
  });

  Future<void> setWebSocketInterceptionPatterns(
    List<PageSetWebSocketInterceptionPatternsItems> patterns,
  );

  Future<void> startJSCoverage({
    bool? resetOnNavigation,

    bool? reportAnonymousScripts,
  });

  Future<PageStopJSCoverageResult> stopJSCoverage();

  Future<void> startCSSCoverage({bool? resetOnNavigation});

  Future<PageStopCSSCoverageResult> stopCSSCoverage();

  Future<PageScreencastShowOverlayResult> screencastShowOverlay(
    String html, {

    double? duration,
  });

  Future<void> screencastRemoveOverlay(String id);

  Future<void> screencastChapter(
    String title, {

    String? description,

    double? duration,
  });

  Future<void> screencastSetOverlayVisible(bool visible);

  Future<void> screencastShowActions(ShowActionsOptions options);

  Future<void> screencastHideActions();

  /// Acknowledges receiving a screencast frame.
  Future<void> screencastFrameAck({
    required int frameId,
    double? timeout,
  });

  Future<void> updateSubscription({
    required PageUpdateSubscriptionEvent event,

    required bool enabled,
  });

  // ── Web Storage ───────────────────────────────────────────────────────────

  /// Returns all items from `localStorage` or `sessionStorage`.

  Future<Map<String, String>> storageItems(Kind kind);

  /// Returns the value of an item from `localStorage` or `sessionStorage`.

  Future<String?> storageGetItem(Kind kind, String name);

  /// Sets an item in `localStorage` or `sessionStorage`.

  Future<void> storageSetItem(Kind kind, String name, String value);

  /// Removes an item from `localStorage` or `sessionStorage`.

  Future<void> storageRemoveItem(Kind kind, String name);

  /// Clears all items from `localStorage` or `sessionStorage`.

  Future<void> storageClear(Kind kind);

  // ── Channel Method Aliases ────────────────────────────────────────────────

  /// Runs the beforeunload event handler (channel method alias).

  Future<void> runBeforeUnload();

  /// Clears web storage (channel method alias for storageClear).

  Future<void> webStorageClear({required Kind kind});

  /// Gets an item from web storage (channel method alias).

  Future<PageWebStorageGetItemResult> webStorageGetItem({
    required Kind kind,

    required String name,
  });

  /// Gets all items from web storage (channel method alias).

  Future<PageWebStorageItemsResult> webStorageItems({required Kind kind});

  /// Removes an item from web storage (channel method alias).

  Future<void> webStorageRemoveItem({required Kind kind, required String name});

  /// Sets an item in web storage (channel method alias).

  Future<void> webStorageSetItem({
    required Kind kind,

    required String name,

    required String value,
  });
}

class PageImpl extends PageBase implements Page {
  bool _isClosed = false;

  double? _timeout;

  double? _navigationTimeout;

  final RouteManager _routeManager = RouteManager();

  late final RouteListener _routeListener = RouteListener(_routeManager);

  double get defaultNavigationTimeout =>
      _navigationTimeout ??
      _timeout ??
      (context as BrowserContextImpl).defaultNavigationTimeout ??
      (context as BrowserContextImpl).defaultTimeout ??
      30000.0;

  double get defaultTimeout =>
      _timeout ?? (context as BrowserContextImpl).defaultTimeout ?? 30000.0;

  @override
  bool get isClosed => _isClosed;

  @override
  String url() => mainFrame.url();

  @override
  PageSetViewportSize? get viewportSize {
    final size = typedInitializer.viewportSize;
    if (size == null) return null;
    return PageSetViewportSize(width: size.width, height: size.height);
  }

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
  List<Frame> get frames => objects.values.whereType<Frame>().toList();

  @override
  List<Worker> get workers => objects.values.whereType<Worker>().toList();

  @override
  Stream<WebSocketRoute> get onWebSocketRoute {
    return onEvent
        .where((e) => e['event'] == 'webSocketRoute')
        .map((e) => e['params']['webSocketRoute']);
  }

  @override
  Stream<Map<String, dynamic>> get onScreencastFrame {
    return onEvent
        .where((e) => e['event'] == 'screencastFrame')
        .map((e) => e['params']);
  }

  @override
  Stream<Route> get onRoute {
    return onEvent.where((e) => e['event'] == 'route').map((e) {
      final routeGuid = e['params']['route']['guid'];

      return connection.objects[routeGuid] as Route;
    });
  }

  @override
  Stream<dynamic> get onLocatorHandlerTriggered {
    return onEvent
        .where((e) => e['event'] == 'locatorHandlerTriggered')
        .map((e) => e['params']['uid']);
  }

  @override
  Stream<Frame> get onFrameDetached {
    return onEvent
        .where((e) => e['event'] == 'frameDetached')
        .map((e) => connection.objects[e['params']['frame']['guid']] as Frame);
  }

  @override
  Stream<Frame> get onFrameAttached {
    return onEvent
        .where((e) => e['event'] == 'frameAttached')
        .map((e) => connection.objects[e['params']['frame']['guid']] as Frame);
  }

  @override
  Stream<Map<String, dynamic>> get onViewportSizeChanged {
    return onEvent
        .where((e) => e['event'] == 'viewportSizeChanged')
        .map((e) => e['params']['viewportSize']);
  }

  @override
  Stream<BindingCall> get onBindingCall {
    return onEvent
        .where((e) => e['event'] == 'bindingCall')
        .map((e) => e['params']['binding']);
  }

  @override
  late final Keyboard keyboard;

  @override
  late final Mouse mouse;

  @override
  late final Touchscreen touchscreen;

  PageImpl(
    super.connection,

    super.channelType,

    super.guid,

    super.initializer, [

    super.parent,
  ]) {
    keyboard = Keyboard(this);

    mouse = Mouse(this);

    touchscreen = Touchscreen(this);

    onEvent.where((e) => e['event'] == 'close').listen((_) => _isClosed = true);

    (mainFrame as FrameImpl).internalSetPage(this);

    for (final f in mainFrame.childFrames) {
      (f as FrameImpl).internalSetPage(this);
    }

    onEvent.where((e) => e['event'] == 'frameAttached').listen((e) {
      final frame =
          connection.objects[e['params']['frame']['guid']] as FrameImpl?;

      if (frame != null) frame.internalSetPage(this);
    });
  }

  @override
  BrowserContext get context => parent as BrowserContext;

  String get _mainFrameGuid => typedInitializer.mainFrame.guid;

  @override
  Frame get mainFrame => typedInitializer.mainFrame as Frame;

  @override
  Stream<ConsoleMessage> get onConsole {
    channel.updateSubscription(
      enabled: true,

      event: PageUpdateSubscriptionEvent.console,
    );

    return (context as BrowserContextImpl).onEvent
        .where(
          (e) =>
              e['event'] == 'console' &&
              e['params']['page'] != null &&
              e['params']['page']['guid'] == guid,
        )
        .map((e) {
          final message = channels.ConsoleMessage.fromJson(
            e['params'],

            connection: connection,
          );

          return ConsoleMessage(this, message);
        });
  }

  @override
  Stream<FileChooser> get onFileChooser {
    channel.updateSubscription(
      enabled: true,

      event: PageUpdateSubscriptionEvent.fileChooser,
    );

    return onEvent.where((e) => e['event'] == 'fileChooser').map((e) {
      final elementGuid = e['params']['element']['guid'];

      final element = connection.objects[elementGuid] as ElementHandle;

      final isMultiple = e['params']['isMultiple'] as bool;

      return FileChooser(this, element, isMultiple);
    });
  }

  @override
  Stream<Dialog> get onDialog {
    channel.updateSubscription(
      enabled: true,

      event: PageUpdateSubscriptionEvent.dialog,
    );

    return onEvent.where((e) => e['event'] == 'dialog').map((e) {
      final dialogGuid = e['params']['dialog']['guid'];

      return connection.objects[dialogGuid] as Dialog;
    });
  }

  @override
  Stream<Request> get onRequest {
    channel.updateSubscription(
      enabled: true,

      event: PageUpdateSubscriptionEvent.request,
    );

    return (context as BrowserContextImpl).onEvent
        .where(
          (e) =>
              e['event'] == 'request' &&
              e['params']['page'] != null &&
              e['params']['page']['guid'] == guid,
        )
        .map((e) {
          final requestGuid = e['params']['request']['guid'];

          return connection.objects[requestGuid] as Request;
        });
  }

  @override
  Stream<Response> get onResponse {
    channel.updateSubscription(
      enabled: true,

      event: PageUpdateSubscriptionEvent.response,
    );

    return (context as BrowserContextImpl).onEvent
        .where(
          (e) =>
              e['event'] == 'response' &&
              e['params']['page'] != null &&
              e['params']['page']['guid'] == guid,
        )
        .map((e) {
          final responseGuid = e['params']['response']['guid'];

          return connection.objects[responseGuid] as Response;
        });
  }

  @override
  Stream<Request> get onRequestFinished {
    channel.updateSubscription(
      enabled: true,

      event: PageUpdateSubscriptionEvent.requestFinished,
    );

    return (context as BrowserContextImpl).onEvent
        .where((e) => e['event'] == 'requestFinished')
        .map((e) {
          final requestGuid = e['params']['request']['guid'];

          return connection.objects[requestGuid] as Request;
        })
        .where((request) => request.frame.page == this);
  }

  @override
  Stream<Request> get onRequestFailed {
    channel.updateSubscription(
      enabled: true,

      event: PageUpdateSubscriptionEvent.requestFailed,
    );

    return (context as BrowserContextImpl).onEvent
        .where(
          (e) =>
              e['event'] == 'requestFailed' &&
              e['params']['page'] != null &&
              e['params']['page']['guid'] == guid,
        )
        .map((e) {
          final requestGuid = e['params']['request']['guid'];

          final req = connection.objects[requestGuid] as RequestImpl;

          if (e['params']['failureText'] != null) {
            req.failureText = e['params']['failureText'];
          }

          if (e['params']['responseEndTiming'] != null) {
            final t = req.timing;

            t['responseEnd'] = e['params']['responseEndTiming'];

            req.timing = t;
          }

          return req;
        });
  }

  @override
  Stream<WebSocket> get onWebSocket {
    return onEvent.where((e) => e['event'] == 'webSocket').map((e) {
      final guid = e['params']['webSocket']['guid'];

      return connection.objects[guid] as WebSocket;
    });
  }

  @override
  Stream<Page> get onClose {
    return onEvent.where((e) => e['event'] == 'close').map((e) => this);
  }

  @override
  Stream<Page> get onCrash {
    return onEvent.where((e) => e['event'] == 'crash').map((e) => this);
  }

  @override
  Stream<Exception> get onPageError {
    return (context as BrowserContextImpl).onEvent
        .where(
          (e) =>
              e['event'] == 'pageError' &&
              e['params']['page'] != null &&
              e['params']['page']['guid'] == guid,
        )
        .map((e) {
          final errorPayload = e['params']['error']['error'];

          return Exception(errorPayload['message']);
        });
  }

  @override
  Video? video() {
    final videoInitializer = typedInitializer.video;

    if (videoInitializer == null) return null;

    final artifact = connection.objects[videoInitializer.guid] as Artifact;

    return Video(this, artifact);
  }

  @override
  Stream<Page> get onPopup {
    return onEvent.where((e) => e['event'] == 'popup').map((e) {
      final guid = e['params']['page']['guid'];

      return connection.objects[guid] as Page;
    });
  }

  @override
  Stream<Worker> get onWorker {
    return onEvent.where((e) => e['event'] == 'worker').map((e) {
      final workerGuid = e['params']['worker']['guid'];

      return connection.objects[workerGuid] as Worker;
    });
  }

  @override
  Future<Request> waitForRequest(
    RouteMatcher urlOrPredicate, {

    double? timeout,
  }) async {
    return await _waitForNetworkEvent(
      onRequest,

      urlOrPredicate,

      timeout: timeout,
    );
  }

  @override
  Future<Response> waitForResponse(
    RouteMatcher urlOrPredicate, {

    double? timeout,
  }) async {
    return await _waitForNetworkEvent(
      onResponse,

      urlOrPredicate,

      timeout: timeout,
    );
  }

  Future<T> _waitForNetworkEvent<T>(
    Stream<T> stream,
    RouteMatcher urlOrPredicate, {
    double? timeout,
  }) async {
    final timeoutDuration = Duration(milliseconds: timeout?.toInt() ?? 30000);

    return await stream
        .firstWhere((event) {
          if (urlOrPredicate is StringRouteMatcher) {
            final url = (event as dynamic).url as String;

            return url.contains(urlOrPredicate.glob) ||
                RegExp(urlOrPredicate.glob).hasMatch(url);
          } else if (urlOrPredicate is RegExpRouteMatcher) {
            final url = (event as dynamic).url as String;

            return urlOrPredicate.regex.hasMatch(url);
          } else if (urlOrPredicate is FunctionRouteMatcher) {
            try {
              final result = urlOrPredicate.callPredicate(event);
              return result == true;
            } catch (e, stack) {
              print('Caught error in page.dart: $e\n$stack');
              return false;
            }
          }

          return false;
        })
        .timeout(
          timeoutDuration,
          onTimeout: () => throw Exception(
            'Timeout ${timeoutDuration.inMilliseconds}ms exceeded',
          ),
        );
  }

  @override
  Stream<Download> get onDownload {
    return onEvent.where((e) => e['event'] == 'download').map((e) {
      final artifactGuid = e['params']['artifact']['guid'];

      final artifact = connection.objects[artifactGuid] as Artifact;

      final url = e['params']['url'] as String;

      final suggestedFilename = e['params']['suggestedFilename'] as String;

      return Download(this, url, suggestedFilename, artifact);
    });
  }

  @override
  Future<void> goto(
    String url, {

    double? timeout,

    LifecycleEvent? waitUntil,

    String? referer,
  }) async {
    Logger.debug('goto $url', name: 'playwright.page');
    await mainFrame.goto(
      url,

      timeout: timeout,

      waitUntil: waitUntil,

      referer: referer,
    );
  }

  @override
  Future<void> waitForLoadState({
    LifecycleEvent state = LifecycleEvent.load,

    double? timeout,
  }) async {
    await mainFrame.waitForLoadState(state: state, timeout: timeout);
  }

  @override
  Future<void> waitForURL(
    RouteMatcher urlOrPredicate, {

    double? timeout,

    LifecycleEvent? waitUntil,
  }) async {
    await mainFrame.waitForURL(
      urlOrPredicate,

      timeout: timeout,

      waitUntil: waitUntil,
    );
  }

  @override
  Future<void> waitForNavigation({
    RouteMatcher? url,

    LifecycleEvent? waitUntil,

    double? timeout,
  }) async {
    await mainFrame.waitForNavigation(
      url: url,

      waitUntil: waitUntil,

      timeout: timeout,
    );
  }

  @override
  Future<String> title() async {
    final result = await connection.sendMessageToServer(
      _mainFrameGuid,

      'title',

      {},
    );

    return result['value'] as String;
  }

  @override
  Locator locator(String selector) {
    return mainFrame.locator(selector);
  }

  @override
  FrameLocator frameLocator(String selector) =>
      mainFrame.frameLocator(selector);

  @override
  Future<T> evaluate<T>(String expression, [Object? arg]) async {
    return mainFrame.evaluate(expression, arg);
  }

  @override
  Future<FrameWaitForSelectorResult> waitForSelector(
    String selector, {

    SelectorState? state,

    double? timeout,
  }) async {
    return mainFrame.waitForSelector(selector, state: state, timeout: timeout);
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

  @override
  Future<void> route(String url, Future<void> Function(Route) handler) async {
    _routeManager.add(url, handler);

    _routeListener.attach(onRoute);

    await channel.setNetworkInterceptionPatterns(
      patterns: _routeManager.preparePagePatterns(),
    );
  }

  @override
  Future<void> unroute(
    String url, {

    Future<void> Function(Route route)? handler,
  }) async {
    _routeManager.remove(url, handler);

    await channel.setNetworkInterceptionPatterns(
      patterns: _routeManager.preparePagePatterns(),
    );
  }

  @override
  Future<void> unrouteAll() async {
    _routeManager.clear();

    await channel.setNetworkInterceptionPatterns(patterns: []);
  }

  @override
  Frame? frame({String? name, String? url}) {
    if (name == null && url == null) {
      throw ArgumentError('Either name or url must be specified');
    }

    for (final f in frames) {
      if (name != null && f.name == name) return f;

      if (url != null && f.url().contains(url)) return f;
    }

    return null;
  }

  @override
  Locator getByText(Pattern text, {bool exact = false}) {
    return locator(
      'internal:text=${encodePatternForTextSelector(text, exact: exact)}',
    );
  }

  @override
  Locator getByRole(
    String role, {
    Pattern? name,
    bool exact = false,
    bool? checked,
    bool? disabled,
    bool? expanded,
    bool? includeHidden,
    int? level,
    bool? pressed,
    bool? selected,
    Pattern? description,
  }) {
    return locator(
      buildRoleSelector(
        role,
        name: name,
        exact: exact,
        checked: checked,
        disabled: disabled,
        expanded: expanded,
        includeHidden: includeHidden,
        level: level,
        pressed: pressed,
        selected: selected,
        description: description,
      ),
    );
  }

  @override
  Locator getByLabel(Pattern text, {bool exact = false}) {
    return locator(
      'internal:label=${encodePatternForLabelSelector(text, exact: exact)}',
    );
  }

  @override
  Locator getByPlaceholder(Pattern text, {bool exact = false}) {
    return locator(
      'internal:attr=[placeholder=${encodePatternForAttrSelector(text, exact: exact)}]',
    );
  }

  @override
  Locator getByAltText(Pattern text, {bool exact = false}) {
    return locator(
      'internal:attr=[alt=${encodePatternForAttrSelector(text, exact: exact)}]',
    );
  }

  @override
  Locator getByTitle(Pattern text, {bool exact = false}) {
    return locator(
      'internal:attr=[title=${encodePatternForAttrSelector(text, exact: exact)}]',
    );
  }

  @override
  Locator getByTestId(String testId) {
    return locator(getByTestIdSelector(testId));
  }

  @override
  PageAssertions pageExpect({double? timeout}) =>
      PageAssertions(this, false, timeout);

  @override
  APIRequestContext get request => (context as BrowserContextImpl).request;

  @override
  Clock get clock => (context as BrowserContextImpl).clock;

  @override
  Future<void> setViewportSize(PageSetViewportSize viewportSize) async {
    await channel.setViewportSize(viewportSize: viewportSize);
  }

  @override
  Future<Uint8List> screenshot({
    String? path,

    bool? fullPage,

    ElementHandleScreenshotType? type,

    int? quality,

    double? timeout,

    Map<String, dynamic>? clip,
  }) async {
    Logger.debug(
      'screenshot${path != null ? ' to "$path"' : ''}',
      name: 'playwright.page',
    );
    final result = await channel.screenshot(
      timeout: timeout ?? 30000.0,

      type: type,

      quality: quality,

      fullPage: fullPage,

      clip: clip != null ? Rect.fromJson(clip) : null,

      commonScreenshotOptions: CommonScreenshotOptions(),
    );

    final buffer = base64Decode(result.binary);

    if (path != null) {
      await File(path).writeAsBytes(buffer);
    }

    return buffer;
  }

  @override
  Future<Uint8List> pdf({
    String? path,

    PdfFormat? format,

    bool? landscape,

    double? scale,

    bool? displayHeaderFooter,

    String? headerTemplate,

    String? footerTemplate,

    bool? printBackground,

    String? pageRanges,

    PdfDimension? width,

    PdfDimension? height,

    bool? preferCSSPageSize,

    PagePdfMargin? margin,

    bool? tagged,

    bool? outline,
  }) async {
    Logger.debug(
      'pdf${path != null ? ' to "$path"' : ''}',
      name: 'playwright.page',
    );
    final result = await channel.pdf(
      format: format?.value,

      landscape: landscape,

      scale: scale,

      displayHeaderFooter: displayHeaderFooter,

      headerTemplate: headerTemplate,

      footerTemplate: footerTemplate,

      printBackground: printBackground,

      pageRanges: pageRanges,

      width: width?.toString(),

      height: height?.toString(),

      preferCSSPageSize: preferCSSPageSize,

      margin: margin,

      tagged: tagged,

      outline: outline,
    );

    final buffer = base64Decode(result.pdf);

    if (path != null) {
      await File(path).writeAsBytes(buffer);
    }

    return buffer;
  }

  @override
  Future<void> reload({double? timeout, LifecycleEvent? waitUntil}) async {
    Logger.debug('reload', name: 'playwright.page');
    await channel.reload(
      timeout: timeout ?? 30000.0,

      waitUntil: waitUntil ?? LifecycleEvent.load,
    );
  }

  @override
  Future<void> goBack({double? timeout, LifecycleEvent? waitUntil}) async {
    Logger.debug('goBack', name: 'playwright.page');
    await channel.goBack(
      timeout: timeout ?? 30000.0,

      waitUntil: waitUntil ?? LifecycleEvent.load,
    );
  }

  @override
  Future<void> goForward({double? timeout, LifecycleEvent? waitUntil}) async {
    Logger.debug('goForward', name: 'playwright.page');
    await channel.goForward(
      timeout: timeout ?? 30000.0,

      waitUntil: waitUntil ?? LifecycleEvent.load,
    );
  }

  @override
  Future<void> addInitScript(String source) async {
    await channel.addInitScript(source: source);
  }

  @override
  Future<void> close({bool? runBeforeUnload, String? reason}) async {
    Logger.debug(
      'close${reason != null ? ': $reason' : ''}',
      name: 'playwright.page',
    );
    if (runBeforeUnload == true) {
      await channel.runBeforeUnload();
    } else {
      await channel.close(reason: reason);
    }
  }

  @override
  Future<void> emulateMedia({
    Media? media,

    Scheme? colorScheme,

    Motion? reducedMotion,

    Colors? forcedColors,

    Contrast? contrast,
  }) async {
    await channel.emulateMedia(
      media: media,

      colorScheme: colorScheme,

      reducedMotion: reducedMotion,

      forcedColors: forcedColors,

      contrast: contrast,
    );
  }

  // --- Frame proxies ---

  @override
  Future<void> click(String selector, {bool? force, double? timeout}) {
    return mainFrame.click(selector, force: force, timeout: timeout);
  }

  @override
  Future<void> fill(
    String selector,

    String value, {

    bool? force,

    double? timeout,
  }) {
    return mainFrame.fill(selector, value, force: force, timeout: timeout);
  }

  @override
  Future<void> check(String selector, {bool? force, double? timeout}) {
    return mainFrame.check(selector, force: force, timeout: timeout);
  }

  @override
  Future<void> uncheck(String selector, {bool? force, double? timeout}) {
    return mainFrame.uncheck(selector, force: force, timeout: timeout);
  }

  @override
  Future<void> setChecked(
    String selector,

    bool checked, {

    bool? force,

    double? timeout,
  }) {
    return mainFrame.setChecked(
      selector,

      checked,

      force: force,

      timeout: timeout,
    );
  }

  @override
  Future<void> hover(String selector, {bool? force, double? timeout}) {
    return mainFrame.hover(selector, force: force, timeout: timeout);
  }

  @override
  Future<void> focus(String selector, {double? timeout}) {
    return mainFrame.focus(selector, timeout: timeout);
  }

  @override
  Future<void> blur(String selector, {double? timeout}) {
    return mainFrame.blur(selector, timeout: timeout);
  }

  @override
  Future<void> dblclick(String selector, {bool? force, double? timeout}) {
    return mainFrame.dblclick(selector, force: force, timeout: timeout);
  }

  @override
  Future<void> type(
    String selector,

    String text, {

    double? delay,

    double? timeout,
  }) {
    return mainFrame.type(selector, text, delay: delay, timeout: timeout);
  }

  @override
  Future<void> press(
    String selector,

    String key, {

    double? delay,

    double? timeout,
  }) {
    return mainFrame.press(selector, key, delay: delay, timeout: timeout);
  }

  @override
  Future<void> tap(String selector, {bool? force, double? timeout}) {
    return mainFrame.tap(selector, force: force, timeout: timeout);
  }

  @override
  Future<String> content() {
    return mainFrame.content();
  }

  @override
  Future<void> setContent(String html, {double? timeout}) {
    Logger.debug('setContent', name: 'playwright.page');
    return mainFrame.setContent(html, timeout: timeout);
  }

  @override
  Future<T> evalOnSelector<T>(
    String selector,

    String expression, [

    Object? arg,
  ]) {
    return mainFrame.evalOnSelector(selector, expression, arg);
  }

  @override
  Future<T> evalOnSelectorAll<T>(
    String selector,

    String expression, [

    Object? arg,
  ]) {
    return mainFrame.evalOnSelectorAll(selector, expression, arg);
  }

  @override
  Future<String?> getAttribute(
    String selector,

    String name, {

    double? timeout,
  }) {
    return mainFrame.getAttribute(selector, name, timeout: timeout);
  }

  @override
  Future<String> innerHTML(String selector, {double? timeout}) {
    return mainFrame.innerHTML(selector, timeout: timeout);
  }

  @override
  Future<String> innerText(String selector, {double? timeout}) {
    return mainFrame.innerText(selector, timeout: timeout);
  }

  @override
  Future<String> inputValue(String selector, {double? timeout}) {
    return mainFrame.inputValue(selector, timeout: timeout);
  }

  @override
  Future<bool> isChecked(String selector, {double? timeout}) {
    return mainFrame.isChecked(selector, timeout: timeout);
  }

  @override
  Future<bool> isDisabled(String selector, {double? timeout}) {
    return mainFrame.isDisabled(selector, timeout: timeout);
  }

  @override
  Future<bool> isEnabled(String selector, {double? timeout}) {
    return mainFrame.isEnabled(selector, timeout: timeout);
  }

  @override
  Future<bool> isHidden(String selector) {
    return mainFrame.isHidden(selector);
  }

  @override
  Future<bool> isVisible(String selector) {
    return mainFrame.isVisible(selector);
  }

  @override
  Future<bool> isEditable(String selector, {double? timeout}) {
    return mainFrame.isEditable(selector, timeout: timeout);
  }

  @override
  Future<void> addScriptTag({String? url, String? content, String? type}) {
    return mainFrame.addScriptTag(url: url, content: content, type: type);
  }

  @override
  Future<void> addStyleTag({String? url, String? content}) {
    return mainFrame.addStyleTag(url: url, content: content);
  }

  @override
  Future<void> waitForTimeout(double timeout) {
    return mainFrame.waitForTimeout(timeout);
  }

  @override
  Future<JSHandle> waitForFunction(
    String expression, [

    Object? arg,

    double? timeout,

    double? pollingInterval,
  ]) {
    return mainFrame.waitForFunction(
      expression,

      arg: arg,

      timeout: timeout,

      pollingInterval: pollingInterval,
    );
  }

  @override
  Future<void> dispatchEvent(
    String selector,

    String type, {

    Map<String, dynamic>? eventInit,

    double? timeout,
  }) {
    return mainFrame.dispatchEvent(
      selector,

      type,

      eventInit: eventInit,

      timeout: timeout,
    );
  }

  @override
  Future<void> highlight(String selector) {
    return mainFrame.highlight(selector);
  }

  @override
  Future<void> hideHighlight() async {
    await channel.hideHighlight();
  }

  @override
  Future<void> drop(
    String selector, {

    List<FrameDropPayloadsItems>? payloads,

    List<String>? localPaths,

    List<FrameDropDataItems>? data,

    bool? strict,

    double? timeout,
  }) {
    return mainFrame.drop(
      selector,

      payloads: payloads,

      localPaths: localPaths,

      data: data,

      strict: strict,

      timeout: timeout,
    );
  }

  @override
  Locator querySelector(String selector) {
    return mainFrame.querySelector(selector);
  }

  @override
  Future<List<Locator>> querySelectorAll(String selector) {
    return mainFrame.querySelectorAll(selector);
  }

  @override
  Future<int> queryCount(String selector) {
    return mainFrame.queryCount(selector);
  }

  @override
  Future<List<String>> selectOption(
    String selector,

    List<SelectOption>? values, {

    bool? force,

    double? timeout,
  }) {
    return mainFrame.selectOption(
      selector,

      values,

      force: force,

      timeout: timeout,
    );
  }

  @override
  Future<void> setInputFiles(
    String selector,

    List<InputFile>? files, {

    bool? noWaitAfter,

    double? timeout,
  }) {
    return mainFrame.setInputFiles(
      selector,

      files,

      noWaitAfter: noWaitAfter,

      timeout: timeout,
    );
  }

  @override
  Future<FrameAriaSnapshotResult> ariaSnapshot(
    String selector, {

    SnapshotMode? mode,

    String? track,

    int? depth,

    bool? boxes,

    double? timeout,
  }) {
    return mainFrame.ariaSnapshot(
      selector,

      mode: mode,

      track: track,

      depth: depth,

      boxes: boxes,

      timeout: timeout,
    );
  }

  @override
  Future<FrameAriaSnapshotJSONResult> ariaSnapshotJSON({
    Pattern? selector,
    SnapshotMode? mode,
    int? depth,
    bool? boxes,
    double? timeout,
  }) {
    return mainFrame.ariaSnapshotJSON(
      selector: selector,
      mode: mode,
      depth: depth,
      boxes: boxes,
      timeout: timeout,
    );
  }

  @override
  Future<ExpectResult> expect(
    String selector,

    String expression, {

    SerializedArgument? expectedValue,

    List<ExpectedTextValue>? expectedText,

    double? expectedNumber,

    bool? useInnerText,

    required bool isNot,

    double? timeout,
  }) {
    return mainFrame.expect(
      selector,

      expression,

      expectedValue: expectedValue,

      expectedText: expectedText,

      expectedNumber: expectedNumber,

      useInnerText: useInnerText,

      isNot: isNot,

      timeout: timeout,
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

  @override
  Page? opener() => typedInitializer.opener as Page?;

  @override
  Future<void> requestGC() async {
    await channel.requestGC();
  }

  @override
  Future<PageRegisterLocatorHandlerResult> registerLocatorHandler(
    Locator selector, {

    bool? noWaitAfter,
  }) async {
    return await channel.registerLocatorHandler(
      selector: selector.selector,

      noWaitAfter: noWaitAfter,
    );
  }

  @override
  Future<void> unregisterLocatorHandler(int uid) async {
    await channel.unregisterLocatorHandler(uid: uid);
  }

  // ── High-level locator handler API ────────────────────────────────────────

  final Map<String, List<_LocatorHandlerEntry>> _locatorHandlers = {};
  StreamSubscription<dynamic>? _locatorHandlerSub;

  // ── WebSocket routing API ───────────────────────────────────────────────────

  final Map<Pattern, Future<void> Function(WebSocketRoute)> _webSocketHandlers =
      {};
  StreamSubscription<dynamic>? _webSocketRouteSub;

  @override
  Future<void> addLocatorHandler(
    Locator locator,
    Future<void> Function(Locator) handler, {
    bool? noWaitAfter,
    int? times,
  }) async {
    final result = await registerLocatorHandler(
      locator,
      noWaitAfter: noWaitAfter,
    );
    final uid = result.uid;
    final entry = _LocatorHandlerEntry(
      uid: uid,
      locator: locator,
      handler: handler,
      times: times,
    );
    _locatorHandlers.putIfAbsent(locator.selector, () => []).add(entry);

    // Subscribe once to the triggered event.
    _locatorHandlerSub ??= onLocatorHandlerTriggered.listen((
      Object? uidValue,
    ) async {
      final triggeredUid = uidValue as int;
      // Find and call the matching handler.
      for (final entries in _locatorHandlers.values) {
        for (final e in entries) {
          if (e.uid == triggeredUid) {
            try {
              await e.handler(e.locator);
            } catch (_) {
              // Ignore handler errors — Playwright will see a timeout instead.
            }
            // Decrement times if limited.
            if (e.times != null) {
              e.remainingTimes = (e.remainingTimes ?? e.times!) - 1;
              final shouldRemove = e.remainingTimes! <= 0;
              await channel.resolveLocatorHandlerNoReply(
                uid: triggeredUid,
                remove: shouldRemove,
              );
              if (shouldRemove) {
                for (final list in _locatorHandlers.values) {
                  list.removeWhere((x) => x.uid == triggeredUid);
                }
              }
            } else {
              await channel.resolveLocatorHandlerNoReply(
                uid: triggeredUid,
                remove: false,
              );
            }
            return;
          }
        }
      }
      // Unknown uid — just resolve without remove.
      await channel.resolveLocatorHandlerNoReply(
        uid: triggeredUid,
        remove: false,
      );
    });
  }

  @override
  Future<void> removeLocatorHandler(Locator locator) async {
    final entries = _locatorHandlers.remove(locator.selector);
    if (entries != null) {
      for (final e in entries) {
        try {
          await unregisterLocatorHandler(e.uid);
        } catch (_) {
          // Ignore if already removed.
        }
      }
    }
  }

  @override
  Future<void> routeWebSocket(
    Pattern url,
    Future<void> Function(WebSocketRoute) handler,
  ) async {
    _webSocketHandlers[url] = handler;

    // Subscribe once to the WebSocket route event.
    _webSocketRouteSub ??= onWebSocketRoute.listen((dynamic wsRoute) async {
      final route = wsRoute as WebSocketRoute;
      final routeUrl = (route as dynamic).typedInitializer.url as String;

      // Find a matching handler.
      for (final entry in _webSocketHandlers.entries) {
        if (_matchesPattern(routeUrl, entry.key)) {
          try {
            await entry.value(route);
          } catch (_) {
            // Ignore handler errors
          }
          return;
        }
      }
    });

    // Enable WebSocket interception for this pattern.
    final pattern = _urlToPattern(url);
    await channel.setWebSocketInterceptionPatterns(patterns: [pattern]);
  }

  bool _matchesPattern(String url, Pattern pattern) {
    if (pattern is RegExp) {
      return pattern.hasMatch(url);
    } else {
      return url.contains(pattern as String);
    }
  }

  PageSetWebSocketInterceptionPatternsItems _urlToPattern(Pattern url) {
    if (url is RegExp) {
      return PageSetWebSocketInterceptionPatternsItems(
        regexSource: url.pattern,
        regexFlags: _regexFlags(url),
      );
    } else {
      return PageSetWebSocketInterceptionPatternsItems(glob: url as String);
    }
  }

  String _regexFlags(RegExp re) {
    final flags = StringBuffer();
    if (!re.isCaseSensitive) flags.write('i');
    if (re.isMultiLine) flags.write('m');
    if (re.isDotAll) flags.write('s');
    if (re.isUnicode) flags.write('u');
    return flags.toString();
  }

  @override
  Future<void> setExtraHTTPHeaders(List<NameValue> headers) async {
    await channel.setExtraHTTPHeaders(headers: headers);
  }

  @override
  Future<void> setNetworkInterceptionPatterns(
    List<PageSetNetworkInterceptionPatternsItems> patterns,
  ) async {
    await channel.setNetworkInterceptionPatterns(patterns: patterns);
  }

  @override
  Future<void> touchscreenTap(double x, double y) async {
    await channel.touchscreenTap(x: x, y: y);
  }

  @override
  Future<void> bringToFront() async {
    await channel.bringToFront();
  }

  @override
  Future<PagePickLocatorResult> pickLocator() async {
    return await channel.pickLocator();
  }

  @override
  Future<void> cancelPickLocator() async {
    await channel.cancelPickLocator();
  }

  @override
  Future<void> screencastStart({
    PageScreencastStartSize? size,

    int? quality,

    bool? sendFrames,

    bool? record,
  }) async {
    await channel.screencastStart(
      size: size,

      quality: quality,

      sendFrames: sendFrames,

      record: record,
    );
  }

  @override
  Future<void> screencastStop() async {
    await channel.screencastStop();
  }

  @override
  Future<void> setDockTile(String image) async {
    await channel.setDockTile(image: image);
  }

  // --- Console Messages ---

  @override
  Future<void> clearConsoleMessages() async {
    await channel.clearConsoleMessages();
  }

  @override
  Future<PageConsoleMessagesResult> consoleMessages({
    ConsoleMessagesFilter? filter,
  }) async {
    return await channel.consoleMessages(filter: filter);
  }

  // --- Page Errors ---

  @override
  Future<void> clearPageErrors() async {
    await channel.clearPageErrors();
  }

  @override
  Future<PagePageErrorsResult> pageErrors({
    ConsoleMessagesFilter? filter,
  }) async {
    return await channel.pageErrors(filter: filter);
  }

  // --- Requests ---

  @override
  Future<PageRequestsResult> requests() async {
    return await channel.requests();
  }

  // --- Locator Handler ---

  @override
  Future<void> resolveLocatorHandlerNoReply(int uid, {bool? remove}) async {
    await channel.resolveLocatorHandlerNoReply(uid: uid, remove: remove);
  }

  // --- Screenshot Expect ---

  @override
  Future<PageExpectScreenshotResult> expectScreenshot({
    String? expected,

    required double timeout,

    required bool isNot,

    PageExpectScreenshotLocator? locator,

    String? comparator,

    int? maxDiffPixels,

    double? maxDiffPixelRatio,

    double? threshold,

    bool? fullPage,

    Rect? clip,

    required CommonScreenshotOptions screenshotOptions,
  }) async {
    return await channel.expectScreenshot(
      expected: expected,

      timeout: timeout,

      isNot: isNot,

      locator: locator,

      comparator: comparator,

      maxDiffPixels: maxDiffPixels,

      maxDiffPixelRatio: maxDiffPixelRatio,

      threshold: threshold,

      fullPage: fullPage,

      clip: clip,

      commonScreenshotOptions: screenshotOptions,
    );
  }

  // --- WebSocket Interception ---

  @override
  Future<void> setWebSocketInterceptionPatterns(
    List<PageSetWebSocketInterceptionPatternsItems> patterns,
  ) async {
    await channel.setWebSocketInterceptionPatterns(patterns: patterns);
  }

  // --- JS/CSS Coverage ---

  @override
  Future<void> startJSCoverage({
    bool? resetOnNavigation,

    bool? reportAnonymousScripts,
  }) async {
    await channel.startJSCoverage(
      resetOnNavigation: resetOnNavigation,

      reportAnonymousScripts: reportAnonymousScripts,
    );
  }

  @override
  Future<PageStopJSCoverageResult> stopJSCoverage() async {
    return await channel.stopJSCoverage();
  }

  @override
  Future<void> startCSSCoverage({bool? resetOnNavigation}) async {
    await channel.startCSSCoverage(resetOnNavigation: resetOnNavigation);
  }

  @override
  Future<PageStopCSSCoverageResult> stopCSSCoverage() async {
    return await channel.stopCSSCoverage();
  }

  // --- Screencast ---

  @override
  Future<PageScreencastShowOverlayResult> screencastShowOverlay(
    String html, {

    double? duration,
  }) async {
    return await channel.screencastShowOverlay(html: html, duration: duration);
  }

  @override
  Future<void> screencastRemoveOverlay(String id) async {
    await channel.screencastRemoveOverlay(id: id);
  }

  @override
  Future<void> screencastChapter(
    String title, {

    String? description,

    double? duration,
  }) async {
    await channel.screencastChapter(
      title: title,

      description: description,

      duration: duration,
    );
  }

  @override
  Future<void> screencastSetOverlayVisible(bool visible) async {
    await channel.screencastSetOverlayVisible(visible: visible);
  }

  @override
  Future<void> screencastShowActions(ShowActionsOptions options) async {
    await channel.screencastShowActions(showActionsOptions: options);
  }

  @override
  Future<void> screencastHideActions() async {
    await channel.screencastHideActions();
  }

  @override
  Future<void> screencastFrameAck({
    required int frameId,
    double? timeout,
  }) async {
    await channel.screencastFrameAck(
      frameId: frameId,
      timeout: timeout,
    );
  }

  // --- Subscription ---

  @override
  Future<void> updateSubscription({
    required PageUpdateSubscriptionEvent event,

    required bool enabled,
  }) async {
    await channel.updateSubscription(event: event, enabled: enabled);
  }

  // ── Web Storage ───────────────────────────────────────────────────────────

  @override
  Future<Map<String, String>> storageItems(Kind kind) async {
    final result = await channel.webStorageItems(kind: kind);

    final items = result.items;

    return {for (final item in items) item.name: item.value};
  }

  @override
  Future<String?> storageGetItem(Kind kind, String name) async {
    final result = await channel.webStorageGetItem(kind: kind, name: name);

    return result.value;
  }

  @override
  Future<void> storageSetItem(Kind kind, String name, String value) async {
    await channel.webStorageSetItem(kind: kind, name: name, value: value);
  }

  @override
  Future<void> storageRemoveItem(Kind kind, String name) async {
    await channel.webStorageRemoveItem(kind: kind, name: name);
  }

  @override
  Future<void> storageClear(Kind kind) async {
    await channel.webStorageClear(kind: kind);
  }

  // ── Channel Method Aliases ────────────────────────────────────────────────

  @override
  Future<void> runBeforeUnload() async {
    await channel.runBeforeUnload();
  }

  @override
  Future<void> webStorageClear({required Kind kind}) async {
    await channel.webStorageClear(kind: kind);
  }

  @override
  Future<PageWebStorageGetItemResult> webStorageGetItem({
    required Kind kind,

    required String name,
  }) async {
    return await channel.webStorageGetItem(kind: kind, name: name);
  }

  @override
  Future<PageWebStorageItemsResult> webStorageItems({
    required Kind kind,
  }) async {
    return await channel.webStorageItems(kind: kind);
  }

  @override
  Future<void> webStorageRemoveItem({
    required Kind kind,

    required String name,
  }) async {
    await channel.webStorageRemoveItem(kind: kind, name: name);
  }

  @override
  Future<void> webStorageSetItem({
    required Kind kind,

    required String name,

    required String value,
  }) async {
    await channel.webStorageSetItem(kind: kind, name: name, value: value);
  }
}

class _LocatorHandlerEntry {
  final int uid;
  final Locator locator;
  final Future<void> Function(Locator) handler;
  final int? times;
  int? remainingTimes;

  _LocatorHandlerEntry({
    required this.uid,
    required this.locator,
    required this.handler,
    this.times,
  }) : remainingTimes = times;
}
