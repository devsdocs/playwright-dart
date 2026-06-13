import 'test_helper.dart';

void main() {
  group('Page API', () {
    test('should navigate and return title', (page) async {
      await page.goto('https://example.com');
      final title = await page.title();
      expect(title, equals('Example Domain'));
    });

    test('should evaluate JavaScript', (page) async {
      final result = await page.evaluate('1 + 2');
      expect(result, equals(3));
    });

    test('should set content and evaluate', (page) async {
      await page.setContent('<div><h1>Hello World</h1></div>');
      final text = await page.evaluate(
        '() => document.querySelector("h1").innerText',
      );
      expect(text, equals('Hello World'));
    });
  });
}
