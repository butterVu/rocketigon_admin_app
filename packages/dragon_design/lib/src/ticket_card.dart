import 'package:flutter/material.dart';

import 'app_color.dart';

/// Thẻ hình vé (voucher, coupon): phần [leading] bên trái, nội dung [child]
/// bên phải, ngăn cách bởi đường gạch đứt có khấc tròn ở hai đầu.
///
/// ```dart
/// TicketCard(
///   leading: Image.asset('assets/bike.png'),
///   onTap: openDetail,
///   child: Text('HLNOW1121'),
/// )
/// ```
class TicketCard extends StatelessWidget {
  /// Tạo [TicketCard].
  const TicketCard({
    super.key,
    required this.leading,
    required this.child,
    this.leadingWidth = 104,
    this.onTap,
  });

  /// Nội dung phần cuống vé bên trái, thường là hình ảnh.
  final Widget leading;

  /// Nội dung chính bên phải.
  final Widget child;

  /// Chiều rộng phần [leading], cũng là vị trí đường gạch đứt.
  final double leadingWidth;

  /// Gọi khi bấm vào thẻ.
  final VoidCallback? onTap;

  static const _notchRadius = 7.0;

  @override
  Widget build(BuildContext context) {
    final shape = _TicketBorder(
      notchCenterX: leadingWidth,
      notchRadius: _notchRadius,
    );
    return DecoratedBox(
      decoration: ShapeDecoration(
        shape: shape,
        shadows: [
          BoxShadow(
            color: AppColor.text.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: AppColor.surface,
        shape: shape,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: leadingWidth,
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Center(child: leading),
                  ),
                ),
                const _DashedDivider(margin: _notchRadius + 4),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                    child: child,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DashedDivider extends StatelessWidget {
  const _DashedDivider({required this.margin});

  final double margin;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(vertical: margin),
    child: const CustomPaint(
      size: Size(2, double.infinity),
      painter: _DashedLinePainter(),
    ),
  );
}

class _DashedLinePainter extends CustomPainter {
  const _DashedLinePainter();

  static const _dashLength = 4.0;
  static const _gapLength = 4.0;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColor.border
      ..strokeWidth = size.width
      ..strokeCap = StrokeCap.round;
    final x = size.width / 2;
    for (var y = 0.0; y < size.height; y += _dashLength + _gapLength) {
      canvas.drawLine(Offset(x, y), Offset(x, y + _dashLength), paint);
    }
  }

  @override
  bool shouldRepaint(_DashedLinePainter oldDelegate) => false;
}

/// Rounded rectangle with semicircle notches cut into the top and bottom
/// edges at [notchCenterX].
class _TicketBorder extends ShapeBorder {
  const _TicketBorder({required this.notchCenterX, required this.notchRadius});

  final double notchCenterX;
  final double notchRadius;

  static const _cornerRadius = Radius.circular(14);

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final card = Path()..addRRect(RRect.fromRectAndRadius(rect, _cornerRadius));
    final notches = Path()
      ..addOval(
        Rect.fromCircle(
          center: Offset(rect.left + notchCenterX + 1, rect.top),
          radius: notchRadius,
        ),
      )
      ..addOval(
        Rect.fromCircle(
          center: Offset(rect.left + notchCenterX + 1, rect.bottom),
          radius: notchRadius,
        ),
      );
    return Path.combine(PathOperation.difference, card, notches);
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) =>
      getOuterPath(rect, textDirection: textDirection);

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => _TicketBorder(
    notchCenterX: notchCenterX * t,
    notchRadius: notchRadius * t,
  );
}
