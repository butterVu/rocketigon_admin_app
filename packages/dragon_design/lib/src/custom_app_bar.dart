import 'package:flutter/material.dart';

import 'app_color.dart';
import 'app_text_style.dart';

/// Thanh tiêu đề chuẩn của Dragon Design: nền [AppColor.surface], không đổ
/// bóng, tiêu đề căn trái.
///
/// ```dart
/// Scaffold(
///   appBar: CustomAppBar(
///     title: 'Thông báo',
///     showDivider: true,
///     actions: [IconButton(onPressed: openMenu, icon: Icon(Icons.menu))],
///   ),
/// )
/// ```
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Tạo [CustomAppBar].
  const CustomAppBar({
    super.key,
    this.title,
    this.titleStyle,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.actions,
    this.centerTitle = false,
    this.showDivider = false,
    this.backgroundColor = AppColor.surface,
  });

  /// Nội dung tiêu đề, bỏ trống nếu màn hình tự hiển thị tiêu đề lớn.
  final String? title;

  /// Kiểu chữ tiêu đề, mặc định [AppTextStyle.semibold20].
  final TextStyle? titleStyle;

  /// Widget bên trái, mặc định là nút quay lại khi có thể quay lại.
  final Widget? leading;

  /// Tự hiện nút quay lại khi [leading] để trống.
  final bool automaticallyImplyLeading;

  /// Các nút bên phải.
  final List<Widget>? actions;

  /// Căn giữa tiêu đề.
  final bool centerTitle;

  /// Hiện đường kẻ [AppColor.border] dưới thanh tiêu đề.
  final bool showDivider;

  /// Màu nền.
  final Color backgroundColor;

  static const _dividerHeight = 1.0;

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (showDivider ? _dividerHeight : 0));

  @override
  Widget build(BuildContext context) => AppBar(
    backgroundColor: backgroundColor,
    surfaceTintColor: backgroundColor,
    foregroundColor: AppColor.text,
    elevation: 0,
    scrolledUnderElevation: 0,
    leading: leading,
    automaticallyImplyLeading: automaticallyImplyLeading,
    centerTitle: centerTitle,
    titleSpacing: leading == null && !_canPop(context) ? 20 : null,
    title: title == null
        ? null
        : Text(title!, style: titleStyle ?? AppTextStyle.semibold20()),
    actions: actions,
    bottom: showDivider
        ? const PreferredSize(
            preferredSize: Size.fromHeight(_dividerHeight),
            child: Divider(height: _dividerHeight, color: AppColor.border),
          )
        : null,
  );

  bool _canPop(BuildContext context) =>
      automaticallyImplyLeading && (ModalRoute.of(context)?.canPop ?? false);
}
