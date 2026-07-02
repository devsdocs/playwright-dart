import '../generated/channels.dart';

/// Interface for APIRequestContext
abstract interface class APIRequestContext {
  /// Sends HTTP(S) request and returns its response. The method will populate request cookies from the context and update context cookies from the response. The method will automatically follow redirects.
  ///
  /// **Usage**
  ///
  /// JSON objects can be passed directly to the request:
  ///
  /// ```dart
  /// await request.fetch('https://example.com/api/createBook',
  ///   method: 'post',
  ///   data: {
  ///     title: 'Book Title',
  ///     author: 'John Doe',
  ///   );
  /// ```
  ///
  /// The common way to send file(s) in the body of a request is to upload them as form fields with `multipart/form-data` encoding, by specifiying the `multipart` parameter:
  ///
  /// ```dart
  /// final form = new FormData();
  /// form.set('name', 'John');
  /// form.append('name', 'Doe');
  /// // Send two file fields with the same name.
  /// form.append('file', new File(['print(2024);'], 'f1.js', { type: 'text/javascript' ));
  /// form.append('file', new File(['hello'], 'f2.txt', { type: 'text/plain' ));
  /// await request.fetch('https://example.com/api/uploadForm', {
  ///   multipart: form
  /// );
  /// ```
  ///
  /// **Arguments**
  /// - `urlOrRequest` String | [Request]
  ///
  ///   Target URL or Request to get all parameters from.
  /// - `options` Map *(optional)*
  ///   - `data` String | List&lt;int&gt; | [Serializable] *(optional)*
  ///
  ///     Allows to set post data of the request. If the data parameter is an object, it will be serialized to json string and `content-type` header will be set to `application/json` if not explicitly set. Otherwise the `content-type` header will be set to `application/octet-stream` if not explicitly set.
  ///   - `failOnStatusCode` bool *(optional)*
  ///
  ///     Whether to throw on response codes other than 2xx and 3xx. By default response object is returned for all status codes.
  ///   - `form` Map&lt;String, String | num | bool&gt; | [FormData] *(optional)*
  ///
  ///     Provides an object that will be serialized as html form using `application/x-www-form-urlencoded` encoding and sent as this request body. If this parameter is specified `content-type` header will be set to `application/x-www-form-urlencoded` unless explicitly provided.
  ///   - `headers` List&lt;NameValue&gt; *(optional)*
  ///
  ///     Allows to set HTTP headers. These headers will apply to the fetched request as well as any redirects initiated by it.
  ///   - `ignoreHTTPSErrors` bool *(optional)*
  ///
  ///     Whether to ignore HTTPS errors when sending network requests. Defaults to `false`.
  ///   - `maxRedirects` int *(optional)*
  ///
  ///     Maximum number of request redirects that will be followed automatically. An error will be thrown if the number is exceeded. Defaults to `20`. Pass `0` to not follow redirects.
  ///   - `maxRetries` int *(optional)*
  ///
  ///     Maximum number of times network errors should be retried. Currently only `ECONNRESET` error is retried. Does not retry based on HTTP response codes. An error will be thrown if the limit is exceeded. Defaults to `0` - no retries.
  ///   - `method` String *(optional)*
  ///
  ///     If set changes the fetch method (e.g. [PUT] or [POST]). If not specified, GET method is used.
  ///   - `multipart` [FormData] | Map&lt;String, String | num | bool | [ReadStream] | Map&gt; *(optional)*
  ///     - `name` String
  ///
  ///       File name
  ///     - `mimeType` String
  ///
  ///       File type
  ///     - `buffer` List&lt;int&gt;
  ///
  ///       File content
  ///
  ///     Provides an object that will be serialized as html form using `multipart/form-data` encoding and sent as this request body. If this parameter is specified `content-type` header will be set to `multipart/form-data` unless explicitly provided. File values can be passed either as [`fs.ReadStream`] or as file-like object containing file name, mime-type and its content.
  ///   - `params` List&lt;NameValue&gt; *(optional)*
  ///
  ///     Query parameters to be sent with the URL.
  ///   - `timeout` double *(optional)*
  ///
  ///     Request timeout in milliseconds. Defaults to `30000` (30 seconds). Pass `0` to disable timeout.
  ///
  /// **Returns**
  /// - Future&lt;[APIResponse]&gt;
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

