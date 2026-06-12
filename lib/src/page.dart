import 'generated/channels.dart';
import 'frame.dart';
import 'locator.dart';

class Page extends PageBase {
  Page(
    super.connection,
    super.type,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  String get _mainFrameGuid => initializer['mainFrame']['guid'];

  Frame get mainFrame => connection.objects[_mainFrameGuid] as Frame;

  Future<void> goto(String url) async {
    await mainFrame.goto(url);
  }

  Future<String> title() async {
    final result = await connection.sendMessageToServer(
      _mainFrameGuid,
      'title',
      {},
    );
    return result['value'] as String;
  }

  /// Returns a locator for the given selector.
  Locator locator(String selector) {
    return mainFrame.locator(selector);
  }

  /// Returns a locator by text.
  Locator getByText(String text, {bool exact = false}) {
    if (exact) {
      return locator('internal:text="$text"');
    }
    // Substring match
    return locator('internal:text=$text');
  }

  /// Returns a locator by role.
  Locator getByRole(String role, {String? name}) {
    var selector = 'internal:role=$role';
    if (name != null) {
      selector +=
          '[name="$name"i]'; // Case-insensitive matching by default in intro
    }
    return locator(selector);
  }
}
