import '../interaction/interaction_types.dart';
import 'route_matcher.dart';
import '../interaction/element_handle.dart';

import '../infrastructure/channel_owner.dart';

import 'frame_locator.dart';

import '../generated/channels.dart';

import '../interaction/jshandle.dart';

import 'locator.dart';

import '../infrastructure/serialization.dart';

import 'page.dart';

import '../utils/locator_utils.dart';

import '../utils/logger.dart';

/// The received value from a failed assertion (mirrors `ExpectReceived` in the

/// Playwright TypeScript client).

class ExpectReceived {
  /// The JavaScript value received from the page, deserialised.

  final dynamic value;

  /// ARIA snapshot of the received element, if applicable.

  final String? ariaSnapshot;

  const ExpectReceived({this.value, this.ariaSnapshot});
}

/// Result returned by [Frame.expect] / [Page.expect].

///

/// Mirrors the TypeScript `ExpectResult` type from `frame.ts`:

/// `{ matches: boolean, received?: ExpectReceived, log?: string[],

///   timedOut?: boolean, errorMessage?: string }`

///

/// When [matches] is `true` the assertion passed.  When `false`, [received]

/// and [errorMessage] carry the failure details.

class ExpectResult {
  final bool matches;

  final ExpectReceived? received;

  final List<String>? log;

  final bool? timedOut;

  final String? errorMessage;

  const ExpectResult({
    required this.matches,

    this.received,

    this.log,

    this.timedOut,

    this.errorMessage,
  });
}

/// Interface for Frame

abstract interface class Frame {
  /// Parent frame, if any. Detached frames and main frames return `null`.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// frame.parentFrame;
  /// ```
  ///
  /// **Returns**
  /// - [Frame]?
  Frame? get parentFrame;

  /// **Usage**
  ///
  /// ```dart
  /// frame.childFrames;
  /// ```
  ///
  /// **Returns**
  /// - List&lt;[Frame]&gt;
  List<Frame> get childFrames;

  /// Returns frame's name attribute as specified in the tag.
  ///
  /// If the name is empty, returns the id attribute instead.
  ///
  /// **NOTE**
  /// This value is calculated once when the frame is created, and will not update if the attribute is changed later.
  /// **Usage**
  ///
  /// ```dart
  /// frame.name;
  /// ```
  ///
  /// **Returns**
  /// - String
  String get name;

  /// Stream that emits when the frame navigates.
  Stream<Map<String, dynamic>> get onNavigated;

  /// Stream that emits when the frame load state changes.
  Stream<Map<String, dynamic>> get onLoadstate;

  /// Returns frame's url.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// frame.url();
  /// ```
  ///
  /// **Returns**
  /// - String
  String url();

  /// Returns the page containing this frame.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// frame.page;
  /// ```
  ///
  /// **Returns**
  /// - [Page]
  Page get page;

  /// When working with iframes, you can create a frame locator that will enter the iframe and allow selecting elements in that iframe.
  ///
  /// **Usage**
  ///
  /// Following snippet locates element with text "Submit" in the iframe with id `my-frame`, like `<iframe id="my-frame">`:
  ///
  /// ```dart
  /// final locator = frame.frameLocator('#my-iframe').getByText('Submit');
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

  /// The method returns an element locator that can be used to perform actions on this page / frame. Locator is resolved to the element immediately before performing an action, so a series of actions on the same locator can in fact be performed on different DOM elements. That would happen if the DOM structure between those actions has changed.
  ///
  /// [Learn more about locators].
  ///
  /// [Learn more about locators].
  ///
  /// **Usage**
  ///
  /// ```dart
  /// frame.locator(selector);
  /// frame.locator(selector, options);
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

  /// Returns the main resource response. In case of multiple redirects, the navigation will resolve with the response of the last redirect.
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
  /// await frame.goto(url);
  /// await frame.goto(url, options);
  /// ```
  ///
  /// **Arguments**
  /// - `url` String
  ///
  ///   URL to navigate frame to. The url should include scheme, e.g. `https://`.
  /// - `options` Map *(optional)*
  ///   - `referer` String *(optional)*
  ///
  ///     Referer header value. If provided it will take preference over the referer header value set by [page.setExtraHTTPHeaders()].
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

  /// **WARNING**
  /// [Discouraged]
  ///
  /// Use locator-based [locator.textContent()] instead. Read more about [locators].
  ///
  /// Returns `element.textContent`.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await frame.textContent(selector);
  /// await frame.textContent(selector, options);
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
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;[String&gt;]?
  Future<String> textContent({
    required String selector,

    double? timeout,

    bool? strict,
  });

  /// Returns the return value of [pageFunction].
  ///
  /// If the function passed to the [frame.evaluate()] returns a Future, then [frame.evaluate()] would wait for the future to complete and return its value.
  ///
  /// If the function passed to the [frame.evaluate()] returns a non-[Serializable] value, then [frame.evaluate()] returns `undefined`. Playwright also supports transferring some additional values that are not serializable by `JSON`: `-0`, `NaN`, `Infinity`, `-Infinity`.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// final result = await frame.evaluate(([x, y]) {
  ///   return Future.value(x * y);
  /// }, [7, 8]);
  /// print(result); // prints "56"
  /// ```
  ///
  /// A string can also be passed in instead of a function.
  ///
  /// ```dart
  /// print(await frame.evaluate('1 + 2')); // prints "3"
  /// ```
  ///
  /// [ElementHandle] instances can be passed as an argument to the [frame.evaluate()]:
  ///
  /// ```dart
  /// final bodyHandle = await frame.evaluateHandle('document.body');
  /// final html = await frame.evaluate(([body, suffix]) =>
  ///   body.innerHTML + suffix, [bodyHandle, 'hello'],
  /// );
  /// await bodyHandle.dispose();
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
  Future<dynamic> evaluate(String expression, [Object? arg]);

  /// **WARNING**
  /// [Discouraged]
  ///
  /// Use web assertions that assert visibility or a locator-based [locator.waitFor()] instead. Read more about [locators].
  ///
  /// Returns when element specified by selector satisfies [state] option. Returns `null` if waiting for `hidden` or `detached`.
  ///
  /// **NOTE**
  /// Playwright automatically waits for element to be ready before performing an action. Using [Locator] objects and web-first assertions make the code wait-for-selector-free.
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
  ///     final element = await page.mainFrame().waitForSelector('img');
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
  ///   - `state` FrameWaitForSelectorStateEnum *(optional)*
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

    FrameWaitForSelectorStateEnum? state,

    double? timeout,

    bool? strict,

