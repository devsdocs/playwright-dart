import 'generated/channels.dart';
import 'request.dart';

class Route extends RouteBase {
  Route(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  Request get request =>
      connection.objects[initializer['request']['guid']] as Request;

  Future<void> abort({String? errorCode}) async {
    await channel_abort(errorCode: errorCode);
  }

  Future<void> fulfill({
    int? status,
    Map<String, String>? headers,
    String? body,
    bool? isBase64,
    String? fetchResponseUid,
  }) async {
    final mappedHeaders = headers?.entries
        .map((e) => NameValue(name: e.key, value: e.value))
        .toList();
    await channel_fulfill(
      status: status,
      headers: mappedHeaders,
      body: body,
      isBase64: isBase64,
      fetchResponseUid: fetchResponseUid,
    );
  }

  Future<void> continueRoute({
    String? url,
    String? method,
    Map<String, String>? headers,
    String? postData,
    bool isFallback = false,
  }) async {
    final mappedHeaders = headers?.entries
        .map((e) => NameValue(name: e.key, value: e.value))
        .toList();
    await channel_continueValue(
      url: url,
      method: method,
      headers: mappedHeaders,
      postData: postData,
      isFallback: isFallback,
    );
  }

  Future<void> redirectNavigationRequest(String url) async {
    await channel_redirectNavigationRequest(url: url);
  }

  Future<void> continueValue({
    String? url,
    String? method,
    Map<String, String>? headers,
    String? postData,
    bool isFallback = false,
  }) => continueRoute(
    url: url,
    method: method,
    headers: headers,
    postData: postData,
    isFallback: isFallback,
  );
}
