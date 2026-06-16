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
