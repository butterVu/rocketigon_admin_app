import 'dart:async';
import 'dart:developer' as developer;

import '../../../../core/network/api_error_codes.dart';
import '../../../../core/network/api_exception.dart';
import '../../../../core/services/device_identity.dart';
import '../../../../core/services/token_storage.dart';
import '../../domain/entities/auth_exception.dart';
import '../../domain/entities/login_result.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/login_response_model.dart';

/// [AuthRepository] backed by an [AuthRemoteDataSource].
class AuthRepositoryImpl implements AuthRepository {
  /// Creates an [AuthRepositoryImpl].
  const AuthRepositoryImpl({
    required this._remoteDataSource,
    required this._tokenStorage,
    required this._deviceIdentity,
  });

  final AuthRemoteDataSource _remoteDataSource;
  final TokenStorage _tokenStorage;
  final DeviceIdentity _deviceIdentity;

  @override
  Future<LoginResult> login({
    required String phoneNumber,
    required String loginCode,
  }) => _guard('login', () async {
    final response = await _remoteDataSource.login(
      phone: phoneNumber,
      loginCode: loginCode,
      deviceId: await _deviceIdentity.deviceId(),
      deviceName: await _deviceIdentity.deviceName(),
    );
    return _toLoginResult(response);
  });

  @override
  Future<void> logout() async {
    final refreshToken = await _tokenStorage.readRefreshToken();
    await _tokenStorage.clear();
    if (refreshToken == null) return;
    // The server accepts expired tokens, so the result is not awaited and
    // signing out stays instant, even offline.
    unawaited(
      _remoteDataSource.logout(refreshToken).catchError((Object error) {
        developer.log('logout failed', name: 'rocketigo.auth', error: error);
      }),
    );
  }

  Future<LoginResult> _toLoginResult(LoginResponseModel response) async {
    switch (response) {
      case LoginResponseModel(
        nextStep: loginStepAuthenticated,
        auth: final auth?,
      ):
        await _tokenStorage.saveTokens(
          accessToken: auth.accessToken,
          refreshToken: auth.refreshToken,
        );
        return const LoginResult.authenticated();
      case LoginResponseModel(
        nextStep: loginStepDeviceVerification,
        challengeId: final challengeId?,
        otp: final otp?,
      ):
        return LoginResult.deviceVerificationRequired(
          challengeId: challengeId,
          otp: otp.toEntity(),
        );
      default:
        throw AuthException(
          AuthFailure.unknown,
          detail: 'Unexpected login step ${response.nextStep}',
        );
    }
  }

  /// Logs failures and converts them into [AuthException].
  Future<T> _guard<T>(String operation, Future<T> Function() action) async {
    try {
      return await action();
    } on AuthException {
      rethrow;
    } on ApiException catch (error) {
      developer.log('$operation failed', name: 'rocketigo.auth', error: error);
      throw AuthException(
        _failureOf(error),
        retryAfter: error.retryDelay,
        accountRole: error.accountRole,
        detail: error.toString(),
      );
    } catch (error, stackTrace) {
      developer.log(
        '$operation failed',
        name: 'rocketigo.auth',
        level: 1000,
        error: error,
        stackTrace: stackTrace,
      );
      throw AuthException(AuthFailure.unknown, detail: error.toString());
    }
  }

  static AuthFailure _failureOf(ApiException error) => switch (error.code) {
    ApiErrorCodes.authInvalidCredentials => AuthFailure.invalidCredentials,
    ApiErrorCodes.authLoginLocked => AuthFailure.loginLocked,
    ApiErrorCodes.accountLocked => AuthFailure.accountLocked,
    ApiErrorCodes.otpResendTooSoon => AuthFailure.otpResendTooSoon,
    ApiErrorCodes.otpLimitExceeded => AuthFailure.otpLimitExceeded,
    ApiErrorCodes.otpDeliveryFailed => AuthFailure.otpDeliveryFailed,
    ApiErrorCodes.tooManyRequests => AuthFailure.tooManyRequests,
    ApiErrorCodes.authWrongApp => AuthFailure.wrongApp,
    ApiErrorCodes.validationFailed
        when error.fieldErrors.any((field) => field.field == 'phone') =>
      AuthFailure.invalidPhoneNumber,
    _ when error.isServiceUnavailable => AuthFailure.serviceUnavailable,
    _ when error.isConnectivityError => AuthFailure.network,
    _ => AuthFailure.unknown,
  };
}
