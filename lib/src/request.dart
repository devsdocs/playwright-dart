import 'response.dart';
import 'dart:convert';
import 'channel_owner.dart';
import 'generated/channels.dart';
import 'frame.dart';

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
}

class RequestImpl extends RequestBase implements Request {
  Map<String, dynamic>? _timing;

  @override
  Map<String, dynamic> get timing {
    if (_timing != null) return _timing!;
    _timing = Map<String, dynamic>.from(
      initializer['timing'] ??
          {
            'startTime': 0,
            'domainLookupStart': -1,
            'domainLookupEnd': -1,
            'connectStart': -1,
            'secureConnectionStart': -1,
            'connectEnd': -1,
            'requestStart': -1,
            'responseStart': -1,
            'responseEnd': -1,
          },
    );
    return _timing!;
  }

  set timing(Map<String, dynamic> value) {
    _timing = value;
  }

  @override
  Request? get redirectedFrom {
    final ref = initializer['redirectedFrom'];
    if (ref == null) return null;
    return connection.objects[ref['guid']] as Request?;
  }

  @override
  Request? get redirectedTo {
    final ref = initializer['redirectedTo'];
    if (ref == null) return null;
    return connection.objects[ref['guid']] as Request?;
  }

  String? _failureText;

  @override
  String? get failure => _failureText ?? initializer['failureText'] as String?;

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
    final b64 = initializer['postData'] as String?;
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
  String get url => initializer['url'] as String;

  /// Frame that initiated this request.
  @override
  Frame get frame => connection.objects[initializer['frame']['guid']] as Frame;

  /// Resource type of the request.
  @override
  String get resourceType => initializer['resourceType'] as String;

  /// HTTP method of the request (e.g. GET, POST).
  @override
  String get method => initializer['method'] as String;

  /// Request's post body, if any.
  @override
  String? get postData {
    final b64 = initializer['postData'] as String?;
    if (b64 == null) return null;
    return utf8.decode(base64Decode(b64));
  }

  @override
  Map<String, dynamic> get headers =>
      (initializer['headers'] as List?)?.fold<Map<String, dynamic>>({}, (
        map,
        header,
      ) {
        map[(header['name'] as String).toLowerCase()] =
            header['value'] as String;
        return map;
      }) ??
      {};
  @override
  bool get isNavigationRequest =>
      initializer['isNavigationRequest'] as bool? ?? false;

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
}
