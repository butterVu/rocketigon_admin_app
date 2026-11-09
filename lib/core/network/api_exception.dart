import 'package:dio/dio.dart';

import 'api_error_codes.dart';

/// Validation error of a single request field.
class FieldError {
  /// Creates a [FieldError].
  const FieldError({required this.field, required this.messages});

  /// Field path, using dots for nested objects, e.g. `address.city`.
  final String field;

  /// Validation messages in English, for debugging.
  final List<String> messages;
}

/// Failure of an API call, built from the error envelope or a transport error.
///
/// Branch on [code] (see [ApiErrorCodes]); [message] is English text for
/// logs and must not be shown to the user.
class ApiException implements Exception {
  /// Creates an [ApiException].
  const ApiException({
    required this.code,
    required this.message,
    this.statusCode,
    this.details,
    this.path,
    this.retryAfter,
  });

  /// Creates an [ApiException] for a response that cannot be parsed.
  const ApiException.invalidResponse(String message)
    : this(code: ApiErrorCodes.invalidResponse, message: message);

  /// Converts a [DioException] into an [ApiException].
  factory ApiException.fromDioException(DioException exception) =>
      switch (exception.type) {
        DioExceptionType.badResponse when exception.response != null =>
          ApiException._fromResponse(exception.response!),
        DioExceptionType.connectionTimeout ||
        DioExceptionType.sendTimeout ||
        DioExceptionType.receiveTimeout => ApiException(
          code: ApiErrorCodes.timeout,
          message: exception.message ?? 'Request timed out',
        ),
        DioExceptionType.connectionError ||
        DioExceptionType.badCertificate => ApiException(
          code: ApiErrorCodes.network,
          message: exception.message ?? 'Connection failed',
        ),
        DioExceptionType.cancel => const ApiException(
          code: ApiErrorCodes.cancelled,
          message: 'Request cancelled',
        ),
        _ when exception.error is ApiException =>
          exception.error! as ApiException,
        _ => ApiException(
          code: ApiErrorCodes.unknown,
          message: exception.message ?? exception.error.toString(),
        ),
      };

  factory ApiException._fromResponse(Response<Object?> response) {
    final statusCode = response.statusCode;
    final error = switch (response.data) {
      {'error': final Map<String, dynamic> error} => error,
      _ => const <String, dynamic>{},
    };
    return ApiException(
      statusCode: statusCode,
      code:
          error['code'] as String? ?? ApiErrorCodes.fromStatusCode(statusCode),
      message: error['message'] as String? ?? 'HTTP $statusCode',
      details: error['details'],
      path: switch (response.data) {
        {'path': final String path} => path,
        _ => response.requestOptions.path,
      },
      retryAfter: _parseRetryAfter(response.headers.value('retry-after')),
    );
  }

  /// Stable error code, `UPPER_SNAKE_CASE`.
  final String code;

  /// English message for debugging.
  final String message;

  /// HTTP status, or `null` when the server was not reached.
  final int? statusCode;

  /// Extra data whose shape depends on [code].
  final Object? details;

  /// Path of the failed request.
  final String? path;

  /// Delay requested by the server before retrying (HTTP 429).
  final Duration? retryAfter;

  /// Whether the server rejected the request body or query.
  bool get isValidationError => code == ApiErrorCodes.validationFailed;

  /// Whether the failure comes from connectivity rather than the server.
  bool get isConnectivityError =>
      code == ApiErrorCodes.network || code == ApiErrorCodes.timeout;

  /// Per-field errors of a [ApiErrorCodes.validationFailed] response.
  List<FieldError> get fieldErrors => switch (details) {
    final List<dynamic> items => [
      for (final item in items)
        if (item case {
          'field': final String field,
          'messages': final List<dynamic> messages,
        })
          FieldError(field: field, messages: messages.cast<String>()),
    ],
    _ => const [],
  };

  /// Delay before retrying, from `details.retryAfterSeconds` or the
  /// `Retry-After` header.
  Duration? get retryDelay => switch (details) {
    {'retryAfterSeconds': final int seconds} => Duration(seconds: seconds),
    _ => retryAfter,
  };

  /// Tries left before the OTP is cancelled, from
  /// `details.remainingAttempts`.
  int? get remainingAttempts => switch (details) {
    {'remainingAttempts': final int attempts} => attempts,
    _ => null,
  };

  /// Role of the account that belongs to another app, from
  /// `details.accountRole` of `AUTH_WRONG_APP`.
  String? get accountRole => switch (details) {
    {'accountRole': final String role} => role,
    _ => null,
  };

  /// Whether the server is temporarily unable to answer (HTTP 503).
  bool get isServiceUnavailable =>
      statusCode == 503 || code == ApiErrorCodes.authSessionCheckUnavailable;

  static Duration? _parseRetryAfter(String? header) {
    final seconds = int.tryParse(header ?? '');
    return seconds == null ? null : Duration(seconds: seconds);
  }

  @override
  String toString() =>
      'ApiException($code, status: $statusCode, path: $path): $message';
}
