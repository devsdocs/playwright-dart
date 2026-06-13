// ignore_for_file: unused_local_variable, unnecessary_null_comparison, unused_field, annotate_overrides, non_constant_identifier_names
// AUTO-GENERATED FILE. DO NOT MODIFY.
// Generated from Playwright protocol.

import '../channel_owner.dart';
import '../connection.dart';

abstract class Channel {}

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

enum ContextOptionsHttpCredentialsPropertiesSendEnum {
  always('always'),
  unauthorized('unauthorized');

  final String value;
  const ContextOptionsHttpCredentialsPropertiesSendEnum(this.value);
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

enum EventTargetWaitForEventInfoInfoPropertiesPhaseEnum {
  before('before'),
  after('after'),
  log('log');

  final String value;
  const EventTargetWaitForEventInfoInfoPropertiesPhaseEnum(this.value);
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

enum PlaywrightNewRequestHttpCredentialsPropertiesSendEnum {
  always('always'),
  unauthorized('unauthorized');

  final String value;
  const PlaywrightNewRequestHttpCredentialsPropertiesSendEnum(this.value);
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

enum SerializedValueTaPropertiesKEnum {
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
  const SerializedValueTaPropertiesKEnum(this.value);
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
      log: ((json['log'] as List?)?.cast<String>()) ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {'log': log};
  }
}

class APIRequestContextFetchResponseBodyResult {
  final String? binary;

  APIRequestContextFetchResponseBodyResult({this.binary});

  factory APIRequestContextFetchResponseBodyResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return APIRequestContextFetchResponseBodyResult(binary: json['binary']);
  }

  Map<String, dynamic> toJson() {
    return {if (binary != null) 'binary': binary};
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
      response: (json['response'] == null
          ? null
          : APIResponse.fromJson(json['response']))!,
    );
  }

  Map<String, dynamic> toJson() {
    return {'response': response};
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
          ((json['cookies'] as List?)
              ?.map((e) => NetworkCookie.fromJson(e))
              .toList()) ??
          [],
      origins:
          ((json['origins'] as List?)
              ?.map((e) => OriginStorage.fromJson(e))
              .toList()) ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {'cookies': cookies, 'origins': origins};
  }
}

class APIResponse {
  final String fetchUid;
  final List<NameValue> headers;
  final int status;
  final String statusText;
  final String url;

  APIResponse({
    required this.fetchUid,
    required this.headers,
    required this.status,
    required this.statusText,
    required this.url,
  });

