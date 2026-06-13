## 0.1.1

Dependencies bump

## 0.1.0

Initial release — complete Dart SDK for Playwright with full API parity to Node.js `v1.60.0`.

### Features

- **Browser Automation**: Launch and control Chromium, Firefox, and WebKit browsers
- **Page Interactions**: Navigate, evaluate JavaScript, take screenshots, generate PDFs
- **Locator API**: 30+ interaction methods with 7 sub-locator strategies (`getByRole`, `getByText`, `getByLabel`, `getByPlaceholder`, `getByAltText`, `getByTitle`, `getByTestId`)
- **Network Interception**: Intercept, mock, and modify network requests with `route.abort()`, `route.fulfill()`, `route.continue_()`
- **Input Simulation**: Full keyboard and mouse input support (`keyboard.type()`, `mouse.click()`, etc.)
- **Tracing**: Record and export traces for debugging with the Playwright Trace Viewer
- **CDP Session**: Direct Chrome DevTools Protocol access for advanced manipulation

- **35 wrapper classes** covering 100% of the Playwright protocol (308 channel methods)
- **Auto-download**: Automatic Playwright driver and browser binary management

### Platform Support

- Windows, macOS, Linux
- Dart SDK `^3.12.0`
