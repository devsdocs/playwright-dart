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

  print('Evaluating document.title...');
  final evaluatedTitle = await page.mainFrame.evaluate('document.title');
  print('Evaluated title: $evaluatedTitle');

  print('Testing keyboard...');
  await page.keyboard.press('Tab');
  await page.keyboard.type('Hello Playwright');

  print('Testing mouse...');
  await page.mouse.move(100, 100);
  await page.mouse.click(100, 100);

  print('Fetching raw HTML content...');
  final html = await page.content();
  print('Page content length: ${html.length} characters');

  print('Taking a screenshot...');
  await page.screenshot(path: 'example.png');
  print('Screenshot saved to example.png');

  print('Closing browser...');
  await browser.close();

  print('Done!');
}
