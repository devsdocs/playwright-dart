import 'package:playwright_dart/playwright_dart.dart';
import 'package:test/test.dart';

void main() {
  late Playwright playwright;
  late Browser browser;
  late BrowserContext context;

  setUpAll(() async {
    playwright = await PlaywrightDart.create();
    browser = await playwright.chromium.launch();
    context = await browser.newContext();
  });

  tearDownAll(() async {
    await browser.close();
    await playwright.stop();
  });

  group('Worker API', () {
    test('should capture worker and evaluate', () async {
      final page = await context.newPage();

      final workerFuture = page.onWorker.first;

      await page.goto(
        'data:text/html,<script>window.worker = new Worker(URL.createObjectURL(new Blob(["console.log(\\"worker created\\");"], {type: "application/javascript"})));</script>',
      );

      final worker = await workerFuture;

      final result = await worker.evaluate('1 + 1');
      expect(result, equals(2));

      await page.close();
    });
  });
}
