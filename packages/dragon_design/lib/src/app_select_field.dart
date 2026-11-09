import 'package:flutter/material.dart';

import 'app_color.dart';
import 'app_text_style.dart';

/// Ô chỉ bấm được (không gõ trực tiếp), mở màn hình hoặc sheet để chọn
/// giá trị, ví dụ chọn địa chỉ.
///
/// Hiện [hintText] khi [value] trống, kèm mũi tên bên phải.
class AppSelectField extends StatelessWidget {
  /// Tạo [AppSelectField].
  const AppSelectField({
    super.key,
    this.value,
    this.hintText,
    this.errorText,
    this.onTap,
  });

  /// Giá trị đã chọn.
  final String? value;

  /// Gợi ý hiển thị khi chưa chọn.
  final String? hintText;

  /// Thông báo lỗi hiển thị bên dưới.
  final String? errorText;

  /// Gọi khi bấm vào ô.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final hasValue = value != null && value!.isNotEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Material(
          color: AppColor.surfaceVariant,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: BorderSide(
              color: errorText == null ? AppColor.border : AppColor.error,
              width: 1.5,
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 12, 16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      hasValue ? value! : (hintText ?? ''),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.regular18().copyWith(
                        color: hasValue ? AppColor.text : AppColor.textHint,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: AppColor.textSecondary,
                  ),
                ],
              ),
            ),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 6),
            child: Text(
              errorText!,
              style: AppTextStyle.regular12().copyWith(color: AppColor.error),
            ),
          ),
      ],
    );
  }
}
