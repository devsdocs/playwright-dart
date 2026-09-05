import '../interaction/interaction_types.dart';
import 'dart:convert';

import 'dart:typed_data';

import 'frame_locator.dart';

import 'frame.dart';

import 'page.dart';

import '../generated/channels.dart';

import '../infrastructure/serialization.dart';

import '../interaction/element_handle.dart';

import '../interaction/locator_assertions.dart';

import '../utils/locator_utils.dart';

import '../utils/logger.dart';

/// Locators are the central piece of Playwright's auto-waiting and retry-ability.

///

/// In a nutshell, locators represent a way to find element(s) on the page at any moment.

class Locator {
  /// The frame this locator belongs to.

  final Frame frame;

  /// The selector string for this locator.
  final String selector;

  /// Creates a new locator for the given [frame] and [selector].
  Locator(this.frame, this.selector);

  /// Returns an assertions object that provides web-first assertions for this locator.

  LocatorAssertions expect({double? timeout}) =>
      LocatorAssertions(this, false, timeout);

  /// Returns locator to the first matching element.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// locator.first();
  /// ```
  ///
  /// **Returns**
  /// - [Locator]
  Locator first() => locator('nth=0');

  /// Returns locator to the last matching element.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// final banana = await page.getByRole('listitem').last();
  /// ```
  ///
  /// **Returns**
  /// - [Locator]
  Locator last() => locator('nth=-1');

  /// Returns locator to the n-th matching element. It's zero based, `nth(0)` selects the first element.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// final banana = await page.getByRole('listitem').nth(2);
  /// ```
  ///
  /// **Arguments**
  /// - `index` num
  ///
  /// **Returns**
  /// - [Locator]
  Locator nth(int index) => locator('nth=$index');

  /// Creates a locator that matches both this locator and the argument locator.
  ///
  /// **Usage**
  ///
  /// The following example finds a button with a specific title.
  ///
  /// ```dart
  /// final button = page.getByRole('button').and(page.getByTitle('Subscribe'));
  /// ```
  ///
  /// **Arguments**
  /// - `locator` [Locator]
  ///
  ///   Additional locator to match.
  ///
  /// **Returns**
  /// - [Locator]
  Locator and(Locator other) {
    if (other.frame != frame) {
      throw Exception('Locators must belong to the same frame.');
    }

    return Locator(
      frame,

      '$selector >> internal:and=${jsonEncode(other.selector)}',
    );
  }

  /// Creates a locator matching all elements that match one or both of the two locators.
  ///
  /// Note that when both locators match something, the resulting locator will have multiple matches, potentially causing a [locator strictness] violation.
  ///
  /// **Usage**
  ///
  /// Consider a scenario where you'd like to click on a "New email" button, but sometimes a security settings dialog shows up instead. In this case, you can wait for either a "New email" button, or a dialog and act accordingly.
  ///
  /// **NOTE**
  /// If both "New email" button and security dialog appear on screen, the "or" locator will match both of them, possibly throwing the ["strict mode violation" error]. In this case, you can use [locator.first()] to only match one of them.
  /// ```dart
  /// final newEmail = page.getByRole('button', { name: 'New' );
  /// final dialog = page.getByText('Confirm security settings');
  /// await expect(newEmail.or(dialog).first()).toBeVisible();
  /// if (await dialog.isVisible())
  ///   await page.getByRole('button', { name: 'Dismiss' ).click();
  /// await newEmail.click();
  /// ```
  ///
  /// **Arguments**
  /// - `locator` [Locator]
  ///
  ///   Alternative locator to match.
  ///
  /// **Returns**
  /// - [Locator]
  Locator or(Locator other) {
    if (other.frame != frame) {
      throw Exception('Locators must belong to the same frame.');
    }

    return Locator(
      frame,

      '$selector >> internal:or=${jsonEncode(other.selector)}',
    );
  }

  /// This method narrows existing locator according to the options, for example filters by text. It can be chained to filter multiple times.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// final rowLocator = page.locator('tr');
  /// // ...
  /// await rowLocator
  ///     .filter( hasText: 'text in column 1' )
  ///     .filter( has: page.getByRole('button', { name: 'column 2 button' ) )
  ///     .screenshot();
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `has` Locator *(optional)*
  ///
  ///     Narrows down the results of the method to those which contain elements matching this relative locator. For example, `article` that has `text=Playwright` matches `<article><div>Playwright</div></article>`.
  ///
  ///     Inner locator **must be relative** to the outer locator and is queried starting with the outer locator match, not the document root. For example, you can find `content` that has `div` in `<article><content><div>Playwright</div></content></article>`. However, looking for `content` that has `article div` will fail, because the inner locator must be relative and should not use any elements outside the `content`.
  ///
  ///     Note that outer and inner locators must belong to the same frame. Inner locator must not contain [FrameLocator]s.
  ///   - `hasNot` Locator *(optional)*
  ///
  ///     Matches elements that do not contain an element that matches an inner locator. Inner locator is queried against the outer one. For example, `article` that does not have `div` matches `<article><span>Playwright</span></article>`.
  ///
  ///     Note that outer and inner locators must belong to the same frame. Inner locator must not contain [FrameLocator]s.
  ///   - `hasNotText` Pattern *(optional)*
  ///
  ///     Matches elements that do not contain specified text somewhere inside, possibly in a child or a descendant element. When passed a String, matching is case-insensitive and searches for a substring.
  ///   - `hasText` Pattern *(optional)*
  ///
  ///     Matches elements containing specified text somewhere inside, possibly in a child or a descendant element. When passed a String, matching is case-insensitive and searches for a substring. For example, `"Playwright"` matches `<article><div>Playwright</div></article>`.
  ///   - `visible` bool *(optional)*
  ///
  ///     Only matches visible or invisible elements.
  ///
  /// **Returns**
  /// - [Locator]
  Locator filter({
    Pattern? hasText,

    Locator? has,

    Pattern? hasNotText,

    Locator? hasNot,

    bool? visible,
  }) {
    var sel = selector;

    if (hasText != null) {
      if (hasText is RegExp) {
        sel += ' >> internal:has-text=${regExpToString(hasText)}';
      } else {
        sel += ' >> internal:has-text=${jsonEncode(hasText as String)}';
      }
    }

    if (has != null) {
      sel += ' >> internal:has=${jsonEncode(has.selector)}';
    }

    if (hasNotText != null) {
      if (hasNotText is RegExp) {
        sel += ' >> internal:has-not-text=${regExpToString(hasNotText)}';
      } else {
        sel += ' >> internal:has-not-text=${jsonEncode(hasNotText as String)}';
      }
    }

    if (hasNot != null) {
      sel += ' >> internal:has-not=${jsonEncode(hasNot.selector)}';
    }

    if (visible != null) {
      sel += ' >> visible=${visible ? 'true' : 'false'}';
    }

    return Locator(frame, sel);
  }

  /// Returns a [FrameLocator] object pointing to the same `iframe` as this locator.
  ///
  /// Useful when you have a [Locator] object obtained somewhere, and later on would like to interact with the content inside the frame.
  ///
  /// For a reverse operation, use [frameLocator.owner()].
  ///
  /// **Usage**
  ///
  /// ```dart
  /// final locator = page.locator('iframe[name="embedded"]');
  /// // ...
  /// final frameLocator = locator.contentFrame;
  /// await frameLocator.getByRole('button').click();
  /// ```
  ///
  /// **Returns**
  /// - [FrameLocator]
  FrameLocator get contentFrame => FrameLocator(frame, selector);

  /// When working with iframes, you can create a frame locator that will enter the iframe and allow locating elements in that iframe:
  ///
  /// **Usage**
  ///
  /// ```dart
  /// final locator = page.frameLocator('iframe').getByText('Submit');
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
  FrameLocator frameLocator(String selectorOrLocator) =>
      FrameLocator(frame, '$selector >> $selectorOrLocator');

  /// A page this locator belongs to.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// locator.page;
  /// ```
  ///
  /// **Returns**
  /// - [Page]
  Page get page => frame.page;

