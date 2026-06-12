# Playwright Dart Port Implementation Plan

Based on the Playwright documentation (specifically `library.md` and the protocol architecture), here is the detailed assessment and implementation plan for porting Playwright to Dart.

## Proposed Architecture

Playwright uses a client/server architecture. The Node.js server (`playwright-core`) executes the browser automation, while the client (Dart) communicates with it using a JSON RPC protocol.

### Core Components
1. **Connection Layer**: A transport layer (spawning `node playwright.js run-driver`) communicating via JSON over standard I/O (stdin/stdout) or WebSockets.
2. **Base Object Model (`ChannelOwner`)**: Every Playwright object (Browser, Page, Locator) will extend a Dart base class `ChannelOwner`, tracking the `guid` to match the server object and dispatching method calls to the protocol.
3. **Protocol Generator**: A tool that reads `packages/protocol/src/protocol.yml` to generate Dart types, method parameters, and Channel interfaces.
4. **Public API Surface**: The user-facing Dart API that delegates calls to the auto-generated channel interfaces.

## Port Priorities (Phased Implementation)

### Phase 1: Transport & Connection (Foundation)
- Implement a driver runner that fetches or locates the Playwright Node.js binaries.
- Implement the `Connection` class to handle JSON-RPC message serialization and routing.
- Support request/response tracking (`id`) and object routing (`guid`).

### Phase 2: Protocol Code Generation
- Create a Dart script to parse `protocol.yml`.
- Generate `channels.dart` with Dart classes for all protocol parameters, results, and events (e.g., `PageChannel`, `BrowserChannel`).

### Phase 3: Object Lifecycle
- Implement `ChannelOwner` in Dart to manage object instantiation (`__create__`), parenting (`__adopt__`), and cleanup (`__dispose__`).
- Map initializers from the server to Dart constructors.

### Phase 4: Core Automation (Playwright, Browser, Page)
- Implement `Playwright` and `BrowserType` (supporting `launch` and `connect`).
- Implement `Browser`, `BrowserContext`, `Page`, and `Frame`.
- Wire up core methods: `goto()`, `close()`, `evaluate()`.

### Phase 5: Actionability & Locators
- Implement `Locator` and `ElementHandle`.
- Implement user interactions (`click()`, `fill()`, `check()`) ensuring auto-waiting is inherently handled by the server.

### Phase 6: Network & Advanced Features
- Implement network interception (`Route`, `Request`, `Response`).
- Implement `Dialog`, `Download`, and Tracing.

### Phase 7: Testing Framework Integration
- Develop a `playwright_test` Dart package providing a `test()` runner with built-in fixtures (like `page`, `context`) similar to `@playwright/test` for Node.js.

## Verification Plan

### Automated Tests
- Create a test suite modeled after Playwright's `tests/library/` and `tests/page/`.
- Validate each API feature against Chromium, Firefox, and WebKit.

### Manual Verification
- Build a simple Dart console application that launches a browser, navigates to `example.com`, takes a screenshot, and closes the browser to prove the end-to-end RPC transport works.
