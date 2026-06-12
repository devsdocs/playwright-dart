// ignore_for_file: unused_local_variable, unnecessary_null_comparison, unused_field, annotate_overrides, non_constant_identifier_names
// AUTO-GENERATED FILE. DO NOT MODIFY.
// Generated from Playwright protocol.

import '../channel_owner.dart';

abstract class Channel {}

enum SDKLanguage {
  javascript('javascript'),
  python('python'),
  java('java'),
  csharp('csharp');

  final String value;
  const SDKLanguage(this.value);
}

enum LifecycleEvent {
  load('load'),
  domcontentloaded('domcontentloaded'),
  networkidle('networkidle'),
  commit('commit');

  final String value;
  const LifecycleEvent(this.value);
}

enum ConsoleMessagesFilter {
  all('all'),
  sinceNavigation('since-navigation');

  final String value;
  const ConsoleMessagesFilter(this.value);
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

  Map<String, dynamic> toJson() {
    return {'pid': pid, 'pkg': pkg, 'socketName': socketName};
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

class AndroidElementInfo {
  final List<AndroidElementInfo>? children;
  final String clazz;
  final String desc;
  final String res;
  final String pkg;
  final String text;
  final Rect bounds;
  final bool checkable;
  final bool checked;
  final bool clickable;
  final bool enabled;
  final bool focusable;
  final bool focused;
  final bool longClickable;
  final bool scrollable;
  final bool selected;

  AndroidElementInfo({
    this.children,
    required this.clazz,
    required this.desc,
    required this.res,
    required this.pkg,
    required this.text,
    required this.bounds,
    required this.checkable,
    required this.checked,
    required this.clickable,
    required this.enabled,
    required this.focusable,
    required this.focused,
    required this.longClickable,
    required this.scrollable,
    required this.selected,
  });

  Map<String, dynamic> toJson() {
    return {
      if (children != null) 'children': children,
      'clazz': clazz,
      'desc': desc,
      'res': res,
      'pkg': pkg,
      'text': text,
      'bounds': bounds,
      'checkable': checkable,
      'checked': checked,
      'clickable': clickable,
      'enabled': enabled,
      'focusable': focusable,
      'focused': focused,
      'longClickable': longClickable,
      'scrollable': scrollable,
      'selected': selected,
    };
  }
}

class APIResponse {
  final String fetchUid;
  final String url;
  final int status;
  final String statusText;
  final List<NameValue> headers;

  APIResponse({
    required this.fetchUid,
    required this.url,
    required this.status,
    required this.statusText,
    required this.headers,
  });

  Map<String, dynamic> toJson() {
    return {
      'fetchUid': fetchUid,
      'url': url,
      'status': status,
      'statusText': statusText,
      'headers': headers,
    };
  }
}

class Metadata {
  final Map<String, dynamic>? location;
  final String? title;
  final bool? internal;
  final String? stepId;

  Metadata({this.location, this.title, this.internal, this.stepId});

  Map<String, dynamic> toJson() {
    return {
      if (location != null) 'location': location,
      if (title != null) 'title': title,
      if (internal != null) 'internal': internal,
      if (stepId != null) 'stepId': stepId,
    };
  }
}

class ClientSideCallMetadata {
  final int id;
  final List<StackFrame>? stack;

  ClientSideCallMetadata({required this.id, this.stack});

  Map<String, dynamic> toJson() {
    return {'id': id, if (stack != null) 'stack': stack};
  }
}

class ShowActionsOptions {
  final double? duration;
  final String? position;
  final int? fontSize;

  ShowActionsOptions({this.duration, this.position, this.fontSize});

  Map<String, dynamic> toJson() {
    return {
      if (duration != null) 'duration': duration,
      if (position != null) 'position': position,
      if (fontSize != null) 'fontSize': fontSize,
    };
  }
}

class CommonScreenshotOptions {
  final bool? omitBackground;
  final String? caret;
  final String? animations;
  final String? scale;
  final List<Map<String, dynamic>>? mask;
  final String? maskColor;
  final String? style;

  CommonScreenshotOptions({
    this.omitBackground,
    this.caret,
    this.animations,
    this.scale,
    this.mask,
    this.maskColor,
    this.style,
  });

  Map<String, dynamic> toJson() {
    return {
      if (omitBackground != null) 'omitBackground': omitBackground,
      if (caret != null) 'caret': caret,
      if (animations != null) 'animations': animations,
      if (scale != null) 'scale': scale,
      if (mask != null) 'mask': mask,
      if (maskColor != null) 'maskColor': maskColor,
      if (style != null) 'style': style,
    };
  }
}

class LaunchOptions {
  final String? channel;
  final String? executablePath;
  final List<String>? args;
  final bool? ignoreAllDefaultArgs;
  final List<String>? ignoreDefaultArgs;
  final bool? handleSIGINT;
  final bool? handleSIGTERM;
  final bool? handleSIGHUP;
  final double timeout;
  final List<NameValue>? env;
  final bool? headless;
  final Map<String, dynamic>? proxy;
  final String? downloadsPath;
  final String? tracesDir;
  final String? artifactsDir;
  final bool? chromiumSandbox;
  final Map<String, dynamic>? firefoxUserPrefs;
  final int? cdpPort;

  LaunchOptions({
    this.channel,
    this.executablePath,
    this.args,
    this.ignoreAllDefaultArgs,
    this.ignoreDefaultArgs,
    this.handleSIGINT,
    this.handleSIGTERM,
    this.handleSIGHUP,
    required this.timeout,
    this.env,
    this.headless,
    this.proxy,
    this.downloadsPath,
    this.tracesDir,
    this.artifactsDir,
    this.chromiumSandbox,
    this.firefoxUserPrefs,
    this.cdpPort,
  });

  Map<String, dynamic> toJson() {
    return {
      if (channel != null) 'channel': channel,
      if (executablePath != null) 'executablePath': executablePath,
      if (args != null) 'args': args,
      if (ignoreAllDefaultArgs != null)
        'ignoreAllDefaultArgs': ignoreAllDefaultArgs,
      if (ignoreDefaultArgs != null) 'ignoreDefaultArgs': ignoreDefaultArgs,
      if (handleSIGINT != null) 'handleSIGINT': handleSIGINT,
      if (handleSIGTERM != null) 'handleSIGTERM': handleSIGTERM,
      if (handleSIGHUP != null) 'handleSIGHUP': handleSIGHUP,
      'timeout': timeout,
      if (env != null) 'env': env,
      if (headless != null) 'headless': headless,
      if (proxy != null) 'proxy': proxy,
      if (downloadsPath != null) 'downloadsPath': downloadsPath,
      if (tracesDir != null) 'tracesDir': tracesDir,
      if (artifactsDir != null) 'artifactsDir': artifactsDir,
      if (chromiumSandbox != null) 'chromiumSandbox': chromiumSandbox,
      if (firefoxUserPrefs != null) 'firefoxUserPrefs': firefoxUserPrefs,
      if (cdpPort != null) 'cdpPort': cdpPort,
    };
  }
}

class ContextOptions {
  final bool? noDefaultViewport;
  final Map<String, dynamic>? viewport;
  final Map<String, dynamic>? screen;
  final bool? ignoreHTTPSErrors;
  final List<Map<String, dynamic>>? clientCertificates;
  final bool? javaScriptEnabled;
  final bool? bypassCSP;
  final String? userAgent;
  final String? locale;
  final String? timezoneId;
  final Map<String, dynamic>? geolocation;
  final List<String>? permissions;
  final List<NameValue>? extraHTTPHeaders;
  final bool? offline;
  final Map<String, dynamic>? httpCredentials;
  final double? deviceScaleFactor;
  final bool? isMobile;
  final bool? hasTouch;
  final String? colorScheme;
  final String? reducedMotion;
  final String? forcedColors;
  final String? acceptDownloads;
  final String? contrast;
  final String? baseURL;
  final Map<String, dynamic>? recordVideo;
  final bool? strictSelectors;
  final String? serviceWorkers;
  final List<SelectorEngine>? selectorEngines;
  final String? testIdAttributeName;

  ContextOptions({
    this.noDefaultViewport,
    this.viewport,
    this.screen,
    this.ignoreHTTPSErrors,
    this.clientCertificates,
    this.javaScriptEnabled,
    this.bypassCSP,
    this.userAgent,
    this.locale,
    this.timezoneId,
    this.geolocation,
    this.permissions,
    this.extraHTTPHeaders,
    this.offline,
    this.httpCredentials,
    this.deviceScaleFactor,
    this.isMobile,
    this.hasTouch,
    this.colorScheme,
    this.reducedMotion,
    this.forcedColors,
    this.acceptDownloads,
    this.contrast,
    this.baseURL,
    this.recordVideo,
    this.strictSelectors,
    this.serviceWorkers,
    this.selectorEngines,
    this.testIdAttributeName,
  });

  Map<String, dynamic> toJson() {
    return {
      if (noDefaultViewport != null) 'noDefaultViewport': noDefaultViewport,
      if (viewport != null) 'viewport': viewport,
      if (screen != null) 'screen': screen,
      if (ignoreHTTPSErrors != null) 'ignoreHTTPSErrors': ignoreHTTPSErrors,
      if (clientCertificates != null) 'clientCertificates': clientCertificates,
      if (javaScriptEnabled != null) 'javaScriptEnabled': javaScriptEnabled,
      if (bypassCSP != null) 'bypassCSP': bypassCSP,
      if (userAgent != null) 'userAgent': userAgent,
      if (locale != null) 'locale': locale,
      if (timezoneId != null) 'timezoneId': timezoneId,
      if (geolocation != null) 'geolocation': geolocation,
      if (permissions != null) 'permissions': permissions,
      if (extraHTTPHeaders != null) 'extraHTTPHeaders': extraHTTPHeaders,
      if (offline != null) 'offline': offline,
      if (httpCredentials != null) 'httpCredentials': httpCredentials,
      if (deviceScaleFactor != null) 'deviceScaleFactor': deviceScaleFactor,
      if (isMobile != null) 'isMobile': isMobile,
      if (hasTouch != null) 'hasTouch': hasTouch,
      if (colorScheme != null) 'colorScheme': colorScheme,
      if (reducedMotion != null) 'reducedMotion': reducedMotion,
      if (forcedColors != null) 'forcedColors': forcedColors,
      if (acceptDownloads != null) 'acceptDownloads': acceptDownloads,
      if (contrast != null) 'contrast': contrast,
      if (baseURL != null) 'baseURL': baseURL,
      if (recordVideo != null) 'recordVideo': recordVideo,
      if (strictSelectors != null) 'strictSelectors': strictSelectors,
      if (serviceWorkers != null) 'serviceWorkers': serviceWorkers,
      if (selectorEngines != null) 'selectorEngines': selectorEngines,
      if (testIdAttributeName != null)
        'testIdAttributeName': testIdAttributeName,
    };
  }
}

class ConsoleMessage {
  final String type;
  final String text;
  final List<JSHandleBase> args;
  final Map<String, dynamic> location;
  final double timestamp;

  ConsoleMessage({
    required this.type,
    required this.text,
    required this.args,
    required this.location,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'text': text,
      'args': args,
      'location': location,
      'timestamp': timestamp,
    };
  }
}

class SetNetworkCookie {
  final String name;
  final String value;
  final String? url;
  final String? domain;
  final String? path;
  final double? expires;
  final bool? httpOnly;
  final bool? secure;
  final String? sameSite;
  final String? partitionKey;
  final bool? _crHasCrossSiteAncestor;

  SetNetworkCookie({
    required this.name,
    required this.value,
    this.url,
    this.domain,
    this.path,
    this.expires,
    this.httpOnly,
    this.secure,
    this.sameSite,
    this.partitionKey,
    this._crHasCrossSiteAncestor,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'value': value,
      if (url != null) 'url': url,
      if (domain != null) 'domain': domain,
      if (path != null) 'path': path,
      if (expires != null) 'expires': expires,
      if (httpOnly != null) 'httpOnly': httpOnly,
      if (secure != null) 'secure': secure,
      if (sameSite != null) 'sameSite': sameSite,
      if (partitionKey != null) 'partitionKey': partitionKey,
      if (_crHasCrossSiteAncestor != null)
        '_crHasCrossSiteAncestor': _crHasCrossSiteAncestor,
    };
  }
}

class NetworkCookie {
  final String name;
  final String value;
  final String domain;
  final String path;
  final double expires;
  final bool httpOnly;
  final bool secure;
  final String sameSite;
  final String? partitionKey;
  final bool? _crHasCrossSiteAncestor;

  NetworkCookie({
    required this.name,
    required this.value,
    required this.domain,
    required this.path,
    required this.expires,
    required this.httpOnly,
    required this.secure,
    required this.sameSite,
    this.partitionKey,
    this._crHasCrossSiteAncestor,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'value': value,
      'domain': domain,
      'path': path,
      'expires': expires,
      'httpOnly': httpOnly,
      'secure': secure,
      'sameSite': sameSite,
      if (partitionKey != null) 'partitionKey': partitionKey,
      if (_crHasCrossSiteAncestor != null)
        '_crHasCrossSiteAncestor': _crHasCrossSiteAncestor,
    };
  }
}

class ResourceTiming {
  final double startTime;
  final double domainLookupStart;
  final double domainLookupEnd;
  final double connectStart;
  final double secureConnectionStart;
  final double connectEnd;
  final double requestStart;
  final double responseStart;

  ResourceTiming({
    required this.startTime,
    required this.domainLookupStart,
    required this.domainLookupEnd,
    required this.connectStart,
    required this.secureConnectionStart,
    required this.connectEnd,
    required this.requestStart,
    required this.responseStart,
  });

  Map<String, dynamic> toJson() {
    return {
      'startTime': startTime,
      'domainLookupStart': domainLookupStart,
      'domainLookupEnd': domainLookupEnd,
      'connectStart': connectStart,
      'secureConnectionStart': secureConnectionStart,
      'connectEnd': connectEnd,
      'requestStart': requestStart,
      'responseStart': responseStart,
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

  Map<String, dynamic> toJson() {
    return {
      'requestBodySize': requestBodySize,
      'requestHeadersSize': requestHeadersSize,
      'responseBodySize': responseBodySize,
      'responseHeadersSize': responseHeadersSize,
    };
  }
}

class RemoteAddr {
  final String ipAddress;
  final int port;

  RemoteAddr({required this.ipAddress, required this.port});

  Map<String, dynamic> toJson() {
    return {'ipAddress': ipAddress, 'port': port};
  }
}

class ExpectedTextValue {
  final String? string;
  final String? regexSource;
  final String? regexFlags;
  final bool? matchSubstring;
  final bool? ignoreCase;
  final bool? normalizeWhiteSpace;

  ExpectedTextValue({
    this.string,
    this.regexSource,
    this.regexFlags,
    this.matchSubstring,
    this.ignoreCase,
    this.normalizeWhiteSpace,
  });

  Map<String, dynamic> toJson() {
    return {
      if (string != null) 'string': string,
      if (regexSource != null) 'regexSource': regexSource,
      if (regexFlags != null) 'regexFlags': regexFlags,
      if (matchSubstring != null) 'matchSubstring': matchSubstring,
      if (ignoreCase != null) 'ignoreCase': ignoreCase,
      if (normalizeWhiteSpace != null)
        'normalizeWhiteSpace': normalizeWhiteSpace,
    };
  }
}

class SelectorEngine {
  final String name;
  final String source;
  final bool? contentScript;

  SelectorEngine({
    required this.name,
    required this.source,
    this.contentScript,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'source': source,
      if (contentScript != null) 'contentScript': contentScript,
    };
  }
}

class FormField {
  final String name;
  final String? value;
  final Map<String, dynamic>? file;

  FormField({required this.name, this.value, this.file});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      if (value != null) 'value': value,
      if (file != null) 'file': file,
    };
  }
}

class RecorderSource {
  final bool isRecorded;
  final String id;
  final String label;
  final String text;
  final String language;
  final List<Map<String, dynamic>> highlight;
  final int? revealLine;
  final String? group;

  RecorderSource({
    required this.isRecorded,
    required this.id,
    required this.label,
    required this.text,
    required this.language,
    required this.highlight,
    this.revealLine,
    this.group,
  });

  Map<String, dynamic> toJson() {
    return {
      'isRecorded': isRecorded,
      'id': id,
      'label': label,
      'text': text,
      'language': language,
      'highlight': highlight,
      if (revealLine != null) 'revealLine': revealLine,
      if (group != null) 'group': group,
    };
  }
}

class IndexedDBDatabase {
  final String name;
  final int version;
  final List<Map<String, dynamic>> stores;

  IndexedDBDatabase({
    required this.name,
    required this.version,
    required this.stores,
  });

  Map<String, dynamic> toJson() {
    return {'name': name, 'version': version, 'stores': stores};
  }
}

class SetOriginStorage {
  final String origin;
  final List<NameValue> localStorage;
  final List<IndexedDBDatabase>? indexedDB;

  SetOriginStorage({
    required this.origin,
    required this.localStorage,
    this.indexedDB,
  });

  Map<String, dynamic> toJson() {
    return {
      'origin': origin,
      'localStorage': localStorage,
      if (indexedDB != null) 'indexedDB': indexedDB,
    };
  }
}

class OriginStorage {
  final String origin;
  final List<NameValue> localStorage;
  final List<IndexedDBDatabase>? indexedDB;

  OriginStorage({
    required this.origin,
    required this.localStorage,
    this.indexedDB,
  });

  Map<String, dynamic> toJson() {
    return {
      'origin': origin,
      'localStorage': localStorage,
      if (indexedDB != null) 'indexedDB': indexedDB,
    };
  }
}

class RecordHarOptions {
  final String? content;
  final String? mode;
  final String? urlGlob;
  final String? urlRegexSource;
  final String? urlRegexFlags;
  final String? harPath;
  final String? resourcesDir;

  RecordHarOptions({
    this.content,
    this.mode,
    this.urlGlob,
    this.urlRegexSource,
    this.urlRegexFlags,
    this.harPath,
    this.resourcesDir,
  });

  Map<String, dynamic> toJson() {
    return {
      if (content != null) 'content': content,
      if (mode != null) 'mode': mode,
      if (urlGlob != null) 'urlGlob': urlGlob,
      if (urlRegexSource != null) 'urlRegexSource': urlRegexSource,
      if (urlRegexFlags != null) 'urlRegexFlags': urlRegexFlags,
      if (harPath != null) 'harPath': harPath,
      if (resourcesDir != null) 'resourcesDir': resourcesDir,
    };
  }
}

class SerializedValue {
  final double? n;
  final bool? b;
  final String? s;
  final String? v;
  final String? d;
  final String? u;
  final String? bi;
  final Map<String, dynamic>? ta;
  final Map<String, dynamic>? e;
  final Map<String, dynamic>? r;
  final List<SerializedValue>? a;
  final List<Map<String, dynamic>>? o;
  final int? h;
  final int? id;
  final int? ref;

  SerializedValue({
    this.n,
    this.b,
    this.s,
    this.v,
    this.d,
    this.u,
    this.bi,
    this.ta,
    this.e,
    this.r,
    this.a,
    this.o,
    this.h,
    this.id,
    this.ref,
  });

  Map<String, dynamic> toJson() {
    return {
      if (n != null) 'n': n,
      if (b != null) 'b': b,
      if (s != null) 's': s,
      if (v != null) 'v': v,
      if (d != null) 'd': d,
      if (u != null) 'u': u,
      if (bi != null) 'bi': bi,
      if (ta != null) 'ta': ta,
      if (e != null) 'e': e,
      if (r != null) 'r': r,
      if (a != null) 'a': a,
      if (o != null) 'o': o,
      if (h != null) 'h': h,
      if (id != null) 'id': id,
      if (ref != null) 'ref': ref,
    };
  }
}

class SerializedArgument {
  final SerializedValue value;
  final List<Channel> handles;

  SerializedArgument({required this.value, required this.handles});

  Map<String, dynamic> toJson() {
    return {'value': value, 'handles': handles};
  }
}

class SerializedError {
  final Map<String, dynamic>? error;
  final SerializedValue? value;

  SerializedError({this.error, this.value});

  Map<String, dynamic> toJson() {
    return {
      if (error != null) 'error': error,
      if (value != null) 'value': value,
    };
  }
}

class StackFrame {
  final String file;
  final int line;
  final int column;
  final String? function;

  StackFrame({
    required this.file,
    required this.line,
    required this.column,
    this.function,
  });

  Map<String, dynamic> toJson() {
    return {
      'file': file,
      'line': line,
      'column': column,
      if (function != null) 'function': function,
    };
  }
}

class Point {
  final double x;
  final double y;

  Point({required this.x, required this.y});

  Map<String, dynamic> toJson() {
    return {'x': x, 'y': y};
  }
}

class Rect {
  final double x;
  final double y;
  final double width;
  final double height;

  Rect({
    required this.x,
    required this.y,
    required this.width,
    required this.height,
  });

  Map<String, dynamic> toJson() {
    return {'x': x, 'y': y, 'width': width, 'height': height};
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

class NameValue {
  final String name;
  final String value;

  NameValue({required this.name, required this.value});

  Map<String, dynamic> toJson() {
    return {'name': name, 'value': value};
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

  Future<Map<String, dynamic>> channel_devices({
    String? host,
    int? port,
    bool? omitDriverInstall,
  }) async {
    final params = <String, dynamic>{};
    if (host != null) params['host'] = host;
    if (port != null) params['port'] = port;
    if (omitDriverInstall != null) {
      params['omitDriverInstall'] = omitDriverInstall;
    }
    final response = await connection.sendMessageToServer(
      guid,
      'devices',
      params,
    );
    return response;
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

  Future<void> channel_write({required String data}) async {
    final params = <String, dynamic>{};
    params['data'] = data;
    final response = await connection.sendMessageToServer(
      guid,
      'write',
      params,
    );
    return;
  }

  Future<void> channel_close() async {
    final response = await connection.sendMessageToServer(guid, 'close', {});
    return;
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

  Future<void> channel_wait({
    required AndroidSelector androidSelector,
    String? state,
    required double timeout,
  }) async {
    final params = <String, dynamic>{};
    params['androidSelector'] = ((v) => v is Enum
        ? (v as dynamic).value
        : (v is Map ? v : (v as dynamic).toJson()))(androidSelector);
    if (state != null) params['state'] = state;
    params['timeout'] = timeout;
    final response = await connection.sendMessageToServer(guid, 'wait', params);
    return;
  }

  Future<void> channel_fill({
    required AndroidSelector androidSelector,
    required String text,
    required double timeout,
  }) async {
    final params = <String, dynamic>{};
    params['androidSelector'] = ((v) => v is Enum
        ? (v as dynamic).value
        : (v is Map ? v : (v as dynamic).toJson()))(androidSelector);
    params['text'] = text;
    params['timeout'] = timeout;
    final response = await connection.sendMessageToServer(guid, 'fill', params);
    return;
  }

  Future<void> channel_tap({
    required AndroidSelector androidSelector,
    double? duration,
    required double timeout,
  }) async {
    final params = <String, dynamic>{};
    params['androidSelector'] = ((v) => v is Enum
        ? (v as dynamic).value
        : (v is Map ? v : (v as dynamic).toJson()))(androidSelector);
    if (duration != null) params['duration'] = duration;
    params['timeout'] = timeout;
    final response = await connection.sendMessageToServer(guid, 'tap', params);
    return;
  }

  Future<void> channel_drag({
    required AndroidSelector androidSelector,
    required Point dest,
    double? speed,
    required double timeout,
  }) async {
    final params = <String, dynamic>{};
    params['androidSelector'] = ((v) => v is Enum
        ? (v as dynamic).value
        : (v is Map ? v : (v as dynamic).toJson()))(androidSelector);
    params['dest'] = ((v) => v is Enum
        ? (v as dynamic).value
        : (v is Map ? v : (v as dynamic).toJson()))(dest);
    if (speed != null) params['speed'] = speed;
    params['timeout'] = timeout;
    final response = await connection.sendMessageToServer(guid, 'drag', params);
    return;
  }

  Future<void> channel_fling({
    required AndroidSelector androidSelector,
    required String direction,
    double? speed,
    required double timeout,
  }) async {
    final params = <String, dynamic>{};
    params['androidSelector'] = ((v) => v is Enum
        ? (v as dynamic).value
        : (v is Map ? v : (v as dynamic).toJson()))(androidSelector);
    params['direction'] = direction;
    if (speed != null) params['speed'] = speed;
    params['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'fling',
      params,
    );
    return;
  }

  Future<void> channel_longTap({
    required AndroidSelector androidSelector,
    required double timeout,
  }) async {
    final params = <String, dynamic>{};
    params['androidSelector'] = ((v) => v is Enum
        ? (v as dynamic).value
        : (v is Map ? v : (v as dynamic).toJson()))(androidSelector);
    params['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'longTap',
      params,
    );
    return;
  }

  Future<void> channel_pinchClose({
    required AndroidSelector androidSelector,
    required double percent,
    double? speed,
    required double timeout,
  }) async {
    final params = <String, dynamic>{};
    params['androidSelector'] = ((v) => v is Enum
        ? (v as dynamic).value
        : (v is Map ? v : (v as dynamic).toJson()))(androidSelector);
    params['percent'] = percent;
    if (speed != null) params['speed'] = speed;
    params['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'pinchClose',
      params,
    );
    return;
  }

  Future<void> channel_pinchOpen({
    required AndroidSelector androidSelector,
    required double percent,
    double? speed,
    required double timeout,
  }) async {
    final params = <String, dynamic>{};
    params['androidSelector'] = ((v) => v is Enum
        ? (v as dynamic).value
        : (v is Map ? v : (v as dynamic).toJson()))(androidSelector);
    params['percent'] = percent;
    if (speed != null) params['speed'] = speed;
    params['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'pinchOpen',
      params,
    );
    return;
  }

  Future<void> channel_scroll({
    required AndroidSelector androidSelector,
    required String direction,
    required double percent,
    double? speed,
    required double timeout,
  }) async {
    final params = <String, dynamic>{};
    params['androidSelector'] = ((v) => v is Enum
        ? (v as dynamic).value
        : (v is Map ? v : (v as dynamic).toJson()))(androidSelector);
    params['direction'] = direction;
    params['percent'] = percent;
    if (speed != null) params['speed'] = speed;
    params['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'scroll',
      params,
    );
    return;
  }

  Future<void> channel_swipe({
    required AndroidSelector androidSelector,
    required String direction,
    required double percent,
    double? speed,
    required double timeout,
  }) async {
    final params = <String, dynamic>{};
    params['androidSelector'] = ((v) => v is Enum
        ? (v as dynamic).value
        : (v is Map ? v : (v as dynamic).toJson()))(androidSelector);
    params['direction'] = direction;
    params['percent'] = percent;
    if (speed != null) params['speed'] = speed;
    params['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'swipe',
      params,
    );
    return;
  }

  Future<Map<String, dynamic>> channel_info({
    required AndroidSelector androidSelector,
  }) async {
    final params = <String, dynamic>{};
    params['androidSelector'] = ((v) => v is Enum
        ? (v as dynamic).value
        : (v is Map ? v : (v as dynamic).toJson()))(androidSelector);
    final response = await connection.sendMessageToServer(guid, 'info', params);
    return response;
  }

  Future<Map<String, dynamic>> channel_screenshot() async {
    final response = await connection.sendMessageToServer(
      guid,
      'screenshot',
      {},
    );
    return response;
  }

  Future<void> channel_inputType({required String text}) async {
    final params = <String, dynamic>{};
    params['text'] = text;
    final response = await connection.sendMessageToServer(
      guid,
      'inputType',
      params,
    );
    return;
  }

  Future<void> channel_inputPress({required String key}) async {
    final params = <String, dynamic>{};
    params['key'] = key;
    final response = await connection.sendMessageToServer(
      guid,
      'inputPress',
      params,
    );
    return;
  }

  Future<void> channel_inputTap({required Point point}) async {
    final params = <String, dynamic>{};
    params['point'] = ((v) => v is Enum
        ? (v as dynamic).value
        : (v is Map ? v : (v as dynamic).toJson()))(point);
    final response = await connection.sendMessageToServer(
      guid,
      'inputTap',
      params,
    );
    return;
  }

  Future<void> channel_inputSwipe({
    required List<Point> segments,
    required int steps,
  }) async {
    final params = <String, dynamic>{};
    params['segments'] = segments;
    params['steps'] = steps;
    final response = await connection.sendMessageToServer(
      guid,
      'inputSwipe',
      params,
    );
    return;
  }

  Future<void> channel_inputDrag({
    required Point from,
    required Point to,
    required int steps,
  }) async {
    final params = <String, dynamic>{};
    params['from'] = ((v) => v is Enum
        ? (v as dynamic).value
        : (v is Map ? v : (v as dynamic).toJson()))(from);
    params['to'] = ((v) => v is Enum
        ? (v as dynamic).value
        : (v is Map ? v : (v as dynamic).toJson()))(to);
    params['steps'] = steps;
    final response = await connection.sendMessageToServer(
      guid,
      'inputDrag',
      params,
    );
    return;
  }

  Future<Map<String, dynamic>> channel_launchBrowser({
    required ContextOptions mixin,
    String? pkg,
    List<String>? args,
    Map<String, dynamic>? proxy,
  }) async {
    final params = <String, dynamic>{};
    params.addAll(
      ((v) => v is Enum
              ? (v as dynamic).value
              : (v is Map ? v : (v as dynamic).toJson()))(mixin)
          as Map<String, dynamic>,
    );
    if (pkg != null) params['pkg'] = pkg;
    if (args != null) params['args'] = args;
    if (proxy != null) {
      params['proxy'] = ((v) => v is Enum
          ? (v as dynamic).value
          : (v is Map ? v : (v as dynamic).toJson()))(proxy);
    }
    final response = await connection.sendMessageToServer(
      guid,
      'launchBrowser',
      params,
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_open({required String command}) async {
    final params = <String, dynamic>{};
    params['command'] = command;
    final response = await connection.sendMessageToServer(guid, 'open', params);
    return response;
  }

  Future<Map<String, dynamic>> channel_shell({required String command}) async {
    final params = <String, dynamic>{};
    params['command'] = command;
    final response = await connection.sendMessageToServer(
      guid,
      'shell',
      params,
    );
    return response;
  }

  Future<void> channel_installApk({
    required String file,
    List<String>? args,
  }) async {
    final params = <String, dynamic>{};
    params['file'] = file;
    if (args != null) params['args'] = args;
    final response = await connection.sendMessageToServer(
      guid,
      'installApk',
      params,
    );
    return;
  }

  Future<void> channel_push({
    required String file,
    required String path,
    int? mode,
  }) async {
    final params = <String, dynamic>{};
    params['file'] = file;
    params['path'] = path;
    if (mode != null) params['mode'] = mode;
    final response = await connection.sendMessageToServer(guid, 'push', params);
    return;
  }

  Future<Map<String, dynamic>> channel_connectToWebView({
    required String socketName,
  }) async {
    final params = <String, dynamic>{};
    params['socketName'] = socketName;
    final response = await connection.sendMessageToServer(
      guid,
      'connectToWebView',
      params,
    );
    return response;
  }

  Future<void> channel_close() async {
    final response = await connection.sendMessageToServer(guid, 'close', {});
    return;
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

  Future<Map<String, dynamic>> channel_fetch({
    required String url,
    String? encodedParams,
    List<NameValue>? params,
    String? method,
    List<NameValue>? headers,
    String? postData,
    String? jsonData,
    List<NameValue>? formData,
    List<FormField>? multipartData,
    required double timeout,
    bool? failOnStatusCode,
    bool? ignoreHTTPSErrors,
    int? maxRedirects,
    int? maxRetries,
  }) async {
    final params = <String, dynamic>{};
    params['url'] = url;
    if (encodedParams != null) params['encodedParams'] = encodedParams;
    if (params != null) params['params'] = params;
    if (method != null) params['method'] = method;
    if (headers != null) params['headers'] = headers;
    if (postData != null) params['postData'] = postData;
    if (jsonData != null) params['jsonData'] = jsonData;
    if (formData != null) params['formData'] = formData;
    if (multipartData != null) params['multipartData'] = multipartData;
    params['timeout'] = timeout;
    if (failOnStatusCode != null) params['failOnStatusCode'] = failOnStatusCode;
    if (ignoreHTTPSErrors != null) {
      params['ignoreHTTPSErrors'] = ignoreHTTPSErrors;
    }
    if (maxRedirects != null) params['maxRedirects'] = maxRedirects;
    if (maxRetries != null) params['maxRetries'] = maxRetries;
    final response = await connection.sendMessageToServer(
      guid,
      'fetch',
      params,
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_fetchResponseBody({
    required String fetchUid,
  }) async {
    final params = <String, dynamic>{};
    params['fetchUid'] = fetchUid;
    final response = await connection.sendMessageToServer(
      guid,
      'fetchResponseBody',
      params,
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_fetchLog({
    required String fetchUid,
  }) async {
    final params = <String, dynamic>{};
    params['fetchUid'] = fetchUid;
    final response = await connection.sendMessageToServer(
      guid,
      'fetchLog',
      params,
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_storageState({bool? indexedDB}) async {
    final params = <String, dynamic>{};
    if (indexedDB != null) params['indexedDB'] = indexedDB;
    final response = await connection.sendMessageToServer(
      guid,
      'storageState',
      params,
    );
    return response;
  }

  Future<void> channel_disposeAPIResponse({required String fetchUid}) async {
    final params = <String, dynamic>{};
    params['fetchUid'] = fetchUid;
    final response = await connection.sendMessageToServer(
      guid,
      'disposeAPIResponse',
      params,
    );
    return;
  }

  Future<void> channel_dispose({String? reason}) async {
    final params = <String, dynamic>{};
    if (reason != null) params['reason'] = reason;
    final response = await connection.sendMessageToServer(
      guid,
      'dispose',
      params,
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

  Future<Map<String, dynamic>> channel_pathAfterFinished() async {
    final response = await connection.sendMessageToServer(
      guid,
      'pathAfterFinished',
      {},
    );
    return response;
  }

  Future<void> channel_saveAs({required String path}) async {
    final params = <String, dynamic>{};
    params['path'] = path;
    final response = await connection.sendMessageToServer(
      guid,
      'saveAs',
      params,
    );
    return;
  }

  Future<Map<String, dynamic>> channel_saveAsStream() async {
    final response = await connection.sendMessageToServer(
      guid,
      'saveAsStream',
      {},
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_failure() async {
    final response = await connection.sendMessageToServer(guid, 'failure', {});
    return response;
  }

  Future<Map<String, dynamic>> channel_stream() async {
    final response = await connection.sendMessageToServer(guid, 'stream', {});
    return response;
  }

  Future<void> channel_cancel() async {
    final response = await connection.sendMessageToServer(guid, 'cancel', {});
    return;
  }

  Future<void> channel_delete() async {
    final response = await connection.sendMessageToServer(guid, 'delete', {});
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

  Future<Map<String, dynamic>> channel_read({int? size}) async {
    final params = <String, dynamic>{};
    if (size != null) params['size'] = size;
    final response = await connection.sendMessageToServer(guid, 'read', params);
    return response;
  }

  Future<void> channel_close() async {
    final response = await connection.sendMessageToServer(guid, 'close', {});
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

  Future<void> channel_write({required String binary}) async {
    final params = <String, dynamic>{};
    params['binary'] = binary;
    final response = await connection.sendMessageToServer(
      guid,
      'write',
      params,
    );
    return;
  }

  Future<void> channel_close() async {
    final response = await connection.sendMessageToServer(guid, 'close', {});
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

  Future<Map<String, dynamic>> channel_startServer({
    required String title,
    String? workspaceDir,
    Map<String, dynamic>? metadata,
    String? host,
    int? port,
  }) async {
    final params = <String, dynamic>{};
    params['title'] = title;
    if (workspaceDir != null) params['workspaceDir'] = workspaceDir;
    if (metadata != null) {
      params['metadata'] = ((v) => v is Enum
          ? (v as dynamic).value
          : (v is Map ? v : (v as dynamic).toJson()))(metadata);
    }
    if (host != null) params['host'] = host;
    if (port != null) params['port'] = port;
    final response = await connection.sendMessageToServer(
      guid,
      'startServer',
      params,
    );
    return response;
  }

  Future<void> channel_stopServer() async {
    final response = await connection.sendMessageToServer(
      guid,
      'stopServer',
      {},
    );
    return;
  }

  Future<void> channel_close({String? reason}) async {
    final params = <String, dynamic>{};
    if (reason != null) params['reason'] = reason;
    final response = await connection.sendMessageToServer(
      guid,
      'close',
      params,
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

  Future<Map<String, dynamic>> channel_defaultUserAgentForTest() async {
    final response = await connection.sendMessageToServer(
      guid,
      'defaultUserAgentForTest',
      {},
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_newContext({
    required ContextOptions mixin,
    Map<String, dynamic>? proxy,
    Map<String, dynamic>? storageState,
  }) async {
    final params = <String, dynamic>{};
    params.addAll(
      ((v) => v is Enum
              ? (v as dynamic).value
              : (v is Map ? v : (v as dynamic).toJson()))(mixin)
          as Map<String, dynamic>,
    );
    if (proxy != null) {
      params['proxy'] = ((v) => v is Enum
          ? (v as dynamic).value
          : (v is Map ? v : (v as dynamic).toJson()))(proxy);
    }
    if (storageState != null) {
      params['storageState'] = ((v) => v is Enum
          ? (v as dynamic).value
          : (v is Map ? v : (v as dynamic).toJson()))(storageState);
    }
    final response = await connection.sendMessageToServer(
      guid,
      'newContext',
      params,
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_newContextForReuse({
    required ContextOptions mixin,
    Map<String, dynamic>? proxy,
    Map<String, dynamic>? storageState,
  }) async {
    final params = <String, dynamic>{};
    params.addAll(
      ((v) => v is Enum
              ? (v as dynamic).value
              : (v is Map ? v : (v as dynamic).toJson()))(mixin)
          as Map<String, dynamic>,
    );
    if (proxy != null) {
      params['proxy'] = ((v) => v is Enum
          ? (v as dynamic).value
          : (v is Map ? v : (v as dynamic).toJson()))(proxy);
    }
    if (storageState != null) {
      params['storageState'] = ((v) => v is Enum
          ? (v as dynamic).value
          : (v is Map ? v : (v as dynamic).toJson()))(storageState);
    }
    final response = await connection.sendMessageToServer(
      guid,
      'newContextForReuse',
      params,
    );
    return response;
  }

  Future<void> channel_disconnectFromReusedContext({
    required String reason,
  }) async {
    final params = <String, dynamic>{};
    params['reason'] = reason;
    final response = await connection.sendMessageToServer(
      guid,
      'disconnectFromReusedContext',
      params,
    );
    return;
  }

  Future<Map<String, dynamic>> channel_newBrowserCDPSession() async {
    final response = await connection.sendMessageToServer(
      guid,
      'newBrowserCDPSession',
      {},
    );
    return response;
  }

  Future<void> channel_startTracing({
    PageBase? page,
    bool? screenshots,
    List<String>? categories,
  }) async {
    final params = <String, dynamic>{};
    if (page != null) params['page'] = page.guid;
    if (screenshots != null) params['screenshots'] = screenshots;
    if (categories != null) params['categories'] = categories;
    final response = await connection.sendMessageToServer(
      guid,
      'startTracing',
      params,
    );
    return;
  }

  Future<Map<String, dynamic>> channel_stopTracing() async {
    final response = await connection.sendMessageToServer(
      guid,
      'stopTracing',
      {},
    );
    return response;
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
    final params = <String, dynamic>{};
    params['cookies'] = cookies;
    final response = await connection.sendMessageToServer(
      guid,
      'addCookies',
      params,
    );
    return;
  }

  Future<Map<String, dynamic>> channel_addInitScript({
    required String source,
  }) async {
    final params = <String, dynamic>{};
    params['source'] = source;
    final response = await connection.sendMessageToServer(
      guid,
      'addInitScript',
      params,
    );
    return response;
  }

  Future<void> channel_clearCookies({
    String? name,
    String? nameRegexSource,
    String? nameRegexFlags,
    String? domain,
    String? domainRegexSource,
    String? domainRegexFlags,
    String? path,
    String? pathRegexSource,
    String? pathRegexFlags,
  }) async {
    final params = <String, dynamic>{};
    if (name != null) params['name'] = name;
    if (nameRegexSource != null) params['nameRegexSource'] = nameRegexSource;
    if (nameRegexFlags != null) params['nameRegexFlags'] = nameRegexFlags;
    if (domain != null) params['domain'] = domain;
    if (domainRegexSource != null) {
      params['domainRegexSource'] = domainRegexSource;
    }
    if (domainRegexFlags != null) params['domainRegexFlags'] = domainRegexFlags;
    if (path != null) params['path'] = path;
    if (pathRegexSource != null) params['pathRegexSource'] = pathRegexSource;
    if (pathRegexFlags != null) params['pathRegexFlags'] = pathRegexFlags;
    final response = await connection.sendMessageToServer(
      guid,
      'clearCookies',
      params,
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

  Future<void> channel_close({String? reason}) async {
    final params = <String, dynamic>{};
    if (reason != null) params['reason'] = reason;
    final response = await connection.sendMessageToServer(
      guid,
      'close',
      params,
    );
    return;
  }

  Future<Map<String, dynamic>> channel_cookies({
    required List<String> urls,
  }) async {
    final params = <String, dynamic>{};
    params['urls'] = urls;
    final response = await connection.sendMessageToServer(
      guid,
      'cookies',
      params,
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_exposeBinding({
    required String name,
  }) async {
    final params = <String, dynamic>{};
    params['name'] = name;
    final response = await connection.sendMessageToServer(
      guid,
      'exposeBinding',
      params,
    );
    return response;
  }

  Future<void> channel_grantPermissions({
    required List<String> permissions,
    String? origin,
  }) async {
    final params = <String, dynamic>{};
    params['permissions'] = permissions;
    if (origin != null) params['origin'] = origin;
    final response = await connection.sendMessageToServer(
      guid,
      'grantPermissions',
      params,
    );
    return;
  }

  Future<Map<String, dynamic>> channel_newPage() async {
    final response = await connection.sendMessageToServer(guid, 'newPage', {});
    return response;
  }

  Future<void> channel_registerSelectorEngine({
    required SelectorEngine selectorEngine,
  }) async {
    final params = <String, dynamic>{};
    params['selectorEngine'] = ((v) => v is Enum
        ? (v as dynamic).value
        : (v is Map ? v : (v as dynamic).toJson()))(selectorEngine);
    final response = await connection.sendMessageToServer(
      guid,
      'registerSelectorEngine',
      params,
    );
    return;
  }

  Future<void> channel_setTestIdAttributeName({
    required String testIdAttributeName,
  }) async {
    final params = <String, dynamic>{};
    params['testIdAttributeName'] = testIdAttributeName;
    final response = await connection.sendMessageToServer(
      guid,
      'setTestIdAttributeName',
      params,
    );
    return;
  }

  Future<void> channel_setExtraHTTPHeaders({
    required List<NameValue> headers,
  }) async {
    final params = <String, dynamic>{};
    params['headers'] = headers;
    final response = await connection.sendMessageToServer(
      guid,
      'setExtraHTTPHeaders',
      params,
    );
    return;
  }

  Future<void> channel_setGeolocation({
    Map<String, dynamic>? geolocation,
  }) async {
    final params = <String, dynamic>{};
    if (geolocation != null) {
      params['geolocation'] = ((v) => v is Enum
          ? (v as dynamic).value
          : (v is Map ? v : (v as dynamic).toJson()))(geolocation);
    }
    final response = await connection.sendMessageToServer(
      guid,
      'setGeolocation',
      params,
    );
    return;
  }

  Future<void> channel_setHTTPCredentials({
    Map<String, dynamic>? httpCredentials,
  }) async {
    final params = <String, dynamic>{};
    if (httpCredentials != null) {
      params['httpCredentials'] = ((v) => v is Enum
          ? (v as dynamic).value
          : (v is Map ? v : (v as dynamic).toJson()))(httpCredentials);
    }
    final response = await connection.sendMessageToServer(
      guid,
      'setHTTPCredentials',
      params,
    );
    return;
  }

  Future<void> channel_setNetworkInterceptionPatterns({
    required List<Map<String, dynamic>> patterns,
  }) async {
    final params = <String, dynamic>{};
    params['patterns'] = patterns;
    final response = await connection.sendMessageToServer(
      guid,
      'setNetworkInterceptionPatterns',
      params,
    );
    return;
  }

  Future<void> channel_setWebSocketInterceptionPatterns({
    required List<Map<String, dynamic>> patterns,
  }) async {
    final params = <String, dynamic>{};
    params['patterns'] = patterns;
    final response = await connection.sendMessageToServer(
      guid,
      'setWebSocketInterceptionPatterns',
      params,
    );
    return;
  }

  Future<void> channel_setOffline({required bool offline}) async {
    final params = <String, dynamic>{};
    params['offline'] = offline;
    final response = await connection.sendMessageToServer(
      guid,
      'setOffline',
      params,
    );
    return;
  }

  Future<Map<String, dynamic>> channel_storageState({bool? indexedDB}) async {
    final params = <String, dynamic>{};
    if (indexedDB != null) params['indexedDB'] = indexedDB;
    final response = await connection.sendMessageToServer(
      guid,
      'storageState',
      params,
    );
    return response;
  }

  Future<void> channel_setStorageState({
    Map<String, dynamic>? storageState,
  }) async {
    final params = <String, dynamic>{};
    if (storageState != null) {
      params['storageState'] = ((v) => v is Enum
          ? (v as dynamic).value
          : (v is Map ? v : (v as dynamic).toJson()))(storageState);
    }
    final response = await connection.sendMessageToServer(
      guid,
      'setStorageState',
      params,
    );
    return;
  }

  Future<void> channel_pause() async {
    final response = await connection.sendMessageToServer(guid, 'pause', {});
    return;
  }

  Future<void> channel_enableRecorder({
    String? language,
    String? mode,
    String? recorderMode,
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
    final params = <String, dynamic>{};
    if (language != null) params['language'] = language;
    if (mode != null) params['mode'] = mode;
    if (recorderMode != null) params['recorderMode'] = recorderMode;
    if (pauseOnNextStatement != null) {
      params['pauseOnNextStatement'] = pauseOnNextStatement;
    }
    if (testIdAttributeName != null) {
      params['testIdAttributeName'] = testIdAttributeName;
    }
    if (launchOptions != null) {
      params['launchOptions'] = ((v) => v is Enum
          ? (v as dynamic).value
          : (v is Map ? v : (v as dynamic).toJson()))(launchOptions);
    }
    if (contextOptions != null) {
      params['contextOptions'] = ((v) => v is Enum
          ? (v as dynamic).value
          : (v is Map ? v : (v as dynamic).toJson()))(contextOptions);
    }
    if (device != null) params['device'] = device;
    if (saveStorage != null) params['saveStorage'] = saveStorage;
    if (outputFile != null) params['outputFile'] = outputFile;
    if (handleSIGINT != null) params['handleSIGINT'] = handleSIGINT;
    if (omitCallTracking != null) params['omitCallTracking'] = omitCallTracking;
    final response = await connection.sendMessageToServer(
      guid,
      'enableRecorder',
      params,
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

  Future<void> channel_exposeConsoleApi() async {
    final response = await connection.sendMessageToServer(
      guid,
      'exposeConsoleApi',
      {},
    );
    return;
  }

  Future<Map<String, dynamic>> channel_newCDPSession({
    PageBase? page,
    FrameBase? frame,
  }) async {
    final params = <String, dynamic>{};
    if (page != null) params['page'] = page.guid;
    if (frame != null) params['frame'] = frame.guid;
    final response = await connection.sendMessageToServer(
      guid,
      'newCDPSession',
      params,
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_createTempFiles({
    String? rootDirName,
    required List<Map<String, dynamic>> items,
  }) async {
    final params = <String, dynamic>{};
    if (rootDirName != null) params['rootDirName'] = rootDirName;
    params['items'] = items;
    final response = await connection.sendMessageToServer(
      guid,
      'createTempFiles',
      params,
    );
    return response;
  }

  Future<void> channel_updateSubscription({
    required String event,
    required bool enabled,
  }) async {
    final params = <String, dynamic>{};
    params['event'] = event;
    params['enabled'] = enabled;
    final response = await connection.sendMessageToServer(
      guid,
      'updateSubscription',
      params,
    );
    return;
  }

  Future<void> channel_clockFastForward({
    double? ticksNumber,
    String? ticksString,
  }) async {
    final params = <String, dynamic>{};
    if (ticksNumber != null) params['ticksNumber'] = ticksNumber;
    if (ticksString != null) params['ticksString'] = ticksString;
    final response = await connection.sendMessageToServer(
      guid,
      'clockFastForward',
      params,
    );
    return;
  }

  Future<void> channel_clockInstall({
    double? timeNumber,
    String? timeString,
  }) async {
    final params = <String, dynamic>{};
    if (timeNumber != null) params['timeNumber'] = timeNumber;
    if (timeString != null) params['timeString'] = timeString;
    final response = await connection.sendMessageToServer(
      guid,
      'clockInstall',
      params,
    );
    return;
  }

  Future<void> channel_clockPauseAt({
    double? timeNumber,
    String? timeString,
  }) async {
    final params = <String, dynamic>{};
    if (timeNumber != null) params['timeNumber'] = timeNumber;
    if (timeString != null) params['timeString'] = timeString;
    final response = await connection.sendMessageToServer(
      guid,
      'clockPauseAt',
      params,
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
    final params = <String, dynamic>{};
    if (ticksNumber != null) params['ticksNumber'] = ticksNumber;
    if (ticksString != null) params['ticksString'] = ticksString;
    final response = await connection.sendMessageToServer(
      guid,
      'clockRunFor',
      params,
    );
    return;
  }

  Future<void> channel_clockSetFixedTime({
    double? timeNumber,
    String? timeString,
  }) async {
    final params = <String, dynamic>{};
    if (timeNumber != null) params['timeNumber'] = timeNumber;
    if (timeString != null) params['timeString'] = timeString;
    final response = await connection.sendMessageToServer(
      guid,
      'clockSetFixedTime',
      params,
    );
    return;
  }

  Future<void> channel_clockSetSystemTime({
    double? timeNumber,
    String? timeString,
  }) async {
    final params = <String, dynamic>{};
    if (timeNumber != null) params['timeNumber'] = timeNumber;
    if (timeString != null) params['timeString'] = timeString;
    final response = await connection.sendMessageToServer(
      guid,
      'clockSetSystemTime',
      params,
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

  Future<Map<String, dynamic>> channel_launch({
    required LaunchOptions mixin,
    double? slowMo,
  }) async {
    final params = <String, dynamic>{};
    params.addAll(
      ((v) => v is Enum
              ? (v as dynamic).value
              : (v is Map ? v : (v as dynamic).toJson()))(mixin)
          as Map<String, dynamic>,
    );
    if (slowMo != null) params['slowMo'] = slowMo;
    final response = await connection.sendMessageToServer(
      guid,
      'launch',
      params,
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_launchPersistentContext({
    required LaunchOptions mixin1,
    required ContextOptions mixin2,
    required String userDataDir,
    double? slowMo,
  }) async {
    final params = <String, dynamic>{};
    params.addAll(
      ((v) => v is Enum
              ? (v as dynamic).value
              : (v is Map ? v : (v as dynamic).toJson()))(mixin1)
          as Map<String, dynamic>,
    );
    params.addAll(
      ((v) => v is Enum
              ? (v as dynamic).value
              : (v is Map ? v : (v as dynamic).toJson()))(mixin2)
          as Map<String, dynamic>,
    );
    params['userDataDir'] = userDataDir;
    if (slowMo != null) params['slowMo'] = slowMo;
    final response = await connection.sendMessageToServer(
      guid,
      'launchPersistentContext',
      params,
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_connectOverCDP({
    required String endpointURL,
    List<NameValue>? headers,
    double? slowMo,
    required double timeout,
    bool? isLocal,
    bool? noDefaults,
  }) async {
    final params = <String, dynamic>{};
    params['endpointURL'] = endpointURL;
    if (headers != null) params['headers'] = headers;
    if (slowMo != null) params['slowMo'] = slowMo;
    params['timeout'] = timeout;
    if (isLocal != null) params['isLocal'] = isLocal;
    if (noDefaults != null) params['noDefaults'] = noDefaults;
    final response = await connection.sendMessageToServer(
      guid,
      'connectOverCDP',
      params,
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_connectToWorker({
    required String endpoint,
    required double timeout,
  }) async {
    final params = <String, dynamic>{};
    params['endpoint'] = endpoint;
    params['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'connectToWorker',
      params,
    );
    return response;
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
    final params = <String, dynamic>{};
    params['info'] = ((v) => v is Enum
        ? (v as dynamic).value
        : (v is Map ? v : (v as dynamic).toJson()))(info);
    final response = await connection.sendMessageToServer(
      guid,
      'waitForEventInfo',
      params,
    );
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

  Future<Map<String, dynamic>> channel_launch({
    String? executablePath,
    List<String>? args,
    bool? chromiumSandbox,
    String? cwd,
    List<NameValue>? env,
    required double timeout,
    String? acceptDownloads,
    bool? bypassCSP,
    String? colorScheme,
    List<NameValue>? extraHTTPHeaders,
    Map<String, dynamic>? geolocation,
    Map<String, dynamic>? httpCredentials,
    bool? ignoreHTTPSErrors,
    String? locale,
    bool? offline,
    Map<String, dynamic>? recordVideo,
    bool? strictSelectors,
    String? timezoneId,
    String? tracesDir,
    String? artifactsDir,
    List<SelectorEngine>? selectorEngines,
    String? testIdAttributeName,
  }) async {
    final params = <String, dynamic>{};
    if (executablePath != null) params['executablePath'] = executablePath;
    if (args != null) params['args'] = args;
    if (chromiumSandbox != null) params['chromiumSandbox'] = chromiumSandbox;
    if (cwd != null) params['cwd'] = cwd;
    if (env != null) params['env'] = env;
    params['timeout'] = timeout;
    if (acceptDownloads != null) params['acceptDownloads'] = acceptDownloads;
    if (bypassCSP != null) params['bypassCSP'] = bypassCSP;
    if (colorScheme != null) params['colorScheme'] = colorScheme;
    if (extraHTTPHeaders != null) params['extraHTTPHeaders'] = extraHTTPHeaders;
    if (geolocation != null) {
      params['geolocation'] = ((v) => v is Enum
          ? (v as dynamic).value
          : (v is Map ? v : (v as dynamic).toJson()))(geolocation);
    }
    if (httpCredentials != null) {
      params['httpCredentials'] = ((v) => v is Enum
          ? (v as dynamic).value
          : (v is Map ? v : (v as dynamic).toJson()))(httpCredentials);
    }
    if (ignoreHTTPSErrors != null) {
      params['ignoreHTTPSErrors'] = ignoreHTTPSErrors;
    }
    if (locale != null) params['locale'] = locale;
    if (offline != null) params['offline'] = offline;
    if (recordVideo != null) {
      params['recordVideo'] = ((v) => v is Enum
          ? (v as dynamic).value
          : (v is Map ? v : (v as dynamic).toJson()))(recordVideo);
    }
    if (strictSelectors != null) params['strictSelectors'] = strictSelectors;
    if (timezoneId != null) params['timezoneId'] = timezoneId;
    if (tracesDir != null) params['tracesDir'] = tracesDir;
    if (artifactsDir != null) params['artifactsDir'] = artifactsDir;
    if (selectorEngines != null) params['selectorEngines'] = selectorEngines;
    if (testIdAttributeName != null) {
      params['testIdAttributeName'] = testIdAttributeName;
    }
    final response = await connection.sendMessageToServer(
      guid,
      'launch',
      params,
    );
    return response;
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

  Future<Map<String, dynamic>> channel_browserWindow({
    required PageBase page,
  }) async {
    final params = <String, dynamic>{};
    params['page'] = page.guid;
    final response = await connection.sendMessageToServer(
      guid,
      'browserWindow',
      params,
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_evaluateExpression({
    required String expression,
    bool? isFunction,
    required SerializedArgument arg,
  }) async {
    final params = <String, dynamic>{};
    params['expression'] = expression;
    if (isFunction != null) params['isFunction'] = isFunction;
    params['arg'] = ((v) => v is Enum
        ? (v as dynamic).value
        : (v is Map ? v : (v as dynamic).toJson()))(arg);
    final response = await connection.sendMessageToServer(
      guid,
      'evaluateExpression',
      params,
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_evaluateExpressionHandle({
    required String expression,
    bool? isFunction,
    required SerializedArgument arg,
  }) async {
    final params = <String, dynamic>{};
    params['expression'] = expression;
    if (isFunction != null) params['isFunction'] = isFunction;
    params['arg'] = ((v) => v is Enum
        ? (v as dynamic).value
        : (v is Map ? v : (v as dynamic).toJson()))(arg);
    final response = await connection.sendMessageToServer(
      guid,
      'evaluateExpressionHandle',
      params,
    );
    return response;
  }

  Future<void> channel_updateSubscription({
    required String event,
    required bool enabled,
  }) async {
    final params = <String, dynamic>{};
    params['event'] = event;
    params['enabled'] = enabled;
    final response = await connection.sendMessageToServer(
      guid,
      'updateSubscription',
      params,
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

  Future<Map<String, dynamic>> channel_evalOnSelector({
    required String selector,
    bool? strict,
    required String expression,
    bool? isFunction,
    required SerializedArgument arg,
  }) async {
    final params = <String, dynamic>{};
    params['selector'] = selector;
    if (strict != null) params['strict'] = strict;
    params['expression'] = expression;
    if (isFunction != null) params['isFunction'] = isFunction;
    params['arg'] = ((v) => v is Enum
        ? (v as dynamic).value
        : (v is Map ? v : (v as dynamic).toJson()))(arg);
    final response = await connection.sendMessageToServer(
      guid,
      'evalOnSelector',
      params,
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_evalOnSelectorAll({
    required String selector,
    required String expression,
    bool? isFunction,
    required SerializedArgument arg,
  }) async {
    final params = <String, dynamic>{};
    params['selector'] = selector;
    params['expression'] = expression;
    if (isFunction != null) params['isFunction'] = isFunction;
    params['arg'] = ((v) => v is Enum
        ? (v as dynamic).value
        : (v is Map ? v : (v as dynamic).toJson()))(arg);
    final response = await connection.sendMessageToServer(
      guid,
      'evalOnSelectorAll',
      params,
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_addScriptTag({
    String? url,
    String? content,
    String? type,
  }) async {
    final params = <String, dynamic>{};
    if (url != null) params['url'] = url;
    if (content != null) params['content'] = content;
    if (type != null) params['type'] = type;
    final response = await connection.sendMessageToServer(
      guid,
      'addScriptTag',
      params,
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_addStyleTag({
    String? url,
    String? content,
  }) async {
    final params = <String, dynamic>{};
    if (url != null) params['url'] = url;
    if (content != null) params['content'] = content;
    final response = await connection.sendMessageToServer(
      guid,
      'addStyleTag',
      params,
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_ariaSnapshot({
    String? mode,
    String? track,
    String? selector,
    int? depth,
    bool? boxes,
    required double timeout,
  }) async {
    final params = <String, dynamic>{};
    if (mode != null) params['mode'] = mode;
    if (track != null) params['track'] = track;
    if (selector != null) params['selector'] = selector;
    if (depth != null) params['depth'] = depth;
    if (boxes != null) params['boxes'] = boxes;
    params['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'ariaSnapshot',
      params,
    );
    return response;
  }

  Future<void> channel_blur({
    required String selector,
    bool? strict,
    required double timeout,
  }) async {
    final params = <String, dynamic>{};
    params['selector'] = selector;
    if (strict != null) params['strict'] = strict;
    params['timeout'] = timeout;
    final response = await connection.sendMessageToServer(guid, 'blur', params);
    return;
  }

  Future<void> channel_check({
    required String selector,
    bool? strict,
    bool? force,
    Point? position,
    required double timeout,
    bool? trial,
  }) async {
    final params = <String, dynamic>{};
    params['selector'] = selector;
    if (strict != null) params['strict'] = strict;
    if (force != null) params['force'] = force;
    if (position != null) {
      params['position'] = ((v) => v is Enum
          ? (v as dynamic).value
          : (v is Map ? v : (v as dynamic).toJson()))(position);
    }
    params['timeout'] = timeout;
    if (trial != null) params['trial'] = trial;
    final response = await connection.sendMessageToServer(
      guid,
      'check',
      params,
    );
    return;
  }

  Future<void> channel_click({
    required String selector,
    bool? strict,
    bool? force,
    bool? noWaitAfter,
    List<String>? modifiers,
    Point? position,
    double? delay,
    String? button,
    int? clickCount,
    required double timeout,
    bool? trial,
    int? steps,
  }) async {
    final params = <String, dynamic>{};
    params['selector'] = selector;
    if (strict != null) params['strict'] = strict;
    if (force != null) params['force'] = force;
    if (noWaitAfter != null) params['noWaitAfter'] = noWaitAfter;
    if (modifiers != null) params['modifiers'] = modifiers;
    if (position != null) {
      params['position'] = ((v) => v is Enum
          ? (v as dynamic).value
          : (v is Map ? v : (v as dynamic).toJson()))(position);
    }
    if (delay != null) params['delay'] = delay;
    if (button != null) params['button'] = button;
    if (clickCount != null) params['clickCount'] = clickCount;
    params['timeout'] = timeout;
    if (trial != null) params['trial'] = trial;
    if (steps != null) params['steps'] = steps;
    final response = await connection.sendMessageToServer(
      guid,
      'click',
      params,
    );
    return;
  }

  Future<Map<String, dynamic>> channel_content() async {
    final response = await connection.sendMessageToServer(guid, 'content', {});
    return response;
  }

  Future<void> channel_dragAndDrop({
    required String source,
    required String target,
    bool? force,
    required double timeout,
    bool? trial,
    Point? sourcePosition,
    Point? targetPosition,
    bool? strict,
    int? steps,
  }) async {
    final params = <String, dynamic>{};
    params['source'] = source;
    params['target'] = target;
    if (force != null) params['force'] = force;
    params['timeout'] = timeout;
    if (trial != null) params['trial'] = trial;
    if (sourcePosition != null) {
      params['sourcePosition'] = ((v) => v is Enum
          ? (v as dynamic).value
          : (v is Map ? v : (v as dynamic).toJson()))(sourcePosition);
    }
    if (targetPosition != null) {
      params['targetPosition'] = ((v) => v is Enum
          ? (v as dynamic).value
          : (v is Map ? v : (v as dynamic).toJson()))(targetPosition);
    }
    if (strict != null) params['strict'] = strict;
    if (steps != null) params['steps'] = steps;
    final response = await connection.sendMessageToServer(
      guid,
      'dragAndDrop',
      params,
    );
    return;
  }

  Future<void> channel_drop({
    required String selector,
    bool? strict,
    Point? position,
    List<Map<String, dynamic>>? payloads,
    List<String>? localPaths,
    List<WritableStreamBase>? streams,
    List<Map<String, dynamic>>? data,
    required double timeout,
  }) async {
    final params = <String, dynamic>{};
    params['selector'] = selector;
    if (strict != null) params['strict'] = strict;
    if (position != null) {
      params['position'] = ((v) => v is Enum
          ? (v as dynamic).value
          : (v is Map ? v : (v as dynamic).toJson()))(position);
    }
    if (payloads != null) params['payloads'] = payloads;
    if (localPaths != null) params['localPaths'] = localPaths;
    if (streams != null) params['streams'] = streams;
    if (data != null) params['data'] = data;
    params['timeout'] = timeout;
    final response = await connection.sendMessageToServer(guid, 'drop', params);
    return;
  }

  Future<void> channel_dblclick({
    required String selector,
    bool? strict,
    bool? force,
    List<String>? modifiers,
    Point? position,
    double? delay,
    String? button,
    required double timeout,
    bool? trial,
    int? steps,
  }) async {
    final params = <String, dynamic>{};
    params['selector'] = selector;
    if (strict != null) params['strict'] = strict;
    if (force != null) params['force'] = force;
    if (modifiers != null) params['modifiers'] = modifiers;
    if (position != null) {
      params['position'] = ((v) => v is Enum
          ? (v as dynamic).value
          : (v is Map ? v : (v as dynamic).toJson()))(position);
    }
    if (delay != null) params['delay'] = delay;
    if (button != null) params['button'] = button;
    params['timeout'] = timeout;
    if (trial != null) params['trial'] = trial;
    if (steps != null) params['steps'] = steps;
    final response = await connection.sendMessageToServer(
      guid,
      'dblclick',
      params,
    );
    return;
  }

  Future<void> channel_dispatchEvent({
    required String selector,
    bool? strict,
    required String type,
    required SerializedArgument eventInit,
    required double timeout,
  }) async {
    final params = <String, dynamic>{};
    params['selector'] = selector;
    if (strict != null) params['strict'] = strict;
    params['type'] = type;
    params['eventInit'] = ((v) => v is Enum
        ? (v as dynamic).value
        : (v is Map ? v : (v as dynamic).toJson()))(eventInit);
    params['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'dispatchEvent',
      params,
    );
    return;
  }

  Future<Map<String, dynamic>> channel_evaluateExpression({
    required String expression,
    bool? isFunction,
    required SerializedArgument arg,
  }) async {
    final params = <String, dynamic>{};
    params['expression'] = expression;
    if (isFunction != null) params['isFunction'] = isFunction;
    params['arg'] = ((v) => v is Enum
        ? (v as dynamic).value
        : (v is Map ? v : (v as dynamic).toJson()))(arg);
    final response = await connection.sendMessageToServer(
      guid,
      'evaluateExpression',
      params,
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_evaluateExpressionHandle({
    required String expression,
    bool? isFunction,
    required SerializedArgument arg,
  }) async {
    final params = <String, dynamic>{};
    params['expression'] = expression;
    if (isFunction != null) params['isFunction'] = isFunction;
    params['arg'] = ((v) => v is Enum
        ? (v as dynamic).value
        : (v is Map ? v : (v as dynamic).toJson()))(arg);
    final response = await connection.sendMessageToServer(
      guid,
      'evaluateExpressionHandle',
      params,
    );
    return response;
  }

  Future<void> channel_fill({
    required String selector,
    bool? strict,
    required String value,
    bool? force,
    required double timeout,
  }) async {
    final params = <String, dynamic>{};
    params['selector'] = selector;
    if (strict != null) params['strict'] = strict;
    params['value'] = value;
    if (force != null) params['force'] = force;
    params['timeout'] = timeout;
    final response = await connection.sendMessageToServer(guid, 'fill', params);
    return;
  }

  Future<void> channel_focus({
    required String selector,
    bool? strict,
    required double timeout,
  }) async {
    final params = <String, dynamic>{};
    params['selector'] = selector;
    if (strict != null) params['strict'] = strict;
    params['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'focus',
      params,
    );
    return;
  }

  Future<Map<String, dynamic>> channel_frameElement() async {
    final response = await connection.sendMessageToServer(
      guid,
      'frameElement',
      {},
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_resolveSelector({
    required String selector,
  }) async {
    final params = <String, dynamic>{};
    params['selector'] = selector;
    final response = await connection.sendMessageToServer(
      guid,
      'resolveSelector',
      params,
    );
    return response;
  }

  Future<void> channel_highlight({
    required String selector,
    String? style,
  }) async {
    final params = <String, dynamic>{};
    params['selector'] = selector;
    if (style != null) params['style'] = style;
    final response = await connection.sendMessageToServer(
      guid,
      'highlight',
      params,
    );
    return;
  }

  Future<void> channel_hideHighlight({required String selector}) async {
    final params = <String, dynamic>{};
    params['selector'] = selector;
    final response = await connection.sendMessageToServer(
      guid,
      'hideHighlight',
      params,
    );
    return;
  }

  Future<Map<String, dynamic>> channel_getAttribute({
    required String selector,
    bool? strict,
    required String name,
    required double timeout,
  }) async {
    final params = <String, dynamic>{};
    params['selector'] = selector;
    if (strict != null) params['strict'] = strict;
    params['name'] = name;
    params['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'getAttribute',
      params,
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_goto({
    required String url,
    required double timeout,
    LifecycleEvent? waitUntil,
    String? referer,
  }) async {
    final params = <String, dynamic>{};
    params['url'] = url;
    params['timeout'] = timeout;
    if (waitUntil != null) {
      params['waitUntil'] = ((v) => v is Enum
          ? (v as dynamic).value
          : (v is Map ? v : (v as dynamic).toJson()))(waitUntil);
    }
    if (referer != null) params['referer'] = referer;
    final response = await connection.sendMessageToServer(guid, 'goto', params);
    return response;
  }

  Future<void> channel_hover({
    required String selector,
    bool? strict,
    bool? force,
    List<String>? modifiers,
    Point? position,
    required double timeout,
    bool? trial,
  }) async {
    final params = <String, dynamic>{};
    params['selector'] = selector;
    if (strict != null) params['strict'] = strict;
    if (force != null) params['force'] = force;
    if (modifiers != null) params['modifiers'] = modifiers;
    if (position != null) {
      params['position'] = ((v) => v is Enum
          ? (v as dynamic).value
          : (v is Map ? v : (v as dynamic).toJson()))(position);
    }
    params['timeout'] = timeout;
    if (trial != null) params['trial'] = trial;
    final response = await connection.sendMessageToServer(
      guid,
      'hover',
      params,
    );
    return;
  }

  Future<Map<String, dynamic>> channel_innerHTML({
    required String selector,
    bool? strict,
    required double timeout,
  }) async {
    final params = <String, dynamic>{};
    params['selector'] = selector;
    if (strict != null) params['strict'] = strict;
    params['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'innerHTML',
      params,
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_innerText({
    required String selector,
    bool? strict,
    required double timeout,
  }) async {
    final params = <String, dynamic>{};
    params['selector'] = selector;
    if (strict != null) params['strict'] = strict;
    params['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'innerText',
      params,
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_inputValue({
    required String selector,
    bool? strict,
    required double timeout,
  }) async {
    final params = <String, dynamic>{};
    params['selector'] = selector;
    if (strict != null) params['strict'] = strict;
    params['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'inputValue',
      params,
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_isChecked({
    required String selector,
    bool? strict,
    required double timeout,
  }) async {
    final params = <String, dynamic>{};
    params['selector'] = selector;
    if (strict != null) params['strict'] = strict;
    params['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'isChecked',
      params,
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_isDisabled({
    required String selector,
    bool? strict,
    required double timeout,
  }) async {
    final params = <String, dynamic>{};
    params['selector'] = selector;
    if (strict != null) params['strict'] = strict;
    params['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'isDisabled',
      params,
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_isEnabled({
    required String selector,
    bool? strict,
    required double timeout,
  }) async {
    final params = <String, dynamic>{};
    params['selector'] = selector;
    if (strict != null) params['strict'] = strict;
    params['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'isEnabled',
      params,
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_isHidden({
    required String selector,
    bool? strict,
  }) async {
    final params = <String, dynamic>{};
    params['selector'] = selector;
    if (strict != null) params['strict'] = strict;
    final response = await connection.sendMessageToServer(
      guid,
      'isHidden',
      params,
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_isVisible({
    required String selector,
    bool? strict,
  }) async {
    final params = <String, dynamic>{};
    params['selector'] = selector;
    if (strict != null) params['strict'] = strict;
    final response = await connection.sendMessageToServer(
      guid,
      'isVisible',
      params,
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_isEditable({
    required String selector,
    bool? strict,
    required double timeout,
  }) async {
    final params = <String, dynamic>{};
    params['selector'] = selector;
    if (strict != null) params['strict'] = strict;
    params['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'isEditable',
      params,
    );
    return response;
  }

  Future<void> channel_press({
    required String selector,
    bool? strict,
    required String key,
    double? delay,
    bool? noWaitAfter,
    required double timeout,
  }) async {
    final params = <String, dynamic>{};
    params['selector'] = selector;
    if (strict != null) params['strict'] = strict;
    params['key'] = key;
    if (delay != null) params['delay'] = delay;
    if (noWaitAfter != null) params['noWaitAfter'] = noWaitAfter;
    params['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'press',
      params,
    );
    return;
  }

  Future<Map<String, dynamic>> channel_querySelector({
    required String selector,
    bool? strict,
  }) async {
    final params = <String, dynamic>{};
    params['selector'] = selector;
    if (strict != null) params['strict'] = strict;
    final response = await connection.sendMessageToServer(
      guid,
      'querySelector',
      params,
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_querySelectorAll({
    required String selector,
  }) async {
    final params = <String, dynamic>{};
    params['selector'] = selector;
    final response = await connection.sendMessageToServer(
      guid,
      'querySelectorAll',
      params,
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_queryCount({
    required String selector,
  }) async {
    final params = <String, dynamic>{};
    params['selector'] = selector;
    final response = await connection.sendMessageToServer(
      guid,
      'queryCount',
      params,
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_selectOption({
    required String selector,
    bool? strict,
    List<ElementHandleBase>? elements,
    List<Map<String, dynamic>>? options,
    bool? force,
    required double timeout,
  }) async {
    final params = <String, dynamic>{};
    params['selector'] = selector;
    if (strict != null) params['strict'] = strict;
    if (elements != null) params['elements'] = elements;
    if (options != null) params['options'] = options;
    if (force != null) params['force'] = force;
    params['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'selectOption',
      params,
    );
    return response;
  }

  Future<void> channel_setContent({
    required String html,
    required double timeout,
    LifecycleEvent? waitUntil,
  }) async {
    final params = <String, dynamic>{};
    params['html'] = html;
    params['timeout'] = timeout;
    if (waitUntil != null) {
      params['waitUntil'] = ((v) => v is Enum
          ? (v as dynamic).value
          : (v is Map ? v : (v as dynamic).toJson()))(waitUntil);
    }
    final response = await connection.sendMessageToServer(
      guid,
      'setContent',
      params,
    );
    return;
  }

  Future<void> channel_setInputFiles({
    required String selector,
    bool? strict,
    List<Map<String, dynamic>>? payloads,
    String? localDirectory,
    WritableStreamBase? directoryStream,
    List<String>? localPaths,
    List<WritableStreamBase>? streams,
    required double timeout,
  }) async {
    final params = <String, dynamic>{};
    params['selector'] = selector;
    if (strict != null) params['strict'] = strict;
    if (payloads != null) params['payloads'] = payloads;
    if (localDirectory != null) params['localDirectory'] = localDirectory;
    if (directoryStream != null) {
      params['directoryStream'] = directoryStream.guid;
    }
    if (localPaths != null) params['localPaths'] = localPaths;
    if (streams != null) params['streams'] = streams;
    params['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'setInputFiles',
      params,
    );
    return;
  }

  Future<void> channel_tap({
    required String selector,
    bool? strict,
    bool? force,
    List<String>? modifiers,
    Point? position,
    required double timeout,
    bool? trial,
  }) async {
    final params = <String, dynamic>{};
    params['selector'] = selector;
    if (strict != null) params['strict'] = strict;
    if (force != null) params['force'] = force;
    if (modifiers != null) params['modifiers'] = modifiers;
    if (position != null) {
      params['position'] = ((v) => v is Enum
          ? (v as dynamic).value
          : (v is Map ? v : (v as dynamic).toJson()))(position);
    }
    params['timeout'] = timeout;
    if (trial != null) params['trial'] = trial;
    final response = await connection.sendMessageToServer(guid, 'tap', params);
    return;
  }

  Future<Map<String, dynamic>> channel_textContent({
    required String selector,
    bool? strict,
    required double timeout,
  }) async {
    final params = <String, dynamic>{};
    params['selector'] = selector;
    if (strict != null) params['strict'] = strict;
    params['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'textContent',
      params,
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_title() async {
    final response = await connection.sendMessageToServer(guid, 'title', {});
    return response;
  }

  Future<void> channel_type({
    required String selector,
    bool? strict,
    required String text,
    double? delay,
    required double timeout,
  }) async {
    final params = <String, dynamic>{};
    params['selector'] = selector;
    if (strict != null) params['strict'] = strict;
    params['text'] = text;
    if (delay != null) params['delay'] = delay;
    params['timeout'] = timeout;
    final response = await connection.sendMessageToServer(guid, 'type', params);
    return;
  }

  Future<void> channel_uncheck({
    required String selector,
    bool? strict,
    bool? force,
    Point? position,
    required double timeout,
    bool? trial,
  }) async {
    final params = <String, dynamic>{};
    params['selector'] = selector;
    if (strict != null) params['strict'] = strict;
    if (force != null) params['force'] = force;
    if (position != null) {
      params['position'] = ((v) => v is Enum
          ? (v as dynamic).value
          : (v is Map ? v : (v as dynamic).toJson()))(position);
    }
    params['timeout'] = timeout;
    if (trial != null) params['trial'] = trial;
    final response = await connection.sendMessageToServer(
      guid,
      'uncheck',
      params,
    );
    return;
  }

  Future<void> channel_waitForTimeout({required double waitTimeout}) async {
    final params = <String, dynamic>{};
    params['waitTimeout'] = waitTimeout;
    final response = await connection.sendMessageToServer(
      guid,
      'waitForTimeout',
      params,
    );
    return;
  }

  Future<Map<String, dynamic>> channel_waitForFunction({
    required String expression,
    bool? isFunction,
    required SerializedArgument arg,
    required double timeout,
    double? pollingInterval,
  }) async {
    final params = <String, dynamic>{};
    params['expression'] = expression;
    if (isFunction != null) params['isFunction'] = isFunction;
    params['arg'] = ((v) => v is Enum
        ? (v as dynamic).value
        : (v is Map ? v : (v as dynamic).toJson()))(arg);
    params['timeout'] = timeout;
    if (pollingInterval != null) params['pollingInterval'] = pollingInterval;
    final response = await connection.sendMessageToServer(
      guid,
      'waitForFunction',
      params,
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_waitForSelector({
    required String selector,
    bool? strict,
    required double timeout,
    String? state,
    bool? omitReturnValue,
  }) async {
    final params = <String, dynamic>{};
    params['selector'] = selector;
    if (strict != null) params['strict'] = strict;
    params['timeout'] = timeout;
    if (state != null) params['state'] = state;
    if (omitReturnValue != null) params['omitReturnValue'] = omitReturnValue;
    final response = await connection.sendMessageToServer(
      guid,
      'waitForSelector',
      params,
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_expect({
    String? selector,
    required String expression,
    Map<String, dynamic>? expressionArg,
    String? pseudo,
    List<ExpectedTextValue>? expectedText,
    double? expectedNumber,
    SerializedArgument? expectedValue,
    bool? useInnerText,
    required bool isNot,
    required double timeout,
  }) async {
    final params = <String, dynamic>{};
    if (selector != null) params['selector'] = selector;
    params['expression'] = expression;
    if (expressionArg != null) {
      params['expressionArg'] = ((v) => v is Enum
          ? (v as dynamic).value
          : (v is Map ? v : (v as dynamic).toJson()))(expressionArg);
    }
    if (pseudo != null) params['pseudo'] = pseudo;
    if (expectedText != null) params['expectedText'] = expectedText;
    if (expectedNumber != null) params['expectedNumber'] = expectedNumber;
    if (expectedValue != null) {
      params['expectedValue'] = ((v) => v is Enum
          ? (v as dynamic).value
          : (v is Map ? v : (v as dynamic).toJson()))(expectedValue);
    }
    if (useInnerText != null) params['useInnerText'] = useInnerText;
    params['isNot'] = isNot;
    params['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'expect',
      params,
    );
    return response;
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

  Future<Map<String, dynamic>> channel_evaluateExpression({
    required String expression,
    bool? isFunction,
    required SerializedArgument arg,
  }) async {
    final params = <String, dynamic>{};
    params['expression'] = expression;
    if (isFunction != null) params['isFunction'] = isFunction;
    params['arg'] = ((v) => v is Enum
        ? (v as dynamic).value
        : (v is Map ? v : (v as dynamic).toJson()))(arg);
    final response = await connection.sendMessageToServer(
      guid,
      'evaluateExpression',
      params,
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_evaluateExpressionHandle({
    required String expression,
    bool? isFunction,
    required SerializedArgument arg,
  }) async {
    final params = <String, dynamic>{};
    params['expression'] = expression;
    if (isFunction != null) params['isFunction'] = isFunction;
    params['arg'] = ((v) => v is Enum
        ? (v as dynamic).value
        : (v is Map ? v : (v as dynamic).toJson()))(arg);
    final response = await connection.sendMessageToServer(
      guid,
      'evaluateExpressionHandle',
      params,
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_getPropertyList() async {
    final response = await connection.sendMessageToServer(
      guid,
      'getPropertyList',
      {},
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_getProperty({
    required String name,
  }) async {
    final params = <String, dynamic>{};
    params['name'] = name;
    final response = await connection.sendMessageToServer(
      guid,
      'getProperty',
      params,
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_jsonValue() async {
    final response = await connection.sendMessageToServer(
      guid,
      'jsonValue',
      {},
    );
    return response;
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

  Future<Map<String, dynamic>> channel_evalOnSelector({
    required String selector,
    bool? strict,
    required String expression,
    bool? isFunction,
    required SerializedArgument arg,
  }) async {
    final params = <String, dynamic>{};
    params['selector'] = selector;
    if (strict != null) params['strict'] = strict;
    params['expression'] = expression;
    if (isFunction != null) params['isFunction'] = isFunction;
    params['arg'] = ((v) => v is Enum
        ? (v as dynamic).value
        : (v is Map ? v : (v as dynamic).toJson()))(arg);
    final response = await connection.sendMessageToServer(
      guid,
      'evalOnSelector',
      params,
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_evalOnSelectorAll({
    required String selector,
    required String expression,
    bool? isFunction,
    required SerializedArgument arg,
  }) async {
    final params = <String, dynamic>{};
    params['selector'] = selector;
    params['expression'] = expression;
    if (isFunction != null) params['isFunction'] = isFunction;
    params['arg'] = ((v) => v is Enum
        ? (v as dynamic).value
        : (v is Map ? v : (v as dynamic).toJson()))(arg);
    final response = await connection.sendMessageToServer(
      guid,
      'evalOnSelectorAll',
      params,
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_boundingBox() async {
    final response = await connection.sendMessageToServer(
      guid,
      'boundingBox',
      {},
    );
    return response;
  }

  Future<void> channel_check({
    bool? force,
    Point? position,
    required double timeout,
    bool? trial,
  }) async {
    final params = <String, dynamic>{};
    if (force != null) params['force'] = force;
    if (position != null) {
      params['position'] = ((v) => v is Enum
          ? (v as dynamic).value
          : (v is Map ? v : (v as dynamic).toJson()))(position);
    }
    params['timeout'] = timeout;
    if (trial != null) params['trial'] = trial;
    final response = await connection.sendMessageToServer(
      guid,
      'check',
      params,
    );
    return;
  }

  Future<void> channel_click({
    bool? force,
    bool? noWaitAfter,
    List<String>? modifiers,
    Point? position,
    double? delay,
    String? button,
    int? clickCount,
    required double timeout,
    bool? trial,
    int? steps,
  }) async {
    final params = <String, dynamic>{};
    if (force != null) params['force'] = force;
    if (noWaitAfter != null) params['noWaitAfter'] = noWaitAfter;
    if (modifiers != null) params['modifiers'] = modifiers;
    if (position != null) {
      params['position'] = ((v) => v is Enum
          ? (v as dynamic).value
          : (v is Map ? v : (v as dynamic).toJson()))(position);
    }
    if (delay != null) params['delay'] = delay;
    if (button != null) params['button'] = button;
    if (clickCount != null) params['clickCount'] = clickCount;
    params['timeout'] = timeout;
    if (trial != null) params['trial'] = trial;
    if (steps != null) params['steps'] = steps;
    final response = await connection.sendMessageToServer(
      guid,
      'click',
      params,
    );
    return;
  }

  Future<Map<String, dynamic>> channel_contentFrame() async {
    final response = await connection.sendMessageToServer(
      guid,
      'contentFrame',
      {},
    );
    return response;
  }

  Future<void> channel_dblclick({
    bool? force,
    List<String>? modifiers,
    Point? position,
    double? delay,
    String? button,
    required double timeout,
    bool? trial,
    int? steps,
  }) async {
    final params = <String, dynamic>{};
    if (force != null) params['force'] = force;
    if (modifiers != null) params['modifiers'] = modifiers;
    if (position != null) {
      params['position'] = ((v) => v is Enum
          ? (v as dynamic).value
          : (v is Map ? v : (v as dynamic).toJson()))(position);
    }
    if (delay != null) params['delay'] = delay;
    if (button != null) params['button'] = button;
    params['timeout'] = timeout;
    if (trial != null) params['trial'] = trial;
    if (steps != null) params['steps'] = steps;
    final response = await connection.sendMessageToServer(
      guid,
      'dblclick',
      params,
    );
    return;
  }

  Future<void> channel_dispatchEvent({
    required String type,
    required SerializedArgument eventInit,
  }) async {
    final params = <String, dynamic>{};
    params['type'] = type;
    params['eventInit'] = ((v) => v is Enum
        ? (v as dynamic).value
        : (v is Map ? v : (v as dynamic).toJson()))(eventInit);
    final response = await connection.sendMessageToServer(
      guid,
      'dispatchEvent',
      params,
    );
    return;
  }

  Future<void> channel_fill({
    required String value,
    bool? force,
    required double timeout,
  }) async {
    final params = <String, dynamic>{};
    params['value'] = value;
    if (force != null) params['force'] = force;
    params['timeout'] = timeout;
    final response = await connection.sendMessageToServer(guid, 'fill', params);
    return;
  }

  Future<void> channel_focus() async {
    final response = await connection.sendMessageToServer(guid, 'focus', {});
    return;
  }

  Future<Map<String, dynamic>> channel_getAttribute({
    required String name,
  }) async {
    final params = <String, dynamic>{};
    params['name'] = name;
    final response = await connection.sendMessageToServer(
      guid,
      'getAttribute',
      params,
    );
    return response;
  }

  Future<void> channel_hover({
    bool? force,
    List<String>? modifiers,
    Point? position,
    required double timeout,
    bool? trial,
  }) async {
    final params = <String, dynamic>{};
    if (force != null) params['force'] = force;
    if (modifiers != null) params['modifiers'] = modifiers;
    if (position != null) {
      params['position'] = ((v) => v is Enum
          ? (v as dynamic).value
          : (v is Map ? v : (v as dynamic).toJson()))(position);
    }
    params['timeout'] = timeout;
    if (trial != null) params['trial'] = trial;
    final response = await connection.sendMessageToServer(
      guid,
      'hover',
      params,
    );
    return;
  }

  Future<Map<String, dynamic>> channel_innerHTML() async {
    final response = await connection.sendMessageToServer(
      guid,
      'innerHTML',
      {},
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_innerText() async {
    final response = await connection.sendMessageToServer(
      guid,
      'innerText',
      {},
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_inputValue() async {
    final response = await connection.sendMessageToServer(
      guid,
      'inputValue',
      {},
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_isChecked() async {
    final response = await connection.sendMessageToServer(
      guid,
      'isChecked',
      {},
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_isDisabled() async {
    final response = await connection.sendMessageToServer(
      guid,
      'isDisabled',
      {},
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_isEditable() async {
    final response = await connection.sendMessageToServer(
      guid,
      'isEditable',
      {},
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_isEnabled() async {
    final response = await connection.sendMessageToServer(
      guid,
      'isEnabled',
      {},
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_isHidden() async {
    final response = await connection.sendMessageToServer(guid, 'isHidden', {});
    return response;
  }

  Future<Map<String, dynamic>> channel_isVisible() async {
    final response = await connection.sendMessageToServer(
      guid,
      'isVisible',
      {},
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_ownerFrame() async {
    final response = await connection.sendMessageToServer(
      guid,
      'ownerFrame',
      {},
    );
    return response;
  }

  Future<void> channel_press({
    required String key,
    double? delay,
    required double timeout,
    bool? noWaitAfter,
  }) async {
    final params = <String, dynamic>{};
    params['key'] = key;
    if (delay != null) params['delay'] = delay;
    params['timeout'] = timeout;
    if (noWaitAfter != null) params['noWaitAfter'] = noWaitAfter;
    final response = await connection.sendMessageToServer(
      guid,
      'press',
      params,
    );
    return;
  }

  Future<Map<String, dynamic>> channel_querySelector({
    required String selector,
    bool? strict,
  }) async {
    final params = <String, dynamic>{};
    params['selector'] = selector;
    if (strict != null) params['strict'] = strict;
    final response = await connection.sendMessageToServer(
      guid,
      'querySelector',
      params,
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_querySelectorAll({
    required String selector,
  }) async {
    final params = <String, dynamic>{};
    params['selector'] = selector;
    final response = await connection.sendMessageToServer(
      guid,
      'querySelectorAll',
      params,
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_screenshot({
    required double timeout,
    String? type,
    int? quality,
    required CommonScreenshotOptions mixin,
  }) async {
    final params = <String, dynamic>{};
    params['timeout'] = timeout;
    if (type != null) params['type'] = type;
    if (quality != null) params['quality'] = quality;
    params.addAll(
      ((v) => v is Enum
              ? (v as dynamic).value
              : (v is Map ? v : (v as dynamic).toJson()))(mixin)
          as Map<String, dynamic>,
    );
    final response = await connection.sendMessageToServer(
      guid,
      'screenshot',
      params,
    );
    return response;
  }

  Future<void> channel_scrollIntoViewIfNeeded({required double timeout}) async {
    final params = <String, dynamic>{};
    params['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'scrollIntoViewIfNeeded',
      params,
    );
    return;
  }

  Future<Map<String, dynamic>> channel_selectOption({
    List<ElementHandleBase>? elements,
    List<Map<String, dynamic>>? options,
    bool? force,
    required double timeout,
  }) async {
    final params = <String, dynamic>{};
    if (elements != null) params['elements'] = elements;
    if (options != null) params['options'] = options;
    if (force != null) params['force'] = force;
    params['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'selectOption',
      params,
    );
    return response;
  }

  Future<void> channel_selectText({
    bool? force,
    required double timeout,
  }) async {
    final params = <String, dynamic>{};
    if (force != null) params['force'] = force;
    params['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'selectText',
      params,
    );
    return;
  }

  Future<void> channel_setInputFiles({
    List<Map<String, dynamic>>? payloads,
    String? localDirectory,
    WritableStreamBase? directoryStream,
    List<String>? localPaths,
    List<WritableStreamBase>? streams,
    required double timeout,
  }) async {
    final params = <String, dynamic>{};
    if (payloads != null) params['payloads'] = payloads;
    if (localDirectory != null) params['localDirectory'] = localDirectory;
    if (directoryStream != null) {
      params['directoryStream'] = directoryStream.guid;
    }
    if (localPaths != null) params['localPaths'] = localPaths;
    if (streams != null) params['streams'] = streams;
    params['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'setInputFiles',
      params,
    );
    return;
  }

  Future<void> channel_tap({
    bool? force,
    List<String>? modifiers,
    Point? position,
    required double timeout,
    bool? trial,
  }) async {
    final params = <String, dynamic>{};
    if (force != null) params['force'] = force;
    if (modifiers != null) params['modifiers'] = modifiers;
    if (position != null) {
      params['position'] = ((v) => v is Enum
          ? (v as dynamic).value
          : (v is Map ? v : (v as dynamic).toJson()))(position);
    }
    params['timeout'] = timeout;
    if (trial != null) params['trial'] = trial;
    final response = await connection.sendMessageToServer(guid, 'tap', params);
    return;
  }

  Future<Map<String, dynamic>> channel_textContent() async {
    final response = await connection.sendMessageToServer(
      guid,
      'textContent',
      {},
    );
    return response;
  }

  Future<void> channel_type({
    required String text,
    double? delay,
    required double timeout,
  }) async {
    final params = <String, dynamic>{};
    params['text'] = text;
    if (delay != null) params['delay'] = delay;
    params['timeout'] = timeout;
    final response = await connection.sendMessageToServer(guid, 'type', params);
    return;
  }

  Future<void> channel_uncheck({
    bool? force,
    Point? position,
    required double timeout,
    bool? trial,
  }) async {
    final params = <String, dynamic>{};
    if (force != null) params['force'] = force;
    if (position != null) {
      params['position'] = ((v) => v is Enum
          ? (v as dynamic).value
          : (v is Map ? v : (v as dynamic).toJson()))(position);
    }
    params['timeout'] = timeout;
    if (trial != null) params['trial'] = trial;
    final response = await connection.sendMessageToServer(
      guid,
      'uncheck',
      params,
    );
    return;
  }

  Future<void> channel_waitForElementState({
    required String state,
    required double timeout,
  }) async {
    final params = <String, dynamic>{};
    params['state'] = state;
    params['timeout'] = timeout;
    final response = await connection.sendMessageToServer(
      guid,
      'waitForElementState',
      params,
    );
    return;
  }

  Future<Map<String, dynamic>> channel_waitForSelector({
    required String selector,
    bool? strict,
    required double timeout,
    String? state,
  }) async {
    final params = <String, dynamic>{};
    params['selector'] = selector;
    if (strict != null) params['strict'] = strict;
    params['timeout'] = timeout;
    if (state != null) params['state'] = state;
    final response = await connection.sendMessageToServer(
      guid,
      'waitForSelector',
      params,
    );
    return response;
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

  Future<void> channel_zip({
    required String zipFile,
    required List<NameValue> entries,
    String? stacksId,
    required String mode,
    required bool includeSources,
    List<String>? additionalSources,
  }) async {
    final params = <String, dynamic>{};
    params['zipFile'] = zipFile;
    params['entries'] = entries;
    if (stacksId != null) params['stacksId'] = stacksId;
    params['mode'] = mode;
    params['includeSources'] = includeSources;
    if (additionalSources != null) {
      params['additionalSources'] = additionalSources;
    }
    final response = await connection.sendMessageToServer(guid, 'zip', params);
    return;
  }

  Future<Map<String, dynamic>> channel_harOpen({required String file}) async {
    final params = <String, dynamic>{};
    params['file'] = file;
    final response = await connection.sendMessageToServer(
      guid,
      'harOpen',
      params,
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_harLookup({
    required String harId,
    required String url,
    required String method,
    required List<NameValue> headers,
    String? postData,
    required bool isNavigationRequest,
  }) async {
    final params = <String, dynamic>{};
    params['harId'] = harId;
    params['url'] = url;
    params['method'] = method;
    params['headers'] = headers;
    if (postData != null) params['postData'] = postData;
    params['isNavigationRequest'] = isNavigationRequest;
    final response = await connection.sendMessageToServer(
      guid,
      'harLookup',
      params,
    );
    return response;
  }

  Future<void> channel_harClose({required String harId}) async {
    final params = <String, dynamic>{};
    params['harId'] = harId;
    final response = await connection.sendMessageToServer(
      guid,
      'harClose',
      params,
    );
    return;
  }

  Future<void> channel_harUnzip({
    required String zipFile,
    required String harFile,
    String? resourcesDir,
  }) async {
    final params = <String, dynamic>{};
    params['zipFile'] = zipFile;
    params['harFile'] = harFile;
    if (resourcesDir != null) params['resourcesDir'] = resourcesDir;
    final response = await connection.sendMessageToServer(
      guid,
      'harUnzip',
      params,
    );
    return;
  }

  Future<Map<String, dynamic>> channel_connect({
    required String endpoint,
    Map<String, dynamic>? headers,
    String? exposeNetwork,
    double? slowMo,
    required double timeout,
    int? socksProxyRedirectPortForTest,
  }) async {
    final params = <String, dynamic>{};
    params['endpoint'] = endpoint;
    if (headers != null) {
      params['headers'] = ((v) => v is Enum
          ? (v as dynamic).value
          : (v is Map ? v : (v as dynamic).toJson()))(headers);
    }
    if (exposeNetwork != null) params['exposeNetwork'] = exposeNetwork;
    if (slowMo != null) params['slowMo'] = slowMo;
    params['timeout'] = timeout;
    if (socksProxyRedirectPortForTest != null) {
      params['socksProxyRedirectPortForTest'] = socksProxyRedirectPortForTest;
    }
    final response = await connection.sendMessageToServer(
      guid,
      'connect',
      params,
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_tracingStarted({
    String? tracesDir,
    required String traceName,
    bool? live,
  }) async {
    final params = <String, dynamic>{};
    if (tracesDir != null) params['tracesDir'] = tracesDir;
    params['traceName'] = traceName;
    if (live != null) params['live'] = live;
    final response = await connection.sendMessageToServer(
      guid,
      'tracingStarted',
      params,
    );
    return response;
  }

  Future<void> channel_addStackToTracingNoReply({
    required ClientSideCallMetadata callData,
  }) async {
    final params = <String, dynamic>{};
    params['callData'] = ((v) => v is Enum
        ? (v as dynamic).value
        : (v is Map ? v : (v as dynamic).toJson()))(callData);
    final response = await connection.sendMessageToServer(
      guid,
      'addStackToTracingNoReply',
      params,
    );
    return;
  }

  Future<void> channel_traceDiscarded({required String stacksId}) async {
    final params = <String, dynamic>{};
    params['stacksId'] = stacksId;
    final response = await connection.sendMessageToServer(
      guid,
      'traceDiscarded',
      params,
    );
    return;
  }

  Future<Map<String, dynamic>> channel_globToRegex({
    required String glob,
    String? baseURL,
    bool? webSocketUrl,
  }) async {
    final params = <String, dynamic>{};
    params['glob'] = glob;
    if (baseURL != null) params['baseURL'] = baseURL;
    if (webSocketUrl != null) params['webSocketUrl'] = webSocketUrl;
    final response = await connection.sendMessageToServer(
      guid,
      'globToRegex',
      params,
    );
    return response;
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

  Future<Map<String, dynamic>> channel_response() async {
    final response = await connection.sendMessageToServer(guid, 'response', {});
    return response;
  }

  Future<Map<String, dynamic>> channel_rawRequestHeaders() async {
    final response = await connection.sendMessageToServer(
      guid,
      'rawRequestHeaders',
      {},
    );
    return response;
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

  Future<void> channel_redirectNavigationRequest({required String url}) async {
    final params = <String, dynamic>{};
    params['url'] = url;
    final response = await connection.sendMessageToServer(
      guid,
      'redirectNavigationRequest',
      params,
    );
    return;
  }

  Future<void> channel_abort({String? errorCode}) async {
    final params = <String, dynamic>{};
    if (errorCode != null) params['errorCode'] = errorCode;
    final response = await connection.sendMessageToServer(
      guid,
      'abort',
      params,
    );
    return;
  }

  Future<void> channel_continueValue({
    String? url,
    String? method,
    List<NameValue>? headers,
    String? postData,
    required bool isFallback,
  }) async {
    final params = <String, dynamic>{};
    if (url != null) params['url'] = url;
    if (method != null) params['method'] = method;
    if (headers != null) params['headers'] = headers;
    if (postData != null) params['postData'] = postData;
    params['isFallback'] = isFallback;
    final response = await connection.sendMessageToServer(
      guid,
      'continue',
      params,
    );
    return;
  }

  Future<void> channel_fulfill({
    int? status,
    List<NameValue>? headers,
    String? body,
    bool? isBase64,
    String? fetchResponseUid,
  }) async {
    final params = <String, dynamic>{};
    if (status != null) params['status'] = status;
    if (headers != null) params['headers'] = headers;
    if (body != null) params['body'] = body;
    if (isBase64 != null) params['isBase64'] = isBase64;
    if (fetchResponseUid != null) params['fetchResponseUid'] = fetchResponseUid;
    final response = await connection.sendMessageToServer(
      guid,
      'fulfill',
      params,
    );
    return;
  }
}

abstract class WebSocketRouteBase extends ChannelOwner {
  WebSocketRouteBase(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

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
    required String message,
    required bool isBase64,
  }) async {
    final params = <String, dynamic>{};
    params['message'] = message;
    params['isBase64'] = isBase64;
    final response = await connection.sendMessageToServer(
      guid,
      'sendToPage',
      params,
    );
    return;
  }

  Future<void> channel_sendToServer({
    required String message,
    required bool isBase64,
  }) async {
    final params = <String, dynamic>{};
    params['message'] = message;
    params['isBase64'] = isBase64;
    final response = await connection.sendMessageToServer(
      guid,
      'sendToServer',
      params,
    );
    return;
  }

  Future<void> channel_closePage({
    int? code,
    String? reason,
    required bool wasClean,
  }) async {
    final params = <String, dynamic>{};
    if (code != null) params['code'] = code;
    if (reason != null) params['reason'] = reason;
    params['wasClean'] = wasClean;
    final response = await connection.sendMessageToServer(
      guid,
      'closePage',
      params,
    );
    return;
  }

  Future<void> channel_closeServer({
    int? code,
    String? reason,
    required bool wasClean,
  }) async {
    final params = <String, dynamic>{};
    if (code != null) params['code'] = code;
    if (reason != null) params['reason'] = reason;
    params['wasClean'] = wasClean;
    final response = await connection.sendMessageToServer(
      guid,
      'closeServer',
      params,
    );
    return;
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

  Future<Map<String, dynamic>> channel_body() async {
    final response = await connection.sendMessageToServer(guid, 'body', {});
    return response;
  }

  Future<Map<String, dynamic>> channel_securityDetails() async {
    final response = await connection.sendMessageToServer(
      guid,
      'securityDetails',
      {},
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_serverAddr() async {
    final response = await connection.sendMessageToServer(
      guid,
      'serverAddr',
      {},
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_rawResponseHeaders() async {
    final response = await connection.sendMessageToServer(
      guid,
      'rawResponseHeaders',
      {},
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_httpVersion() async {
    final response = await connection.sendMessageToServer(
      guid,
      'httpVersion',
      {},
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_sizes() async {
    final response = await connection.sendMessageToServer(guid, 'sizes', {});
    return response;
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

abstract class PageBase extends EventTargetBase {
  PageBase(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  Future<Map<String, dynamic>> channel_addInitScript({
    required String source,
  }) async {
    final params = <String, dynamic>{};
    params['source'] = source;
    final response = await connection.sendMessageToServer(
      guid,
      'addInitScript',
      params,
    );
    return response;
  }

  Future<void> channel_close({bool? runBeforeUnload, String? reason}) async {
    final params = <String, dynamic>{};
    if (runBeforeUnload != null) params['runBeforeUnload'] = runBeforeUnload;
    if (reason != null) params['reason'] = reason;
    final response = await connection.sendMessageToServer(
      guid,
      'close',
      params,
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

  Future<Map<String, dynamic>> channel_consoleMessages({
    ConsoleMessagesFilter? filter,
  }) async {
    final params = <String, dynamic>{};
    if (filter != null) {
      params['filter'] = ((v) => v is Enum
          ? (v as dynamic).value
          : (v is Map ? v : (v as dynamic).toJson()))(filter);
    }
    final response = await connection.sendMessageToServer(
      guid,
      'consoleMessages',
      params,
    );
    return response;
  }

  Future<void> channel_emulateMedia({
    String? media,
    String? colorScheme,
    String? reducedMotion,
    String? forcedColors,
    String? contrast,
  }) async {
    final params = <String, dynamic>{};
    if (media != null) params['media'] = media;
    if (colorScheme != null) params['colorScheme'] = colorScheme;
    if (reducedMotion != null) params['reducedMotion'] = reducedMotion;
    if (forcedColors != null) params['forcedColors'] = forcedColors;
    if (contrast != null) params['contrast'] = contrast;
    final response = await connection.sendMessageToServer(
      guid,
      'emulateMedia',
      params,
    );
    return;
  }

  Future<Map<String, dynamic>> channel_exposeBinding({
    required String name,
  }) async {
    final params = <String, dynamic>{};
    params['name'] = name;
    final response = await connection.sendMessageToServer(
      guid,
      'exposeBinding',
      params,
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_goBack({
    required double timeout,
    LifecycleEvent? waitUntil,
  }) async {
    final params = <String, dynamic>{};
    params['timeout'] = timeout;
    if (waitUntil != null) {
      params['waitUntil'] = ((v) => v is Enum
          ? (v as dynamic).value
          : (v is Map ? v : (v as dynamic).toJson()))(waitUntil);
    }
    final response = await connection.sendMessageToServer(
      guid,
      'goBack',
      params,
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_goForward({
    required double timeout,
    LifecycleEvent? waitUntil,
  }) async {
    final params = <String, dynamic>{};
    params['timeout'] = timeout;
    if (waitUntil != null) {
      params['waitUntil'] = ((v) => v is Enum
          ? (v as dynamic).value
          : (v is Map ? v : (v as dynamic).toJson()))(waitUntil);
    }
    final response = await connection.sendMessageToServer(
      guid,
      'goForward',
      params,
    );
    return response;
  }

  Future<void> channel_requestGC() async {
    final response = await connection.sendMessageToServer(
      guid,
      'requestGC',
      {},
    );
    return;
  }

  Future<Map<String, dynamic>> channel_registerLocatorHandler({
    required String selector,
    bool? noWaitAfter,
  }) async {
    final params = <String, dynamic>{};
    params['selector'] = selector;
    if (noWaitAfter != null) params['noWaitAfter'] = noWaitAfter;
    final response = await connection.sendMessageToServer(
      guid,
      'registerLocatorHandler',
      params,
    );
    return response;
  }

  Future<void> channel_resolveLocatorHandlerNoReply({
    required int uid,
    bool? remove,
  }) async {
    final params = <String, dynamic>{};
    params['uid'] = uid;
    if (remove != null) params['remove'] = remove;
    final response = await connection.sendMessageToServer(
      guid,
      'resolveLocatorHandlerNoReply',
      params,
    );
    return;
  }

  Future<void> channel_unregisterLocatorHandler({required int uid}) async {
    final params = <String, dynamic>{};
    params['uid'] = uid;
    final response = await connection.sendMessageToServer(
      guid,
      'unregisterLocatorHandler',
      params,
    );
    return;
  }

  Future<Map<String, dynamic>> channel_reload({
    required double timeout,
    LifecycleEvent? waitUntil,
  }) async {
    final params = <String, dynamic>{};
    params['timeout'] = timeout;
    if (waitUntil != null) {
      params['waitUntil'] = ((v) => v is Enum
          ? (v as dynamic).value
          : (v is Map ? v : (v as dynamic).toJson()))(waitUntil);
    }
    final response = await connection.sendMessageToServer(
      guid,
      'reload',
      params,
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_expectScreenshot({
    String? expected,
    required double timeout,
    required bool isNot,
    Map<String, dynamic>? locator,
    String? comparator,
    int? maxDiffPixels,
    double? maxDiffPixelRatio,
    double? threshold,
    bool? fullPage,
    Rect? clip,
    required CommonScreenshotOptions mixin,
  }) async {
    final params = <String, dynamic>{};
    if (expected != null) params['expected'] = expected;
    params['timeout'] = timeout;
    params['isNot'] = isNot;
    if (locator != null) {
      params['locator'] = ((v) => v is Enum
          ? (v as dynamic).value
          : (v is Map ? v : (v as dynamic).toJson()))(locator);
    }
    if (comparator != null) params['comparator'] = comparator;
    if (maxDiffPixels != null) params['maxDiffPixels'] = maxDiffPixels;
    if (maxDiffPixelRatio != null) {
      params['maxDiffPixelRatio'] = maxDiffPixelRatio;
    }
    if (threshold != null) params['threshold'] = threshold;
    if (fullPage != null) params['fullPage'] = fullPage;
    if (clip != null) {
      params['clip'] = ((v) => v is Enum
          ? (v as dynamic).value
          : (v is Map ? v : (v as dynamic).toJson()))(clip);
    }
    params.addAll(
      ((v) => v is Enum
              ? (v as dynamic).value
              : (v is Map ? v : (v as dynamic).toJson()))(mixin)
          as Map<String, dynamic>,
    );
    final response = await connection.sendMessageToServer(
      guid,
      'expectScreenshot',
      params,
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_screenshot({
    required double timeout,
    String? type,
    int? quality,
    bool? fullPage,
    Rect? clip,
    required CommonScreenshotOptions mixin,
  }) async {
    final params = <String, dynamic>{};
    params['timeout'] = timeout;
    if (type != null) params['type'] = type;
    if (quality != null) params['quality'] = quality;
    if (fullPage != null) params['fullPage'] = fullPage;
    if (clip != null) {
      params['clip'] = ((v) => v is Enum
          ? (v as dynamic).value
          : (v is Map ? v : (v as dynamic).toJson()))(clip);
    }
    params.addAll(
      ((v) => v is Enum
              ? (v as dynamic).value
              : (v is Map ? v : (v as dynamic).toJson()))(mixin)
          as Map<String, dynamic>,
    );
    final response = await connection.sendMessageToServer(
      guid,
      'screenshot',
      params,
    );
    return response;
  }

  Future<void> channel_setExtraHTTPHeaders({
    required List<NameValue> headers,
  }) async {
    final params = <String, dynamic>{};
    params['headers'] = headers;
    final response = await connection.sendMessageToServer(
      guid,
      'setExtraHTTPHeaders',
      params,
    );
    return;
  }

  Future<void> channel_setNetworkInterceptionPatterns({
    required List<Map<String, dynamic>> patterns,
  }) async {
    final params = <String, dynamic>{};
    params['patterns'] = patterns;
    final response = await connection.sendMessageToServer(
      guid,
      'setNetworkInterceptionPatterns',
      params,
    );
    return;
  }

  Future<void> channel_setWebSocketInterceptionPatterns({
    required List<Map<String, dynamic>> patterns,
  }) async {
    final params = <String, dynamic>{};
    params['patterns'] = patterns;
    final response = await connection.sendMessageToServer(
      guid,
      'setWebSocketInterceptionPatterns',
      params,
    );
    return;
  }

  Future<void> channel_setViewportSize({
    required Map<String, dynamic> viewportSize,
  }) async {
    final params = <String, dynamic>{};
    params['viewportSize'] = ((v) => v is Enum
        ? (v as dynamic).value
        : (v is Map ? v : (v as dynamic).toJson()))(viewportSize);
    final response = await connection.sendMessageToServer(
      guid,
      'setViewportSize',
      params,
    );
    return;
  }

  Future<void> channel_keyboardDown({required String key}) async {
    final params = <String, dynamic>{};
    params['key'] = key;
    final response = await connection.sendMessageToServer(
      guid,
      'keyboardDown',
      params,
    );
    return;
  }

  Future<void> channel_keyboardUp({required String key}) async {
    final params = <String, dynamic>{};
    params['key'] = key;
    final response = await connection.sendMessageToServer(
      guid,
      'keyboardUp',
      params,
    );
    return;
  }

  Future<void> channel_keyboardInsertText({required String text}) async {
    final params = <String, dynamic>{};
    params['text'] = text;
    final response = await connection.sendMessageToServer(
      guid,
      'keyboardInsertText',
      params,
    );
    return;
  }

  Future<void> channel_keyboardType({
    required String text,
    double? delay,
  }) async {
    final params = <String, dynamic>{};
    params['text'] = text;
    if (delay != null) params['delay'] = delay;
    final response = await connection.sendMessageToServer(
      guid,
      'keyboardType',
      params,
    );
    return;
  }

  Future<void> channel_keyboardPress({
    required String key,
    double? delay,
  }) async {
    final params = <String, dynamic>{};
    params['key'] = key;
    if (delay != null) params['delay'] = delay;
    final response = await connection.sendMessageToServer(
      guid,
      'keyboardPress',
      params,
    );
    return;
  }

  Future<void> channel_mouseMove({
    required double x,
    required double y,
    int? steps,
  }) async {
    final params = <String, dynamic>{};
    params['x'] = x;
    params['y'] = y;
    if (steps != null) params['steps'] = steps;
    final response = await connection.sendMessageToServer(
      guid,
      'mouseMove',
      params,
    );
    return;
  }

  Future<void> channel_mouseDown({String? button, int? clickCount}) async {
    final params = <String, dynamic>{};
    if (button != null) params['button'] = button;
    if (clickCount != null) params['clickCount'] = clickCount;
    final response = await connection.sendMessageToServer(
      guid,
      'mouseDown',
      params,
    );
    return;
  }

  Future<void> channel_mouseUp({String? button, int? clickCount}) async {
    final params = <String, dynamic>{};
    if (button != null) params['button'] = button;
    if (clickCount != null) params['clickCount'] = clickCount;
    final response = await connection.sendMessageToServer(
      guid,
      'mouseUp',
      params,
    );
    return;
  }

  Future<void> channel_mouseClick({
    required double x,
    required double y,
    double? delay,
    String? button,
    int? clickCount,
  }) async {
    final params = <String, dynamic>{};
    params['x'] = x;
    params['y'] = y;
    if (delay != null) params['delay'] = delay;
    if (button != null) params['button'] = button;
    if (clickCount != null) params['clickCount'] = clickCount;
    final response = await connection.sendMessageToServer(
      guid,
      'mouseClick',
      params,
    );
    return;
  }

  Future<void> channel_mouseWheel({
    required double deltaX,
    required double deltaY,
  }) async {
    final params = <String, dynamic>{};
    params['deltaX'] = deltaX;
    params['deltaY'] = deltaY;
    final response = await connection.sendMessageToServer(
      guid,
      'mouseWheel',
      params,
    );
    return;
  }

  Future<void> channel_touchscreenTap({
    required double x,
    required double y,
  }) async {
    final params = <String, dynamic>{};
    params['x'] = x;
    params['y'] = y;
    final response = await connection.sendMessageToServer(
      guid,
      'touchscreenTap',
      params,
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

  Future<Map<String, dynamic>> channel_pageErrors({
    ConsoleMessagesFilter? filter,
  }) async {
    final params = <String, dynamic>{};
    if (filter != null) {
      params['filter'] = ((v) => v is Enum
          ? (v as dynamic).value
          : (v is Map ? v : (v as dynamic).toJson()))(filter);
    }
    final response = await connection.sendMessageToServer(
      guid,
      'pageErrors',
      params,
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_pdf({
    double? scale,
    bool? displayHeaderFooter,
    String? headerTemplate,
    String? footerTemplate,
    bool? printBackground,
    bool? landscape,
    String? pageRanges,
    String? format,
    String? width,
    String? height,
    bool? preferCSSPageSize,
    Map<String, dynamic>? margin,
    bool? tagged,
    bool? outline,
  }) async {
    final params = <String, dynamic>{};
    if (scale != null) params['scale'] = scale;
    if (displayHeaderFooter != null) {
      params['displayHeaderFooter'] = displayHeaderFooter;
    }
    if (headerTemplate != null) params['headerTemplate'] = headerTemplate;
    if (footerTemplate != null) params['footerTemplate'] = footerTemplate;
    if (printBackground != null) params['printBackground'] = printBackground;
    if (landscape != null) params['landscape'] = landscape;
    if (pageRanges != null) params['pageRanges'] = pageRanges;
    if (format != null) params['format'] = format;
    if (width != null) params['width'] = width;
    if (height != null) params['height'] = height;
    if (preferCSSPageSize != null) {
      params['preferCSSPageSize'] = preferCSSPageSize;
    }
    if (margin != null) {
      params['margin'] = ((v) => v is Enum
          ? (v as dynamic).value
          : (v is Map ? v : (v as dynamic).toJson()))(margin);
    }
    if (tagged != null) params['tagged'] = tagged;
    if (outline != null) params['outline'] = outline;
    final response = await connection.sendMessageToServer(guid, 'pdf', params);
    return response;
  }

  Future<Map<String, dynamic>> channel_requests() async {
    final response = await connection.sendMessageToServer(guid, 'requests', {});
    return response;
  }

  Future<void> channel_startJSCoverage({
    bool? resetOnNavigation,
    bool? reportAnonymousScripts,
  }) async {
    final params = <String, dynamic>{};
    if (resetOnNavigation != null) {
      params['resetOnNavigation'] = resetOnNavigation;
    }
    if (reportAnonymousScripts != null) {
      params['reportAnonymousScripts'] = reportAnonymousScripts;
    }
    final response = await connection.sendMessageToServer(
      guid,
      'startJSCoverage',
      params,
    );
    return;
  }

  Future<Map<String, dynamic>> channel_stopJSCoverage() async {
    final response = await connection.sendMessageToServer(
      guid,
      'stopJSCoverage',
      {},
    );
    return response;
  }

  Future<void> channel_startCSSCoverage({bool? resetOnNavigation}) async {
    final params = <String, dynamic>{};
    if (resetOnNavigation != null) {
      params['resetOnNavigation'] = resetOnNavigation;
    }
    final response = await connection.sendMessageToServer(
      guid,
      'startCSSCoverage',
      params,
    );
    return;
  }

  Future<Map<String, dynamic>> channel_stopCSSCoverage() async {
    final response = await connection.sendMessageToServer(
      guid,
      'stopCSSCoverage',
      {},
    );
    return response;
  }

  Future<void> channel_bringToFront() async {
    final response = await connection.sendMessageToServer(
      guid,
      'bringToFront',
      {},
    );
    return;
  }

  Future<Map<String, dynamic>> channel_pickLocator() async {
    final response = await connection.sendMessageToServer(
      guid,
      'pickLocator',
      {},
    );
    return response;
  }

  Future<void> channel_cancelPickLocator() async {
    final response = await connection.sendMessageToServer(
      guid,
      'cancelPickLocator',
      {},
    );
    return;
  }

  Future<void> channel_hideHighlight() async {
    final response = await connection.sendMessageToServer(
      guid,
      'hideHighlight',
      {},
    );
    return;
  }

  Future<Map<String, dynamic>> channel_screencastShowOverlay({
    required String html,
    double? duration,
  }) async {
    final params = <String, dynamic>{};
    params['html'] = html;
    if (duration != null) params['duration'] = duration;
    final response = await connection.sendMessageToServer(
      guid,
      'screencastShowOverlay',
      params,
    );
    return response;
  }

  Future<void> channel_screencastRemoveOverlay({required String id}) async {
    final params = <String, dynamic>{};
    params['id'] = id;
    final response = await connection.sendMessageToServer(
      guid,
      'screencastRemoveOverlay',
      params,
    );
    return;
  }

  Future<void> channel_screencastChapter({
    required String title,
    String? description,
    double? duration,
  }) async {
    final params = <String, dynamic>{};
    params['title'] = title;
    if (description != null) params['description'] = description;
    if (duration != null) params['duration'] = duration;
    final response = await connection.sendMessageToServer(
      guid,
      'screencastChapter',
      params,
    );
    return;
  }

  Future<void> channel_screencastSetOverlayVisible({
    required bool visible,
  }) async {
    final params = <String, dynamic>{};
    params['visible'] = visible;
    final response = await connection.sendMessageToServer(
      guid,
      'screencastSetOverlayVisible',
      params,
    );
    return;
  }

  Future<void> channel_screencastShowActions({
    required ShowActionsOptions mixin,
  }) async {
    final params = <String, dynamic>{};
    params.addAll(
      ((v) => v is Enum
              ? (v as dynamic).value
              : (v is Map ? v : (v as dynamic).toJson()))(mixin)
          as Map<String, dynamic>,
    );
    final response = await connection.sendMessageToServer(
      guid,
      'screencastShowActions',
      params,
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

  Future<Map<String, dynamic>> channel_screencastStart({
    Map<String, dynamic>? size,
    int? quality,
    bool? sendFrames,
    bool? record,
  }) async {
    final params = <String, dynamic>{};
    if (size != null) {
      params['size'] = ((v) => v is Enum
          ? (v as dynamic).value
          : (v is Map ? v : (v as dynamic).toJson()))(size);
    }
    if (quality != null) params['quality'] = quality;
    if (sendFrames != null) params['sendFrames'] = sendFrames;
    if (record != null) params['record'] = record;
    final response = await connection.sendMessageToServer(
      guid,
      'screencastStart',
      params,
    );
    return response;
  }

  Future<void> channel_screencastStop() async {
    final response = await connection.sendMessageToServer(
      guid,
      'screencastStop',
      {},
    );
    return;
  }

  Future<void> channel_updateSubscription({
    required String event,
    required bool enabled,
  }) async {
    final params = <String, dynamic>{};
    params['event'] = event;
    params['enabled'] = enabled;
    final response = await connection.sendMessageToServer(
      guid,
      'updateSubscription',
      params,
    );
    return;
  }

  Future<void> channel_setDockTile({required String image}) async {
    final params = <String, dynamic>{};
    params['image'] = image;
    final response = await connection.sendMessageToServer(
      guid,
      'setDockTile',
      params,
    );
    return;
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

  Future<Map<String, dynamic>> channel_initialize({
    required SDKLanguage sdkLanguage,
  }) async {
    final params = <String, dynamic>{};
    params['sdkLanguage'] = ((v) => v is Enum
        ? (v as dynamic).value
        : (v is Map ? v : (v as dynamic).toJson()))(sdkLanguage);
    final response = await connection.sendMessageToServer(
      guid,
      'initialize',
      params,
    );
    return response;
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

  Future<Map<String, dynamic>> channel_newRequest({
    String? baseURL,
    String? userAgent,
    bool? ignoreHTTPSErrors,
    List<NameValue>? extraHTTPHeaders,
    bool? failOnStatusCode,
    List<Map<String, dynamic>>? clientCertificates,
    int? maxRedirects,
    Map<String, dynamic>? httpCredentials,
    Map<String, dynamic>? proxy,
    Map<String, dynamic>? storageState,
    String? tracesDir,
  }) async {
    final params = <String, dynamic>{};
    if (baseURL != null) params['baseURL'] = baseURL;
    if (userAgent != null) params['userAgent'] = userAgent;
    if (ignoreHTTPSErrors != null) {
      params['ignoreHTTPSErrors'] = ignoreHTTPSErrors;
    }
    if (extraHTTPHeaders != null) params['extraHTTPHeaders'] = extraHTTPHeaders;
    if (failOnStatusCode != null) params['failOnStatusCode'] = failOnStatusCode;
    if (clientCertificates != null) {
      params['clientCertificates'] = clientCertificates;
    }
    if (maxRedirects != null) params['maxRedirects'] = maxRedirects;
    if (httpCredentials != null) {
      params['httpCredentials'] = ((v) => v is Enum
          ? (v as dynamic).value
          : (v is Map ? v : (v as dynamic).toJson()))(httpCredentials);
    }
    if (proxy != null) {
      params['proxy'] = ((v) => v is Enum
          ? (v as dynamic).value
          : (v is Map ? v : (v as dynamic).toJson()))(proxy);
    }
    if (storageState != null) {
      params['storageState'] = ((v) => v is Enum
          ? (v as dynamic).value
          : (v is Map ? v : (v as dynamic).toJson()))(storageState);
    }
    if (tracesDir != null) params['tracesDir'] = tracesDir;
    final response = await connection.sendMessageToServer(
      guid,
      'newRequest',
      params,
    );
    return response;
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

  Future<void> channel_initialize({
    required String codegenId,
    required SDKLanguage sdkLanguage,
  }) async {
    final params = <String, dynamic>{};
    params['codegenId'] = codegenId;
    params['sdkLanguage'] = ((v) => v is Enum
        ? (v as dynamic).value
        : (v is Map ? v : (v as dynamic).toJson()))(sdkLanguage);
    final response = await connection.sendMessageToServer(
      guid,
      'initialize',
      params,
    );
    return;
  }

  Future<void> channel_setReportStateChanged({required bool enabled}) async {
    final params = <String, dynamic>{};
    params['enabled'] = enabled;
    final response = await connection.sendMessageToServer(
      guid,
      'setReportStateChanged',
      params,
    );
    return;
  }

  Future<void> channel_setRecorderMode({
    required String mode,
    String? testIdAttributeName,
    bool? generateAutoExpect,
  }) async {
    final params = <String, dynamic>{};
    params['mode'] = mode;
    if (testIdAttributeName != null) {
      params['testIdAttributeName'] = testIdAttributeName;
    }
    if (generateAutoExpect != null) {
      params['generateAutoExpect'] = generateAutoExpect;
    }
    final response = await connection.sendMessageToServer(
      guid,
      'setRecorderMode',
      params,
    );
    return;
  }

  Future<void> channel_highlight({
    String? selector,
    String? ariaTemplate,
  }) async {
    final params = <String, dynamic>{};
    if (selector != null) params['selector'] = selector;
    if (ariaTemplate != null) params['ariaTemplate'] = ariaTemplate;
    final response = await connection.sendMessageToServer(
      guid,
      'highlight',
      params,
    );
    return;
  }

  Future<void> channel_hideHighlight() async {
    final response = await connection.sendMessageToServer(
      guid,
      'hideHighlight',
      {},
    );
    return;
  }

  Future<void> channel_resume() async {
    final response = await connection.sendMessageToServer(guid, 'resume', {});
    return;
  }

  Future<void> channel_kill() async {
    final response = await connection.sendMessageToServer(guid, 'kill', {});
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
    required String uid,
    required String host,
    required int port,
  }) async {
    final params = <String, dynamic>{};
    params['uid'] = uid;
    params['host'] = host;
    params['port'] = port;
    final response = await connection.sendMessageToServer(
      guid,
      'socksConnected',
      params,
    );
    return;
  }

  Future<void> channel_socksFailed({
    required String uid,
    required String errorCode,
  }) async {
    final params = <String, dynamic>{};
    params['uid'] = uid;
    params['errorCode'] = errorCode;
    final response = await connection.sendMessageToServer(
      guid,
      'socksFailed',
      params,
    );
    return;
  }

  Future<void> channel_socksData({
    required String uid,
    required String data,
  }) async {
    final params = <String, dynamic>{};
    params['uid'] = uid;
    params['data'] = data;
    final response = await connection.sendMessageToServer(
      guid,
      'socksData',
      params,
    );
    return;
  }

  Future<void> channel_socksError({
    required String uid,
    required String error,
  }) async {
    final params = <String, dynamic>{};
    params['uid'] = uid;
    params['error'] = error;
    final response = await connection.sendMessageToServer(
      guid,
      'socksError',
      params,
    );
    return;
  }

  Future<void> channel_socksEnd({required String uid}) async {
    final params = <String, dynamic>{};
    params['uid'] = uid;
    final response = await connection.sendMessageToServer(
      guid,
      'socksEnd',
      params,
    );
    return;
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

  Future<void> channel_send({required Map<String, dynamic> message}) async {
    final params = <String, dynamic>{};
    params['message'] = ((v) => v is Enum
        ? (v as dynamic).value
        : (v is Map ? v : (v as dynamic).toJson()))(message);
    final response = await connection.sendMessageToServer(guid, 'send', params);
    return;
  }

  Future<void> channel_close() async {
    final response = await connection.sendMessageToServer(guid, 'close', {});
    return;
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

  Future<Map<String, dynamic>> channel_send({
    required String method,
    Map<String, dynamic>? params,
  }) async {
    final params = <String, dynamic>{};
    params['method'] = method;
    if (params != null) {
      params['params'] = ((v) => v is Enum
          ? (v as dynamic).value
          : (v is Map ? v : (v as dynamic).toJson()))(params);
    }
    final response = await connection.sendMessageToServer(guid, 'send', params);
    return response;
  }

  Future<void> channel_detach() async {
    final response = await connection.sendMessageToServer(guid, 'detach', {});
    return;
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
    final params = <String, dynamic>{};
    params['error'] = ((v) => v is Enum
        ? (v as dynamic).value
        : (v is Map ? v : (v as dynamic).toJson()))(error);
    final response = await connection.sendMessageToServer(
      guid,
      'reject',
      params,
    );
    return;
  }

  Future<void> channel_resolve({required SerializedArgument result}) async {
    final params = <String, dynamic>{};
    params['result'] = ((v) => v is Enum
        ? (v as dynamic).value
        : (v is Map ? v : (v as dynamic).toJson()))(result);
    final response = await connection.sendMessageToServer(
      guid,
      'resolve',
      params,
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

  Future<void> channel_next() async {
    final response = await connection.sendMessageToServer(guid, 'next', {});
    return;
  }

  Future<void> channel_runTo({required Map<String, dynamic> location}) async {
    final params = <String, dynamic>{};
    params['location'] = ((v) => v is Enum
        ? (v as dynamic).value
        : (v is Map ? v : (v as dynamic).toJson()))(location);
    final response = await connection.sendMessageToServer(
      guid,
      'runTo',
      params,
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
    final params = <String, dynamic>{};
    if (promptText != null) params['promptText'] = promptText;
    final response = await connection.sendMessageToServer(
      guid,
      'accept',
      params,
    );
    return;
  }

  Future<void> channel_dismiss() async {
    final response = await connection.sendMessageToServer(guid, 'dismiss', {});
    return;
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

  Future<void> channel_tracingStart({
    String? name,
    bool? snapshots,
    bool? screenshots,
    bool? live,
  }) async {
    final params = <String, dynamic>{};
    if (name != null) params['name'] = name;
    if (snapshots != null) params['snapshots'] = snapshots;
    if (screenshots != null) params['screenshots'] = screenshots;
    if (live != null) params['live'] = live;
    final response = await connection.sendMessageToServer(
      guid,
      'tracingStart',
      params,
    );
    return;
  }

  Future<Map<String, dynamic>> channel_tracingStartChunk({
    String? name,
    String? title,
  }) async {
    final params = <String, dynamic>{};
    if (name != null) params['name'] = name;
    if (title != null) params['title'] = title;
    final response = await connection.sendMessageToServer(
      guid,
      'tracingStartChunk',
      params,
    );
    return response;
  }

  Future<void> channel_tracingGroup({
    required String name,
    Map<String, dynamic>? location,
  }) async {
    final params = <String, dynamic>{};
    params['name'] = name;
    if (location != null) {
      params['location'] = ((v) => v is Enum
          ? (v as dynamic).value
          : (v is Map ? v : (v as dynamic).toJson()))(location);
    }
    final response = await connection.sendMessageToServer(
      guid,
      'tracingGroup',
      params,
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

  Future<Map<String, dynamic>> channel_tracingStopChunk({
    required String mode,
  }) async {
    final params = <String, dynamic>{};
    params['mode'] = mode;
    final response = await connection.sendMessageToServer(
      guid,
      'tracingStopChunk',
      params,
    );
    return response;
  }

  Future<void> channel_tracingStop() async {
    final response = await connection.sendMessageToServer(
      guid,
      'tracingStop',
      {},
    );
    return;
  }

  Future<Map<String, dynamic>> channel_harStart({
    PageBase? page,
    required RecordHarOptions options,
  }) async {
    final params = <String, dynamic>{};
    if (page != null) params['page'] = page.guid;
    params['options'] = ((v) => v is Enum
        ? (v as dynamic).value
        : (v is Map ? v : (v as dynamic).toJson()))(options);
    final response = await connection.sendMessageToServer(
      guid,
      'harStart',
      params,
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_harExport({
    String? harId,
    required String mode,
  }) async {
    final params = <String, dynamic>{};
    if (harId != null) params['harId'] = harId;
    params['mode'] = mode;
    final response = await connection.sendMessageToServer(
      guid,
      'harExport',
      params,
    );
    return response;
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
    final params = <String, dynamic>{};
    if (reason != null) params['reason'] = reason;
    final response = await connection.sendMessageToServer(
      guid,
      'disconnect',
      params,
    );
    return;
  }

  Future<Map<String, dynamic>> channel_evaluateExpression({
    required String expression,
    bool? isFunction,
    required SerializedArgument arg,
  }) async {
    final params = <String, dynamic>{};
    params['expression'] = expression;
    if (isFunction != null) params['isFunction'] = isFunction;
    params['arg'] = ((v) => v is Enum
        ? (v as dynamic).value
        : (v is Map ? v : (v as dynamic).toJson()))(arg);
    final response = await connection.sendMessageToServer(
      guid,
      'evaluateExpression',
      params,
    );
    return response;
  }

  Future<Map<String, dynamic>> channel_evaluateExpressionHandle({
    required String expression,
    bool? isFunction,
    required SerializedArgument arg,
  }) async {
    final params = <String, dynamic>{};
    params['expression'] = expression;
    if (isFunction != null) params['isFunction'] = isFunction;
    params['arg'] = ((v) => v is Enum
        ? (v as dynamic).value
        : (v is Map ? v : (v as dynamic).toJson()))(arg);
    final response = await connection.sendMessageToServer(
      guid,
      'evaluateExpressionHandle',
      params,
    );
    return response;
  }

  Future<void> channel_updateSubscription({
    required String event,
    required bool enabled,
  }) async {
    final params = <String, dynamic>{};
    params['event'] = event;
    params['enabled'] = enabled;
    final response = await connection.sendMessageToServer(
      guid,
      'updateSubscription',
      params,
    );
    return;
  }
}
