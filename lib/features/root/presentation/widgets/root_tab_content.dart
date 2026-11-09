import 'package:flutter/material.dart';

import '../../../account/presentation/views/account_view.dart';
import '../controllers/root_controller.dart';

/// View of the feature behind [tab].
class RootTabContent extends StatelessWidget {
  /// Creates a [RootTabContent] for [tab].
  const RootTabContent({super.key, required this.tab});

  /// Tab whose view is shown.
  final RootTab tab;

  @override
  Widget build(BuildContext context) => switch (tab) {
    RootTab.account => const AccountView(),
  };
}
