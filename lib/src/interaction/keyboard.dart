import '../core/page.dart';
import 'keyboard_key.dart';

class Keyboard {
  final Page page;

  Keyboard(this.page);

  /// Dispatches a `keydown` event.
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
  /// If [key] is a modifier key, `Shift`, `Meta`, `Control`, or `Alt`, subsequent key presses will be sent with that modifier active. To release the modifier key, use [keyboard.up()].
  ///
  /// After the key is pressed once, subsequent calls to [keyboard.down()] will have [repeat] set to true. To release the key, use [keyboard.up()].
  ///
  /// **NOTE**
  /// Modifier keys DO influence `keyboard.down`. Holding down `Shift` will type the text in upper case.
  /// **Usage**
  ///
  /// ```dart
  /// await keyboard.down(key);
  /// ```
  ///
  /// **Arguments**
  /// - `key` String
  ///
  ///   Name of the key to press or a character to generate, such as `ArrowLeft` or `a`.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> down(String key) async {
    await (page as PageImpl).channel.keyboardDown(key: key);
  }

  /// Typesafe version of [down] that accepts a [KeyboardKey] enum.
  Future<void> downKey(KeyboardKey key) async {
    /// Dispatches a `keydown` event.
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
    /// If [key] is a modifier key, `Shift`, `Meta`, `Control`, or `Alt`, subsequent key presses will be sent with that modifier active. To release the modifier key, use [keyboard.up()].
    ///
    /// After the key is pressed once, subsequent calls to [keyboard.down()] will have [repeat] set to true. To release the key, use [keyboard.up()].
    ///
    /// **NOTE**
    /// Modifier keys DO influence `keyboard.down`. Holding down `Shift` will type the text in upper case.
    /// **Usage**
    ///
    /// ```dart
    /// await keyboard.down(key);
    /// ```
    ///
    /// **Arguments**
    /// - `key` String
    ///
    ///   Name of the key to press or a character to generate, such as `ArrowLeft` or `a`.
    ///
    /// **Returns**
    /// - Future&lt;void&gt;
    await down(key.value);
  }

  /// Dispatches a `keyup` event.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await keyboard.up(key);
  /// ```
  ///
  /// **Arguments**
  /// - `key` String
  ///
  ///   Name of the key to press or a character to generate, such as `ArrowLeft` or `a`.
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
  Future<void> up(String key) async {
    await (page as PageImpl).channel.keyboardUp(key: key);
  }

  /// Typesafe version of [up] that accepts a [KeyboardKey] enum.
  Future<void> upKey(KeyboardKey key) async {
    /// Dispatches a `keyup` event.
    ///
    /// **Usage**
    ///
    /// ```dart
    /// await keyboard.up(key);
    /// ```
    ///
    /// **Arguments**
    /// - `key` String
    ///
    ///   Name of the key to press or a character to generate, such as `ArrowLeft` or `a`.
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
    await up(key.value);
  }

  /// Dispatches only `input` event, does not emit the `keydown`, `keyup` or `keypress` events.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// page.keyboard.insertText('嗨');
  /// ```
  ///
  /// **NOTE**
  /// Modifier keys DO NOT effect `keyboard.insertText`. Holding down `Shift` will not type the text in upper case.
  /// **Arguments**
  /// - `text` String
  ///
  ///   Sets input to the specified text value.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> insertText(String text) async {
    await (page as PageImpl).channel.keyboardInsertText(text: text);
  }

  /// In most cases, you should use [locator.fill()] instead. You only need to press keys one by one if there is special keyboard handling on the page - in this case use [locator.pressSequentially()].
  /// Sends a `keydown`, `keypress`/`input`, and `keyup` event for each character in the text.
  ///
  /// To press a special key, like `Control` or `ArrowDown`, use [keyboard.press()].
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await page.keyboard.type('Hello'); // Types instantly
  /// await page.keyboard.type('World', { delay: 100 ); // Types slower, like a user
  /// ```
  ///
  /// **NOTE**
  /// Modifier keys DO NOT effect `keyboard.type`. Holding down `Shift` will not type the text in upper case.
  /// **NOTE**
  /// For characters that are not on a US keyboard, only an `input` event will be sent.
  /// **Arguments**
  /// - `text` String
  ///
  ///   A text to type into a focused element.
  /// - `options` Map *(optional)*
  ///   - `delay` double *(optional)*
  ///
  ///     Time to wait between key presses in milliseconds. Defaults to 0.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> type(String text, {double? delay}) async {
    await (page as PageImpl).channel.keyboardType(text: text, delay: delay);
  }

  /// In most cases, you should use [locator.press()] instead.
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
  /// await page.keyboard.press('A');
  /// await page.screenshot( path: 'A.png' );
  /// await page.keyboard.press('ArrowLeft');
  /// await page.screenshot( path: 'ArrowLeft.png' );
  /// await page.keyboard.press('Shift+O');
  /// await page.screenshot( path: 'O.png' );
  /// await browser.close();
  /// ```
  ///
  /// Shortcut for [keyboard.down()] and [keyboard.up()].
  ///
  /// **Arguments**
  /// - `key` String
  ///
  ///   Name of the key to press or a character to generate, such as `ArrowLeft` or `a`.
  /// - `options` Map *(optional)*
  ///   - `delay` double *(optional)*
  ///
  ///     Time to wait between `keydown` and `keyup` in milliseconds. Defaults to 0.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> press(String key, {double? delay}) async {
    await (page as PageImpl).channel.keyboardPress(key: key, delay: delay);
  }

  /// Typesafe version of [press] that accepts a [KeyboardKey] enum.
  Future<void> pressKey(KeyboardKey key, {double? delay}) async {
    /// In most cases, you should use [locator.press()] instead.
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
    /// await page.keyboard.press('A');
    /// await page.screenshot( path: 'A.png' );
    /// await page.keyboard.press('ArrowLeft');
    /// await page.screenshot( path: 'ArrowLeft.png' );
    /// await page.keyboard.press('Shift+O');
    /// await page.screenshot( path: 'O.png' );
    /// await browser.close();
    /// ```
    ///
    /// Shortcut for [keyboard.down()] and [keyboard.up()].
    ///
    /// **Arguments**
    /// - `key` String
    ///
    ///   Name of the key to press or a character to generate, such as `ArrowLeft` or `a`.
    /// - `options` Map *(optional)*
    ///   - `delay` delay: *(optional)*
    ///
    ///     Time to wait between `keydown` and `keyup` in milliseconds. Defaults to 0.
    ///
    /// **Returns**
    /// - Future&lt;void&gt;
    await press(key.value, delay: delay);
  }

  // Shorthand convenience methods for common keys

  /// Presses the Enter key.
  Future<void> enter({double? delay}) async =>
      pressKey(KeyboardKey.enter, delay: delay);

  /// Presses the Escape key.
  Future<void> escape({double? delay}) async =>
      pressKey(KeyboardKey.escape, delay: delay);

  /// Presses the Backspace key.
  Future<void> backspace({double? delay}) async =>
      pressKey(KeyboardKey.backspace, delay: delay);

  /// Presses the Tab key.
  Future<void> tab({double? delay}) async =>
      pressKey(KeyboardKey.tab, delay: delay);

  /// Presses the Delete key.
  Future<void> delete({double? delay}) async =>
      pressKey(KeyboardKey.delete, delay: delay);

  /// Presses the Space key.
  Future<void> space({double? delay}) async =>
      pressKey(KeyboardKey.space, delay: delay);

  /// Presses the Up arrow key.
  Future<void> arrowUp({double? delay}) async =>
      pressKey(KeyboardKey.arrowUp, delay: delay);

  /// Presses the Down arrow key.
  Future<void> arrowDown({double? delay}) async =>
      pressKey(KeyboardKey.arrowDown, delay: delay);

  /// Presses the Left arrow key.
  Future<void> arrowLeft({double? delay}) async =>
      pressKey(KeyboardKey.arrowLeft, delay: delay);

  /// Presses the Right arrow key.
  Future<void> arrowRight({double? delay}) async =>
      pressKey(KeyboardKey.arrowRight, delay: delay);
}
