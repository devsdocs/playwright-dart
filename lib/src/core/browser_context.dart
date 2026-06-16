import '../debugging/binding_call.dart';

import '../interaction/dialog.dart';

import '../network/websocket_route.dart';

import '../utils/worker.dart';

import '../utils/cdp_session.dart';

import '../utils/tracing.dart';

import '../utils/clock.dart';

import '../network/api_request_context.dart';

import '../network/route_handler.dart';

import '../infrastructure/channel_owner.dart';

import 'frame.dart';

import 'page.dart';

import 'browser.dart';

import '../generated/channels.dart';

import '../network/route.dart';

import '../network/route_from_har.dart';

import '../network/request.dart';

import '../utils/logger.dart';

/// BrowserContexts provide a way to operate multiple independent browser sessions.

///

/// If a page opens another page, e.g. with a `window.open` call, the popup will belong to the parent page's browser context.

/// Interface for BrowserContext

abstract interface class BrowserContext {
  /// The browser that this context belongs to.
  Browser? get browser;

  /// Tracing API for this context.
  Tracing get tracing;

  /// API request context for this context.
  APIRequestContext get request;

  /// Clock API for this context.
  Clock get clock;

  /// Stream that emits recorder events.
  Stream<Map<String, dynamic>> get onRecorderEvent;

  /// Stream that emits when a response is received.
  Stream<Map<String, dynamic>> get onResponse;

  /// Stream that emits when a request finishes.
  Stream<Map<String, dynamic>> get onRequestFinished;

  /// Stream that emits when a request fails.
  Stream<Map<String, dynamic>> get onRequestFailed;

  /// Stream that emits when a request is made.
  Stream<Map<String, dynamic>> get onRequest;

  /// Stream that emits when a service worker is created.
  Stream<Worker> get onServiceWorker;

  /// Stream that emits when a WebSocket route is created.
  Stream<WebSocketRoute> get onWebSocketRoute;

  /// Stream that emits when a route is created.
  Stream<Route> get onRoute;

  /// Stream that emits when a page error occurs.
  Stream<Map<String, dynamic>> get onPageError;

  /// Stream that emits when a new page is created.
  Stream<Page> get onPage;

  /// Stream that emits when a dialog is shown.
  Stream<Dialog> get onDialog;

  /// Stream that emits when the context is closed.
  Stream<BrowserContext> get onClose;

  /// Stream that emits when a console message is logged.
  Stream<Map<String, dynamic>> get onConsole;

  /// Stream that emits when a binding call is made.
  Stream<BindingCall> get onBindingCall;

  /// All pages in this context.
  List<Page> get pages;

  /// Creates a new page in this context.
  Future<Page> newPage();

  /// Adds cookies to this context.
  Future<void> addCookies(List<SetNetworkCookie> cookies);

