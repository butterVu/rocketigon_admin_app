import 'package:flutter/material.dart';

import 'app_color.dart';
import 'code_input.dart';

/// Ô nhập mã mở khoá, hiển thị mỗi chữ số đã nhập bằng một chấm tròn.
///
/// ```dart
/// PasscodeField(
///   length: 6,
///   onCompleted: (passcode) => submit(passcode),
/// )
/// ```
class PasscodeField extends StatelessWidget {
  /// Tạo [PasscodeField].
  const PasscodeField({
    super.key,
    this.length = 6,
    this.controller,
    this.focusNode,
    this.autofocus = true,
    this.enabled = true,
    this.hasError = false,
    this.onChanged,
    this.onCompleted,
  });

  /// Số chữ số của mã.
  final int length;

  /// Controller chứa mã đã nhập, dùng để đọc hoặc xoá mã.
  final TextEditingController? controller;

  /// Focus node của ô nhập ẩn.
  final FocusNode? focusNode;

  /// Tự động mở bàn phím khi hiển thị.
  final bool autofocus;

  /// Cho phép nhập hay không.
  final bool enabled;

  /// Hiển thị các chấm bằng màu [AppColor.error].
  final bool hasError;

  /// Gọi mỗi khi mã thay đổi.
  final ValueChanged<String>? onChanged;

  /// Gọi khi đã nhập đủ [length] chữ số.
  final ValueChanged<String>? onCompleted;

  @override
  Widget build(BuildContext context) => CodeInput(
    length: length,
    spacing: 20,
    controller: controller,
    focusNode: focusNode,
    autofocus: autofocus,
    enabled: enabled,
    onChanged: onChanged,
    onCompleted: onCompleted,
    cellBuilder: (context, index, digit, isActive) =>
        _PasscodeDot(isFilled: digit != null, hasError: hasError),
  );
}

class _PasscodeDot extends StatelessWidget {
  const _PasscodeDot({required this.isFilled, required this.hasError});

  final bool isFilled;
  final bool hasError;

  static const _size = 28.0;

  @override
  Widget build(BuildContext context) {
    final color = hasError ? AppColor.error : AppColor.text;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: _size,
      height: _size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isFilled ? color : Colors.transparent,
        border: Border.all(color: color, width: 2.5),
      ),
    );
  }
}
