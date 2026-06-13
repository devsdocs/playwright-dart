import 'package:playwright_dart/playwright_dart.dart';

void main() async {
  final playwright = await PlaywrightDart.create();
  final browser = await playwright.chromium.launch();
  final page = await browser.newPage();

  // Route to intercept all requests
  await page.route('**/*', (route) async {
    final request = route.request;
    final resourceType = request.resourceType;
    if (resourceType == 'image' || resourceType == 'media') {
      print('Blocking image/media request: ${request.url}');
      await route.abort();
    } else {
      await route.continueRoute();
    }
  });

  print('Navigating to Wikipedia (images will be blocked)...');
  await page.goto('https://en.wikipedia.org/wiki/Main_Page');
  
  print('Page loaded successfully without images!');

  await browser.close();
}
