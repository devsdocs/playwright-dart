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

**All API-Level Gaps Have Been Addressed**: All previously identified missing methods, assertions, and classes have been implemented:
- ✅ Priority 1 (High Impact): LocatorAssertions, PageAssertions, getByRole ARIA filters, addLocatorHandler
- ✅ Priority 2 (Medium Impact): page.request, page.clock, page.routeWebSocket, FrameLocator.owner(), Locator.description(), Locator.filter({ visible? })
- ✅ Priority 3 (Low Impact/Bug Fixes): Request.redirectedTo, Response.fromServiceWorker

The only remaining gaps are:

1. **Dart-Native Features**: Features that could be implemented in Dart but don't exist in Node.js Playwright (e.g., HTML reports, config file parser) - These are optional enhancements

**Excluded from this analysis**: Node.js-specific tools like `@playwright/test`, `playwright codegen`, UI mode, component testing, and AI integration. These cannot be ported to Dart as they are separate Node.js applications, not protocol features.

---

## Part 1: API-Level Gaps (Core Automation API)

These are specific methods, classes, and features missing from the core Playwright automation API. These gaps affect users even when using playwright-dart for basic browser automation.

### Priority 1 — High Impact (User-Facing Testing Gaps)

#### 1.1 LocatorAssertions — 13+ Missing Assertions

**Status**: ✅ Already Implemented

**File**: `lib/src/interaction/locator_assertions.dart`

All 13 missing assertions are already implemented:
- `toBeAttached({attached?, timeout?})` (lines 150-160)
- `toBeEditable({editable?, timeout?})` (lines 162-172)
- `toBeEmpty({timeout?})` (lines 174-181)
- `toBeFocused({timeout?})` (lines 183-190)
- `toBeInViewport({ratio?, timeout?})` (lines 192-200)
- `toContainClass(expected, {timeout?})` (lines 202-214)
- `toHaveAccessibleDescription(desc, {ignoreCase?, timeout?})` (lines 216-234)
- `toHaveAccessibleErrorMessage(msg, {ignoreCase?, timeout?})` (lines 236-254)
- `toHaveAccessibleName(name, {ignoreCase?, timeout?})` (lines 256-274)
- `toHaveCSS(name, value, {pseudo?, timeout?})` (lines 276-293)
- `toHaveJSProperty(name, value, {timeout?})` (lines 295-304)
- `toHaveRole(role, {timeout?})` (lines 306-314)
- `toHaveValues(values, {timeout?})` (lines 316-328)
- `toMatchAriaSnapshot(expected, {timeout?})` (lines 330-338)

The `toBeChecked` method already supports the `indeterminate` option (lines 134-148).

**Implementation Effort**: Low–Medium  
**Impact**: High - These assertions are commonly used in modern Playwright tests

---

#### 1.2 PageAssertions Class — Entirely Absent

**Status**: ✅ Already Implemented

**File**: `lib/src/interaction/page_assertions.dart`

The `PageAssertions` class is already implemented with:
- `toHaveTitle(Pattern expected, {double? timeout})` (lines 25-37)
- `toHaveURL(Pattern expected, {double? timeout})` (lines 42-51)

The class includes the `not` getter and helper methods for pattern matching.

**Implementation Effort**: Low  
**Impact**: High - Page-level assertions are fundamental to test reliability

---

#### 1.3 getByRole — Missing ARIA Filter Options

**Status**: ✅ Already Implemented

**Files**: `lib/src/core/locator.dart`, `lib/src/core/frame_locator.dart`, `lib/src/core/frame.dart`, `lib/src/core/page.dart`

All ARIA filter options are already implemented in `getByRole` (locator.dart lines 203-231):
- `checked` (v1.27)
- `description` (v1.60)
- `disabled` (v1.27)
- `expanded` (v1.27)
- `includeHidden` (v1.27)
- `level` (v1.27)
- `pressed` (v1.27)
- `selected` (v1.27)

**Implementation Effort**: Medium  
**Impact**: High - ARIA filters are essential for accessible testing

---

#### 1.4 addLocatorHandler / removeLocatorHandler

**Status**: ✅ Already Implemented

**File**: `lib/src/core/page.dart`

Both methods are already implemented:
- `addLocatorHandler(Locator locator, Future<void> Function(Locator) handler, {bool? noWaitAfter, int? times})` (lines 2548-2585)
- `removeLocatorHandler(Locator locator)` (lines 2587-2600)

**Implementation Effort**: Medium  
**Impact**: High - Critical for handling overlays, cookie banners, and interstitials

---

### Priority 2 — Medium Impact

#### 2.1 page.request Property

**Status**: ✅ Already Implemented

**File**: `lib/src/core/page.dart`

The `page.request` property is already implemented (line 1737):
```dart
APIRequestContext get request => (context as BrowserContextImpl).request;
```

**Available Since**: v1.16  
**Implementation Effort**: Trivial  
**Impact**: Medium - Convenience method for API testing from page context

---

#### 2.2 page.clock Property

**Status**: ✅ Already Implemented

**File**: `lib/src/core/page.dart`

The `page.clock` property is already implemented (line 1741):
```dart
Clock get clock => (context as BrowserContextImpl).clock;
```