  /// Describes the locator, description is used in the trace viewer and reports. Returns the locator pointing to the same element.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// final button = page.getByTestId('btn-sub').describe('Subscribe button');
  /// await button.click();
  /// ```
  ///
  /// **Arguments**
  /// - `description` String
  ///
  ///   Locator description.
  ///
  /// **Returns**
  /// - [Locator]
  Locator describe(String description) => Locator(
    frame,

    '$selector >> internal:describe=${jsonEncode(description)}',
  );

  /// Returns locator description previously set with [locator.describe()]. Returns `null` if no custom description has been set. Prefer [locator.toString()] for a human-readable representation, as it uses the description when available.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// final button = page.getByRole('button').describe('Subscribe button');
  /// print(button.description()); // "Subscribe button"
  ///
  /// final input = page.getByRole('textbox');
  /// print(input.description()); // null
  /// ```
  ///
  /// **Returns**
  /// - [String]?
  String? description() {
    final match = RegExp(r'internal:describe=(.+)$').firstMatch(selector);
    if (match == null) return null;
    try {
      final raw = match.group(1)!;
      return jsonDecode(raw) as String?;
    } catch (_) {
      return null;
    }
  }

  /// Returns a human-readable representation of the locator, using the [locator.description()] if one exists; otherwise, it generates a string based on the locator's selector.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// locator.toString();
  /// ```
  ///
  /// **Returns**
  /// - String
  @override
  String toString() => description() ?? 'Locator@$selector';

  /// Returns a new locator that uses best practices for referencing the matched element, prioritizing test ids, aria roles, and other user-facing attributes over CSS selectors. This is useful for converting implementation-detail selectors into more resilient, human-readable locators.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await locator.normalize();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;[Locator]&gt;
  Future<Locator> normalize() async {
    final result = await frame.resolveSelector(selector);

    return Locator(frame, result.resolvedSelector);
  }

  Future<R> _withElement<R>(
    Future<R> Function(ElementHandle handle) task, {

    double? timeout,
  }) async {
    final result = await (frame as FrameImpl).channel.waitForSelector(
      selector: selector,

      state: SelectorState.attached,

      strict: true,

      timeout: timeout ?? 30000.0,
    );

    final handle = result.element;

    if (handle == null) {
      throw Exception('Could not resolve $selector to DOM Element');
    }

    try {
      return await task(handle as ElementHandle);
    } finally {
      await (handle as ElementHandleImpl).dispose();
    }
  }

  /// The method finds an element matching the specified selector in the locator's subtree. It also accepts filter options, similar to [locator.filter()] method.
  ///
  /// [Learn more about locators].
  ///
  /// **Usage**
  ///
  /// ```dart
  /// locator.locator(selectorOrLocator);
  /// locator.locator(selectorOrLocator, options);
  /// ```
  ///
  /// **Arguments**
  /// - `selectorOrLocator` String
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
  Locator locator(String selectorOrLocator) {
    return Locator(frame, '$selector >> $selectorOrLocator');
  }

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
    /// locator.locator(selectorOrLocator);
    /// locator.locator(selectorOrLocator, options);
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
    /// locator.locator(selectorOrLocator);
    /// locator.locator(selectorOrLocator, options);
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
    /// locator.locator(selectorOrLocator);
    /// locator.locator(selectorOrLocator, options);
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
    /// locator.locator(selectorOrLocator);
    /// locator.locator(selectorOrLocator, options);
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
    /// locator.locator(selectorOrLocator);
    /// locator.locator(selectorOrLocator, options);
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
    /// locator.locator(selectorOrLocator);
    /// locator.locator(selectorOrLocator, options);
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
    /// locator.locator(selectorOrLocator);
    /// locator.locator(selectorOrLocator, options);
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

  /// Click an element.

  ///

  /// It will wait for the element to be visible, enabled and stable.

  /// Click an element.
  ///
  /// **Usage**
  ///
  /// Click a button:
  ///
  /// ```dart
  /// await page.getByRole('button').click();
  /// ```
  ///
  /// Shift-right-click at a specific position on a canvas:
  ///
  /// ```dart
  /// await page.locator('canvas').click(
  ///   button: 'right',
  ///   modifiers: ['Shift'],
  ///   position: { x: 23, y: 32 },
  /// );
  /// ```
  ///
  /// **Arguments**
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
  ///   - `steps` num *(optional)*
  ///
  ///     Defaults to 1. Sends `n` interpolated `mousemove` events to represent travel between Playwright's current cursor position and the provided destination. When set to 1, emits a single `mousemove` event at the destination location.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///   - `trial` bool *(optional)*
  ///
  ///     When set, this method only performs the [actionability] checks and skips the action. Defaults to `false`. Useful to wait until the element is ready for the action without performing it. Note that keyboard `modifiers` will be pressed regardless of `trial` to allow testing elements which are only visible when those keys are pressed.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  ///
  /// **Details**
  ///
  /// This method clicks the element by performing the following steps:
  /// 1. Wait for [actionability] checks on the element, unless [force] option is set.
  /// 1. Scroll the element into view if needed.
  /// 1. Use [page.mouse] to click in the center of the element, or the specified [position].
  /// 1. Wait for initiated navigations to either succeed or fail, unless [noWaitAfter] option is set.
  ///
  /// If the element is detached from the DOM at any moment during the action, this method throws.
  ///
  /// When all steps combined have not finished during the specified [timeout], this method throws a [TimeoutError]. Passing zero timeout disables this.
  Future<void> click({bool? force, double? timeout}) async {
    Logger.debug('click "$selector"', name: 'playwright.locator');
    await (frame as FrameImpl).channel.click(
      selector: selector,

      force: force,

      timeout: timeout ?? 30000.0,
    );
  }

  /// Fills an `<input>`, `<textarea>` or `[contenteditable]` element with the provided value.

  /// Set a value to the input field.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await page.getByRole('textbox').fill('example value');
  /// ```
  ///
  /// **Arguments**
  /// - `value` String
  ///
  ///   Value to set for the `<input>`, `<textarea>` or `[contenteditable]` element.
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
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  ///
  /// **Details**
  ///
  /// This method waits for [actionability] checks, focuses the element, fills it and triggers an `input` event after filling. Note that you can pass an empty string to clear the input field.
  ///
  /// If the target element is not an `<input>`, `<textarea>` or `[contenteditable]` element, this method throws an error. However, if the element is inside the `<label>` element that has an associated [control], the control will be filled instead.
  ///
  /// To send fine-grained keyboard events, use [locator.pressSequentially()].
  Future<void> fill(String value, {bool? force, double? timeout}) async {
    Logger.debug('fill "$selector" ← "$value"', name: 'playwright.locator');
    await (frame as FrameImpl).channel.fill(
      selector: selector,

      value: value,

      force: force,

      timeout: timeout ?? 30000.0,
    );
  }

  /// Clears the input element by filling it with an empty string.

  /// Clear the input field.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await page.getByRole('textbox').clear();
  /// ```
  ///
  /// **Arguments**
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
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  ///
  /// **Details**
  ///
  /// This method waits for [actionability] checks, focuses the element, clears it and triggers an `input` event after clearing.
  ///
  /// If the target element is not an `<input>`, `<textarea>` or `[contenteditable]` element, this method throws an error. However, if the element is inside the `<label>` element that has an associated [control], the control will be cleared instead.
  Future<void> clear({bool? force, double? timeout}) =>
      /// Set a value to the input field.
      ///
      /// **Usage**
      ///
      /// ```dart
      /// await page.getByRole('textbox').fill('example value');
      /// ```
      ///
      /// **Arguments**
      /// - `value` String
      ///
      ///   Value to set for the `<input>`, `<textarea>` or `[contenteditable]` element.
      /// - `options` Map *(optional)*
      ///   - `force` force: *(optional)*
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
      ///   - `timeout` timeout: *(optional)*
      ///
      ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
      ///
      /// **Returns**
      /// - Future&lt;void&gt;
      ///
      /// **Details**
      ///
      /// This method waits for [actionability] checks, focuses the element, fills it and triggers an `input` event after filling. Note that you can pass an empty string to clear the input field.
      ///
      /// If the target element is not an `<input>`, `<textarea>` or `[contenteditable]` element, this method throws an error. However, if the element is inside the `<label>` element that has an associated [control], the control will be filled instead.
      ///
      /// To send fine-grained keyboard events, use [locator.pressSequentially()].
      fill('', force: force, timeout: timeout);

