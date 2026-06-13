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
  Future<void> setExtraHTTPHeaders(Map<String, String> headers) async {
    final mappedHeaders = headers.entries
        .map((e) => NameValue(name: e.key, value: e.value))
        .toList();
    await super.channel_setExtraHTTPHeaders(headers: mappedHeaders);
  }

  Future<void> clearPermissions() async {
    await channel_clearPermissions();
  }

  Future<void> setGeolocation(Map<String, dynamic>? geolocation) async {
    await channel_setGeolocation(geolocation: geolocation);
  }

  Future<void> setHTTPCredentials(Map<String, dynamic>? httpCredentials) async {
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

  Future<void> setStorageState(Map<String, dynamic> storageState) async {
    await channel_setStorageState(storageState: storageState);
  }

  /// Adds a script which would be evaluated in one of the following scenarios:
  /// - Whenever a page is created in the browser context.
  /// - Whenever a child frame is attached or navigated in any page in the browser context.
  Future<void> addInitScript(String source) async {
    await channel_addInitScript(source: source);
  }

  Future<void> close({String? reason}) async {
    await channel_close(reason: reason);
  }

  Future<void> setNetworkInterceptionPatterns(
    List<Map<String, dynamic>> patterns,
  ) async {
    await channel_setNetworkInterceptionPatterns(patterns: patterns);
  }

  Future<void> pause() async {
    await channel_pause();
  }

  Future<void> clockFastForward({
    double? ticksNumber,
    String? ticksString,
  }) async {
    await channel_clockFastForward(
      ticksNumber: ticksNumber,
      ticksString: ticksString,
    );
  }

  Future<void> clockInstall({double? timeNumber, String? timeString}) async {
    await channel_clockInstall(timeNumber: timeNumber, timeString: timeString);
  }

  Future<void> clockPauseAt({double? timeNumber, String? timeString}) async {
    await channel_clockPauseAt(timeNumber: timeNumber, timeString: timeString);
  }

  Future<void> clockResume() async {
    await channel_clockResume();
  }

  Future<void> clockRunFor({double? ticksNumber, String? ticksString}) async {
    await channel_clockRunFor(
      ticksNumber: ticksNumber,
      ticksString: ticksString,
    );
  }

  Future<void> clockSetFixedTime({
    double? timeNumber,
    String? timeString,
  }) async {
    await channel_clockSetFixedTime(
      timeNumber: timeNumber,
      timeString: timeString,
    );
  }

  Future<void> clockSetSystemTime({
    double? timeNumber,
    String? timeString,
  }) async {
    await channel_clockSetSystemTime(
      timeNumber: timeNumber,
      timeString: timeString,
    );
  }

  Future<void> exposeBinding(String name) async {
    await channel_exposeBinding(name: name);
  }

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

  Future<void> setTestIdAttributeName(String testIdAttributeName) async {
    await channel_setTestIdAttributeName(
      testIdAttributeName: testIdAttributeName,
    );
  }

  Future<void> setWebSocketInterceptionPatterns(
    List<Map<String, dynamic>> patterns,
  ) async {
    await channel_setWebSocketInterceptionPatterns(patterns: patterns);
  }

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

  Future<void> disableRecorder() async {
    await channel_disableRecorder();
  }

  Future<void> exposeConsoleApi() async {
    await channel_exposeConsoleApi();
  }

  Future<dynamic> newCDPSession({Page? page, Frame? frame}) async {
    final result = await channel_newCDPSession(page: page, frame: frame);
    return result.session as CDPSession;
  }

  Future<BrowserContextCreateTempFilesResult> createTempFiles({
    String? rootDirName,
    required List<Map<String, dynamic>> items,
  }) async {
    return await channel_createTempFiles(
      rootDirName: rootDirName,
      items: items,
    );
  }

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
        {'glob': url},
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
