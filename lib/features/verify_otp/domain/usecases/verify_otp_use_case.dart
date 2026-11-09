import '../entities/otp_exception.dart';
import '../entities/verify_otp_arguments.dart';
import '../repositories/otp_repository.dart';

/// Verifies the OTP of a login on a new device.
class VerifyOtpUseCase {
  /// Creates a [VerifyOtpUseCase].
  const VerifyOtpUseCase({required this._repository});

  final OtpRepository _repository;

  /// Verifies [code] for [arguments].
  ///
  /// Throws an [OtpException] when the code is malformed or rejected.
  Future<void> call({
    required VerifyOtpArguments arguments,
    required String code,
  }) {
    if (!RegExp('^\\d{${arguments.codeLength}}\$').hasMatch(code)) {
      throw OtpException(OtpFailure.invalidCode, detail: 'Malformed "$code"');
    }
    return _repository.verifyOtp(
      challengeId: arguments.challengeId,
      code: code,
    );
  }
}
