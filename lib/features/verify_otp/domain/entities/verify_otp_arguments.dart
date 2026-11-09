import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../auth/domain/entities/phone_number.dart';

part 'verify_otp_arguments.freezed.dart';

/// Route arguments required to open the device verification screen.
@freezed
abstract class VerifyOtpArguments with _$VerifyOtpArguments {
  const VerifyOtpArguments._();

  /// Creates [VerifyOtpArguments].
  const factory VerifyOtpArguments({
    required PhoneNumber phoneNumber,

    /// Login challenge returned by the server for the new device.
    required String challengeId,

    /// Waiting time before the code may be resent, from the server.
    @Default(Duration(seconds: 60)) Duration resendAfter,
    @Default(4) int codeLength,
  }) = _VerifyOtpArguments;

  /// Phone number grouped for display, e.g. `+84 983 975 038`.
  String get displayPhoneNumber => phoneNumber.display;
}
