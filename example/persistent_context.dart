import 'package:playwright_dart/playwright_dart.dart';
import 'dart:io';

void main() async {
  final playwright = await PlaywrightDart.create();

  // Use a temporary directory for this example
  final tempDir = Directory.systemTemp.createTempSync('playwright_example_');
  print('Using persistent profile at: ${tempDir.path}');

  print('Launching first persistent context...');
  final context1 = await playwright.chromium.launchPersistentContext(
    tempDir.path,
  );
  final page1 = await context1.newPage();

  // Set a persistent local storage item
  print('Setting persistent local storage...');
  await page1.goto('https://example.com');
  await page1.evaluate(
    'localStorage.setItem("persistent_auth", "secret_token_123");',
  );

  await Future.delayed(const Duration(seconds: 1));

  print('Closing first browser...');
  await context1.close();

  // Relaunch the same profile
  print('Relaunching second persistent context...');
  final context2 = await playwright.chromium.launchPersistentContext(
    tempDir.path,
  );
  final page2 = await context2.newPage();
  await page2.goto('https://example.com');

  // Verify item survived
  final value = await page2.evaluate(
    'localStorage.getItem("persistent_auth");',
  );
  print('Recovered Local Storage Item: persistent_auth = $value');

  await context2.close();
  tempDir.deleteSync(recursive: true);
}
