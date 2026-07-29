import 'package:playwright_dart/playwright_dart.dart';
import 'dart:io';

void main() async {
  final playwright = await PlaywrightDart.create();
  final browser = await playwright.chromium.launch();
  final context = await browser.newContext();

  print('Starting tracing...');
  await context.tracing.start(screenshots: true, snapshots: true);
  await context.tracing.startChunk(name: 'trace', title: 'Playwright Trace');

  final page = await context.newPage();
  print('Navigating to website...');
  await page.goto('https://playwright.dev');

  print('Interacting with the page...');
  await page.getByRole('link', name: 'Get started').click();

  print('Stopping tracing and saving to trace.zip...');
  final result = await context.tracing.stopChunk(mode: ChunkMode.archive);

  if (result.artifact != null) {
    final artifact = result.artifact! as Artifact;
    final streamResult = await artifact.stream();
    final stream = streamResult.stream as PlaywrightStream;

    final buffer = <int>[];
    while (true) {
      final chunk = await stream.read();
      if (chunk.isEmpty) break;
      buffer.addAll(chunk);
    }

    final file = File('trace.zip');
    await file.writeAsBytes(buffer);
    await artifact.delete();

    print('Trace saved! You can view it at https://trace.playwright.dev');
  } else {
    print('No artifact returned from tracing stop');
  }

  await context.close();
  await browser.close();
}
