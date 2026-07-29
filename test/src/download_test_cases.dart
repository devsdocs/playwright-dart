import 'dart:io';

import 'package:playwright_dart/playwright_dart.dart';
import 'package:test/test.dart';

void main() {
  late Playwright playwright;
  late Browser browser;
  late BrowserContext context;

  setUpAll(() async {
    playwright = await PlaywrightDart.create();
    browser = await playwright.chromium.launch();
    // Enable downloads for this context
    context = await browser.newContext(
      options: ContextOptions(acceptDownloads: Downloads.accept),
    );
  });

  tearDownAll(() async {
    await browser.close();
    await playwright.stop();
  });

  group('Download API', () {
    test('should trigger download and expose artifact', () async {
      final page = await context.newPage();

      final downloadFuture = page.onDownload.first;

      // Navigate to a page that triggers a download
      await page.setContent('''
        <a id="download-link" href="data:text/plain;charset=utf-8,hello" download="hello.txt">Download</a>
      ''');

      await page.locator('#download-link').click();

      final download = await downloadFuture;

      // Wait for it to finish and get path
      final path = await download.path();
      expect(path, isNotNull);

      // Save it locally to a temp path
      final tempFile = File(
        '${Directory.systemTemp.path}/test_download_${DateTime.now().millisecondsSinceEpoch}.txt',
      );
      await download.saveAs(tempFile.path);

      final error = await download.failure();
      expect(error, isEmpty);

      // Clean up both the browser artifact and the saved copy
      await download.delete();
      if (await tempFile.exists()) await tempFile.delete();
      await page.close();
    });
  });
}
