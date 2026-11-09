/// App-wide constant values.
abstract final class AppConstants {
  /// Display name of the app.
  static const appName = 'Rocketigo Admin';

  /// Role sent as `app` to the auth endpoints: the account of this app is
  /// an admin, and the server refuses it in any other app.
  static const appRole = 'admin';

  /// Base URL of the Rocketigo API, set with `--dart-define=API_BASE_URL=...`.
  static const apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://201-79-123-38.sslip.io/api/v1',
  );

  /// Maximum time to open a connection to the API.
  static const apiConnectTimeout = Duration(seconds: 15);

  /// Maximum time to wait for an API response.
  static const apiReceiveTimeout = Duration(seconds: 30);
}
