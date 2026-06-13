import 'generated/channels.dart';
import 'request.dart';

/// Whenever a network route is set up with `page.route()` or `browserContext.route()`, the `Route` object allows to handle the route.
class Route extends RouteBase {
  Route(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  /// A request to be routed.
  Request get request =>
      connection.objects[initializer['request']['guid']] as Request;

  /// Aborts the route's request.
  Future<void> abort({String? errorCode}) async {
    await channel_abort(errorCode: errorCode);
  }

  /// Fulfills route's request with given response.
  Future<void> fulfill({
    int? status,
    List<NameValue>? headers,
    String? body,
    bool? isBase64,
    String? contentType,
    String? fetchResponseUid,
  }) async {
    final mappedHeaders = headers ?? [];
    if (contentType != null) {
      mappedHeaders.add(NameValue(name: 'content-type', value: contentType));
    }
    await channel_fulfill(
      status: status,
      headers: mappedHeaders,
      body: body,
      isBase64: isBase64,
      fetchResponseUid: fetchResponseUid,
    );
  }

  /// Continues route's request with optional overrides.
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
