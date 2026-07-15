import '../infrastructure/channel_owner.dart';
import '../generated/channels.dart';
import 'jshandle.dart';
import '../infrastructure/serialization.dart';
// Re-exports Node, Element, etc. from package:html/dom.dart
import '../infrastructure/html_node.dart';
import '../core/frame.dart';
import 'interaction_types.dart';
import 'dart:convert';

/// A handle to a DOM element in the browser page.
///
/// The optional type parameter [T] mirrors the TypeScript SDK's
/// `ElementHandle<T extends Node = Node>` generic, where [Node] is
/// `package:html`'s DOM [Node] class.  It carries type information about
/// the underlying DOM element kind without impacting runtime behaviour.
///
/// [ElementHandle] extends [JSHandle] because every DOM element is also a
/// JavaScript value — the same relationship as in the TypeScript SDK where
/// `ElementHandle<T extends Node> extends JSHandle<T>`.
///
/// ```dart
/// import 'package:html/dom.dart' show Element;
///
/// // Default: any DOM node
/// final ElementHandle<Node> handle = await page.querySelector('div');
///
/// // Narrowed to Element (any HTML element):
/// final ElementHandle<Element> el = handle as ElementHandle<Element>;
/// await el.click();
/// ```
abstract interface class ElementHandle<T extends Node> implements JSHandle<T> {
  Future<R> evalOnSelector<R>(
    String selector,
    String expression, [
    Object? arg,
    bool? strict,
    bool? isFunction,
  ]);
  Future<R> evalOnSelectorAll<R>(
    String selector,
    String expression, [
    Object? arg,
    bool? isFunction,
  ]);

