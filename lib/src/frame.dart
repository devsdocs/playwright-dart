import 'channel_owner.dart';
import 'generated/channels.dart';
import 'jshandle.dart';
import 'locator.dart';
import 'serialization.dart';
import 'page.dart';

class Frame extends FrameBase {
  Frame(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  /// Returns the frame's URL.
  String url() => initializer['url'] as String;

  /// Returns the page containing this frame.
  Page get page => parent as Page;

  /// Returns a locator for the given selector.
  Locator locator(String selector) {
    return Locator(this, selector);
  }

  Locator getByText(String text, {bool exact = false}) {
    return exact
        ? locator('internal:text="$text"')
        : locator('internal:text=$text');
  }

  Locator getByRole(String role, {String? name}) {
    var sel = 'internal:role=$role';
    if (name != null) sel += '[name="$name"i]';
    return locator(sel);
  }

  Locator getByLabel(String text, {bool exact = false}) {
    return exact
        ? locator('internal:label="$text"')
        : locator('internal:label=$text');
  }

  Locator getByPlaceholder(String text, {bool exact = false}) {
    return exact
        ? locator('internal:attr=[placeholder="$text"]')
        : locator('internal:attr=[placeholder="$text"i]');
  }

  Locator getByAltText(String text, {bool exact = false}) {
    return exact
        ? locator('internal:attr=[alt="$text"]')
        : locator('internal:attr=[alt="$text"i]');
  }

  Locator getByTitle(String text, {bool exact = false}) {
    return exact
        ? locator('internal:attr=[title="$text"]')
        : locator('internal:attr=[title="$text"i]');
  }

  Locator getByTestId(String testId) {
    return locator('internal:testid=[data-testid="$testId"]');
  }

  /// Goto URL
  Future<void> goto(
    String url, {
    double? timeout,
    String waitUntil = 'load',
    String? referer,
  }) async {
    await channel_goto(
      url: url,
      timeout: timeout ?? 30000.0,
      waitUntil: LifecycleEvent.values.firstWhere(
        (e) => e.value == waitUntil,
        orElse: () => LifecycleEvent.load,
      ),
      referer: referer,
    );
  }

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

  Future<dynamic> evaluate(String expression, [dynamic arg]) async {
    final result = await channel_evaluateExpression(
      expression: expression,
      arg: serializeArgument(arg),
    );
    return parseSerializedValue(result.value);
  }

  Future<void> waitForSelector(
    String selector, {
    FrameWaitForSelectorStateEnum? state,
    double? timeout,
    bool? strict,
    bool? omitReturnValue,
  }) async {
    await channel_waitForSelector(
      selector: selector,
      state: state,
      timeout: timeout ?? 30000.0,
      strict: strict,
      omitReturnValue: omitReturnValue,
    );
  }

  /// Waits for the required load state to be reached.
  Future<void> waitForLoadState({
    String state = 'load',
    double? timeout,
  }) async {
    final timeoutDuration = Duration(milliseconds: timeout?.toInt() ?? 30000);

    // Some events might have already occurred if we check the current state, but for simplicity
    // we wait for the next loadstate event matching our state. Playwright JS has a more complex Waiter.
    await onEvent
        .firstWhere(
          (e) => e['event'] == 'loadstate' && e['params']['add'] == state,
        )
        .timeout(
          timeoutDuration,
          onTimeout: () => throw Exception(
            'Timeout ${timeoutDuration.inMilliseconds}ms exceeded while waiting for $state',
          ),
        );
  }

  /// Waits for the main frame to navigate to the given URL.
  Future<void> waitForURL(
    dynamic urlOrPredicate, {
    double? timeout,
    String waitUntil = 'load',
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
  Future<void> waitForNavigation({
    String? url,
    String waitUntil = 'load',
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

  Future<void> dragAndDrop(
    String source,
    String target, {
    bool? force,
    double? timeout,
    bool? strict,
    bool? trial,
    Map<String, dynamic>? sourcePosition,
    Map<String, dynamic>? targetPosition,
    int? steps,
  }) async {
    await channel_dragAndDrop(
      source: source,
      target: target,
      force: force,
      timeout: timeout ?? 30000.0,
      strict: strict,
      trial: trial,
      sourcePosition: sourcePosition != null
          ? Point(
              x: sourcePosition['x'] as double,
              y: sourcePosition['y'] as double,
            )
          : null,
      targetPosition: targetPosition != null
          ? Point(
              x: targetPosition['x'] as double,
              y: targetPosition['y'] as double,
            )
          : null,
      steps: steps,
    );
  }

  Future<void> click(
    String selector, {
    bool? force,
    double? timeout,
    bool? strict,
    bool? trial,
    bool? noWaitAfter,
    List<String>? modifiers,
    Map<String, dynamic>? position,
    double? delay,
    String? button,
    int? clickCount,
    int? steps,
  }) async {
    await channel_click(
      selector: selector,
      force: force,
      timeout: timeout ?? 30000.0,
      strict: strict,
      trial: trial,

      modifiers: modifiers
          ?.map(
            (e) =>
                FrameClickModifiersEnum.values.firstWhere((m) => m.value == e),
          )
          .toList(),
      position: position != null
          ? Point(x: position['x'] as double, y: position['y'] as double)
          : null,
      delay: delay,
      button: button != null
          ? FrameClickButtonEnum.values.firstWhere((e) => e.value == button)
          : null,
      clickCount: clickCount,
      steps: steps,
    );
  }

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

  Future<void> check(
    String selector, {
    bool? force,
    double? timeout,
    bool? strict,
    bool? trial,
    Map<String, dynamic>? position,
  }) async {
    await channel_check(
      selector: selector,
      force: force,
      timeout: timeout ?? 30000.0,
      strict: strict,
      trial: trial,
      position: position != null
          ? Point(x: position['x'] as double, y: position['y'] as double)
          : null,
    );
  }

  Future<void> uncheck(
    String selector, {
    bool? force,
    double? timeout,
    bool? strict,
    bool? trial,
    Map<String, dynamic>? position,
  }) async {
    await channel_uncheck(
      selector: selector,
      force: force,
      timeout: timeout ?? 30000.0,
      strict: strict,
      trial: trial,
      position: position != null
          ? Point(x: position['x'] as double, y: position['y'] as double)
          : null,
    );
  }

  Future<void> hover(
    String selector, {
    bool? force,
    double? timeout,
    bool? strict,
    bool? trial,
    List<String>? modifiers,
    Map<String, dynamic>? position,
  }) async {
    await channel_hover(
      selector: selector,
      force: force,
      timeout: timeout ?? 30000.0,
      strict: strict,
      trial: trial,
      modifiers: modifiers
          ?.map(
            (e) =>
                FrameHoverModifiersEnum.values.firstWhere((m) => m.value == e),
          )
          .toList(),
      position: position != null
          ? Point(x: position['x'] as double, y: position['y'] as double)
          : null,
    );
  }

  Future<void> focus(String selector, {double? timeout, bool? strict}) async {
    await channel_focus(
      selector: selector,
      timeout: timeout ?? 30000.0,
      strict: strict,
    );
  }

  Future<void> blur(String selector, {double? timeout, bool? strict}) async {
    await channel_blur(
      selector: selector,
      timeout: timeout ?? 30000.0,
      strict: strict,
    );
  }

  Future<void> dblclick(
    String selector, {
    bool? force,
    double? timeout,
    bool? strict,
    bool? trial,
    List<String>? modifiers,
    Map<String, dynamic>? position,
    double? delay,
    String? button,
    int? steps,
  }) async {
    await channel_dblclick(
      selector: selector,
      force: force,
      timeout: timeout ?? 30000.0,
      strict: strict,
      trial: trial,
      modifiers: modifiers
          ?.map(
            (e) => FrameDblclickModifiersEnum.values.firstWhere(
              (m) => m.value == e,
            ),
          )
          .toList(),
      position: position != null
          ? Point(x: position['x'] as double, y: position['y'] as double)
          : null,
      delay: delay,
      button: button != null
          ? FrameDblclickButtonEnum.values.firstWhere((e) => e.value == button)
          : null,
      steps: steps,
    );
  }

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

  Future<void> tap(
    String selector, {
    bool? force,
    double? timeout,
    bool? strict,
    bool? trial,
    List<String>? modifiers,
    Map<String, dynamic>? position,
  }) async {
    await channel_tap(
      selector: selector,
      force: force,
      timeout: timeout ?? 30000.0,
      strict: strict,
      trial: trial,
      modifiers: modifiers
          ?.map(
            (e) => FrameTapModifiersEnum.values.firstWhere((m) => m.value == e),
          )
          .toList(),
      position: position != null
          ? Point(x: position['x'] as double, y: position['y'] as double)
          : null,
    );
  }

  Future<String> content() async {
    final result = await channel_content();
    return result.value;
  }

  Future<void> setContent(
    String html, {
    double? timeout,
    String waitUntil = 'load',
  }) async {
    await channel_setContent(
      html: html,
      timeout: timeout ?? 30000.0,
      waitUntil: LifecycleEvent.values.firstWhere(
        (e) => e.value == waitUntil,
        orElse: () => LifecycleEvent.load,
      ),
    );
  }

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

  Future<String> title() async {
    final result = await channel_title();
    return result.value;
  }

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

  Future<bool> isHidden(String selector, {bool? strict}) async {
    final result = await channel_isHidden(selector: selector, strict: strict);
    return result.value;
  }

  Future<bool> isVisible(String selector, {bool? strict}) async {
    final result = await channel_isVisible(selector: selector, strict: strict);
    return result.value;
  }

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

  Future<void> addScriptTag({
    String? url,
    String? content,
    String? type,
  }) async {
    await channel_addScriptTag(url: url, content: content, type: type);
  }

  Future<void> addStyleTag({String? url, String? content}) async {
    await channel_addStyleTag(url: url, content: content);
  }

  Future<void> waitForTimeout(double waitTimeout) async {
    await channel_waitForTimeout(waitTimeout: waitTimeout);
  }

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

  Future<void> highlight(String selector, {String? style}) async {
    await channel_highlight(selector: selector, style: style);
  }

  Future<void> hideHighlight(String selector) async {
    await channel_hideHighlight(selector: selector);
  }

  Future<void> drop(
    String selector, {
    List<Map<String, dynamic>>? payloads,
    List<String>? localPaths,
    List<Map<String, dynamic>>? data,
    bool? strict,
    double? timeout,
    Map<String, dynamic>? position,
    List<dynamic>? streams,
  }) async {
    await channel_drop(
      selector: selector,
      strict: strict,
      payloads: payloads
          ?.map((e) => FrameDropPayloadsItems.fromJson(e))
          .toList(),
      localPaths: localPaths,
      data: data?.map((e) => FrameDropDataItems.fromJson(e)).toList(),
      timeout: timeout ?? 30000.0,
      position: position != null
          ? Point(x: position['x'] as double, y: position['y'] as double)
          : null,
      streams: streams?.map((s) => s as WritableStreamBase).toList(),
    );
  }

  Future<FrameResolveSelectorResult> resolveSelector(String selector) async {
    return await channel_resolveSelector(selector: selector);
  }

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

  Future<dynamic> frameElement() async {
    final result = await channel_frameElement();
    return ChannelOwner.from(
      connection,
      result.element as Map<String, dynamic>,
    );
  }

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
    String? pseudo,
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
      pseudo: pseudo != null
          ? FrameExpectPseudoEnum.values.firstWhere((e) => e.value == pseudo)
          : null,
    );
  }

  Locator querySelector(String selector, {bool? strict}) {
    // strict parameter is accepted to satisfy types but locator handles strictness internally
    return locator(selector);
  }

  Future<List<Locator>> querySelectorAll(String selector) async {
    final result = await channel_querySelectorAll(selector: selector);
    final elements = result.elements as List? ?? [];
    return elements.map((_) => locator(selector)).toList();
  }

  Future<int> queryCount(String selector) async {
    final result = await channel_queryCount(selector: selector);
    return result.value;
  }

  Future<List<String>> selectOption(
    String selector,
    dynamic values, {
    bool? force,
    double? timeout,
    bool? strict,
    List<Map<String, dynamic>>? elements,
    List<Map<String, dynamic>>? options,
  }) async {
    final parsed = parseSelectOptions(values);
    final result = await channel_selectOption(
      selector: selector,
      elements: elements != null
          ? elements.cast<ElementHandleBase>()
          : parsed.elements,
      options: (options ?? parsed.options)
          ?.map((e) => FrameSelectOptionOptionsItems.fromJson(e))
          .toList(),
      strict: strict,
      force: force,
      timeout: timeout ?? 30000.0,
    );
    return (result.values as List).cast<String>();
  }

  Future<void> setInputFiles(
    String selector,
    dynamic files, {
    bool? noWaitAfter,
    double? timeout,
    bool? strict,
    List<Map<String, dynamic>>? payloads,
    String? localDirectory,
    ChannelOwner? directoryStream,
    List<String>? localPaths,
    List<ChannelOwner>? streams,
  }) async {
    final parsed = parseInputFiles(files);
    await channel_setInputFiles(
      selector: selector,
      payloads: (payloads ?? parsed.payloads)
          ?.map((e) => FrameSetInputFilesPayloadsItems.fromJson(e))
          .toList(),
      localPaths: localPaths ?? parsed.localPaths,
      timeout: timeout ?? 30000.0,
      strict: strict,
      localDirectory: localDirectory,
      directoryStream: directoryStream as WritableStreamBase?,
      streams: streams?.map((s) => s as WritableStreamBase).toList(),
    );
  }
}
