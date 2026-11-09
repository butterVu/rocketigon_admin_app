import '../../../auth/domain/entities/otp_dispatch.dart';
import '../entities/verify_otp_arguments.dart';
import '../repositories/otp_repository.dart';

/// Asks for a new OTP of a login on a new device.
class ResendOtpUseCase {
  /// Creates a [ResendOtpUseCase].
  const ResendOtpUseCase({required this._repository});

  final OtpRepository _repository;

  /// Requests a new code for [arguments].
  Future<OtpDispatch> call(VerifyOtpArguments arguments) =>
      _repository.resendOtp(challengeId: arguments.challengeId);
}
