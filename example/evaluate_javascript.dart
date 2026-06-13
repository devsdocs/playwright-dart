import 'package:playwright_dart/playwright_dart.dart';

void main() async {
  final playwright = await PlaywrightDart.create();
  final browser = await playwright.chromium.launch();
  final page = await browser.newPage();

  await page.goto('https://example.com');

  // Evaluate simple JavaScript
  final title = await page.evaluate('document.title');
  print('Title from JS: $title');

  // Evaluate JavaScript passing complex objects
  final data = {
    'name': 'Playwright',
    'language': 'Dart'
  };
  
  final message = await page.evaluate(
    '(data) => `Hello \${data["name"]} from \${data["language"]}!`',
    data
  );
  
  print('Evaluated Message: $message');

  await browser.close();
}