  /// Sends HTTP(S) [GET] request and returns its response. The method will populate request cookies from the context and update context cookies from the response. The method will automatically follow redirects.
  ///
  /// **Usage**
  ///
  /// Request parameters can be configured with `params` option, they will be serialized into the URL search parameters:
  ///
  /// ```dart
  /// // Passing params as object
  /// await request.get('https://example.com/api/getText',
  ///   params: {
  ///     'isbn': '1234',
  ///     'page': 23,
  ///   );
  ///
  /// // Passing params as URLSearchParams
  /// final searchParams = new URLSearchParams();
  /// searchParams.set('isbn', '1234');
  /// searchParams.append('page', 23);
  /// searchParams.append('page', 24);
  /// await request.get('https://example.com/api/getText', { params: searchParams );
  ///
  /// // Passing params as string
  /// final queryString = 'isbn=1234&page=23&page=24';
  /// await request.get('https://example.com/api/getText', { params: queryString );
  /// ```
  ///
  /// **Arguments**
  /// - `url` String
  ///
  ///   Target URL.
  /// - `options` Map *(optional)*
  ///   - `data` String | List&lt;int&gt; | [Serializable] *(optional)*
  ///
  ///     Allows to set post data of the request. If the data parameter is an object, it will be serialized to json string and `content-type` header will be set to `application/json` if not explicitly set. Otherwise the `content-type` header will be set to `application/octet-stream` if not explicitly set.
  ///   - `failOnStatusCode` bool *(optional)*
  ///
  ///     Whether to throw on response codes other than 2xx and 3xx. By default response object is returned for all status codes.
  ///   - `form` Map&lt;String, String | num | bool&gt; | [FormData] *(optional)*
  ///
  ///     Provides an object that will be serialized as html form using `application/x-www-form-urlencoded` encoding and sent as this request body. If this parameter is specified `content-type` header will be set to `application/x-www-form-urlencoded` unless explicitly provided.
  ///   - `headers` List&lt;NameValue&gt; *(optional)*
  ///
  ///     Allows to set HTTP headers. These headers will apply to the fetched request as well as any redirects initiated by it.
  ///   - `ignoreHTTPSErrors` bool *(optional)*
  ///
  ///     Whether to ignore HTTPS errors when sending network requests. Defaults to `false`.
  ///   - `maxRedirects` num *(optional)*
  ///
  ///     Maximum number of request redirects that will be followed automatically. An error will be thrown if the number is exceeded. Defaults to `20`. Pass `0` to not follow redirects.
  ///   - `maxRetries` num *(optional)*
  ///
  ///     Maximum number of times network errors should be retried. Currently only `ECONNRESET` error is retried. Does not retry based on HTTP response codes. An error will be thrown if the limit is exceeded. Defaults to `0` - no retries.
  ///   - `multipart` [FormData] | Map&lt;String, String | num | bool | [ReadStream] | Map&gt; *(optional)*
  ///     - `name` String
  ///
  ///       File name
  ///     - `mimeType` String
  ///
  ///       File type
  ///     - `buffer` List&lt;int&gt;
  ///
  ///       File content
  ///
  ///     Provides an object that will be serialized as html form using `multipart/form-data` encoding and sent as this request body. If this parameter is specified `content-type` header will be set to `multipart/form-data` unless explicitly provided. File values can be passed either as [`fs.ReadStream`] or as file-like object containing file name, mime-type and its content.
  ///   - `params` Map&lt;String, String | num | bool&gt; | [URLSearchParams] | String *(optional)*
  ///
  ///     Query parameters to be sent with the URL.
  ///   - `timeout` double *(optional)*
  ///
  ///     Request timeout in milliseconds. Defaults to `30000` (30 seconds). Pass `0` to disable timeout.
  ///
  /// **Returns**
  /// - Future&lt;[APIResponse]&gt;
  Future<APIResponse> get(
    String url, {
    List<NameValue>? headers,
    double? timeout,
  });

