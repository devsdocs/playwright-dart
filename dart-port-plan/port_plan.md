# Playwright Dart Port — Implementation Plan

A complete Dart SDK for [Playwright](https://playwright.dev), ported from the official Node.js `v1.60.0` codebase. This document describes the architecture, implementation phases, and current completion status.

## Architecture

Playwright uses a **client/server architecture**. The Node.js server (`playwright-core`) executes browser automation, while this Dart SDK communicates with it via a JSON-RPC protocol over stdio.

### Core Components

| Component | File(s) | Description |
|---|---|---|
| **Transport** | `transport.dart`, `websocket_transport.dart` | Bidirectional stdio/WebSocket channel to the Playwright driver process |
| **Connection** | `connection.dart` | JSON-RPC message routing — tracks `id` for request/response, `guid` for object identity, dispatches `__create__`/`__dispose__`/events |
| **ChannelOwner** | `channel_owner.dart` | Base class for all protocol objects. Manages `guid`, parent/child relationships, event streams, and lifecycle |
| **Protocol Generator** | `tool/generate_protocol.dart` | Parses `protocol.yml` from Playwright source and emits `generated/channels.dart` |
| **Generated Channels** | `generated/channels.dart` | Auto-generated abstract `*Base` classes containing all `channel_*` RPC dispatch methods |
| **Wrapper Classes** | `lib/src/*.dart` | User-facing API classes extending the generated bases, providing ergonomic Dart methods |
| **Parity Checker** | `tool/find_missing.dart` | Scans `channels.dart` and cross-references wrappers to detect missing fileMap entries, missing classes, missing methods, and missing channel calls |
| **Serialization** | `serialization.dart` | `serializeArgument()` / `parseSerializedValue()` for crossing the RPC bridge |
| **Driver** | `driver.dart`, `driver_downloader.dart` | Locates or downloads the Playwright Node.js driver binary, spawns it as a child process |

### Message Flow

```
Dart Code ──▶ Wrapper Method ──▶ channel_*() ──▶ Connection.sendMessageToServer()
                                                        │
                                                        ▼
                                                 StdioTransport ──▶ Playwright Node.js Server
                                                        │
                                                        ▼
                                              Response / Event dispatched back
```

---

## Implementation Phases

### Phase 1: Transport & Connection (Foundation) ✅

- [x] Implement `Driver` to spawn `node playwright.js run-driver`
- [x] Implement `DriverDownloader` for automatic binary management
- [x] Implement `StdioTransport` for JSON-over-stdio communication
- [x] Implement `WebSocketTransport` for remote browser connections
- [x] Implement `Connection` class with request/response tracking (`id`), object routing (`guid`), and event dispatch

### Phase 2: Protocol Code Generation ✅

- [x] Create `tool/generate_protocol.dart` to parse the official Playwright `protocol.yml`
- [x] Generate `lib/src/generated/channels.dart` with all abstract `*Base` classes
- [x] Generate typed parameters, enums, and mixins (e.g. `ContextOptions`, `AndroidSelector`, `SerializedArgument`)
- [x] Ensure generator references official remote Playwright repo, not local copies

### Phase 3: Object Lifecycle ✅

- [x] Implement `ChannelOwner` base class with `guid` management
- [x] Handle `__create__` — instantiate objects via registered factories
- [x] Handle `__dispose__` — clean up parent/child/connection references, close event streams
- [x] Implement `RootChannelOwner` for the connection root
- [x] Add broadcast `StreamController`-based event system (`emitEvent()` / `onEvent`)
- [x] Implement `ChannelOwner.from<T>()` for typed object resolution from wire data

### Phase 4: Core Automation ✅

- [x] `Playwright` — `chromium`, `firefox`, `webkit` browser type accessors, `newRequest()`, entry via `PlaywrightDart.create()`
- [x] `BrowserType` — `launch()`, `launchPersistentContext()`, `connect()`, `connectOverCDP()`, `connectToWorker()`
- [x] `Browser` — `newContext()`, `newPage()`, `close()`, `startTracing()`, `stopTracing()`, `newBrowserCDPSession()`, `contexts`
- [x] `BrowserContext` — `newPage()`, `cookies()`, `addCookies()`, `clearCookies()`, `grantPermissions()`, `setGeolocation()`, `setHTTPCredentials()`, `setExtraHTTPHeaders()`, `route()`, `unroute()`, `storageState()`, `newCDPSession()`, `harStart()`, `harExport()`, `close()`
- [x] `Page` — `goto()`, `close()`, `evaluate()`, `evaluateHandle()`, `waitForSelector()`, `waitForLoadState()`, `waitForNavigation()`, `waitForEvent()`, `screenshot()`, `pdf()`, `title()`, `content()`, `setContent()`, `addScriptTag()`, `addStyleTag()`, `route()`, `unroute()`, `emulateMedia()`, `setViewportSize()`, `bringToFront()`, `opener()`, all locator shortcuts
- [x] `Frame` — full mirroring of `Page` frame-level methods (`goto`, `click`, `fill`, `check`, `evaluate`, `waitForSelector`, `querySelector`, `querySelectorAll`, `selectOption`, `setInputFiles`, `dragAndDrop`, `ariaSnapshot`, etc.)

### Phase 5: Actionability & Locators ✅

- [x] `Locator` — `click()`, `fill()`, `check()`, `uncheck()`, `hover()`, `focus()`, `blur()`, `dblclick()`, `tap()`, `press()`, `type()`, `getAttribute()`, `innerText()`, `textContent()`, `innerHTML()`, `inputValue()`, `isVisible()`, `isHidden()`, `isEnabled()`, `isDisabled()`, `isEditable()`, `isChecked()`, `selectOption()`, `setInputFiles()`, `dispatchEvent()`, `highlight()`, `hideHighlight()`, `drop()`, `ariaSnapshot()`, `waitFor()`, `dragTo()`, `evaluate()`, `evaluateAll()`
- [x] `Locator` sub-locators — `getByText()`, `getByRole()`, `getByLabel()`, `getByPlaceholder()`, `getByAltText()`, `getByTitle()`, `getByTestId()`
- [x] `ElementHandle` — `contentFrame()`, `ownerFrame()`, `querySelector()`, `querySelectorAll()`, `dispatchEvent()`, `screenshot()`, `selectOption()`, `selectText()`, `setInputFiles()`, `waitForElementState()`, `waitForSelector()`, `fill()`, `click()`, `dblclick()`, `tap()`, `hover()`, `focus()`, `type()`, `press()`, `getAttribute()`, `textContent()`, `innerText()`, `innerHTML()`, `inputValue()`, `isVisible()`, `isHidden()`, `isEnabled()`, `isDisabled()`, `isEditable()`, `isChecked()`, `check()`, `uncheck()`, `scrollIntoViewIfNeeded()`, `boundingBox()`
- [x] `JSHandle` — `evaluateExpression()`, `evaluateExpressionHandle()`, `getPropertyList()`, `getProperty()`, `jsonValue()`, `dispose()`
- [x] `Keyboard` — `down()`, `up()`, `insertText()`, `type()`, `press()`
- [x] `Mouse` — `move()`, `down()`, `up()`, `click()`, `dblclick()`, `wheel()`

### Phase 6: Network & Advanced Features ✅

- [x] `Request` — `response()`, `rawRequestHeaders()`, `sizes()`
- [x] `Response` — `finished()`, `body()`, `securityDetails()`, `serverAddr()`, `rawResponseHeaders()`
- [x] `Route` — `abort()`, `continue_()`, `fulfill()`, `fallback()`, `redirectNavigationRequest()`
- [x] `WebSocket` (PlaywrightWebSocket) — registered channel wrapper
- [x] `WebSocketRoute` — `close()`, `closePage()`, `closeServer()`, `send()`, `ensureOpened()`
- [x] `APIRequestContext` — `fetch()`, `storageState()`, `dispose()`, `fetchResponseBody()`, `fetchLog()`
- [x] `Dialog` — `accept()`, `dismiss()`
- [x] `Worker` — `evaluateExpression()`, `evaluateExpressionHandle()`
- [x] `Tracing` — `tracingStart()`, `tracingStop()`, `tracingStartChunk()`, `tracingStopChunk()`
- [x] `CDPSession` — `send()`, `detach()`
- [x] `Artifact` — `pathAfterFinished()`, `saveAs()`, `saveAsStream()`, `stream()`, `failure()`, `cancel()`, `delete()`
- [x] `Stream` (PlaywrightStream) — `read()`, `close()`
- [x] `WritableStream` — `write()`, `close()`

### Phase 7: Debugging, Events & Low-Level ✅

- [x] `Debugger` — `resume()`, `next()`, `runTo()`
- [x] `DebugController` — `initialize()`, `navigate()`, `setRecorderMode()`, `highlight()`, `hideHighlight()`, `resume()`, `kill()`, `closeAllBrowsers()`
- [x] `BindingCall` — `reject()`, `resolve()`
- [x] `EventTarget` — `waitForEventInfo()`
- [x] `Disposable` — registered channel wrapper

### Phase 8: Experimental & Platform-Specific ✅

- [x] `Android` — `devices()`
- [x] `AndroidDevice` — `wait()`, `fill()`, `tap()`, `drag()`, `fling()`, `longTap()`, `pinchClose()`, `pinchOpen()`, `scroll()`, `swipe()`, `info()`, `screenshot()`, `inputType()`, `inputPress()`, `inputTap()`, `inputSwipe()`, `inputDrag()`, `launchBrowser()`, `open()`, `shell()`, `installApk()`, `push()`, `connectToWebView()`, `close()`
- [x] `AndroidSocket` — `write()`, `close()`
- [x] `Electron` — `launch()`
- [x] `ElectronApplication` — `browserWindow()`, `evaluateExpression()`, `evaluateExpressionHandle()`, `updateSubscription()`
- [x] `Root` — `initialize()`
- [x] `SocksSupport` — `socksConnected()`, `socksFailed()`, `socksData()`, `socksError()`, `socksEnd()`
- [x] `JsonPipe` — `send()`, `close()`

### Phase 9: Convenience & Documentation ✅

- [x] Keep `PlaywrightDart.create()` as the package entry point
- [x] Clean up `lib/playwright_dart.dart` as a unified export barrel
- [x] `README.md` with usage examples for browser launch, locators, routing, tracing, CDP
- [x] This implementation plan document

---

## File Inventory

### Wrapper Classes (35 total — 100% coverage of generated protocol)

| # | Class | File | Base Class |
|---|---|---|---|
| 1 | `Playwright` | `playwright.dart` | `PlaywrightBase` |
| 2 | `BrowserType` | `browser_type.dart` | `BrowserTypeBase` |
| 3 | `Browser` | `browser.dart` | `BrowserBase` |
| 4 | `BrowserContext` | `browser_context.dart` | `BrowserContextBase` |
| 5 | `Page` | `page.dart` | `PageBase` |
| 6 | `Frame` | `frame.dart` | `FrameBase` |
| 7 | `Locator` | `locator.dart` | *(standalone, uses Frame)* |
| 8 | `JSHandle` | `jshandle.dart` | `JSHandleBase` |
| 9 | `ElementHandle` | `element_handle.dart` | `ElementHandleBase` |
| 10 | `LocalUtils` | `local_utils.dart` | `LocalUtilsBase` |
| 11 | `Request` | `request.dart` | `RequestBase` |
| 12 | `Response` | `response.dart` | `ResponseBase` |
| 13 | `Route` | `route.dart` | `RouteBase` |
| 14 | `PlaywrightWebSocket` | `websocket.dart` | `WebSocketBase` |
| 15 | `WebSocketRoute` | `websocket_route.dart` | `WebSocketRouteBase` |
| 16 | `APIRequestContext` | `api_request_context.dart` | `APIRequestContextBase` |
| 17 | `Dialog` | `dialog.dart` | `DialogBase` |
| 18 | `Worker` | `worker.dart` | `WorkerBase` |
| 19 | `Tracing` | `tracing.dart` | `TracingBase` |
| 20 | `CDPSession` | `cdp_session.dart` | `CDPSessionBase` |
| 21 | `Artifact` | `artifact.dart` | `ArtifactBase` |
| 22 | `PlaywrightStream` | `stream.dart` | `StreamBase` |
| 23 | `WritableStream` | `writable_stream.dart` | `WritableStreamBase` |
| 24 | `Debugger` | `debugger.dart` | `DebuggerBase` |
| 25 | `DebugController` | `debug_controller.dart` | `DebugControllerBase` |
| 26 | `BindingCall` | `binding_call.dart` | `BindingCallBase` |
| 27 | `EventTarget` | `event_target.dart` | `EventTargetBase` |
| 28 | `Disposable` | `disposable.dart` | `DisposableBase` |
| 29 | `Android` | `android.dart` | `AndroidBase` |
| 30 | `AndroidDevice` | `android_device.dart` | `AndroidDeviceBase` |
| 31 | `AndroidSocket` | `android_socket.dart` | `AndroidSocketBase` |
| 32 | `Electron` | `electron.dart` | `ElectronBase` |
| 33 | `ElectronApplication` | `electron_application.dart` | `ElectronApplicationBase` |
| 34 | `Root` | `root.dart` | `RootBase` |
| 35 | `SocksSupport` | `socks_support.dart` | `SocksSupportBase` |
| — | `JsonPipe` | `json_pipe.dart` | `JsonPipeBase` |

### Infrastructure Files

| File | Purpose |
|---|---|
| `channel_owner.dart` | Base class with guid, event streams, lifecycle |
| `connection.dart` | JSON-RPC dispatch, 35 registered object factories |
| `driver.dart` | Spawns the Playwright Node.js driver process |
| `driver_downloader.dart` | Downloads Playwright binaries |
| `transport.dart` | Stdio-based transport layer |
| `websocket_transport.dart` | WebSocket-based transport layer |
| `serialization.dart` | Argument serialization/deserialization |
| `keyboard.dart` | Keyboard input helper |
| `mouse.dart` | Mouse input helper |
| `locator.dart` | Locator API (standalone, delegates to Frame) |
| `file_payload.dart` | File upload payload model |
| `version.dart` | SDK version constants |

### Tools

| File | Purpose |
|---|---|
| `tool/generate_protocol.dart` | Generates `channels.dart` from Playwright `protocol.yml` |
| `tool/find_missing.dart` | Validates 100% parity — checks fileMap, wrapper classes, method wrappers, and channel call presence |

---

### Phase 10: Testing Framework ✅

- [x] Create `test/playwright_test.dart` exporting `package:test/test.dart` and `package:playwright_dart/playwright_dart.dart` for internal test use
- [x] Implement `test()` wrapper function that auto-manages `Playwright`, `Browser`, `BrowserContext`, and `Page` fixtures
- [x] Global `setUpAll` / `tearDownAll` lifecycle — launches browser once per test file, disposes gracefully
- [x] Robust `TargetClosedError` handling during teardown (swallows errors from in-flight commands when the browser closes)

### Phase 11: Integration Tests ✅

- [x] `test/page_test.dart` — Navigation (`goto`), JavaScript evaluation (`evaluate`), content injection (`setContent`), and title assertions
- [x] `test/locator_test.dart` — DOM interactions: `click`, `fill`, `check`, `uncheck`, sub-locators (`locator.locator()`), `getByLabel`, `getByRole`
- [x] `test/network_test.dart` — Network interception: `route.abort()` to block image requests, `route.fulfill()` to mock API JSON responses
- [x] All 8 tests pass with `dart test --concurrency=1`

---

## Verification Status

```
$ dart analyze
Analyzing playwright-dart...
No issues found!

$ dart tool/find_missing.dart
=== Missing fileMap Entries ===
None!

=== Missing Wrapper Classes ===
None!

=== Missing API Wrappers in Existing Classes ===
None! (Checked 308 methods)

$ dart test --concurrency=1
00:21 +3: test\locator_test.dart: Locator API (tearDownAll)
00:42 +5: test\network_test.dart: Network Interception (tearDownAll)
01:03 +8: test\page_test.dart: Page API (tearDownAll)
01:04 +8: All tests passed!
```

- **35 abstract Base classes** generated from `protocol.yml`
- **35 wrapper classes** implemented (+ `Locator` standalone)
- **308 channel methods** verified with actual `channel_*` dispatch calls
- **8 integration tests** passing across 3 test files
- **0 TODOs** remaining
- **0 `Future.value()` placeholder stubs** remaining

---

### Phase 12: pub.dev Release ✅

- [x] `pubspec.yaml` — Proper `description`, `homepage`, `repository`, `issue_tracker`, `topics`
- [x] Version set to `0.1.0` (first pre-release)
- [x] `LICENSE` — MIT license file
- [x] `CHANGELOG.md` — pub.dev-compatible changelog with structured feature list
- [x] `README.md` — Polished with badges, quick start, testing, locators, network interception, tracing, CDP, API coverage table, contributing guide
- [x] `lib/playwright_dart.dart` — Complete barrel export with dartdoc, organized by category (Core, Interaction, Network, Utilities, Debugging, Platform, Infrastructure)
- [x] `.pubignore` — Excludes `dart-port-plan/`, `tool/`, `bin/` from published package
- [x] `.gitignore` — Updated for library packages (ignores `pubspec.lock`, IDE files, OS files)
- [x] `example/main.dart` — Clean standalone example with dartdoc
- [x] `dart pub publish --dry-run` — Passes with 0 errors (58 KB compressed)

---

## All Phases Complete 🎉

All 12 implementation phases have been completed. The package is ready for `dart pub publish`.
