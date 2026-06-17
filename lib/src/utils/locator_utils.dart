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

/// Builds the `internal:role=...` selector string with optional ARIA filter
/// attributes.
///
/// Encodes all ARIA filter options supported since Playwright v1.27+.
String buildRoleSelector(
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
  final buf = StringBuffer('internal:role=$role');

  if (name != null) {
    buf.write('[name=${encodePatternForRoleName(name, exact: exact)}]');
  }
  if (checked != null) buf.write('[checked=${checked ? 'true' : 'false'}]');
  if (disabled != null) buf.write('[disabled=${disabled ? 'true' : 'false'}]');
  if (expanded != null) buf.write('[expanded=${expanded ? 'true' : 'false'}]');
  if (includeHidden != null) {
    buf.write('[include-hidden=${includeHidden ? 'true' : 'false'}]');
  }
  if (level != null) buf.write('[level=$level]');
  if (pressed != null) {
    // aria-pressed can be true/false/mixed (mixed is treated as a bool here)
    buf.write('[pressed=${pressed ? 'true' : 'false'}]');
  }
  if (selected != null) buf.write('[selected=${selected ? 'true' : 'false'}]');
  if (description != null) {
    buf.write(
      '[description=${encodePatternForRoleName(description, exact: exact)}]',
    );
  }

  return buf.toString();
}