  /// **WARNING**
  /// [Discouraged]
  ///
  /// Use locator-based [locator.click()] instead. Read more about [locators].
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
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await elementHandle.click();
  /// await elementHandle.click(options);
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `button` ElementHandleClickButtonEnum *(optional)*
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
  ///   - `modifiers` List&lt;ElementHandleClickModifiersEnum&gt; *(optional)*
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
  ///   - `steps` int *(optional)*
  ///
  ///     Defaults to 1. Sends `n` interpolated `mousemove` events to represent travel between Playwright's current cursor position and the provided destination. When set to 1, emits a single `mousemove` event at the destination location.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///   - `trial` bool *(optional)*
  ///
  ///     When set, this method only performs the [actionability] checks and skips the action. Defaults to `false`. Useful to wait until the element is ready for the action without performing it.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> click({
    bool? force,
    double? timeout,
    bool? trial,
    bool? noWaitAfter,
    List<ElementHandleClickModifiersEnum>? modifiers,
    Point? position,
    double? delay,
    ElementHandleClickButtonEnum? button,
    int? clickCount,
    int? steps,
  });

  /// **WARNING**
  /// [Discouraged]
  ///
  /// Use locator-based [locator.dblclick()] instead. Read more about [locators].
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
  /// `elementHandle.dblclick()` dispatches two `click` events and a single `dblclick` event.
  /// **Usage**
  ///
  /// ```dart
  /// await elementHandle.dblclick();
  /// await elementHandle.dblclick(options);
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `button` ElementHandleDblclickButtonEnum *(optional)*
  ///
  ///     Defaults to `left`.
  ///   - `delay` double *(optional)*
  ///
  ///     Time to wait between `mousedown` and `mouseup` in milliseconds. Defaults to 0.
  ///   - `force` bool *(optional)*
  ///
  ///     Whether to bypass the [actionability] checks. Defaults to `false`.
  ///   - `modifiers` List&lt;ElementHandleDblclickModifiersEnum&gt; *(optional)*
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
  ///   - `steps` int *(optional)*
  ///
  ///     Defaults to 1. Sends `n` interpolated `mousemove` events to represent travel between Playwright's current cursor position and the provided destination. When set to 1, emits a single `mousemove` event at the destination location.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///   - `trial` bool *(optional)*
  ///
  ///     When set, this method only performs the [actionability] checks and skips the action. Defaults to `false`. Useful to wait until the element is ready for the action without performing it.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> dblclick({
    bool? force,
    double? timeout,
    bool? trial,
    List<ElementHandleDblclickModifiersEnum>? modifiers,
    Point? position,
    double? delay,
    ElementHandleDblclickButtonEnum? button,
    int? steps,
  });

  /// **WARNING**
  /// [Discouraged]
  ///
  /// Use locator-based [locator.fill()] instead. Read more about [locators].
  ///
  /// This method waits for [actionability] checks, focuses the element, fills it and triggers an `input` event after filling. Note that you can pass an empty string to clear the input field.
  ///
  /// If the target element is not an `<input>`, `<textarea>` or `[contenteditable]` element, this method throws an error. However, if the element is inside the `<label>` element that has an associated [control], the control will be filled instead.
  ///
  /// To send fine-grained keyboard events, use [locator.pressSequentially()].
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await elementHandle.fill(value);
  /// await elementHandle.fill(value, options);
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
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> fill(String value, {bool? force, double? timeout});

  /// **WARNING**
  /// [Discouraged]
  ///
  /// Use locator-based [locator.hover()] instead. Read more about [locators].
  ///
  /// This method hovers over the element by performing the following steps:
  /// 1. Wait for [actionability] checks on the element, unless [force] option is set.
  /// 1. Scroll the element into view if needed.
  /// 1. Use [page.mouse] to hover over the center of the element, or the specified [position].
  ///
  /// If the element is detached from the DOM at any moment during the action, this method throws.
  ///
  /// When all steps combined have not finished during the specified [timeout], this method throws a [TimeoutError]. Passing zero timeout disables this.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await elementHandle.hover();
  /// await elementHandle.hover(options);
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `force` bool *(optional)*
  ///
  ///     Whether to bypass the [actionability] checks. Defaults to `false`.
  ///   - `modifiers` List&lt;ElementHandleHoverModifiersEnum&gt; *(optional)*
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
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///   - `trial` bool *(optional)*
  ///
  ///     When set, this method only performs the [actionability] checks and skips the action. Defaults to `false`. Useful to wait until the element is ready for the action without performing it.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> hover({
    bool? force,
    double? timeout,
    bool? trial,
    List<ElementHandleHoverModifiersEnum>? modifiers,
    Point? position,
  });

  /// **WARNING**
  /// [Discouraged]
  ///
  /// Use locator-based [locator.focus()] instead. Read more about [locators].
  ///
  /// Calls [focus] on the element.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await elementHandle.focus();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> focus();

  /// **WARNING**
  /// [Deprecated]
  ///
  /// In most cases, you should use [locator.fill()] instead. You only need to press keys one by one if there is special keyboard handling on the page - in this case use [locator.pressSequentially()].
  ///
  /// Focuses the element, and then sends a `keydown`, `keypress`/`input`, and `keyup` event for each character in the text.
  ///
  /// To press a special key, like `Control` or `ArrowDown`, use [elementHandle.press()].
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
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> type(String text, {double? delay, double? timeout});

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
  /// Following modification shortcuts are also supported: `Shift`, `Control`, `Alt`, `Meta`, `ShiftLeft`, `ControlOrMeta`.
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
  /// await elementHandle.press(key);
  /// await elementHandle.press(key, options);
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
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> press(
    String key, {
    double? delay,
    double? timeout,
    bool? noWaitAfter,
  });

  /// **WARNING**
  /// [Discouraged]
  ///
  /// Use locator-based [locator.tap()] instead. Read more about [locators].
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
  /// `elementHandle.tap()` requires that the `hasTouch` option of the browser context be set to true.
  /// **Usage**
  ///
  /// ```dart
  /// await elementHandle.tap();
  /// await elementHandle.tap(options);
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `force` bool *(optional)*
  ///
  ///     Whether to bypass the [actionability] checks. Defaults to `false`.
  ///   - `modifiers` List&lt;ElementHandleTapModifiersEnum&gt; *(optional)*
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
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///   - `trial` bool *(optional)*
  ///
  ///     When set, this method only performs the [actionability] checks and skips the action. Defaults to `false`. Useful to wait until the element is ready for the action without performing it.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> tap({
    bool? force,
    double? timeout,
    bool? trial,
    List<ElementHandleTapModifiersEnum>? modifiers,
    Point? position,
  });

  /// **WARNING**
  /// [Discouraged]
  ///
  /// Use locator-based [locator.check()] instead. Read more about [locators].
  ///
  /// This method checks the element by performing the following steps:
  /// 1. Ensure that element is a checkbox or a radio input. If not, this method throws. If the element is already checked, this method returns immediately.
  /// 1. Wait for [actionability] checks on the element, unless [force] option is set.
  /// 1. Scroll the element into view if needed.
  /// 1. Use [page.mouse] to click in the center of the element.
  /// 1. Ensure that the element is now checked. If not, this method throws.
  ///
  /// If the element is detached from the DOM at any moment during the action, this method throws.
  ///
  /// When all steps combined have not finished during the specified [timeout], this method throws a [TimeoutError]. Passing zero timeout disables this.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await elementHandle.check();
  /// await elementHandle.check(options);
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
  ///   - `position` Point *(optional)*
  ///     - `x` num
  ///
  ///
  ///     - `y` num
  ///
  ///
  ///     A point to use relative to the top-left corner of element padding box. If not specified, uses some visible point of the element.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///   - `trial` bool *(optional)*
  ///
  ///     When set, this method only performs the [actionability] checks and skips the action. Defaults to `false`. Useful to wait until the element is ready for the action without performing it.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> check({
    bool? force,
    double? timeout,
    bool? trial,
    Point? position,
  });

  /// **WARNING**
  /// [Discouraged]
  ///
  /// Use locator-based [locator.uncheck()] instead. Read more about [locators].
  ///
  /// This method checks the element by performing the following steps:
  /// 1. Ensure that element is a checkbox or a radio input. If not, this method throws. If the element is already unchecked, this method returns immediately.
  /// 1. Wait for [actionability] checks on the element, unless [force] option is set.
  /// 1. Scroll the element into view if needed.
  /// 1. Use [page.mouse] to click in the center of the element.
  /// 1. Ensure that the element is now unchecked. If not, this method throws.
  ///
  /// If the element is detached from the DOM at any moment during the action, this method throws.
  ///
  /// When all steps combined have not finished during the specified [timeout], this method throws a [TimeoutError]. Passing zero timeout disables this.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await elementHandle.uncheck();
  /// await elementHandle.uncheck(options);
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
  ///   - `position` Point *(optional)*
  ///     - `x` num
  ///
  ///
  ///     - `y` num
  ///
  ///
  ///     A point to use relative to the top-left corner of element padding box. If not specified, uses some visible point of the element.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///   - `trial` bool *(optional)*
  ///
  ///     When set, this method only performs the [actionability] checks and skips the action. Defaults to `false`. Useful to wait until the element is ready for the action without performing it.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> uncheck({
    bool? force,
    double? timeout,
    bool? trial,
    Point? position,
  });

  /// **WARNING**
  /// [Discouraged]
  ///
  /// Use locator-based [locator.scrollIntoViewIfNeeded()] instead. Read more about [locators].
  ///
  /// This method waits for [actionability] checks, then tries to scroll element into view, unless it is completely visible as defined by [IntersectionObserver]'s `ratio`.
  ///
  /// Throws when `elementHandle` does not point to an element [connected] to a Document or a ShadowRoot.
  ///
  /// See [scrolling] for alternative ways to scroll.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await elementHandle.scrollIntoViewIfNeeded();
  /// await elementHandle.scrollIntoViewIfNeeded(options);
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> scrollIntoViewIfNeeded({double? timeout});

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
  /// await elementHandle.getAttribute(name);
  /// ```
  ///
  /// **Arguments**
  /// - `name` String
  ///
  ///   Attribute name to get the value for.
  ///
  /// **Returns**
  /// - Future&lt;[String&gt;]?
  Future<String?> getAttribute(String name);

  /// **WARNING**
  /// [Discouraged]
  ///
  /// Use locator-based [locator.innerHTML()] instead. Read more about [locators].
  ///
  /// Returns the `element.innerHTML`.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await elementHandle.innerHTML();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;String&gt;
  Future<String> innerHTML();

  /// **WARNING**
  /// [Discouraged]
  ///
  /// Use locator-based [locator.innerText()] instead. Read more about [locators].
  ///
  /// Returns the `element.innerText`.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await elementHandle.innerText();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;String&gt;
  Future<String> innerText();

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
  /// await elementHandle.inputValue();
  /// await elementHandle.inputValue(options);
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `timeout` num *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;String&gt;
  Future<String> inputValue();

  /// **WARNING**
  /// [Discouraged]
  ///
  /// Use locator-based [locator.textContent()] instead. Read more about [locators].
  ///
  /// Returns the `node.textContent`.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await elementHandle.textContent();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;[String&gt;]?
  Future<String> textContent();

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
  /// await elementHandle.isChecked();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;bool&gt;
  Future<bool> isChecked();

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
  /// await elementHandle.isDisabled();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;bool&gt;
  Future<bool> isDisabled();

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
  /// await elementHandle.isEditable();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;bool&gt;
  Future<bool> isEditable();

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
  /// await elementHandle.isEnabled();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;bool&gt;
  Future<bool> isEnabled();

  /// **WARNING**
  /// [Discouraged]
  ///
  /// Use locator-based [locator.isHidden()] instead. Read more about [locators].
  ///
  /// Returns whether the element is hidden, the opposite of [visible].
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await elementHandle.isHidden();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;bool&gt;
  Future<bool> isHidden();

  /// **WARNING**
  /// [Discouraged]
  ///
  /// Use locator-based [locator.isVisible()] instead. Read more about [locators].
  ///
  /// Returns whether the element is [visible].
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await elementHandle.isVisible();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;bool&gt;
  Future<bool> isVisible();

  /// This method returns the bounding box of the element, or `null` if the element is not visible. The bounding box is calculated relative to the main frame viewport - which is usually the same as the browser window.
  ///
  /// Scrolling affects the returned bounding box, similarly to [Element.getBoundingClientRect]. That means `x` and/or `y` may be negative.
  ///
  /// Elements from child frames return the bounding box relative to the main frame, unlike the [Element.getBoundingClientRect].
  ///
  /// Assuming the page is static, it is safe to use bounding box coordinates to perform input. For example, the following snippet should click the center of the element.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// final box = await elementHandle.boundingBox();
  /// await page.mouse.click(box.x + box.width / 2, box.y + box.height / 2);
  /// ```
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
  Future<Rect?> boundingBox();

  /// Returns the content frame for element handles referencing iframe nodes, or `null` otherwise
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await elementHandle.contentFrame();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;[Frame]?&gt;
  Future<Frame?> contentFrame();

  /// Returns the frame containing the given element.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await elementHandle.ownerFrame();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;[Frame]?&gt;
  Future<Frame?> ownerFrame();
  Future<ElementHandle?> querySelector(String selector, {bool? strict});
  Future<List<ElementHandle>> querySelectorAll(String selector);

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
  /// await elementHandle.dispatchEvent('click');
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
  /// await elementHandle.dispatchEvent('dragstart', { dataTransfer );
  /// ```
  ///
  /// **Arguments**
  /// - `type` String
  ///
  ///   DOM event type: `"click"`, `"dragstart"`, etc.
  /// - `eventInit` dynamic *(optional)*
  ///
  ///   Optional event-specific initialization properties.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> dispatchEvent(String type, {Map<String, dynamic>? eventInit});

  /// **WARNING**
  /// [Discouraged]
  ///
  /// Use locator-based [locator.screenshot()] instead. Read more about [locators].
  ///
  /// This method captures a screenshot of the page, clipped to the size and position of this particular element. If the element is covered by other elements, it will not be actually visible on the screenshot. If the element is a scrollable container, only the currently scrolled content will be visible on the screenshot.
  ///
  /// This method waits for the [actionability] checks, then scrolls element into view before taking a screenshot. If the element is detached from DOM, the method throws an error.
  ///
  /// Returns the buffer with the captured screenshot.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await elementHandle.screenshot();
  /// await elementHandle.screenshot(options);
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
  ///     The quality of the image, between 0-100. Not applicable to `png` images.
  ///   - `scale` "css" | "device" *(optional)*
  ///
  ///     When set to `"css"`, screenshot will have a single pixel per each css pixel on the page. For high-dpi devices, this will keep screenshots small. Using `"device"` option will produce a single pixel per each device pixel, so screenshots of high-dpi devices will be twice as large or even larger.
  ///
  ///     Defaults to `"device"`.
  ///   - `style` String *(optional)*
  ///
  ///     Text of the stylesheet to apply while making the screenshot. This is where you can hide dynamic elements, make elements invisible or change their properties to help you creating repeatable screenshots. This stylesheet pierces the Shadow DOM and applies to the inner frames.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///   - `type` String *(optional)*
  ///
  ///     Specify screenshot type, defaults to `png`.
  ///
  /// **Returns**
  /// - Future&lt;List&lt;int&gt;&gt;
  Future<List<int>> screenshot({
    CommonScreenshotOptions? options,
    required double timeout,
    String? type,
    int? quality,
  });

  /// **WARNING**
  /// [Discouraged]
  ///
  /// Use locator-based [locator.selectOption()] instead. Read more about [locators].
  ///
  /// This method waits for [actionability] checks, waits until all specified options are present in the `<select>` element and selects these options.
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
  /// handle.selectOption('blue');
  ///
  /// // single selection matching the label
  /// handle.selectOption( label: 'Blue' );
  ///
  /// // multiple selection
  /// handle.selectOption(['red', 'green', 'blue']);
  /// ```
  ///
  /// **Arguments**
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
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;List&lt;String&gt;&gt;
  Future<List<String>> selectOption({
    List<SelectOption>? values,
    bool? force,
    double? timeout,
    List<ElementHandle>? elements,
    List<ElementHandleSelectOptionOptionsItems>? options,
  });

  /// **WARNING**
  /// [Discouraged]
  ///
  /// Use locator-based [locator.selectText()] instead. Read more about [locators].
  ///
  /// This method waits for [actionability] checks, then focuses the element and selects all its text content.
  ///
  /// If the element is inside the `<label>` element that has an associated [control], focuses and selects text in the control instead.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await elementHandle.selectText();
  /// await elementHandle.selectText(options);
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `force` bool *(optional)*
  ///
  ///     Whether to bypass the [actionability] checks. Defaults to `false`.
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> selectText({bool? force, double? timeout});

  /// **WARNING**
  /// [Discouraged]
  ///
  /// Use locator-based [locator.setInputFiles()] instead. Read more about [locators].
  ///
  /// Sets the value of the file input to these file paths or files. If some of the `filePaths` are relative paths, then they are resolved relative to the current working directory. For empty array, clears the selected files. For inputs with a `[webkitdirectory]` attribute, only a single directory path is supported.
  ///
  /// This method expects [ElementHandle] to point to an [input element]. However, if the element is inside the `<label>` element that has an associated [control], targets the control instead.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await elementHandle.setInputFiles(files);
  /// await elementHandle.setInputFiles(files, options);
  /// ```
  ///
  /// **Arguments**
  /// - `files` List&lt;String&gt;
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
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> setInputFiles(
    List<String> files, {
    double? timeout,
    List<ElementHandleSetInputFilesPayloadsItems>? payloads,
    String? localDirectory,
    ChannelOwner? directoryStream,
    List<String>? localPaths,
    List<ChannelOwner>? streams,
  });

  /// Returns when the element satisfies the [state].
  ///
  /// Depending on the [state] parameter, this method waits for one of the [actionability] checks to pass. This method throws when the element is detached while waiting, unless waiting for the `"hidden"` state.
  /// * `"visible"` Wait until the element is [visible].
  /// * `"hidden"` Wait until the element is [not visible] or not attached. Note that waiting for hidden does not throw when the element detaches.
  /// * `"stable"` Wait until the element is both [visible] and [stable].
  /// * `"enabled"` Wait until the element is [enabled].
  /// * `"disabled"` Wait until the element is [not enabled].
  /// * `"editable"` Wait until the element is [editable].
  ///
  /// If the element does not satisfy the condition for the [timeout] milliseconds, this method will throw.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await elementHandle.waitForElementState(state);
  /// await elementHandle.waitForElementState(state, options);
  /// ```
  ///
  /// **Arguments**
  /// - `state` ElementHandleWaitForElementStateStateEnum
  ///
  ///   A state to wait for, see below for more details.
  /// - `options` Map *(optional)*
  ///   - `timeout` double *(optional)*
  ///
  ///     Maximum time in milliseconds. Defaults to `0` - no timeout. The default value can be changed via `actionTimeout` option in the config, or by using the [browserContext.setDefaultTimeout()] or [page.setDefaultTimeout()] methods.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> waitForElementState(
    ElementHandleWaitForElementStateStateEnum state, {
    double? timeout,
  });

  /// **WARNING**
  /// [Discouraged]
  ///
  /// Use web assertions that assert visibility or a locator-based [locator.waitFor()] instead.
  ///
  /// Returns element specified by selector when it satisfies [state] option. Returns `null` if waiting for `hidden` or `detached`.
  ///
  /// Wait for the [selector] relative to the element handle to satisfy [state] option (either appear/disappear from dom, or become visible/hidden). If at the moment of calling the method [selector] already satisfies the condition, the method will return immediately. If the selector doesn't satisfy the condition for the [timeout] milliseconds, the function will throw.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await page.setContent(`<div><span></span></div>`);
  /// final div = await page.$('div');
  /// // Waiting for the 'span' selector relative to the div.
  /// final span = await div.waitForSelector('span', { state: 'attached' );
  /// ```
  ///
  /// **NOTE**
  /// This method does not work across navigations, use [page.waitForSelector()] instead.
  /// **Arguments**
  /// - `selector` String
  ///
  ///   A selector to query for.
  /// - `options` Map *(optional)*
  ///   - `state` ElementHandleWaitForSelectorStateEnum *(optional)*
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
  Future<ElementHandle?> waitForSelector(
    String selector, {
    bool? strict,
    ElementHandleWaitForSelectorStateEnum? state,
    double? timeout,
  });
}

