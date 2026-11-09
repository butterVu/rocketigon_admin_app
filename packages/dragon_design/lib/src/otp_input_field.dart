import 'package:flutter/material.dart';

import 'app_color.dart';
import 'app_text_style.dart';
import 'code_input.dart';

/// Ô nhập mã OTP gồm [length] ô, mỗi ô một chữ số.
///
/// Hỗ trợ tự điền OTP từ SMS.
///
/// ```dart
/// OtpInputField(
///   length: 4,
///   onCompleted: (code) => verify(code),
/// )
/// ```
class OtpInputField extends StatelessWidget {
  /// Tạo [OtpInputField].
  const OtpInputField({
    super.key,
    this.length = 4,
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

  /// Hiển thị viền lỗi cho tất cả các ô.
  final bool hasError;

  /// Gọi mỗi khi mã thay đổi.
  final ValueChanged<String>? onChanged;

  /// Gọi khi đã nhập đủ [length] chữ số.
  final ValueChanged<String>? onCompleted;

  @override
  Widget build(BuildContext context) => CodeInput(
    length: length,
    controller: controller,
    focusNode: focusNode,
    autofocus: autofocus,
    enabled: enabled,
    autofillHints: const [AutofillHints.oneTimeCode],
    onChanged: onChanged,
    onCompleted: onCompleted,
    cellBuilder: (context, index, digit, isActive) =>
        _OtpBox(digit: digit, isActive: isActive, hasError: hasError),
  );
}

class _OtpBox extends StatelessWidget {
  const _OtpBox({
    required this.digit,
    required this.isActive,
    required this.hasError,
  });

  final String? digit;
  final bool isActive;
  final bool hasError;

  static const _width = 52.0;
  static const _height = 60.0;

  @override
  Widget build(BuildContext context) {
    final isEmpty = digit == null;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: _width,
      height: _height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isEmpty && !isActive
            ? AppColor.surfaceVariant
            : AppColor.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _borderColor, width: isActive ? 2.5 : 1),
      ),
      child: isEmpty
          ? (isActive ? const _BlinkingCursor() : null)
          : Text(digit!, style: AppTextStyle.semibold24()),
    );
  }

  Color get _borderColor {
    if (hasError) return AppColor.error;
    if (isActive) return AppColor.text;
    return digit == null ? AppColor.surfaceVariant : AppColor.border;
  }
}

class _BlinkingCursor extends StatefulWidget {
  const _BlinkingCursor();

  @override
  State<_BlinkingCursor> createState() => _BlinkingCursorState();
}

class _BlinkingCursorState extends State<_BlinkingCursor>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animation = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FadeTransition(
    opacity: _animation,
    child: Container(width: 2, height: 24, color: AppColor.primary),
  );
}