  /// Clears cookies from this context.
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
  });

  /// Returns cookies from this context.
  Future<List<NetworkCookie>> cookies({List<String>? urls});

  /// Grants permissions to this context.
  Future<void> grantPermissions(List<String> permissions, {String? origin});

  /// Sets extra HTTP headers for this context.
  Future<void> setExtraHTTPHeaders(List<NameValue> headers);

  /// Clears all permission overrides for this context.
  Future<void> clearPermissions();

  /// Sets the geolocation for this context.
  Future<void> setGeolocation(
    BrowserContextSetGeolocationGeolocation? geolocation,
  );

  /// Sets HTTP credentials for this context.
  Future<void> setHTTPCredentials(
    BrowserContextSetHTTPCredentialsHttpCredentials? httpCredentials,
  );

  /// Sets the offline mode for this context.
  Future<void> setOffline(bool offline);

  /// Returns the storage state for this context.
  Future<BrowserContextStorageStateResult> storageState({bool? indexedDB});

  /// Sets the storage state for this context.
  Future<void> setStorageState(
    BrowserContextSetStorageStateStorageState storageState,
  );

  /// Adds an initialization script to this context.
  Future<void> addInitScript(String source);

  /// Whether the context is closed.
  bool get isClosed;

  /// Background pages in this context.
  List<Page> get backgroundPages;

  /// Service workers in this context.
  List<Worker> get serviceWorkers;

  /// Sets the default timeout for this context.
  void setDefaultTimeout(double timeout);

  /// Sets the default navigation timeout for this context.
  void setDefaultNavigationTimeout(double timeout);

  /// Closes this context.
  Future<void> close({String? reason});

  /// Sets network interception patterns for this context.
  Future<void> setNetworkInterceptionPatterns(
    List<BrowserContextSetNetworkInterceptionPatternsPatternsItems> patterns,
  );

  /// Pauses the context for debugging.
  Future<void> pause();

  /// Fast forwards the clock.
  Future<void> clockFastForward({double? ticksNumber, String? ticksString});

  /// Installs the clock.
  Future<void> clockInstall({double? timeNumber, String? timeString});

  /// Pauses the clock at a specific time.
  Future<void> clockPauseAt({double? timeNumber, String? timeString});

  /// Resumes the clock.
  Future<void> clockResume();

  /// Runs the clock for a specific duration.
  Future<void> clockRunFor({double? ticksNumber, String? ticksString});

  /// Sets a fixed time for the clock.
  Future<void> clockSetFixedTime({double? timeNumber, String? timeString});

  /// Sets the system time for the clock.
  Future<void> clockSetSystemTime({double? timeNumber, String? timeString});

  /// Exposes a binding to the page.
  Future<void> exposeBinding(String name);

  /// Exposes a function to the page.
  Future<void> exposeFunction(String name);

  // ── WebAuthn / Virtual Authenticator ─────────────────────────────────────

  /// Installs a virtual authenticator into this browser context.

  ///

  /// After calling this, the context can create and use virtual credentials

  /// for WebAuthn flows. Call once before [addVirtualCredential].

  Future<void> installVirtualAuthenticator();

  /// Creates a new virtual credential on the installed authenticator.

  Future<BrowserContextCredentialsCreateResult> addVirtualCredential({
    String? id,

    String? privateKey,

    String? publicKey,

    required String rpId,

    String? userHandle,
  });

  /// Returns all virtual credentials matching the optional filters.

  Future<List<VirtualCredential>> getVirtualCredentials({
    String? id,

    String? rpId,
  });

  /// Removes a virtual credential by its [id].

  Future<void> removeVirtualCredential(String id);

  // ── Channel Method Aliases ────────────────────────────────────────────────

  // These provide direct access to channel methods for compatibility

  /// Creates a virtual credential (alias for addVirtualCredential).

  Future<BrowserContextCredentialsCreateResult> credentialsCreate({
    String? id,

    String? privateKey,

    String? publicKey,

    required String rpId,

    String? userHandle,
  });

  /// Deletes a virtual credential (alias for removeVirtualCredential).

  Future<void> credentialsDelete({required String id});

  /// Gets virtual credentials (alias for getVirtualCredentials).

  Future<BrowserContextCredentialsGetResult> credentialsGet({
    String? id,

    String? rpId,
  });

  /// Installs virtual authenticator (alias for installVirtualAuthenticator).

  Future<void> credentialsInstall();

  /// Registers a custom selector engine.
  Future<void> registerSelectorEngine(
    String name,

    String source, {

    bool? contentScript,

    SelectorEngine? selectorEngine,
  });

  /// Sets the test ID attribute name.
  Future<void> setTestIdAttributeName(String testIdAttributeName);

  /// Sets WebSocket interception patterns.
  Future<void> setWebSocketInterceptionPatterns(
    List<BrowserContextSetWebSocketInterceptionPatternsPatternsItems> patterns,
  );

  /// Enables the recorder.
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
  });

  /// Disables the recorder.
  Future<void> disableRecorder();

  /// Exposes the console API to the page.
  Future<void> exposeConsoleApi();

  /// Creates a new Chrome DevTools Protocol session.
  Future<CDPSession> newCDPSession({Page? page, Frame? frame});

  /// Creates temporary files.
  Future<BrowserContextCreateTempFilesResult> createTempFiles({
    String? rootDirName,

    required List<BrowserContextCreateTempFilesItemsItems> items,
  });

  /// Updates the subscription for events.
  Future<void> updateSubscription({
    required BrowserContextUpdateSubscriptionEventEnum event,

    required bool enabled,
  });

  /// Routes network requests matching the given URL.
  Future<void> route(String url, Future<void> Function(Route) handler);

  /// Removes a route for the given URL.
  Future<void> unroute(
    String url, {

    Future<void> Function(Route route)? handler,
  });

  /// Removes all routes.
  Future<void> unrouteAll();

  /// Routes network requests from a HAR file.
  Future<void> routeFromHAR(
    String harPath, {

    String? url,

    bool notFoundFallback,
  });
}