class ElementHandleImpl extends ElementHandleBase
    implements ElementHandle<Node>, JSHandle<Node> {
  @override
  ElementHandle<Node>? asElement() => this;

  @override
  Stream<dynamic> get onPreviewUpdated {
    return onEvent
        .where((e) => e['event'] == 'previewUpdated')
        .map((e) => e['params']['preview']);
  }

  ElementHandleImpl(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  @override
  Future<R> evaluate<R>(
    String expression, [
    Object? arg,
    bool? isFunction,
  ]) async {
    final result = await channel.evaluateExpression(
      expression: expression,
      arg: serializeArgument(arg),
      isFunction: isFunction,
    );
    return castEvaluateResult<R>(parseSerializedValue(result.value));
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
  Future<R> evaluateExpression<R>(
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
    final result = await channel.getProperty(name: name);
    return ChannelOwner.from<JSHandleImpl>(
      connection,
      result.handle as Map<String, dynamic>,
    );
  }

  @override
  Future<Map<String, JSHandle<Object?>>> getProperties() async {
    final result = await channel.getPropertyList();
    final map = <String, JSHandle<Object?>>{};
    for (final property in result.properties as List) {
      map[property['name'] as String] = ChannelOwner.from<JSHandleImpl>(
        connection,
        property['value'] as Map<String, dynamic>,
      );
    }
    return map;
  }

  @override
  Future<Map<String, JSHandle<Object?>>> getPropertyList() => getProperties();

  @override
  Future<dynamic> jsonValue() async {
    final result = await channel.jsonValue();
    return parseSerializedValue(result.value);
  }

  @override
  Future<void> dispose() async {
    await channel.dispose();
  }

  @override
  Future<R> evalOnSelector<R>(
    String selector,
    String expression, [
    Object? arg,
    bool? strict,
    bool? isFunction,
  ]) async {
    final result = await channel.evalOnSelector(
      selector: selector,
      expression: expression,
      arg: serializeArgument(arg),
      strict: strict,
      isFunction: isFunction,
    );
    return castEvaluateResult<R>(parseSerializedValue(result.value));
  }

  @override
  Future<R> evalOnSelectorAll<R>(
    String selector,
    String expression, [
    Object? arg,
    bool? isFunction,
  ]) async {
    final result = await channel.evalOnSelectorAll(
      selector: selector,
      expression: expression,
      arg: serializeArgument(arg),
      isFunction: isFunction,
    );
    return castEvaluateResult<R>(parseSerializedValue(result.value));
  }

  // Element actions
  @override
  Future<void> click({
    bool? force,
    double? timeout,
    bool? trial,
    bool? noWaitAfter,
    List<ElementHandleClickModifiersEnum>? modifiers,
    Point? position,
    double? delay,
    ElementHandleClickButtonEnum? button,
    int? clickCount,
    int? steps,
  }) async {
    await channel.click(
      force: force,
      timeout: timeout ?? 30000.0,
      trial: trial,
      noWaitAfter: noWaitAfter,
      modifiers: modifiers,
      position: position,
      delay: delay,
      button: button,
      clickCount: clickCount,
      steps: steps,
    );
  }

  @override
  Future<void> dblclick({
    bool? force,
    double? timeout,
    bool? trial,
    List<ElementHandleDblclickModifiersEnum>? modifiers,
    Point? position,
    double? delay,
    ElementHandleDblclickButtonEnum? button,
    int? steps,
  }) async {
    await channel.dblclick(
      force: force,
      timeout: timeout ?? 30000.0,
      trial: trial,
      modifiers: modifiers,
      position: position,
      delay: delay,
      button: button,
      steps: steps,
    );
  }

  @override
  Future<void> fill(String value, {bool? force, double? timeout}) async {
    await channel.fill(value: value, force: force, timeout: timeout ?? 30000.0);
  }

  @override
  Future<void> hover({
    bool? force,
    double? timeout,
    bool? trial,
    List<ElementHandleHoverModifiersEnum>? modifiers,
    Point? position,
  }) async {
    await channel.hover(
      force: force,
      timeout: timeout ?? 30000.0,
      trial: trial,
      modifiers: modifiers,
      position: position,
    );
  }

  @override
  Future<void> focus() async {
    await channel.focus();
  }

  @override
  Future<void> type(String text, {double? delay, double? timeout}) async {
    await channel.type(text: text, delay: delay, timeout: timeout ?? 30000.0);
  }

  @override
  Future<void> press(
    String key, {
    double? delay,
    double? timeout,
    bool? noWaitAfter,
  }) async {
    await channel.press(
      key: key,
      delay: delay,
      timeout: timeout ?? 30000.0,
      noWaitAfter: noWaitAfter,
    );
  }

  @override
  Future<void> tap({
    bool? force,
    double? timeout,
    bool? trial,
    List<ElementHandleTapModifiersEnum>? modifiers,
    Point? position,
  }) async {
    await channel.tap(
      force: force,
      timeout: timeout ?? 30000.0,
      trial: trial,
      modifiers: modifiers,
      position: position,
    );
  }

  @override
  Future<void> check({
    bool? force,
    double? timeout,
    bool? trial,
    Point? position,
  }) async {
    await channel.check(
      force: force,
      timeout: timeout ?? 30000.0,
      trial: trial,
      position: position,
    );
  }

  @override
  Future<void> uncheck({
    bool? force,
    double? timeout,
    bool? trial,
    Point? position,
  }) async {
    await channel.uncheck(
      force: force,
      timeout: timeout ?? 30000.0,
      trial: trial,
      position: position,
    );
  }

  @override
  Future<void> scrollIntoViewIfNeeded({double? timeout}) async {
    await channel.scrollIntoViewIfNeeded(timeout: timeout ?? 30000.0);
  }

  // State
  @override
  Future<String?> getAttribute(String name) async {
    final result = await channel.getAttribute(name: name);
    return result.value;
  }

  @override
  Future<String> innerHTML() async {
    final result = await channel.innerHTML();
    return result.value;
  }

  @override
  Future<String> innerText() async {
    final result = await channel.innerText();
    return result.value;
  }

  @override
  Future<String> inputValue() async {
    final result = await channel.inputValue();
    return result.value;
  }

  @override
  Future<String> textContent() async {
    final result = await channel.textContent();
    return result.value as String;
  }

  @override
  Future<bool> isChecked() async {
    final result = await channel.isChecked();
    return result.value;
  }

  @override
  Future<bool> isDisabled() async {
    final result = await channel.isDisabled();
    return result.value;
  }

  @override
  Future<bool> isEditable() async {
    final result = await channel.isEditable();
    return result.value;
  }

  @override
  Future<bool> isEnabled() async {
    final result = await channel.isEnabled();
    return result.value;
  }

  @override
  Future<bool> isHidden() async {
    final result = await channel.isHidden();
    return result.value;
  }

  @override
  Future<bool> isVisible() async {
    final result = await channel.isVisible();
    return result.value;
  }

  @override
  Future<Rect?> boundingBox() async {
    final result = await channel.boundingBox();
    return result.value;
  }

  @override
  Future<Frame?> contentFrame() async {
    final result = await channel.contentFrame();
    return result.frame as Frame?;
  }

  @override
  Future<Frame?> ownerFrame() async {
    final result = await channel.ownerFrame();
    return result.frame as Frame?;
  }

  @override
  Future<ElementHandle?> querySelector(String selector, {bool? strict}) async {
    final result = await channel.querySelector(
      selector: selector,
      strict: strict,
    );
    return result.element as ElementHandle?;
  }

  @override
  Future<List<ElementHandle>> querySelectorAll(String selector) async {
    final result = await channel.querySelectorAll(selector: selector);
    final elements = result.elements as List;
    return elements.cast<ElementHandle>();
  }

  @override
  Future<void> dispatchEvent(
    String type, {
    Map<String, dynamic>? eventInit,
  }) async {
    await channel.dispatchEvent(
      type: type,
      eventInit: serializeArgument(eventInit),
    );
  }

  @override
  Future<List<int>> screenshot({
    CommonScreenshotOptions? options,
    required double timeout,
    String? type,
    int? quality,
  }) async {
    final result = await channel.screenshot(
      commonScreenshotOptions: options ?? CommonScreenshotOptions(),
      timeout: timeout,
      type: type != null
          ? ElementHandleScreenshotTypeEnum.values.firstWhere(
              (e) => e.value == type,
            )
          : null,
      quality: quality,
    );
    return base64Decode(result.binary);
  }

  @override
  Future<List<String>> selectOption({
    List<SelectOption>? values,
    bool? force,
    double? timeout,
    List<ElementHandle>? elements,
    List<ElementHandleSelectOptionOptionsItems>? options,
  }) async {
    List<ElementHandleSelectOptionOptionsItems>? finalOptions = options;
    if (finalOptions == null && values != null) {
      finalOptions = [];
      finalOptions.addAll(
        values.map(
          (v) => ElementHandleSelectOptionOptionsItems(
            valueOrLabel: v.value ?? v.label ?? v.index?.toString() ?? '',
          ),
        ),
      );
    }

    final result = await channel.selectOption(
      elements: elements?.cast<ElementHandleImpl>(),
      options: finalOptions?.isNotEmpty == true ? finalOptions : null,
      force: force,
      timeout: timeout ?? 30000.0,
    );
    return (result.values as List).cast<String>();
  }

  @override
  Future<void> selectText({bool? force, double? timeout}) async {
    await channel.selectText(force: force, timeout: timeout ?? 30000.0);
  }

  @override
  Future<void> setInputFiles(
    List<String> files, {
    double? timeout,
    List<ElementHandleSetInputFilesPayloadsItems>? payloads,
    String? localDirectory,
    ChannelOwner? directoryStream,
    List<String>? localPaths,
    List<ChannelOwner>? streams,
  }) async {
    await channel.setInputFiles(
      localPaths: localPaths ?? files,
      timeout: timeout ?? 30000.0,
      payloads: payloads,
      localDirectory: localDirectory,
      directoryStream: directoryStream as WritableStreamBase?,
      streams: streams?.map((s) => s as WritableStreamBase).toList(),
    );
  }

  @override
  Future<void> waitForElementState(
    ElementHandleWaitForElementStateStateEnum state, {
    double? timeout,
  }) async {
    await channel.waitForElementState(
      state: state,
      timeout: timeout ?? 30000.0,
    );
  }

  @override
  Future<ElementHandle?> waitForSelector(
    String selector, {
    bool? strict,
    ElementHandleWaitForSelectorStateEnum? state,
    double? timeout,
  }) async {
    final result = await channel.waitForSelector(
      selector: selector,
      strict: strict,
      state: state,
      timeout: timeout ?? 30000.0,
    );
    return result.element as ElementHandle?;
  }
}
