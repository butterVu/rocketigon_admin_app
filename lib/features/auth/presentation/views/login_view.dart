import 'package:dragon_design/dragon_design.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/translations/locale_keys.dart';
import '../controllers/login_controller.dart';
import '../widgets/auth_phone_number_field.dart';
import '../widgets/login_code_field.dart';

/// Login screen with a phone number, a login code and a sign-in button.
class LoginView extends GetView<LoginController> {
  /// Creates a [LoginView].
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColor.surface,
    body: SafeArea(
      child: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: const SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20, 64, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _LoginHeader(),
              SizedBox(height: 40),
              AuthPhoneNumberField(),
              SizedBox(height: 16),
              LoginCodeField(),
              _LoginError(),
              SizedBox(height: 24),
              _LoginButton(),
            ],
          ),
        ),
      ),
    ),
  );
}

class _LoginHeader extends StatelessWidget {
  const _LoginHeader();

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        LocaleKeys.authHeadline.tr,
        style: AppTextStyle.regular32().copyWith(color: AppColor.primary),
      ),
      const SizedBox(height: 12),
      Text(
        LocaleKeys.authSubtitle.tr,
        style: AppTextStyle.regular16().copyWith(color: AppColor.textSecondary),
      ),
    ],
  );
}

class _LoginError extends GetView<LoginController> {
  const _LoginError();

  @override
  Widget build(BuildContext context) => Obx(() {
    final message = controller.errorMessage.value;
    if (message == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Text(
        message,
        style: AppTextStyle.regular14().copyWith(color: AppColor.error),
      ),
    );
  });
}

class _LoginButton extends GetView<LoginController> {
  const _LoginButton();

  @override
  Widget build(BuildContext context) => Obx(
    () => PrimaryButton(
      label: LocaleKeys.authLogin.tr,
      isLoading: controller.isLoading.value,
      onPressed: controller.canSubmit ? controller.submit : null,
    ),
  );
}
