import 'element_handle.dart';
import '../generated/channels.dart';
import '../infrastructure/serialization.dart';
// Re-exports Node, Element, etc. from package:html/dom.dart
import '../infrastructure/html_node.dart';

/// A handle to a JavaScript value in the browser page.
///
/// The optional type parameter [T] mirrors the TypeScript SDK's
/// `JSHandle<T = any>` generic.  It acts as a phantom type that carries
/// information about the underlying JS value without impacting runtime
/// behaviour.
///
/// When [T] is [Node] or a subtype (e.g. [Element]) the handle wraps a DOM
/// node, and [asElement] will return a non-null [ElementHandle].
///
/// ```dart
/// // Untyped handle (equivalent to JSHandle<any>):
/// final handle = await page.evaluateHandle('() => window');
///
/// // Typed as an Element handle:
/// final JSHandle<Element> el =
///     await frame.evaluateHandle('() => document.body');
/// final element = el.asElement(); // non-null because T <: Node
/// ```
abstract interface class JSHandle<T extends Object?> {
  Stream<dynamic> get onPreviewUpdated;

  /// Returns the return value of [pageFunction].
  ///
  /// This method passes this handle as the first argument to [pageFunction].
  ///
  /// If [pageFunction] returns a Future, then `handle.evaluate` would wait for the future to complete and return its value.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// final tweetHandle = await page.$('.tweet .retweets');
  /// expect(await tweetHandle.evaluate((node) => node.innerText)).toBe('10 retweets');
  /// ```
  ///
  /// **Arguments**
  /// - `pageFunction` Function | String
  ///
  ///   Function to be evaluated in the page context.
  /// - `arg` dynamic *(optional)*
  ///
  ///   Optional argument to pass to [pageFunction].
  ///
  /// **Returns**
  /// - Future&lt;[Serializable]&gt;
  Future<dynamic> evaluate(String expression, [Object? arg, bool? isFunction]);

  /// Returns the return value of [pageFunction] as a [JSHandle].
  ///
  /// This method passes this handle as the first argument to [pageFunction].
  ///
  /// The only difference between `jsHandle.evaluate` and `jsHandle.evaluateHandle` is that `jsHandle.evaluateHandle` returns [JSHandle].
  ///
  /// If the function passed to the `jsHandle.evaluateHandle` returns a Future, then `jsHandle.evaluateHandle` would wait for the future to complete and return its value.
  ///
  /// See [page.evaluateHandle()] for more details.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await jsHandle.evaluateHandle(pageFunction);
  /// await jsHandle.evaluateHandle(pageFunction, arg);
  /// ```
  ///
  /// **Arguments**
  /// - `pageFunction` Function | String
  ///
  ///   Function to be evaluated in the page context.
  /// - `arg` dynamic *(optional)*
  ///
  ///   Optional argument to pass to [pageFunction].
  ///
  /// **Returns**
  /// - Future&lt;[JSHandle]&gt;
  Future<JSHandle<Object?>> evaluateHandle(
    String expression, [
    Object? arg,
    bool? isFunction,
  ]);
  Future<dynamic> evaluateExpression(
    String expression, [
    Object? arg,
    bool? isFunction,
  ]);
  Future<JSHandle<Object?>> evaluateExpressionHandle(
    String expression, [
    Object? arg,
    bool? isFunction,
  ]);

  /// Fetches a single property from the referenced object.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await jsHandle.getProperty(propertyName);
  /// ```
  ///
  /// **Arguments**
  /// - `propertyName` String
  ///
  ///   property to get
  ///
  /// **Returns**
  /// - Future&lt;[JSHandle]&gt;
  Future<JSHandle<Object?>> getProperty(String name);

  /// The method returns a map with **own property names** as keys and JSHandle instances for the property values.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// final handle = await page.evaluateHandle(() => ( window, document ));
  /// final properties = await handle.getProperties();
  /// final windowHandle = properties.get('window');
  /// final documentHandle = properties.get('document');
  /// await handle.dispose();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;[Map]&lt;String, [JSHandle]&gt;&gt;
  Future<Map<String, JSHandle<Object?>>> getProperties();
  Future<Map<String, JSHandle<Object?>>> getPropertyList();

  /// Returns a JSON representation of the object. If the object has a `toJSON` function, it **will not be called**.
  ///
  /// **NOTE**
  /// The method will return an empty JSON object if the referenced object is not stringifiable. It will throw an error if the object has circular references.
  /// **Usage**
  ///
  /// ```dart
  /// await jsHandle.jsonValue();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;[Serializable]&gt;
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
  Future<dynamic> jsonValue();

  /// Returns either `null` or the object handle itself, if the object handle is an instance of [ElementHandle].
  ///
  /// **Usage**
  ///
  /// ```dart
  /// jsHandle.asElement();
  /// ```
  ///
  /// **Returns**
  /// - [ElementHandle]?
  ElementHandle<Node>? asElement();

  /// The `jsHandle.dispose` method stops referencing the element handle.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await jsHandle.dispose();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> dispose();
}

class JSHandleImpl<T extends Object?> extends JSHandleBase
    implements JSHandle<T> {
  @override
  Future<void> dispose() async {
    await channel.dispose();
  }

  @override
  ElementHandle<Node>? asElement() =>
      this is ElementHandle<Node> ? this as ElementHandle<Node> : null;

  @override
  Stream<dynamic> get onPreviewUpdated {
    return onEvent
        .where((e) => e['event'] == 'previewUpdated')
        .map((e) => e['params']['preview']);
  }

  JSHandleImpl(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  @override
  Future<dynamic> evaluate(
    String expression, [
    Object? arg,
    bool? isFunction,
  ]) async {
    final result = await channel.evaluateExpression(
      expression: expression,
      arg: serializeArgument(arg),
      isFunction: isFunction,
    );
    return parseSerializedValue(result.value);
  }

  @override
  Future<JSHandle<Object?>> evaluateHandle(
    String expression, [
    Object? arg,
    bool? isFunction,
  ]) async {
    final result = await channel.evaluateExpressionHandle(
      expression: expression,
      arg: serializeArgument(arg),
      isFunction: isFunction,
    );
    return result.handle as JSHandle<Object?>;
  }

  @override
  Future<dynamic> evaluateExpression(
    String expression, [
    Object? arg,
    bool? isFunction,
  ]) => evaluate(expression, arg, isFunction);

  @override
  Future<JSHandle<Object?>> evaluateExpressionHandle(
    String expression, [
    Object? arg,
    bool? isFunction,
  ]) => evaluateHandle(expression, arg, isFunction);

  @override
  Future<JSHandle<Object?>> getProperty(String name) async {
    final result = await super.channel.getProperty(name: name);
    return result.handle as JSHandle<Object?>;
  }

  @override
  Future<Map<String, JSHandle<Object?>>> getProperties() async {
    final result = await super.channel.getPropertyList();
    final map = <String, JSHandle<Object?>>{};
    for (final property in result.properties) {
      map[property.name] = property.value as JSHandle<Object?>;
    }
    return map;
  }

  @override
  Future<Map<String, JSHandle<Object?>>> getPropertyList() => getProperties();

  @override
  Future<dynamic> jsonValue() async {
    final result = await super.channel.jsonValue();
    return parseSerializedValue(result.value);
  }
}
