import 'package:playwright_dart/playwright_dart.dart';

void main() async {
  print('Starting Playwright...');
  final playwright = await PlaywrightDart.create(autoClose: true);
  // Initialize Playwright and launch browser

  final browser = await playwright.chromium.launch();

  print('Creating browser context and page...');
  final context = await browser.newContext();
  final page = await context.newPage();

  // Test drag and drop using an online demo site
  print('Navigating to drag and drop demo...');
  await page.goto('https://the-internet.herokuapp.com/drag_and_drop');

  print('Waiting for source and target elements...');
  final source = page.locator('#column-a');
  final target = page.locator('#column-b');

  // Print text before dragging
  print('Before Drag:');
  print('Source Column Text: ${await source.textContent()}');
  print('Target Column Text: ${await target.textContent()}');

  // Perform drag and drop using the locator dragTo method
  print('Dragging Column A to Column B...');
  await source.dragTo(target);

  // Small delay to ensure UI updates
  await page.waitForTimeout(500);

  // Print text after dragging
  print('After Drag:');
  print('Source Column Text: ${await source.textContent()}');
  print('Target Column Text: ${await target.textContent()}');

  print('Closing browser...');
  await browser.close();
}
