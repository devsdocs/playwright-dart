# Playwright Dart — Comprehensive Gaps Analysis

This document provides a complete analysis of gaps between the playwright-dart implementation and the official Playwright Node.js API. It focuses on features that are **possible to implement** given the architecture where the Dart SDK communicates with the Playwright Node.js driver via JSON-RPC protocol.

**Last Updated**: June 17, 2026  
**Protocol Version**: 1.61.0  
**Package Version**: 3.4.0

---

## Architecture Context

The playwright-dart SDK uses a **client/server architecture**:
- Dart SDK communicates with Playwright Node.js driver via JSON-RPC protocol over stdio
- The Node.js driver executes browser automation
- Dart wrapper classes call `channel_*()` methods that send messages to the Node.js server
- All protocol-based features are implementable in Dart
- Node.js-specific tools (CLI tools, test runners, UI apps) are NOT portable to Dart

**Key Implication**: Only protocol-based features can be implemented in Dart. Node.js-specific tools must be used separately or re-implemented from scratch in Dart.

---

## Executive Summary

The playwright-dart repository provides a **complete port of the core Playwright automation library** with 35 wrapper classes and 308 channel methods. The core automation API is 100% complete (verified by `tool/find_missing.dart`).

However, there are gaps in:

1. **API-Level Gaps**: Specific methods, assertions, and classes that are missing from the core automation API (ALL implementable via protocol)
2. **Dart-Native Features**: Features that could be implemented in Dart but don't exist in Node.js Playwright (e.g., HTML reports, config file parser)

**Excluded from this analysis**: Node.js-specific tools like `@playwright/test`, `playwright codegen`, UI mode, component testing, and AI integration. These cannot be ported to Dart as they are separate Node.js applications, not protocol features.

---

## Part 1: API-Level Gaps (Core Automation API)

These are specific methods, classes, and features missing from the core Playwright automation API. These gaps affect users even when using playwright-dart for basic browser automation.

### Priority 1 — High Impact (User-Facing Testing Gaps)

#### 1.1 LocatorAssertions — 13+ Missing Assertions

**File**: `lib/src/interaction/locator_assertions.dart`

The current implementation has 12 assertions. The following are missing from the official Playwright API:

| Assertion | Added Version | Description | Implementation Notes |
|---|---|---|---|
| `toBeAttached({attached?, timeout?})` | v1.33 | Checks element is connected to DOM | Delegates to `FrameImpl.channel_expect(...)` with expression `"to.be.attached"` |
| `toBeEditable({editable?, timeout?})` | v1.20 | Checks editable state | Expression: `"to.be.editable"` |
| `toBeEmpty({timeout?})` | v1.20 | Empty editable or no text content | Expression: `"to.be.empty"` |
| `toBeFocused({timeout?})` | v1.20 | Element has focus | Expression: `"to.be.focused"` |
| `toBeInViewport({ratio?, timeout?})` | v1.31 | Intersects viewport by given ratio | Expression: `"to.be.in.viewport"` with `expectedNumber` = ratio |
| `toContainClass(expected, {timeout?})` | v1.52 | Element has subset of CSS classes | Expression: `"to.contain.class"`; accepts `String \| List<String>` |
| `toHaveAccessibleDescription(desc, {ignoreCase?, timeout?})` | v1.44 | Matches `aria-describedby` / `aria-description` | Expression: `"to.have.accessible.description"` |
| `toHaveAccessibleErrorMessage(msg, {ignoreCase?, timeout?})` | v1.50 | Matches `aria-errormessage` | Expression: `"to.have.accessible.error.message"` |
| `toHaveAccessibleName(name, {ignoreCase?, timeout?})` | v1.44 | Matches accessible name | Expression: `"to.have.accessible.name"` |
| `toHaveCSS(name, value, {pseudo?, timeout?})` | v1.20 | Computed CSS property | Expression: `"to.have.css"`; `pseudo` can be `"before"` / `"after"` (v1.60) |
| `toHaveJSProperty(name, value, {timeout?})` | v1.20 | JavaScript DOM property equality | Expression: `"to.have.js.property"`; expressionArg = name, expectedValue = serialized value |
| `toHaveRole(role, {timeout?})` | v1.44 | ARIA role string match | Expression: `"to.have.role"`; expressionArg = role string |
| `toHaveValues(values, {timeout?})` | v1.23 | Multi-select `<select>` selected options | Expression: `"to.have.values"`; expectedText list |
| `toMatchAriaSnapshot(expected, {timeout?})` | v1.49 | ARIA snapshot string match | Expression: `"to.match.aria.snapshot"`; expressionArg = snapshot YAML |
| `toHaveScreenshot(name\|options)` | v1.23 | Screenshot diff | Test-runner only; can be stubbed |

