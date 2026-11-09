import 'package:flutter/material.dart';

/// Bảng màu cơ bản của Dragon Design.
abstract final class AppColor {
  /// Màu chủ đạo của thương hiệu (xanh logo): nút chính, liên kết,
  /// trạng thái được chọn.
  static const Color primary = Color(0xFF204282);

  /// Màu nhấn (cam ngọn lửa logo): icon dịch vụ, nhãn ưu đãi, điểm nhấn
  /// nhỏ. Không dùng làm màu chữ trên nền trắng vì độ tương phản thấp.
  static const Color secondary = Color(0xFFE1813B);

  /// Màu nhấn phụ (đỏ thân xe logo): huy hiệu, khuyến mãi nổi bật.
  static const Color tertiary = Color(0xFF9D3637);

  /// Màu xanh dương, dùng cho icon vị trí và thông tin.
  static const Color info = Color(0xFF2757B0);

  /// Màu báo thành công.
  static const Color success = Color(0xFF43A047);

  /// Màu cảnh báo.
  static const Color warning = Color(0xFFFFB300);

  /// Màu báo lỗi.
  static const Color error = Color(0xFFE53935);

  /// Màu chữ mặc định.
  static const Color text = Color(0xFF1A1A1A);

  /// Màu chữ phụ, dùng cho mô tả và nhãn.
  static const Color textSecondary = Color(0xFF6B6B6B);

  /// Màu chữ gợi ý (placeholder).
  static const Color textHint = Color(0xFF9E9E9E);

  /// Màu nền của màn hình, thẻ và ô nhập.
  static const Color surface = Color(0xFFFFFFFF);

  /// Màu nền phụ, dùng cho ô trống hoặc vùng không được chọn.
  static const Color surfaceVariant = Color(0xFFF5F5F5);

  /// Màu viền và đường phân cách.
  static const Color border = Color(0xFFE6E6E6);
}