  /// Set the state of a checkbox or a radio element.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await page.getByRole('checkbox').setChecked(true);
  /// ```
  ///
  /// **Arguments**
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
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///   - `trial` bool *(optional)*
  ///
  ///     When set, this method only performs the [actionability] checks and skips the action. Defaults to `false`. Useful to wait until the element is ready for the action without performing it.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  ///
  /// **Details**
  ///
  /// This method checks or unchecks an element by performing the following steps:
  /// 1. Ensure that matched element is a checkbox or a radio input. If not, this method throws.
  /// 1. If the element already has the right checked state, this method returns immediately.
  /// 1. Wait for [actionability] checks on the matched element, unless [force] option is set. If the element is detached during the checks, the whole action is retried.
  /// 1. Scroll the element into view if needed.
  /// 1. Use [page.mouse] to click in the center of the element.
  /// 1. Ensure that the element is now checked or unchecked. If not, this method throws.
  ///
  /// When all steps combined have not finished during the specified [timeout], this method throws a [TimeoutError]. Passing zero timeout disables this.
  Future<void> setChecked(bool checked, {bool? force, double? timeout}) async {
    if (checked) {
      /// Ensure that checkbox or radio element is checked.
      ///
      /// **Usage**
      ///
      /// ```dart
      /// await page.getByRole('checkbox').check();
      /// ```
      ///
      /// **Arguments**
      /// - `options` Map *(optional)*
      ///   - `force` force: *(optional)*
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
      ///   - `timeout` timeout: *(optional)*
      ///
      ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
      ///   - `trial` bool *(optional)*
      ///
      ///     When set, this method only performs the [actionability] checks and skips the action. Defaults to `false`. Useful to wait until the element is ready for the action without performing it.
      ///
      /// **Returns**
      /// - Future&lt;void&gt;
      ///
      /// **Details**
      ///
      /// Performs the following steps:
      /// 1. Ensure that element is a checkbox or a radio input. If not, this method throws. If the element is already checked, this method returns immediately.
      /// 1. Wait for [actionability] checks on the element, unless [force] option is set.
      /// 1. Scroll the element into view if needed.
      /// 1. Use [page.mouse] to click in the center of the element.
      /// 1. Ensure that the element is now checked. If not, this method throws.
      ///
      /// If the element is detached from the DOM at any moment during the action, this method throws.
      ///
      /// When all steps combined have not finished during the specified [timeout], this method throws a [TimeoutError]. Passing zero timeout disables this.
      await check(force: force, timeout: timeout);

      /// Ensure that checkbox or radio element is unchecked.
      ///
      /// **Usage**
      ///
      /// ```dart
      /// await page.getByRole('checkbox').uncheck();
      /// ```
      ///
      /// **Arguments**
      /// - `options` Map *(optional)*
      ///   - `force` force: *(optional)*
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
      ///   - `timeout` timeout: *(optional)*
      ///
      ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
      ///   - `trial` bool *(optional)*
      ///
      ///     When set, this method only performs the [actionability] checks and skips the action. Defaults to `false`. Useful to wait until the element is ready for the action without performing it.
      ///
      /// **Returns**
      /// - Future&lt;void&gt;
      ///
      /// **Details**
      ///
      /// This method unchecks the element by performing the following steps:
      /// 1. Ensure that element is a checkbox or a radio input. If not, this method throws. If the element is already unchecked, this method returns immediately.
      /// 1. Wait for [actionability] checks on the element, unless [force] option is set.
      /// 1. Scroll the element into view if needed.
      /// 1. Use [page.mouse] to click in the center of the element.
      /// 1. Ensure that the element is now unchecked. If not, this method throws.
      ///
      /// If the element is detached from the DOM at any moment during the action, this method throws.
      ///
      /// When all steps combined have not finished during the specified [timeout], this method throws a [TimeoutError]. Passing zero timeout disables this.
    } else {
      await uncheck(force: force, timeout: timeout);
    }
  }

  /// Ensure that checkbox or radio element is checked.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await page.getByRole('checkbox').check();
  /// ```
  ///
  /// **Arguments**
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
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///   - `trial` bool *(optional)*
  ///
  ///     When set, this method only performs the [actionability] checks and skips the action. Defaults to `false`. Useful to wait until the element is ready for the action without performing it.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  ///
  /// **Details**
  ///
  /// Performs the following steps:
  /// 1. Ensure that element is a checkbox or a radio input. If not, this method throws. If the element is already checked, this method returns immediately.
  /// 1. Wait for [actionability] checks on the element, unless [force] option is set.
  /// 1. Scroll the element into view if needed.
  /// 1. Use [page.mouse] to click in the center of the element.
  /// 1. Ensure that the element is now checked. If not, this method throws.
  ///
  /// If the element is detached from the DOM at any moment during the action, this method throws.
  ///
  /// When all steps combined have not finished during the specified [timeout], this method throws a [TimeoutError]. Passing zero timeout disables this.
  Future<void> check({bool? force, double? timeout}) async {
    Logger.debug('check "$selector"', name: 'playwright.locator');
    await (frame as FrameImpl).channel.check(
      selector: selector,

      force: force,

      timeout: timeout ?? 30000.0,
    );
  }

  /// Ensure that checkbox or radio element is unchecked.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await page.getByRole('checkbox').uncheck();
  /// ```
  ///
  /// **Arguments**
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
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///   - `trial` bool *(optional)*
  ///
  ///     When set, this method only performs the [actionability] checks and skips the action. Defaults to `false`. Useful to wait until the element is ready for the action without performing it.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  ///
  /// **Details**
  ///
  /// This method unchecks the element by performing the following steps:
  /// 1. Ensure that element is a checkbox or a radio input. If not, this method throws. If the element is already unchecked, this method returns immediately.
  /// 1. Wait for [actionability] checks on the element, unless [force] option is set.
  /// 1. Scroll the element into view if needed.
  /// 1. Use [page.mouse] to click in the center of the element.
  /// 1. Ensure that the element is now unchecked. If not, this method throws.
  ///
  /// If the element is detached from the DOM at any moment during the action, this method throws.
  ///
  /// When all steps combined have not finished during the specified [timeout], this method throws a [TimeoutError]. Passing zero timeout disables this.
  Future<void> uncheck({bool? force, double? timeout}) async {
    Logger.debug('uncheck "$selector"', name: 'playwright.locator');
    await (frame as FrameImpl).channel.uncheck(
      selector: selector,

      force: force,

      timeout: timeout ?? 30000.0,
    );
  }

  /// Returns the [`element.innerText`].
  ///
  /// **WARNING**
  /// [Asserting text]
  ///
  /// If you need to assert text on the page, prefer [expect(locator).toHaveText()] with [useInnerText] option to avoid flakiness. See [assertions guide] for more details.
  /// **Usage**
  ///
  /// ```dart
  /// await locator.innerText();
  /// await locator.innerText(options);
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     Allows to cancel the operation using an [`AbortSignal`]. If the signal is aborted, the operation will be aborted and throw an error. Note that providing a signal does not disable the default timeout, which can be changed using [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()]; pass `timeout: 0` to disable the timeout entirely.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;String&gt;
  Future<String> innerText({double? timeout}) async {
    final result = await (frame as FrameImpl).channel.innerText(
      selector: selector,

      timeout: timeout ?? 30000.0,
    );

    return result.value;
  }

  /// Returns the [`node.textContent`].
  ///
  /// **WARNING**
  /// [Asserting text]
  ///
  /// If you need to assert text on the page, prefer [expect(locator).toHaveText()] to avoid flakiness. See [assertions guide] for more details.
  /// **Usage**
  ///
  /// ```dart
  /// await locator.textContent();
  /// await locator.textContent(options);
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     Allows to cancel the operation using an [`AbortSignal`]. If the signal is aborted, the operation will be aborted and throw an error. Note that providing a signal does not disable the default timeout, which can be changed using [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()]; pass `timeout: 0` to disable the timeout entirely.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;[String&gt;]?
  Future<String> textContent({double? timeout}) async {
    final result = await (frame as FrameImpl).channel.textContent(
      selector: selector,

      timeout: timeout ?? 30000.0,
    );

    return result.value as String;
  }

