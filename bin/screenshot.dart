import 'package:playwright_dart/playwright_dart.dart';

void main() async {
  final playwright = await PlaywrightDart.create();
  final browser = await playwright.chromium.launch();
  final page = await browser.newPage();

  await page.goto('https://playwright.dev');
  await page.getByRole('link', name: 'Get started').click();
  await page.screenshot(path: 'screenshot.png');

  await browser.close();
}
