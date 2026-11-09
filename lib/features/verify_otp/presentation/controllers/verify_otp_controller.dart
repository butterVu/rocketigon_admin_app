import 'dart:async';
import 'dart:developer' as developer;

import 'package:dragon_design/dragon_design.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../app/translations/locale_keys.dart';
import '../../../../core/extensions/duration_format_extension.dart';
import '../../../auth/presentation/controllers/auth_error_message.dart';
import '../../domain/entities/otp_exception.dart';
import '../../domain/entities/verify_otp_arguments.dart';
import '../../domain/usecases/resend_otp_use_case.dart';
import '../../domain/usecases/verify_otp_use_case.dart';

/// Operation the OTP screen is currently running.
enum VerifyOtpStatus {
  /// Waiting for user input.
  idle,

  /// Checking the entered code.
  verifying,

  /// Requesting a new code.
  resending,
}

/// Drives the OTP verification screen.
class VerifyOtpController extends GetxController {
  /// Creates a [VerifyOtpController].
  VerifyOtpController({
    required this.arguments,
    required this._verifyOtpUseCase,
    required this._resendOtpUseCase,
  });

  /// Phone number, purpose and code length passed by the previous screen.
  final VerifyOtpArguments arguments;

  final VerifyOtpUseCase _verifyOtpUseCase;
  final ResendOtpUseCase _resendOtpUseCase;

  /// Holds the code typed into the OTP field.
  final codeController = TextEditingController();

  /// Current operation.
  final status = VerifyOtpStatus.idle.obs;

  /// Translated error of the last attempt, or `null`.
  final errorMessage = RxnString();

  /// Seconds left before the code can be resent.
  final resendSecondsLeft = 0.obs;

  Timer? _resendTimer;

  /// Whether the user may request a new code now.
  bool get canResend =>
      resendSecondsLeft.value == 0 && status.value == VerifyOtpStatus.idle;

  @override
  void onInit() {
    super.onInit();
    _startResendCountdown(arguments.resendAfter);
  }

  @override
  void onClose() {
    _resendTimer?.cancel();
    codeController.dispose();
    super.onClose();
  }

  /// Clears the previous error once the user edits the code.
  void onCodeChanged(String _) => errorMessage.value = null;

  /// Verifies the entered code and continues the flow of the purpose.
  Future<void> verify() async {
    if (status.value != VerifyOtpStatus.idle) return;
    status.value = VerifyOtpStatus.verifying;
    try {
      await _verifyOtpUseCase(arguments: arguments, code: codeController.text);
      Get.offAllNamed<void>(Routes.root);
    } on OtpException catch (error) {
      _handleFailure(error);
      codeController.clear();
    } finally {
      status.value = VerifyOtpStatus.idle;
    }
  }

  /// Sends a new code once the cooldown is over.
  Future<void> resend() async {
    if (!canResend) return;
    status.value = VerifyOtpStatus.resending;
    try {
      final dispatch = await _resendOtpUseCase(arguments);
      codeController.clear();
      errorMessage.value = null;
      _startResendCountdown(dispatch.resendAfter);
      Get.snackbar(
        LocaleKeys.commonSuccess.tr,
        LocaleKeys.authOtpSent.trParams({
          'phone': arguments.displayPhoneNumber,
        }),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColor.success,
        colorText: AppColor.surface,
      );
    } on OtpException catch (error) {
      _handleFailure(error);
    } finally {
      status.value = VerifyOtpStatus.idle;
    }
  }

  void _handleFailure(OtpException error) {
    developer.log(
      'Device OTP failed',
      name: 'rocketigo.verify_otp',
      error: error,
    );
    switch (error.failure) {
      case OtpFailure.sessionExpired:
        // The login challenge is gone: sign in again from the login screen.
        Get.back<void>();
        Get.snackbar(
          LocaleKeys.commonError.tr,
          LocaleKeys.verifyOtpSessionExpired.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColor.error,
          colorText: AppColor.surface,
        );
        return;
      case OtpFailure.resendTooSoon:
        _startResendCountdown(error.retryAfter ?? arguments.resendAfter);
      case OtpFailure.deliveryFailed:
        _startResendCountdown(Duration.zero);
      default:
        break;
    }
    errorMessage.value = _messageOf(error);
  }

  String _messageOf(OtpException error) {
    final retryAfter = (error.retryAfter ?? Duration.zero).toClockLabel();
    return switch (error.failure) {
      OtpFailure.invalidCode when error.remainingAttempts != null =>
        LocaleKeys.verifyOtpInvalidCodeRemaining.trParams({
          'count': '${error.remainingAttempts}',
        }),
      OtpFailure.invalidCode => LocaleKeys.verifyOtpInvalidCode.tr,
      OtpFailure.codeCancelled => LocaleKeys.verifyOtpCodeCancelled.tr,
      OtpFailure.expired => LocaleKeys.verifyOtpExpired.tr,
      OtpFailure.resendTooSoon => LocaleKeys.verifyOtpResendTooSoon.tr,
      OtpFailure.limitExceeded => LocaleKeys.verifyOtpLimitExceeded.trParams({
        'time': retryAfter,
      }),
      OtpFailure.deliveryFailed => LocaleKeys.verifyOtpDeliveryFailed.tr,
      OtpFailure.sessionExpired => LocaleKeys.verifyOtpSessionExpired.tr,
      OtpFailure.loginLocked => LocaleKeys.authLoginLocked.trParams({
        'time': retryAfter,
      }),
      OtpFailure.accountLocked => LocaleKeys.authAccountLocked.tr,
      OtpFailure.tooManyRequests => LocaleKeys.verifyOtpTooManyRequests.tr,
      OtpFailure.wrongApp => wrongAppMessage(error.accountRole),
      OtpFailure.network => LocaleKeys.commonNetworkError.tr,
      OtpFailure.unknown => LocaleKeys.commonUnexpectedError.tr,
    };
  }

  void _startResendCountdown(Duration cooldown) {
    _resendTimer?.cancel();
    resendSecondsLeft.value = cooldown.inSeconds;
    if (cooldown.inSeconds <= 0) return;
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      resendSecondsLeft.value--;
      if (resendSecondsLeft.value <= 0) timer.cancel();
    });
  }
}