  /// Hovers over the element.

  /// Hover over the matching element.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await page.getByRole('link').hover();
  /// ```
  ///
  /// **Arguments**
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
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///   - `trial` bool *(optional)*
  ///
  ///     When set, this method only performs the [actionability] checks and skips the action. Defaults to `false`. Useful to wait until the element is ready for the action without performing it. Note that keyboard `modifiers` will be pressed regardless of `trial` to allow testing elements which are only visible when those keys are pressed.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  ///
  /// **Details**
  ///
  /// This method hovers over the element by performing the following steps:
  /// 1. Wait for [actionability] checks on the element, unless [force] option is set.
  /// 1. Scroll the element into view if needed.
  /// 1. Use [page.mouse] to hover over the center of the element, or the specified [position].
  ///
  /// If the element is detached from the DOM at any moment during the action, this method throws.
  ///
  /// When all steps combined have not finished during the specified [timeout], this method throws a [TimeoutError]. Passing zero timeout disables this.
  Future<void> hover({bool? force, double? timeout}) async {
    Logger.debug('hover "$selector"', name: 'playwright.locator');
    await (frame as FrameImpl).channel.hover(
      selector: selector,

      force: force,

      timeout: timeout ?? 30000.0,
    );
  }

  /// Calls [focus] on the matching element.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await locator.focus();
  /// await locator.focus(options);
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     Allows to cancel the operation using an [`AbortSignal`]. If the signal is aborted, the operation will be aborted and throw an error. Note that providing a signal does not disable the default timeout, which can be changed using [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()]; pass `timeout: 0` to disable the timeout entirely.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> focus({double? timeout}) async {
    Logger.debug('focus "$selector"', name: 'playwright.locator');
    await (frame as FrameImpl).channel.focus(
      selector: selector,

      timeout: timeout ?? 30000.0,
    );
  }

  /// Calls [blur] on the element.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await locator.blur();
  /// await locator.blur(options);
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     Allows to cancel the operation using an [`AbortSignal`]. If the signal is aborted, the operation will be aborted and throw an error. Note that providing a signal does not disable the default timeout, which can be changed using [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()]; pass `timeout: 0` to disable the timeout entirely.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> blur({double? timeout}) async {
    Logger.debug('blur "$selector"', name: 'playwright.locator');
    await (frame as FrameImpl).channel.blur(
      selector: selector,

      timeout: timeout ?? 30000.0,
    );
  }

  /// Double-click an element.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await locator.dblclick();
  /// await locator.dblclick(options);
  /// ```
  ///
  /// **Arguments**
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
  ///   - `steps` num *(optional)*
  ///
  ///     Defaults to 1. Sends `n` interpolated `mousemove` events to represent travel between Playwright's current cursor position and the provided destination. When set to 1, emits a single `mousemove` event at the destination location.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///   - `trial` bool *(optional)*
  ///
  ///     When set, this method only performs the [actionability] checks and skips the action. Defaults to `false`. Useful to wait until the element is ready for the action without performing it. Note that keyboard `modifiers` will be pressed regardless of `trial` to allow testing elements which are only visible when those keys are pressed.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  ///
  /// **Details**
  ///
  /// This method double clicks the element by performing the following steps:
  /// 1. Wait for [actionability] checks on the element, unless [force] option is set.
  /// 1. Scroll the element into view if needed.
  /// 1. Use [page.mouse] to double click in the center of the element, or the specified [position].
  ///
  /// If the element is detached from the DOM at any moment during the action, this method throws.
  ///
  /// When all steps combined have not finished during the specified [timeout], this method throws a [TimeoutError]. Passing zero timeout disables this.
  ///
  /// **NOTE**
  /// `element.dblclick()` dispatches two `click` events and a single `dblclick` event.
  Future<void> dblclick({bool? force, double? timeout}) async {
    Logger.debug('dblclick "$selector"', name: 'playwright.locator');
    await (frame as FrameImpl).channel.dblclick(
      selector: selector,

      force: force,

      timeout: timeout ?? 30000.0,
    );
  }

  /// Returns the matching element's attribute value.
  ///
  /// **WARNING**
  /// [Asserting attributes]
  ///
  /// If you need to assert an element's attribute, prefer [expect(locator).toHaveAttribute()] to avoid flakiness. See [assertions guide] for more details.
  /// **Usage**
  ///
  /// ```dart
  /// await locator.getAttribute(name);
  /// await locator.getAttribute(name, options);
  /// ```
  ///
  /// **Arguments**
  /// - `name` String
  ///
  ///   Attribute name to get the value for.
  /// - `options` Map *(optional)*
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     Allows to cancel the operation using an [`AbortSignal`]. If the signal is aborted, the operation will be aborted and throw an error. Note that providing a signal does not disable the default timeout, which can be changed using [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()]; pass `timeout: 0` to disable the timeout entirely.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;[String&gt;]?
  Future<String?> getAttribute(String name, {double? timeout}) async {
    final result = await (frame as FrameImpl).channel.getAttribute(
      selector: selector,

      name: name,

      timeout: timeout ?? 30000.0,
    );

    return result.value;
  }

  /// Returns the value for the matching `<input>` or `<textarea>` or `<select>` element.
  ///
  /// **WARNING**
  /// [Asserting value]
  ///
  /// If you need to assert input value, prefer [expect(locator).toHaveValue()] to avoid flakiness. See [assertions guide] for more details.
  /// **Usage**
  ///
  /// ```dart
  /// final value = await page.getByRole('textbox').inputValue();
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     Allows to cancel the operation using an [`AbortSignal`]. If the signal is aborted, the operation will be aborted and throw an error. Note that providing a signal does not disable the default timeout, which can be changed using [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()]; pass `timeout: 0` to disable the timeout entirely.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;String&gt;
  ///
  /// **Details**
  ///
  /// Throws elements that are not an input, textarea or a select. However, if the element is inside the `<label>` element that has an associated [control], returns the value of the control.
  Future<String> inputValue({double? timeout}) async {
    final result = await (frame as FrameImpl).channel.inputValue(
      selector: selector,

      timeout: timeout ?? 30000.0,
    );

    return result.value;
  }

  /// Returns whether the element is visible.

  /// Returns whether the element is [visible].
  ///
  /// **WARNING**
  /// [Asserting visibility]
  ///
  /// If you need to assert that element is visible, prefer [expect(locator).toBeVisible()] to avoid flakiness. See [assertions guide] for more details.
  /// **Usage**
  ///
  /// ```dart
  /// final visible = await page.getByRole('button').isVisible();
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `timeout` num *(optional)*
  ///
  ///     **WARNING**
  /// [Deprecated]
  ///     This option is ignored. [locator.isVisible()] does not wait for the element to become visible and returns immediately.
  ///     **Returns**
  /// - Future&lt;bool&gt;
  Future<bool> isVisible() async {
    final result = await (frame as FrameImpl).channel.isVisible(
      selector: selector,
    );

    return result.value;
  }

  /// Returns the [`element.innerHTML`].
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await locator.innerHTML();
  /// await locator.innerHTML(options);
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     Allows to cancel the operation using an [`AbortSignal`]. If the signal is aborted, the operation will be aborted and throw an error. Note that providing a signal does not disable the default timeout, which can be changed using [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()]; pass `timeout: 0` to disable the timeout entirely.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;String&gt;
  Future<String> innerHTML({double? timeout}) async {
    final result = await (frame as FrameImpl).channel.innerHTML(
      selector: selector,

      timeout: timeout ?? 30000.0,
    );

    return result.value;
  }

  /// Returns whether the element is [editable]. If the target element is not an `<input>`, `<textarea>`, `<select>`, `[contenteditable]` and does not have a role allowing `[aria-readonly]`, this method throws an error.
  ///
  /// **WARNING**
  /// [Asserting editable state]
  ///
  /// If you need to assert that an element is editable, prefer [expect(locator).toBeEditable()] to avoid flakiness. See [assertions guide] for more details.
  /// **Usage**
  ///
  /// ```dart
  /// final editable = await page.getByRole('textbox').isEditable();
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     Allows to cancel the operation using an [`AbortSignal`]. If the signal is aborted, the operation will be aborted and throw an error. Note that providing a signal does not disable the default timeout, which can be changed using [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()]; pass `timeout: 0` to disable the timeout entirely.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;bool&gt;
  Future<bool> isEditable({double? timeout}) async {
    final result = await (frame as FrameImpl).channel.isEditable(
      selector: selector,

      timeout: timeout ?? 30000.0,
    );

    return result.value;
  }

