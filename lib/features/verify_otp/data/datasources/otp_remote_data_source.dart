import '../../../../core/network/api_client.dart';
import '../../../auth/data/models/auth_session_model.dart';
import '../../../auth/data/models/otp_dispatch_model.dart';

/// Remote API for verifying a login on a new device.
abstract interface class OtpRemoteDataSource {
  /// `POST /auth/login/verify-device`.
  Future<AuthSessionModel> verifyDevice({
    required String challengeId,
    required String otp,
  });

  /// `POST /auth/login/resend-otp`.
  Future<OtpDispatchModel> resendDeviceOtp(String challengeId);
}

/// [OtpRemoteDataSource] calling the Rocketigo API.
class ApiOtpRemoteDataSource implements OtpRemoteDataSource {
  /// Creates an [ApiOtpRemoteDataSource].
  const ApiOtpRemoteDataSource({required this._client});

  final ApiClient _client;

  @override
  Future<AuthSessionModel> verifyDevice({
    required String challengeId,
    required String otp,
  }) => _client.post(
    '/auth/login/verify-device',
    body: {'challengeId': challengeId, 'otp': otp},
    skipAuth: true,
    decode: ApiDecoders.object(AuthSessionModel.fromJson),
  );

  @override
  Future<OtpDispatchModel> resendDeviceOtp(String challengeId) => _client.post(
    '/auth/login/resend-otp',
    body: {'challengeId': challengeId},
    skipAuth: true,
    decode: ApiDecoders.object(OtpDispatchModel.fromJson),
  );
}
