import 'package:playwright_dart/playwright_dart.dart';
import 'dart:io';

void main() async {
  final playwright = await PlaywrightDart.create();
  final browser = await playwright.chromium.launch();
  final page = await browser.newPage();

  print('Navigating to Wikipedia...');
  await page.goto('https://en.wikipedia.org/wiki/Dart_(programming_language)');

  print('Generating PDF...');
  final pdfBytes = await page.pdf(format: PdfFormat.a4, landscape: true);

  final file = File('dart_wiki.pdf');
  await file.writeAsBytes(pdfBytes);
  print('Saved PDF to ${file.path} (${pdfBytes.length} bytes)');

  await browser.close();
}