  /// Sends HTTP(S) [POST] request and returns its response. The method will populate request cookies from the context and update context cookies from the response. The method will automatically follow redirects.
  ///
  /// **Usage**
  ///
  /// JSON objects can be passed directly to the request:
  ///
  /// ```dart
  /// await request.post('https://example.com/api/createBook',
  ///   data: {
  ///     title: 'Book Title',
  ///     author: 'John Doe',
  ///   );
  /// ```
  ///
  /// To send form data to the server use `form` option. Its value will be encoded into the request body with `application/x-www-form-urlencoded` encoding (see below how to use `multipart/form-data` form encoding to send files):
  ///
  /// ```dart
  /// await request.post('https://example.com/api/findBook',
  ///   form: {
  ///     title: 'Book Title',
  ///     author: 'John Doe',
  ///   );
  /// ```
  ///
  /// The common way to send file(s) in the body of a request is to upload them as form fields with `multipart/form-data` encoding. Use [FormData] to construct request body and pass it to the request as `multipart` parameter:
  ///
  /// ```dart
  /// final form = new FormData();
  /// form.set('name', 'John');
  /// form.append('name', 'Doe');
  /// // Send two file fields with the same name.
  /// form.append('file', new File(['print(2024);'], 'f1.js', { type: 'text/javascript' ));
  /// form.append('file', new File(['hello'], 'f2.txt', { type: 'text/plain' ));
  /// await request.post('https://example.com/api/uploadForm', {
  ///   multipart: form
  /// );
  /// ```
  ///
  /// **Arguments**
  /// - `url` String
  ///
  ///   Target URL.
  /// - `options` Map *(optional)*
  ///   - `data` String | List&lt;int&gt; | [Serializable] *(optional)*
  ///
  ///     Allows to set post data of the request. If the data parameter is an object, it will be serialized to json string and `content-type` header will be set to `application/json` if not explicitly set. Otherwise the `content-type` header will be set to `application/octet-stream` if not explicitly set.
  ///   - `failOnStatusCode` bool *(optional)*
  ///
  ///     Whether to throw on response codes other than 2xx and 3xx. By default response object is returned for all status codes.
  ///   - `form` Map&lt;String, String | num | bool&gt; | [FormData] *(optional)*
  ///
  ///     Provides an object that will be serialized as html form using `application/x-www-form-urlencoded` encoding and sent as this request body. If this parameter is specified `content-type` header will be set to `application/x-www-form-urlencoded` unless explicitly provided.
  ///   - `headers` List&lt;NameValue&gt; *(optional)*
  ///
  ///     Allows to set HTTP headers. These headers will apply to the fetched request as well as any redirects initiated by it.
  ///   - `ignoreHTTPSErrors` bool *(optional)*
  ///
  ///     Whether to ignore HTTPS errors when sending network requests. Defaults to `false`.
  ///   - `maxRedirects` num *(optional)*
  ///
  ///     Maximum number of request redirects that will be followed automatically. An error will be thrown if the number is exceeded. Defaults to `20`. Pass `0` to not follow redirects.
  ///   - `maxRetries` num *(optional)*
  ///
  ///     Maximum number of times network errors should be retried. Currently only `ECONNRESET` error is retried. Does not retry based on HTTP response codes. An error will be thrown if the limit is exceeded. Defaults to `0` - no retries.
  ///   - `multipart` [FormData] | Map&lt;String, String | num | bool | [ReadStream] | Map&gt; *(optional)*
  ///     - `name` String
  ///
  ///       File name
  ///     - `mimeType` String
  ///
  ///       File type
  ///     - `buffer` List&lt;int&gt;
  ///
  ///       File content
  ///
  ///     Provides an object that will be serialized as html form using `multipart/form-data` encoding and sent as this request body. If this parameter is specified `content-type` header will be set to `multipart/form-data` unless explicitly provided. File values can be passed either as [`fs.ReadStream`] or as file-like object containing file name, mime-type and its content.
  ///   - `params` Map&lt;String, String | num | bool&gt; | [URLSearchParams] | String *(optional)*
  ///
  ///     Query parameters to be sent with the URL.
  ///   - `timeout` double *(optional)*
  ///
  ///     Request timeout in milliseconds. Defaults to `30000` (30 seconds). Pass `0` to disable timeout.
  ///
  /// **Returns**
  /// - Future&lt;[APIResponse]&gt;
  Future<APIResponse> post(
    String url, {
    List<NameValue>? headers,
    String? postData,
    String? jsonData,
    double? timeout,
  });