class BrowserContextImpl extends BrowserContextBase implements BrowserContext {
  bool _isClosed = false;

  final RouteManager _routeManager = RouteManager();

  late final RouteListener _routeListener = RouteListener(_routeManager);

  @override
  late final Tracing tracing;

  @override
  late final APIRequestContext request;

  @override
  late final Clock clock;

  @override
  bool get isClosed => _isClosed;

  @override
  List<Page> get backgroundPages => objects.values
      .whereType<PageImpl>()
      .where((p) => p.initializer['isBackgroundPage'] == true)
      .toList();

  @override
  List<Worker> get serviceWorkers =>
      objects.values.whereType<Worker>().toList();

  double? _timeout;

  double? _navigationTimeout;

  double? get defaultTimeout => _timeout;

  double? get defaultNavigationTimeout => _navigationTimeout;

  @override
  void setDefaultTimeout(double timeout) {
    _timeout = timeout;

    connection
        .sendMessageToServer(guid, 'setDefaultTimeoutNoReply', {
          'timeout': timeout,
        })
        .catchError((_) => <String, dynamic>{});
  }

  @override
  void setDefaultNavigationTimeout(double timeout) {
    _navigationTimeout = timeout;

    connection
        .sendMessageToServer(guid, 'setDefaultNavigationTimeoutNoReply', {
          'timeout': timeout,
        })
        .catchError((_) => <String, dynamic>{});
  }

  @override
  Browser? get browser => parent is Browser ? parent as Browser : null;

  @override
  Stream<Map<String, dynamic>> get onRecorderEvent {
    return onEvent
        .where((e) => e['event'] == 'recorderEvent')
        .map((e) => e['params']);
  }

  @override
  Stream<Map<String, dynamic>> get onResponse {
    return onEvent
        .where((e) => e['event'] == 'response')
        .map((e) => e['params']);
  }

  @override
  Stream<Map<String, dynamic>> get onRequestFinished {
    return onEvent
        .where((e) => e['event'] == 'requestFinished')
        .map((e) => e['params']);
  }

  @override
  Stream<Map<String, dynamic>> get onRequestFailed {
    return onEvent
        .where((e) => e['event'] == 'requestFailed')
        .map((e) => e['params']);
  }

  @override
  Stream<Map<String, dynamic>> get onRequest {
    return onEvent
        .where((e) => e['event'] == 'request')
        .map((e) => e['params']);
  }

  @override
  Stream<Worker> get onServiceWorker {
    return onEvent
        .where((e) => e['event'] == 'serviceWorker')
        .map((e) => e['params']['worker']);
  }

  @override
  Stream<WebSocketRoute> get onWebSocketRoute {
    return onEvent
        .where((e) => e['event'] == 'webSocketRoute')
        .map((e) => e['params']['webSocketRoute']);
  }

  @override
  Stream<Route> get onRoute {
    return onEvent.where((e) => e['event'] == 'route').map((e) {
      final routeGuid = e['params']['route']['guid'];

      return connection.objects[routeGuid] as Route;
    });
  }

  @override
  Stream<Map<String, dynamic>> get onPageError {
    return onEvent
        .where((e) => e['event'] == 'pageError')
        .map((e) => e['params']);
  }

  @override
  Stream<Page> get onPage {
    return onEvent
        .where((e) => e['event'] == 'page')
        .map((e) => e['params']['page']);
  }

