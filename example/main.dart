import 'package:playwright_dart/playwright_dart.dart';

void main() async {
  print('Starting Playwright...');
  final playwright = await PlaywrightDart.create();

  print('Launching chromium...');
  final browser = await playwright.chromium.launch();

  print('Creating new page...');
  final page = await browser.newPage();

  print('Navigating to playwright.dev...');
  await page.goto('https://playwright.dev/');

  final title = await page.title();
  print('Page title: $title');

  print('Locating "Get started" link...');
  final getStarted = page.getByRole('link', name: 'Get started');
  final text = await getStarted.innerText();
  print('Found link text: $text');

  print('Clicking link...');
  await getStarted.click();

  print('Closing browser...');
  await browser.close();

  print('Done!');
}
