## 2.2.0

- **Feature**: Implemented missing page events: `onConsole`, `onRequest`, `onResponse`, `onRequestFinished`, `onRequestFailed`, `onFileChooser`, `onWebSocket`, `onCrash`, `onClose`, `onPageError`, and `onPopup`.
- **Feature**: Implemented asynchronous wait methods on `Page` and `Frame`: `waitForRequest`, `waitForResponse`, `waitForLoadState`, `waitForURL`, and `waitForNavigation`.
- **Feature**: Added new wrapper classes for advanced interactions: `ConsoleMessage`, `FileChooser`, and `Video`.
- **Bug Fix**: Fixed protocol event routing issues where network and console events were missing because they are dispatched to the `BrowserContext` channel instead of the `Page` channel.

## 2.1.0

- **Feature**: Officially exposed `onWorker` and `onDownload` events on the `Page` API, giving access to `Worker` and `Artifact` components.
- **Bug Fix**: Fixed a critical crash in `APIRequestContext.fetch()` and `Playwright.newRequest()` preventing raw HTTP requests from working.
- **Documentation**: Emphasized that Node.js is automatically bundled by the driver downloader, requiring zero manual installation by users for a seamless out-of-the-box experience.

## 2.0.0
- **Feature (Breaking)**: Introduced `autoClose` behavior to emulate Node.js driver lifecycle patterns. Playwright Dart now automatically closes the driver process when the last browser is closed. Set `autoClose: false` in `PlaywrightDart.create()` to disable this behavior and manage the lifecycle manually.
- **Feature**: Added WebSocket CDP connection support (`connectOverCDP`) for integrating with remote providers like Browserless.
- **Documentation**: Substantial inline API documentation added across all core modules to improve auto-completion and Developer Experience.

## 1.0.1

Update supported platform

## 1.0.0

First stable major release.

- Promoted package version to `1.0.0`.
- Includes all features and fixes delivered in the `0.1.x` line.

## 0.1.2

Update pubspec information

## 0.1.1

Dependencies bump

## 0.1.0

Initial release — complete Dart SDK for Playwright with full API parity to Node.js `v1.60.0`.

### Features

- **Browser Automation**: Launch and control Chromium, Firefox, and WebKit browsers
- **Page Interactions**: Navigate, evaluate JavaScript, take screenshots, generate PDFs
- **Locator API**: 30+ interaction methods with 7 sub-locator strategies (`getByRole`, `getByText`, `getByLabel`, `getByPlaceholder`, `getByAltText`, `getByTitle`, `getByTestId`)
- **Network Interception**: Intercept, mock, and modify network requests with `route.abort()`, `route.fulfill()`, `route.continue_()`
- **Input Simulation**: Full keyboard and mouse input support (`keyboard.type()`, `mouse.click()`, etc.)
- **Tracing**: Record and export traces for debugging with the Playwright Trace Viewer
- **CDP Session**: Direct Chrome DevTools Protocol access for advanced manipulation

- **35 wrapper classes** covering 100% of the Playwright protocol (308 channel methods)
- **Auto-download**: Automatic Playwright driver and browser binary management

### Platform Support

- Windows, macOS, Linux
- Dart SDK `^3.12.0`
