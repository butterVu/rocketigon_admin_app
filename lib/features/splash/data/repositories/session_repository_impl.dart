import 'dart:developer' as developer;

import '../../domain/repositories/session_repository.dart';
import '../datasources/session_local_data_source.dart';

/// [SessionRepository] backed by a [SessionLocalDataSource].
class SessionRepositoryImpl implements SessionRepository {
  /// Creates a [SessionRepositoryImpl].
  const SessionRepositoryImpl({required this._localDataSource});

  final SessionLocalDataSource _localDataSource;

  @override
  Future<bool> hasActiveSession() async {
    try {
      final token = await _localDataSource.readToken();
      return token != null && token.isNotEmpty;
    } catch (error, stackTrace) {
      // An unreadable session is treated as signed out.
      developer.log(
        'Failed to read session',
        name: 'rocket.splash',
        level: 1000,
        error: error,
        stackTrace: stackTrace,
      );
      return false;
    }
  }
}
