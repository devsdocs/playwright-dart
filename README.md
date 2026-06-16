# Playwright Dart

[![pub package](https://img.shields.io/pub/v/playwright_dart.svg)](https://pub.dev/packages/playwright_dart)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![Test Coverage](https://img.shields.io/badge/Coverage-35.7%25-yellow.svg)](https://github.com/devsdocs/playwright-dart)
[![AI Assisted](https://img.shields.io/badge/AI-Assisted-purple.svg)](https://github.com/devsdocs/playwright-dart)

A complete Dart port of [Playwright](https://playwright.dev) — fast, reliable browser automation for Chromium, Firefox, and WebKit.

**Compatible API** with Node.js Playwright, including network interception, tracing, CDP sessions, and the full Locator API.

## Features

- 🚀 **Launch & control** Chromium, Firefox, and WebKit
- 🎯 **Locator API** with `getByRole`, `getByText`, `getByLabel`, and more
- 🌐 **Network interception** — abort, mock, and modify requests
- 📸 **Screenshots & PDFs** — capture pages in any format
- 🔍 **Tracing** — record and view traces in the Playwright Trace Viewer
- ⚡ **Auto-downloads** Playwright driver and browser binaries
- 📦 **No Node.js Required** — Node is bundled automatically!

## 📦 Seamless Experience (No Node.js Required!)

You **do not** need to install Node.js to use this package!

To guarantee compatibility across operating systems without forcing users to manage Node versions, `playwright_dart` automatically downloads a pre-compiled Playwright Driver directly from Microsoft's CDN. This driver **bundles its own isolated, perfectly compatible version of Node.js** (`node.exe` / `node`).

This means your users and CI pipelines can run browser automation seamlessly out-of-the-box using only Dart. No `npm install`, no global node requirements!

## Installation

```yaml
dependencies:
  playwright_dart: ^3.3.0
```

## Quick Start

```dart
import 'package:playwright_dart/playwright_dart.dart';

void main() async {
  final playwright = await PlaywrightDart.create();
  final browser = await playwright.chromium.launch();
  final page = await browser.newPage();

  await page.goto('https://playwright.dev');
  await page.getByRole('link', name: 'Get started').click();
  await page.screenshot(path: 'screenshot.png');

  await browser.close();
}
```

## Remote Browser Connection (Skip Browser Download)

For Playwright WebSocket endpoints, use `PlaywrightDart.connect()` to connect
directly without local setup or browser installation:

```dart
import 'package:playwright_dart/playwright_dart.dart';

void main() async {
  final browser = await PlaywrightDart.connect('ws://127.0.0.1:3000/ws');
  final context = await browser.newContext();
  final page = await context.newPage();
  print(await page.title());
  await browser.close();
}
```

For CDP endpoints, use Chromium `connectOverCDP`:

```dart
import 'package:playwright_dart/playwright_dart.dart';

void main() async {
  final playwright = await PlaywrightDart.create();
  final browser = await playwright.chromium.connectOverCDP(
    endpointURL: 'http://127.0.0.1:9222',
  );

  final context = browser.contexts.first;
  final page = context.pages.first;
  print(await page.title());

  await browser.close();
}
```

## Locators

Playwright's robust [Locator API](https://playwright.dev/docs/locators) is fully supported:

```dart
// By role
await page.getByRole('button', name: 'Submit').click();

// By text
await page.getByText('Welcome').isVisible();

// By label
await page.getByLabel('Email').fill('user@example.com');

// By test ID
await page.getByTestId('nav-menu').click();

// Chaining
await page.locator('nav').getByText('Docs').click();

// State assertions
final isVisible = await page.locator('.modal').isVisible();
final text = await page.locator('h1').textContent();
```

## Network Interception

Intercept, mock, or abort network requests:

```dart
// Block all images
await page.route('**/*.{png,jpg,jpeg}', (route) async {
  await route.abort();
});

// Mock an API response
await page.route('**/api/users', (route) async {
  await route.fulfill(
    status: 200,
    headers: {'content-type': 'application/json'},
    body: '{"users": [{"name": "Alice"}]}',
  );
});
```

## Tracing

Record traces for debugging with the [Playwright Trace Viewer](https://playwright.dev/docs/trace-viewer):

```dart
await browser.startTracing(page: page, screenshots: true);
await page.goto('https://example.com');
final trace = await browser.stopTracing();
// Save trace bytes to a .zip file and open with: npx playwright show-trace trace.zip
```

## CDP Session

Access the Chrome DevTools Protocol directly:

```dart
final session = await context.newCDPSession(page);
await session.send('Network.enable');
await session.send('Performance.enable');
```

## API Coverage

| Category | Classes |
|----------|---------|
| **Core** | `Playwright`, `Browser`, `BrowserType`, `BrowserContext`, `Page`, `Frame` |
| **Interaction** | `Locator`, `ElementHandle`, `JSHandle`, `Keyboard`, `Mouse` |
| **Network** | `Request`, `Response`, `Route`, `APIRequestContext`, `WebSocket`, `WebSocketRoute` |
| **Utilities** | `Tracing`, `CDPSession`, `Dialog`, `Worker`, `Artifact`, `Waiter` |
| **Errors** | `PlaywrightError`, `TimeoutError`, `TargetClosedError` |
| **Debugging** | `Debugger`, `DebugController`, `BindingCall`, `EventTarget` |
| **Platform** | `Android`, `AndroidDevice`, `Electron`, `ElectronApplication` |

**35 wrapper classes** • **308 channel methods**

## Contributing

```bash
# Regenerate protocol bindings from Playwright source
dart tool/generate_protocol.dart

# Verify API
dart tool/find_missing.dart

# Run tests
dart test --concurrency=1

# Static analysis
dart analyze
```

## License

MIT — see [LICENSE](LICENSE) for details.

---

> 🤖 **AI-Assisted Development**
>
> This repository was built and maintained with the assistance of an advanced AI agent. The AI helped port the entire Playwright Node.js API to Dart, generated the protocol bindings, and test coverage for the protocol structures!