    bool? omitReturnValue,
  });

  /// Waits for the required load state to be reached.
  ///
  /// This returns when the frame reaches a required load state, `load` by default. The navigation must have been committed when this method is called. If current document has already reached the required state, resolves immediately.
  ///
  /// **NOTE**
  /// Most of the time, this method is not needed because Playwright [auto-waits before every action].
  /// **Usage**
  ///
  /// ```dart
  /// await frame.click('button'); // Click triggers navigation.
  /// await frame.waitForLoadState(); // Waits for 'load' state by default.
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
  ///     Allows to cancel the waiting using an [`AbortSignal`]. If the signal is aborted, the waiting will be aborted and the operation will throw an error. Note that providing a signal does not disable the default timeout; pass `timeout: 0` to disable the timeout entirely.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum operation time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `navigationTimeout` option in the config, or by using the [browserContext.setDefaultNavigationTimeout()], [browserContext.setDefaultTimeout()], [page.setDefaultNavigationTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> waitForLoadState({LifecycleEvent? state, double? timeout});

  /// Waits for the frame to navigate to the given URL.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await frame.click('a.delayed-navigation'); // Clicking the link will indirectly cause a navigation
  /// await frame.waitForURL('**/target.html');
  /// ```
  ///
  /// **Arguments**
  /// - `url` String | [RegExp] | [URLPattern] | Function\([URL]\):bool
  ///
  ///   A glob pattern, regex pattern, URL pattern, or predicate receiving [URL] to match while waiting for the navigation. Note that if the parameter is a string without wildcard characters, the method will wait for navigation to URL that is exactly equal to the string.
  /// - `options` Map *(optional)*
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     Allows to cancel the waiting using an [`AbortSignal`]. If the signal is aborted, the waiting will be aborted and the operation will throw an error. Note that providing a signal does not disable the default timeout; pass `timeout: 0` to disable the timeout entirely.
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
  /// This method is inherently racy, please use [frame.waitForURL()] instead.
  ///
  /// Waits for the frame navigation and returns the main resource response. In case of multiple redirects, the navigation will resolve with the response of the last redirect. In case of navigation to a different anchor or navigation due to History API usage, the navigation will resolve with `null`.
  ///
  /// **Usage**
  ///
  /// This method waits for the frame to navigate to a new URL. It is useful for when you run code which will indirectly cause the frame to navigate. Consider this example:
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
  ///     Allows to cancel the waiting using an [`AbortSignal`]. If the signal is aborted, the waiting will be aborted and the operation will throw an error. Note that providing a signal does not disable the default timeout; pass `timeout: 0` to disable the timeout entirely.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum operation time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `navigationTimeout` option in the config, or by using the [browserContext.setDefaultNavigationTimeout()], [browserContext.setDefaultTimeout()], [page.setDefaultNavigationTimeout()] or [page.setDefaultTimeout()] methods.
  ///   - `url` String *(optional)*
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

  /// **Usage**
  ///
  /// ```dart
  /// await frame.dragAndDrop(source, target);
  /// await frame.dragAndDrop(source, target, options);
  /// ```
  ///
  /// **Arguments**
  /// - `source` String
  ///
  ///   A selector to search for an element to drag. If there are multiple elements satisfying the selector, the first will be used.
  /// - `target` String
  ///
  ///   A selector to search for an element to drop onto. If there are multiple elements satisfying the selector, the first will be used.
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
  ///   - `sourcePosition` Point *(optional)*
  ///     - `x` num
  ///
  ///
  ///     - `y` num
  ///
  ///
  ///     Clicks on the source element at this point relative to the top-left corner of the element's padding box. If not specified, some visible point of the element is used.
  ///   - `steps` int *(optional)*
  ///
  ///     Defaults to 1. Sends `n` interpolated `mousemove` events to represent travel between the `mousedown` and `mouseup` of the drag. When set to 1, emits a single `mousemove` event at the destination location.
  ///   - `strict` bool *(optional)*
  ///
  ///     When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
  ///   - `targetPosition` Point *(optional)*
  ///     - `x` num
  ///
  ///
  ///     - `y` num
  ///
  ///
  ///     Drops on the target element at this point relative to the top-left corner of the element's padding box. If not specified, some visible point of the element is used.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///   - `trial` bool *(optional)*
  ///
  ///     When set, this method only performs the [actionability] checks and skips the action. Defaults to `false`. Useful to wait until the element is ready for the action without performing it.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> dragAndDrop(
    String source,

    String target, {

    bool? force,

    double? timeout,

    bool? strict,

    bool? trial,

    Point? sourcePosition,

    Point? targetPosition,

    int? steps,
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
  /// await frame.click(selector);
  /// await frame.click(selector, options);
  /// ```
  ///
  /// **Arguments**
  /// - `selector` String
  ///
  ///   A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
  /// - `options` Map *(optional)*
  ///   - `button` FrameClickButtonEnum *(optional)*
  ///
  ///     Defaults to `left`.
  ///   - `clickCount` int *(optional)*
  ///
  ///     defaults to 1. See [UIEvent.detail].
  ///   - `delay` double *(optional)*
  ///
  ///     Time to wait between `mousedown` and `mouseup` in milliseconds. Defaults to 0.
  ///   - `force` bool *(optional)*
  ///
  ///     Whether to bypass the [actionability] checks. Defaults to `false`.
  ///   - `modifiers` List&lt;FrameClickModifiersEnum&gt; *(optional)*
  ///
  ///     Modifier keys to press. Ensures that only these modifiers are pressed during the operation, and then restores current modifiers back. If not specified, currently pressed modifiers are used. "ControlOrMeta" resolves to "Control" on Windows and Linux and to "Meta" on macOS.
  ///   - `noWaitAfter` bool *(optional)*
  ///
  ///     **WARNING**
  /// [Deprecated]
  ///     This option will default to `true` in the future.
  ///     Actions that initiate navigations are waiting for these navigations to happen and for pages to start loading. You can opt out of waiting via setting this flag. You would only need this option in the exceptional cases such as navigating to inaccessible pages. Defaults to `false`.
  ///   - `position` Point *(optional)*
  ///     - `x` num
  ///
  ///
  ///     - `y` num
  ///
  ///
  ///     A point to use relative to the top-left corner of element padding box. If not specified, uses some visible point of the element.
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
  Future<void> click(
    String selector, {

    bool? force,

    double? timeout,

    bool? strict,

    bool? trial,

    bool? noWaitAfter,

    List<FrameClickModifiersEnum>? modifiers,

    Point? position,

    double? delay,

    FrameClickButtonEnum? button,

    int? clickCount,

    int? steps,
  });

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
  /// await frame.fill(selector, value);
  /// await frame.fill(selector, value, options);
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

    bool? strict,
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
  /// await frame.check(selector);
  /// await frame.check(selector, options);
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
  ///   - `position` Point *(optional)*
  ///     - `x` num
  ///
  ///
  ///     - `y` num
  ///
  ///
  ///     A point to use relative to the top-left corner of element padding box. If not specified, uses some visible point of the element.
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
  Future<void> check(
    String selector, {

    bool? force,

    double? timeout,

    bool? strict,

    bool? trial,

    Point? position,
  });

  /// **WARNING**
  /// [Discouraged]
  ///
  /// Use locator-based [locator.uncheck()] instead. Read more about [locators].
  ///
  /// This method checks an element matching [selector] by performing the following steps:
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
  /// await frame.uncheck(selector);
  /// await frame.uncheck(selector, options);
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
  ///   - `position` Point *(optional)*
  ///     - `x` num
  ///
  ///
  ///     - `y` num
  ///
  ///
  ///     A point to use relative to the top-left corner of element padding box. If not specified, uses some visible point of the element.
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
  Future<void> uncheck(
    String selector, {

    bool? force,

    double? timeout,

    bool? strict,

    bool? trial,

    Point? position,
  });

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
  /// await frame.setChecked(selector, checked);
  /// await frame.setChecked(selector, checked, options);
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
  ///   - `position` Point *(optional)*
  ///     - `x` num
  ///
  ///
  ///     - `y` num
  ///
  ///
  ///     A point to use relative to the top-left corner of element padding box. If not specified, uses some visible point of the element.
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

    bool? strict,

    bool? trial,

    Point? position,
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
  /// await frame.hover(selector);
  /// await frame.hover(selector, options);
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
  ///   - `modifiers` List&lt;FrameHoverModifiersEnum&gt; *(optional)*
  ///
  ///     Modifier keys to press. Ensures that only these modifiers are pressed during the operation, and then restores current modifiers back. If not specified, currently pressed modifiers are used. "ControlOrMeta" resolves to "Control" on Windows and Linux and to "Meta" on macOS.
  ///   - `noWaitAfter` bool *(optional)*
  ///
  ///     **WARNING**
  /// [Deprecated]
  ///     This option has no effect.
  ///     This option has no effect.
  ///   - `position` Point *(optional)*
  ///     - `x` num
  ///
  ///
  ///     - `y` num
  ///
  ///
  ///     A point to use relative to the top-left corner of element padding box. If not specified, uses some visible point of the element.
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
  Future<void> hover(
    String selector, {

    bool? force,

    double? timeout,

    bool? strict,

    bool? trial,

    List<FrameHoverModifiersEnum>? modifiers,

    Point? position,
  });

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
  /// await frame.focus(selector);
  /// await frame.focus(selector, options);
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
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> focus(String selector, {double? timeout, bool? strict});

  /// Removes focus from an element matching the selector.
  Future<void> blur(String selector, {double? timeout, bool? strict});

  /// **WARNING**
  /// [Discouraged]
  ///
  /// Use locator-based [locator.dblclick()] instead. Read more about [locators].
  ///
  /// This method double clicks an element matching [selector] by performing the following steps:
  /// 1. Find an element matching [selector]. If there is none, wait until a matching element is attached to the DOM.
  /// 1. Wait for [actionability] checks on the matched element, unless [force] option is set. If the element is detached during the checks, the whole action is retried.
  /// 1. Scroll the element into view if needed.
  /// 1. Use [page.mouse] to double click in the center of the element, or the specified [position]. if the first click of the `dblclick()` triggers a navigation event, this method will throw.
  ///
  /// When all steps combined have not finished during the specified [timeout], this method throws a [TimeoutError]. Passing zero timeout disables this.
  ///
  /// **NOTE**
  /// `frame.dblclick()` dispatches two `click` events and a single `dblclick` event.
  /// **Usage**
  ///
  /// ```dart
  /// await frame.dblclick(selector);
  /// await frame.dblclick(selector, options);
  /// ```
  ///
  /// **Arguments**
  /// - `selector` String
  ///
  ///   A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
  /// - `options` Map *(optional)*
  ///   - `button` FrameDblclickButtonEnum *(optional)*
  ///
  ///     Defaults to `left`.
  ///   - `delay` double *(optional)*
  ///
  ///     Time to wait between `mousedown` and `mouseup` in milliseconds. Defaults to 0.
  ///   - `force` bool *(optional)*
  ///
  ///     Whether to bypass the [actionability] checks. Defaults to `false`.
  ///   - `modifiers` List&lt;FrameDblclickModifiersEnum&gt; *(optional)*
  ///
  ///     Modifier keys to press. Ensures that only these modifiers are pressed during the operation, and then restores current modifiers back. If not specified, currently pressed modifiers are used. "ControlOrMeta" resolves to "Control" on Windows and Linux and to "Meta" on macOS.
  ///   - `noWaitAfter` bool *(optional)*
  ///
  ///     **WARNING**
  /// [Deprecated]
  ///     This option has no effect.
  ///     This option has no effect.
  ///   - `position` Point *(optional)*
  ///     - `x` num
  ///
  ///
  ///     - `y` num
  ///
  ///
  ///     A point to use relative to the top-left corner of element padding box. If not specified, uses some visible point of the element.
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
  Future<void> dblclick(
    String selector, {

    bool? force,

    double? timeout,

    bool? strict,

    bool? trial,

    List<FrameDblclickModifiersEnum>? modifiers,

    Point? position,

    double? delay,

    FrameDblclickButtonEnum? button,

    int? steps,
  });

  /// **WARNING**
  /// [Deprecated]
  ///
  /// In most cases, you should use [locator.fill()] instead. You only need to press keys one by one if there is special keyboard handling on the page - in this case use [locator.pressSequentially()].
  ///
  /// Sends a `keydown`, `keypress`/`input`, and `keyup` event for each character in the text. `frame.type` can be used to send fine-grained keyboard events. To fill values in form fields, use [frame.fill()].
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

    bool? strict,
  });

  /// **WARNING**
  /// [Discouraged]
  ///
  /// Use locator-based [locator.press()] instead. Read more about [locators].
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
  /// await frame.press(selector, key);
  /// await frame.press(selector, key, options);
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

    bool? strict,

    bool? noWaitAfter,
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
  /// `frame.tap()` requires that the `hasTouch` option of the browser context be set to true.
  /// **Usage**
  ///
  /// ```dart
  /// await frame.tap(selector);
  /// await frame.tap(selector, options);
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
  ///   - `modifiers` List&lt;FrameTapModifiersEnum&gt; *(optional)*
  ///
  ///     Modifier keys to press. Ensures that only these modifiers are pressed during the operation, and then restores current modifiers back. If not specified, currently pressed modifiers are used. "ControlOrMeta" resolves to "Control" on Windows and Linux and to "Meta" on macOS.
  ///   - `noWaitAfter` bool *(optional)*
  ///
  ///     **WARNING**
  /// [Deprecated]
  ///     This option has no effect.
  ///     This option has no effect.
  ///   - `position` Point *(optional)*
  ///     - `x` num
  ///
  ///
  ///     - `y` num
  ///
  ///
  ///     A point to use relative to the top-left corner of element padding box. If not specified, uses some visible point of the element.
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
  Future<void> tap(
    String selector, {

    bool? force,

    double? timeout,

    bool? strict,

    bool? trial,

    List<FrameTapModifiersEnum>? modifiers,

    Point? position,
  });

  /// Gets the full HTML contents of the frame, including the doctype.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await frame.content();
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
  /// await frame.setContent(html);
  /// await frame.setContent(html, options);
  /// ```
  ///
  /// **Arguments**
  /// - `html` String
  ///
  ///   HTML markup to assign to the page.
  /// - `options` Map *(optional)*
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
  Future<void> setContent(
    String html, {

    double? timeout,

    LifecycleEvent? waitUntil,
  });

  /// Evaluates JavaScript on the element matching the selector.
  Future<dynamic> evalOnSelector(
    String selector,

    String expression, [

    Object? arg,

    bool? strict,

    bool? isFunction,
  ]);

  /// Evaluates JavaScript on all elements matching the selector.
  Future<dynamic> evalOnSelectorAll(
    String selector,

    String expression, [

    Object? arg,

    bool? isFunction,
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
  /// await frame.getAttribute(selector, name);
  /// await frame.getAttribute(selector, name, options);
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
  ///   - `strict` bool *(optional)*
  ///
  ///     When true, the call requires selector to resolve to a single element. If given selector resolves to more than one element, the call throws an exception.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;[String&gt;]?
  Future<String?> getAttribute(
    String selector,

    String name, {

    double? timeout,

    bool? strict,
  });

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
  /// await frame.innerHTML(selector);
  /// await frame.innerHTML(selector, options);
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
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;String&gt;
  Future<String> innerHTML(String selector, {double? timeout, bool? strict});

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
  /// await frame.innerText(selector);
  /// await frame.innerText(selector, options);
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
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;String&gt;
  Future<String> innerText(String selector, {double? timeout, bool? strict});

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
  /// await frame.inputValue(selector);
  /// await frame.inputValue(selector, options);
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
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;String&gt;
  Future<String> inputValue(String selector, {double? timeout, bool? strict});

  /// Returns the page title.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await frame.title();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;String&gt;
  Future<String> title();

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
  /// await frame.isChecked(selector);
  /// await frame.isChecked(selector, options);
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
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;bool&gt;
  Future<bool> isChecked(String selector, {double? timeout, bool? strict});

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
  /// await frame.isDisabled(selector);
  /// await frame.isDisabled(selector, options);
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
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;bool&gt;
  Future<bool> isDisabled(String selector, {double? timeout, bool? strict});

  /// Returns whether the element is [enabled].
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await frame.isEnabled(selector);
  /// await frame.isEnabled(selector, options);
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
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;bool&gt;
  Future<bool> isEnabled(String selector, {double? timeout, bool? strict});

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
  /// await frame.isHidden(selector);
  /// await frame.isHidden(selector, options);
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
  ///     This option is ignored. [frame.isHidden()] does not wait for the element to become hidden and returns immediately.
  ///     **Returns**
  /// - Future&lt;bool&gt;
  Future<bool> isHidden(String selector, {bool? strict});

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
  /// await frame.isVisible(selector);
  /// await frame.isVisible(selector, options);
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
  ///     This option is ignored. [frame.isVisible()] does not wait for the element to become visible and returns immediately.
  ///     **Returns**
  /// - Future&lt;bool&gt;
  Future<bool> isVisible(String selector, {bool? strict});

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
  /// await frame.isEditable(selector);
  /// await frame.isEditable(selector, options);
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
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;bool&gt;
  Future<bool> isEditable(String selector, {double? timeout, bool? strict});

  /// Returns the added tag when the script's onload fires or when the script content was injected into frame.
  ///
  /// Adds a `<script>` tag into the page with the desired url or content.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await frame.addScriptTag();
  /// await frame.addScriptTag(options);
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

  /// Returns the added tag when the stylesheet's onload fires or when the CSS content was injected into frame.
  ///
  /// Adds a `<link rel="stylesheet">` tag into the page with the desired url or a `<style type="text/css">` tag with the content.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await frame.addStyleTag();
  /// await frame.addStyleTag(options);
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
  /// Note that `frame.waitForTimeout()` should only be used for debugging. Tests using the timer in production are going to be flaky. Use signals such as network events, selectors becoming visible and others instead.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await frame.waitForTimeout(timeout);
  /// ```
  ///
  /// **Arguments**
  /// - `timeout` num
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
  /// [TestStep]: /api/class-teststep.mdx "TestStep"
  /// [EvaluationArgument]: /evaluating.mdx#evaluation-argument "EvaluationArgument"
  /// [UIEvent.detail]: https://developer.mozilla.org/en-US/docs/Web/API/UIEvent/detail "UIEvent.detail"
  ///
  ///
  /// [all available image tags]: https://mcr.microsoft.com/en-us/product/playwright/about "all available image tags"
  /// [Microsoft Artifact Registry]: https://mcr.microsoft.com/en-us/product/playwright/about "Microsoft Artifact Registry"
  /// [Dockerfile.noble]: https://github.com/microsoft/playwright/blob/main/utils/docker/Dockerfile.noble "Dockerfile.noble"
  Future<void> waitForTimeout(double waitTimeout);

  /// Returns when the [pageFunction] returns a truthy value, returns that value.
  ///
  /// **Usage**
  ///
  /// The [frame.waitForFunction()] can be used to observe viewport size change:
  ///
  /// ```dart
  ///   // Or 'chromium' or 'webkit'.
  ///
  /// (() async {
  ///   final browser = await firefox.launch();
  ///   final page = await browser.newPage();
  ///   final watchDog = page.mainFrame().waitForFunction('window.innerWidth < 100');
  ///   await page.setViewportSize( width: 50, height: 50 );
  ///   await watchDog;
  ///   await browser.close();
  /// }
  /// ```
  ///
  /// To pass an argument to the predicate of `frame.waitForFunction` function:
  ///
  /// ```dart
  /// final selector = '.foo';
  /// await frame.waitForFunction((selector) => !!document.querySelector(selector), selector);
  /// ```
  ///
  /// **Arguments**
  /// - `pageFunction` Function | String
  ///
  ///   Function to be evaluated in the page context.
  /// - `arg` dynamic *(optional)*
  ///
  ///   Optional argument to pass to [pageFunction].
  /// - `options` Map *(optional)*
  ///   - `polling` num | "raf" *(optional)*
  ///
  ///     If [polling] is `'raf'`, then [pageFunction] is constantly executed in `requestAnimationFrame` callback. If [polling] is a number, then it is treated as an interval in milliseconds at which the function would be executed. Defaults to `raf`.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time to wait for in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;[JSHandle]&gt;
  Future<JSHandle> waitForFunction(
    String expression, {

    Object? arg,

    double? timeout,

    double? pollingInterval,

    bool? isFunction,
  });

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
  /// await frame.dispatchEvent('button#submit', 'click');
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
  /// final dataTransfer = await frame.evaluateHandle(() => new DataTransfer());
  /// await frame.dispatchEvent('#source', 'dragstart', { dataTransfer );
  /// ```
  ///
  /// **Arguments**
  /// - `selector` String
  ///
  ///   A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
  /// - `type` String
  ///
  ///   DOM event type: `"click"`, `"dragstart"`, etc.
  /// - `eventInit` dynamic *(optional)*
  ///
  ///   Optional event-specific initialization properties.
  /// - `options` Map *(optional)*
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

    bool? strict,
  });

  /// Highlights the element matching the selector.
  Future<void> highlight(String selector, {String? style});

  /// Hides the highlight on the element matching the selector.
  Future<void> hideHighlight(String selector);

  /// Drops files on the element matching the selector.
  Future<void> drop(
    String selector, {

    List<FrameDropPayloadsItems>? payloads,

    List<String>? localPaths,

    List<FrameDropDataItems>? data,

    bool? strict,

    double? timeout,

    Point? position,

    List<WritableStreamBase>? streams,
  });

  Future<FrameResolveSelectorResult> resolveSelector(String selector);

  Future<FrameAriaSnapshotResult> ariaSnapshot(
    String selector, {

    FrameAriaSnapshotModeEnum? mode,

    String? track,

    int? depth,

    bool? boxes,

    double? timeout,
  });

  Future<dynamic> evaluateExpression(
    String expression, {

    bool? isFunction,

    Object? arg,
  });

  Future<JSHandle> evaluateExpressionHandle(
    String expression, {

    bool? isFunction,

    Object? arg,
  });

  /// Returns the `frame` or `iframe` element handle which corresponds to this frame.
  ///
  /// This is an inverse of [elementHandle.contentFrame()]. Note that returned handle actually belongs to the parent frame.
  ///
  /// This method throws an error if the frame has been detached before `frameElement()` returns.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// final frameElement = await frame.frameElement();
  /// final contentFrame = await frameElement.contentFrame();
  /// print(frame == contentFrame);  // -> true
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;[ElementHandle]&gt;
  Future<ElementHandle> frameElement();

  Future<ExpectResult> expect(
    String selector,

    String expression, {

    SerializedArgument? expectedValue,

    List<ExpectedTextValue>? expectedText,

    double? expectedNumber,

    bool? useInnerText,

    required bool isNot,

    double? timeout,

    Object? expressionArg,

    FrameExpectPseudoEnum? pseudo,
  });

  Locator querySelector(String selector, {bool? strict});

  Future<List<Locator>> querySelectorAll(String selector);

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
  /// frame.selectOption('select#colors', 'blue');
  ///
  /// // single selection matching both the value and the label
  /// frame.selectOption('select#colors', { label: 'Blue' );
  ///
  /// // multiple selection
  /// frame.selectOption('select#colors', 'red', 'green', 'blue');
  /// ```
  ///
  /// **Arguments**
  /// - `selector` String
  ///
  ///   A selector to query for.
  /// - `values` dynamic
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
  /// - `options` List&lt;ElementHandleSelectOptionOptionsItems&gt; *(optional)*
  ///   - `force` bool *(optional)*
  ///
  ///     Whether to bypass the [actionability] checks. Defaults to `false`.
  ///   - `noWaitAfter` bool *(optional)*
  ///
  ///     **WARNING**
  /// [Deprecated]
  ///     This option has no effect.
  ///     This option has no effect.
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

    bool? strict,

    List<ElementHandleBase>? elements,

    List<ElementHandleSelectOptionOptionsItems>? options,
  });

  /// **WARNING**
  /// [Discouraged]
  ///
  /// Use locator-based [locator.setInputFiles()] instead. Read more about [locators].
  ///
  /// Sets the value of the file input to these file paths or files. If some of the `filePaths` are relative paths, then they are resolved relative to the current working directory. For empty array, clears the selected files.
  ///
  /// This method expects [selector] to point to an [input element]. However, if the element is inside the `<label>` element that has an associated [control], targets the control instead.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await frame.setInputFiles(selector, files);
  /// await frame.setInputFiles(selector, files, options);
  /// ```
  ///
  /// **Arguments**
  /// - `selector` String
  ///
  ///   A selector to search for an element. If there are multiple elements satisfying the selector, the first will be used.
  /// - `files` dynamic
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

    bool? strict,

    List<FrameDropPayloadsItems>? payloads,

    String? localDirectory,

    ChannelOwner? directoryStream,

    List<String>? localPaths,

    List<ChannelOwner>? streams,
  });
}

