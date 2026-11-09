import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_color.dart';
import 'app_text_style.dart';

/// Ô nhập liệu chuẩn của Dragon Design.
///
/// Mặc định có viền bo góc, viền chuyển sang [AppColor.primary] khi focus.
/// Đặt [showBorder] là `false` khi ô nhập nằm trong một khung khác,
/// ví dụ trong `PhoneNumberField`.
class AppTextField extends StatelessWidget {
  /// Tạo [AppTextField].
  const AppTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.hintText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.obscureText = false,
    this.enabled = true,
    this.autofocus = false,
    this.showBorder = true,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.onChanged,
    this.onSubmitted,
  });

  /// Controller của ô nhập.
  final TextEditingController? controller;

  /// Focus node của ô nhập.
  final FocusNode? focusNode;

  /// Gợi ý hiển thị khi ô nhập trống.
  final String? hintText;

  /// Thông báo lỗi hiển thị bên dưới, viền chuyển sang [AppColor.error].
  final String? errorText;

  /// Widget hiển thị trước nội dung nhập.
  final Widget? prefixIcon;

  /// Widget hiển thị sau nội dung nhập.
  final Widget? suffixIcon;

  /// Loại bàn phím.
  final TextInputType? keyboardType;

  /// Nút hành động trên bàn phím.
  final TextInputAction? textInputAction;

  /// Bộ lọc/định dạng nội dung nhập.
  final List<TextInputFormatter>? inputFormatters;

  /// Ẩn nội dung nhập, dùng cho mật khẩu.
  final bool obscureText;

  /// Cho phép nhập hay không.
  final bool enabled;

  /// Tự động focus khi hiển thị.
  final bool autofocus;

  /// Hiển thị viền bo góc quanh ô nhập.
  final bool showBorder;

  /// Số dòng tối đa, `null` để tự giãn theo nội dung.
  final int? maxLines;

  /// Số dòng tối thiểu, dùng cho ô ghi chú nhiều dòng.
  final int? minLines;

  /// Số ký tự tối đa, hiện bộ đếm `0/100` bên dưới khi được đặt.
  final int? maxLength;

  /// Gọi mỗi khi nội dung thay đổi.
  final ValueChanged<String>? onChanged;

  /// Gọi khi người dùng bấm nút hành động trên bàn phím.
  final ValueChanged<String>? onSubmitted;

  static const _radius = BorderRadius.all(Radius.circular(18));

  @override
  Widget build(BuildContext context) => TextField(
    controller: controller,
    focusNode: focusNode,
    keyboardType: keyboardType,
    textInputAction: textInputAction,
    inputFormatters: inputFormatters,
    obscureText: obscureText,
    enabled: enabled,
    autofocus: autofocus,
    maxLines: maxLines,
    minLines: minLines,
    maxLength: maxLength,
    style: AppTextStyle.regular18(),
    cursorColor: AppColor.primary,
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: AppTextStyle.regular18().copyWith(color: AppColor.textHint),
      errorText: errorText,
      errorStyle: AppTextStyle.regular12().copyWith(color: AppColor.error),
      counterStyle: AppTextStyle.regular12().copyWith(color: AppColor.textHint),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      filled: showBorder,
      fillColor: AppColor.surface,
      contentPadding: showBorder
          ? const EdgeInsets.symmetric(horizontal: 16, vertical: 16)
          : null,
      border: _border(AppColor.border),
      enabledBorder: _border(AppColor.border),
      disabledBorder: _border(AppColor.border),
      focusedBorder: _border(AppColor.primary),
      errorBorder: _border(AppColor.error),
      focusedErrorBorder: _border(AppColor.error),
    ),
    onChanged: onChanged,
    onSubmitted: onSubmitted,
  );

  InputBorder _border(Color color) => showBorder
      ? OutlineInputBorder(
          borderRadius: _radius,
          borderSide: BorderSide(color: color, width: 1.5),
        )
      : InputBorder.none;
}
