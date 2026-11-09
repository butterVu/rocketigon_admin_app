import 'package:dragon_design/dragon_design.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/translations/locale_keys.dart';
import '../controllers/account_controller.dart';
import '../widgets/account_menu_tile.dart';

/// Account tab of the root screen, showing the profile and settings.
class AccountView extends GetView<AccountController> {
  /// Creates a [AccountView].
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) => SafeArea(
    child: ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(LocaleKeys.rootTabAccount.tr, style: AppTextStyle.semibold24()),
        const SizedBox(height: 16),
        AccountMenuTile(
          icon: Icons.logout_rounded,
          title: LocaleKeys.accountLogout.tr,
          color: AppColor.error,
          onTap: controller.logout,
        ),
      ],
    ),
  );
}
