import 'package:flutter/material.dart';

import 'app_color.dart';
import 'app_text_style.dart';

/// Chip chọn một giá trị trong nhóm, ví dụ loại địa chỉ Nhà / Công ty.
///
/// Chip được chọn có nền [AppColor.text] và chữ trắng.
class AppChoiceChip extends StatelessWidget {
  /// Tạo [AppChoiceChip].
  const AppChoiceChip({
    super.key,
    required this.label,
    required this.selected,
    this.icon,
    this.onSelected,
  });

  /// Nội dung chip.
  final String label;

  /// Chip đang được chọn.
  final bool selected;

  /// Icon bên trái [label].
  final IconData? icon;

  /// Gọi khi bấm chip.
  final VoidCallback? onSelected;

  @override
  Widget build(BuildContext context) {
    final foreground = selected ? AppColor.surface : AppColor.text;
    return Material(
      color: selected ? AppColor.text : AppColor.surface,
      shape: StadiumBorder(
        side: BorderSide(color: selected ? AppColor.text : AppColor.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onSelected,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 20, color: foreground),
                const SizedBox(width: 8),
              ],
              Text(
                label,
                style: AppTextStyle.medium16().copyWith(color: foreground),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
