import 'package:dragon_design/dragon_design.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/root_controller.dart';
import '../widgets/root_bottom_navigation_bar.dart';
import '../widgets/root_tab_content.dart';

/// Main screen after sign-in, hosting the tabs of [RootTab].
class RootView extends GetView<RootController> {
  /// Creates a [RootView].
  const RootView({super.key});

  @override
  Widget build(BuildContext context) => Obx(
    () => Scaffold(
      backgroundColor: AppColor.surface,
      // IndexedStack keeps each tab's state while switching.
      body: IndexedStack(
        index: controller.currentTab.value.index,
        children: [for (final tab in RootTab.values) RootTabContent(tab: tab)],
      ),
      bottomNavigationBar: RootTab.values.length > 1
          ? const RootBottomNavigationBar()
          : null,
    ),
  );
}
