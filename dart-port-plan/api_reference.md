# Playwright Dart — API Reference

Quick reference mapping between the Playwright Node.js API and the Dart port. All methods listed below are fully implemented and wired to the protocol.

---

## Entry Point

```dart
import 'package:playwright_dart/playwright_dart.dart';

final playwright = await Playwright.create();
```

| Node.js | Dart |
|---|---|
| `const { chromium } = require('playwright')` | `playwright.chromium` |
| `const { firefox } = require('playwright')` | `playwright.firefox` |
| `const { webkit } = require('playwright')` | `playwright.webkit` |

---

## BrowserType

| Node.js | Dart |
|---|---|
| `browserType.launch([options])` | `browserType.launch({headless, channel, ...})` |
| `browserType.launchPersistentContext(userDataDir)` | `browserType.launchPersistentContext(userDataDir, ...)` |
| `browserType.connect(wsEndpoint)` | `browserType.connect(wsEndpoint)` |
| `browserType.connectOverCDP({endpointURL})` | `browserType.connectOverCDP(endpointURL: ...)` |

---

## Browser

| Node.js | Dart |
|---|---|
| `browser.newContext([options])` | `browser.newContext({...})` |
| `browser.newPage([options])` | `browser.newPage({...})` |
| `browser.close()` | `browser.close()` |
| `browser.contexts` | `browser.contexts` |
| `browser.startTracing(page)` | `browser.startTracing(page: page)` |
| `browser.stopTracing()` | `browser.stopTracing()` |
| `browser.newBrowserCDPSession()` | `browser.newBrowserCDPSession()` |

---

## BrowserContext

| Node.js | Dart |
|---|---|
| `context.newPage()` | `context.newPage()` |
| `context.cookies([urls])` | `context.cookies({urls})` |
| `context.addCookies(cookies)` | `context.addCookies(cookies)` |
| `context.clearCookies()` | `context.clearCookies()` |
| `context.grantPermissions(permissions)` | `context.grantPermissions(permissions)` |
| `context.setGeolocation(geo)` | `context.setGeolocation(geo)` |
| `context.setHTTPCredentials(creds)` | `context.setHTTPCredentials(creds)` |
| `context.setExtraHTTPHeaders(headers)` | `context.setExtraHTTPHeaders(headers)` |
| `context.route(url, handler)` | `context.route(url, handler)` |
| `context.unroute(url)` | `context.unroute(url)` |
| `context.storageState()` | `context.storageState()` |
| `context.newCDPSession(page)` | `context.newCDPSession(page)` |
| `context.close()` | `context.close()` |

---

## Page

| Node.js | Dart |
|---|---|
| `page.goto(url)` | `page.goto(url)` |
| `page.close()` | `page.close()` |
| `page.evaluate(expr)` | `page.evaluate(expression)` |
| `page.evaluateHandle(expr)` | `page.evaluateHandle(expression)` |
| `page.screenshot([options])` | `page.screenshot({path, type, ...})` |
| `page.pdf([options])` | `page.pdf({path, ...})` |
| `page.title()` | `page.title()` |
| `page.content()` | `page.content()` |
| `page.setContent(html)` | `page.setContent(html)` |
| `page.waitForSelector(selector)` | `page.waitForSelector(selector)` |
| `page.waitForLoadState([state])` | `page.waitForLoadState({state})` |
| `page.waitForNavigation()` | `page.waitForNavigation()` |
| `page.waitForEvent(event)` | `page.waitForEvent(event)` |
| `page.route(url, handler)` | `page.route(url, handler)` |
| `page.unroute(url)` | `page.unroute(url)` |
| `page.emulateMedia({media})` | `page.emulateMedia({media, colorScheme})` |
| `page.setViewportSize({w,h})` | `page.setViewportSize(width, height)` |
| `page.bringToFront()` | `page.bringToFront()` |
| `page.addScriptTag({url})` | `page.addScriptTag({url, content})` |
| `page.addStyleTag({url})` | `page.addStyleTag({url, content})` |
| `page.opener()` | `page.opener()` |

### Page — Locator Shortcuts

| Node.js | Dart |
|---|---|
| `page.locator(selector)` | `page.locator(selector)` |
| `page.getByText(text)` | `page.getByText(text)` |
| `page.getByRole(role)` | `page.getByRole(role)` |
| `page.getByLabel(text)` | `page.getByLabel(text)` |
| `page.getByPlaceholder(text)` | `page.getByPlaceholder(text)` |
| `page.getByAltText(text)` | `page.getByAltText(text)` |
| `page.getByTitle(text)` | `page.getByTitle(text)` |
| `page.getByTestId(testId)` | `page.getByTestId(testId)` |