  /// Returns whether the element is hidden, the opposite of [visible].
  ///
  /// **WARNING**
  /// [Asserting visibility]
  ///
  /// If you need to assert that element is hidden, prefer [expect(locator).toBeHidden()] to avoid flakiness. See [assertions guide] for more details.
  /// **Usage**
  ///
  /// ```dart
  /// final hidden = await page.getByRole('button').isHidden();
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `timeout` num *(optional)*
  ///
  ///     **WARNING**
  /// [Deprecated]
  ///     This option is ignored. [locator.isHidden()] does not wait for the element to become hidden and returns immediately.
  ///     **Returns**
  /// - Future&lt;bool&gt;
  Future<bool> isHidden() async {
    final result = await (frame as FrameImpl).channel.isHidden(
      selector: selector,
    );

    return result.value;
  }

  /// Returns whether the element is enabled.

  /// Returns whether the element is [enabled].
  ///
  /// **WARNING**
  /// [Asserting enabled state]
  ///
  /// If you need to assert that an element is enabled, prefer [expect(locator).toBeEnabled()] to avoid flakiness. See [assertions guide] for more details.
  /// **Usage**
  ///
  /// ```dart
  /// final enabled = await page.getByRole('button').isEnabled();
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     Allows to cancel the operation using an [`AbortSignal`]. If the signal is aborted, the operation will be aborted and throw an error. Note that providing a signal does not disable the default timeout, which can be changed using [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()]; pass `timeout: 0` to disable the timeout entirely.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;bool&gt;
  Future<bool> isEnabled({double? timeout}) async {
    final result = await (frame as FrameImpl).channel.isEnabled(
      selector: selector,

      timeout: timeout ?? 30000.0,
    );

    return result.value;
  }

  /// Returns whether the element is disabled, the opposite of [enabled].
  ///
  /// **WARNING**
  /// [Asserting disabled state]
  ///
  /// If you need to assert that an element is disabled, prefer [expect(locator).toBeDisabled()] to avoid flakiness. See [assertions guide] for more details.
  /// **Usage**
  ///
  /// ```dart
  /// final disabled = await page.getByRole('button').isDisabled();
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     Allows to cancel the operation using an [`AbortSignal`]. If the signal is aborted, the operation will be aborted and throw an error. Note that providing a signal does not disable the default timeout, which can be changed using [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()]; pass `timeout: 0` to disable the timeout entirely.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;bool&gt;
  Future<bool> isDisabled({double? timeout}) async {
    final result = await (frame as FrameImpl).channel.isDisabled(
      selector: selector,

      timeout: timeout ?? 30000.0,
    );

    return result.value;
  }

  /// Returns whether the element is checked. Throws if the element is not a checkbox or radio input.
  ///
  /// **WARNING**
  /// [Asserting checked state]
  ///
  /// If you need to assert that checkbox is checked, prefer [expect(locator).toBeChecked()] to avoid flakiness. See [assertions guide] for more details.
  /// **Usage**
  ///
  /// ```dart
  /// final checked = await page.getByRole('checkbox').isChecked();
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     Allows to cancel the operation using an [`AbortSignal`]. If the signal is aborted, the operation will be aborted and throw an error. Note that providing a signal does not disable the default timeout, which can be changed using [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()]; pass `timeout: 0` to disable the timeout entirely.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;bool&gt;
  Future<bool> isChecked({double? timeout}) async {
    final result = await (frame as FrameImpl).channel.isChecked(
      selector: selector,

      timeout: timeout ?? 30000.0,
    );

    return result.value;
  }

  /// Execute JavaScript code in the page, taking all matching elements as an argument.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// final locator = page.locator('div');
  /// final moreThanTen = await locator.evaluateAll((divs, min) => divs.length > min, 10);
  /// ```
  ///
  /// **Arguments**
  /// - `pageFunction` Function | String
  ///
  ///   Function to be evaluated in the page context.
  /// - `arg` Object *(optional)*
  ///
  ///   Optional argument to pass to [pageFunction].
  ///
  /// **Returns**
  /// - Future&lt;[Serializable]&gt;
  ///
  /// **Details**
  ///
  /// Returns the return value of [pageFunction], called with an array of all matching elements as a first argument, and [arg] as a second argument.
  ///
  /// If [pageFunction] returns a Future, this method will wait for the future to complete and return its value.
  ///
  /// If [pageFunction] throws or rejects, this method throws.
  Future<T> evaluateAll<T>(String expression, [Object? arg]) async {
    return frame.evalOnSelectorAll(selector, expression, arg);
  }

  /// **WARNING**
  /// [Deprecated]
  ///
  /// In most cases, you should use [locator.fill()] instead. You only need to press keys one by one if there is special keyboard handling on the page - in this case use [locator.pressSequentially()].
  ///
  /// Focuses the element, and then sends a `keydown`, `keypress`/`input`, and `keyup` event for each character in the text.
  ///
  /// To press a special key, like `Control` or `ArrowDown`, use [locator.press()].
  ///
  /// **Usage**
  ///
  /// **Arguments**
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
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
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
  Future<void> type(String text, {double? delay, double? timeout}) async {
    Logger.debug('type "$selector" ← "$text"', name: 'playwright.locator');
    await (frame as FrameImpl).channel.type(
      selector: selector,

      text: text,

      delay: delay,

      timeout: timeout ?? 30000.0,
    );
  }

  /// Types text character by character. Alias for [type].

  /// In most cases, you should use [locator.fill()] instead. You only need to press keys one by one if there is special keyboard handling on the page.
  /// Focuses the element, and then sends a `keydown`, `keypress`/`input`, and `keyup` event for each character in the text.
  ///
  /// To press a special key, like `Control` or `ArrowDown`, use [locator.press()].
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await locator.pressSequentially('Hello'); // Types instantly
  /// await locator.pressSequentially('World', { delay: 100 ); // Types slower, like a user
  /// ```
  ///
  /// An example of typing into a text field and then submitting the form:
  ///
  /// ```dart
  /// final locator = page.getByLabel('Password');
  /// await locator.pressSequentially('my password');
  /// await locator.press('Enter');
  /// ```
  ///
  /// **Arguments**
  /// - `text` String
  ///
  ///   String of characters to sequentially press into a focused element.
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
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> pressSequentially(
    String text, {

    double? delay,

    double? timeout,
  }) => type(text, delay: delay, timeout: timeout);

  /// Focuses the element, and then uses keyboard to press the given key.

  /// Focuses the matching element and presses a combination of the keys.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await page.getByRole('textbox').press('Backspace');
  /// ```
  ///
  /// **Arguments**
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
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  ///
  /// **Details**
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
  Future<void> press(String key, {double? delay, double? timeout}) async {
    Logger.debug('press "$selector" ← "$key"', name: 'playwright.locator');
    await (frame as FrameImpl).channel.press(
      selector: selector,

      key: key,

      delay: delay,

      timeout: timeout ?? 30000.0,
    );
  }

  /// Perform a tap gesture on the element matching the locator. For examples of emulating other gestures by manually dispatching touch events, see the [emulating legacy touch events] page.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await locator.tap();
  /// await locator.tap(options);
  /// ```
  ///
  /// **Arguments**
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
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///   - `trial` bool *(optional)*
  ///
  ///     When set, this method only performs the [actionability] checks and skips the action. Defaults to `false`. Useful to wait until the element is ready for the action without performing it. Note that keyboard `modifiers` will be pressed regardless of `trial` to allow testing elements which are only visible when those keys are pressed.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  ///
  /// **Details**
  ///
  /// This method taps the element by performing the following steps:
  /// 1. Wait for [actionability] checks on the element, unless [force] option is set.
  /// 1. Scroll the element into view if needed.
  /// 1. Use [page.touchscreen] to tap the center of the element, or the specified [position].
  ///
  /// If the element is detached from the DOM at any moment during the action, this method throws.
  ///
  /// When all steps combined have not finished during the specified [timeout], this method throws a [TimeoutError]. Passing zero timeout disables this.
  ///
  /// **NOTE**
  /// `element.tap()` requires that the `hasTouch` option of the browser context be set to true.
  Future<void> tap({bool? force, double? timeout}) async {
    Logger.debug('tap "$selector"', name: 'playwright.locator');
    await (frame as FrameImpl).channel.tap(
      selector: selector,

      force: force,

      timeout: timeout ?? 30000.0,
    );
  }