class FrameImpl extends FrameBase implements Frame {
  @override
  Frame? get parentFrame => typedInitializer.parentFrame as Frame?;

  @override
  List<Frame> get childFrames => objects.values.whereType<Frame>().toList();

  @override
  String get name => typedInitializer.name;

  @override
  Stream<Map<String, dynamic>> get onNavigated {
    return onEvent
        .where((e) => e['event'] == 'navigated')
        .map((e) => e['params']);
  }

  @override
  Stream<Map<String, dynamic>> get onLoadstate {
    return onEvent
        .where((e) => e['event'] == 'loadstate')
        .map((e) => e['params']);
  }

  FrameImpl(
    super.connection,

    super.channelType,

    super.guid,

    super.initializer, [

    super.parent,
  ]);

  @override
  String url() => typedInitializer.url;

  PageImpl? _page;

  void internalSetPage(PageImpl p) => _page = p;

  @override
  Page get page {
    if (_page != null) return _page!;

    // Fallback in case _page wasn't set (though it should be)

    var p = parent;

    while (p != null) {
      if (p is PageImpl) return p;

      p = p.parent;
    }

    throw StateError('Frame does not have a Page ancestor');
  }

  @override
  Locator locator(String selector) {
    return Locator(this, selector);
  }

  @override
  FrameLocator frameLocator(String selector) => FrameLocator(this, selector);

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
  Future<void> goto(
    String url, {

    double? timeout,

    LifecycleEvent? waitUntil,

    String? referer,
  }) async {
    Logger.debug('goto $url', name: 'playwright.frame');
    await channel_goto(
      url: url,

      timeout: timeout ?? (page as PageImpl).defaultNavigationTimeout,

      waitUntil: waitUntil ?? LifecycleEvent.load,

      referer: referer,
    );
    Logger.debug('navigated → $url', name: 'playwright.frame');
  }

