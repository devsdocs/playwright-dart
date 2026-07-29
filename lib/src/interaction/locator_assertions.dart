import '../core/frame.dart';
import '../core/locator.dart';
import '../generated/channels.dart';
import '../infrastructure/serialization.dart';

class LocatorAssertions {
  final Locator _locator;
  final bool _isNot;
  final double? _timeout;

  LocatorAssertions(this._locator, [this._isNot = false, this._timeout]);

  /// Makes the assertion check for the opposite condition.
  ///
  /// **Usage**
  ///
  /// For example, this code tests that the Locator doesn't contain text `"error"`:
  ///
  /// ```dart
  /// await expect(locator).not.toContainText('error');
  /// ```
  ///
  /// **Type**
  /// - [LocatorAssertions]
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
  LocatorAssertions get not => LocatorAssertions(_locator, !_isNot, _timeout);

  /// Ensures that [Locator] points to an attached and [visible] DOM node.
  ///
  /// To check that at least one element from the list is visible, use [locator.first()].
  ///
  /// **Usage**
  ///
  /// ```dart
  /// // A specific element is visible.
  /// await expect(page.getByText('Welcome')).toBeVisible();
  ///
  /// // At least one item in the list is visible.
  /// await expect(page.getByTestId('todo-item').first()).toBeVisible();
  ///
  /// // At least one of the two elements is visible, possibly both.
  /// await expect(
  ///     page.getByRole('button', { name: 'Sign in' )
  ///         .or(page.getByRole('button', { name: 'Sign up' ))
  ///         .first()
  /// ).toBeVisible();
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     An optional [`AbortSignal`] that can cancel the assertion. Aborting the signal fails the assertion like a timeout: if the signal is aborted while the assertion is retrying, or is already aborted before the assertion starts, the assertion fails without retrying further.
  ///   - `timeout` double *(optional)*
  ///
  ///     Time to retry the assertion for in milliseconds. Defaults to `timeout` in `TestConfig.expect`.
  ///   - `visible` bool *(optional)*
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> toBeVisible({double? timeout}) async {
    await (_locator.frame as FrameImpl).channel.expect(
      selector: _locator.selector,
      expression: 'to.be.visible',
      isNot: _isNot,
      timeout: timeout ?? _timeout ?? 5000.0,
    );
  }

