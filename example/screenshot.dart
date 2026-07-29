import 'package:playwright_dart/playwright_dart.dart';

void main() async {
  final playwright = await PlaywrightDart.create();
  final browser = await playwright.chromium.launch();
  final page = await browser.newPage();

  print('Navigating to example.com...');
  await page.goto('https://example.com');

  print('Taking full page screenshot...');
  final bytes = await page.screenshot(
    fullPage: true,
    type: ElementHandleScreenshotType.png,
  );

  print('Screenshot taken! Size: ${bytes.length} bytes');

  await browser.close();
}
