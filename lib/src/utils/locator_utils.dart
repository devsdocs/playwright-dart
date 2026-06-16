import 'dart:convert';

String _testIdAttributeName = 'data-testid';

/// Returns the configured test id attribute name used by [getByTestIdSelector].
String get testIdAttributeName => _testIdAttributeName;

/// Updates the test id attribute name used when building getByTestId selectors.
void setTestIdAttributeName(String name) {
  _testIdAttributeName = name;
}

String encodeTestIdAttributeName(String testIdAttributeName) {
  return testIdAttributeName.contains(',')
      ? jsonEncode(testIdAttributeName)
      : testIdAttributeName;
}

String escapeForAttributeSelector(String value, {bool exact = false}) {
  final escaped = value.replaceAll('\\', '\\\\').replaceAll('"', '\\"');
  return '"$escaped"${exact ? 's' : 'i'}';
}

String getByTestIdSelector(String testId) {
  return 'internal:testid=[${encodeTestIdAttributeName(_testIdAttributeName)}=${escapeForAttributeSelector(testId, exact: true)}]';
}

/// Serializes a [RegExp] to the `/pattern/flags` format expected by the
/// Playwright selector engine.
String regExpToString(RegExp re) {
  final flags = StringBuffer();
  if (!re.isCaseSensitive) flags.write('i');
  if (re.isMultiLine) flags.write('m');
  if (re.isDotAll) flags.write('s');
  if (re.isUnicode) flags.write('u');
  return '/${re.pattern}/$flags';
}

/// Encodes a [Pattern] (either [String] or [RegExp]) for use in an
/// `internal:text` / `internal:has-text` selector.
///
/// - [String] with [exact] `false` → `value` (substring, case-insensitive)
/// - [String] with [exact] `true`  → `"value"` (exact, case-sensitive)
/// - [RegExp]                       → `/pattern/flags` ([exact] is ignored)
String encodePatternForTextSelector(Pattern text, {bool exact = false}) {
  if (text is RegExp) return regExpToString(text);
  final s = text as String;
  if (exact) {
    final escaped = s.replaceAll('\\', '\\\\').replaceAll('"', '\\"');
    return '"$escaped"';
  }
  return s;
}

/// Encodes a [Pattern] for use in an `internal:attr=[attr=…]` selector.
///
/// - [String] with [exact] `false` → `"value"i`
/// - [String] with [exact] `true`  → `"value"s`
/// - [RegExp]                       → `/pattern/flags` ([exact] is ignored)
String encodePatternForAttrSelector(Pattern text, {bool exact = false}) {
  if (text is RegExp) return regExpToString(text);
  return escapeForAttributeSelector(text as String, exact: exact);
}

/// Encodes a [Pattern] for use in an `internal:label` selector.
String encodePatternForLabelSelector(Pattern text, {bool exact = false}) {
  if (text is RegExp) return regExpToString(text);
  final s = text as String;
  if (exact) {
    final escaped = s.replaceAll('\\', '\\\\').replaceAll('"', '\\"');
    return '"$escaped"';
  }
  return s;
}

/// Encodes a [Pattern] for use in an `internal:role` `name` attribute.
///
/// - [String] with [exact] `false` → `"value"i`
/// - [String] with [exact] `true`  → `"value"s`
/// - [RegExp]                       → `/pattern/flags`
String encodePatternForRoleName(Pattern name, {bool exact = false}) {
  if (name is RegExp) return regExpToString(name);
  return escapeForAttributeSelector(name as String, exact: exact);
}
