import 'channel_owner.dart';
import 'generated/channels.dart';
import 'jshandle.dart';
import 'locator.dart';
import 'serialization.dart';
import 'page.dart';

/// Interface for Frame
abstract interface class Frame {
  Stream<Map<String, dynamic>> get onNavigated;
  Stream<Map<String, dynamic>> get onLoadstate;
  String url();
  Page get page;
  Locator locator(String selector);
  Locator getByText(String text, {bool exact});
  Locator getByRole(String role, {String? name});
  Locator getByLabel(String text, {bool exact});
  Locator getByPlaceholder(String text, {bool exact});
  Locator getByAltText(String text, {bool exact});
  Locator getByTitle(String text, {bool exact});
  Locator getByTestId(String testId);
  Future<void> goto(
    String url, {
    double? timeout,
    LifecycleEvent? waitUntil,
    String? referer,
  });
  Future<String> textContent({
    required String selector,
    double? timeout,
    bool? strict,
  });
  Future<dynamic> evaluate(String expression, [dynamic arg]);
  Future<FrameWaitForSelectorResult> waitForSelector(
    String selector, {
    FrameWaitForSelectorStateEnum? state,
    double? timeout,
    bool? strict,
    bool? omitReturnValue,
  });
  Future<void> waitForLoadState({LifecycleEvent? state, double? timeout});
  Future<void> waitForURL(
    dynamic urlOrPredicate, {
    double? timeout,
    LifecycleEvent? waitUntil,
  });
  Future<void> waitForNavigation({
    String? url,
    LifecycleEvent? waitUntil,
    double? timeout,
  });
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
  Future<void> fill(
    String selector,
    String value, {
    bool? force,
    double? timeout,
    bool? strict,
  });
  Future<void> check(
    String selector, {
    bool? force,
    double? timeout,
    bool? strict,
    bool? trial,
    Point? position,
  });
  Future<void> uncheck(
    String selector, {
    bool? force,
    double? timeout,
    bool? strict,
    bool? trial,
    Point? position,
  });
  Future<void> hover(
    String selector, {
    bool? force,
    double? timeout,
    bool? strict,
    bool? trial,
    List<FrameHoverModifiersEnum>? modifiers,
    Point? position,
  });
  Future<void> focus(String selector, {double? timeout, bool? strict});
  Future<void> blur(String selector, {double? timeout, bool? strict});
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
  Future<void> type(
    String selector,
    String text, {
    double? delay,
    double? timeout,
    bool? strict,
  });
  Future<void> press(
    String selector,
    String key, {
    double? delay,
    double? timeout,
    bool? strict,
    bool? noWaitAfter,
  });
  Future<void> tap(
    String selector, {
    bool? force,
    double? timeout,
    bool? strict,
    bool? trial,
    List<FrameTapModifiersEnum>? modifiers,
    Point? position,
  });
  Future<String> content();
  Future<void> setContent(
    String html, {
    double? timeout,
    LifecycleEvent? waitUntil,
  });
  Future<dynamic> evalOnSelector(
    String selector,
    String expression, [
    dynamic arg,
    bool? strict,
    bool? isFunction,
  ]);
  Future<dynamic> evalOnSelectorAll(
    String selector,
    String expression, [
    dynamic arg,
    bool? isFunction,
  ]);
  Future<String?> getAttribute(
    String selector,
    String name, {
    double? timeout,
    bool? strict,
  });
  Future<String> innerHTML(String selector, {double? timeout, bool? strict});
  Future<String> innerText(String selector, {double? timeout, bool? strict});
  Future<String> inputValue(String selector, {double? timeout, bool? strict});
  Future<String> title();
  Future<bool> isChecked(String selector, {double? timeout, bool? strict});
  Future<bool> isDisabled(String selector, {double? timeout, bool? strict});
  Future<bool> isEnabled(String selector, {double? timeout, bool? strict});
  Future<bool> isHidden(String selector, {bool? strict});
  Future<bool> isVisible(String selector, {bool? strict});
  Future<bool> isEditable(String selector, {double? timeout, bool? strict});
  Future<void> addScriptTag({String? url, String? content, String? type});
  Future<void> addStyleTag({String? url, String? content});
  Future<void> waitForTimeout(double waitTimeout);
  Future<dynamic> waitForFunction(
    String expression, {
    dynamic arg,
    double? timeout,
    double? pollingInterval,
    bool? isFunction,
  });
  Future<void> dispatchEvent(
    String selector,
    String type, {
    dynamic eventInit,
    double? timeout,
    bool? strict,
  });
  Future<void> highlight(String selector, {String? style});
  Future<void> hideHighlight(String selector);
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
  Future<dynamic> evaluateExpressionHandle(
    String expression, {
    bool? isFunction,
    dynamic arg,
  });
  Future<dynamic> frameElement();
  Future<FrameExpectResult> expect(
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
  String url() => initializer['url'] as String;

  /// Returns the page containing this frame.
  @override
  Page get page => parent as Page;

  /// Returns a locator for the given selector.
  @override
  Locator locator(String selector) {
    return Locator(this, selector);
  }

  @override
  Locator getByText(String text, {bool exact = false}) {
    return exact
        ? locator('internal:text="$text"')
        : locator('internal:text=$text');
  }

  @override
  Locator getByRole(String role, {String? name}) {
    var sel = 'internal:role=$role';
    if (name != null) sel += '[name="$name"i]';
    return locator(sel);
  }

  @override
  Locator getByLabel(String text, {bool exact = false}) {
    return exact
        ? locator('internal:label="$text"')
        : locator('internal:label=$text');
  }

  @override
  Locator getByPlaceholder(String text, {bool exact = false}) {
    return exact
        ? locator('internal:attr=[placeholder="$text"]')
        : locator('internal:attr=[placeholder="$text"i]');
  }

  @override
  Locator getByAltText(String text, {bool exact = false}) {
    return exact
        ? locator('internal:attr=[alt="$text"]')
        : locator('internal:attr=[alt="$text"i]');
  }

  @override
  Locator getByTitle(String text, {bool exact = false}) {
    return exact
        ? locator('internal:attr=[title="$text"]')
        : locator('internal:attr=[title="$text"i]');
  }

  @override
  Locator getByTestId(String testId) {
    return locator('internal:testid=[data-testid="$testId"]');
  }

  /// Goto URL
  @override
  Future<void> goto(
    String url, {
    double? timeout,
    LifecycleEvent? waitUntil,
    String? referer,
  }) async {
    await channel_goto(
      url: url,
      timeout: timeout ?? 30000.0,
      waitUntil: waitUntil ?? LifecycleEvent.load,
      referer: referer,
    );
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
      timeout: timeout ?? 30000.0,
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
    final timeoutDuration = Duration(milliseconds: timeout?.toInt() ?? 30000);

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
    final timeoutDuration = Duration(milliseconds: timeout?.toInt() ?? 30000);

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
      final timeoutDuration = Duration(milliseconds: timeout?.toInt() ?? 30000);
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
    await channel_dragAndDrop(
      source: source,
      target: target,
      force: force,
      timeout: timeout ?? 30000.0,
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
      timeout: timeout ?? 30000.0,
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
      timeout: timeout ?? 30000.0,
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
      timeout: timeout ?? 30000.0,
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
      timeout: timeout ?? 30000.0,
      strict: strict,
      trial: trial,
      position: position,
    );
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
      timeout: timeout ?? 30000.0,
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
      timeout: timeout ?? 30000.0,
      strict: strict,
    );
  }

