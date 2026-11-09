import '../../../auth/domain/entities/otp_dispatch.dart';

/// Device verification of a login on a new device.
abstract interface class OtpRepository {
  /// Verifies [code] for the login [challengeId] and stores the tokens.
  ///
  /// Throws an `OtpException` when the code is rejected.
  Future<void> verifyOtp({required String challengeId, required String code});

  /// Asks the server to send a new code for [challengeId].
  Future<OtpDispatch> resendOtp({required String challengeId});
}