  @override
  Stream<Dialog> get onDialog {
    return onEvent
        .where((e) => e['event'] == 'dialog')
        .map((e) => e['params']['dialog']);
  }

  @override
  Stream<BrowserContext> get onClose {
    return onEvent.where((e) => e['event'] == 'close').map((e) => this);
  }

  @override
  Stream<Map<String, dynamic>> get onConsole {
    return onEvent
        .where((e) => e['event'] == 'console')
        .map((e) => e['params']);
  }

  @override
  Stream<BindingCall> get onBindingCall {
    return onEvent
        .where((e) => e['event'] == 'bindingCall')
        .map((e) => e['params']['binding']);
  }

  @override
  List<Page> get pages => objects.values.whereType<Page>().toList();

  BrowserContextImpl(
    super.connection,

    super.channelType,

    super.guid,

    super.initializer, [

    super.parent,
  ]) {
    tracing = ChannelOwner.from<TracingImpl>(
      connection,

      initializer['tracing'],
    );

    request = ChannelOwner.from<APIRequestContextImpl>(
      connection,

      initializer['requestContext'],
    );

    clock = ClockImpl(this);

    onEvent.where((e) => e['event'] == 'close').listen((_) => _isClosed = true);

    onEvent.where((e) => e['event'] == 'requestFailed').listen((e) {
      final requestGuid = e['params']['request']['guid'];

      final request = connection.objects[requestGuid] as RequestImpl?;

      if (request != null) {
        request.failureText = e['params']['failureText'];

        if (e['params']['responseEndTiming'] != null) {
          final t = request.timing;

          t['responseEnd'] = e['params']['responseEndTiming'];

          request.timing = t;
        }
      }
    });

    onEvent.where((e) => e['event'] == 'requestFinished').listen((e) {
      final requestGuid = e['params']['request']['guid'];

      final request = connection.objects[requestGuid] as RequestImpl?;

      if (request != null && e['params']['responseEndTiming'] != null) {
        final t = request.timing;

        t['responseEnd'] = e['params']['responseEndTiming'];

        request.timing = t;
      }
    });
  }

  /// Creates a new page in the browser context.

  @override
  Future<Page> newPage() async {
    final result = await super.channel_newPage();

    final page = result.page as Page;
    Logger.debug('New page created.', name: 'playwright.context');
    return page;
  }

  /// Adds cookies into this browser context.

  ///

  /// All pages within this context will have these cookies installed.

  @override
  Future<void> addCookies(List<SetNetworkCookie> cookies) async {
    Logger.debug(
      'addCookies (${cookies.length} cookies)',
      name: 'playwright.context',
    );
    await super.channel_addCookies(cookies: cookies);
  }

  /// Clears context cookies.

  ///

  /// Optionally filter by [name], [domain], or [path] (exact strings or regex).

  @override
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

  @override
  Future<List<NetworkCookie>> cookies({List<String>? urls}) async {
    final result = await super.channel_cookies(urls: urls ?? []);

    return result.cookies;
  }

  /// Grants specified permissions to the browser context.

  ///

  /// If [origin] is specified, the permissions are granted only for the given origin.

  @override
  Future<void> grantPermissions(
    List<String> permissions, {

    String? origin,
  }) async {
    Logger.debug(
      'grantPermissions $permissions${origin != null ? ' (origin: $origin)' : ''}',
      name: 'playwright.context',
    );
    await super.channel_grantPermissions(
      permissions: permissions,

      origin: origin,
    );
  }

  /// The extra HTTP headers will be sent with every request the context initiates.

  @override
  Future<void> setExtraHTTPHeaders(List<NameValue> headers) async {
    Logger.debug(
      'setExtraHTTPHeaders (${headers.length} headers)',
      name: 'playwright.context',
    );
    await super.channel_setExtraHTTPHeaders(headers: headers);
  }

  /// Clears all permission overrides for the browser context.

  @override
  Future<void> clearPermissions() async {
    await channel_clearPermissions();
  }

  /// Sets the context's geolocation. Passing `null` clears the geolocation override.

