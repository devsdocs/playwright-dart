// ignore_for_file: unused_local_variable, unnecessary_null_comparison, unused_field, annotate_overrides, non_constant_identifier_names, unnecessary_cast, invalid_null_aware_operator, curly_braces_in_flow_control_structures
// AUTO-GENERATED FILE. DO NOT MODIFY.
// Generated from Playwright protocol.

import '../infrastructure/channel_owner.dart';
import '../infrastructure/connection.dart';

abstract class Channel {}

/// Arbitrary JSON value (Playwright protocol type `json` / `any`).
typedef JsonValue = Object?;

enum AndroidDeviceFlingDirectionEnum {
  up('up'),
  down('down'),
  left('left'),
  right('right');

  final String value;
  const AndroidDeviceFlingDirectionEnum(this.value);
}

enum AndroidDeviceScrollDirectionEnum {
  up('up'),
  down('down'),
  left('left'),
  right('right');

  final String value;
  const AndroidDeviceScrollDirectionEnum(this.value);
}

enum AndroidDeviceSwipeDirectionEnum {
  up('up'),
  down('down'),
  left('left'),
  right('right');

  final String value;
  const AndroidDeviceSwipeDirectionEnum(this.value);
}

enum AndroidDeviceWaitStateEnum {
  gone('gone');

  final String value;
  const AndroidDeviceWaitStateEnum(this.value);
}

enum BrowserContextEnableRecorderModeEnum {
  inspecting('inspecting'),
  recording('recording');

  final String value;
  const BrowserContextEnableRecorderModeEnum(this.value);
}

enum BrowserContextEnableRecorderRecorderModeEnum {
  defaultValue('default'),
  api('api');

  final String value;
  const BrowserContextEnableRecorderRecorderModeEnum(this.value);
}

enum BrowserContextRecorderEventEventEventEnum {
  actionAdded('actionAdded'),
  actionUpdated('actionUpdated'),
  signalAdded('signalAdded');

  final String value;
  const BrowserContextRecorderEventEventEventEnum(this.value);
}

enum BrowserContextUpdateSubscriptionEventEnum {
  console('console'),
  dialog('dialog'),
  request('request'),
  response('response'),
  requestFinished('requestFinished'),
  requestFailed('requestFailed');

  final String value;
  const BrowserContextUpdateSubscriptionEventEnum(this.value);
}

enum BrowserInitializerBrowserNameEnum {
  chromium('chromium'),
  firefox('firefox'),
  webkit('webkit');

  final String value;
  const BrowserInitializerBrowserNameEnum(this.value);
}

enum CommonScreenshotOptionsAnimationsEnum {
  disabled('disabled'),
  allow('allow');

  final String value;
  const CommonScreenshotOptionsAnimationsEnum(this.value);
}

enum CommonScreenshotOptionsCaretEnum {
  hide('hide'),
  initial('initial');

  final String value;
  const CommonScreenshotOptionsCaretEnum(this.value);
}

enum CommonScreenshotOptionsScaleEnum {
  css('css'),
  device('device');

  final String value;
  const CommonScreenshotOptionsScaleEnum(this.value);
}

enum ConsoleMessagesFilter {
  all('all'),
  sinceNavigation('since-navigation');

  final String value;
  const ConsoleMessagesFilter(this.value);
}

enum ContextOptionsAcceptDownloadsEnum {
  accept('accept'),
  deny('deny'),
  internalBrowserDefault('internal-browser-default');

  final String value;
  const ContextOptionsAcceptDownloadsEnum(this.value);
}

enum ContextOptionsColorSchemeEnum {
  dark('dark'),
  light('light'),
  noPreference('no-preference'),
  noOverride('no-override');

  final String value;
  const ContextOptionsColorSchemeEnum(this.value);
}

enum ContextOptionsContrastEnum {
  noPreference('no-preference'),
  more('more'),
  noOverride('no-override');

  final String value;
  const ContextOptionsContrastEnum(this.value);
}

enum ContextOptionsForcedColorsEnum {
  active('active'),
  none('none'),
  noOverride('no-override');

  final String value;
  const ContextOptionsForcedColorsEnum(this.value);
}

enum ContextOptionsHttpCredentialsSendEnum {
  always('always'),
  unauthorized('unauthorized');

  final String value;
  const ContextOptionsHttpCredentialsSendEnum(this.value);
}

enum ContextOptionsReducedMotionEnum {
  reduce('reduce'),
  noPreference('no-preference'),
  noOverride('no-override');

  final String value;
  const ContextOptionsReducedMotionEnum(this.value);
}

enum ContextOptionsServiceWorkersEnum {
  allow('allow'),
  block('block');

  final String value;
  const ContextOptionsServiceWorkersEnum(this.value);
}

enum DebugControllerSetRecorderModeModeEnum {
  inspecting('inspecting'),
  recording('recording'),
  none('none');

  final String value;
  const DebugControllerSetRecorderModeModeEnum(this.value);
}

enum ElectronApplicationUpdateSubscriptionEventEnum {
  console('console');

  final String value;
  const ElectronApplicationUpdateSubscriptionEventEnum(this.value);
}

enum ElectronLaunchAcceptDownloadsEnum {
  accept('accept'),
  deny('deny'),
  internalBrowserDefault('internal-browser-default');

  final String value;
  const ElectronLaunchAcceptDownloadsEnum(this.value);
}

enum ElectronLaunchColorSchemeEnum {
  dark('dark'),
  light('light'),
  noPreference('no-preference'),
  noOverride('no-override');

  final String value;
  const ElectronLaunchColorSchemeEnum(this.value);
}

enum ElementHandleClickButtonEnum {
  left('left'),
  right('right'),
  middle('middle');

  final String value;
  const ElementHandleClickButtonEnum(this.value);
}

enum ElementHandleClickModifiersEnum {
  alt('Alt'),
  control('Control'),
  controlOrMeta('ControlOrMeta'),
  meta('Meta'),
  shift('Shift');

  final String value;
  const ElementHandleClickModifiersEnum(this.value);
}

enum ElementHandleDblclickButtonEnum {
  left('left'),
  right('right'),
  middle('middle');

  final String value;
  const ElementHandleDblclickButtonEnum(this.value);
}

enum ElementHandleDblclickModifiersEnum {
  alt('Alt'),
  control('Control'),
  controlOrMeta('ControlOrMeta'),
  meta('Meta'),
  shift('Shift');

  final String value;
  const ElementHandleDblclickModifiersEnum(this.value);
}

enum ElementHandleHoverModifiersEnum {
  alt('Alt'),
  control('Control'),
  controlOrMeta('ControlOrMeta'),
  meta('Meta'),
  shift('Shift');

  final String value;
  const ElementHandleHoverModifiersEnum(this.value);
}

enum ElementHandleScreenshotTypeEnum {
  png('png'),
  jpeg('jpeg');

  final String value;
  const ElementHandleScreenshotTypeEnum(this.value);
}

enum ElementHandleTapModifiersEnum {
  alt('Alt'),
  control('Control'),
  controlOrMeta('ControlOrMeta'),
  meta('Meta'),
  shift('Shift');

  final String value;
  const ElementHandleTapModifiersEnum(this.value);
}

enum ElementHandleWaitForElementStateStateEnum {
  visible('visible'),
  hidden('hidden'),
  stable('stable'),
  enabled('enabled'),
  disabled('disabled'),
  editable('editable');

  final String value;
  const ElementHandleWaitForElementStateStateEnum(this.value);
}

enum ElementHandleWaitForSelectorStateEnum {
  attached('attached'),
  detached('detached'),
  visible('visible'),
  hidden('hidden');

  final String value;
  const ElementHandleWaitForSelectorStateEnum(this.value);
}

enum FrameAriaSnapshotModeEnum {
  ai('ai'),
  defaultValue('default');

  final String value;
  const FrameAriaSnapshotModeEnum(this.value);
}

enum FrameClickButtonEnum {
  left('left'),
  right('right'),
  middle('middle');

  final String value;
  const FrameClickButtonEnum(this.value);
}

enum FrameClickModifiersEnum {
  alt('Alt'),
  control('Control'),
  controlOrMeta('ControlOrMeta'),
  meta('Meta'),
  shift('Shift');

  final String value;
  const FrameClickModifiersEnum(this.value);
}

enum FrameDblclickButtonEnum {
  left('left'),
  right('right'),
  middle('middle');

  final String value;
  const FrameDblclickButtonEnum(this.value);
}

enum FrameDblclickModifiersEnum {
  alt('Alt'),
  control('Control'),
  controlOrMeta('ControlOrMeta'),
  meta('Meta'),
  shift('Shift');

  final String value;
  const FrameDblclickModifiersEnum(this.value);
}

enum FrameExpectPseudoEnum {
  before('before'),
  after('after');

  final String value;
  const FrameExpectPseudoEnum(this.value);
}

enum FrameHoverModifiersEnum {
  alt('Alt'),
  control('Control'),
  controlOrMeta('ControlOrMeta'),
  meta('Meta'),
  shift('Shift');

  final String value;
  const FrameHoverModifiersEnum(this.value);
}

enum FrameTapModifiersEnum {
  alt('Alt'),
  control('Control'),
  controlOrMeta('ControlOrMeta'),
  meta('Meta'),
  shift('Shift');

  final String value;
  const FrameTapModifiersEnum(this.value);
}

enum FrameWaitForSelectorStateEnum {
  attached('attached'),
  detached('detached'),
  visible('visible'),
  hidden('hidden');

  final String value;
  const FrameWaitForSelectorStateEnum(this.value);
}

enum LifecycleEvent {
  load('load'),
  domcontentloaded('domcontentloaded'),
  networkidle('networkidle'),
  commit('commit');

  final String value;
  const LifecycleEvent(this.value);
}

enum LocalUtilsHarLookupResultActionEnum {
  error('error'),
  redirect('redirect'),
  fulfill('fulfill'),
  noentry('noentry');

  final String value;
  const LocalUtilsHarLookupResultActionEnum(this.value);
}

enum LocalUtilsInitializerDeviceDescriptorsItemsDescriptorDefaultBrowserTypeEnum {
  chromium('chromium'),
  firefox('firefox'),
  webkit('webkit');

  final String value;
  const LocalUtilsInitializerDeviceDescriptorsItemsDescriptorDefaultBrowserTypeEnum(
    this.value,
  );
}

enum LocalUtilsZipModeEnum {
  write('write'),
  append('append');

  final String value;
  const LocalUtilsZipModeEnum(this.value);
}

enum NetworkCookieSameSiteEnum {
  strict('Strict'),
  lax('Lax'),
  none('None');

  final String value;
  const NetworkCookieSameSiteEnum(this.value);
}

enum PageEmulateMediaColorSchemeEnum {
  dark('dark'),
  light('light'),
  noPreference('no-preference'),
  noOverride('no-override');

  final String value;
  const PageEmulateMediaColorSchemeEnum(this.value);
}

enum PageEmulateMediaContrastEnum {
  noPreference('no-preference'),
  more('more'),
  noOverride('no-override');

  final String value;
  const PageEmulateMediaContrastEnum(this.value);
}

enum PageEmulateMediaForcedColorsEnum {
  active('active'),
  none('none'),
  noOverride('no-override');

  final String value;
  const PageEmulateMediaForcedColorsEnum(this.value);
}

enum PageEmulateMediaMediaEnum {
  screen('screen'),
  print('print'),
  noOverride('no-override');

  final String value;
  const PageEmulateMediaMediaEnum(this.value);
}

enum PageEmulateMediaReducedMotionEnum {
  reduce('reduce'),
  noPreference('no-preference'),
  noOverride('no-override');

  final String value;
  const PageEmulateMediaReducedMotionEnum(this.value);
}

enum PageMouseClickButtonEnum {
  left('left'),
  right('right'),
  middle('middle');

  final String value;
  const PageMouseClickButtonEnum(this.value);
}

enum PageMouseDownButtonEnum {
  left('left'),
  right('right'),
  middle('middle');

  final String value;
  const PageMouseDownButtonEnum(this.value);
}

enum PageMouseUpButtonEnum {
  left('left'),
  right('right'),
  middle('middle');

  final String value;
  const PageMouseUpButtonEnum(this.value);
}

enum PageScreenshotTypeEnum {
  png('png'),
  jpeg('jpeg');

  final String value;
  const PageScreenshotTypeEnum(this.value);
}

enum PageUpdateSubscriptionEventEnum {
  console('console'),
  dialog('dialog'),
  fileChooser('fileChooser'),
  request('request'),
  response('response'),
  requestFinished('requestFinished'),
  requestFailed('requestFailed');

  final String value;
  const PageUpdateSubscriptionEventEnum(this.value);
}

enum PageWebStorageClearKindEnum {
  local('local'),
  session('session');

  final String value;
  const PageWebStorageClearKindEnum(this.value);
}

enum PageWebStorageGetItemKindEnum {
  local('local'),
  session('session');

  final String value;
  const PageWebStorageGetItemKindEnum(this.value);
}

enum PageWebStorageItemsKindEnum {
  local('local'),
  session('session');

  final String value;
  const PageWebStorageItemsKindEnum(this.value);
}

enum PageWebStorageRemoveItemKindEnum {
  local('local'),
  session('session');

  final String value;
  const PageWebStorageRemoveItemKindEnum(this.value);
}

enum PageWebStorageSetItemKindEnum {
  local('local'),
  session('session');

  final String value;
  const PageWebStorageSetItemKindEnum(this.value);
}

enum PlaywrightNewRequestHttpCredentialsSendEnum {
  always('always'),
  unauthorized('unauthorized');

  final String value;
  const PlaywrightNewRequestHttpCredentialsSendEnum(this.value);
}

enum RecordHarOptionsContentEnum {
  embed('embed'),
  attach('attach'),
  omit('omit');

  final String value;
  const RecordHarOptionsContentEnum(this.value);
}

enum RecordHarOptionsModeEnum {
  full('full'),
  minimal('minimal');

  final String value;
  const RecordHarOptionsModeEnum(this.value);
}

enum SDKLanguage {
  javascript('javascript'),
  python('python'),
  java('java'),
  csharp('csharp');

  final String value;
  const SDKLanguage(this.value);
}

enum SerializedValueTaKEnum {
  i8('i8'),
  ui8('ui8'),
  ui8c('ui8c'),
  i16('i16'),
  ui16('ui16'),
  i32('i32'),
  ui32('ui32'),
  f32('f32'),
  f64('f64'),
  bi64('bi64'),
  bui64('bui64');

  final String value;
  const SerializedValueTaKEnum(this.value);
}

enum SerializedValueVEnum {
  nullValue('null'),
  undefined('undefined'),
  nan('NaN'),
  infinity('Infinity'),
  minusInfinity('-Infinity'),
  minusZero('-0');

  final String value;
  const SerializedValueVEnum(this.value);
}

enum SetNetworkCookieSameSiteEnum {
  strict('Strict'),
  lax('Lax'),
  none('None');

  final String value;
  const SetNetworkCookieSameSiteEnum(this.value);
}

enum ShowActionsOptionsCursorEnum {
  none('none'),
  pointer('pointer');

  final String value;
  const ShowActionsOptionsCursorEnum(this.value);
}

enum ShowActionsOptionsPositionEnum {
  topLeft('top-left'),
  top('top'),
  topRight('top-right'),
  bottomLeft('bottom-left'),
  bottom('bottom'),
  bottomRight('bottom-right');

  final String value;
  const ShowActionsOptionsPositionEnum(this.value);
}

enum TracingHarExportModeEnum {
  archive('archive'),
  entries('entries');

  final String value;
  const TracingHarExportModeEnum(this.value);
}

enum TracingTracingStopChunkModeEnum {
  archive('archive'),
  discard('discard'),
  entries('entries');

  final String value;
  const TracingTracingStopChunkModeEnum(this.value);
}

enum WaitInfoPhaseEnum {
  before('before'),
  after('after'),
  log('log');

  final String value;
  const WaitInfoPhaseEnum(this.value);
}

enum WorkerUpdateSubscriptionEventEnum {
  console('console');

  final String value;
  const WorkerUpdateSubscriptionEventEnum(this.value);
}

class APIRequestContextFetchLogResult {
  final List<String> log;

  APIRequestContextFetchLogResult({required this.log});

  factory APIRequestContextFetchLogResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return APIRequestContextFetchLogResult(
      log: ((json[r'log'] as List?)?.cast<String>()) ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {r'log': log};
  }
}

class APIRequestContextFetchResponseBodyResult {
  final String? binary;

  APIRequestContextFetchResponseBodyResult({this.binary});

  factory APIRequestContextFetchResponseBodyResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return APIRequestContextFetchResponseBodyResult(binary: json[r'binary']);
  }

  Map<String, dynamic> toJson() {
    return {if (binary != null) r'binary': binary};
  }
}

class APIRequestContextFetchResult {
  final APIResponse response;

  APIRequestContextFetchResult({required this.response});

  factory APIRequestContextFetchResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return APIRequestContextFetchResult(
      response: (json[r'response'] == null
          ? null
          : APIResponse.fromJson(json[r'response'], connection: connection))!,
    );
  }

  Map<String, dynamic> toJson() {
    return {r'response': response.toJson()};
  }
}

class APIRequestContextInitializer {
  final TracingBase tracing;

  APIRequestContextInitializer({required this.tracing});

  factory APIRequestContextInitializer.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return APIRequestContextInitializer(
      tracing: (connection != null && json[r'tracing'] != null
          ? ChannelOwner.from<TracingBase>(connection, json[r'tracing'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'tracing': {'guid': tracing.guid},
    };
  }
}

class APIRequestContextStorageStateResult {
  final List<NetworkCookie> cookies;
  final List<OriginStorage> origins;

  APIRequestContextStorageStateResult({
    required this.cookies,
    required this.origins,
  });

  factory APIRequestContextStorageStateResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return APIRequestContextStorageStateResult(
      cookies:
          ((json[r'cookies'] as List?)
              ?.map((e) => NetworkCookie.fromJson(e, connection: connection))
              .toList()) ??
          [],
      origins:
          ((json[r'origins'] as List?)
              ?.map((e) => OriginStorage.fromJson(e, connection: connection))
              .toList()) ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'cookies': cookies.map((e) => e.toJson()).toList(),
      r'origins': origins.map((e) => e.toJson()).toList(),
    };
  }
}

class APIResponse {
  final String fetchUid;
  final List<NameValue> headers;
  final SecurityDetails? securityDetails;
  final RemoteAddr? serverAddr;
  final int status;
  final String statusText;
  final String url;

  APIResponse({
    required this.fetchUid,
    required this.headers,
    this.securityDetails,
    this.serverAddr,
    required this.status,
    required this.statusText,
    required this.url,
  });

  factory APIResponse.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return APIResponse(
      fetchUid: (json[r'fetchUid'])!,
      headers:
          ((json[r'headers'] as List?)
              ?.map((e) => NameValue.fromJson(e, connection: connection))
              .toList()) ??
          [],
      securityDetails: json[r'securityDetails'] == null
          ? null
          : SecurityDetails.fromJson(
              json[r'securityDetails'],
              connection: connection,
            ),
      serverAddr: json[r'serverAddr'] == null
          ? null
          : RemoteAddr.fromJson(json[r'serverAddr'], connection: connection),
      status: (json[r'status'])!,
      statusText: (json[r'statusText'])!,
      url: (json[r'url'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'fetchUid': fetchUid,
      r'headers': headers.map((e) => e.toJson()).toList(),
      if (securityDetails != null)
        r'securityDetails': securityDetails?.toJson(),
      if (serverAddr != null) r'serverAddr': serverAddr?.toJson(),
      r'status': status,
      r'statusText': statusText,
      r'url': url,
    };
  }
}

class AndroidDeviceConnectToWebViewResult {
  final BrowserContextBase context;

  AndroidDeviceConnectToWebViewResult({required this.context});

  factory AndroidDeviceConnectToWebViewResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return AndroidDeviceConnectToWebViewResult(
      context: (connection != null && json[r'context'] != null
          ? ChannelOwner.from<BrowserContextBase>(connection, json[r'context'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'context': {'guid': context.guid},
    };
  }
}

class AndroidDeviceInfoResult {
  final AndroidElementInfo info;

  AndroidDeviceInfoResult({required this.info});

  factory AndroidDeviceInfoResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return AndroidDeviceInfoResult(
      info: (json[r'info'] == null
          ? null
          : AndroidElementInfo.fromJson(
              json[r'info'],
              connection: connection,
            ))!,
    );
  }

  Map<String, dynamic> toJson() {
    return {r'info': info.toJson()};
  }
}

class AndroidDeviceInitializer {
  final String model;
  final String serial;

  AndroidDeviceInitializer({required this.model, required this.serial});

  factory AndroidDeviceInitializer.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return AndroidDeviceInitializer(
      model: (json[r'model'])!,
      serial: (json[r'serial'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {r'model': model, r'serial': serial};
  }
}

class AndroidDeviceLaunchBrowserProxy {
  final String? bypass;
  final String? password;
  final String server;
  final String? username;

  AndroidDeviceLaunchBrowserProxy({
    this.bypass,
    this.password,
    required this.server,
    this.username,
  });

  factory AndroidDeviceLaunchBrowserProxy.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return AndroidDeviceLaunchBrowserProxy(
      bypass: json[r'bypass'],
      password: json[r'password'],
      server: (json[r'server'])!,
      username: json[r'username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (bypass != null) r'bypass': bypass,
      if (password != null) r'password': password,
      r'server': server,
      if (username != null) r'username': username,
    };
  }
}

class AndroidDeviceLaunchBrowserResult {
  final BrowserContextBase context;

  AndroidDeviceLaunchBrowserResult({required this.context});

  factory AndroidDeviceLaunchBrowserResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return AndroidDeviceLaunchBrowserResult(
      context: (connection != null && json[r'context'] != null
          ? ChannelOwner.from<BrowserContextBase>(connection, json[r'context'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'context': {'guid': context.guid},
    };
  }
}

class AndroidDeviceOpenResult {
  final AndroidSocketBase socket;

  AndroidDeviceOpenResult({required this.socket});

  factory AndroidDeviceOpenResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return AndroidDeviceOpenResult(
      socket: (connection != null && json[r'socket'] != null
          ? ChannelOwner.from<AndroidSocketBase>(connection, json[r'socket'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'socket': {'guid': socket.guid},
    };
  }
}

class AndroidDeviceScreenshotResult {
  final String binary;

  AndroidDeviceScreenshotResult({required this.binary});

  factory AndroidDeviceScreenshotResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return AndroidDeviceScreenshotResult(binary: (json[r'binary'])!);
  }

  Map<String, dynamic> toJson() {
    return {r'binary': binary};
  }
}

class AndroidDeviceShellResult {
  final String result;

  AndroidDeviceShellResult({required this.result});

  factory AndroidDeviceShellResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return AndroidDeviceShellResult(result: (json[r'result'])!);
  }

  Map<String, dynamic> toJson() {
    return {r'result': result};
  }
}

class AndroidDeviceWebViewAddedEvent {
  final AndroidWebView webView;

  AndroidDeviceWebViewAddedEvent({required this.webView});

  factory AndroidDeviceWebViewAddedEvent.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return AndroidDeviceWebViewAddedEvent(
      webView: (json[r'webView'] == null
          ? null
          : AndroidWebView.fromJson(json[r'webView'], connection: connection))!,
    );
  }

  Map<String, dynamic> toJson() {
    return {r'webView': webView.toJson()};
  }
}

class AndroidDeviceWebViewRemovedEvent {
  final String socketName;

  AndroidDeviceWebViewRemovedEvent({required this.socketName});

  factory AndroidDeviceWebViewRemovedEvent.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return AndroidDeviceWebViewRemovedEvent(socketName: (json[r'socketName'])!);
  }

  Map<String, dynamic> toJson() {
    return {r'socketName': socketName};
  }
}

class AndroidDevicesResult {
  final List<AndroidDeviceBase> devices;

  AndroidDevicesResult({required this.devices});

  factory AndroidDevicesResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return AndroidDevicesResult(
      devices:
          (connection != null
              ? (json[r'devices'] as List?)
                    ?.map(
                      (e) =>
                          ChannelOwner.from<AndroidDeviceBase>(connection, e),
                    )
                    .toList()
              : null) ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'devices': devices.map((e) => {'guid': e.guid}).toList(),
    };
  }
}

class AndroidElementInfo {
  final Rect bounds;
  final bool checkable;
  final bool checked;
  final List<AndroidElementInfo>? children;
  final String clazz;
  final bool clickable;
  final String desc;
  final bool enabled;
  final bool focusable;
  final bool focused;
  final bool longClickable;
  final String pkg;
  final String res;
  final bool scrollable;
  final bool selected;
  final String text;

  AndroidElementInfo({
    required this.bounds,
    required this.checkable,
    required this.checked,
    this.children,
    required this.clazz,
    required this.clickable,
    required this.desc,
    required this.enabled,
    required this.focusable,
    required this.focused,
    required this.longClickable,
    required this.pkg,
    required this.res,
    required this.scrollable,
    required this.selected,
    required this.text,
  });

  factory AndroidElementInfo.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return AndroidElementInfo(
      bounds: (json[r'bounds'] == null
          ? null
          : Rect.fromJson(json[r'bounds'], connection: connection))!,
      checkable: (json[r'checkable'])!,
      checked: (json[r'checked'])!,
      children: (json[r'children'] as List?)
          ?.map((e) => AndroidElementInfo.fromJson(e, connection: connection))
          .toList(),
      clazz: (json[r'clazz'])!,
      clickable: (json[r'clickable'])!,
      desc: (json[r'desc'])!,
      enabled: (json[r'enabled'])!,
      focusable: (json[r'focusable'])!,
      focused: (json[r'focused'])!,
      longClickable: (json[r'longClickable'])!,
      pkg: (json[r'pkg'])!,
      res: (json[r'res'])!,
      scrollable: (json[r'scrollable'])!,
      selected: (json[r'selected'])!,
      text: (json[r'text'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'bounds': bounds.toJson(),
      r'checkable': checkable,
      r'checked': checked,
      if (children != null)
        r'children': children?.map((e) => e.toJson()).toList(),
      r'clazz': clazz,
      r'clickable': clickable,
      r'desc': desc,
      r'enabled': enabled,
      r'focusable': focusable,
      r'focused': focused,
      r'longClickable': longClickable,
      r'pkg': pkg,
      r'res': res,
      r'scrollable': scrollable,
      r'selected': selected,
      r'text': text,
    };
  }
}

class AndroidSelector {
  final bool? checkable;
  final bool? checked;
  final String? clazz;
  final bool? clickable;
  final int? depth;
  final String? desc;
  final bool? enabled;
  final bool? focusable;
  final bool? focused;
  final AndroidSelectorHasChild? hasChild;
  final AndroidSelectorHasDescendant? hasDescendant;
  final bool? longClickable;
  final String? pkg;
  final String? res;
  final bool? scrollable;
  final bool? selected;
  final String? text;

  AndroidSelector({
    this.checkable,
    this.checked,
    this.clazz,
    this.clickable,
    this.depth,
    this.desc,
    this.enabled,
    this.focusable,
    this.focused,
    this.hasChild,
    this.hasDescendant,
    this.longClickable,
    this.pkg,
    this.res,
    this.scrollable,
    this.selected,
    this.text,
  });

  factory AndroidSelector.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return AndroidSelector(
      checkable: json[r'checkable'],
      checked: json[r'checked'],
      clazz: json[r'clazz'],
      clickable: json[r'clickable'],
      depth: json[r'depth'],
      desc: json[r'desc'],
      enabled: json[r'enabled'],
      focusable: json[r'focusable'],
      focused: json[r'focused'],
      hasChild: json[r'hasChild'] == null
          ? null
          : AndroidSelectorHasChild.fromJson(
              json[r'hasChild'],
              connection: connection,
            ),
      hasDescendant: json[r'hasDescendant'] == null
          ? null
          : AndroidSelectorHasDescendant.fromJson(
              json[r'hasDescendant'],
              connection: connection,
            ),
      longClickable: json[r'longClickable'],
      pkg: json[r'pkg'],
      res: json[r'res'],
      scrollable: json[r'scrollable'],
      selected: json[r'selected'],
      text: json[r'text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (checkable != null) r'checkable': checkable,
      if (checked != null) r'checked': checked,
      if (clazz != null) r'clazz': clazz,
      if (clickable != null) r'clickable': clickable,
      if (depth != null) r'depth': depth,
      if (desc != null) r'desc': desc,
      if (enabled != null) r'enabled': enabled,
      if (focusable != null) r'focusable': focusable,
      if (focused != null) r'focused': focused,
      if (hasChild != null) r'hasChild': hasChild?.toJson(),
      if (hasDescendant != null) r'hasDescendant': hasDescendant?.toJson(),
      if (longClickable != null) r'longClickable': longClickable,
      if (pkg != null) r'pkg': pkg,
      if (res != null) r'res': res,
      if (scrollable != null) r'scrollable': scrollable,
      if (selected != null) r'selected': selected,
      if (text != null) r'text': text,
    };
  }
}

class AndroidSelectorHasChild {
  final AndroidSelector androidSelector;

  AndroidSelectorHasChild({required this.androidSelector});

  factory AndroidSelectorHasChild.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return AndroidSelectorHasChild(
      androidSelector: (json[r'androidSelector'] == null
          ? null
          : AndroidSelector.fromJson(
              json[r'androidSelector'],
              connection: connection,
            ))!,
    );
  }

  Map<String, dynamic> toJson() {
    return {r'androidSelector': androidSelector.toJson()};
  }
}

class AndroidSelectorHasDescendant {
  final AndroidSelector androidSelector;
  final int? maxDepth;

  AndroidSelectorHasDescendant({required this.androidSelector, this.maxDepth});

  factory AndroidSelectorHasDescendant.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return AndroidSelectorHasDescendant(
      androidSelector: (json[r'androidSelector'] == null
          ? null
          : AndroidSelector.fromJson(
              json[r'androidSelector'],
              connection: connection,
            ))!,
      maxDepth: json[r'maxDepth'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'androidSelector': androidSelector.toJson(),
      if (maxDepth != null) r'maxDepth': maxDepth,
    };
  }
}

class AndroidSocketDataEvent {
  final String data;

  AndroidSocketDataEvent({required this.data});

  factory AndroidSocketDataEvent.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return AndroidSocketDataEvent(data: (json[r'data'])!);
  }

  Map<String, dynamic> toJson() {
    return {r'data': data};
  }
}

class AndroidWebView {
  final int pid;
  final String pkg;
  final String socketName;

  AndroidWebView({
    required this.pid,
    required this.pkg,
    required this.socketName,
  });

  factory AndroidWebView.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return AndroidWebView(
      pid: (json[r'pid'])!,
      pkg: (json[r'pkg'])!,
      socketName: (json[r'socketName'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {r'pid': pid, r'pkg': pkg, r'socketName': socketName};
  }
}

class ArtifactFailureResult {
  final String? error;

  ArtifactFailureResult({this.error});

  factory ArtifactFailureResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ArtifactFailureResult(error: json[r'error']);
  }

  Map<String, dynamic> toJson() {
    return {if (error != null) r'error': error};
  }
}

class ArtifactInitializer {
  final String absolutePath;

  ArtifactInitializer({required this.absolutePath});

  factory ArtifactInitializer.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ArtifactInitializer(absolutePath: (json[r'absolutePath'])!);
  }

  Map<String, dynamic> toJson() {
    return {r'absolutePath': absolutePath};
  }
}

class ArtifactPathAfterFinishedResult {
  final String value;

  ArtifactPathAfterFinishedResult({required this.value});

  factory ArtifactPathAfterFinishedResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ArtifactPathAfterFinishedResult(value: (json[r'value'])!);
  }

  Map<String, dynamic> toJson() {
    return {r'value': value};
  }
}

class ArtifactSaveAsStreamResult {
  final StreamBase stream;

  ArtifactSaveAsStreamResult({required this.stream});

  factory ArtifactSaveAsStreamResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ArtifactSaveAsStreamResult(
      stream: (connection != null && json[r'stream'] != null
          ? ChannelOwner.from<StreamBase>(connection, json[r'stream'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'stream': {'guid': stream.guid},
    };
  }
}

class ArtifactStreamResult {
  final StreamBase stream;

  ArtifactStreamResult({required this.stream});

  factory ArtifactStreamResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ArtifactStreamResult(
      stream: (connection != null && json[r'stream'] != null
          ? ChannelOwner.from<StreamBase>(connection, json[r'stream'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'stream': {'guid': stream.guid},
    };
  }
}

class BindingCallInitializer {
  final List<SerializedValue> args;
  final FrameBase frame;
  final String name;

  BindingCallInitializer({
    required this.args,
    required this.frame,
    required this.name,
  });

  factory BindingCallInitializer.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return BindingCallInitializer(
      args:
          ((json[r'args'] as List?)
              ?.map((e) => SerializedValue.fromJson(e, connection: connection))
              .toList()) ??
          [],
      frame: (connection != null && json[r'frame'] != null
          ? ChannelOwner.from<FrameBase>(connection, json[r'frame'])
          : null)!,
      name: (json[r'name'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'args': args.map((e) => e.toJson()).toList(),
      r'frame': {'guid': frame.guid},
      r'name': name,
    };
  }
}

class BrowserContextAddInitScriptResult {
  final DisposableBase disposable;

  BrowserContextAddInitScriptResult({required this.disposable});

  factory BrowserContextAddInitScriptResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return BrowserContextAddInitScriptResult(
      disposable: (connection != null && json[r'disposable'] != null
          ? ChannelOwner.from<DisposableBase>(connection, json[r'disposable'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'disposable': {'guid': disposable.guid},
    };
  }
}

class BrowserContextBindingCallEvent {
  final BindingCallBase binding;

  BrowserContextBindingCallEvent({required this.binding});

  factory BrowserContextBindingCallEvent.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return BrowserContextBindingCallEvent(
      binding: (connection != null && json[r'binding'] != null
          ? ChannelOwner.from<BindingCallBase>(connection, json[r'binding'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'binding': {'guid': binding.guid},
    };
  }
}

class BrowserContextConsoleEvent {
  final ConsoleMessage mixinValue;
  final PageBase? page;
  final WorkerBase? worker;

  BrowserContextConsoleEvent({
    required this.mixinValue,
    this.page,
    this.worker,
  });

  factory BrowserContextConsoleEvent.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return BrowserContextConsoleEvent(
      mixinValue: (json[r'$mixin'] == null
          ? null
          : ConsoleMessage.fromJson(json[r'$mixin'], connection: connection))!,
      page: connection != null && json[r'page'] != null
          ? ChannelOwner.from<PageBase>(connection, json[r'page'])
          : null,
      worker: connection != null && json[r'worker'] != null
          ? ChannelOwner.from<WorkerBase>(connection, json[r'worker'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'$mixin': mixinValue.toJson(),
      if (page != null) r'page': {'guid': page?.guid},
      if (worker != null) r'worker': {'guid': worker?.guid},
    };
  }
}

class BrowserContextCookiesResult {
  final List<NetworkCookie> cookies;

  BrowserContextCookiesResult({required this.cookies});

  factory BrowserContextCookiesResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return BrowserContextCookiesResult(
      cookies:
          ((json[r'cookies'] as List?)
              ?.map((e) => NetworkCookie.fromJson(e, connection: connection))
              .toList()) ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {r'cookies': cookies.map((e) => e.toJson()).toList()};
  }
}

class BrowserContextCreateTempFilesItemsItems {
  final double? lastModifiedMs;
  final String name;

  BrowserContextCreateTempFilesItemsItems({
    this.lastModifiedMs,
    required this.name,
  });

  factory BrowserContextCreateTempFilesItemsItems.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return BrowserContextCreateTempFilesItemsItems(
      lastModifiedMs: (json[r'lastModifiedMs'] as num?)?.toDouble(),
      name: (json[r'name'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (lastModifiedMs != null) r'lastModifiedMs': lastModifiedMs,
      r'name': name,
    };
  }
}

class BrowserContextCreateTempFilesResult {
  final WritableStreamBase? rootDir;
  final List<WritableStreamBase> writableStreams;

  BrowserContextCreateTempFilesResult({
    this.rootDir,
    required this.writableStreams,
  });

  factory BrowserContextCreateTempFilesResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return BrowserContextCreateTempFilesResult(
      rootDir: connection != null && json[r'rootDir'] != null
          ? ChannelOwner.from<WritableStreamBase>(connection, json[r'rootDir'])
          : null,
      writableStreams:
          (connection != null
              ? (json[r'writableStreams'] as List?)
                    ?.map(
                      (e) =>
                          ChannelOwner.from<WritableStreamBase>(connection, e),
                    )
                    .toList()
              : null) ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (rootDir != null) r'rootDir': {'guid': rootDir?.guid},
      r'writableStreams': writableStreams.map((e) => {'guid': e.guid}).toList(),
    };
  }
}

class BrowserContextCredentialsCreateResult {
  final VirtualCredential credential;

  BrowserContextCredentialsCreateResult({required this.credential});

  factory BrowserContextCredentialsCreateResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return BrowserContextCredentialsCreateResult(
      credential: (json[r'credential'] == null
          ? null
          : VirtualCredential.fromJson(
              json[r'credential'],
              connection: connection,
            ))!,
    );
  }

  Map<String, dynamic> toJson() {
    return {r'credential': credential.toJson()};
  }
}

class BrowserContextCredentialsGetResult {
  final List<VirtualCredential> credentials;

  BrowserContextCredentialsGetResult({required this.credentials});

  factory BrowserContextCredentialsGetResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return BrowserContextCredentialsGetResult(
      credentials:
          ((json[r'credentials'] as List?)
              ?.map(
                (e) => VirtualCredential.fromJson(e, connection: connection),
              )
              .toList()) ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {r'credentials': credentials.map((e) => e.toJson()).toList()};
  }
}

class BrowserContextDialogEvent {
  final DialogBase dialog;

  BrowserContextDialogEvent({required this.dialog});

  factory BrowserContextDialogEvent.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return BrowserContextDialogEvent(
      dialog: (connection != null && json[r'dialog'] != null
          ? ChannelOwner.from<DialogBase>(connection, json[r'dialog'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'dialog': {'guid': dialog.guid},
    };
  }
}

class BrowserContextEvent {
  final BrowserContextBase context;

  BrowserContextEvent({required this.context});

  factory BrowserContextEvent.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return BrowserContextEvent(
      context: (connection != null && json[r'context'] != null
          ? ChannelOwner.from<BrowserContextBase>(connection, json[r'context'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'context': {'guid': context.guid},
    };
  }
}

class BrowserContextExposeBindingResult {
  final DisposableBase disposable;

  BrowserContextExposeBindingResult({required this.disposable});

  factory BrowserContextExposeBindingResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return BrowserContextExposeBindingResult(
      disposable: (connection != null && json[r'disposable'] != null
          ? ChannelOwner.from<DisposableBase>(connection, json[r'disposable'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'disposable': {'guid': disposable.guid},
    };
  }
}

class BrowserContextInitializer {
  final DebuggerBase debugger;
  final BrowserContextInitializerOptions options;
  final APIRequestContextBase requestContext;
  final TracingBase tracing;

  BrowserContextInitializer({
    required this.debugger,
    required this.options,
    required this.requestContext,
    required this.tracing,
  });

  factory BrowserContextInitializer.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return BrowserContextInitializer(
      debugger: (connection != null && json[r'debugger'] != null
          ? ChannelOwner.from<DebuggerBase>(connection, json[r'debugger'])
          : null)!,
      options: (json[r'options'] == null
          ? null
          : BrowserContextInitializerOptions.fromJson(
              json[r'options'],
              connection: connection,
            ))!,
      requestContext: (connection != null && json[r'requestContext'] != null
          ? ChannelOwner.from<APIRequestContextBase>(
              connection,
              json[r'requestContext'],
            )
          : null)!,
      tracing: (connection != null && json[r'tracing'] != null
          ? ChannelOwner.from<TracingBase>(connection, json[r'tracing'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'debugger': {'guid': debugger.guid},
      r'options': options.toJson(),
      r'requestContext': {'guid': requestContext.guid},
      r'tracing': {'guid': tracing.guid},
    };
  }
}

class BrowserContextInitializerOptions {
  final ContextOptions mixinValue;

  BrowserContextInitializerOptions({required this.mixinValue});

  factory BrowserContextInitializerOptions.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return BrowserContextInitializerOptions(
      mixinValue: (json[r'$mixin'] == null
          ? null
          : ContextOptions.fromJson(json[r'$mixin'], connection: connection))!,
    );
  }

  Map<String, dynamic> toJson() {
    return {r'$mixin': mixinValue.toJson()};
  }
}

class BrowserContextNewCDPSessionResult {
  final CDPSessionBase session;

  BrowserContextNewCDPSessionResult({required this.session});

  factory BrowserContextNewCDPSessionResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return BrowserContextNewCDPSessionResult(
      session: (connection != null && json[r'session'] != null
          ? ChannelOwner.from<CDPSessionBase>(connection, json[r'session'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'session': {'guid': session.guid},
    };
  }
}

class BrowserContextNewPageResult {
  final PageBase page;

  BrowserContextNewPageResult({required this.page});

  factory BrowserContextNewPageResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return BrowserContextNewPageResult(
      page: (connection != null && json[r'page'] != null
          ? ChannelOwner.from<PageBase>(connection, json[r'page'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'page': {'guid': page.guid},
    };
  }
}

class BrowserContextPageErrorEvent {
  final SerializedError error;
  final BrowserContextPageErrorEventLocation location;
  final PageBase page;

  BrowserContextPageErrorEvent({
    required this.error,
    required this.location,
    required this.page,
  });

  factory BrowserContextPageErrorEvent.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return BrowserContextPageErrorEvent(
      error: (json[r'error'] == null
          ? null
          : SerializedError.fromJson(json[r'error'], connection: connection))!,
      location: (json[r'location'] == null
          ? null
          : BrowserContextPageErrorEventLocation.fromJson(
              json[r'location'],
              connection: connection,
            ))!,
      page: (connection != null && json[r'page'] != null
          ? ChannelOwner.from<PageBase>(connection, json[r'page'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'error': error.toJson(),
      r'location': location.toJson(),
      r'page': {'guid': page.guid},
    };
  }
}

class BrowserContextPageErrorEventLocation {
  final int column;
  final int line;
  final String url;

  BrowserContextPageErrorEventLocation({
    required this.column,
    required this.line,
    required this.url,
  });

  factory BrowserContextPageErrorEventLocation.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return BrowserContextPageErrorEventLocation(
      column: (json[r'column'])!,
      line: (json[r'line'])!,
      url: (json[r'url'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {r'column': column, r'line': line, r'url': url};
  }
}

class BrowserContextPageEvent {
  final PageBase page;

  BrowserContextPageEvent({required this.page});

  factory BrowserContextPageEvent.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return BrowserContextPageEvent(
      page: (connection != null && json[r'page'] != null
          ? ChannelOwner.from<PageBase>(connection, json[r'page'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'page': {'guid': page.guid},
    };
  }
}

class BrowserContextRecorderEventEvent {
  final String code;
  final JsonValue data;
  final BrowserContextRecorderEventEventEventEnum event;
  final PageBase page;

  BrowserContextRecorderEventEvent({
    required this.code,
    this.data,
    required this.event,
    required this.page,
  });

  factory BrowserContextRecorderEventEvent.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return BrowserContextRecorderEventEvent(
      code: (json[r'code'])!,
      data: json[r'data'],
      event: (json[r'event'] == null
          ? null
          : BrowserContextRecorderEventEventEventEnum.values.firstWhere(
              (e) => e.value == json[r'event'],
            ))!,
      page: (connection != null && json[r'page'] != null
          ? ChannelOwner.from<PageBase>(connection, json[r'page'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'code': code,
      if (data != null) r'data': data,
      r'event': event.value,
      r'page': {'guid': page.guid},
    };
  }
}

class BrowserContextRequestEvent {
  final PageBase? page;
  final RequestBase request;

  BrowserContextRequestEvent({this.page, required this.request});

  factory BrowserContextRequestEvent.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return BrowserContextRequestEvent(
      page: connection != null && json[r'page'] != null
          ? ChannelOwner.from<PageBase>(connection, json[r'page'])
          : null,
      request: (connection != null && json[r'request'] != null
          ? ChannelOwner.from<RequestBase>(connection, json[r'request'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (page != null) r'page': {'guid': page?.guid},
      r'request': {'guid': request.guid},
    };
  }
}

class BrowserContextRequestFailedEvent {
  final String? failureText;
  final PageBase? page;
  final RequestBase request;
  final double responseEndTiming;

  BrowserContextRequestFailedEvent({
    this.failureText,
    this.page,
    required this.request,
    required this.responseEndTiming,
  });

  factory BrowserContextRequestFailedEvent.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return BrowserContextRequestFailedEvent(
      failureText: json[r'failureText'],
      page: connection != null && json[r'page'] != null
          ? ChannelOwner.from<PageBase>(connection, json[r'page'])
          : null,
      request: (connection != null && json[r'request'] != null
          ? ChannelOwner.from<RequestBase>(connection, json[r'request'])
          : null)!,
      responseEndTiming: ((json[r'responseEndTiming'] as num?)?.toDouble())!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (failureText != null) r'failureText': failureText,
      if (page != null) r'page': {'guid': page?.guid},
      r'request': {'guid': request.guid},
      r'responseEndTiming': responseEndTiming,
    };
  }
}

class BrowserContextRequestFinishedEvent {
  final PageBase? page;
  final RequestBase request;
  final ResponseBase? response;
  final double responseEndTiming;

  BrowserContextRequestFinishedEvent({
    this.page,
    required this.request,
    this.response,
    required this.responseEndTiming,
  });

  factory BrowserContextRequestFinishedEvent.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return BrowserContextRequestFinishedEvent(
      page: connection != null && json[r'page'] != null
          ? ChannelOwner.from<PageBase>(connection, json[r'page'])
          : null,
      request: (connection != null && json[r'request'] != null
          ? ChannelOwner.from<RequestBase>(connection, json[r'request'])
          : null)!,
      response: connection != null && json[r'response'] != null
          ? ChannelOwner.from<ResponseBase>(connection, json[r'response'])
          : null,
      responseEndTiming: ((json[r'responseEndTiming'] as num?)?.toDouble())!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (page != null) r'page': {'guid': page?.guid},
      r'request': {'guid': request.guid},
      if (response != null) r'response': {'guid': response?.guid},
      r'responseEndTiming': responseEndTiming,
    };
  }
}

class BrowserContextResponseEvent {
  final PageBase? page;
  final ResponseBase response;

  BrowserContextResponseEvent({this.page, required this.response});

  factory BrowserContextResponseEvent.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return BrowserContextResponseEvent(
      page: connection != null && json[r'page'] != null
          ? ChannelOwner.from<PageBase>(connection, json[r'page'])
          : null,
      response: (connection != null && json[r'response'] != null
          ? ChannelOwner.from<ResponseBase>(connection, json[r'response'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (page != null) r'page': {'guid': page?.guid},
      r'response': {'guid': response.guid},
    };
  }
}

class BrowserContextRouteEvent {
  final RouteBase route;

  BrowserContextRouteEvent({required this.route});

  factory BrowserContextRouteEvent.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return BrowserContextRouteEvent(
      route: (connection != null && json[r'route'] != null
          ? ChannelOwner.from<RouteBase>(connection, json[r'route'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'route': {'guid': route.guid},
    };
  }
}

class BrowserContextServiceWorkerEvent {
  final WorkerBase worker;

  BrowserContextServiceWorkerEvent({required this.worker});

  factory BrowserContextServiceWorkerEvent.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return BrowserContextServiceWorkerEvent(
      worker: (connection != null && json[r'worker'] != null
          ? ChannelOwner.from<WorkerBase>(connection, json[r'worker'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'worker': {'guid': worker.guid},
    };
  }
}

class BrowserContextSetGeolocationGeolocation {
  final double? accuracy;
  final double latitude;
  final double longitude;

  BrowserContextSetGeolocationGeolocation({
    this.accuracy,
    required this.latitude,
    required this.longitude,
  });

  factory BrowserContextSetGeolocationGeolocation.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return BrowserContextSetGeolocationGeolocation(
      accuracy: (json[r'accuracy'] as num?)?.toDouble(),
      latitude: ((json[r'latitude'] as num?)?.toDouble())!,
      longitude: ((json[r'longitude'] as num?)?.toDouble())!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (accuracy != null) r'accuracy': accuracy,
      r'latitude': latitude,
      r'longitude': longitude,
    };
  }
}

class BrowserContextSetHTTPCredentialsHttpCredentials {
  final String? origin;
  final String password;
  final String username;

  BrowserContextSetHTTPCredentialsHttpCredentials({
    this.origin,
    required this.password,
    required this.username,
  });

  factory BrowserContextSetHTTPCredentialsHttpCredentials.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return BrowserContextSetHTTPCredentialsHttpCredentials(
      origin: json[r'origin'],
      password: (json[r'password'])!,
      username: (json[r'username'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (origin != null) r'origin': origin,
      r'password': password,
      r'username': username,
    };
  }
}

class BrowserContextSetNetworkInterceptionPatternsPatternsItems {
  final String? glob;
  final String? regexFlags;
  final String? regexSource;
  final URLPattern? urlPattern;

  BrowserContextSetNetworkInterceptionPatternsPatternsItems({
    this.glob,
    this.regexFlags,
    this.regexSource,
    this.urlPattern,
  });

  factory BrowserContextSetNetworkInterceptionPatternsPatternsItems.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return BrowserContextSetNetworkInterceptionPatternsPatternsItems(
      glob: json[r'glob'],
      regexFlags: json[r'regexFlags'],
      regexSource: json[r'regexSource'],
      urlPattern: json[r'urlPattern'] == null
          ? null
          : URLPattern.fromJson(json[r'urlPattern'], connection: connection),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (glob != null) r'glob': glob,
      if (regexFlags != null) r'regexFlags': regexFlags,
      if (regexSource != null) r'regexSource': regexSource,
      if (urlPattern != null) r'urlPattern': urlPattern?.toJson(),
    };
  }
}

class BrowserContextSetStorageStateStorageState {
  final List<SetNetworkCookie>? cookies;
  final List<SetOriginStorage>? origins;

  BrowserContextSetStorageStateStorageState({this.cookies, this.origins});

  factory BrowserContextSetStorageStateStorageState.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return BrowserContextSetStorageStateStorageState(
      cookies: (json[r'cookies'] as List?)
          ?.map((e) => SetNetworkCookie.fromJson(e, connection: connection))
          .toList(),
      origins: (json[r'origins'] as List?)
          ?.map((e) => SetOriginStorage.fromJson(e, connection: connection))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (cookies != null) r'cookies': cookies?.map((e) => e.toJson()).toList(),
      if (origins != null) r'origins': origins?.map((e) => e.toJson()).toList(),
    };
  }
}

class BrowserContextSetWebSocketInterceptionPatternsPatternsItems {
  final String? glob;
  final String? regexFlags;
  final String? regexSource;
  final URLPattern? urlPattern;

  BrowserContextSetWebSocketInterceptionPatternsPatternsItems({
    this.glob,
    this.regexFlags,
    this.regexSource,
    this.urlPattern,
  });

  factory BrowserContextSetWebSocketInterceptionPatternsPatternsItems.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return BrowserContextSetWebSocketInterceptionPatternsPatternsItems(
      glob: json[r'glob'],
      regexFlags: json[r'regexFlags'],
      regexSource: json[r'regexSource'],
      urlPattern: json[r'urlPattern'] == null
          ? null
          : URLPattern.fromJson(json[r'urlPattern'], connection: connection),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (glob != null) r'glob': glob,
      if (regexFlags != null) r'regexFlags': regexFlags,
      if (regexSource != null) r'regexSource': regexSource,
      if (urlPattern != null) r'urlPattern': urlPattern?.toJson(),
    };
  }
}

class BrowserContextStorageStateResult {
  final List<NetworkCookie> cookies;
  final List<OriginStorage> origins;

  BrowserContextStorageStateResult({
    required this.cookies,
    required this.origins,
  });

  factory BrowserContextStorageStateResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return BrowserContextStorageStateResult(
      cookies:
          ((json[r'cookies'] as List?)
              ?.map((e) => NetworkCookie.fromJson(e, connection: connection))
              .toList()) ??
          [],
      origins:
          ((json[r'origins'] as List?)
              ?.map((e) => OriginStorage.fromJson(e, connection: connection))
              .toList()) ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'cookies': cookies.map((e) => e.toJson()).toList(),
      r'origins': origins.map((e) => e.toJson()).toList(),
    };
  }
}

class BrowserContextWebSocketRouteEvent {
  final WebSocketRouteBase webSocketRoute;

  BrowserContextWebSocketRouteEvent({required this.webSocketRoute});

  factory BrowserContextWebSocketRouteEvent.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return BrowserContextWebSocketRouteEvent(
      webSocketRoute: (connection != null && json[r'webSocketRoute'] != null
          ? ChannelOwner.from<WebSocketRouteBase>(
              connection,
              json[r'webSocketRoute'],
            )
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'webSocketRoute': {'guid': webSocketRoute.guid},
    };
  }
}

class BrowserDefaultUserAgentForTestResult {
  final String userAgent;

  BrowserDefaultUserAgentForTestResult({required this.userAgent});

  factory BrowserDefaultUserAgentForTestResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return BrowserDefaultUserAgentForTestResult(
      userAgent: (json[r'userAgent'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {r'userAgent': userAgent};
  }
}

class BrowserInitializer {
  final BrowserInitializerBrowserNameEnum browserName;
  final String name;
  final String version;

  BrowserInitializer({
    required this.browserName,
    required this.name,
    required this.version,
  });

  factory BrowserInitializer.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return BrowserInitializer(
      browserName: (json[r'browserName'] == null
          ? null
          : BrowserInitializerBrowserNameEnum.values.firstWhere(
              (e) => e.value == json[r'browserName'],
            ))!,
      name: (json[r'name'])!,
      version: (json[r'version'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'browserName': browserName.value,
      r'name': name,
      r'version': version,
    };
  }
}

class BrowserNewBrowserCDPSessionResult {
  final CDPSessionBase session;

  BrowserNewBrowserCDPSessionResult({required this.session});

  factory BrowserNewBrowserCDPSessionResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return BrowserNewBrowserCDPSessionResult(
      session: (connection != null && json[r'session'] != null
          ? ChannelOwner.from<CDPSessionBase>(connection, json[r'session'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'session': {'guid': session.guid},
    };
  }
}

class BrowserNewContextForReuseProxy {
  final String? bypass;
  final String? password;
  final String server;
  final String? username;

  BrowserNewContextForReuseProxy({
    this.bypass,
    this.password,
    required this.server,
    this.username,
  });

  factory BrowserNewContextForReuseProxy.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return BrowserNewContextForReuseProxy(
      bypass: json[r'bypass'],
      password: json[r'password'],
      server: (json[r'server'])!,
      username: json[r'username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (bypass != null) r'bypass': bypass,
      if (password != null) r'password': password,
      r'server': server,
      if (username != null) r'username': username,
    };
  }
}

class BrowserNewContextForReuseResult {
  final BrowserContextBase context;

  BrowserNewContextForReuseResult({required this.context});

  factory BrowserNewContextForReuseResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return BrowserNewContextForReuseResult(
      context: (connection != null && json[r'context'] != null
          ? ChannelOwner.from<BrowserContextBase>(connection, json[r'context'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'context': {'guid': context.guid},
    };
  }
}

class BrowserNewContextForReuseStorageState {
  final List<SetNetworkCookie>? cookies;
  final List<SetOriginStorage>? origins;

  BrowserNewContextForReuseStorageState({this.cookies, this.origins});

  factory BrowserNewContextForReuseStorageState.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return BrowserNewContextForReuseStorageState(
      cookies: (json[r'cookies'] as List?)
          ?.map((e) => SetNetworkCookie.fromJson(e, connection: connection))
          .toList(),
      origins: (json[r'origins'] as List?)
          ?.map((e) => SetOriginStorage.fromJson(e, connection: connection))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (cookies != null) r'cookies': cookies?.map((e) => e.toJson()).toList(),
      if (origins != null) r'origins': origins?.map((e) => e.toJson()).toList(),
    };
  }
}

class BrowserNewContextProxy {
  final String? bypass;
  final String? password;
  final String server;
  final String? username;

  BrowserNewContextProxy({
    this.bypass,
    this.password,
    required this.server,
    this.username,
  });

  factory BrowserNewContextProxy.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return BrowserNewContextProxy(
      bypass: json[r'bypass'],
      password: json[r'password'],
      server: (json[r'server'])!,
      username: json[r'username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (bypass != null) r'bypass': bypass,
      if (password != null) r'password': password,
      r'server': server,
      if (username != null) r'username': username,
    };
  }
}

class BrowserNewContextResult {
  final BrowserContextBase context;

  BrowserNewContextResult({required this.context});

  factory BrowserNewContextResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return BrowserNewContextResult(
      context: (connection != null && json[r'context'] != null
          ? ChannelOwner.from<BrowserContextBase>(connection, json[r'context'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'context': {'guid': context.guid},
    };
  }
}

class BrowserNewContextStorageState {
  final List<SetNetworkCookie>? cookies;
  final List<SetOriginStorage>? origins;

  BrowserNewContextStorageState({this.cookies, this.origins});

  factory BrowserNewContextStorageState.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return BrowserNewContextStorageState(
      cookies: (json[r'cookies'] as List?)
          ?.map((e) => SetNetworkCookie.fromJson(e, connection: connection))
          .toList(),
      origins: (json[r'origins'] as List?)
          ?.map((e) => SetOriginStorage.fromJson(e, connection: connection))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (cookies != null) r'cookies': cookies?.map((e) => e.toJson()).toList(),
      if (origins != null) r'origins': origins?.map((e) => e.toJson()).toList(),
    };
  }
}

class BrowserStartServerResult {
  final String endpoint;

  BrowserStartServerResult({required this.endpoint});

  factory BrowserStartServerResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return BrowserStartServerResult(endpoint: (json[r'endpoint'])!);
  }

  Map<String, dynamic> toJson() {
    return {r'endpoint': endpoint};
  }
}

class BrowserStopTracingResult {
  final ArtifactBase artifact;

  BrowserStopTracingResult({required this.artifact});

  factory BrowserStopTracingResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return BrowserStopTracingResult(
      artifact: (connection != null && json[r'artifact'] != null
          ? ChannelOwner.from<ArtifactBase>(connection, json[r'artifact'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'artifact': {'guid': artifact.guid},
    };
  }
}

class BrowserTypeConnectOverCDPResult {
  final BrowserBase browser;
  final BrowserContextBase? defaultContext;

  BrowserTypeConnectOverCDPResult({required this.browser, this.defaultContext});

  factory BrowserTypeConnectOverCDPResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return BrowserTypeConnectOverCDPResult(
      browser: (connection != null && json[r'browser'] != null
          ? ChannelOwner.from<BrowserBase>(connection, json[r'browser'])
          : null)!,
      defaultContext: connection != null && json[r'defaultContext'] != null
          ? ChannelOwner.from<BrowserContextBase>(
              connection,
              json[r'defaultContext'],
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'browser': {'guid': browser.guid},
      if (defaultContext != null)
        r'defaultContext': {'guid': defaultContext?.guid},
    };
  }
}

class BrowserTypeConnectToWorkerResult {
  final WorkerBase worker;

  BrowserTypeConnectToWorkerResult({required this.worker});

  factory BrowserTypeConnectToWorkerResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return BrowserTypeConnectToWorkerResult(
      worker: (connection != null && json[r'worker'] != null
          ? ChannelOwner.from<WorkerBase>(connection, json[r'worker'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'worker': {'guid': worker.guid},
    };
  }
}

class BrowserTypeInitializer {
  final String executablePath;
  final String name;

  BrowserTypeInitializer({required this.executablePath, required this.name});

  factory BrowserTypeInitializer.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return BrowserTypeInitializer(
      executablePath: (json[r'executablePath'])!,
      name: (json[r'name'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {r'executablePath': executablePath, r'name': name};
  }
}

class BrowserTypeLaunchPersistentContextResult {
  final BrowserBase browser;
  final BrowserContextBase context;

  BrowserTypeLaunchPersistentContextResult({
    required this.browser,
    required this.context,
  });

  factory BrowserTypeLaunchPersistentContextResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return BrowserTypeLaunchPersistentContextResult(
      browser: (connection != null && json[r'browser'] != null
          ? ChannelOwner.from<BrowserBase>(connection, json[r'browser'])
          : null)!,
      context: (connection != null && json[r'context'] != null
          ? ChannelOwner.from<BrowserContextBase>(connection, json[r'context'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'browser': {'guid': browser.guid},
      r'context': {'guid': context.guid},
    };
  }
}

class BrowserTypeLaunchResult {
  final BrowserBase browser;

  BrowserTypeLaunchResult({required this.browser});

  factory BrowserTypeLaunchResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return BrowserTypeLaunchResult(
      browser: (connection != null && json[r'browser'] != null
          ? ChannelOwner.from<BrowserBase>(connection, json[r'browser'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'browser': {'guid': browser.guid},
    };
  }
}

class CDPSessionEventEvent {
  final String method;
  final JsonValue params;

  CDPSessionEventEvent({required this.method, this.params});

  factory CDPSessionEventEvent.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return CDPSessionEventEvent(
      method: (json[r'method'])!,
      params: json[r'params'],
    );
  }

  Map<String, dynamic> toJson() {
    return {r'method': method, if (params != null) r'params': params};
  }
}

class CDPSessionSendResult {
  final JsonValue result;

  CDPSessionSendResult({this.result});

  factory CDPSessionSendResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return CDPSessionSendResult(result: json[r'result']);
  }

  Map<String, dynamic> toJson() {
    return {if (result != null) r'result': result};
  }
}

class ClientSideCallMetadata {
  final int id;
  final List<StackFrame>? stack;

  ClientSideCallMetadata({required this.id, this.stack});

  factory ClientSideCallMetadata.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ClientSideCallMetadata(
      id: (json[r'id'])!,
      stack: (json[r'stack'] as List?)
          ?.map((e) => StackFrame.fromJson(e, connection: connection))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'id': id,
      if (stack != null) r'stack': stack?.map((e) => e.toJson()).toList(),
    };
  }
}

class CommonScreenshotOptions {
  final CommonScreenshotOptionsAnimationsEnum? animations;
  final CommonScreenshotOptionsCaretEnum? caret;
  final List<CommonScreenshotOptionsMaskItems>? mask;
  final String? maskColor;
  final bool? omitBackground;
  final CommonScreenshotOptionsScaleEnum? scale;
  final String? style;

  CommonScreenshotOptions({
    this.animations,
    this.caret,
    this.mask,
    this.maskColor,
    this.omitBackground,
    this.scale,
    this.style,
  });

  factory CommonScreenshotOptions.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return CommonScreenshotOptions(
      animations: json[r'animations'] == null
          ? null
          : CommonScreenshotOptionsAnimationsEnum.values.firstWhere(
              (e) => e.value == json[r'animations'],
            ),
      caret: json[r'caret'] == null
          ? null
          : CommonScreenshotOptionsCaretEnum.values.firstWhere(
              (e) => e.value == json[r'caret'],
            ),
      mask: (json[r'mask'] as List?)
          ?.map(
            (e) => CommonScreenshotOptionsMaskItems.fromJson(
              e,
              connection: connection,
            ),
          )
          .toList(),
      maskColor: json[r'maskColor'],
      omitBackground: json[r'omitBackground'],
      scale: json[r'scale'] == null
          ? null
          : CommonScreenshotOptionsScaleEnum.values.firstWhere(
              (e) => e.value == json[r'scale'],
            ),
      style: json[r'style'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (animations != null) r'animations': animations?.value,
      if (caret != null) r'caret': caret?.value,
      if (mask != null) r'mask': mask?.map((e) => e.toJson()).toList(),
      if (maskColor != null) r'maskColor': maskColor,
      if (omitBackground != null) r'omitBackground': omitBackground,
      if (scale != null) r'scale': scale?.value,
      if (style != null) r'style': style,
    };
  }
}

class CommonScreenshotOptionsMaskItems {
  final FrameBase frame;
  final Pattern selector;

  CommonScreenshotOptionsMaskItems({
    required this.frame,
    required this.selector,
  });

  factory CommonScreenshotOptionsMaskItems.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return CommonScreenshotOptionsMaskItems(
      frame: (connection != null && json[r'frame'] != null
          ? ChannelOwner.from<FrameBase>(connection, json[r'frame'])
          : null)!,
      selector: (json[r'selector'] as String?)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'frame': {'guid': frame.guid},
      r'selector': selector.toString(),
    };
  }
}

class ConsoleMessage {
  final List<JSHandleBase> args;
  final ConsoleMessageLocation location;
  final String text;
  final double timestamp;
  final String type;

  ConsoleMessage({
    required this.args,
    required this.location,
    required this.text,
    required this.timestamp,
    required this.type,
  });

  factory ConsoleMessage.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ConsoleMessage(
      args:
          (connection != null
              ? (json[r'args'] as List?)
                    ?.map((e) => ChannelOwner.from<JSHandleBase>(connection, e))
                    .toList()
              : null) ??
          [],
      location: (json[r'location'] == null
          ? null
          : ConsoleMessageLocation.fromJson(
              json[r'location'],
              connection: connection,
            ))!,
      text: (json[r'text'])!,
      timestamp: ((json[r'timestamp'] as num?)?.toDouble())!,
      type: (json[r'type'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'args': args.map((e) => {'guid': e.guid}).toList(),
      r'location': location.toJson(),
      r'text': text,
      r'timestamp': timestamp,
      r'type': type,
    };
  }
}

class ConsoleMessageLocation {
  final int columnNumber;
  final int lineNumber;
  final String url;

  ConsoleMessageLocation({
    required this.columnNumber,
    required this.lineNumber,
    required this.url,
  });

  factory ConsoleMessageLocation.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ConsoleMessageLocation(
      columnNumber: (json[r'columnNumber'])!,
      lineNumber: (json[r'lineNumber'])!,
      url: (json[r'url'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'columnNumber': columnNumber,
      r'lineNumber': lineNumber,
      r'url': url,
    };
  }
}

class ContextOptions {
  final ContextOptionsAcceptDownloadsEnum? acceptDownloads;
  final String? baseURL;
  final bool? bypassCSP;
  final List<ContextOptionsClientCertificatesItems>? clientCertificates;
  final ContextOptionsColorSchemeEnum? colorScheme;
  final ContextOptionsContrastEnum? contrast;
  final double? deviceScaleFactor;
  final List<NameValue>? extraHTTPHeaders;
  final ContextOptionsForcedColorsEnum? forcedColors;
  final ContextOptionsGeolocation? geolocation;
  final bool? hasTouch;
  final ContextOptionsHttpCredentials? httpCredentials;
  final bool? ignoreHTTPSErrors;
  final bool? isMobile;
  final bool? javaScriptEnabled;
  final String? locale;
  final bool? noDefaultViewport;
  final bool? offline;
  final List<String>? permissions;
  final RecordHarOptions? recordHar;
  final ContextOptionsRecordVideo? recordVideo;
  final ContextOptionsReducedMotionEnum? reducedMotion;
  final ContextOptionsScreen? screen;
  final List<SelectorEngine>? selectorEngines;
  final ContextOptionsServiceWorkersEnum? serviceWorkers;
  final bool? strictSelectors;
  final String? testIdAttributeName;
  final String? timezoneId;
  final String? userAgent;
  final ContextOptionsViewport? viewport;

  ContextOptions({
    this.acceptDownloads,
    this.baseURL,
    this.bypassCSP,
    this.clientCertificates,
    this.colorScheme,
    this.contrast,
    this.deviceScaleFactor,
    this.extraHTTPHeaders,
    this.forcedColors,
    this.geolocation,
    this.hasTouch,
    this.httpCredentials,
    this.ignoreHTTPSErrors,
    this.isMobile,
    this.javaScriptEnabled,
    this.locale,
    this.noDefaultViewport,
    this.offline,
    this.permissions,
    this.recordHar,
    this.recordVideo,
    this.reducedMotion,
    this.screen,
    this.selectorEngines,
    this.serviceWorkers,
    this.strictSelectors,
    this.testIdAttributeName,
    this.timezoneId,
    this.userAgent,
    this.viewport,
  });

  factory ContextOptions.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ContextOptions(
      acceptDownloads: json[r'acceptDownloads'] == null
          ? null
          : ContextOptionsAcceptDownloadsEnum.values.firstWhere(
              (e) => e.value == json[r'acceptDownloads'],
            ),
      baseURL: json[r'baseURL'],
      bypassCSP: json[r'bypassCSP'],
      clientCertificates: (json[r'clientCertificates'] as List?)
          ?.map(
            (e) => ContextOptionsClientCertificatesItems.fromJson(
              e,
              connection: connection,
            ),
          )
          .toList(),
      colorScheme: json[r'colorScheme'] == null
          ? null
          : ContextOptionsColorSchemeEnum.values.firstWhere(
              (e) => e.value == json[r'colorScheme'],
            ),
      contrast: json[r'contrast'] == null
          ? null
          : ContextOptionsContrastEnum.values.firstWhere(
              (e) => e.value == json[r'contrast'],
            ),
      deviceScaleFactor: (json[r'deviceScaleFactor'] as num?)?.toDouble(),
      extraHTTPHeaders: (json[r'extraHTTPHeaders'] as List?)
          ?.map((e) => NameValue.fromJson(e, connection: connection))
          .toList(),
      forcedColors: json[r'forcedColors'] == null
          ? null
          : ContextOptionsForcedColorsEnum.values.firstWhere(
              (e) => e.value == json[r'forcedColors'],
            ),
      geolocation: json[r'geolocation'] == null
          ? null
          : ContextOptionsGeolocation.fromJson(
              json[r'geolocation'],
              connection: connection,
            ),
      hasTouch: json[r'hasTouch'],
      httpCredentials: json[r'httpCredentials'] == null
          ? null
          : ContextOptionsHttpCredentials.fromJson(
              json[r'httpCredentials'],
              connection: connection,
            ),
      ignoreHTTPSErrors: json[r'ignoreHTTPSErrors'],
      isMobile: json[r'isMobile'],
      javaScriptEnabled: json[r'javaScriptEnabled'],
      locale: json[r'locale'],
      noDefaultViewport: json[r'noDefaultViewport'],
      offline: json[r'offline'],
      permissions: (json[r'permissions'] as List?)?.cast<String>(),
      recordHar: json[r'recordHar'] == null
          ? null
          : RecordHarOptions.fromJson(
              json[r'recordHar'],
              connection: connection,
            ),
      recordVideo: json[r'recordVideo'] == null
          ? null
          : ContextOptionsRecordVideo.fromJson(
              json[r'recordVideo'],
              connection: connection,
            ),
      reducedMotion: json[r'reducedMotion'] == null
          ? null
          : ContextOptionsReducedMotionEnum.values.firstWhere(
              (e) => e.value == json[r'reducedMotion'],
            ),
      screen: json[r'screen'] == null
          ? null
          : ContextOptionsScreen.fromJson(
              json[r'screen'],
              connection: connection,
            ),
      selectorEngines: (json[r'selectorEngines'] as List?)
          ?.map((e) => SelectorEngine.fromJson(e, connection: connection))
          .toList(),
      serviceWorkers: json[r'serviceWorkers'] == null
          ? null
          : ContextOptionsServiceWorkersEnum.values.firstWhere(
              (e) => e.value == json[r'serviceWorkers'],
            ),
      strictSelectors: json[r'strictSelectors'],
      testIdAttributeName: json[r'testIdAttributeName'],
      timezoneId: json[r'timezoneId'],
      userAgent: json[r'userAgent'],
      viewport: json[r'viewport'] == null
          ? null
          : ContextOptionsViewport.fromJson(
              json[r'viewport'],
              connection: connection,
            ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (acceptDownloads != null) r'acceptDownloads': acceptDownloads?.value,
      if (baseURL != null) r'baseURL': baseURL,
      if (bypassCSP != null) r'bypassCSP': bypassCSP,
      if (clientCertificates != null)
        r'clientCertificates': clientCertificates
            ?.map((e) => e.toJson())
            .toList(),
      if (colorScheme != null) r'colorScheme': colorScheme?.value,
      if (contrast != null) r'contrast': contrast?.value,
      if (deviceScaleFactor != null) r'deviceScaleFactor': deviceScaleFactor,
      if (extraHTTPHeaders != null)
        r'extraHTTPHeaders': extraHTTPHeaders?.map((e) => e.toJson()).toList(),
      if (forcedColors != null) r'forcedColors': forcedColors?.value,
      if (geolocation != null) r'geolocation': geolocation?.toJson(),
      if (hasTouch != null) r'hasTouch': hasTouch,
      if (httpCredentials != null)
        r'httpCredentials': httpCredentials?.toJson(),
      if (ignoreHTTPSErrors != null) r'ignoreHTTPSErrors': ignoreHTTPSErrors,
      if (isMobile != null) r'isMobile': isMobile,
      if (javaScriptEnabled != null) r'javaScriptEnabled': javaScriptEnabled,
      if (locale != null) r'locale': locale,
      if (noDefaultViewport != null) r'noDefaultViewport': noDefaultViewport,
      if (offline != null) r'offline': offline,
      if (permissions != null) r'permissions': permissions,
      if (recordHar != null) r'recordHar': recordHar?.toJson(),
      if (recordVideo != null) r'recordVideo': recordVideo?.toJson(),
      if (reducedMotion != null) r'reducedMotion': reducedMotion?.value,
      if (screen != null) r'screen': screen?.toJson(),
      if (selectorEngines != null)
        r'selectorEngines': selectorEngines?.map((e) => e.toJson()).toList(),
      if (serviceWorkers != null) r'serviceWorkers': serviceWorkers?.value,
      if (strictSelectors != null) r'strictSelectors': strictSelectors,
      if (testIdAttributeName != null)
        r'testIdAttributeName': testIdAttributeName,
      if (timezoneId != null) r'timezoneId': timezoneId,
      if (userAgent != null) r'userAgent': userAgent,
      if (viewport != null) r'viewport': viewport?.toJson(),
    };
  }
}

class ContextOptionsClientCertificatesItems {
  final String? cert;
  final String? key;
  final String origin;
  final String? passphrase;
  final String? pfx;

  ContextOptionsClientCertificatesItems({
    this.cert,
    this.key,
    required this.origin,
    this.passphrase,
    this.pfx,
  });

  factory ContextOptionsClientCertificatesItems.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ContextOptionsClientCertificatesItems(
      cert: json[r'cert'],
      key: json[r'key'],
      origin: (json[r'origin'])!,
      passphrase: json[r'passphrase'],
      pfx: json[r'pfx'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (cert != null) r'cert': cert,
      if (key != null) r'key': key,
      r'origin': origin,
      if (passphrase != null) r'passphrase': passphrase,
      if (pfx != null) r'pfx': pfx,
    };
  }
}

class ContextOptionsGeolocation {
  final double? accuracy;
  final double latitude;
  final double longitude;

  ContextOptionsGeolocation({
    this.accuracy,
    required this.latitude,
    required this.longitude,
  });

  factory ContextOptionsGeolocation.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ContextOptionsGeolocation(
      accuracy: (json[r'accuracy'] as num?)?.toDouble(),
      latitude: ((json[r'latitude'] as num?)?.toDouble())!,
      longitude: ((json[r'longitude'] as num?)?.toDouble())!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (accuracy != null) r'accuracy': accuracy,
      r'latitude': latitude,
      r'longitude': longitude,
    };
  }
}

class ContextOptionsHttpCredentials {
  final String? origin;
  final String password;
  final ContextOptionsHttpCredentialsSendEnum? send;
  final String username;

  ContextOptionsHttpCredentials({
    this.origin,
    required this.password,
    this.send,
    required this.username,
  });

  factory ContextOptionsHttpCredentials.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ContextOptionsHttpCredentials(
      origin: json[r'origin'],
      password: (json[r'password'])!,
      send: json[r'send'] == null
          ? null
          : ContextOptionsHttpCredentialsSendEnum.values.firstWhere(
              (e) => e.value == json[r'send'],
            ),
      username: (json[r'username'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (origin != null) r'origin': origin,
      r'password': password,
      if (send != null) r'send': send?.value,
      r'username': username,
    };
  }
}

class ContextOptionsRecordVideo {
  final String? dir;
  final ContextOptionsRecordVideoShowActions? showActions;
  final ContextOptionsRecordVideoSize? size;

  ContextOptionsRecordVideo({this.dir, this.showActions, this.size});

  factory ContextOptionsRecordVideo.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ContextOptionsRecordVideo(
      dir: json[r'dir'],
      showActions: json[r'showActions'] == null
          ? null
          : ContextOptionsRecordVideoShowActions.fromJson(
              json[r'showActions'],
              connection: connection,
            ),
      size: json[r'size'] == null
          ? null
          : ContextOptionsRecordVideoSize.fromJson(
              json[r'size'],
              connection: connection,
            ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (dir != null) r'dir': dir,
      if (showActions != null) r'showActions': showActions?.toJson(),
      if (size != null) r'size': size?.toJson(),
    };
  }
}

class ContextOptionsRecordVideoShowActions {
  final ShowActionsOptions mixinValue;

  ContextOptionsRecordVideoShowActions({required this.mixinValue});

  factory ContextOptionsRecordVideoShowActions.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ContextOptionsRecordVideoShowActions(
      mixinValue: (json[r'$mixin'] == null
          ? null
          : ShowActionsOptions.fromJson(
              json[r'$mixin'],
              connection: connection,
            ))!,
    );
  }

  Map<String, dynamic> toJson() {
    return {r'$mixin': mixinValue.toJson()};
  }
}

class ContextOptionsRecordVideoSize {
  final int height;
  final int width;

  ContextOptionsRecordVideoSize({required this.height, required this.width});

  factory ContextOptionsRecordVideoSize.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ContextOptionsRecordVideoSize(
      height: (json[r'height'])!,
      width: (json[r'width'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {r'height': height, r'width': width};
  }
}

class ContextOptionsScreen {
  final int height;
  final int width;

  ContextOptionsScreen({required this.height, required this.width});

  factory ContextOptionsScreen.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ContextOptionsScreen(
      height: (json[r'height'])!,
      width: (json[r'width'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {r'height': height, r'width': width};
  }
}

class ContextOptionsViewport {
  final int height;
  final int width;

  ContextOptionsViewport({required this.height, required this.width});

  factory ContextOptionsViewport.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ContextOptionsViewport(
      height: (json[r'height'])!,
      width: (json[r'width'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {r'height': height, r'width': width};
  }
}

class DebugControllerInspectRequestedEvent {
  final String ariaSnapshot;
  final Pattern locator;
  final Pattern selector;

  DebugControllerInspectRequestedEvent({
    required this.ariaSnapshot,
    required this.locator,
    required this.selector,
  });

  factory DebugControllerInspectRequestedEvent.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return DebugControllerInspectRequestedEvent(
      ariaSnapshot: (json[r'ariaSnapshot'])!,
      locator: (json[r'locator'] as String?)!,
      selector: (json[r'selector'] as String?)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'ariaSnapshot': ariaSnapshot,
      r'locator': locator.toString(),
      r'selector': selector.toString(),
    };
  }
}

class DebugControllerPausedEvent {
  final bool paused;

  DebugControllerPausedEvent({required this.paused});

  factory DebugControllerPausedEvent.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return DebugControllerPausedEvent(paused: (json[r'paused'])!);
  }

  Map<String, dynamic> toJson() {
    return {r'paused': paused};
  }
}

class DebugControllerSetModeRequestedEvent {
  final String mode;

  DebugControllerSetModeRequestedEvent({required this.mode});

  factory DebugControllerSetModeRequestedEvent.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return DebugControllerSetModeRequestedEvent(mode: (json[r'mode'])!);
  }

  Map<String, dynamic> toJson() {
    return {r'mode': mode};
  }
}

class DebugControllerSourceChangedEvent {
  final List<String>? actions;
  final String? footer;
  final String? header;
  final String text;

  DebugControllerSourceChangedEvent({
    this.actions,
    this.footer,
    this.header,
    required this.text,
  });

  factory DebugControllerSourceChangedEvent.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return DebugControllerSourceChangedEvent(
      actions: (json[r'actions'] as List?)?.cast<String>(),
      footer: json[r'footer'],
      header: json[r'header'],
      text: (json[r'text'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (actions != null) r'actions': actions,
      if (footer != null) r'footer': footer,
      if (header != null) r'header': header,
      r'text': text,
    };
  }
}

class DebugControllerStateChangedEvent {
  final int pageCount;

  DebugControllerStateChangedEvent({required this.pageCount});

  factory DebugControllerStateChangedEvent.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return DebugControllerStateChangedEvent(pageCount: (json[r'pageCount'])!);
  }

  Map<String, dynamic> toJson() {
    return {r'pageCount': pageCount};
  }
}

class DebuggerPausedStateChangedEvent {
  final DebuggerPausedStateChangedEventPausedDetails? pausedDetails;

  DebuggerPausedStateChangedEvent({this.pausedDetails});

  factory DebuggerPausedStateChangedEvent.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return DebuggerPausedStateChangedEvent(
      pausedDetails: json[r'pausedDetails'] == null
          ? null
          : DebuggerPausedStateChangedEventPausedDetails.fromJson(
              json[r'pausedDetails'],
              connection: connection,
            ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (pausedDetails != null) r'pausedDetails': pausedDetails?.toJson(),
    };
  }
}

class DebuggerPausedStateChangedEventPausedDetails {
  final DebuggerPausedStateChangedEventPausedDetailsLocation location;
  final String? stack;
  final String title;

  DebuggerPausedStateChangedEventPausedDetails({
    required this.location,
    this.stack,
    required this.title,
  });

  factory DebuggerPausedStateChangedEventPausedDetails.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return DebuggerPausedStateChangedEventPausedDetails(
      location: (json[r'location'] == null
          ? null
          : DebuggerPausedStateChangedEventPausedDetailsLocation.fromJson(
              json[r'location'],
              connection: connection,
            ))!,
      stack: json[r'stack'],
      title: (json[r'title'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'location': location.toJson(),
      if (stack != null) r'stack': stack,
      r'title': title,
    };
  }
}

class DebuggerPausedStateChangedEventPausedDetailsLocation {
  final int? column;
  final String file;
  final int? line;

  DebuggerPausedStateChangedEventPausedDetailsLocation({
    this.column,
    required this.file,
    this.line,
  });

  factory DebuggerPausedStateChangedEventPausedDetailsLocation.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return DebuggerPausedStateChangedEventPausedDetailsLocation(
      column: json[r'column'],
      file: (json[r'file'])!,
      line: json[r'line'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (column != null) r'column': column,
      r'file': file,
      if (line != null) r'line': line,
    };
  }
}

class DebuggerRunToLocation {
  final int? column;
  final String file;
  final int? line;

  DebuggerRunToLocation({this.column, required this.file, this.line});

  factory DebuggerRunToLocation.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return DebuggerRunToLocation(
      column: json[r'column'],
      file: (json[r'file'])!,
      line: json[r'line'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (column != null) r'column': column,
      r'file': file,
      if (line != null) r'line': line,
    };
  }
}

class DialogInitializer {
  final String defaultValue;
  final String message;
  final PageBase? page;
  final String type;

  DialogInitializer({
    required this.defaultValue,
    required this.message,
    this.page,
    required this.type,
  });

  factory DialogInitializer.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return DialogInitializer(
      defaultValue: (json[r'defaultValue'])!,
      message: (json[r'message'])!,
      page: connection != null && json[r'page'] != null
          ? ChannelOwner.from<PageBase>(connection, json[r'page'])
          : null,
      type: (json[r'type'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'defaultValue': defaultValue,
      r'message': message,
      if (page != null) r'page': {'guid': page?.guid},
      r'type': type,
    };
  }
}

class ElectronApplicationBrowserWindowResult {
  final JSHandleBase handle;

  ElectronApplicationBrowserWindowResult({required this.handle});

  factory ElectronApplicationBrowserWindowResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ElectronApplicationBrowserWindowResult(
      handle: (connection != null && json[r'handle'] != null
          ? ChannelOwner.from<JSHandleBase>(connection, json[r'handle'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'handle': {'guid': handle.guid},
    };
  }
}

class ElectronApplicationConsoleEvent {
  final ConsoleMessage mixinValue;

  ElectronApplicationConsoleEvent({required this.mixinValue});

  factory ElectronApplicationConsoleEvent.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ElectronApplicationConsoleEvent(
      mixinValue: (json[r'$mixin'] == null
          ? null
          : ConsoleMessage.fromJson(json[r'$mixin'], connection: connection))!,
    );
  }

  Map<String, dynamic> toJson() {
    return {r'$mixin': mixinValue.toJson()};
  }
}

class ElectronApplicationEvaluateExpressionHandleResult {
  final JSHandleBase handle;

  ElectronApplicationEvaluateExpressionHandleResult({required this.handle});

  factory ElectronApplicationEvaluateExpressionHandleResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ElectronApplicationEvaluateExpressionHandleResult(
      handle: (connection != null && json[r'handle'] != null
          ? ChannelOwner.from<JSHandleBase>(connection, json[r'handle'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'handle': {'guid': handle.guid},
    };
  }
}

class ElectronApplicationEvaluateExpressionResult {
  final SerializedValue value;

  ElectronApplicationEvaluateExpressionResult({required this.value});

  factory ElectronApplicationEvaluateExpressionResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ElectronApplicationEvaluateExpressionResult(
      value: (json[r'value'] == null
          ? null
          : SerializedValue.fromJson(json[r'value'], connection: connection))!,
    );
  }

  Map<String, dynamic> toJson() {
    return {r'value': value.toJson()};
  }
}

class ElectronApplicationInitializer {
  final BrowserContextBase context;

  ElectronApplicationInitializer({required this.context});

  factory ElectronApplicationInitializer.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ElectronApplicationInitializer(
      context: (connection != null && json[r'context'] != null
          ? ChannelOwner.from<BrowserContextBase>(connection, json[r'context'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'context': {'guid': context.guid},
    };
  }
}

class ElectronLaunchGeolocation {
  final double? accuracy;
  final double latitude;
  final double longitude;

  ElectronLaunchGeolocation({
    this.accuracy,
    required this.latitude,
    required this.longitude,
  });

  factory ElectronLaunchGeolocation.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ElectronLaunchGeolocation(
      accuracy: (json[r'accuracy'] as num?)?.toDouble(),
      latitude: ((json[r'latitude'] as num?)?.toDouble())!,
      longitude: ((json[r'longitude'] as num?)?.toDouble())!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (accuracy != null) r'accuracy': accuracy,
      r'latitude': latitude,
      r'longitude': longitude,
    };
  }
}

class ElectronLaunchHttpCredentials {
  final String? origin;
  final String password;
  final String username;

  ElectronLaunchHttpCredentials({
    this.origin,
    required this.password,
    required this.username,
  });

  factory ElectronLaunchHttpCredentials.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ElectronLaunchHttpCredentials(
      origin: json[r'origin'],
      password: (json[r'password'])!,
      username: (json[r'username'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (origin != null) r'origin': origin,
      r'password': password,
      r'username': username,
    };
  }
}

class ElectronLaunchRecordVideo {
  final String? dir;
  final ElectronLaunchRecordVideoShowActions? showActions;
  final ElectronLaunchRecordVideoSize? size;

  ElectronLaunchRecordVideo({this.dir, this.showActions, this.size});

  factory ElectronLaunchRecordVideo.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ElectronLaunchRecordVideo(
      dir: json[r'dir'],
      showActions: json[r'showActions'] == null
          ? null
          : ElectronLaunchRecordVideoShowActions.fromJson(
              json[r'showActions'],
              connection: connection,
            ),
      size: json[r'size'] == null
          ? null
          : ElectronLaunchRecordVideoSize.fromJson(
              json[r'size'],
              connection: connection,
            ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (dir != null) r'dir': dir,
      if (showActions != null) r'showActions': showActions?.toJson(),
      if (size != null) r'size': size?.toJson(),
    };
  }
}

class ElectronLaunchRecordVideoShowActions {
  final ShowActionsOptions mixinValue;

  ElectronLaunchRecordVideoShowActions({required this.mixinValue});

  factory ElectronLaunchRecordVideoShowActions.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ElectronLaunchRecordVideoShowActions(
      mixinValue: (json[r'$mixin'] == null
          ? null
          : ShowActionsOptions.fromJson(
              json[r'$mixin'],
              connection: connection,
            ))!,
    );
  }

  Map<String, dynamic> toJson() {
    return {r'$mixin': mixinValue.toJson()};
  }
}

class ElectronLaunchRecordVideoSize {
  final int height;
  final int width;

  ElectronLaunchRecordVideoSize({required this.height, required this.width});

  factory ElectronLaunchRecordVideoSize.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ElectronLaunchRecordVideoSize(
      height: (json[r'height'])!,
      width: (json[r'width'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {r'height': height, r'width': width};
  }
}

class ElectronLaunchResult {
  final ElectronApplicationBase electronApplication;

  ElectronLaunchResult({required this.electronApplication});

  factory ElectronLaunchResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ElectronLaunchResult(
      electronApplication:
          (connection != null && json[r'electronApplication'] != null
          ? ChannelOwner.from<ElectronApplicationBase>(
              connection,
              json[r'electronApplication'],
            )
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'electronApplication': {'guid': electronApplication.guid},
    };
  }
}

class ElementHandleBoundingBoxResult {
  final Rect? value;

  ElementHandleBoundingBoxResult({this.value});

  factory ElementHandleBoundingBoxResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ElementHandleBoundingBoxResult(
      value: json[r'value'] == null
          ? null
          : Rect.fromJson(json[r'value'], connection: connection),
    );
  }

  Map<String, dynamic> toJson() {
    return {if (value != null) r'value': value?.toJson()};
  }
}

class ElementHandleContentFrameResult {
  final FrameBase? frame;

  ElementHandleContentFrameResult({this.frame});

  factory ElementHandleContentFrameResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ElementHandleContentFrameResult(
      frame: connection != null && json[r'frame'] != null
          ? ChannelOwner.from<FrameBase>(connection, json[r'frame'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (frame != null) r'frame': {'guid': frame?.guid},
    };
  }
}

class ElementHandleEvalOnSelectorAllResult {
  final SerializedValue value;

  ElementHandleEvalOnSelectorAllResult({required this.value});

  factory ElementHandleEvalOnSelectorAllResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ElementHandleEvalOnSelectorAllResult(
      value: (json[r'value'] == null
          ? null
          : SerializedValue.fromJson(json[r'value'], connection: connection))!,
    );
  }

  Map<String, dynamic> toJson() {
    return {r'value': value.toJson()};
  }
}

class ElementHandleEvalOnSelectorResult {
  final SerializedValue value;

  ElementHandleEvalOnSelectorResult({required this.value});

  factory ElementHandleEvalOnSelectorResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ElementHandleEvalOnSelectorResult(
      value: (json[r'value'] == null
          ? null
          : SerializedValue.fromJson(json[r'value'], connection: connection))!,
    );
  }

  Map<String, dynamic> toJson() {
    return {r'value': value.toJson()};
  }
}

class ElementHandleGetAttributeResult {
  final String? value;

  ElementHandleGetAttributeResult({this.value});

  factory ElementHandleGetAttributeResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ElementHandleGetAttributeResult(value: json[r'value']);
  }

  Map<String, dynamic> toJson() {
    return {if (value != null) r'value': value};
  }
}

class ElementHandleInnerHTMLResult {
  final String value;

  ElementHandleInnerHTMLResult({required this.value});

  factory ElementHandleInnerHTMLResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ElementHandleInnerHTMLResult(value: (json[r'value'])!);
  }

  Map<String, dynamic> toJson() {
    return {r'value': value};
  }
}

class ElementHandleInnerTextResult {
  final String value;

  ElementHandleInnerTextResult({required this.value});

  factory ElementHandleInnerTextResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ElementHandleInnerTextResult(value: (json[r'value'])!);
  }

  Map<String, dynamic> toJson() {
    return {r'value': value};
  }
}

class ElementHandleInputValueResult {
  final String value;

  ElementHandleInputValueResult({required this.value});

  factory ElementHandleInputValueResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ElementHandleInputValueResult(value: (json[r'value'])!);
  }

  Map<String, dynamic> toJson() {
    return {r'value': value};
  }
}

class ElementHandleIsCheckedResult {
  final bool value;

  ElementHandleIsCheckedResult({required this.value});

  factory ElementHandleIsCheckedResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ElementHandleIsCheckedResult(value: (json[r'value'])!);
  }

  Map<String, dynamic> toJson() {
    return {r'value': value};
  }
}

class ElementHandleIsDisabledResult {
  final bool value;

  ElementHandleIsDisabledResult({required this.value});

  factory ElementHandleIsDisabledResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ElementHandleIsDisabledResult(value: (json[r'value'])!);
  }

  Map<String, dynamic> toJson() {
    return {r'value': value};
  }
}

class ElementHandleIsEditableResult {
  final bool value;

  ElementHandleIsEditableResult({required this.value});

  factory ElementHandleIsEditableResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ElementHandleIsEditableResult(value: (json[r'value'])!);
  }

  Map<String, dynamic> toJson() {
    return {r'value': value};
  }
}

class ElementHandleIsEnabledResult {
  final bool value;

  ElementHandleIsEnabledResult({required this.value});

  factory ElementHandleIsEnabledResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ElementHandleIsEnabledResult(value: (json[r'value'])!);
  }

  Map<String, dynamic> toJson() {
    return {r'value': value};
  }
}

class ElementHandleIsHiddenResult {
  final bool value;

  ElementHandleIsHiddenResult({required this.value});

  factory ElementHandleIsHiddenResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ElementHandleIsHiddenResult(value: (json[r'value'])!);
  }

  Map<String, dynamic> toJson() {
    return {r'value': value};
  }
}

class ElementHandleIsVisibleResult {
  final bool value;

  ElementHandleIsVisibleResult({required this.value});

  factory ElementHandleIsVisibleResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ElementHandleIsVisibleResult(value: (json[r'value'])!);
  }

  Map<String, dynamic> toJson() {
    return {r'value': value};
  }
}

class ElementHandleOwnerFrameResult {
  final FrameBase? frame;

  ElementHandleOwnerFrameResult({this.frame});

  factory ElementHandleOwnerFrameResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ElementHandleOwnerFrameResult(
      frame: connection != null && json[r'frame'] != null
          ? ChannelOwner.from<FrameBase>(connection, json[r'frame'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (frame != null) r'frame': {'guid': frame?.guid},
    };
  }
}

class ElementHandleQuerySelectorAllResult {
  final List<ElementHandleBase> elements;

  ElementHandleQuerySelectorAllResult({required this.elements});

  factory ElementHandleQuerySelectorAllResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ElementHandleQuerySelectorAllResult(
      elements:
          (connection != null
              ? (json[r'elements'] as List?)
                    ?.map(
                      (e) =>
                          ChannelOwner.from<ElementHandleBase>(connection, e),
                    )
                    .toList()
              : null) ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'elements': elements.map((e) => {'guid': e.guid}).toList(),
    };
  }
}

class ElementHandleQuerySelectorResult {
  final ElementHandleBase? element;

  ElementHandleQuerySelectorResult({this.element});

  factory ElementHandleQuerySelectorResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ElementHandleQuerySelectorResult(
      element: connection != null && json[r'element'] != null
          ? ChannelOwner.from<ElementHandleBase>(connection, json[r'element'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (element != null) r'element': {'guid': element?.guid},
    };
  }
}

class ElementHandleScreenshotResult {
  final String binary;

  ElementHandleScreenshotResult({required this.binary});

  factory ElementHandleScreenshotResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ElementHandleScreenshotResult(binary: (json[r'binary'])!);
  }

  Map<String, dynamic> toJson() {
    return {r'binary': binary};
  }
}

class ElementHandleSelectOptionOptionsItems {
  final int? index;
  final String? label;
  final String? value;
  final String? valueOrLabel;

  ElementHandleSelectOptionOptionsItems({
    this.index,
    this.label,
    this.value,
    this.valueOrLabel,
  });

  factory ElementHandleSelectOptionOptionsItems.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ElementHandleSelectOptionOptionsItems(
      index: json[r'index'],
      label: json[r'label'],
      value: json[r'value'],
      valueOrLabel: json[r'valueOrLabel'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (index != null) r'index': index,
      if (label != null) r'label': label,
      if (value != null) r'value': value,
      if (valueOrLabel != null) r'valueOrLabel': valueOrLabel,
    };
  }
}

class ElementHandleSelectOptionResult {
  final List<String> values;

  ElementHandleSelectOptionResult({required this.values});

  factory ElementHandleSelectOptionResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ElementHandleSelectOptionResult(
      values: ((json[r'values'] as List?)?.cast<String>()) ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {r'values': values};
  }
}

class ElementHandleSetInputFilesPayloadsItems {
  final String buffer;
  final String? mimeType;
  final String name;

  ElementHandleSetInputFilesPayloadsItems({
    required this.buffer,
    this.mimeType,
    required this.name,
  });

  factory ElementHandleSetInputFilesPayloadsItems.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ElementHandleSetInputFilesPayloadsItems(
      buffer: (json[r'buffer'])!,
      mimeType: json[r'mimeType'],
      name: (json[r'name'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'buffer': buffer,
      if (mimeType != null) r'mimeType': mimeType,
      r'name': name,
    };
  }
}

class ElementHandleTextContentResult {
  final String? value;

  ElementHandleTextContentResult({this.value});

  factory ElementHandleTextContentResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ElementHandleTextContentResult(value: json[r'value']);
  }

  Map<String, dynamic> toJson() {
    return {if (value != null) r'value': value};
  }
}

class ElementHandleWaitForSelectorResult {
  final ElementHandleBase? element;

  ElementHandleWaitForSelectorResult({this.element});

  factory ElementHandleWaitForSelectorResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ElementHandleWaitForSelectorResult(
      element: connection != null && json[r'element'] != null
          ? ChannelOwner.from<ElementHandleBase>(connection, json[r'element'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (element != null) r'element': {'guid': element?.guid},
    };
  }
}

class ExpectedTextValue {
  final bool? ignoreCase;
  final bool? matchSubstring;
  final bool? normalizeWhiteSpace;
  final String? regexFlags;
  final String? regexSource;
  final String? string;

  ExpectedTextValue({
    this.ignoreCase,
    this.matchSubstring,
    this.normalizeWhiteSpace,
    this.regexFlags,
    this.regexSource,
    this.string,
  });

  factory ExpectedTextValue.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ExpectedTextValue(
      ignoreCase: json[r'ignoreCase'],
      matchSubstring: json[r'matchSubstring'],
      normalizeWhiteSpace: json[r'normalizeWhiteSpace'],
      regexFlags: json[r'regexFlags'],
      regexSource: json[r'regexSource'],
      string: json[r'string'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (ignoreCase != null) r'ignoreCase': ignoreCase,
      if (matchSubstring != null) r'matchSubstring': matchSubstring,
      if (normalizeWhiteSpace != null)
        r'normalizeWhiteSpace': normalizeWhiteSpace,
      if (regexFlags != null) r'regexFlags': regexFlags,
      if (regexSource != null) r'regexSource': regexSource,
      if (string != null) r'string': string,
    };
  }
}

class FormField {
  final FormFieldFile? file;
  final String name;
  final String? value;

  FormField({this.file, required this.name, this.value});

  factory FormField.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return FormField(
      file: json[r'file'] == null
          ? null
          : FormFieldFile.fromJson(json[r'file'], connection: connection),
      name: (json[r'name'])!,
      value: json[r'value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (file != null) r'file': file?.toJson(),
      r'name': name,
      if (value != null) r'value': value,
    };
  }
}

class FormFieldFile {
  final String buffer;
  final String? mimeType;
  final String name;

  FormFieldFile({required this.buffer, this.mimeType, required this.name});

  factory FormFieldFile.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return FormFieldFile(
      buffer: (json[r'buffer'])!,
      mimeType: json[r'mimeType'],
      name: (json[r'name'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'buffer': buffer,
      if (mimeType != null) r'mimeType': mimeType,
      r'name': name,
    };
  }
}

class FrameAddScriptTagResult {
  final ElementHandleBase element;

  FrameAddScriptTagResult({required this.element});

  factory FrameAddScriptTagResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return FrameAddScriptTagResult(
      element: (connection != null && json[r'element'] != null
          ? ChannelOwner.from<ElementHandleBase>(connection, json[r'element'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'element': {'guid': element.guid},
    };
  }
}

class FrameAddStyleTagResult {
  final ElementHandleBase element;

  FrameAddStyleTagResult({required this.element});

  factory FrameAddStyleTagResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return FrameAddStyleTagResult(
      element: (connection != null && json[r'element'] != null
          ? ChannelOwner.from<ElementHandleBase>(connection, json[r'element'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'element': {'guid': element.guid},
    };
  }
}

class FrameAriaSnapshotResult {
  final String snapshot;

  FrameAriaSnapshotResult({required this.snapshot});

  factory FrameAriaSnapshotResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return FrameAriaSnapshotResult(snapshot: (json[r'snapshot'])!);
  }

  Map<String, dynamic> toJson() {
    return {r'snapshot': snapshot};
  }
}

class FrameContentResult {
  final String value;

  FrameContentResult({required this.value});

  factory FrameContentResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return FrameContentResult(value: (json[r'value'])!);
  }

  Map<String, dynamic> toJson() {
    return {r'value': value};
  }
}

class FrameDropDataItems {
  final String mimeType;
  final String value;

  FrameDropDataItems({required this.mimeType, required this.value});

  factory FrameDropDataItems.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return FrameDropDataItems(
      mimeType: (json[r'mimeType'])!,
      value: (json[r'value'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {r'mimeType': mimeType, r'value': value};
  }
}

class FrameDropPayloadsItems {
  final String buffer;
  final String? mimeType;
  final String name;

  FrameDropPayloadsItems({
    required this.buffer,
    this.mimeType,
    required this.name,
  });

  factory FrameDropPayloadsItems.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return FrameDropPayloadsItems(
      buffer: (json[r'buffer'])!,
      mimeType: json[r'mimeType'],
      name: (json[r'name'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'buffer': buffer,
      if (mimeType != null) r'mimeType': mimeType,
      r'name': name,
    };
  }
}

class FrameEvalOnSelectorAllResult {
  final SerializedValue value;

  FrameEvalOnSelectorAllResult({required this.value});

  factory FrameEvalOnSelectorAllResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return FrameEvalOnSelectorAllResult(
      value: (json[r'value'] == null
          ? null
          : SerializedValue.fromJson(json[r'value'], connection: connection))!,
    );
  }

  Map<String, dynamic> toJson() {
    return {r'value': value.toJson()};
  }
}

class FrameEvalOnSelectorResult {
  final SerializedValue value;

  FrameEvalOnSelectorResult({required this.value});

  factory FrameEvalOnSelectorResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return FrameEvalOnSelectorResult(
      value: (json[r'value'] == null
          ? null
          : SerializedValue.fromJson(json[r'value'], connection: connection))!,
    );
  }

  Map<String, dynamic> toJson() {
    return {r'value': value.toJson()};
  }
}

class FrameEvaluateExpressionHandleResult {
  final JSHandleBase handle;

  FrameEvaluateExpressionHandleResult({required this.handle});

  factory FrameEvaluateExpressionHandleResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return FrameEvaluateExpressionHandleResult(
      handle: (connection != null && json[r'handle'] != null
          ? ChannelOwner.from<JSHandleBase>(connection, json[r'handle'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'handle': {'guid': handle.guid},
    };
  }
}

class FrameEvaluateExpressionResult {
  final SerializedValue value;

  FrameEvaluateExpressionResult({required this.value});

  factory FrameEvaluateExpressionResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return FrameEvaluateExpressionResult(
      value: (json[r'value'] == null
          ? null
          : SerializedValue.fromJson(json[r'value'], connection: connection))!,
    );
  }

  Map<String, dynamic> toJson() {
    return {r'value': value.toJson()};
  }
}

class FrameFrameElementResult {
  final ElementHandleBase element;

  FrameFrameElementResult({required this.element});

  factory FrameFrameElementResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return FrameFrameElementResult(
      element: (connection != null && json[r'element'] != null
          ? ChannelOwner.from<ElementHandleBase>(connection, json[r'element'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'element': {'guid': element.guid},
    };
  }
}

class FrameGetAttributeResult {
  final String? value;

  FrameGetAttributeResult({this.value});

  factory FrameGetAttributeResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return FrameGetAttributeResult(value: json[r'value']);
  }

  Map<String, dynamic> toJson() {
    return {if (value != null) r'value': value};
  }
}

class FrameGotoResult {
  final ResponseBase? response;

  FrameGotoResult({this.response});

  factory FrameGotoResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return FrameGotoResult(
      response: connection != null && json[r'response'] != null
          ? ChannelOwner.from<ResponseBase>(connection, json[r'response'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (response != null) r'response': {'guid': response?.guid},
    };
  }
}

class FrameInitializer {
  final List<LifecycleEvent> loadStates;
  final String name;
  final FrameBase? parentFrame;
  final String url;

  FrameInitializer({
    required this.loadStates,
    required this.name,
    this.parentFrame,
    required this.url,
  });

  factory FrameInitializer.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return FrameInitializer(
      loadStates:
          ((json[r'loadStates'] as List?)
              ?.map(
                (e) => LifecycleEvent.values.firstWhere((v) => v.value == e),
              )
              .toList()) ??
          [],
      name: (json[r'name'])!,
      parentFrame: connection != null && json[r'parentFrame'] != null
          ? ChannelOwner.from<FrameBase>(connection, json[r'parentFrame'])
          : null,
      url: (json[r'url'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'loadStates': loadStates.map((e) => e.value).toList(),
      r'name': name,
      if (parentFrame != null) r'parentFrame': {'guid': parentFrame?.guid},
      r'url': url,
    };
  }
}

class FrameInnerHTMLResult {
  final String value;

  FrameInnerHTMLResult({required this.value});

  factory FrameInnerHTMLResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return FrameInnerHTMLResult(value: (json[r'value'])!);
  }

  Map<String, dynamic> toJson() {
    return {r'value': value};
  }
}

class FrameInnerTextResult {
  final String value;

  FrameInnerTextResult({required this.value});

  factory FrameInnerTextResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return FrameInnerTextResult(value: (json[r'value'])!);
  }

  Map<String, dynamic> toJson() {
    return {r'value': value};
  }
}

class FrameInputValueResult {
  final String value;

  FrameInputValueResult({required this.value});

  factory FrameInputValueResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return FrameInputValueResult(value: (json[r'value'])!);
  }

  Map<String, dynamic> toJson() {
    return {r'value': value};
  }
}

class FrameIsCheckedResult {
  final bool value;

  FrameIsCheckedResult({required this.value});

  factory FrameIsCheckedResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return FrameIsCheckedResult(value: (json[r'value'])!);
  }

  Map<String, dynamic> toJson() {
    return {r'value': value};
  }
}

class FrameIsDisabledResult {
  final bool value;

  FrameIsDisabledResult({required this.value});

  factory FrameIsDisabledResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return FrameIsDisabledResult(value: (json[r'value'])!);
  }

  Map<String, dynamic> toJson() {
    return {r'value': value};
  }
}

class FrameIsEditableResult {
  final bool value;

  FrameIsEditableResult({required this.value});

  factory FrameIsEditableResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return FrameIsEditableResult(value: (json[r'value'])!);
  }

  Map<String, dynamic> toJson() {
    return {r'value': value};
  }
}

class FrameIsEnabledResult {
  final bool value;

  FrameIsEnabledResult({required this.value});

  factory FrameIsEnabledResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return FrameIsEnabledResult(value: (json[r'value'])!);
  }

  Map<String, dynamic> toJson() {
    return {r'value': value};
  }
}

class FrameIsHiddenResult {
  final bool value;

  FrameIsHiddenResult({required this.value});

  factory FrameIsHiddenResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return FrameIsHiddenResult(value: (json[r'value'])!);
  }

  Map<String, dynamic> toJson() {
    return {r'value': value};
  }
}

class FrameIsVisibleResult {
  final bool value;

  FrameIsVisibleResult({required this.value});

  factory FrameIsVisibleResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return FrameIsVisibleResult(value: (json[r'value'])!);
  }

  Map<String, dynamic> toJson() {
    return {r'value': value};
  }
}

class FrameLoadstateEvent {
  final LifecycleEvent? add;
  final LifecycleEvent? remove;

  FrameLoadstateEvent({this.add, this.remove});

  factory FrameLoadstateEvent.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return FrameLoadstateEvent(
      add: json[r'add'] == null
          ? null
          : LifecycleEvent.values.firstWhere((e) => e.value == json[r'add']),
      remove: json[r'remove'] == null
          ? null
          : LifecycleEvent.values.firstWhere((e) => e.value == json[r'remove']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (add != null) r'add': add?.value,
      if (remove != null) r'remove': remove?.value,
    };
  }
}

class FrameNavigatedEvent {
  final String? error;
  final String name;
  final FrameNavigatedEventNewDocument? newDocument;
  final String url;

  FrameNavigatedEvent({
    this.error,
    required this.name,
    this.newDocument,
    required this.url,
  });

  factory FrameNavigatedEvent.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return FrameNavigatedEvent(
      error: json[r'error'],
      name: (json[r'name'])!,
      newDocument: json[r'newDocument'] == null
          ? null
          : FrameNavigatedEventNewDocument.fromJson(
              json[r'newDocument'],
              connection: connection,
            ),
      url: (json[r'url'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (error != null) r'error': error,
      r'name': name,
      if (newDocument != null) r'newDocument': newDocument?.toJson(),
      r'url': url,
    };
  }
}

class FrameNavigatedEventNewDocument {
  final RequestBase? request;

  FrameNavigatedEventNewDocument({this.request});

  factory FrameNavigatedEventNewDocument.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return FrameNavigatedEventNewDocument(
      request: connection != null && json[r'request'] != null
          ? ChannelOwner.from<RequestBase>(connection, json[r'request'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (request != null) r'request': {'guid': request?.guid},
    };
  }
}

class FrameQueryCountResult {
  final int value;

  FrameQueryCountResult({required this.value});

  factory FrameQueryCountResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return FrameQueryCountResult(value: (json[r'value'])!);
  }

  Map<String, dynamic> toJson() {
    return {r'value': value};
  }
}

class FrameQuerySelectorAllResult {
  final List<ElementHandleBase> elements;

  FrameQuerySelectorAllResult({required this.elements});

  factory FrameQuerySelectorAllResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return FrameQuerySelectorAllResult(
      elements:
          (connection != null
              ? (json[r'elements'] as List?)
                    ?.map(
                      (e) =>
                          ChannelOwner.from<ElementHandleBase>(connection, e),
                    )
                    .toList()
              : null) ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'elements': elements.map((e) => {'guid': e.guid}).toList(),
    };
  }
}

class FrameQuerySelectorResult {
  final ElementHandleBase? element;

  FrameQuerySelectorResult({this.element});

  factory FrameQuerySelectorResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return FrameQuerySelectorResult(
      element: connection != null && json[r'element'] != null
          ? ChannelOwner.from<ElementHandleBase>(connection, json[r'element'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (element != null) r'element': {'guid': element?.guid},
    };
  }
}

class FrameResolveSelectorResult {
  final String resolvedSelector;

  FrameResolveSelectorResult({required this.resolvedSelector});

  factory FrameResolveSelectorResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return FrameResolveSelectorResult(
      resolvedSelector: (json[r'resolvedSelector'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {r'resolvedSelector': resolvedSelector};
  }
}

class FrameSelectOptionOptionsItems {
  final int? index;
  final String? label;
  final String? value;
  final String? valueOrLabel;

  FrameSelectOptionOptionsItems({
    this.index,
    this.label,
    this.value,
    this.valueOrLabel,
  });

  factory FrameSelectOptionOptionsItems.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return FrameSelectOptionOptionsItems(
      index: json[r'index'],
      label: json[r'label'],
      value: json[r'value'],
      valueOrLabel: json[r'valueOrLabel'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (index != null) r'index': index,
      if (label != null) r'label': label,
      if (value != null) r'value': value,
      if (valueOrLabel != null) r'valueOrLabel': valueOrLabel,
    };
  }
}

class FrameSelectOptionResult {
  final List<String> values;

  FrameSelectOptionResult({required this.values});

  factory FrameSelectOptionResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return FrameSelectOptionResult(
      values: ((json[r'values'] as List?)?.cast<String>()) ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {r'values': values};
  }
}

class FrameSetInputFilesPayloadsItems {
  final String buffer;
  final String? mimeType;
  final String name;

  FrameSetInputFilesPayloadsItems({
    required this.buffer,
    this.mimeType,
    required this.name,
  });

  factory FrameSetInputFilesPayloadsItems.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return FrameSetInputFilesPayloadsItems(
      buffer: (json[r'buffer'])!,
      mimeType: json[r'mimeType'],
      name: (json[r'name'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'buffer': buffer,
      if (mimeType != null) r'mimeType': mimeType,
      r'name': name,
    };
  }
}

class FrameTextContentResult {
  final String? value;

  FrameTextContentResult({this.value});

  factory FrameTextContentResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return FrameTextContentResult(value: json[r'value']);
  }

  Map<String, dynamic> toJson() {
    return {if (value != null) r'value': value};
  }
}

class FrameTitleResult {
  final String value;

  FrameTitleResult({required this.value});

  factory FrameTitleResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return FrameTitleResult(value: (json[r'value'])!);
  }

  Map<String, dynamic> toJson() {
    return {r'value': value};
  }
}

class FrameWaitForFunctionResult {
  final JSHandleBase handle;

  FrameWaitForFunctionResult({required this.handle});

  factory FrameWaitForFunctionResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return FrameWaitForFunctionResult(
      handle: (connection != null && json[r'handle'] != null
          ? ChannelOwner.from<JSHandleBase>(connection, json[r'handle'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'handle': {'guid': handle.guid},
    };
  }
}

class FrameWaitForSelectorResult {
  final ElementHandleBase? element;

  FrameWaitForSelectorResult({this.element});

  factory FrameWaitForSelectorResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return FrameWaitForSelectorResult(
      element: connection != null && json[r'element'] != null
          ? ChannelOwner.from<ElementHandleBase>(connection, json[r'element'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (element != null) r'element': {'guid': element?.guid},
    };
  }
}

class IndexedDBDatabase {
  final String name;
  final List<IndexedDBDatabaseStoresItems> stores;
  final int version;

  IndexedDBDatabase({
    required this.name,
    required this.stores,
    required this.version,
  });

  factory IndexedDBDatabase.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return IndexedDBDatabase(
      name: (json[r'name'])!,
      stores:
          ((json[r'stores'] as List?)
              ?.map(
                (e) => IndexedDBDatabaseStoresItems.fromJson(
                  e,
                  connection: connection,
                ),
              )
              .toList()) ??
          [],
      version: (json[r'version'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'name': name,
      r'stores': stores.map((e) => e.toJson()).toList(),
      r'version': version,
    };
  }
}

class IndexedDBDatabaseStoresItems {
  final bool autoIncrement;
  final List<IndexedDBDatabaseStoresItemsIndexesItems> indexes;
  final String? keyPath;
  final List<String>? keyPathArray;
  final String name;
  final List<IndexedDBDatabaseStoresItemsRecordsItems> records;

  IndexedDBDatabaseStoresItems({
    required this.autoIncrement,
    required this.indexes,
    this.keyPath,
    this.keyPathArray,
    required this.name,
    required this.records,
  });

  factory IndexedDBDatabaseStoresItems.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return IndexedDBDatabaseStoresItems(
      autoIncrement: (json[r'autoIncrement'])!,
      indexes:
          ((json[r'indexes'] as List?)
              ?.map(
                (e) => IndexedDBDatabaseStoresItemsIndexesItems.fromJson(
                  e,
                  connection: connection,
                ),
              )
              .toList()) ??
          [],
      keyPath: json[r'keyPath'],
      keyPathArray: (json[r'keyPathArray'] as List?)?.cast<String>(),
      name: (json[r'name'])!,
      records:
          ((json[r'records'] as List?)
              ?.map(
                (e) => IndexedDBDatabaseStoresItemsRecordsItems.fromJson(
                  e,
                  connection: connection,
                ),
              )
              .toList()) ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'autoIncrement': autoIncrement,
      r'indexes': indexes.map((e) => e.toJson()).toList(),
      if (keyPath != null) r'keyPath': keyPath,
      if (keyPathArray != null) r'keyPathArray': keyPathArray,
      r'name': name,
      r'records': records.map((e) => e.toJson()).toList(),
    };
  }
}

class IndexedDBDatabaseStoresItemsIndexesItems {
  final String? keyPath;
  final List<String>? keyPathArray;
  final bool multiEntry;
  final String name;
  final bool unique;

  IndexedDBDatabaseStoresItemsIndexesItems({
    this.keyPath,
    this.keyPathArray,
    required this.multiEntry,
    required this.name,
    required this.unique,
  });

  factory IndexedDBDatabaseStoresItemsIndexesItems.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return IndexedDBDatabaseStoresItemsIndexesItems(
      keyPath: json[r'keyPath'],
      keyPathArray: (json[r'keyPathArray'] as List?)?.cast<String>(),
      multiEntry: (json[r'multiEntry'])!,
      name: (json[r'name'])!,
      unique: (json[r'unique'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (keyPath != null) r'keyPath': keyPath,
      if (keyPathArray != null) r'keyPathArray': keyPathArray,
      r'multiEntry': multiEntry,
      r'name': name,
      r'unique': unique,
    };
  }
}

class IndexedDBDatabaseStoresItemsRecordsItems {
  final JsonValue key;
  final JsonValue keyEncoded;
  final JsonValue value;
  final JsonValue valueEncoded;

  IndexedDBDatabaseStoresItemsRecordsItems({
    this.key,
    this.keyEncoded,
    this.value,
    this.valueEncoded,
  });

  factory IndexedDBDatabaseStoresItemsRecordsItems.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return IndexedDBDatabaseStoresItemsRecordsItems(
      key: json[r'key'],
      keyEncoded: json[r'keyEncoded'],
      value: json[r'value'],
      valueEncoded: json[r'valueEncoded'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (key != null) r'key': key,
      if (keyEncoded != null) r'keyEncoded': keyEncoded,
      if (value != null) r'value': value,
      if (valueEncoded != null) r'valueEncoded': valueEncoded,
    };
  }
}

class JSHandleEvaluateExpressionHandleResult {
  final JSHandleBase handle;

  JSHandleEvaluateExpressionHandleResult({required this.handle});

  factory JSHandleEvaluateExpressionHandleResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return JSHandleEvaluateExpressionHandleResult(
      handle: (connection != null && json[r'handle'] != null
          ? ChannelOwner.from<JSHandleBase>(connection, json[r'handle'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'handle': {'guid': handle.guid},
    };
  }
}

class JSHandleEvaluateExpressionResult {
  final SerializedValue value;

  JSHandleEvaluateExpressionResult({required this.value});

  factory JSHandleEvaluateExpressionResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return JSHandleEvaluateExpressionResult(
      value: (json[r'value'] == null
          ? null
          : SerializedValue.fromJson(json[r'value'], connection: connection))!,
    );
  }

  Map<String, dynamic> toJson() {
    return {r'value': value.toJson()};
  }
}

class JSHandleGetPropertyListResult {
  final List<JSHandleGetPropertyListResultPropertiesItems> properties;

  JSHandleGetPropertyListResult({required this.properties});

  factory JSHandleGetPropertyListResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return JSHandleGetPropertyListResult(
      properties:
          ((json[r'properties'] as List?)
              ?.map(
                (e) => JSHandleGetPropertyListResultPropertiesItems.fromJson(
                  e,
                  connection: connection,
                ),
              )
              .toList()) ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {r'properties': properties.map((e) => e.toJson()).toList()};
  }
}

class JSHandleGetPropertyListResultPropertiesItems {
  final String name;
  final JSHandleBase value;

  JSHandleGetPropertyListResultPropertiesItems({
    required this.name,
    required this.value,
  });

  factory JSHandleGetPropertyListResultPropertiesItems.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return JSHandleGetPropertyListResultPropertiesItems(
      name: (json[r'name'])!,
      value: (connection != null && json[r'value'] != null
          ? ChannelOwner.from<JSHandleBase>(connection, json[r'value'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'name': name,
      r'value': {'guid': value.guid},
    };
  }
}

class JSHandleGetPropertyResult {
  final JSHandleBase handle;

  JSHandleGetPropertyResult({required this.handle});

  factory JSHandleGetPropertyResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return JSHandleGetPropertyResult(
      handle: (connection != null && json[r'handle'] != null
          ? ChannelOwner.from<JSHandleBase>(connection, json[r'handle'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'handle': {'guid': handle.guid},
    };
  }
}

class JSHandleInitializer {
  final String preview;

  JSHandleInitializer({required this.preview});

  factory JSHandleInitializer.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return JSHandleInitializer(preview: (json[r'preview'])!);
  }

  Map<String, dynamic> toJson() {
    return {r'preview': preview};
  }
}

class JSHandleJsonValueResult {
  final SerializedValue value;

  JSHandleJsonValueResult({required this.value});

  factory JSHandleJsonValueResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return JSHandleJsonValueResult(
      value: (json[r'value'] == null
          ? null
          : SerializedValue.fromJson(json[r'value'], connection: connection))!,
    );
  }

  Map<String, dynamic> toJson() {
    return {r'value': value.toJson()};
  }
}

class JSHandlePreviewUpdatedEvent {
  final String preview;

  JSHandlePreviewUpdatedEvent({required this.preview});

  factory JSHandlePreviewUpdatedEvent.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return JSHandlePreviewUpdatedEvent(preview: (json[r'preview'])!);
  }

  Map<String, dynamic> toJson() {
    return {r'preview': preview};
  }
}

class JsonPipeClosedEvent {
  final String? reason;

  JsonPipeClosedEvent({this.reason});

  factory JsonPipeClosedEvent.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return JsonPipeClosedEvent(reason: json[r'reason']);
  }

  Map<String, dynamic> toJson() {
    return {if (reason != null) r'reason': reason};
  }
}

class JsonPipeMessageEvent {
  final JsonValue message;

  JsonPipeMessageEvent({this.message});

  factory JsonPipeMessageEvent.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return JsonPipeMessageEvent(message: json[r'message']);
  }

  Map<String, dynamic> toJson() {
    return {if (message != null) r'message': message};
  }
}

class LaunchOptions {
  final List<String>? args;
  final String? artifactsDir;
  final int? cdpPort;
  final String? channel;
  final bool? chromiumSandbox;
  final String? downloadsPath;
  final List<NameValue>? env;
  final String? executablePath;
  final JsonValue firefoxUserPrefs;
  final bool? handleSIGHUP;
  final bool? handleSIGINT;
  final bool? handleSIGTERM;
  final bool? headless;
  final bool? ignoreAllDefaultArgs;
  final List<String>? ignoreDefaultArgs;
  final LaunchOptionsProxy? proxy;
  final double timeout;
  final String? tracesDir;

  LaunchOptions({
    this.args,
    this.artifactsDir,
    this.cdpPort,
    this.channel,
    this.chromiumSandbox,
    this.downloadsPath,
    this.env,
    this.executablePath,
    this.firefoxUserPrefs,
    this.handleSIGHUP,
    this.handleSIGINT,
    this.handleSIGTERM,
    this.headless,
    this.ignoreAllDefaultArgs,
    this.ignoreDefaultArgs,
    this.proxy,
    required this.timeout,
    this.tracesDir,
  });

  factory LaunchOptions.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return LaunchOptions(
      args: (json[r'args'] as List?)?.cast<String>(),
      artifactsDir: json[r'artifactsDir'],
      cdpPort: json[r'cdpPort'],
      channel: json[r'channel'],
      chromiumSandbox: json[r'chromiumSandbox'],
      downloadsPath: json[r'downloadsPath'],
      env: (json[r'env'] as List?)
          ?.map((e) => NameValue.fromJson(e, connection: connection))
          .toList(),
      executablePath: json[r'executablePath'],
      firefoxUserPrefs: json[r'firefoxUserPrefs'],
      handleSIGHUP: json[r'handleSIGHUP'],
      handleSIGINT: json[r'handleSIGINT'],
      handleSIGTERM: json[r'handleSIGTERM'],
      headless: json[r'headless'],
      ignoreAllDefaultArgs: json[r'ignoreAllDefaultArgs'],
      ignoreDefaultArgs: (json[r'ignoreDefaultArgs'] as List?)?.cast<String>(),
      proxy: json[r'proxy'] == null
          ? null
          : LaunchOptionsProxy.fromJson(json[r'proxy'], connection: connection),
      timeout: ((json[r'timeout'] as num?)?.toDouble())!,
      tracesDir: json[r'tracesDir'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (args != null) r'args': args,
      if (artifactsDir != null) r'artifactsDir': artifactsDir,
      if (cdpPort != null) r'cdpPort': cdpPort,
      if (channel != null) r'channel': channel,
      if (chromiumSandbox != null) r'chromiumSandbox': chromiumSandbox,
      if (downloadsPath != null) r'downloadsPath': downloadsPath,
      if (env != null) r'env': env?.map((e) => e.toJson()).toList(),
      if (executablePath != null) r'executablePath': executablePath,
      if (firefoxUserPrefs != null) r'firefoxUserPrefs': firefoxUserPrefs,
      if (handleSIGHUP != null) r'handleSIGHUP': handleSIGHUP,
      if (handleSIGINT != null) r'handleSIGINT': handleSIGINT,
      if (handleSIGTERM != null) r'handleSIGTERM': handleSIGTERM,
      if (headless != null) r'headless': headless,
      if (ignoreAllDefaultArgs != null)
        r'ignoreAllDefaultArgs': ignoreAllDefaultArgs,
      if (ignoreDefaultArgs != null) r'ignoreDefaultArgs': ignoreDefaultArgs,
      if (proxy != null) r'proxy': proxy?.toJson(),
      r'timeout': timeout,
      if (tracesDir != null) r'tracesDir': tracesDir,
    };
  }
}

class LaunchOptionsProxy {
  final String? bypass;
  final String? password;
  final String server;
  final String? username;

  LaunchOptionsProxy({
    this.bypass,
    this.password,
    required this.server,
    this.username,
  });

  factory LaunchOptionsProxy.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return LaunchOptionsProxy(
      bypass: json[r'bypass'],
      password: json[r'password'],
      server: (json[r'server'])!,
      username: json[r'username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (bypass != null) r'bypass': bypass,
      if (password != null) r'password': password,
      r'server': server,
      if (username != null) r'username': username,
    };
  }
}

class LocalUtilsConnectResult {
  final List<NameValue> headers;
  final JsonPipeBase pipe;

  LocalUtilsConnectResult({required this.headers, required this.pipe});

  factory LocalUtilsConnectResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return LocalUtilsConnectResult(
      headers:
          ((json[r'headers'] as List?)
              ?.map((e) => NameValue.fromJson(e, connection: connection))
              .toList()) ??
          [],
      pipe: (connection != null && json[r'pipe'] != null
          ? ChannelOwner.from<JsonPipeBase>(connection, json[r'pipe'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'headers': headers.map((e) => e.toJson()).toList(),
      r'pipe': {'guid': pipe.guid},
    };
  }
}

class LocalUtilsGlobToRegexResult {
  final String regex;

  LocalUtilsGlobToRegexResult({required this.regex});

  factory LocalUtilsGlobToRegexResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return LocalUtilsGlobToRegexResult(regex: (json[r'regex'])!);
  }

  Map<String, dynamic> toJson() {
    return {r'regex': regex};
  }
}

class LocalUtilsHarLookupResult {
  final LocalUtilsHarLookupResultActionEnum action;
  final String? body;
  final List<NameValue>? headers;
  final String? message;
  final String? redirectURL;
  final int? status;

  LocalUtilsHarLookupResult({
    required this.action,
    this.body,
    this.headers,
    this.message,
    this.redirectURL,
    this.status,
  });

  factory LocalUtilsHarLookupResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return LocalUtilsHarLookupResult(
      action: (json[r'action'] == null
          ? null
          : LocalUtilsHarLookupResultActionEnum.values.firstWhere(
              (e) => e.value == json[r'action'],
            ))!,
      body: json[r'body'],
      headers: (json[r'headers'] as List?)
          ?.map((e) => NameValue.fromJson(e, connection: connection))
          .toList(),
      message: json[r'message'],
      redirectURL: json[r'redirectURL'],
      status: json[r'status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'action': action.value,
      if (body != null) r'body': body,
      if (headers != null) r'headers': headers?.map((e) => e.toJson()).toList(),
      if (message != null) r'message': message,
      if (redirectURL != null) r'redirectURL': redirectURL,
      if (status != null) r'status': status,
    };
  }
}

class LocalUtilsHarOpenResult {
  final String? error;
  final String? harId;

  LocalUtilsHarOpenResult({this.error, this.harId});

  factory LocalUtilsHarOpenResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return LocalUtilsHarOpenResult(
      error: json[r'error'],
      harId: json[r'harId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (error != null) r'error': error,
      if (harId != null) r'harId': harId,
    };
  }
}

class LocalUtilsInitializer {
  final List<LocalUtilsInitializerDeviceDescriptorsItems> deviceDescriptors;

  LocalUtilsInitializer({required this.deviceDescriptors});

  factory LocalUtilsInitializer.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return LocalUtilsInitializer(
      deviceDescriptors:
          ((json[r'deviceDescriptors'] as List?)
              ?.map(
                (e) => LocalUtilsInitializerDeviceDescriptorsItems.fromJson(
                  e,
                  connection: connection,
                ),
              )
              .toList()) ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'deviceDescriptors': deviceDescriptors.map((e) => e.toJson()).toList(),
    };
  }
}

class LocalUtilsInitializerDeviceDescriptorsItems {
  final LocalUtilsInitializerDeviceDescriptorsItemsDescriptor descriptor;
  final String name;

  LocalUtilsInitializerDeviceDescriptorsItems({
    required this.descriptor,
    required this.name,
  });

  factory LocalUtilsInitializerDeviceDescriptorsItems.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return LocalUtilsInitializerDeviceDescriptorsItems(
      descriptor: (json[r'descriptor'] == null
          ? null
          : LocalUtilsInitializerDeviceDescriptorsItemsDescriptor.fromJson(
              json[r'descriptor'],
              connection: connection,
            ))!,
      name: (json[r'name'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {r'descriptor': descriptor.toJson(), r'name': name};
  }
}

class LocalUtilsInitializerDeviceDescriptorsItemsDescriptor {
  final LocalUtilsInitializerDeviceDescriptorsItemsDescriptorDefaultBrowserTypeEnum
  defaultBrowserType;
  final double deviceScaleFactor;
  final bool hasTouch;
  final bool isMobile;
  final LocalUtilsInitializerDeviceDescriptorsItemsDescriptorScreen? screen;
  final String userAgent;
  final LocalUtilsInitializerDeviceDescriptorsItemsDescriptorViewport viewport;

  LocalUtilsInitializerDeviceDescriptorsItemsDescriptor({
    required this.defaultBrowserType,
    required this.deviceScaleFactor,
    required this.hasTouch,
    required this.isMobile,
    this.screen,
    required this.userAgent,
    required this.viewport,
  });

  factory LocalUtilsInitializerDeviceDescriptorsItemsDescriptor.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return LocalUtilsInitializerDeviceDescriptorsItemsDescriptor(
      defaultBrowserType: (json[r'defaultBrowserType'] == null
          ? null
          : LocalUtilsInitializerDeviceDescriptorsItemsDescriptorDefaultBrowserTypeEnum
                .values
                .firstWhere((e) => e.value == json[r'defaultBrowserType']))!,
      deviceScaleFactor: ((json[r'deviceScaleFactor'] as num?)?.toDouble())!,
      hasTouch: (json[r'hasTouch'])!,
      isMobile: (json[r'isMobile'])!,
      screen: json[r'screen'] == null
          ? null
          : LocalUtilsInitializerDeviceDescriptorsItemsDescriptorScreen.fromJson(
              json[r'screen'],
              connection: connection,
            ),
      userAgent: (json[r'userAgent'])!,
      viewport: (json[r'viewport'] == null
          ? null
          : LocalUtilsInitializerDeviceDescriptorsItemsDescriptorViewport.fromJson(
              json[r'viewport'],
              connection: connection,
            ))!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'defaultBrowserType': defaultBrowserType.value,
      r'deviceScaleFactor': deviceScaleFactor,
      r'hasTouch': hasTouch,
      r'isMobile': isMobile,
      if (screen != null) r'screen': screen?.toJson(),
      r'userAgent': userAgent,
      r'viewport': viewport.toJson(),
    };
  }
}

class LocalUtilsInitializerDeviceDescriptorsItemsDescriptorScreen {
  final int height;
  final int width;

  LocalUtilsInitializerDeviceDescriptorsItemsDescriptorScreen({
    required this.height,
    required this.width,
  });

  factory LocalUtilsInitializerDeviceDescriptorsItemsDescriptorScreen.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return LocalUtilsInitializerDeviceDescriptorsItemsDescriptorScreen(
      height: (json[r'height'])!,
      width: (json[r'width'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {r'height': height, r'width': width};
  }
}

class LocalUtilsInitializerDeviceDescriptorsItemsDescriptorViewport {
  final int height;
  final int width;

  LocalUtilsInitializerDeviceDescriptorsItemsDescriptorViewport({
    required this.height,
    required this.width,
  });

  factory LocalUtilsInitializerDeviceDescriptorsItemsDescriptorViewport.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return LocalUtilsInitializerDeviceDescriptorsItemsDescriptorViewport(
      height: (json[r'height'])!,
      width: (json[r'width'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {r'height': height, r'width': width};
  }
}

class LocalUtilsTracingStartedResult {
  final String stacksId;

  LocalUtilsTracingStartedResult({required this.stacksId});

  factory LocalUtilsTracingStartedResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return LocalUtilsTracingStartedResult(stacksId: (json[r'stacksId'])!);
  }

  Map<String, dynamic> toJson() {
    return {r'stacksId': stacksId};
  }
}

class Metadata {
  final bool? internal;
  final MetadataLocation? location;
  final String? stepId;
  final String? title;

  Metadata({this.internal, this.location, this.stepId, this.title});

  factory Metadata.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return Metadata(
      internal: json[r'internal'],
      location: json[r'location'] == null
          ? null
          : MetadataLocation.fromJson(
              json[r'location'],
              connection: connection,
            ),
      stepId: json[r'stepId'],
      title: json[r'title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (internal != null) r'internal': internal,
      if (location != null) r'location': location?.toJson(),
      if (stepId != null) r'stepId': stepId,
      if (title != null) r'title': title,
    };
  }
}

class MetadataLocation {
  final int? column;
  final String file;
  final int? line;

  MetadataLocation({this.column, required this.file, this.line});

  factory MetadataLocation.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return MetadataLocation(
      column: json[r'column'],
      file: (json[r'file'])!,
      line: json[r'line'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (column != null) r'column': column,
      r'file': file,
      if (line != null) r'line': line,
    };
  }
}

class NameValue {
  final String name;
  final String value;

  NameValue({required this.name, required this.value});

  factory NameValue.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return NameValue(name: (json[r'name'])!, value: (json[r'value'])!);
  }

  Map<String, dynamic> toJson() {
    return {r'name': name, r'value': value};
  }
}

class NetworkCookie {
  final bool? crHasCrossSiteAncestor;
  final String domain;
  final double expires;
  final bool httpOnly;
  final String name;
  final String? partitionKey;
  final String path;
  final NetworkCookieSameSiteEnum sameSite;
  final bool secure;
  final String value;

  NetworkCookie({
    this.crHasCrossSiteAncestor,
    required this.domain,
    required this.expires,
    required this.httpOnly,
    required this.name,
    this.partitionKey,
    required this.path,
    required this.sameSite,
    required this.secure,
    required this.value,
  });

  factory NetworkCookie.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return NetworkCookie(
      crHasCrossSiteAncestor: json[r'_crHasCrossSiteAncestor'],
      domain: (json[r'domain'])!,
      expires: ((json[r'expires'] as num?)?.toDouble())!,
      httpOnly: (json[r'httpOnly'])!,
      name: (json[r'name'])!,
      partitionKey: json[r'partitionKey'],
      path: (json[r'path'])!,
      sameSite: (json[r'sameSite'] == null
          ? null
          : NetworkCookieSameSiteEnum.values.firstWhere(
              (e) => e.value == json[r'sameSite'],
            ))!,
      secure: (json[r'secure'])!,
      value: (json[r'value'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (crHasCrossSiteAncestor != null)
        r'_crHasCrossSiteAncestor': crHasCrossSiteAncestor,
      r'domain': domain,
      r'expires': expires,
      r'httpOnly': httpOnly,
      r'name': name,
      if (partitionKey != null) r'partitionKey': partitionKey,
      r'path': path,
      r'sameSite': sameSite.value,
      r'secure': secure,
      r'value': value,
    };
  }
}

class OriginStorage {
  final List<IndexedDBDatabase>? indexedDB;
  final List<NameValue> localStorage;
  final String origin;

  OriginStorage({
    this.indexedDB,
    required this.localStorage,
    required this.origin,
  });

  factory OriginStorage.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return OriginStorage(
      indexedDB: (json[r'indexedDB'] as List?)
          ?.map((e) => IndexedDBDatabase.fromJson(e, connection: connection))
          .toList(),
      localStorage:
          ((json[r'localStorage'] as List?)
              ?.map((e) => NameValue.fromJson(e, connection: connection))
              .toList()) ??
          [],
      origin: (json[r'origin'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (indexedDB != null)
        r'indexedDB': indexedDB?.map((e) => e.toJson()).toList(),
      r'localStorage': localStorage.map((e) => e.toJson()).toList(),
      r'origin': origin,
    };
  }
}

class PageAddInitScriptResult {
  final DisposableBase disposable;

  PageAddInitScriptResult({required this.disposable});

  factory PageAddInitScriptResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return PageAddInitScriptResult(
      disposable: (connection != null && json[r'disposable'] != null
          ? ChannelOwner.from<DisposableBase>(connection, json[r'disposable'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'disposable': {'guid': disposable.guid},
    };
  }
}

class PageBindingCallEvent {
  final BindingCallBase binding;

  PageBindingCallEvent({required this.binding});

  factory PageBindingCallEvent.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return PageBindingCallEvent(
      binding: (connection != null && json[r'binding'] != null
          ? ChannelOwner.from<BindingCallBase>(connection, json[r'binding'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'binding': {'guid': binding.guid},
    };
  }
}

class PageConsoleMessagesResult {
  final List<PageConsoleMessagesResultMessagesItems> messages;

  PageConsoleMessagesResult({required this.messages});

  factory PageConsoleMessagesResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return PageConsoleMessagesResult(
      messages:
          ((json[r'messages'] as List?)
              ?.map(
                (e) => PageConsoleMessagesResultMessagesItems.fromJson(
                  e,
                  connection: connection,
                ),
              )
              .toList()) ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {r'messages': messages.map((e) => e.toJson()).toList()};
  }
}

class PageConsoleMessagesResultMessagesItems {
  final ConsoleMessage mixinValue;

  PageConsoleMessagesResultMessagesItems({required this.mixinValue});

  factory PageConsoleMessagesResultMessagesItems.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return PageConsoleMessagesResultMessagesItems(
      mixinValue: (json[r'$mixin'] == null
          ? null
          : ConsoleMessage.fromJson(json[r'$mixin'], connection: connection))!,
    );
  }

  Map<String, dynamic> toJson() {
    return {r'$mixin': mixinValue.toJson()};
  }
}

class PageDownloadEvent {
  final ArtifactBase artifact;
  final String suggestedFilename;
  final String url;

  PageDownloadEvent({
    required this.artifact,
    required this.suggestedFilename,
    required this.url,
  });

  factory PageDownloadEvent.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return PageDownloadEvent(
      artifact: (connection != null && json[r'artifact'] != null
          ? ChannelOwner.from<ArtifactBase>(connection, json[r'artifact'])
          : null)!,
      suggestedFilename: (json[r'suggestedFilename'])!,
      url: (json[r'url'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'artifact': {'guid': artifact.guid},
      r'suggestedFilename': suggestedFilename,
      r'url': url,
    };
  }
}

class PageExpectScreenshotLocator {
  final FrameBase frame;
  final Pattern selector;

  PageExpectScreenshotLocator({required this.frame, required this.selector});

  factory PageExpectScreenshotLocator.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return PageExpectScreenshotLocator(
      frame: (connection != null && json[r'frame'] != null
          ? ChannelOwner.from<FrameBase>(connection, json[r'frame'])
          : null)!,
      selector: (json[r'selector'] as String?)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'frame': {'guid': frame.guid},
      r'selector': selector.toString(),
    };
  }
}

class PageExpectScreenshotResult {
  final String? actual;

  PageExpectScreenshotResult({this.actual});

  factory PageExpectScreenshotResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return PageExpectScreenshotResult(actual: json[r'actual']);
  }

  Map<String, dynamic> toJson() {
    return {if (actual != null) r'actual': actual};
  }
}

class PageExposeBindingResult {
  final DisposableBase disposable;

  PageExposeBindingResult({required this.disposable});

  factory PageExposeBindingResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return PageExposeBindingResult(
      disposable: (connection != null && json[r'disposable'] != null
          ? ChannelOwner.from<DisposableBase>(connection, json[r'disposable'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'disposable': {'guid': disposable.guid},
    };
  }
}

class PageFileChooserEvent {
  final ElementHandleBase element;
  final bool isMultiple;

  PageFileChooserEvent({required this.element, required this.isMultiple});

  factory PageFileChooserEvent.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return PageFileChooserEvent(
      element: (connection != null && json[r'element'] != null
          ? ChannelOwner.from<ElementHandleBase>(connection, json[r'element'])
          : null)!,
      isMultiple: (json[r'isMultiple'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'element': {'guid': element.guid},
      r'isMultiple': isMultiple,
    };
  }
}

class PageFrameAttachedEvent {
  final FrameBase frame;

  PageFrameAttachedEvent({required this.frame});

  factory PageFrameAttachedEvent.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return PageFrameAttachedEvent(
      frame: (connection != null && json[r'frame'] != null
          ? ChannelOwner.from<FrameBase>(connection, json[r'frame'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'frame': {'guid': frame.guid},
    };
  }
}

class PageFrameDetachedEvent {
  final FrameBase frame;

  PageFrameDetachedEvent({required this.frame});

  factory PageFrameDetachedEvent.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return PageFrameDetachedEvent(
      frame: (connection != null && json[r'frame'] != null
          ? ChannelOwner.from<FrameBase>(connection, json[r'frame'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'frame': {'guid': frame.guid},
    };
  }
}

class PageGoBackResult {
  final ResponseBase? response;

  PageGoBackResult({this.response});

  factory PageGoBackResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return PageGoBackResult(
      response: connection != null && json[r'response'] != null
          ? ChannelOwner.from<ResponseBase>(connection, json[r'response'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (response != null) r'response': {'guid': response?.guid},
    };
  }
}

class PageGoForwardResult {
  final ResponseBase? response;

  PageGoForwardResult({this.response});

  factory PageGoForwardResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return PageGoForwardResult(
      response: connection != null && json[r'response'] != null
          ? ChannelOwner.from<ResponseBase>(connection, json[r'response'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (response != null) r'response': {'guid': response?.guid},
    };
  }
}

class PageInitializer {
  final bool isClosed;
  final FrameBase mainFrame;
  final PageBase? opener;
  final ArtifactBase? video;
  final PageInitializerViewportSize? viewportSize;

  PageInitializer({
    required this.isClosed,
    required this.mainFrame,
    this.opener,
    this.video,
    this.viewportSize,
  });

  factory PageInitializer.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return PageInitializer(
      isClosed: (json[r'isClosed'])!,
      mainFrame: (connection != null && json[r'mainFrame'] != null
          ? ChannelOwner.from<FrameBase>(connection, json[r'mainFrame'])
          : null)!,
      opener: connection != null && json[r'opener'] != null
          ? ChannelOwner.from<PageBase>(connection, json[r'opener'])
          : null,
      video: connection != null && json[r'video'] != null
          ? ChannelOwner.from<ArtifactBase>(connection, json[r'video'])
          : null,
      viewportSize: json[r'viewportSize'] == null
          ? null
          : PageInitializerViewportSize.fromJson(
              json[r'viewportSize'],
              connection: connection,
            ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'isClosed': isClosed,
      r'mainFrame': {'guid': mainFrame.guid},
      if (opener != null) r'opener': {'guid': opener?.guid},
      if (video != null) r'video': {'guid': video?.guid},
      if (viewportSize != null) r'viewportSize': viewportSize?.toJson(),
    };
  }
}

class PageInitializerViewportSize {
  final int height;
  final int width;

  PageInitializerViewportSize({required this.height, required this.width});

  factory PageInitializerViewportSize.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return PageInitializerViewportSize(
      height: (json[r'height'])!,
      width: (json[r'width'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {r'height': height, r'width': width};
  }
}

class PageLocatorHandlerTriggeredEvent {
  final int uid;

  PageLocatorHandlerTriggeredEvent({required this.uid});

  factory PageLocatorHandlerTriggeredEvent.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return PageLocatorHandlerTriggeredEvent(uid: (json[r'uid'])!);
  }

  Map<String, dynamic> toJson() {
    return {r'uid': uid};
  }
}

class PagePageErrorsResult {
  final List<SerializedError> errors;

  PagePageErrorsResult({required this.errors});

  factory PagePageErrorsResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return PagePageErrorsResult(
      errors:
          ((json[r'errors'] as List?)
              ?.map((e) => SerializedError.fromJson(e, connection: connection))
              .toList()) ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {r'errors': errors.map((e) => e.toJson()).toList()};
  }
}

class PagePdfMargin {
  final String? bottom;
  final String? left;
  final String? right;
  final String? top;

  PagePdfMargin({this.bottom, this.left, this.right, this.top});

  factory PagePdfMargin.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return PagePdfMargin(
      bottom: json[r'bottom'],
      left: json[r'left'],
      right: json[r'right'],
      top: json[r'top'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (bottom != null) r'bottom': bottom,
      if (left != null) r'left': left,
      if (right != null) r'right': right,
      if (top != null) r'top': top,
    };
  }
}

class PagePdfResult {
  final String pdf;

  PagePdfResult({required this.pdf});

  factory PagePdfResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return PagePdfResult(pdf: (json[r'pdf'])!);
  }

  Map<String, dynamic> toJson() {
    return {r'pdf': pdf};
  }
}

class PagePickLocatorResult {
  final Pattern selector;

  PagePickLocatorResult({required this.selector});

  factory PagePickLocatorResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return PagePickLocatorResult(selector: (json[r'selector'] as String?)!);
  }

  Map<String, dynamic> toJson() {
    return {r'selector': selector.toString()};
  }
}

class PageRegisterLocatorHandlerResult {
  final int uid;

  PageRegisterLocatorHandlerResult({required this.uid});

  factory PageRegisterLocatorHandlerResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return PageRegisterLocatorHandlerResult(uid: (json[r'uid'])!);
  }

  Map<String, dynamic> toJson() {
    return {r'uid': uid};
  }
}

class PageReloadResult {
  final ResponseBase? response;

  PageReloadResult({this.response});

  factory PageReloadResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return PageReloadResult(
      response: connection != null && json[r'response'] != null
          ? ChannelOwner.from<ResponseBase>(connection, json[r'response'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (response != null) r'response': {'guid': response?.guid},
    };
  }
}

class PageRequestsResult {
  final List<RequestBase> requests;

  PageRequestsResult({required this.requests});

  factory PageRequestsResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return PageRequestsResult(
      requests:
          (connection != null
              ? (json[r'requests'] as List?)
                    ?.map((e) => ChannelOwner.from<RequestBase>(connection, e))
                    .toList()
              : null) ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'requests': requests.map((e) => {'guid': e.guid}).toList(),
    };
  }
}

class PageRouteEvent {
  final RouteBase route;

  PageRouteEvent({required this.route});

  factory PageRouteEvent.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return PageRouteEvent(
      route: (connection != null && json[r'route'] != null
          ? ChannelOwner.from<RouteBase>(connection, json[r'route'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'route': {'guid': route.guid},
    };
  }
}

class PageScreencastFrameEvent {
  final String data;
  final double timestamp;
  final int viewportHeight;
  final int viewportWidth;

  PageScreencastFrameEvent({
    required this.data,
    required this.timestamp,
    required this.viewportHeight,
    required this.viewportWidth,
  });

  factory PageScreencastFrameEvent.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return PageScreencastFrameEvent(
      data: (json[r'data'])!,
      timestamp: ((json[r'timestamp'] as num?)?.toDouble())!,
      viewportHeight: (json[r'viewportHeight'])!,
      viewportWidth: (json[r'viewportWidth'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'data': data,
      r'timestamp': timestamp,
      r'viewportHeight': viewportHeight,
      r'viewportWidth': viewportWidth,
    };
  }
}

class PageScreencastShowOverlayResult {
  final String id;

  PageScreencastShowOverlayResult({required this.id});

  factory PageScreencastShowOverlayResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return PageScreencastShowOverlayResult(id: (json[r'id'])!);
  }

  Map<String, dynamic> toJson() {
    return {r'id': id};
  }
}

class PageScreencastStartResult {
  final ArtifactBase? artifact;

  PageScreencastStartResult({this.artifact});

  factory PageScreencastStartResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return PageScreencastStartResult(
      artifact: connection != null && json[r'artifact'] != null
          ? ChannelOwner.from<ArtifactBase>(connection, json[r'artifact'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (artifact != null) r'artifact': {'guid': artifact?.guid},
    };
  }
}

class PageScreencastStartSize {
  final int height;
  final int width;

  PageScreencastStartSize({required this.height, required this.width});

  factory PageScreencastStartSize.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return PageScreencastStartSize(
      height: (json[r'height'])!,
      width: (json[r'width'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {r'height': height, r'width': width};
  }
}

class PageScreenshotResult {
  final String binary;

  PageScreenshotResult({required this.binary});

  factory PageScreenshotResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return PageScreenshotResult(binary: (json[r'binary'])!);
  }

  Map<String, dynamic> toJson() {
    return {r'binary': binary};
  }
}

class PageSetNetworkInterceptionPatternsPatternsItems {
  final String? glob;
  final String? regexFlags;
  final String? regexSource;
  final URLPattern? urlPattern;

  PageSetNetworkInterceptionPatternsPatternsItems({
    this.glob,
    this.regexFlags,
    this.regexSource,
    this.urlPattern,
  });

  factory PageSetNetworkInterceptionPatternsPatternsItems.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return PageSetNetworkInterceptionPatternsPatternsItems(
      glob: json[r'glob'],
      regexFlags: json[r'regexFlags'],
      regexSource: json[r'regexSource'],
      urlPattern: json[r'urlPattern'] == null
          ? null
          : URLPattern.fromJson(json[r'urlPattern'], connection: connection),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (glob != null) r'glob': glob,
      if (regexFlags != null) r'regexFlags': regexFlags,
      if (regexSource != null) r'regexSource': regexSource,
      if (urlPattern != null) r'urlPattern': urlPattern?.toJson(),
    };
  }
}

class PageSetViewportSizeViewportSize {
  final int height;
  final int width;

  PageSetViewportSizeViewportSize({required this.height, required this.width});

  factory PageSetViewportSizeViewportSize.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return PageSetViewportSizeViewportSize(
      height: (json[r'height'])!,
      width: (json[r'width'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {r'height': height, r'width': width};
  }
}

class PageSetWebSocketInterceptionPatternsPatternsItems {
  final String? glob;
  final String? regexFlags;
  final String? regexSource;
  final URLPattern? urlPattern;

  PageSetWebSocketInterceptionPatternsPatternsItems({
    this.glob,
    this.regexFlags,
    this.regexSource,
    this.urlPattern,
  });

  factory PageSetWebSocketInterceptionPatternsPatternsItems.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return PageSetWebSocketInterceptionPatternsPatternsItems(
      glob: json[r'glob'],
      regexFlags: json[r'regexFlags'],
      regexSource: json[r'regexSource'],
      urlPattern: json[r'urlPattern'] == null
          ? null
          : URLPattern.fromJson(json[r'urlPattern'], connection: connection),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (glob != null) r'glob': glob,
      if (regexFlags != null) r'regexFlags': regexFlags,
      if (regexSource != null) r'regexSource': regexSource,
      if (urlPattern != null) r'urlPattern': urlPattern?.toJson(),
    };
  }
}

class PageStopCSSCoverageResult {
  final List<PageStopCSSCoverageResultEntriesItems> entries;

  PageStopCSSCoverageResult({required this.entries});

  factory PageStopCSSCoverageResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return PageStopCSSCoverageResult(
      entries:
          ((json[r'entries'] as List?)
              ?.map(
                (e) => PageStopCSSCoverageResultEntriesItems.fromJson(
                  e,
                  connection: connection,
                ),
              )
              .toList()) ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {r'entries': entries.map((e) => e.toJson()).toList()};
  }
}

class PageStopCSSCoverageResultEntriesItems {
  final List<PageStopCSSCoverageResultEntriesItemsRangesItems> ranges;
  final String? text;
  final String url;

  PageStopCSSCoverageResultEntriesItems({
    required this.ranges,
    this.text,
    required this.url,
  });

  factory PageStopCSSCoverageResultEntriesItems.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return PageStopCSSCoverageResultEntriesItems(
      ranges:
          ((json[r'ranges'] as List?)
              ?.map(
                (e) =>
                    PageStopCSSCoverageResultEntriesItemsRangesItems.fromJson(
                      e,
                      connection: connection,
                    ),
              )
              .toList()) ??
          [],
      text: json[r'text'],
      url: (json[r'url'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'ranges': ranges.map((e) => e.toJson()).toList(),
      if (text != null) r'text': text,
      r'url': url,
    };
  }
}

class PageStopCSSCoverageResultEntriesItemsRangesItems {
  final int end;
  final int start;

  PageStopCSSCoverageResultEntriesItemsRangesItems({
    required this.end,
    required this.start,
  });

  factory PageStopCSSCoverageResultEntriesItemsRangesItems.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return PageStopCSSCoverageResultEntriesItemsRangesItems(
      end: (json[r'end'])!,
      start: (json[r'start'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {r'end': end, r'start': start};
  }
}

class PageStopJSCoverageResult {
  final List<PageStopJSCoverageResultEntriesItems> entries;

  PageStopJSCoverageResult({required this.entries});

  factory PageStopJSCoverageResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return PageStopJSCoverageResult(
      entries:
          ((json[r'entries'] as List?)
              ?.map(
                (e) => PageStopJSCoverageResultEntriesItems.fromJson(
                  e,
                  connection: connection,
                ),
              )
              .toList()) ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {r'entries': entries.map((e) => e.toJson()).toList()};
  }
}

class PageStopJSCoverageResultEntriesItems {
  final List<PageStopJSCoverageResultEntriesItemsFunctionsItems> functions;
  final String scriptId;
  final String? source;
  final String url;

  PageStopJSCoverageResultEntriesItems({
    required this.functions,
    required this.scriptId,
    this.source,
    required this.url,
  });

  factory PageStopJSCoverageResultEntriesItems.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return PageStopJSCoverageResultEntriesItems(
      functions:
          ((json[r'functions'] as List?)
              ?.map(
                (e) =>
                    PageStopJSCoverageResultEntriesItemsFunctionsItems.fromJson(
                      e,
                      connection: connection,
                    ),
              )
              .toList()) ??
          [],
      scriptId: (json[r'scriptId'])!,
      source: json[r'source'],
      url: (json[r'url'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'functions': functions.map((e) => e.toJson()).toList(),
      r'scriptId': scriptId,
      if (source != null) r'source': source,
      r'url': url,
    };
  }
}

class PageStopJSCoverageResultEntriesItemsFunctionsItems {
  final String functionName;
  final bool isBlockCoverage;
  final List<PageStopJSCoverageResultEntriesItemsFunctionsItemsRangesItems>
  ranges;

  PageStopJSCoverageResultEntriesItemsFunctionsItems({
    required this.functionName,
    required this.isBlockCoverage,
    required this.ranges,
  });

  factory PageStopJSCoverageResultEntriesItemsFunctionsItems.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return PageStopJSCoverageResultEntriesItemsFunctionsItems(
      functionName: (json[r'functionName'])!,
      isBlockCoverage: (json[r'isBlockCoverage'])!,
      ranges:
          ((json[r'ranges'] as List?)
              ?.map(
                (e) =>
                    PageStopJSCoverageResultEntriesItemsFunctionsItemsRangesItems.fromJson(
                      e,
                      connection: connection,
                    ),
              )
              .toList()) ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'functionName': functionName,
      r'isBlockCoverage': isBlockCoverage,
      r'ranges': ranges.map((e) => e.toJson()).toList(),
    };
  }
}

class PageStopJSCoverageResultEntriesItemsFunctionsItemsRangesItems {
  final int count;
  final int endOffset;
  final int startOffset;

  PageStopJSCoverageResultEntriesItemsFunctionsItemsRangesItems({
    required this.count,
    required this.endOffset,
    required this.startOffset,
  });

  factory PageStopJSCoverageResultEntriesItemsFunctionsItemsRangesItems.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return PageStopJSCoverageResultEntriesItemsFunctionsItemsRangesItems(
      count: (json[r'count'])!,
      endOffset: (json[r'endOffset'])!,
      startOffset: (json[r'startOffset'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'count': count,
      r'endOffset': endOffset,
      r'startOffset': startOffset,
    };
  }
}

class PageViewportSizeChangedEvent {
  final PageViewportSizeChangedEventViewportSize? viewportSize;

  PageViewportSizeChangedEvent({this.viewportSize});

  factory PageViewportSizeChangedEvent.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return PageViewportSizeChangedEvent(
      viewportSize: json[r'viewportSize'] == null
          ? null
          : PageViewportSizeChangedEventViewportSize.fromJson(
              json[r'viewportSize'],
              connection: connection,
            ),
    );
  }

  Map<String, dynamic> toJson() {
    return {if (viewportSize != null) r'viewportSize': viewportSize?.toJson()};
  }
}

class PageViewportSizeChangedEventViewportSize {
  final int height;
  final int width;

  PageViewportSizeChangedEventViewportSize({
    required this.height,
    required this.width,
  });

  factory PageViewportSizeChangedEventViewportSize.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return PageViewportSizeChangedEventViewportSize(
      height: (json[r'height'])!,
      width: (json[r'width'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {r'height': height, r'width': width};
  }
}

class PageWebSocketEvent {
  final WebSocketBase webSocket;

  PageWebSocketEvent({required this.webSocket});

  factory PageWebSocketEvent.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return PageWebSocketEvent(
      webSocket: (connection != null && json[r'webSocket'] != null
          ? ChannelOwner.from<WebSocketBase>(connection, json[r'webSocket'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'webSocket': {'guid': webSocket.guid},
    };
  }
}

class PageWebSocketRouteEvent {
  final WebSocketRouteBase webSocketRoute;

  PageWebSocketRouteEvent({required this.webSocketRoute});

  factory PageWebSocketRouteEvent.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return PageWebSocketRouteEvent(
      webSocketRoute: (connection != null && json[r'webSocketRoute'] != null
          ? ChannelOwner.from<WebSocketRouteBase>(
              connection,
              json[r'webSocketRoute'],
            )
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'webSocketRoute': {'guid': webSocketRoute.guid},
    };
  }
}

class PageWebStorageGetItemResult {
  final String? value;

  PageWebStorageGetItemResult({this.value});

  factory PageWebStorageGetItemResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return PageWebStorageGetItemResult(value: json[r'value']);
  }

  Map<String, dynamic> toJson() {
    return {if (value != null) r'value': value};
  }
}

class PageWebStorageItemsResult {
  final List<NameValue> items;

  PageWebStorageItemsResult({required this.items});

  factory PageWebStorageItemsResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return PageWebStorageItemsResult(
      items:
          ((json[r'items'] as List?)
              ?.map((e) => NameValue.fromJson(e, connection: connection))
              .toList()) ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {r'items': items.map((e) => e.toJson()).toList()};
  }
}

class PageWorkerEvent {
  final WorkerBase worker;

  PageWorkerEvent({required this.worker});

  factory PageWorkerEvent.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return PageWorkerEvent(
      worker: (connection != null && json[r'worker'] != null
          ? ChannelOwner.from<WorkerBase>(connection, json[r'worker'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'worker': {'guid': worker.guid},
    };
  }
}

class PlaywrightInitializer {
  final AndroidBase android;
  final BrowserTypeBase chromium;
  final ElectronBase electron;
  final BrowserTypeBase firefox;
  final AndroidDeviceBase? preConnectedAndroidDevice;
  final BrowserBase? preLaunchedBrowser;
  final SocksSupportBase? socksSupport;
  final LocalUtilsBase? utils;
  final BrowserTypeBase webkit;

  PlaywrightInitializer({
    required this.android,
    required this.chromium,
    required this.electron,
    required this.firefox,
    this.preConnectedAndroidDevice,
    this.preLaunchedBrowser,
    this.socksSupport,
    this.utils,
    required this.webkit,
  });

  factory PlaywrightInitializer.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return PlaywrightInitializer(
      android: (connection != null && json[r'android'] != null
          ? ChannelOwner.from<AndroidBase>(connection, json[r'android'])
          : null)!,
      chromium: (connection != null && json[r'chromium'] != null
          ? ChannelOwner.from<BrowserTypeBase>(connection, json[r'chromium'])
          : null)!,
      electron: (connection != null && json[r'electron'] != null
          ? ChannelOwner.from<ElectronBase>(connection, json[r'electron'])
          : null)!,
      firefox: (connection != null && json[r'firefox'] != null
          ? ChannelOwner.from<BrowserTypeBase>(connection, json[r'firefox'])
          : null)!,
      preConnectedAndroidDevice:
          connection != null && json[r'preConnectedAndroidDevice'] != null
          ? ChannelOwner.from<AndroidDeviceBase>(
              connection,
              json[r'preConnectedAndroidDevice'],
            )
          : null,
      preLaunchedBrowser:
          connection != null && json[r'preLaunchedBrowser'] != null
          ? ChannelOwner.from<BrowserBase>(
              connection,
              json[r'preLaunchedBrowser'],
            )
          : null,
      socksSupport: connection != null && json[r'socksSupport'] != null
          ? ChannelOwner.from<SocksSupportBase>(
              connection,
              json[r'socksSupport'],
            )
          : null,
      utils: connection != null && json[r'utils'] != null
          ? ChannelOwner.from<LocalUtilsBase>(connection, json[r'utils'])
          : null,
      webkit: (connection != null && json[r'webkit'] != null
          ? ChannelOwner.from<BrowserTypeBase>(connection, json[r'webkit'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'android': {'guid': android.guid},
      r'chromium': {'guid': chromium.guid},
      r'electron': {'guid': electron.guid},
      r'firefox': {'guid': firefox.guid},
      if (preConnectedAndroidDevice != null)
        r'preConnectedAndroidDevice': {'guid': preConnectedAndroidDevice?.guid},
      if (preLaunchedBrowser != null)
        r'preLaunchedBrowser': {'guid': preLaunchedBrowser?.guid},
      if (socksSupport != null) r'socksSupport': {'guid': socksSupport?.guid},
      if (utils != null) r'utils': {'guid': utils?.guid},
      r'webkit': {'guid': webkit.guid},
    };
  }
}

class PlaywrightNewRequestClientCertificatesItems {
  final String? cert;
  final String? key;
  final String origin;
  final String? passphrase;
  final String? pfx;

  PlaywrightNewRequestClientCertificatesItems({
    this.cert,
    this.key,
    required this.origin,
    this.passphrase,
    this.pfx,
  });

  factory PlaywrightNewRequestClientCertificatesItems.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return PlaywrightNewRequestClientCertificatesItems(
      cert: json[r'cert'],
      key: json[r'key'],
      origin: (json[r'origin'])!,
      passphrase: json[r'passphrase'],
      pfx: json[r'pfx'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (cert != null) r'cert': cert,
      if (key != null) r'key': key,
      r'origin': origin,
      if (passphrase != null) r'passphrase': passphrase,
      if (pfx != null) r'pfx': pfx,
    };
  }
}

class PlaywrightNewRequestHttpCredentials {
  final String? origin;
  final String password;
  final PlaywrightNewRequestHttpCredentialsSendEnum? send;
  final String username;

  PlaywrightNewRequestHttpCredentials({
    this.origin,
    required this.password,
    this.send,
    required this.username,
  });

  factory PlaywrightNewRequestHttpCredentials.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return PlaywrightNewRequestHttpCredentials(
      origin: json[r'origin'],
      password: (json[r'password'])!,
      send: json[r'send'] == null
          ? null
          : PlaywrightNewRequestHttpCredentialsSendEnum.values.firstWhere(
              (e) => e.value == json[r'send'],
            ),
      username: (json[r'username'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (origin != null) r'origin': origin,
      r'password': password,
      if (send != null) r'send': send?.value,
      r'username': username,
    };
  }
}

class PlaywrightNewRequestProxy {
  final String? bypass;
  final String? password;
  final String server;
  final String? username;

  PlaywrightNewRequestProxy({
    this.bypass,
    this.password,
    required this.server,
    this.username,
  });

  factory PlaywrightNewRequestProxy.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return PlaywrightNewRequestProxy(
      bypass: json[r'bypass'],
      password: json[r'password'],
      server: (json[r'server'])!,
      username: json[r'username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (bypass != null) r'bypass': bypass,
      if (password != null) r'password': password,
      r'server': server,
      if (username != null) r'username': username,
    };
  }
}

class PlaywrightNewRequestResult {
  final APIRequestContextBase request;

  PlaywrightNewRequestResult({required this.request});

  factory PlaywrightNewRequestResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return PlaywrightNewRequestResult(
      request: (connection != null && json[r'request'] != null
          ? ChannelOwner.from<APIRequestContextBase>(
              connection,
              json[r'request'],
            )
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'request': {'guid': request.guid},
    };
  }
}

class PlaywrightNewRequestStorageState {
  final List<NetworkCookie>? cookies;
  final List<SetOriginStorage>? origins;

  PlaywrightNewRequestStorageState({this.cookies, this.origins});

  factory PlaywrightNewRequestStorageState.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return PlaywrightNewRequestStorageState(
      cookies: (json[r'cookies'] as List?)
          ?.map((e) => NetworkCookie.fromJson(e, connection: connection))
          .toList(),
      origins: (json[r'origins'] as List?)
          ?.map((e) => SetOriginStorage.fromJson(e, connection: connection))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (cookies != null) r'cookies': cookies?.map((e) => e.toJson()).toList(),
      if (origins != null) r'origins': origins?.map((e) => e.toJson()).toList(),
    };
  }
}

class Point {
  final double x;
  final double y;

  Point({required this.x, required this.y});

  factory Point.fromJson(Map<String, dynamic> json, {Connection? connection}) {
    return Point(
      x: ((json[r'x'] as num?)?.toDouble())!,
      y: ((json[r'y'] as num?)?.toDouble())!,
    );
  }

  Map<String, dynamic> toJson() {
    return {r'x': x, r'y': y};
  }
}

class RecordHarOptions {
  final RecordHarOptionsContentEnum? content;
  final String? harPath;
  final RecordHarOptionsModeEnum? mode;
  final String? resourcesDir;
  final String? urlGlob;
  final String? urlRegexFlags;
  final String? urlRegexSource;

  RecordHarOptions({
    this.content,
    this.harPath,
    this.mode,
    this.resourcesDir,
    this.urlGlob,
    this.urlRegexFlags,
    this.urlRegexSource,
  });

  factory RecordHarOptions.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return RecordHarOptions(
      content: json[r'content'] == null
          ? null
          : RecordHarOptionsContentEnum.values.firstWhere(
              (e) => e.value == json[r'content'],
            ),
      harPath: json[r'harPath'],
      mode: json[r'mode'] == null
          ? null
          : RecordHarOptionsModeEnum.values.firstWhere(
              (e) => e.value == json[r'mode'],
            ),
      resourcesDir: json[r'resourcesDir'],
      urlGlob: json[r'urlGlob'],
      urlRegexFlags: json[r'urlRegexFlags'],
      urlRegexSource: json[r'urlRegexSource'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (content != null) r'content': content?.value,
      if (harPath != null) r'harPath': harPath,
      if (mode != null) r'mode': mode?.value,
      if (resourcesDir != null) r'resourcesDir': resourcesDir,
      if (urlGlob != null) r'urlGlob': urlGlob,
      if (urlRegexFlags != null) r'urlRegexFlags': urlRegexFlags,
      if (urlRegexSource != null) r'urlRegexSource': urlRegexSource,
    };
  }
}

class RecorderSource {
  final String? group;
  final List<RecorderSourceHighlightItems> highlight;
  final String id;
  final bool isRecorded;
  final String label;
  final String language;
  final int? revealLine;
  final String text;

  RecorderSource({
    this.group,
    required this.highlight,
    required this.id,
    required this.isRecorded,
    required this.label,
    required this.language,
    this.revealLine,
    required this.text,
  });

  factory RecorderSource.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return RecorderSource(
      group: json[r'group'],
      highlight:
          ((json[r'highlight'] as List?)
              ?.map(
                (e) => RecorderSourceHighlightItems.fromJson(
                  e,
                  connection: connection,
                ),
              )
              .toList()) ??
          [],
      id: (json[r'id'])!,
      isRecorded: (json[r'isRecorded'])!,
      label: (json[r'label'])!,
      language: (json[r'language'])!,
      revealLine: json[r'revealLine'],
      text: (json[r'text'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (group != null) r'group': group,
      r'highlight': highlight.map((e) => e.toJson()).toList(),
      r'id': id,
      r'isRecorded': isRecorded,
      r'label': label,
      r'language': language,
      if (revealLine != null) r'revealLine': revealLine,
      r'text': text,
    };
  }
}

class RecorderSourceHighlightItems {
  final int line;
  final String type;

  RecorderSourceHighlightItems({required this.line, required this.type});

  factory RecorderSourceHighlightItems.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return RecorderSourceHighlightItems(
      line: (json[r'line'])!,
      type: (json[r'type'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {r'line': line, r'type': type};
  }
}

class Rect {
  final double height;
  final double width;
  final double x;
  final double y;

  Rect({
    required this.height,
    required this.width,
    required this.x,
    required this.y,
  });

  factory Rect.fromJson(Map<String, dynamic> json, {Connection? connection}) {
    return Rect(
      height: ((json[r'height'] as num?)?.toDouble())!,
      width: ((json[r'width'] as num?)?.toDouble())!,
      x: ((json[r'x'] as num?)?.toDouble())!,
      y: ((json[r'y'] as num?)?.toDouble())!,
    );
  }

  Map<String, dynamic> toJson() {
    return {r'height': height, r'width': width, r'x': x, r'y': y};
  }
}

class RemoteAddr {
  final String ipAddress;
  final int port;

  RemoteAddr({required this.ipAddress, required this.port});

  factory RemoteAddr.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return RemoteAddr(ipAddress: (json[r'ipAddress'])!, port: (json[r'port'])!);
  }

  Map<String, dynamic> toJson() {
    return {r'ipAddress': ipAddress, r'port': port};
  }
}

class RequestInitializer {
  final FrameBase? frame;
  final List<NameValue> headers;
  final bool isNavigationRequest;
  final String method;
  final String? postData;
  final RequestBase? redirectedFrom;
  final String resourceType;
  final WorkerBase? serviceWorker;
  final String url;

  RequestInitializer({
    this.frame,
    required this.headers,
    required this.isNavigationRequest,
    required this.method,
    this.postData,
    this.redirectedFrom,
    required this.resourceType,
    this.serviceWorker,
    required this.url,
  });

  factory RequestInitializer.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return RequestInitializer(
      frame: connection != null && json[r'frame'] != null
          ? ChannelOwner.from<FrameBase>(connection, json[r'frame'])
          : null,
      headers:
          ((json[r'headers'] as List?)
              ?.map((e) => NameValue.fromJson(e, connection: connection))
              .toList()) ??
          [],
      isNavigationRequest: (json[r'isNavigationRequest'])!,
      method: (json[r'method'])!,
      postData: json[r'postData'],
      redirectedFrom: connection != null && json[r'redirectedFrom'] != null
          ? ChannelOwner.from<RequestBase>(connection, json[r'redirectedFrom'])
          : null,
      resourceType: (json[r'resourceType'])!,
      serviceWorker: connection != null && json[r'serviceWorker'] != null
          ? ChannelOwner.from<WorkerBase>(connection, json[r'serviceWorker'])
          : null,
      url: (json[r'url'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (frame != null) r'frame': {'guid': frame?.guid},
      r'headers': headers.map((e) => e.toJson()).toList(),
      r'isNavigationRequest': isNavigationRequest,
      r'method': method,
      if (postData != null) r'postData': postData,
      if (redirectedFrom != null)
        r'redirectedFrom': {'guid': redirectedFrom?.guid},
      r'resourceType': resourceType,
      if (serviceWorker != null)
        r'serviceWorker': {'guid': serviceWorker?.guid},
      r'url': url,
    };
  }
}

class RequestRawRequestHeadersResult {
  final List<NameValue> headers;

  RequestRawRequestHeadersResult({required this.headers});

  factory RequestRawRequestHeadersResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return RequestRawRequestHeadersResult(
      headers:
          ((json[r'headers'] as List?)
              ?.map((e) => NameValue.fromJson(e, connection: connection))
              .toList()) ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {r'headers': headers.map((e) => e.toJson()).toList()};
  }
}

class RequestResponseResult {
  final ResponseBase? response;

  RequestResponseResult({this.response});

  factory RequestResponseResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return RequestResponseResult(
      response: connection != null && json[r'response'] != null
          ? ChannelOwner.from<ResponseBase>(connection, json[r'response'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (response != null) r'response': {'guid': response?.guid},
    };
  }
}

class RequestSizes {
  final int requestBodySize;
  final int requestHeadersSize;
  final int responseBodySize;
  final int responseHeadersSize;

  RequestSizes({
    required this.requestBodySize,
    required this.requestHeadersSize,
    required this.responseBodySize,
    required this.responseHeadersSize,
  });

  factory RequestSizes.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return RequestSizes(
      requestBodySize: (json[r'requestBodySize'])!,
      requestHeadersSize: (json[r'requestHeadersSize'])!,
      responseBodySize: (json[r'responseBodySize'])!,
      responseHeadersSize: (json[r'responseHeadersSize'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'requestBodySize': requestBodySize,
      r'requestHeadersSize': requestHeadersSize,
      r'responseBodySize': responseBodySize,
      r'responseHeadersSize': responseHeadersSize,
    };
  }
}

class ResourceTiming {
  final double connectEnd;
  final double connectStart;
  final double domainLookupEnd;
  final double domainLookupStart;
  final double requestStart;
  final double responseStart;
  final double secureConnectionStart;
  final double startTime;

  ResourceTiming({
    required this.connectEnd,
    required this.connectStart,
    required this.domainLookupEnd,
    required this.domainLookupStart,
    required this.requestStart,
    required this.responseStart,
    required this.secureConnectionStart,
    required this.startTime,
  });

  factory ResourceTiming.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ResourceTiming(
      connectEnd: ((json[r'connectEnd'] as num?)?.toDouble())!,
      connectStart: ((json[r'connectStart'] as num?)?.toDouble())!,
      domainLookupEnd: ((json[r'domainLookupEnd'] as num?)?.toDouble())!,
      domainLookupStart: ((json[r'domainLookupStart'] as num?)?.toDouble())!,
      requestStart: ((json[r'requestStart'] as num?)?.toDouble())!,
      responseStart: ((json[r'responseStart'] as num?)?.toDouble())!,
      secureConnectionStart: ((json[r'secureConnectionStart'] as num?)
          ?.toDouble())!,
      startTime: ((json[r'startTime'] as num?)?.toDouble())!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'connectEnd': connectEnd,
      r'connectStart': connectStart,
      r'domainLookupEnd': domainLookupEnd,
      r'domainLookupStart': domainLookupStart,
      r'requestStart': requestStart,
      r'responseStart': responseStart,
      r'secureConnectionStart': secureConnectionStart,
      r'startTime': startTime,
    };
  }
}

class ResponseBodyResult {
  final String binary;

  ResponseBodyResult({required this.binary});

  factory ResponseBodyResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ResponseBodyResult(binary: (json[r'binary'])!);
  }

  Map<String, dynamic> toJson() {
    return {r'binary': binary};
  }
}

class ResponseHttpVersionResult {
  final String value;

  ResponseHttpVersionResult({required this.value});

  factory ResponseHttpVersionResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ResponseHttpVersionResult(value: (json[r'value'])!);
  }

  Map<String, dynamic> toJson() {
    return {r'value': value};
  }
}

class ResponseInitializer {
  final bool fromServiceWorker;
  final List<NameValue> headers;
  final RequestBase request;
  final int status;
  final String statusText;
  final ResourceTiming timing;
  final String url;

  ResponseInitializer({
    required this.fromServiceWorker,
    required this.headers,
    required this.request,
    required this.status,
    required this.statusText,
    required this.timing,
    required this.url,
  });

  factory ResponseInitializer.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ResponseInitializer(
      fromServiceWorker: (json[r'fromServiceWorker'])!,
      headers:
          ((json[r'headers'] as List?)
              ?.map((e) => NameValue.fromJson(e, connection: connection))
              .toList()) ??
          [],
      request: (connection != null && json[r'request'] != null
          ? ChannelOwner.from<RequestBase>(connection, json[r'request'])
          : null)!,
      status: (json[r'status'])!,
      statusText: (json[r'statusText'])!,
      timing: (json[r'timing'] == null
          ? null
          : ResourceTiming.fromJson(json[r'timing'], connection: connection))!,
      url: (json[r'url'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'fromServiceWorker': fromServiceWorker,
      r'headers': headers.map((e) => e.toJson()).toList(),
      r'request': {'guid': request.guid},
      r'status': status,
      r'statusText': statusText,
      r'timing': timing.toJson(),
      r'url': url,
    };
  }
}

class ResponseRawResponseHeadersResult {
  final List<NameValue> headers;

  ResponseRawResponseHeadersResult({required this.headers});

  factory ResponseRawResponseHeadersResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ResponseRawResponseHeadersResult(
      headers:
          ((json[r'headers'] as List?)
              ?.map((e) => NameValue.fromJson(e, connection: connection))
              .toList()) ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {r'headers': headers.map((e) => e.toJson()).toList()};
  }
}

class ResponseSecurityDetailsResult {
  final SecurityDetails? value;

  ResponseSecurityDetailsResult({this.value});

  factory ResponseSecurityDetailsResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ResponseSecurityDetailsResult(
      value: json[r'value'] == null
          ? null
          : SecurityDetails.fromJson(json[r'value'], connection: connection),
    );
  }

  Map<String, dynamic> toJson() {
    return {if (value != null) r'value': value?.toJson()};
  }
}

class ResponseServerAddrResult {
  final RemoteAddr? value;

  ResponseServerAddrResult({this.value});

  factory ResponseServerAddrResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ResponseServerAddrResult(
      value: json[r'value'] == null
          ? null
          : RemoteAddr.fromJson(json[r'value'], connection: connection),
    );
  }

  Map<String, dynamic> toJson() {
    return {if (value != null) r'value': value?.toJson()};
  }
}

class ResponseSizesResult {
  final RequestSizes sizes;

  ResponseSizesResult({required this.sizes});

  factory ResponseSizesResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ResponseSizesResult(
      sizes: (json[r'sizes'] == null
          ? null
          : RequestSizes.fromJson(json[r'sizes'], connection: connection))!,
    );
  }

  Map<String, dynamic> toJson() {
    return {r'sizes': sizes.toJson()};
  }
}

class RootInitializeResult {
  final PlaywrightBase playwright;

  RootInitializeResult({required this.playwright});

  factory RootInitializeResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return RootInitializeResult(
      playwright: (connection != null && json[r'playwright'] != null
          ? ChannelOwner.from<PlaywrightBase>(connection, json[r'playwright'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'playwright': {'guid': playwright.guid},
    };
  }
}

class RouteInitializer {
  final RequestBase request;

  RouteInitializer({required this.request});

  factory RouteInitializer.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return RouteInitializer(
      request: (connection != null && json[r'request'] != null
          ? ChannelOwner.from<RequestBase>(connection, json[r'request'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'request': {'guid': request.guid},
    };
  }
}

class SecurityDetails {
  final String? issuer;
  final String? protocol;
  final String? subjectName;
  final double? validFrom;
  final double? validTo;

  SecurityDetails({
    this.issuer,
    this.protocol,
    this.subjectName,
    this.validFrom,
    this.validTo,
  });

  factory SecurityDetails.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return SecurityDetails(
      issuer: json[r'issuer'],
      protocol: json[r'protocol'],
      subjectName: json[r'subjectName'],
      validFrom: (json[r'validFrom'] as num?)?.toDouble(),
      validTo: (json[r'validTo'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (issuer != null) r'issuer': issuer,
      if (protocol != null) r'protocol': protocol,
      if (subjectName != null) r'subjectName': subjectName,
      if (validFrom != null) r'validFrom': validFrom,
      if (validTo != null) r'validTo': validTo,
    };
  }
}

class SelectorEngine {
  final bool? contentScript;
  final String name;
  final String source;

  SelectorEngine({
    this.contentScript,
    required this.name,
    required this.source,
  });

  factory SelectorEngine.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return SelectorEngine(
      contentScript: json[r'contentScript'],
      name: (json[r'name'])!,
      source: (json[r'source'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (contentScript != null) r'contentScript': contentScript,
      r'name': name,
      r'source': source,
    };
  }
}

class SerializedArgument {
  final List<ChannelOwner> handles;
  final SerializedValue value;

  SerializedArgument({required this.handles, required this.value});

  factory SerializedArgument.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return SerializedArgument(
      handles:
          (connection != null
              ? (json[r'handles'] as List?)
                    ?.map((e) => ChannelOwner.from<ChannelOwner>(connection, e))
                    .toList()
              : null) ??
          [],
      value: (json[r'value'] == null
          ? null
          : SerializedValue.fromJson(json[r'value'], connection: connection))!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'handles': handles.map((e) => {'guid': e.guid}).toList(),
      r'value': value.toJson(),
    };
  }
}

class SerializedError {
  final SerializedErrorError? error;
  final SerializedValue? value;

  SerializedError({this.error, this.value});

  factory SerializedError.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return SerializedError(
      error: json[r'error'] == null
          ? null
          : SerializedErrorError.fromJson(
              json[r'error'],
              connection: connection,
            ),
      value: json[r'value'] == null
          ? null
          : SerializedValue.fromJson(json[r'value'], connection: connection),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (error != null) r'error': error?.toJson(),
      if (value != null) r'value': value?.toJson(),
    };
  }
}

class SerializedErrorError {
  final String message;
  final String name;
  final String? stack;

  SerializedErrorError({required this.message, required this.name, this.stack});

  factory SerializedErrorError.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return SerializedErrorError(
      message: (json[r'message'])!,
      name: (json[r'name'])!,
      stack: json[r'stack'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'message': message,
      r'name': name,
      if (stack != null) r'stack': stack,
    };
  }
}

class SerializedValue {
  final List<SerializedValue>? a;
  final bool? b;
  final String? bi;
  final String? d;
  final SerializedValueE? e;
  final int? h;
  final int? id;
  final double? n;
  final List<SerializedValueOItems>? o;
  final SerializedValueR? r;
  final int? ref;
  final String? s;
  final SerializedValueTa? ta;
  final String? u;
  final SerializedValueVEnum? v;

  SerializedValue({
    this.a,
    this.b,
    this.bi,
    this.d,
    this.e,
    this.h,
    this.id,
    this.n,
    this.o,
    this.r,
    this.ref,
    this.s,
    this.ta,
    this.u,
    this.v,
  });

  factory SerializedValue.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return SerializedValue(
      a: (json[r'a'] as List?)
          ?.map((e) => SerializedValue.fromJson(e, connection: connection))
          .toList(),
      b: json[r'b'],
      bi: json[r'bi'],
      d: json[r'd'],
      e: json[r'e'] == null
          ? null
          : SerializedValueE.fromJson(json[r'e'], connection: connection),
      h: json[r'h'],
      id: json[r'id'],
      n: (json[r'n'] as num?)?.toDouble(),
      o: (json[r'o'] as List?)
          ?.map(
            (e) => SerializedValueOItems.fromJson(e, connection: connection),
          )
          .toList(),
      r: json[r'r'] == null
          ? null
          : SerializedValueR.fromJson(json[r'r'], connection: connection),
      ref: json[r'ref'],
      s: json[r's'],
      ta: json[r'ta'] == null
          ? null
          : SerializedValueTa.fromJson(json[r'ta'], connection: connection),
      u: json[r'u'],
      v: json[r'v'] == null
          ? null
          : SerializedValueVEnum.values.firstWhere(
              (e) => e.value == json[r'v'],
            ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (a != null) r'a': a?.map((e) => e.toJson()).toList(),
      if (b != null) r'b': b,
      if (bi != null) r'bi': bi,
      if (d != null) r'd': d,
      if (e != null) r'e': e?.toJson(),
      if (h != null) r'h': h,
      if (id != null) r'id': id,
      if (n != null) r'n': n,
      if (o != null) r'o': o?.map((e) => e.toJson()).toList(),
      if (r != null) r'r': r?.toJson(),
      if (ref != null) r'ref': ref,
      if (s != null) r's': s,
      if (ta != null) r'ta': ta?.toJson(),
      if (u != null) r'u': u,
      if (v != null) r'v': v?.value,
    };
  }
}

class SerializedValueE {
  final String m;
  final String n;
  final String s;

  SerializedValueE({required this.m, required this.n, required this.s});

  factory SerializedValueE.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return SerializedValueE(
      m: (json[r'm'])!,
      n: (json[r'n'])!,
      s: (json[r's'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {r'm': m, r'n': n, r's': s};
  }
}

class SerializedValueOItems {
  final String k;
  final SerializedValue v;

  SerializedValueOItems({required this.k, required this.v});

  factory SerializedValueOItems.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return SerializedValueOItems(
      k: (json[r'k'])!,
      v: (json[r'v'] == null
          ? null
          : SerializedValue.fromJson(json[r'v'], connection: connection))!,
    );
  }

  Map<String, dynamic> toJson() {
    return {r'k': k, r'v': v.toJson()};
  }
}

class SerializedValueR {
  final String f;
  final String p;

  SerializedValueR({required this.f, required this.p});

  factory SerializedValueR.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return SerializedValueR(f: (json[r'f'])!, p: (json[r'p'])!);
  }

  Map<String, dynamic> toJson() {
    return {r'f': f, r'p': p};
  }
}

class SerializedValueTa {
  final String b;
  final SerializedValueTaKEnum k;

  SerializedValueTa({required this.b, required this.k});

  factory SerializedValueTa.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return SerializedValueTa(
      b: (json[r'b'])!,
      k: (json[r'k'] == null
          ? null
          : SerializedValueTaKEnum.values.firstWhere(
              (e) => e.value == json[r'k'],
            ))!,
    );
  }

  Map<String, dynamic> toJson() {
    return {r'b': b, r'k': k.value};
  }
}

class SetNetworkCookie {
  final bool? crHasCrossSiteAncestor;
  final String? domain;
  final double? expires;
  final bool? httpOnly;
  final String name;
  final String? partitionKey;
  final String? path;
  final SetNetworkCookieSameSiteEnum? sameSite;
  final bool? secure;
  final String? url;
  final String value;

  SetNetworkCookie({
    this.crHasCrossSiteAncestor,
    this.domain,
    this.expires,
    this.httpOnly,
    required this.name,
    this.partitionKey,
    this.path,
    this.sameSite,
    this.secure,
    this.url,
    required this.value,
  });

  factory SetNetworkCookie.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return SetNetworkCookie(
      crHasCrossSiteAncestor: json[r'_crHasCrossSiteAncestor'],
      domain: json[r'domain'],
      expires: (json[r'expires'] as num?)?.toDouble(),
      httpOnly: json[r'httpOnly'],
      name: (json[r'name'])!,
      partitionKey: json[r'partitionKey'],
      path: json[r'path'],
      sameSite: json[r'sameSite'] == null
          ? null
          : SetNetworkCookieSameSiteEnum.values.firstWhere(
              (e) => e.value == json[r'sameSite'],
            ),
      secure: json[r'secure'],
      url: json[r'url'],
      value: (json[r'value'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (crHasCrossSiteAncestor != null)
        r'_crHasCrossSiteAncestor': crHasCrossSiteAncestor,
      if (domain != null) r'domain': domain,
      if (expires != null) r'expires': expires,
      if (httpOnly != null) r'httpOnly': httpOnly,
      r'name': name,
      if (partitionKey != null) r'partitionKey': partitionKey,
      if (path != null) r'path': path,
      if (sameSite != null) r'sameSite': sameSite?.value,
      if (secure != null) r'secure': secure,
      if (url != null) r'url': url,
      r'value': value,
    };
  }
}

class SetOriginStorage {
  final List<IndexedDBDatabase>? indexedDB;
  final List<NameValue> localStorage;
  final String origin;

  SetOriginStorage({
    this.indexedDB,
    required this.localStorage,
    required this.origin,
  });

  factory SetOriginStorage.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return SetOriginStorage(
      indexedDB: (json[r'indexedDB'] as List?)
          ?.map((e) => IndexedDBDatabase.fromJson(e, connection: connection))
          .toList(),
      localStorage:
          ((json[r'localStorage'] as List?)
              ?.map((e) => NameValue.fromJson(e, connection: connection))
              .toList()) ??
          [],
      origin: (json[r'origin'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (indexedDB != null)
        r'indexedDB': indexedDB?.map((e) => e.toJson()).toList(),
      r'localStorage': localStorage.map((e) => e.toJson()).toList(),
      r'origin': origin,
    };
  }
}

class ShowActionsOptions {
  final ShowActionsOptionsCursorEnum? cursor;
  final double? duration;
  final int? fontSize;
  final ShowActionsOptionsPositionEnum? position;

  ShowActionsOptions({
    this.cursor,
    this.duration,
    this.fontSize,
    this.position,
  });

  factory ShowActionsOptions.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ShowActionsOptions(
      cursor: json[r'cursor'] == null
          ? null
          : ShowActionsOptionsCursorEnum.values.firstWhere(
              (e) => e.value == json[r'cursor'],
            ),
      duration: (json[r'duration'] as num?)?.toDouble(),
      fontSize: json[r'fontSize'],
      position: json[r'position'] == null
          ? null
          : ShowActionsOptionsPositionEnum.values.firstWhere(
              (e) => e.value == json[r'position'],
            ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (cursor != null) r'cursor': cursor?.value,
      if (duration != null) r'duration': duration,
      if (fontSize != null) r'fontSize': fontSize,
      if (position != null) r'position': position?.value,
    };
  }
}

class SocksSupportSocksClosedEvent {
  final String uid;

  SocksSupportSocksClosedEvent({required this.uid});

  factory SocksSupportSocksClosedEvent.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return SocksSupportSocksClosedEvent(uid: (json[r'uid'])!);
  }

  Map<String, dynamic> toJson() {
    return {r'uid': uid};
  }
}

class SocksSupportSocksDataEvent {
  final String data;
  final String uid;

  SocksSupportSocksDataEvent({required this.data, required this.uid});

  factory SocksSupportSocksDataEvent.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return SocksSupportSocksDataEvent(
      data: (json[r'data'])!,
      uid: (json[r'uid'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {r'data': data, r'uid': uid};
  }
}

class SocksSupportSocksRequestedEvent {
  final String host;
  final int port;
  final String uid;

  SocksSupportSocksRequestedEvent({
    required this.host,
    required this.port,
    required this.uid,
  });

  factory SocksSupportSocksRequestedEvent.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return SocksSupportSocksRequestedEvent(
      host: (json[r'host'])!,
      port: (json[r'port'])!,
      uid: (json[r'uid'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {r'host': host, r'port': port, r'uid': uid};
  }
}

class StackFrame {
  final int column;
  final String file;
  final String? function;
  final int line;

  StackFrame({
    required this.column,
    required this.file,
    this.function,
    required this.line,
  });

  factory StackFrame.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return StackFrame(
      column: (json[r'column'])!,
      file: (json[r'file'])!,
      function: json[r'function'],
      line: (json[r'line'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'column': column,
      r'file': file,
      if (function != null) r'function': function,
      r'line': line,
    };
  }
}

class StreamReadResult {
  final String binary;

  StreamReadResult({required this.binary});

  factory StreamReadResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return StreamReadResult(binary: (json[r'binary'])!);
  }

  Map<String, dynamic> toJson() {
    return {r'binary': binary};
  }
}

class TracingHarExportResult {
  final ArtifactBase? artifact;
  final List<NameValue>? entries;

  TracingHarExportResult({this.artifact, this.entries});

  factory TracingHarExportResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return TracingHarExportResult(
      artifact: connection != null && json[r'artifact'] != null
          ? ChannelOwner.from<ArtifactBase>(connection, json[r'artifact'])
          : null,
      entries: (json[r'entries'] as List?)
          ?.map((e) => NameValue.fromJson(e, connection: connection))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (artifact != null) r'artifact': {'guid': artifact?.guid},
      if (entries != null) r'entries': entries?.map((e) => e.toJson()).toList(),
    };
  }
}

class TracingHarStartResult {
  final String harId;

  TracingHarStartResult({required this.harId});

  factory TracingHarStartResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return TracingHarStartResult(harId: (json[r'harId'])!);
  }

  Map<String, dynamic> toJson() {
    return {r'harId': harId};
  }
}

class TracingTracingGroupLocation {
  final int? column;
  final String file;
  final int? line;

  TracingTracingGroupLocation({this.column, required this.file, this.line});

  factory TracingTracingGroupLocation.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return TracingTracingGroupLocation(
      column: json[r'column'],
      file: (json[r'file'])!,
      line: json[r'line'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (column != null) r'column': column,
      r'file': file,
      if (line != null) r'line': line,
    };
  }
}

class TracingTracingStartChunkResult {
  final String traceName;

  TracingTracingStartChunkResult({required this.traceName});

  factory TracingTracingStartChunkResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return TracingTracingStartChunkResult(traceName: (json[r'traceName'])!);
  }

  Map<String, dynamic> toJson() {
    return {r'traceName': traceName};
  }
}

class TracingTracingStopChunkResult {
  final ArtifactBase? artifact;
  final List<NameValue>? entries;

  TracingTracingStopChunkResult({this.artifact, this.entries});

  factory TracingTracingStopChunkResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return TracingTracingStopChunkResult(
      artifact: connection != null && json[r'artifact'] != null
          ? ChannelOwner.from<ArtifactBase>(connection, json[r'artifact'])
          : null,
      entries: (json[r'entries'] as List?)
          ?.map((e) => NameValue.fromJson(e, connection: connection))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (artifact != null) r'artifact': {'guid': artifact?.guid},
      if (entries != null) r'entries': entries?.map((e) => e.toJson()).toList(),
    };
  }
}

class URLPattern {
  final String hash;
  final String hostname;
  final String password;
  final String pathname;
  final String port;
  final String protocol;
  final String search;
  final String username;

  URLPattern({
    required this.hash,
    required this.hostname,
    required this.password,
    required this.pathname,
    required this.port,
    required this.protocol,
    required this.search,
    required this.username,
  });

  factory URLPattern.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return URLPattern(
      hash: (json[r'hash'])!,
      hostname: (json[r'hostname'])!,
      password: (json[r'password'])!,
      pathname: (json[r'pathname'])!,
      port: (json[r'port'])!,
      protocol: (json[r'protocol'])!,
      search: (json[r'search'])!,
      username: (json[r'username'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'hash': hash,
      r'hostname': hostname,
      r'password': password,
      r'pathname': pathname,
      r'port': port,
      r'protocol': protocol,
      r'search': search,
      r'username': username,
    };
  }
}

class VirtualCredential {
  final String id;
  final String privateKey;
  final String publicKey;
  final String rpId;
  final String userHandle;

  VirtualCredential({
    required this.id,
    required this.privateKey,
    required this.publicKey,
    required this.rpId,
    required this.userHandle,
  });

  factory VirtualCredential.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return VirtualCredential(
      id: (json[r'id'])!,
      privateKey: (json[r'privateKey'])!,
      publicKey: (json[r'publicKey'])!,
      rpId: (json[r'rpId'])!,
      userHandle: (json[r'userHandle'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'id': id,
      r'privateKey': privateKey,
      r'publicKey': publicKey,
      r'rpId': rpId,
      r'userHandle': userHandle,
    };
  }
}

class WaitInfo {
  final String? error;
  final String? event;
  final String? message;
  final WaitInfoPhaseEnum phase;
  final String waitId;

  WaitInfo({
    this.error,
    this.event,
    this.message,
    required this.phase,
    required this.waitId,
  });

  factory WaitInfo.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return WaitInfo(
      error: json[r'error'],
      event: json[r'event'],
      message: json[r'message'],
      phase: (json[r'phase'] == null
          ? null
          : WaitInfoPhaseEnum.values.firstWhere(
              (e) => e.value == json[r'phase'],
            ))!,
      waitId: (json[r'waitId'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (error != null) r'error': error,
      if (event != null) r'event': event,
      if (message != null) r'message': message,
      r'phase': phase.value,
      r'waitId': waitId,
    };
  }
}

class WebSocketFrameReceivedEvent {
  final String data;
  final int opcode;

  WebSocketFrameReceivedEvent({required this.data, required this.opcode});

  factory WebSocketFrameReceivedEvent.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return WebSocketFrameReceivedEvent(
      data: (json[r'data'])!,
      opcode: (json[r'opcode'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {r'data': data, r'opcode': opcode};
  }
}

class WebSocketFrameSentEvent {
  final String data;
  final int opcode;

  WebSocketFrameSentEvent({required this.data, required this.opcode});

  factory WebSocketFrameSentEvent.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return WebSocketFrameSentEvent(
      data: (json[r'data'])!,
      opcode: (json[r'opcode'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {r'data': data, r'opcode': opcode};
  }
}

class WebSocketInitializer {
  final String url;

  WebSocketInitializer({required this.url});

  factory WebSocketInitializer.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return WebSocketInitializer(url: (json[r'url'])!);
  }

  Map<String, dynamic> toJson() {
    return {r'url': url};
  }
}

class WebSocketRouteClosePageEvent {
  final int? code;
  final String? reason;
  final bool wasClean;

  WebSocketRouteClosePageEvent({
    this.code,
    this.reason,
    required this.wasClean,
  });

  factory WebSocketRouteClosePageEvent.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return WebSocketRouteClosePageEvent(
      code: json[r'code'],
      reason: json[r'reason'],
      wasClean: (json[r'wasClean'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (code != null) r'code': code,
      if (reason != null) r'reason': reason,
      r'wasClean': wasClean,
    };
  }
}

class WebSocketRouteCloseServerEvent {
  final int? code;
  final String? reason;
  final bool wasClean;

  WebSocketRouteCloseServerEvent({
    this.code,
    this.reason,
    required this.wasClean,
  });

  factory WebSocketRouteCloseServerEvent.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return WebSocketRouteCloseServerEvent(
      code: json[r'code'],
      reason: json[r'reason'],
      wasClean: (json[r'wasClean'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (code != null) r'code': code,
      if (reason != null) r'reason': reason,
      r'wasClean': wasClean,
    };
  }
}

class WebSocketRouteInitializer {
  final List<String> protocols;
  final String url;

  WebSocketRouteInitializer({required this.protocols, required this.url});

  factory WebSocketRouteInitializer.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return WebSocketRouteInitializer(
      protocols: ((json[r'protocols'] as List?)?.cast<String>()) ?? [],
      url: (json[r'url'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {r'protocols': protocols, r'url': url};
  }
}

class WebSocketRouteMessageFromPageEvent {
  final bool isBase64;
  final String message;

  WebSocketRouteMessageFromPageEvent({
    required this.isBase64,
    required this.message,
  });

  factory WebSocketRouteMessageFromPageEvent.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return WebSocketRouteMessageFromPageEvent(
      isBase64: (json[r'isBase64'])!,
      message: (json[r'message'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {r'isBase64': isBase64, r'message': message};
  }
}

class WebSocketRouteMessageFromServerEvent {
  final bool isBase64;
  final String message;

  WebSocketRouteMessageFromServerEvent({
    required this.isBase64,
    required this.message,
  });

  factory WebSocketRouteMessageFromServerEvent.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return WebSocketRouteMessageFromServerEvent(
      isBase64: (json[r'isBase64'])!,
      message: (json[r'message'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {r'isBase64': isBase64, r'message': message};
  }
}

class WebSocketSocketErrorEvent {
  final String error;

  WebSocketSocketErrorEvent({required this.error});

  factory WebSocketSocketErrorEvent.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return WebSocketSocketErrorEvent(error: (json[r'error'])!);
  }

  Map<String, dynamic> toJson() {
    return {r'error': error};
  }
}

class WorkerConsoleEvent {
  final ConsoleMessage mixinValue;

  WorkerConsoleEvent({required this.mixinValue});

  factory WorkerConsoleEvent.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return WorkerConsoleEvent(
      mixinValue: (json[r'$mixin'] == null
          ? null
          : ConsoleMessage.fromJson(json[r'$mixin'], connection: connection))!,
    );
  }

  Map<String, dynamic> toJson() {
    return {r'$mixin': mixinValue.toJson()};
  }
}

class WorkerEvaluateExpressionHandleResult {
  final JSHandleBase handle;

  WorkerEvaluateExpressionHandleResult({required this.handle});

  factory WorkerEvaluateExpressionHandleResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return WorkerEvaluateExpressionHandleResult(
      handle: (connection != null && json[r'handle'] != null
          ? ChannelOwner.from<JSHandleBase>(connection, json[r'handle'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      r'handle': {'guid': handle.guid},
    };
  }
}

class WorkerEvaluateExpressionResult {
  final SerializedValue value;

  WorkerEvaluateExpressionResult({required this.value});

  factory WorkerEvaluateExpressionResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return WorkerEvaluateExpressionResult(
      value: (json[r'value'] == null
          ? null
          : SerializedValue.fromJson(json[r'value'], connection: connection))!,
    );
  }

  Map<String, dynamic> toJson() {
    return {r'value': value.toJson()};
  }
}

class WorkerInitializer {
  final String url;

  WorkerInitializer({required this.url});

  factory WorkerInitializer.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return WorkerInitializer(url: (json[r'url'])!);
  }

  Map<String, dynamic> toJson() {
    return {r'url': url};
  }
}

abstract class APIRequestContextBase extends ChannelOwner {
  APIRequestContextBase(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  APIRequestContextInitializer get typedInitializer =>
      APIRequestContextInitializer.fromJson(
        super.initializer,
        connection: connection,
      );

  Future<void> channel_dispose({String? reason}) async {
    final payload = <String, dynamic>{};
    if (reason != null) payload['reason'] = reason;
    final response = await connection.sendMessageToServer(
      guid,
      'dispose',
      payload,
    );
    return;
  }

  Future<void> channel_disposeAPIResponse({required String fetchUid}) async {
    final payload = <String, dynamic>{};
    payload['fetchUid'] = fetchUid;
    final response = await connection.sendMessageToServer(
      guid,
      'disposeAPIResponse',
      payload,
    );
    return;
  }

  /// {method} "{url}"
  Future<APIRequestContextFetchResult> channel_fetch({
    String? encodedParams,
    bool? failOnStatusCode,
    List<NameValue>? formData,
    List<NameValue>? headers,
    bool? ignoreHTTPSErrors,
    String? jsonData,
    int? maxRedirects,
    int? maxRetries,
    String? method,
    List<FormField>? multipartData,
    List<NameValue>? params,
    String? postData,
    required double timeout,
    required String url,
  }) async {
    final payload = <String, dynamic>{};
    if (encodedParams != null) payload['encodedParams'] = encodedParams;
    if (failOnStatusCode != null)
      payload['failOnStatusCode'] = failOnStatusCode;
    if (formData != null) payload['formData'] = formData;
    if (headers != null) payload['headers'] = headers;
    if (ignoreHTTPSErrors != null)
      payload['ignoreHTTPSErrors'] = ignoreHTTPSErrors;
    if (jsonData != null) payload['jsonData'] = jsonData;
    if (maxRedirects != null) payload['maxRedirects'] = maxRedirects;
    if (maxRetries != null) payload['maxRetries'] = maxRetries;
    if (method != null) payload['method'] = method;
    if (multipartData != null) payload['multipartData'] = multipartData;
    if (params != null) payload['params'] = params;
    if (postData != null) payload['postData'] = postData;
    payload['timeout'] = timeout;
    payload['url'] = url;
    final response = await connection.sendMessageToServer(
      guid,
      'fetch',
      payload,
    );
    return APIRequestContextFetchResult.fromJson(
      response,
      connection: connection,
    );
  }

  Future<APIRequestContextFetchLogResult> channel_fetchLog({
    required String fetchUid,
  }) async {
    final payload = <String, dynamic>{};
    payload['fetchUid'] = fetchUid;
    final response = await connection.sendMessageToServer(
      guid,
      'fetchLog',
      payload,
    );
    return APIRequestContextFetchLogResult.fromJson(
      response,
      connection: connection,
    );
  }

  /// Get response body
  Future<APIRequestContextFetchResponseBodyResult> channel_fetchResponseBody({
    required String fetchUid,
  }) async {
    final payload = <String, dynamic>{};
    payload['fetchUid'] = fetchUid;
    final response = await connection.sendMessageToServer(
      guid,
      'fetchResponseBody',
      payload,
    );
    return APIRequestContextFetchResponseBodyResult.fromJson(
      response,
      connection: connection,
    );
  }

  /// Get storage state
  Future<APIRequestContextStorageStateResult> channel_storageState({
    bool? indexedDB,
  }) async {
    final payload = <String, dynamic>{};
    if (indexedDB != null) payload['indexedDB'] = indexedDB;
    final response = await connection.sendMessageToServer(
      guid,
      'storageState',
      payload,
    );
    return APIRequestContextStorageStateResult.fromJson(
      response,
      connection: connection,
    );
  }
}

abstract class AndroidBase extends ChannelOwner {
  AndroidBase(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  Future<AndroidDevicesResult> channel_devices({
    String? host,
    bool? omitDriverInstall,
    int? port,
  }) async {
    final payload = <String, dynamic>{};
    if (host != null) payload['host'] = host;
    if (omitDriverInstall != null)
      payload['omitDriverInstall'] = omitDriverInstall;
    if (port != null) payload['port'] = port;
    final response = await connection.sendMessageToServer(
      guid,
      'devices',
      payload,
    );
    return AndroidDevicesResult.fromJson(response, connection: connection);
  }
}

abstract class AndroidDeviceBase extends ChannelOwner {
  AndroidDeviceBase(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  AndroidDeviceInitializer get typedInitializer =>
      AndroidDeviceInitializer.fromJson(
        super.initializer,
        connection: connection,
      );

  Future<void> channel_close() async {
    final response = await connection.sendMessageToServer(guid, 'close', {});
    return;
  }

  /// Connect to Web View
  Future<AndroidDeviceConnectToWebViewResult> channel_connectToWebView({
    required String socketName,
  }) async {
    final payload = <String, dynamic>{};
    payload['socketName'] = socketName;
    final response = await connection.sendMessageToServer(
      guid,
      'connectToWebView',
      payload,
    );
    return AndroidDeviceConnectToWebViewResult.fromJson(
      response,
      connection: connection,
    );
  }

  /// Drag
  Future<void> channel_drag({
    required AndroidSelector androidSelector,
    required Point dest,
    double? speed,
    required double timeout,
  }) async {
    final payload = <String, dynamic>{};
    payload['androidSelector'] = androidSelector.toJson();
    payload['dest'] = dest.toJson();
    if (speed != null) payload['speed'] = speed;
    payload['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'drag',
      payload,
    );
    return;
  }

  /// Fill "{text}"
  Future<void> channel_fill({
    required AndroidSelector androidSelector,
    required String text,
    required double timeout,
  }) async {
    final payload = <String, dynamic>{};
    payload['androidSelector'] = androidSelector.toJson();
    payload['text'] = text;
    payload['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'fill',
      payload,
    );
    return;
  }

  /// Fling
  Future<void> channel_fling({
    required AndroidSelector androidSelector,
    required AndroidDeviceFlingDirectionEnum direction,
    double? speed,
    required double timeout,
  }) async {
    final payload = <String, dynamic>{};
    payload['androidSelector'] = androidSelector.toJson();
    payload['direction'] = direction.value;
    if (speed != null) payload['speed'] = speed;
    payload['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'fling',
      payload,
    );
    return;
  }

  Future<AndroidDeviceInfoResult> channel_info({
    required AndroidSelector androidSelector,
  }) async {
    final payload = <String, dynamic>{};
    payload['androidSelector'] = androidSelector.toJson();
    final response = await connection.sendMessageToServer(
      guid,
      'info',
      payload,
    );
    return AndroidDeviceInfoResult.fromJson(response, connection: connection);
  }

  /// Drag
  Future<void> channel_inputDrag({
    required Point from,
    required int steps,
    required Point to,
  }) async {
    final payload = <String, dynamic>{};
    payload['from'] = from.toJson();
    payload['steps'] = steps;
    payload['to'] = to.toJson();
    final response = await connection.sendMessageToServer(
      guid,
      'inputDrag',
      payload,
    );
    return;
  }

  /// Press
  Future<void> channel_inputPress({required String key}) async {
    final payload = <String, dynamic>{};
    payload['key'] = key;
    final response = await connection.sendMessageToServer(
      guid,
      'inputPress',
      payload,
    );
    return;
  }

  /// Swipe
  Future<void> channel_inputSwipe({
    required List<Point> segments,
    required int steps,
  }) async {
    final payload = <String, dynamic>{};
    payload['segments'] = segments;
    payload['steps'] = steps;
    final response = await connection.sendMessageToServer(
      guid,
      'inputSwipe',
      payload,
    );
    return;
  }

  /// Tap
  Future<void> channel_inputTap({required Point point}) async {
    final payload = <String, dynamic>{};
    payload['point'] = point.toJson();
    final response = await connection.sendMessageToServer(
      guid,
      'inputTap',
      payload,
    );
    return;
  }

  /// Type
  Future<void> channel_inputType({required String text}) async {
    final payload = <String, dynamic>{};
    payload['text'] = text;
    final response = await connection.sendMessageToServer(
      guid,
      'inputType',
      payload,
    );
    return;
  }

  /// Install apk
  Future<void> channel_installApk({
    List<String>? args,
    required String file,
  }) async {
    final payload = <String, dynamic>{};
    if (args != null) payload['args'] = args;
    payload['file'] = file;
    final response = await connection.sendMessageToServer(
      guid,
      'installApk',
      payload,
    );
    return;
  }

  /// Launch browser
  Future<AndroidDeviceLaunchBrowserResult> channel_launchBrowser({
    required ContextOptions contextOptions,
    List<String>? args,
    String? pkg,
    AndroidDeviceLaunchBrowserProxy? proxy,
  }) async {
    final payload = <String, dynamic>{};
    payload.addAll(contextOptions.toJson() as Map<String, dynamic>);
    if (args != null) payload['args'] = args;
    if (pkg != null) payload['pkg'] = pkg;
    if (proxy != null) payload['proxy'] = proxy?.toJson();
    final response = await connection.sendMessageToServer(
      guid,
      'launchBrowser',
      payload,
    );
    return AndroidDeviceLaunchBrowserResult.fromJson(
      response,
      connection: connection,
    );
  }

  /// Long tap
  Future<void> channel_longTap({
    required AndroidSelector androidSelector,
    required double timeout,
  }) async {
    final payload = <String, dynamic>{};
    payload['androidSelector'] = androidSelector.toJson();
    payload['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'longTap',
      payload,
    );
    return;
  }

  /// Open app
  Future<AndroidDeviceOpenResult> channel_open({
    required String command,
  }) async {
    final payload = <String, dynamic>{};
    payload['command'] = command;
    final response = await connection.sendMessageToServer(
      guid,
      'open',
      payload,
    );
    return AndroidDeviceOpenResult.fromJson(response, connection: connection);
  }

  /// Pinch close
  Future<void> channel_pinchClose({
    required AndroidSelector androidSelector,
    required double percent,
    double? speed,
    required double timeout,
  }) async {
    final payload = <String, dynamic>{};
    payload['androidSelector'] = androidSelector.toJson();
    payload['percent'] = percent;
    if (speed != null) payload['speed'] = speed;
    payload['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'pinchClose',
      payload,
    );
    return;
  }

  /// Pinch open
  Future<void> channel_pinchOpen({
    required AndroidSelector androidSelector,
    required double percent,
    double? speed,
    required double timeout,
  }) async {
    final payload = <String, dynamic>{};
    payload['androidSelector'] = androidSelector.toJson();
    payload['percent'] = percent;
    if (speed != null) payload['speed'] = speed;
    payload['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'pinchOpen',
      payload,
    );
    return;
  }

  /// Push
  Future<void> channel_push({
    required String file,
    int? mode,
    required String path,
  }) async {
    final payload = <String, dynamic>{};
    payload['file'] = file;
    if (mode != null) payload['mode'] = mode;
    payload['path'] = path;
    final response = await connection.sendMessageToServer(
      guid,
      'push',
      payload,
    );
    return;
  }

  /// Screenshot
  Future<AndroidDeviceScreenshotResult> channel_screenshot() async {
    final response = await connection.sendMessageToServer(
      guid,
      'screenshot',
      {},
    );
    return AndroidDeviceScreenshotResult.fromJson(
      response,
      connection: connection,
    );
  }

  /// Scroll
  Future<void> channel_scroll({
    required AndroidSelector androidSelector,
    required AndroidDeviceScrollDirectionEnum direction,
    required double percent,
    double? speed,
    required double timeout,
  }) async {
    final payload = <String, dynamic>{};
    payload['androidSelector'] = androidSelector.toJson();
    payload['direction'] = direction.value;
    payload['percent'] = percent;
    if (speed != null) payload['speed'] = speed;
    payload['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'scroll',
      payload,
    );
    return;
  }

  /// Execute shell command
  Future<AndroidDeviceShellResult> channel_shell({
    required String command,
  }) async {
    final payload = <String, dynamic>{};
    payload['command'] = command;
    final response = await connection.sendMessageToServer(
      guid,
      'shell',
      payload,
    );
    return AndroidDeviceShellResult.fromJson(response, connection: connection);
  }

  /// Swipe
  Future<void> channel_swipe({
    required AndroidSelector androidSelector,
    required AndroidDeviceSwipeDirectionEnum direction,
    required double percent,
    double? speed,
    required double timeout,
  }) async {
    final payload = <String, dynamic>{};
    payload['androidSelector'] = androidSelector.toJson();
    payload['direction'] = direction.value;
    payload['percent'] = percent;
    if (speed != null) payload['speed'] = speed;
    payload['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'swipe',
      payload,
    );
    return;
  }

  /// Tap
  Future<void> channel_tap({
    required AndroidSelector androidSelector,
    double? duration,
    required double timeout,
  }) async {
    final payload = <String, dynamic>{};
    payload['androidSelector'] = androidSelector.toJson();
    if (duration != null) payload['duration'] = duration;
    payload['timeout'] = timeout;
    final response = await connection.sendMessageToServer(guid, 'tap', payload);
    return;
  }

  /// Wait
  Future<void> channel_wait({
    required AndroidSelector androidSelector,
    AndroidDeviceWaitStateEnum? state,
    required double timeout,
  }) async {
    final payload = <String, dynamic>{};
    payload['androidSelector'] = androidSelector.toJson();
    if (state != null) payload['state'] = state?.value;
    payload['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'wait',
      payload,
    );
    return;
  }
}

abstract class AndroidSocketBase extends ChannelOwner {
  AndroidSocketBase(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  Future<void> channel_close() async {
    final response = await connection.sendMessageToServer(guid, 'close', {});
    return;
  }

  Future<void> channel_write({required String data}) async {
    final payload = <String, dynamic>{};
    payload['data'] = data;
    final response = await connection.sendMessageToServer(
      guid,
      'write',
      payload,
    );
    return;
  }
}

abstract class ArtifactBase extends ChannelOwner {
  ArtifactBase(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  ArtifactInitializer get typedInitializer =>
      ArtifactInitializer.fromJson(super.initializer, connection: connection);

  Future<void> channel_cancel() async {
    final response = await connection.sendMessageToServer(guid, 'cancel', {});
    return;
  }

  Future<void> channel_delete() async {
    final response = await connection.sendMessageToServer(guid, 'delete', {});
    return;
  }

  Future<ArtifactFailureResult> channel_failure() async {
    final response = await connection.sendMessageToServer(guid, 'failure', {});
    return ArtifactFailureResult.fromJson(response, connection: connection);
  }

  Future<ArtifactPathAfterFinishedResult> channel_pathAfterFinished() async {
    final response = await connection.sendMessageToServer(
      guid,
      'pathAfterFinished',
      {},
    );
    return ArtifactPathAfterFinishedResult.fromJson(
      response,
      connection: connection,
    );
  }

  Future<void> channel_saveAs({required String path}) async {
    final payload = <String, dynamic>{};
    payload['path'] = path;
    final response = await connection.sendMessageToServer(
      guid,
      'saveAs',
      payload,
    );
    return;
  }

  Future<ArtifactSaveAsStreamResult> channel_saveAsStream() async {
    final response = await connection.sendMessageToServer(
      guid,
      'saveAsStream',
      {},
    );
    return ArtifactSaveAsStreamResult.fromJson(
      response,
      connection: connection,
    );
  }

  Future<ArtifactStreamResult> channel_stream() async {
    final response = await connection.sendMessageToServer(guid, 'stream', {});
    return ArtifactStreamResult.fromJson(response, connection: connection);
  }
}

abstract class BindingCallBase extends ChannelOwner {
  BindingCallBase(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  BindingCallInitializer get typedInitializer =>
      BindingCallInitializer.fromJson(
        super.initializer,
        connection: connection,
      );

  Future<void> channel_reject({required SerializedError error}) async {
    final payload = <String, dynamic>{};
    payload['error'] = error.toJson();
    final response = await connection.sendMessageToServer(
      guid,
      'reject',
      payload,
    );
    return;
  }

  Future<void> channel_resolve({required SerializedArgument result}) async {
    final payload = <String, dynamic>{};
    payload['result'] = result.toJson();
    final response = await connection.sendMessageToServer(
      guid,
      'resolve',
      payload,
    );
    return;
  }
}

abstract class BrowserBase extends ChannelOwner {
  BrowserBase(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  BrowserInitializer get typedInitializer =>
      BrowserInitializer.fromJson(super.initializer, connection: connection);

  /// Close browser
  Future<void> channel_close({String? reason}) async {
    final payload = <String, dynamic>{};
    if (reason != null) payload['reason'] = reason;
    final response = await connection.sendMessageToServer(
      guid,
      'close',
      payload,
    );
    return;
  }

  Future<BrowserDefaultUserAgentForTestResult>
  channel_defaultUserAgentForTest() async {
    final response = await connection.sendMessageToServer(
      guid,
      'defaultUserAgentForTest',
      {},
    );
    return BrowserDefaultUserAgentForTestResult.fromJson(
      response,
      connection: connection,
    );
  }

  Future<void> channel_disconnectFromReusedContext({
    required String reason,
  }) async {
    final payload = <String, dynamic>{};
    payload['reason'] = reason;
    final response = await connection.sendMessageToServer(
      guid,
      'disconnectFromReusedContext',
      payload,
    );
    return;
  }

  Future<void> channel_killForTests() async {
    final response = await connection.sendMessageToServer(
      guid,
      'killForTests',
      {},
    );
    return;
  }

  /// Create CDP session
  Future<BrowserNewBrowserCDPSessionResult>
  channel_newBrowserCDPSession() async {
    final response = await connection.sendMessageToServer(
      guid,
      'newBrowserCDPSession',
      {},
    );
    return BrowserNewBrowserCDPSessionResult.fromJson(
      response,
      connection: connection,
    );
  }

  /// Create context
  Future<BrowserNewContextResult> channel_newContext({
    required ContextOptions contextOptions,
    BrowserNewContextProxy? proxy,
    BrowserNewContextStorageState? storageState,
  }) async {
    final payload = <String, dynamic>{};
    payload.addAll(contextOptions.toJson() as Map<String, dynamic>);
    if (proxy != null) payload['proxy'] = proxy?.toJson();
    if (storageState != null) payload['storageState'] = storageState?.toJson();
    final response = await connection.sendMessageToServer(
      guid,
      'newContext',
      payload,
    );
    return BrowserNewContextResult.fromJson(response, connection: connection);
  }

  Future<BrowserNewContextForReuseResult> channel_newContextForReuse({
    required ContextOptions contextOptions,
    BrowserNewContextForReuseProxy? proxy,
    BrowserNewContextForReuseStorageState? storageState,
  }) async {
    final payload = <String, dynamic>{};
    payload.addAll(contextOptions.toJson() as Map<String, dynamic>);
    if (proxy != null) payload['proxy'] = proxy?.toJson();
    if (storageState != null) payload['storageState'] = storageState?.toJson();
    final response = await connection.sendMessageToServer(
      guid,
      'newContextForReuse',
      payload,
    );
    return BrowserNewContextForReuseResult.fromJson(
      response,
      connection: connection,
    );
  }

  /// Start server
  Future<BrowserStartServerResult> channel_startServer({
    String? host,
    JsonValue metadata,
    int? port,
    required String title,
    String? workspaceDir,
  }) async {
    final payload = <String, dynamic>{};
    if (host != null) payload['host'] = host;
    if (metadata != null) payload['metadata'] = metadata;
    if (port != null) payload['port'] = port;
    payload['title'] = title;
    if (workspaceDir != null) payload['workspaceDir'] = workspaceDir;
    final response = await connection.sendMessageToServer(
      guid,
      'startServer',
      payload,
    );
    return BrowserStartServerResult.fromJson(response, connection: connection);
  }

  /// Start browser tracing
  Future<void> channel_startTracing({
    List<String>? categories,
    PageBase? page,
    bool? screenshots,
  }) async {
    final payload = <String, dynamic>{};
    if (categories != null) payload['categories'] = categories;
    if (page != null) payload['page'] = {'guid': page.guid};
    if (screenshots != null) payload['screenshots'] = screenshots;
    final response = await connection.sendMessageToServer(
      guid,
      'startTracing',
      payload,
    );
    return;
  }

  /// Stop server
  Future<void> channel_stopServer() async {
    final response = await connection.sendMessageToServer(
      guid,
      'stopServer',
      {},
    );
    return;
  }

  /// Stop browser tracing
  Future<BrowserStopTracingResult> channel_stopTracing() async {
    final response = await connection.sendMessageToServer(
      guid,
      'stopTracing',
      {},
    );
    return BrowserStopTracingResult.fromJson(response, connection: connection);
  }
}

abstract class BrowserContextBase extends ChannelOwner {
  BrowserContextBase(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  BrowserContextInitializer get typedInitializer =>
      BrowserContextInitializer.fromJson(
        super.initializer,
        connection: connection,
      );

  /// Add cookies
  Future<void> channel_addCookies({
    required List<SetNetworkCookie> cookies,
  }) async {
    final payload = <String, dynamic>{};
    payload['cookies'] = cookies;
    final response = await connection.sendMessageToServer(
      guid,
      'addCookies',
      payload,
    );
    return;
  }

  /// Add init script
  Future<BrowserContextAddInitScriptResult> channel_addInitScript({
    required String source,
  }) async {
    final payload = <String, dynamic>{};
    payload['source'] = source;
    final response = await connection.sendMessageToServer(
      guid,
      'addInitScript',
      payload,
    );
    return BrowserContextAddInitScriptResult.fromJson(
      response,
      connection: connection,
    );
  }

  /// Clear cookies
  Future<void> channel_clearCookies({
    String? domain,
    String? domainRegexFlags,
    String? domainRegexSource,
    String? name,
    String? nameRegexFlags,
    String? nameRegexSource,
    String? path,
    String? pathRegexFlags,
    String? pathRegexSource,
  }) async {
    final payload = <String, dynamic>{};
    if (domain != null) payload['domain'] = domain;
    if (domainRegexFlags != null)
      payload['domainRegexFlags'] = domainRegexFlags;
    if (domainRegexSource != null)
      payload['domainRegexSource'] = domainRegexSource;
    if (name != null) payload['name'] = name;
    if (nameRegexFlags != null) payload['nameRegexFlags'] = nameRegexFlags;
    if (nameRegexSource != null) payload['nameRegexSource'] = nameRegexSource;
    if (path != null) payload['path'] = path;
    if (pathRegexFlags != null) payload['pathRegexFlags'] = pathRegexFlags;
    if (pathRegexSource != null) payload['pathRegexSource'] = pathRegexSource;
    final response = await connection.sendMessageToServer(
      guid,
      'clearCookies',
      payload,
    );
    return;
  }

  /// Clear permissions
  Future<void> channel_clearPermissions() async {
    final response = await connection.sendMessageToServer(
      guid,
      'clearPermissions',
      {},
    );
    return;
  }

  /// Fast forward clock "{ticksNumber|ticksString}"
  Future<void> channel_clockFastForward({
    double? ticksNumber,
    String? ticksString,
  }) async {
    final payload = <String, dynamic>{};
    if (ticksNumber != null) payload['ticksNumber'] = ticksNumber;
    if (ticksString != null) payload['ticksString'] = ticksString;
    final response = await connection.sendMessageToServer(
      guid,
      'clockFastForward',
      payload,
    );
    return;
  }

  /// Install clock "{timeNumber|timeString}"
  Future<void> channel_clockInstall({
    double? timeNumber,
    String? timeString,
  }) async {
    final payload = <String, dynamic>{};
    if (timeNumber != null) payload['timeNumber'] = timeNumber;
    if (timeString != null) payload['timeString'] = timeString;
    final response = await connection.sendMessageToServer(
      guid,
      'clockInstall',
      payload,
    );
    return;
  }

  /// Pause clock "{timeNumber|timeString}"
  Future<void> channel_clockPauseAt({
    double? timeNumber,
    String? timeString,
  }) async {
    final payload = <String, dynamic>{};
    if (timeNumber != null) payload['timeNumber'] = timeNumber;
    if (timeString != null) payload['timeString'] = timeString;
    final response = await connection.sendMessageToServer(
      guid,
      'clockPauseAt',
      payload,
    );
    return;
  }

  /// Resume clock
  Future<void> channel_clockResume() async {
    final response = await connection.sendMessageToServer(
      guid,
      'clockResume',
      {},
    );
    return;
  }

  /// Run clock "{ticksNumber|ticksString}"
  Future<void> channel_clockRunFor({
    double? ticksNumber,
    String? ticksString,
  }) async {
    final payload = <String, dynamic>{};
    if (ticksNumber != null) payload['ticksNumber'] = ticksNumber;
    if (ticksString != null) payload['ticksString'] = ticksString;
    final response = await connection.sendMessageToServer(
      guid,
      'clockRunFor',
      payload,
    );
    return;
  }

  /// Set fixed time "{timeNumber|timeString}"
  Future<void> channel_clockSetFixedTime({
    double? timeNumber,
    String? timeString,
  }) async {
    final payload = <String, dynamic>{};
    if (timeNumber != null) payload['timeNumber'] = timeNumber;
    if (timeString != null) payload['timeString'] = timeString;
    final response = await connection.sendMessageToServer(
      guid,
      'clockSetFixedTime',
      payload,
    );
    return;
  }

  /// Set system time "{timeNumber|timeString}"
  Future<void> channel_clockSetSystemTime({
    double? timeNumber,
    String? timeString,
  }) async {
    final payload = <String, dynamic>{};
    if (timeNumber != null) payload['timeNumber'] = timeNumber;
    if (timeString != null) payload['timeString'] = timeString;
    final response = await connection.sendMessageToServer(
      guid,
      'clockSetSystemTime',
      payload,
    );
    return;
  }

  /// Close context
  Future<void> channel_close({String? reason}) async {
    final payload = <String, dynamic>{};
    if (reason != null) payload['reason'] = reason;
    final response = await connection.sendMessageToServer(
      guid,
      'close',
      payload,
    );
    return;
  }

  /// Get cookies
  Future<BrowserContextCookiesResult> channel_cookies({
    required List<String> urls,
  }) async {
    final payload = <String, dynamic>{};
    payload['urls'] = urls;
    final response = await connection.sendMessageToServer(
      guid,
      'cookies',
      payload,
    );
    return BrowserContextCookiesResult.fromJson(
      response,
      connection: connection,
    );
  }

  Future<BrowserContextCreateTempFilesResult> channel_createTempFiles({
    required List<BrowserContextCreateTempFilesItemsItems> items,
    String? rootDirName,
  }) async {
    final payload = <String, dynamic>{};
    payload['items'] = items;
    if (rootDirName != null) payload['rootDirName'] = rootDirName;
    final response = await connection.sendMessageToServer(
      guid,
      'createTempFiles',
      payload,
    );
    return BrowserContextCreateTempFilesResult.fromJson(
      response,
      connection: connection,
    );
  }

  /// Create virtual credential for "{rpId}"
  Future<BrowserContextCredentialsCreateResult> channel_credentialsCreate({
    String? id,
    String? privateKey,
    String? publicKey,
    required String rpId,
    String? userHandle,
  }) async {
    final payload = <String, dynamic>{};
    if (id != null) payload['id'] = id;
    if (privateKey != null) payload['privateKey'] = privateKey;
    if (publicKey != null) payload['publicKey'] = publicKey;
    payload['rpId'] = rpId;
    if (userHandle != null) payload['userHandle'] = userHandle;
    final response = await connection.sendMessageToServer(
      guid,
      'credentialsCreate',
      payload,
    );
    return BrowserContextCredentialsCreateResult.fromJson(
      response,
      connection: connection,
    );
  }

  /// Delete virtual credential
  Future<void> channel_credentialsDelete({required String id}) async {
    final payload = <String, dynamic>{};
    payload['id'] = id;
    final response = await connection.sendMessageToServer(
      guid,
      'credentialsDelete',
      payload,
    );
    return;
  }

  /// Get virtual credentials
  Future<BrowserContextCredentialsGetResult> channel_credentialsGet({
    String? id,
    String? rpId,
  }) async {
    final payload = <String, dynamic>{};
    if (id != null) payload['id'] = id;
    if (rpId != null) payload['rpId'] = rpId;
    final response = await connection.sendMessageToServer(
      guid,
      'credentialsGet',
      payload,
    );
    return BrowserContextCredentialsGetResult.fromJson(
      response,
      connection: connection,
    );
  }

  /// Install virtual WebAuthn authenticator
  Future<void> channel_credentialsInstall() async {
    final response = await connection.sendMessageToServer(
      guid,
      'credentialsInstall',
      {},
    );
    return;
  }

  Future<void> channel_disableRecorder() async {
    final response = await connection.sendMessageToServer(
      guid,
      'disableRecorder',
      {},
    );
    return;
  }

  Future<void> channel_enableRecorder({
    JsonValue contextOptions,
    String? device,
    bool? handleSIGINT,
    String? language,
    JsonValue launchOptions,
    BrowserContextEnableRecorderModeEnum? mode,
    bool? omitCallTracking,
    String? outputFile,
    bool? pauseOnNextStatement,
    BrowserContextEnableRecorderRecorderModeEnum? recorderMode,
    String? saveStorage,
    String? testIdAttributeName,
  }) async {
    final payload = <String, dynamic>{};
    if (contextOptions != null) payload['contextOptions'] = contextOptions;
    if (device != null) payload['device'] = device;
    if (handleSIGINT != null) payload['handleSIGINT'] = handleSIGINT;
    if (language != null) payload['language'] = language;
    if (launchOptions != null) payload['launchOptions'] = launchOptions;
    if (mode != null) payload['mode'] = mode?.value;
    if (omitCallTracking != null)
      payload['omitCallTracking'] = omitCallTracking;
    if (outputFile != null) payload['outputFile'] = outputFile;
    if (pauseOnNextStatement != null)
      payload['pauseOnNextStatement'] = pauseOnNextStatement;
    if (recorderMode != null) payload['recorderMode'] = recorderMode?.value;
    if (saveStorage != null) payload['saveStorage'] = saveStorage;
    if (testIdAttributeName != null)
      payload['testIdAttributeName'] = testIdAttributeName;
    final response = await connection.sendMessageToServer(
      guid,
      'enableRecorder',
      payload,
    );
    return;
  }

  /// Expose binding
  Future<BrowserContextExposeBindingResult> channel_exposeBinding({
    required String name,
  }) async {
    final payload = <String, dynamic>{};
    payload['name'] = name;
    final response = await connection.sendMessageToServer(
      guid,
      'exposeBinding',
      payload,
    );
    return BrowserContextExposeBindingResult.fromJson(
      response,
      connection: connection,
    );
  }

  Future<void> channel_exposeConsoleApi() async {
    final response = await connection.sendMessageToServer(
      guid,
      'exposeConsoleApi',
      {},
    );
    return;
  }

  /// Grant permissions
  Future<void> channel_grantPermissions({
    String? origin,
    required List<String> permissions,
  }) async {
    final payload = <String, dynamic>{};
    if (origin != null) payload['origin'] = origin;
    payload['permissions'] = permissions;
    final response = await connection.sendMessageToServer(
      guid,
      'grantPermissions',
      payload,
    );
    return;
  }

  /// Create CDP session
  Future<BrowserContextNewCDPSessionResult> channel_newCDPSession({
    FrameBase? frame,
    PageBase? page,
  }) async {
    final payload = <String, dynamic>{};
    if (frame != null) payload['frame'] = {'guid': frame.guid};
    if (page != null) payload['page'] = {'guid': page.guid};
    final response = await connection.sendMessageToServer(
      guid,
      'newCDPSession',
      payload,
    );
    return BrowserContextNewCDPSessionResult.fromJson(
      response,
      connection: connection,
    );
  }

  /// Create page
  Future<BrowserContextNewPageResult> channel_newPage() async {
    final response = await connection.sendMessageToServer(guid, 'newPage', {});
    return BrowserContextNewPageResult.fromJson(
      response,
      connection: connection,
    );
  }

  /// Pause
  Future<void> channel_pause() async {
    final response = await connection.sendMessageToServer(guid, 'pause', {});
    return;
  }

  Future<void> channel_registerSelectorEngine({
    required SelectorEngine selectorEngine,
  }) async {
    final payload = <String, dynamic>{};
    payload['selectorEngine'] = selectorEngine.toJson();
    final response = await connection.sendMessageToServer(
      guid,
      'registerSelectorEngine',
      payload,
    );
    return;
  }

  /// Set extra HTTP headers
  Future<void> channel_setExtraHTTPHeaders({
    required List<NameValue> headers,
  }) async {
    final payload = <String, dynamic>{};
    payload['headers'] = headers;
    final response = await connection.sendMessageToServer(
      guid,
      'setExtraHTTPHeaders',
      payload,
    );
    return;
  }

  /// Set geolocation
  Future<void> channel_setGeolocation({
    BrowserContextSetGeolocationGeolocation? geolocation,
  }) async {
    final payload = <String, dynamic>{};
    if (geolocation != null) payload['geolocation'] = geolocation?.toJson();
    final response = await connection.sendMessageToServer(
      guid,
      'setGeolocation',
      payload,
    );
    return;
  }

  /// Set HTTP credentials
  Future<void> channel_setHTTPCredentials({
    BrowserContextSetHTTPCredentialsHttpCredentials? httpCredentials,
  }) async {
    final payload = <String, dynamic>{};
    if (httpCredentials != null)
      payload['httpCredentials'] = httpCredentials?.toJson();
    final response = await connection.sendMessageToServer(
      guid,
      'setHTTPCredentials',
      payload,
    );
    return;
  }

  /// Route requests
  Future<void> channel_setNetworkInterceptionPatterns({
    required List<BrowserContextSetNetworkInterceptionPatternsPatternsItems>
    patterns,
  }) async {
    final payload = <String, dynamic>{};
    payload['patterns'] = patterns;
    final response = await connection.sendMessageToServer(
      guid,
      'setNetworkInterceptionPatterns',
      payload,
    );
    return;
  }

  /// Set offline mode
  Future<void> channel_setOffline({required bool offline}) async {
    final payload = <String, dynamic>{};
    payload['offline'] = offline;
    final response = await connection.sendMessageToServer(
      guid,
      'setOffline',
      payload,
    );
    return;
  }

  /// Set storage state
  Future<void> channel_setStorageState({
    BrowserContextSetStorageStateStorageState? storageState,
  }) async {
    final payload = <String, dynamic>{};
    if (storageState != null) payload['storageState'] = storageState?.toJson();
    final response = await connection.sendMessageToServer(
      guid,
      'setStorageState',
      payload,
    );
    return;
  }

  Future<void> channel_setTestIdAttributeName({
    required String testIdAttributeName,
  }) async {
    final payload = <String, dynamic>{};
    payload['testIdAttributeName'] = testIdAttributeName;
    final response = await connection.sendMessageToServer(
      guid,
      'setTestIdAttributeName',
      payload,
    );
    return;
  }

  /// Route WebSockets
  Future<void> channel_setWebSocketInterceptionPatterns({
    required List<BrowserContextSetWebSocketInterceptionPatternsPatternsItems>
    patterns,
  }) async {
    final payload = <String, dynamic>{};
    payload['patterns'] = patterns;
    final response = await connection.sendMessageToServer(
      guid,
      'setWebSocketInterceptionPatterns',
      payload,
    );
    return;
  }

  /// Get storage state
  Future<BrowserContextStorageStateResult> channel_storageState({
    bool? indexedDB,
  }) async {
    final payload = <String, dynamic>{};
    if (indexedDB != null) payload['indexedDB'] = indexedDB;
    final response = await connection.sendMessageToServer(
      guid,
      'storageState',
      payload,
    );
    return BrowserContextStorageStateResult.fromJson(
      response,
      connection: connection,
    );
  }

  Future<void> channel_updateSubscription({
    required bool enabled,
    required BrowserContextUpdateSubscriptionEventEnum event,
  }) async {
    final payload = <String, dynamic>{};
    payload['enabled'] = enabled;
    payload['event'] = event.value;
    final response = await connection.sendMessageToServer(
      guid,
      'updateSubscription',
      payload,
    );
    return;
  }
}

abstract class BrowserTypeBase extends ChannelOwner {
  BrowserTypeBase(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  BrowserTypeInitializer get typedInitializer =>
      BrowserTypeInitializer.fromJson(
        super.initializer,
        connection: connection,
      );

  /// Connect over CDP
  Future<BrowserTypeConnectOverCDPResult> channel_connectOverCDP({
    String? artifactsDir,
    String? endpointURL,
    List<NameValue>? headers,
    bool? isLocal,
    bool? noDefaults,
    double? slowMo,
    required double timeout,
    String? transport,
  }) async {
    final payload = <String, dynamic>{};
    if (artifactsDir != null) payload['artifactsDir'] = artifactsDir;
    if (endpointURL != null) payload['endpointURL'] = endpointURL;
    if (headers != null) payload['headers'] = headers;
    if (isLocal != null) payload['isLocal'] = isLocal;
    if (noDefaults != null) payload['noDefaults'] = noDefaults;
    if (slowMo != null) payload['slowMo'] = slowMo;
    payload['timeout'] = timeout;
    if (transport != null) payload['transport'] = transport;
    final response = await connection.sendMessageToServer(
      guid,
      'connectOverCDP',
      payload,
    );
    return BrowserTypeConnectOverCDPResult.fromJson(
      response,
      connection: connection,
    );
  }

  /// Connect to worker
  Future<BrowserTypeConnectToWorkerResult> channel_connectToWorker({
    required String endpoint,
    required double timeout,
  }) async {
    final payload = <String, dynamic>{};
    payload['endpoint'] = endpoint;
    payload['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'connectToWorker',
      payload,
    );
    return BrowserTypeConnectToWorkerResult.fromJson(
      response,
      connection: connection,
    );
  }

  /// Launch browser
  Future<BrowserTypeLaunchResult> channel_launch({
    required LaunchOptions launchOptions,
    double? slowMo,
  }) async {
    final payload = <String, dynamic>{};
    payload.addAll(launchOptions.toJson() as Map<String, dynamic>);
    if (slowMo != null) payload['slowMo'] = slowMo;
    final response = await connection.sendMessageToServer(
      guid,
      'launch',
      payload,
    );
    return BrowserTypeLaunchResult.fromJson(response, connection: connection);
  }

  /// Launch persistent context
  Future<BrowserTypeLaunchPersistentContextResult>
  channel_launchPersistentContext({
    required LaunchOptions launchOptions,
    required ContextOptions contextOptions,
    double? slowMo,
    required String userDataDir,
  }) async {
    final payload = <String, dynamic>{};
    payload.addAll(launchOptions.toJson() as Map<String, dynamic>);
    payload.addAll(contextOptions.toJson() as Map<String, dynamic>);
    if (slowMo != null) payload['slowMo'] = slowMo;
    payload['userDataDir'] = userDataDir;
    final response = await connection.sendMessageToServer(
      guid,
      'launchPersistentContext',
      payload,
    );
    return BrowserTypeLaunchPersistentContextResult.fromJson(
      response,
      connection: connection,
    );
  }
}

abstract class CDPSessionBase extends ChannelOwner {
  CDPSessionBase(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  /// Detach CDP session
  Future<void> channel_detach() async {
    final response = await connection.sendMessageToServer(guid, 'detach', {});
    return;
  }

  /// Send CDP command
  Future<CDPSessionSendResult> channel_send({
    required String method,
    JsonValue params,
  }) async {
    final payload = <String, dynamic>{};
    payload['method'] = method;
    if (params != null) payload['params'] = params;
    final response = await connection.sendMessageToServer(
      guid,
      'send',
      payload,
    );
    return CDPSessionSendResult.fromJson(response, connection: connection);
  }
}

abstract class DebugControllerBase extends ChannelOwner {
  DebugControllerBase(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  Future<void> channel_hideHighlight() async {
    final response = await connection.sendMessageToServer(
      guid,
      'hideHighlight',
      {},
    );
    return;
  }

  Future<void> channel_highlight({
    String? ariaTemplate,
    Pattern? selector,
  }) async {
    final payload = <String, dynamic>{};
    if (ariaTemplate != null) payload['ariaTemplate'] = ariaTemplate;
    if (selector != null) payload['selector'] = selector?.toString();
    final response = await connection.sendMessageToServer(
      guid,
      'highlight',
      payload,
    );
    return;
  }

  Future<void> channel_initialize({
    required String codegenId,
    required SDKLanguage sdkLanguage,
  }) async {
    final payload = <String, dynamic>{};
    payload['codegenId'] = codegenId;
    payload['sdkLanguage'] = sdkLanguage.value;
    final response = await connection.sendMessageToServer(
      guid,
      'initialize',
      payload,
    );
    return;
  }

  Future<void> channel_kill() async {
    final response = await connection.sendMessageToServer(guid, 'kill', {});
    return;
  }

  Future<void> channel_resume() async {
    final response = await connection.sendMessageToServer(guid, 'resume', {});
    return;
  }

  Future<void> channel_setRecorderMode({
    bool? generateAutoExpect,
    required DebugControllerSetRecorderModeModeEnum mode,
    String? testIdAttributeName,
  }) async {
    final payload = <String, dynamic>{};
    if (generateAutoExpect != null)
      payload['generateAutoExpect'] = generateAutoExpect;
    payload['mode'] = mode.value;
    if (testIdAttributeName != null)
      payload['testIdAttributeName'] = testIdAttributeName;
    final response = await connection.sendMessageToServer(
      guid,
      'setRecorderMode',
      payload,
    );
    return;
  }

  Future<void> channel_setReportStateChanged({required bool enabled}) async {
    final payload = <String, dynamic>{};
    payload['enabled'] = enabled;
    final response = await connection.sendMessageToServer(
      guid,
      'setReportStateChanged',
      payload,
    );
    return;
  }
}

abstract class DebuggerBase extends ChannelOwner {
  DebuggerBase(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  /// Step to next call
  Future<void> channel_next() async {
    final response = await connection.sendMessageToServer(guid, 'next', {});
    return;
  }

  /// Pause on next call
  Future<void> channel_requestPause() async {
    final response = await connection.sendMessageToServer(
      guid,
      'requestPause',
      {},
    );
    return;
  }

  /// Resume
  Future<void> channel_resume() async {
    final response = await connection.sendMessageToServer(guid, 'resume', {});
    return;
  }

  /// Run to location
  Future<void> channel_runTo({required DebuggerRunToLocation location}) async {
    final payload = <String, dynamic>{};
    payload['location'] = location.toJson();
    final response = await connection.sendMessageToServer(
      guid,
      'runTo',
      payload,
    );
    return;
  }
}

abstract class DialogBase extends ChannelOwner {
  DialogBase(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  DialogInitializer get typedInitializer =>
      DialogInitializer.fromJson(super.initializer, connection: connection);

  /// Accept dialog
  Future<void> channel_accept({String? promptText}) async {
    final payload = <String, dynamic>{};
    if (promptText != null) payload['promptText'] = promptText;
    final response = await connection.sendMessageToServer(
      guid,
      'accept',
      payload,
    );
    return;
  }

  /// Dismiss dialog
  Future<void> channel_dismiss() async {
    final response = await connection.sendMessageToServer(guid, 'dismiss', {});
    return;
  }
}

abstract class DisposableBase extends ChannelOwner {
  DisposableBase(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  Future<void> channel_dispose() async {
    final response = await connection.sendMessageToServer(guid, 'dispose', {});
    return;
  }
}

abstract class ElectronBase extends ChannelOwner {
  ElectronBase(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  /// Launch electron
  Future<ElectronLaunchResult> channel_launch({
    ElectronLaunchAcceptDownloadsEnum? acceptDownloads,
    List<String>? args,
    String? artifactsDir,
    bool? bypassCSP,
    bool? chromiumSandbox,
    ElectronLaunchColorSchemeEnum? colorScheme,
    String? cwd,
    List<NameValue>? env,
    String? executablePath,
    List<NameValue>? extraHTTPHeaders,
    ElectronLaunchGeolocation? geolocation,
    ElectronLaunchHttpCredentials? httpCredentials,
    bool? ignoreHTTPSErrors,
    String? locale,
    bool? offline,
    ElectronLaunchRecordVideo? recordVideo,
    List<SelectorEngine>? selectorEngines,
    bool? strictSelectors,
    String? testIdAttributeName,
    required double timeout,
    String? timezoneId,
    String? tracesDir,
  }) async {
    final payload = <String, dynamic>{};
    if (acceptDownloads != null)
      payload['acceptDownloads'] = acceptDownloads?.value;
    if (args != null) payload['args'] = args;
    if (artifactsDir != null) payload['artifactsDir'] = artifactsDir;
    if (bypassCSP != null) payload['bypassCSP'] = bypassCSP;
    if (chromiumSandbox != null) payload['chromiumSandbox'] = chromiumSandbox;
    if (colorScheme != null) payload['colorScheme'] = colorScheme?.value;
    if (cwd != null) payload['cwd'] = cwd;
    if (env != null) payload['env'] = env;
    if (executablePath != null) payload['executablePath'] = executablePath;
    if (extraHTTPHeaders != null)
      payload['extraHTTPHeaders'] = extraHTTPHeaders;
    if (geolocation != null) payload['geolocation'] = geolocation?.toJson();
    if (httpCredentials != null)
      payload['httpCredentials'] = httpCredentials?.toJson();
    if (ignoreHTTPSErrors != null)
      payload['ignoreHTTPSErrors'] = ignoreHTTPSErrors;
    if (locale != null) payload['locale'] = locale;
    if (offline != null) payload['offline'] = offline;
    if (recordVideo != null) payload['recordVideo'] = recordVideo?.toJson();
    if (selectorEngines != null) payload['selectorEngines'] = selectorEngines;
    if (strictSelectors != null) payload['strictSelectors'] = strictSelectors;
    if (testIdAttributeName != null)
      payload['testIdAttributeName'] = testIdAttributeName;
    payload['timeout'] = timeout;
    if (timezoneId != null) payload['timezoneId'] = timezoneId;
    if (tracesDir != null) payload['tracesDir'] = tracesDir;
    final response = await connection.sendMessageToServer(
      guid,
      'launch',
      payload,
    );
    return ElectronLaunchResult.fromJson(response, connection: connection);
  }
}

abstract class ElectronApplicationBase extends ChannelOwner {
  ElectronApplicationBase(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  ElectronApplicationInitializer get typedInitializer =>
      ElectronApplicationInitializer.fromJson(
        super.initializer,
        connection: connection,
      );

  Future<ElectronApplicationBrowserWindowResult> channel_browserWindow({
    required PageBase page,
  }) async {
    final payload = <String, dynamic>{};
    payload['page'] = {'guid': page.guid};
    final response = await connection.sendMessageToServer(
      guid,
      'browserWindow',
      payload,
    );
    return ElectronApplicationBrowserWindowResult.fromJson(
      response,
      connection: connection,
    );
  }

  /// Evaluate
  Future<ElectronApplicationEvaluateExpressionResult>
  channel_evaluateExpression({
    required SerializedArgument arg,
    required String expression,
    bool? isFunction,
  }) async {
    final payload = <String, dynamic>{};
    payload['arg'] = arg.toJson();
    payload['expression'] = expression;
    if (isFunction != null) payload['isFunction'] = isFunction;
    final response = await connection.sendMessageToServer(
      guid,
      'evaluateExpression',
      payload,
    );
    return ElectronApplicationEvaluateExpressionResult.fromJson(
      response,
      connection: connection,
    );
  }

  /// Evaluate
  Future<ElectronApplicationEvaluateExpressionHandleResult>
  channel_evaluateExpressionHandle({
    required SerializedArgument arg,
    required String expression,
    bool? isFunction,
  }) async {
    final payload = <String, dynamic>{};
    payload['arg'] = arg.toJson();
    payload['expression'] = expression;
    if (isFunction != null) payload['isFunction'] = isFunction;
    final response = await connection.sendMessageToServer(
      guid,
      'evaluateExpressionHandle',
      payload,
    );
    return ElectronApplicationEvaluateExpressionHandleResult.fromJson(
      response,
      connection: connection,
    );
  }

  Future<void> channel_updateSubscription({
    required bool enabled,
    required ElectronApplicationUpdateSubscriptionEventEnum event,
  }) async {
    final payload = <String, dynamic>{};
    payload['enabled'] = enabled;
    payload['event'] = event.value;
    final response = await connection.sendMessageToServer(
      guid,
      'updateSubscription',
      payload,
    );
    return;
  }
}

abstract class ElementHandleBase extends JSHandleBase {
  ElementHandleBase(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  /// Get bounding box
  Future<ElementHandleBoundingBoxResult> channel_boundingBox() async {
    final response = await connection.sendMessageToServer(
      guid,
      'boundingBox',
      {},
    );
    return ElementHandleBoundingBoxResult.fromJson(
      response,
      connection: connection,
    );
  }

  /// Check
  Future<void> channel_check({
    bool? force,
    Point? position,
    required double timeout,
    bool? trial,
  }) async {
    final payload = <String, dynamic>{};
    if (force != null) payload['force'] = force;
    if (position != null) payload['position'] = position?.toJson();
    payload['timeout'] = timeout;
    if (trial != null) payload['trial'] = trial;
    final response = await connection.sendMessageToServer(
      guid,
      'check',
      payload,
    );
    return;
  }

  /// Click
  Future<void> channel_click({
    ElementHandleClickButtonEnum? button,
    int? clickCount,
    double? delay,
    bool? force,
    List<ElementHandleClickModifiersEnum>? modifiers,
    bool? noWaitAfter,
    Point? position,
    int? steps,
    required double timeout,
    bool? trial,
  }) async {
    final payload = <String, dynamic>{};
    if (button != null) payload['button'] = button?.value;
    if (clickCount != null) payload['clickCount'] = clickCount;
    if (delay != null) payload['delay'] = delay;
    if (force != null) payload['force'] = force;
    if (modifiers != null) payload['modifiers'] = modifiers;
    if (noWaitAfter != null) payload['noWaitAfter'] = noWaitAfter;
    if (position != null) payload['position'] = position?.toJson();
    if (steps != null) payload['steps'] = steps;
    payload['timeout'] = timeout;
    if (trial != null) payload['trial'] = trial;
    final response = await connection.sendMessageToServer(
      guid,
      'click',
      payload,
    );
    return;
  }

  /// Get content frame
  Future<ElementHandleContentFrameResult> channel_contentFrame() async {
    final response = await connection.sendMessageToServer(
      guid,
      'contentFrame',
      {},
    );
    return ElementHandleContentFrameResult.fromJson(
      response,
      connection: connection,
    );
  }

  /// Double click
  Future<void> channel_dblclick({
    ElementHandleDblclickButtonEnum? button,
    double? delay,
    bool? force,
    List<ElementHandleDblclickModifiersEnum>? modifiers,
    Point? position,
    int? steps,
    required double timeout,
    bool? trial,
  }) async {
    final payload = <String, dynamic>{};
    if (button != null) payload['button'] = button?.value;
    if (delay != null) payload['delay'] = delay;
    if (force != null) payload['force'] = force;
    if (modifiers != null) payload['modifiers'] = modifiers;
    if (position != null) payload['position'] = position?.toJson();
    if (steps != null) payload['steps'] = steps;
    payload['timeout'] = timeout;
    if (trial != null) payload['trial'] = trial;
    final response = await connection.sendMessageToServer(
      guid,
      'dblclick',
      payload,
    );
    return;
  }

  /// Dispatch event
  Future<void> channel_dispatchEvent({
    required SerializedArgument eventInit,
    required String type,
  }) async {
    final payload = <String, dynamic>{};
    payload['eventInit'] = eventInit.toJson();
    payload['type'] = type;
    final response = await connection.sendMessageToServer(
      guid,
      'dispatchEvent',
      payload,
    );
    return;
  }

  /// Evaluate
  Future<ElementHandleEvalOnSelectorResult> channel_evalOnSelector({
    required SerializedArgument arg,
    required String expression,
    bool? isFunction,
    required Pattern selector,
    bool? strict,
  }) async {
    final payload = <String, dynamic>{};
    payload['arg'] = arg.toJson();
    payload['expression'] = expression;
    if (isFunction != null) payload['isFunction'] = isFunction;
    payload['selector'] = selector.toString();
    if (strict != null) payload['strict'] = strict;
    final response = await connection.sendMessageToServer(
      guid,
      'evalOnSelector',
      payload,
    );
    return ElementHandleEvalOnSelectorResult.fromJson(
      response,
      connection: connection,
    );
  }

  /// Evaluate
  Future<ElementHandleEvalOnSelectorAllResult> channel_evalOnSelectorAll({
    required SerializedArgument arg,
    required String expression,
    bool? isFunction,
    required Pattern selector,
  }) async {
    final payload = <String, dynamic>{};
    payload['arg'] = arg.toJson();
    payload['expression'] = expression;
    if (isFunction != null) payload['isFunction'] = isFunction;
    payload['selector'] = selector.toString();
    final response = await connection.sendMessageToServer(
      guid,
      'evalOnSelectorAll',
      payload,
    );
    return ElementHandleEvalOnSelectorAllResult.fromJson(
      response,
      connection: connection,
    );
  }

  /// Fill "{value}"
  Future<void> channel_fill({
    bool? force,
    required double timeout,
    required String value,
  }) async {
    final payload = <String, dynamic>{};
    if (force != null) payload['force'] = force;
    payload['timeout'] = timeout;
    payload['value'] = value;
    final response = await connection.sendMessageToServer(
      guid,
      'fill',
      payload,
    );
    return;
  }

  /// Focus
  Future<void> channel_focus() async {
    final response = await connection.sendMessageToServer(guid, 'focus', {});
    return;
  }

  /// Get attribute
  Future<ElementHandleGetAttributeResult> channel_getAttribute({
    required String name,
  }) async {
    final payload = <String, dynamic>{};
    payload['name'] = name;
    final response = await connection.sendMessageToServer(
      guid,
      'getAttribute',
      payload,
    );
    return ElementHandleGetAttributeResult.fromJson(
      response,
      connection: connection,
    );
  }

  /// Hover
  Future<void> channel_hover({
    bool? force,
    List<ElementHandleHoverModifiersEnum>? modifiers,
    Point? position,
    required double timeout,
    bool? trial,
  }) async {
    final payload = <String, dynamic>{};
    if (force != null) payload['force'] = force;
    if (modifiers != null) payload['modifiers'] = modifiers;
    if (position != null) payload['position'] = position?.toJson();
    payload['timeout'] = timeout;
    if (trial != null) payload['trial'] = trial;
    final response = await connection.sendMessageToServer(
      guid,
      'hover',
      payload,
    );
    return;
  }

  /// Get HTML
  Future<ElementHandleInnerHTMLResult> channel_innerHTML() async {
    final response = await connection.sendMessageToServer(
      guid,
      'innerHTML',
      {},
    );
    return ElementHandleInnerHTMLResult.fromJson(
      response,
      connection: connection,
    );
  }

  /// Get inner text
  Future<ElementHandleInnerTextResult> channel_innerText() async {
    final response = await connection.sendMessageToServer(
      guid,
      'innerText',
      {},
    );
    return ElementHandleInnerTextResult.fromJson(
      response,
      connection: connection,
    );
  }

  /// Get input value
  Future<ElementHandleInputValueResult> channel_inputValue() async {
    final response = await connection.sendMessageToServer(
      guid,
      'inputValue',
      {},
    );
    return ElementHandleInputValueResult.fromJson(
      response,
      connection: connection,
    );
  }

  /// Is checked
  Future<ElementHandleIsCheckedResult> channel_isChecked() async {
    final response = await connection.sendMessageToServer(
      guid,
      'isChecked',
      {},
    );
    return ElementHandleIsCheckedResult.fromJson(
      response,
      connection: connection,
    );
  }

  /// Is disabled
  Future<ElementHandleIsDisabledResult> channel_isDisabled() async {
    final response = await connection.sendMessageToServer(
      guid,
      'isDisabled',
      {},
    );
    return ElementHandleIsDisabledResult.fromJson(
      response,
      connection: connection,
    );
  }

  /// Is editable
  Future<ElementHandleIsEditableResult> channel_isEditable() async {
    final response = await connection.sendMessageToServer(
      guid,
      'isEditable',
      {},
    );
    return ElementHandleIsEditableResult.fromJson(
      response,
      connection: connection,
    );
  }

  /// Is enabled
  Future<ElementHandleIsEnabledResult> channel_isEnabled() async {
    final response = await connection.sendMessageToServer(
      guid,
      'isEnabled',
      {},
    );
    return ElementHandleIsEnabledResult.fromJson(
      response,
      connection: connection,
    );
  }

  /// Is hidden
  Future<ElementHandleIsHiddenResult> channel_isHidden() async {
    final response = await connection.sendMessageToServer(guid, 'isHidden', {});
    return ElementHandleIsHiddenResult.fromJson(
      response,
      connection: connection,
    );
  }

  /// Is visible
  Future<ElementHandleIsVisibleResult> channel_isVisible() async {
    final response = await connection.sendMessageToServer(
      guid,
      'isVisible',
      {},
    );
    return ElementHandleIsVisibleResult.fromJson(
      response,
      connection: connection,
    );
  }

  /// Get owner frame
  Future<ElementHandleOwnerFrameResult> channel_ownerFrame() async {
    final response = await connection.sendMessageToServer(
      guid,
      'ownerFrame',
      {},
    );
    return ElementHandleOwnerFrameResult.fromJson(
      response,
      connection: connection,
    );
  }

  /// Press "{key}"
  Future<void> channel_press({
    double? delay,
    required String key,
    bool? noWaitAfter,
    required double timeout,
  }) async {
    final payload = <String, dynamic>{};
    if (delay != null) payload['delay'] = delay;
    payload['key'] = key;
    if (noWaitAfter != null) payload['noWaitAfter'] = noWaitAfter;
    payload['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'press',
      payload,
    );
    return;
  }

  /// Query selector
  Future<ElementHandleQuerySelectorResult> channel_querySelector({
    required Pattern selector,
    bool? strict,
  }) async {
    final payload = <String, dynamic>{};
    payload['selector'] = selector.toString();
    if (strict != null) payload['strict'] = strict;
    final response = await connection.sendMessageToServer(
      guid,
      'querySelector',
      payload,
    );
    return ElementHandleQuerySelectorResult.fromJson(
      response,
      connection: connection,
    );
  }

  /// Query selector all
  Future<ElementHandleQuerySelectorAllResult> channel_querySelectorAll({
    required Pattern selector,
  }) async {
    final payload = <String, dynamic>{};
    payload['selector'] = selector.toString();
    final response = await connection.sendMessageToServer(
      guid,
      'querySelectorAll',
      payload,
    );
    return ElementHandleQuerySelectorAllResult.fromJson(
      response,
      connection: connection,
    );
  }

  /// Screenshot
  Future<ElementHandleScreenshotResult> channel_screenshot({
    required CommonScreenshotOptions commonScreenshotOptions,
    int? quality,
    required double timeout,
    ElementHandleScreenshotTypeEnum? type,
  }) async {
    final payload = <String, dynamic>{};
    payload.addAll(commonScreenshotOptions.toJson() as Map<String, dynamic>);
    if (quality != null) payload['quality'] = quality;
    payload['timeout'] = timeout;
    if (type != null) payload['type'] = type?.value;
    final response = await connection.sendMessageToServer(
      guid,
      'screenshot',
      payload,
    );
    return ElementHandleScreenshotResult.fromJson(
      response,
      connection: connection,
    );
  }

  /// Scroll into view
  Future<void> channel_scrollIntoViewIfNeeded({required double timeout}) async {
    final payload = <String, dynamic>{};
    payload['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'scrollIntoViewIfNeeded',
      payload,
    );
    return;
  }

  /// Select option
  Future<ElementHandleSelectOptionResult> channel_selectOption({
    List<ElementHandleBase>? elements,
    bool? force,
    List<ElementHandleSelectOptionOptionsItems>? options,
    required double timeout,
  }) async {
    final payload = <String, dynamic>{};
    if (elements != null) payload['elements'] = elements;
    if (force != null) payload['force'] = force;
    if (options != null) payload['options'] = options;
    payload['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'selectOption',
      payload,
    );
    return ElementHandleSelectOptionResult.fromJson(
      response,
      connection: connection,
    );
  }

  /// Select text
  Future<void> channel_selectText({
    bool? force,
    required double timeout,
  }) async {
    final payload = <String, dynamic>{};
    if (force != null) payload['force'] = force;
    payload['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'selectText',
      payload,
    );
    return;
  }

  /// Set input files
  Future<void> channel_setInputFiles({
    WritableStreamBase? directoryStream,
    String? localDirectory,
    List<String>? localPaths,
    List<ElementHandleSetInputFilesPayloadsItems>? payloads,
    List<WritableStreamBase>? streams,
    required double timeout,
  }) async {
    final payload = <String, dynamic>{};
    if (directoryStream != null)
      payload['directoryStream'] = {'guid': directoryStream.guid};
    if (localDirectory != null) payload['localDirectory'] = localDirectory;
    if (localPaths != null) payload['localPaths'] = localPaths;
    if (payloads != null) payload['payloads'] = payloads;
    if (streams != null) payload['streams'] = streams;
    payload['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'setInputFiles',
      payload,
    );
    return;
  }

  /// Tap
  Future<void> channel_tap({
    bool? force,
    List<ElementHandleTapModifiersEnum>? modifiers,
    Point? position,
    required double timeout,
    bool? trial,
  }) async {
    final payload = <String, dynamic>{};
    if (force != null) payload['force'] = force;
    if (modifiers != null) payload['modifiers'] = modifiers;
    if (position != null) payload['position'] = position?.toJson();
    payload['timeout'] = timeout;
    if (trial != null) payload['trial'] = trial;
    final response = await connection.sendMessageToServer(guid, 'tap', payload);
    return;
  }

  /// Get text content
  Future<ElementHandleTextContentResult> channel_textContent() async {
    final response = await connection.sendMessageToServer(
      guid,
      'textContent',
      {},
    );
    return ElementHandleTextContentResult.fromJson(
      response,
      connection: connection,
    );
  }

  /// Type
  Future<void> channel_type({
    double? delay,
    required String text,
    required double timeout,
  }) async {
    final payload = <String, dynamic>{};
    if (delay != null) payload['delay'] = delay;
    payload['text'] = text;
    payload['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'type',
      payload,
    );
    return;
  }

  /// Uncheck
  Future<void> channel_uncheck({
    bool? force,
    Point? position,
    required double timeout,
    bool? trial,
  }) async {
    final payload = <String, dynamic>{};
    if (force != null) payload['force'] = force;
    if (position != null) payload['position'] = position?.toJson();
    payload['timeout'] = timeout;
    if (trial != null) payload['trial'] = trial;
    final response = await connection.sendMessageToServer(
      guid,
      'uncheck',
      payload,
    );
    return;
  }

  /// Wait for state
  Future<void> channel_waitForElementState({
    required ElementHandleWaitForElementStateStateEnum state,
    required double timeout,
  }) async {
    final payload = <String, dynamic>{};
    payload['state'] = state.value;
    payload['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'waitForElementState',
      payload,
    );
    return;
  }

  /// Wait for selector
  Future<ElementHandleWaitForSelectorResult> channel_waitForSelector({
    required Pattern selector,
    ElementHandleWaitForSelectorStateEnum? state,
    bool? strict,
    required double timeout,
  }) async {
    final payload = <String, dynamic>{};
    payload['selector'] = selector.toString();
    if (state != null) payload['state'] = state?.value;
    if (strict != null) payload['strict'] = strict;
    payload['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'waitForSelector',
      payload,
    );
    return ElementHandleWaitForSelectorResult.fromJson(
      response,
      connection: connection,
    );
  }
}

abstract class FrameBase extends ChannelOwner {
  FrameBase(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  FrameInitializer get typedInitializer =>
      FrameInitializer.fromJson(super.initializer, connection: connection);

  /// Add script tag
  Future<FrameAddScriptTagResult> channel_addScriptTag({
    String? content,
    String? type,
    String? url,
  }) async {
    final payload = <String, dynamic>{};
    if (content != null) payload['content'] = content;
    if (type != null) payload['type'] = type;
    if (url != null) payload['url'] = url;
    final response = await connection.sendMessageToServer(
      guid,
      'addScriptTag',
      payload,
    );
    return FrameAddScriptTagResult.fromJson(response, connection: connection);
  }

  /// Add style tag
  Future<FrameAddStyleTagResult> channel_addStyleTag({
    String? content,
    String? url,
  }) async {
    final payload = <String, dynamic>{};
    if (content != null) payload['content'] = content;
    if (url != null) payload['url'] = url;
    final response = await connection.sendMessageToServer(
      guid,
      'addStyleTag',
      payload,
    );
    return FrameAddStyleTagResult.fromJson(response, connection: connection);
  }

  /// Aria snapshot
  Future<FrameAriaSnapshotResult> channel_ariaSnapshot({
    bool? boxes,
    int? depth,
    FrameAriaSnapshotModeEnum? mode,
    Pattern? selector,
    required double timeout,
    String? track,
  }) async {
    final payload = <String, dynamic>{};
    if (boxes != null) payload['boxes'] = boxes;
    if (depth != null) payload['depth'] = depth;
    if (mode != null) payload['mode'] = mode?.value;
    if (selector != null) payload['selector'] = selector?.toString();
    payload['timeout'] = timeout;
    if (track != null) payload['track'] = track;
    final response = await connection.sendMessageToServer(
      guid,
      'ariaSnapshot',
      payload,
    );
    return FrameAriaSnapshotResult.fromJson(response, connection: connection);
  }

  /// Blur
  Future<void> channel_blur({
    required Pattern selector,
    bool? strict,
    required double timeout,
  }) async {
    final payload = <String, dynamic>{};
    payload['selector'] = selector.toString();
    if (strict != null) payload['strict'] = strict;
    payload['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'blur',
      payload,
    );
    return;
  }

  /// Check
  Future<void> channel_check({
    bool? force,
    Point? position,
    required Pattern selector,
    bool? strict,
    required double timeout,
    bool? trial,
  }) async {
    final payload = <String, dynamic>{};
    if (force != null) payload['force'] = force;
    if (position != null) payload['position'] = position?.toJson();
    payload['selector'] = selector.toString();
    if (strict != null) payload['strict'] = strict;
    payload['timeout'] = timeout;
    if (trial != null) payload['trial'] = trial;
    final response = await connection.sendMessageToServer(
      guid,
      'check',
      payload,
    );
    return;
  }

  /// Click
  Future<void> channel_click({
    FrameClickButtonEnum? button,
    int? clickCount,
    double? delay,
    bool? force,
    List<FrameClickModifiersEnum>? modifiers,
    bool? noWaitAfter,
    Point? position,
    required Pattern selector,
    int? steps,
    bool? strict,
    required double timeout,
    bool? trial,
  }) async {
    final payload = <String, dynamic>{};
    if (button != null) payload['button'] = button?.value;
    if (clickCount != null) payload['clickCount'] = clickCount;
    if (delay != null) payload['delay'] = delay;
    if (force != null) payload['force'] = force;
    if (modifiers != null) payload['modifiers'] = modifiers;
    if (noWaitAfter != null) payload['noWaitAfter'] = noWaitAfter;
    if (position != null) payload['position'] = position?.toJson();
    payload['selector'] = selector.toString();
    if (steps != null) payload['steps'] = steps;
    if (strict != null) payload['strict'] = strict;
    payload['timeout'] = timeout;
    if (trial != null) payload['trial'] = trial;
    final response = await connection.sendMessageToServer(
      guid,
      'click',
      payload,
    );
    return;
  }

  /// Get content
  Future<FrameContentResult> channel_content() async {
    final response = await connection.sendMessageToServer(guid, 'content', {});
    return FrameContentResult.fromJson(response, connection: connection);
  }

  /// Double click
  Future<void> channel_dblclick({
    FrameDblclickButtonEnum? button,
    double? delay,
    bool? force,
    List<FrameDblclickModifiersEnum>? modifiers,
    Point? position,
    required Pattern selector,
    int? steps,
    bool? strict,
    required double timeout,
    bool? trial,
  }) async {
    final payload = <String, dynamic>{};
    if (button != null) payload['button'] = button?.value;
    if (delay != null) payload['delay'] = delay;
    if (force != null) payload['force'] = force;
    if (modifiers != null) payload['modifiers'] = modifiers;
    if (position != null) payload['position'] = position?.toJson();
    payload['selector'] = selector.toString();
    if (steps != null) payload['steps'] = steps;
    if (strict != null) payload['strict'] = strict;
    payload['timeout'] = timeout;
    if (trial != null) payload['trial'] = trial;
    final response = await connection.sendMessageToServer(
      guid,
      'dblclick',
      payload,
    );
    return;
  }

  /// Dispatch "{type}"
  Future<void> channel_dispatchEvent({
    required SerializedArgument eventInit,
    required Pattern selector,
    bool? strict,
    required double timeout,
    required String type,
  }) async {
    final payload = <String, dynamic>{};
    payload['eventInit'] = eventInit.toJson();
    payload['selector'] = selector.toString();
    if (strict != null) payload['strict'] = strict;
    payload['timeout'] = timeout;
    payload['type'] = type;
    final response = await connection.sendMessageToServer(
      guid,
      'dispatchEvent',
      payload,
    );
    return;
  }

  /// Drag and drop
  Future<void> channel_dragAndDrop({
    bool? force,
    required String source,
    Point? sourcePosition,
    int? steps,
    bool? strict,
    required String target,
    Point? targetPosition,
    required double timeout,
    bool? trial,
  }) async {
    final payload = <String, dynamic>{};
    if (force != null) payload['force'] = force;
    payload['source'] = source;
    if (sourcePosition != null)
      payload['sourcePosition'] = sourcePosition?.toJson();
    if (steps != null) payload['steps'] = steps;
    if (strict != null) payload['strict'] = strict;
    payload['target'] = target;
    if (targetPosition != null)
      payload['targetPosition'] = targetPosition?.toJson();
    payload['timeout'] = timeout;
    if (trial != null) payload['trial'] = trial;
    final response = await connection.sendMessageToServer(
      guid,
      'dragAndDrop',
      payload,
    );
    return;
  }

  /// Drop files or data onto an element
  Future<void> channel_drop({
    List<FrameDropDataItems>? data,
    List<String>? localPaths,
    List<FrameDropPayloadsItems>? payloads,
    Point? position,
    required Pattern selector,
    List<WritableStreamBase>? streams,
    bool? strict,
    required double timeout,
  }) async {
    final payload = <String, dynamic>{};
    if (data != null) payload['data'] = data;
    if (localPaths != null) payload['localPaths'] = localPaths;
    if (payloads != null) payload['payloads'] = payloads;
    if (position != null) payload['position'] = position?.toJson();
    payload['selector'] = selector.toString();
    if (streams != null) payload['streams'] = streams;
    if (strict != null) payload['strict'] = strict;
    payload['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'drop',
      payload,
    );
    return;
  }

  /// Evaluate
  Future<FrameEvalOnSelectorResult> channel_evalOnSelector({
    required SerializedArgument arg,
    required String expression,
    bool? isFunction,
    required Pattern selector,
    bool? strict,
  }) async {
    final payload = <String, dynamic>{};
    payload['arg'] = arg.toJson();
    payload['expression'] = expression;
    if (isFunction != null) payload['isFunction'] = isFunction;
    payload['selector'] = selector.toString();
    if (strict != null) payload['strict'] = strict;
    final response = await connection.sendMessageToServer(
      guid,
      'evalOnSelector',
      payload,
    );
    return FrameEvalOnSelectorResult.fromJson(response, connection: connection);
  }

  /// Evaluate
  Future<FrameEvalOnSelectorAllResult> channel_evalOnSelectorAll({
    required SerializedArgument arg,
    required String expression,
    bool? isFunction,
    required Pattern selector,
  }) async {
    final payload = <String, dynamic>{};
    payload['arg'] = arg.toJson();
    payload['expression'] = expression;
    if (isFunction != null) payload['isFunction'] = isFunction;
    payload['selector'] = selector.toString();
    final response = await connection.sendMessageToServer(
      guid,
      'evalOnSelectorAll',
      payload,
    );
    return FrameEvalOnSelectorAllResult.fromJson(
      response,
      connection: connection,
    );
  }

  /// Evaluate
  Future<FrameEvaluateExpressionResult> channel_evaluateExpression({
    required SerializedArgument arg,
    required String expression,
    bool? isFunction,
  }) async {
    final payload = <String, dynamic>{};
    payload['arg'] = arg.toJson();
    payload['expression'] = expression;
    if (isFunction != null) payload['isFunction'] = isFunction;
    final response = await connection.sendMessageToServer(
      guid,
      'evaluateExpression',
      payload,
    );
    return FrameEvaluateExpressionResult.fromJson(
      response,
      connection: connection,
    );
  }

  /// Evaluate
  Future<FrameEvaluateExpressionHandleResult> channel_evaluateExpressionHandle({
    required SerializedArgument arg,
    required String expression,
    bool? isFunction,
  }) async {
    final payload = <String, dynamic>{};
    payload['arg'] = arg.toJson();
    payload['expression'] = expression;
    if (isFunction != null) payload['isFunction'] = isFunction;
    final response = await connection.sendMessageToServer(
      guid,
      'evaluateExpressionHandle',
      payload,
    );
    return FrameEvaluateExpressionHandleResult.fromJson(
      response,
      connection: connection,
    );
  }

  /// Expect "{expression}"
  Future<void> channel_expect({
    double? expectedNumber,
    List<ExpectedTextValue>? expectedText,
    SerializedArgument? expectedValue,
    required String expression,
    JsonValue expressionArg,
    required bool isNot,
    FrameExpectPseudoEnum? pseudo,
    Pattern? selector,
    required double timeout,
    bool? useInnerText,
  }) async {
    final payload = <String, dynamic>{};
    if (expectedNumber != null) payload['expectedNumber'] = expectedNumber;
    if (expectedText != null) payload['expectedText'] = expectedText;
    if (expectedValue != null)
      payload['expectedValue'] = expectedValue?.toJson();
    payload['expression'] = expression;
    if (expressionArg != null) payload['expressionArg'] = expressionArg;
    payload['isNot'] = isNot;
    if (pseudo != null) payload['pseudo'] = pseudo?.value;
    if (selector != null) payload['selector'] = selector?.toString();
    payload['timeout'] = timeout;
    if (useInnerText != null) payload['useInnerText'] = useInnerText;
    final response = await connection.sendMessageToServer(
      guid,
      'expect',
      payload,
    );
    return;
  }

  /// Fill "{value}"
  Future<void> channel_fill({
    bool? force,
    required Pattern selector,
    bool? strict,
    required double timeout,
    required String value,
  }) async {
    final payload = <String, dynamic>{};
    if (force != null) payload['force'] = force;
    payload['selector'] = selector.toString();
    if (strict != null) payload['strict'] = strict;
    payload['timeout'] = timeout;
    payload['value'] = value;
    final response = await connection.sendMessageToServer(
      guid,
      'fill',
      payload,
    );
    return;
  }

  /// Focus
  Future<void> channel_focus({
    required Pattern selector,
    bool? strict,
    required double timeout,
  }) async {
    final payload = <String, dynamic>{};
    payload['selector'] = selector.toString();
    if (strict != null) payload['strict'] = strict;
    payload['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'focus',
      payload,
    );
    return;
  }

  /// Get frame element
  Future<FrameFrameElementResult> channel_frameElement() async {
    final response = await connection.sendMessageToServer(
      guid,
      'frameElement',
      {},
    );
    return FrameFrameElementResult.fromJson(response, connection: connection);
  }

  /// Get attribute "{name}"
  Future<FrameGetAttributeResult> channel_getAttribute({
    required String name,
    required Pattern selector,
    bool? strict,
    required double timeout,
  }) async {
    final payload = <String, dynamic>{};
    payload['name'] = name;
    payload['selector'] = selector.toString();
    if (strict != null) payload['strict'] = strict;
    payload['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'getAttribute',
      payload,
    );
    return FrameGetAttributeResult.fromJson(response, connection: connection);
  }

  /// Navigate to "{url}"
  Future<FrameGotoResult> channel_goto({
    String? referer,
    required double timeout,
    required String url,
    LifecycleEvent? waitUntil,
  }) async {
    final payload = <String, dynamic>{};
    if (referer != null) payload['referer'] = referer;
    payload['timeout'] = timeout;
    payload['url'] = url;
    if (waitUntil != null) payload['waitUntil'] = waitUntil?.value;
    final response = await connection.sendMessageToServer(
      guid,
      'goto',
      payload,
    );
    return FrameGotoResult.fromJson(response, connection: connection);
  }

  Future<void> channel_hideHighlight({required Pattern selector}) async {
    final payload = <String, dynamic>{};
    payload['selector'] = selector.toString();
    final response = await connection.sendMessageToServer(
      guid,
      'hideHighlight',
      payload,
    );
    return;
  }

  Future<void> channel_highlight({
    required Pattern selector,
    String? style,
  }) async {
    final payload = <String, dynamic>{};
    payload['selector'] = selector.toString();
    if (style != null) payload['style'] = style;
    final response = await connection.sendMessageToServer(
      guid,
      'highlight',
      payload,
    );
    return;
  }

  /// Hover
  Future<void> channel_hover({
    bool? force,
    List<FrameHoverModifiersEnum>? modifiers,
    Point? position,
    required Pattern selector,
    bool? strict,
    required double timeout,
    bool? trial,
  }) async {
    final payload = <String, dynamic>{};
    if (force != null) payload['force'] = force;
    if (modifiers != null) payload['modifiers'] = modifiers;
    if (position != null) payload['position'] = position?.toJson();
    payload['selector'] = selector.toString();
    if (strict != null) payload['strict'] = strict;
    payload['timeout'] = timeout;
    if (trial != null) payload['trial'] = trial;
    final response = await connection.sendMessageToServer(
      guid,
      'hover',
      payload,
    );
    return;
  }

  /// Get HTML
  Future<FrameInnerHTMLResult> channel_innerHTML({
    required Pattern selector,
    bool? strict,
    required double timeout,
  }) async {
    final payload = <String, dynamic>{};
    payload['selector'] = selector.toString();
    if (strict != null) payload['strict'] = strict;
    payload['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'innerHTML',
      payload,
    );
    return FrameInnerHTMLResult.fromJson(response, connection: connection);
  }

  /// Get inner text
  Future<FrameInnerTextResult> channel_innerText({
    required Pattern selector,
    bool? strict,
    required double timeout,
  }) async {
    final payload = <String, dynamic>{};
    payload['selector'] = selector.toString();
    if (strict != null) payload['strict'] = strict;
    payload['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'innerText',
      payload,
    );
    return FrameInnerTextResult.fromJson(response, connection: connection);
  }

  /// Get input value
  Future<FrameInputValueResult> channel_inputValue({
    required Pattern selector,
    bool? strict,
    required double timeout,
  }) async {
    final payload = <String, dynamic>{};
    payload['selector'] = selector.toString();
    if (strict != null) payload['strict'] = strict;
    payload['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'inputValue',
      payload,
    );
    return FrameInputValueResult.fromJson(response, connection: connection);
  }

  /// Is checked
  Future<FrameIsCheckedResult> channel_isChecked({
    required Pattern selector,
    bool? strict,
    required double timeout,
  }) async {
    final payload = <String, dynamic>{};
    payload['selector'] = selector.toString();
    if (strict != null) payload['strict'] = strict;
    payload['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'isChecked',
      payload,
    );
    return FrameIsCheckedResult.fromJson(response, connection: connection);
  }

  /// Is disabled
  Future<FrameIsDisabledResult> channel_isDisabled({
    required Pattern selector,
    bool? strict,
    required double timeout,
  }) async {
    final payload = <String, dynamic>{};
    payload['selector'] = selector.toString();
    if (strict != null) payload['strict'] = strict;
    payload['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'isDisabled',
      payload,
    );
    return FrameIsDisabledResult.fromJson(response, connection: connection);
  }

  /// Is editable
  Future<FrameIsEditableResult> channel_isEditable({
    required Pattern selector,
    bool? strict,
    required double timeout,
  }) async {
    final payload = <String, dynamic>{};
    payload['selector'] = selector.toString();
    if (strict != null) payload['strict'] = strict;
    payload['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'isEditable',
      payload,
    );
    return FrameIsEditableResult.fromJson(response, connection: connection);
  }

  /// Is enabled
  Future<FrameIsEnabledResult> channel_isEnabled({
    required Pattern selector,
    bool? strict,
    required double timeout,
  }) async {
    final payload = <String, dynamic>{};
    payload['selector'] = selector.toString();
    if (strict != null) payload['strict'] = strict;
    payload['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'isEnabled',
      payload,
    );
    return FrameIsEnabledResult.fromJson(response, connection: connection);
  }

  /// Is hidden
  Future<FrameIsHiddenResult> channel_isHidden({
    required Pattern selector,
    bool? strict,
  }) async {
    final payload = <String, dynamic>{};
    payload['selector'] = selector.toString();
    if (strict != null) payload['strict'] = strict;
    final response = await connection.sendMessageToServer(
      guid,
      'isHidden',
      payload,
    );
    return FrameIsHiddenResult.fromJson(response, connection: connection);
  }

  /// Is visible
  Future<FrameIsVisibleResult> channel_isVisible({
    required Pattern selector,
    bool? strict,
  }) async {
    final payload = <String, dynamic>{};
    payload['selector'] = selector.toString();
    if (strict != null) payload['strict'] = strict;
    final response = await connection.sendMessageToServer(
      guid,
      'isVisible',
      payload,
    );
    return FrameIsVisibleResult.fromJson(response, connection: connection);
  }

  /// Press "{key}"
  Future<void> channel_press({
    double? delay,
    required String key,
    bool? noWaitAfter,
    required Pattern selector,
    bool? strict,
    required double timeout,
  }) async {
    final payload = <String, dynamic>{};
    if (delay != null) payload['delay'] = delay;
    payload['key'] = key;
    if (noWaitAfter != null) payload['noWaitAfter'] = noWaitAfter;
    payload['selector'] = selector.toString();
    if (strict != null) payload['strict'] = strict;
    payload['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'press',
      payload,
    );
    return;
  }

  /// Query count
  Future<FrameQueryCountResult> channel_queryCount({
    required Pattern selector,
  }) async {
    final payload = <String, dynamic>{};
    payload['selector'] = selector.toString();
    final response = await connection.sendMessageToServer(
      guid,
      'queryCount',
      payload,
    );
    return FrameQueryCountResult.fromJson(response, connection: connection);
  }

  /// Query selector
  Future<FrameQuerySelectorResult> channel_querySelector({
    required Pattern selector,
    bool? strict,
  }) async {
    final payload = <String, dynamic>{};
    payload['selector'] = selector.toString();
    if (strict != null) payload['strict'] = strict;
    final response = await connection.sendMessageToServer(
      guid,
      'querySelector',
      payload,
    );
    return FrameQuerySelectorResult.fromJson(response, connection: connection);
  }

  /// Query selector all
  Future<FrameQuerySelectorAllResult> channel_querySelectorAll({
    required Pattern selector,
  }) async {
    final payload = <String, dynamic>{};
    payload['selector'] = selector.toString();
    final response = await connection.sendMessageToServer(
      guid,
      'querySelectorAll',
      payload,
    );
    return FrameQuerySelectorAllResult.fromJson(
      response,
      connection: connection,
    );
  }

  Future<FrameResolveSelectorResult> channel_resolveSelector({
    required Pattern selector,
  }) async {
    final payload = <String, dynamic>{};
    payload['selector'] = selector.toString();
    final response = await connection.sendMessageToServer(
      guid,
      'resolveSelector',
      payload,
    );
    return FrameResolveSelectorResult.fromJson(
      response,
      connection: connection,
    );
  }

  /// Select option
  Future<FrameSelectOptionResult> channel_selectOption({
    List<ElementHandleBase>? elements,
    bool? force,
    List<FrameSelectOptionOptionsItems>? options,
    required Pattern selector,
    bool? strict,
    required double timeout,
  }) async {
    final payload = <String, dynamic>{};
    if (elements != null) payload['elements'] = elements;
    if (force != null) payload['force'] = force;
    if (options != null) payload['options'] = options;
    payload['selector'] = selector.toString();
    if (strict != null) payload['strict'] = strict;
    payload['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'selectOption',
      payload,
    );
    return FrameSelectOptionResult.fromJson(response, connection: connection);
  }

  /// Set content
  Future<void> channel_setContent({
    required String html,
    required double timeout,
    LifecycleEvent? waitUntil,
  }) async {
    final payload = <String, dynamic>{};
    payload['html'] = html;
    payload['timeout'] = timeout;
    if (waitUntil != null) payload['waitUntil'] = waitUntil?.value;
    final response = await connection.sendMessageToServer(
      guid,
      'setContent',
      payload,
    );
    return;
  }

  /// Set input files
  Future<void> channel_setInputFiles({
    WritableStreamBase? directoryStream,
    String? localDirectory,
    List<String>? localPaths,
    List<FrameSetInputFilesPayloadsItems>? payloads,
    required Pattern selector,
    List<WritableStreamBase>? streams,
    bool? strict,
    required double timeout,
  }) async {
    final payload = <String, dynamic>{};
    if (directoryStream != null)
      payload['directoryStream'] = {'guid': directoryStream.guid};
    if (localDirectory != null) payload['localDirectory'] = localDirectory;
    if (localPaths != null) payload['localPaths'] = localPaths;
    if (payloads != null) payload['payloads'] = payloads;
    payload['selector'] = selector.toString();
    if (streams != null) payload['streams'] = streams;
    if (strict != null) payload['strict'] = strict;
    payload['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'setInputFiles',
      payload,
    );
    return;
  }

  /// Tap
  Future<void> channel_tap({
    bool? force,
    List<FrameTapModifiersEnum>? modifiers,
    Point? position,
    required Pattern selector,
    bool? strict,
    required double timeout,
    bool? trial,
  }) async {
    final payload = <String, dynamic>{};
    if (force != null) payload['force'] = force;
    if (modifiers != null) payload['modifiers'] = modifiers;
    if (position != null) payload['position'] = position?.toJson();
    payload['selector'] = selector.toString();
    if (strict != null) payload['strict'] = strict;
    payload['timeout'] = timeout;
    if (trial != null) payload['trial'] = trial;
    final response = await connection.sendMessageToServer(guid, 'tap', payload);
    return;
  }

  /// Get text content
  Future<FrameTextContentResult> channel_textContent({
    required Pattern selector,
    bool? strict,
    required double timeout,
  }) async {
    final payload = <String, dynamic>{};
    payload['selector'] = selector.toString();
    if (strict != null) payload['strict'] = strict;
    payload['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'textContent',
      payload,
    );
    return FrameTextContentResult.fromJson(response, connection: connection);
  }

  /// Get page title
  Future<FrameTitleResult> channel_title() async {
    final response = await connection.sendMessageToServer(guid, 'title', {});
    return FrameTitleResult.fromJson(response, connection: connection);
  }

  /// Type "{text}"
  Future<void> channel_type({
    double? delay,
    required Pattern selector,
    bool? strict,
    required String text,
    required double timeout,
  }) async {
    final payload = <String, dynamic>{};
    if (delay != null) payload['delay'] = delay;
    payload['selector'] = selector.toString();
    if (strict != null) payload['strict'] = strict;
    payload['text'] = text;
    payload['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'type',
      payload,
    );
    return;
  }

  /// Uncheck
  Future<void> channel_uncheck({
    bool? force,
    Point? position,
    required Pattern selector,
    bool? strict,
    required double timeout,
    bool? trial,
  }) async {
    final payload = <String, dynamic>{};
    if (force != null) payload['force'] = force;
    if (position != null) payload['position'] = position?.toJson();
    payload['selector'] = selector.toString();
    if (strict != null) payload['strict'] = strict;
    payload['timeout'] = timeout;
    if (trial != null) payload['trial'] = trial;
    final response = await connection.sendMessageToServer(
      guid,
      'uncheck',
      payload,
    );
    return;
  }

  /// Wait for function
  Future<FrameWaitForFunctionResult> channel_waitForFunction({
    required SerializedArgument arg,
    required String expression,
    bool? isFunction,
    double? pollingInterval,
    required double timeout,
  }) async {
    final payload = <String, dynamic>{};
    payload['arg'] = arg.toJson();
    payload['expression'] = expression;
    if (isFunction != null) payload['isFunction'] = isFunction;
    if (pollingInterval != null) payload['pollingInterval'] = pollingInterval;
    payload['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'waitForFunction',
      payload,
    );
    return FrameWaitForFunctionResult.fromJson(
      response,
      connection: connection,
    );
  }

  /// Wait for selector
  Future<FrameWaitForSelectorResult> channel_waitForSelector({
    bool? omitReturnValue,
    required Pattern selector,
    FrameWaitForSelectorStateEnum? state,
    bool? strict,
    required double timeout,
  }) async {
    final payload = <String, dynamic>{};
    if (omitReturnValue != null) payload['omitReturnValue'] = omitReturnValue;
    payload['selector'] = selector.toString();
    if (state != null) payload['state'] = state?.value;
    if (strict != null) payload['strict'] = strict;
    payload['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'waitForSelector',
      payload,
    );
    return FrameWaitForSelectorResult.fromJson(
      response,
      connection: connection,
    );
  }

  /// Wait for timeout
  Future<void> channel_waitForTimeout({required double waitTimeout}) async {
    final payload = <String, dynamic>{};
    payload['waitTimeout'] = waitTimeout;
    final response = await connection.sendMessageToServer(
      guid,
      'waitForTimeout',
      payload,
    );
    return;
  }
}

abstract class JSHandleBase extends ChannelOwner {
  JSHandleBase(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  JSHandleInitializer get typedInitializer =>
      JSHandleInitializer.fromJson(super.initializer, connection: connection);

  Future<void> channel_dispose() async {
    final response = await connection.sendMessageToServer(guid, 'dispose', {});
    return;
  }

  /// Evaluate
  Future<JSHandleEvaluateExpressionResult> channel_evaluateExpression({
    required SerializedArgument arg,
    required String expression,
    bool? isFunction,
  }) async {
    final payload = <String, dynamic>{};
    payload['arg'] = arg.toJson();
    payload['expression'] = expression;
    if (isFunction != null) payload['isFunction'] = isFunction;
    final response = await connection.sendMessageToServer(
      guid,
      'evaluateExpression',
      payload,
    );
    return JSHandleEvaluateExpressionResult.fromJson(
      response,
      connection: connection,
    );
  }

  /// Evaluate
  Future<JSHandleEvaluateExpressionHandleResult>
  channel_evaluateExpressionHandle({
    required SerializedArgument arg,
    required String expression,
    bool? isFunction,
  }) async {
    final payload = <String, dynamic>{};
    payload['arg'] = arg.toJson();
    payload['expression'] = expression;
    if (isFunction != null) payload['isFunction'] = isFunction;
    final response = await connection.sendMessageToServer(
      guid,
      'evaluateExpressionHandle',
      payload,
    );
    return JSHandleEvaluateExpressionHandleResult.fromJson(
      response,
      connection: connection,
    );
  }

  /// Get JS property
  Future<JSHandleGetPropertyResult> channel_getProperty({
    required String name,
  }) async {
    final payload = <String, dynamic>{};
    payload['name'] = name;
    final response = await connection.sendMessageToServer(
      guid,
      'getProperty',
      payload,
    );
    return JSHandleGetPropertyResult.fromJson(response, connection: connection);
  }

  /// Get property list
  Future<JSHandleGetPropertyListResult> channel_getPropertyList() async {
    final response = await connection.sendMessageToServer(
      guid,
      'getPropertyList',
      {},
    );
    return JSHandleGetPropertyListResult.fromJson(
      response,
      connection: connection,
    );
  }

  /// Get JSON value
  Future<JSHandleJsonValueResult> channel_jsonValue() async {
    final response = await connection.sendMessageToServer(
      guid,
      'jsonValue',
      {},
    );
    return JSHandleJsonValueResult.fromJson(response, connection: connection);
  }
}

abstract class JsonPipeBase extends ChannelOwner {
  JsonPipeBase(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  Future<void> channel_close() async {
    final response = await connection.sendMessageToServer(guid, 'close', {});
    return;
  }

  Future<void> channel_send({JsonValue message}) async {
    final payload = <String, dynamic>{};
    if (message != null) payload['message'] = message;
    final response = await connection.sendMessageToServer(
      guid,
      'send',
      payload,
    );
    return;
  }
}

abstract class LocalUtilsBase extends ChannelOwner {
  LocalUtilsBase(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  LocalUtilsInitializer get typedInitializer =>
      LocalUtilsInitializer.fromJson(super.initializer, connection: connection);

  Future<void> channel_addStackToTracingNoReply({
    required ClientSideCallMetadata callData,
  }) async {
    final payload = <String, dynamic>{};
    payload['callData'] = callData.toJson();
    final response = await connection.sendMessageToServer(
      guid,
      'addStackToTracingNoReply',
      payload,
    );
    return;
  }

  Future<LocalUtilsConnectResult> channel_connect({
    required String endpoint,
    String? exposeNetwork,
    JsonValue headers,
    double? slowMo,
    int? socksProxyRedirectPortForTest,
    required double timeout,
  }) async {
    final payload = <String, dynamic>{};
    payload['endpoint'] = endpoint;
    if (exposeNetwork != null) payload['exposeNetwork'] = exposeNetwork;
    if (headers != null) payload['headers'] = headers;
    if (slowMo != null) payload['slowMo'] = slowMo;
    if (socksProxyRedirectPortForTest != null)
      payload['socksProxyRedirectPortForTest'] = socksProxyRedirectPortForTest;
    payload['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'connect',
      payload,
    );
    return LocalUtilsConnectResult.fromJson(response, connection: connection);
  }

  Future<LocalUtilsGlobToRegexResult> channel_globToRegex({
    String? baseURL,
    required String glob,
    bool? webSocketUrl,
  }) async {
    final payload = <String, dynamic>{};
    if (baseURL != null) payload['baseURL'] = baseURL;
    payload['glob'] = glob;
    if (webSocketUrl != null) payload['webSocketUrl'] = webSocketUrl;
    final response = await connection.sendMessageToServer(
      guid,
      'globToRegex',
      payload,
    );
    return LocalUtilsGlobToRegexResult.fromJson(
      response,
      connection: connection,
    );
  }

  Future<void> channel_harClose({required String harId}) async {
    final payload = <String, dynamic>{};
    payload['harId'] = harId;
    final response = await connection.sendMessageToServer(
      guid,
      'harClose',
      payload,
    );
    return;
  }

  Future<LocalUtilsHarLookupResult> channel_harLookup({
    required String harId,
    required List<NameValue> headers,
    required bool isNavigationRequest,
    required String method,
    String? postData,
    required String url,
  }) async {
    final payload = <String, dynamic>{};
    payload['harId'] = harId;
    payload['headers'] = headers;
    payload['isNavigationRequest'] = isNavigationRequest;
    payload['method'] = method;
    if (postData != null) payload['postData'] = postData;
    payload['url'] = url;
    final response = await connection.sendMessageToServer(
      guid,
      'harLookup',
      payload,
    );
    return LocalUtilsHarLookupResult.fromJson(response, connection: connection);
  }

  Future<LocalUtilsHarOpenResult> channel_harOpen({
    required String file,
  }) async {
    final payload = <String, dynamic>{};
    payload['file'] = file;
    final response = await connection.sendMessageToServer(
      guid,
      'harOpen',
      payload,
    );
    return LocalUtilsHarOpenResult.fromJson(response, connection: connection);
  }

  Future<void> channel_harUnzip({
    required String harFile,
    String? resourcesDir,
    required String zipFile,
  }) async {
    final payload = <String, dynamic>{};
    payload['harFile'] = harFile;
    if (resourcesDir != null) payload['resourcesDir'] = resourcesDir;
    payload['zipFile'] = zipFile;
    final response = await connection.sendMessageToServer(
      guid,
      'harUnzip',
      payload,
    );
    return;
  }

  Future<void> channel_traceDiscarded({required String stacksId}) async {
    final payload = <String, dynamic>{};
    payload['stacksId'] = stacksId;
    final response = await connection.sendMessageToServer(
      guid,
      'traceDiscarded',
      payload,
    );
    return;
  }

  Future<LocalUtilsTracingStartedResult> channel_tracingStarted({
    bool? live,
    required String traceName,
    String? tracesDir,
  }) async {
    final payload = <String, dynamic>{};
    if (live != null) payload['live'] = live;
    payload['traceName'] = traceName;
    if (tracesDir != null) payload['tracesDir'] = tracesDir;
    final response = await connection.sendMessageToServer(
      guid,
      'tracingStarted',
      payload,
    );
    return LocalUtilsTracingStartedResult.fromJson(
      response,
      connection: connection,
    );
  }

  Future<void> channel_zip({
    List<String>? additionalSources,
    required List<NameValue> entries,
    required bool includeSources,
    required LocalUtilsZipModeEnum mode,
    String? stacksId,
    required String zipFile,
  }) async {
    final payload = <String, dynamic>{};
    if (additionalSources != null)
      payload['additionalSources'] = additionalSources;
    payload['entries'] = entries;
    payload['includeSources'] = includeSources;
    payload['mode'] = mode.value;
    if (stacksId != null) payload['stacksId'] = stacksId;
    payload['zipFile'] = zipFile;
    final response = await connection.sendMessageToServer(guid, 'zip', payload);
    return;
  }
}

abstract class PageBase extends ChannelOwner {
  PageBase(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  PageInitializer get typedInitializer =>
      PageInitializer.fromJson(super.initializer, connection: connection);

  /// Add init script
  Future<PageAddInitScriptResult> channel_addInitScript({
    required String source,
  }) async {
    final payload = <String, dynamic>{};
    payload['source'] = source;
    final response = await connection.sendMessageToServer(
      guid,
      'addInitScript',
      payload,
    );
    return PageAddInitScriptResult.fromJson(response, connection: connection);
  }

  /// Bring to front
  Future<void> channel_bringToFront() async {
    final response = await connection.sendMessageToServer(
      guid,
      'bringToFront',
      {},
    );
    return;
  }

  /// Cancel pick locator
  Future<void> channel_cancelPickLocator() async {
    final response = await connection.sendMessageToServer(
      guid,
      'cancelPickLocator',
      {},
    );
    return;
  }

  /// Clear console messages
  Future<void> channel_clearConsoleMessages() async {
    final response = await connection.sendMessageToServer(
      guid,
      'clearConsoleMessages',
      {},
    );
    return;
  }

  /// Clear page errors
  Future<void> channel_clearPageErrors() async {
    final response = await connection.sendMessageToServer(
      guid,
      'clearPageErrors',
      {},
    );
    return;
  }

  /// Close page
  Future<void> channel_close({String? reason}) async {
    final payload = <String, dynamic>{};
    if (reason != null) payload['reason'] = reason;
    final response = await connection.sendMessageToServer(
      guid,
      'close',
      payload,
    );
    return;
  }

  /// Get console messages
  Future<PageConsoleMessagesResult> channel_consoleMessages({
    ConsoleMessagesFilter? filter,
  }) async {
    final payload = <String, dynamic>{};
    if (filter != null) payload['filter'] = filter?.value;
    final response = await connection.sendMessageToServer(
      guid,
      'consoleMessages',
      payload,
    );
    return PageConsoleMessagesResult.fromJson(response, connection: connection);
  }

  /// Emulate media
  Future<void> channel_emulateMedia({
    PageEmulateMediaColorSchemeEnum? colorScheme,
    PageEmulateMediaContrastEnum? contrast,
    PageEmulateMediaForcedColorsEnum? forcedColors,
    PageEmulateMediaMediaEnum? media,
    PageEmulateMediaReducedMotionEnum? reducedMotion,
  }) async {
    final payload = <String, dynamic>{};
    if (colorScheme != null) payload['colorScheme'] = colorScheme?.value;
    if (contrast != null) payload['contrast'] = contrast?.value;
    if (forcedColors != null) payload['forcedColors'] = forcedColors?.value;
    if (media != null) payload['media'] = media?.value;
    if (reducedMotion != null) payload['reducedMotion'] = reducedMotion?.value;
    final response = await connection.sendMessageToServer(
      guid,
      'emulateMedia',
      payload,
    );
    return;
  }

  /// Expect screenshot
  Future<PageExpectScreenshotResult> channel_expectScreenshot({
    required CommonScreenshotOptions commonScreenshotOptions,
    Rect? clip,
    String? comparator,
    String? expected,
    bool? fullPage,
    required bool isNot,
    PageExpectScreenshotLocator? locator,
    double? maxDiffPixelRatio,
    int? maxDiffPixels,
    double? threshold,
    required double timeout,
  }) async {
    final payload = <String, dynamic>{};
    payload.addAll(commonScreenshotOptions.toJson() as Map<String, dynamic>);
    if (clip != null) payload['clip'] = clip?.toJson();
    if (comparator != null) payload['comparator'] = comparator;
    if (expected != null) payload['expected'] = expected;
    if (fullPage != null) payload['fullPage'] = fullPage;
    payload['isNot'] = isNot;
    if (locator != null) payload['locator'] = locator?.toJson();
    if (maxDiffPixelRatio != null)
      payload['maxDiffPixelRatio'] = maxDiffPixelRatio;
    if (maxDiffPixels != null) payload['maxDiffPixels'] = maxDiffPixels;
    if (threshold != null) payload['threshold'] = threshold;
    payload['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'expectScreenshot',
      payload,
    );
    return PageExpectScreenshotResult.fromJson(
      response,
      connection: connection,
    );
  }

  /// Expose binding
  Future<PageExposeBindingResult> channel_exposeBinding({
    required String name,
  }) async {
    final payload = <String, dynamic>{};
    payload['name'] = name;
    final response = await connection.sendMessageToServer(
      guid,
      'exposeBinding',
      payload,
    );
    return PageExposeBindingResult.fromJson(response, connection: connection);
  }

  /// Go back
  Future<PageGoBackResult> channel_goBack({
    required double timeout,
    LifecycleEvent? waitUntil,
  }) async {
    final payload = <String, dynamic>{};
    payload['timeout'] = timeout;
    if (waitUntil != null) payload['waitUntil'] = waitUntil?.value;
    final response = await connection.sendMessageToServer(
      guid,
      'goBack',
      payload,
    );
    return PageGoBackResult.fromJson(response, connection: connection);
  }

  /// Go forward
  Future<PageGoForwardResult> channel_goForward({
    required double timeout,
    LifecycleEvent? waitUntil,
  }) async {
    final payload = <String, dynamic>{};
    payload['timeout'] = timeout;
    if (waitUntil != null) payload['waitUntil'] = waitUntil?.value;
    final response = await connection.sendMessageToServer(
      guid,
      'goForward',
      payload,
    );
    return PageGoForwardResult.fromJson(response, connection: connection);
  }

  /// Hide all element highlights
  Future<void> channel_hideHighlight() async {
    final response = await connection.sendMessageToServer(
      guid,
      'hideHighlight',
      {},
    );
    return;
  }

  /// Key down "{key}"
  Future<void> channel_keyboardDown({required String key}) async {
    final payload = <String, dynamic>{};
    payload['key'] = key;
    final response = await connection.sendMessageToServer(
      guid,
      'keyboardDown',
      payload,
    );
    return;
  }

  /// Insert "{text}"
  Future<void> channel_keyboardInsertText({required String text}) async {
    final payload = <String, dynamic>{};
    payload['text'] = text;
    final response = await connection.sendMessageToServer(
      guid,
      'keyboardInsertText',
      payload,
    );
    return;
  }

  /// Press "{key}"
  Future<void> channel_keyboardPress({
    double? delay,
    required String key,
  }) async {
    final payload = <String, dynamic>{};
    if (delay != null) payload['delay'] = delay;
    payload['key'] = key;
    final response = await connection.sendMessageToServer(
      guid,
      'keyboardPress',
      payload,
    );
    return;
  }

  /// Type "{text}"
  Future<void> channel_keyboardType({
    double? delay,
    required String text,
  }) async {
    final payload = <String, dynamic>{};
    if (delay != null) payload['delay'] = delay;
    payload['text'] = text;
    final response = await connection.sendMessageToServer(
      guid,
      'keyboardType',
      payload,
    );
    return;
  }

  /// Key up "{key}"
  Future<void> channel_keyboardUp({required String key}) async {
    final payload = <String, dynamic>{};
    payload['key'] = key;
    final response = await connection.sendMessageToServer(
      guid,
      'keyboardUp',
      payload,
    );
    return;
  }

  /// Click
  Future<void> channel_mouseClick({
    PageMouseClickButtonEnum? button,
    int? clickCount,
    double? delay,
    required double x,
    required double y,
  }) async {
    final payload = <String, dynamic>{};
    if (button != null) payload['button'] = button?.value;
    if (clickCount != null) payload['clickCount'] = clickCount;
    if (delay != null) payload['delay'] = delay;
    payload['x'] = x;
    payload['y'] = y;
    final response = await connection.sendMessageToServer(
      guid,
      'mouseClick',
      payload,
    );
    return;
  }

  /// Mouse down
  Future<void> channel_mouseDown({
    PageMouseDownButtonEnum? button,
    int? clickCount,
  }) async {
    final payload = <String, dynamic>{};
    if (button != null) payload['button'] = button?.value;
    if (clickCount != null) payload['clickCount'] = clickCount;
    final response = await connection.sendMessageToServer(
      guid,
      'mouseDown',
      payload,
    );
    return;
  }

  /// Mouse move
  Future<void> channel_mouseMove({
    int? steps,
    required double x,
    required double y,
  }) async {
    final payload = <String, dynamic>{};
    if (steps != null) payload['steps'] = steps;
    payload['x'] = x;
    payload['y'] = y;
    final response = await connection.sendMessageToServer(
      guid,
      'mouseMove',
      payload,
    );
    return;
  }

  /// Mouse up
  Future<void> channel_mouseUp({
    PageMouseUpButtonEnum? button,
    int? clickCount,
  }) async {
    final payload = <String, dynamic>{};
    if (button != null) payload['button'] = button?.value;
    if (clickCount != null) payload['clickCount'] = clickCount;
    final response = await connection.sendMessageToServer(
      guid,
      'mouseUp',
      payload,
    );
    return;
  }

  /// Mouse wheel
  Future<void> channel_mouseWheel({
    required double deltaX,
    required double deltaY,
  }) async {
    final payload = <String, dynamic>{};
    payload['deltaX'] = deltaX;
    payload['deltaY'] = deltaY;
    final response = await connection.sendMessageToServer(
      guid,
      'mouseWheel',
      payload,
    );
    return;
  }

  /// Get page errors
  Future<PagePageErrorsResult> channel_pageErrors({
    ConsoleMessagesFilter? filter,
  }) async {
    final payload = <String, dynamic>{};
    if (filter != null) payload['filter'] = filter?.value;
    final response = await connection.sendMessageToServer(
      guid,
      'pageErrors',
      payload,
    );
    return PagePageErrorsResult.fromJson(response, connection: connection);
  }

  /// PDF
  Future<PagePdfResult> channel_pdf({
    bool? displayHeaderFooter,
    String? footerTemplate,
    String? format,
    String? headerTemplate,
    String? height,
    bool? landscape,
    PagePdfMargin? margin,
    bool? outline,
    String? pageRanges,
    bool? preferCSSPageSize,
    bool? printBackground,
    double? scale,
    bool? tagged,
    String? width,
  }) async {
    final payload = <String, dynamic>{};
    if (displayHeaderFooter != null)
      payload['displayHeaderFooter'] = displayHeaderFooter;
    if (footerTemplate != null) payload['footerTemplate'] = footerTemplate;
    if (format != null) payload['format'] = format;
    if (headerTemplate != null) payload['headerTemplate'] = headerTemplate;
    if (height != null) payload['height'] = height;
    if (landscape != null) payload['landscape'] = landscape;
    if (margin != null) payload['margin'] = margin?.toJson();
    if (outline != null) payload['outline'] = outline;
    if (pageRanges != null) payload['pageRanges'] = pageRanges;
    if (preferCSSPageSize != null)
      payload['preferCSSPageSize'] = preferCSSPageSize;
    if (printBackground != null) payload['printBackground'] = printBackground;
    if (scale != null) payload['scale'] = scale;
    if (tagged != null) payload['tagged'] = tagged;
    if (width != null) payload['width'] = width;
    final response = await connection.sendMessageToServer(guid, 'pdf', payload);
    return PagePdfResult.fromJson(response, connection: connection);
  }

  /// Pick locator
  Future<PagePickLocatorResult> channel_pickLocator() async {
    final response = await connection.sendMessageToServer(
      guid,
      'pickLocator',
      {},
    );
    return PagePickLocatorResult.fromJson(response, connection: connection);
  }

  /// Register locator handler
  Future<PageRegisterLocatorHandlerResult> channel_registerLocatorHandler({
    bool? noWaitAfter,
    required Pattern selector,
  }) async {
    final payload = <String, dynamic>{};
    if (noWaitAfter != null) payload['noWaitAfter'] = noWaitAfter;
    payload['selector'] = selector.toString();
    final response = await connection.sendMessageToServer(
      guid,
      'registerLocatorHandler',
      payload,
    );
    return PageRegisterLocatorHandlerResult.fromJson(
      response,
      connection: connection,
    );
  }

  /// Reload
  Future<PageReloadResult> channel_reload({
    required double timeout,
    LifecycleEvent? waitUntil,
  }) async {
    final payload = <String, dynamic>{};
    payload['timeout'] = timeout;
    if (waitUntil != null) payload['waitUntil'] = waitUntil?.value;
    final response = await connection.sendMessageToServer(
      guid,
      'reload',
      payload,
    );
    return PageReloadResult.fromJson(response, connection: connection);
  }

  /// Request garbage collection
  Future<void> channel_requestGC() async {
    final response = await connection.sendMessageToServer(
      guid,
      'requestGC',
      {},
    );
    return;
  }

  /// Get network requests
  Future<PageRequestsResult> channel_requests() async {
    final response = await connection.sendMessageToServer(guid, 'requests', {});
    return PageRequestsResult.fromJson(response, connection: connection);
  }

  Future<void> channel_resolveLocatorHandlerNoReply({
    bool? remove,
    required int uid,
  }) async {
    final payload = <String, dynamic>{};
    if (remove != null) payload['remove'] = remove;
    payload['uid'] = uid;
    final response = await connection.sendMessageToServer(
      guid,
      'resolveLocatorHandlerNoReply',
      payload,
    );
    return;
  }

  /// Run beforeunload
  Future<void> channel_runBeforeUnload() async {
    final response = await connection.sendMessageToServer(
      guid,
      'runBeforeUnload',
      {},
    );
    return;
  }

  /// Show chapter overlay
  Future<void> channel_screencastChapter({
    String? description,
    double? duration,
    required String title,
  }) async {
    final payload = <String, dynamic>{};
    if (description != null) payload['description'] = description;
    if (duration != null) payload['duration'] = duration;
    payload['title'] = title;
    final response = await connection.sendMessageToServer(
      guid,
      'screencastChapter',
      payload,
    );
    return;
  }

  /// Remove actions
  Future<void> channel_screencastHideActions() async {
    final response = await connection.sendMessageToServer(
      guid,
      'screencastHideActions',
      {},
    );
    return;
  }

  /// Remove overlay
  Future<void> channel_screencastRemoveOverlay({required String id}) async {
    final payload = <String, dynamic>{};
    payload['id'] = id;
    final response = await connection.sendMessageToServer(
      guid,
      'screencastRemoveOverlay',
      payload,
    );
    return;
  }

  /// Set overlay visibility
  Future<void> channel_screencastSetOverlayVisible({
    required bool visible,
  }) async {
    final payload = <String, dynamic>{};
    payload['visible'] = visible;
    final response = await connection.sendMessageToServer(
      guid,
      'screencastSetOverlayVisible',
      payload,
    );
    return;
  }

  /// Show actions
  Future<void> channel_screencastShowActions({
    required ShowActionsOptions showActionsOptions,
  }) async {
    final payload = <String, dynamic>{};
    payload.addAll(showActionsOptions.toJson() as Map<String, dynamic>);
    final response = await connection.sendMessageToServer(
      guid,
      'screencastShowActions',
      payload,
    );
    return;
  }

  /// Show overlay
  Future<PageScreencastShowOverlayResult> channel_screencastShowOverlay({
    double? duration,
    required String html,
  }) async {
    final payload = <String, dynamic>{};
    if (duration != null) payload['duration'] = duration;
    payload['html'] = html;
    final response = await connection.sendMessageToServer(
      guid,
      'screencastShowOverlay',
      payload,
    );
    return PageScreencastShowOverlayResult.fromJson(
      response,
      connection: connection,
    );
  }

  /// Start screencast
  Future<PageScreencastStartResult> channel_screencastStart({
    int? quality,
    bool? record,
    bool? sendFrames,
    PageScreencastStartSize? size,
  }) async {
    final payload = <String, dynamic>{};
    if (quality != null) payload['quality'] = quality;
    if (record != null) payload['record'] = record;
    if (sendFrames != null) payload['sendFrames'] = sendFrames;
    if (size != null) payload['size'] = size?.toJson();
    final response = await connection.sendMessageToServer(
      guid,
      'screencastStart',
      payload,
    );
    return PageScreencastStartResult.fromJson(response, connection: connection);
  }

  /// Stop screencast
  Future<void> channel_screencastStop() async {
    final response = await connection.sendMessageToServer(
      guid,
      'screencastStop',
      {},
    );
    return;
  }

  /// Screenshot
  Future<PageScreenshotResult> channel_screenshot({
    required CommonScreenshotOptions commonScreenshotOptions,
    Rect? clip,
    bool? fullPage,
    int? quality,
    required double timeout,
    PageScreenshotTypeEnum? type,
  }) async {
    final payload = <String, dynamic>{};
    payload.addAll(commonScreenshotOptions.toJson() as Map<String, dynamic>);
    if (clip != null) payload['clip'] = clip?.toJson();
    if (fullPage != null) payload['fullPage'] = fullPage;
    if (quality != null) payload['quality'] = quality;
    payload['timeout'] = timeout;
    if (type != null) payload['type'] = type?.value;
    final response = await connection.sendMessageToServer(
      guid,
      'screenshot',
      payload,
    );
    return PageScreenshotResult.fromJson(response, connection: connection);
  }

  Future<void> channel_setDockTile({required String image}) async {
    final payload = <String, dynamic>{};
    payload['image'] = image;
    final response = await connection.sendMessageToServer(
      guid,
      'setDockTile',
      payload,
    );
    return;
  }

  /// Set extra HTTP headers
  Future<void> channel_setExtraHTTPHeaders({
    required List<NameValue> headers,
  }) async {
    final payload = <String, dynamic>{};
    payload['headers'] = headers;
    final response = await connection.sendMessageToServer(
      guid,
      'setExtraHTTPHeaders',
      payload,
    );
    return;
  }

  /// Route requests
  Future<void> channel_setNetworkInterceptionPatterns({
    required List<PageSetNetworkInterceptionPatternsPatternsItems> patterns,
  }) async {
    final payload = <String, dynamic>{};
    payload['patterns'] = patterns;
    final response = await connection.sendMessageToServer(
      guid,
      'setNetworkInterceptionPatterns',
      payload,
    );
    return;
  }

  /// Set viewport size
  Future<void> channel_setViewportSize({
    required PageSetViewportSizeViewportSize viewportSize,
  }) async {
    final payload = <String, dynamic>{};
    payload['viewportSize'] = viewportSize.toJson();
    final response = await connection.sendMessageToServer(
      guid,
      'setViewportSize',
      payload,
    );
    return;
  }

  /// Route WebSockets
  Future<void> channel_setWebSocketInterceptionPatterns({
    required List<PageSetWebSocketInterceptionPatternsPatternsItems> patterns,
  }) async {
    final payload = <String, dynamic>{};
    payload['patterns'] = patterns;
    final response = await connection.sendMessageToServer(
      guid,
      'setWebSocketInterceptionPatterns',
      payload,
    );
    return;
  }

  /// Start CSS coverage
  Future<void> channel_startCSSCoverage({bool? resetOnNavigation}) async {
    final payload = <String, dynamic>{};
    if (resetOnNavigation != null)
      payload['resetOnNavigation'] = resetOnNavigation;
    final response = await connection.sendMessageToServer(
      guid,
      'startCSSCoverage',
      payload,
    );
    return;
  }

  /// Start JS coverage
  Future<void> channel_startJSCoverage({
    bool? reportAnonymousScripts,
    bool? resetOnNavigation,
  }) async {
    final payload = <String, dynamic>{};
    if (reportAnonymousScripts != null)
      payload['reportAnonymousScripts'] = reportAnonymousScripts;
    if (resetOnNavigation != null)
      payload['resetOnNavigation'] = resetOnNavigation;
    final response = await connection.sendMessageToServer(
      guid,
      'startJSCoverage',
      payload,
    );
    return;
  }

  /// Stop CSS coverage
  Future<PageStopCSSCoverageResult> channel_stopCSSCoverage() async {
    final response = await connection.sendMessageToServer(
      guid,
      'stopCSSCoverage',
      {},
    );
    return PageStopCSSCoverageResult.fromJson(response, connection: connection);
  }

  /// Stop JS coverage
  Future<PageStopJSCoverageResult> channel_stopJSCoverage() async {
    final response = await connection.sendMessageToServer(
      guid,
      'stopJSCoverage',
      {},
    );
    return PageStopJSCoverageResult.fromJson(response, connection: connection);
  }

  /// Tap
  Future<void> channel_touchscreenTap({
    required double x,
    required double y,
  }) async {
    final payload = <String, dynamic>{};
    payload['x'] = x;
    payload['y'] = y;
    final response = await connection.sendMessageToServer(
      guid,
      'touchscreenTap',
      payload,
    );
    return;
  }

  /// Unregister locator handler
  Future<void> channel_unregisterLocatorHandler({required int uid}) async {
    final payload = <String, dynamic>{};
    payload['uid'] = uid;
    final response = await connection.sendMessageToServer(
      guid,
      'unregisterLocatorHandler',
      payload,
    );
    return;
  }

  Future<void> channel_updateSubscription({
    required bool enabled,
    required PageUpdateSubscriptionEventEnum event,
  }) async {
    final payload = <String, dynamic>{};
    payload['enabled'] = enabled;
    payload['event'] = event.value;
    final response = await connection.sendMessageToServer(
      guid,
      'updateSubscription',
      payload,
    );
    return;
  }

  /// Clear WebStorage
  Future<void> channel_webStorageClear({
    required PageWebStorageClearKindEnum kind,
  }) async {
    final payload = <String, dynamic>{};
    payload['kind'] = kind.value;
    final response = await connection.sendMessageToServer(
      guid,
      'webStorageClear',
      payload,
    );
    return;
  }

  /// Get WebStorage item
  Future<PageWebStorageGetItemResult> channel_webStorageGetItem({
    required PageWebStorageGetItemKindEnum kind,
    required String name,
  }) async {
    final payload = <String, dynamic>{};
    payload['kind'] = kind.value;
    payload['name'] = name;
    final response = await connection.sendMessageToServer(
      guid,
      'webStorageGetItem',
      payload,
    );
    return PageWebStorageGetItemResult.fromJson(
      response,
      connection: connection,
    );
  }

  /// Get WebStorage items
  Future<PageWebStorageItemsResult> channel_webStorageItems({
    required PageWebStorageItemsKindEnum kind,
  }) async {
    final payload = <String, dynamic>{};
    payload['kind'] = kind.value;
    final response = await connection.sendMessageToServer(
      guid,
      'webStorageItems',
      payload,
    );
    return PageWebStorageItemsResult.fromJson(response, connection: connection);
  }

  /// Remove WebStorage item
  Future<void> channel_webStorageRemoveItem({
    required PageWebStorageRemoveItemKindEnum kind,
    required String name,
  }) async {
    final payload = <String, dynamic>{};
    payload['kind'] = kind.value;
    payload['name'] = name;
    final response = await connection.sendMessageToServer(
      guid,
      'webStorageRemoveItem',
      payload,
    );
    return;
  }

  /// Set WebStorage item
  Future<void> channel_webStorageSetItem({
    required PageWebStorageSetItemKindEnum kind,
    required String name,
    required String value,
  }) async {
    final payload = <String, dynamic>{};
    payload['kind'] = kind.value;
    payload['name'] = name;
    payload['value'] = value;
    final response = await connection.sendMessageToServer(
      guid,
      'webStorageSetItem',
      payload,
    );
    return;
  }
}

abstract class PlaywrightBase extends ChannelOwner {
  PlaywrightBase(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  PlaywrightInitializer get typedInitializer =>
      PlaywrightInitializer.fromJson(super.initializer, connection: connection);

  /// Create request context
  Future<PlaywrightNewRequestResult> channel_newRequest({
    String? baseURL,
    List<PlaywrightNewRequestClientCertificatesItems>? clientCertificates,
    List<NameValue>? extraHTTPHeaders,
    bool? failOnStatusCode,
    PlaywrightNewRequestHttpCredentials? httpCredentials,
    bool? ignoreHTTPSErrors,
    int? maxRedirects,
    PlaywrightNewRequestProxy? proxy,
    PlaywrightNewRequestStorageState? storageState,
    String? tracesDir,
    String? userAgent,
  }) async {
    final payload = <String, dynamic>{};
    if (baseURL != null) payload['baseURL'] = baseURL;
    if (clientCertificates != null)
      payload['clientCertificates'] = clientCertificates;
    if (extraHTTPHeaders != null)
      payload['extraHTTPHeaders'] = extraHTTPHeaders;
    if (failOnStatusCode != null)
      payload['failOnStatusCode'] = failOnStatusCode;
    if (httpCredentials != null)
      payload['httpCredentials'] = httpCredentials?.toJson();
    if (ignoreHTTPSErrors != null)
      payload['ignoreHTTPSErrors'] = ignoreHTTPSErrors;
    if (maxRedirects != null) payload['maxRedirects'] = maxRedirects;
    if (proxy != null) payload['proxy'] = proxy?.toJson();
    if (storageState != null) payload['storageState'] = storageState?.toJson();
    if (tracesDir != null) payload['tracesDir'] = tracesDir;
    if (userAgent != null) payload['userAgent'] = userAgent;
    final response = await connection.sendMessageToServer(
      guid,
      'newRequest',
      payload,
    );
    return PlaywrightNewRequestResult.fromJson(
      response,
      connection: connection,
    );
  }
}

abstract class RequestBase extends ChannelOwner {
  RequestBase(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  RequestInitializer get typedInitializer =>
      RequestInitializer.fromJson(super.initializer, connection: connection);

  Future<RequestRawRequestHeadersResult> channel_rawRequestHeaders() async {
    final response = await connection.sendMessageToServer(
      guid,
      'rawRequestHeaders',
      {},
    );
    return RequestRawRequestHeadersResult.fromJson(
      response,
      connection: connection,
    );
  }

  Future<RequestResponseResult> channel_response() async {
    final response = await connection.sendMessageToServer(guid, 'response', {});
    return RequestResponseResult.fromJson(response, connection: connection);
  }
}

abstract class ResponseBase extends ChannelOwner {
  ResponseBase(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  ResponseInitializer get typedInitializer =>
      ResponseInitializer.fromJson(super.initializer, connection: connection);

  /// Get response body
  Future<ResponseBodyResult> channel_body() async {
    final response = await connection.sendMessageToServer(guid, 'body', {});
    return ResponseBodyResult.fromJson(response, connection: connection);
  }

  Future<ResponseHttpVersionResult> channel_httpVersion() async {
    final response = await connection.sendMessageToServer(
      guid,
      'httpVersion',
      {},
    );
    return ResponseHttpVersionResult.fromJson(response, connection: connection);
  }

  Future<ResponseRawResponseHeadersResult> channel_rawResponseHeaders() async {
    final response = await connection.sendMessageToServer(
      guid,
      'rawResponseHeaders',
      {},
    );
    return ResponseRawResponseHeadersResult.fromJson(
      response,
      connection: connection,
    );
  }

  Future<ResponseSecurityDetailsResult> channel_securityDetails() async {
    final response = await connection.sendMessageToServer(
      guid,
      'securityDetails',
      {},
    );
    return ResponseSecurityDetailsResult.fromJson(
      response,
      connection: connection,
    );
  }

  Future<ResponseServerAddrResult> channel_serverAddr() async {
    final response = await connection.sendMessageToServer(
      guid,
      'serverAddr',
      {},
    );
    return ResponseServerAddrResult.fromJson(response, connection: connection);
  }

  Future<ResponseSizesResult> channel_sizes() async {
    final response = await connection.sendMessageToServer(guid, 'sizes', {});
    return ResponseSizesResult.fromJson(response, connection: connection);
  }
}

abstract class RootBase extends ChannelOwner {
  RootBase(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  Future<RootInitializeResult> channel_initialize({
    required SDKLanguage sdkLanguage,
  }) async {
    final payload = <String, dynamic>{};
    payload['sdkLanguage'] = sdkLanguage.value;
    final response = await connection.sendMessageToServer(
      guid,
      'initialize',
      payload,
    );
    return RootInitializeResult.fromJson(response, connection: connection);
  }
}

abstract class RouteBase extends ChannelOwner {
  RouteBase(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  RouteInitializer get typedInitializer =>
      RouteInitializer.fromJson(super.initializer, connection: connection);

  /// Abort request
  Future<void> channel_abort({String? errorCode}) async {
    final payload = <String, dynamic>{};
    if (errorCode != null) payload['errorCode'] = errorCode;
    final response = await connection.sendMessageToServer(
      guid,
      'abort',
      payload,
    );
    return;
  }

  /// Continue request
  Future<void> channel_continueValue({
    List<NameValue>? headers,
    required bool isFallback,
    String? method,
    String? postData,
    String? url,
  }) async {
    final payload = <String, dynamic>{};
    if (headers != null) payload['headers'] = headers;
    payload['isFallback'] = isFallback;
    if (method != null) payload['method'] = method;
    if (postData != null) payload['postData'] = postData;
    if (url != null) payload['url'] = url;
    final response = await connection.sendMessageToServer(
      guid,
      'continue',
      payload,
    );
    return;
  }

  /// Fulfill request
  Future<void> channel_fulfill({
    String? body,
    String? fetchResponseUid,
    List<NameValue>? headers,
    bool? isBase64,
    int? status,
  }) async {
    final payload = <String, dynamic>{};
    if (body != null) payload['body'] = body;
    if (fetchResponseUid != null)
      payload['fetchResponseUid'] = fetchResponseUid;
    if (headers != null) payload['headers'] = headers;
    if (isBase64 != null) payload['isBase64'] = isBase64;
    if (status != null) payload['status'] = status;
    final response = await connection.sendMessageToServer(
      guid,
      'fulfill',
      payload,
    );
    return;
  }

  Future<void> channel_redirectNavigationRequest({required String url}) async {
    final payload = <String, dynamic>{};
    payload['url'] = url;
    final response = await connection.sendMessageToServer(
      guid,
      'redirectNavigationRequest',
      payload,
    );
    return;
  }
}

abstract class SocksSupportBase extends ChannelOwner {
  SocksSupportBase(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  Future<void> channel_socksConnected({
    required String host,
    required int port,
    required String uid,
  }) async {
    final payload = <String, dynamic>{};
    payload['host'] = host;
    payload['port'] = port;
    payload['uid'] = uid;
    final response = await connection.sendMessageToServer(
      guid,
      'socksConnected',
      payload,
    );
    return;
  }

  Future<void> channel_socksData({
    required String data,
    required String uid,
  }) async {
    final payload = <String, dynamic>{};
    payload['data'] = data;
    payload['uid'] = uid;
    final response = await connection.sendMessageToServer(
      guid,
      'socksData',
      payload,
    );
    return;
  }

  Future<void> channel_socksEnd({required String uid}) async {
    final payload = <String, dynamic>{};
    payload['uid'] = uid;
    final response = await connection.sendMessageToServer(
      guid,
      'socksEnd',
      payload,
    );
    return;
  }

  Future<void> channel_socksError({
    required String error,
    required String uid,
  }) async {
    final payload = <String, dynamic>{};
    payload['error'] = error;
    payload['uid'] = uid;
    final response = await connection.sendMessageToServer(
      guid,
      'socksError',
      payload,
    );
    return;
  }

  Future<void> channel_socksFailed({
    required String errorCode,
    required String uid,
  }) async {
    final payload = <String, dynamic>{};
    payload['errorCode'] = errorCode;
    payload['uid'] = uid;
    final response = await connection.sendMessageToServer(
      guid,
      'socksFailed',
      payload,
    );
    return;
  }
}

abstract class StreamBase extends ChannelOwner {
  StreamBase(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  Future<void> channel_close() async {
    final response = await connection.sendMessageToServer(guid, 'close', {});
    return;
  }

  Future<StreamReadResult> channel_read({int? size}) async {
    final payload = <String, dynamic>{};
    if (size != null) payload['size'] = size;
    final response = await connection.sendMessageToServer(
      guid,
      'read',
      payload,
    );
    return StreamReadResult.fromJson(response, connection: connection);
  }
}

abstract class TracingBase extends ChannelOwner {
  TracingBase(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  Future<TracingHarExportResult> channel_harExport({
    String? harId,
    required TracingHarExportModeEnum mode,
  }) async {
    final payload = <String, dynamic>{};
    if (harId != null) payload['harId'] = harId;
    payload['mode'] = mode.value;
    final response = await connection.sendMessageToServer(
      guid,
      'harExport',
      payload,
    );
    return TracingHarExportResult.fromJson(response, connection: connection);
  }

  Future<TracingHarStartResult> channel_harStart({
    required RecordHarOptions options,
    PageBase? page,
  }) async {
    final payload = <String, dynamic>{};
    payload['options'] = options.toJson();
    if (page != null) payload['page'] = {'guid': page.guid};
    final response = await connection.sendMessageToServer(
      guid,
      'harStart',
      payload,
    );
    return TracingHarStartResult.fromJson(response, connection: connection);
  }

  /// Trace "{name}"
  Future<void> channel_tracingGroup({
    TracingTracingGroupLocation? location,
    required String name,
  }) async {
    final payload = <String, dynamic>{};
    if (location != null) payload['location'] = location?.toJson();
    payload['name'] = name;
    final response = await connection.sendMessageToServer(
      guid,
      'tracingGroup',
      payload,
    );
    return;
  }

  /// Group end
  Future<void> channel_tracingGroupEnd() async {
    final response = await connection.sendMessageToServer(
      guid,
      'tracingGroupEnd',
      {},
    );
    return;
  }

  /// Start tracing
  Future<void> channel_tracingStart({
    bool? live,
    String? name,
    bool? screenshots,
    bool? snapshots,
  }) async {
    final payload = <String, dynamic>{};
    if (live != null) payload['live'] = live;
    if (name != null) payload['name'] = name;
    if (screenshots != null) payload['screenshots'] = screenshots;
    if (snapshots != null) payload['snapshots'] = snapshots;
    final response = await connection.sendMessageToServer(
      guid,
      'tracingStart',
      payload,
    );
    return;
  }

  /// Start tracing
  Future<TracingTracingStartChunkResult> channel_tracingStartChunk({
    String? name,
    String? title,
  }) async {
    final payload = <String, dynamic>{};
    if (name != null) payload['name'] = name;
    if (title != null) payload['title'] = title;
    final response = await connection.sendMessageToServer(
      guid,
      'tracingStartChunk',
      payload,
    );
    return TracingTracingStartChunkResult.fromJson(
      response,
      connection: connection,
    );
  }

  /// Stop tracing
  Future<void> channel_tracingStop() async {
    final response = await connection.sendMessageToServer(
      guid,
      'tracingStop',
      {},
    );
    return;
  }

  /// Stop tracing
  Future<TracingTracingStopChunkResult> channel_tracingStopChunk({
    required TracingTracingStopChunkModeEnum mode,
  }) async {
    final payload = <String, dynamic>{};
    payload['mode'] = mode.value;
    final response = await connection.sendMessageToServer(
      guid,
      'tracingStopChunk',
      payload,
    );
    return TracingTracingStopChunkResult.fromJson(
      response,
      connection: connection,
    );
  }
}

abstract class WebSocketBase extends ChannelOwner {
  WebSocketBase(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  WebSocketInitializer get typedInitializer =>
      WebSocketInitializer.fromJson(super.initializer, connection: connection);
}

abstract class WebSocketRouteBase extends ChannelOwner {
  WebSocketRouteBase(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  WebSocketRouteInitializer get typedInitializer =>
      WebSocketRouteInitializer.fromJson(
        super.initializer,
        connection: connection,
      );

  Future<void> channel_closePage({
    int? code,
    String? reason,
    required bool wasClean,
  }) async {
    final payload = <String, dynamic>{};
    if (code != null) payload['code'] = code;
    if (reason != null) payload['reason'] = reason;
    payload['wasClean'] = wasClean;
    final response = await connection.sendMessageToServer(
      guid,
      'closePage',
      payload,
    );
    return;
  }

  Future<void> channel_closeServer({
    int? code,
    String? reason,
    required bool wasClean,
  }) async {
    final payload = <String, dynamic>{};
    if (code != null) payload['code'] = code;
    if (reason != null) payload['reason'] = reason;
    payload['wasClean'] = wasClean;
    final response = await connection.sendMessageToServer(
      guid,
      'closeServer',
      payload,
    );
    return;
  }

  /// Connect WebSocket to server
  Future<void> channel_connect() async {
    final response = await connection.sendMessageToServer(guid, 'connect', {});
    return;
  }

  Future<void> channel_ensureOpened() async {
    final response = await connection.sendMessageToServer(
      guid,
      'ensureOpened',
      {},
    );
    return;
  }

  /// Send WebSocket message
  Future<void> channel_sendToPage({
    required bool isBase64,
    required String message,
  }) async {
    final payload = <String, dynamic>{};
    payload['isBase64'] = isBase64;
    payload['message'] = message;
    final response = await connection.sendMessageToServer(
      guid,
      'sendToPage',
      payload,
    );
    return;
  }

  /// Send WebSocket message
  Future<void> channel_sendToServer({
    required bool isBase64,
    required String message,
  }) async {
    final payload = <String, dynamic>{};
    payload['isBase64'] = isBase64;
    payload['message'] = message;
    final response = await connection.sendMessageToServer(
      guid,
      'sendToServer',
      payload,
    );
    return;
  }
}

abstract class WorkerBase extends ChannelOwner {
  WorkerBase(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  WorkerInitializer get typedInitializer =>
      WorkerInitializer.fromJson(super.initializer, connection: connection);

  /// Disconnect from worker
  Future<void> channel_disconnect({String? reason}) async {
    final payload = <String, dynamic>{};
    if (reason != null) payload['reason'] = reason;
    final response = await connection.sendMessageToServer(
      guid,
      'disconnect',
      payload,
    );
    return;
  }

  /// Evaluate
  Future<WorkerEvaluateExpressionResult> channel_evaluateExpression({
    required SerializedArgument arg,
    required String expression,
    bool? isFunction,
  }) async {
    final payload = <String, dynamic>{};
    payload['arg'] = arg.toJson();
    payload['expression'] = expression;
    if (isFunction != null) payload['isFunction'] = isFunction;
    final response = await connection.sendMessageToServer(
      guid,
      'evaluateExpression',
      payload,
    );
    return WorkerEvaluateExpressionResult.fromJson(
      response,
      connection: connection,
    );
  }

  /// Evaluate
  Future<WorkerEvaluateExpressionHandleResult>
  channel_evaluateExpressionHandle({
    required SerializedArgument arg,
    required String expression,
    bool? isFunction,
  }) async {
    final payload = <String, dynamic>{};
    payload['arg'] = arg.toJson();
    payload['expression'] = expression;
    if (isFunction != null) payload['isFunction'] = isFunction;
    final response = await connection.sendMessageToServer(
      guid,
      'evaluateExpressionHandle',
      payload,
    );
    return WorkerEvaluateExpressionHandleResult.fromJson(
      response,
      connection: connection,
    );
  }

  Future<void> channel_updateSubscription({
    required bool enabled,
    required WorkerUpdateSubscriptionEventEnum event,
  }) async {
    final payload = <String, dynamic>{};
    payload['enabled'] = enabled;
    payload['event'] = event.value;
    final response = await connection.sendMessageToServer(
      guid,
      'updateSubscription',
      payload,
    );
    return;
  }
}

abstract class WritableStreamBase extends ChannelOwner {
  WritableStreamBase(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  Future<void> channel_close() async {
    final response = await connection.sendMessageToServer(guid, 'close', {});
    return;
  }

  Future<void> channel_write({required String binary}) async {
    final payload = <String, dynamic>{};
    payload['binary'] = binary;
    final response = await connection.sendMessageToServer(
      guid,
      'write',
      payload,
    );
    return;
  }
}
