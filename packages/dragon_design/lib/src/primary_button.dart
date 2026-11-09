import 'package:flutter/material.dart';

import 'app_color.dart';
import 'app_text_style.dart';

/// Nút chính của Dragon Design: nền [AppColor.primary], cao [height], bo góc
/// [radius], chữ [AppTextStyle.semibold18] màu trắng.
///
/// Kích thước và kiểu chữ cố định để mọi màn hình đồng bộ, nên nút chỉ nhận
/// [label] chứ không nhận `style` hay `Text` riêng. Ngoại lệ duy nhất là hai
/// nút nằm ngang trong `AppAlertSheet`, tự định kiểu bên trong sheet.
///
/// ```dart
/// PrimaryButton(
///   label: 'Tiếp tục',
///   onPressed: canContinue ? submit : null,
///   isLoading: isSubmitting,
/// )
/// ```
class PrimaryButton extends StatelessWidget {
  /// Tạo [PrimaryButton].
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isExpanded = true,
  });

  /// Chiều cao chuẩn, bằng chiều cao `AppTextField`.
  static const height = 56.0;

  /// Bán kính bo góc chuẩn, bằng bo góc `AppTextField`.
  static const radius = 18.0;

  /// Nội dung nút, hiển thị trên một dòng.
  final String label;

  /// Gọi khi bấm nút, `null` để vô hiệu hoá.
  final VoidCallback? onPressed;

  /// Hiện vòng xoay thay cho [label] và vô hiệu hoá nút.
  final bool isLoading;

  /// Nút giãn hết chiều ngang. Đặt `false` khi nút nằm cạnh widget khác
  /// hoặc giữa màn hình.
  final bool isExpanded;

  static final _style = TextButton.styleFrom(
    backgroundColor: AppColor.primary,
    foregroundColor: AppColor.surface,
    disabledBackgroundColor: AppColor.primary.withValues(alpha: 0.4),
    disabledForegroundColor: AppColor.surface.withValues(alpha: 0.8),
    textStyle: AppTextStyle.semibold18(),
    minimumSize: const Size(64, height),
    padding: const EdgeInsets.symmetric(horizontal: 24),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
    ),
  );

  @override
  Widget build(BuildContext context) => SizedBox(
    width: isExpanded ? double.infinity : null,
    height: height,
    child: TextButton(
      style: _style,
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? const SizedBox.square(
              dimension: 22,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                color: AppColor.surface,
              ),
            )
          : Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
    ),
  );
}
