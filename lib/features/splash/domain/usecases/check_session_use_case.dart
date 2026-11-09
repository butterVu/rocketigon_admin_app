import '../repositories/session_repository.dart';

/// Decides whether the user is still signed in when the app starts.
class CheckSessionUseCase {
  /// Creates a [CheckSessionUseCase].
  const CheckSessionUseCase({required this._repository});

  final SessionRepository _repository;

  /// Returns `true` when a valid session exists.
  Future<bool> call() => _repository.hasActiveSession();
}
