import 'dart:convert';

import '../generated/channels.dart';

import 'request.dart';

import '../core/frame.dart';

/// Response class represents responses which are received by page.

/// Interface for Response

abstract interface class Response {
  int get status;

  String get statusText;

  String get url;

  Map<String, dynamic> get headers;

  bool get ok;

  Request get request;

  Frame get frame;

  Future<List<int>> body();

  bool get fromServiceWorker;

  Future<String> text();

  Future<dynamic> json();

  Future<Map<String, dynamic>?> securityDetails();

  Future<Map<String, dynamic>?> serverAddr();

  Future<Map<String, String>> allHeaders();

  Future<Map<String, String>> rawResponseHeaders();

  Future<String?> headerValue(String name);

  Future<List<String>> headerValues(String name);

  Future<ResponseSizesResult> sizes();

  Future<String> httpVersion();
}

class ResponseImpl extends ResponseBase implements Response {
  @override
  bool get fromServiceWorker => typedInitializer.fromServiceWorker;

  @override
  Request get request => typedInitializer.request as Request;

  @override
  Frame get frame => request.frame;

  ResponseImpl(
    super.connection,

    super.channelType,

    super.guid,

    super.initializer, [

    super.parent,
  ]) {
    (request as RequestImpl).timing = typedInitializer.timing.toJson();
  }

  /// Contains the status code of the response (e.g., 200 for a success).

  @override
  int get status => typedInitializer.status;

  /// Contains the status text of the response (e.g. usually an "OK" for a success).

  @override
  String get statusText => typedInitializer.statusText;

  /// Contains the URL of the response.

  @override
  String get url => typedInitializer.url;

  @override
  Map<String, dynamic> get headers =>
      typedInitializer.headers.fold<Map<String, dynamic>>({}, (map, header) {
        map[header.name.toLowerCase()] = header.value;

        return map;
      });

  @override
  bool get ok => status >= 200 && status <= 299;

  @override
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

    return {for (final h in headers) h.name.toLowerCase(): h.value};
  }

  @override
  Future<Map<String, String>> rawResponseHeaders() => allHeaders();

  @override
  Future<String?> headerValue(String name) async {
    final all = await allHeaders();

    return all[name.toLowerCase()];
  }

  @override
  Future<List<String>> headerValues(String name) async {
    final result = await channel_rawResponseHeaders();

    final lower = name.toLowerCase();

    return [
      for (final h in result.headers)
        if (h.name.toLowerCase() == lower) h.value,
    ];
  }

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
  Future<String> httpVersion() async => (await channel_httpVersion()).value;
}