**Available Since**: v1.45  
**Implementation Effort**: Trivial  
**Impact**: Medium - Important for time-based testing

---

#### 2.3 page.routeWebSocket(url, handler)

**Status**: ✅ Already Implemented

**File**: `lib/src/core/page.dart`

The `routeWebSocket` method is already implemented (lines 2643-2671):
```dart
Future<void> routeWebSocket(
  Pattern url,
  Future<void> Function(WebSocketRoute) handler,
)
```

It stores handlers and dispatches via `onWebSocketRoute` event, and calls `channel_setWebSocketInterceptionPatterns` to enable interception.

**Added**: v1.48  
**Description**: Mirrors `context.setWebSocketInterceptionPatterns` but as a higher-level route API on `Page`. Internally stores handlers and dispatches via `onWebSocketRoute`.

**Implementation Effort**: Medium  
**Impact**: Medium - Important for WebSocket testing

---

#### 2.4 FrameLocator.owner()

**Status**: ✅ Already Implemented

**File**: `lib/src/core/frame_locator.dart`

The `owner()` method is already implemented (line 20):
```dart
Locator owner() => Locator(frame, frameSelector);
```

**Added**: v1.43  
**Description**: Returns the `Locator` for the `<iframe>` element itself (the reverse of `locator.contentFrame`).

**Implementation Effort**: Trivial  
**Impact**: Medium - Useful for iframe manipulation

---

#### 2.5 Locator.description() Getter and Locator.toString()

**Status**: ✅ Already Implemented

**File**: `lib/src/core/locator.dart`

Both methods are already implemented (lines 145-157):
```dart
/// Returns the description string set via [describe()], or null.
String? description() {
  final match = RegExp(r'internal:describe=(.+)$').firstMatch(selector);
  if (match == null) return null;
  try {
    return jsonDecode(match.group(1)!) as String?;
  } catch (_) {
    return null;
  }
}

@override
String toString() => description() ?? 'Locator@$selector';
```

**Added**: v1.57  
**Implementation Effort**: Trivial  
**Impact**: Medium - Improves debugging and error messages

---

#### 2.6 Locator.filter({ visible? }) Option

**Status**: ✅ Already Implemented

**File**: `lib/src/core/locator.dart`

The `filter()` method already includes the `visible` option (line 90):
```dart
Locator filter({
  Pattern? hasText,
  Locator? has,
  Pattern? hasNotText,
  Locator? hasNot,
  bool? visible,
})
```

**Implementation Effort**: Low  
**Impact**: Medium - Useful for filtering by visibility

---

### Priority 3 — Lower Impact / Bug Fixes

#### 3.1 Request.redirectedTo — Always Returns null

**Status**: ✅ Already Implemented

**File**: `lib/src/network/request.dart`

The `redirectedTo` getter is already implemented (lines 92-95) and the back-reference is wired in the constructor (lines 139-144):
```dart
RequestImpl? _redirectedTo;

@override
Request? get redirectedTo => _redirectedTo;

// In constructor:
final from = typedInitializer.redirectedFrom;
if (from != null && from is RequestImpl) {
  from._redirectedTo = this;
}
```

**Implementation Effort**: Low  
**Impact**: Low - Bug fix for redirect chain tracking

---

#### 3.2 Response.fromServiceWorker — Type Mismatch

**Status**: ✅ Already Implemented

**File**: `lib/src/network/response.dart`

The `fromServiceWorker` getter is already implemented correctly (line 55):
```dart
@override
bool get fromServiceWorker => typedInitializer.fromServiceWorker;
```

It returns `bool` as expected by the protocol, not `Worker?`.

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

### ✅ All API-Level Gaps Completed

All previously identified API-level gaps have been addressed:

1. ✅ **LocatorAssertions (Priority 1.1)** - 13 missing assertions - Already implemented
2. ✅ **PageAssertions (Priority 1.2)** - Page-level assertions - Already implemented
3. ✅ **getByRole ARIA Filter Options (Priority 1.3)** - ARIA filters - Already implemented
4. ✅ **addLocatorHandler (Priority 1.4)** - Overlay/interstitial handling - Already implemented
5. ✅ **page.request property (Priority 2.1)** - API testing convenience - Already implemented
6. ✅ **page.clock property (Priority 2.2)** - Time-based testing - Already implemented
7. ✅ **page.routeWebSocket (Priority 2.3)** - WebSocket testing - Already implemented
8. ✅ **FrameLocator.owner() (Priority 2.4)** - Iframe manipulation - Already implemented
9. ✅ **Locator.description() + toString() (Priority 2.5)** - Debugging improvements - Already implemented
10. ✅ **Locator.filter({ visible? }) (Priority 2.6)** - Visibility filtering - Already implemented
11. ✅ **Request.redirectedTo fix (Priority 3.1)** - Redirect chain tracking - Already implemented
12. ✅ **Response.fromServiceWorker type fix (Priority 3.2)** - Protocol accuracy - Already implemented

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
- **June 17, 2026**: Verified that ALL API-level gaps have been addressed. All Priority 1, 2, and 3 tasks are already implemented. Updated Executive Summary and Implementation Priority Recommendations to reflect completion status.
