import 'channel_owner.dart';
import 'generated/channels.dart';

class Request extends RequestBase {
  Request(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  String get url => initializer['url'] as String;
  String get resourceType => initializer['resourceType'] as String;
  String get method => initializer['method'] as String;
  String? get postData => initializer['postData'] as String?;
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
  bool get isNavigationRequest =>
      initializer['isNavigationRequest'] as bool? ?? false;

  Future<dynamic> response() async {
    final result = await channel_response();
    final resp = result['response'];
    if (resp == null) return null;
    return ChannelOwner.from(connection, resp as Map<String, dynamic>);
  }

  Future<Map<String, String>> allHeaders() async {
    final result = await channel_rawRequestHeaders();
    final headers = result['headers'] as List;
    return {
      for (final h in headers)
        (h['name'] as String).toLowerCase(): h['value'] as String,
    };
  }

  Future<Map<String, String>> rawRequestHeaders() => allHeaders();
}
