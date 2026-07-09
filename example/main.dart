// Example demonstrating basic Playwright Dart usage.
//
// This script launches Chromium, navigates to a page, interacts with
// elements using the Locator API, evaluates JavaScript, and takes a screenshot.
import 'package:playwright_dart/playwright_dart.dart';

void main() async {
  // Connect directly to a remote Playwright endpoint.
  // This avoids local browser installation/download.
  final playwright = await PlaywrightDart.create();

  // Create a new page
  final browser = await playwright.chromium.launch();
  final page = await browser.newPage();

  // Set page content with interactive elements
  await page.setContent('''
    <html>
      <head><title>Playwright Dart Example</title></head>
      <body>
        <h1 id="header">Hello World</h1>
        <button id="btn">Click Me</button>
        <input type="text" id="name" placeholder="Enter your name" />
        <select id="dropdown">
          <option value="opt1">Option 1</option>
          <option value="opt2">Option 2</option>
        </select>
      </body>
    </html>
  ''');

  // Get the page title
  final title = await page.title();
  print('Page title: $title');

  // Use Locator API for interactions
  await page.locator('#btn').click();
  print('Button clicked!');

  await page.locator('#name').fill('Playwright Dart');
  print('Input filled!');

  final selected = await page.locator('#dropdown').selectOption([
    SelectOption.value('opt2'),
  ]);
  print('Selected: $selected');

  // Evaluate JavaScript
  final result = await page.mainFrame.evaluate('document.title');
  print('Evaluated title: $result');

  // Clean up
  await browser.close();
  print('Done!');
}