  @override
  Future<void> blur(String selector, {double? timeout, bool? strict}) async {
    await channel_blur(
      selector: selector,
      timeout: timeout ?? 30000.0,
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
      timeout: timeout ?? 30000.0,
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
      timeout: timeout ?? 30000.0,
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
      timeout: timeout ?? 30000.0,
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
      timeout: timeout ?? 30000.0,
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
    await channel_setContent(
      html: html,
      timeout: timeout ?? 30000.0,
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
      timeout: timeout ?? 30000.0,
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
      timeout: timeout ?? 30000.0,
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
      timeout: timeout ?? 30000.0,
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
      timeout: timeout ?? 30000.0,
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
      timeout: timeout ?? 30000.0,
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
      timeout: timeout ?? 30000.0,
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
      timeout: timeout ?? 30000.0,
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
      timeout: timeout ?? 30000.0,
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
  Future<dynamic> waitForFunction(
    String expression, {
    dynamic arg,
    double? timeout,
    double? pollingInterval,
    bool? isFunction,
  }) async {
    final result = await channel_waitForFunction(
      expression: expression,
      arg: serializeArgument(arg),
      timeout: timeout ?? 30000.0,
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
  Future<dynamic> evaluateExpressionHandle(
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
  Future<dynamic> frameElement() async {
    final result = await channel_frameElement();
    return ChannelOwner.from(
      connection,
      result.element as Map<String, dynamic>,
    );
  }

  @override
  Future<FrameExpectResult> expect(
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
    return await channel_expect(
      selector: selector,
      expression: expression,
      expectedValue: expectedValue,
      expectedText: expectedText,
      expectedNumber: expectedNumber,
      useInnerText: useInnerText,
      isNot: isNot,
      timeout: timeout ?? 30000.0,
      expressionArg: serializeArgument(expressionArg),
      pseudo: pseudo,
    );
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
