import '../../../../core/constants/app_constants.dart';
import '../../../../core/network/api_client.dart';
import '../models/login_response_model.dart';

/// Remote API for phone sign-in.
abstract interface class AuthRemoteDataSource {
  /// `POST /auth/login`.
  Future<LoginResponseModel> login({
    required String phone,
    required String loginCode,
    required String deviceId,
    String? deviceName,
  });

  /// `POST /auth/logout`, revoking [refreshToken].
  Future<void> logout(String refreshToken);
}

/// [AuthRemoteDataSource] calling the Rocketigo API.
class ApiAuthRemoteDataSource implements AuthRemoteDataSource {
  /// Creates an [ApiAuthRemoteDataSource].
  const ApiAuthRemoteDataSource({required this._client});

  final ApiClient _client;

  @override
  Future<LoginResponseModel> login({
    required String phone,
    required String loginCode,
    required String deviceId,
    String? deviceName,
  }) => _client.post(
    '/auth/login',
    body: {
      'phone': phone,
      'loginCode': loginCode,
      'app': AppConstants.appRole,
      'deviceId': deviceId,
      'deviceName': ?deviceName,
    },
    skipAuth: true,
    decode: ApiDecoders.object(LoginResponseModel.fromJson),
  );

  @override
  Future<void> logout(String refreshToken) => _client.send(
    ApiMethod.post,
    '/auth/logout',
    body: {'refreshToken': refreshToken},
    skipAuth: true,
  );
}