  factory APIResponse.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return APIResponse(
      fetchUid: (json['fetchUid'])!,
      headers:
          ((json['headers'] as List?)
              ?.map((e) => NameValue.fromJson(e))
              .toList()) ??
          [],
      status: (json['status'])!,
      statusText: (json['statusText'])!,
      url: (json['url'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fetchUid': fetchUid,
      'headers': headers,
      'status': status,
      'statusText': statusText,
      'url': url,
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
      context: (connection != null && json['context'] != null
          ? ChannelOwner.from<BrowserContextBase>(connection, json['context'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {'context': context};
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
      info: (json['info'] == null
          ? null
          : AndroidElementInfo.fromJson(json['info']))!,
    );
  }

  Map<String, dynamic> toJson() {
    return {'info': info};
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
      context: (connection != null && json['context'] != null
          ? ChannelOwner.from<BrowserContextBase>(connection, json['context'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {'context': context};
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
      socket: (connection != null && json['socket'] != null
          ? ChannelOwner.from<AndroidSocketBase>(connection, json['socket'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {'socket': socket};
  }
}

class AndroidDeviceScreenshotResult {
  final String binary;

  AndroidDeviceScreenshotResult({required this.binary});

  factory AndroidDeviceScreenshotResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return AndroidDeviceScreenshotResult(binary: (json['binary'])!);
  }

  Map<String, dynamic> toJson() {
    return {'binary': binary};
  }
}

class AndroidDeviceShellResult {
  final String result;

  AndroidDeviceShellResult({required this.result});

  factory AndroidDeviceShellResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return AndroidDeviceShellResult(result: (json['result'])!);
  }

  Map<String, dynamic> toJson() {
    return {'result': result};
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
              ? (json['devices'] as List?)
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
    return {'devices': devices};
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
      bounds: (json['bounds'] == null ? null : Rect.fromJson(json['bounds']))!,
      checkable: (json['checkable'])!,
      checked: (json['checked'])!,
      children: (json['children'] as List?)
          ?.map((e) => AndroidElementInfo.fromJson(e))
          .toList(),
      clazz: (json['clazz'])!,
      clickable: (json['clickable'])!,
      desc: (json['desc'])!,
      enabled: (json['enabled'])!,
      focusable: (json['focusable'])!,
      focused: (json['focused'])!,
      longClickable: (json['longClickable'])!,
      pkg: (json['pkg'])!,
      res: (json['res'])!,
      scrollable: (json['scrollable'])!,
      selected: (json['selected'])!,
      text: (json['text'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bounds': bounds,
      'checkable': checkable,
      'checked': checked,
      if (children != null) 'children': children,
      'clazz': clazz,
      'clickable': clickable,
      'desc': desc,
      'enabled': enabled,
      'focusable': focusable,
      'focused': focused,
      'longClickable': longClickable,
      'pkg': pkg,
      'res': res,
      'scrollable': scrollable,
      'selected': selected,
      'text': text,
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
  final Map<String, dynamic>? hasChild;
  final Map<String, dynamic>? hasDescendant;
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
      checkable: json['checkable'],
      checked: json['checked'],
      clazz: json['clazz'],
      clickable: json['clickable'],
      depth: json['depth'],
      desc: json['desc'],
      enabled: json['enabled'],
      focusable: json['focusable'],
      focused: json['focused'],
      hasChild: json['hasChild'],
      hasDescendant: json['hasDescendant'],
      longClickable: json['longClickable'],
      pkg: json['pkg'],
      res: json['res'],
      scrollable: json['scrollable'],
      selected: json['selected'],
      text: json['text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (checkable != null) 'checkable': checkable,
      if (checked != null) 'checked': checked,
      if (clazz != null) 'clazz': clazz,
      if (clickable != null) 'clickable': clickable,
      if (depth != null) 'depth': depth,
      if (desc != null) 'desc': desc,
      if (enabled != null) 'enabled': enabled,
      if (focusable != null) 'focusable': focusable,
      if (focused != null) 'focused': focused,
      if (hasChild != null) 'hasChild': hasChild,
      if (hasDescendant != null) 'hasDescendant': hasDescendant,
      if (longClickable != null) 'longClickable': longClickable,
      if (pkg != null) 'pkg': pkg,
      if (res != null) 'res': res,
      if (scrollable != null) 'scrollable': scrollable,
      if (selected != null) 'selected': selected,
      if (text != null) 'text': text,
    };
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
      pid: (json['pid'])!,
      pkg: (json['pkg'])!,
      socketName: (json['socketName'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {'pid': pid, 'pkg': pkg, 'socketName': socketName};
  }
}

class ArtifactFailureResult {
  final String? error;

  ArtifactFailureResult({this.error});

  factory ArtifactFailureResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ArtifactFailureResult(error: json['error']);
  }

  Map<String, dynamic> toJson() {
    return {if (error != null) 'error': error};
  }
}

class ArtifactPathAfterFinishedResult {
  final String value;

  ArtifactPathAfterFinishedResult({required this.value});

  factory ArtifactPathAfterFinishedResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ArtifactPathAfterFinishedResult(value: (json['value'])!);
  }

  Map<String, dynamic> toJson() {
    return {'value': value};
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
      stream: (connection != null && json['stream'] != null
          ? ChannelOwner.from<StreamBase>(connection, json['stream'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {'stream': stream};
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
      stream: (connection != null && json['stream'] != null
          ? ChannelOwner.from<StreamBase>(connection, json['stream'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {'stream': stream};
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
      disposable: (connection != null && json['disposable'] != null
          ? ChannelOwner.from<DisposableBase>(connection, json['disposable'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {'disposable': disposable};
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
          ((json['cookies'] as List?)
              ?.map((e) => NetworkCookie.fromJson(e))
              .toList()) ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {'cookies': cookies};
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
      rootDir: connection != null && json['rootDir'] != null
          ? ChannelOwner.from<WritableStreamBase>(connection, json['rootDir'])
          : null,
      writableStreams:
          (connection != null
              ? (json['writableStreams'] as List?)
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
      if (rootDir != null) 'rootDir': rootDir,
      'writableStreams': writableStreams,
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
      disposable: (connection != null && json['disposable'] != null
          ? ChannelOwner.from<DisposableBase>(connection, json['disposable'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {'disposable': disposable};
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
      session: (connection != null && json['session'] != null
          ? ChannelOwner.from<CDPSessionBase>(connection, json['session'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {'session': session};
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
      page: (connection != null && json['page'] != null
          ? ChannelOwner.from<PageBase>(connection, json['page'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {'page': page};
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
          ((json['cookies'] as List?)
              ?.map((e) => NetworkCookie.fromJson(e))
              .toList()) ??
          [],
      origins:
          ((json['origins'] as List?)
              ?.map((e) => OriginStorage.fromJson(e))
              .toList()) ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {'cookies': cookies, 'origins': origins};
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
      userAgent: (json['userAgent'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {'userAgent': userAgent};
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
      session: (connection != null && json['session'] != null
          ? ChannelOwner.from<CDPSessionBase>(connection, json['session'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {'session': session};
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
      context: (connection != null && json['context'] != null
          ? ChannelOwner.from<BrowserContextBase>(connection, json['context'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {'context': context};
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
      context: (connection != null && json['context'] != null
          ? ChannelOwner.from<BrowserContextBase>(connection, json['context'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {'context': context};
  }
}

class BrowserStartServerResult {
  final String endpoint;

  BrowserStartServerResult({required this.endpoint});

  factory BrowserStartServerResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return BrowserStartServerResult(endpoint: (json['endpoint'])!);
  }

  Map<String, dynamic> toJson() {
    return {'endpoint': endpoint};
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
      artifact: (connection != null && json['artifact'] != null
          ? ChannelOwner.from<ArtifactBase>(connection, json['artifact'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {'artifact': artifact};
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
      browser: (connection != null && json['browser'] != null
          ? ChannelOwner.from<BrowserBase>(connection, json['browser'])
          : null)!,
      defaultContext: connection != null && json['defaultContext'] != null
          ? ChannelOwner.from<BrowserContextBase>(
              connection,
              json['defaultContext'],
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'browser': browser,
      if (defaultContext != null) 'defaultContext': defaultContext,
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
      worker: (connection != null && json['worker'] != null
          ? ChannelOwner.from<WorkerBase>(connection, json['worker'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {'worker': worker};
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
      browser: (connection != null && json['browser'] != null
          ? ChannelOwner.from<BrowserBase>(connection, json['browser'])
          : null)!,
      context: (connection != null && json['context'] != null
          ? ChannelOwner.from<BrowserContextBase>(connection, json['context'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {'browser': browser, 'context': context};
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
      browser: (connection != null && json['browser'] != null
          ? ChannelOwner.from<BrowserBase>(connection, json['browser'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {'browser': browser};
  }
}

class CDPSessionSendResult {
  final Map<String, dynamic> result;

  CDPSessionSendResult({required this.result});

  factory CDPSessionSendResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return CDPSessionSendResult(result: (json['result'])!);
  }

  Map<String, dynamic> toJson() {
    return {'result': result};
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
      id: (json['id'])!,
      stack: (json['stack'] as List?)
          ?.map((e) => StackFrame.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, if (stack != null) 'stack': stack};
  }
}

class CommonScreenshotOptions {
  final CommonScreenshotOptionsAnimationsEnum? animations;
  final CommonScreenshotOptionsCaretEnum? caret;
  final List<Map<String, dynamic>>? mask;
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
      animations: json['animations'] == null
          ? null
          : CommonScreenshotOptionsAnimationsEnum.values.firstWhere(
              (e) => e.value == json['animations'],
            ),
      caret: json['caret'] == null
          ? null
          : CommonScreenshotOptionsCaretEnum.values.firstWhere(
              (e) => e.value == json['caret'],
            ),
      mask: (json['mask'] as List?)?.cast<Map<String, dynamic>>(),
      maskColor: json['maskColor'],
      omitBackground: json['omitBackground'],
      scale: json['scale'] == null
          ? null
          : CommonScreenshotOptionsScaleEnum.values.firstWhere(
              (e) => e.value == json['scale'],
            ),
      style: json['style'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (animations != null) 'animations': animations,
      if (caret != null) 'caret': caret,
      if (mask != null) 'mask': mask,
      if (maskColor != null) 'maskColor': maskColor,
      if (omitBackground != null) 'omitBackground': omitBackground,
      if (scale != null) 'scale': scale,
      if (style != null) 'style': style,
    };
  }
}

class ConsoleMessage {
  final List<JSHandleBase> args;
  final Map<String, dynamic> location;
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
              ? (json['args'] as List?)
                    ?.map((e) => ChannelOwner.from<JSHandleBase>(connection, e))
                    .toList()
              : null) ??
          [],
      location: (json['location'])!,
      text: (json['text'])!,
      timestamp: ((json['timestamp'] as num?)?.toDouble())!,
      type: (json['type'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'args': args,
      'location': location,
      'text': text,
      'timestamp': timestamp,
      'type': type,
    };
  }
}

class ContextOptions {
  final ContextOptionsAcceptDownloadsEnum? acceptDownloads;
  final String? baseURL;
  final bool? bypassCSP;
  final List<Map<String, dynamic>>? clientCertificates;
  final ContextOptionsColorSchemeEnum? colorScheme;
  final ContextOptionsContrastEnum? contrast;
  final double? deviceScaleFactor;
  final List<NameValue>? extraHTTPHeaders;
  final ContextOptionsForcedColorsEnum? forcedColors;
  final Map<String, dynamic>? geolocation;
  final bool? hasTouch;
  final Map<String, dynamic>? httpCredentials;
  final bool? ignoreHTTPSErrors;
  final bool? isMobile;
  final bool? javaScriptEnabled;
  final String? locale;
  final bool? noDefaultViewport;
  final bool? offline;
  final List<String>? permissions;
  final Map<String, dynamic>? recordVideo;
  final ContextOptionsReducedMotionEnum? reducedMotion;
  final Map<String, dynamic>? screen;
  final List<SelectorEngine>? selectorEngines;
  final ContextOptionsServiceWorkersEnum? serviceWorkers;
  final bool? strictSelectors;
  final String? testIdAttributeName;
  final String? timezoneId;
  final String? userAgent;
  final Map<String, dynamic>? viewport;

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
      acceptDownloads: json['acceptDownloads'] == null
          ? null
          : ContextOptionsAcceptDownloadsEnum.values.firstWhere(
              (e) => e.value == json['acceptDownloads'],
            ),
      baseURL: json['baseURL'],
      bypassCSP: json['bypassCSP'],
      clientCertificates: (json['clientCertificates'] as List?)
          ?.cast<Map<String, dynamic>>(),
      colorScheme: json['colorScheme'] == null
          ? null
          : ContextOptionsColorSchemeEnum.values.firstWhere(
              (e) => e.value == json['colorScheme'],
            ),
      contrast: json['contrast'] == null
          ? null
          : ContextOptionsContrastEnum.values.firstWhere(
              (e) => e.value == json['contrast'],
            ),
      deviceScaleFactor: (json['deviceScaleFactor'] as num?)?.toDouble(),
      extraHTTPHeaders: (json['extraHTTPHeaders'] as List?)
          ?.map((e) => NameValue.fromJson(e))
          .toList(),
      forcedColors: json['forcedColors'] == null
          ? null
          : ContextOptionsForcedColorsEnum.values.firstWhere(
              (e) => e.value == json['forcedColors'],
            ),
      geolocation: json['geolocation'],
      hasTouch: json['hasTouch'],
      httpCredentials: json['httpCredentials'],
      ignoreHTTPSErrors: json['ignoreHTTPSErrors'],
      isMobile: json['isMobile'],
      javaScriptEnabled: json['javaScriptEnabled'],
      locale: json['locale'],
      noDefaultViewport: json['noDefaultViewport'],
      offline: json['offline'],
      permissions: (json['permissions'] as List?)?.cast<String>(),
      recordVideo: json['recordVideo'],
      reducedMotion: json['reducedMotion'] == null
          ? null
          : ContextOptionsReducedMotionEnum.values.firstWhere(
              (e) => e.value == json['reducedMotion'],
            ),
      screen: json['screen'],
      selectorEngines: (json['selectorEngines'] as List?)
          ?.map((e) => SelectorEngine.fromJson(e))
          .toList(),
      serviceWorkers: json['serviceWorkers'] == null
          ? null
          : ContextOptionsServiceWorkersEnum.values.firstWhere(
              (e) => e.value == json['serviceWorkers'],
            ),
      strictSelectors: json['strictSelectors'],
      testIdAttributeName: json['testIdAttributeName'],
      timezoneId: json['timezoneId'],
      userAgent: json['userAgent'],
      viewport: json['viewport'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (acceptDownloads != null) 'acceptDownloads': acceptDownloads,
      if (baseURL != null) 'baseURL': baseURL,
      if (bypassCSP != null) 'bypassCSP': bypassCSP,
      if (clientCertificates != null) 'clientCertificates': clientCertificates,
      if (colorScheme != null) 'colorScheme': colorScheme,
      if (contrast != null) 'contrast': contrast,
      if (deviceScaleFactor != null) 'deviceScaleFactor': deviceScaleFactor,
      if (extraHTTPHeaders != null) 'extraHTTPHeaders': extraHTTPHeaders,
      if (forcedColors != null) 'forcedColors': forcedColors,
      if (geolocation != null) 'geolocation': geolocation,
      if (hasTouch != null) 'hasTouch': hasTouch,
      if (httpCredentials != null) 'httpCredentials': httpCredentials,
      if (ignoreHTTPSErrors != null) 'ignoreHTTPSErrors': ignoreHTTPSErrors,
      if (isMobile != null) 'isMobile': isMobile,
      if (javaScriptEnabled != null) 'javaScriptEnabled': javaScriptEnabled,
      if (locale != null) 'locale': locale,
      if (noDefaultViewport != null) 'noDefaultViewport': noDefaultViewport,
      if (offline != null) 'offline': offline,
      if (permissions != null) 'permissions': permissions,
      if (recordVideo != null) 'recordVideo': recordVideo,
      if (reducedMotion != null) 'reducedMotion': reducedMotion,
      if (screen != null) 'screen': screen,
      if (selectorEngines != null) 'selectorEngines': selectorEngines,
      if (serviceWorkers != null) 'serviceWorkers': serviceWorkers,
      if (strictSelectors != null) 'strictSelectors': strictSelectors,
      if (testIdAttributeName != null)
        'testIdAttributeName': testIdAttributeName,
      if (timezoneId != null) 'timezoneId': timezoneId,
      if (userAgent != null) 'userAgent': userAgent,
      if (viewport != null) 'viewport': viewport,
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
      handle: (connection != null && json['handle'] != null
          ? ChannelOwner.from<JSHandleBase>(connection, json['handle'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {'handle': handle};
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
      handle: (connection != null && json['handle'] != null
          ? ChannelOwner.from<JSHandleBase>(connection, json['handle'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {'handle': handle};
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
      value: (json['value'] == null
          ? null
          : SerializedValue.fromJson(json['value']))!,
    );
  }

  Map<String, dynamic> toJson() {
    return {'value': value};
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
          (connection != null && json['electronApplication'] != null
          ? ChannelOwner.from<ElectronApplicationBase>(
              connection,
              json['electronApplication'],
            )
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {'electronApplication': electronApplication};
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
      value: json['value'] == null ? null : Rect.fromJson(json['value']),
    );
  }

  Map<String, dynamic> toJson() {
    return {if (value != null) 'value': value};
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
      frame: connection != null && json['frame'] != null
          ? ChannelOwner.from<FrameBase>(connection, json['frame'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {if (frame != null) 'frame': frame};
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
      value: (json['value'] == null
          ? null
          : SerializedValue.fromJson(json['value']))!,
    );
  }

  Map<String, dynamic> toJson() {
    return {'value': value};
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
      value: (json['value'] == null
          ? null
          : SerializedValue.fromJson(json['value']))!,
    );
  }

  Map<String, dynamic> toJson() {
    return {'value': value};
  }
}

class ElementHandleGetAttributeResult {
  final String? value;

  ElementHandleGetAttributeResult({this.value});

  factory ElementHandleGetAttributeResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ElementHandleGetAttributeResult(value: json['value']);
  }

  Map<String, dynamic> toJson() {
    return {if (value != null) 'value': value};
  }
}

class ElementHandleInnerHTMLResult {
  final String value;

  ElementHandleInnerHTMLResult({required this.value});

  factory ElementHandleInnerHTMLResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ElementHandleInnerHTMLResult(value: (json['value'])!);
  }

  Map<String, dynamic> toJson() {
    return {'value': value};
  }
}

class ElementHandleInnerTextResult {
  final String value;

  ElementHandleInnerTextResult({required this.value});

  factory ElementHandleInnerTextResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ElementHandleInnerTextResult(value: (json['value'])!);
  }

  Map<String, dynamic> toJson() {
    return {'value': value};
  }
}

class ElementHandleInputValueResult {
  final String value;

  ElementHandleInputValueResult({required this.value});

  factory ElementHandleInputValueResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ElementHandleInputValueResult(value: (json['value'])!);
  }

  Map<String, dynamic> toJson() {
    return {'value': value};
  }
}

class ElementHandleIsCheckedResult {
  final bool value;

  ElementHandleIsCheckedResult({required this.value});

  factory ElementHandleIsCheckedResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ElementHandleIsCheckedResult(value: (json['value'])!);
  }

  Map<String, dynamic> toJson() {
    return {'value': value};
  }
}

class ElementHandleIsDisabledResult {
  final bool value;

  ElementHandleIsDisabledResult({required this.value});

  factory ElementHandleIsDisabledResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ElementHandleIsDisabledResult(value: (json['value'])!);
  }

  Map<String, dynamic> toJson() {
    return {'value': value};
  }
}

class ElementHandleIsEditableResult {
  final bool value;

  ElementHandleIsEditableResult({required this.value});

  factory ElementHandleIsEditableResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ElementHandleIsEditableResult(value: (json['value'])!);
  }

  Map<String, dynamic> toJson() {
    return {'value': value};
  }
}

class ElementHandleIsEnabledResult {
  final bool value;

  ElementHandleIsEnabledResult({required this.value});

  factory ElementHandleIsEnabledResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ElementHandleIsEnabledResult(value: (json['value'])!);
  }

  Map<String, dynamic> toJson() {
    return {'value': value};
  }
}

class ElementHandleIsHiddenResult {
  final bool value;

  ElementHandleIsHiddenResult({required this.value});

  factory ElementHandleIsHiddenResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ElementHandleIsHiddenResult(value: (json['value'])!);
  }

  Map<String, dynamic> toJson() {
    return {'value': value};
  }
}

class ElementHandleIsVisibleResult {
  final bool value;

  ElementHandleIsVisibleResult({required this.value});

  factory ElementHandleIsVisibleResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ElementHandleIsVisibleResult(value: (json['value'])!);
  }

  Map<String, dynamic> toJson() {
    return {'value': value};
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
      frame: connection != null && json['frame'] != null
          ? ChannelOwner.from<FrameBase>(connection, json['frame'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {if (frame != null) 'frame': frame};
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
              ? (json['elements'] as List?)
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
    return {'elements': elements};
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
      element: connection != null && json['element'] != null
          ? ChannelOwner.from<ElementHandleBase>(connection, json['element'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {if (element != null) 'element': element};
  }
}

class ElementHandleScreenshotResult {
  final String binary;

  ElementHandleScreenshotResult({required this.binary});

  factory ElementHandleScreenshotResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ElementHandleScreenshotResult(binary: (json['binary'])!);
  }

  Map<String, dynamic> toJson() {
    return {'binary': binary};
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
      values: ((json['values'] as List?)?.cast<String>()) ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {'values': values};
  }
}

class ElementHandleTextContentResult {
  final String? value;

  ElementHandleTextContentResult({this.value});

  factory ElementHandleTextContentResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ElementHandleTextContentResult(value: json['value']);
  }

  Map<String, dynamic> toJson() {
    return {if (value != null) 'value': value};
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
      element: connection != null && json['element'] != null
          ? ChannelOwner.from<ElementHandleBase>(connection, json['element'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {if (element != null) 'element': element};
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
      ignoreCase: json['ignoreCase'],
      matchSubstring: json['matchSubstring'],
      normalizeWhiteSpace: json['normalizeWhiteSpace'],
      regexFlags: json['regexFlags'],
      regexSource: json['regexSource'],
      string: json['string'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (ignoreCase != null) 'ignoreCase': ignoreCase,
      if (matchSubstring != null) 'matchSubstring': matchSubstring,
      if (normalizeWhiteSpace != null)
        'normalizeWhiteSpace': normalizeWhiteSpace,
      if (regexFlags != null) 'regexFlags': regexFlags,
      if (regexSource != null) 'regexSource': regexSource,
      if (string != null) 'string': string,
    };
  }
}

class FormField {
  final Map<String, dynamic>? file;
  final String name;
  final String? value;

  FormField({this.file, required this.name, this.value});

  factory FormField.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return FormField(
      file: json['file'],
      name: (json['name'])!,
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (file != null) 'file': file,
      'name': name,
      if (value != null) 'value': value,
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
      element: (connection != null && json['element'] != null
          ? ChannelOwner.from<ElementHandleBase>(connection, json['element'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {'element': element};
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
      element: (connection != null && json['element'] != null
          ? ChannelOwner.from<ElementHandleBase>(connection, json['element'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {'element': element};
  }
}

class FrameAriaSnapshotResult {
  final String snapshot;

  FrameAriaSnapshotResult({required this.snapshot});

  factory FrameAriaSnapshotResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return FrameAriaSnapshotResult(snapshot: (json['snapshot'])!);
  }

  Map<String, dynamic> toJson() {
    return {'snapshot': snapshot};
  }
}

class FrameContentResult {
  final String value;

  FrameContentResult({required this.value});

  factory FrameContentResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return FrameContentResult(value: (json['value'])!);
  }

  Map<String, dynamic> toJson() {
    return {'value': value};
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
      value: (json['value'] == null
          ? null
          : SerializedValue.fromJson(json['value']))!,
    );
  }

  Map<String, dynamic> toJson() {
    return {'value': value};
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
      value: (json['value'] == null
          ? null
          : SerializedValue.fromJson(json['value']))!,
    );
  }

  Map<String, dynamic> toJson() {
    return {'value': value};
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
      handle: (connection != null && json['handle'] != null
          ? ChannelOwner.from<JSHandleBase>(connection, json['handle'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {'handle': handle};
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
      value: (json['value'] == null
          ? null
          : SerializedValue.fromJson(json['value']))!,
    );
  }

  Map<String, dynamic> toJson() {
    return {'value': value};
  }
}

class FrameExpectResult {
  final String? errorMessage;
  final List<String>? log;
  final bool matches;
  final Map<String, dynamic>? received;
  final bool? timedOut;

  FrameExpectResult({
    this.errorMessage,
    this.log,
    required this.matches,
    this.received,
    this.timedOut,
  });

  factory FrameExpectResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return FrameExpectResult(
      errorMessage: json['errorMessage'],
      log: (json['log'] as List?)?.cast<String>(),
      matches: (json['matches'])!,
      received: json['received'],
      timedOut: json['timedOut'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (errorMessage != null) 'errorMessage': errorMessage,
      if (log != null) 'log': log,
      'matches': matches,
      if (received != null) 'received': received,
      if (timedOut != null) 'timedOut': timedOut,
    };
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
      element: (connection != null && json['element'] != null
          ? ChannelOwner.from<ElementHandleBase>(connection, json['element'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {'element': element};
  }
}

class FrameGetAttributeResult {
  final String? value;

  FrameGetAttributeResult({this.value});

  factory FrameGetAttributeResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return FrameGetAttributeResult(value: json['value']);
  }

  Map<String, dynamic> toJson() {
    return {if (value != null) 'value': value};
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
      response: connection != null && json['response'] != null
          ? ChannelOwner.from<ResponseBase>(connection, json['response'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {if (response != null) 'response': response};
  }
}

class FrameInnerHTMLResult {
  final String value;

  FrameInnerHTMLResult({required this.value});

  factory FrameInnerHTMLResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return FrameInnerHTMLResult(value: (json['value'])!);
  }

  Map<String, dynamic> toJson() {
    return {'value': value};
  }
}

class FrameInnerTextResult {
  final String value;

  FrameInnerTextResult({required this.value});

  factory FrameInnerTextResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return FrameInnerTextResult(value: (json['value'])!);
  }

  Map<String, dynamic> toJson() {
    return {'value': value};
  }
}

class FrameInputValueResult {
  final String value;

  FrameInputValueResult({required this.value});

  factory FrameInputValueResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return FrameInputValueResult(value: (json['value'])!);
  }

  Map<String, dynamic> toJson() {
    return {'value': value};
  }
}

class FrameIsCheckedResult {
  final bool value;

  FrameIsCheckedResult({required this.value});

  factory FrameIsCheckedResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return FrameIsCheckedResult(value: (json['value'])!);
  }

  Map<String, dynamic> toJson() {
    return {'value': value};
  }
}

class FrameIsDisabledResult {
  final bool value;

  FrameIsDisabledResult({required this.value});

  factory FrameIsDisabledResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return FrameIsDisabledResult(value: (json['value'])!);
  }

  Map<String, dynamic> toJson() {
    return {'value': value};
  }
}

class FrameIsEditableResult {
  final bool value;

  FrameIsEditableResult({required this.value});

  factory FrameIsEditableResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return FrameIsEditableResult(value: (json['value'])!);
  }

  Map<String, dynamic> toJson() {
    return {'value': value};
  }
}

class FrameIsEnabledResult {
  final bool value;

  FrameIsEnabledResult({required this.value});

  factory FrameIsEnabledResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return FrameIsEnabledResult(value: (json['value'])!);
  }

  Map<String, dynamic> toJson() {
    return {'value': value};
  }
}

class FrameIsHiddenResult {
  final bool value;

  FrameIsHiddenResult({required this.value});

  factory FrameIsHiddenResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return FrameIsHiddenResult(value: (json['value'])!);
  }

  Map<String, dynamic> toJson() {
    return {'value': value};
  }
}

class FrameIsVisibleResult {
  final bool value;

  FrameIsVisibleResult({required this.value});

  factory FrameIsVisibleResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return FrameIsVisibleResult(value: (json['value'])!);
  }

  Map<String, dynamic> toJson() {
    return {'value': value};
  }
}

class FrameQueryCountResult {
  final int value;

  FrameQueryCountResult({required this.value});

  factory FrameQueryCountResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return FrameQueryCountResult(value: (json['value'])!);
  }

  Map<String, dynamic> toJson() {
    return {'value': value};
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
              ? (json['elements'] as List?)
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
    return {'elements': elements};
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
      element: connection != null && json['element'] != null
          ? ChannelOwner.from<ElementHandleBase>(connection, json['element'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {if (element != null) 'element': element};
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
      resolvedSelector: (json['resolvedSelector'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {'resolvedSelector': resolvedSelector};
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
      values: ((json['values'] as List?)?.cast<String>()) ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {'values': values};
  }
}

class FrameTextContentResult {
  final String? value;

  FrameTextContentResult({this.value});

  factory FrameTextContentResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return FrameTextContentResult(value: json['value']);
  }

  Map<String, dynamic> toJson() {
    return {if (value != null) 'value': value};
  }
}

class FrameTitleResult {
  final String value;

  FrameTitleResult({required this.value});

  factory FrameTitleResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return FrameTitleResult(value: (json['value'])!);
  }

  Map<String, dynamic> toJson() {
    return {'value': value};
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
      handle: (connection != null && json['handle'] != null
          ? ChannelOwner.from<JSHandleBase>(connection, json['handle'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {'handle': handle};
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
      element: connection != null && json['element'] != null
          ? ChannelOwner.from<ElementHandleBase>(connection, json['element'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {if (element != null) 'element': element};
  }
}

class IndexedDBDatabase {
  final String name;
  final List<Map<String, dynamic>> stores;
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
      name: (json['name'])!,
      stores: ((json['stores'] as List?)?.cast<Map<String, dynamic>>()) ?? [],
      version: (json['version'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'stores': stores, 'version': version};
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
      handle: (connection != null && json['handle'] != null
          ? ChannelOwner.from<JSHandleBase>(connection, json['handle'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {'handle': handle};
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
      value: (json['value'] == null
          ? null
          : SerializedValue.fromJson(json['value']))!,
    );
  }

  Map<String, dynamic> toJson() {
    return {'value': value};
  }
}

class JSHandleGetPropertyListResult {
  final List<Map<String, dynamic>> properties;

  JSHandleGetPropertyListResult({required this.properties});

  factory JSHandleGetPropertyListResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return JSHandleGetPropertyListResult(
      properties:
          ((json['properties'] as List?)?.cast<Map<String, dynamic>>()) ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {'properties': properties};
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
      handle: (connection != null && json['handle'] != null
          ? ChannelOwner.from<JSHandleBase>(connection, json['handle'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {'handle': handle};
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
      value: (json['value'] == null
          ? null
          : SerializedValue.fromJson(json['value']))!,
    );
  }

  Map<String, dynamic> toJson() {
    return {'value': value};
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
  final Map<String, dynamic>? firefoxUserPrefs;
  final bool? handleSIGHUP;
  final bool? handleSIGINT;
  final bool? handleSIGTERM;
  final bool? headless;
  final bool? ignoreAllDefaultArgs;
  final List<String>? ignoreDefaultArgs;
  final Map<String, dynamic>? proxy;
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
      args: (json['args'] as List?)?.cast<String>(),
      artifactsDir: json['artifactsDir'],
      cdpPort: json['cdpPort'],
      channel: json['channel'],
      chromiumSandbox: json['chromiumSandbox'],
      downloadsPath: json['downloadsPath'],
      env: (json['env'] as List?)?.map((e) => NameValue.fromJson(e)).toList(),
      executablePath: json['executablePath'],
      firefoxUserPrefs: json['firefoxUserPrefs'],
      handleSIGHUP: json['handleSIGHUP'],
      handleSIGINT: json['handleSIGINT'],
      handleSIGTERM: json['handleSIGTERM'],
      headless: json['headless'],
      ignoreAllDefaultArgs: json['ignoreAllDefaultArgs'],
      ignoreDefaultArgs: (json['ignoreDefaultArgs'] as List?)?.cast<String>(),
      proxy: json['proxy'],
      timeout: ((json['timeout'] as num?)?.toDouble())!,
      tracesDir: json['tracesDir'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (args != null) 'args': args,
      if (artifactsDir != null) 'artifactsDir': artifactsDir,
      if (cdpPort != null) 'cdpPort': cdpPort,
      if (channel != null) 'channel': channel,
      if (chromiumSandbox != null) 'chromiumSandbox': chromiumSandbox,
      if (downloadsPath != null) 'downloadsPath': downloadsPath,
      if (env != null) 'env': env,
      if (executablePath != null) 'executablePath': executablePath,
      if (firefoxUserPrefs != null) 'firefoxUserPrefs': firefoxUserPrefs,
      if (handleSIGHUP != null) 'handleSIGHUP': handleSIGHUP,
      if (handleSIGINT != null) 'handleSIGINT': handleSIGINT,
      if (handleSIGTERM != null) 'handleSIGTERM': handleSIGTERM,
      if (headless != null) 'headless': headless,
      if (ignoreAllDefaultArgs != null)
        'ignoreAllDefaultArgs': ignoreAllDefaultArgs,
      if (ignoreDefaultArgs != null) 'ignoreDefaultArgs': ignoreDefaultArgs,
      if (proxy != null) 'proxy': proxy,
      'timeout': timeout,
      if (tracesDir != null) 'tracesDir': tracesDir,
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
          ((json['headers'] as List?)
              ?.map((e) => NameValue.fromJson(e))
              .toList()) ??
          [],
      pipe: (connection != null && json['pipe'] != null
          ? ChannelOwner.from<JsonPipeBase>(connection, json['pipe'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {'headers': headers, 'pipe': pipe};
  }
}

class LocalUtilsGlobToRegexResult {
  final String regex;

  LocalUtilsGlobToRegexResult({required this.regex});

  factory LocalUtilsGlobToRegexResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return LocalUtilsGlobToRegexResult(regex: (json['regex'])!);
  }

  Map<String, dynamic> toJson() {
    return {'regex': regex};
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
      action: (json['action'] == null
          ? null
          : LocalUtilsHarLookupResultActionEnum.values.firstWhere(
              (e) => e.value == json['action'],
            ))!,
      body: json['body'],
      headers: (json['headers'] as List?)
          ?.map((e) => NameValue.fromJson(e))
          .toList(),
      message: json['message'],
      redirectURL: json['redirectURL'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'action': action,
      if (body != null) 'body': body,
      if (headers != null) 'headers': headers,
      if (message != null) 'message': message,
      if (redirectURL != null) 'redirectURL': redirectURL,
      if (status != null) 'status': status,
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
    return LocalUtilsHarOpenResult(error: json['error'], harId: json['harId']);
  }

  Map<String, dynamic> toJson() {
    return {
      if (error != null) 'error': error,
      if (harId != null) 'harId': harId,
    };
  }
}

class LocalUtilsTracingStartedResult {
  final String stacksId;

  LocalUtilsTracingStartedResult({required this.stacksId});

  factory LocalUtilsTracingStartedResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return LocalUtilsTracingStartedResult(stacksId: (json['stacksId'])!);
  }

  Map<String, dynamic> toJson() {
    return {'stacksId': stacksId};
  }
}

class Metadata {
  final bool? internal;
  final Map<String, dynamic>? location;
  final String? stepId;
  final String? title;

  Metadata({this.internal, this.location, this.stepId, this.title});

  factory Metadata.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return Metadata(
      internal: json['internal'],
      location: json['location'],
      stepId: json['stepId'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (internal != null) 'internal': internal,
      if (location != null) 'location': location,
      if (stepId != null) 'stepId': stepId,
      if (title != null) 'title': title,
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
    return NameValue(name: (json['name'])!, value: (json['value'])!);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'value': value};
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
      crHasCrossSiteAncestor: json['_crHasCrossSiteAncestor'],
      domain: (json['domain'])!,
      expires: ((json['expires'] as num?)?.toDouble())!,
      httpOnly: (json['httpOnly'])!,
      name: (json['name'])!,
      partitionKey: json['partitionKey'],
      path: (json['path'])!,
      sameSite: (json['sameSite'] == null
          ? null
          : NetworkCookieSameSiteEnum.values.firstWhere(
              (e) => e.value == json['sameSite'],
            ))!,
      secure: (json['secure'])!,
      value: (json['value'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (crHasCrossSiteAncestor != null)
        '_crHasCrossSiteAncestor': crHasCrossSiteAncestor,
      'domain': domain,
      'expires': expires,
      'httpOnly': httpOnly,
      'name': name,
      if (partitionKey != null) 'partitionKey': partitionKey,
      'path': path,
      'sameSite': sameSite,
      'secure': secure,
      'value': value,
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
      indexedDB: (json['indexedDB'] as List?)
          ?.map((e) => IndexedDBDatabase.fromJson(e))
          .toList(),
      localStorage:
          ((json['localStorage'] as List?)
              ?.map((e) => NameValue.fromJson(e))
              .toList()) ??
          [],
      origin: (json['origin'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (indexedDB != null) 'indexedDB': indexedDB,
      'localStorage': localStorage,
      'origin': origin,
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
      disposable: (connection != null && json['disposable'] != null
          ? ChannelOwner.from<DisposableBase>(connection, json['disposable'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {'disposable': disposable};
  }
}

class PageConsoleMessagesResult {
  final List<Map<String, dynamic>> messages;

  PageConsoleMessagesResult({required this.messages});

  factory PageConsoleMessagesResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return PageConsoleMessagesResult(
      messages:
          ((json['messages'] as List?)?.cast<Map<String, dynamic>>()) ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {'messages': messages};
  }
}

class PageExpectScreenshotResult {
  final String? actual;
  final String? diff;
  final String? errorMessage;
  final List<String>? log;
  final String? previous;
  final bool? timedOut;

  PageExpectScreenshotResult({
    this.actual,
    this.diff,
    this.errorMessage,
    this.log,
    this.previous,
    this.timedOut,
  });

  factory PageExpectScreenshotResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return PageExpectScreenshotResult(
      actual: json['actual'],
      diff: json['diff'],
      errorMessage: json['errorMessage'],
      log: (json['log'] as List?)?.cast<String>(),
      previous: json['previous'],
      timedOut: json['timedOut'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (actual != null) 'actual': actual,
      if (diff != null) 'diff': diff,
      if (errorMessage != null) 'errorMessage': errorMessage,
      if (log != null) 'log': log,
      if (previous != null) 'previous': previous,
      if (timedOut != null) 'timedOut': timedOut,
    };
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
      disposable: (connection != null && json['disposable'] != null
          ? ChannelOwner.from<DisposableBase>(connection, json['disposable'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {'disposable': disposable};
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
      response: connection != null && json['response'] != null
          ? ChannelOwner.from<ResponseBase>(connection, json['response'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {if (response != null) 'response': response};
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
      response: connection != null && json['response'] != null
          ? ChannelOwner.from<ResponseBase>(connection, json['response'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {if (response != null) 'response': response};
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
          ((json['errors'] as List?)
              ?.map((e) => SerializedError.fromJson(e))
              .toList()) ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {'errors': errors};
  }
}

class PagePdfResult {
  final String pdf;

  PagePdfResult({required this.pdf});

  factory PagePdfResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return PagePdfResult(pdf: (json['pdf'])!);
  }

  Map<String, dynamic> toJson() {
    return {'pdf': pdf};
  }
}

class PagePickLocatorResult {
  final String selector;

  PagePickLocatorResult({required this.selector});

  factory PagePickLocatorResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return PagePickLocatorResult(selector: (json['selector'])!);
  }

  Map<String, dynamic> toJson() {
    return {'selector': selector};
  }
}

class PageRegisterLocatorHandlerResult {
  final int uid;

  PageRegisterLocatorHandlerResult({required this.uid});

  factory PageRegisterLocatorHandlerResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return PageRegisterLocatorHandlerResult(uid: (json['uid'])!);
  }

  Map<String, dynamic> toJson() {
    return {'uid': uid};
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
      response: connection != null && json['response'] != null
          ? ChannelOwner.from<ResponseBase>(connection, json['response'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {if (response != null) 'response': response};
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
              ? (json['requests'] as List?)
                    ?.map((e) => ChannelOwner.from<RequestBase>(connection, e))
                    .toList()
              : null) ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {'requests': requests};
  }
}

class PageScreencastShowOverlayResult {
  final String id;

  PageScreencastShowOverlayResult({required this.id});

  factory PageScreencastShowOverlayResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return PageScreencastShowOverlayResult(id: (json['id'])!);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
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
      artifact: connection != null && json['artifact'] != null
          ? ChannelOwner.from<ArtifactBase>(connection, json['artifact'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {if (artifact != null) 'artifact': artifact};
  }
}

class PageScreenshotResult {
  final String binary;

  PageScreenshotResult({required this.binary});

  factory PageScreenshotResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return PageScreenshotResult(binary: (json['binary'])!);
  }

  Map<String, dynamic> toJson() {
    return {'binary': binary};
  }
}

class PageStopCSSCoverageResult {
  final List<Map<String, dynamic>> entries;

  PageStopCSSCoverageResult({required this.entries});

  factory PageStopCSSCoverageResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return PageStopCSSCoverageResult(
      entries: ((json['entries'] as List?)?.cast<Map<String, dynamic>>()) ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {'entries': entries};
  }
}

class PageStopJSCoverageResult {
  final List<Map<String, dynamic>> entries;

  PageStopJSCoverageResult({required this.entries});

  factory PageStopJSCoverageResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return PageStopJSCoverageResult(
      entries: ((json['entries'] as List?)?.cast<Map<String, dynamic>>()) ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {'entries': entries};
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
      request: (connection != null && json['request'] != null
          ? ChannelOwner.from<APIRequestContextBase>(
              connection,
              json['request'],
            )
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {'request': request};
  }
}

class Point {
  final double x;
  final double y;

  Point({required this.x, required this.y});

  factory Point.fromJson(Map<String, dynamic> json, {Connection? connection}) {
    return Point(
      x: ((json['x'] as num?)?.toDouble())!,
      y: ((json['y'] as num?)?.toDouble())!,
    );
  }

  Map<String, dynamic> toJson() {
    return {'x': x, 'y': y};
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
      content: json['content'] == null
          ? null
          : RecordHarOptionsContentEnum.values.firstWhere(
              (e) => e.value == json['content'],
            ),
      harPath: json['harPath'],
      mode: json['mode'] == null
          ? null
          : RecordHarOptionsModeEnum.values.firstWhere(
              (e) => e.value == json['mode'],
            ),
      resourcesDir: json['resourcesDir'],
      urlGlob: json['urlGlob'],
      urlRegexFlags: json['urlRegexFlags'],
      urlRegexSource: json['urlRegexSource'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (content != null) 'content': content,
      if (harPath != null) 'harPath': harPath,
      if (mode != null) 'mode': mode,
      if (resourcesDir != null) 'resourcesDir': resourcesDir,
      if (urlGlob != null) 'urlGlob': urlGlob,
      if (urlRegexFlags != null) 'urlRegexFlags': urlRegexFlags,
      if (urlRegexSource != null) 'urlRegexSource': urlRegexSource,
    };
  }
}

class RecorderSource {
  final String? group;
  final List<Map<String, dynamic>> highlight;
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
      group: json['group'],
      highlight:
          ((json['highlight'] as List?)?.cast<Map<String, dynamic>>()) ?? [],
      id: (json['id'])!,
      isRecorded: (json['isRecorded'])!,
      label: (json['label'])!,
      language: (json['language'])!,
      revealLine: json['revealLine'],
      text: (json['text'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (group != null) 'group': group,
      'highlight': highlight,
      'id': id,
      'isRecorded': isRecorded,
      'label': label,
      'language': language,
      if (revealLine != null) 'revealLine': revealLine,
      'text': text,
    };
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
      height: ((json['height'] as num?)?.toDouble())!,
      width: ((json['width'] as num?)?.toDouble())!,
      x: ((json['x'] as num?)?.toDouble())!,
      y: ((json['y'] as num?)?.toDouble())!,
    );
  }

  Map<String, dynamic> toJson() {
    return {'height': height, 'width': width, 'x': x, 'y': y};
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
    return RemoteAddr(ipAddress: (json['ipAddress'])!, port: (json['port'])!);
  }

  Map<String, dynamic> toJson() {
    return {'ipAddress': ipAddress, 'port': port};
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
          ((json['headers'] as List?)
              ?.map((e) => NameValue.fromJson(e))
              .toList()) ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {'headers': headers};
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
      response: connection != null && json['response'] != null
          ? ChannelOwner.from<ResponseBase>(connection, json['response'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {if (response != null) 'response': response};
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
      requestBodySize: (json['requestBodySize'])!,
      requestHeadersSize: (json['requestHeadersSize'])!,
      responseBodySize: (json['responseBodySize'])!,
      responseHeadersSize: (json['responseHeadersSize'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'requestBodySize': requestBodySize,
      'requestHeadersSize': requestHeadersSize,
      'responseBodySize': responseBodySize,
      'responseHeadersSize': responseHeadersSize,
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
      connectEnd: ((json['connectEnd'] as num?)?.toDouble())!,
      connectStart: ((json['connectStart'] as num?)?.toDouble())!,
      domainLookupEnd: ((json['domainLookupEnd'] as num?)?.toDouble())!,
      domainLookupStart: ((json['domainLookupStart'] as num?)?.toDouble())!,
      requestStart: ((json['requestStart'] as num?)?.toDouble())!,
      responseStart: ((json['responseStart'] as num?)?.toDouble())!,
      secureConnectionStart: ((json['secureConnectionStart'] as num?)
          ?.toDouble())!,
      startTime: ((json['startTime'] as num?)?.toDouble())!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'connectEnd': connectEnd,
      'connectStart': connectStart,
      'domainLookupEnd': domainLookupEnd,
      'domainLookupStart': domainLookupStart,
      'requestStart': requestStart,
      'responseStart': responseStart,
      'secureConnectionStart': secureConnectionStart,
      'startTime': startTime,
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
    return ResponseBodyResult(binary: (json['binary'])!);
  }

  Map<String, dynamic> toJson() {
    return {'binary': binary};
  }
}

class ResponseHttpVersionResult {
  final String value;

  ResponseHttpVersionResult({required this.value});

  factory ResponseHttpVersionResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ResponseHttpVersionResult(value: (json['value'])!);
  }

  Map<String, dynamic> toJson() {
    return {'value': value};
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
          ((json['headers'] as List?)
              ?.map((e) => NameValue.fromJson(e))
              .toList()) ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {'headers': headers};
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
      value: json['value'] == null
          ? null
          : SecurityDetails.fromJson(json['value']),
    );
  }

  Map<String, dynamic> toJson() {
    return {if (value != null) 'value': value};
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
      value: json['value'] == null ? null : RemoteAddr.fromJson(json['value']),
    );
  }

  Map<String, dynamic> toJson() {
    return {if (value != null) 'value': value};
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
      sizes: (json['sizes'] == null
          ? null
          : RequestSizes.fromJson(json['sizes']))!,
    );
  }

  Map<String, dynamic> toJson() {
    return {'sizes': sizes};
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
      playwright: (connection != null && json['playwright'] != null
          ? ChannelOwner.from<PlaywrightBase>(connection, json['playwright'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {'playwright': playwright};
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
      issuer: json['issuer'],
      protocol: json['protocol'],
      subjectName: json['subjectName'],
      validFrom: (json['validFrom'] as num?)?.toDouble(),
      validTo: (json['validTo'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (issuer != null) 'issuer': issuer,
      if (protocol != null) 'protocol': protocol,
      if (subjectName != null) 'subjectName': subjectName,
      if (validFrom != null) 'validFrom': validFrom,
      if (validTo != null) 'validTo': validTo,
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
      contentScript: json['contentScript'],
      name: (json['name'])!,
      source: (json['source'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (contentScript != null) 'contentScript': contentScript,
      'name': name,
      'source': source,
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
              ? (json['handles'] as List?)
                    ?.map((e) => ChannelOwner.from<ChannelOwner>(connection, e))
                    .toList()
              : null) ??
          [],
      value: (json['value'] == null
          ? null
          : SerializedValue.fromJson(json['value']))!,
    );
  }

  Map<String, dynamic> toJson() {
    return {'handles': handles, 'value': value};
  }
}

class SerializedError {
  final Map<String, dynamic>? error;
  final SerializedValue? value;

  SerializedError({this.error, this.value});

  factory SerializedError.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return SerializedError(
      error: json['error'],
      value: json['value'] == null
          ? null
          : SerializedValue.fromJson(json['value']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (error != null) 'error': error,
      if (value != null) 'value': value,
    };
  }
}

class SerializedValue {
  final List<SerializedValue>? a;
  final bool? b;
  final String? bi;
  final String? d;
  final Map<String, dynamic>? e;
  final int? h;
  final int? id;
  final double? n;
  final List<Map<String, dynamic>>? o;
  final Map<String, dynamic>? r;
  final int? ref;
  final String? s;
  final Map<String, dynamic>? ta;
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
      a: (json['a'] as List?)?.map((e) => SerializedValue.fromJson(e)).toList(),
      b: json['b'],
      bi: json['bi'],
      d: json['d'],
      e: json['e'],
      h: json['h'],
      id: json['id'],
      n: (json['n'] as num?)?.toDouble(),
      o: (json['o'] as List?)?.cast<Map<String, dynamic>>(),
      r: json['r'],
      ref: json['ref'],
      s: json['s'],
      ta: json['ta'],
      u: json['u'],
      v: json['v'] == null
          ? null
          : SerializedValueVEnum.values.firstWhere((e) => e.value == json['v']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (a != null) 'a': a,
      if (b != null) 'b': b,
      if (bi != null) 'bi': bi,
      if (d != null) 'd': d,
      if (e != null) 'e': e,
      if (h != null) 'h': h,
      if (id != null) 'id': id,
      if (n != null) 'n': n,
      if (o != null) 'o': o,
      if (r != null) 'r': r,
      if (ref != null) 'ref': ref,
      if (s != null) 's': s,
      if (ta != null) 'ta': ta,
      if (u != null) 'u': u,
      if (v != null) 'v': v,
    };
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
      crHasCrossSiteAncestor: json['_crHasCrossSiteAncestor'],
      domain: json['domain'],
      expires: (json['expires'] as num?)?.toDouble(),
      httpOnly: json['httpOnly'],
      name: (json['name'])!,
      partitionKey: json['partitionKey'],
      path: json['path'],
      sameSite: json['sameSite'] == null
          ? null
          : SetNetworkCookieSameSiteEnum.values.firstWhere(
              (e) => e.value == json['sameSite'],
            ),
      secure: json['secure'],
      url: json['url'],
      value: (json['value'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (crHasCrossSiteAncestor != null)
        '_crHasCrossSiteAncestor': crHasCrossSiteAncestor,
      if (domain != null) 'domain': domain,
      if (expires != null) 'expires': expires,
      if (httpOnly != null) 'httpOnly': httpOnly,
      'name': name,
      if (partitionKey != null) 'partitionKey': partitionKey,
      if (path != null) 'path': path,
      if (sameSite != null) 'sameSite': sameSite,
      if (secure != null) 'secure': secure,
      if (url != null) 'url': url,
      'value': value,
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
      indexedDB: (json['indexedDB'] as List?)
          ?.map((e) => IndexedDBDatabase.fromJson(e))
          .toList(),
      localStorage:
          ((json['localStorage'] as List?)
              ?.map((e) => NameValue.fromJson(e))
              .toList()) ??
          [],
      origin: (json['origin'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (indexedDB != null) 'indexedDB': indexedDB,
      'localStorage': localStorage,
      'origin': origin,
    };
  }
}

class ShowActionsOptions {
  final double? duration;
  final int? fontSize;
  final ShowActionsOptionsPositionEnum? position;

  ShowActionsOptions({this.duration, this.fontSize, this.position});

  factory ShowActionsOptions.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return ShowActionsOptions(
      duration: (json['duration'] as num?)?.toDouble(),
      fontSize: json['fontSize'],
      position: json['position'] == null
          ? null
          : ShowActionsOptionsPositionEnum.values.firstWhere(
              (e) => e.value == json['position'],
            ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (duration != null) 'duration': duration,
      if (fontSize != null) 'fontSize': fontSize,
      if (position != null) 'position': position,
    };
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
      column: (json['column'])!,
      file: (json['file'])!,
      function: json['function'],
      line: (json['line'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'column': column,
      'file': file,
      if (function != null) 'function': function,
      'line': line,
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
    return StreamReadResult(binary: (json['binary'])!);
  }

  Map<String, dynamic> toJson() {
    return {'binary': binary};
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
      artifact: connection != null && json['artifact'] != null
          ? ChannelOwner.from<ArtifactBase>(connection, json['artifact'])
          : null,
      entries: (json['entries'] as List?)
          ?.map((e) => NameValue.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (artifact != null) 'artifact': artifact,
      if (entries != null) 'entries': entries,
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
    return TracingHarStartResult(harId: (json['harId'])!);
  }

  Map<String, dynamic> toJson() {
    return {'harId': harId};
  }
}

class TracingTracingStartChunkResult {
  final String traceName;

  TracingTracingStartChunkResult({required this.traceName});

  factory TracingTracingStartChunkResult.fromJson(
    Map<String, dynamic> json, {
    Connection? connection,
  }) {
    return TracingTracingStartChunkResult(traceName: (json['traceName'])!);
  }

  Map<String, dynamic> toJson() {
    return {'traceName': traceName};
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
      artifact: connection != null && json['artifact'] != null
          ? ChannelOwner.from<ArtifactBase>(connection, json['artifact'])
          : null,
      entries: (json['entries'] as List?)
          ?.map((e) => NameValue.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (artifact != null) 'artifact': artifact,
      if (entries != null) 'entries': entries,
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
      hash: (json['hash'])!,
      hostname: (json['hostname'])!,
      password: (json['password'])!,
      pathname: (json['pathname'])!,
      port: (json['port'])!,
      protocol: (json['protocol'])!,
      search: (json['search'])!,
      username: (json['username'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hash': hash,
      'hostname': hostname,
      'password': password,
      'pathname': pathname,
      'port': port,
      'protocol': protocol,
      'search': search,
      'username': username,
    };
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
      handle: (connection != null && json['handle'] != null
          ? ChannelOwner.from<JSHandleBase>(connection, json['handle'])
          : null)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {'handle': handle};
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
      value: (json['value'] == null
          ? null
          : SerializedValue.fromJson(json['value']))!,
    );
  }

  Map<String, dynamic> toJson() {
    return {'value': value};
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
    if (failOnStatusCode != null) {
      payload['failOnStatusCode'] = failOnStatusCode;
    }
    if (formData != null) payload['formData'] = formData;
    if (headers != null) payload['headers'] = headers;
    if (ignoreHTTPSErrors != null) {
      payload['ignoreHTTPSErrors'] = ignoreHTTPSErrors;
    }
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
    if (omitDriverInstall != null) {
      payload['omitDriverInstall'] = omitDriverInstall;
    }
    if (port != null) payload['port'] = port;
    final response = await connection.sendMessageToServer(
      guid,
      'devices',
      payload,
    );
    return AndroidDevicesResult.fromJson(response, connection: connection);
  }
}

abstract class AndroidDeviceBase extends EventTargetBase {
  AndroidDeviceBase(
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

  Future<AndroidDeviceLaunchBrowserResult> channel_launchBrowser({
    required ContextOptions mixinValue,
    List<String>? args,
    String? pkg,
    Map<String, dynamic>? proxy,
  }) async {
    final payload = <String, dynamic>{};
    payload.addAll(mixinValue.toJson());
    if (args != null) payload['args'] = args;
    if (pkg != null) payload['pkg'] = pkg;
    if (proxy != null) payload['proxy'] = proxy;
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

  Future<void> channel_wait({
    required AndroidSelector androidSelector,
    AndroidDeviceWaitStateEnum? state,
    required double timeout,
  }) async {
    final payload = <String, dynamic>{};
    payload['androidSelector'] = androidSelector.toJson();
    if (state != null) payload['state'] = state.value;
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

  Future<BrowserNewContextResult> channel_newContext({
    required ContextOptions mixinValue,
    Map<String, dynamic>? proxy,
    Map<String, dynamic>? storageState,
  }) async {
    final payload = <String, dynamic>{};
    payload.addAll(mixinValue.toJson());
    if (proxy != null) payload['proxy'] = proxy;
    if (storageState != null) payload['storageState'] = storageState;
    final response = await connection.sendMessageToServer(
      guid,
      'newContext',
      payload,
    );
    return BrowserNewContextResult.fromJson(response, connection: connection);
  }

  Future<BrowserNewContextForReuseResult> channel_newContextForReuse({
    required ContextOptions mixinValue,
    Map<String, dynamic>? proxy,
    Map<String, dynamic>? storageState,
  }) async {
    final payload = <String, dynamic>{};
    payload.addAll(mixinValue.toJson());
    if (proxy != null) payload['proxy'] = proxy;
    if (storageState != null) payload['storageState'] = storageState;
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

  Future<BrowserStartServerResult> channel_startServer({
    String? host,
    Map<String, dynamic>? metadata,
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

  Future<void> channel_stopServer() async {
    final response = await connection.sendMessageToServer(
      guid,
      'stopServer',
      {},
    );
    return;
  }

  Future<BrowserStopTracingResult> channel_stopTracing() async {
    final response = await connection.sendMessageToServer(
      guid,
      'stopTracing',
      {},
    );
    return BrowserStopTracingResult.fromJson(response, connection: connection);
  }
}

abstract class BrowserContextBase extends EventTargetBase {
  BrowserContextBase(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

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
    if (domainRegexFlags != null) {
      payload['domainRegexFlags'] = domainRegexFlags;
    }
    if (domainRegexSource != null) {
      payload['domainRegexSource'] = domainRegexSource;
    }
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

  Future<void> channel_clearPermissions() async {
    final response = await connection.sendMessageToServer(
      guid,
      'clearPermissions',
      {},
    );
    return;
  }

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

  Future<void> channel_clockResume() async {
    final response = await connection.sendMessageToServer(
      guid,
      'clockResume',
      {},
    );
    return;
  }

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
    required List<Map<String, dynamic>> items,
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

  Future<void> channel_disableRecorder() async {
    final response = await connection.sendMessageToServer(
      guid,
      'disableRecorder',
      {},
    );
    return;
  }

  Future<void> channel_enableRecorder({
    Map<String, dynamic>? contextOptions,
    String? device,
    bool? handleSIGINT,
    String? language,
    Map<String, dynamic>? launchOptions,
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
    if (mode != null) payload['mode'] = mode.value;
    if (omitCallTracking != null) {
      payload['omitCallTracking'] = omitCallTracking;
    }
    if (outputFile != null) payload['outputFile'] = outputFile;
    if (pauseOnNextStatement != null) {
      payload['pauseOnNextStatement'] = pauseOnNextStatement;
    }
    if (recorderMode != null) payload['recorderMode'] = recorderMode.value;
    if (saveStorage != null) payload['saveStorage'] = saveStorage;
    if (testIdAttributeName != null) {
      payload['testIdAttributeName'] = testIdAttributeName;
    }
    final response = await connection.sendMessageToServer(
      guid,
      'enableRecorder',
      payload,
    );
    return;
  }

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

  Future<BrowserContextNewPageResult> channel_newPage() async {
    final response = await connection.sendMessageToServer(guid, 'newPage', {});
    return BrowserContextNewPageResult.fromJson(
      response,
      connection: connection,
    );
  }

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

  Future<void> channel_setGeolocation({
    Map<String, dynamic>? geolocation,
  }) async {
    final payload = <String, dynamic>{};
    if (geolocation != null) payload['geolocation'] = geolocation;
    final response = await connection.sendMessageToServer(
      guid,
      'setGeolocation',
      payload,
    );
    return;
  }

  Future<void> channel_setHTTPCredentials({
    Map<String, dynamic>? httpCredentials,
  }) async {
    final payload = <String, dynamic>{};
    if (httpCredentials != null) payload['httpCredentials'] = httpCredentials;
    final response = await connection.sendMessageToServer(
      guid,
      'setHTTPCredentials',
      payload,
    );
    return;
  }

  Future<void> channel_setNetworkInterceptionPatterns({
    required List<Map<String, dynamic>> patterns,
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

  Future<void> channel_setStorageState({
    Map<String, dynamic>? storageState,
  }) async {
    final payload = <String, dynamic>{};
    if (storageState != null) payload['storageState'] = storageState;
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

  Future<void> channel_setWebSocketInterceptionPatterns({
    required List<Map<String, dynamic>> patterns,
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

  Future<BrowserTypeConnectOverCDPResult> channel_connectOverCDP({
    required String endpointURL,
    List<NameValue>? headers,
    bool? isLocal,
    bool? noDefaults,
    double? slowMo,
    required double timeout,
  }) async {
    final payload = <String, dynamic>{};
    payload['endpointURL'] = endpointURL;
    if (headers != null) payload['headers'] = headers;
    if (isLocal != null) payload['isLocal'] = isLocal;
    if (noDefaults != null) payload['noDefaults'] = noDefaults;
    if (slowMo != null) payload['slowMo'] = slowMo;
    payload['timeout'] = timeout;
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

  Future<BrowserTypeLaunchResult> channel_launch({
    required LaunchOptions mixinValue,
    double? slowMo,
  }) async {
    final payload = <String, dynamic>{};
    payload.addAll(mixinValue.toJson());
    if (slowMo != null) payload['slowMo'] = slowMo;
    final response = await connection.sendMessageToServer(
      guid,
      'launch',
      payload,
    );
    return BrowserTypeLaunchResult.fromJson(response, connection: connection);
  }

  Future<BrowserTypeLaunchPersistentContextResult>
  channel_launchPersistentContext({
    required LaunchOptions mixin1Value,
    required ContextOptions mixin2Value,
    double? slowMo,
    required String userDataDir,
  }) async {
    final payload = <String, dynamic>{};
    payload.addAll(mixin1Value.toJson());
    payload.addAll(mixin2Value.toJson());
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

  Future<void> channel_detach() async {
    final response = await connection.sendMessageToServer(guid, 'detach', {});
    return;
  }

  Future<CDPSessionSendResult> channel_send({
    required String method,
    Map<String, dynamic>? params,
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
    String? selector,
  }) async {
    final payload = <String, dynamic>{};
    if (ariaTemplate != null) payload['ariaTemplate'] = ariaTemplate;
    if (selector != null) payload['selector'] = selector;
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
    if (generateAutoExpect != null) {
      payload['generateAutoExpect'] = generateAutoExpect;
    }
    payload['mode'] = mode.value;
    if (testIdAttributeName != null) {
      payload['testIdAttributeName'] = testIdAttributeName;
    }
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

abstract class DebuggerBase extends EventTargetBase {
  DebuggerBase(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  Future<void> channel_next() async {
    final response = await connection.sendMessageToServer(guid, 'next', {});
    return;
  }

  Future<void> channel_requestPause() async {
    final response = await connection.sendMessageToServer(
      guid,
      'requestPause',
      {},
    );
    return;
  }

  Future<void> channel_resume() async {
    final response = await connection.sendMessageToServer(guid, 'resume', {});
    return;
  }

  Future<void> channel_runTo({required Map<String, dynamic> location}) async {
    final payload = <String, dynamic>{};
    payload['location'] = location;
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
    Map<String, dynamic>? geolocation,
    Map<String, dynamic>? httpCredentials,
    bool? ignoreHTTPSErrors,
    String? locale,
    bool? offline,
    Map<String, dynamic>? recordVideo,
    List<SelectorEngine>? selectorEngines,
    bool? strictSelectors,
    String? testIdAttributeName,
    required double timeout,
    String? timezoneId,
    String? tracesDir,
  }) async {
    final payload = <String, dynamic>{};
    if (acceptDownloads != null) {
      payload['acceptDownloads'] = acceptDownloads.value;
    }
    if (args != null) payload['args'] = args;
    if (artifactsDir != null) payload['artifactsDir'] = artifactsDir;
    if (bypassCSP != null) payload['bypassCSP'] = bypassCSP;
    if (chromiumSandbox != null) payload['chromiumSandbox'] = chromiumSandbox;
    if (colorScheme != null) payload['colorScheme'] = colorScheme.value;
    if (cwd != null) payload['cwd'] = cwd;
    if (env != null) payload['env'] = env;
    if (executablePath != null) payload['executablePath'] = executablePath;
    if (extraHTTPHeaders != null) {
      payload['extraHTTPHeaders'] = extraHTTPHeaders;
    }
    if (geolocation != null) payload['geolocation'] = geolocation;
    if (httpCredentials != null) payload['httpCredentials'] = httpCredentials;
    if (ignoreHTTPSErrors != null) {
      payload['ignoreHTTPSErrors'] = ignoreHTTPSErrors;
    }
    if (locale != null) payload['locale'] = locale;
    if (offline != null) payload['offline'] = offline;
    if (recordVideo != null) payload['recordVideo'] = recordVideo;
    if (selectorEngines != null) payload['selectorEngines'] = selectorEngines;
    if (strictSelectors != null) payload['strictSelectors'] = strictSelectors;
    if (testIdAttributeName != null) {
      payload['testIdAttributeName'] = testIdAttributeName;
    }
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

abstract class ElectronApplicationBase extends EventTargetBase {
  ElectronApplicationBase(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

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

  Future<void> channel_check({
    bool? force,
    Point? position,
    required double timeout,
    bool? trial,
  }) async {
    final payload = <String, dynamic>{};
    if (force != null) payload['force'] = force;
    if (position != null) payload['position'] = position.toJson();
    payload['timeout'] = timeout;
    if (trial != null) payload['trial'] = trial;
    final response = await connection.sendMessageToServer(
      guid,
      'check',
      payload,
    );
    return;
  }

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
    if (button != null) payload['button'] = button.value;
    if (clickCount != null) payload['clickCount'] = clickCount;
    if (delay != null) payload['delay'] = delay;
    if (force != null) payload['force'] = force;
    if (modifiers != null) payload['modifiers'] = modifiers;
    if (noWaitAfter != null) payload['noWaitAfter'] = noWaitAfter;
    if (position != null) payload['position'] = position.toJson();
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
    if (button != null) payload['button'] = button.value;
    if (delay != null) payload['delay'] = delay;
    if (force != null) payload['force'] = force;
    if (modifiers != null) payload['modifiers'] = modifiers;
    if (position != null) payload['position'] = position.toJson();
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

  Future<ElementHandleEvalOnSelectorResult> channel_evalOnSelector({
    required SerializedArgument arg,
    required String expression,
    bool? isFunction,
    required String selector,
    bool? strict,
  }) async {
    final payload = <String, dynamic>{};
    payload['arg'] = arg.toJson();
    payload['expression'] = expression;
    if (isFunction != null) payload['isFunction'] = isFunction;
    payload['selector'] = selector;
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

  Future<ElementHandleEvalOnSelectorAllResult> channel_evalOnSelectorAll({
    required SerializedArgument arg,
    required String expression,
    bool? isFunction,
    required String selector,
  }) async {
    final payload = <String, dynamic>{};
    payload['arg'] = arg.toJson();
    payload['expression'] = expression;
    if (isFunction != null) payload['isFunction'] = isFunction;
    payload['selector'] = selector;
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

  Future<void> channel_focus() async {
    final response = await connection.sendMessageToServer(guid, 'focus', {});
    return;
  }

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
    if (position != null) payload['position'] = position.toJson();
    payload['timeout'] = timeout;
    if (trial != null) payload['trial'] = trial;
    final response = await connection.sendMessageToServer(
      guid,
      'hover',
      payload,
    );
    return;
  }

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

  Future<ElementHandleIsHiddenResult> channel_isHidden() async {
    final response = await connection.sendMessageToServer(guid, 'isHidden', {});
    return ElementHandleIsHiddenResult.fromJson(
      response,
      connection: connection,
    );
  }

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

  Future<ElementHandleQuerySelectorResult> channel_querySelector({
    required String selector,
    bool? strict,
  }) async {
    final payload = <String, dynamic>{};
    payload['selector'] = selector;
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

  Future<ElementHandleQuerySelectorAllResult> channel_querySelectorAll({
    required String selector,
  }) async {
    final payload = <String, dynamic>{};
    payload['selector'] = selector;
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

  Future<ElementHandleScreenshotResult> channel_screenshot({
    required CommonScreenshotOptions mixinValue,
    int? quality,
    required double timeout,
    ElementHandleScreenshotTypeEnum? type,
  }) async {
    final payload = <String, dynamic>{};
    payload.addAll(mixinValue.toJson());
    if (quality != null) payload['quality'] = quality;
    payload['timeout'] = timeout;
    if (type != null) payload['type'] = type.value;
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

  Future<ElementHandleSelectOptionResult> channel_selectOption({
    List<ElementHandleBase>? elements,
    bool? force,
    List<Map<String, dynamic>>? options,
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

  Future<void> channel_setInputFiles({
    WritableStreamBase? directoryStream,
    String? localDirectory,
    List<String>? localPaths,
    List<Map<String, dynamic>>? payloads,
    List<WritableStreamBase>? streams,
    required double timeout,
  }) async {
    final payload = <String, dynamic>{};
    if (directoryStream != null) {
      payload['directoryStream'] = {'guid': directoryStream.guid};
    }
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
    if (position != null) payload['position'] = position.toJson();
    payload['timeout'] = timeout;
    if (trial != null) payload['trial'] = trial;
    final response = await connection.sendMessageToServer(guid, 'tap', payload);
    return;
  }

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

  Future<void> channel_uncheck({
    bool? force,
    Point? position,
    required double timeout,
    bool? trial,
  }) async {
    final payload = <String, dynamic>{};
    if (force != null) payload['force'] = force;
    if (position != null) payload['position'] = position.toJson();
    payload['timeout'] = timeout;
    if (trial != null) payload['trial'] = trial;
    final response = await connection.sendMessageToServer(
      guid,
      'uncheck',
      payload,
    );
    return;
  }

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

  Future<ElementHandleWaitForSelectorResult> channel_waitForSelector({
    required String selector,
    ElementHandleWaitForSelectorStateEnum? state,
    bool? strict,
    required double timeout,
  }) async {
    final payload = <String, dynamic>{};
    payload['selector'] = selector;
    if (state != null) payload['state'] = state.value;
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

abstract class EventTargetBase extends ChannelOwner {
  EventTargetBase(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  Future<void> channel_waitForEventInfo({
    required Map<String, dynamic> info,
  }) async {
    final payload = <String, dynamic>{};
    payload['info'] = info;
    final response = await connection.sendMessageToServer(
      guid,
      'waitForEventInfo',
      payload,
    );
    return;
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

  Future<FrameAriaSnapshotResult> channel_ariaSnapshot({
    bool? boxes,
    int? depth,
    FrameAriaSnapshotModeEnum? mode,
    String? selector,
    required double timeout,
    String? track,
  }) async {
    final payload = <String, dynamic>{};
    if (boxes != null) payload['boxes'] = boxes;
    if (depth != null) payload['depth'] = depth;
    if (mode != null) payload['mode'] = mode.value;
    if (selector != null) payload['selector'] = selector;
    payload['timeout'] = timeout;
    if (track != null) payload['track'] = track;
    final response = await connection.sendMessageToServer(
      guid,
      'ariaSnapshot',
      payload,
    );
    return FrameAriaSnapshotResult.fromJson(response, connection: connection);
  }

  Future<void> channel_blur({
    required String selector,
    bool? strict,
    required double timeout,
  }) async {
    final payload = <String, dynamic>{};
    payload['selector'] = selector;
    if (strict != null) payload['strict'] = strict;
    payload['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'blur',
      payload,
    );
    return;
  }

  Future<void> channel_check({
    bool? force,
    Point? position,
    required String selector,
    bool? strict,
    required double timeout,
    bool? trial,
  }) async {
    final payload = <String, dynamic>{};
    if (force != null) payload['force'] = force;
    if (position != null) payload['position'] = position.toJson();
    payload['selector'] = selector;
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

  Future<void> channel_click({
    FrameClickButtonEnum? button,
    int? clickCount,
    double? delay,
    bool? force,
    List<FrameClickModifiersEnum>? modifiers,
    bool? noWaitAfter,
    Point? position,
    required String selector,
    int? steps,
    bool? strict,
    required double timeout,
    bool? trial,
  }) async {
    final payload = <String, dynamic>{};
    if (button != null) payload['button'] = button.value;
    if (clickCount != null) payload['clickCount'] = clickCount;
    if (delay != null) payload['delay'] = delay;
    if (force != null) payload['force'] = force;
    if (modifiers != null) payload['modifiers'] = modifiers;
    if (noWaitAfter != null) payload['noWaitAfter'] = noWaitAfter;
    if (position != null) payload['position'] = position.toJson();
    payload['selector'] = selector;
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

  Future<FrameContentResult> channel_content() async {
    final response = await connection.sendMessageToServer(guid, 'content', {});
    return FrameContentResult.fromJson(response, connection: connection);
  }

  Future<void> channel_dblclick({
    FrameDblclickButtonEnum? button,
    double? delay,
    bool? force,
    List<FrameDblclickModifiersEnum>? modifiers,
    Point? position,
    required String selector,
    int? steps,
    bool? strict,
    required double timeout,
    bool? trial,
  }) async {
    final payload = <String, dynamic>{};
    if (button != null) payload['button'] = button.value;
    if (delay != null) payload['delay'] = delay;
    if (force != null) payload['force'] = force;
    if (modifiers != null) payload['modifiers'] = modifiers;
    if (position != null) payload['position'] = position.toJson();
    payload['selector'] = selector;
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

  Future<void> channel_dispatchEvent({
    required SerializedArgument eventInit,
    required String selector,
    bool? strict,
    required double timeout,
    required String type,
  }) async {
    final payload = <String, dynamic>{};
    payload['eventInit'] = eventInit.toJson();
    payload['selector'] = selector;
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
    if (sourcePosition != null) {
      payload['sourcePosition'] = sourcePosition.toJson();
    }
    if (steps != null) payload['steps'] = steps;
    if (strict != null) payload['strict'] = strict;
    payload['target'] = target;
    if (targetPosition != null) {
      payload['targetPosition'] = targetPosition.toJson();
    }
    payload['timeout'] = timeout;
    if (trial != null) payload['trial'] = trial;
    final response = await connection.sendMessageToServer(
      guid,
      'dragAndDrop',
      payload,
    );
    return;
  }

  Future<void> channel_drop({
    List<Map<String, dynamic>>? data,
    List<String>? localPaths,
    List<Map<String, dynamic>>? payloads,
    Point? position,
    required String selector,
    List<WritableStreamBase>? streams,
    bool? strict,
    required double timeout,
  }) async {
    final payload = <String, dynamic>{};
    if (data != null) payload['data'] = data;
    if (localPaths != null) payload['localPaths'] = localPaths;
    if (payloads != null) payload['payloads'] = payloads;
    if (position != null) payload['position'] = position.toJson();
    payload['selector'] = selector;
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

  Future<FrameEvalOnSelectorResult> channel_evalOnSelector({
    required SerializedArgument arg,
    required String expression,
    bool? isFunction,
    required String selector,
    bool? strict,
  }) async {
    final payload = <String, dynamic>{};
    payload['arg'] = arg.toJson();
    payload['expression'] = expression;
    if (isFunction != null) payload['isFunction'] = isFunction;
    payload['selector'] = selector;
    if (strict != null) payload['strict'] = strict;
    final response = await connection.sendMessageToServer(
      guid,
      'evalOnSelector',
      payload,
    );
    return FrameEvalOnSelectorResult.fromJson(response, connection: connection);
  }

  Future<FrameEvalOnSelectorAllResult> channel_evalOnSelectorAll({
    required SerializedArgument arg,
    required String expression,
    bool? isFunction,
    required String selector,
  }) async {
    final payload = <String, dynamic>{};
    payload['arg'] = arg.toJson();
    payload['expression'] = expression;
    if (isFunction != null) payload['isFunction'] = isFunction;
    payload['selector'] = selector;
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

  Future<FrameExpectResult> channel_expect({
    double? expectedNumber,
    List<ExpectedTextValue>? expectedText,
    SerializedArgument? expectedValue,
    required String expression,
    Map<String, dynamic>? expressionArg,
    required bool isNot,
    FrameExpectPseudoEnum? pseudo,
    String? selector,
    required double timeout,
    bool? useInnerText,
  }) async {
    final payload = <String, dynamic>{};
    if (expectedNumber != null) payload['expectedNumber'] = expectedNumber;
    if (expectedText != null) payload['expectedText'] = expectedText;
    if (expectedValue != null) {
      payload['expectedValue'] = expectedValue.toJson();
    }
    payload['expression'] = expression;
    if (expressionArg != null) payload['expressionArg'] = expressionArg;
    payload['isNot'] = isNot;
    if (pseudo != null) payload['pseudo'] = pseudo.value;
    if (selector != null) payload['selector'] = selector;
    payload['timeout'] = timeout;
    if (useInnerText != null) payload['useInnerText'] = useInnerText;
    final response = await connection.sendMessageToServer(
      guid,
      'expect',
      payload,
    );
    return FrameExpectResult.fromJson(response, connection: connection);
  }

  Future<void> channel_fill({
    bool? force,
    required String selector,
    bool? strict,
    required double timeout,
    required String value,
  }) async {
    final payload = <String, dynamic>{};
    if (force != null) payload['force'] = force;
    payload['selector'] = selector;
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

  Future<void> channel_focus({
    required String selector,
    bool? strict,
    required double timeout,
  }) async {
    final payload = <String, dynamic>{};
    payload['selector'] = selector;
    if (strict != null) payload['strict'] = strict;
    payload['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'focus',
      payload,
    );
    return;
  }

  Future<FrameFrameElementResult> channel_frameElement() async {
    final response = await connection.sendMessageToServer(
      guid,
      'frameElement',
      {},
    );
    return FrameFrameElementResult.fromJson(response, connection: connection);
  }

  Future<FrameGetAttributeResult> channel_getAttribute({
    required String name,
    required String selector,
    bool? strict,
    required double timeout,
  }) async {
    final payload = <String, dynamic>{};
    payload['name'] = name;
    payload['selector'] = selector;
    if (strict != null) payload['strict'] = strict;
    payload['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'getAttribute',
      payload,
    );
    return FrameGetAttributeResult.fromJson(response, connection: connection);
  }

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
    if (waitUntil != null) payload['waitUntil'] = waitUntil.value;
    final response = await connection.sendMessageToServer(
      guid,
      'goto',
      payload,
    );
    return FrameGotoResult.fromJson(response, connection: connection);
  }

  Future<void> channel_hideHighlight({required String selector}) async {
    final payload = <String, dynamic>{};
    payload['selector'] = selector;
    final response = await connection.sendMessageToServer(
      guid,
      'hideHighlight',
      payload,
    );
    return;
  }

  Future<void> channel_highlight({
    required String selector,
    String? style,
  }) async {
    final payload = <String, dynamic>{};
    payload['selector'] = selector;
    if (style != null) payload['style'] = style;
    final response = await connection.sendMessageToServer(
      guid,
      'highlight',
      payload,
    );
    return;
  }

  Future<void> channel_hover({
    bool? force,
    List<FrameHoverModifiersEnum>? modifiers,
    Point? position,
    required String selector,
    bool? strict,
    required double timeout,
    bool? trial,
  }) async {
    final payload = <String, dynamic>{};
    if (force != null) payload['force'] = force;
    if (modifiers != null) payload['modifiers'] = modifiers;
    if (position != null) payload['position'] = position.toJson();
    payload['selector'] = selector;
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

  Future<FrameInnerHTMLResult> channel_innerHTML({
    required String selector,
    bool? strict,
    required double timeout,
  }) async {
    final payload = <String, dynamic>{};
    payload['selector'] = selector;
    if (strict != null) payload['strict'] = strict;
    payload['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'innerHTML',
      payload,
    );
    return FrameInnerHTMLResult.fromJson(response, connection: connection);
  }

  Future<FrameInnerTextResult> channel_innerText({
    required String selector,
    bool? strict,
    required double timeout,
  }) async {
    final payload = <String, dynamic>{};
    payload['selector'] = selector;
    if (strict != null) payload['strict'] = strict;
    payload['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'innerText',
      payload,
    );
    return FrameInnerTextResult.fromJson(response, connection: connection);
  }

  Future<FrameInputValueResult> channel_inputValue({
    required String selector,
    bool? strict,
    required double timeout,
  }) async {
    final payload = <String, dynamic>{};
    payload['selector'] = selector;
    if (strict != null) payload['strict'] = strict;
    payload['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'inputValue',
      payload,
    );
    return FrameInputValueResult.fromJson(response, connection: connection);
  }

  Future<FrameIsCheckedResult> channel_isChecked({
    required String selector,
    bool? strict,
    required double timeout,
  }) async {
    final payload = <String, dynamic>{};
    payload['selector'] = selector;
    if (strict != null) payload['strict'] = strict;
    payload['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'isChecked',
      payload,
    );
    return FrameIsCheckedResult.fromJson(response, connection: connection);
  }

  Future<FrameIsDisabledResult> channel_isDisabled({
    required String selector,
    bool? strict,
    required double timeout,
  }) async {
    final payload = <String, dynamic>{};
    payload['selector'] = selector;
    if (strict != null) payload['strict'] = strict;
    payload['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'isDisabled',
      payload,
    );
    return FrameIsDisabledResult.fromJson(response, connection: connection);
  }

  Future<FrameIsEditableResult> channel_isEditable({
    required String selector,
    bool? strict,
    required double timeout,
  }) async {
    final payload = <String, dynamic>{};
    payload['selector'] = selector;
    if (strict != null) payload['strict'] = strict;
    payload['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'isEditable',
      payload,
    );
    return FrameIsEditableResult.fromJson(response, connection: connection);
  }

  Future<FrameIsEnabledResult> channel_isEnabled({
    required String selector,
    bool? strict,
    required double timeout,
  }) async {
    final payload = <String, dynamic>{};
    payload['selector'] = selector;
    if (strict != null) payload['strict'] = strict;
    payload['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'isEnabled',
      payload,
    );
    return FrameIsEnabledResult.fromJson(response, connection: connection);
  }

  Future<FrameIsHiddenResult> channel_isHidden({
    required String selector,
    bool? strict,
  }) async {
    final payload = <String, dynamic>{};
    payload['selector'] = selector;
    if (strict != null) payload['strict'] = strict;
    final response = await connection.sendMessageToServer(
      guid,
      'isHidden',
      payload,
    );
    return FrameIsHiddenResult.fromJson(response, connection: connection);
  }

  Future<FrameIsVisibleResult> channel_isVisible({
    required String selector,
    bool? strict,
  }) async {
    final payload = <String, dynamic>{};
    payload['selector'] = selector;
    if (strict != null) payload['strict'] = strict;
    final response = await connection.sendMessageToServer(
      guid,
      'isVisible',
      payload,
    );
    return FrameIsVisibleResult.fromJson(response, connection: connection);
  }

  Future<void> channel_press({
    double? delay,
    required String key,
    bool? noWaitAfter,
    required String selector,
    bool? strict,
    required double timeout,
  }) async {
    final payload = <String, dynamic>{};
    if (delay != null) payload['delay'] = delay;
    payload['key'] = key;
    if (noWaitAfter != null) payload['noWaitAfter'] = noWaitAfter;
    payload['selector'] = selector;
    if (strict != null) payload['strict'] = strict;
    payload['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'press',
      payload,
    );
    return;
  }

  Future<FrameQueryCountResult> channel_queryCount({
    required String selector,
  }) async {
    final payload = <String, dynamic>{};
    payload['selector'] = selector;
    final response = await connection.sendMessageToServer(
      guid,
      'queryCount',
      payload,
    );
    return FrameQueryCountResult.fromJson(response, connection: connection);
  }

  Future<FrameQuerySelectorResult> channel_querySelector({
    required String selector,
    bool? strict,
  }) async {
    final payload = <String, dynamic>{};
    payload['selector'] = selector;
    if (strict != null) payload['strict'] = strict;
    final response = await connection.sendMessageToServer(
      guid,
      'querySelector',
      payload,
    );
    return FrameQuerySelectorResult.fromJson(response, connection: connection);
  }

  Future<FrameQuerySelectorAllResult> channel_querySelectorAll({
    required String selector,
  }) async {
    final payload = <String, dynamic>{};
    payload['selector'] = selector;
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
    required String selector,
  }) async {
    final payload = <String, dynamic>{};
    payload['selector'] = selector;
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

  Future<FrameSelectOptionResult> channel_selectOption({
    List<ElementHandleBase>? elements,
    bool? force,
    List<Map<String, dynamic>>? options,
    required String selector,
    bool? strict,
    required double timeout,
  }) async {
    final payload = <String, dynamic>{};
    if (elements != null) payload['elements'] = elements;
    if (force != null) payload['force'] = force;
    if (options != null) payload['options'] = options;
    payload['selector'] = selector;
    if (strict != null) payload['strict'] = strict;
    payload['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'selectOption',
      payload,
    );
    return FrameSelectOptionResult.fromJson(response, connection: connection);
  }

  Future<void> channel_setContent({
    required String html,
    required double timeout,
    LifecycleEvent? waitUntil,
  }) async {
    final payload = <String, dynamic>{};
    payload['html'] = html;
    payload['timeout'] = timeout;
    if (waitUntil != null) payload['waitUntil'] = waitUntil.value;
    final response = await connection.sendMessageToServer(
      guid,
      'setContent',
      payload,
    );
    return;
  }

  Future<void> channel_setInputFiles({
    WritableStreamBase? directoryStream,
    String? localDirectory,
    List<String>? localPaths,
    List<Map<String, dynamic>>? payloads,
    required String selector,
    List<WritableStreamBase>? streams,
    bool? strict,
    required double timeout,
  }) async {
    final payload = <String, dynamic>{};
    if (directoryStream != null) {
      payload['directoryStream'] = {'guid': directoryStream.guid};
    }
    if (localDirectory != null) payload['localDirectory'] = localDirectory;
    if (localPaths != null) payload['localPaths'] = localPaths;
    if (payloads != null) payload['payloads'] = payloads;
    payload['selector'] = selector;
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

  Future<void> channel_tap({
    bool? force,
    List<FrameTapModifiersEnum>? modifiers,
    Point? position,
    required String selector,
    bool? strict,
    required double timeout,
    bool? trial,
  }) async {
    final payload = <String, dynamic>{};
    if (force != null) payload['force'] = force;
    if (modifiers != null) payload['modifiers'] = modifiers;
    if (position != null) payload['position'] = position.toJson();
    payload['selector'] = selector;
    if (strict != null) payload['strict'] = strict;
    payload['timeout'] = timeout;
    if (trial != null) payload['trial'] = trial;
    final response = await connection.sendMessageToServer(guid, 'tap', payload);
    return;
  }

  Future<FrameTextContentResult> channel_textContent({
    required String selector,
    bool? strict,
    required double timeout,
  }) async {
    final payload = <String, dynamic>{};
    payload['selector'] = selector;
    if (strict != null) payload['strict'] = strict;
    payload['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'textContent',
      payload,
    );
    return FrameTextContentResult.fromJson(response, connection: connection);
  }

  Future<FrameTitleResult> channel_title() async {
    final response = await connection.sendMessageToServer(guid, 'title', {});
    return FrameTitleResult.fromJson(response, connection: connection);
  }

  Future<void> channel_type({
    double? delay,
    required String selector,
    bool? strict,
    required String text,
    required double timeout,
  }) async {
    final payload = <String, dynamic>{};
    if (delay != null) payload['delay'] = delay;
    payload['selector'] = selector;
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

  Future<void> channel_uncheck({
    bool? force,
    Point? position,
    required String selector,
    bool? strict,
    required double timeout,
    bool? trial,
  }) async {
    final payload = <String, dynamic>{};
    if (force != null) payload['force'] = force;
    if (position != null) payload['position'] = position.toJson();
    payload['selector'] = selector;
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

  Future<FrameWaitForSelectorResult> channel_waitForSelector({
    bool? omitReturnValue,
    required String selector,
    FrameWaitForSelectorStateEnum? state,
    bool? strict,
    required double timeout,
  }) async {
    final payload = <String, dynamic>{};
    if (omitReturnValue != null) payload['omitReturnValue'] = omitReturnValue;
    payload['selector'] = selector;
    if (state != null) payload['state'] = state.value;
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

  Future<void> channel_dispose() async {
    final response = await connection.sendMessageToServer(guid, 'dispose', {});
    return;
  }

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

  Future<void> channel_send({required Map<String, dynamic> message}) async {
    final payload = <String, dynamic>{};
    payload['message'] = message;
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
    Map<String, dynamic>? headers,
    double? slowMo,
    int? socksProxyRedirectPortForTest,
    required double timeout,
  }) async {
    final payload = <String, dynamic>{};
    payload['endpoint'] = endpoint;
    if (exposeNetwork != null) payload['exposeNetwork'] = exposeNetwork;
    if (headers != null) payload['headers'] = headers;
    if (slowMo != null) payload['slowMo'] = slowMo;
    if (socksProxyRedirectPortForTest != null) {
      payload['socksProxyRedirectPortForTest'] = socksProxyRedirectPortForTest;
    }
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
    if (additionalSources != null) {
      payload['additionalSources'] = additionalSources;
    }
    payload['entries'] = entries;
    payload['includeSources'] = includeSources;
    payload['mode'] = mode.value;
    if (stacksId != null) payload['stacksId'] = stacksId;
    payload['zipFile'] = zipFile;
    final response = await connection.sendMessageToServer(guid, 'zip', payload);
    return;
  }
}

abstract class PageBase extends EventTargetBase {
  PageBase(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

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

  Future<void> channel_bringToFront() async {
    final response = await connection.sendMessageToServer(
      guid,
      'bringToFront',
      {},
    );
    return;
  }

  Future<void> channel_cancelPickLocator() async {
    final response = await connection.sendMessageToServer(
      guid,
      'cancelPickLocator',
      {},
    );
    return;
  }

  Future<void> channel_clearConsoleMessages() async {
    final response = await connection.sendMessageToServer(
      guid,
      'clearConsoleMessages',
      {},
    );
    return;
  }

  Future<void> channel_clearPageErrors() async {
    final response = await connection.sendMessageToServer(
      guid,
      'clearPageErrors',
      {},
    );
    return;
  }

  Future<void> channel_close({String? reason, bool? runBeforeUnload}) async {
    final payload = <String, dynamic>{};
    if (reason != null) payload['reason'] = reason;
    if (runBeforeUnload != null) payload['runBeforeUnload'] = runBeforeUnload;
    final response = await connection.sendMessageToServer(
      guid,
      'close',
      payload,
    );
    return;
  }

  Future<PageConsoleMessagesResult> channel_consoleMessages({
    ConsoleMessagesFilter? filter,
  }) async {
    final payload = <String, dynamic>{};
    if (filter != null) payload['filter'] = filter.value;
    final response = await connection.sendMessageToServer(
      guid,
      'consoleMessages',
      payload,
    );
    return PageConsoleMessagesResult.fromJson(response, connection: connection);
  }

  Future<void> channel_emulateMedia({
    PageEmulateMediaColorSchemeEnum? colorScheme,
    PageEmulateMediaContrastEnum? contrast,
    PageEmulateMediaForcedColorsEnum? forcedColors,
    PageEmulateMediaMediaEnum? media,
    PageEmulateMediaReducedMotionEnum? reducedMotion,
  }) async {
    final payload = <String, dynamic>{};
    if (colorScheme != null) payload['colorScheme'] = colorScheme.value;
    if (contrast != null) payload['contrast'] = contrast.value;
    if (forcedColors != null) payload['forcedColors'] = forcedColors.value;
    if (media != null) payload['media'] = media.value;
    if (reducedMotion != null) payload['reducedMotion'] = reducedMotion.value;
    final response = await connection.sendMessageToServer(
      guid,
      'emulateMedia',
      payload,
    );
    return;
  }

  Future<PageExpectScreenshotResult> channel_expectScreenshot({
    required CommonScreenshotOptions mixinValue,
    Rect? clip,
    String? comparator,
    String? expected,
    bool? fullPage,
    required bool isNot,
    Map<String, dynamic>? locator,
    double? maxDiffPixelRatio,
    int? maxDiffPixels,
    double? threshold,
    required double timeout,
  }) async {
    final payload = <String, dynamic>{};
    payload.addAll(mixinValue.toJson());
    if (clip != null) payload['clip'] = clip.toJson();
    if (comparator != null) payload['comparator'] = comparator;
    if (expected != null) payload['expected'] = expected;
    if (fullPage != null) payload['fullPage'] = fullPage;
    payload['isNot'] = isNot;
    if (locator != null) payload['locator'] = locator;
    if (maxDiffPixelRatio != null) {
      payload['maxDiffPixelRatio'] = maxDiffPixelRatio;
    }
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

  Future<PageGoBackResult> channel_goBack({
    required double timeout,
    LifecycleEvent? waitUntil,
  }) async {
    final payload = <String, dynamic>{};
    payload['timeout'] = timeout;
    if (waitUntil != null) payload['waitUntil'] = waitUntil.value;
    final response = await connection.sendMessageToServer(
      guid,
      'goBack',
      payload,
    );
    return PageGoBackResult.fromJson(response, connection: connection);
  }

  Future<PageGoForwardResult> channel_goForward({
    required double timeout,
    LifecycleEvent? waitUntil,
  }) async {
    final payload = <String, dynamic>{};
    payload['timeout'] = timeout;
    if (waitUntil != null) payload['waitUntil'] = waitUntil.value;
    final response = await connection.sendMessageToServer(
      guid,
      'goForward',
      payload,
    );
    return PageGoForwardResult.fromJson(response, connection: connection);
  }

  Future<void> channel_hideHighlight() async {
    final response = await connection.sendMessageToServer(
      guid,
      'hideHighlight',
      {},
    );
    return;
  }

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

  Future<void> channel_mouseClick({
    PageMouseClickButtonEnum? button,
    int? clickCount,
    double? delay,
    required double x,
    required double y,
  }) async {
    final payload = <String, dynamic>{};
    if (button != null) payload['button'] = button.value;
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

  Future<void> channel_mouseDown({
    PageMouseDownButtonEnum? button,
    int? clickCount,
  }) async {
    final payload = <String, dynamic>{};
    if (button != null) payload['button'] = button.value;
    if (clickCount != null) payload['clickCount'] = clickCount;
    final response = await connection.sendMessageToServer(
      guid,
      'mouseDown',
      payload,
    );
    return;
  }

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

  Future<void> channel_mouseUp({
    PageMouseUpButtonEnum? button,
    int? clickCount,
  }) async {
    final payload = <String, dynamic>{};
    if (button != null) payload['button'] = button.value;
    if (clickCount != null) payload['clickCount'] = clickCount;
    final response = await connection.sendMessageToServer(
      guid,
      'mouseUp',
      payload,
    );
    return;
  }

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

  Future<PagePageErrorsResult> channel_pageErrors({
    ConsoleMessagesFilter? filter,
  }) async {
    final payload = <String, dynamic>{};
    if (filter != null) payload['filter'] = filter.value;
    final response = await connection.sendMessageToServer(
      guid,
      'pageErrors',
      payload,
    );
    return PagePageErrorsResult.fromJson(response, connection: connection);
  }

  Future<PagePdfResult> channel_pdf({
    bool? displayHeaderFooter,
    String? footerTemplate,
    String? format,
    String? headerTemplate,
    String? height,
    bool? landscape,
    Map<String, dynamic>? margin,
    bool? outline,
    String? pageRanges,
    bool? preferCSSPageSize,
    bool? printBackground,
    double? scale,
    bool? tagged,
    String? width,
  }) async {
    final payload = <String, dynamic>{};
    if (displayHeaderFooter != null) {
      payload['displayHeaderFooter'] = displayHeaderFooter;
    }
    if (footerTemplate != null) payload['footerTemplate'] = footerTemplate;
    if (format != null) payload['format'] = format;
    if (headerTemplate != null) payload['headerTemplate'] = headerTemplate;
    if (height != null) payload['height'] = height;
    if (landscape != null) payload['landscape'] = landscape;
    if (margin != null) payload['margin'] = margin;
    if (outline != null) payload['outline'] = outline;
    if (pageRanges != null) payload['pageRanges'] = pageRanges;
    if (preferCSSPageSize != null) {
      payload['preferCSSPageSize'] = preferCSSPageSize;
    }
    if (printBackground != null) payload['printBackground'] = printBackground;
    if (scale != null) payload['scale'] = scale;
    if (tagged != null) payload['tagged'] = tagged;
    if (width != null) payload['width'] = width;
    final response = await connection.sendMessageToServer(guid, 'pdf', payload);
    return PagePdfResult.fromJson(response, connection: connection);
  }

  Future<PagePickLocatorResult> channel_pickLocator() async {
    final response = await connection.sendMessageToServer(
      guid,
      'pickLocator',
      {},
    );
    return PagePickLocatorResult.fromJson(response, connection: connection);
  }

  Future<PageRegisterLocatorHandlerResult> channel_registerLocatorHandler({
    bool? noWaitAfter,
    required String selector,
  }) async {
    final payload = <String, dynamic>{};
    if (noWaitAfter != null) payload['noWaitAfter'] = noWaitAfter;
    payload['selector'] = selector;
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

  Future<PageReloadResult> channel_reload({
    required double timeout,
    LifecycleEvent? waitUntil,
  }) async {
    final payload = <String, dynamic>{};
    payload['timeout'] = timeout;
    if (waitUntil != null) payload['waitUntil'] = waitUntil.value;
    final response = await connection.sendMessageToServer(
      guid,
      'reload',
      payload,
    );
    return PageReloadResult.fromJson(response, connection: connection);
  }

  Future<void> channel_requestGC() async {
    final response = await connection.sendMessageToServer(
      guid,
      'requestGC',
      {},
    );
    return;
  }

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

  Future<void> channel_screencastHideActions() async {
    final response = await connection.sendMessageToServer(
      guid,
      'screencastHideActions',
      {},
    );
    return;
  }

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

  Future<void> channel_screencastShowActions({
    required ShowActionsOptions mixinValue,
  }) async {
    final payload = <String, dynamic>{};
    payload.addAll(mixinValue.toJson());
    final response = await connection.sendMessageToServer(
      guid,
      'screencastShowActions',
      payload,
    );
    return;
  }

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

  Future<PageScreencastStartResult> channel_screencastStart({
    int? quality,
    bool? record,
    bool? sendFrames,
    Map<String, dynamic>? size,
  }) async {
    final payload = <String, dynamic>{};
    if (quality != null) payload['quality'] = quality;
    if (record != null) payload['record'] = record;
    if (sendFrames != null) payload['sendFrames'] = sendFrames;
    if (size != null) payload['size'] = size;
    final response = await connection.sendMessageToServer(
      guid,
      'screencastStart',
      payload,
    );
    return PageScreencastStartResult.fromJson(response, connection: connection);
  }

  Future<void> channel_screencastStop() async {
    final response = await connection.sendMessageToServer(
      guid,
      'screencastStop',
      {},
    );
    return;
  }

  Future<PageScreenshotResult> channel_screenshot({
    required CommonScreenshotOptions mixinValue,
    Rect? clip,
    bool? fullPage,
    int? quality,
    required double timeout,
    PageScreenshotTypeEnum? type,
  }) async {
    final payload = <String, dynamic>{};
    payload.addAll(mixinValue.toJson());
    if (clip != null) payload['clip'] = clip.toJson();
    if (fullPage != null) payload['fullPage'] = fullPage;
    if (quality != null) payload['quality'] = quality;
    payload['timeout'] = timeout;
    if (type != null) payload['type'] = type.value;
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

  Future<void> channel_setNetworkInterceptionPatterns({
    required List<Map<String, dynamic>> patterns,
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

  Future<void> channel_setViewportSize({
    required Map<String, dynamic> viewportSize,
  }) async {
    final payload = <String, dynamic>{};
    payload['viewportSize'] = viewportSize;
    final response = await connection.sendMessageToServer(
      guid,
      'setViewportSize',
      payload,
    );
    return;
  }

  Future<void> channel_setWebSocketInterceptionPatterns({
    required List<Map<String, dynamic>> patterns,
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

  Future<void> channel_startCSSCoverage({bool? resetOnNavigation}) async {
    final payload = <String, dynamic>{};
    if (resetOnNavigation != null) {
      payload['resetOnNavigation'] = resetOnNavigation;
    }
    final response = await connection.sendMessageToServer(
      guid,
      'startCSSCoverage',
      payload,
    );
    return;
  }

  Future<void> channel_startJSCoverage({
    bool? reportAnonymousScripts,
    bool? resetOnNavigation,
  }) async {
    final payload = <String, dynamic>{};
    if (reportAnonymousScripts != null) {
      payload['reportAnonymousScripts'] = reportAnonymousScripts;
    }
    if (resetOnNavigation != null) {
      payload['resetOnNavigation'] = resetOnNavigation;
    }
    final response = await connection.sendMessageToServer(
      guid,
      'startJSCoverage',
      payload,
    );
    return;
  }

  Future<PageStopCSSCoverageResult> channel_stopCSSCoverage() async {
    final response = await connection.sendMessageToServer(
      guid,
      'stopCSSCoverage',
      {},
    );
    return PageStopCSSCoverageResult.fromJson(response, connection: connection);
  }

  Future<PageStopJSCoverageResult> channel_stopJSCoverage() async {
    final response = await connection.sendMessageToServer(
      guid,
      'stopJSCoverage',
      {},
    );
    return PageStopJSCoverageResult.fromJson(response, connection: connection);
  }

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
}

abstract class PlaywrightBase extends ChannelOwner {
  PlaywrightBase(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  Future<PlaywrightNewRequestResult> channel_newRequest({
    String? baseURL,
    List<Map<String, dynamic>>? clientCertificates,
    List<NameValue>? extraHTTPHeaders,
    bool? failOnStatusCode,
    Map<String, dynamic>? httpCredentials,
    bool? ignoreHTTPSErrors,
    int? maxRedirects,
    Map<String, dynamic>? proxy,
    Map<String, dynamic>? storageState,
    String? tracesDir,
    String? userAgent,
  }) async {
    final payload = <String, dynamic>{};
    if (baseURL != null) payload['baseURL'] = baseURL;
    if (clientCertificates != null) {
      payload['clientCertificates'] = clientCertificates;
    }
    if (extraHTTPHeaders != null) {
      payload['extraHTTPHeaders'] = extraHTTPHeaders;
    }
    if (failOnStatusCode != null) {
      payload['failOnStatusCode'] = failOnStatusCode;
    }
    if (httpCredentials != null) payload['httpCredentials'] = httpCredentials;
    if (ignoreHTTPSErrors != null) {
      payload['ignoreHTTPSErrors'] = ignoreHTTPSErrors;
    }
    if (maxRedirects != null) payload['maxRedirects'] = maxRedirects;
    if (proxy != null) payload['proxy'] = proxy;
    if (storageState != null) payload['storageState'] = storageState;
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

  Future<void> channel_fulfill({
    String? body,
    String? fetchResponseUid,
    List<NameValue>? headers,
    bool? isBase64,
    int? status,
  }) async {
    final payload = <String, dynamic>{};
    if (body != null) payload['body'] = body;
    if (fetchResponseUid != null) {
      payload['fetchResponseUid'] = fetchResponseUid;
    }
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

  Future<void> channel_tracingGroup({
    Map<String, dynamic>? location,
    required String name,
  }) async {
    final payload = <String, dynamic>{};
    if (location != null) payload['location'] = location;
    payload['name'] = name;
    final response = await connection.sendMessageToServer(
      guid,
      'tracingGroup',
      payload,
    );
    return;
  }

  Future<void> channel_tracingGroupEnd() async {
    final response = await connection.sendMessageToServer(
      guid,
      'tracingGroupEnd',
      {},
    );
    return;
  }

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

  Future<void> channel_tracingStop() async {
    final response = await connection.sendMessageToServer(
      guid,
      'tracingStop',
      {},
    );
    return;
  }

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

abstract class WebSocketBase extends EventTargetBase {
  WebSocketBase(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);
}

abstract class WebSocketRouteBase extends ChannelOwner {
  WebSocketRouteBase(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

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

abstract class WorkerBase extends EventTargetBase {
  WorkerBase(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

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
