import 'package:freezed_annotation/freezed_annotation.dart';

part 'phone_number.freezed.dart';

/// Phone number split into its dial code and national part.
@freezed
abstract class PhoneNumber with _$PhoneNumber {
  const PhoneNumber._();

  /// Creates a [PhoneNumber].
  ///
  /// [nationalNumber] must not contain the trunk prefix `0`.
  const factory PhoneNumber({
    required String dialCode,
    required String nationalNumber,
  }) = _PhoneNumber;

  /// Dial code of Vietnam, the only country the CMS accepts.
  static const vietnamDialCode = '+84';

  /// Parses a Vietnamese number typed by the user, with or without the
  /// leading trunk `0`. Returns `null` when it is not 9 or 10 digits.
  static PhoneNumber? tryParseVietnam(String input) {
    final digits = input.startsWith('0') ? input.substring(1) : input;
    if (!RegExp(r'^\d{9,10}$').hasMatch(digits)) return null;
    return PhoneNumber(dialCode: vietnamDialCode, nationalNumber: digits);
  }

  /// E.164 format sent to the API, e.g. `+84983975038`.
  String get e164 => '$dialCode$nationalNumber';

  /// Grouped for display, e.g. `+84 983 975 038`.
  String get display {
    final groups = RegExp(r'\d{1,3}').allMatches(nationalNumber);
    return [dialCode, ...groups.map((group) => group[0])].join(' ');
  }
}
