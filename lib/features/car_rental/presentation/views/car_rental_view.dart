import 'package:dragon_design/dragon_design.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/translations/locale_keys.dart';
import '../controllers/car_rental_controller.dart';

/// Placeholder screen for car rental management.
class CarRentalView extends GetView<CarRentalController> {
  /// Creates a [CarRentalView].
  const CarRentalView({super.key});

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          LocaleKeys.rootTabCarRental.tr,
          style: AppTextStyle.semibold24(),
        ),
      ),
    ),
  );
}
