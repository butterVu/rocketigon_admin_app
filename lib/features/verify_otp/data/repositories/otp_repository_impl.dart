import 'dart:developer' as developer;

import '../../../../core/network/api_error_codes.dart';
import '../../../../core/network/api_exception.dart';
import '../../../../core/services/token_storage.dart';
import '../../../auth/domain/entities/otp_dispatch.dart';
import '../../domain/entities/otp_exception.dart';
import '../../domain/repositories/otp_repository.dart';
import '../datasources/otp_remote_data_source.dart';

/// [OtpRepository] backed by an [OtpRemoteDataSource].
class OtpRepositoryImpl implements OtpRepository {
  /// Creates an [OtpRepositoryImpl].
  const OtpRepositoryImpl({
    required this._remoteDataSource,
    required this._tokenStorage,
  });

  final OtpRemoteDataSource _remoteDataSource;
  final TokenStorage _tokenStorage;

  @override
  Future<void> verifyOtp({required String challengeId, required String code}) =>
      _guard('verifyOtp', () async {
        final session = await _remoteDataSource.verifyDevice(
          challengeId: challengeId,
          otp: code,
        );
        await _tokenStorage.saveTokens(
          accessToken: session.accessToken,
          refreshToken: session.refreshToken,
        );
      });

  @override
  Future<OtpDispatch> resendOtp({required String challengeId}) =>
      _guard('resendOtp', () async {
        final dispatch = await _remoteDataSource.resendDeviceOtp(challengeId);
        return dispatch.toEntity();
      });

  Future<T> _guard<T>(String operation, Future<T> Function() action) async {
    try {
      return await action();
    } on OtpException {
      rethrow;
    } on ApiException catch (error) {
      developer.log('$operation failed', name: 'rocketigo.otp', error: error);
      throw OtpException(
        _failureOf(error),
        retryAfter: error.retryDelay,
        remainingAttempts: error.remainingAttempts,
        accountRole: error.accountRole,
        detail: error.toString(),
      );
    } catch (error, stackTrace) {
      developer.log(
        '$operation failed',
        name: 'rocketigo.otp',
        level: 1000,
        error: error,
        stackTrace: stackTrace,
      );
      throw OtpException(OtpFailure.unknown, detail: error.toString());
    }
  }

  static OtpFailure _failureOf(ApiException error) => switch (error.code) {
    ApiErrorCodes.otpInvalid ||
    ApiErrorCodes.validationFailed => OtpFailure.invalidCode,
    ApiErrorCodes.otpTooManyAttempts => OtpFailure.codeCancelled,
    ApiErrorCodes.otpExpired => OtpFailure.expired,
    ApiErrorCodes.otpResendTooSoon => OtpFailure.resendTooSoon,
    ApiErrorCodes.otpLimitExceeded => OtpFailure.limitExceeded,
    ApiErrorCodes.otpDeliveryFailed => OtpFailure.deliveryFailed,
    ApiErrorCodes.loginChallengeInvalid => OtpFailure.sessionExpired,
    ApiErrorCodes.authLoginLocked => OtpFailure.loginLocked,
    ApiErrorCodes.accountLocked => OtpFailure.accountLocked,
    ApiErrorCodes.tooManyRequests => OtpFailure.tooManyRequests,
    ApiErrorCodes.authWrongApp => OtpFailure.wrongApp,
    _ when error.isConnectivityError => OtpFailure.network,
    _ => OtpFailure.unknown,
  };
}
