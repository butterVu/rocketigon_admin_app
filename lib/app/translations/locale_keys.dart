/// Translation keys used with GetX `.tr`, centralized to avoid typos.
abstract final class LocaleKeys {
  /// Headline shown on the authentication screen.
  static const authHeadline = 'auth_headline';

  /// Supporting text below the authentication headline.
  static const authSubtitle = 'auth_subtitle';

  /// Hint of the phone number input.
  static const authPhoneHint = 'auth_phone_hint';

  /// Message shown after an OTP was sent. Uses the `@phone` parameter.
  static const authOtpSent = 'auth_otp_sent';

  /// Title of the success snackbar.
  static const commonSuccess = 'common_success';

  /// Title of the error snackbar.
  static const commonError = 'common_error';

  /// Fallback message for unexpected errors.
  static const commonUnexpectedError = 'common_unexpected_error';

  /// Title of the OTP verification screen.
  static const verifyOtpTitle = 'verify_otp_title';

  /// Instruction above the phone number. Uses the `@length` parameter.
  static const verifyOtpInstruction = 'verify_otp_instruction';

  /// Label of the resend button once it is enabled.
  static const verifyOtpResend = 'verify_otp_resend';

  /// Label of the resend button during the cooldown. Uses `@seconds`.
  static const verifyOtpResendCountdown = 'verify_otp_resend_countdown';

  /// Error shown when the entered code is wrong.
  static const verifyOtpInvalidCode = 'verify_otp_invalid_code';

  /// Error shown when the code expired.
  static const verifyOtpExpired = 'verify_otp_expired';

  /// Error shown after too many attempts.
  static const verifyOtpTooManyRequests = 'verify_otp_too_many_requests';

  /// Label of the account tab.
  static const rootTabAccount = 'root_tab_account';

  /// Label of the food management tab.
  static const rootTabFood = 'root_tab_food';

  /// Label of the car rental management tab.
  static const rootTabCarRental = 'root_tab_car_rental';

  /// Label of the finance management tab.
  static const rootTabFinance = 'root_tab_finance';

  /// Label of buttons closing a dialog or sheet.
  static const commonClose = 'common_close';

  /// Account menu entry signing the user out.
  static const accountLogout = 'account_logout';

  /// Question of the sign-out confirmation dialog.
  static const accountLogoutConfirm = 'account_logout_confirm';

  /// Label of confirm buttons.
  static const commonConfirm = 'common_confirm';

  /// Error shown when the phone number is invalid.
  static const authInvalidPhoneNumber = 'auth_invalid_phone_number';

  /// Account of another app (@app).
  static const authWrongApp = 'auth_wrong_app';

  /// Account of another app, unknown which.
  static const authWrongAppUnknown = 'auth_wrong_app_unknown';

  /// Name of the driver app.
  static const authRoleDriver = 'auth_role_driver';

  /// Name of the merchant app.
  static const authRoleMerchant = 'auth_role_merchant';

  /// Name of the admin app.
  static const authRoleAdmin = 'auth_role_admin';

  /// The server is busy.
  static const authServiceUnavailable = 'auth_service_unavailable';

  /// Error shown while sign-in is locked. Uses `@time`.
  static const authLoginLocked = 'auth_login_locked';

  /// Error shown when an administrator locked the account.
  static const authAccountLocked = 'auth_account_locked';

  /// Error shown when the server cannot be reached.
  static const commonNetworkError = 'common_network_error';

  /// Error shown when the code is wrong. Uses `@count`.
  static const verifyOtpInvalidCodeRemaining =
      'verify_otp_invalid_code_remaining';

  /// Error shown when the code was cancelled after too many attempts.
  static const verifyOtpCodeCancelled = 'verify_otp_code_cancelled';

  /// Error shown when a code is resent too early.
  static const verifyOtpResendTooSoon = 'verify_otp_resend_too_soon';

  /// Error shown when too many codes were sent. Uses `@time`.
  static const verifyOtpLimitExceeded = 'verify_otp_limit_exceeded';

  /// Error shown when the SMS could not be sent.
  static const verifyOtpDeliveryFailed = 'verify_otp_delivery_failed';

  /// Error shown when the device verification expired.
  static const verifyOtpSessionExpired = 'verify_otp_session_expired';

  /// Error shown when the phone number or login code is wrong.
  static const loginCodeInvalid = 'login_code_invalid';

  /// Hint of the login code input.
  static const authLoginCodeHint = 'auth_login_code_hint';

  /// Label of the sign-in button.
  static const authLogin = 'auth_login';
}
