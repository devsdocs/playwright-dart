import '../test_helper.dart';

void main() {
  group('Console API', () {
    test('should capture console messages using onConsole stream', (
      page,
    ) async {
      final messageFuture = page.onConsole.first;

      await Future.delayed(Duration(milliseconds: 100));

      await page.evaluate("() => console.log('Hello console stream!')");

      final message = await messageFuture;

      expect(message.text, equals('Hello console stream!'));
      expect(message.type, equals('log'));
    });
  });
}
