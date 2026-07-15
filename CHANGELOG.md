## 3.11.1

- **Feature**: `RouteMatcher.function<T>()` now supports a generic type parameter (like `<Request>`). This enforces type-safety on the predicate and automatically filters out incompatible network events under the hood without throwing errors.

## 3.11.0

- **Feature**: Introduced type-safe JavaScript evaluation! Methods like `page.evaluate<T>()`, `locator.evaluate<T>()`, and `elementHandle.evaluate<T>()` now accept a generic type parameter `T`. 
- **Feature**: Added smart numeric casting for `evaluate<T>()`. JavaScript numbers are floating-point (`double`), but Playwright Dart will now automatically cast them to Dart `int` when you specify `evaluate<int>()` and the value is a whole number.
- **Feature**: Added type-safe `Response.json<T>()` allowing seamless parsing of network response bodies directly into typed Dart objects (like `Map<String, dynamic>` or `List`).
- **Feature**: `APIRequestContext` request methods (`post`, `put`, `patch`, `delete`, `fetch`) now support an auto-serializing `data` parameter. Supplying a `Map` or `List` to `data` automatically serializes it to a JSON string, matching the convenience of the Node.js API.

## 3.10.1

- **Fix**: Corrected a bug in `page.querySelectorAll()` where mapping locators directly to an array caused interactions on those locators to re-evaluate and execute against the first matching element on the page. The method now correctly appends `nth(i)` to each returned locator.
- **Fix**: Improved strict type validation in `PlaywrightConfig`. Supplying an array instead of a JSON object for nested structures like `launchOptions` now gracefully throws a `FormatException` instead of crashing with a Dart `TypeError`.

## 3.10.0

- **Test Coverage**: Increased core DOM interaction API test coverage from 13.7% to 49.1%. Added comprehensive tests for `ElementHandle`, `Frame`, `FrameLocator`, `Mouse`, and `Keyboard` APIs.
- **Stability**: Fixed `TargetClosedError` and `SocketException` during test tear-downs by correctly managing reference counting in the Browser lifecycle.
- **Fix**: Adjusted `selectOption` arguments in `Frame` to match positional semantics and resolved test flakiness related to `dispatchEvent` and keyboard modifiers.

## 3.9.0
- **Architecture**: Stripped the `channel_` prefix from generated internal protocol methods (e.g. `channel_saveAs` is now just `saveAs` in the internal API).
- **Architecture**: Refactored the core protocol classes to use composition instead of inheritance for channel methods. All generated methods are now strictly isolated inside a strongly-typed `channel` property (e.g. `await channel.saveAs(...)`) rather than being inherited into the public wrappers. This prevents naming collisions and strictly hides the generated API from external consumers.
- **Tooling**: Updated `find_missing.dart` and `cross_check_types.dart` to fully support the new `channel.` composition pattern.

## 3.8.0

- **Breaking**: Refactored various string-based parameters in the public API into strongly-typed enums. 
  - `BrowserContext.grantPermissions` now accepts `List<BrowserPermission>` instead of `List<String>`.
  - `Route.abort` now accepts `RouteErrorCode?` instead of `String?`.
  - `Page.pdf` now accepts `PdfFormat?` instead of `String?` for the `format` configuration.
  - Dimension configurations (`width`, `height`, `margin`) for PDFs are now strongly typed with `PdfDimension` and `PdfUnit` instead of raw strings.
- **Refactor**: Replaced generic `dynamic` arguments with `RouteMatcher` in API methods like `waitForRequest`, `waitForResponse`, and `waitForNavigation`.

## 3.7.4

- **Feature**: Re-wrote driver downloader to natively fetch `playwright-core` from npmjs and Node.js directly from nodejs.org, completely removing the dependency on `npm install` and system `node`.
- **Feature**: Added dynamic Node.js version resolution using upstream GitHub metadata, ensuring perfect compatibility with the bundled Playwright protocol version.

## 3.7.3
- **Documentation**: Overhauled the API documentation injection script to automatically detect and translate NodeJS-specific syntax patterns into native Dart equivalents.
- **Documentation**: Translated JS `Promise` references to `Future`, `Buffer` types to `List<int>`, and `===` to `==`.
- **Documentation**: Seamlessly converted JS arrow functions (e.g. `async route => { ... }`) to native Dart lambda syntax (e.g. `(route) async { ... }`).
- **Documentation**: Mapped Playwright JS event handlers like `page.on('requestfailed', ...)` to native Dart streams `page.onRequestFailed.listen(...)`, and `page.waitForEvent('popup')` to `page.onPopup.first`.
- **Documentation**: Correctly formatted Dart property getters in usage examples by stripping method call parentheses.
- **Documentation**: Filtered out dead MDN/NodeJS documentation reference links, and corrected angle brackets formatting preventing `unintended_html_in_doc_comment` warnings.

