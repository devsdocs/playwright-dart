import 'package:playwright_dart/playwright_dart.dart';
import 'dart:io';

void main() async {
  // If you want to use the Python/Java lifecycle pattern, pass autoClose: false
  // and manage the Playwright instance explicitly.
  final playwright = await PlaywrightDart.create(autoClose: false);

  try {
    // You can connect to a remote Browserless instance using CDP
    final wsEndpoint = Platform.environment['PLAYWRIGHT_WS_ENDPOINT'];
    
    if (wsEndpoint != null) {
      print('Connecting to remote browser at $wsEndpoint');
      final browser = await playwright.chromium.connectOverCDP(endpointURL: wsEndpoint);
      
      final page = await browser.newPage();
      await page.goto('https://example.com');
      print('Remote page title: ${await page.title()}');
      
      await browser.close();
    } else {
      print('No PLAYWRIGHT_WS_ENDPOINT set, skipping remote connection.');
      
      print('Launching local browser 1...');
      final browser1 = await playwright.chromium.launch();
      await browser1.close();

      print('Launching local browser 2...');
      final browser2 = await playwright.chromium.launch();
      await browser2.close();
    }
  } finally {
    // We must manually stop the Playwright connection when autoClose is false
    print('Stopping playwright driver...');
    await playwright.stop();
  }
}
