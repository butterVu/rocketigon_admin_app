import 'package:get/get.dart';

import '../../../../app/translations/locale_keys.dart';
import '../../../../core/extensions/duration_format_extension.dart';
import '../../domain/entities/auth_exception.dart';

/// Translation key of the name of the app of [role], or `null` when the
/// role is missing or unknown.
String? accountRoleKey(String? role) => switch (role) {
  'driver' => LocaleKeys.authRoleDriver,
  'merchant' => LocaleKeys.authRoleMerchant,
  'admin' => LocaleKeys.authRoleAdmin,
  _ => null,
};

/// Translated message telling that the account belongs to the app of
/// [role].
String wrongAppMessage(String? role) => switch (accountRoleKey(role)) {
  final key? => LocaleKeys.authWrongApp.trParams({'app': key.tr}),
  null => LocaleKeys.authWrongAppUnknown.tr,
};

/// Translated message describing [error] to the user.
String authErrorMessage(AuthException error) {
  final retryAfter = (error.retryAfter ?? Duration.zero).toClockLabel();
  return switch (error.failure) {
    AuthFailure.invalidPhoneNumber => LocaleKeys.authInvalidPhoneNumber.tr,
    AuthFailure.invalidCredentials => LocaleKeys.loginCodeInvalid.tr,
    AuthFailure.loginLocked => LocaleKeys.authLoginLocked.trParams({
      'time': retryAfter,
    }),
    AuthFailure.accountLocked => LocaleKeys.authAccountLocked.tr,
    AuthFailure.otpLimitExceeded => LocaleKeys.verifyOtpLimitExceeded.trParams({
      'time': retryAfter,
    }),
    AuthFailure.otpDeliveryFailed => LocaleKeys.verifyOtpDeliveryFailed.tr,
    AuthFailure.otpResendTooSoon ||
    AuthFailure.tooManyRequests => LocaleKeys.verifyOtpTooManyRequests.tr,
    AuthFailure.wrongApp => wrongAppMessage(error.accountRole),
    AuthFailure.serviceUnavailable => LocaleKeys.authServiceUnavailable.tr,
    AuthFailure.network => LocaleKeys.commonNetworkError.tr,
    AuthFailure.unknown => LocaleKeys.commonUnexpectedError.tr,
  };
}
