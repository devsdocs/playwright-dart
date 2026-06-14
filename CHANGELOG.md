## 3.2.2

- **Documentation**: Fix README

## 3.2.1

- **Fix**: Updated protocol generator to automatically and recursively inject `connection` bindings into nested object `.fromJson()` factories. This resolves initialization crashes caused by nested objects failing to obtain a valid channel connection.
- **Fix**: Corrected import paths in generated output so that `channel_owner.dart` correctly targets the `infrastructure` directory.
- **Fix**: Handled edge cases in header parsing for network Responses.
- **Test**: Considerably expanded API test coverage across `JSHandle`, `ElementHandle`, and `Response` interfaces. Test suite is now 160+ strong.

## 3.2.0

- **Feature**: Added a native `Logger` and a `debug` flag to `PlaywrightDart.create(debug: true)`. When enabled, it natively intercepts and logs all raw protocol JSON messages sent to and received from the Playwright driver directly to the terminal stdout.
- **Feature**: Introduced `Logger.info()` to clearly print CLI operations like background driver extraction without relying on unstructured `print` calls.
- **Refactor**: Completely reorganized the internal repository architecture. Flattened the massive `lib/src/` directory into cleanly isolated logic domains (`core/`, `network/`, `interaction/`, `infrastructure/`, `utils/`, `platform/`, `debugging/`). 
- **Refactor**: Updated all internal tools and scripts inside `tool/` to target the newly mapped architecture while achieving zero static analysis warnings and a perfectly green test suite.

## 3.1.0

- **Feature**: Completed full isolation of internal implementation classes (e.g. `ElementHandleImpl`, `PageImpl`), exclusively exposing pure interface types across the entire public API boundary. This vastly improves the developer experience by preventing unintentional access to underlying channel mechanisms.
- **Feature**: Added advanced `Locator` query combinators including `.and()`, `.or()`, and `.filter()`, empowering complex semantic queries.
- **Feature**: Enhanced `Locator` with utility selection methods `.first()`, `.last()`, and `.nth()`.
- **Feature**: Exposed complete `timing` properties (e.g., `startTime`, `responseEnd`) and `failure` message text mapping on intercepted network `Request` objects, exactly matching the Playwright spec.
- **Bug Fix**: Fixed unclosed `Connection` leaks in skipped WebSocket and CDP connection environments which previously orphaned Node.js background driver processes.
- **Bug Fix**: Addressed null timing object assignments in advanced network events during `fetch` and isolated `BrowserContext` dispatches.

## 3.0.0

- **Breaking**: Fully migrated the entire public API to use strongly-typed data structures and Enums for method parameters rather than untyped `Map<String, dynamic>` and `String` inputs. This enforces 100% compile-time parameter parity with the underlying Playwright channel protocol and unlocks full IDE type-checking for users.
  - E.g., `page.setViewportSize({'width': 800, 'height': 600})` is now strictly `page.setViewportSize(PageSetViewportSizeViewportSize(width: 800, height: 600))`.
  - All pointer event parameters like `click`, `hover`, and `dblclick` now require their specific enum types (e.g., `FrameClickModifiersEnum` instead of raw strings).
- **Tooling**: Extended `tool/cross_check_types.dart` to strictly validate strongly-typed inputs, guaranteeing that there are 0 parameter type mismatches between the generated protocol schemas and our public Dart wrappers.

## 2.3.1

- **Fix**: Generated structs (`BrowserNewContextStorageState`, `BrowserNewContextProxy`, etc.) now recursively serialize deep object properties and arrays when `toJson()` is called. This fixes the runtime `type 'X' is not a subtype of type 'Map<String, dynamic>'` errors encountered when using `page.setViewportSize` or `context.setStorageState` with nested definitions.
- **Fix**: Corrected argument mapping in wrapper classes (`BrowserContext`, `Page`, `ElementHandle`, `Frame`) to strictly parse standard `Map<String, dynamic>` maps to their corresponding generated structs automatically.

## 2.3.0

- **Feature**: Achieved 100% parameter parity with Playwright Node.js `v1.60.0`. Added over 200 missing parameters across core classes (`Page`, `Frame`, `ElementHandle`, `BrowserContext`, `APIRequestContext`, `Electron`, `Worker`, `DebugController`, `Tracing`, and `AndroidDevice`) to fully align with the underlying protocol.
- **Tooling**: Added `tool/cross_check_types.dart` to automatically verify API parameter and method parity between Dart wrapper classes and generated protocol channels.
- **Bug Fix**: Addressed various missing enum mappings and type mappings in method signatures.

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
