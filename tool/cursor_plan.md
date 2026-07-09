# Playwright Client API Surface for Dart Porting

Source of truth: public interfaces in `D:\Devs\App8\playwright\packages\playwright-core\types\types.d.ts`, implemented in `D:\Devs\App8\playwright\packages\playwright-core\src\client\`.

**Priority legend**
- **CORE** — needed for a minimal usable automation library
- **HIGH** — common in real tests/apps
- **MEDIUM** — scenario-specific but important
- **LOW** — legacy, debugging, or niche

Event APIs (`on`/`once`/`waitForEvent`) are grouped once per class; in Dart you likely map these to `Stream`s (as `playwright-dart` already does).

---

## Tier 0 — Entry points

### `Playwright` (`playwright.ts`)
| API | Priority |
|-----|----------|
| `chromium`, `firefox`, `webkit` (`BrowserType`) | **CORE** |
| `request` (`APIRequest`) | **HIGH** |
| `selectors` (`Selectors`) | **HIGH** |
| `devices` (preset configs) | **MEDIUM** |
| `errors.TimeoutError` | **CORE** |
| `_android`, `_electron` (internal; public via `@playwright/test`) | **LOW** |

### `BrowserType` (`browserType.ts`)
| API | Priority |
|-----|----------|
| `launch()` | **CORE** |
| `launchPersistentContext(userDataDir)` | **HIGH** |
| `connect()` / `connect(wsEndpoint)` | **HIGH** |
| `name()`, `executablePath()` | **MEDIUM** |
| `connectOverCDP()` | **MEDIUM** |
| `launchServer()` | **MEDIUM** |
| `_connectToWorker()` | **LOW** |

### `Selectors` (`selectors.ts`)
| API | Priority |
|-----|----------|
| `setTestIdAttribute()` | **HIGH** |
| `register()` (custom selector engines) | **MEDIUM** |

---

## Tier 1 — Browser lifecycle

### `Browser` (`browser.ts`)
| API | Priority |
|-----|----------|
| `newContext()` | **CORE** |
| `newPage()` (convenience) | **HIGH** |
| `contexts()` | **CORE** |
| `close()` | **CORE** |
| `isConnected()` | **HIGH** |
| `browserType()` | **MEDIUM** |
| `version()` | **MEDIUM** |
| `newBrowserCDPSession()` | **MEDIUM** (Chromium) |
| `startTracing()` / `stopTracing()` | **MEDIUM** |
| `bind()` / `unbind()` (remote server sharing) | **LOW** |
| Events: `context`, `disconnected` | **HIGH** |

### `BrowserContext` (`browserContext.ts`)
| API | Priority |
|-----|----------|
| `newPage()` | **CORE** |
| `pages()` | **CORE** |
| `close()` | **CORE** |
| `cookies()` / `addCookies()` / `clearCookies()` | **HIGH** |
| `storageState()` / `setStorageState()` | **HIGH** |
| `route()` / `unroute()` / `unrouteAll()` | **HIGH** |
| `setDefaultTimeout()` / `setDefaultNavigationTimeout()` | **CORE** |
| `setExtraHTTPHeaders()` | **HIGH** |
| `setGeolocation()` / `setOffline()` / `setHTTPCredentials()` | **HIGH** |
| `grantPermissions()` / `clearPermissions()` | **MEDIUM** |
| `addInitScript()` | **HIGH** |
| `exposeFunction()` / `exposeBinding()` | **MEDIUM** |
| `routeFromHAR()` / `routeWebSocket()` | **MEDIUM** |
| `newCDPSession(page\|frame)` | **MEDIUM** |
| `browser()`, `isClosed()` | **CORE** |
| `backgroundPages()`, `serviceWorkers()` | **LOW** |
| Events: `page`, `close`, `dialog`, `request`, `response`, `download`, `console` | **HIGH** |
| Events: `requestfailed`, `requestfinished`, `frame*`, `serviceworker`, `weberror` | **MEDIUM** |

**Properties:** `request` (`APIRequestContext`), `tracing` (`Tracing`), `clock` (`Clock`) — **MEDIUM/HIGH**

---

## Tier 2 — Page & Frame (navigation + selector shortcuts)

### `Page` (`page.ts`) — mirrors `Frame` for most actions on main frame

#### CORE
| API |
|-----|
| `goto()`, `reload()`, `goBack()`, `goForward()` |
| `waitForLoadState()`, `waitForURL()`, `waitForNavigation()` |
| `title()`, `url()`, `content()`, `setContent()` |
| `locator()`, `getByRole()`, `getByText()`, `getByLabel()`, `getByPlaceholder()`, `getByTestId()`, `getByAltText()`, `getByTitle()` |
| `frameLocator()` |
| `mainFrame()`, `frames()`, `frame()`, `context()` |
| `close()`, `isClosed()` |
| `setDefaultTimeout()`, `setDefaultNavigationTimeout()` |
| `evaluate()`, `evaluateHandle()` |
| `screenshot()` |
| `setViewportSize()`, `viewportSize()` |
| Selector shortcuts: `click()`, `fill()`, `check()`, `uncheck()`, `hover()`, `press()`, `selectOption()`, `setInputFiles()` |
| Properties: `keyboard`, `mouse`, `touchscreen` |

#### HIGH
| API |
|-----|
| `waitForRequest()`, `waitForResponse()`, `waitForSelector()`, `waitForFunction()`, `waitForTimeout()` |
| `route()`, `unroute()`, `unrouteAll()`, `routeFromHAR()` |
| `addInitScript()`, `exposeFunction()` |
| `emulateMedia()` |
| `pdf()` |
| `dragAndDrop()`, `dispatchEvent()`, `setChecked()` |
| `isVisible()`, `isHidden()`, `isEnabled()`, `isDisabled()`, `isChecked()`, `isEditable()` |
| `getAttribute()`, `innerText()`, `innerHTML()`, `inputValue()`, `textContent()` |
| `addScriptTag()`, `addStyleTag()` |
| `setExtraHTTPHeaders()` |
| `video()` |
| `workers()`, `opener()` |
| `dblclick()`, `tap()`, `type()`, `focus()` |
| Events: `close`, `dialog`, `download`, `popup`, `request`, `response`, `console`, `pageerror`, `filechooser` |

#### MEDIUM
| API |
|-----|
| `exposeBinding()`, `addLocatorHandler()`, `removeLocatorHandler()` |
| `routeWebSocket()` |
| `ariaSnapshot()` |
| `bringToFront()` |
| `requests()` |
| `consoleMessages()`, `pageErrors()`, `clearConsoleMessages()`, `clearPageErrors()` |
| `waitForEvent()` |
| Properties: `request`, `clock`, `coverage`, `localStorage`, `sessionStorage`, `screencast` |

#### LOW (legacy / tooling)
| API |
|-----|
| `$()`, `$$()`, `$eval()`, `$$eval()` — deprecated vs locators |
| `pickLocator()`, `cancelPickLocator()`, `hideHighlight()` |
| `pause()` (inspector) |
| `requestGC()` |
| Events: `crash`, `websocket`, `worker`, `frame*`, `load`, `domcontentloaded` |

---

### `Frame` (`frame.ts`)
Nearly the same surface as `Page` minus page-only APIs. Frame-specific:

| API | Priority |
|-----|----------|
| `page()`, `parentFrame()`, `childFrames()`, `name()`, `url()`, `isDetached()` | **CORE/HIGH** |
| `frameElement()` | **MEDIUM** |
| All selector/locator/interaction methods (parallel to Page) | **CORE/HIGH** |
| `evaluate()`, `evaluateHandle()`, `waitForFunction()` | **HIGH** |
| `$()`, `$$()`, `$eval()`, `$$eval()` | **LOW** |

---

## Tier 3 — Locator (primary interaction model)

### `Locator` (`locator.ts`) — **most important class for modern Playwright**

#### CORE
| API |
|-----|
| **Actions:** `click()`, `fill()`, `check()`, `uncheck()`, `press()`, `hover()`, `focus()` |
| **Queries:** `textContent()`, `innerText()`, `innerHTML()`, `inputValue()`, `getAttribute()` |
| **State:** `isVisible()`, `isHidden()`, `isEnabled()`, `isDisabled()`, `isChecked()`, `isEditable()` |
| **Chaining:** `locator()`, `first()`, `last()`, `nth()`, `filter()` |
| **Built-ins:** `getByRole()`, `getByText()`, `getByLabel()`, `getByPlaceholder()`, `getByTestId()`, `getByAltText()`, `getByTitle()` |
| `waitFor()` |
| `count()` |

#### HIGH
| API |
|-----|
| `selectOption()`, `setInputFiles()`, `setChecked()`, `clear()` |
| `dblclick()`, `tap()`, `type()`, `pressSequentially()` |
| `dragTo()`, `drop()`, `dispatchEvent()` |
| `scrollIntoViewIfNeeded()`, `boundingBox()` |
| `screenshot()` |
| `and()`, `or()`, `all()`, `allInnerTexts()`, `allTextContents()` |
| `frameLocator()`, `contentFrame()` |
| `evaluate()`, `evaluateHandle()`, `evaluateAll()` |
| `page()` |

#### MEDIUM
| API |
|-----|
| `ariaSnapshot()`, `blur()`, `selectText()` |
| `elementHandle()`, `elementHandles()` |
| `describe()`, `description()`, `normalize()` |
| `highlight()`, `hideHighlight()` |

#### LOW
| API |
|-----|
| `toString()` |

### `FrameLocator` (`locator.ts` / `FrameLocator` interface)
| API | Priority |
|-----|----------|
| `locator()`, all `getBy*` methods, `frameLocator()` | **HIGH** |
| `owner()` | **MEDIUM** |
| `first()`, `last()`, `nth()` | **LOW** (deprecated; use `locator.nth()` + `contentFrame()`) |

---

## Tier 4 — Handles (legacy but still referenced)

### `JSHandle` (`jsHandle.ts`)
| API | Priority |
|-----|----------|
| `evaluate()`, `evaluateHandle()` | **HIGH** |
| `jsonValue()`, `dispose()` | **HIGH** |
| `getProperty()`, `getProperties()` | **MEDIUM** |
| `asElement()` | **MEDIUM** |

### `ElementHandle` (`elementHandle.ts`) — Playwright discourages these vs Locators
| API | Priority |
|-----|----------|
| Same interaction set as Locator (click, fill, hover, etc.) | **MEDIUM** (compat) |
| `ownerFrame()`, `contentFrame()` | **MEDIUM** |
| `boundingBox()`, `screenshot()`, `scrollIntoViewIfNeeded()` | **MEDIUM** |
| `waitForElementState()`, `waitForSelector()` | **MEDIUM** |
| `$()`, `$$()`, `$eval()`, `$$eval()` | **LOW** |

---

## Tier 5 — Input devices

### `Keyboard` (`input.ts`) — **HIGH**
`down()`, `up()`, `insertText()`, `type()`, `press()`

### `Mouse` (`input.ts`) — **HIGH**
`move()`, `down()`, `up()`, `click()`, `dblclick()`, `wheel()`

### `Touchscreen` (`input.ts`) — **MEDIUM**
`tap(x, y)`

---

## Tier 6 — Network

### `Request` (`network.ts`) — **HIGH**
`url()`, `method()`, `headers()`, `postData()`, `response()`, `frame()`, `isNavigationRequest()`, `redirectedFrom()`, `redirectedTo()`, `failure()`, `timing()`, `sizes()`, `serviceWorker()`, `allHeaders()`, `headerValue()`, `headerValues()`

### `Response` — **HIGH**
`url()`, `status()`, `statusText()`, `ok()`, `headers()`, `body()`, `text()`, `json()`, `finished()`, `frame()`, `fromServiceWorker()`, `securityDetails()`, `serverAddr()`, `allHeaders()`, `headerValue()`, `headerValues()`

### `Route` — **HIGH**
`abort()`, `continue()`, `fallback()`, `fulfill()`, `request()`

### `WebSocket` — **MEDIUM**
`url()`, `waitForEvent('close'|'framereceived'|'framesent')`

### `WebSocketRoute` — **MEDIUM**
`connectToServer()`, `send()`, `close()`, `onMessage()`, `onClose()`, `url()`, `protocols()`

### `APIRequest` / `APIRequestContext` / `APIResponse` (`fetch.ts`) — **HIGH**
- `APIRequest.newContext()`
- `APIRequestContext`: `get`, `post`, `put`, `patch`, `delete`, `head`, `fetch`, `storageState`, `dispose`
- `APIResponse`: `status`, `headers`, `body`, `text`, `json`, `ok`, `url`, `dispose`

---

## Tier 7 — Supporting types

| Class | Key APIs | Priority |
|-------|----------|----------|
| **Dialog** | `accept()`, `dismiss()`, `message()`, `type()`, `defaultValue()` | **HIGH** |
| **Download** | `path()`, `saveAs()`, `delete()`, `failure()`, `url()`, `suggestedFilename()` | **HIGH** |
| **FileChooser** | `setFiles()`, `element()`, `page()`, `isMultiple()` | **MEDIUM** |
| **ConsoleMessage** | `text()`, `type()`, `args()`, `location()`, `page()`, `worker()` | **HIGH** |
| **Video** | `path()`, `delete()`, `saveAs()` | **MEDIUM** |
| **Worker** | `url()`, `evaluate()`, `evaluateHandle()` + events | **MEDIUM** |
| **CDPSession** | `send()`, `detach()` + `event` stream | **MEDIUM** |
| **Tracing** | `start()`, `stop()`, `group()`, `groupEnd()`, `startChunk()`, `stopChunk()` | **MEDIUM** |
| **Clock** | `install()`, `fastForward()`, `pauseAt()`, `resume()`, `runFor()`, `setFixedTime()`, `setSystemTime()` | **MEDIUM** |
| **Coverage** | `startJSCoverage()`, `stopJSCoverage()`, `startCSSCoverage()`, `stopCSSCoverage()` | **LOW** (Chromium) |
| **WebStorage** | `getItem()`, `setItem()`, `removeItem()`, `clear()`, `items()` | **MEDIUM** |
| **Screencast** | `start()`, `stop()`, `showActions()`, `hideActions()`, overlays | **LOW** |
| **Credentials** (WebAuthn) | `create()`, `get()`, `list()`, `delete()`, `enable()`, `disable()` | **LOW** |
| **Debugger** | `next()`, `resume()`, `pauseOnNextStatement()`, `pausedDetails()` | **LOW** |
| **WebError** | `page()`, `error()` | **MEDIUM** |
| **BrowserServer** | `wsEndpoint()`, `close()`, `kill()`, `process()` | **MEDIUM** |
| **Disposable** | `[Symbol.asyncDispose]()` / `dispose()` pattern | **MEDIUM** |

---

## Tier 8 — Platform-specific (defer unless targeting those platforms)

| Class | Priority |
|-------|----------|
| **Electron** / **ElectronApplication** | **LOW** |
| **Android** / **AndroidDevice** / **AndroidInput** / **AndroidSocket** / **AndroidWebView** | **LOW** |

---

## Recommended port phases

### Phase 1 — CORE (MVP)
`BrowserType.launch` → `Browser.newContext` → `BrowserContext.newPage` → `Page.goto` → `Locator` actions (`click`, `fill`, `getBy*`) → waits (`waitForLoadState`, `waitForURL`, `locator.waitFor`) → `screenshot` → `close` → `evaluate`

### Phase 2 — HIGH (production-ready)
Network routing (`route`, `Request`/`Response`), cookies/storage state, dialogs/downloads, keyboard/mouse, frames/iframes (`frameLocator`, `contentFrame`), `APIRequestContext`, events/streams, PDF, file uploads, permissions/geo/offline

### Phase 3 — MEDIUM
CDP session, tracing, clock mocking, HAR routing, WebSocket routing, locator handlers, `exposeBinding`, `ariaSnapshot`, touch, video artifacts

### Phase 4 — LOW / compat
ElementHandle legacy API, `$`/`$$`, inspector (`pause`, `pickLocator`), coverage, screencast, Electron/Android, WebAuthn credentials, browser `bind`/`unbind`

---

## `playwright-dart` coverage snapshot

Your Dart port (`D:\Devs\App8\playwright-dart\lib\`) already implements a solid **Phase 1–2 subset**:

- **Done:** launch/context/page lifecycle, navigation, locators + getBy*, most selector shortcuts, screenshot/PDF, routing basics, cookies/storage, keyboard/mouse/touchscreen, CDPSession, many events as Streams
- **Partial:** Frame API, Locator (missing `dragTo`, `drop`, `pressSequentially`, `evaluateAll`, `ariaSnapshot`, etc.)
- **Missing / gaps vs upstream:** `$`/`$$`/`$eval`, `exposeFunction`/`exposeBinding`, `addLocatorHandler`, `waitForEvent`, Page `request` property, `clock`/`coverage`/`screencast`/`localStorage`/`sessionStorage`, `pickLocator`/`pause`, full `Tracing`/`WebSocketRoute`, platform APIs

---

## File reference map

| Class | Client impl | Public types |
|-------|-------------|--------------|
| Page | `...\client\page.ts` | `types.d.ts` L84–5342 |
| Frame | `...\client\frame.ts` | L5379–8226 |
| BrowserContext | `...\client\browserContext.ts` | L8228–10012 |
| Browser | `...\client\browser.ts` | L10013–10775 |
| Locator / FrameLocator | `...\client\locator.ts` | L12791–15403, L19443+ |
| ElementHandle / JSHandle | `...\client\elementHandle.ts`, `jsHandle.ts` | L10961–12790 |
| BrowserType | `...\client\browserType.ts` | L15404+ |
| Network | `...\client\network.ts` | L20274+ |
| API testing | `...\client\fetch.ts` | L17331+ |

If you want, I can turn this into a checklist mapped 1:1 against your existing Dart interfaces in Agent mode.