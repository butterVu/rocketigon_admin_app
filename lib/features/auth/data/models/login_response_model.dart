import 'package:freezed_annotation/freezed_annotation.dart';

import 'auth_session_model.dart';
import 'otp_dispatch_model.dart';

part 'login_response_model.freezed.dart';
part 'login_response_model.g.dart';

/// `nextStep` value of a login on a trusted device.
const loginStepAuthenticated = 'AUTHENTICATED';

/// `nextStep` value of a login on a device that needs OTP verification.
const loginStepDeviceVerification = 'DEVICE_VERIFICATION_REQUIRED';

/// JSON response of `POST /auth/login`.
@freezed
abstract class LoginResponseModel with _$LoginResponseModel {
  /// Creates a [LoginResponseModel].
  const factory LoginResponseModel({
    /// [loginStepAuthenticated] or [loginStepDeviceVerification].
    required String nextStep,

    /// Session, set when [nextStep] is [loginStepAuthenticated].
    AuthSessionModel? auth,

    /// Device verification id, set with [otp].
    String? challengeId,
    OtpDispatchModel? otp,
  }) = _LoginResponseModel;

  /// Parses a [LoginResponseModel] from [json].
  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);
}