  @override
  Future<String> textContent({
    required String selector,

    double? timeout,

    bool? strict,
  }) async {
    final result = await channel_textContent(
      selector: selector,

      timeout: timeout ?? 30000.0,

      strict: strict,
    );

    return result.value as String;
  }

  @override
  Future<dynamic> evaluate(String expression, [Object? arg]) async {
    Logger.debug('evaluate', name: 'playwright.frame');
    final result = await channel_evaluateExpression(
      expression: expression,

      arg: serializeArgument(arg),
    );

    return parseSerializedValue(result.value);
  }

  @override
  Future<FrameWaitForSelectorResult> waitForSelector(
    String selector, {

    FrameWaitForSelectorStateEnum? state,

    double? timeout,

    bool? strict,

    bool? omitReturnValue,
  }) async {
    return await channel_waitForSelector(
      selector: selector,

      state: state,

      timeout: timeout ?? (page as PageImpl).defaultTimeout,

      strict: strict,

      omitReturnValue: omitReturnValue,
    );
  }

  @override
  Future<void> waitForLoadState({
    LifecycleEvent? state = LifecycleEvent.load,

    double? timeout,
  }) async {
    final timeoutDuration = Duration(
      milliseconds: (timeout ?? (page as PageImpl).defaultTimeout).toInt(),
    );

    // Some events might have already occurred if we check the current state, but for simplicity

    // we wait for the next loadstate event matching our state. Playwright JS has a more complex Waiter.

    await onEvent
        .firstWhere(
          (e) =>
              e['event'] == 'loadstate' && e['params']['add'] == state?.value,
        )
        .timeout(
          timeoutDuration,

          onTimeout: () => throw Exception(
            'Timeout ${timeoutDuration.inMilliseconds}ms exceeded while waiting for $state',
          ),
        );
  }

