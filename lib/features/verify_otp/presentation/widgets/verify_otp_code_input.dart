import 'package:dragon_design/dragon_design.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/verify_otp_controller.dart';

/// Binds the shared [OtpInputField] to [VerifyOtpController], showing the
/// error or a progress indicator below it.
class VerifyOtpCodeInput extends GetView<VerifyOtpController> {
  /// Creates a [VerifyOtpCodeInput].
  const VerifyOtpCodeInput({super.key});

  @override
  Widget build(BuildContext context) => Obx(() {
    final error = controller.errorMessage.value;
    final isVerifying = controller.status.value == VerifyOtpStatus.verifying;
    return Column(
      children: [
        OtpInputField(
          length: controller.arguments.codeLength,
          controller: controller.codeController,
          hasError: error != null,
          onChanged: controller.onCodeChanged,
          onCompleted: (_) => controller.verify(),
        ),
        if (isVerifying)
          const Padding(
            padding: EdgeInsets.only(top: 16),
            child: SizedBox.square(
              dimension: 22,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                color: AppColor.primary,
              ),
            ),
          )
        else if (error != null)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(
              error,
              textAlign: TextAlign.center,
              style: AppTextStyle.regular14().copyWith(color: AppColor.error),
            ),
          ),
      ],
    );
  });
}