  /// Sends HTTP(S) [PUT] request and returns its response. The method will populate request cookies from the context and update context cookies from the response. The method will automatically follow redirects.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await apiRequestContext.put(url);
  /// await apiRequestContext.put(url, options);
  /// ```
  ///
  /// **Arguments**
  /// - `url` String
  ///
  ///   Target URL.
  /// - `options` Map *(optional)*
  ///   - `data` String | List&lt;int&gt; | [Serializable] *(optional)*
  ///
  ///     Allows to set post data of the request. If the data parameter is an object, it will be serialized to json string and `content-type` header will be set to `application/json` if not explicitly set. Otherwise the `content-type` header will be set to `application/octet-stream` if not explicitly set.
  ///   - `failOnStatusCode` bool *(optional)*
  ///
  ///     Whether to throw on response codes other than 2xx and 3xx. By default response object is returned for all status codes.
  ///   - `form` Map&lt;String, String | num | bool&gt; | [FormData] *(optional)*
  ///
  ///     Provides an object that will be serialized as html form using `application/x-www-form-urlencoded` encoding and sent as this request body. If this parameter is specified `content-type` header will be set to `application/x-www-form-urlencoded` unless explicitly provided.
  ///   - `headers` List&lt;NameValue&gt; *(optional)*
  ///
  ///     Allows to set HTTP headers. These headers will apply to the fetched request as well as any redirects initiated by it.
  ///   - `ignoreHTTPSErrors` bool *(optional)*
  ///
  ///     Whether to ignore HTTPS errors when sending network requests. Defaults to `false`.
  ///   - `maxRedirects` num *(optional)*
  ///
  ///     Maximum number of request redirects that will be followed automatically. An error will be thrown if the number is exceeded. Defaults to `20`. Pass `0` to not follow redirects.
  ///   - `maxRetries` num *(optional)*
  ///
  ///     Maximum number of times network errors should be retried. Currently only `ECONNRESET` error is retried. Does not retry based on HTTP response codes. An error will be thrown if the limit is exceeded. Defaults to `0` - no retries.
  ///   - `multipart` [FormData] | Map&lt;String, String | num | bool | [ReadStream] | Map&gt; *(optional)*
  ///     - `name` String
  ///
  ///       File name
  ///     - `mimeType` String
  ///
  ///       File type
  ///     - `buffer` List&lt;int&gt;
  ///
  ///       File content
  ///
  ///     Provides an object that will be serialized as html form using `multipart/form-data` encoding and sent as this request body. If this parameter is specified `content-type` header will be set to `multipart/form-data` unless explicitly provided. File values can be passed either as [`fs.ReadStream`] or as file-like object containing file name, mime-type and its content.
  ///   - `params` Map&lt;String, String | num | bool&gt; | [URLSearchParams] | String *(optional)*
  ///
  ///     Query parameters to be sent with the URL.
  ///   - `timeout` double *(optional)*
  ///
  ///     Request timeout in milliseconds. Defaults to `30000` (30 seconds). Pass `0` to disable timeout.
  ///
  /// **Returns**
  /// - Future&lt;[APIResponse]&gt;
  Future<APIResponse> put(
    String url, {
    List<NameValue>? headers,
    String? postData,
    String? jsonData,
    double? timeout,
  });

