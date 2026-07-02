import 'frame.dart';

import 'locator.dart';

import '../utils/locator_utils.dart';

/// FrameLocator represents a view to the `iframe` on the page.

class FrameLocator {
  final Frame frame;

  final String frameSelector;

  FrameLocator(this.frame, this.frameSelector);

  /// Returns a [Locator] object pointing to the same `iframe` as this frame locator.
  ///
  /// Useful when you have a [FrameLocator] object obtained somewhere, and later on would like to interact with the `iframe` element.
  ///
  /// For a reverse operation, use [locator.contentFrame()].
  ///
  /// **Usage**
  ///
  /// ```dart
  /// final frameLocator = page.locator('iframe[name="embedded"]').contentFrame();
  /// // ...
  /// final locator = frameLocator.owner();
  /// await expect(locator).toBeVisible();
  /// ```
  ///
  /// **Returns**
  /// - [Locator]
  Locator owner() => Locator(frame, frameSelector);

  /// The method finds an element matching the specified selector in the locator's subtree. It also accepts filter options, similar to [locator.filter()] method.
  ///
  /// [Learn more about locators].
  ///
  /// **Usage**
  ///
  /// ```dart
  /// frameLocator.locator(selectorOrLocator);
  /// frameLocator.locator(selectorOrLocator, options);
  /// ```
  ///
  /// **Arguments**
  /// - `selectorOrLocator` String | [Locator]
  ///
  ///   A selector or locator to use when resolving DOM element.
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
  Locator locator(String selector) {
    return Locator(
      frame,

      '$frameSelector >> internal:control=enter-frame >> $selector',
    );
  }

  /// When working with iframes, you can create a frame locator that will enter the iframe and allow selecting elements in that iframe.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// frameLocator.frameLocator(selector);
  /// ```
  ///
  /// **Arguments**
  /// - `selector` String
  ///
  ///   A selector to use when resolving DOM element.
  ///
  /// **Returns**
  /// - [FrameLocator]
  FrameLocator frameLocator(String selector) {
    return FrameLocator(
      frame,

      '$frameSelector >> internal:control=enter-frame >> $selector',
    );
  }

  /// **WARNING**
  /// [Deprecated]
  ///
  /// Use [locator.first()] followed by [locator.contentFrame()] instead.
  ///
  /// Returns locator to the first matching frame.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// frameLocator.first();
  /// ```
  ///
  /// **Returns**
  /// - [FrameLocator]
  Locator first() => locator('nth=0');

  /// **WARNING**
  /// [Deprecated]
  ///
  /// Use [locator.last()] followed by [locator.contentFrame()] instead.
  ///
  /// Returns locator to the last matching frame.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// frameLocator.last();
  /// ```
  ///
  /// **Returns**
  /// - [FrameLocator]
  Locator last() => locator('nth=-1');

