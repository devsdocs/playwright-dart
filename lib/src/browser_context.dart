import 'cdp_session.dart';
import 'frame.dart';
import 'page.dart';
import 'generated/channels.dart';
import 'route.dart';
import 'route_from_har.dart';

/// BrowserContexts provide a way to operate multiple independent browser sessions.
///
/// If a page opens another page, e.g. with a `window.open` call, the popup will belong to the parent page's browser context.
class BrowserContext extends BrowserContextBase {
  BrowserContext(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  /// Creates a new page in the browser context.
  Future<Page> newPage() async {
    final result = await super.channel_newPage();
    return result.page as Page;
  }

  /// Adds cookies into this browser context.
  ///
  /// All pages within this context will have these cookies installed.
  Future<void> addCookies(List<SetNetworkCookie> cookies) async {
    await super.channel_addCookies(cookies: cookies);
  }

  /// Clears context cookies.
  ///
  /// Optionally filter by [name], [domain], or [path] (exact strings or regex).
  Future<void> clearCookies({
    String? name,
    String? domain,
    String? path,
    String? nameRegexSource,
    String? nameRegexFlags,
    String? domainRegexSource,
    String? domainRegexFlags,
    String? pathRegexSource,
    String? pathRegexFlags,
  }) async {
    await super.channel_clearCookies(
      name: name,
      domain: domain,
      path: path,
      nameRegexSource: nameRegexSource,
      nameRegexFlags: nameRegexFlags,
      domainRegexSource: domainRegexSource,
      domainRegexFlags: domainRegexFlags,
      pathRegexSource: pathRegexSource,
      pathRegexFlags: pathRegexFlags,
    );
  }

  /// Returns the browser context cookies.
  ///
  /// If no [urls] are specified, this method returns cookies for all pages.
  Future<List<NetworkCookie>> cookies({List<String>? urls}) async {
    final result = await super.channel_cookies(urls: urls ?? []);
    return result.cookies;
  }

  /// Grants specified permissions to the browser context.
  ///
  /// If [origin] is specified, the permissions are granted only for the given origin.
  Future<void> grantPermissions(
    List<String> permissions, {
    String? origin,
  }) async {
    await super.channel_grantPermissions(
      permissions: permissions,
      origin: origin,
    );
  }

  /// The extra HTTP headers will be sent with every request the context initiates.
  Future<void> setExtraHTTPHeaders(List<NameValue> headers) async {
    await super.channel_setExtraHTTPHeaders(headers: headers);
  }

  /// Clears all permission overrides for the browser context.
  Future<void> clearPermissions() async {
    await channel_clearPermissions();
  }

  /// Sets the context's geolocation. Passing `null` clears the geolocation override.
  Future<void> setGeolocation(
    BrowserContextSetGeolocationGeolocation? geolocation,
  ) async {
    await channel_setGeolocation(geolocation: geolocation);
  }

  /// Sets HTTP credentials for all requests in this context.
  ///
  /// Passing `null` disables authentication.
  Future<void> setHTTPCredentials(
    BrowserContextSetHTTPCredentialsHttpCredentials? httpCredentials,
  ) async {
    await channel_setHTTPCredentials(httpCredentials: httpCredentials);
  }

  /// Emulates network being offline or online.
  Future<void> setOffline(bool offline) async {
    await channel_setOffline(offline: offline);
  }

  /// Returns storage state for this browser context, contains current cookies and local storage snapshot.
  Future<BrowserContextStorageStateResult> storageState({
    bool? indexedDB,
  }) async {
    final result = await channel_storageState(indexedDB: indexedDB);
    return result;
  }

  /// Restores the storage state from a previously captured state object.
  Future<void> setStorageState(
    BrowserContextSetStorageStateStorageState storageState,
  ) async {
    await channel_setStorageState(storageState: storageState);
  }

  /// Adds a script which would be evaluated in one of the following scenarios:
  /// - Whenever a page is created in the browser context.
  /// - Whenever a child frame is attached or navigated in any page in the browser context.
  Future<void> addInitScript(String source) async {
    await channel_addInitScript(source: source);
  }

  /// Closes the browser context. All pages that belong to this context will be closed.
  Future<void> close({String? reason}) async {
    await channel_close(reason: reason);
  }

  /// Sets the network interception patterns for this context.
  Future<void> setNetworkInterceptionPatterns(
    List<BrowserContextSetNetworkInterceptionPatternsPatternsItems> patterns,
  ) async {
    await channel_setNetworkInterceptionPatterns(patterns: patterns);
  }

  /// Pauses the context for debugging.
  Future<void> pause() async {
    await channel_pause();
  }

  /// Fast-forwards the clock by the specified amount of ticks.
  Future<void> clockFastForward({
    double? ticksNumber,
    String? ticksString,
  }) async {
    await channel_clockFastForward(
      ticksNumber: ticksNumber,
      ticksString: ticksString,
    );
  }

  /// Installs fake timers and optionally sets the clock to the specified time.
  Future<void> clockInstall({double? timeNumber, String? timeString}) async {
    await channel_clockInstall(timeNumber: timeNumber, timeString: timeString);
  }

  /// Pauses the clock at the specified time.
  Future<void> clockPauseAt({double? timeNumber, String? timeString}) async {
    await channel_clockPauseAt(timeNumber: timeNumber, timeString: timeString);
  }

  /// Resumes the clock after being paused.
  Future<void> clockResume() async {
    await channel_clockResume();
  }

  /// Advances the clock by the specified amount of ticks, firing any timers.
  Future<void> clockRunFor({double? ticksNumber, String? ticksString}) async {
    await channel_clockRunFor(
      ticksNumber: ticksNumber,
      ticksString: ticksString,
    );
  }

  /// Sets the clock to always return a fixed time.
  Future<void> clockSetFixedTime({
    double? timeNumber,
    String? timeString,
  }) async {
    await channel_clockSetFixedTime(
      timeNumber: timeNumber,
      timeString: timeString,
    );
  }

  /// Sets the system time but does not trigger any timers.
  Future<void> clockSetSystemTime({
    double? timeNumber,
    String? timeString,
  }) async {
    await channel_clockSetSystemTime(
      timeNumber: timeNumber,
      timeString: timeString,
    );
  }

  /// Exposes a binding with the given [name] to all pages in the context.
  Future<void> exposeBinding(String name) async {
    await channel_exposeBinding(name: name);
  }

  /// Registers a custom selector engine with the given [name] and [source].
  Future<void> registerSelectorEngine(
    String name,
    String source, {
    bool? contentScript,
    SelectorEngine? selectorEngine,
  }) async {
    await channel_registerSelectorEngine(
      selectorEngine:
          selectorEngine ??
          SelectorEngine(
            name: name,
            source: source,
            contentScript: contentScript,
          ),
    );
  }

  /// Changes the default test ID attribute used by `getByTestId()` locators.
  Future<void> setTestIdAttributeName(String testIdAttributeName) async {
    await channel_setTestIdAttributeName(
      testIdAttributeName: testIdAttributeName,
    );
  }

  /// Sets WebSocket interception patterns for this context.
  Future<void> setWebSocketInterceptionPatterns(
    List<BrowserContextSetWebSocketInterceptionPatternsPatternsItems> patterns,
  ) async {
    await channel_setWebSocketInterceptionPatterns(patterns: patterns);
  }

  /// Enables the Playwright recorder/codegen in the browser context.
  Future<void> enableRecorder({
    String? language,
    BrowserContextEnableRecorderModeEnum? mode,
    BrowserContextEnableRecorderRecorderModeEnum? recorderMode,
    bool? pauseOnNextStatement,
    String? testIdAttributeName,
    Map<String, dynamic>? launchOptions,
    Map<String, dynamic>? contextOptions,
    String? device,
    String? saveStorage,
    String? outputFile,
    bool? handleSIGINT,
    bool? omitCallTracking,
  }) async {
    await channel_enableRecorder(
      language: language,
      mode: mode,
      recorderMode: recorderMode,
      pauseOnNextStatement: pauseOnNextStatement,
      testIdAttributeName: testIdAttributeName,
      launchOptions: launchOptions,
      contextOptions: contextOptions,
      device: device,
      saveStorage: saveStorage,
      outputFile: outputFile,
      handleSIGINT: handleSIGINT,
      omitCallTracking: omitCallTracking,
    );
  }

  /// Disables the Playwright recorder.
  Future<void> disableRecorder() async {
    await channel_disableRecorder();
  }

  /// Exposes the Playwright console API into the browser context pages.
  Future<void> exposeConsoleApi() async {
    await channel_exposeConsoleApi();
  }

  /// Creates a new Chrome DevTools Protocol session for the given [page] or [frame].
  Future<dynamic> newCDPSession({Page? page, Frame? frame}) async {
    final result = await channel_newCDPSession(page: page, frame: frame);
    return result.session as CDPSession;
  }

  /// Creates temporary files that can be used with file inputs.
  Future<BrowserContextCreateTempFilesResult> createTempFiles({
    String? rootDirName,
    required List<BrowserContextCreateTempFilesItemsItems> items,
  }) async {
    return await channel_createTempFiles(
      rootDirName: rootDirName,
      items: items,
    );
  }

  /// Updates the subscription state for a specific event type in this context.
  Future<void> updateSubscription({
    required BrowserContextUpdateSubscriptionEventEnum event,
    required bool enabled,
  }) async {
    await channel_updateSubscription(event: event, enabled: enabled);
  }

  /// Routing provides the capability to modify network requests that are made by a context.
  Future<void> route(String url, Future<void> Function(Route) handler) async {
    await channel_setNetworkInterceptionPatterns(
      patterns: [
        BrowserContextSetNetworkInterceptionPatternsPatternsItems.fromJson({
          'glob': url,
        }),
      ],
    );

    onEvent.listen((event) async {
      if (event['event'] == 'route') {
        final params = event['params'] as Map<String, dynamic>;
        final routeObj = connection.objects[params['route']['guid']] as Route;
        final requestObj = routeObj.request;

        final matches = url == '**/*' || url == '*' || url.contains('*')
            ? true
            : requestObj.url.contains(url);

        if (matches) {
          await handler(routeObj);
        }
      }
    });
  }

  /// Removes a route previously set with [route].
  Future<void> unroute(
    String url, {
    Future<void> Function(Route route)? handler,
  }) async {
    // A simplified unroute that clears the glob pattern for now.
    await channel_setNetworkInterceptionPatterns(patterns: []);
  }

  /// Serves all requests matching the given [url] from the HAR file.
  Future<void> routeFromHAR(
    String harPath, {
    String? url,
    bool notFoundFallback = false,
  }) async {
    await sharedRouteFromHAR(
      this,
      harPath,
      url: url,
      notFoundFallback: notFoundFallback,
    );
  }
}
