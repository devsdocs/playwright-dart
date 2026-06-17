import '../core/frame.dart';
import '../core/locator.dart';
import '../generated/channels.dart';
import '../infrastructure/serialization.dart';

class LocatorAssertions {
  final Locator _locator;
  final bool _isNot;
  final double? _timeout;

  LocatorAssertions(this._locator, [this._isNot = false, this._timeout]);

  LocatorAssertions get not => LocatorAssertions(_locator, !_isNot, _timeout);

  Future<void> toBeVisible({double? timeout}) async {
    await (_locator.frame as FrameImpl).channel_expect(
      selector: _locator.selector,
      expression: 'to.be.visible',
      isNot: _isNot,
      timeout: timeout ?? _timeout ?? 5000.0,
    );
  }

  Future<void> toBeHidden({double? timeout}) async {
    await (_locator.frame as FrameImpl).channel_expect(
      selector: _locator.selector,
      expression: 'to.be.hidden',
      isNot: _isNot,
      timeout: timeout ?? _timeout ?? 5000.0,
    );
  }

  Future<void> toHaveText(
    String expected, {
    double? timeout,
    bool useInnerText = false,
  }) async {
    await (_locator.frame as FrameImpl).channel_expect(
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

  Future<void> toContainText(
    String expected, {
    double? timeout,
    bool useInnerText = false,
  }) async {
    await (_locator.frame as FrameImpl).channel_expect(
      selector: _locator.selector,
      expression: 'to.have.text',
      expectedText: [ExpectedTextValue(string: expected, matchSubstring: true)],
      isNot: _isNot,
      timeout: timeout ?? _timeout ?? 5000.0,
      useInnerText: useInnerText,
    );
  }

  Future<void> toBeEnabled({double? timeout}) async {
    await (_locator.frame as FrameImpl).channel_expect(
      selector: _locator.selector,
      expression: 'to.be.enabled',
      isNot: _isNot,
      timeout: timeout ?? _timeout ?? 5000.0,
    );
  }

  Future<void> toBeDisabled({double? timeout}) async {
    await (_locator.frame as FrameImpl).channel_expect(
      selector: _locator.selector,
      expression: 'to.be.disabled',
      isNot: _isNot,
      timeout: timeout ?? _timeout ?? 5000.0,
    );
  }

  Future<void> toHaveAttribute(
    String name,
    String value, {
    double? timeout,
  }) async {
    await (_locator.frame as FrameImpl).channel_expect(
      selector: _locator.selector,
      expression: 'to.have.attribute',
      expressionArg: name,
      expectedText: [ExpectedTextValue(string: value, matchSubstring: false)],
      isNot: _isNot,
      timeout: timeout ?? _timeout ?? 5000.0,
    );
  }

  Future<void> toHaveClass(String expected, {double? timeout}) async {
    await (_locator.frame as FrameImpl).channel_expect(
      selector: _locator.selector,
      expression: 'to.have.class',
      expectedText: [
        ExpectedTextValue(string: expected, matchSubstring: false),
      ],
      isNot: _isNot,
      timeout: timeout ?? _timeout ?? 5000.0,
    );
  }

  Future<void> toHaveId(String expected, {double? timeout}) async {
    await (_locator.frame as FrameImpl).channel_expect(
      selector: _locator.selector,
      expression: 'to.have.id',
      expectedText: [
        ExpectedTextValue(string: expected, matchSubstring: false),
      ],
      isNot: _isNot,
      timeout: timeout ?? _timeout ?? 5000.0,
    );
  }

  Future<void> toHaveValue(String expected, {double? timeout}) async {
    await (_locator.frame as FrameImpl).channel_expect(
      selector: _locator.selector,
      expression: 'to.have.value',
      expectedText: [
        ExpectedTextValue(string: expected, matchSubstring: false),
      ],
      isNot: _isNot,
      timeout: timeout ?? _timeout ?? 5000.0,
    );
  }

  Future<void> toBeChecked({
    bool? checked,
    bool? indeterminate,
    double? timeout,
  }) async {
    final Map<String, dynamic> expectedValueMap = {};
    if (checked != null) expectedValueMap['checked'] = checked;
    if (indeterminate != null)
      expectedValueMap['indeterminate'] = indeterminate;

    await (_locator.frame as FrameImpl).channel_expect(
      selector: _locator.selector,
      expression: 'to.be.checked',
      expectedValue: expectedValueMap.isNotEmpty
          ? serializeArgument(expectedValueMap)
          : null,
      isNot: _isNot,
      timeout: timeout ?? _timeout ?? 5000.0,
    );
  }

  Future<void> toBeAttached({bool? attached, double? timeout}) async {
    await (_locator.frame as FrameImpl).channel_expect(
      selector: _locator.selector,
      expression: 'to.be.attached',
      expectedValue: attached != null ? serializeArgument(attached) : null,
      isNot: _isNot,
      timeout: timeout ?? _timeout ?? 5000.0,
    );
  }

  Future<void> toBeEditable({bool? editable, double? timeout}) async {
    await (_locator.frame as FrameImpl).channel_expect(
      selector: _locator.selector,
      expression: 'to.be.editable',
      expectedValue: editable != null ? serializeArgument(editable) : null,
      isNot: _isNot,
      timeout: timeout ?? _timeout ?? 5000.0,
    );
  }

  Future<void> toBeEmpty({double? timeout}) async {
    await (_locator.frame as FrameImpl).channel_expect(
      selector: _locator.selector,
      expression: 'to.be.empty',
      isNot: _isNot,
      timeout: timeout ?? _timeout ?? 5000.0,
    );
  }

  Future<void> toBeFocused({double? timeout}) async {
    await (_locator.frame as FrameImpl).channel_expect(
      selector: _locator.selector,
      expression: 'to.be.focused',
      isNot: _isNot,
      timeout: timeout ?? _timeout ?? 5000.0,
    );
  }

  Future<void> toBeInViewport({double? ratio, double? timeout}) async {
    await (_locator.frame as FrameImpl).channel_expect(
      selector: _locator.selector,
      expression: 'to.be.in.viewport',
      expectedNumber: ratio,
      isNot: _isNot,
      timeout: timeout ?? _timeout ?? 5000.0,
    );
  }

  Future<void> toContainClass(dynamic expected, {double? timeout}) async {
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

    await (_locator.frame as FrameImpl).channel_expect(
      selector: _locator.selector,
      expression: 'to.contain.class',
      expectedText: expectedText,
      isNot: _isNot,
      timeout: timeout ?? _timeout ?? 5000.0,
    );
  }

  Future<void> toHaveAccessibleDescription(
    String description, {
    bool? ignoreCase,
    double? timeout,
  }) async {
    await (_locator.frame as FrameImpl).channel_expect(
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

  Future<void> toHaveAccessibleErrorMessage(
    String message, {
    bool? ignoreCase,
    double? timeout,
  }) async {
    await (_locator.frame as FrameImpl).channel_expect(
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

  Future<void> toHaveAccessibleName(
    String name, {
    bool? ignoreCase,
    double? timeout,
  }) async {
    await (_locator.frame as FrameImpl).channel_expect(
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

  Future<void> toHaveCSS(
    String name,
    String value, {
    String? pseudo,
    double? timeout,
  }) async {
    await (_locator.frame as FrameImpl).channel_expect(
      selector: _locator.selector,
      expression: 'to.have.css',
      expressionArg: name,
      expectedText: [ExpectedTextValue(string: value, matchSubstring: false)],
      expectedValue: pseudo != null ? serializeArgument(pseudo) : null,
      isNot: _isNot,
      timeout: timeout ?? _timeout ?? 5000.0,
    );
  }

  Future<void> toHaveJSProperty(
    String name,
    dynamic value, {
    double? timeout,
  }) async {
    await (_locator.frame as FrameImpl).channel_expect(
      selector: _locator.selector,
      expression: 'to.have.js.property',
      expressionArg: name,
      expectedValue: serializeArgument(value),
      isNot: _isNot,
      timeout: timeout ?? _timeout ?? 5000.0,
    );
  }

  Future<void> toHaveRole(String role, {double? timeout}) async {
    await (_locator.frame as FrameImpl).channel_expect(
      selector: _locator.selector,
      expression: 'to.have.role',
      expectedText: [ExpectedTextValue(string: role, matchSubstring: false)],
      isNot: _isNot,
      timeout: timeout ?? _timeout ?? 5000.0,
    );
  }

  Future<void> toHaveValues(dynamic values, {double? timeout}) async {
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

    await (_locator.frame as FrameImpl).channel_expect(
      selector: _locator.selector,
      expression: 'to.have.values',
      expectedText: expectedText,
      isNot: _isNot,
      timeout: timeout ?? _timeout ?? 5000.0,
    );
  }

  Future<void> toMatchAriaSnapshot(String snapshot, {double? timeout}) async {
    await (_locator.frame as FrameImpl).channel_expect(
      selector: _locator.selector,
      expression: 'to.match.aria.snapshot',
      expressionArg: snapshot,
      isNot: _isNot,
      timeout: timeout ?? _timeout ?? 5000.0,
    );
  }

  Future<void> toHaveCount(int count, {double? timeout}) async {
    await (_locator.frame as FrameImpl).channel_expect(
      selector: _locator.selector,
      expression: 'to.have.count',
      expectedNumber: count.toDouble(),
      isNot: _isNot,
      timeout: timeout ?? _timeout ?? 5000.0,
    );
  }
}
