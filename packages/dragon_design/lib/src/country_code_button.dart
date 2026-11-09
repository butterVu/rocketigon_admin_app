import 'package:flutter/material.dart';

import 'app_color.dart';
import 'app_text_style.dart';

/// Nút hiển thị cờ và mã vùng quốc gia, ví dụ `🇻🇳 +84 ▾`.
class CountryCodeButton extends StatelessWidget {
  /// Tạo [CountryCodeButton].
  const CountryCodeButton({
    super.key,
    required this.flag,
    required this.dialCode,
    this.onPressed,
  });

  /// Cờ quốc gia dạng emoji, ví dụ `🇻🇳`.
  final String flag;

  /// Mã vùng quốc gia, ví dụ `+84`.
  final String dialCode;

  /// Gọi khi người dùng bấm nút, thường để mở danh sách quốc gia.
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => Material(
    color: AppColor.surface,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: const BorderSide(color: AppColor.border),
    ),
    clipBehavior: Clip.antiAlias,
    child: InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(flag, style: AppTextStyle.regular24()),
            const SizedBox(width: 8),
            Text(dialCode, style: AppTextStyle.regular18()),
            const Icon(Icons.arrow_drop_down, color: AppColor.textSecondary),
          ],
        ),
      ),
    ),
  );
}
