import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/translations/locale_keys.dart';

/// A tab of the root screen.
///
/// Add, remove or reorder values to change the bottom navigation.
enum RootTab {
  /// Profile and settings.
  account(LocaleKeys.rootTabAccount, Icons.person_outline, Icons.person);

  const RootTab(this.labelKey, this.icon, this.selectedIcon);

  /// Translation key of the tab label.
  final String labelKey;

  /// Icon shown while the tab is not selected.
  final IconData icon;

  /// Icon shown while the tab is selected.
  final IconData selectedIcon;
}

/// Tracks the selected tab of the root screen.
class RootController extends GetxController {
  /// Tab currently shown.
  final currentTab = RootTab.account.obs;

  /// Shows [tab].
  void selectTab(RootTab tab) => currentTab.value = tab;
}
