import 'package:freezed_annotation/freezed_annotation.dart';

import 'otp_dispatch.dart';

part 'login_result.freezed.dart';

/// Outcome of a correct login code.
@freezed
sealed class LoginResult with _$LoginResult {
  /// Trusted device: the session is saved and the user is signed in.
  const factory LoginResult.authenticated() = LoginAuthenticated;

  /// Unknown device: an OTP was sent and must be verified with
  /// [challengeId] before signing in.
  const factory LoginResult.deviceVerificationRequired({
    required String challengeId,
    required OtpDispatch otp,
  }) = LoginDeviceVerificationRequired;
}
