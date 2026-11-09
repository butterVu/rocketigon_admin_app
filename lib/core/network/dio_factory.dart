import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../constants/app_constants.dart';
import '../services/token_storage.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/logging_interceptor.dart';

/// Builds the [Dio] instance shared by the app.
abstract final class DioFactory {
  /// Creates a [Dio] targeting [AppConstants.apiBaseUrl].
  ///
  /// [onSessionExpired] runs when the session cannot be refreshed and the
  /// stored tokens were cleared.
  static Dio create({
    required TokenStorage tokenStorage,
    required void Function() onSessionExpired,
  }) => _plain()
    ..interceptors.insert(
      0,
      AuthInterceptor(
        tokenStorage: tokenStorage,
        refreshClient: _plain(),
        onSessionExpired: onSessionExpired,
      ),
    );

  static Dio _plain() => Dio(
    BaseOptions(
      baseUrl: AppConstants.apiBaseUrl,
      connectTimeout: AppConstants.apiConnectTimeout,
      receiveTimeout: AppConstants.apiReceiveTimeout,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
    ),
  )..interceptors.addAll([if (kDebugMode) LoggingInterceptor()]);
}
