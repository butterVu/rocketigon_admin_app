import 'package:dragon_design/dragon_design.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/translations/locale_keys.dart';
import '../controllers/verify_otp_controller.dart';
import '../widgets/otp_illustration.dart';
import '../widgets/resend_code_button.dart';
import '../widgets/verify_otp_code_input.dart';

/// Screen where the user enters the OTP sent to their phone.
class VerifyOtpView extends GetView<VerifyOtpController> {
  /// Creates a [VerifyOtpView].
  const VerifyOtpView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColor.surface,
    appBar: const CustomAppBar(),
    body: SafeArea(
      top: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(LocaleKeys.verifyOtpTitle.tr, style: AppTextStyle.regular28()),
            const SizedBox(height: 24),
            const OtpIllustration(),
            const SizedBox(height: 24),
            Text(
              LocaleKeys.verifyOtpInstruction.trParams({
                'length': '${controller.arguments.codeLength}',
              }),
              textAlign: TextAlign.center,
              style: AppTextStyle.regular14().copyWith(
                color: AppColor.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              controller.arguments.displayPhoneNumber,
              textAlign: TextAlign.center,
              style: AppTextStyle.medium20(),
            ),
            const SizedBox(height: 32),
            const VerifyOtpCodeInput(),
            const SizedBox(height: 24),
            const Center(child: ResendCodeButton()),
          ],
        ),
      ),
    ),
  );
}
