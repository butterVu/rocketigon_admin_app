import 'package:dragon_design/dragon_design.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/translations/locale_keys.dart';
import '../controllers/food_controller.dart';

/// Placeholder screen for food management.
class FoodView extends GetView<FoodController> {
  /// Creates a [FoodView].
  const FoodView({super.key});

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          LocaleKeys.rootTabFood.tr,
          style: AppTextStyle.semibold24(),
        ),
      ),
    ),
  );
}