### Page — Input

| Node.js | Dart |
|---|---|
| `page.keyboard.down(key)` | `page.keyboard.down(key)` |
| `page.keyboard.up(key)` | `page.keyboard.up(key)` |
| `page.keyboard.press(key)` | `page.keyboard.press(key)` |
| `page.keyboard.type(text)` | `page.keyboard.type(text)` |
| `page.keyboard.insertText(text)` | `page.keyboard.insertText(text)` |
| `page.mouse.click(x, y)` | `page.mouse.click(x, y)` |
| `page.mouse.dblclick(x, y)` | `page.mouse.dblclick(x, y)` |
| `page.mouse.move(x, y)` | `page.mouse.move(x, y)` |
| `page.mouse.down()` | `page.mouse.down()` |
| `page.mouse.up()` | `page.mouse.up()` |
| `page.mouse.wheel(dx, dy)` | `page.mouse.wheel(deltaX, deltaY)` |

---

## Locator

| Node.js | Dart |
|---|---|
| `locator.click()` | `locator.click()` |
| `locator.fill(value)` | `locator.fill(value)` |
| `locator.check()` | `locator.check()` |
| `locator.uncheck()` | `locator.uncheck()` |
| `locator.hover()` | `locator.hover()` |
| `locator.focus()` | `locator.focus()` |
| `locator.blur()` | `locator.blur()` |
| `locator.dblclick()` | `locator.dblclick()` |
| `locator.tap()` | `locator.tap()` |
| `locator.press(key)` | `locator.press(key)` |
| `locator.type(text)` | `locator.type(text)` |
| `locator.selectOption(values)` | `locator.selectOption(values)` |
| `locator.setInputFiles(files)` | `locator.setInputFiles(files)` |
| `locator.getAttribute(name)` | `locator.getAttribute(name)` |
| `locator.innerText()` | `locator.innerText()` |
| `locator.textContent()` | `locator.textContent()` |
| `locator.innerHTML()` | `locator.innerHTML()` |
| `locator.inputValue()` | `locator.inputValue()` |
| `locator.isVisible()` | `locator.isVisible()` |
| `locator.isHidden()` | `locator.isHidden()` |
| `locator.isEnabled()` | `locator.isEnabled()` |
| `locator.isDisabled()` | `locator.isDisabled()` |
| `locator.isEditable()` | `locator.isEditable()` |
| `locator.isChecked()` | `locator.isChecked()` |
| `locator.waitFor()` | `locator.waitFor()` |
| `locator.dragTo(target)` | `locator.dragTo(target)` |
| `locator.evaluate(expr)` | `locator.evaluate(expression)` |
| `locator.evaluateAll(expr)` | `locator.evaluateAll(expression)` |

---

## Network

### Request

| Node.js | Dart |
|---|---|
| `request.response()` | `request.response()` |
| `request.rawRequestHeaders()` | `request.rawRequestHeaders()` |
| `request.sizes()` | `request.sizes()` |

### Response

| Node.js | Dart |
|---|---|
| `response.finished()` | `response.finished()` |
| `response.body()` | `response.body()` |
| `response.securityDetails()` | `response.securityDetails()` |
| `response.serverAddr()` | `response.serverAddr()` |

### Route

| Node.js | Dart |
|---|---|
| `route.abort()` | `route.abort()` |
| `route.continue()` | `route.continue_()` |
| `route.fulfill({status, body})` | `route.fulfill({status, body, contentType})` |
| `route.fallback()` | `route.fallback()` |

---

## Tracing

| Node.js | Dart |
|---|---|
| `tracing.start({screenshots})` | `tracing.tracingStart(...)` |
| `tracing.stop({path})` | `tracing.tracingStop(...)` |
| `tracing.startChunk()` | `tracing.tracingStartChunk(...)` |
| `tracing.stopChunk({path})` | `tracing.tracingStopChunk(...)` |

---

## CDPSession

| Node.js | Dart |
|---|---|
| `session.send(method, params)` | `session.send(method, params)` |
| `session.detach()` | `session.detach()` |

---

## Codebase Statistics

| Metric | Value |
|---|---|
| Total Dart source files | 48 (47 in `lib/src` + `channels.dart`) |
| Total lines of code | ~10,600 |
| Generated protocol code | ~6,100 lines (`channels.dart`) |
| Hand-written wrapper code | ~4,500 lines |
| Wrapper classes | 35 |
| Verified channel methods | 308 |
| Analyzer issues | 0 |
| Remaining TODOs | 0 |
| Placeholder stubs | 0 |
