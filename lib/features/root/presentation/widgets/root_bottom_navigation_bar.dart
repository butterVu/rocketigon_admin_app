import 'package:dragon_design/dragon_design.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/root_controller.dart';

/// Bottom navigation listing every [RootTab].
class RootBottomNavigationBar extends GetView<RootController> {
  /// Creates a [RootBottomNavigationBar].
  const RootBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: const BoxDecoration(
      border: Border(top: BorderSide(color: AppColor.border)),
    ),
    child: Obx(
      () => NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.selected)
                ? AppTextStyle.semibold12().copyWith(color: AppColor.primary)
                : AppTextStyle.regular12().copyWith(
                    color: AppColor.textSecondary,
                  ),
          ),
        ),
        child: NavigationBar(
          backgroundColor: AppColor.surface,
          surfaceTintColor: AppColor.surface,
          indicatorColor: AppColor.primary.withValues(alpha: 0.12),
          selectedIndex: controller.currentTab.value.index,
          onDestinationSelected: (index) =>
              controller.selectTab(RootTab.values[index]),
          destinations: [
            for (final tab in RootTab.values)
              NavigationDestination(
                icon: Icon(tab.icon, color: AppColor.textSecondary),
                selectedIcon: Icon(tab.selectedIcon, color: AppColor.primary),
                label: tab.labelKey.tr,
              ),
          ],
        ),
      ),
    ),
  );
}
