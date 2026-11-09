import 'dart:developer' as developer;

import 'package:dio/dio.dart';

/// Logs requests, responses and errors to DevTools.
///
/// Headers and bodies are not logged, so tokens and personal data stay out
/// of the logs.
class LoggingInterceptor extends Interceptor {
  static const _name = 'rocket.network';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    developer.log('--> ${options.method} ${options.uri}', name: _name);
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    final request = response.requestOptions;
    developer.log(
      '<-- ${response.statusCode} ${request.method} ${request.uri}',
      name: _name,
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final request = err.requestOptions;
    developer.log(
      '<-- ${err.response?.statusCode ?? err.type.name} '
      '${request.method} ${request.uri}',
      name: _name,
      level: 900,
      error: err.response?.data ?? err.message,
    );
    handler.next(err);
  }
}
