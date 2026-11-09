import 'package:flutter/material.dart';

import 'app_color.dart';
import 'app_text_style.dart';

/// Bottom sheet xác nhận gồm icon, tiêu đề, nội dung và hai nút.
///
/// Sheet đóng với kết quả `true` khi bấm [confirmLabel], `false` khi bấm
/// [cancelLabel], và `null` khi người dùng vuốt đóng. Bỏ trống
/// [cancelLabel] để chỉ hiện một nút, ví dụ khi báo thành công.
///
/// ```dart
/// final confirmed = await showModalBottomSheet<bool>(
///   context: context,
///   backgroundColor: Colors.transparent,
///   builder: (_) => const AppAlertSheet(
///     title: 'Xác nhận',
///     message: 'Bạn có chắc chắn muốn đăng xuất?',
///     confirmLabel: 'Đăng xuất',
///     cancelLabel: 'Đóng',
///   ),
/// );
/// ```
class AppAlertSheet extends StatelessWidget {
  /// Tạo [AppAlertSheet].
  const AppAlertSheet({
    super.key,
    required this.title,
    required this.message,
    required this.confirmLabel,
    this.cancelLabel,
    this.icon,
    this.isDestructive = true,
  });

  /// Tiêu đề màu [AppColor.primary].
  final String title;

  /// Nội dung giải thích bên dưới tiêu đề.
  final String message;

  /// Nhãn nút thực hiện hành động.
  final String confirmLabel;

  /// Nhãn nút đóng sheet, `null` để chỉ hiện nút [confirmLabel].
  final String? cancelLabel;

  /// Icon phía trên tiêu đề, mặc định là ảnh placeholder.
  final Widget? icon;

  /// Hành động khó hoàn tác (đăng xuất, xoá...): nút đóng được tô nổi bật
  /// để người dùng không bấm nhầm, nút xác nhận chỉ có viền.
  final bool isDestructive;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: const BoxDecoration(
      color: AppColor.surface,
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    child: SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Placeholder: thay bằng asset icon cảnh báo.
            icon ?? const FlutterLogo(size: 72),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyle.bold20().copyWith(color: AppColor.primary),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyle.regular14().copyWith(
                color: AppColor.textSecondary,
              ),
            ),
            const SizedBox(height: 20),
            _AlertActions(
              confirmLabel: confirmLabel,
              cancelLabel: cancelLabel,
              isDestructive: isDestructive,
            ),
          ],
        ),
      ),
    ),
  );
}

class _AlertActions extends StatelessWidget {
  const _AlertActions({
    required this.confirmLabel,
    required this.cancelLabel,
    required this.isDestructive,
  });

  final String confirmLabel;
  final String? cancelLabel;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final cancelLabel = this.cancelLabel;
    final confirm = _AlertButton(
      label: confirmLabel,
      isFilled: !isDestructive || cancelLabel == null,
      onPressed: () => Navigator.of(context).pop(true),
    );
    if (cancelLabel == null) {
      return SizedBox(width: double.infinity, child: confirm);
    }
    final cancel = _AlertButton(
      label: cancelLabel,
      isFilled: isDestructive,
      onPressed: () => Navigator.of(context).pop(false),
    );
    return Row(
      children: [
        Expanded(child: isDestructive ? confirm : cancel),
        const SizedBox(width: 12),
        Expanded(child: isDestructive ? cancel : confirm),
      ],
    );
  }
}

class _AlertButton extends StatelessWidget {
  const _AlertButton({
    required this.label,
    required this.isFilled,
    required this.onPressed,
  });

  final String label;
  final bool isFilled;
  final VoidCallback onPressed;

  static const _shape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
  );
  static const _minimumSize = Size.fromHeight(48);

  @override
  Widget build(BuildContext context) {
    final textStyle = AppTextStyle.semibold16();
    // Hai nút nằm ngang nên nhỏ hơn `PrimaryButton` chuẩn.
    if (isFilled) {
      return TextButton(
        style: TextButton.styleFrom(
          minimumSize: _minimumSize,
          shape: _shape,
          backgroundColor: AppColor.primary,
          foregroundColor: AppColor.surface,
        ),
        onPressed: onPressed,
        child: Text(label, style: textStyle.copyWith(color: AppColor.surface)),
      );
    }
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        minimumSize: _minimumSize,
        shape: _shape,
        foregroundColor: AppColor.primary,
        side: const BorderSide(color: AppColor.primary),
      ),
      onPressed: onPressed,
      child: Text(label, style: textStyle.copyWith(color: AppColor.primary)),
    );
  }
}