**Additional Update**: Update `toBeChecked` to support the `indeterminate` option (added v1.50):
```dart
Future<void> toBeChecked({bool? checked, bool? indeterminate, double? timeout})
```

**Implementation Effort**: Low–Medium  
**Impact**: High - These assertions are commonly used in modern Playwright tests

---

#### 1.2 PageAssertions Class — Entirely Absent

**New File**: `lib/src/interaction/page_assertions.dart`

The official Playwright API includes a `PageAssertions` class for page-level assertions. This is currently missing.

```dart
class PageAssertions {
  final Page _page;
  final bool _isNot;
  PageAssertions(this._page, [this._isNot = false]);
  PageAssertions get not => PageAssertions(_page, !_isNot);

  Future<void> toHaveTitle(Pattern expected, {double? timeout});
  Future<void> toHaveURL(Pattern expected, {double? timeout});
}
```

These delegate to `PageImpl.channel_expect(...)` with:
- `toHaveTitle` → expression `"to.have.title"`, `expectedText` = title pattern
- `toHaveURL` → expression `"to.have.url"`, `expectedText` = URL pattern

**Required Addition**: Add an `expect()` helper on `Page` that returns `PageAssertions`:
```dart
PageAssertions expect({double? timeout}) => PageAssertions(this, false, timeout);
```

Export from `lib/playwright_dart.dart`.

**Implementation Effort**: Low  
**Impact**: High - Page-level assertions are fundamental to test reliability

---

#### 1.3 getByRole — Missing ARIA Filter Options

**Files**: `lib/src/core/locator.dart`, `lib/src/core/frame_locator.dart`, `lib/src/core/frame.dart`, `lib/src/core/page.dart`

The current `getByRole(String role, {Pattern? name, bool exact})` is missing several ARIA filter options:

| Option | Added Version | Description |
|---|---|---|
| `checked` | v1.27 | `aria-checked` |
| `description` | v1.60 | Accessible description match |
| `disabled` | v1.27 | `aria-disabled` |
| `expanded` | v1.27 | `aria-expanded` |
| `includeHidden` | v1.27 | Include `aria-hidden` elements |
| `level` | v1.27 | For headings, list items, etc. |
| `pressed` | v1.27 | `aria-pressed` |
| `selected` | v1.27 | `aria-selected` |

**Implementation Details**: These are encoded in the internal selector string passed to Playwright:
```
internal:role=button[name="Submit"][checked=true][disabled=false]
```

Update `encodePatternForRoleName` / `getByRole` to accept and encode these options.

**Implementation Effort**: Medium  
**Impact**: High - ARIA filters are essential for accessible testing

---

#### 1.4 addLocatorHandler / removeLocatorHandler

**File**: `lib/src/core/page.dart`

| Method | Added Version | Description |
|---|---|---|
| `addLocatorHandler(Locator locator, Future<void> Function(Locator) handler, {bool? noWaitAfter, int? times})` | v1.42 | Registers handler for overlay/interstitial locators |
| `removeLocatorHandler(Locator locator)` | v1.44 | Removes all handlers for a locator |

**Implementation Details**: These map to:
- `channel_registerLocatorHandler(selector, noWaitAfter, times)`
- `channel_unregisterLocatorHandler(uid)` (uid returned from register call)

