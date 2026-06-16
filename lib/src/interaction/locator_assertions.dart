import '../core/frame.dart';
import '../core/locator.dart';
import '../generated/channels.dart';

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

  Future<void> toBeChecked({double? timeout}) async {
    await (_locator.frame as FrameImpl).channel_expect(
      selector: _locator.selector,
      expression: 'to.be.checked',
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
