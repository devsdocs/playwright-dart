import 'playwright.dart';
import 'browser_context.dart';
import '../generated/channels.dart';
import '../utils/locator_utils.dart';

/// Selectors can be used to install custom selector engines.
class Selectors {
  final Playwright _playwright;
  final List<SelectorEngine> _registrations = [];
  String _testIdAttributeName = 'data-testid';

  Selectors(this._playwright);

  /// Selectors must be registered before creating the page.
  ///
  /// **Usage**
  ///
  /// An example of registering selector engine that queries elements based on a tag name:
  ///
  /// ```dart
  /// final { selectors, firefox } = require('@playwright/test');  // Or 'chromium' or 'webkit'.
  ///
  /// (() async {
  ///   // Must be a function that evaluates to a selector engine instance.
  ///   final createTagNameEngine = () => (
  ///     // Returns the first element matching given selector in the root's subtree.
  ///     query(root, selector) {
  ///       return root.querySelector(selector);
  ///     },
  ///
  ///     // Returns all elements matching given selector in the root's subtree.
  ///     queryAll(root, selector) {
  ///       return Array.from(root.querySelectorAll(selector));
  ///     }
  ///   );
  ///
  ///   // Register the engine. Selectors will be prefixed with "tag=".
  ///   await selectors.register('tag', createTagNameEngine);
  ///
  ///   final browser = await firefox.launch();
  ///   final page = await browser.newPage();
  ///   await page.setContent(`<div><button>Click me</button></div>`);
  ///
  ///   // Use the selector prefixed with its name.
  ///   final button = page.locator('tag=button');
  ///   // We can combine it with built-in locators.
  ///   await page.locator('tag=div').getByText('Click me').click();
  ///   // Can use it in any methods supporting selectors.
  ///   final buttonCount = await page.locator('tag=button').count();
  ///
  ///   await browser.close();
  /// }
  /// ```
  ///
  /// **Arguments**
  /// - `name` String
  ///
  ///   Name that is used in selectors as a prefix, e.g. `{name: 'foo'}` enables `foo=myselectorbody` selectors. May only contain `[a-zA-Z0-9_]` characters.
  /// - `script` String
  ///   - `path` String *(optional)*
  ///
  ///     Path to the JavaScript file. If `path` is a relative path, then it is resolved relative to the current working directory. Optional.
  ///   - `content` String *(optional)*
  ///
  ///     Raw script content. Optional.
  ///
  ///   Script that evaluates to a selector engine instance. The script is evaluated in the page context.
  /// - `options` Map *(optional)*
  ///   - `contentScript` bool *(optional)*
  ///
  ///     Whether to run this selector engine in isolated JavaScript environment. This environment has access to the same DOM, but not any JavaScript objects from the frame's scripts. Defaults to `false`. Note that running as a content script is not guaranteed when this engine is used together with other registered engines.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> register(
    String name,
    String script, {
    bool contentScript = false,
  }) async {
    final engine = SelectorEngine(
      name: name,
      source: script,
      contentScript: contentScript,
    );
    _registrations.add(engine);
    for (final context
        in (_playwright as PlaywrightImpl).connection.objects.values
            .whereType<BrowserContext>()) {
      await (context as BrowserContextImpl).channel.registerSelectorEngine(
        selectorEngine: engine,
      );
    }
  }

  /// Defines custom attribute name to be used in [page.getByTestId()]. `data-testid` is used by default.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// selectors.setTestIdAttribute(attributeName);
  /// ```
  ///
  /// **Arguments**
  /// - `attributeName` String
  ///
  ///   Test id attribute name. To match elements with any of several attributes, pass them as a comma-separated list, e.g. `"data-pw,data-ti"`.
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
  Future<void> setTestIdAttribute(String name) async {
    _testIdAttributeName = name;
    setTestIdAttributeName(name);
    for (final context
        in (_playwright as PlaywrightImpl).connection.objects.values
            .whereType<BrowserContext>()) {
      await (context as BrowserContextImpl).channel.setTestIdAttributeName(
        testIdAttributeName: name,
      );
    }
  }

  /// Internal method called by [Browser.newContext] when a new [BrowserContext]
  /// is created.
  ///
  /// Applies any pending testId attribute name and registered selector engines
  /// to the freshly-created context **before** it is returned to the caller,
  /// so that every operation on the new context already uses the correct
  /// configuration.
  Future<void> addContext(BrowserContext context) async {
    if (_testIdAttributeName != 'data-testid') {
      // Must be awaited so the attribute is in effect before the context is used.
      await (context as BrowserContextImpl).channel.setTestIdAttributeName(
        testIdAttributeName: _testIdAttributeName,
      );
    }
    for (final engine in _registrations) {
      await (context as BrowserContextImpl).channel.registerSelectorEngine(
        selectorEngine: engine,
      );
    }
  }
}