Internally, on `onLocatorHandlerTriggered` event, call the registered handler and then `channel_resolveLocatorHandlerNoReply(uid)`.

**Implementation Effort**: Medium  
**Impact**: High - Critical for handling overlays, cookie banners, and interstitials

---

### Priority 2 — Medium Impact

#### 2.1 page.request Property

**File**: `lib/src/core/page.dart`

The `BrowserContext.request` `APIRequestContext` should be exposed directly on `Page` as a shortcut:

```dart
APIRequestContext get request => context.request;
```

**Available Since**: v1.16  
**Implementation Effort**: Trivial  
**Impact**: Medium - Convenience method for API testing from page context

---

#### 2.2 page.clock Property

**File**: `lib/src/core/page.dart`

Expose the context's `Clock` on `Page`:

```dart
Clock get clock => context.clock;
```

**Available Since**: v1.45  
**Implementation Effort**: Trivial  
**Impact**: Medium - Important for time-based testing

---

#### 2.3 page.routeWebSocket(url, handler)

**File**: `lib/src/core/page.dart`

```dart
Future<void> routeWebSocket(String url, Future<void> Function(WebSocketRoute) handler)
```

**Added**: v1.48  
**Description**: Mirrors `context.setWebSocketInterceptionPatterns` but as a higher-level route API on `Page`. Internally stores handlers and dispatches via `onWebSocketRoute`.

**Implementation Effort**: Medium  
**Impact**: Medium - Important for WebSocket testing

---

#### 2.4 FrameLocator.owner()

**File**: `lib/src/core/frame_locator.dart`

```dart
Locator owner() => Locator(frame, frameSelector);
```

**Added**: v1.43  
**Description**: Returns the `Locator` for the `<iframe>` element itself (the reverse of `locator.contentFrame`).

**Implementation Effort**: Trivial  
**Impact**: Medium - Useful for iframe manipulation

---

#### 2.5 Locator.description() Getter and Locator.toString()

**File**: `lib/src/core/locator.dart`

```dart
/// Returns the description string set via [describe()], or null.
String? description() {
  final match = RegExp(r'internal:describe=(.+)$').firstMatch(selector);
  if (match == null) return null;
  return jsonDecode(match.group(1)!) as String?;
}

@override
String toString() {
  return description() ?? 'Locator@$selector';
}
```

**Added**: v1.57  
**Implementation Effort**: Trivial  
**Impact**: Medium - Improves debugging and error messages

---

#### 2.6 Locator.filter({ visible? }) Option

**File**: `lib/src/core/locator.dart`

The `filter()` method is missing the `visible` option (added v1.51):

```dart
Locator filter({
  Pattern? hasText,
  Locator? has,
  Pattern? hasNotText,
  Locator? hasNot,
  bool? visible,   // NEW
})
```

**Implementation Details**: When `visible` is provided, append `>> visible=true` or `>> visible=false` to the selector chain.

**Implementation Effort**: Low  
**Impact**: Medium - Useful for filtering by visibility

---

### Priority 3 — Lower Impact / Bug Fixes

#### 3.1 Request.redirectedTo — Always Returns null

**File**: `lib/src/network/request.dart`

**Issue**: The `redirectedTo` getter currently always returns `null`. It should resolve to the next request in the redirect chain.

**Fix**: When constructing a `RequestImpl`, look up `redirectedFrom` in `connection.objects` and set a `_redirectedTo` back-reference on it. The `redirectedFrom` → `redirectedTo` back-reference needs to be wired when Playwright fires `requestRedirected` or when a `Request` is created with a `redirectedFrom` in its initializer.

**Implementation Effort**: Low  
**Impact**: Low - Bug fix for redirect chain tracking

---

#### 3.2 Response.fromServiceWorker — Type Mismatch

**File**: `lib/src/network/response.dart`

**Issue**: The boolean `typedInitializer.fromServiceWorker` is read, but the getter returns `Worker?`. The protocol sends only the boolean, not an object reference.

**Fix**: Change the return type to `bool` and return `typedInitializer.fromServiceWorker` directly.

