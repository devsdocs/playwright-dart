# Playwright Dart

[![pub package](https://img.shields.io/pub/v/playwright_dart.svg)](https://pub.dev/packages/playwright_dart)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![Test Coverage](https://img.shields.io/badge/Coverage-44.1%25-yellow.svg)](https://github.com/devsdocs/playwright-dart)
[![AI Assisted](https://img.shields.io/badge/AI-Assisted-purple.svg)](https://github.com/devsdocs/playwright-dart)

A Dart port of [Playwright](https://playwright.dev) — browser automation for Chromium, Firefox, and WebKit.

This is an actively developed port that covers the core Playwright surface area used in most real-world automation and testing workflows. It targets Playwright protocol v1.61.0 and keeps up with the upstream API as development continues.

## Features

- 🚀 **Launch & control** Chromium, Firefox, and WebKit
- 🎯 **Locator API** with `getByRole`, `getByText`, `getByLabel`, and more — accepting both strings and `RegExp`
- ✅ **Locator assertions** — 15+ assertions including `toBeVisible`, `toHaveText`, `toBeEditable`, `toHaveCSS`, and more
- 🌐 **Network interception** — abort, mock, and modify requests
- 🔐 **WebAuthn support** — virtual authenticators and credential management
- 📸 **Screenshots & PDFs** — capture pages in any format
- 🔍 **Tracing** — record and view traces in the Playwright Trace Viewer
- 📊 **HTML Reporter** — comprehensive test reporting with asset copying support
- ⚙️ **Configuration** — YAML and JSON configuration file support
- ⚡ **Auto-downloads** Playwright driver and browser binaries
- 📦 **No Node.js required** — Node is bundled automatically!
- 🐧 **Linux-ready** — Automatically handles OS-level browser dependencies during setup

## 📦 Seamless Experience (No Node.js Required!)

You **do not** need to install Node.js to use this package!

To guarantee compatibility across operating systems without forcing users to manage Node versions, `playwright_dart` automatically downloads a pre-compiled Playwright Driver directly from Microsoft's CDN. This driver **bundles its own isolated, perfectly compatible version of Node.js** (`node.exe` / `node`).

This means your users and CI pipelines can run browser automation seamlessly out-of-the-box using only Dart. No `npm install`, no global node requirements!

### 🐧 Linux System Dependencies

While Node.js is not required, Playwright still requires certain system-level dependencies to run browsers on Linux. If these dependencies are missing, you may encounter an error similar to this:

```text
╔══════════════════════════════════════════════════════╗
║ Host system is missing dependencies to run browsers. ║
║ Please install them with the following command:      ║
║                                                      ║
║     sudo npx playwright install-deps                 ║
║                                                      ║
║ Alternatively, use apt:                              ║
║     sudo apt-get install libatk1.0-0t64\             ║
║         libxcomposite1\                              ║
║         libxdamage1\                                 ║
║         libxfixes3\                                  ║
║         libxrandr2\                                  ║
║         libgbm1\                                     ║
║         libasound2t64\                               ║
║         libatspi2.0-0t64                             ║
║                                                      ║
║ <3 Playwright Team                                   ║
╚══════════════════════════════════════════════════════╝
```

To resolve this, you can install the required dependencies using the suggested command:
```bash
sudo npx playwright install-deps
```
Or by manually installing the packages via `apt-get` as indicated in the error message.

## Installation

```yaml
dependencies:
  playwright_dart: ^3.8.0
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

For Playwright servers launched with `launchServer()`, use `BrowserType.connect()` to connect
directly without local setup or browser installation:

```dart
import 'package:playwright_dart/playwright_dart.dart';

void main() async {
  final playwright = await PlaywrightDart.create();
  final browser = await playwright.chromium.connect(
    'ws://127.0.0.1:3000/ws',
  );
  final context = await browser.newContext();
  final page = await context.newPage();
  print(await page.title());
  await browser.close();
}
```

For remote browser connections via WebSocket (cloud-hosted browsers), use `connectOverCDP()`:

```dart
import 'package:playwright_dart/playwright_dart.dart';

void main() async {
  final playwright = await PlaywrightDart.create();
  final browser = await playwright.chromium.connectOverCDP(
    endpointURL: 'ws://your.remote-browser.com:9222',
  );

  final context = browser.contexts.first;
  final page = context.pages.first;
  print(await page.title());

  await browser.close();
}
```

## Locators

Playwright's [Locator API](https://playwright.dev/docs/locators) is well supported, including string and `RegExp` matching:

```dart
// By role
await page.getByRole('button', name: 'Submit').click();

// By text (string or RegExp)
await page.getByText('Welcome').isVisible();
await page.getByText(RegExp(r'welcom', caseSensitive: false)).isVisible();

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

## HTML Reporter

Generate comprehensive HTML test reports with asset copying support:

```dart
import 'package:playwright_dart/playwright_dart.dart';

void main() async {
  final reporter = HtmlReporter(
    outputDir: 'test-results/html-report',
    metadata: ReportMetadata(
      title: 'My Test Suite',
      projectName: 'My Project',
      startTime: DateTime.now(),
    ),
  );

  reporter.addTestResult(TestResult(
    name: 'User can login',
    file: 'test/auth_test.dart',
    status: TestStatus.passed,
    duration: 2340,
    steps: [
      TestStep(title: 'Navigate to login', duration: 450, status: 'passed'),
      TestStep(title: 'Enter credentials', duration: 890, status: 'passed'),
    ],
    screenshotPath: 'test-results/screenshots/login.png',
  ));

  await reporter.generate();
  // Opens test-results/html-report/index.html
}
```

## Configuration

Configure Playwright using YAML or JSON files:

**playwright.config.yaml**
```yaml
launchOptions:
  headless: true
  channel: chrome
contextOptions:
  viewport:
    width: 1280
    height: 720
test:
  testDir: "test"
timeout:
  defaultTimeout: 30000
outputDir: "test-results"
workers: 4
```

```dart
import 'package:playwright_dart/playwright_dart.dart';

void main() async {
  // Load from file
  final config = await PlaywrightConfig.load();
  
  // Or parse directly
  final config = PlaywrightConfig.fromYaml(yamlString);
  final config = PlaywrightConfig.fromJson(jsonString);
}
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

**35 wrapper classes** • **317 channel methods**

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