  /// Selects one or multiple options in the `<select>` element.

  /// Selects option or options in `<select>`.
  ///
  /// **Usage**
  ///
  /// ```html
  /// <select multiple>
  ///   <option value="red">Red</option>
  ///   <option value="green">Green</option>
  ///   <option value="blue">Blue</option>
  /// </select>
  /// ```
  ///
  /// ```dart
  /// // single selection matching the value or label
  /// element.selectOption('blue');
  ///
  /// // single selection matching the label
  /// element.selectOption( label: 'Blue' );
  ///
  /// // multiple selection for red, green and blue options
  /// element.selectOption(['red', 'green', 'blue']);
  /// ```
  ///
  /// **Arguments**
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
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;List&lt;String&gt;&gt;
  ///
  /// **Details**
  ///
  /// This method waits for [actionability] checks, waits until all specified options are present in the `<select>` element and selects these options.
  ///
  /// If the target element is not a `<select>` element, this method throws an error. However, if the element is inside the `<label>` element that has an associated [control], the control will be used instead.
  ///
  /// Returns the array of option values that have been successfully selected.
  ///
  /// Triggers a `change` and `input` event once all the provided options have been selected.
  Future<List<String>> selectOption(
    List<SelectOption>? values, {

    bool? force,

    double? timeout,
  }) async {
    return frame.selectOption(selector, values, force: force, timeout: timeout);
  }

  /// Upload file or multiple files into `<input type=file>`. For inputs with a `[webkitdirectory]` attribute, only a single directory path is supported.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// // Select one file
  /// await page.getByLabel('Upload file').setInputFiles(path.join(__dirname, 'myfile.pdf'));
  ///
  /// // Select multiple files
  /// await page.getByLabel('Upload files').setInputFiles([
  ///   path.join(__dirname, 'file1.txt'),
  ///   path.join(__dirname, 'file2.txt'),
  /// ]);
  ///
  /// // Select a directory
  /// await page.getByLabel('Upload directory').setInputFiles(path.join(__dirname, 'mydir'));
  ///
  /// // Remove all the selected files
  /// await page.getByLabel('Upload file').setInputFiles([]);
  ///
  /// // Upload buffer from memory
  /// await page.getByLabel('Upload file').setInputFiles(
  ///   name: 'file.txt',
  ///   mimeType: 'text/plain',
  ///   buffer: utf8.encode('this is test')
  /// );
  /// ```
  ///
  /// **Arguments**
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
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  ///
  /// **Details**
  ///
  /// Sets the value of the file input to these file paths or files. If some of the `filePaths` are relative paths, then they are resolved relative to the current working directory. For empty array, clears the selected files.
  ///
  /// This method expects [Locator] to point to an [input element]. However, if the element is inside the `<label>` element that has an associated [control], targets the control instead.
  Future<void> setInputFiles(
    List<InputFile>? files, {

    bool? noWaitAfter,

    double? timeout,
  }) async {
    await frame.setInputFiles(
      selector,

      files,

      noWaitAfter: noWaitAfter,

      timeout: timeout,
    );
  }

  /// Programmatically dispatch an event on the matching element.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await locator.dispatchEvent('click');
  /// ```
  ///
  /// **Arguments**
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
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  ///
  /// **Details**
  ///
  /// The snippet above dispatches the `click` event on the element. Regardless of the visibility state of the element, `click` is dispatched. This is equivalent to calling [element.click()].
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
  /// You can also specify [JSHandle] as the property value if you want live objects to be passed into the event:
  ///
  /// ```dart
  /// final dataTransfer = await page.evaluateHandle(() => new DataTransfer());
  /// await locator.dispatchEvent('dragstart', { dataTransfer );
  /// ```
  Future<void> dispatchEvent(
    String type, {

    Map<String, dynamic>? eventInit,

    double? timeout,
  }) async {
    await (frame as FrameImpl).channel.dispatchEvent(
      selector: selector,

      type: type,

      eventInit: serializeArgument(eventInit),

      timeout: timeout ?? 30000.0,
    );
  }

  /// Highlight the corresponding element(s) on the screen. Useful for debugging, don't commit the code that uses [locator.highlight()].
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await locator.highlight();
  /// await locator.highlight(options);
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `style` String | Map&lt;String, String | num&gt; *(optional)*
  ///
  ///     Inline CSS applied to the highlight overlay, e.g.
  ///
  ///     ```dart
  ///     await locator.highlight( style: 'outline: 2px dashed red' );
  ///     await locator.highlight( style: { color: 'red' } );
  ///     ```
  ///
  /// **Returns**
  /// - Future&lt;[Disposable]&gt;
  Future<void> highlight() async {
    await (frame as FrameImpl).channel.highlight(selector: selector);
  }

  /// Hides the element highlight previously added by [locator.highlight()].
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await locator.hideHighlight();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> hideHighlight() async {
    await (frame as FrameImpl).channel.hideHighlight(selector: selector);
  }

  /// Simulate an external drag-and-drop of files or clipboard-like data onto this locator.
  ///
  /// **Usage**
  ///
  /// Drop a file buffer onto an upload area:
  ///
  /// ```dart
  /// await page.locator('#dropzone').drop(
  ///   files: { name: 'note.txt', mimeType: 'text/plain', buffer: utf8.encode('hello') },
  /// );
  /// ```
  ///
  /// Drop plain text and a URL together:
  ///
  /// ```dart
  /// await page.locator('#dropzone').drop(
  ///   data: {
  ///     'text/plain': 'hello world',
  ///     'text/uri-list': 'https://example.com',
  ///   },
  /// );
  /// ```
  ///
  /// **Arguments**
  /// - `payload` Map
  ///   - `files` String | List&lt;String&gt; | Map | List&lt;Map&gt; *(optional)*
  ///     - `name` String
  ///
  ///       File name
  ///     - `mimeType` String
  ///
  ///       File type
  ///     - `buffer` List&lt;int&gt;
  ///
  ///       File content
  ///
  ///
  ///   - `data` List&lt;FrameDropDataItems&gt; *(optional)*
  ///
  ///
  ///   Data to drop onto the target. Provide `files` (file paths or in-memory buffers), `data` (a mime-type → string map for clipboard-like content such as `text/plain`, `text/html`, `text/uri-list`), or both.
  /// - `options` Map *(optional)*
  ///   - `position` Map *(optional)*
  ///     - `x` num
  ///
  ///
  ///     - `y` num
  ///
  ///
  ///     A point to use relative to the top-left corner of element padding box. If not specified, uses some visible point of the element.
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     Allows to cancel the operation using an [`AbortSignal`]. If the signal is aborted, the operation will be aborted and throw an error. Note that providing a signal does not disable the default timeout, which can be changed using [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()]; pass `timeout: 0` to disable the timeout entirely.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  ///
  /// **Details**
  ///
  /// Dispatches the native `dragenter`, `dragover`, and `drop` events at the center of the target element with a synthetic [DataTransfer] carrying the provided files and/or data entries. Works cross-browser by constructing the [DataTransfer] in the page context.
  ///
  /// If the target element's `dragover` listener does not call `preventDefault()`, the target is considered to have rejected the drop: Playwright dispatches `dragleave` and this method throws.
  Future<void> drop({
    List<FrameDropPayloadsItems>? payloads,

    List<String>? localPaths,

    List<FrameDropDataItems>? data,

    double? timeout,
  }) async {
    await frame.drop(
      selector,

      payloads: payloads,

      localPaths: localPaths,

      data: data,

      timeout: timeout,
    );
  }

  Future<FrameResolveSelectorResult> resolveSelector() async {
    return await frame.resolveSelector(selector);
  }