**Current Code** (line 57-63 in response.dart):
```dart
@override
Worker? get fromServiceWorker {
  if (!typedInitializer.fromServiceWorker) return null;
  // The fromServiceWorker in the protocol is a boolean, but we need to resolve the actual worker
  // This is a special case - the boolean indicates if it came from a service worker
  // but we don't have the actual worker reference in the initializer
  return null;
}
```

**Should Be**:
```dart
@override
bool get fromServiceWorker => typedInitializer.fromServiceWorker;
```

**Implementation Effort**: Trivial  
**Impact**: Low - Type fix for protocol accuracy

---

## Part 2: Already Implemented (Previously Listed as Missing)

The following features were previously listed as missing but are **already implemented** in the current codebase:

### 2.1 WebStorage (localStorage/sessionStorage)

**Status**: ✅ Already Implemented

**Files**: `lib/src/core/page.dart` (lines 744-777, 2763-2807)

The protocol methods `channel_webStorageGetItem`, `channel_webStorageSetItem`, `channel_webStorageRemoveItem`, `channel_webStorageClear` exist and are already wrapped in the `Page` class as:
- `storageItems(kind)`
- `storageGetItem(kind, name)`
- `storageSetItem(kind, name, value)`
- `storageRemoveItem(kind, name)`
- `storageClear(kind)`

No additional `WebStorage` class is needed - the methods are directly available on `Page`.

---

### 2.2 Screencast

**Status**: ✅ Already Implemented

**Files**: `lib/src/core/page.dart` (lines 642-654, 2497-2522, 2687-2720)

The protocol methods `channel_screencastStart`, `channel_screencastStop` exist and are already wrapped in the `Page` class as:
- `screencastStart({size, quality, sendFrames, record})`
- `screencastStop()`
- `screencastShowOverlay(html, {duration})`
- `screencastRemoveOverlay(id)`
- `screencastChapter(title, {description, duration})`
- `screencastSetOverlayVisible(visible)`
- `screencastShowActions(options)`
- `screencastHideActions()`

The `onScreencastFrame` stream is also already implemented (line 895-899).

No additional `Screencast` class is needed - the methods are directly available on `Page`.

---

### 2.3 Coverage (JS/CSS)

**Status**: ✅ Already Implemented

**Files**: `lib/src/core/page.dart` (lines 703-713, 2649-2685)

The protocol methods `channel_startJSCoverage`, `channel_stopJSCoverage`, `channel_startCSSCoverage`, `channel_stopCSSCoverage` exist and are already wrapped in the `Page` class as:
- `startJSCoverage({resetOnNavigation, reportAnonymousScripts})`
- `stopJSCoverage()`
- `startCSSCoverage({resetOnNavigation})`
- `stopCSSCoverage()`

No additional `Coverage` class is needed - the methods are directly available on `Page`.

---

### 2.4 consoleMessages, pageErrors, requests

**Status**: ✅ Already Implemented

**Files**: `lib/src/core/page.dart` (lines 660-671, 2536-2575)

The protocol methods `channel_consoleMessages`, `channel_clearConsoleMessages`, `channel_pageErrors`, `channel_clearPageErrors` exist and are already wrapped in the `Page` class as:
- `consoleMessages({filter})`
- `clearConsoleMessages()`
- `pageErrors({filter})`
- `clearPageErrors()`
- `requests()`

These were previously listed as missing (Priority 2.3) but are already implemented.

---

## Part 3: Dart-Native Features (Optional Enhancements)

These are features that could be implemented in Dart to improve the developer experience, even though they don't exist in the official Node.js Playwright. These are NOT protocol features but could be built as Dart-specific enhancements.

### 3.1 HTML Test Reports

**Status**: ❌ Not Implemented (Optional)

**Description**: Generate HTML test reports from Dart test execution using the playwright-dart package. This would be a Dart-native feature, not a protocol feature.

**Implementation**: Build a Dart package that:
- Hooks into Dart's test package
- Captures test results, screenshots, and traces
- Generates an HTML report similar to Playwright's HTML reporter
- Provides filtering, search, and detailed error inspection

