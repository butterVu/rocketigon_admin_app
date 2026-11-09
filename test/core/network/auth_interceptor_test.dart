import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rocketigo_admin/core/network/api_error_codes.dart';
import 'package:rocketigo_admin/core/network/interceptors/auth_interceptor.dart';
import 'package:rocketigo_admin/core/services/token_storage.dart';

import '../../helpers/recording_http_adapter.dart';

class _MemoryTokenStorage implements TokenStorage {
  String? accessToken = 'old-access';
  String? refreshToken = 'old-refresh';

  @override
  Future<String?> readAccessToken() async => accessToken;

  @override
  Future<String?> readRefreshToken() async => refreshToken;

  @override
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    this.accessToken = accessToken;
    this.refreshToken = refreshToken;
  }

  @override
  Future<void> clear() async {
    accessToken = null;
    refreshToken = null;
  }
}

void main() {
  late _MemoryTokenStorage storage;
  var sessionExpired = false;

  Dio buildClient(FakeResponder respond) {
    final adapter = RecordingHttpAdapter(respond);
    final refreshClient = Dio(BaseOptions(baseUrl: 'https://test.local'))
      ..httpClientAdapter = adapter;
    return Dio(BaseOptions(baseUrl: 'https://test.local'))
      ..httpClientAdapter = adapter
      ..interceptors.add(
        AuthInterceptor(
          tokenStorage: storage,
          refreshClient: refreshClient,
          onSessionExpired: () => sessionExpired = true,
        ),
      );
  }

  setUp(() {
    storage = _MemoryTokenStorage();
    sessionExpired = false;
  });

  test('keeps the session when the refresh answers 503', () async {
    final dio = buildClient(
      (options) => options.path == '/auth/refresh'
          ? errorOf(503, ApiErrorCodes.authSessionCheckUnavailable)
          : errorOf(401, ApiErrorCodes.authTokenExpired),
    );

    await expectLater(
      dio.get<Object?>('/users/me'),
      throwsA(isA<DioException>()),
    );

    expect(storage.refreshToken, 'old-refresh');
    expect(storage.accessToken, 'old-access');
    expect(sessionExpired, isFalse);
  });

  test('ends the session when the refresh token is refused', () async {
    final dio = buildClient(
      (options) => options.path == '/auth/refresh'
          ? errorOf(401, ApiErrorCodes.authRefreshTokenInvalid)
          : errorOf(401, ApiErrorCodes.authTokenExpired),
    );

    await expectLater(
      dio.get<Object?>('/users/me'),
      throwsA(isA<DioException>()),
    );

    expect(storage.refreshToken, isNull);
    expect(sessionExpired, isTrue);
  });
}
