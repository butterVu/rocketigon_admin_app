import 'package:freezed_annotation/freezed_annotation.dart';

import 'auth_exception.dart';

part 'otp_dispatch.freezed.dart';

/// An OTP the server sent, or already sent and still valid.
@freezed
abstract class OtpDispatch with _$OtpDispatch {
  /// Creates an [OtpDispatch].
  const factory OtpDispatch({
    /// Time before another code may be requested.
    required Duration resendAfter,
  }) = _OtpDispatch;

  /// The previous code is still valid and a new one may be requested after
  /// [retryAfter], e.g. when the user goes back and continues again.
  ///
  /// Throws [error] again when [error] is not an early resend.
  factory OtpDispatch.fromEarlyResend(AuthException error) => switch (error) {
    AuthException(failure: AuthFailure.otpResendTooSoon, :final retryAfter?) =>
      OtpDispatch(resendAfter: retryAfter),
    _ => throw error,
  };
}