  /// Sends HTTP(S) [DELETE] request and returns its response. The method will populate request cookies from the context and update context cookies from the response. The method will automatically follow redirects.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await apiRequestContext.delete(url);
  /// await apiRequestContext.delete(url, options);
  /// ```
  ///
  /// **Arguments**
  /// - `url` String
  ///
  ///   Target URL.
  /// - `options` Map *(optional)*
  ///   - `data` String | List&lt;int&gt; | [Serializable] *(optional)*
  ///
  ///     Allows to set post data of the request. If the data parameter is an object, it will be serialized to json string and `content-type` header will be set to `application/json` if not explicitly set. Otherwise the `content-type` header will be set to `application/octet-stream` if not explicitly set.
  ///   - `failOnStatusCode` bool *(optional)*
  ///
  ///     Whether to throw on response codes other than 2xx and 3xx. By default response object is returned for all status codes.
  ///   - `form` Map&lt;String, String | num | bool&gt; | [FormData] *(optional)*
  ///
  ///     Provides an object that will be serialized as html form using `application/x-www-form-urlencoded` encoding and sent as this request body. If this parameter is specified `content-type` header will be set to `application/x-www-form-urlencoded` unless explicitly provided.
  ///   - `headers` List&lt;NameValue&gt; *(optional)*
  ///
  ///     Allows to set HTTP headers. These headers will apply to the fetched request as well as any redirects initiated by it.
  ///   - `ignoreHTTPSErrors` bool *(optional)*
  ///
  ///     Whether to ignore HTTPS errors when sending network requests. Defaults to `false`.
  ///   - `maxRedirects` num *(optional)*
  ///
  ///     Maximum number of request redirects that will be followed automatically. An error will be thrown if the number is exceeded. Defaults to `20`. Pass `0` to not follow redirects.
  ///   - `maxRetries` num *(optional)*
  ///
  ///     Maximum number of times network errors should be retried. Currently only `ECONNRESET` error is retried. Does not retry based on HTTP response codes. An error will be thrown if the limit is exceeded. Defaults to `0` - no retries.
  ///   - `multipart` [FormData] | Map&lt;String, String | num | bool | [ReadStream] | Map&gt; *(optional)*
  ///     - `name` String
  ///
  ///       File name
  ///     - `mimeType` String
  ///
  ///       File type
  ///     - `buffer` List&lt;int&gt;
  ///
  ///       File content
  ///
  ///     Provides an object that will be serialized as html form using `multipart/form-data` encoding and sent as this request body. If this parameter is specified `content-type` header will be set to `multipart/form-data` unless explicitly provided. File values can be passed either as [`fs.ReadStream`] or as file-like object containing file name, mime-type and its content.
  ///   - `params` Map&lt;String, String | num | bool&gt; | [URLSearchParams] | String *(optional)*
  ///
  ///     Query parameters to be sent with the URL.
  ///   - `timeout` double *(optional)*
  ///
  ///     Request timeout in milliseconds. Defaults to `30000` (30 seconds). Pass `0` to disable timeout.
  ///
  /// **Returns**
  /// - Future&lt;[APIResponse]&gt;
  Future<APIResponse> delete(
    String url, {
    List<NameValue>? headers,
    double? timeout,
  });

