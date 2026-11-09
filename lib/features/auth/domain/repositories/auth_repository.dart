import '../entities/login_result.dart';

/// Sign-in operations of the CMS account.
abstract interface class AuthRepository {
  /// Signs [phoneNumber] in with [loginCode] and stores the tokens when the
  /// device is already trusted.
  ///
  /// Throws an `AuthException` when the sign-in fails.
  Future<LoginResult> login({
    required String phoneNumber,
    required String loginCode,
  });

  /// Revokes the stored refresh token and clears the session.
  Future<void> logout();
}
