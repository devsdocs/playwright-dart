import 'frame.dart';

class Locator {
  final Frame frame;
  final String selector;

  Locator(this.frame, this.selector);

  Locator locator(String selectorOrLocator) {
    return Locator(frame, '$selector >> $selectorOrLocator');
  }

  Future<void> click({bool? force, double? timeout}) async {
    await frame.channel_click(
      selector: selector,
      force: force,
      timeout: timeout ?? 30000.0,
    );
  }

  Future<void> fill(String value, {bool? force, double? timeout}) async {
    await frame.channel_fill(
      selector: selector,
      value: value,
      force: force,
      timeout: timeout ?? 30000.0,
    );
  }

  Future<void> check({bool? force, double? timeout}) async {
    await frame.channel_check(
      selector: selector,
      force: force,
      timeout: timeout ?? 30000.0,
    );
  }

  Future<void> uncheck({bool? force, double? timeout}) async {
    await frame.channel_uncheck(
      selector: selector,
      force: force,
      timeout: timeout ?? 30000.0,
    );
  }

  Future<String> innerText({double? timeout}) async {
    final result = await frame.channel_innerText(
      selector: selector,
      timeout: timeout ?? 30000.0,
    );
    return result['value'] as String;
  }

  Future<String> textContent({double? timeout}) async {
    final result = await frame.channel_textContent(
      selector: selector,
      timeout: timeout ?? 30000.0,
    );
    return result['value'] as String;
  }
}
