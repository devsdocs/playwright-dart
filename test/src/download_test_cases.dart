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
      options: ContextOptions(
        acceptDownloads: ContextOptionsAcceptDownloadsEnum.accept,
      ),
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

      final artifact = await downloadFuture;

      // Wait for it to finish and get path
      final path = await artifact.pathAfterFinished();
      expect(path, isNotNull);

      // Save it locally
      final tempFile = 'test_download.txt';
      await artifact.saveAs(tempFile);

      final error = await artifact.failureError();
      expect(error, isEmpty);

      await artifact.delete();
      await page.close();
    });
  });
}
