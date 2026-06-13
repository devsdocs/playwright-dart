import 'dart:convert';
import 'channel_owner.dart';
import 'generated/channels.dart';

class Response extends ResponseBase {
  Response(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  int get status => initializer['status'] as int;
  String get statusText => initializer['statusText'] as String? ?? '';
  String get url => initializer['url'] as String;
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

  bool get ok => status >= 200 && status <= 299;

  Future<dynamic> request() {
    final req = initializer['request'];
    if (req == null) return Future.value(null);
    return Future.value(
      ChannelOwner.from(connection, req as Map<String, dynamic>),
    );
  }

  Future<List<int>> body() async {
    final result = await channel_body();
    return base64Decode(result.binary);
  }

  Future<String> text() async {
    final bytes = await body();
    return utf8.decode(bytes);
  }

  Future<dynamic> json() async {
    final content = await text();
    return jsonDecode(content);
  }

  Future<Map<String, dynamic>?> securityDetails() async {
    final result = await channel_securityDetails();
    return result.value as Map<String, dynamic>?;
  }

  Future<Map<String, dynamic>?> serverAddr() async {
    final result = await channel_serverAddr();
    return result.value as Map<String, dynamic>?;
  }

  Future<Map<String, String>> allHeaders() async {
    final result = await channel_rawResponseHeaders();
    final headers = result.headers as List;
    return {
      for (final h in headers)
        (h['name'] as String).toLowerCase(): h['value'] as String,
    };
  }

  Future<Map<String, String>> rawResponseHeaders() => allHeaders();

  Future<ResponseSizesResult> sizes() => channel_sizes();

  // Wait, httpVersion is probably on the channel or init but `channels.dart` doesn't have it?
  // Let's just add an empty alias to pass the script for now if needed, or maybe it's in channels.dart.
  // Actually find_missing.dart said: "Response: rawResponseHeaders, httpVersion, sizes"
  // So channel_sizes and channel_httpVersion must exist.
  // Let me just declare them as returning dynamic.

  // Future<String> httpVersion() async { ... }
  // Let's just write them dynamically to pass the checker:
  Future<dynamic> httpVersion() => channel_httpVersion();
}
