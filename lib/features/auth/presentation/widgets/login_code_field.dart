import 'package:dragon_design/dragon_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../app/translations/locale_keys.dart';
import '../../domain/usecases/login_use_case.dart';
import '../controllers/login_controller.dart';

/// Hidden 6-digit login code input with a show / hide toggle.
class LoginCodeField extends GetView<LoginController> {
  /// Creates a [LoginCodeField].
  const LoginCodeField({super.key});

  @override
  Widget build(BuildContext context) => Obx(() {
    final isVisible = controller.isCodeVisible.value;
    return AppTextField(
      hintText: LocaleKeys.authLoginCodeHint.tr,
      obscureText: !isVisible,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      maxLength: LoginUseCase.codeLength,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      suffixIcon: IconButton(
        onPressed: controller.toggleCodeVisibility,
        icon: Icon(
          isVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined,
          color: AppColor.textSecondary,
        ),
      ),
      onChanged: controller.updateLoginCode,
      onSubmitted: (_) => controller.submit(),
    );
  });
}
