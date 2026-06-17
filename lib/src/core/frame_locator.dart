import 'frame.dart';

import 'locator.dart';

import '../utils/locator_utils.dart';

/// FrameLocator represents a view to the `iframe` on the page.

class FrameLocator {
  final Frame frame;

  final String frameSelector;

  FrameLocator(this.frame, this.frameSelector);

  /// Returns a [Locator] for the `<iframe>` element itself.
  ///
  /// This is the reverse of [Locator.contentFrame].
  /// Available since Playwright v1.43.
  Locator owner() => Locator(frame, frameSelector);

  /// Creates a locator for the given selector within this frame.
  Locator locator(String selector) {
    return Locator(
      frame,

      '$frameSelector >> internal:control=enter-frame >> $selector',
    );
  }

  /// Creates a frame locator for the given selector within this frame.
  FrameLocator frameLocator(String selector) {
    return FrameLocator(
      frame,

      '$frameSelector >> internal:control=enter-frame >> $selector',
    );
  }

  /// Returns the first matching locator.
  Locator first() => locator('nth=0');

  /// Returns the last matching locator.
  Locator last() => locator('nth=-1');

  /// Returns the nth matching locator.
  Locator nth(int index) => locator('nth=$index');

  /// Locates element by text content.
  Locator getByText(Pattern text, {bool exact = false}) {
    return locator(
      'internal:text=${encodePatternForTextSelector(text, exact: exact)}',
    );
  }

  /// Locates element by ARIA role.
  Locator getByRole(
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
    return locator(
      buildRoleSelector(
        role,
        name: name,
        exact: exact,
        checked: checked,
        disabled: disabled,
        expanded: expanded,
        includeHidden: includeHidden,
        level: level,
        pressed: pressed,
        selected: selected,
        description: description,
      ),
    );
  }

  /// Locates element by associated label.
  Locator getByLabel(Pattern text, {bool exact = false}) {
    return locator(
      'internal:label=${encodePatternForLabelSelector(text, exact: exact)}',
    );
  }

  /// Locates element by placeholder text.
  Locator getByPlaceholder(Pattern text, {bool exact = false}) {
    return locator(
      'internal:attr=[placeholder=${encodePatternForAttrSelector(text, exact: exact)}]',
    );
  }

  /// Locates element by alt text.
  Locator getByAltText(Pattern text, {bool exact = false}) {
    return locator(
      'internal:attr=[alt=${encodePatternForAttrSelector(text, exact: exact)}]',
    );
  }

  /// Locates element by title attribute.
  Locator getByTitle(Pattern text, {bool exact = false}) {
    return locator(
      'internal:attr=[title=${encodePatternForAttrSelector(text, exact: exact)}]',
    );
  }

  /// Locates element by test ID.
  Locator getByTestId(String testId) {
    return locator(getByTestIdSelector(testId));
  }
}
