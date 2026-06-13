import 'page.dart';

class Keyboard {
  final Page page;

  Keyboard(this.page);

  Future<void> down(String key) async {
    await (page as PageImpl).channel_keyboardDown(key: key);
  }

  Future<void> up(String key) async {
    await (page as PageImpl).channel_keyboardUp(key: key);
  }

  Future<void> insertText(String text) async {
    await (page as PageImpl).channel_keyboardInsertText(text: text);
  }

  Future<void> type(String text, {double? delay}) async {
    await (page as PageImpl).channel_keyboardType(text: text, delay: delay);
  }

  Future<void> press(String key, {double? delay}) async {
    await (page as PageImpl).channel_keyboardPress(key: key, delay: delay);
  }
}
