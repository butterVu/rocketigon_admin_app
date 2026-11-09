import 'package:dragon_design/dragon_design.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/translations/locale_keys.dart';
import '../controllers/finance_controller.dart';

/// Placeholder screen for finance management.
class FinanceView extends GetView<FinanceController> {
  /// Creates a [FinanceView].
  const FinanceView({super.key});

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          LocaleKeys.rootTabFinance.tr,
          style: AppTextStyle.semibold24(),
        ),
      ),
    ),
  );
}
