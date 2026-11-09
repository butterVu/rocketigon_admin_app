import 'dart:developer' as developer;

import 'package:dio/dio.dart';

import '../../services/token_storage.dart';
import '../api_error_codes.dart';

/// Adds the `Authorization: Bearer <token>` header to each request and
/// refreshes the token pair once the access token expires.
///
/// Errors are handled one at a time ([QueuedInterceptor]), so requests
/// failing together with `AUTH_TOKEN_EXPIRED` share a single refresh. This
/// matters: the server signs the user out on every device when a rotated
/// refresh token is sent again.
///
/// Set [skipAuthKey] to `true` in `Options.extra` for public endpoints.
class AuthInterceptor extends QueuedInterceptor {
  /// Creates an [AuthInterceptor].
  ///
  /// [refreshClient] must not use this interceptor; it sends the refresh
  /// call and the retried request. [onSessionExpired] runs after the stored
  /// tokens were cleared because the session can no longer be refreshed.
  AuthInterceptor({
    required this._tokenStorage,
    required this._refreshClient,
    required this._onSessionExpired,
  });

  /// `Options.extra` key that disables the header for one request.
  static const skipAuthKey = 'skipAuth';

  static const _retriedKey = 'authRetried';
  static const _header = 'Authorization';

  final TokenStorage _tokenStorage;
  final Dio _refreshClient;
  final void Function() _onSessionExpired;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.extra[skipAuthKey] != true) {
      final token = await _tokenStorage.readAccessToken();
      if (token != null) options.headers[_header] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final request = err.requestOptions;
    if (request.extra[skipAuthKey] == true) return handler.next(err);
    switch (_errorCode(err.response)) {
      case ApiErrorCodes.authTokenExpired
          when request.extra[_retriedKey] != true:
        await _refreshAndRetry(err, handler);
      case ApiErrorCodes.authTokenMissing || ApiErrorCodes.authTokenInvalid:
        await _endSession();
        handler.next(err);
      default:
        handler.next(err);
    }
  }

  Future<void> _refreshAndRetry(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final request = err.requestOptions;
    try {
      final token = await _validAccessToken(request);
      if (token == null) return handler.next(err);
      request
        ..headers[_header] = 'Bearer $token'
        ..extra[_retriedKey] = true;
      handler.resolve(await _refreshClient.fetch<Object?>(request));
    } on DioException catch (error) {
      handler.next(error);
    } catch (error, stackTrace) {
      developer.log(
        'Token refresh failed',
        name: 'rocket.network',
        level: 1000,
        error: error,
        stackTrace: stackTrace,
      );
      handler.next(err);
    }
  }

  /// Access token to retry [request] with, or `null` once the session
  /// ended.
  Future<String?> _validAccessToken(RequestOptions request) async {
    final stored = await _tokenStorage.readAccessToken();
    // A request queued earlier already refreshed the token pair.
    if (stored != null && request.headers[_header] != 'Bearer $stored') {
      return stored;
    }
    final refreshToken = await _tokenStorage.readRefreshToken();
    if (refreshToken == null) {
      await _endSession();
      return null;
    }
    try {
      final response = await _refreshClient.post<Map<String, dynamic>>(
        '/auth/refresh',
        data: {'refreshToken': refreshToken},
      );
      final data = response.data!['data'] as Map<String, dynamic>;
      final accessToken = data['accessToken'] as String;
      await _tokenStorage.saveTokens(
        accessToken: accessToken,
        refreshToken: data['refreshToken'] as String,
      );
      return accessToken;
    } on DioException catch (error) {
      if (error.response?.statusCode != 401) rethrow;
      await _endSession();
      return null;
    }
  }

  Future<void> _endSession() async {
    final hadSession = await _tokenStorage.readRefreshToken() != null;
    await _tokenStorage.clear();
    if (hadSession) _onSessionExpired();
  }

  static String? _errorCode(Response<Object?>? response) =>
      switch (response?.data) {
        {'error': {'code': final String code}} => code,
        _ => null,
      };
}
