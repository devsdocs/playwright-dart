import 'package:playwright_dart/playwright_dart.dart';
import 'dart:io';

import 'package:playwright_dart/src/utils/logger.dart';

/// Example demonstrating how to connect to a remote browser via WebSocket.
///
/// This example uses connectOverCDP() to connect to a cloud-hosted browser
/// (e.g., Browserless.io) and generate a PDF of a Wikipedia page.
///
/// Set the PLAYWRIGHT_WS_ENDPOINT environment variable to your remote browser endpoint.
void main() async {
  try {
    final playwright = await PlaywrightDart.create(
      logLevel: LogLevel.info,
      autoClose: false,
    );

    // Connect to a remote browser via WebSocket using CDP protocol
    // Use connectOverCDP() for remote browser connections (cloud-hosted browsers)
    // Use connect() for Playwright servers launched with launchServer()
    final browser = await playwright.chromium.connectOverCDP(
      endpointURL: Platform.environment['PLAYWRIGHT_WS_ENDPOINT']!,
    );
    final page = await browser.newPage();

    print('Navigating to Wikipedia...');
    await page.goto(
      'https://en.wikipedia.org/wiki/Dart_(programming_language)',
    );

    print('Generating PDF...');
    final pdfBytes = await page.pdf(format: 'A4', landscape: false);

    final file = File('dart_wiki.pdf');
    await file.writeAsBytes(pdfBytes);
    print('Saved PDF to ${file.path} (${pdfBytes.length} bytes)');

    try {
      await browser.close();
    } catch (e) {
      // Ignore cleanup errors
    }

    try {
      await playwright.stop();
    } catch (e) {
      // Ignore cleanup errors
    }
  } catch (e) {
    // Ignore all errors
    print('Error: $e');
  }
}
