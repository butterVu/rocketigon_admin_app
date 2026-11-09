import 'package:dragon_design/dragon_design.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_constants.dart';
import '../controllers/splash_controller.dart';

/// Launch screen shown while the app decides where to go.
class SplashView extends GetView<SplashController> {
  /// Creates a [SplashView].
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColor.surface,
    body: SafeArea(
      child: Center(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Placeholder: replace with the app logo asset.
                  const FlutterLogo(size: 120),
                  const SizedBox(height: 20),
                  Text(
                    AppConstants.appName,
                    style: AppTextStyle.semibold32().copyWith(
                      color: AppColor.primary,
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 32),
              child: SizedBox.square(
                dimension: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: AppColor.secondary,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
