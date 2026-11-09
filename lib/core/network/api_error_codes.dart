/// Stable error codes carried by `ApiException.code`.
///
/// Server codes come from `error.code` of the API error envelope; client
/// codes are raised by the app when no server response is available.
abstract final class ApiErrorCodes {
  /// Request rejected without a specific code (HTTP 400).
  static const badRequest = 'BAD_REQUEST';

  /// Request body or query failed validation; see `ApiException.fieldErrors`.
  static const validationFailed = 'VALIDATION_FAILED';

  /// Missing or invalid credentials (HTTP 401).
  static const unauthorized = 'UNAUTHORIZED';

  /// Authenticated but not allowed (HTTP 403).
  static const forbidden = 'FORBIDDEN';

  /// Resource or route does not exist (HTTP 404).
  static const notFound = 'NOT_FOUND';

  /// Conflicting state (HTTP 409).
  static const conflict = 'CONFLICT';

  /// Unique index violation (HTTP 409).
  static const duplicateKey = 'DUPLICATE_KEY';

  /// Rate limit exceeded (HTTP 429); see `ApiException.retryAfter`.
  static const tooManyRequests = 'TOO_MANY_REQUESTS';

  /// Unexpected server failure (HTTP 500).
  static const internalServerError = 'INTERNAL_SERVER_ERROR';

  /// Wrong OTP; `details.remainingAttempts` tells how many tries are left.
  static const otpInvalid = 'OTP_INVALID';

  /// The OTP was cancelled after too many wrong entries.
  static const otpTooManyAttempts = 'OTP_TOO_MANY_ATTEMPTS';

  /// The OTP expired or was already used.
  static const otpExpired = 'OTP_EXPIRED';

  /// A new OTP was requested before `details.retryAfterSeconds`.
  static const otpResendTooSoon = 'OTP_RESEND_TOO_SOON';

  /// The phone number received too many OTPs in the last hour.
  static const otpLimitExceeded = 'OTP_LIMIT_EXCEEDED';

  /// The SMS could not be sent; retrying right away is allowed.
  static const otpDeliveryFailed = 'OTP_DELIVERY_FAILED';

  /// The registration token expired or was used; restart registration.
  static const registrationTokenInvalid = 'REGISTRATION_TOKEN_INVALID';

  /// The reset token expired or was used; restart the forgot code flow.
  static const resetTokenInvalid = 'RESET_TOKEN_INVALID';

  /// The device verification challenge expired; sign in again.
  static const loginChallengeInvalid = 'LOGIN_CHALLENGE_INVALID';

  /// Saved address deleted or owned by another user.
  static const addressNotFound = 'ADDRESS_NOT_FOUND';

  /// The user already saved the maximum number of addresses.
  static const addressLimitReached = 'ADDRESS_LIMIT_REACHED';

  /// Registering a phone number that already has an account.
  static const phoneAlreadyRegistered = 'PHONE_ALREADY_REGISTERED';

  /// Wrong phone number or login code.
  static const authInvalidCredentials = 'AUTH_INVALID_CREDENTIALS';

  /// Sign-in locked after too many failures, see
  /// `details.retryAfterSeconds`.
  static const authLoginLocked = 'AUTH_LOGIN_LOCKED';

  /// Account locked by an administrator.
  static const accountLocked = 'ACCOUNT_LOCKED';

  /// The credentials are right but the account belongs to another app; see
  /// `details.accountRole`.
  static const authWrongApp = 'AUTH_WRONG_APP';

  /// The new login code equals the current one.
  static const loginCodeUnchanged = 'LOGIN_CODE_UNCHANGED';

  /// The session of the account cannot be checked now; retry later without
  /// signing out.
  static const authSessionCheckUnavailable = 'AUTH_SESSION_CHECK_UNAVAILABLE';

  /// The merchant does not exist, was deleted, paused or is not approved yet.
  static const merchantNotFound = 'MERCHANT_NOT_FOUND';

  /// Access token expired; refresh it and retry once.
  static const authTokenExpired = 'AUTH_TOKEN_EXPIRED';

  /// No access token was sent.
  static const authTokenMissing = 'AUTH_TOKEN_MISSING';

  /// Access token is malformed or revoked.
  static const authTokenInvalid = 'AUTH_TOKEN_INVALID';

  /// Refresh token is expired, revoked or already rotated.
  static const authRefreshTokenInvalid = 'AUTH_REFRESH_TOKEN_INVALID';

  /// Client: no connection to the server.
  static const network = 'NETWORK_ERROR';

  /// Client: the request timed out.
  static const timeout = 'TIMEOUT';

  /// Client: the request was cancelled through a `CancelToken`.
  static const cancelled = 'CANCELLED';

  /// Client: the response does not follow the API envelope or model.
  static const invalidResponse = 'INVALID_RESPONSE';

  /// Client: any other failure.
  static const unknown = 'UNKNOWN';

  /// Default code the server derives from an HTTP [statusCode].
  static String fromStatusCode(int? statusCode) => switch (statusCode) {
    400 => badRequest,
    401 => unauthorized,
    403 => forbidden,
    404 => notFound,
    409 => conflict,
    429 => tooManyRequests,
    final code? when code >= 500 => internalServerError,
    _ => unknown,
  };
}
