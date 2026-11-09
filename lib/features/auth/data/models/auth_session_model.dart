import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_session_model.freezed.dart';
part 'auth_session_model.g.dart';

/// `AuthResponse` of the API, returned once the user is signed in by
/// registration, login or login code reset.
///
/// Only the fields the app uses are parsed; `user` is ignored.
@freezed
abstract class AuthSessionModel with _$AuthSessionModel {
  /// Creates an [AuthSessionModel].
  const factory AuthSessionModel({
    required String accessToken,
    required String refreshToken,
    @Default(<String>[]) List<String> roles,
  }) = _AuthSessionModel;

  /// Parses an [AuthSessionModel] from [json].
  factory AuthSessionModel.fromJson(Map<String, dynamic> json) =>
      _$AuthSessionModelFromJson(json);
}
