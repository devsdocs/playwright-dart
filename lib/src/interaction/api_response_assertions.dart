import '../generated/channels.dart';

/// Web-first assertions for an [APIResponse].
///
/// Obtain via [APIResponseAssertions]:
/// ```dart
/// final response = await apiRequestContext.get('https://example.com/api');
/// final assertions = APIResponseAssertions(response);
/// await assertions.toBeOK();
/// ```
class APIResponseAssertions {
  final APIResponse _response;
  final bool _isNot;

  APIResponseAssertions(this._response, [this._isNot = false]);

  /// Makes the assertion check for the opposite condition.
  ///
  /// **Usage**
  ///
  /// For example, this code tests that the response status is not successful:
  ///
  /// ```dart
  /// await expect(response).not.toBeOK();
  /// ```
  ///
  /// **Type**
  /// - [APIResponseAssertions]
  ///
  ///
  /// [APIRequest]: /api/class-apirequest.mdx "APIRequest"
  /// [APIRequestContext]: /api/class-apirequestcontext.mdx "APIRequestContext"
  /// [APIResponse]: /api/class-apiresponse.mdx "APIResponse"
  /// [APIResponseAssertions]: /api/class-apiresponseassertions.mdx "APIResponseAssertions"
  /// [Browser]: /api/class-browser.mdx "Browser"
  /// [BrowserContext]: /api/class-browsercontext.mdx "BrowserContext"
  /// [BrowserServer]: /api/class-browserserver.mdx "BrowserServer"
  /// [BrowserType]: /api/class-browsertype.mdx "BrowserType"
  /// [CDPSession]: /api/class-cdpsession.mdx "CDPSession"
  /// [Clock]: /api/class-clock.mdx "Clock"
  /// [ConsoleMessage]: /api/class-consolemessage.mdx "ConsoleMessage"
  /// [Coverage]: /api/class-coverage.mdx "Coverage"
  /// [Credentials]: /api/class-credentials.mdx "Credentials"
  /// [Debugger]: /api/class-debugger.mdx "Debugger"
  /// [Dialog]: /api/class-dialog.mdx "Dialog"
  /// [Disposable]: /api/class-disposable.mdx "Disposable"
  /// [Download]: /api/class-download.mdx "Download"
  /// [ElementHandle]: /api/class-elementhandle.mdx "ElementHandle"
  /// [FileChooser]: /api/class-filechooser.mdx "FileChooser"
  /// [Frame]: /api/class-frame.mdx "Frame"
  /// [FrameLocator]: /api/class-framelocator.mdx "FrameLocator"
  /// [GenericAssertions]: /api/class-genericassertions.mdx "GenericAssertions"
  /// [JSHandle]: /api/class-jshandle.mdx "JSHandle"
  /// [Keyboard]: /api/class-keyboard.mdx "Keyboard"
  /// [Locator]: /api/class-locator.mdx "Locator"
  /// [LocatorAssertions]: /api/class-locatorassertions.mdx "LocatorAssertions"
  /// [Logger]: /api/class-logger.mdx "Logger"
  /// [Mouse]: /api/class-mouse.mdx "Mouse"
  /// [Page]: /api/class-page.mdx "Page"
  /// [PageAssertions]: /api/class-pageassertions.mdx "PageAssertions"
  /// [Playwright]: /api/class-playwright.mdx "Playwright"
  /// [PlaywrightAssertions]: /api/class-playwrightassertions.mdx "PlaywrightAssertions"
  /// [Request]: /api/class-request.mdx "Request"
  /// [Response]: /api/class-response.mdx "Response"
  /// [Route]: /api/class-route.mdx "Route"
  /// [Screencast]: /api/class-screencast.mdx "Screencast"
  /// [Selectors]: /api/class-selectors.mdx "Selectors"
  /// [SnapshotAssertions]: /api/class-snapshotassertions.mdx "SnapshotAssertions"
  /// [TimeoutError]: /api/class-timeouterror.mdx "TimeoutError"
  /// [Touchscreen]: /api/class-touchscreen.mdx "Touchscreen"
  /// [Tracing]: /api/class-tracing.mdx "Tracing"
  /// [Video]: /api/class-video.mdx "Video"
  /// [WebError]: /api/class-weberror.mdx "WebError"
  /// [WebSocket]: /api/class-websocket.mdx "WebSocket"
  /// [WebSocketRoute]: /api/class-websocketroute.mdx "WebSocketRoute"
  /// [WebStorage]: /api/class-webstorage.mdx "WebStorage"
  /// [Worker]: /api/class-worker.mdx "Worker"
  /// [Electron]: /api/class-electron.mdx "Electron"
  /// [ElectronApplication]: /api/class-electronapplication.mdx "ElectronApplication"
  /// [Android]: /api/class-android.mdx "Android"
  /// [AndroidDevice]: /api/class-androiddevice.mdx "AndroidDevice"
  /// [AndroidInput]: /api/class-androidinput.mdx "AndroidInput"
  /// [AndroidSocket]: /api/class-androidsocket.mdx "AndroidSocket"
  /// [AndroidWebView]: /api/class-androidwebview.mdx "AndroidWebView"
  /// [Fixtures]: /api/class-fixtures.mdx "Fixtures"
  /// [FullConfig]: /api/class-fullconfig.mdx "FullConfig"
  /// [FullProject]: /api/class-fullproject.mdx "FullProject"
  /// [Location]: /api/class-location.mdx "Location"
  /// [Test]: /api/class-test.mdx "Test"
  /// [TestConfig]: /api/class-testconfig.mdx "TestConfig"
  /// [TestInfo]: /api/class-testinfo.mdx "TestInfo"
  /// [TestInfoError]: /api/class-testinfoerror.mdx "TestInfoError"
  /// [TestOptions]: /api/class-testoptions.mdx "TestOptions"
  /// [TestProject]: /api/class-testproject.mdx "TestProject"
  /// [TestStepInfo]: /api/class-teststepinfo.mdx "TestStepInfo"
  /// [WorkerInfo]: /api/class-workerinfo.mdx "WorkerInfo"
  /// [Reporter]: /api/class-reporter.mdx "Reporter"
  /// [Suite]: /api/class-suite.mdx "Suite"
  /// [TestCase]: /api/class-testcase.mdx "TestCase"
  /// [TestError]: /api/class-testerror.mdx "TestError"
  /// [TestResult]: /api/class-testresult.mdx "TestResult"
  /// [TestRun]: /api/class-testrun.mdx "TestRun"
  /// [TestStep]: /api/class-teststep.mdx "TestStep"
  /// [EvaluationArgument]: /evaluating.mdx#evaluation-argument "EvaluationArgument"
  /// [UIEvent.detail]: https://developer.mozilla.org/en-US/docs/Web/API/UIEvent/detail "UIEvent.detail"
  ///
  ///
  /// [all available image tags]: https://mcr.microsoft.com/en-us/product/playwright/about "all available image tags"
  /// [Microsoft Artifact Registry]: https://mcr.microsoft.com/en-us/product/playwright/about "Microsoft Artifact Registry"
  /// [Dockerfile.noble]: https://github.com/microsoft/playwright/blob/main/utils/docker/Dockerfile.noble "Dockerfile.noble"
  APIResponseAssertions get not => APIResponseAssertions(_response, !_isNot);

