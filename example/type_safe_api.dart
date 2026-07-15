import 'package:playwright_dart/playwright_dart.dart';

void main() async {
  final playwright = await PlaywrightDart.create();

  // Start Playwright and launch Chromium
  final browser = await playwright.chromium.launch();
  final context = await browser.newContext();
  final page = await context.newPage();

  print('Navigating to example page...');

  // Set up a type-safe route matcher for incoming network requests.
  // By using RouteMatcher.function<Request>, Dart enforces that the event
  // passed to the predicate is strictly a Request. Other network events
  // (like Response) are automatically filtered out safely at runtime.
  final requestFuture = page.waitForRequest(
    RouteMatcher.function<Request>(
      (req) => req.url.contains('example.com') && req.method == 'GET',
    ),
  );

  await page.goto('https://example.com');

  // Await the captured, strongly-typed Request object
  final request = await requestFuture;
  print('✅ Successfully intercepted Request: ${request.method} ${request.url}');

  // Demonstrate type-safe JavaScript evaluation with smart numeric casting
  print('\nRunning type-safe JavaScript evaluation...');

  // The returned value is securely cast as an `int`. JavaScript returns
  // numbers as floating-point doubles, but Playwright Dart intelligently
  // converts them to integers when `int` is explicitly requested.
  final pCount = await page.evaluate<int>(
    '() => document.querySelectorAll("p").length',
  );
  print('✅ Found $pCount <p> elements (strongly typed as int)');

  // Strongly-typed boolean evaluation
  final isReady = await page.evaluate<bool>(
    '() => document.readyState === "complete"',
  );
  print(
    '✅ Document ready state is complete: $isReady (strongly typed as bool)',
  );

  // Strongly-typed complex Map evaluation
  final pageInfo = await page.evaluate<Map<String, dynamic>>('''() => ({
      title: document.title,
      url: document.location.href,
      charset: document.characterSet
    })''');
  print('✅ Page Info: ${pageInfo['title']} (${pageInfo['charset']})');

  await browser.close();
  await playwright.stop();
}