  /// Sends HTTP(S) [PATCH] request and returns its response. The method will populate request cookies from the context and update context cookies from the response. The method will automatically follow redirects.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await apiRequestContext.patch(url);
  /// await apiRequestContext.patch(url, options);
  /// ```
  ///
  /// **Arguments**
  /// - `url` String
  ///
  ///   Target URL.
  /// - `options` Map *(optional)*
  ///   - `data` String | List&lt;int&gt; | [Serializable] *(optional)*
  ///
  ///     Allows to set post data of the request. If the data parameter is an object, it will be serialized to json string and `content-type` header will be set to `application/json` if not explicitly set. Otherwise the `content-type` header will be set to `application/octet-stream` if not explicitly set.
  ///   - `failOnStatusCode` bool *(optional)*
  ///
  ///     Whether to throw on response codes other than 2xx and 3xx. By default response object is returned for all status codes.
  ///   - `form` Map&lt;String, String | num | bool&gt; | [FormData] *(optional)*
  ///
  ///     Provides an object that will be serialized as html form using `application/x-www-form-urlencoded` encoding and sent as this request body. If this parameter is specified `content-type` header will be set to `application/x-www-form-urlencoded` unless explicitly provided.
  ///   - `headers` List&lt;NameValue&gt; *(optional)*
  ///
  ///     Allows to set HTTP headers. These headers will apply to the fetched request as well as any redirects initiated by it.
  ///   - `ignoreHTTPSErrors` bool *(optional)*
  ///
  ///     Whether to ignore HTTPS errors when sending network requests. Defaults to `false`.
  ///   - `maxRedirects` num *(optional)*
  ///
  ///     Maximum number of request redirects that will be followed automatically. An error will be thrown if the number is exceeded. Defaults to `20`. Pass `0` to not follow redirects.
  ///   - `maxRetries` num *(optional)*
  ///
  ///     Maximum number of times network errors should be retried. Currently only `ECONNRESET` error is retried. Does not retry based on HTTP response codes. An error will be thrown if the limit is exceeded. Defaults to `0` - no retries.
  ///   - `multipart` [FormData] | Map&lt;String, String | num | bool | [ReadStream] | Map&gt; *(optional)*
  ///     - `name` String
  ///
  ///       File name
  ///     - `mimeType` String
  ///
  ///       File type
  ///     - `buffer` List&lt;int&gt;
  ///
  ///       File content
  ///
  ///     Provides an object that will be serialized as html form using `multipart/form-data` encoding and sent as this request body. If this parameter is specified `content-type` header will be set to `multipart/form-data` unless explicitly provided. File values can be passed either as [`fs.ReadStream`] or as file-like object containing file name, mime-type and its content.
  ///   - `params` Map&lt;String, String | num | bool&gt; | [URLSearchParams] | String *(optional)*
  ///
  ///     Query parameters to be sent with the URL.
  ///   - `timeout` double *(optional)*
  ///
  ///     Request timeout in milliseconds. Defaults to `30000` (30 seconds). Pass `0` to disable timeout.
  ///
  /// **Returns**
  /// - Future&lt;[APIResponse]&gt;
  Future<APIResponse> patch(
    String url, {
    List<NameValue>? headers,
    String? postData,
    String? jsonData,
    double? timeout,
  });

