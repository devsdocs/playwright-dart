import '../core/page.dart';
import 'keyboard_key.dart';

class Keyboard {
  final Page page;

  Keyboard(this.page);

  /// Simulates pressing a key down and holding it.
  ///
  /// Use this for modifier keys (Shift, Control, Alt) or when you need
  /// to hold a key for an extended period. Remember to call [up] to release the key.
  ///
  /// Example:
  /// ```dart
  /// await keyboard.down('Shift');
  /// await keyboard.press('A'); // Types 'A' (uppercase)
  /// await keyboard.up('Shift');
  /// ```
  Future<void> down(String key) async {
    await (page as PageImpl).channel_keyboardDown(key: key);
  }

  /// Typesafe version of [down] that accepts a [KeyboardKey] enum.
  Future<void> downKey(KeyboardKey key) async {
    await down(key.value);
  }

  /// Simulates releasing a key that was previously pressed down.
  ///
  /// Use this after calling [down] to release a held key.
  ///
  /// Example:
  /// ```dart
  /// await keyboard.down('Shift');
  /// await keyboard.press('A');
  /// await keyboard.up('Shift');
  /// ```
  Future<void> up(String key) async {
    await (page as PageImpl).channel_keyboardUp(key: key);
  }

  /// Typesafe version of [up] that accepts a [KeyboardKey] enum.
  Future<void> upKey(KeyboardKey key) async {
    await up(key.value);
  }

  /// Inserts text directly into the focused element without key events.
  ///
  /// This bypasses the keyboard event system and directly sets the text value.
  /// Use this when you don't need to trigger keyboard events.
  Future<void> insertText(String text) async {
    await (page as PageImpl).channel_keyboardInsertText(text: text);
  }

  /// Types text character by character with optional delay between keystrokes.
  ///
  /// This simulates a user typing and triggers keyboard events for each character.
  /// Use [delay] to control the typing speed (in milliseconds).
  ///
  /// Example:
  /// ```dart
  /// await keyboard.type('Hello World', delay: 100);
  /// ```
  Future<void> type(String text, {double? delay}) async {
    await (page as PageImpl).channel_keyboardType(text: text, delay: delay);
  }

  /// Simulates a complete key press cycle (down then up).
  ///
  /// This is the most common way to press a key. It combines [down] and [up]
  /// in a single call. Use [delay] to add a delay between down and up.
  ///
  /// Example:
  /// ```dart
  /// await keyboard.press('Enter');
  /// await keyboard.press('Backspace');
  /// ```
  Future<void> press(String key, {double? delay}) async {
    await (page as PageImpl).channel_keyboardPress(key: key, delay: delay);
  }

  /// Typesafe version of [press] that accepts a [KeyboardKey] enum.
  Future<void> pressKey(KeyboardKey key, {double? delay}) async {
    await press(key.value, delay: delay);
  }

  // Shorthand convenience methods for common keys

  /// Presses the Enter key.
  Future<void> enter({double? delay}) async =>
      pressKey(KeyboardKey.enter, delay: delay);

  /// Presses the Escape key.
  Future<void> escape({double? delay}) async =>
      pressKey(KeyboardKey.escape, delay: delay);

  /// Presses the Backspace key.
  Future<void> backspace({double? delay}) async =>
      pressKey(KeyboardKey.backspace, delay: delay);

  /// Presses the Tab key.
  Future<void> tab({double? delay}) async =>
      pressKey(KeyboardKey.tab, delay: delay);

  /// Presses the Delete key.
  Future<void> delete({double? delay}) async =>
      pressKey(KeyboardKey.delete, delay: delay);

  /// Presses the Space key.
  Future<void> space({double? delay}) async =>
      pressKey(KeyboardKey.space, delay: delay);

  /// Presses the Up arrow key.
  Future<void> arrowUp({double? delay}) async =>
      pressKey(KeyboardKey.arrowUp, delay: delay);

  /// Presses the Down arrow key.
  Future<void> arrowDown({double? delay}) async =>
      pressKey(KeyboardKey.arrowDown, delay: delay);

  /// Presses the Left arrow key.
  Future<void> arrowLeft({double? delay}) async =>
      pressKey(KeyboardKey.arrowLeft, delay: delay);

  /// Presses the Right arrow key.
  Future<void> arrowRight({double? delay}) async =>
      pressKey(KeyboardKey.arrowRight, delay: delay);
}
