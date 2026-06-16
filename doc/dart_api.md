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

## `BrowserType`

```dart
abstract interface class BrowserType
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

## `FrameLocator`

```dart
class FrameLocator
```

## `Locator`

```dart
class Locator
```

## `Page`

```dart
abstract interface class Page
```

## `Playwright`

```dart
abstract interface class Playwright
```

## `PlaywrightDart`

```dart
class PlaywrightDart
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

Simple native logger for Playwright internal debugging.

```dart
class Logger
```

### `debug`

*⚙️ Method*

Prints a debug message if debugging is enabled.

```dart
static void debug(String message,
```

### `info`

*⚙️ Method*

Prints an informational message unconditionally.

```dart
static void info(String message)
```

### `error`

*⚙️ Method*

Prints an error message.

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