## 3.7.2

- **Fix**: Automatically install Linux OS-level browser dependencies (`install-deps`) during the initial browser download step in `driver_downloader.dart`. This removes the need to manually run `install-deps` on Linux machines.

## 3.7.1

- **Fix**: Replaced platform-specific shell extraction commands (`powershell Expand-Archive` on Windows, `unzip` on Linux/macOS) with the cross-platform `extractFileToDisk` API from the `archive` package in `driver_downloader.dart`. This removes external process dependencies and makes driver extraction more reliable and portable.

## 3.7.0

- **Feature**: Added comprehensive HTML test reporter with asset copying support. Generates interactive HTML reports with embedded CSS/JavaScript and dynamic data loading.
- **Feature**: Added PlaywrightConfig with YAML and JSON configuration file support. Supports loading config from `playwright.config.yaml` and `playwright.config.json` files.
- **Feature**: Added PlaywrightConfig using pre-existing `LaunchOptions` and `ContextOptions` classes from the protocol.
- **Feature**: Added HTML reporter asset copying for screenshots, videos, traces, and attachments to organized subdirectories.
- **Refactor**: Simplified PlaywrightConfig to use YAML and JSON parsing instead of complex Dart file parsing.
- **Test**: Added comprehensive test suite for PlaywrightConfig with YAML and JSON file loading.
- **Test**: Added comprehensive test suite for HTML reporter with meaningful test results.

## 3.6.0

- **Feature**: Added typesafe function parameters and shorthand command in `Keyboard` and `Mouse` functionalities.
- **Documentation**: Added comprehensive analysis of official Playwright v1.62.0-next protocol changes in `comprehensive_gaps_analysis.md`.
- **Documentation**: Identified new protocol features available in v1.62.0-next: AbortSignal support for wait operations and removeAllListeners behavior option.
- **Documentation**: Updated protocol version references to reflect official Playwright repo status (v1.61.0 with official at v1.62.0-next).
- **Documentation**: Added implementation guidance for new v1.62.0 features including file locations and code examples.

## 3.5.0

- **Feature**: Added `page.routeWebSocket()` method for WebSocket connection interception and routing. Supports both glob patterns and RegExp for URL matching.
- **Documentation**: Updated `connect()` method documentation to clarify it's for Playwright servers launched with `launchServer()`, while `connectOverCDP()` should be used for remote browser connections via WebSocket (cloud-hosted browsers).
- **Documentation**: Updated README with clearer guidance on when to use `connect()` vs `connectOverCDP()` for different connection scenarios.
- **Documentation**: Verified and documented that all API-level gaps have been addressed in `comprehensive_gaps_analysis.md`. All Priority 1, 2, and 3 tasks are now implemented.
- **Documentation**: Updated `comprehensive_gaps_analysis.md` to reflect completion status of all API-level gaps.

## 3.4.0

- **Feature**: Added RegExp serialization/deserialization support in `serialization.dart`, enabling `Pattern` types to be properly converted to/from strings when communicating with the Playwright server.
- **Feature**: Enhanced `Locator` with new utility methods: `count()`, `all()`, `allInnerTexts()`, `allTextContents()`, `elementHandle()`, `elementHandles()`, `boundingBox()`, `scrollIntoViewIfNeeded()`, `selectText()`, and `screenshot()`.
- **Feature**: Added `fallback()` method to `Route` for continuing route requests to the next handler in the chain.
- **Feature**: Added web storage methods to `Page`: `webStorageGetItem()`, `webStorageSetItem()`, `webStorageRemoveItem()`, `webStorageClear()`, and `webStorageItems()`.
- **Feature**: Added virtual credential methods to `BrowserContext`: `credentialsCreate()`, `credentialsDelete()`, `credentialsGet()`, and `credentialsInstall()` for WebAuthn testing support.
- **Feature**: Enhanced `LocatorAssertions` with 2 new assertion methods: `toBeChecked()` and `toHaveCount()`.
- **Feature**: Added `Clock` property to `BrowserContext` interface.
- **Feature**: Added `RouteHandler` for improved network route management in `BrowserContext`.
- **Refactor**: Improved `ChannelOwner` with enhanced EventEmitter integration and comprehensive documentation.
- **Refactor**: Added `timeout`, `strict`, and other optional parameters to many `Frame` and `Locator` methods for better control over element interactions.
- **Refactor**: Enhanced `RouteFromHAR` with improved logging and error handling for HAR file routing.
- **Refactor**: Improved network routing in `BrowserContext` with `RouteHandler` for better pattern matching and handler management.
- **Fix**: Fixed network test cases to use proper CORS headers and navigate to real pages before making fetch requests.

