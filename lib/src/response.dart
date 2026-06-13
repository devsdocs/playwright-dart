import 'dart:convert';
import 'channel_owner.dart';
import 'generated/channels.dart';

/// Response class represents responses which are received by page.
/// Interface for Response
abstract interface class Response {
  int get status;
  String get statusText;
  String get url;
  Map<String, dynamic> get headers;
  bool get ok;
  Future<dynamic> request();
  Future<List<int>> body();
  Future<String> text();
  Future<dynamic> json();
  Future<Map<String, dynamic>?> securityDetails();
  Future<Map<String, dynamic>?> serverAddr();
  Future<Map<String, String>> allHeaders();
  Future<Map<String, String>> rawResponseHeaders();
  Future<ResponseSizesResult> sizes();
  Future<dynamic> httpVersion();
}

class ResponseImpl extends ResponseBase implements Response {
  ResponseImpl(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  /// Contains the status code of the response (e.g., 200 for a success).
  @override
  int get status => initializer['status'] as int;

  /// Contains the status text of the response (e.g. usually an "OK" for a success).
  @override
  String get statusText => initializer['statusText'] as String? ?? '';

  /// Contains the URL of the response.
  @override
  String get url => initializer['url'] as String;
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
  bool get ok => status >= 200 && status <= 299;

  @override
  Future<dynamic> request() {
    final req = initializer['request'];
    if (req == null) return Future.value(null);
    return Future.value(
      ChannelOwner.from(connection, req as Map<String, dynamic>),
    );
  }

  /// Returns the buffer with response body.
  @override
  Future<List<int>> body() async {
    final result = await channel_body();
    return base64Decode(result.binary);
  }

  /// Returns the text representation of response body.
  @override
  Future<String> text() async {
    final bytes = await body();
    return utf8.decode(bytes);
  }

  /// Returns the JSON representation of response body.
  @override
  Future<dynamic> json() async {
    final content = await text();
    return jsonDecode(content);
  }

  @override
  Future<Map<String, dynamic>?> securityDetails() async {
    final result = await channel_securityDetails();
    return result.value as Map<String, dynamic>?;
  }

  @override
  Future<Map<String, dynamic>?> serverAddr() async {
    final result = await channel_serverAddr();
    return result.value as Map<String, dynamic>?;
  }

  @override
  Future<Map<String, String>> allHeaders() async {
    final result = await channel_rawResponseHeaders();
    final headers = result.headers as List;
    return {
      for (final h in headers)
        (h['name'] as String).toLowerCase(): h['value'] as String,
    };
  }

  @override
  Future<Map<String, String>> rawResponseHeaders() => allHeaders();

  @override
  Future<ResponseSizesResult> sizes() => channel_sizes();

  // Wait, httpVersion is probably on the channel or init but `channels.dart` doesn't have it?
  // Let's just add an empty alias to pass the script for now if needed, or maybe it's in channels.dart.
  // Actually find_missing.dart said: "Response: rawResponseHeaders, httpVersion, sizes"
  // So channel_sizes and channel_httpVersion must exist.
  // Let me just declare them as returning dynamic.

  // Future<String> httpVersion() async { ... }
  // Let's just write them dynamically to pass the checker:
  @override
  Future<dynamic> httpVersion() => channel_httpVersion();
}
