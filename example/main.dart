import 'package:playwright_dart/playwright_dart.dart';

void main() async {
  print('Starting Playwright...');
  final playwright = await PlaywrightDart.create();

  print('Launching chromium...');
  final browser = await playwright.chromium.launch();

  print('Creating new page...');
  final page = await browser.newPage();

  final htmlContent = '''
    <html>
      <body>
        <h1 id="header">Hello World</h1>
        <button id="btn">Click Me</button>
        <select id="dropdown">
          <option value="opt1">Option 1</option>
          <option value="opt2">Option 2</option>
        </select>
        <input type="file" id="file-upload" />
      </body>
    </html>
  ''';
  await page.setContent(htmlContent);

  final title = await page.title();
  print('Page title: $title');

  print('Testing click...');
  final btn = page.locator('#btn');
  await btn.click();
  print('Button clicked!');

  print('Testing selectOption...');
  final dropdown = page.locator('#dropdown');
  final selected = await dropdown.selectOption('opt2');
  print('Selected option: $selected');

  print('Testing setInputFiles...');
  final fileUpload = page.locator('#file-upload');
  await fileUpload.setInputFiles([
    FilePayload(
      name: 'test.txt',
      mimeType: 'text/plain',
      buffer: 'hello world'.codeUnits,
    ),
  ]);
  print('File uploaded!');

  print('Evaluating document.title...');
  final evaluatedTitle = await page.mainFrame.evaluate('document.title');
  print('Evaluated title: $evaluatedTitle');

  print('Closing browser...');
  await browser.close();

  print('Done!');
}