## 3.3.0

- **Feature**: Introduced `EventEmitter` into `ChannelOwner` for named event management. Added methods for event registration, deregistration, and emitting, with lifecycle cleanup in `dispose`.
- **Feature**: Added a Playwright error hierarchy — `PlaywrightError`, `TimeoutError`, and `TargetClosedError` — with an error parsing utility for server-side error messages.
- **Feature**: Implemented `Waiter` utility class for managing event waiting with configurable timeouts and rejection conditions.
- **Feature**: Added locator utilities for test ID attribute handling, including encoding and escaping helpers used by `getByTestId`.
- **Refactor**: Improved error handling in `Connection` to use typed `PlaywrightError` subclasses; connection closure now throws `TargetClosedError`.
- **Refactor**: Enhanced `ElementHandle` and `JSHandle` interfaces with generic type parameters for improved type safety in `evaluateHandle` and related methods.
- **Refactor**: Updated download test cases to use temporary file paths with automatic artifact cleanup.
- **Chore**: Added `html` package dependency for DOM manipulation support.

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
- **Feature**: Exposed `timing` properties (e.g., `startTime`, `responseEnd`) and `failure` message text mapping on intercepted network `Request` objects, aligning with the Playwright protocol spec.
- **Bug Fix**: Fixed unclosed `Connection` leaks in skipped WebSocket and CDP connection environments which previously orphaned Node.js background driver processes.
- **Bug Fix**: Addressed null timing object assignments in advanced network events during `fetch` and isolated `BrowserContext` dispatches.

## 3.0.0

- **Breaking**: Migrated the public API to use strongly-typed data structures and enums for method parameters rather than untyped `Map<String, dynamic>` and `String` inputs. This aligns parameter types with the underlying Playwright channel protocol and enables IDE type-checking for users.
  - E.g., `page.setViewportSize({'width': 800, 'height': 600})` is now strictly `page.setViewportSize(PageSetViewportSizeViewportSize(width: 800, height: 600))`.
  - All pointer event parameters like `click`, `hover`, and `dblclick` now require their specific enum types (e.g., `FrameClickModifiersEnum` instead of raw strings).
- **Tooling**: Extended `tool/cross_check_types.dart` to validate strongly-typed inputs against generated protocol schemas, reducing the risk of parameter type mismatches.

## 2.3.1

- **Fix**: Generated structs (`BrowserNewContextStorageState`, `BrowserNewContextProxy`, etc.) now recursively serialize deep object properties and arrays when `toJson()` is called. This fixes the runtime `type 'X' is not a subtype of type 'Map<String, dynamic>'` errors encountered when using `page.setViewportSize` or `context.setStorageState` with nested definitions.
- **Fix**: Corrected argument mapping in wrapper classes (`BrowserContext`, `Page`, `ElementHandle`, `Frame`) to strictly parse standard `Map<String, dynamic>` maps to their corresponding generated structs automatically.

## 2.3.0

- **Feature**: Expanded parameter coverage for Playwright Node.js `v1.60.0`. Added over 200 missing parameters across core classes (`Page`, `Frame`, `ElementHandle`, `BrowserContext`, `APIRequestContext`, `Electron`, `Worker`, `DebugController`, `Tracing`, and `AndroidDevice`) to better align with the underlying protocol.
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

Initial release — a Dart port of Playwright targeting Node.js `v1.60.0`.

### Features

- **Browser Automation**: Launch and control Chromium, Firefox, and WebKit browsers
- **Page Interactions**: Navigate, evaluate JavaScript, take screenshots, generate PDFs
- **Locator API**: 30+ interaction methods with 7 sub-locator strategies (`getByRole`, `getByText`, `getByLabel`, `getByPlaceholder`, `getByAltText`, `getByTitle`, `getByTestId`)
- **Network Interception**: Intercept, mock, and modify network requests with `route.abort()`, `route.fulfill()`, `route.continue_()`
- **Input Simulation**: Full keyboard and mouse input support (`keyboard.type()`, `mouse.click()`, etc.)
- **Tracing**: Record and export traces for debugging with the Playwright Trace Viewer
- **CDP Session**: Direct Chrome DevTools Protocol access for advanced manipulation

- **35 wrapper classes** covering a broad range of the Playwright protocol (308 channel methods)
- **Auto-download**: Automatic Playwright driver and browser binary management

### Platform Support

- Windows, macOS, Linux
- Dart SDK `^3.12.0`
