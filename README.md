# Playwright Dart

A Dart port of the official [Playwright](https://playwright.dev) library, bringing fast, reliable, and capable browser automation to the Dart and Flutter ecosystem.

This library achieves **100% API Parity** with the NodeJS Playwright `v1.60.0` protocol, including all network interception, tracing, CDPSession, and advanced locator features.

## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  playwright_dart:
    path: /path/to/playwright-dart
```

## Basic Usage

```dart
import 'package:playwright_dart/playwright_dart.dart';

void main() async {
  // Start the Playwright driver and connect
  final playwright = await Playwright.create();

  // Launch a browser (Chromium)
  final browser = await playwright.chromium.launch(headless: false);
  
  // Create a new browser context and page
  final context = await browser.newContext();
  final page = await context.newPage();

  // Navigate and interact
  await page.goto('https://playwright.dev');
  
  // Use locators for robust UI interaction
  await page.getByRole('link', name: 'Get started').click();

  // Take a screenshot
  await page.screenshot(path: 'screenshot.png');

  // Close the browser when done
  await browser.close();
}
```

## Advanced Features

### Locators
Playwright's `Locator` API is fully supported for strict and reliable interactions.

```dart
final locator = page.locator('.my-class');
await locator.click();

// Chaining and text matching
await page.locator('nav').getByText('Docs').click();
```

### Network Interception
Intercept, mock, or modify network traffic seamlessly.

```dart
await page.route('**/*.jpg', (route, request) async {
  // Abort all image requests
  await route.abort();
});

await page.route('**/api/data', (route, request) async {
  // Fulfill the request with custom mocked data
  await route.fulfill(
    status: 200,
    contentType: 'application/json',
    body: '{"message": "mocked response"}',
  );
});
```

### Tracing
Record traces to debug tests locally using the Playwright Trace Viewer.

```dart
await browser.startTracing(page: page, screenshots: true);

await page.goto('https://example.com');

final trace = await browser.stopTracing();
// Save `trace` (List<int>) to a `.zip` file and view in Playwright Trace Viewer.
```

### CDPSession (Chrome DevTools Protocol)
Connect directly to the Chrome DevTools Protocol to do advanced manipulation.

```dart
final session = await context.newCDPSession(page);
await session.send('Network.enable');
```

## API Parity Checklist

* `Page`, `Browser`, `BrowserContext`, `Frame`, `Locator` (Fully Implemented)
* `JSHandle`, `ElementHandle` (Fully Implemented)
* `Request`, `Response`, `Route`, `APIRequestContext` (Fully Implemented)
* `Tracing`, `Artifact`, `Dialog`, `Worker` (Fully Implemented)
* `WebSocket`, `PlaywrightStream`, `WritableStream` (Fully Implemented)
* `Debugger`, `DebugController`, `CDPSession` (Fully Implemented)

## Contributing

To regenerate protocol files:
```bash
dart tool/generate_protocol.dart
dart tool/find_missing.dart
```