  /// Captures the aria snapshot of the given element. Read more about [aria snapshots] and [expect(locator).toMatchAriaSnapshot()] for the corresponding assertion.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await page.getByRole('link').ariaSnapshot();
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
  ///     When set to `"ai"`, returns a snapshot optimized for AI consumption. Defaults to `"default"`. See details for more information.
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     Allows to cancel the operation using an [`AbortSignal`]. If the signal is aborted, the operation will be aborted and throw an error. Note that providing a signal does not disable the default timeout, which can be changed using [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()]; pass `timeout: 0` to disable the timeout entirely.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;String&gt;
  ///
  /// **Details**
  ///
  /// This method captures the aria snapshot of the given element. The snapshot is a string that represents the state of the element and its children. The snapshot can be used to assert the state of the element in the test, or to compare it to state in the future.
  ///
  /// The ARIA snapshot is represented using [YAML] markup language:
  /// * The keys of the objects are the roles and optional accessible names of the elements.
  /// * The values are either text content or an array of child elements.
  /// * Generic static text can be represented with the `text` key.
  ///
  /// Below is the HTML markup and the respective ARIA snapshot:
  ///
  /// ```html
  /// <ul aria-label="Links">
  ///   <li><a href="/">Home</a></li>
  ///   <li><a href="/about">About</a></li>
  /// <ul>
  /// ```
  ///
  /// ```yml
  /// - list "Links":
  ///   - listitem:
  ///     - link "Home"
  ///   - listitem:
  ///     - link "About"
  /// ```
  ///
  /// An AI-optimized snapshot, controlled by [mode], is different from a default snapshot:
  /// 1. Includes element references `[ref=e2]`. 2. Does not wait for an element matching the locator, and throws when no elements match. 3. Includes snapshots of `<iframe>`s inside the target.
  Future<FrameAriaSnapshotResult> ariaSnapshot({
    SnapshotMode? mode,

    String? track,

    int? depth,

    bool? boxes,

    double? timeout,
  }) async {
    return await frame.ariaSnapshot(
      selector,

      mode: mode,

      track: track,

      depth: depth,

      boxes: boxes,

      timeout: timeout,
    );
  }

  /// Returns the ARIA snapshot of this locator in JSON format.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await locator.ariaSnapshotJSON();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;FrameAriaSnapshotJSONResult&gt;
  Future<FrameAriaSnapshotJSONResult> ariaSnapshotJSON({
    SnapshotMode? mode,
    int? depth,
    bool? boxes,
    double? timeout,
  }) async {
    return await frame.ariaSnapshotJSON(
      selector: selector,
      mode: mode,
      depth: depth,
      boxes: boxes,
      timeout: timeout,
    );
  }

  Locator querySelector(String subSelector) {
    /// The method finds an element matching the specified selector in the locator's subtree. It also accepts filter options, similar to [locator.filter()] method.
    ///
    /// [Learn more about locators].
    ///
    /// **Usage**
    ///
    /// ```dart
    /// locator.locator(selectorOrLocator);
    /// locator.locator(selectorOrLocator, options);
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
    return locator(subSelector);
  }

  Future<List<Locator>> querySelectorAll(String subSelector) async {
    final count = await frame.queryCount('$selector >> $subSelector');

    return List.generate(count, (i) => locator('$subSelector >> nth=$i'));
  }

  Future<int> queryCount(String subSelector) async {
    return await frame.queryCount('$selector >> $subSelector');
  }

  /// Execute JavaScript code in the page, taking the matching element as an argument.
  ///
  /// **Usage**
  ///
  /// Passing argument to [pageFunction]:
  ///
  /// ```dart
  /// final result = await page.getByTestId('myId').evaluate((element, [x, y]) {
  ///   return element.textContent + ' ' + x * y;
  /// }, [7, 8]);
  /// print(result); // prints "myId text 56"
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
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     Allows to cancel the operation using an [`AbortSignal`]. If the signal is aborted, the operation will be aborted and throw an error. Note that providing a signal does not disable the default timeout, which can be changed using [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()]; pass `timeout: 0` to disable the timeout entirely.
  ///   - `timeout` num *(optional)*
  ///
  ///     Maximum time in milliseconds to wait for the locator before evaluating. Note that after locator is resolved, evaluation itself is not limited by the timeout. Defaults to `0` - no timeout.
  ///
  /// **Returns**
  /// - Future&lt;[Serializable]&gt;
  ///
  /// **Details**
  ///
  /// Returns the return value of [pageFunction], called with the matching element as a first argument, and [arg] as a second argument.
  ///
  /// If [pageFunction] returns a Future, this method will wait for the future to complete and return its value.
  ///
  /// If [pageFunction] throws or rejects, this method throws.
  Future<T> evaluate<T>(String expression, [Object? arg]) async {
    // Locator evaluation in Playwright takes the element as the first arg.

    // For simplicity, we just use the frame evaluate and pass the selector,

    // or rely on evalOnSelector which evaluates in the context of the element.

    final result = await (frame as FrameImpl).channel.evalOnSelector(
      selector: selector,

      expression: expression,

      arg: serializeArgument(arg),
    );

    return castEvaluateResult<T>(parseSerializedValue(result.value));
  }

  /// Returns when element specified by locator satisfies the [state] option.
  ///
  /// If target element already satisfies the condition, the method returns immediately. Otherwise, waits for up to [timeout] milliseconds until the condition is met.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// final orderSent = page.locator('#order-sent');
  /// await orderSent.waitFor();
  /// ```
  ///
  /// **Arguments**
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
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> waitFor({SelectorState? state, double? timeout}) async {
    await frame.waitForSelector(selector, state: state, timeout: timeout);
  }

  /// Drag the source element towards the target element and drop it.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// final source = page.locator('#source');
  /// final target = page.locator('#target');
  ///
  /// await source.dragTo(target);
  /// // or specify exact positions relative to the top-left corners of the elements:
  /// await source.dragTo(target, {
  ///   sourcePosition: { x: 34, y: 7 },
  ///   targetPosition: { x: 10, y: 20 },
  /// );
  /// ```
  ///
  /// **Arguments**
  /// - `target` Locator
  ///
  ///   Locator of the element to drag to.
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
  ///   - `scroll` "auto" | "none" *(optional)*
  ///
  ///     Controls whether Playwright scrolls the element into view before performing the action. Defaults to `"auto"`, which scrolls the element into view when necessary, including scrolling nested scrollable containers. When set to `"none"`, Playwright does not scroll the element and the action fails if the element is not already in the viewport. This is useful to assert that an element is reachable by the user without additional scrolling.
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     Allows to cancel the operation using an [`AbortSignal`]. If the signal is aborted, the operation will be aborted and throw an error. Note that providing a signal does not disable the default timeout, which can be changed using [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()]; pass `timeout: 0` to disable the timeout entirely.
  ///   - `sourcePosition` Map *(optional)*
  ///     - `x` num
  ///
  ///
  ///     - `y` num
  ///
  ///
  ///     Clicks on the source element at this point relative to the top-left corner of the element's padding box. If not specified, some visible point of the element is used.
  ///   - `steps` num *(optional)*
  ///
  ///     Defaults to 1. Sends `n` interpolated `mousemove` events to represent travel between the `mousedown` and `mouseup` of the drag. When set to 1, emits a single `mousemove` event at the destination location.
  ///   - `targetPosition` Map *(optional)*
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
  ///
  /// **Details**
  ///
  /// This method drags the locator to another target locator or target position. It will first move to the source element, perform a `mousedown`, then move to the target element or position and perform a `mouseup`.
  Future<void> dragTo(Locator target, {bool? force, double? timeout}) async {
    await frame.dragAndDrop(
      selector,

      target.selector,

      force: force,

      timeout: timeout,
    );
  }

  /// Returns the number of elements matching the locator.

  /// Returns the number of elements matching the locator.
  ///
  /// **WARNING**
  /// [Asserting count]
  ///
  /// If you need to assert the number of elements on the page, prefer [expect(locator).toHaveCount()] to avoid flakiness. See [assertions guide] for more details.
  /// **Usage**
  ///
  /// ```dart
  /// final count = await page.getByRole('listitem').count();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;num&gt;
  Future<int> count() => frame.queryCount(selector);

  /// Returns an array of locators, one for each matching element.

