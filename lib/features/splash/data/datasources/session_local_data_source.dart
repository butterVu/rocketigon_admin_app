import '../../../../core/services/token_storage.dart';

/// Reads the session token persisted on the device.
abstract interface class SessionLocalDataSource {
  /// Stored session token, or `null` when signed out.
  Future<String?> readToken();
}

/// [SessionLocalDataSource] reading the refresh token, which outlives the
/// access token: an expired access token is refreshed on the first request.
class TokenSessionLocalDataSource implements SessionLocalDataSource {
  /// Creates a [TokenSessionLocalDataSource].
  const TokenSessionLocalDataSource({required this._tokenStorage});

  final TokenStorage _tokenStorage;

  @override
  Future<String?> readToken() => _tokenStorage.readRefreshToken();
}
