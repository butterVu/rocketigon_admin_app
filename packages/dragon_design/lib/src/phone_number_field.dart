import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_color.dart';
import 'app_text_field.dart';
import 'country_code_button.dart';

/// Ô nhập số điện thoại gồm nút chọn mã vùng và ô nhập số.
///
/// ```dart
/// PhoneNumberField(
///   flag: '🇻🇳',
///   dialCode: '+84',
///   hintText: 'Nhập số điện thoại',
///   maxLength: 11,
///   onCountryPressed: openCountryPicker,
///   onChanged: (value) => phoneNumber = value,
/// )
/// ```
class PhoneNumberField extends StatelessWidget {
  /// Tạo [PhoneNumberField].
  const PhoneNumberField({
    super.key,
    required this.flag,
    required this.dialCode,
    this.hintText,
    this.maxLength,
    this.controller,
    this.focusNode,
    this.onCountryPressed,
    this.onChanged,
    this.onSubmitted,
  });

  /// Cờ của quốc gia đang chọn, dạng emoji.
  final String flag;

  /// Mã vùng của quốc gia đang chọn, ví dụ `+84`.
  final String dialCode;

  /// Gợi ý hiển thị khi ô nhập trống.
  final String? hintText;

  /// Số chữ số tối đa được nhập, không giới hạn nếu `null`.
  final int? maxLength;

  /// Controller của ô nhập số.
  final TextEditingController? controller;

  /// Focus node của ô nhập số.
  final FocusNode? focusNode;

  /// Gọi khi người dùng bấm nút mã vùng.
  final VoidCallback? onCountryPressed;

  /// Gọi mỗi khi số điện thoại thay đổi.
  final ValueChanged<String>? onChanged;

  /// Gọi khi người dùng bấm "xong" trên bàn phím.
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(6),
    decoration: BoxDecoration(
      color: AppColor.surface,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: AppColor.border, width: 1.5),
    ),
    child: Row(
      children: [
        CountryCodeButton(
          flag: flag,
          dialCode: dialCode,
          onPressed: onCountryPressed,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: AppTextField(
            controller: controller,
            focusNode: focusNode,
            hintText: hintText,
            showBorder: false,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.done,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              if (maxLength != null)
                LengthLimitingTextInputFormatter(maxLength),
            ],
            onChanged: onChanged,
            onSubmitted: onSubmitted,
          ),
        ),
      ],
    ),
  );
}
