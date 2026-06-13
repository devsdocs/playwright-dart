import 'dart:io';

import 'package:playwright_dart/playwright_dart.dart';

void main(List<String> args) async {
  final isRemoteScreenshot = args.isNotEmpty;
  final playwright = await PlaywrightDart.create();

  if (isRemoteScreenshot) {
    final remoteBrowser = await playwright.chromium.connectOverCDP(
      endpointURL: args[0],
    );
    final page = await remoteBrowser.newPage();
    await page.goto('https://playwright.dev');
    final screenshotBytes = await page.screenshot();
    // Save the screenshot to a file
    final file = File('screenshot_remote.png');
    await file.writeAsBytes(screenshotBytes);
    await remoteBrowser.close();
  }
  // final localBrowser = await playwright.chromium.launch();

  // final page = await localBrowser.newPage();

  // await page.goto('https://playwright.dev');
  // await page.getByRole('link', name: 'Get started').click();
  // await page.screenshot(path: 'screenshot.png');

  // await localBrowser.close();
}
