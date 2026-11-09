import 'package:dragon_design/dragon_design.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/translations/locale_keys.dart';
import '../../domain/entities/phone_number.dart';
import '../controllers/login_controller.dart';

/// Binds the shared [PhoneNumberField] to [LoginController].
class AuthPhoneNumberField extends GetView<LoginController> {
  /// Creates an [AuthPhoneNumberField].
  const AuthPhoneNumberField({super.key});

  @override
  Widget build(BuildContext context) => PhoneNumberField(
    flag: '🇻🇳',
    dialCode: PhoneNumber.vietnamDialCode,
    hintText: LocaleKeys.authPhoneHint.tr,
    // One extra digit allows a leading trunk prefix `0`.
    maxLength: 11,
    onChanged: controller.updatePhone,
  );
}