  /// When the locator points to a list of elements, this returns an array of locators, pointing to their respective elements.
  ///
  /// **NOTE**
  /// [locator.all()] does not wait for elements to match the locator, and instead immediately returns whatever is present in the page.
  ///
  /// When the list of elements changes dynamically, [locator.all()] will produce unpredictable and flaky results.
  ///
  /// When the list of elements is stable, but loaded dynamically, wait for the full list to finish loading before calling [locator.all()].
  /// **Usage**
  ///
  /// ```dart
  /// for (final li of await page.getByRole('listitem').all())
  ///   await li.click();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;List&lt;[Locator]&gt;&gt;
  Future<List<Locator>> all() async {
    final n = await count();

    return List.generate(n, nth);
  }

  /// Returns an array of innerText values for all matching elements.

  /// Returns an array of `node.innerText` values for all matching nodes.
  ///
  /// **WARNING**
  /// [Asserting text]
  ///
  /// If you need to assert text on the page, prefer [expect(locator).toHaveText()] with [useInnerText] option to avoid flakiness. See [assertions guide] for more details.
  /// **Usage**
  ///
  /// ```dart
  /// final texts = await page.getByRole('link').allInnerTexts();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;List&lt;String&gt;&gt;
  Future<List<String>> allInnerTexts() async {
    final result = await frame.evalOnSelectorAll(
      selector,

      'elements => elements.map(e => e.innerText)',
    );

    return (result as List).cast<String>();
  }

  /// Returns an array of textContent values for all matching elements.

  /// Returns an array of `node.textContent` values for all matching nodes.
  ///
  /// **WARNING**
  /// [Asserting text]
  ///
  /// If you need to assert text on the page, prefer [expect(locator).toHaveText()] to avoid flakiness. See [assertions guide] for more details.
  /// **Usage**
  ///
  /// ```dart
  /// final texts = await page.getByRole('link').allTextContents();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;List&lt;String&gt;&gt;
  Future<List<String>> allTextContents() async {
    final result = await frame.evalOnSelectorAll(
      selector,

      'elements => elements.map(e => e.textContent || "")',
    );

    return (result as List).cast<String>();
  }

  /// Resolves to the first matching element handle.

  /// **WARNING**
  /// [Discouraged]
  ///
  /// Always prefer using [Locator]s and web assertions over [ElementHandle]s because latter are inherently racy.
  ///
  /// Resolves given locator to the first matching DOM element. If there are no matching elements, waits for one. If multiple elements match the locator, throws.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await locator.elementHandle();
  /// await locator.elementHandle(options);
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     Allows to cancel the operation using an [`AbortSignal`]. If the signal is aborted, the operation will be aborted and throw an error. Note that providing a signal does not disable the default timeout, which can be changed using [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()]; pass `timeout: 0` to disable the timeout entirely.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;[ElementHandle]&gt;
  Future<ElementHandle> elementHandle({double? timeout}) async {
    final result = await (frame as FrameImpl).channel.waitForSelector(
      selector: selector,

      state: SelectorState.attached,

      strict: true,

      timeout: timeout ?? 30000.0,
    );

    final handle = result.element;

    if (handle == null) {
      throw Exception('Could not resolve $selector to DOM Element');
    }

    return handle as ElementHandle;
  }

  /// Resolves to all matching element handles.

  /// **WARNING**
  /// [Discouraged]
  ///
  /// Always prefer using [Locator]s and web assertions over [ElementHandle]s because latter are inherently racy.
  ///
  /// Resolves given locator to all matching DOM elements. If there are no matching elements, returns an empty list.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await locator.elementHandles();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;List&lt;[ElementHandle]&gt;&gt;
  Future<List<ElementHandle>> elementHandles() async {
    final result = await (frame as FrameImpl).channel.querySelectorAll(
      selector: selector,
    );

    return result.elements.cast<ElementHandle>();
  }

  /// This method returns the bounding box of the element matching the locator, or `null` if the element is not visible. The bounding box is calculated relative to the main frame viewport - which is usually the same as the browser window.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// final box = await page.getByRole('button').boundingBox();
  /// await page.mouse.click(box.x + box.width / 2, box.y + box.height / 2);
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     Allows to cancel the operation using an [`AbortSignal`]. If the signal is aborted, the operation will be aborted and throw an error. Note that providing a signal does not disable the default timeout, which can be changed using [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()]; pass `timeout: 0` to disable the timeout entirely.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;[Map&gt;]?
  ///   - `x` num
  ///
  ///     the x coordinate of the element in pixels.
  ///   - `y` num
  ///
  ///     the y coordinate of the element in pixels.
  ///   - `width` num
  ///
  ///     the width of the element in pixels.
  ///   - `height` num
  ///
  ///     the height of the element in pixels.
  ///
  /// **Details**
  ///
  /// Scrolling affects the returned bounding box, similarly to [Element.getBoundingClientRect]. That means `x` and/or `y` may be negative.
  ///
  /// Elements from child frames return the bounding box relative to the main frame, unlike the [Element.getBoundingClientRect].
  ///
  /// Assuming the page is static, it is safe to use bounding box coordinates to perform input. For example, the following snippet should click the center of the element.
  Future<Rect?> boundingBox({double? timeout}) =>
      _withElement((h) => h.boundingBox(), timeout: timeout);

  /// This method waits for [actionability] checks, then tries to scroll element into view, unless it is completely visible as defined by [IntersectionObserver]'s `ratio`.
  ///
  /// See [scrolling] for alternative ways to scroll.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await locator.scrollIntoViewIfNeeded();
  /// await locator.scrollIntoViewIfNeeded(options);
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     Allows to cancel the operation using an [`AbortSignal`]. If the signal is aborted, the operation will be aborted and throw an error. Note that providing a signal does not disable the default timeout, which can be changed using [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()]; pass `timeout: 0` to disable the timeout entirely.
  ///   - `timeout` num *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> scrollIntoViewIfNeeded({double? timeout}) => _withElement(
    (h) => h.scrollIntoViewIfNeeded(timeout: timeout),

    timeout: timeout,
  );

  /// This method waits for [actionability] checks, then focuses the element and selects all its text content.
  ///
  /// If the element is inside the `<label>` element that has an associated [control], focuses and selects text in the control instead.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await locator.selectText();
  /// await locator.selectText(options);
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `force` bool *(optional)*
  ///
  ///     Whether to bypass the [actionability] checks. Defaults to `false`.
  ///   - `signal` [AbortSignal] *(optional)*
  ///
  ///     Allows to cancel the operation using an [`AbortSignal`]. If the signal is aborted, the operation will be aborted and throw an error. Note that providing a signal does not disable the default timeout, which can be changed using [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()]; pass `timeout: 0` to disable the timeout entirely.
  ///   - `timeout` num *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> selectText({bool? force, double? timeout}) => _withElement(
    (h) => h.selectText(force: force, timeout: timeout),

    timeout: timeout,
  );

  /// Take a screenshot of the element matching the locator.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await page.getByRole('link').screenshot();
  /// ```
  ///
  /// Disable animations and save screenshot to a file:
  ///
  /// ```dart
  /// await page.getByRole('link').screenshot( animations: 'disabled', path: 'link.png' );
  /// ```
  ///
  /// **Arguments**
  /// - `options` CommonScreenshotOptions *(optional)*
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
  ///
  /// **Details**
  ///
  /// This method captures a screenshot of the page, clipped to the size and position of a particular element matching the locator. If the element is covered by other elements, it will not be actually visible on the screenshot. If the element is a scrollable container, only the currently scrolled content will be visible on the screenshot.
  ///
  /// This method waits for the [actionability] checks, then scrolls element into view before taking a screenshot. If the element is detached from DOM, the method throws an error.
  ///
  /// Returns the buffer with the captured screenshot.
  Future<Uint8List> screenshot({
    CommonScreenshotOptions? options,

    double? timeout,

    ElementHandleScreenshotType? type,

    int? quality,
  }) async {
    final bytes = await _withElement(
      (h) => h.screenshot(
        options: options,

        timeout: timeout ?? 30000.0,

        type: type,

        quality: quality,
      ),

      timeout: timeout,
    );

    return Uint8List.fromList(bytes);
  }
}
