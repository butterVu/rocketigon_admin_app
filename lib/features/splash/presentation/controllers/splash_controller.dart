import 'dart:developer' as developer;

import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';
import '../../domain/usecases/check_session_use_case.dart';

/// Shows the splash briefly, then opens home or sign-in.
class SplashController extends GetxController {
  /// Creates a [SplashController].
  SplashController({required this._checkSession});

  final CheckSessionUseCase _checkSession;

  /// Shortest time the splash stays visible, avoiding a flash on fast
  /// devices.
  static const minimumDisplayDuration = Duration(milliseconds: 1500);

  @override
  void onReady() {
    super.onReady();
    _openNextScreen();
  }

  Future<void> _openNextScreen() async {
    final (isSignedIn, _) = await (
      _isSignedIn(),
      Future<void>.delayed(minimumDisplayDuration),
    ).wait;
    Get.offAllNamed<void>(isSignedIn ? Routes.root : Routes.login);
  }

  Future<bool> _isSignedIn() async {
    try {
      return await _checkSession();
    } catch (error, stackTrace) {
      developer.log(
        'Session check failed, opening sign-in',
        name: 'rocket.splash',
        level: 1000,
        error: error,
        stackTrace: stackTrace,
      );
      return false;
    }
  }
}