  @override
  Future<void> setGeolocation(
    BrowserContextSetGeolocationGeolocation? geolocation,
  ) async {
    Logger.debug('setGeolocation', name: 'playwright.context');
    await channel_setGeolocation(geolocation: geolocation);
  }

  /// Sets HTTP credentials for all requests in this context.

  ///

  /// Passing `null` disables authentication.

  @override
  Future<void> setHTTPCredentials(
    BrowserContextSetHTTPCredentialsHttpCredentials? httpCredentials,
  ) async {
    Logger.debug('setHTTPCredentials', name: 'playwright.context');
    await channel_setHTTPCredentials(httpCredentials: httpCredentials);
  }

  /// Emulates network being offline or online.

  @override
  Future<void> setOffline(bool offline) async {
    Logger.debug('setOffline ($offline)', name: 'playwright.context');
    await channel_setOffline(offline: offline);
  }

  /// Returns storage state for this browser context, contains current cookies and local storage snapshot.

  @override
  Future<BrowserContextStorageStateResult> storageState({
    bool? indexedDB,
  }) async {
    final result = await channel_storageState(indexedDB: indexedDB);

    return result;
  }

  /// Restores the storage state from a previously captured state object.

  @override
  Future<void> setStorageState(
    BrowserContextSetStorageStateStorageState storageState,
  ) async {
    await channel_setStorageState(storageState: storageState);
  }

  /// Adds a script which would be evaluated in one of the following scenarios:

  /// - Whenever a page is created in the browser context.

  /// - Whenever a child frame is attached or navigated in any page in the browser context.

  @override
  Future<void> addInitScript(String source) async {
    Logger.debug('addInitScript', name: 'playwright.context');
    await channel_addInitScript(source: source);
  }

  /// Closes the browser context. All pages that belong to this context will be closed.

  @override
  Future<void> close({String? reason}) async {
    Logger.debug(
      'Closing browser context${reason != null ? ': $reason' : ''}.',
      name: 'playwright.context',
    );
    await channel_close(reason: reason);
  }

  /// Sets the network interception patterns for this context.

  @override
  Future<void> setNetworkInterceptionPatterns(
    List<BrowserContextSetNetworkInterceptionPatternsPatternsItems> patterns,
  ) async {
    await channel_setNetworkInterceptionPatterns(patterns: patterns);
  }

  /// Pauses the context for debugging.

  @override
  Future<void> pause() async {
    await channel_pause();
  }

  /// Fast-forwards the clock by the specified amount of ticks.

  @override
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

  @override
  Future<void> clockInstall({double? timeNumber, String? timeString}) async {
    await channel_clockInstall(timeNumber: timeNumber, timeString: timeString);
  }

  /// Pauses the clock at the specified time.

  @override
  Future<void> clockPauseAt({double? timeNumber, String? timeString}) async {
    await channel_clockPauseAt(timeNumber: timeNumber, timeString: timeString);
  }

  /// Resumes the clock after being paused.

  @override
  Future<void> clockResume() async {
    await channel_clockResume();
  }

  /// Advances the clock by the specified amount of ticks, firing any timers.

  @override
  Future<void> clockRunFor({double? ticksNumber, String? ticksString}) async {
    await channel_clockRunFor(
      ticksNumber: ticksNumber,

      ticksString: ticksString,
    );
  }

  /// Sets the clock to always return a fixed time.

  @override
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

  @override
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

  @override
  Future<void> exposeBinding(String name) async {
    await channel_exposeBinding(name: name);
  }

  /// Exposes a simple callback function with [name] to all pages in the context.

  ///

  /// Convenience alias for [exposeBinding]. Wire up a full callback by

  /// listening to [onBindingCall] after calling this.

  @override
  Future<void> exposeFunction(String name) async {
    await channel_exposeBinding(name: name);
  }

  // ── WebAuthn / Virtual Authenticator ─────────────────────────────────────

  @override
  Future<void> installVirtualAuthenticator() async {
    await channel_credentialsInstall();
  }

