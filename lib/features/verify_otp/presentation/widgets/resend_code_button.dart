import 'package:dragon_design/dragon_design.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/translations/locale_keys.dart';
import '../controllers/verify_otp_controller.dart';

/// "Resend code" link showing the remaining cooldown, e.g. `Gửi lại mã (16)`.
class ResendCodeButton extends GetView<VerifyOtpController> {
  /// Creates a [ResendCodeButton].
  const ResendCodeButton({super.key});

  @override
  Widget build(BuildContext context) => Obx(() {
    final secondsLeft = controller.resendSecondsLeft.value;
    final canResend = controller.canResend;
    final color = canResend ? AppColor.primary : AppColor.textHint;
    final label = secondsLeft > 0
        ? LocaleKeys.verifyOtpResendCountdown.trParams({
            'seconds': '$secondsLeft',
          })
        : LocaleKeys.verifyOtpResend.tr;
    return TextButton.icon(
      onPressed: canResend ? controller.resend : null,
      icon: Icon(Icons.refresh, size: 20, color: color),
      label: Text(
        label,
        style: AppTextStyle.regular16().copyWith(color: color),
      ),
    );
  });
}
