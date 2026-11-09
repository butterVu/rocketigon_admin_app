import 'dart:async';
import 'dart:developer' as developer;

import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../app/translations/locale_keys.dart';
import '../../../verify_otp/domain/entities/verify_otp_arguments.dart';
import '../../domain/entities/auth_exception.dart';
import '../../domain/entities/login_result.dart';
import '../../domain/entities/phone_number.dart';
import '../../domain/usecases/login_use_case.dart';
import 'auth_error_message.dart';

/// Drives the login screen with a phone number and a login code.
class LoginController extends GetxController {
  /// Creates a [LoginController].
  LoginController({required this._loginUseCase});

  final LoginUseCase _loginUseCase;

  /// Phone number typed by the user.
  final phone = ''.obs;

  /// Login code typed by the user.
  final loginCode = ''.obs;

  /// Whether the login code is shown instead of hidden.
  final isCodeVisible = false.obs;

  /// Whether a sign-in request is running.
  final isLoading = false.obs;

  /// Error shown below the fields, or `null`.
  final errorMessage = RxnString();

  /// Seconds left before a locked account may try again.
  final lockSecondsLeft = 0.obs;

  Timer? _lockTimer;

  /// Whether the typed values can be submitted.
  bool get canSubmit =>
      !isLoading.value &&
      lockSecondsLeft.value == 0 &&
      LoginUseCase.isValidInput(phone.value, loginCode.value);

  @override
  void onClose() {
    _lockTimer?.cancel();
    super.onClose();
  }

  /// Updates the typed phone number.
  void updatePhone(String value) {
    phone.value = value;
    errorMessage.value = null;
  }

  /// Updates the typed login code.
  void updateLoginCode(String value) {
    loginCode.value = value;
    errorMessage.value = null;
  }

  /// Shows or hides the login code.
  void toggleCodeVisibility() => isCodeVisible.toggle();

  /// Signs in, then opens the root screen or the device verification.
  Future<void> submit() async {
    if (!canSubmit) return;
    isLoading.value = true;
    errorMessage.value = null;
    try {
      final result = await _loginUseCase(
        phone: phone.value,
        loginCode: loginCode.value,
      );
      _continueWith(result);
    } on AuthException catch (error) {
      developer.log('Login failed', name: 'rocketigo.auth', error: error);
      _showFailure(error);
    } catch (error, stackTrace) {
      developer.log(
        'Login failed',
        name: 'rocketigo.auth',
        level: 1000,
        error: error,
        stackTrace: stackTrace,
      );
      errorMessage.value = LocaleKeys.commonUnexpectedError.tr;
    } finally {
      isLoading.value = false;
    }
  }

  void _continueWith(LoginResult result) => switch (result) {
    LoginAuthenticated() => Get.offAllNamed<void>(Routes.root),
    LoginDeviceVerificationRequired(:final challengeId, :final otp) =>
      Get.toNamed<void>(
        Routes.verifyOtp,
        arguments: VerifyOtpArguments(
          // Already validated by the use case, so parsing cannot fail.
          phoneNumber: PhoneNumber.tryParseVietnam(phone.value)!,
          challengeId: challengeId,
          resendAfter: otp.resendAfter,
        ),
      ),
  };

  void _showFailure(AuthException error) {
    errorMessage.value = authErrorMessage(error);
    final retryAfter = error.retryAfter;
    if (error.failure == AuthFailure.loginLocked && retryAfter != null) {
      _startLockCountdown(retryAfter);
    }
  }

  void _startLockCountdown(Duration duration) {
    _lockTimer?.cancel();
    lockSecondsLeft.value = duration.inSeconds;
    _lockTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      lockSecondsLeft.value--;
      if (lockSecondsLeft.value <= 0) {
        timer.cancel();
        errorMessage.value = null;
      }
    });
  }
}
