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
  /// The parent frame, if this is an iframe.
  Frame? get parentFrame;

  /// Child frames of this frame.
  List<Frame> get childFrames;

  /// The frame name.
  String get name;

  /// Stream that emits when the frame navigates.
  Stream<Map<String, dynamic>> get onNavigated;

  /// Stream that emits when the frame load state changes.
  Stream<Map<String, dynamic>> get onLoadstate;

  /// Returns the frame URL.
  String url();

  /// The page this frame belongs to.
  Page get page;

  /// Creates a frame locator for the given selector.
  FrameLocator frameLocator(String selector);

  /// Creates a locator for the given selector.
  Locator locator(String selector);

  /// Locates element by text content.
  Locator getByText(Pattern text, {bool exact});

  /// Locates element by ARIA role.
  Locator getByRole(String role, {Pattern? name, bool exact});

  /// Locates element by associated label.
  Locator getByLabel(Pattern text, {bool exact});

  /// Locates element by placeholder text.
  Locator getByPlaceholder(Pattern text, {bool exact});

  /// Locates element by alt text.
  Locator getByAltText(Pattern text, {bool exact});

  /// Locates element by title attribute.
  Locator getByTitle(Pattern text, {bool exact});

  /// Locates element by test ID.
  Locator getByTestId(String testId);

  /// Navigates the frame to the given URL.
  Future<void> goto(
    String url, {

    double? timeout,

    LifecycleEvent? waitUntil,

    String? referer,
  });

  /// Returns the text content of the element matching the selector.
  Future<String> textContent({
    required String selector,

    double? timeout,

    bool? strict,
  });

  /// Evaluates JavaScript in the frame.
  Future<dynamic> evaluate(String expression, [dynamic arg]);

  /// Waits for the element matching the selector to satisfy the state.
  Future<FrameWaitForSelectorResult> waitForSelector(
    String selector, {

    FrameWaitForSelectorStateEnum? state,

    double? timeout,

    bool? strict,

    bool? omitReturnValue,
  });

  /// Waits for the frame to reach the given load state.
  Future<void> waitForLoadState({LifecycleEvent? state, double? timeout});

  /// Waits for the frame to navigate to the given URL.
  Future<void> waitForURL(
    dynamic urlOrPredicate, {

    double? timeout,

    LifecycleEvent? waitUntil,
  });

  /// Waits for navigation to complete.
  Future<void> waitForNavigation({
    String? url,

    LifecycleEvent? waitUntil,

    double? timeout,
  });

  /// Drags and drops an element from source to target.
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

  /// Clicks an element matching the selector.
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

  /// Fills an element with the given value.
  Future<void> fill(
    String selector,

    String value, {

    bool? force,

    double? timeout,

    bool? strict,
  });

  /// Checks a checkbox or radio button.
  Future<void> check(
    String selector, {

    bool? force,

    double? timeout,

    bool? strict,

    bool? trial,

    Point? position,
  });

  /// Unchecks a checkbox.
  Future<void> uncheck(
    String selector, {

    bool? force,

    double? timeout,

    bool? strict,

    bool? trial,

    Point? position,
  });

  /// Sets the checked state of a checkbox or radio button.
  Future<void> setChecked(
    String selector,

    bool checked, {

    bool? force,

    double? timeout,

    bool? strict,

    bool? trial,

    Point? position,
  });

  /// Hovers over an element matching the selector.
  Future<void> hover(
    String selector, {

    bool? force,

    double? timeout,

    bool? strict,

    bool? trial,

    List<FrameHoverModifiersEnum>? modifiers,

    Point? position,
  });

  /// Focuses an element matching the selector.
  Future<void> focus(String selector, {double? timeout, bool? strict});

  /// Removes focus from an element matching the selector.
  Future<void> blur(String selector, {double? timeout, bool? strict});

  /// Double-clicks an element matching the selector.
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

  /// Types text into an element matching the selector.
  Future<void> type(
    String selector,

    String text, {

    double? delay,

    double? timeout,

    bool? strict,
  });

  /// Presses a key while focused on an element matching the selector.
  Future<void> press(
    String selector,

    String key, {

    double? delay,

    double? timeout,

    bool? strict,

    bool? noWaitAfter,
  });

  /// Taps an element matching the selector.
  Future<void> tap(
    String selector, {

    bool? force,

    double? timeout,

    bool? strict,

    bool? trial,

    List<FrameTapModifiersEnum>? modifiers,

    Point? position,
  });

  /// Returns the HTML content of the frame.
  Future<String> content();

  /// Sets the HTML content of the frame.
  Future<void> setContent(
    String html, {

    double? timeout,

    LifecycleEvent? waitUntil,
  });

  /// Evaluates JavaScript on the element matching the selector.
  Future<dynamic> evalOnSelector(
    String selector,

    String expression, [

    dynamic arg,

    bool? strict,

    bool? isFunction,
  ]);

  /// Evaluates JavaScript on all elements matching the selector.
  Future<dynamic> evalOnSelectorAll(
    String selector,

    String expression, [

    dynamic arg,

    bool? isFunction,
  ]);

  /// Returns the attribute value of the element matching the selector.
  Future<String?> getAttribute(
    String selector,

    String name, {

    double? timeout,

    bool? strict,
  });

  /// Returns the inner HTML of the element matching the selector.
  Future<String> innerHTML(String selector, {double? timeout, bool? strict});

  /// Returns the inner text of the element matching the selector.
  Future<String> innerText(String selector, {double? timeout, bool? strict});

  /// Returns the input value of the element matching the selector.
  Future<String> inputValue(String selector, {double? timeout, bool? strict});

  /// Returns the frame title.
  Future<String> title();

  /// Returns whether the element matching the selector is checked.
  Future<bool> isChecked(String selector, {double? timeout, bool? strict});

  /// Returns whether the element matching the selector is disabled.
  Future<bool> isDisabled(String selector, {double? timeout, bool? strict});

  /// Returns whether the element matching the selector is enabled.
  Future<bool> isEnabled(String selector, {double? timeout, bool? strict});

  /// Returns whether the element matching the selector is hidden.
  Future<bool> isHidden(String selector, {bool? strict});

  /// Returns whether the element matching the selector is visible.
  Future<bool> isVisible(String selector, {bool? strict});

  /// Returns whether the element matching the selector is editable.
  Future<bool> isEditable(String selector, {double? timeout, bool? strict});

  /// Adds a script tag to the frame.
  Future<void> addScriptTag({String? url, String? content, String? type});

  /// Adds a style tag to the frame.
  Future<void> addStyleTag({String? url, String? content});

  /// Waits for the given timeout.
  Future<void> waitForTimeout(double waitTimeout);

  /// Waits for the function to return a truthy value.
  Future<JSHandle> waitForFunction(
    String expression, {

    dynamic arg,

    double? timeout,

    double? pollingInterval,

    bool? isFunction,
  });

  /// Dispatches an event on the element matching the selector.
  Future<void> dispatchEvent(
    String selector,

    String type, {

    dynamic eventInit,

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

    dynamic arg,
  });

  Future<JSHandle> evaluateExpressionHandle(
    String expression, {

    bool? isFunction,

    dynamic arg,
  });

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

    dynamic expressionArg,

    FrameExpectPseudoEnum? pseudo,
  });

  Locator querySelector(String selector, {bool? strict});

  Future<List<Locator>> querySelectorAll(String selector);

  Future<int> queryCount(String selector);

  Future<List<String>> selectOption(
    String selector,

    dynamic values, {

    bool? force,

    double? timeout,

    bool? strict,

    List<ElementHandleBase>? elements,

    List<ElementHandleSelectOptionOptionsItems>? options,
  });

  Future<void> setInputFiles(
    String selector,

    dynamic files, {

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

  /// Returns the frame's URL.

  @override
  String url() => typedInitializer.url;

  PageImpl? _page;

  void internalSetPage(PageImpl p) => _page = p;

  /// Returns the page containing this frame.

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

  /// Returns a locator for the given selector.

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
  Locator getByRole(String role, {Pattern? name, bool exact = false}) {
    var sel = 'internal:role=$role';

    if (name != null) {
      sel += '[name=${encodePatternForRoleName(name, exact: exact)}]';
    }

    return locator(sel);
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

  /// Goto URL

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
  Future<dynamic> evaluate(String expression, [dynamic arg]) async {
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

  /// Waits for the required load state to be reached.

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

  /// Waits for the main frame to navigate to the given URL.

  @override
  Future<void> waitForURL(
    dynamic urlOrPredicate, {

    double? timeout,

    LifecycleEvent? waitUntil,
  }) async {
    final timeoutDuration = Duration(
      milliseconds: (timeout ?? (page as PageImpl).defaultTimeout).toInt(),
    );

    bool matches(String currentUrl) {
      if (urlOrPredicate is String) {
        return currentUrl.contains(urlOrPredicate) ||
            RegExp(urlOrPredicate).hasMatch(currentUrl);
      } else if (urlOrPredicate is RegExp) {
        return urlOrPredicate.hasMatch(currentUrl);
      } else if (urlOrPredicate is bool Function(String)) {
        return urlOrPredicate(currentUrl);
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

  /// Waits for navigation to complete.

  @override
  Future<void> waitForNavigation({
    String? url,

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

    dynamic arg,

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

    dynamic arg,

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

    dynamic arg,

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

    dynamic eventInit,

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

    dynamic arg,
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

    dynamic arg,
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

    dynamic expressionArg,

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

    dynamic values, {

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

    dynamic files, {

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
