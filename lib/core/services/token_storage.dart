import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Stores the token pair of the signed-in session.
abstract interface class TokenStorage {
  /// Stored access token, or `null` when signed out.
  Future<String?> readAccessToken();

  /// Stored refresh token, or `null` when signed out.
  Future<String?> readRefreshToken();

  /// Persists both tokens after sign-in or refresh.
  ///
  /// The refresh token is written first: the server signs the user out
  /// everywhere when an already rotated refresh token is sent again.
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  });

  /// Removes both tokens on sign-out.
  Future<void> clear();
}

/// [TokenStorage] in the iOS Keychain or Android Keystore.
class SecureTokenStorage implements TokenStorage {
  /// Creates a [SecureTokenStorage] writing to [storage].
  const SecureTokenStorage(this._storage);

  final FlutterSecureStorage _storage;

  static const _accessTokenKey = 'auth.access_token';
  static const _refreshTokenKey = 'auth.refresh_token';

  @override
  Future<String?> readAccessToken() => _storage.read(key: _accessTokenKey);

  @override
  Future<String?> readRefreshToken() => _storage.read(key: _refreshTokenKey);

  @override
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _storage.write(key: _refreshTokenKey, value: refreshToken);
    await _storage.write(key: _accessTokenKey, value: accessToken);
  }

  @override
  Future<void> clear() async {
    await _storage.delete(key: _refreshTokenKey);
    await _storage.delete(key: _accessTokenKey);
  }
}