  @override
  Future<void> waitForURL(
    RouteMatcher urlOrPredicate, {

    double? timeout,

    LifecycleEvent? waitUntil,
  }) async {
    final timeoutDuration = Duration(
      milliseconds: (timeout ?? (page as PageImpl).defaultTimeout).toInt(),
    );

    bool matches(String currentUrl) {
      if (urlOrPredicate is StringRouteMatcher) {
        return currentUrl.contains(urlOrPredicate.glob) ||
            RegExp(urlOrPredicate.glob).hasMatch(currentUrl);
      } else if (urlOrPredicate is RegExpRouteMatcher) {
        return urlOrPredicate.regex.hasMatch(currentUrl);
      } else if (urlOrPredicate is FunctionRouteMatcher) {
        return urlOrPredicate.predicate(currentUrl);
      }
      return false;
    }

    // Check if currently matching

    final currentUrl = url();

    if (matches(currentUrl)) {
      Logger.debug(
        'waitForURL: already at $urlOrPredicate',
        name: 'playwright.frame',
      );
      await waitForLoadState(state: waitUntil, timeout: timeout);

      return;
    }

    await onEvent
        .firstWhere((e) {
          if (e['event'] == 'navigated') {
            final targetUrl = e['params']['url'] as String;

            return matches(targetUrl);
          }

          return false;
        })
        .timeout(
          timeoutDuration,

          onTimeout: () => throw Exception(
            'Timeout ${timeoutDuration.inMilliseconds}ms exceeded while waiting for url $urlOrPredicate',
          ),
        );

    Logger.debug(
      'waitForURL: reached $urlOrPredicate',
      name: 'playwright.frame',
    );
    await waitForLoadState(state: waitUntil, timeout: timeout);
  }

