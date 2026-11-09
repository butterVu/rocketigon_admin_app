import '../entities/auth_exception.dart';
import '../entities/login_result.dart';
import '../entities/phone_number.dart';
import '../repositories/auth_repository.dart';

/// Signs a CMS account in with its phone number and login code.
class LoginUseCase {
  /// Creates a [LoginUseCase].
  const LoginUseCase({required this._repository});

  final AuthRepository _repository;

  /// Number of digits of a login code.
  static const codeLength = 6;

  /// Whether [phone] and [loginCode] have a valid format.
  static bool isValidInput(String phone, String loginCode) =>
      PhoneNumber.tryParseVietnam(phone) != null && _isValidCode(loginCode);

  /// Signs in with the national [phone] number typed by the user.
  ///
  /// Throws an [AuthException] when the input is malformed or rejected.
  Future<LoginResult> call({required String phone, required String loginCode}) {
    final phoneNumber = PhoneNumber.tryParseVietnam(phone);
    if (phoneNumber == null) {
      throw const AuthException(AuthFailure.invalidPhoneNumber);
    }
    if (!_isValidCode(loginCode)) {
      throw const AuthException(AuthFailure.invalidCredentials);
    }
    return _repository.login(
      phoneNumber: phoneNumber.e164,
      loginCode: loginCode,
    );
  }

  static bool _isValidCode(String code) =>
      code.length == codeLength && RegExp(r'^\d+$').hasMatch(code);
}
