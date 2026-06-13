import 'generated/channels.dart';

/// Interface for APIRequestContext
abstract interface class APIRequestContext {
  Future<APIResponse> fetch(
    String url, {
    String? method,
    List<NameValue>? headers,
    String? postData,
    String? jsonData,
    List<NameValue>? formData,
    List<FormField>? multipartData,
    double? timeout,
    bool? failOnStatusCode,
    bool? ignoreHTTPSErrors,
    int? maxRedirects,
    int? maxRetries,
    String? encodedParams,
    List<NameValue>? params,
  });
  Future<APIResponse> get(
    String url, {
    List<NameValue>? headers,
    double? timeout,
  });
  Future<APIResponse> post(
    String url, {
    List<NameValue>? headers,
    String? postData,
    String? jsonData,
    double? timeout,
  });
  Future<APIResponse> put(
    String url, {
    List<NameValue>? headers,
    String? postData,
    String? jsonData,
    double? timeout,
  });
  Future<APIResponse> delete(
    String url, {
    List<NameValue>? headers,
    double? timeout,
  });
  Future<APIResponse> patch(
    String url, {
    List<NameValue>? headers,
    String? postData,
    String? jsonData,
    double? timeout,
  });
  Future<APIResponse> head(
    String url, {
    List<NameValue>? headers,
    double? timeout,
  });
  Future<APIRequestContextStorageStateResult> storageState({bool? indexedDB});
  Future<APIRequestContextFetchResponseBodyResult> fetchResponseBody({
    required String fetchUid,
  });
  Future<APIRequestContextFetchLogResult> fetchLog({required String fetchUid});
  Future<void> disposeAPIResponse({required String fetchUid});
  Future<void> dispose({String? reason});
}

class APIRequestContextImpl extends APIRequestContextBase
    implements APIRequestContext {
  APIRequestContextImpl(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  @override
  Future<APIResponse> fetch(
    String url, {
    String? method,
    List<NameValue>? headers,
    String? postData,
    String? jsonData,
    List<NameValue>? formData,
    List<FormField>? multipartData,
    double? timeout,
    bool? failOnStatusCode,
    bool? ignoreHTTPSErrors,
    int? maxRedirects,
    int? maxRetries,
    String? encodedParams,
    List<NameValue>? params,
  }) async {
    final result = await channel_fetch(
      url: url,
      method: method,
      headers: headers,
      postData: postData,
      jsonData: jsonData,
      formData: formData,
      multipartData: multipartData,
      timeout: timeout ?? 30000.0,
      failOnStatusCode: failOnStatusCode,
      ignoreHTTPSErrors: ignoreHTTPSErrors,
      maxRedirects: maxRedirects,
      maxRetries: maxRetries,
      encodedParams: encodedParams,
      params: params,
    );
    return result.response;
  }

  @override
  Future<APIResponse> get(
    String url, {
    List<NameValue>? headers,
    double? timeout,
  }) => fetch(url, method: 'GET', headers: headers, timeout: timeout);

  @override
  Future<APIResponse> post(
    String url, {
    List<NameValue>? headers,
    String? postData,
    String? jsonData,
    double? timeout,
  }) => fetch(
    url,
    method: 'POST',
    headers: headers,
    postData: postData,
    jsonData: jsonData,
    timeout: timeout,
  );

  @override
  Future<APIResponse> put(
    String url, {
    List<NameValue>? headers,
    String? postData,
    String? jsonData,
    double? timeout,
  }) => fetch(
    url,
    method: 'PUT',
    headers: headers,
    postData: postData,
    jsonData: jsonData,
    timeout: timeout,
  );

  @override
  Future<APIResponse> delete(
    String url, {
    List<NameValue>? headers,
    double? timeout,
  }) => fetch(url, method: 'DELETE', headers: headers, timeout: timeout);

  @override
  Future<APIResponse> patch(
    String url, {
    List<NameValue>? headers,
    String? postData,
    String? jsonData,
    double? timeout,
  }) => fetch(
    url,
    method: 'PATCH',
    headers: headers,
    postData: postData,
    jsonData: jsonData,
    timeout: timeout,
  );

  @override
  Future<APIResponse> head(
    String url, {
    List<NameValue>? headers,
    double? timeout,
  }) => fetch(url, method: 'HEAD', headers: headers, timeout: timeout);

  @override
  Future<APIRequestContextStorageStateResult> storageState({
    bool? indexedDB,
  }) async {
    final result = await channel_storageState(indexedDB: indexedDB);
    return result;
  }

  @override
  Future<void> dispose({String? reason}) async {
    await channel_dispose(reason: reason);
  }

  // Aliases for missing script check
  @override
  Future<APIRequestContextFetchResponseBodyResult> fetchResponseBody({
    required String fetchUid,
  }) => channel_fetchResponseBody(fetchUid: fetchUid);
  @override
  Future<APIRequestContextFetchLogResult> fetchLog({
    required String fetchUid,
  }) => channel_fetchLog(fetchUid: fetchUid);
  @override
  Future<void> disposeAPIResponse({required String fetchUid}) =>
      channel_disposeAPIResponse(fetchUid: fetchUid);
}