**Implementation Effort**: Medium  
**Impact**: High - Significantly improves test result visualization and team collaboration

---

### 3.2 Configuration File (playwright.config.dart)

**Status**: ❌ Not Implemented (Optional)

**Description**: Create a Dart configuration file system similar to `playwright.config.ts`. This would be a Dart-native feature, not a protocol feature.

**Implementation**: Build a configuration parser that:
- Reads a `playwright.config.dart` or YAML file
- Provides centralized configuration for browsers, timeouts, retries
- Integrates with Dart's test package
- Supports project configurations

**Implementation Effort**: Medium  
**Impact**: High - Improves developer experience and configuration management

---

### 3.3 APIResponseAssertions

**Status**: ❌ Not Implemented (Optional)

**Description**: Add assertions for APIResponse objects. This is a pure Dart feature, not a protocol feature.

**Implementation**:
```dart
class APIResponseAssertions {
  final APIResponse _response;
  final bool _isNot;
  APIResponseAssertions(this._response, [this._isNot = false]);
  APIResponseAssertions get not => APIResponseAssertions(_response, !_isNot);

  Future<void> toBeOK() {
    if (_isNot) {
      if (_response.ok) throw Exception('Expected response not to be OK');
    } else {
      if (!_response.ok) throw Exception('Expected response to be OK');
    }
  }
}
```

**Implementation Effort**: Low  
**Impact**: Low - Useful for API response validation

---

## What IS Implemented ✅

The playwright-dart repository has excellent coverage of the **core Playwright API**:

- ✅ **All 35 wrapper classes** with 308 channel methods
- ✅ **Browser automation** (Chromium, Firefox, WebKit)
- ✅ **Locator API** with assertions (12 assertions implemented)
- ✅ **Network interception** (abort, mock, modify requests)
- ✅ **Tracing** (record and view traces in Trace Viewer)
- ✅ **WebAuthn support** (virtual authenticators)
- ✅ **Screenshots & PDFs**
- ✅ **CDP session access** (Chrome DevTools Protocol)
- ✅ **Android support** (device automation)
- ✅ **Electron support** (desktop app automation)
- ✅ **API testing** (APIRequestContext)
- ✅ **Remote browser connection** (WebSocket and CDP)
- ✅ **No Node.js required** (bundled driver)
- ✅ **WebStorage** (localStorage/sessionStorage methods on Page)
- ✅ **Screencast** (screencast methods on Page)
- ✅ **Coverage** (JS/CSS coverage methods on Page)
- ✅ **consoleMessages/pageErrors/requests** (methods on Page)
- ✅ **100% protocol parity** (verified by `tool/find_missing.dart`)

---

## Implementation Priority Recommendations

### High Priority (Core API Completeness)

These features are essential for API parity with the official Playwright:

1. **LocatorAssertions (Priority 1.1)** - 13 missing assertions commonly used in modern tests
2. **PageAssertions (Priority 1.2)** - Fundamental page-level assertions
3. **getByRole ARIA Filter Options (Priority 1.3)** - Essential for accessible testing
4. **addLocatorHandler (Priority 1.4)** - Critical for handling overlays and interstitials

### Medium Priority (Developer Experience)

These features improve the developer experience:

5. **page.request property (Priority 2.1)** - Convenience method for API testing
6. **page.clock property (Priority 2.2)** - Important for time-based testing
7. **page.routeWebSocket (Priority 2.3)** - Important for WebSocket testing
8. **Locator.filter({ visible? }) (Priority 2.6)** - Useful for filtering by visibility

### Low Priority (Nice-to-Have)

These features are minor enhancements:

9. **FrameLocator.owner() (Priority 2.4)** - Useful for iframe manipulation
10. **Locator.description() + toString() (Priority 2.5)** - Improves debugging
11. **Request.redirectedTo fix (Priority 3.1)** - Bug fix for redirect chain tracking
12. **Response.fromServiceWorker type fix (Priority 3.2)** - Type fix for protocol accuracy

### Optional Dart-Native Features

