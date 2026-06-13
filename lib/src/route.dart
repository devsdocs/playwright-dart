import 'generated/channels.dart';

class Route extends RouteBase {
  Route(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  Future<void> abort({String? errorCode}) async {
    await channel_abort(errorCode: errorCode);
  }

  Future<void> fulfill({
    int? status,
    List<NameValue>? headers,
    String? body,
    bool? isBase64,
    String? fetchResponseUid,
  }) async {
    await channel_fulfill(
      status: status,
      headers: headers,
      body: body,
      isBase64: isBase64,
      fetchResponseUid: fetchResponseUid,
    );
  }

  Future<void> continueRoute({
    String? url,
    String? method,
    List<NameValue>? headers,
    String? postData,
    bool isFallback = false,
  }) async {
    await channel_continueValue(
      url: url,
      method: method,
      headers: headers,
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
    List<NameValue>? headers,
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
