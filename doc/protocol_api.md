# Playwright Protocol API Reference

> Auto-generated from Playwright protocol **v1.61.1**.
> Source: `.protocol_cache/1.61.1/*.yml`
> Regenerate: `dart tool/generate_protocol_docs.dart`

## Contents

- [Interfaces](#interfaces)
  - [`APIRequestContext`](#apirequestcontext)
  - [`Android`](#android)
  - [`AndroidDevice`](#androiddevice)
  - [`AndroidSocket`](#androidsocket)
  - [`Artifact`](#artifact)
  - [`BindingCall`](#bindingcall)
  - [`Browser`](#browser)
  - [`BrowserContext`](#browsercontext)
  - [`BrowserType`](#browsertype)
  - [`CDPSession`](#cdpsession)
  - [`DebugController`](#debugcontroller)
  - [`Debugger`](#debugger)
  - [`Dialog`](#dialog)
  - [`Disposable`](#disposable)
  - [`Electron`](#electron)
  - [`ElectronApplication`](#electronapplication)
  - [`ElementHandle`](#elementhandle)
  - [`Frame`](#frame)
  - [`JSHandle`](#jshandle)
  - [`JsonPipe`](#jsonpipe)
  - [`LocalUtils`](#localutils)
  - [`Page`](#page)
  - [`Playwright`](#playwright)
  - [`Request`](#request)
  - [`Response`](#response)
  - [`Root`](#root)
  - [`Route`](#route)
  - [`SocksSupport`](#sockssupport)
  - [`Stream`](#stream)
  - [`Tracing`](#tracing)
  - [`WebSocket`](#websocket)
  - [`WebSocketRoute`](#websocketroute)
  - [`Worker`](#worker)
  - [`WritableStream`](#writablestream)
- [Mixins & Objects](#mixins--objects)
- [Enums](#enums)

---

# Interfaces

## `APIRequestContext`

**Initializer**

| Property | Type |
|----------|------|
| `tracing` | `Tracing` |

**Commands**

#### `fetch`(url: string, encodedParams: string?, params: Array<NameValue>?, method: string?, headers: Array<NameValue>?, postData: binary?, jsonData: string?, formData: Array<NameValue>?, multipartData: Array<FormField>?, timeout: float, failOnStatusCode: boolean?, ignoreHTTPSErrors: boolean?, maxRedirects: int?, maxRetries: int?)

*{method} "{url}"*

→ `response`: `APIResponse`

#### `fetchResponseBody`(fetchUid: string)

*Get response body · group: `getter`*

→ `binary`: `binary?`

#### `storageState`(indexedDB: boolean?)

*Get storage state · group: `configuration`*

→ `cookies`: `Array<NetworkCookie>`, `origins`: `Array<OriginStorage>`

---

## `Android`

---

## `AndroidDevice`

**Initializer**

| Property | Type |
|----------|------|
| `model` | `string` |
| `serial` | `string` |

**Commands**

#### `connectToWebView`(socketName: string)

*Connect to Web View*

→ `context`: `BrowserContext`

#### `drag`(androidSelector: AndroidSelector, dest: Point, speed: float?, timeout: float)

*Drag*

#### `fill`(androidSelector: AndroidSelector, text: string, timeout: float)

*Fill "{text}"*

#### `fling`(androidSelector: AndroidSelector, direction: ("up" | "down" | "left" | "right"), speed: float?, timeout: float)

*Fling*

#### `inputDrag`(from: Point, to: Point, steps: int)

*Drag*

#### `inputPress`(key: string)

*Press*

#### `inputSwipe`(segments: Array<Point>, steps: int)

*Swipe*

#### `inputTap`(point: Point)

*Tap*

#### `inputType`(text: string)

*Type*

#### `installApk`(file: binary, args: Array<string>?)

*Install apk*

#### `launchBrowser`(...$mixin, pkg: string?, args: Array<string>?, proxy: {server: string, bypass: string?, username: string?, password: string?}?)

*Launch browser*

→ `context`: `BrowserContext`

#### `longTap`(androidSelector: AndroidSelector, timeout: float)

*Long tap*

#### `open`(command: string)

*Open app*

→ `socket`: `AndroidSocket`

#### `pinchClose`(androidSelector: AndroidSelector, percent: float, speed: float?, timeout: float)

*Pinch close*

#### `pinchOpen`(androidSelector: AndroidSelector, percent: float, speed: float?, timeout: float)

*Pinch open*

#### `push`(file: binary, path: string, mode: int?)

*Push*

#### `screenshot`()

*Screenshot*

→ `binary`: `binary`

#### `scroll`(androidSelector: AndroidSelector, direction: ("up" | "down" | "left" | "right"), percent: float, speed: float?, timeout: float)

*Scroll*

#### `shell`(command: string)

*Execute shell command · group: `configuration`*

→ `result`: `binary`

#### `swipe`(androidSelector: AndroidSelector, direction: ("up" | "down" | "left" | "right"), percent: float, speed: float?, timeout: float)

*Swipe*

#### `tap`(androidSelector: AndroidSelector, duration: float?, timeout: float)

*Tap*

#### `wait`(androidSelector: AndroidSelector, state: ("gone")?, timeout: float)

*Wait*

**Events**

| Event | Parameters |
|-------|------------|
| `close` | — |
| `webViewAdded` | `webView`: `AndroidWebView` |
| `webViewRemoved` | `socketName`: `string` |

---

## `AndroidSocket`

**Events**

| Event | Parameters |
|-------|------------|
| `close` | — |
| `data` | `data`: `binary` |

---

## `Artifact`

**Initializer**

| Property | Type |
|----------|------|
| `absolutePath` | `string` |

---

## `BindingCall`

**Initializer**

| Property | Type |
|----------|------|
| `frame` | `Frame` |
| `name` | `string` |
| `args` | `Array<SerializedValue>` |

---

## `Browser`

**Initializer**

| Property | Type |
|----------|------|
| `version` | `string` |
| `name` | `string` |
| `browserName` | `("chromium" | "firefox" | "webkit")` |

**Commands**

#### `close`(reason: string?)

*Close browser*

#### `newBrowserCDPSession`()

*Create CDP session · group: `configuration`*

→ `session`: `CDPSession`

#### `newContext`(...$mixin, proxy: {server: string, bypass: string?, username: string?, password: string?}?, storageState: {cookies: Array<SetNetworkCookie>?, origins: Array<SetOriginStorage>?}?)

*Create context*

→ `context`: `BrowserContext`

#### `startServer`(title: string, workspaceDir: string?, metadata: json?, host: string?, port: int?)

*Start server*

→ `endpoint`: `string`

#### `startTracing`(page: Page?, screenshots: boolean?, categories: Array<string>?)

*Start browser tracing · group: `configuration`*

#### `stopServer`()

*Stop server*

#### `stopTracing`()

*Stop browser tracing · group: `configuration`*

→ `artifact`: `Artifact`

**Events**

| Event | Parameters |
|-------|------------|
| `close` | — |
| `context` | `context`: `BrowserContext` |

---

## `BrowserContext`

**Initializer**

| Property | Type |
|----------|------|
| `debugger` | `Debugger` |
| `requestContext` | `APIRequestContext` |
| `tracing` | `Tracing` |
| `options` | `{$mixin: ContextOptions}` |

**Commands**

#### `addCookies`(cookies: Array<SetNetworkCookie>)

*Add cookies · group: `configuration`*

#### `addInitScript`(source: string)

*Add init script · group: `configuration`*

→ `disposable`: `Disposable`

#### `clearCookies`(name: string?, nameRegexSource: string?, nameRegexFlags: string?, domain: string?, domainRegexSource: string?, domainRegexFlags: string?, path: string?, pathRegexSource: string?, pathRegexFlags: string?)

*Clear cookies · group: `configuration`*

#### `clearPermissions`()

*Clear permissions · group: `configuration`*

#### `clockFastForward`(ticksNumber: float?, ticksString: string?)

*Fast forward clock "{ticksNumber|ticksString}"*

#### `clockInstall`(timeNumber: float?, timeString: string?)

*Install clock "{timeNumber|timeString}"*

#### `clockPauseAt`(timeNumber: float?, timeString: string?)

*Pause clock "{timeNumber|timeString}"*

#### `clockResume`()

*Resume clock*

#### `clockRunFor`(ticksNumber: float?, ticksString: string?)

*Run clock "{ticksNumber|ticksString}"*

#### `clockSetFixedTime`(timeNumber: float?, timeString: string?)

*Set fixed time "{timeNumber|timeString}"*

#### `clockSetSystemTime`(timeNumber: float?, timeString: string?)

*Set system time "{timeNumber|timeString}"*

#### `close`(reason: string?)

*Close context*

#### `cookies`(urls: Array<string>)

*Get cookies · group: `getter`*

→ `cookies`: `Array<NetworkCookie>`

#### `credentialsCreate`(rpId: string, id: string?, userHandle: string?, privateKey: string?, publicKey: string?)

*Create virtual credential for "{rpId}" · group: `configuration`*

→ `credential`: `VirtualCredential`

#### `credentialsDelete`(id: string)

*Delete virtual credential · group: `configuration`*

#### `credentialsGet`(rpId: string?, id: string?)

*Get virtual credentials · group: `configuration`*

→ `credentials`: `Array<VirtualCredential>`

#### `credentialsInstall`()

*Install virtual WebAuthn authenticator · group: `configuration`*

#### `exposeBinding`(name: string)

*Expose binding · group: `configuration`*

→ `disposable`: `Disposable`

#### `grantPermissions`(permissions: Array<string>, origin: string?)

*Grant permissions · group: `configuration`*

#### `newCDPSession`(page: Page?, frame: Frame?)

*Create CDP session · group: `configuration`*

→ `session`: `CDPSession`

#### `newPage`()

*Create page*

→ `page`: `Page`

#### `pause`()

*Pause*

#### `setExtraHTTPHeaders`(headers: Array<NameValue>)

*Set extra HTTP headers · group: `configuration`*

#### `setGeolocation`(geolocation: {longitude: float, latitude: float, accuracy: float?}?)

*Set geolocation · group: `configuration`*

#### `setHTTPCredentials`(httpCredentials: {username: string, password: string, origin: string?}?)

*Set HTTP credentials · group: `configuration`*

#### `setNetworkInterceptionPatterns`(patterns: Array<{glob: string?, regexSource: string?, regexFlags: string?, urlPattern: URLPattern?}>)

*Route requests · group: `route`*

#### `setOffline`(offline: boolean)

*Set offline mode*

#### `setStorageState`(storageState: {cookies: Array<SetNetworkCookie>?, origins: Array<SetOriginStorage>?}?)

*Set storage state · group: `configuration`*

#### `setWebSocketInterceptionPatterns`(patterns: Array<{glob: string?, regexSource: string?, regexFlags: string?, urlPattern: URLPattern?}>)

*Route WebSockets · group: `route`*

#### `storageState`(indexedDB: boolean?)

*Get storage state · group: `configuration`*

→ `cookies`: `Array<NetworkCookie>`, `origins`: `Array<OriginStorage>`

**Events**

| Event | Parameters |
|-------|------------|
| `bindingCall` | `binding`: `BindingCall` |
| `close` | — |
| `console` | `$mixin`: `ConsoleMessage`, `page`: `Page?`, `worker`: `Worker?` |
| `dialog` | `dialog`: `Dialog` |
| `page` | `page`: `Page` |
| `pageError` | `error`: `SerializedError`, `page`: `Page`, `location`: `{url: string, line: int, column: int}` |
| `recorderEvent` | `event`: `("actionAdded" | "actionUpdated" | "signalAdded")`, `data`: `json`, `page`: `Page`, `code`: `string` |
| `request` | `request`: `Request`, `page`: `Page?` |
| `requestFailed` | `request`: `Request`, `failureText`: `string?`, `responseEndTiming`: `float`, `page`: `Page?` |
| `requestFinished` | `request`: `Request`, `response`: `Response?`, `responseEndTiming`: `float`, `page`: `Page?` |
| `response` | `response`: `Response`, `page`: `Page?` |
| `route` | `route`: `Route` |
| `serviceWorker` | `worker`: `Worker` |
| `webSocketRoute` | `webSocketRoute`: `WebSocketRoute` |

---

## `BrowserType`

**Initializer**

| Property | Type |
|----------|------|
| `executablePath` | `string` |
| `name` | `string` |

**Commands**

#### `connectOverCDP`(endpointURL: string?, headers: Array<NameValue>?, slowMo: float?, timeout: float, isLocal: boolean?, noDefaults: boolean?, artifactsDir: string?, transport: binary?)

*Connect over CDP*

→ `browser`: `Browser`, `defaultContext`: `BrowserContext?`

#### `connectToWorker`(endpoint: string, timeout: float)

*Connect to worker*

→ `worker`: `Worker`

#### `launch`(...$mixin, slowMo: float?)

*Launch browser*

→ `browser`: `Browser`

#### `launchPersistentContext`(...$mixin, ...$mixin, userDataDir: string, slowMo: float?)

*Launch persistent context*

→ `browser`: `Browser`, `context`: `BrowserContext`

---

## `CDPSession`

**Commands**

#### `detach`()

*Detach CDP session · group: `configuration`*

#### `send`(method: string, params: json?)

*Send CDP command · group: `configuration`*

→ `result`: `json`

**Events**

| Event | Parameters |
|-------|------------|
| `close` | — |
| `event` | `method`: `string`, `params`: `json?` |

---

## `DebugController`

**Events**

| Event | Parameters |
|-------|------------|
| `inspectRequested` | `selector`: `string`, `locator`: `string`, `ariaSnapshot`: `string` |
| `paused` | `paused`: `boolean` |
| `setModeRequested` | `mode`: `string` |
| `sourceChanged` | `text`: `string`, `header`: `string?`, `footer`: `string?`, `actions`: `Array<string>?` |
| `stateChanged` | `pageCount`: `int` |

---

## `Debugger`

**Commands**

#### `next`()

*Step to next call · group: `configuration`*

#### `requestPause`()

*Pause on next call · group: `configuration`*

#### `resume`()

*Resume · group: `configuration`*

#### `runTo`(location: {file: string, line: int?, column: int?})

*Run to location · group: `configuration`*

**Events**

| Event | Parameters |
|-------|------------|
| `pausedStateChanged` | `pausedDetails`: `{location: {file: string, line: int?, column: int?}, title: string, stack: string?}?` |

---

## `Dialog`

**Initializer**

| Property | Type |
|----------|------|
| `page` | `Page?` |
| `type` | `string` |
| `message` | `string` |
| `defaultValue` | `string` |

**Commands**

#### `accept`(promptText: string?)

*Accept dialog*

#### `dismiss`()

*Dismiss dialog*

---

## `Disposable`

---

## `Electron`

**Commands**

#### `launch`(executablePath: string?, args: Array<string>?, chromiumSandbox: boolean?, cwd: string?, env: Array<NameValue>?, timeout: float, acceptDownloads: ("accept" | "deny" | "internal-browser-default")?, bypassCSP: boolean?, colorScheme: ("dark" | "light" | "no-preference" | "no-override")?, extraHTTPHeaders: Array<NameValue>?, geolocation: {longitude: float, latitude: float, accuracy: float?}?, httpCredentials: {username: string, password: string, origin: string?}?, ignoreHTTPSErrors: boolean?, locale: string?, offline: boolean?, recordVideo: {dir: string?, size: {width: int, height: int}?, showActions: {$mixin: ShowActionsOptions}?}?, strictSelectors: boolean?, timezoneId: string?, tracesDir: string?, artifactsDir: string?, selectorEngines: Array<SelectorEngine>?, testIdAttributeName: string?)

*Launch electron*

→ `electronApplication`: `ElectronApplication`

---

## `ElectronApplication`

**Initializer**

| Property | Type |
|----------|------|
| `context` | `BrowserContext` |

**Commands**

#### `evaluateExpression`(expression: string, isFunction: boolean?, arg: SerializedArgument)

*Evaluate*

→ `value`: `SerializedValue`

#### `evaluateExpressionHandle`(expression: string, isFunction: boolean?, arg: SerializedArgument)

*Evaluate*

→ `handle`: `JSHandle`

**Events**

| Event | Parameters |
|-------|------------|
| `close` | — |
| `console` | `$mixin`: `ConsoleMessage` |

---

## `ElementHandle` *(extends `JSHandle`)*

**Commands**

#### `boundingBox`()

*Get bounding box*

→ `value`: `Rect?`

#### `check`(force: boolean?, position: Point?, timeout: float, trial: boolean?)

*Check*

#### `click`(force: boolean?, noWaitAfter: boolean?, modifiers: Array<("Alt" | "Control" | "ControlOrMeta" | "Meta" | "Shift")>?, position: Point?, delay: float?, button: ("left" | "right" | "middle")?, clickCount: int?, timeout: float, trial: boolean?, steps: int?)

*Click*

#### `contentFrame`()

*Get content frame · group: `getter`*

→ `frame`: `Frame?`

#### `dblclick`(force: boolean?, modifiers: Array<("Alt" | "Control" | "ControlOrMeta" | "Meta" | "Shift")>?, position: Point?, delay: float?, button: ("left" | "right" | "middle")?, timeout: float, trial: boolean?, steps: int?)

*Double click*

#### `dispatchEvent`(type: string, eventInit: SerializedArgument)

*Dispatch event*

#### `evalOnSelector`(selector: string, strict: boolean?, expression: string, isFunction: boolean?, arg: SerializedArgument)

*Evaluate*

→ `value`: `SerializedValue`

#### `evalOnSelectorAll`(selector: string, expression: string, isFunction: boolean?, arg: SerializedArgument)

*Evaluate*

→ `value`: `SerializedValue`

#### `fill`(value: string, force: boolean?, timeout: float)

*Fill "{value}"*

#### `focus`()

*Focus*

#### `getAttribute`(name: string)

*Get attribute · group: `getter`*

→ `value`: `string?`

#### `hover`(force: boolean?, modifiers: Array<("Alt" | "Control" | "ControlOrMeta" | "Meta" | "Shift")>?, position: Point?, timeout: float, trial: boolean?)

*Hover*

#### `innerHTML`()

*Get HTML · group: `getter`*

→ `value`: `string`

#### `innerText`()

*Get inner text · group: `getter`*

→ `value`: `string`

#### `inputValue`()

*Get input value · group: `getter`*

→ `value`: `string`

#### `isChecked`()

*Is checked · group: `getter`*

→ `value`: `boolean`

#### `isDisabled`()

*Is disabled · group: `getter`*

→ `value`: `boolean`

#### `isEditable`()

*Is editable · group: `getter`*

→ `value`: `boolean`

#### `isEnabled`()

*Is enabled · group: `getter`*

→ `value`: `boolean`

#### `isHidden`()

*Is hidden · group: `getter`*

→ `value`: `boolean`

#### `isVisible`()

*Is visible · group: `getter`*

→ `value`: `boolean`

#### `ownerFrame`()

*Get owner frame · group: `getter`*

→ `frame`: `Frame?`

#### `press`(key: string, delay: float?, timeout: float, noWaitAfter: boolean?)

*Press "{key}"*

#### `querySelector`(selector: string, strict: boolean?)

*Query selector*

→ `element`: `ElementHandle?`

#### `querySelectorAll`(selector: string)

*Query selector all*

→ `elements`: `Array<ElementHandle>`

#### `screenshot`(timeout: float, type: ("png" | "jpeg")?, quality: int?, ...$mixin)

*Screenshot*

→ `binary`: `binary`

#### `scrollIntoViewIfNeeded`(timeout: float)

*Scroll into view*

#### `selectOption`(elements: Array<ElementHandle>?, options: Array<{valueOrLabel: string?, value: string?, label: string?, index: int?}>?, force: boolean?, timeout: float)

*Select option*

→ `values`: `Array<string>`

#### `selectText`(force: boolean?, timeout: float)

*Select text*

#### `setInputFiles`(payloads: Array<{name: string, mimeType: string?, buffer: binary}>?, localDirectory: string?, directoryStream: WritableStream?, localPaths: Array<string>?, streams: Array<WritableStream>?, timeout: float)

*Set input files*

#### `tap`(force: boolean?, modifiers: Array<("Alt" | "Control" | "ControlOrMeta" | "Meta" | "Shift")>?, position: Point?, timeout: float, trial: boolean?)

*Tap*

#### `textContent`()

*Get text content · group: `getter`*

→ `value`: `string?`

#### `type`(text: string, delay: float?, timeout: float)

*Type*

#### `uncheck`(force: boolean?, position: Point?, timeout: float, trial: boolean?)

*Uncheck*

#### `waitForElementState`(state: ("visible" | "hidden" | "stable" | "enabled" | "disabled" | "editable"), timeout: float)

*Wait for state*

#### `waitForSelector`(selector: string, strict: boolean?, timeout: float, state: ("attached" | "detached" | "visible" | "hidden")?)

*Wait for selector*

→ `element`: `ElementHandle?`

---

## `Frame`

**Initializer**

| Property | Type |
|----------|------|
| `url` | `string` |
| `name` | `string` |
| `parentFrame` | `Frame?` |
| `loadStates` | `Array<LifecycleEvent>` |

**Commands**

#### `addScriptTag`(url: string?, content: string?, type: string?)

*Add script tag*

→ `element`: `ElementHandle`

#### `addStyleTag`(url: string?, content: string?)

*Add style tag*

→ `element`: `ElementHandle`

#### `ariaSnapshot`(mode: ("ai" | "default")?, track: string?, selector: string?, depth: int?, boxes: boolean?, timeout: float)

*Aria snapshot · group: `getter`*

→ `snapshot`: `string`

#### `blur`(selector: string, strict: boolean?, timeout: float)

*Blur*

#### `check`(selector: string, strict: boolean?, force: boolean?, position: Point?, timeout: float, trial: boolean?)

*Check*

#### `click`(selector: string, strict: boolean?, force: boolean?, noWaitAfter: boolean?, modifiers: Array<("Alt" | "Control" | "ControlOrMeta" | "Meta" | "Shift")>?, position: Point?, delay: float?, button: ("left" | "right" | "middle")?, clickCount: int?, timeout: float, trial: boolean?, steps: int?)

*Click*

#### `content`()

*Get content*

→ `value`: `string`

#### `dblclick`(selector: string, strict: boolean?, force: boolean?, modifiers: Array<("Alt" | "Control" | "ControlOrMeta" | "Meta" | "Shift")>?, position: Point?, delay: float?, button: ("left" | "right" | "middle")?, timeout: float, trial: boolean?, steps: int?)

*Double click*

#### `dispatchEvent`(selector: string, strict: boolean?, type: string, eventInit: SerializedArgument, timeout: float)

*Dispatch "{type}"*

#### `dragAndDrop`(source: string, target: string, force: boolean?, timeout: float, trial: boolean?, sourcePosition: Point?, targetPosition: Point?, strict: boolean?, steps: int?)

*Drag and drop*

#### `drop`(selector: string, strict: boolean?, position: Point?, payloads: Array<{name: string, mimeType: string?, buffer: binary}>?, localPaths: Array<string>?, streams: Array<WritableStream>?, data: Array<{mimeType: string, value: string}>?, timeout: float)

*Drop files or data onto an element*

#### `evalOnSelector`(selector: string, strict: boolean?, expression: string, isFunction: boolean?, arg: SerializedArgument)

*Evaluate*

→ `value`: `SerializedValue`

#### `evalOnSelectorAll`(selector: string, expression: string, isFunction: boolean?, arg: SerializedArgument)

*Evaluate*

→ `value`: `SerializedValue`

#### `evaluateExpression`(expression: string, isFunction: boolean?, arg: SerializedArgument)

*Evaluate*

→ `value`: `SerializedValue`

#### `evaluateExpressionHandle`(expression: string, isFunction: boolean?, arg: SerializedArgument)

*Evaluate*

→ `handle`: `JSHandle`

#### `expect`(selector: string?, expression: string, expressionArg: json?, pseudo: ("before" | "after")?, expectedText: Array<ExpectedTextValue>?, expectedNumber: float?, expectedValue: SerializedArgument?, useInnerText: boolean?, isNot: boolean, timeout: float)

*Expect "{expression}"*

#### `fill`(selector: string, strict: boolean?, value: string, force: boolean?, timeout: float)

*Fill "{value}"*

#### `focus`(selector: string, strict: boolean?, timeout: float)

*Focus*

#### `frameElement`()

*Get frame element · group: `getter`*

→ `element`: `ElementHandle`

#### `getAttribute`(selector: string, strict: boolean?, name: string, timeout: float)

*Get attribute "{name}" · group: `getter`*

→ `value`: `string?`

#### `goto`(url: string, timeout: float, waitUntil: LifecycleEvent?, referer: string?)

*Navigate to "{url}"*

→ `response`: `Response?`

#### `hover`(selector: string, strict: boolean?, force: boolean?, modifiers: Array<("Alt" | "Control" | "ControlOrMeta" | "Meta" | "Shift")>?, position: Point?, timeout: float, trial: boolean?)

*Hover*

#### `innerHTML`(selector: string, strict: boolean?, timeout: float)

*Get HTML · group: `getter`*

→ `value`: `string`

#### `innerText`(selector: string, strict: boolean?, timeout: float)

*Get inner text · group: `getter`*

→ `value`: `string`

#### `inputValue`(selector: string, strict: boolean?, timeout: float)

*Get input value · group: `getter`*

→ `value`: `string`

#### `isChecked`(selector: string, strict: boolean?, timeout: float)

*Is checked · group: `getter`*

→ `value`: `boolean`

#### `isDisabled`(selector: string, strict: boolean?, timeout: float)

*Is disabled · group: `getter`*

→ `value`: `boolean`

#### `isEditable`(selector: string, strict: boolean?, timeout: float)

*Is editable · group: `getter`*

→ `value`: `boolean`

#### `isEnabled`(selector: string, strict: boolean?, timeout: float)

*Is enabled · group: `getter`*

→ `value`: `boolean`

#### `isHidden`(selector: string, strict: boolean?)

*Is hidden · group: `getter`*

→ `value`: `boolean`

#### `isVisible`(selector: string, strict: boolean?)

*Is visible · group: `getter`*

→ `value`: `boolean`

#### `press`(selector: string, strict: boolean?, key: string, delay: float?, noWaitAfter: boolean?, timeout: float)

*Press "{key}"*

#### `queryCount`(selector: string)

*Query count*

→ `value`: `int`

#### `querySelector`(selector: string, strict: boolean?)

*Query selector*

→ `element`: `ElementHandle?`

#### `querySelectorAll`(selector: string)

*Query selector all*

→ `elements`: `Array<ElementHandle>`

#### `selectOption`(selector: string, strict: boolean?, elements: Array<ElementHandle>?, options: Array<{valueOrLabel: string?, value: string?, label: string?, index: int?}>?, force: boolean?, timeout: float)

*Select option*

→ `values`: `Array<string>`

#### `setContent`(html: string, timeout: float, waitUntil: LifecycleEvent?)

*Set content*

#### `setInputFiles`(selector: string, strict: boolean?, payloads: Array<{name: string, mimeType: string?, buffer: binary}>?, localDirectory: string?, directoryStream: WritableStream?, localPaths: Array<string>?, streams: Array<WritableStream>?, timeout: float)

*Set input files*

#### `tap`(selector: string, strict: boolean?, force: boolean?, modifiers: Array<("Alt" | "Control" | "ControlOrMeta" | "Meta" | "Shift")>?, position: Point?, timeout: float, trial: boolean?)

*Tap*

#### `textContent`(selector: string, strict: boolean?, timeout: float)

*Get text content · group: `getter`*

→ `value`: `string?`

#### `title`()

*Get page title · group: `getter`*

→ `value`: `string`

#### `type`(selector: string, strict: boolean?, text: string, delay: float?, timeout: float)

*Type "{text}"*

#### `uncheck`(selector: string, strict: boolean?, force: boolean?, position: Point?, timeout: float, trial: boolean?)

*Uncheck*

#### `waitForFunction`(expression: string, isFunction: boolean?, arg: SerializedArgument, timeout: float, pollingInterval: float?)

*Wait for function*

→ `handle`: `JSHandle`

#### `waitForSelector`(selector: string, strict: boolean?, timeout: float, state: ("attached" | "detached" | "visible" | "hidden")?, omitReturnValue: boolean?)

*Wait for selector*

→ `element`: `ElementHandle?`

#### `waitForTimeout`(waitTimeout: float)

*Wait for timeout*

**Events**

| Event | Parameters |
|-------|------------|
| `loadstate` | `add`: `LifecycleEvent?`, `remove`: `LifecycleEvent?` |
| `navigated` | `url`: `string`, `name`: `string`, `newDocument`: `{request: Request?}?`, `error`: `string?` |

---

## `JSHandle`

**Initializer**

| Property | Type |
|----------|------|
| `preview` | `string` |

**Commands**

#### `evaluateExpression`(expression: string, isFunction: boolean?, arg: SerializedArgument)

*Evaluate*

→ `value`: `SerializedValue`

#### `evaluateExpressionHandle`(expression: string, isFunction: boolean?, arg: SerializedArgument)

*Evaluate*

→ `handle`: `JSHandle`

#### `getProperty`(name: string)

*Get JS property · group: `getter`*

→ `handle`: `JSHandle`

#### `getPropertyList`()

*Get property list · group: `getter`*

→ `properties`: `Array<{name: string, value: JSHandle}>`

#### `jsonValue`()

*Get JSON value · group: `getter`*

→ `value`: `SerializedValue`

**Events**

| Event | Parameters |
|-------|------------|
| `previewUpdated` | `preview`: `string` |

---

## `JsonPipe`

**Events**

| Event | Parameters |
|-------|------------|
| `closed` | `reason`: `string?` |
| `message` | `message`: `json` |

---

## `LocalUtils`

**Initializer**

| Property | Type |
|----------|------|
| `deviceDescriptors` | `Array<{name: string, descriptor: {userAgent: string, viewport: {width: int, height: int}, screen: {width: int, height: int}?, deviceScaleFactor: float, isMobile: boolean, hasTouch: boolean, defaultBrowserType: ("chromium" | "firefox" | "webkit")}}>` |

---

## `Page`

**Initializer**

| Property | Type |
|----------|------|
| `mainFrame` | `Frame` |
| `viewportSize` | `{width: int, height: int}?` |
| `isClosed` | `boolean` |
| `opener` | `Page?` |
| `video` | `Artifact?` |

**Commands**

#### `addInitScript`(source: string)

*Add init script · group: `configuration`*

→ `disposable`: `Disposable`

#### `bringToFront`()

*Bring to front*

#### `cancelPickLocator`()

*Cancel pick locator · group: `configuration`*

#### `clearConsoleMessages`()

*Clear console messages*

#### `clearPageErrors`()

*Clear page errors*

#### `close`(reason: string?)

*Close page*

#### `consoleMessages`(filter: ConsoleMessagesFilter?)

*Get console messages · group: `getter`*

→ `messages`: `Array<{$mixin: ConsoleMessage}>`

#### `emulateMedia`(media: ("screen" | "print" | "no-override")?, colorScheme: ("dark" | "light" | "no-preference" | "no-override")?, reducedMotion: ("reduce" | "no-preference" | "no-override")?, forcedColors: ("active" | "none" | "no-override")?, contrast: ("no-preference" | "more" | "no-override")?)

*Emulate media*

#### `expectScreenshot`(expected: binary?, timeout: float, isNot: boolean, locator: {frame: Frame, selector: string}?, comparator: string?, maxDiffPixels: int?, maxDiffPixelRatio: float?, threshold: float?, fullPage: boolean?, clip: Rect?, ...$mixin)

*Expect screenshot*

→ `actual`: `binary?`

#### `exposeBinding`(name: string)

*Expose binding · group: `configuration`*

→ `disposable`: `Disposable`

#### `goBack`(timeout: float, waitUntil: LifecycleEvent?)

*Go back*

→ `response`: `Response?`

#### `goForward`(timeout: float, waitUntil: LifecycleEvent?)

*Go forward*

→ `response`: `Response?`

#### `hideHighlight`()

*Hide all element highlights · group: `configuration`*

#### `keyboardDown`(key: string)

*Key down "{key}"*

#### `keyboardInsertText`(text: string)

*Insert "{text}"*

#### `keyboardPress`(key: string, delay: float?)

*Press "{key}"*

#### `keyboardType`(text: string, delay: float?)

*Type "{text}"*

#### `keyboardUp`(key: string)

*Key up "{key}"*

#### `mouseClick`(x: float, y: float, delay: float?, button: ("left" | "right" | "middle")?, clickCount: int?)

*Click*

#### `mouseDown`(button: ("left" | "right" | "middle")?, clickCount: int?)

*Mouse down*

#### `mouseMove`(x: float, y: float, steps: int?)

*Mouse move*

#### `mouseUp`(button: ("left" | "right" | "middle")?, clickCount: int?)

*Mouse up*

#### `mouseWheel`(deltaX: float, deltaY: float)

*Mouse wheel*

#### `pageErrors`(filter: ConsoleMessagesFilter?)

*Get page errors · group: `getter`*

→ `errors`: `Array<SerializedError>`

#### `pdf`(scale: float?, displayHeaderFooter: boolean?, headerTemplate: string?, footerTemplate: string?, printBackground: boolean?, landscape: boolean?, pageRanges: string?, format: string?, width: string?, height: string?, preferCSSPageSize: boolean?, margin: {top: string?, bottom: string?, left: string?, right: string?}?, tagged: boolean?, outline: boolean?)

*PDF*

→ `pdf`: `binary`

#### `pickLocator`()

*Pick locator · group: `configuration`*

→ `selector`: `string`

#### `registerLocatorHandler`(selector: string, noWaitAfter: boolean?)

*Register locator handler*

→ `uid`: `int`

#### `reload`(timeout: float, waitUntil: LifecycleEvent?)

*Reload*

→ `response`: `Response?`

#### `requestGC`()

*Request garbage collection · group: `configuration`*

#### `requests`()

*Get network requests · group: `getter`*

→ `requests`: `Array<Request>`

#### `runBeforeUnload`()

*Run beforeunload*

#### `screencastChapter`(title: string, description: string?, duration: float?)

*Show chapter overlay · group: `configuration`*

#### `screencastHideActions`()

*Remove actions · group: `configuration`*

#### `screencastRemoveOverlay`(id: string)

*Remove overlay · group: `configuration`*

#### `screencastSetOverlayVisible`(visible: boolean)

*Set overlay visibility · group: `configuration`*

#### `screencastShowActions`(...$mixin)

*Show actions · group: `configuration`*

#### `screencastShowOverlay`(html: string, duration: float?)

*Show overlay · group: `configuration`*

→ `id`: `string`

#### `screencastStart`(size: {width: int, height: int}?, quality: int?, sendFrames: boolean?, record: boolean?)

*Start screencast · group: `configuration`*

→ `artifact`: `Artifact?`

#### `screencastStop`()

*Stop screencast · group: `configuration`*

#### `screenshot`(timeout: float, type: ("png" | "jpeg")?, quality: int?, fullPage: boolean?, clip: Rect?, ...$mixin)

*Screenshot*

→ `binary`: `binary`

#### `setExtraHTTPHeaders`(headers: Array<NameValue>)

*Set extra HTTP headers · group: `configuration`*

#### `setNetworkInterceptionPatterns`(patterns: Array<{glob: string?, regexSource: string?, regexFlags: string?, urlPattern: URLPattern?}>)

*Route requests · group: `route`*

#### `setViewportSize`(viewportSize: {width: int, height: int})

*Set viewport size*

#### `setWebSocketInterceptionPatterns`(patterns: Array<{glob: string?, regexSource: string?, regexFlags: string?, urlPattern: URLPattern?}>)

*Route WebSockets · group: `route`*

#### `startCSSCoverage`(resetOnNavigation: boolean?)

*Start CSS coverage · group: `configuration`*

#### `startJSCoverage`(resetOnNavigation: boolean?, reportAnonymousScripts: boolean?)

*Start JS coverage · group: `configuration`*

#### `stopCSSCoverage`()

*Stop CSS coverage · group: `configuration`*

→ `entries`: `Array<{url: string, text: string?, ranges: Array<{start: int, end: int}>}>`

#### `stopJSCoverage`()

*Stop JS coverage · group: `configuration`*

→ `entries`: `Array<{url: string, scriptId: string, source: string?, functions: Array<{functionName: string, isBlockCoverage: boolean, ranges: Array<{startOffset: int, endOffset: int, count: int}>}>}>`

#### `touchscreenTap`(x: float, y: float)

*Tap*

#### `unregisterLocatorHandler`(uid: int)

*Unregister locator handler*

#### `webStorageClear`(kind: ("local" | "session"))

*Clear WebStorage · group: `configuration`*

#### `webStorageGetItem`(kind: ("local" | "session"), name: string)

*Get WebStorage item · group: `getter`*

→ `value`: `string?`

#### `webStorageItems`(kind: ("local" | "session"))

*Get WebStorage items · group: `getter`*

→ `items`: `Array<NameValue>`

#### `webStorageRemoveItem`(kind: ("local" | "session"), name: string)

*Remove WebStorage item · group: `configuration`*

#### `webStorageSetItem`(kind: ("local" | "session"), name: string, value: string)

*Set WebStorage item · group: `configuration`*

**Events**

| Event | Parameters |
|-------|------------|
| `bindingCall` | `binding`: `BindingCall` |
| `close` | — |
| `crash` | — |
| `download` | `url`: `string`, `suggestedFilename`: `string`, `artifact`: `Artifact` |
| `fileChooser` | `element`: `ElementHandle`, `isMultiple`: `boolean` |
| `frameAttached` | `frame`: `Frame` |
| `frameDetached` | `frame`: `Frame` |
| `locatorHandlerTriggered` | `uid`: `int` |
| `route` | `route`: `Route` |
| `screencastFrame` | `data`: `binary`, `timestamp`: `float`, `viewportWidth`: `int`, `viewportHeight`: `int` |
| `viewportSizeChanged` | `viewportSize`: `{width: int, height: int}?` |
| `webSocket` | `webSocket`: `WebSocket` |
| `webSocketRoute` | `webSocketRoute`: `WebSocketRoute` |
| `worker` | `worker`: `Worker` |

---

## `Playwright`

**Initializer**

| Property | Type |
|----------|------|
| `chromium` | `BrowserType` |
| `firefox` | `BrowserType` |
| `webkit` | `BrowserType` |
| `android` | `Android` |
| `electron` | `Electron` |
| `utils` | `LocalUtils?` |
| `preLaunchedBrowser` | `Browser?` |
| `preConnectedAndroidDevice` | `AndroidDevice?` |
| `socksSupport` | `SocksSupport?` |

**Commands**

#### `newRequest`(baseURL: string?, userAgent: string?, ignoreHTTPSErrors: boolean?, extraHTTPHeaders: Array<NameValue>?, failOnStatusCode: boolean?, clientCertificates: Array<{origin: string, cert: binary?, key: binary?, passphrase: string?, pfx: binary?}>?, maxRedirects: int?, httpCredentials: {username: string, password: string, origin: string?, send: ("always" | "unauthorized")?}?, proxy: {server: string, bypass: string?, username: string?, password: string?}?, storageState: {cookies: Array<NetworkCookie>?, origins: Array<SetOriginStorage>?}?, tracesDir: string?)

*Create request context*

→ `request`: `APIRequestContext`

---

## `Request`

**Initializer**

| Property | Type |
|----------|------|
| `frame` | `Frame?` |
| `serviceWorker` | `Worker?` |
| `url` | `string` |
| `resourceType` | `string` |
| `method` | `string` |
| `postData` | `binary?` |
| `headers` | `Array<NameValue>` |
| `isNavigationRequest` | `boolean` |
| `redirectedFrom` | `Request?` |

---

## `Response`

**Initializer**

| Property | Type |
|----------|------|
| `request` | `Request` |
| `url` | `string` |
| `status` | `int` |
| `statusText` | `string` |
| `headers` | `Array<NameValue>` |
| `timing` | `ResourceTiming` |
| `fromServiceWorker` | `boolean` |

**Commands**

#### `body`()

*Get response body · group: `getter`*

→ `binary`: `binary`

---

## `Root`

---

## `Route`

**Initializer**

| Property | Type |
|----------|------|
| `request` | `Request` |

**Commands**

#### `abort`(errorCode: string?)

*Abort request · group: `route`*

#### `continue`(url: string?, method: string?, headers: Array<NameValue>?, postData: binary?, isFallback: boolean)

*Continue request · group: `route`*

#### `fulfill`(status: int?, headers: Array<NameValue>?, body: string?, isBase64: boolean?, fetchResponseUid: string?)

*Fulfill request · group: `route`*

---

## `SocksSupport`

**Events**

| Event | Parameters |
|-------|------------|
| `socksClosed` | `uid`: `string` |
| `socksData` | `uid`: `string`, `data`: `binary` |
| `socksRequested` | `uid`: `string`, `host`: `string`, `port`: `int` |

---

## `Stream`

---

## `Tracing`

**Commands**

#### `tracingGroup`(name: string, location: {file: string, line: int?, column: int?}?)

*Trace "{name}"*

#### `tracingGroupEnd`()

*Group end*

#### `tracingStart`(name: string?, snapshots: boolean?, screenshots: boolean?, live: boolean?)

*Start tracing · group: `configuration`*

#### `tracingStartChunk`(name: string?, title: string?)

*Start tracing · group: `configuration`*

→ `traceName`: `string`

#### `tracingStop`()

*Stop tracing · group: `configuration`*

#### `tracingStopChunk`(mode: ("archive" | "discard" | "entries"))

*Stop tracing · group: `configuration`*

→ `artifact`: `Artifact?`, `entries`: `Array<NameValue>?`

---

## `WebSocket`

**Initializer**

| Property | Type |
|----------|------|
| `url` | `string` |

**Events**

| Event | Parameters |
|-------|------------|
| `close` | — |
| `frameReceived` | `opcode`: `int`, `data`: `string` |
| `frameSent` | `opcode`: `int`, `data`: `string` |
| `open` | — |
| `socketError` | `error`: `string` |

---

## `WebSocketRoute`

**Initializer**

| Property | Type |
|----------|------|
| `url` | `string` |
| `protocols` | `Array<string>` |

**Commands**

#### `connect`()

*Connect WebSocket to server · group: `route`*

#### `sendToPage`(message: string, isBase64: boolean)

*Send WebSocket message · group: `route`*

#### `sendToServer`(message: string, isBase64: boolean)

*Send WebSocket message · group: `route`*

**Events**

| Event | Parameters |
|-------|------------|
| `closePage` | `code`: `int?`, `reason`: `string?`, `wasClean`: `boolean` |
| `closeServer` | `code`: `int?`, `reason`: `string?`, `wasClean`: `boolean` |
| `messageFromPage` | `message`: `string`, `isBase64`: `boolean` |
| `messageFromServer` | `message`: `string`, `isBase64`: `boolean` |

---

## `Worker`

**Initializer**

| Property | Type |
|----------|------|
| `url` | `string` |

**Commands**

#### `disconnect`(reason: string?)

*Disconnect from worker*

#### `evaluateExpression`(expression: string, isFunction: boolean?, arg: SerializedArgument)

*Evaluate*

→ `value`: `SerializedValue`

#### `evaluateExpressionHandle`(expression: string, isFunction: boolean?, arg: SerializedArgument)

*Evaluate*

→ `handle`: `JSHandle`

**Events**

| Event | Parameters |
|-------|------------|
| `close` | — |
| `console` | `$mixin`: `ConsoleMessage` |

---

## `WritableStream`

---

---

# Mixins & Objects

### `APIResponse` *(object)*

| Property | Type |
|----------|------|
| `fetchUid` | `string` |
| `url` | `string` |
| `status` | `int` |
| `statusText` | `string` |
| `headers` | `Array<NameValue>` |
| `securityDetails` | `SecurityDetails?` |
| `serverAddr` | `RemoteAddr?` |

### `AndroidElementInfo` *(object)*

| Property | Type |
|----------|------|
| `children` | `Array<AndroidElementInfo>?` |
| `clazz` | `string` |
| `desc` | `string` |
| `res` | `string` |
| `pkg` | `string` |
| `text` | `string` |
| `bounds` | `Rect` |
| `checkable` | `boolean` |
| `checked` | `boolean` |
| `clickable` | `boolean` |
| `enabled` | `boolean` |
| `focusable` | `boolean` |
| `focused` | `boolean` |
| `longClickable` | `boolean` |
| `scrollable` | `boolean` |
| `selected` | `boolean` |

### `AndroidSelector` *(object)*

| Property | Type |
|----------|------|
| `checkable` | `boolean?` |
| `checked` | `boolean?` |
| `clazz` | `string?` |
| `clickable` | `boolean?` |
| `depth` | `int?` |
| `desc` | `string?` |
| `enabled` | `boolean?` |
| `focusable` | `boolean?` |
| `focused` | `boolean?` |
| `hasChild` | `{androidSelector: AndroidSelector}?` |
| `hasDescendant` | `{androidSelector: AndroidSelector, maxDepth: int?}?` |
| `longClickable` | `boolean?` |
| `pkg` | `string?` |
| `res` | `string?` |
| `scrollable` | `boolean?` |
| `selected` | `boolean?` |
| `text` | `string?` |

### `AndroidWebView` *(object)*

| Property | Type |
|----------|------|
| `pid` | `int` |
| `pkg` | `string` |
| `socketName` | `string` |

### `ClientSideCallMetadata` *(object)*

| Property | Type |
|----------|------|
| `id` | `int` |
| `stack` | `Array<StackFrame>?` |

### `CommonScreenshotOptions` *(mixin)*

| Property | Type |
|----------|------|
| `omitBackground` | `boolean?` |
| `caret` | `("hide" | "initial")?` |
| `animations` | `("disabled" | "allow")?` |
| `scale` | `("css" | "device")?` |
| `mask` | `Array<{frame: Frame, selector: string}>?` |
| `maskColor` | `string?` |
| `style` | `string?` |

### `ConsoleMessage` *(mixin)*

| Property | Type |
|----------|------|
| `type` | `string` |
| `text` | `string` |
| `args` | `Array<JSHandle>` |
| `location` | `{url: string, lineNumber: int, columnNumber: int}` |
| `timestamp` | `float` |

### `ContextOptions` *(mixin)*

| Property | Type |
|----------|------|
| `noDefaultViewport` | `boolean?` |
| `viewport` | `{width: int, height: int}?` |
| `screen` | `{width: int, height: int}?` |
| `ignoreHTTPSErrors` | `boolean?` |
| `clientCertificates` | `Array<{origin: string, cert: binary?, key: binary?, passphrase: string?, pfx: binary?}>?` |
| `javaScriptEnabled` | `boolean?` |
| `bypassCSP` | `boolean?` |
| `userAgent` | `string?` |
| `locale` | `string?` |
| `timezoneId` | `string?` |
| `geolocation` | `{longitude: float, latitude: float, accuracy: float?}?` |
| `permissions` | `Array<string>?` |
| `extraHTTPHeaders` | `Array<NameValue>?` |
| `offline` | `boolean?` |
| `httpCredentials` | `{username: string, password: string, origin: string?, send: ("always" | "unauthorized")?}?` |
| `deviceScaleFactor` | `float?` |
| `isMobile` | `boolean?` |
| `hasTouch` | `boolean?` |
| `colorScheme` | `("dark" | "light" | "no-preference" | "no-override")?` |
| `reducedMotion` | `("reduce" | "no-preference" | "no-override")?` |
| `forcedColors` | `("active" | "none" | "no-override")?` |
| `acceptDownloads` | `("accept" | "deny" | "internal-browser-default")?` |
| `contrast` | `("no-preference" | "more" | "no-override")?` |
| `baseURL` | `string?` |
| `recordVideo` | `{dir: string?, size: {width: int, height: int}?, showActions: {$mixin: ShowActionsOptions}?}?` |
| `strictSelectors` | `boolean?` |
| `serviceWorkers` | `("allow" | "block")?` |
| `selectorEngines` | `Array<SelectorEngine>?` |
| `testIdAttributeName` | `string?` |

### `ExpectedTextValue` *(object)*

| Property | Type |
|----------|------|
| `string` | `string?` |
| `regexSource` | `string?` |
| `regexFlags` | `string?` |
| `matchSubstring` | `boolean?` |
| `ignoreCase` | `boolean?` |
| `normalizeWhiteSpace` | `boolean?` |

### `FormField` *(object)*

| Property | Type |
|----------|------|
| `name` | `string` |
| `value` | `string?` |
| `file` | `{name: string, mimeType: string?, buffer: binary}?` |

### `IndexedDBDatabase` *(object)*

| Property | Type |
|----------|------|
| `name` | `string` |
| `version` | `int` |
| `stores` | `Array<{name: string, autoIncrement: boolean, keyPath: string?, keyPathArray: Array<string>?, records: Array<{key: json?, keyEncoded: json?, value: json?, valueEncoded: json?}>, indexes: Array<{name: string, keyPath: string?, keyPathArray: Array<string>?, multiEntry: boolean, unique: boolean}>}>` |

### `LaunchOptions` *(mixin)*

| Property | Type |
|----------|------|
| `channel` | `string?` |
| `executablePath` | `string?` |
| `args` | `Array<string>?` |
| `ignoreAllDefaultArgs` | `boolean?` |
| `ignoreDefaultArgs` | `Array<string>?` |
| `handleSIGINT` | `boolean?` |
| `handleSIGTERM` | `boolean?` |
| `handleSIGHUP` | `boolean?` |
| `timeout` | `float` |
| `env` | `Array<NameValue>?` |
| `headless` | `boolean?` |
| `proxy` | `{server: string, bypass: string?, username: string?, password: string?}?` |
| `downloadsPath` | `string?` |
| `tracesDir` | `string?` |
| `artifactsDir` | `string?` |
| `chromiumSandbox` | `boolean?` |
| `firefoxUserPrefs` | `json?` |
| `cdpPort` | `int?` |

### `Metadata` *(object)*

| Property | Type |
|----------|------|
| `location` | `{file: string, line: int?, column: int?}?` |
| `title` | `string?` |
| `internal` | `boolean?` |
| `stepId` | `string?` |

### `NameValue` *(object)*

| Property | Type |
|----------|------|
| `name` | `string` |
| `value` | `string` |

### `NetworkCookie` *(object)*

| Property | Type |
|----------|------|
| `name` | `string` |
| `value` | `string` |
| `domain` | `string` |
| `path` | `string` |
| `expires` | `float` |
| `httpOnly` | `boolean` |
| `secure` | `boolean` |
| `sameSite` | `("Strict" | "Lax" | "None")` |
| `partitionKey` | `string?` |
| `_crHasCrossSiteAncestor` | `boolean?` |

### `OriginStorage` *(object)*

| Property | Type |
|----------|------|
| `origin` | `string` |
| `localStorage` | `Array<NameValue>` |
| `indexedDB` | `Array<IndexedDBDatabase>?` |

### `Point` *(object)*

| Property | Type |
|----------|------|
| `x` | `float` |
| `y` | `float` |

### `RecordHarOptions` *(object)*

| Property | Type |
|----------|------|
| `content` | `("embed" | "attach" | "omit")?` |
| `mode` | `("full" | "minimal")?` |
| `urlGlob` | `string?` |
| `urlRegexSource` | `string?` |
| `urlRegexFlags` | `string?` |
| `harPath` | `string?` |
| `resourcesDir` | `string?` |

### `RecorderSource` *(object)*

| Property | Type |
|----------|------|
| `isRecorded` | `boolean` |
| `id` | `string` |
| `label` | `string` |
| `text` | `string` |
| `language` | `string` |
| `highlight` | `Array<{line: int, type: string}>` |
| `revealLine` | `int?` |
| `group` | `string?` |

### `Rect` *(object)*

| Property | Type |
|----------|------|
| `x` | `float` |
| `y` | `float` |
| `width` | `float` |
| `height` | `float` |

### `RemoteAddr` *(object)*

| Property | Type |
|----------|------|
| `ipAddress` | `string` |
| `port` | `int` |

### `RequestSizes` *(object)*

| Property | Type |
|----------|------|
| `requestBodySize` | `int` |
| `requestHeadersSize` | `int` |
| `responseBodySize` | `int` |
| `responseHeadersSize` | `int` |

### `ResourceTiming` *(object)*

| Property | Type |
|----------|------|
| `startTime` | `float` |
| `domainLookupStart` | `float` |
| `domainLookupEnd` | `float` |
| `connectStart` | `float` |
| `secureConnectionStart` | `float` |
| `connectEnd` | `float` |
| `requestStart` | `float` |
| `responseStart` | `float` |

### `SecurityDetails` *(object)*

| Property | Type |
|----------|------|
| `issuer` | `string?` |
| `protocol` | `string?` |
| `subjectName` | `string?` |
| `validFrom` | `float?` |
| `validTo` | `float?` |

### `SelectorEngine` *(object)*

| Property | Type |
|----------|------|
| `name` | `string` |
| `source` | `string` |
| `contentScript` | `boolean?` |

### `SerializedArgument` *(object)*

| Property | Type |
|----------|------|
| `value` | `SerializedValue` |
| `handles` | `Array<Channel>` |

### `SerializedError` *(object)*

| Property | Type |
|----------|------|
| `error` | `{message: string, name: string, stack: string?}?` |
| `value` | `SerializedValue?` |

### `SerializedValue` *(object)*

| Property | Type |
|----------|------|
| `n` | `float?` |
| `b` | `boolean?` |
| `s` | `string?` |
| `v` | `("null" | "undefined" | "NaN" | "Infinity" | "-Infinity" | "-0")?` |
| `d` | `string?` |
| `u` | `string?` |
| `bi` | `string?` |
| `ta` | `{b: binary, k: ("i8" | "ui8" | "ui8c" | "i16" | "ui16" | "i32" | "ui32" | "f32" | "f64" | "bi64" | "bui64")}?` |
| `e` | `{m: string, n: string, s: string}?` |
| `r` | `{p: string, f: string}?` |
| `a` | `Array<SerializedValue>?` |
| `o` | `Array<{k: string, v: SerializedValue}>?` |
| `h` | `int?` |
| `id` | `int?` |
| `ref` | `int?` |

### `SetNetworkCookie` *(object)*

| Property | Type |
|----------|------|
| `name` | `string` |
| `value` | `string` |
| `url` | `string?` |
| `domain` | `string?` |
| `path` | `string?` |
| `expires` | `float?` |
| `httpOnly` | `boolean?` |
| `secure` | `boolean?` |
| `sameSite` | `("Strict" | "Lax" | "None")?` |
| `partitionKey` | `string?` |
| `_crHasCrossSiteAncestor` | `boolean?` |

### `SetOriginStorage` *(object)*

| Property | Type |
|----------|------|
| `origin` | `string` |
| `localStorage` | `Array<NameValue>` |
| `indexedDB` | `Array<IndexedDBDatabase>?` |

### `ShowActionsOptions` *(mixin)*

| Property | Type |
|----------|------|
| `duration` | `float?` |
| `position` | `("top-left" | "top" | "top-right" | "bottom-left" | "bottom" | "bottom-right")?` |
| `fontSize` | `int?` |
| `cursor` | `("none" | "pointer")?` |

### `StackFrame` *(object)*

| Property | Type |
|----------|------|
| `file` | `string` |
| `line` | `int` |
| `column` | `int` |
| `function` | `string?` |

### `URLPattern` *(object)*

| Property | Type |
|----------|------|
| `hash` | `string` |
| `hostname` | `string` |
| `password` | `string` |
| `pathname` | `string` |
| `port` | `string` |
| `protocol` | `string` |
| `search` | `string` |
| `username` | `string` |

### `VirtualCredential` *(object)*

| Property | Type |
|----------|------|
| `id` | `string` |
| `rpId` | `string` |
| `userHandle` | `string` |
| `privateKey` | `string` |
| `publicKey` | `string` |

### `WaitInfo` *(object)*

| Property | Type |
|----------|------|
| `waitId` | `string` |
| `phase` | `("before" | "after" | "log")` |
| `event` | `string?` |
| `message` | `string?` |
| `error` | `string?` |

---

# Enums

### `ConsoleMessagesFilter`

| Value |
|-------|
| `all` |
| `since-navigation` |

### `LifecycleEvent`

| Value |
|-------|
| `load` |
| `domcontentloaded` |
| `networkidle` |
| `commit` |

### `SDKLanguage`

| Value |
|-------|
| `javascript` |
| `python` |
| `java` |
| `csharp` |

