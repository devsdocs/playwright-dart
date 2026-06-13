import 'response.dart';
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
  Future<Response?> response();
  Future<Map<String, String>> allHeaders();
  Future<Map<String, String>> rawRequestHeaders();
}

class RequestImpl extends RequestBase implements Request {
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
  String? get postData => initializer['postData'] as String?;
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
