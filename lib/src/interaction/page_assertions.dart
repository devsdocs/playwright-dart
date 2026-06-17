import '../core/frame.dart';
import '../core/page.dart';
import '../generated/channels.dart';

/// Web-first assertions for a [Page].
///
/// Obtain via [Page.pageExpect]:
/// ```dart
/// await page.pageExpect().toHaveTitle('My Page');
/// await page.pageExpect().toHaveURL('https://example.com/login');
/// ```
class PageAssertions {
  final Page _page;
  final bool _isNot;
  final double? _timeout;

  PageAssertions(this._page, [this._isNot = false, this._timeout]);

  /// Returns the negated assertions object.
  PageAssertions get not => PageAssertions(_page, !_isNot, _timeout);

  /// Checks that the page has the expected title.
  ///
  /// [expected] can be a [String] (exact/substring match) or a [RegExp].
  Future<void> toHaveTitle(Pattern expected, {double? timeout}) async {
    final text = _patternToExpectedText(expected);
    // Page-level assertions (title, url) must NOT pass a selector; the
    // Playwright Node.js driver resolves these from `document` when no element
    // is resolved (selector absent → element null in the driver).
    await (_page.mainFrame as FrameImpl).channel_expect(
      expression: 'to.have.title',
      expectedText: text,
      isNot: _isNot,
      timeout: timeout ?? _timeout ?? 5000.0,
      // selector intentionally omitted — page assertion, not DOM assertion
    );
  }

  /// Checks that the page has the expected URL.
  ///
  /// [expected] can be a [String] (substring/glob) or a [RegExp].
  Future<void> toHaveURL(Pattern expected, {double? timeout}) async {
    final text = _patternToExpectedText(expected);
    await (_page.mainFrame as FrameImpl).channel_expect(
      expression: 'to.have.url',
      expectedText: text,
      isNot: _isNot,
      timeout: timeout ?? _timeout ?? 5000.0,
      // selector intentionally omitted — page assertion, not DOM assertion
    );
  }

  // ---- helpers -------------------------------------------------------

  List<ExpectedTextValue> _patternToExpectedText(Pattern expected) {
    if (expected is RegExp) {
      return [
        ExpectedTextValue(
          regexSource: expected.pattern,
          regexFlags: _regexFlags(expected),
          matchSubstring: false,
        ),
      ];
    }
    return [
      ExpectedTextValue(string: expected as String, matchSubstring: false),
    ];
  }

  String _regexFlags(RegExp re) {
    final flags = StringBuffer();
    if (!re.isCaseSensitive) flags.write('i');
    if (re.isMultiLine) flags.write('m');
    if (re.isDotAll) flags.write('s');
    if (re.isUnicode) flags.write('u');
    return flags.toString();
  }
}
