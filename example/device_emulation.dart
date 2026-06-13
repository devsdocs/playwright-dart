import 'package:playwright_dart/playwright_dart.dart';

void main() async {
  final playwright = await PlaywrightDart.create();
  final browser = await playwright.chromium.launch();
  
  // Emulate an iPhone 13 Pro Max
  final context = await browser.newContext(
    options: ContextOptions(
      viewport: {'width': 428, 'height': 926},
      userAgent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 15_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.0 Mobile/15E148 Safari/604.1',
      deviceScaleFactor: 3,
      isMobile: true,
      hasTouch: true,
    )
  );

  final page = await context.newPage();

  print('Navigating to GitHub...');
  await page.goto('https://github.com');
  
  print('Page title on mobile: ${await page.title()}');

  await browser.close();
}
