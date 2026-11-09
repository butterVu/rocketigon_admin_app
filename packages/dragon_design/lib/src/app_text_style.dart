import 'package:flutter/material.dart';

import 'app_color.dart';

class AppTextStyle {
  AppTextStyle._();

  static const String fontFamily = 'GoogleSansFlex';
  static const String _package = 'dragon_design';

  static const FontWeight fontRegular = FontWeight.w400;
  static const FontWeight fontMedium = FontWeight.w500;
  static const FontWeight fontSemibold = FontWeight.w600;
  static const FontWeight fontBold = FontWeight.w700;

  static const _baseTextStyle = TextStyle(
    fontFamily: fontFamily,
    package: _package,
    color: AppColor.text,
    letterSpacing: -0.4,
  );

  /// Google Sans Flex là variable font nên cần set cả trục `wght`
  /// để độ đậm hiển thị đúng trên mọi nền tảng.
  static TextStyle _style(double fontSize, FontWeight fontWeight) =>
      _baseTextStyle.merge(
        TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontVariations: [FontVariation.weight(fontWeight.value.toDouble())],
        ),
      );

  // Regular
  static TextStyle regular10() => _style(10, fontRegular);
  static TextStyle regular11() => _style(11, fontRegular);
  static TextStyle regular12() => _style(12, fontRegular);
  static TextStyle regular13() => _style(13, fontRegular);
  static TextStyle regular14() => _style(14, fontRegular);
  static TextStyle regular15() => _style(15, fontRegular);
  static TextStyle regular16() => _style(16, fontRegular);
  static TextStyle regular18() => _style(18, fontRegular);
  static TextStyle regular20() => _style(20, fontRegular);
  static TextStyle regular24() => _style(24, fontRegular);
  static TextStyle regular28() => _style(28, fontRegular);
  static TextStyle regular32() => _style(32, fontRegular);

  // Medium
  static TextStyle medium10() => _style(10, fontMedium);
  static TextStyle medium11() => _style(11, fontMedium);
  static TextStyle medium12() => _style(12, fontMedium);
  static TextStyle medium13() => _style(13, fontMedium);
  static TextStyle medium14() => _style(14, fontMedium);
  static TextStyle medium15() => _style(15, fontMedium);
  static TextStyle medium16() => _style(16, fontMedium);
  static TextStyle medium18() => _style(18, fontMedium);
  static TextStyle medium20() => _style(20, fontMedium);
  static TextStyle medium24() => _style(24, fontMedium);
  static TextStyle medium28() => _style(28, fontMedium);
  static TextStyle medium32() => _style(32, fontMedium);

  // Semibold
  static TextStyle semibold10() => _style(10, fontSemibold);
  static TextStyle semibold11() => _style(11, fontSemibold);
  static TextStyle semibold12() => _style(12, fontSemibold);
  static TextStyle semibold13() => _style(13, fontSemibold);
  static TextStyle semibold14() => _style(14, fontSemibold);
  static TextStyle semibold15() => _style(15, fontSemibold);
  static TextStyle semibold16() => _style(16, fontSemibold);
  static TextStyle semibold17() => _style(17, fontSemibold);
  static TextStyle semibold18() => _style(18, fontSemibold);
  static TextStyle semibold20() => _style(20, fontSemibold);
  static TextStyle semibold24() => _style(24, fontSemibold);
  static TextStyle semibold28() => _style(28, fontSemibold);
  static TextStyle semibold32() => _style(32, fontSemibold);

  // Bold
  static TextStyle bold10() => _style(10, fontBold);
  static TextStyle bold11() => _style(11, fontBold);
  static TextStyle bold12() => _style(12, fontBold);
  static TextStyle bold13() => _style(13, fontBold);
  static TextStyle bold14() => _style(14, fontBold);
  static TextStyle bold15() => _style(15, fontBold);
  static TextStyle bold16() => _style(16, fontBold);
  static TextStyle bold18() => _style(18, fontBold);
  static TextStyle bold20() => _style(20, fontBold);
  static TextStyle bold24() => _style(24, fontBold);
  static TextStyle bold28() => _style(28, fontBold);
  static TextStyle bold32() => _style(32, fontBold);
}
