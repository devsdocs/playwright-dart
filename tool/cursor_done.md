Compared against the original Playwright repo at `D:\Devs\App8\playwright`, I added the highest-impact missing APIs to `playwright-dart`, prioritized by everyday usefulness.

## Tier 1 — Locator (most used)

Added to `Locator`:
- `count()`, `all()`, `allInnerTexts()`, `allTextContents()`
- `clear()`, `setChecked()`, `pressSequentially()`
- `elementHandle()`, `elementHandles()`
- `boundingBox()`, `scrollIntoViewIfNeeded()`, `screenshot()`, `selectText()`
- `frameLocator()`, `describe()`, `normalize()`

## Tier 2 — Page / Frame / routing

- **Page:** `setChecked()`, `frame({name, url})`, `unroute()`, `unrouteAll()`
- **Frame:** `setChecked()`
- **Route handling:** new `RouteManager` / `RouteListener` — single listener, proper handler tracking (replaces the broken per-call listener pattern)
- **BrowserContext:** same routing fix + `unrouteAll()`

## Tier 3 — Context & Playwright entry points

- **BrowserContext:** `tracing`, `request`, `clock` getters (wired from protocol initializer)
- **Playwright:** `android`, `electron`, `devices` (device descriptor presets)
- **Browser:** `isConnected`, `browserType`
- **Clock:** new wrapper class delegating to existing context clock methods

## Tier 4 — Network & assertions

- **Route:** `fallback()` alias
- **Request / Response:** `headerValue()`, `headerValues()`
- **LocatorAssertions:** `toBeChecked()`, `toHaveCount()`

## Still not implemented (lower priority / protocol gaps)

| API | Reason |
|-----|--------|
| `BrowserType.launchServer()` | Node.js-only server launcher, not in the wire protocol |
| `exposeFunction()` with Dart callbacks | Needs callback bridge (like Node's binding system) |
| `setJavaScriptEnabled()` | Not exposed in generated channels |
| `Page.pause()`, WebStorage, Credentials | Tooling / niche |
| Full `LocatorAssertions` set | `toHaveScreenshot`, etc. |
| Electron/Android root wiring was present but not exported on `Playwright` — now fixed |

`dart analyze lib` passes with no issues.

Want me to continue with the next tier (`exposeFunction`, `routeWebSocket`, WebStorage, more assertions)?