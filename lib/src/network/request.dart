import 'response.dart';

import 'dart:convert';

import '../infrastructure/channel_owner.dart';

import '../generated/channels.dart';

import '../core/frame.dart';

/// Whenever the page sends a request for a network resource the following sequence of events are emitted by Page:

/// - `page.on('request')` emitted when the request is issued by the page.

/// Interface for Request

abstract interface class Request {
  String get url;

  Frame get frame;

  String get resourceType;

  String get method;

  String? get postData;

  Map<String, dynamic> get headers;

  bool get isNavigationRequest;

  Map<String, dynamic> get timing;

  Request? get redirectedFrom;

  Request? get redirectedTo;

  String? get failure;

  dynamic get postDataJSON;

  List<int>? get postDataBuffer;

  Future<Response?> response();

  Future<Map<String, String>> allHeaders();

  Future<Map<String, String>> rawRequestHeaders();

  Future<String?> headerValue(String name);

  Future<List<String>> headerValues(String name);
}

class RequestImpl extends RequestBase implements Request {
  Map<String, dynamic>? _timing;

  @override
  Map<String, dynamic> get timing {
    if (_timing != null) return _timing!;

    _timing = {
      'startTime': 0,

      'domainLookupStart': -1,

      'domainLookupEnd': -1,

      'connectStart': -1,

      'secureConnectionStart': -1,

      'connectEnd': -1,

      'requestStart': -1,

      'responseStart': -1,

      'responseEnd': -1,
    };

    return _timing!;
  }

  set timing(Map<String, dynamic> value) {
    _timing = value;
  }

  @override
  Request? get redirectedFrom => typedInitializer.redirectedFrom as Request?;

  @override
  Request? get redirectedTo {
    // redirectedTo is not in the initializer, need to handle this differently
    return null;
  }

  String? _failureText;

  @override
  String? get failure => _failureText;

  set failureText(String? value) {
    _failureText = value;
  }

  @override
  dynamic get postDataJSON {
    final data = postData;

    if (data == null) return null;

    try {
      return jsonDecode(data);
    } catch (_) {
      return null;
    }
  }

  @override
  List<int>? get postDataBuffer {
    final b64 = typedInitializer.postData;

    if (b64 == null) return null;

    return base64Decode(b64);
  }

  RequestImpl(
    super.connection,

    super.channelType,

    super.guid,

    super.initializer, [

    super.parent,
  ]);

  /// URL of the request.

  @override
  String get url => typedInitializer.url;

  /// Frame that initiated this request.

  @override
  Frame get frame => typedInitializer.frame as Frame;

  /// Resource type of the request.

  @override
  String get resourceType => typedInitializer.resourceType;

  /// HTTP method of the request (e.g. GET, POST).

  @override
  String get method => typedInitializer.method;

  /// Request's post body, if any.

  @override
  String? get postData {
    final b64 = typedInitializer.postData;

    if (b64 == null) return null;

    return utf8.decode(base64Decode(b64));
  }

  @override
  Map<String, dynamic> get headers =>
      typedInitializer.headers.fold<Map<String, dynamic>>({}, (map, header) {
        map[header.name.toLowerCase()] = header.value;

        return map;
      });

  @override
  bool get isNavigationRequest => typedInitializer.isNavigationRequest;

  /// Returns the matching Response object, or null if the response was not received due to error.

  @override
  Future<Response?> response() async {
    final result = await channel_response();

    final resp = result.response;

    if (resp == null) return null;

    return ChannelOwner.from(connection, resp as Map<String, dynamic>);
  }

  @override
  Future<Map<String, String>> allHeaders() async {
    final result = await channel_rawRequestHeaders();

    final headers = result.headers as List;

    return {
      for (final h in headers)
        (h['name'] as String).toLowerCase(): h['value'] as String,
    };
  }

  @override
  Future<Map<String, String>> rawRequestHeaders() => allHeaders();

  @override
  Future<String?> headerValue(String name) async {
    final all = await allHeaders();

    return all[name.toLowerCase()];
  }

  @override
  Future<List<String>> headerValues(String name) async {
    final result = await channel_rawRequestHeaders();

    final lower = name.toLowerCase();

    return [
      for (final h in result.headers)
        if (h.name.toLowerCase() == lower) h.value,
    ];
  }
}
