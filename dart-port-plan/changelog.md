<!-- markdownlint-disable MD024 -->
# Playwright Dart — Changelog

All notable changes to this project are documented in this file.

---

## Phase 1 — Transport & Connection

### Added

- `lib/src/driver.dart` — Spawns the Playwright Node.js driver process
- `lib/src/driver_downloader.dart` — Automatic binary download & management
- `lib/src/transport.dart` — Bidirectional stdio transport (`StdioTransport`)
- `lib/src/websocket_transport.dart` — WebSocket transport for remote connections
- `lib/src/connection.dart` — JSON-RPC message routing with `id`/`guid` tracking
- `lib/src/channel_owner.dart` — Base class for all protocol objects

---

## Phase 2 — Protocol Code Generation

### Added

- `tool/generate_protocol.dart` — Parses official Playwright `protocol.yml` and generates Dart channel classes
- `lib/src/generated/channels.dart` — 35 abstract `*Base` classes with all `channel_*` dispatch methods (~6,100 lines)
- All protocol enums, typed parameters, and mixins auto-generated

---

## Phase 3 — Object Lifecycle

### Added

- `ChannelOwner` base class with `guid`, parent/child tree, and `dispose()` lifecycle
- `RootChannelOwner` for connection root
- `ChannelOwner.from<T>()` for typed object resolution from wire data
- Factory registration system in `Connection` constructor

---

## Phase 4 — Core Automation

### Added

- `lib/src/playwright.dart` — `Playwright` class with `chromium`/`firefox`/`webkit` accessors and `newRequest()`
- `lib/src/browser_type.dart` — `BrowserType` with `launch()`, `launchPersistentContext()`, `connect()`, `connectOverCDP()`, `connectToWorker()`
- `lib/src/browser.dart` — `Browser` with `newContext()`, `newPage()`, `close()`, tracing, CDP session
- `lib/src/browser_context.dart` — `BrowserContext` with cookies, permissions, geolocation, routing, storage state, HAR, CDP
- `lib/src/page.dart` — `Page` with full navigation, evaluation, screenshots, PDF, routing, media emulation, viewport, locator shortcuts (~650 lines)
- `lib/src/frame.dart` — `Frame` with full action methods (~525 lines)
- `lib/src/keyboard.dart` — `Keyboard` input helper
- `lib/src/mouse.dart` — `Mouse` input helper
- `lib/src/serialization.dart` — `serializeArgument()` / `parseSerializedValue()` for RPC bridge

---

## Phase 5 — Actionability & Locators

### Added

- `lib/src/locator.dart` — `Locator` with 30+ interaction methods and 7 sub-locator strategies (~340 lines)
- `lib/src/element_handle.dart` — `ElementHandle` with 30+ DOM interaction methods (~330 lines)
- `lib/src/jshandle.dart` — `JSHandle` with expression evaluation and property access

---

## Phase 6 — Network & Advanced Features

### Added

- `lib/src/request.dart` — `Request` with `response()`, `rawRequestHeaders()`, `sizes()`
- `lib/src/response.dart` — `Response` with `finished()`, `body()`, `securityDetails()`, `serverAddr()`
- `lib/src/route.dart` — `Route` with `abort()`, `continue_()`, `fulfill()`, `fallback()`, `redirectNavigationRequest()`
- `lib/src/websocket.dart` — `PlaywrightWebSocket` channel wrapper
- `lib/src/websocket_route.dart` — `WebSocketRoute` with `close()`, `send()`, `ensureOpened()`
- `lib/src/api_request_context.dart` — `APIRequestContext` with `fetch()`, `storageState()`, `dispose()`
- `lib/src/dialog.dart` — `Dialog` with `accept()`, `dismiss()`
- `lib/src/worker.dart` — `Worker` with expression evaluation
- `lib/src/tracing.dart` — `Tracing` with start/stop/chunk operations
- `lib/src/cdp_session.dart` — `CDPSession` with `send()`, `detach()`
- `lib/src/artifact.dart` — `Artifact` with save/stream/cancel/delete
- `lib/src/stream.dart` — `PlaywrightStream` with `read()`, `close()`
- `lib/src/writable_stream.dart` — `WritableStream` with `write()`, `close()`

---

## Phase 7 — Debugging, Events & Low-Level

### Added

- `lib/src/debugger.dart` — `Debugger` with `resume()`, `next()`, `runTo()`
- `lib/src/debug_controller.dart` — `DebugController` with recorder/highlighting/navigation
- `lib/src/binding_call.dart` — `BindingCall` with `reject()`, `resolve()`
- `lib/src/event_target.dart` — `EventTarget` with `waitForEventInfo()`
- `lib/src/disposable.dart` — `Disposable` channel wrapper

---

## Phase 8 — Experimental & Platform-Specific

### Added

