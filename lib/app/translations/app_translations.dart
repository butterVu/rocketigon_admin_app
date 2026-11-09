import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'locale_keys.dart';

/// A language the user can switch the app to.
enum AppLanguage {
  /// Vietnamese.
  vietnamese(Locale('vi', 'VN'), 'Việt Nam', 'VI'),

  /// English.
  english(Locale('en', 'US'), 'English', 'EN');

  const AppLanguage(this.locale, this.displayName, this.code);

  /// Locale applied through `Get.updateLocale`.
  final Locale locale;

  /// Human readable name shown in the language picker.
  final String displayName;

  /// Short code shown next to [displayName].
  final String code;

  /// Language matching [locale], falling back to [vietnamese].
  static AppLanguage fromLocale(Locale? locale) => values.firstWhere(
    (language) => language.locale.languageCode == locale?.languageCode,
    orElse: () => vietnamese,
  );
}

/// All translated strings of the app, registered in `GetMaterialApp`.
class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'vi_VN': {
      LocaleKeys.authHeadline: 'Rocketigo Admin',
      LocaleKeys.authSubtitle: 'Đăng nhập để quản lý vận hành',
      LocaleKeys.authLoginCodeHint: 'Nhập mã đăng nhập (6 số)',
      LocaleKeys.authLogin: 'Đăng nhập',
      LocaleKeys.authPhoneHint: 'Nhập số điện thoại',
      LocaleKeys.authOtpSent: 'Mã OTP đã được gửi tới @phone',
      LocaleKeys.commonSuccess: 'Thành công',
      LocaleKeys.commonError: 'Lỗi',
      LocaleKeys.commonUnexpectedError: 'Đã có lỗi xảy ra, vui lòng thử lại',
      LocaleKeys.verifyOtpTitle: 'Mã xác thực OTP',
      LocaleKeys.verifyOtpInstruction:
          'Nhập mã gồm @length chữ số mà bạn đã nhận được qua số điện thoại',
      LocaleKeys.verifyOtpResend: 'Gửi lại mã',
      LocaleKeys.verifyOtpResendCountdown: 'Gửi lại mã (@seconds)',
      LocaleKeys.verifyOtpInvalidCode: 'Mã OTP không đúng, vui lòng thử lại',
      LocaleKeys.verifyOtpExpired: 'Mã OTP đã hết hạn, vui lòng gửi lại mã',
      LocaleKeys.verifyOtpTooManyRequests:
          'Bạn đã thử quá nhiều lần, vui lòng thử lại sau',
      LocaleKeys.rootTabAccount: 'Tài khoản',
      LocaleKeys.commonConfirm: 'Xác nhận',
      LocaleKeys.commonClose: 'Đóng',
      LocaleKeys.accountLogout: 'Đăng xuất',
      LocaleKeys.accountLogoutConfirm: 'Bạn có chắc chắn muốn đăng xuất?',
      LocaleKeys.authInvalidPhoneNumber: 'Số điện thoại không hợp lệ',
      LocaleKeys.authWrongApp:
          'Số điện thoại này thuộc app @app. Vui lòng dùng đúng app.',
      LocaleKeys.authWrongAppUnknown:
          'Số điện thoại này thuộc app khác. Vui lòng dùng đúng app.',
      LocaleKeys.authRoleDriver: 'Tài xế',
      LocaleKeys.authRoleMerchant: 'Chủ quán',
      LocaleKeys.authRoleAdmin: 'Quản trị',
      LocaleKeys.authServiceUnavailable: 'Hệ thống đang bận, vui lòng thử lại',
      LocaleKeys.authLoginLocked:
          'Bạn đã nhập sai quá nhiều lần. Vui lòng thử lại sau @time hoặc đặt lại mã mở khoá.',
      LocaleKeys.authAccountLocked:
          'Tài khoản đã bị khoá. Vui lòng liên hệ bộ phận hỗ trợ.',
      LocaleKeys.commonNetworkError: 'Không có kết nối mạng, vui lòng thử lại',
      LocaleKeys.verifyOtpInvalidCodeRemaining:
          'Mã OTP không đúng, bạn còn @count lần thử',
      LocaleKeys.verifyOtpCodeCancelled:
          'Mã OTP đã bị huỷ do nhập sai nhiều lần, vui lòng gửi lại mã',
      LocaleKeys.verifyOtpResendTooSoon:
          'Vui lòng chờ hết thời gian đếm ngược để gửi lại mã',
      LocaleKeys.verifyOtpLimitExceeded:
          'Số điện thoại đã nhận quá nhiều mã. Vui lòng thử lại sau @time',
      LocaleKeys.verifyOtpDeliveryFailed:
          'Không gửi được tin nhắn OTP, vui lòng gửi lại mã',
      LocaleKeys.verifyOtpSessionExpired:
          'Phiên xác minh đã hết hạn, vui lòng đăng nhập lại',
      LocaleKeys.loginCodeInvalid: 'Số điện thoại hoặc mã mở khoá không đúng',
    },
    'en_US': {
      LocaleKeys.authHeadline: 'Rocketigo Admin',
      LocaleKeys.authSubtitle: 'Log in to manage operations',
      LocaleKeys.authLoginCodeHint: 'Enter login code (6 digits)',
      LocaleKeys.authLogin: 'Log in',
      LocaleKeys.authPhoneHint: 'Enter phone number',
      LocaleKeys.authOtpSent: 'An OTP has been sent to @phone',
      LocaleKeys.commonSuccess: 'Success',
      LocaleKeys.commonError: 'Error',
      LocaleKeys.commonUnexpectedError: 'Something went wrong, please retry',
      LocaleKeys.verifyOtpTitle: 'OTP verification',
      LocaleKeys.verifyOtpInstruction:
          'Enter the @length-digit code we sent to your phone number',
      LocaleKeys.verifyOtpResend: 'Resend code',
      LocaleKeys.verifyOtpResendCountdown: 'Resend code (@seconds)',
      LocaleKeys.verifyOtpInvalidCode: 'Incorrect code, please try again',
      LocaleKeys.verifyOtpExpired: 'The code has expired, please resend it',
      LocaleKeys.verifyOtpTooManyRequests:
          'Too many attempts, please try again later',
      LocaleKeys.rootTabAccount: 'Account',
      LocaleKeys.commonConfirm: 'Confirm',
      LocaleKeys.commonClose: 'Close',
      LocaleKeys.accountLogout: 'Log out',
      LocaleKeys.accountLogoutConfirm: 'Are you sure you want to log out?',
      LocaleKeys.authInvalidPhoneNumber: 'Invalid phone number',
      LocaleKeys.authWrongApp:
          'This phone number belongs to the @app app. Please use the right app.',
      LocaleKeys.authWrongAppUnknown:
          'This phone number belongs to another app. Please use the right app.',
      LocaleKeys.authRoleDriver: 'Driver',
      LocaleKeys.authRoleMerchant: 'Merchant',
      LocaleKeys.authRoleAdmin: 'Admin',
      LocaleKeys.authServiceUnavailable: 'The system is busy, please try again',
      LocaleKeys.authLoginLocked:
          'Too many failed attempts. Try again in @time or reset your passcode.',
      LocaleKeys.authAccountLocked:
          'Your account is locked. Please contact support.',
      LocaleKeys.commonNetworkError: 'No internet connection, please retry',
      LocaleKeys.verifyOtpInvalidCodeRemaining:
          'Incorrect code, @count attempts left',
      LocaleKeys.verifyOtpCodeCancelled:
          'The code was cancelled after too many attempts, please resend it',
      LocaleKeys.verifyOtpResendTooSoon:
          'Please wait for the countdown before resending',
      LocaleKeys.verifyOtpLimitExceeded:
          'Too many codes were sent to this number. Try again in @time',
      LocaleKeys.verifyOtpDeliveryFailed:
          'Could not send the SMS, please resend the code',
      LocaleKeys.verifyOtpSessionExpired:
          'The verification expired, please sign in again',
      LocaleKeys.loginCodeInvalid: 'Incorrect phone number or passcode',
    },
  };
}
