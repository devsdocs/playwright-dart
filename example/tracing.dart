import 'package:playwright_dart/playwright_dart.dart';
import 'dart:io';

void main() async {
  final playwright = await PlaywrightDart.create();
  final browser = await playwright.chromium.launch();

  print('Starting tracing...');
  await browser.startTracing(
    screenshots: true,
    categories: ['devtools.timeline'],
  );

  final page = await browser.newPage();
  print('Navigating to website...');
  await page.goto('https://playwright.dev');

  print('Interacting with the page...');
  await page.getByRole('link', name: 'Get started').click();

  print('Stopping tracing and saving to trace.zip...');
  final traceBytes = await browser.stopTracing();

  final file = File('trace.zip');
  await file.writeAsBytes(traceBytes);

  print('Trace saved! You can view it at https://trace.playwright.dev');

  await browser.close();
}