  @override
  Future<void> waitForNavigation({
    RouteMatcher? url,

    LifecycleEvent? waitUntil,

    double? timeout,
  }) async {
    if (url != null) {
      await waitForURL(url, timeout: timeout, waitUntil: waitUntil);
    } else {
      final timeoutDuration = Duration(
        milliseconds: (timeout ?? (page as PageImpl).defaultTimeout).toInt(),
      );

      await onEvent
          .firstWhere((e) => e['event'] == 'navigated')
          .timeout(
            timeoutDuration,

            onTimeout: () => throw Exception(
              'Timeout ${timeoutDuration.inMilliseconds}ms exceeded while waiting for navigation',
            ),
          );

      await waitForLoadState(state: waitUntil, timeout: timeout);
    }
  }

  @override
  Future<void> dragAndDrop(
    String source,

    String target, {

    bool? force,

    double? timeout,

    bool? strict,

    bool? trial,

    Point? sourcePosition,

    Point? targetPosition,

    int? steps,
  }) async {
    Logger.debug('dragAndDrop "$source" → "$target"', name: 'playwright.frame');
    await channel_dragAndDrop(
      source: source,

      target: target,

      force: force,

      timeout: timeout ?? (page as PageImpl).defaultTimeout,

      strict: strict,

      trial: trial,

      sourcePosition: sourcePosition,

      targetPosition: targetPosition,

      steps: steps,
    );
  }

  @override
  Future<void> click(
    String selector, {

    bool? force,

    double? timeout,

    bool? strict,

    bool? trial,

    bool? noWaitAfter,

    List<FrameClickModifiersEnum>? modifiers,

    Point? position,

    double? delay,

    FrameClickButtonEnum? button,

    int? clickCount,

    int? steps,
  }) async {
    await channel_click(
      selector: selector,

      force: force,

      timeout: timeout ?? (page as PageImpl).defaultTimeout,

      strict: strict,

      trial: trial,

      modifiers: modifiers,

      position: position,

      delay: delay,

      button: button,

      clickCount: clickCount,

      steps: steps,
    );
  }

  @override
  Future<void> fill(
    String selector,

    String value, {

    bool? force,

    double? timeout,

    bool? strict,
  }) async {
    await channel_fill(
      selector: selector,

      value: value,

      force: force,

      timeout: timeout ?? (page as PageImpl).defaultTimeout,

      strict: strict,
    );
  }

  @override
  Future<void> check(
    String selector, {

    bool? force,

    double? timeout,

    bool? strict,

    bool? trial,

    Point? position,
  }) async {
    await channel_check(
      selector: selector,

      force: force,

      timeout: timeout ?? (page as PageImpl).defaultTimeout,

      strict: strict,

      trial: trial,

      position: position,
    );
  }

  @override
  Future<void> uncheck(
    String selector, {

    bool? force,

    double? timeout,

    bool? strict,

    bool? trial,

    Point? position,
  }) async {
    await channel_uncheck(
      selector: selector,

      force: force,

      timeout: timeout ?? (page as PageImpl).defaultTimeout,

      strict: strict,

      trial: trial,

      position: position,
    );
  }

  @override
  Future<void> setChecked(
    String selector,

    bool checked, {

    bool? force,

    double? timeout,

    bool? strict,

    bool? trial,

    Point? position,
  }) async {
    if (checked) {
      await check(
        selector,

        force: force,

        timeout: timeout,

        strict: strict,

        trial: trial,

        position: position,
      );
    } else {
      await uncheck(
        selector,

        force: force,

        timeout: timeout,

        strict: strict,

        trial: trial,

        position: position,
      );
    }
  }

  @override
  Future<void> hover(
    String selector, {

    bool? force,

    double? timeout,

    bool? strict,

    bool? trial,

    List<FrameHoverModifiersEnum>? modifiers,

    Point? position,
  }) async {
    await channel_hover(
      selector: selector,

      force: force,

      timeout: timeout ?? (page as PageImpl).defaultTimeout,

      strict: strict,

      trial: trial,

      modifiers: modifiers,

      position: position,
    );
  }

