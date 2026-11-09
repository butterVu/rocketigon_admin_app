import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/otp_dispatch.dart';

part 'otp_dispatch_model.freezed.dart';
part 'otp_dispatch_model.g.dart';

/// JSON returned by every endpoint that sends an OTP.
@freezed
abstract class OtpDispatchModel with _$OtpDispatchModel {
  const OtpDispatchModel._();

  /// Creates an [OtpDispatchModel].
  const factory OtpDispatchModel({required int resendAfterSeconds}) =
      _OtpDispatchModel;

  /// Parses an [OtpDispatchModel] from [json].
  factory OtpDispatchModel.fromJson(Map<String, dynamic> json) =>
      _$OtpDispatchModelFromJson(json);

  /// Converts this model to a domain [OtpDispatch].
  OtpDispatch toEntity() =>
      OtpDispatch(resendAfter: Duration(seconds: resendAfterSeconds));
}
