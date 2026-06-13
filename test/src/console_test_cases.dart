import '../test_helper.dart';

void main() {
  group('Console API', () {
    test('should capture console messages', (page) async {
      await page.evaluate("() => console.log('Hello console!')");
      
      // Wait a moment for messages to propagate
      await Future.delayed(Duration(milliseconds: 100));

      final result = await page.consoleMessages();
      expect(result.messages.length, greaterThanOrEqualTo(1));
      
      final messages = result.messages.where((m) => m['text'] == 'Hello console!').toList();
      expect(messages.length, equals(1));
      expect(messages.first['type'], equals('log'));
    });
  });
}