  @override
  Future<void> focus(String selector, {double? timeout, bool? strict}) async {
    await channel_focus(
      selector: selector,

      timeout: timeout ?? (page as PageImpl).defaultTimeout,

      strict: strict,
    );
  }

  @override
  Future<void> blur(String selector, {double? timeout, bool? strict}) async {
    await channel_blur(
      selector: selector,

      timeout: timeout ?? (page as PageImpl).defaultTimeout,

      strict: strict,
    );
  }

  @override
  Future<void> dblclick(
    String selector, {

    bool? force,

    double? timeout,

    bool? strict,

    bool? trial,

    List<FrameDblclickModifiersEnum>? modifiers,

    Point? position,

    double? delay,

    FrameDblclickButtonEnum? button,

    int? steps,
  }) async {
    await channel_dblclick(
      selector: selector,

      force: force,

      timeout: timeout ?? (page as PageImpl).defaultTimeout,

      strict: strict,

      trial: trial,

      modifiers: modifiers,

      position: position,

      delay: delay,

      button: button,

      steps: steps,
    );
  }

  @override
  Future<void> type(
    String selector,

    String text, {

    double? delay,

    double? timeout,

    bool? strict,
  }) async {
    await channel_type(
      selector: selector,

      text: text,

      delay: delay,

      timeout: timeout ?? (page as PageImpl).defaultTimeout,

      strict: strict,
    );
  }

  @override
  Future<void> press(
    String selector,

    String key, {

    double? delay,

    double? timeout,

    bool? strict,

    bool? noWaitAfter,
  }) async {
    await channel_press(
      selector: selector,

      key: key,

      delay: delay,

      timeout: timeout ?? (page as PageImpl).defaultTimeout,

      strict: strict,
    );
  }

  @override
  Future<void> tap(
    String selector, {

    bool? force,

    double? timeout,

    bool? strict,

    bool? trial,

    List<FrameTapModifiersEnum>? modifiers,

    Point? position,
  }) async {
    await channel_tap(
      selector: selector,

      force: force,

      timeout: timeout ?? (page as PageImpl).defaultTimeout,

      strict: strict,

      trial: trial,

      modifiers: modifiers,

      position: position,
    );
  }

  @override
  Future<String> content() async {
    final result = await channel_content();

    return result.value;
  }

  @override
  Future<void> setContent(
    String html, {

    double? timeout,

    LifecycleEvent? waitUntil,
  }) async {
    Logger.debug('setContent', name: 'playwright.frame');
    await channel_setContent(
      html: html,

      timeout: timeout ?? (page as PageImpl).defaultTimeout,

      waitUntil: waitUntil ?? LifecycleEvent.load,
    );
  }

  @override
  Future<dynamic> evalOnSelector(
    String selector,

    String expression, [

    Object? arg,

    bool? strict,

    bool? isFunction,
  ]) async {
    final result = await channel_evalOnSelector(
      selector: selector,

      expression: expression,

      arg: serializeArgument(arg),

      strict: strict,

      isFunction: isFunction,
    );

    return parseSerializedValue(result.value);
  }

  @override
  Future<dynamic> evalOnSelectorAll(
    String selector,

    String expression, [

    Object? arg,

    bool? isFunction,
  ]) async {
    final result = await channel_evalOnSelectorAll(
      selector: selector,

      expression: expression,

      arg: serializeArgument(arg),

      isFunction: isFunction,
    );

    return parseSerializedValue(result.value);
  }

  @override
  Future<String?> getAttribute(
    String selector,

    String name, {

    double? timeout,

    bool? strict,
  }) async {
    final result = await channel_getAttribute(
      selector: selector,

      name: name,

      timeout: timeout ?? (page as PageImpl).defaultTimeout,

      strict: strict,
    );

    return result.value;
  }

  @override
  Future<String> innerHTML(
    String selector, {

    double? timeout,

    bool? strict,
  }) async {
    final result = await channel_innerHTML(
      selector: selector,

      timeout: timeout ?? (page as PageImpl).defaultTimeout,

      strict: strict,
    );

    return result.value;
  }

  @override
  Future<String> innerText(
    String selector, {

    double? timeout,

    bool? strict,
  }) async {
    final result = await channel_innerText(
      selector: selector,

      timeout: timeout ?? (page as PageImpl).defaultTimeout,

      strict: strict,
    );

    return result.value;
  }

  @override
  Future<String> inputValue(
    String selector, {

    double? timeout,

    bool? strict,
  }) async {
    final result = await channel_inputValue(
      selector: selector,

      timeout: timeout ?? (page as PageImpl).defaultTimeout,

      strict: strict,
    );

    return result.value;
  }

  @override
  Future<String> title() async {
    final result = await channel_title();

    return result.value;
  }

  @override
  Future<bool> isChecked(
    String selector, {

    double? timeout,

    bool? strict,
  }) async {
    final result = await channel_isChecked(
      selector: selector,

      timeout: timeout ?? (page as PageImpl).defaultTimeout,

      strict: strict,
    );

    return result.value;
  }

  @override
  Future<bool> isDisabled(
    String selector, {

    double? timeout,

    bool? strict,
  }) async {
    final result = await channel_isDisabled(
      selector: selector,

      timeout: timeout ?? (page as PageImpl).defaultTimeout,

      strict: strict,
    );

    return result.value;
  }

  @override
  Future<bool> isEnabled(
    String selector, {

    double? timeout,

    bool? strict,
  }) async {
    final result = await channel_isEnabled(
      selector: selector,

      timeout: timeout ?? (page as PageImpl).defaultTimeout,

      strict: strict,
    );

    return result.value;
  }

  @override
  Future<bool> isHidden(String selector, {bool? strict}) async {
    final result = await channel_isHidden(selector: selector, strict: strict);

    return result.value;
  }

  @override
  Future<bool> isVisible(String selector, {bool? strict}) async {
    final result = await channel_isVisible(selector: selector, strict: strict);

    return result.value;
  }

  @override
  Future<bool> isEditable(
    String selector, {

    double? timeout,

    bool? strict,
  }) async {
    final result = await channel_isEditable(
      selector: selector,

      timeout: timeout ?? (page as PageImpl).defaultTimeout,

      strict: strict,
    );

    return result.value;
  }

  @override
  Future<void> addScriptTag({
    String? url,

    String? content,

    String? type,
  }) async {
    await channel_addScriptTag(url: url, content: content, type: type);
  }

  @override
  Future<void> addStyleTag({String? url, String? content}) async {
    await channel_addStyleTag(url: url, content: content);
  }

  @override
  Future<void> waitForTimeout(double waitTimeout) async {
    await channel_waitForTimeout(waitTimeout: waitTimeout);
  }

