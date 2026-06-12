# playwright-dart

A native Dart port of [Playwright](https://playwright.dev/), providing fast and reliable end-to-end testing for modern web apps directly from Dart.

This library is a **fully automated protocol port**. It downloads the official Playwright specification, automatically generates all RPC interfaces, and seamlessly integrates with the standalone Playwright Driver binaries.

## Getting Started

### Installation

Add `playwright-dart` to your `pubspec.yaml` dependencies.

### Basic Usage

You can use the exact same Locators and Intro APIs you are used to from the official Node.js Playwright documentation!

```dart
import 'package:playwright_dart/playwright_dart.dart';

void main() async {
  // 1. Automatically downloads the driver and connects!
  print('Starting Playwright...');
  final playwright = await Playwright.create();
  final browser = await playwright.chromium.launch(headless: false);
  
  final page = await browser.newPage();

  // 2. Navigate
  await page.goto('https://playwright.dev/');
  
  // 3. Locate and Interact
  final getStarted = page.getByRole('link', name: 'Get started');
  await getStarted.click();

  // 4. Cleanup
  await browser.close();
}
```

## Architecture

This port is built to be robust and future-proof:

### 1. Dynamic Protocol Generation
`playwright-dart` relies on a fully automated code generator (`tool/generate_protocol.dart`). 
It pulls the absolute newest published version from the official `playwright-core` NPM registry, then fetches the raw protocol YAML specifications natively from the official Microsoft GitHub repository. It then generates strongly typed `*Base` abstract classes encapsulating all JSON-RPC logic.

### 2. Self-Contained Driver downloader
Instead of requiring a global NodeJS installation, this library automatically downloads the Playwright driver distribution from the Microsoft Azure CDN matching the generated protocol version.
It leverages the built-in standalone `node` binary to automatically install Chromium, Firefox, and WebKit locally in `~/.playwright-dart/driver/`.

### 3. Idiomatic Wrappers
While the underlying protocol is fully generated, manual wrappers (`Browser`, `Page`, `Frame`, `Locator`) are provided to expose the friendly, chaining API identical to `playwright.dev/docs/intro`.

- Supported Locators: `getByRole`, `getByText`, `getByLabel`, `getByPlaceholder`, `getByAltText`, `getByTitle`, `getByTestId`
- Interactions: `click`, `fill`, `check`, `hover`, `focus`, `blur`, `dblclick`, etc.
- Seamless Element interactions powered by the identical robust `internal:` locator engine used in NodeJS/Python/Java.

## Code Generation

If you want to manually trigger the generator to update to a newer version of the protocol:

```bash
dart run tool/generate_protocol.dart
```

This will output the new interfaces into `lib/src/generated/channels.dart`.
