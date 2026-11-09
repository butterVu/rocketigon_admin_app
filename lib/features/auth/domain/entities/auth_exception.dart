/// Reason an authentication operation failed.
enum AuthFailure {
  /// The phone number has an invalid format.
  invalidPhoneNumber,

  /// Wrong phone number or login code.
  invalidCredentials,

  /// Sign-in is locked after too many failures, see
  /// [AuthException.retryAfter].
  loginLocked,

  /// The account was locked by an administrator.
  accountLocked,

  /// A new OTP was requested too early, see [AuthException.retryAfter].
  otpResendTooSoon,

  /// The phone number received too many OTPs, see
  /// [AuthException.retryAfter].
  otpLimitExceeded,

  /// The SMS could not be sent; retrying right away is allowed.
  otpDeliveryFailed,

  /// Too many requests from this network.
  tooManyRequests,

  /// The credentials are right but the account belongs to another app, see
  /// [AuthException.accountRole].
  wrongApp,

  /// The server is temporarily unable to answer.
  serviceUnavailable,

  /// The server could not be reached.
  network,

  /// Any other failure.
  unknown,
}

/// Failure raised by authentication operations.
class AuthException implements Exception {
  /// Creates an [AuthException].
  const AuthException(
    this.failure, {
    this.retryAfter,
    this.accountRole,
    this.detail,
  });

  /// Reason of the failure.
  final AuthFailure failure;

  /// Time to wait before retrying, when the server tells it.
  final Duration? retryAfter;

  /// Role of the app the account belongs to, for [AuthFailure.wrongApp].
  final String? accountRole;

  /// Technical detail for logging, not shown to the user.
  final String? detail;

  @override
  String toString() => 'AuthException(${failure.name}): ${detail ?? ''}';
}