- `lib/src/android.dart` — `Android` with `devices()`
- `lib/src/android_device.dart` — `AndroidDevice` with 23 fully implemented methods (gestures, input, browser, APK, shell)
- `lib/src/android_socket.dart` — `AndroidSocket` with `write()`, `close()`
- `lib/src/electron.dart` — `Electron` with `launch()`
- `lib/src/electron_application.dart` — `ElectronApplication` with evaluation and subscription
- `lib/src/root.dart` — `Root` with `initialize()`
- `lib/src/socks_support.dart` — `SocksSupport` with 5 socket lifecycle methods
- `lib/src/json_pipe.dart` — `JsonPipe` with `send()`, `close()`

### Changed

- `connection.dart` — Registered all 35 object factories (was 17)
- `channel_owner.dart` — Added broadcast `StreamController` event system (`emitEvent()` / `onEvent`)

---

## Phase 9 — Convenience & Documentation

### Changed

- `playwright.dart` — Entry factory exposed as `PlaywrightDart.create()`
- `playwright_dart.dart` — Cleaned up as a unified export barrel file
- `browser_type.dart` — `connectToWorker()` now returns typed `Worker` instead of raw map
- `connection.dart` — Event dispatch now calls `object.emitEvent()` instead of printing debug logs

### Added

- `README.md` — Full usage documentation with examples
- `dart-port-plan/port_plan.md` — Comprehensive implementation plan with completion status
- `dart-port-plan/api_reference.md` — Node.js ↔ Dart API mapping reference
- `dart-port-plan/changelog.md` — This file

### Fixed

- Removed all `Future.value()` placeholder stubs (30 methods)
- Resolved all 2 remaining TODOs
- Zero `dart analyze` issues

---

## Tools

### Added

- `tool/generate_protocol.dart` — Protocol code generator
- `tool/find_missing.dart` — Parity verification tool

### Changed

- `tool/find_missing.dart` — Now checks 3 categories: missing fileMap entries, missing wrapper classes, and missing channel call wiring (308 methods verified)

---

## Phase 10 — Testing Framework

### Added

- `test/playwright_test.dart` — Custom `test()` wrapper function that auto-manages `Playwright`, `Browser`, `BrowserContext`, and `Page` fixtures per test
- Global `setUpAll` / `tearDownAll` lifecycle — launches browser once per test file, disposes gracefully
- Re-exports `package:test/test.dart` (expect, group, etc.) and `package:playwright_dart/playwright_dart.dart` for single-import convenience within the test suite

### Changed

- `pubspec.yaml` — Added `test` to `dev_dependencies`
- `connection.dart` — `TargetClosedError` and `Browser has been closed` errors are now swallowed during response dispatch, returning empty results instead of crashing the test runner
- `route.dart` — Added `request` getter that resolves the `Request` object from the route's initializer guid

### Fixed

- `page.dart` — Route event handler now resolves `Request` via `routeObj.request` instead of looking up a nonexistent `params['request']` key
- Removed unused `import 'request.dart'` from `page.dart`

---

## Phase 11 — Integration Tests

### Added

- `test/page_test.dart` — 3 tests: navigation with `goto()`, JavaScript evaluation with `evaluate()`, and content injection with `setContent()`
- `test/locator_test.dart` — 3 tests: `click`/`fill` interactions, sub-locators (`locator.locator()` with `getByLabel`/`getByRole`), and `check`/`uncheck`
- `test/network_test.dart` — 2 tests: `route.abort()` to block image loading, `route.fulfill()` to mock API JSON responses

### Verified

- `dart test --concurrency=1` — **8 tests passed** across 3 test files
- `dart analyze` — **0 issues**

---

## Phase 12 — pub.dev Release

### Added

- `LICENSE` — MIT license file
- `.pubignore` — Excludes `dart-port-plan/`, `tool/`, `bin/` from published package

### Changed

- `pubspec.yaml` — Added `description`, `homepage`, `repository`, `issue_tracker`, `topics`; version set to `0.1.0`
- `CHANGELOG.md` — Rewritten with pub.dev-compatible structured feature list
- `README.md` — Polished with badges, quick start guide, testing section, Locator/Network/Tracing/CDP examples, API coverage table, contributing guide
- `lib/playwright_dart.dart` — Complete barrel export with dartdoc comment, organized by category (Core, Interaction, Network, Utilities, Debugging, Platform, Infrastructure)
- `.gitignore` — Updated for library packages (ignores `pubspec.lock`, IDE files, OS files)
- `example/main.dart` — Clean standalone example with regular comments (avoids `dangling_library_doc_comments` lint)

### Verified

- `dart pub publish --dry-run` — Passes with 0 errors (58 KB compressed archive)
- `dart analyze` — **0 issues**
- `dart test --concurrency=1` — **8 tests passed**