  /// Ensures that [Locator] either does not resolve to any DOM node, or resolves to a [non-visible] one.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// final locator = page.locator('.my-element');
  /// await expect(locator).toBeHidden();
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     An optional [`AbortSignal`] that can cancel the assertion. Aborting the signal fails the assertion like a timeout: if the signal is aborted while the assertion is retrying, or is already aborted before the assertion starts, the assertion fails without retrying further.
  ///   - `timeout` double *(optional)*
  ///
  ///     Time to retry the assertion for in milliseconds. Defaults to `timeout` in `TestConfig.expect`.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> toBeHidden({double? timeout}) async {
    await (_locator.frame as FrameImpl).channel.expect(
      selector: _locator.selector,
      expression: 'to.be.hidden',
      isNot: _isNot,
      timeout: timeout ?? _timeout ?? 5000.0,
    );
  }

  /// Ensures the [Locator] points to an element with the given text. All nested elements will be considered when computing the text content of the element. You can use regular expressions for the value as well.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// final locator = page.locator('.title');
  /// await expect(locator).toHaveText(/Welcome, Test User/);
  /// await expect(locator).toHaveText(/Welcome, .*/);
  /// ```
  ///
  /// If you pass an array as an expected value, the expectations are:
  /// 1. Locator resolves to a list of elements.
  /// 1. The number of elements equals the number of expected values in the array.
  /// 1. Elements from the list have text matching expected array values, one by one, in order.
  ///
  /// For example, consider the following list:
  ///
  /// ```html
  /// <ul>
  ///   <li>Text 1</li>
  ///   <li>Text 2</li>
  ///   <li>Text 3</li>
  /// </ul>
  /// ```
  ///
  /// Let's see how we can use the assertion:
  ///
  /// ```dart
  /// // ✓ Has the right items in the right order
  /// await expect(page.locator('ul > li')).toHaveText(['Text 1', 'Text 2', 'Text 3']);
  ///
  /// // ✖ Wrong order
  /// await expect(page.locator('ul > li')).toHaveText(['Text 3', 'Text 2', 'Text 1']);
  ///
  /// // ✖ Last item does not match
  /// await expect(page.locator('ul > li')).toHaveText(['Text 1', 'Text 2', 'Text']);
  ///
  /// // ✖ Locator points to the outer list element, not to the list items
  /// await expect(page.locator('ul')).toHaveText(['Text 1', 'Text 2', 'Text 3']);
  /// ```
  ///
  /// **Arguments**
  /// - `expected` String
  ///
  ///   Expected string or RegExp or a list of those.
  /// - `options` Map *(optional)*
  ///   - `ignoreCase` bool *(optional)*
  ///
  ///     Whether to perform case-insensitive match. [ignoreCase] option takes precedence over the corresponding regular expression flag if specified.
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     An optional [`AbortSignal`] that can cancel the assertion. Aborting the signal fails the assertion like a timeout: if the signal is aborted while the assertion is retrying, or is already aborted before the assertion starts, the assertion fails without retrying further.
  ///   - `timeout` double *(optional)*
  ///
  ///     Time to retry the assertion for in milliseconds. Defaults to `timeout` in `TestConfig.expect`.
  ///   - `useInnerText` bool *(optional)*
  ///
  ///     Whether to use `element.innerText` instead of `element.textContent` when retrieving DOM node text.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  ///
  /// **Details**
  ///
  /// When `expected` parameter is a string, Playwright will normalize whitespaces and line breaks both in the actual text and in the expected string before matching. When regular expression is used, the actual text is matched as is.
  Future<void> toHaveText(
    String expected, {
    double? timeout,
    bool useInnerText = false,
  }) async {
    await (_locator.frame as FrameImpl).channel.expect(
      selector: _locator.selector,
      expression: 'to.have.text',
      expectedText: [
        ExpectedTextValue(string: expected, matchSubstring: false),
      ],
      isNot: _isNot,
      timeout: timeout ?? _timeout ?? 5000.0,
      useInnerText: useInnerText,
    );
  }

  /// Ensures the [Locator] points to an element that contains the given text. All nested elements will be considered when computing the text content of the element. You can use regular expressions for the value as well.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// final locator = page.locator('.title');
  /// await expect(locator).toContainText('substring');
  /// await expect(locator).toContainText(/\d messages/);
  /// ```
  ///
  /// If you pass an array as an expected value, the expectations are:
  /// 1. Locator resolves to a list of elements.
  /// 1. Elements from a **subset** of this list contain text from the expected array, respectively.
  /// 1. The matching subset of elements has the same order as the expected array.
  /// 1. Each text value from the expected array is matched by some element from the list.
  ///
  /// For example, consider the following list:
  ///
  /// ```html
  /// <ul>
  ///   <li>Item Text 1</li>
  ///   <li>Item Text 2</li>
  ///   <li>Item Text 3</li>
  /// </ul>
  /// ```
  ///
  /// Let's see how we can use the assertion:
  ///
  /// ```dart
  /// // ✓ Contains the right items in the right order
  /// await expect(page.locator('ul > li')).toContainText(['Text 1', 'Text 3']);
  ///
  /// // ✖ Wrong order
  /// await expect(page.locator('ul > li')).toContainText(['Text 3', 'Text 2']);
  ///
  /// // ✖ No item contains this text
  /// await expect(page.locator('ul > li')).toContainText(['Some 33']);
  ///
  /// // ✖ Locator points to the outer list element, not to the list items
  /// await expect(page.locator('ul')).toContainText(['Text 3']);
  /// ```
  ///
  /// **Arguments**
  /// - `expected` String
  ///
  ///   Expected substring or RegExp or a list of those.
  /// - `options` Map *(optional)*
  ///   - `ignoreCase` bool *(optional)*
  ///
  ///     Whether to perform case-insensitive match. [ignoreCase] option takes precedence over the corresponding regular expression flag if specified.
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     An optional [`AbortSignal`] that can cancel the assertion. Aborting the signal fails the assertion like a timeout: if the signal is aborted while the assertion is retrying, or is already aborted before the assertion starts, the assertion fails without retrying further.
  ///   - `timeout` double *(optional)*
  ///
  ///     Time to retry the assertion for in milliseconds. Defaults to `timeout` in `TestConfig.expect`.
  ///   - `useInnerText` bool *(optional)*
  ///
  ///     Whether to use `element.innerText` instead of `element.textContent` when retrieving DOM node text.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  ///
  /// **Details**
  ///
  /// When `expected` parameter is a string, Playwright will normalize whitespaces and line breaks both in the actual text and in the expected string before matching. When regular expression is used, the actual text is matched as is.
  Future<void> toContainText(
    String expected, {
    double? timeout,
    bool useInnerText = false,
  }) async {
    await (_locator.frame as FrameImpl).channel.expect(
      selector: _locator.selector,
      expression: 'to.have.text',
      expectedText: [ExpectedTextValue(string: expected, matchSubstring: true)],
      isNot: _isNot,
      timeout: timeout ?? _timeout ?? 5000.0,
      useInnerText: useInnerText,
    );
  }

  /// Ensures the [Locator] points to an enabled element.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// final locator = page.locator('button.submit');
  /// await expect(locator).toBeEnabled();
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `enabled` bool *(optional)*
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     An optional [`AbortSignal`] that can cancel the assertion. Aborting the signal fails the assertion like a timeout: if the signal is aborted while the assertion is retrying, or is already aborted before the assertion starts, the assertion fails without retrying further.
  ///   - `timeout` double *(optional)*
  ///
  ///     Time to retry the assertion for in milliseconds. Defaults to `timeout` in `TestConfig.expect`.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> toBeEnabled({double? timeout}) async {
    await (_locator.frame as FrameImpl).channel.expect(
      selector: _locator.selector,
      expression: 'to.be.enabled',
      isNot: _isNot,
      timeout: timeout ?? _timeout ?? 5000.0,
    );
  }

  /// Ensures the [Locator] points to a disabled element. Element is disabled if it has "disabled" attribute or is disabled via ['aria-disabled']. Note that only native control elements such as HTML `button`, `input`, `select`, `textarea`, `option`, `optgroup` can be disabled by setting "disabled" attribute. "disabled" attribute on other elements is ignored by the browser.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// final locator = page.locator('button.submit');
  /// await expect(locator).toBeDisabled();
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     An optional [`AbortSignal`] that can cancel the assertion. Aborting the signal fails the assertion like a timeout: if the signal is aborted while the assertion is retrying, or is already aborted before the assertion starts, the assertion fails without retrying further.
  ///   - `timeout` double *(optional)*
  ///
  ///     Time to retry the assertion for in milliseconds. Defaults to `timeout` in `TestConfig.expect`.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> toBeDisabled({double? timeout}) async {
    await (_locator.frame as FrameImpl).channel.expect(
      selector: _locator.selector,
      expression: 'to.be.disabled',
      isNot: _isNot,
      timeout: timeout ?? _timeout ?? 5000.0,
    );
  }

  /// Ensures the [Locator] points to an element with given attribute. The method will assert attribute presence.
  ///
  /// ```dart
  /// final locator = page.locator('input');
  /// // Assert attribute existence.
  /// await expect(locator).toHaveAttribute('disabled');
  /// await expect(locator).not.toHaveAttribute('open');
  /// ```
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await expect(locator).toHaveAttribute(name);
  /// await expect(locator).toHaveAttribute(name, options);
  /// ```
  ///
  /// **Arguments**
  /// - `name` String
  ///
  ///   Attribute name.
  /// - `options` Map *(optional)*
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     An optional [`AbortSignal`] that can cancel the assertion. Aborting the signal fails the assertion like a timeout: if the signal is aborted while the assertion is retrying, or is already aborted before the assertion starts, the assertion fails without retrying further.
  ///   - `timeout` double *(optional)*
  ///
  ///     Time to retry the assertion for in milliseconds. Defaults to `timeout` in `TestConfig.expect`.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> toHaveAttribute(
    String name,
    String value, {
    double? timeout,
  }) async {
    await (_locator.frame as FrameImpl).channel.expect(
      selector: _locator.selector,
      expression: 'to.have.attribute',
      expressionArg: name,
      expectedText: [ExpectedTextValue(string: value, matchSubstring: false)],
      isNot: _isNot,
      timeout: timeout ?? _timeout ?? 5000.0,
    );
  }

  /// Ensures the [Locator] points to an element with given CSS classes. When a string is provided, it must fully match the element's `class` attribute. To match individual classes use [expect(locator).toContainClass()].
  ///
  /// **Usage**
  ///
  /// ```html
  /// <div class='middle selected row' id='component'></div>
  /// ```
  ///
  /// ```dart
  /// final locator = page.locator('#component');
  /// await expect(locator).toHaveClass('middle selected row');
  /// await expect(locator).toHaveClass(/(^|\s)selected(\s|$)/);
  /// ```
  ///
  /// When an array is passed, the method asserts that the list of elements located matches the corresponding list of expected class values. Each element's class attribute is matched against the corresponding string or regular expression in the array:
  ///
  /// ```dart
  /// final locator = page.locator('.list > .component');
  /// await expect(locator).toHaveClass(['component', 'component selected', 'component']);
  /// ```
  ///
  /// **Arguments**
  /// - `expected` String
  ///
  ///   Expected class or RegExp or a list of those.
  /// - `options` Map *(optional)*
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     An optional [`AbortSignal`] that can cancel the assertion. Aborting the signal fails the assertion like a timeout: if the signal is aborted while the assertion is retrying, or is already aborted before the assertion starts, the assertion fails without retrying further.
  ///   - `timeout` double *(optional)*
  ///
  ///     Time to retry the assertion for in milliseconds. Defaults to `timeout` in `TestConfig.expect`.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> toHaveClass(String expected, {double? timeout}) async {
    await (_locator.frame as FrameImpl).channel.expect(
      selector: _locator.selector,
      expression: 'to.have.class',
      expectedText: [
        ExpectedTextValue(string: expected, matchSubstring: false),
      ],
      isNot: _isNot,
      timeout: timeout ?? _timeout ?? 5000.0,
    );
  }

  /// Ensures the [Locator] points to an element with the given DOM Node ID.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// final locator = page.getByRole('textbox');
  /// await expect(locator).toHaveId('lastname');
  /// ```
  ///
  /// **Arguments**
  /// - `id` String | [RegExp]
  ///
  ///   Element id.
  /// - `options` Map *(optional)*
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     An optional [`AbortSignal`] that can cancel the assertion. Aborting the signal fails the assertion like a timeout: if the signal is aborted while the assertion is retrying, or is already aborted before the assertion starts, the assertion fails without retrying further.
  ///   - `timeout` double *(optional)*
  ///
  ///     Time to retry the assertion for in milliseconds. Defaults to `timeout` in `TestConfig.expect`.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> toHaveId(String expected, {double? timeout}) async {
    await (_locator.frame as FrameImpl).channel.expect(
      selector: _locator.selector,
      expression: 'to.have.id',
      expectedText: [
        ExpectedTextValue(string: expected, matchSubstring: false),
      ],
      isNot: _isNot,
      timeout: timeout ?? _timeout ?? 5000.0,
    );
  }

  /// Ensures the [Locator] points to an element with the given input value. You can use regular expressions for the value as well.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// final locator = page.locator('input[type=number]');
  /// await expect(locator).toHaveValue(/[0-9]/);
  /// ```
  ///
  /// **Arguments**
  /// - `value` String | [RegExp]
  ///
  ///   Expected value.
  /// - `options` Map *(optional)*
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     An optional [`AbortSignal`] that can cancel the assertion. Aborting the signal fails the assertion like a timeout: if the signal is aborted while the assertion is retrying, or is already aborted before the assertion starts, the assertion fails without retrying further.
  ///   - `timeout` double *(optional)*
  ///
  ///     Time to retry the assertion for in milliseconds. Defaults to `timeout` in `TestConfig.expect`.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> toHaveValue(String expected, {double? timeout}) async {
    await (_locator.frame as FrameImpl).channel.expect(
      selector: _locator.selector,
      expression: 'to.have.value',
      expectedText: [
        ExpectedTextValue(string: expected, matchSubstring: false),
      ],
      isNot: _isNot,
      timeout: timeout ?? _timeout ?? 5000.0,
    );
  }

  /// Ensures the [Locator] points to a checked input.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// final locator = page.getByLabel('Subscribe to newsletter');
  /// await expect(locator).toBeChecked();
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `checked` bool *(optional)*
  ///
  ///     Provides state to assert for. Asserts for input to be checked by default. This option can't be used when [indeterminate] is set to true.
  ///   - `indeterminate` bool *(optional)*
  ///
  ///     Asserts that the element is in the indeterminate (mixed) state. Only supported for checkboxes and radio buttons. This option can't be true when [checked] is provided.
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     An optional [`AbortSignal`] that can cancel the assertion. Aborting the signal fails the assertion like a timeout: if the signal is aborted while the assertion is retrying, or is already aborted before the assertion starts, the assertion fails without retrying further.
  ///   - `timeout` double *(optional)*
  ///
  ///     Time to retry the assertion for in milliseconds. Defaults to `timeout` in `TestConfig.expect`.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> toBeChecked({
    bool? checked,
    bool? indeterminate,
    double? timeout,
  }) async {
    final Map<String, dynamic> expectedValueMap = {};
    if (checked != null) expectedValueMap['checked'] = checked;
    if (indeterminate != null) {
      expectedValueMap['indeterminate'] = indeterminate;
    }

    await (_locator.frame as FrameImpl).channel.expect(
      selector: _locator.selector,
      expression: 'to.be.checked',
      expectedValue: expectedValueMap.isNotEmpty
          ? serializeArgument(expectedValueMap)
          : null,
      isNot: _isNot,
      timeout: timeout ?? _timeout ?? 5000.0,
    );
  }

  /// Ensures that [Locator] points to an element that is [connected] to a Document or a ShadowRoot.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await expect(page.getByText('Hidden text')).toBeAttached();
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `attached` bool *(optional)*
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     An optional [`AbortSignal`] that can cancel the assertion. Aborting the signal fails the assertion like a timeout: if the signal is aborted while the assertion is retrying, or is already aborted before the assertion starts, the assertion fails without retrying further.
  ///   - `timeout` double *(optional)*
  ///
  ///     Time to retry the assertion for in milliseconds. Defaults to `timeout` in `TestConfig.expect`.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> toBeAttached({bool? attached, double? timeout}) async {
    await (_locator.frame as FrameImpl).channel.expect(
      selector: _locator.selector,
      expression: 'to.be.attached',
      expectedValue: attached != null ? serializeArgument(attached) : null,
      isNot: _isNot,
      timeout: timeout ?? _timeout ?? 5000.0,
    );
  }

  /// Ensures the [Locator] points to an editable element.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// final locator = page.getByRole('textbox');
  /// await expect(locator).toBeEditable();
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `editable` bool *(optional)*
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     An optional [`AbortSignal`] that can cancel the assertion. Aborting the signal fails the assertion like a timeout: if the signal is aborted while the assertion is retrying, or is already aborted before the assertion starts, the assertion fails without retrying further.
  ///   - `timeout` double *(optional)*
  ///
  ///     Time to retry the assertion for in milliseconds. Defaults to `timeout` in `TestConfig.expect`.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> toBeEditable({bool? editable, double? timeout}) async {
    await (_locator.frame as FrameImpl).channel.expect(
      selector: _locator.selector,
      expression: 'to.be.editable',
      expectedValue: editable != null ? serializeArgument(editable) : null,
      isNot: _isNot,
      timeout: timeout ?? _timeout ?? 5000.0,
    );
  }

  /// Ensures the [Locator] points to an empty editable element or to a DOM node that has no text.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// final locator = page.locator('div.warning');
  /// await expect(locator).toBeEmpty();
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     An optional [`AbortSignal`] that can cancel the assertion. Aborting the signal fails the assertion like a timeout: if the signal is aborted while the assertion is retrying, or is already aborted before the assertion starts, the assertion fails without retrying further.
  ///   - `timeout` double *(optional)*
  ///
  ///     Time to retry the assertion for in milliseconds. Defaults to `timeout` in `TestConfig.expect`.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> toBeEmpty({double? timeout}) async {
    await (_locator.frame as FrameImpl).channel.expect(
      selector: _locator.selector,
      expression: 'to.be.empty',
      isNot: _isNot,
      timeout: timeout ?? _timeout ?? 5000.0,
    );
  }

  /// Ensures the [Locator] points to a focused DOM node.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// final locator = page.getByRole('textbox');
  /// await expect(locator).toBeFocused();
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     An optional [`AbortSignal`] that can cancel the assertion. Aborting the signal fails the assertion like a timeout: if the signal is aborted while the assertion is retrying, or is already aborted before the assertion starts, the assertion fails without retrying further.
  ///   - `timeout` double *(optional)*
  ///
  ///     Time to retry the assertion for in milliseconds. Defaults to `timeout` in `TestConfig.expect`.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> toBeFocused({double? timeout}) async {
    await (_locator.frame as FrameImpl).channel.expect(
      selector: _locator.selector,
      expression: 'to.be.focused',
      isNot: _isNot,
      timeout: timeout ?? _timeout ?? 5000.0,
    );
  }

  /// Ensures the [Locator] points to an element that intersects viewport, according to the [intersection observer API].
  ///
  /// **Usage**
  ///
  /// ```dart
  /// final locator = page.getByRole('button');
  /// // Make sure at least some part of element intersects viewport.
  /// await expect(locator).toBeInViewport();
  /// // Make sure element is fully outside of viewport.
  /// await expect(locator).not.toBeInViewport();
  /// // Make sure that at least half of the element intersects viewport.
  /// await expect(locator).toBeInViewport( ratio: 0.5 );
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `ratio` double *(optional)*
  ///
  ///     The minimal ratio of the element to intersect viewport. If equals to `0`, then element should intersect viewport at any positive ratio. Defaults to `0`.
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     An optional [`AbortSignal`] that can cancel the assertion. Aborting the signal fails the assertion like a timeout: if the signal is aborted while the assertion is retrying, or is already aborted before the assertion starts, the assertion fails without retrying further.
  ///   - `timeout` double *(optional)*
  ///
  ///     Time to retry the assertion for in milliseconds. Defaults to `timeout` in `TestConfig.expect`.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> toBeInViewport({double? ratio, double? timeout}) async {
    await (_locator.frame as FrameImpl).channel.expect(
      selector: _locator.selector,
      expression: 'to.be.in.viewport',
      expectedNumber: ratio,
      isNot: _isNot,
      timeout: timeout ?? _timeout ?? 5000.0,
    );
  }

  /// Ensures the [Locator] points to an element with given CSS classes. All classes from the asserted value, separated by spaces, must be present in the [Element.classList] in any order.
  ///
  /// **Usage**
  ///
  /// ```html
  /// <div class='middle selected row' id='component'></div>
  /// ```
  ///
  /// ```dart
  /// final locator = page.locator('#component');
  /// await expect(locator).toContainClass('middle selected row');
  /// await expect(locator).toContainClass('selected');
  /// await expect(locator).toContainClass('row middle');
  /// ```
  ///
  /// When an array is passed, the method asserts that the list of elements located matches the corresponding list of expected class lists. Each element's class attribute is matched against the corresponding class in the array:
  ///
  /// ```html
  /// <div class='list'>
  ///   <div class='component inactive'></div>
  ///   <div class='component active'></div>
  ///   <div class='component inactive'></div>
  /// </div>
  /// ```
  ///
  /// ```dart
  /// final locator = page.locator('.list > .component');
  /// await expect(locator).toContainClass(['inactive', 'active', 'inactive']);
  /// ```
  ///
  /// **Arguments**
  /// - `expected` Object
  ///
  ///   A string containing expected class names, separated by spaces, or a list of such strings to assert multiple elements.
  /// - `options` Map *(optional)*
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     An optional [`AbortSignal`] that can cancel the assertion. Aborting the signal fails the assertion like a timeout: if the signal is aborted while the assertion is retrying, or is already aborted before the assertion starts, the assertion fails without retrying further.
  ///   - `timeout` double *(optional)*
  ///
  ///     Time to retry the assertion for in milliseconds. Defaults to `timeout` in `TestConfig.expect`.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> toContainClass(Object expected, {double? timeout}) async {
    final expectedText = expected is List
        ? expected
              .map(
                (e) => ExpectedTextValue(
                  string: e.toString(),
                  matchSubstring: false,
                ),
              )
              .toList()
        : [
            ExpectedTextValue(
              string: expected.toString(),
              matchSubstring: false,
            ),
          ];

    await (_locator.frame as FrameImpl).channel.expect(
      selector: _locator.selector,
      expression: 'to.contain.class',
      expectedText: expectedText,
      isNot: _isNot,
      timeout: timeout ?? _timeout ?? 5000.0,
    );
  }

  /// Ensures the [Locator] points to an element with a given [accessible description].
  ///
  /// **Usage**
  ///
  /// ```dart
  /// final locator = page.getByTestId('save-button');
  /// await expect(locator).toHaveAccessibleDescription('Save results to disk');
  /// ```
  ///
  /// **Arguments**
  /// - `description` String
  ///
  ///   Expected accessible description.
  /// - `options` Map *(optional)*
  ///   - `ignoreCase` bool *(optional)*
  ///
  ///     Whether to perform case-insensitive match. [ignoreCase] option takes precedence over the corresponding regular expression flag if specified.
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     An optional [`AbortSignal`] that can cancel the assertion. Aborting the signal fails the assertion like a timeout: if the signal is aborted while the assertion is retrying, or is already aborted before the assertion starts, the assertion fails without retrying further.
  ///   - `timeout` double *(optional)*
  ///
  ///     Time to retry the assertion for in milliseconds. Defaults to `timeout` in `TestConfig.expect`.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> toHaveAccessibleDescription(
    String description, {
    bool? ignoreCase,
    double? timeout,
  }) async {
    await (_locator.frame as FrameImpl).channel.expect(
      selector: _locator.selector,
      expression: 'to.have.accessible.description',
      expectedText: [
        ExpectedTextValue(
          string: description,
          matchSubstring: false,
          ignoreCase: ignoreCase ?? false,
        ),
      ],
      isNot: _isNot,
      timeout: timeout ?? _timeout ?? 5000.0,
    );
  }

  /// Ensures the [Locator] points to an element with a given [aria errormessage].
  ///
  /// **Usage**
  ///
  /// ```dart
  /// final locator = page.getByTestId('username-input');
  /// await expect(locator).toHaveAccessibleErrorMessage('Username is required.');
  /// ```
  ///
  /// **Arguments**
  /// - `errorMessage` String | [RegExp]
  ///
  ///   Expected accessible error message.
  /// - `options` Map *(optional)*
  ///   - `ignoreCase` bool *(optional)*
  ///
  ///     Whether to perform case-insensitive match. [ignoreCase] option takes precedence over the corresponding regular expression flag if specified.
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     An optional [`AbortSignal`] that can cancel the assertion. Aborting the signal fails the assertion like a timeout: if the signal is aborted while the assertion is retrying, or is already aborted before the assertion starts, the assertion fails without retrying further.
  ///   - `timeout` double *(optional)*
  ///
  ///     Time to retry the assertion for in milliseconds. Defaults to `timeout` in `TestConfig.expect`.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> toHaveAccessibleErrorMessage(
    String message, {
    bool? ignoreCase,
    double? timeout,
  }) async {
    await (_locator.frame as FrameImpl).channel.expect(
      selector: _locator.selector,
      expression: 'to.have.accessible.error.message',
      expectedText: [
        ExpectedTextValue(
          string: message,
          matchSubstring: false,
          ignoreCase: ignoreCase ?? false,
        ),
      ],
      isNot: _isNot,
      timeout: timeout ?? _timeout ?? 5000.0,
    );
  }

  /// Ensures the [Locator] points to an element with a given [accessible name].
  ///
  /// **Usage**
  ///
  /// ```dart
  /// final locator = page.getByTestId('save-button');
  /// await expect(locator).toHaveAccessibleName('Save to disk');
  /// ```
  ///
  /// **Arguments**
  /// - `name` String
  ///
  ///   Expected accessible name.
  /// - `options` Map *(optional)*
  ///   - `ignoreCase` bool *(optional)*
  ///
  ///     Whether to perform case-insensitive match. [ignoreCase] option takes precedence over the corresponding regular expression flag if specified.
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     An optional [`AbortSignal`] that can cancel the assertion. Aborting the signal fails the assertion like a timeout: if the signal is aborted while the assertion is retrying, or is already aborted before the assertion starts, the assertion fails without retrying further.
  ///   - `timeout` double *(optional)*
  ///
  ///     Time to retry the assertion for in milliseconds. Defaults to `timeout` in `TestConfig.expect`.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> toHaveAccessibleName(
    String name, {
    bool? ignoreCase,
    double? timeout,
  }) async {
    await (_locator.frame as FrameImpl).channel.expect(
      selector: _locator.selector,
      expression: 'to.have.accessible.name',
      expectedText: [
        ExpectedTextValue(
          string: name,
          matchSubstring: false,
          ignoreCase: ignoreCase ?? false,
        ),
      ],
      isNot: _isNot,
      timeout: timeout ?? _timeout ?? 5000.0,
    );
  }

  /// Ensures the [Locator] resolves to an element with the given computed CSS style.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// final locator = page.getByRole('button');
  /// await expect(locator).toHaveCSS('display', 'flex');
  /// ```
  ///
  /// **Arguments**
  /// - `name` String
  ///
  ///   CSS property name.
  /// - `value` String
  ///
  ///   CSS property value.
  /// - `options` Map *(optional)*
  ///   - `pseudo` String *(optional)*
  ///
  ///     Pseudo-element to read computed styles from.
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     An optional [`AbortSignal`] that can cancel the assertion. Aborting the signal fails the assertion like a timeout: if the signal is aborted while the assertion is retrying, or is already aborted before the assertion starts, the assertion fails without retrying further.
  ///   - `timeout` double *(optional)*
  ///
  ///     Time to retry the assertion for in milliseconds. Defaults to `timeout` in `TestConfig.expect`.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> toHaveCSS(
    String name,
    String value, {
    String? pseudo,
    double? timeout,
  }) async {
    await (_locator.frame as FrameImpl).channel.expect(
      selector: _locator.selector,
      expression: 'to.have.css',
      expressionArg: name,
      expectedText: [ExpectedTextValue(string: value, matchSubstring: false)],
      expectedValue: pseudo != null ? serializeArgument(pseudo) : null,
      isNot: _isNot,
      timeout: timeout ?? _timeout ?? 5000.0,
    );
  }

  /// Ensures the [Locator] points to an element with given JavaScript property. Note that this property can be of a primitive type as well as a plain serializable JavaScript object.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// final locator = page.locator('.component');
  /// await expect(locator).toHaveJSProperty('loaded', true);
  /// ```
  ///
  /// **Arguments**
  /// - `name` String
  ///
  ///   Property name.
  /// - `value` Object
  ///
  ///   Property value.
  /// - `options` Map *(optional)*
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     An optional [`AbortSignal`] that can cancel the assertion. Aborting the signal fails the assertion like a timeout: if the signal is aborted while the assertion is retrying, or is already aborted before the assertion starts, the assertion fails without retrying further.
  ///   - `timeout` double *(optional)*
  ///
  ///     Time to retry the assertion for in milliseconds. Defaults to `timeout` in `TestConfig.expect`.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> toHaveJSProperty(
    String name,
    Object? value, {
    double? timeout,
  }) async {
    await (_locator.frame as FrameImpl).channel.expect(
      selector: _locator.selector,
      expression: 'to.have.js.property',
      expressionArg: name,
      expectedValue: serializeArgument(value),
      isNot: _isNot,
      timeout: timeout ?? _timeout ?? 5000.0,
    );
  }

  /// Ensures the [Locator] points to an element with a given [ARIA role].
  ///
  /// Note that role is matched as a string, disregarding the ARIA role hierarchy. For example, asserting  a superclass role `"checkbox"` on an element with a subclass role `"switch"` will fail.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// final locator = page.getByTestId('save-button');
  /// await expect(locator).toHaveRole('button');
  /// ```
  ///
  /// **Arguments**
  /// - `role` String
  ///
  ///   Required aria role.
  /// - `options` Map *(optional)*
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     An optional [`AbortSignal`] that can cancel the assertion. Aborting the signal fails the assertion like a timeout: if the signal is aborted while the assertion is retrying, or is already aborted before the assertion starts, the assertion fails without retrying further.
  ///   - `timeout` double *(optional)*
  ///
  ///     Time to retry the assertion for in milliseconds. Defaults to `timeout` in `TestConfig.expect`.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> toHaveRole(String role, {double? timeout}) async {
    await (_locator.frame as FrameImpl).channel.expect(
      selector: _locator.selector,
      expression: 'to.have.role',
      expectedText: [ExpectedTextValue(string: role, matchSubstring: false)],
      isNot: _isNot,
      timeout: timeout ?? _timeout ?? 5000.0,
    );
  }

  /// Ensures the [Locator] points to multi-select/combobox (i.e. a `select` with the `multiple` attribute) and the specified values are selected.
  ///
  /// **Usage**
  ///
  /// For example, given the following element:
  ///
  /// ```html
  /// <select id="favorite-colors" multiple>
  ///   <option value="R">Red</option>
  ///   <option value="G">Green</option>
  ///   <option value="B">Blue</option>
  /// </select>
  /// ```
  ///
  /// ```dart
  /// final locator = page.locator('id=favorite-colors');
  /// await locator.selectOption(['R', 'G']);
  /// await expect(locator).toHaveValues([/R/, /G/]);
  /// ```
  ///
  /// **Arguments**
  /// - `values` Object
  ///
  ///   Expected options currently selected.
  /// - `options` Map *(optional)*
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     An optional [`AbortSignal`] that can cancel the assertion. Aborting the signal fails the assertion like a timeout: if the signal is aborted while the assertion is retrying, or is already aborted before the assertion starts, the assertion fails without retrying further.
  ///   - `timeout` double *(optional)*
  ///
  ///     Time to retry the assertion for in milliseconds. Defaults to `timeout` in `TestConfig.expect`.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> toHaveValues(Object values, {double? timeout}) async {
    final expectedText = values is List
        ? values
              .map(
                (e) => ExpectedTextValue(
                  string: e.toString(),
                  matchSubstring: false,
                ),
              )
              .toList()
        : [ExpectedTextValue(string: values.toString(), matchSubstring: false)];

    await (_locator.frame as FrameImpl).channel.expect(
      selector: _locator.selector,
      expression: 'to.have.values',
      expectedText: expectedText,
      isNot: _isNot,
      timeout: timeout ?? _timeout ?? 5000.0,
    );
  }

  /// Asserts that the target element matches the given [accessibility snapshot].
  ///
  /// Snapshot is stored in a separate `.aria.yml` file in a location configured by `expect.toMatchAriaSnapshot.pathTemplate` and/or `snapshotPathTemplate` properties in the configuration file.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await expect(page.locator('body')).toMatchAriaSnapshot();
  /// await expect(page.locator('body')).toMatchAriaSnapshot( name: 'body.aria.yml' );
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `name` String *(optional)*
  ///
  ///     Name of the snapshot to store in the snapshot folder corresponding to this test. Generates sequential names if not specified.
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     An optional [`AbortSignal`] that can cancel the assertion. Aborting the signal fails the assertion like a timeout: if the signal is aborted while the assertion is retrying, or is already aborted before the assertion starts, the assertion fails without retrying further.
  ///   - `timeout` double *(optional)*
  ///
  ///     Time to retry the assertion for in milliseconds. Defaults to `timeout` in `TestConfig.expect`.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> toMatchAriaSnapshot(String snapshot, {double? timeout}) async {
    await (_locator.frame as FrameImpl).channel.expect(
      selector: _locator.selector,
      expression: 'to.match.aria.snapshot',
      expressionArg: snapshot,
      isNot: _isNot,
      timeout: timeout ?? _timeout ?? 5000.0,
    );
  }

  /// Ensures the [Locator] resolves to an exact number of DOM nodes.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// final list = page.locator('list > .component');
  /// await expect(list).toHaveCount(3);
  /// ```
  ///
  /// **Arguments**
  /// - `count` int
  ///
  ///   Expected count.
  /// - `options` Map *(optional)*
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     An optional [`AbortSignal`] that can cancel the assertion. Aborting the signal fails the assertion like a timeout: if the signal is aborted while the assertion is retrying, or is already aborted before the assertion starts, the assertion fails without retrying further.
  ///   - `timeout` double *(optional)*
  ///
  ///     Time to retry the assertion for in milliseconds. Defaults to `timeout` in `TestConfig.expect`.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> toHaveCount(int count, {double? timeout}) async {
    await (_locator.frame as FrameImpl).channel.expect(
      selector: _locator.selector,
      expression: 'to.have.count',
      expectedNumber: count.toDouble(),
      isNot: _isNot,
      timeout: timeout ?? _timeout ?? 5000.0,
    );
  }
}
