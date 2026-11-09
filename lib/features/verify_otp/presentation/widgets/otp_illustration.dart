import 'package:dragon_design/dragon_design.dart';
import 'package:flutter/material.dart';

/// Phone outline with a chat bubble, hinting that a code was sent.
///
/// Replace with an illustration asset once the design provides one.
class OtpIllustration extends StatelessWidget {
  /// Creates an [OtpIllustration].
  const OtpIllustration({super.key});

  static const _phoneWidth = 170.0;
  static const _height = 140.0;

  @override
  Widget build(BuildContext context) => const SizedBox(
    height: _height,
    child: Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        _PhoneOutline(width: _phoneWidth, height: _height - 30),
        Positioned(
          top: 0,
          child: Padding(
            padding: EdgeInsets.only(left: _phoneWidth * 0.75),
            child: _ChatBubble(),
          ),
        ),
      ],
    ),
  );
}

class _PhoneOutline extends StatelessWidget {
  const _PhoneOutline({required this.width, required this.height});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) => ShaderMask(
    // Fades the bottom of the phone into the background.
    shaderCallback: (bounds) => const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.white, Colors.transparent],
    ).createShader(bounds),
    blendMode: BlendMode.dstIn,
    child: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColor.surfaceVariant,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        border: Border.all(color: AppColor.border, width: 6),
      ),
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        width: 48,
        height: 10,
        decoration: BoxDecoration(
          color: AppColor.border,
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    ),
  );
}

class _ChatBubble extends StatelessWidget {
  const _ChatBubble();

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    decoration: BoxDecoration(
      color: AppColor.primary,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
        bottomRight: Radius.circular(16),
        bottomLeft: Radius.circular(4),
      ),
      boxShadow: [
        BoxShadow(
          color: AppColor.primary.withValues(alpha: 0.3),
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _Dot(),
        SizedBox(width: 6),
        _Dot(),
        SizedBox(width: 6),
        _Dot(),
      ],
    ),
  );
}

class _Dot extends StatelessWidget {
  const _Dot();

  @override
  Widget build(BuildContext context) => const DecoratedBox(
    decoration: BoxDecoration(color: AppColor.surface, shape: BoxShape.circle),
    child: SizedBox.square(dimension: 12),
  );
}
