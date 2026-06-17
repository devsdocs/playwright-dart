# Playwright Dart — API Reference

> Auto-generated from `/// ` doc comments in `lib/src/`.
> Regenerate: `dart tool/generate_protocol_docs.dart`

## Contents

- [Core](#core)
  - [`Browser`](#browser)
  - [`BrowserContext`](#browsercontext)
  - [`BrowserType`](#browsertype)
  - [`ExpectReceived`](#expectreceived)
  - [`ExpectResult`](#expectresult)
  - [`Frame`](#frame)
  - [`FrameLocator`](#framelocator)
  - [`Locator`](#locator)
  - [`Page`](#page)
  - [`Playwright`](#playwright)
  - [`PlaywrightDart`](#playwrightdart)
  - [`Selectors`](#selectors)
- [Interaction](#interaction)
  - [`Dialog`](#dialog)
  - [`ElementHandle`](#elementhandle)
  - [`FileChooser`](#filechooser)
  - [`JSHandle`](#jshandle)
  - [`Keyboard`](#keyboard)
  - [`LocatorAssertions`](#locatorassertions)
  - [`Mouse`](#mouse)
  - [`PageAssertions`](#pageassertions)
  - [`Touchscreen`](#touchscreen)
- [Network](#network)
  - [`APIRequestContext`](#apirequestcontext)
  - [`Request`](#request)
  - [`Response`](#response)
  - [`Route`](#route)
  - [`RouteHandlerEntry`](#routehandlerentry)
  - [`RouteManager`](#routemanager)
  - [`RouteListener`](#routelistener)
  - [`SocksSupport`](#sockssupport)
  - [`PlaywrightWebSocket`](#playwrightwebsocket)
  - [`WebSocketRoute`](#websocketroute)
- [Platform](#platform)
  - [`Android`](#android)
  - [`AndroidDevice`](#androiddevice)
  - [`AndroidSocket`](#androidsocket)
  - [`Electron`](#electron)
  - [`ElectronApplication`](#electronapplication)
- [Utilities](#utilities)
  - [`Artifact`](#artifact)
  - [`CDPSession`](#cdpsession)
  - [`Clock`](#clock)
  - [`ConsoleMessage`](#consolemessage)
  - [`Download`](#download)
  - [`Logger`](#logger)
  - [`Tracing`](#tracing)
  - [`Video`](#video)
  - [`Worker`](#worker)
- [Debugging](#debugging)
  - [`BindingCall`](#bindingcall)
  - [`DebugController`](#debugcontroller)
  - [`Debugger`](#debugger)
  - [`Disposable`](#disposable)
  - [`EventTarget`](#eventtarget)
- [Infrastructure](#infrastructure)
  - [`ChannelOwner`](#channelowner)
  - [`RootChannelOwner`](#rootchannelowner)
  - [`Channel`](#channel)
  - [`Connection`](#connection)
  - [`Driver`](#driver)
  - [`EventEmitter`](#eventemitter)
  - [`FilePayload`](#filepayload)
  - [`JsonPipe`](#jsonpipe)
  - [`LocalUtils`](#localutils)
  - [`PlaywrightError`](#playwrighterror)
  - [`TimeoutError`](#timeouterror)
  - [`TargetClosedError`](#targetclosederror)
  - [`Root`](#root)
  - [`SelectOptionParams`](#selectoptionparams)
  - [`InputFilesParams`](#inputfilesparams)
  - [`PlaywrightStream`](#playwrightstream)
  - [`Transport`](#transport)
  - [`StdioTransport`](#stdiotransport)
  - [`JsonPipeTransport`](#jsonpipetransport)
  - [`Waiter`](#waiter)
  - [`WebSocketTransport`](#websockettransport)
  - [`WritableStream`](#writablestream)

---

# Core

## `Browser`

```dart
abstract interface class Browser
```

## `BrowserContext`

```dart
abstract interface class BrowserContext
```

### `browser`

*📦 Property*

The browser that this context belongs to.

```dart
Browser? get browser
```

### `tracing`

*📦 Property*

Tracing API for this context.

```dart
Tracing get tracing
```

### `request`

*📦 Property*

API request context for this context.

```dart
APIRequestContext get request
```

### `clock`

*📦 Property*

Clock API for this context.

```dart
Clock get clock
```

### `onRecorderEvent`

*📦 Property*

Stream that emits recorder events.

```dart
Stream<Map<String, dynamic>> get onRecorderEvent
```

### `onResponse`

*📦 Property*

Stream that emits when a response is received.

```dart
Stream<Map<String, dynamic>> get onResponse
```

### `onRequestFinished`

*📦 Property*

Stream that emits when a request finishes.

```dart
Stream<Map<String, dynamic>> get onRequestFinished
```

### `onRequestFailed`

*📦 Property*

Stream that emits when a request fails.

```dart
Stream<Map<String, dynamic>> get onRequestFailed
```

### `onRequest`

*📦 Property*

Stream that emits when a request is made.

```dart
Stream<Map<String, dynamic>> get onRequest
```

### `onServiceWorker`

*📦 Property*

Stream that emits when a service worker is created.

```dart
Stream<Worker> get onServiceWorker
```

### `onWebSocketRoute`

*📦 Property*

Stream that emits when a WebSocket route is created.

```dart
Stream<WebSocketRoute> get onWebSocketRoute
```

### `onRoute`

*📦 Property*

Stream that emits when a route is created.

```dart
Stream<Route> get onRoute
```

### `onPageError`

*📦 Property*

Stream that emits when a page error occurs.

```dart
Stream<Map<String, dynamic>> get onPageError
```

### `onPage`

*📦 Property*

Stream that emits when a new page is created.

```dart
Stream<Page> get onPage
```

### `onDialog`

*📦 Property*

Stream that emits when a dialog is shown.

```dart
Stream<Dialog> get onDialog
```

### `onClose`

*📦 Property*

Stream that emits when the context is closed.

```dart
Stream<BrowserContext> get onClose
```

### `onConsole`

*📦 Property*

Stream that emits when a console message is logged.

```dart
Stream<Map<String, dynamic>> get onConsole
```

### `onBindingCall`

*📦 Property*

Stream that emits when a binding call is made.

```dart
Stream<BindingCall> get onBindingCall
```

### `pages`

*📦 Property*

All pages in this context.

```dart
List<Page> get pages
```

### `newPage`

*⚙️ Method*

Creates a new page in this context.

```dart
Future<Page> newPage()
```

### `addCookies`

*⚙️ Method*

Adds cookies to this context.

```dart
Future<void> addCookies(List<SetNetworkCookie> cookies)
```

### `clearCookies`

*⚙️ Method*

Clears cookies from this context.

```dart
Future<void> clearCookies(
```

### `cookies`

*⚙️ Method*

Returns cookies from this context.

```dart
Future<List<NetworkCookie>> cookies(
```

### `grantPermissions`

*⚙️ Method*

Grants permissions to this context.

```dart
Future<void> grantPermissions(List<String> permissions,
```

### `setExtraHTTPHeaders`

*⚙️ Method*

Sets extra HTTP headers for this context.

```dart
Future<void> setExtraHTTPHeaders(List<NameValue> headers)
```

### `clearPermissions`

*⚙️ Method*

Clears all permission overrides for this context.

```dart
Future<void> clearPermissions()
```

### `setGeolocation`

*⚙️ Method*

Sets the geolocation for this context.

```dart
Future<void> setGeolocation( BrowserContextSetGeolocationGeolocation? geolocation, )
```

### `setHTTPCredentials`

*⚙️ Method*

Sets HTTP credentials for this context.

```dart
Future<void> setHTTPCredentials( BrowserContextSetHTTPCredentialsHttpCredentials? httpCredentials, )
```

### `setOffline`

*⚙️ Method*

Sets the offline mode for this context.

```dart
Future<void> setOffline(bool offline)
```

### `storageState`

*⚙️ Method*

Returns the storage state for this context.

```dart
Future<BrowserContextStorageStateResult> storageState(
```

### `setStorageState`

*⚙️ Method*

Sets the storage state for this context.

```dart
Future<void> setStorageState( BrowserContextSetStorageStateStorageState storageState, )
```

### `addInitScript`

*⚙️ Method*

Adds an initialization script to this context.

```dart
Future<void> addInitScript(String source)
```

### `isClosed`

*📦 Property*

Whether the context is closed.

```dart
bool get isClosed
```

### `backgroundPages`

*📦 Property*

Background pages in this context.

```dart
List<Page> get backgroundPages
```

### `serviceWorkers`

*📦 Property*

Service workers in this context.

```dart
List<Worker> get serviceWorkers
```

### `setDefaultTimeout`

*⚙️ Method*

Sets the default timeout for this context.

```dart
void setDefaultTimeout(double timeout)
```

### `setDefaultNavigationTimeout`

*⚙️ Method*

Sets the default navigation timeout for this context.

```dart
void setDefaultNavigationTimeout(double timeout)
```

### `close`

*⚙️ Method*

Closes this context.

```dart
Future<void> close(
```

### `setNetworkInterceptionPatterns`

*⚙️ Method*

Sets network interception patterns for this context.

```dart
Future<void> setNetworkInterceptionPatterns( List<BrowserContextSetNetworkInterceptionPatternsPatternsItems> patterns, )
```

### `pause`

*⚙️ Method*

Pauses the context for debugging.

```dart
Future<void> pause()
```

### `clockFastForward`

*⚙️ Method*

Fast forwards the clock.

```dart
Future<void> clockFastForward(
```

### `clockInstall`

*⚙️ Method*

Installs the clock.

```dart
Future<void> clockInstall(
```

### `clockPauseAt`

*⚙️ Method*

Pauses the clock at a specific time.

```dart
Future<void> clockPauseAt(
```

### `clockResume`

*⚙️ Method*

Resumes the clock.

```dart
Future<void> clockResume()
```

### `clockRunFor`

*⚙️ Method*

Runs the clock for a specific duration.

```dart
Future<void> clockRunFor(
```

### `clockSetFixedTime`

*⚙️ Method*

Sets a fixed time for the clock.

```dart
Future<void> clockSetFixedTime(
```

### `clockSetSystemTime`

*⚙️ Method*

Sets the system time for the clock.

```dart
Future<void> clockSetSystemTime(
```

### `exposeBinding`

*⚙️ Method*

Exposes a binding to the page.

```dart
Future<void> exposeBinding(String name)
```

### `exposeFunction`

*⚙️ Method*

Exposes a function to the page.

```dart
Future<void> exposeFunction(String name)
```

### `registerSelectorEngine`

*⚙️ Method*

Registers a custom selector engine.

```dart
Future<void> registerSelectorEngine( String name, String source,
```

### `setTestIdAttributeName`

*⚙️ Method*

Sets the test ID attribute name.

```dart
Future<void> setTestIdAttributeName(String testIdAttributeName)
```

### `setWebSocketInterceptionPatterns`

*⚙️ Method*

Sets WebSocket interception patterns.

```dart
Future<void> setWebSocketInterceptionPatterns( List<BrowserContextSetWebSocketInterceptionPatternsPatternsItems> patterns, )
```

### `enableRecorder`

*⚙️ Method*

Enables the recorder.

```dart
Future<void> enableRecorder(
```

### `disableRecorder`

*⚙️ Method*

Disables the recorder.

```dart
Future<void> disableRecorder()
```

### `exposeConsoleApi`

*⚙️ Method*

Exposes the console API to the page.

```dart
Future<void> exposeConsoleApi()
```

### `newCDPSession`

*⚙️ Method*

Creates a new Chrome DevTools Protocol session.

```dart
Future<CDPSession> newCDPSession(
```

### `createTempFiles`

*⚙️ Method*

Creates temporary files.

```dart
Future<BrowserContextCreateTempFilesResult> createTempFiles(
```

### `updateSubscription`

*⚙️ Method*

Updates the subscription for events.

```dart
Future<void> updateSubscription(
```

### `route`

*⚙️ Method*

Routes network requests matching the given URL.

```dart
Future<void> route(String url, Future<void> Function(Route) handler)
```

### `unroute`

*⚙️ Method*

Removes a route for the given URL.

```dart
Future<void> unroute( String url,
```

### `unrouteAll`

*⚙️ Method*

Removes all routes.

```dart
Future<void> unrouteAll()
```

### `routeFromHAR`

*⚙️ Method*

Routes network requests from a HAR file.

```dart
Future<void> routeFromHAR( String harPath,
```

## `BrowserType`

```dart
abstract interface class BrowserType
```

### `name`

*📦 Property*

The browser type name: `chromium`, `firefox`, or `webkit`.

```dart
String get name
```

### `executablePath`

*📦 Property*

A path where Playwright expects to find a bundled browser executable.

```dart
String get executablePath
```

### `launch`

*⚙️ Method*

Launches a new browser instance.

```dart
Future<Browser> launch(
```

### `launchPersistentContext`

*⚙️ Method*

Launches a persistent browser context with the given user data directory.

```dart
Future<BrowserContext> launchPersistentContext( String userDataDir,
```

### `connectToWorker`

*⚙️ Method*

Connects to an existing worker.

```dart
Future<Worker> connectToWorker(String endpoint,
```

### `connectOverCDP`

*⚙️ Method*

Connects to a browser over Chrome DevTools Protocol.

```dart
Future<Browser> connectOverCDP(
```

### `connect`

*⚙️ Method*

Connects to a browser over WebSocket.

```dart
Future<Browser> connect( String wsEndpoint,
```

## `ExpectReceived`

```dart
class ExpectReceived
```

## `ExpectResult`

```dart
class ExpectResult
```

## `Frame`

```dart
abstract interface class Frame
```

### `parentFrame`

*📦 Property*

The parent frame, if this is an iframe.

```dart
Frame? get parentFrame
```

### `childFrames`

*📦 Property*

Child frames of this frame.

```dart
List<Frame> get childFrames
```

### `name`

*📦 Property*

The frame name.

```dart
String get name
```

### `onNavigated`

*📦 Property*

Stream that emits when the frame navigates.

```dart
Stream<Map<String, dynamic>> get onNavigated
```

### `onLoadstate`

*📦 Property*

Stream that emits when the frame load state changes.

```dart
Stream<Map<String, dynamic>> get onLoadstate
```

### `url`

*⚙️ Method*

Returns the frame URL.

```dart
String url()
```

### `page`

*📦 Property*

The page this frame belongs to.

```dart
Page get page
```

### `frameLocator`

*⚙️ Method*

Creates a frame locator for the given selector.

```dart
FrameLocator frameLocator(String selector)
```

### `locator`

*⚙️ Method*

Creates a locator for the given selector.

```dart
Locator locator(String selector)
```

### `getByText`

*⚙️ Method*

Locates element by text content.

```dart
Locator getByText(Pattern text,
```

### `getByRole`

*⚙️ Method*

Locates element by ARIA role.

```dart
Locator getByRole( String role,
```

### `getByLabel`

*⚙️ Method*

Locates element by associated label.

```dart
Locator getByLabel(Pattern text,
```

### `getByPlaceholder`

*⚙️ Method*

Locates element by placeholder text.

```dart
Locator getByPlaceholder(Pattern text,
```

### `getByAltText`

*⚙️ Method*

Locates element by alt text.

```dart
Locator getByAltText(Pattern text,
```

### `getByTitle`

*⚙️ Method*

Locates element by title attribute.

```dart
Locator getByTitle(Pattern text,
```

### `getByTestId`

*⚙️ Method*

Locates element by test ID.

```dart
Locator getByTestId(String testId)
```

### `goto`

*⚙️ Method*

Navigates the frame to the given URL.

```dart
Future<void> goto( String url,
```

### `textContent`

*⚙️ Method*

Returns the text content of the element matching the selector.

```dart
Future<String> textContent(
```

### `evaluate`

*⚙️ Method*

Evaluates JavaScript in the frame.

```dart
Future<dynamic> evaluate(String expression, [dynamic arg])
```

### `waitForSelector`

*⚙️ Method*

Waits for the element matching the selector to satisfy the state.

```dart
Future<FrameWaitForSelectorResult> waitForSelector( String selector,
```

### `waitForLoadState`

*⚙️ Method*

Waits for the frame to reach the given load state.

```dart
Future<void> waitForLoadState(
```

### `waitForURL`

*⚙️ Method*

Waits for the frame to navigate to the given URL.

```dart
Future<void> waitForURL( dynamic urlOrPredicate,
```

### `waitForNavigation`

*⚙️ Method*

Waits for navigation to complete.

```dart
Future<void> waitForNavigation(
```

### `dragAndDrop`

*⚙️ Method*

Drags and drops an element from source to target.

```dart
Future<void> dragAndDrop( String source, String target,
```

### `click`

*⚙️ Method*

Clicks an element matching the selector.

```dart
Future<void> click( String selector,
```

### `fill`

*⚙️ Method*

Fills an element with the given value.

```dart
Future<void> fill( String selector, String value,
```

### `check`

*⚙️ Method*

Checks a checkbox or radio button.

```dart
Future<void> check( String selector,
```

### `uncheck`

*⚙️ Method*

Unchecks a checkbox.

```dart
Future<void> uncheck( String selector,
```

### `setChecked`

*⚙️ Method*

Sets the checked state of a checkbox or radio button.

```dart
Future<void> setChecked( String selector, bool checked,
```

### `hover`

*⚙️ Method*

Hovers over an element matching the selector.

```dart
Future<void> hover( String selector,
```

### `focus`

*⚙️ Method*

Focuses an element matching the selector.

```dart
Future<void> focus(String selector,
```

### `blur`

*⚙️ Method*

Removes focus from an element matching the selector.

```dart
Future<void> blur(String selector,
```

### `dblclick`

*⚙️ Method*

Double-clicks an element matching the selector.

```dart
Future<void> dblclick( String selector,
```

### `type`

*⚙️ Method*

Types text into an element matching the selector.

```dart
Future<void> type( String selector, String text,
```

### `press`

*⚙️ Method*

Presses a key while focused on an element matching the selector.

```dart
Future<void> press( String selector, String key,
```

### `tap`

*⚙️ Method*

Taps an element matching the selector.

```dart
Future<void> tap( String selector,
```

### `content`

*⚙️ Method*

Returns the HTML content of the frame.

```dart
Future<String> content()
```

### `setContent`

*⚙️ Method*

Sets the HTML content of the frame.

```dart
Future<void> setContent( String html,
```

### `evalOnSelector`

*⚙️ Method*

Evaluates JavaScript on the element matching the selector.

```dart
Future<dynamic> evalOnSelector( String selector, String expression, [ dynamic arg, bool? strict, bool? isFunction, ])
```

### `evalOnSelectorAll`

*⚙️ Method*

Evaluates JavaScript on all elements matching the selector.

```dart
Future<dynamic> evalOnSelectorAll( String selector, String expression, [ dynamic arg, bool? isFunction, ])
```

### `getAttribute`

*⚙️ Method*

Returns the attribute value of the element matching the selector.

```dart
Future<String?> getAttribute( String selector, String name,
```

### `innerHTML`

*⚙️ Method*

Returns the inner HTML of the element matching the selector.

```dart
Future<String> innerHTML(String selector,
```

### `innerText`

*⚙️ Method*

Returns the inner text of the element matching the selector.

```dart
Future<String> innerText(String selector,
```

### `inputValue`

*⚙️ Method*

Returns the input value of the element matching the selector.

```dart
Future<String> inputValue(String selector,
```

### `title`

*⚙️ Method*

Returns the frame title.

```dart
Future<String> title()
```

### `isChecked`

*⚙️ Method*

Returns whether the element matching the selector is checked.

```dart
Future<bool> isChecked(String selector,
```

### `isDisabled`

*⚙️ Method*

Returns whether the element matching the selector is disabled.

```dart
Future<bool> isDisabled(String selector,
```

### `isEnabled`

*⚙️ Method*

Returns whether the element matching the selector is enabled.

```dart
Future<bool> isEnabled(String selector,
```

### `isHidden`

*⚙️ Method*

Returns whether the element matching the selector is hidden.

```dart
Future<bool> isHidden(String selector,
```

### `isVisible`

*⚙️ Method*

Returns whether the element matching the selector is visible.

```dart
Future<bool> isVisible(String selector,
```

### `isEditable`

*⚙️ Method*

Returns whether the element matching the selector is editable.

```dart
Future<bool> isEditable(String selector,
```

### `addScriptTag`

*⚙️ Method*

Adds a script tag to the frame.

```dart
Future<void> addScriptTag(
```

### `addStyleTag`

*⚙️ Method*

Adds a style tag to the frame.

```dart
Future<void> addStyleTag(
```

### `waitForTimeout`

*⚙️ Method*

Waits for the given timeout.

```dart
Future<void> waitForTimeout(double waitTimeout)
```

### `waitForFunction`

*⚙️ Method*

Waits for the function to return a truthy value.

```dart
Future<JSHandle> waitForFunction( String expression,
```

### `dispatchEvent`

*⚙️ Method*

Dispatches an event on the element matching the selector.

```dart
Future<void> dispatchEvent( String selector, String type,
```

### `highlight`

*⚙️ Method*

Highlights the element matching the selector.

```dart
Future<void> highlight(String selector,
```

### `hideHighlight`

*⚙️ Method*

Hides the highlight on the element matching the selector.

```dart
Future<void> hideHighlight(String selector)
```

### `drop`

*⚙️ Method*

Drops files on the element matching the selector.

```dart
Future<void> drop( String selector,
```

## `FrameLocator`

```dart
class FrameLocator
```

### `owner`

*⚙️ Method*

Returns a [Locator] for the `<iframe>` element itself.

This is the reverse of [Locator.contentFrame].
Available since Playwright v1.43.

```dart
Locator owner()
```

### `locator`

*⚙️ Method*

Creates a locator for the given selector within this frame.

```dart
Locator locator(String selector)
```

### `frameLocator`

*⚙️ Method*

Creates a frame locator for the given selector within this frame.

```dart
FrameLocator frameLocator(String selector)
```

### `first`

*⚙️ Method*

Returns the first matching locator.

```dart
Locator first()
```

### `last`

*⚙️ Method*

Returns the last matching locator.

```dart
Locator last()
```

### `nth`

*⚙️ Method*

Returns the nth matching locator.

```dart
Locator nth(int index)
```

### `getByText`

*⚙️ Method*

Locates element by text content.

```dart
Locator getByText(Pattern text,
```

### `getByRole`

*⚙️ Method*

Locates element by ARIA role.

```dart
Locator getByRole( String role,
```

### `getByLabel`

*⚙️ Method*

Locates element by associated label.

```dart
Locator getByLabel(Pattern text,
```

### `getByPlaceholder`

*⚙️ Method*

Locates element by placeholder text.

```dart
Locator getByPlaceholder(Pattern text,
```

### `getByAltText`

*⚙️ Method*

Locates element by alt text.

```dart
Locator getByAltText(Pattern text,
```

### `getByTitle`

*⚙️ Method*

Locates element by title attribute.

```dart
Locator getByTitle(Pattern text,
```

### `getByTestId`

*⚙️ Method*

Locates element by test ID.

```dart
Locator getByTestId(String testId)
```

## `Locator`

```dart
class Locator
```

### `Locator()`

*🔨 Constructor*

Creates a new locator for the given [frame] and [selector].

```dart
Locator(this.frame, this.selector)
```

### `first`

*⚙️ Method*

Returns the first matching locator.

```dart
Locator first()
```

### `last`

*⚙️ Method*

Returns the last matching locator.

```dart
Locator last()
```

### `nth`

*⚙️ Method*

Returns the nth matching locator.

```dart
Locator nth(int index)
```

### `and`

*⚙️ Method*

Creates a locator that matches both this locator and the given [other] locator.

```dart
Locator and(Locator other)
```

### `or`

*⚙️ Method*

Creates a locator that matches either this locator or the given [other] locator.

```dart
Locator or(Locator other)
```

### `filter`

*⚙️ Method*

Creates a locator that filters this locator by the given criteria.

```dart
Locator filter(
```

### `contentFrame`

*📦 Property*

Returns a frame locator for the content frame of this locator.

```dart
FrameLocator get contentFrame
```

### `frameLocator`

*⚙️ Method*

Creates a frame locator for the given selector within this locator.

```dart
FrameLocator frameLocator(String selectorOrLocator)
```

### `page`

*📦 Property*

Returns the page this locator belongs to.

```dart
Page get page
```

### `describe`

*⚙️ Method*

Creates a locator with a description for debugging.

```dart
Locator describe(String description)
```

### `description`

*⚙️ Method*

Returns the description string set via [describe], or `null` if none.

Available since Playwright v1.57.

```dart
String? description()
```

## `Page`

```dart
abstract interface class Page
```

### `frames`

*📦 Property*

All frames in this page.

```dart
List<Frame> get frames
```

### `workers`

*📦 Property*

All workers in this page.

```dart
List<Worker> get workers
```

### `onWebSocketRoute`

*📦 Property*

Stream that emits when a WebSocket route is created.

```dart
Stream<WebSocketRoute> get onWebSocketRoute
```

### `onScreencastFrame`

*📦 Property*

Stream that emits when a screencast frame is available.

```dart
Stream<Map<String, dynamic>> get onScreencastFrame
```

### `onRoute`

*📦 Property*

Stream that emits when a route is created.

```dart
Stream<Route> get onRoute
```

### `onLocatorHandlerTriggered`

*📦 Property*

Stream that emits when a locator handler is triggered.

```dart
Stream<dynamic> get onLocatorHandlerTriggered
```

### `onFrameDetached`

*📦 Property*

Stream that emits when a frame is detached.

```dart
Stream<Frame> get onFrameDetached
```

### `onFrameAttached`

*📦 Property*

Stream that emits when a frame is attached.

```dart
Stream<Frame> get onFrameAttached
```

### `onViewportSizeChanged`

*📦 Property*

Stream that emits when the viewport size changes.

```dart
Stream<Map<String, dynamic>> get onViewportSizeChanged
```

### `onBindingCall`

*📦 Property*

Stream that emits when a binding call is made.

```dart
Stream<BindingCall> get onBindingCall
```

### `keyboard`

*📦 Property*

Keyboard input for this page.

```dart
Keyboard get keyboard
```

### `mouse`

*📦 Property*

Mouse input for this page.

```dart
Mouse get mouse
```

### `touchscreen`

*📦 Property*

Touchscreen input for this page.

```dart
Touchscreen get touchscreen
```

### `context`

*📦 Property*

The browser context this page belongs to.

```dart
BrowserContext get context
```

### `request`

*📦 Property*

Shortcut for `context.request`. API request context for this page.
Available since Playwright v1.16.

```dart
APIRequestContext get request
```

### `clock`

*📦 Property*

Shortcut for `context.clock`. Clock API for this page.
Available since Playwright v1.45.

```dart
Clock get clock
```

### `mainFrame`

*📦 Property*

The main frame of the page.

```dart
Frame get mainFrame
```

### `onConsole`

*📦 Property*

Stream that emits when a console message is logged.

```dart
Stream<ConsoleMessage> get onConsole
```

### `onFileChooser`

*📦 Property*

Stream that emits when a file chooser is shown.

```dart
Stream<FileChooser> get onFileChooser
```

### `onDialog`

*📦 Property*

Stream that emits when a dialog is shown.

```dart
Stream<Dialog> get onDialog
```

### `onRequest`

*📦 Property*

Stream that emits when a request is made.

```dart
Stream<Request> get onRequest
```

### `onResponse`

*📦 Property*

Stream that emits when a response is received.

```dart
Stream<Response> get onResponse
```

### `onRequestFinished`

*📦 Property*

Stream that emits when a request finishes.

```dart
Stream<Request> get onRequestFinished
```

### `onRequestFailed`

*📦 Property*

Stream that emits when a request fails.

```dart
Stream<Request> get onRequestFailed
```

### `onWebSocket`

*📦 Property*

Stream that emits when a WebSocket is created.

```dart
Stream<WebSocket> get onWebSocket
```

### `onClose`

*📦 Property*

Stream that emits when the page closes.

```dart
Stream<Page> get onClose
```

### `onCrash`

*📦 Property*

Stream that emits when the page crashes.

```dart
Stream<Page> get onCrash
```

### `onPageError`

*📦 Property*

Stream that emits when a page error occurs.

```dart
Stream<Exception> get onPageError
```

### `video`

*⚙️ Method*

Video recording for this page.

```dart
Video? video()
```

### `onPopup`

*📦 Property*

Stream that emits when a popup page is created.

```dart
Stream<Page> get onPopup
```

### `onWorker`

*📦 Property*

Stream that emits when a worker is created.

```dart
Stream<Worker> get onWorker
```

### `waitForRequest`

*⚙️ Method*

Waits for a request matching the predicate.

```dart
Future<Request> waitForRequest(dynamic urlOrPredicate,
```

### `waitForResponse`

*⚙️ Method*

Waits for a response matching the predicate.

```dart
Future<Response> waitForResponse(dynamic urlOrPredicate,
```

### `isClosed`

*📦 Property*

Whether the page is closed.

```dart
bool get isClosed
```

### `url`

*⚙️ Method*

Returns the page URL.

```dart
String url()
```

### `viewportSize`

*📦 Property*

The viewport size of the page.

```dart
PageSetViewportSizeViewportSize? get viewportSize
```

### `setDefaultTimeout`

*⚙️ Method*

Sets the default timeout for this page.

```dart
void setDefaultTimeout(double timeout)
```

### `setDefaultNavigationTimeout`

*⚙️ Method*

Sets the default navigation timeout for this page.

```dart
void setDefaultNavigationTimeout(double timeout)
```

### `onDownload`

*📦 Property*

Stream that emits when a download starts.

```dart
Stream<Download> get onDownload
```

### `goto`

*⚙️ Method*

Navigates the page to the given URL.

```dart
Future<void> goto( String url,
```

### `waitForLoadState`

*⚙️ Method*

Waits for the page to reach the given load state.

```dart
Future<void> waitForLoadState(
```

### `waitForURL`

*⚙️ Method*

Waits for the page to navigate to the given URL.

```dart
Future<void> waitForURL( dynamic urlOrPredicate,
```

### `waitForNavigation`

*⚙️ Method*

Waits for navigation to complete.

```dart
Future<void> waitForNavigation(
```

### `title`

*⚙️ Method*

Returns the page title.

```dart
Future<String> title()
```

### `locator`

*⚙️ Method*

Creates a locator for the given selector.

```dart
Locator locator(String selector)
```

### `frameLocator`

*⚙️ Method*

Creates a frame locator for the given selector.

```dart
FrameLocator frameLocator(String selector)
```

### `evaluate`

*⚙️ Method*

Evaluates JavaScript in the page.

```dart
Future<dynamic> evaluate(String expression, [dynamic arg])
```

### `waitForSelector`

*⚙️ Method*

Waits for the element matching the selector to satisfy the state.

```dart
Future<FrameWaitForSelectorResult> waitForSelector( String selector,
```

### `routeFromHAR`

*⚙️ Method*

Routes network requests from a HAR file.

```dart
Future<void> routeFromHAR( String harPath,
```

### `route`

*⚙️ Method*

Routes network requests matching the given URL.

```dart
Future<void> route(String url, Future<void> Function(Route) handler)
```

### `unroute`

*⚙️ Method*

Removes a route for the given URL.

```dart
Future<void> unroute( String url,
```

### `unrouteAll`

*⚙️ Method*

Removes all routes.

```dart
Future<void> unrouteAll()
```

### `frame`

*⚙️ Method*

Returns a frame by name or URL.

```dart
Frame? frame(
```

### `getByText`

*⚙️ Method*

Locates element by text content.

```dart
Locator getByText(Pattern text,
```

### `getByRole`

*⚙️ Method*

Locates element by ARIA role.

```dart
Locator getByRole( String role,
```

### `getByLabel`

*⚙️ Method*

Locates element by associated label.

```dart
Locator getByLabel(Pattern text,
```

### `getByPlaceholder`

*⚙️ Method*

Locates element by placeholder text.

```dart
Locator getByPlaceholder(Pattern text,
```

### `getByAltText`

*⚙️ Method*

Locates element by alt text.

```dart
Locator getByAltText(Pattern text,
```

### `getByTitle`

*⚙️ Method*

Locates element by title attribute.

```dart
Locator getByTitle(Pattern text,
```

### `getByTestId`

*⚙️ Method*

Locates element by test ID.

```dart
Locator getByTestId(String testId)
```

### `pageExpect`

*⚙️ Method*

Returns web-first page-level assertions for this page.

Usage:
```dart
await page.pageExpect().toHaveTitle('My Title');
await page.pageExpect().not.toHaveURL('/login');
```

```dart
PageAssertions pageExpect(
```

### `setViewportSize`

*⚙️ Method*

Sets the viewport size of the page.

```dart
Future<void> setViewportSize(PageSetViewportSizeViewportSize viewportSize)
```

### `screenshot`

*⚙️ Method*

Takes a screenshot of the page.

```dart
Future<Uint8List> screenshot(
```

### `pdf`

*⚙️ Method*

Generates a PDF of the page.

```dart
Future<Uint8List> pdf(
```

### `reload`

*⚙️ Method*

Reloads the page.

```dart
Future<void> reload(
```

### `goBack`

*⚙️ Method*

Navigates back in the page history.

```dart
Future<void> goBack(
```

### `goForward`

*⚙️ Method*

Navigates forward in the page history.

```dart
Future<void> goForward(
```

### `addInitScript`

*⚙️ Method*

Adds an initialization script to the page.

```dart
Future<void> addInitScript(String source)
```

### `close`

*⚙️ Method*

Closes the page.

```dart
Future<void> close(
```

### `emulateMedia`

*⚙️ Method*

Emulates media features for the page.

```dart
Future<void> emulateMedia(
```

### `click`

*⚙️ Method*

Clicks an element matching the selector.

```dart
Future<void> click(String selector,
```

### `fill`

*⚙️ Method*

Fills an element with the given value.

```dart
Future<void> fill( String selector, String value,
```

### `check`

*⚙️ Method*

Checks a checkbox or radio button.

```dart
Future<void> check(String selector,
```

### `uncheck`

*⚙️ Method*

Unchecks a checkbox.

```dart
Future<void> uncheck(String selector,
```

### `setChecked`

*⚙️ Method*

Sets the checked state of a checkbox or radio button.

```dart
Future<void> setChecked( String selector, bool checked,
```

### `hover`

*⚙️ Method*

Hovers over an element matching the selector.

```dart
Future<void> hover(String selector,
```

### `focus`

*⚙️ Method*

Focuses an element matching the selector.

```dart
Future<void> focus(String selector,
```

### `blur`

*⚙️ Method*

Removes focus from an element matching the selector.

```dart
Future<void> blur(String selector,
```

### `dblclick`

*⚙️ Method*

Double-clicks an element matching the selector.

```dart
Future<void> dblclick(String selector,
```

### `type`

*⚙️ Method*

Types text into an element matching the selector.

```dart
Future<void> type( String selector, String text,
```

### `press`

*⚙️ Method*

Presses a key while focused on an element matching the selector.

```dart
Future<void> press( String selector, String key,
```

### `tap`

*⚙️ Method*

Taps an element matching the selector.

```dart
Future<void> tap(String selector,
```

### `content`

*⚙️ Method*

Returns the HTML content of the page.

```dart
Future<String> content()
```

### `setContent`

*⚙️ Method*

Sets the HTML content of the page.

```dart
Future<void> setContent(String html,
```

### `evalOnSelector`

*⚙️ Method*

Evaluates JavaScript on the element matching the selector.

```dart
Future<dynamic> evalOnSelector( String selector, String expression, [ dynamic arg, ])
```

### `evalOnSelectorAll`

*⚙️ Method*

Evaluates JavaScript on all elements matching the selector.

```dart
Future<dynamic> evalOnSelectorAll( String selector, String expression, [ dynamic arg, ])
```

### `getAttribute`

*⚙️ Method*

Returns the attribute value of the element matching the selector.

```dart
Future<String?> getAttribute(String selector, String name,
```

### `innerHTML`

*⚙️ Method*

Returns the inner HTML of the element matching the selector.

```dart
Future<String> innerHTML(String selector,
```

### `innerText`

*⚙️ Method*

Returns the inner text of the element matching the selector.

```dart
Future<String> innerText(String selector,
```

### `inputValue`

*⚙️ Method*

Returns the input value of the element matching the selector.

```dart
Future<String> inputValue(String selector,
```

### `isChecked`

*⚙️ Method*

Returns whether the element matching the selector is checked.

```dart
Future<bool> isChecked(String selector,
```

### `isDisabled`

*⚙️ Method*

Returns whether the element matching the selector is disabled.

```dart
Future<bool> isDisabled(String selector,
```

### `isEnabled`

*⚙️ Method*

Returns whether the element matching the selector is enabled.

```dart
Future<bool> isEnabled(String selector,
```

### `isHidden`

*⚙️ Method*

Returns whether the element matching the selector is hidden.

```dart
Future<bool> isHidden(String selector)
```

### `isVisible`

*⚙️ Method*

Returns whether the element matching the selector is visible.

```dart
Future<bool> isVisible(String selector)
```

### `isEditable`

*⚙️ Method*

Returns whether the element matching the selector is editable.

```dart
Future<bool> isEditable(String selector,
```

### `addScriptTag`

*⚙️ Method*

Adds a script tag to the page.

```dart
Future<void> addScriptTag(
```

### `addStyleTag`

*⚙️ Method*

Adds a style tag to the page.

```dart
Future<void> addStyleTag(
```

### `waitForTimeout`

*⚙️ Method*

Waits for the given timeout.

```dart
Future<void> waitForTimeout(double timeout)
```

### `waitForFunction`

*⚙️ Method*

Waits for the function to return a truthy value.

```dart
Future<JSHandle> waitForFunction( String expression, [ dynamic arg, double? timeout, double? pollingInterval, ])
```

### `dispatchEvent`

*⚙️ Method*

Dispatches an event on the element matching the selector.

```dart
Future<void> dispatchEvent( String selector, String type,
```

### `highlight`

*⚙️ Method*

Highlights the element matching the selector.

```dart
Future<void> highlight(String selector)
```

### `hideHighlight`

*⚙️ Method*

Hides the highlight.

```dart
Future<void> hideHighlight()
```

### `drop`

*⚙️ Method*

Drops files on the element matching the selector.

```dart
Future<void> drop( String selector,
```

### `querySelector`

*⚙️ Method*

Queries for the first element matching the selector.

```dart
Locator querySelector(String selector)
```

### `querySelectorAll`

*⚙️ Method*

Queries for all elements matching the selector.

```dart
Future<List<Locator>> querySelectorAll(String selector)
```

### `queryCount`

*⚙️ Method*

Returns the count of elements matching the selector.

```dart
Future<int> queryCount(String selector)
```

### `selectOption`

*⚙️ Method*

Selects options in a select element.

```dart
Future<List<String>> selectOption( String selector, dynamic values,
```

### `setInputFiles`

*⚙️ Method*

Sets input files for a file input element.

```dart
Future<void> setInputFiles( String selector, dynamic files,
```

### `ariaSnapshot`

*⚙️ Method*

Returns an ARIA snapshot of the element matching the selector.

```dart
Future<FrameAriaSnapshotResult> ariaSnapshot( String selector,
```

### `expect`

*⚙️ Method*

Performs an assertion on the element matching the selector.

```dart
Future<ExpectResult> expect( String selector, String expression,
```

### `exposeBinding`

*⚙️ Method*

Exposes a binding to the page.

```dart
Future<void> exposeBinding(String name)
```

### `exposeFunction`

*⚙️ Method*

Exposes a function to the page.

```dart
Future<void> exposeFunction(String name)
```

### `opener`

*⚙️ Method*

Returns the page that opened this page.

```dart
Page? opener()
```

### `requestGC`

*⚙️ Method*

Requests garbage collection.

```dart
Future<void> requestGC()
```

### `registerLocatorHandler`

*⚙️ Method*

Registers a locator handler.

```dart
Future<PageRegisterLocatorHandlerResult> registerLocatorHandler( Locator selector,
```

### `unregisterLocatorHandler`

*⚙️ Method*

Unregisters a locator handler.

```dart
Future<void> unregisterLocatorHandler(int uid)
```

### `addLocatorHandler`

*⚙️ Method*

Registers a handler that will be called every time the given locator
appears in the page (e.g., a cookie banner).

The [handler] is called with the matching [Locator]. After the handler
returns, Playwright automatically retries the action that triggered it.

Optional [noWaitAfter] (default `false`) — skips the post-handler
stability wait. Use [times] to limit how many times the handler fires
(omit or pass `null` for unlimited).

Available since Playwright v1.42.

```dart
Future<void> addLocatorHandler( Locator locator, Future<void> Function(Locator) handler,
```

### `removeLocatorHandler`

*⚙️ Method*

Removes all handlers registered for [locator] via [addLocatorHandler].

Available since Playwright v1.44.

```dart
Future<void> removeLocatorHandler(Locator locator)
```

### `setExtraHTTPHeaders`

*⚙️ Method*

Sets extra HTTP headers for the page.

```dart
Future<void> setExtraHTTPHeaders(List<NameValue> headers)
```

### `setNetworkInterceptionPatterns`

*⚙️ Method*

Sets network interception patterns for the page.

```dart
Future<void> setNetworkInterceptionPatterns( List<PageSetNetworkInterceptionPatternsPatternsItems> patterns, )
```

### `routeWebSocket`

*⚙️ Method*

Routes WebSocket connections matching the given URL pattern.

[url] can be a string (glob pattern) or a RegExp.
The [handler] is called with the WebSocketRoute when a matching WebSocket is created.

Available since Playwright v1.48.

```dart
Future<void> routeWebSocket( Pattern url, Future<void> Function(WebSocketRoute) handler, )
```

### `touchscreenTap`

*⚙️ Method*

Taps the touchscreen at the given coordinates.

```dart
Future<void> touchscreenTap(double x, double y)
```

### `bringToFront`

*⚙️ Method*

Brings the page to the front.

```dart
Future<void> bringToFront()
```

### `pickLocator`

*⚙️ Method*

Picks a locator from the page.

```dart
Future<PagePickLocatorResult> pickLocator()
```

### `cancelPickLocator`

*⚙️ Method*

Cancels the locator picking.

```dart
Future<void> cancelPickLocator()
```

### `screencastStart`

*⚙️ Method*

Starts screencasting the page.

```dart
Future<void> screencastStart(
```

### `screencastStop`

*⚙️ Method*

Stops screencasting the page.

```dart
Future<void> screencastStop()
```

### `setDockTile`

*⚙️ Method*

Sets the dock tile image.

```dart
Future<void> setDockTile(String image)
```

### `clearConsoleMessages`

*⚙️ Method*

Clears console messages.

```dart
Future<void> clearConsoleMessages()
```

### `consoleMessages`

*⚙️ Method*

Returns console messages.

```dart
Future<PageConsoleMessagesResult> consoleMessages(
```

## `Playwright`

```dart
abstract interface class Playwright
```

### `chromium`

*📦 Property*

Provides access to the Chromium browser type.

```dart
BrowserType get chromium
```

### `firefox`

*📦 Property*

Provides access to the Firefox browser type.

```dart
BrowserType get firefox
```

### `webkit`

*📦 Property*

Provides access to the WebKit browser type.

```dart
BrowserType get webkit
```

### `android`

*📦 Property*

Android automation API.

```dart
Android get android
```

### `electron`

*📦 Property*

Electron automation API.

```dart
Electron get electron
```

### `devices`

*📦 Property*

Predefined device descriptors.

```dart
Map<String, Map<String, dynamic>> get devices
```

### `selectors`

*📦 Property*

Custom selectors API.

```dart
Selectors get selectors
```

### `newRequest`

*⚙️ Method*

Creates a new API request context.

```dart
Future<APIRequestContext> newRequest(
```

### `stop`

*⚙️ Method*

Stops the Playwright driver and closes the connection.

```dart
Future<void> stop()
```

## `PlaywrightDart`

```dart
class PlaywrightDart
```

### `create`

*⚙️ Method*

Launches the background Playwright driver and connects to it, returning the
root [Playwright] API instance.

[autoClose] — when `true` (default), the driver process shuts down
automatically when the last browser is closed.

[logLevel] — controls how verbose the logger is. Defaults to
[LogLevel.info] which prints startup/shutdown milestones. Use
[LogLevel.debug] to see navigation and action calls, [LogLevel.trace]
for raw protocol messages, or [LogLevel.none] to silence everything.

```dart
static Future<Playwright> create(
```

## `Selectors`

Selectors can be used to install custom selector engines.

```dart
class Selectors
```

### `register`

*⚙️ Method*

Registers a custom selector engine.

```dart
Future<void> register( String name, String script,
```

### `setTestIdAttribute`

*⚙️ Method*

Sets the test-id attribute name globally.

This persists the name so that any future [BrowserContext] created via
[Browser.newContext] automatically inherits it through [addContext].
Existing contexts are updated immediately.

```dart
Future<void> setTestIdAttribute(String name) async
```

### `addContext`

*⚙️ Method*

Internal method called by [Browser.newContext] when a new [BrowserContext]
is created.

Applies any pending testId attribute name and registered selector engines
to the freshly-created context **before** it is returned to the caller,
so that every operation on the new context already uses the correct
configuration.

```dart
Future<void> addContext(BrowserContext context) async
```

---

# Interaction

## `Dialog`

```dart
abstract interface class Dialog
```

## `ElementHandle`

A handle to a DOM element in the browser page.

The optional type parameter [T] mirrors the TypeScript SDK's
`ElementHandle<T extends Node = Node>` generic, where [Node] is
`package:html`'s DOM [Node] class.  It carries type information about
the underlying DOM element kind without impacting runtime behaviour.

[ElementHandle] extends [JSHandle] because every DOM element is also a
JavaScript value — the same relationship as in the TypeScript SDK where
`ElementHandle<T extends Node> extends JSHandle<T>`.

```dart
import 'package:html/dom.dart' show Element;

// Default: any DOM node
final ElementHandle<Node> handle = await page.querySelector('div');

// Narrowed to Element (any HTML element):
final ElementHandle<Element> el = handle as ElementHandle<Element>;
await el.click();
```

```dart
abstract interface class ElementHandle<T extends Node> implements JSHandle<T>
```

## `FileChooser`

`FileChooser` objects are dispatched by the page in the `page.onFileChooser` event.

```dart
class FileChooser
```

### `setFiles`

*⚙️ Method*

Sets the value of the file input this chooser is associated with. If some of the `filePaths` are relative paths,
then they are resolved relative to the current working directory.

```dart
Future<void> setFiles(List<String> files,
```

## `JSHandle`

A handle to a JavaScript value in the browser page.

The optional type parameter [T] mirrors the TypeScript SDK's
`JSHandle<T = any>` generic.  It acts as a phantom type that carries
information about the underlying JS value without impacting runtime
behaviour.

When [T] is [Node] or a subtype (e.g. [Element]) the handle wraps a DOM
node, and [asElement] will return a non-null [ElementHandle].

```dart
// Untyped handle (equivalent to JSHandle<any>):
final handle = await page.evaluateHandle('() => window');

// Typed as an Element handle:
final JSHandle<Element> el =
await frame.evaluateHandle('() => document.body');
final element = el.asElement(); // non-null because T <: Node
```

```dart
abstract interface class JSHandle<T extends Object?>
```

### `asElement`

*⚙️ Method*

Returns `null` unless the underlying JavaScript value is a DOM [Node],
in which case it returns this handle narrowed to [ElementHandle].

Mirrors the TypeScript signature:
`asElement(): T extends Node ? ElementHandle<T> : null`

```dart
ElementHandle<Node>? asElement()
```

## `Keyboard`

```dart
class Keyboard
```

## `LocatorAssertions`

```dart
class LocatorAssertions
```

## `Mouse`

```dart
class Mouse
```

## `PageAssertions`

Web-first assertions for a [Page].

Obtain via [Page.pageExpect]:
```dart
await page.pageExpect().toHaveTitle('My Page');
await page.pageExpect().toHaveURL('https://example.com/login');
```

```dart
class PageAssertions
```

### `toHaveTitle`

*⚙️ Method*

Checks that the page has the expected title.

[expected] can be a [String] (exact/substring match) or a [RegExp].

```dart
Future<void> toHaveTitle(Pattern expected,
```

### `toHaveURL`

*⚙️ Method*

Checks that the page has the expected URL.

[expected] can be a [String] (substring/glob) or a [RegExp].

```dart
Future<void> toHaveURL(Pattern expected,
```

## `Touchscreen`

```dart
class Touchscreen
```

---

# Network

## `APIRequestContext`

Interface for APIRequestContext

```dart
abstract interface class APIRequestContext
```

## `Request`

```dart
abstract interface class Request
```

## `Response`

```dart
abstract interface class Response
```

## `Route`

```dart
abstract interface class Route
```

## `RouteHandlerEntry`

```dart
class RouteHandlerEntry
```

## `RouteManager`

Tracks route handlers and dispatches incoming routes to matching handlers.

```dart
class RouteManager
```

## `RouteListener`

Attaches a single route-event listener and forwards events to [manager].

```dart
class RouteListener
```

## `SocksSupport`

Interface for SocksSupport

```dart
abstract interface class SocksSupport
```

## `PlaywrightWebSocket`

```dart
abstract interface class PlaywrightWebSocket
```

## `WebSocketRoute`

Interface for WebSocketRoute

```dart
abstract interface class WebSocketRoute
```

---

# Platform

## `Android`

Interface for Android

```dart
abstract interface class Android
```

## `AndroidDevice`

Interface for AndroidDevice

```dart
abstract interface class AndroidDevice
```

## `AndroidSocket`

Interface for AndroidSocket

```dart
abstract interface class AndroidSocket
```

## `Electron`

Interface for Electron

```dart
abstract interface class Electron
```

## `ElectronApplication`

Interface for ElectronApplication

```dart
abstract interface class ElectronApplication
```

---

# Utilities

## `Artifact`

Interface for Artifact

```dart
abstract interface class Artifact
```

## `CDPSession`

Interface for CDPSession

```dart
abstract interface class CDPSession
```

## `Clock`

Clock API for mocking time in browser contexts.

```dart
abstract interface class Clock
```

## `ConsoleMessage`

`ConsoleMessage` objects are dispatched by page via the `page.onConsole` event.

```dart
class ConsoleMessage
```

## `Download`

Represents a download triggered by the page.

```dart
class Download
```

## `Logger`

Central logger for Playwright Dart.

The active level is set via [Logger.level] (defaults to [LogLevel.info]).
Use [PlaywrightDart.create] to pass a [LogLevel] at startup.

```dart
class Logger
```

### `trace`

*⚙️ Method*

Low-level protocol trace — only emitted at [LogLevel.trace].

```dart
static void trace(String message,
```

### `debug`

*⚙️ Method*

Debug message — emitted at [LogLevel.debug] and below.

```dart
static void debug(String message,
```

### `info`

*⚙️ Method*

Informational milestone — emitted at [LogLevel.info] and below.

```dart
static void info(String message)
```

### `warn`

*⚙️ Method*

Warning — always emitted unless level is [LogLevel.none].

```dart
static void warn(String message)
```

### `error`

*⚙️ Method*

Error — always emitted unless level is [LogLevel.none].

```dart
static void error(String message, [Object? error, StackTrace? stackTrace])
```

## `Tracing`

Interface for Tracing

```dart
abstract interface class Tracing
```

## `Video`

Video objects are returned by `page.video`.

```dart
class Video
```

### `path`

*⚙️ Method*

Returns the file system path where the video will be recorded.

```dart
Future<String> path() async
```

### `saveAs`

*⚙️ Method*

Saves the video to the specified file path.

```dart
Future<void> saveAs(String path) async
```

### `delete`

*⚙️ Method*

Deletes the video file.

```dart
Future<void> delete() async
```

## `Worker`

```dart
abstract interface class Worker
```

---

# Debugging

## `BindingCall`

Interface for BindingCall

```dart
abstract interface class BindingCall
```

## `DebugController`

Interface for DebugController

```dart
abstract interface class DebugController
```

## `Debugger`

Interface for Debugger

```dart
abstract interface class Debugger
```

## `Disposable`

Interface for Disposable

```dart
abstract interface class Disposable
```

## `EventTarget`

Interface for EventTarget.

NOTE: The `EventTarget` protocol channel was removed in Playwright v1.61+.
The class is retained as a stub so that the object factory in [Connection]
can still handle any legacy `__create__` messages without crashing.

```dart
abstract interface class EventTarget
```

---

# Infrastructure

## `ChannelOwner`

```dart
abstract class ChannelOwner
```

## `RootChannelOwner`

```dart
class RootChannelOwner extends ChannelOwner
```

## `Channel`

```dart
abstract class Channel
```

## `Connection`

```dart
class Connection
```

## `Driver`

```dart
class Driver
```

## `EventEmitter`

A typed event emitter that mirrors the Playwright Node.js [EventEmitter] API.

Unlike Dart's built-in [Stream] / [StreamController], this class provides
the familiar `on` / `off` / `once` / `emit` surface that matches the
JavaScript Playwright client, while mapping each named event to a
[StreamController.broadcast] under the hood.

## Usage

```dart
final emitter = EventEmitter();

void handler(dynamic args) => print('got: $args');
emitter.on('data', handler);
emitter.emit('data', 'hello');   // prints "got: hello"
emitter.off('data', handler);
```

```dart
class EventEmitter
```

### `on`

*⚙️ Method*

Adds a persistent [handler] for [event].

```dart
void on(String event, void Function(dynamic) handler)
```

### `addListener`

*⚙️ Method*

Alias for [on].

```dart
void addListener(String event, void Function(dynamic) handler)
```

### `off`

*⚙️ Method*

Removes a previously registered [handler] for [event].

```dart
void off(String event, void Function(dynamic) handler)
```

### `removeListener`

*⚙️ Method*

Alias for [off].

```dart
void removeListener(String event, void Function(dynamic) handler)
```

### `once`

*⚙️ Method*

Adds a [handler] that fires only **once** for [event] and then
automatically removes itself.

```dart
void once(String event, void Function(dynamic) handler)
```

### `removeAllListeners`

*⚙️ Method*

Removes all listeners for [event], or all listeners when [event] is null.

```dart
void removeAllListeners([String? event])
```

### `emit`

*⚙️ Method*

Emits [event] synchronously, calling all registered listeners with [args].

Returns `true` if any listeners were registered for this event.

```dart
bool emit(String event, [dynamic args])
```

### `stream`

*⚙️ Method*

Returns a [Stream] that emits values whenever [event] is fired via
[emit].  Each call returns a new broadcast stream backed by a controller
added to [event]'s listener list.

```dart
Stream<dynamic> stream(String event)
```

## `FilePayload`

```dart
class FilePayload
```

## `JsonPipe`

Interface for JsonPipe

```dart
abstract interface class JsonPipe
```

## `LocalUtils`

Interface for LocalUtils

```dart
abstract interface class LocalUtils
```

## `PlaywrightError`

Base class for all Playwright errors.

```dart
class PlaywrightError implements Exception
```

## `TimeoutError`

Thrown when an action exceeds its configured timeout.

```dart
class TimeoutError extends PlaywrightError
```

## `TargetClosedError`

Thrown when the target page, context or browser has been closed.

```dart
class TargetClosedError extends PlaywrightError
```

### `isTargetClosedError`

*⚙️ Method*

Returns `true` when [error] is a [TargetClosedError].

```dart
bool isTargetClosedError(Object error)
```

### `isTimeoutError`

*⚙️ Method*

Returns `true` when [error] is a [TimeoutError].

```dart
bool isTimeoutError(Object error)
```

### `parseServerError`

*⚙️ Method*

Parses an error message string from the server and returns the appropriate
typed [PlaywrightError] subclass.

```dart
PlaywrightError parseServerError(String message)
```

## `Root`

Interface for Root

```dart
abstract interface class Root
```

## `SelectOptionParams`

```dart
class SelectOptionParams
```

## `InputFilesParams`

```dart
class InputFilesParams
```

## `PlaywrightStream`

Interface for PlaywrightStream

```dart
abstract interface class PlaywrightStream
```

## `Transport`

```dart
abstract class Transport
```

## `StdioTransport`

```dart
class StdioTransport implements Transport
```

## `JsonPipeTransport`

```dart
class JsonPipeTransport implements Transport
```

## `Waiter`

Utility that waits for a named event on a [ChannelOwner] with support for
race conditions (timeout, reject-on-another-event).

This mirrors the Playwright Node.js `Waiter` class, which is used
internally to implement `page.waitForEvent(...)` and similar APIs.

## Example

```dart
final waiter = Waiter(page, 'load');
waiter.rejectOnTimeout(30000, 'Timeout waiting for load event');
waiter.rejectOnEvent(page, 'close', TargetClosedError('Page was closed'));
final result = await waiter.waitForEvent<void>(page, 'load');
waiter.dispose();
```

```dart
class Waiter<T>
```

### `createForEvent`

*⚙️ Method*

Creates a [Waiter] for a named event on [channelOwner].

```dart
static Waiter<T> createForEvent<T>(ChannelOwner channelOwner, String event)
```

### `rejectOnTimeout`

*⚙️ Method*

Rejects the waiter with a [TimeoutError] after [timeoutMs] milliseconds.

Pass 0 to disable the timeout.

```dart
void rejectOnTimeout(double timeoutMs, String message)
```

### `rejectOnEvent`

*⚙️ Method*

Rejects the waiter when [event] fires on [emitter].

```dart
void rejectOnEvent( ChannelOwner emitter, String event, PlaywrightError error, [ bool Function(dynamic)? predicate, ])
```

### `rejectImmediately`

*⚙️ Method*

Rejects the waiter immediately with [error].

```dart
void rejectImmediately(PlaywrightError error)
```

### `waitForEvent`

*⚙️ Method*

Waits for [event] on [emitter], subject to any reject conditions.

An optional [predicate] filters which event payloads are accepted.

```dart
Future<T> waitForEvent( ChannelOwner emitter, String event, [ bool Function(dynamic)? predicate, ])
```

### `waitForPromise`

*⚙️ Method*

Waits for [promise], racing it against all registered reject conditions.

```dart
Future<R> waitForPromise<R>(Future<R> promise) async
```

### `dispose`

*⚙️ Method*

Cancels all registered timers and subscriptions.

```dart
void dispose()
```

## `WebSocketTransport`

```dart
class WebSocketTransport implements Transport
```

## `WritableStream`

Interface for WritableStream

```dart
abstract interface class WritableStream
```

---