These are NOT part of the official Playwright API but could be implemented as Dart-specific enhancements:

13. **HTML Test Reports (Part 3.1)** - Dart-native feature for test visualization
14. **Configuration File (Part 3.2)** - Dart-native configuration system
15. **APIResponseAssertions (Part 3.3)** - Pure Dart assertion helper

---

## Implementation Effort Summary

| Feature Category | Number of Items | Total Effort |
|---|---|---|
| Priority 1 API Gaps | 4 | Medium |
| Priority 2 API Gaps | 6 | Low-Medium |
| Priority 3 Bug Fixes | 2 | Trivial-Low |
| Optional Dart-Native Features | 3 | Medium |

**Total Estimated Effort**: Medium (all features are protocol-based and implementable)

---

## API-Level Gaps Summary Table

| # | Feature | File(s) | Priority | Effort | Impact |
|---|---|---|---|---|---|
| 1.1 | LocatorAssertions — 13 missing assertions + `indeterminate` | `locator_assertions.dart` | P1 | Low–Med | High |
| 1.2 | `PageAssertions` class | new `page_assertions.dart` | P1 | Low | High |
| 1.3 | `getByRole` ARIA filter options | `locator.dart`, `frame.dart`, `page.dart`, `frame_locator.dart` | P1 | Med | High |
| 1.4 | `addLocatorHandler` / `removeLocatorHandler` | `page.dart` | P1 | Med | High |
| 2.1 | `page.request` property | `page.dart` | P2 | Trivial | Medium |
| 2.2 | `page.clock` property | `page.dart` | P2 | Trivial | Medium |
| 2.3 | `page.routeWebSocket` | `page.dart` | P2 | Med | Medium |
| 2.4 | `FrameLocator.owner()` | `frame_locator.dart` | P2 | Trivial | Medium |
| 2.5 | `Locator.description()` + `toString()` | `locator.dart` | P2 | Trivial | Medium |
| 2.6 | `Locator.filter({ visible? })` | `locator.dart` | P2 | Low | Medium |
| 3.1 | `Request.redirectedTo` fix | `request.dart` | P3 | Low | Low |
| 3.2 | `Response.fromServiceWorker` type fix | `response.dart` | P3 | Trivial | Low |

---

## Optional Dart-Native Features Summary Table

| # | Feature | Status | Effort | Impact | Priority |
|---|---|---|---|---|---|
| 3.1 | HTML Test Reports | ❌ Not Implemented | Medium | High | Medium |
| 3.2 | Configuration File (playwright.config.dart) | ❌ Not Implemented | Medium | High | Medium |
| 3.3 | APIResponseAssertions | ❌ Not Implemented | Low | Low | Low |

---

## Notes

- The current playwright-dart implementation is **production-ready for browser automation and scripting**
- All gaps identified in this document are **implementable** via the protocol or as Dart-native features
- Node.js-specific tools (@playwright/test, codegen, UI mode, component testing, AI integration) are **excluded** from this analysis as they cannot be ported to Dart
- The core automation API is 100% complete (verified by `tool/find_missing.dart`)
- API-level gaps are relatively low effort to implement
- Several features previously listed as missing (WebStorage, Screencast, Coverage, consoleMessages, pageErrors, requests) are **already implemented**
- Optional Dart-native features could be implemented to improve the developer experience beyond what the official Playwright provides

---

## References

- Official Playwright Documentation: https://playwright.dev/docs/intro
- DeepWiki Playwright Overview: https://deepwiki.com/microsoft/playwright
- Protocol Version: 1.61.0
- Package Version: 3.4.0

---

## Change History

- **June 17, 2026**: Initial comprehensive gaps analysis created by combining gaps.md and missing_features.md
- **June 17, 2026**: Updated to filter out Node.js-specific tools and cross-check with actual code implementation. Removed ecosystem gaps section (test framework, codegen, UI mode, etc.) as these are not implementable via protocol. Added "Already Implemented" section for features that were incorrectly listed as missing. Added "Dart-Native Features" section for optional enhancements.