  /// Sends HTTP(S) [HEAD] request and returns its response. The method will populate request cookies from the context and update context cookies from the response. The method will automatically follow redirects.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await apiRequestContext.head(url);
  /// await apiRequestContext.head(url, options);
  /// ```
  ///
  /// **Arguments**
  /// - `url` String
  ///
  ///   Target URL.
  /// - `options` Map *(optional)*
  ///   - `data` String | List&lt;int&gt; | [Serializable] *(optional)*
  ///
  ///     Allows to set post data of the request. If the data parameter is an object, it will be serialized to json string and `content-type` header will be set to `application/json` if not explicitly set. Otherwise the `content-type` header will be set to `application/octet-stream` if not explicitly set.
  ///   - `failOnStatusCode` bool *(optional)*
  ///
  ///     Whether to throw on response codes other than 2xx and 3xx. By default response object is returned for all status codes.
  ///   - `form` Map&lt;String, String | num | bool&gt; | [FormData] *(optional)*
  ///
  ///     Provides an object that will be serialized as html form using `application/x-www-form-urlencoded` encoding and sent as this request body. If this parameter is specified `content-type` header will be set to `application/x-www-form-urlencoded` unless explicitly provided.
  ///   - `headers` List&lt;NameValue&gt; *(optional)*
  ///
  ///     Allows to set HTTP headers. These headers will apply to the fetched request as well as any redirects initiated by it.
  ///   - `ignoreHTTPSErrors` bool *(optional)*
  ///
  ///     Whether to ignore HTTPS errors when sending network requests. Defaults to `false`.
  ///   - `maxRedirects` num *(optional)*
  ///
  ///     Maximum number of request redirects that will be followed automatically. An error will be thrown if the number is exceeded. Defaults to `20`. Pass `0` to not follow redirects.
  ///   - `maxRetries` num *(optional)*
  ///
  ///     Maximum number of times network errors should be retried. Currently only `ECONNRESET` error is retried. Does not retry based on HTTP response codes. An error will be thrown if the limit is exceeded. Defaults to `0` - no retries.
  ///   - `multipart` [FormData] | Map&lt;String, String | num | bool | [ReadStream] | Map&gt; *(optional)*
  ///     - `name` String
  ///
  ///       File name
  ///     - `mimeType` String
  ///
  ///       File type
  ///     - `buffer` List&lt;int&gt;
  ///
  ///       File content
  ///
  ///     Provides an object that will be serialized as html form using `multipart/form-data` encoding and sent as this request body. If this parameter is specified `content-type` header will be set to `multipart/form-data` unless explicitly provided. File values can be passed either as [`fs.ReadStream`] or as file-like object containing file name, mime-type and its content.
  ///   - `params` Map&lt;String, String | num | bool&gt; | [URLSearchParams] | String *(optional)*
  ///
  ///     Query parameters to be sent with the URL.
  ///   - `timeout` double *(optional)*
  ///
  ///     Request timeout in milliseconds. Defaults to `30000` (30 seconds). Pass `0` to disable timeout.
  ///
  /// **Returns**
  /// - Future&lt;[APIResponse]&gt;
  Future<APIResponse> head(
    String url, {
    List<NameValue>? headers,
    double? timeout,
  });

  /// Returns storage state for this request context, contains current cookies and local storage snapshot if it was passed to the constructor.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await apiRequestContext.storageState();
  /// await apiRequestContext.storageState(options);
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `indexedDB` bool *(optional)*
  ///
  ///     Set to `true` to include IndexedDB in the storage state snapshot.
  ///   - `path` String *(optional)*
  ///
  ///     The file path to save the storage state to. If [path] is a relative path, then it is resolved relative to current working directory. If no path is provided, storage state is still returned, but won't be saved to the disk.
  ///
  /// **Returns**
  /// - Future&lt;Map&gt;
  ///   - `cookies` List&lt;Map&gt;
  ///     - `name` String
  ///
  ///
  ///     - `value` String
  ///
  ///
  ///     - `domain` String
  ///
  ///
  ///     - `path` String
  ///
  ///
  ///     - `expires` num
  ///
  ///       Unix time in seconds.
  ///     - `httpOnly` bool
  ///
  ///
  ///     - `secure` bool
  ///
  ///
  ///     - `sameSite` "Strict" | "Lax" | "None"
  ///
  ///
  ///
  ///   - `origins` List&lt;Map&gt;
  ///     - `origin` String
  ///
  ///
  ///     - `localStorage` List&lt;Map&gt;
  ///       - `name` String
  ///
  ///
  ///       - `value` String
  Future<APIRequestContextStorageStateResult> storageState({bool? indexedDB});
  Future<APIRequestContextFetchResponseBodyResult> fetchResponseBody({
    required String fetchUid,
  });
  Future<APIRequestContextFetchLogResult> fetchLog({required String fetchUid});
  Future<void> disposeAPIResponse({required String fetchUid});

  /// All responses returned by [apiRequestContext.get()] and similar methods are stored in the memory, so that you can later call [apiResponse.body()].This method discards all its resources, calling any method on disposed [APIRequestContext] will throw an exception.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await apiRequestContext.dispose();
  /// await apiRequestContext.dispose(options);
  /// ```
  ///
  /// **Arguments**
  /// - `options` Map *(optional)*
  ///   - `reason` String *(optional)*
  ///
  ///     The reason to be reported to the operations interrupted by the context disposal.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
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