  @override
  Future<BrowserContextCredentialsCreateResult> addVirtualCredential({
    String? id,

    String? privateKey,

    String? publicKey,

    required String rpId,

    String? userHandle,
  }) async {
    return await channel_credentialsCreate(
      id: id,

      privateKey: privateKey,

      publicKey: publicKey,

      rpId: rpId,

      userHandle: userHandle,
    );
  }

  @override
  Future<List<VirtualCredential>> getVirtualCredentials({
    String? id,

    String? rpId,
  }) async {
    final result = await channel_credentialsGet(id: id, rpId: rpId);

    return result.credentials;
  }

  @override
  Future<void> removeVirtualCredential(String id) async {
    await channel_credentialsDelete(id: id);
  }

  // ── Channel Method Aliases ────────────────────────────────────────────────

  @override
  Future<BrowserContextCredentialsCreateResult> credentialsCreate({
    String? id,

    String? privateKey,

    String? publicKey,

    required String rpId,

    String? userHandle,
  }) async {
    return await channel_credentialsCreate(
      id: id,

      privateKey: privateKey,

      publicKey: publicKey,

      rpId: rpId,

      userHandle: userHandle,
    );
  }

  @override
  Future<void> credentialsDelete({required String id}) async {
    await channel_credentialsDelete(id: id);
  }

  @override
  Future<BrowserContextCredentialsGetResult> credentialsGet({
    String? id,

    String? rpId,
  }) async {
    return await channel_credentialsGet(id: id, rpId: rpId);
  }

  @override
  Future<void> credentialsInstall() async {
    await channel_credentialsInstall();
  }

  /// Registers a custom selector engine with the given [name] and [source].

  @override
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

  @override
  Future<void> setTestIdAttributeName(String testIdAttributeName) async {
    await channel_setTestIdAttributeName(
      testIdAttributeName: testIdAttributeName,
    );
  }

  /// Sets WebSocket interception patterns for this context.

  @override
  Future<void> setWebSocketInterceptionPatterns(
    List<BrowserContextSetWebSocketInterceptionPatternsPatternsItems> patterns,
  ) async {
    await channel_setWebSocketInterceptionPatterns(patterns: patterns);
  }

  /// Enables the Playwright recorder/codegen in the browser context.

  @override
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

  @override
  Future<void> disableRecorder() async {
    await channel_disableRecorder();
  }

  /// Exposes the Playwright console API into the browser context pages.

  @override
  Future<void> exposeConsoleApi() async {
    await channel_exposeConsoleApi();
  }

  /// Creates a new Chrome DevTools Protocol session for the given [page] or [frame].

  @override
  Future<CDPSession> newCDPSession({Page? page, Frame? frame}) async {
    final result = await channel_newCDPSession(
      page: page as PageImpl?,

      frame: frame as FrameImpl?,
    );

    return result.session as CDPSession;
  }

  /// Creates temporary files that can be used with file inputs.

  @override
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

  @override
  Future<void> updateSubscription({
    required BrowserContextUpdateSubscriptionEventEnum event,

    required bool enabled,
  }) async {
    await channel_updateSubscription(event: event, enabled: enabled);
  }

  /// Routing provides the capability to modify network requests that are made by a context.

  @override
  Future<void> route(String url, Future<void> Function(Route) handler) async {
    _routeManager.add(url, handler);

    _routeListener.attach(onRoute);

    await channel_setNetworkInterceptionPatterns(
      patterns: _routeManager.prepareContextPatterns(),
    );
  }

  /// Removes a route previously set with [route].

  @override
  Future<void> unroute(
    String url, {

    Future<void> Function(Route route)? handler,
  }) async {
    _routeManager.remove(url, handler);

    await channel_setNetworkInterceptionPatterns(
      patterns: _routeManager.prepareContextPatterns(),
    );
  }

  /// Removes all routes previously set with [route].

  @override
  Future<void> unrouteAll() async {
    _routeManager.clear();

    await channel_setNetworkInterceptionPatterns(patterns: []);
  }

  /// Serves all requests matching the given [url] from the HAR file.

  @override
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
