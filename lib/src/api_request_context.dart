import 'generated/channels.dart';

class APIRequestContext extends APIRequestContextBase {
  APIRequestContext(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

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
    );
    return result.response;
  }

  Future<APIResponse> get(
    String url, {
    List<NameValue>? headers,
    double? timeout,
  }) => fetch(url, method: 'GET', headers: headers, timeout: timeout);

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

  Future<APIResponse> delete(
    String url, {
    List<NameValue>? headers,
    double? timeout,
  }) => fetch(url, method: 'DELETE', headers: headers, timeout: timeout);

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

  Future<APIResponse> head(
    String url, {
    List<NameValue>? headers,
    double? timeout,
  }) => fetch(url, method: 'HEAD', headers: headers, timeout: timeout);

  Future<APIRequestContextStorageStateResult> storageState({
    bool? indexedDB,
  }) async {
    final result = await channel_storageState(indexedDB: indexedDB);
    return result;
  }

  @override
  Future<void> dispose() async {
    await channel_dispose();
  }

  // Aliases for missing script check
  Future<APIRequestContextFetchResponseBodyResult> fetchResponseBody({
    required String fetchUid,
  }) => channel_fetchResponseBody(fetchUid: fetchUid);
  Future<APIRequestContextFetchLogResult> fetchLog({
    required String fetchUid,
  }) => channel_fetchLog(fetchUid: fetchUid);
  Future<void> disposeAPIResponse({required String fetchUid}) =>
      channel_disposeAPIResponse(fetchUid: fetchUid);
}