  @override
  Future<JSHandle> waitForFunction(
    String expression, {

    Object? arg,

    double? timeout,

    double? pollingInterval,

    bool? isFunction,
  }) async {
    final result = await channel_waitForFunction(
      expression: expression,

      arg: serializeArgument(arg),

      timeout: timeout ?? (page as PageImpl).defaultTimeout,

      pollingInterval: pollingInterval,

      isFunction: isFunction,
    );

    return result.handle as JSHandle;
  }

  @override
  Future<void> dispatchEvent(
    String selector,

    String type, {

    Map<String, dynamic>? eventInit,

    double? timeout,

    bool? strict,
  }) async {
    await channel_dispatchEvent(
      selector: selector,

      type: type,

      eventInit: serializeArgument(eventInit),

      timeout: timeout ?? 30000.0,

      strict: strict,
    );
  }

  @override
  Future<void> highlight(String selector, {String? style}) async {
    await channel_highlight(selector: selector, style: style);
  }

  @override
  Future<void> hideHighlight(String selector) async {
    await channel_hideHighlight(selector: selector);
  }

  @override
  Future<void> drop(
    String selector, {

    List<FrameDropPayloadsItems>? payloads,

    List<String>? localPaths,

    List<FrameDropDataItems>? data,

    bool? strict,

    double? timeout,

    Point? position,

    List<WritableStreamBase>? streams,
  }) async {
    await channel_drop(
      selector: selector,

      strict: strict,

      payloads: payloads,

      localPaths: localPaths,

      data: data,

      timeout: timeout ?? 30000.0,

      position: position,

      streams: streams,
    );
  }

  @override
  Future<FrameResolveSelectorResult> resolveSelector(String selector) async {
    return await channel_resolveSelector(selector: selector);
  }

  @override
  Future<FrameAriaSnapshotResult> ariaSnapshot(
    String selector, {

    FrameAriaSnapshotModeEnum? mode,

    String? track,

    int? depth,

    bool? boxes,

    double? timeout,
  }) async {
    return await channel_ariaSnapshot(
      selector: selector,

      mode: mode,

      track: track,

      depth: depth,

      boxes: boxes,

      timeout: timeout ?? 30000.0,
    );
  }

  @override
  Future<dynamic> evaluateExpression(
    String expression, {

    bool? isFunction,

    Object? arg,
  }) async {
    final result = await channel_evaluateExpression(
      expression: expression,

      isFunction: isFunction,

      arg: serializeArgument(arg),
    );

    return parseSerializedValue(result.value);
  }

  @override
  Future<JSHandle> evaluateExpressionHandle(
    String expression, {

    bool? isFunction,

    Object? arg,
  }) async {
    final result = await channel_evaluateExpressionHandle(
      expression: expression,

      isFunction: isFunction,

      arg: serializeArgument(arg),
    );

    return ChannelOwner.from(connection, result.handle as Map<String, dynamic>);
  }

  @override
  Future<ElementHandle> frameElement() async {
    final result = await channel_frameElement();

    return ChannelOwner.from(
      connection,

      result.element as Map<String, dynamic>,
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

    Object? expressionArg,

    FrameExpectPseudoEnum? pseudo,
  }) async {
    // channel_expect now returns void (protocol change in v1.61+).

    // Success means assertion passed → matches = !isNot.

    // Failure is thrown as an exception carrying the detail payload.

    try {
      await channel_expect(
        selector: selector,

        expression: expression,

        expectedValue: expectedValue,

        expectedText: expectedText,

        expectedNumber: expectedNumber,

        useInnerText: useInnerText,

        isNot: isNot,

        timeout: timeout ?? 30000.0,

        expressionArg: expressionArg,

        pseudo: pseudo,
      );

      return ExpectResult(matches: !isNot);
    } catch (e) {
      final msg = e.toString();

      return ExpectResult(
        matches: isNot,

        errorMessage: msg,

        timedOut: msg.contains('Timeout') || msg.contains('TimeoutError'),
      );
    }
  }

  @override
  Locator querySelector(String selector, {bool? strict}) {
    // strict parameter is accepted to satisfy types but locator handles strictness internally

    return locator(selector);
  }

  @override
  Future<List<Locator>> querySelectorAll(String selector) async {
    final result = await channel_querySelectorAll(selector: selector);

    final elements = result.elements as List? ?? [];

    return elements.map((_) => locator(selector)).toList();
  }

  @override
  Future<int> queryCount(String selector) async {
    final result = await channel_queryCount(selector: selector);

    return result.value;
  }

  @override
  Future<List<String>> selectOption(
    String selector,

    List<SelectOption>? values, {

    bool? force,

    double? timeout,

    bool? strict,

    List<ElementHandleBase>? elements,

    List<ElementHandleSelectOptionOptionsItems>? options,
  }) async {
    final parsed = parseSelectOptions(values);

    List<FrameSelectOptionOptionsItems>? finalOptions;

    if (options != null) {
      finalOptions = options
          .map(
            (e) => FrameSelectOptionOptionsItems(
              value: e.value,

              label: e.label,

              index: e.index,

              valueOrLabel: e.valueOrLabel,
            ),
          )
          .toList();
    } else if (parsed.options != null) {
      finalOptions = parsed.options!
          .map((e) => FrameSelectOptionOptionsItems.fromJson(e))
          .toList();
    }

    final result = await channel_selectOption(
      selector: selector,

      elements: elements ?? parsed.elements,

      options: finalOptions,

      strict: strict,

      force: force,

      timeout: timeout ?? 30000.0,
    );

    return (result.values as List).cast<String>();
  }

  @override
  Future<void> setInputFiles(
    String selector,

    List<InputFile>? files, {

    bool? noWaitAfter,

    double? timeout,

    bool? strict,

    List<FrameDropPayloadsItems>? payloads,

    String? localDirectory,

    ChannelOwner? directoryStream,

    List<String>? localPaths,

    List<ChannelOwner>? streams,
  }) async {
    final parsed = parseInputFiles(files);

    List<FrameSetInputFilesPayloadsItems>? finalPayloads;

    if (payloads != null) {
      finalPayloads = payloads
          .map(
            (e) => FrameSetInputFilesPayloadsItems(
              name: e.name,

              mimeType: e.mimeType,

              buffer: e.buffer,
            ),
          )
          .toList();
    } else if (parsed.payloads != null) {
      finalPayloads = parsed.payloads!
          .map((e) => FrameSetInputFilesPayloadsItems.fromJson(e))
          .toList();
    }

    await channel_setInputFiles(
      selector: selector,

      payloads: finalPayloads,

      localPaths: localPaths ?? parsed.localPaths,

      timeout: timeout ?? 30000.0,

      strict: strict,

      localDirectory: localDirectory,

      directoryStream: directoryStream as WritableStreamBase?,

      streams: streams?.cast<WritableStreamBase>(),
    );
  }
}
