import 'channel_owner.dart';
import 'frame.dart';
import 'page.dart';
import 'generated/channels.dart';

class BrowserContext extends BrowserContextBase {
  BrowserContext(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  Future<Page> newPage() async {
    final result = await super.channel_newPage();
    return result.page as Page;
  }

  Future<void> addCookies(List<SetNetworkCookie> cookies) async {
    await super.channel_addCookies(cookies: cookies);
  }

  Future<void> clearCookies({
    String? name,
    String? domain,
    String? path,
  }) async {
    await super.channel_clearCookies(name: name, domain: domain, path: path);
  }

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

  Future<void> setHTTPCredentials(Map<String, dynamic>? credentials) async {
    await channel_setHTTPCredentials(httpCredentials: credentials);
  }

  Future<void> setOffline(bool offline) async {
    await channel_setOffline(offline: offline);
  }

  Future<BrowserContextStorageStateResult> storageState({
    bool? indexedDB,
  }) async {
    final result = await channel_storageState(indexedDB: indexedDB);
    return result;
  }

  Future<void> setStorageState(Map<String, dynamic> state) async {
    await channel_setStorageState(storageState: state);
  }

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
  }) async {
    await channel_registerSelectorEngine(
      selectorEngine: SelectorEngine(
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
  }) async {
    await channel_enableRecorder(
      language: language,
      mode: mode,
      recorderMode: recorderMode,
      pauseOnNextStatement: pauseOnNextStatement,
      testIdAttributeName: testIdAttributeName,
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
    return ChannelOwner.from(
      connection,
      result.session as Map<String, dynamic>,
    );
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
}