  /// **WARNING**
  /// [Deprecated]
  ///
  /// Use [locator.nth()] followed by [locator.contentFrame()] instead.
  ///
  /// Returns locator to the n-th matching frame. It's zero based, `nth(0)` selects the first frame.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// frameLocator.nth(index);
  /// ```
  ///
  /// **Arguments**
  /// - `index` num
  ///
  /// **Returns**
  /// - [FrameLocator]
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
  Locator nth(int index) => locator('nth=$index');

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
  Locator getByText(Pattern text, {bool exact = false}) {
    /// The method finds an element matching the specified selector in the locator's subtree. It also accepts filter options, similar to [locator.filter()] method.
    ///
    /// [Learn more about locators].
    ///
    /// **Usage**
    ///
    /// ```dart
    /// frameLocator.locator(selectorOrLocator);
    /// frameLocator.locator(selectorOrLocator, options);
    /// ```
    ///
    /// **Arguments**
    /// - `selectorOrLocator` String | [Locator]
    ///
    ///   A selector or locator to use when resolving DOM element.
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
    return locator(
      'internal:text=${encodePatternForTextSelector(text, exact: exact)}',
    );
  }

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
  /// - `role` `"Playwright"` matches `&lt;article&gt;&lt;div&gt;Playwright&lt;/div&gt;&lt;/article&gt;`. /// /// **Returns** /// - Locator String
  ///
  ///   Required aria role.
  /// - `options` /// The method finds an element matching the specified selector in the locator's subtree. It also accepts filter *(optional)*
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
    /// The method finds an element matching the specified selector in the locator's subtree. It also accepts filter options, similar to [locator.filter()] method.
    ///
    /// [Learn more about locators].
    ///
    /// **Usage**
    ///
    /// ```dart
    /// frameLocator.locator(selectorOrLocator);
    /// frameLocator.locator(selectorOrLocator, options);
    /// ```
    ///
    /// **Arguments**
    /// - `selectorOrLocator` String | [Locator]
    ///
    ///   A selector or locator to use when resolving DOM element.
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
  Locator getByLabel(Pattern text, {bool exact = false}) {
    /// The method finds an element matching the specified selector in the locator's subtree. It also accepts filter options, similar to [locator.filter()] method.
    ///
    /// [Learn more about locators].
    ///
    /// **Usage**
    ///
    /// ```dart
    /// frameLocator.locator(selectorOrLocator);
    /// frameLocator.locator(selectorOrLocator, options);
    /// ```
    ///
    /// **Arguments**
    /// - `selectorOrLocator` String | [Locator]
    ///
    ///   A selector or locator to use when resolving DOM element.
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
    return locator(
      'internal:label=${encodePatternForLabelSelector(text, exact: exact)}',
    );
  }

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
  Locator getByPlaceholder(Pattern text, {bool exact = false}) {
    /// The method finds an element matching the specified selector in the locator's subtree. It also accepts filter options, similar to [locator.filter()] method.
    ///
    /// [Learn more about locators].
    ///
    /// **Usage**
    ///
    /// ```dart
    /// frameLocator.locator(selectorOrLocator);
    /// frameLocator.locator(selectorOrLocator, options);
    /// ```
    ///
    /// **Arguments**
    /// - `selectorOrLocator` String | [Locator]
    ///
    ///   A selector or locator to use when resolving DOM element.
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
    return locator(
      'internal:attr=[placeholder=${encodePatternForAttrSelector(text, exact: exact)}]',
    );
  }

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
  Locator getByAltText(Pattern text, {bool exact = false}) {
    /// The method finds an element matching the specified selector in the locator's subtree. It also accepts filter options, similar to [locator.filter()] method.
    ///
    /// [Learn more about locators].
    ///
    /// **Usage**
    ///
    /// ```dart
    /// frameLocator.locator(selectorOrLocator);
    /// frameLocator.locator(selectorOrLocator, options);
    /// ```
    ///
    /// **Arguments**
    /// - `selectorOrLocator` String | [Locator]
    ///
    ///   A selector or locator to use when resolving DOM element.
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
    return locator(
      'internal:attr=[alt=${encodePatternForAttrSelector(text, exact: exact)}]',
    );
  }

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
  Locator getByTitle(Pattern text, {bool exact = false}) {
    /// The method finds an element matching the specified selector in the locator's subtree. It also accepts filter options, similar to [locator.filter()] method.
    ///
    /// [Learn more about locators].
    ///
    /// **Usage**
    ///
    /// ```dart
    /// frameLocator.locator(selectorOrLocator);
    /// frameLocator.locator(selectorOrLocator, options);
    /// ```
    ///
    /// **Arguments**
    /// - `selectorOrLocator` String | [Locator]
    ///
    ///   A selector or locator to use when resolving DOM element.
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
    return locator(
      'internal:attr=[title=${encodePatternForAttrSelector(text, exact: exact)}]',
    );
  }

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
  Locator getByTestId(String testId) {
    /// The method finds an element matching the specified selector in the locator's subtree. It also accepts filter options, similar to [locator.filter()] method.
    ///
    /// [Learn more about locators].
    ///
    /// **Usage**
    ///
    /// ```dart
    /// frameLocator.locator(selectorOrLocator);
    /// frameLocator.locator(selectorOrLocator, options);
    /// ```
    ///
    /// **Arguments**
    /// - `selectorOrLocator` String | [Locator]
    ///
    ///   A selector or locator to use when resolving DOM element.
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
    return locator(getByTestIdSelector(testId));
  }
}
