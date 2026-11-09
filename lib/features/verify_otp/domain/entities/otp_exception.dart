/// Reason an OTP operation failed.
enum OtpFailure {
  /// The entered code does not match, see [OtpException.remainingAttempts].
  invalidCode,

  /// The code was cancelled after too many wrong entries; resend it.
  codeCancelled,

  /// The code expired or was already used; resend it.
  expired,

  /// A new code was requested too early, see [OtpException.retryAfter].
  resendTooSoon,

  /// Too many codes were sent to this number, see
  /// [OtpException.retryAfter].
  limitExceeded,

  /// The SMS could not be sent; resending right away is allowed.
  deliveryFailed,

  /// The verification session expired; the flow must restart.
  sessionExpired,

  /// Sign-in is locked after too many failures, see
  /// [OtpException.retryAfter].
  loginLocked,

  /// The account was locked by an administrator.
  accountLocked,

  /// Too many requests from this network.
  tooManyRequests,

  /// The account belongs to another app, see [OtpException.accountRole].
  wrongApp,

  /// The server could not be reached.
  network,

  /// Any other failure.
  unknown,
}

/// Failure raised by OTP operations.
class OtpException implements Exception {
  /// Creates an [OtpException].
  const OtpException(
    this.failure, {
    this.retryAfter,
    this.remainingAttempts,
    this.accountRole,
    this.detail,
  });

  /// Reason of the failure.
  final OtpFailure failure;

  /// Time to wait before retrying, when the server tells it.
  final Duration? retryAfter;

  /// Tries left before the code is cancelled, when known.
  final int? remainingAttempts;

  /// Role of the app the account belongs to, for [OtpFailure.wrongApp].
  final String? accountRole;

  /// Technical detail for logging, not shown to the user.
  final String? detail;

  @override
  String toString() => 'OtpException(${failure.name}): ${detail ?? ''}';
}
