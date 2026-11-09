import 'package:dragon_design/dragon_design.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../app/translations/locale_keys.dart';
import '../../../auth/domain/usecases/logout_use_case.dart';

/// Drives the account tab showing the profile and settings.
class AccountController extends GetxController {
  /// Creates an [AccountController].
  AccountController({required this._logoutUseCase});

  final LogoutUseCase _logoutUseCase;

  /// Asks for confirmation, then signs out and opens the login screen.
  Future<void> logout() async {
    final confirmed = await Get.bottomSheet<bool>(
      AppAlertSheet(
        title: LocaleKeys.commonConfirm.tr,
        message: LocaleKeys.accountLogoutConfirm.tr,
        confirmLabel: LocaleKeys.accountLogout.tr,
        cancelLabel: LocaleKeys.commonClose.tr,
      ),
      // The sheet draws its own rounded background.
      backgroundColor: Colors.transparent,
    );
    if (confirmed != true) return;
    await _logoutUseCase();
    Get.offAllNamed<void>(Routes.login);
  }
}
