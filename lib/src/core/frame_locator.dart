import 'frame.dart';
import 'locator.dart';

/// FrameLocator represents a view to the `iframe` on the page.
class FrameLocator {
  final Frame frame;
  final String frameSelector;

  FrameLocator(this.frame, this.frameSelector);

  Locator locator(String selector) {
    return Locator(
      frame,
      '$frameSelector >> internal:control=enter-frame >> $selector',
    );
  }

  FrameLocator frameLocator(String selector) {
    return FrameLocator(
      frame,
      '$frameSelector >> internal:control=enter-frame >> $selector',
    );
  }

  Locator first() => locator('nth=0');
  Locator last() => locator('nth=-1');
  Locator nth(int index) => locator('nth=$index');

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
}
