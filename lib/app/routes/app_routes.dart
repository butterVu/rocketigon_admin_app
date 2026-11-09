/// Named route paths used throughout the app.
abstract final class Routes {
  /// Home screen shown after the user is signed in.
  static const root = '/';

  /// Launch screen deciding between home and sign-in.
  static const splash = '/splash';

  /// Login screen with phone number and login code.
  static const login = '/login';

  /// Device verification screen, opened with `VerifyOtpArguments`.
  static const verifyOtp = '/verify-otp';
}
