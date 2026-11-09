import 'dart:developer' as developer;

import 'package:dio/dio.dart';

import 'api_exception.dart';
import 'interceptors/auth_interceptor.dart';
import 'paginated.dart';

/// Converts the `data` field of a success response into [T].
typedef DataDecoder<T> = T Function(Object? data);

/// Parses one JSON object, typically a model's `fromJson`.
typedef JsonParser<T> = T Function(Map<String, dynamic> json);

/// HTTP method of an [ApiClient] request.
enum ApiMethod {
  /// `GET`.
  get('GET'),

  /// `POST`.
  post('POST'),

  /// `PUT`.
  put('PUT'),

  /// `PATCH`.
  patch('PATCH'),

  /// `DELETE`.
  delete('DELETE');

  const ApiMethod(this.value);

  /// Method name sent over HTTP.
  final String value;
}

/// Builds [DataDecoder]s from model parsers.
abstract final class ApiDecoders {
  /// Decodes `data` as a single object.
  static DataDecoder<T> object<T>(JsonParser<T> parse) =>
      (data) => parse(data! as Map<String, dynamic>);

  /// Decodes `data` as a list of objects.
  static DataDecoder<List<T>> list<T>(JsonParser<T> parse) =>
      (data) => [
        for (final item in data! as List<dynamic>)
          parse(item as Map<String, dynamic>),
      ];
}

/// Calls the Rocket API and unwraps its `{ success, data, meta }` envelope.
///
/// Every failure is thrown as an [ApiException], so remote data sources only
/// describe the request and how to decode `data`:
///
/// ```dart
/// Future<UserModel> getMe() => _client.get(
///   '/users/me',
///   decode: ApiDecoders.object(UserModel.fromJson),
/// );
/// ```
class ApiClient {
  /// Creates an [ApiClient] that sends requests through [dio].
  const ApiClient(this._dio);

  final Dio _dio;

  /// Sends a `GET` request and decodes `data`.
  Future<T> get<T>(
    String path, {
    required DataDecoder<T> decode,
    Map<String, dynamic>? query,
    CancelToken? cancelToken,
  }) => request(
    ApiMethod.get,
    path,
    decode: decode,
    query: query,
    cancelToken: cancelToken,
  );

  /// Sends a `POST` request with [body] and decodes `data`.
  ///
  /// Set [skipAuth] for public endpoints such as sign-in.
  Future<T> post<T>(
    String path, {
    required DataDecoder<T> decode,
    Object? body,
    bool skipAuth = false,
    CancelToken? cancelToken,
  }) => request(
    ApiMethod.post,
    path,
    decode: decode,
    body: body,
    skipAuth: skipAuth,
    cancelToken: cancelToken,
  );

  /// Sends a `PUT` request with [body] and decodes `data`.
  Future<T> put<T>(
    String path, {
    required DataDecoder<T> decode,
    Object? body,
    CancelToken? cancelToken,
  }) => request(
    ApiMethod.put,
    path,
    decode: decode,
    body: body,
    cancelToken: cancelToken,
  );

  /// Sends a `PATCH` request with [body] and decodes `data`.
  Future<T> patch<T>(
    String path, {
    required DataDecoder<T> decode,
    Object? body,
    CancelToken? cancelToken,
  }) => request(
    ApiMethod.patch,
    path,
    decode: decode,
    body: body,
    cancelToken: cancelToken,
  );

  /// Sends a request whose response has no useful body, such as `204`.
  Future<void> send(
    ApiMethod method,
    String path, {
    Object? body,
    Map<String, dynamic>? query,
    bool skipAuth = false,
    CancelToken? cancelToken,
  }) => _send(
    method,
    path,
    body: body,
    query: query,
    skipAuth: skipAuth,
    cancelToken: cancelToken,
  );

  /// Sends a `GET` request to a paginated endpoint.
  ///
  /// [page] starts at 1 and [limit] must be between 1 and 100.
  Future<Paginated<T>> getPage<T>(
    String path, {
    required JsonParser<T> parseItem,
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? query,
    CancelToken? cancelToken,
  }) async {
    final envelope = await _send(
      ApiMethod.get,
      path,
      query: {...?query, 'page': page, 'limit': limit},
      cancelToken: cancelToken,
    );
    return _parse(
      path,
      () => Paginated(
        items: ApiDecoders.list(parseItem)(envelope?['data']),
        meta: PaginationMeta.fromJson(
          envelope!['meta'] as Map<String, dynamic>,
        ),
      ),
    );
  }

  /// Sends a request with any [method] and decodes `data`.
  Future<T> request<T>(
    ApiMethod method,
    String path, {
    required DataDecoder<T> decode,
    Object? body,
    Map<String, dynamic>? query,
    bool skipAuth = false,
    CancelToken? cancelToken,
  }) async {
    final envelope = await _send(
      method,
      path,
      body: body,
      query: query,
      skipAuth: skipAuth,
      cancelToken: cancelToken,
    );
    return _parse(path, () => decode(envelope?['data']));
  }

  /// Returns the success envelope, or `null` for an empty `204` response.
  Future<Map<String, dynamic>?> _send(
    ApiMethod method,
    String path, {
    Object? body,
    Map<String, dynamic>? query,
    bool skipAuth = false,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.request<Object?>(
        path,
        data: body,
        queryParameters: query,
        cancelToken: cancelToken,
        options: Options(
          method: method.value,
          extra: {AuthInterceptor.skipAuthKey: skipAuth},
        ),
      );
      return switch (response.data) {
        _ when response.statusCode == 204 => null,
        {'success': true} && final Map<String, dynamic> envelope => envelope,
        _ => throw ApiException.invalidResponse(
          'Missing success envelope from $path',
        ),
      };
    } on DioException catch (exception) {
      throw ApiException.fromDioException(exception);
    }
  }

  /// Runs [parse], turning decoding errors into [ApiException].
  T _parse<T>(String path, T Function() parse) {
    try {
      return parse();
    } catch (error, stackTrace) {
      developer.log(
        'Failed to decode response of $path',
        name: 'rocket.network',
        level: 1000,
        error: error,
        stackTrace: stackTrace,
      );
      throw ApiException.invalidResponse('Cannot decode $path: $error');
    }
  }
}
