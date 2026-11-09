/// Access to the signed-in session stored on the device.
abstract interface class SessionRepository {
  /// Whether a valid session exists, so the user can skip signing in.
  Future<bool> hasActiveSession();
}
