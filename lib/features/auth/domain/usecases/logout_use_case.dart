import '../repositories/auth_repository.dart';

/// Signs the user out of this device.
class LogoutUseCase {
  /// Creates a [LogoutUseCase].
  const LogoutUseCase({required this._repository});

  final AuthRepository _repository;

  /// Clears the session; never fails.
  Future<void> call() => _repository.logout();
}