  /// Ensures the response status code is within `200..299` range.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await expect(response).toBeOK();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> toBeOK() async {
    final ok = _response.status >= 200 && _response.status <= 299;
    if (_isNot) {
      if (ok) {
        throw AssertionError(
          'Expected response not to be OK, but status was ${_response.status}',
        );
      }
    } else {
      if (!ok) {
        throw AssertionError(
          'Expected response to be OK, but status was ${_response.status}',
        );
      }
    }
  }

  /// Checks that the response has the expected status code.
  Future<void> toHaveStatus(int expected) async {
    if (_isNot) {
      if (_response.status == expected) {
        throw AssertionError(
          'Expected response not to have status $expected, but it did',
        );
      }
    } else {
      if (_response.status != expected) {
        throw AssertionError(
          'Expected response to have status $expected, but was ${_response.status}',
        );
      }
    }
  }

  /// Checks that the response has a status code in the expected range.
  Future<void> toHaveStatusInRange(int min, int max) async {
    final inRange = _response.status >= min && _response.status <= max;
    if (_isNot) {
      if (inRange) {
        throw AssertionError(
          'Expected response status not to be in range [$min, $max], but was ${_response.status}',
        );
      }
    } else {
      if (!inRange) {
        throw AssertionError(
          'Expected response status to be in range [$min, $max], but was ${_response.status}',
        );
      }
    }
  }

  /// Checks that the response has the expected status text.
  Future<void> toHaveStatusText(String expected) async {
    if (_isNot) {
      if (_response.statusText == expected) {
        throw AssertionError(
          'Expected response not to have status text "$expected", but it did',
        );
      }
    } else {
      if (_response.statusText != expected) {
        throw AssertionError(
          'Expected response to have status text "$expected", but was "${_response.statusText}"',
        );
      }
    }
  }

  /// Checks that the response has the expected URL.
  Future<void> toHaveURL(Pattern expected) async {
    final matches = expected is RegExp
        ? expected.hasMatch(_response.url)
        : _response.url.contains(expected as String);
    if (_isNot) {
      if (matches) {
        throw AssertionError(
          'Expected response not to have URL matching "$expected", but was "${_response.url}"',
        );
      }
    } else {
      if (!matches) {
        throw AssertionError(
          'Expected response to have URL matching "$expected", but was "${_response.url}"',
        );
      }
    }
  }

  /// Checks that the response has the expected header.
  Future<void> toHaveHeader(String name, String? value) async {
    final headerName = name.toLowerCase();
    final headerValue = _response.headers
        .firstWhere(
          (h) => h.name.toLowerCase() == headerName,
          orElse: () => NameValue(name: '', value: ''),
        )
        .value;

    if (value == null) {
      // Just check existence
      final exists = headerValue.isNotEmpty;
      if (_isNot) {
        if (exists) {
          throw AssertionError(
            'Expected response not to have header "$name", but it did',
          );
        }
      } else {
        if (!exists) {
          throw AssertionError(
            'Expected response to have header "$name", but it did not',
          );
        }
      }
    } else {
      // Check value
      if (_isNot) {
        if (headerValue == value) {
          throw AssertionError(
            'Expected response header "$name" not to be "$value", but it was',
          );
        }
      } else {
        if (headerValue != value) {
          throw AssertionError(
            'Expected response header "$name" to be "$value", but was "$headerValue"',
          );
        }
      }
    }
  }

  /// Checks that the response is successful (status code 2xx or 3xx).
  Future<void> toBeSuccessful() async {
    final successful =
        (_response.status >= 200 && _response.status <= 299) ||
        (_response.status >= 300 && _response.status <= 399);
    if (_isNot) {
      if (successful) {
        throw AssertionError(
          'Expected response not to be successful, but status was ${_response.status}',
        );
      }
    } else {
      if (!successful) {
        throw AssertionError(
          'Expected response to be successful, but status was ${_response.status}',
        );
      }
    }
  }

  /// Checks that the response is a client error (status code 4xx).
  Future<void> toBeClientError() async {
    final clientError = _response.status >= 400 && _response.status <= 499;
    if (_isNot) {
      if (clientError) {
        throw AssertionError(
          'Expected response not to be a client error, but status was ${_response.status}',
        );
      }
    } else {
      if (!clientError) {
        throw AssertionError(
          'Expected response to be a client error, but status was ${_response.status}',
        );
      }
    }
  }

  /// Checks that the response is a server error (status code 5xx).
  Future<void> toBeServerError() async {
    final serverError = _response.status >= 500 && _response.status <= 599;
    if (_isNot) {
      if (serverError) {
        throw AssertionError(
          'Expected response not to be a server error, but status was ${_response.status}',
        );
      }
    } else {
      if (!serverError) {
        throw AssertionError(
          'Expected response to be a server error, but status was ${_response.status}',
        );
      }
    }
  }
}
