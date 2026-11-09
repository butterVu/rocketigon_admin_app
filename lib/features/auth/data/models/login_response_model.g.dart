// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LoginResponseModel _$LoginResponseModelFromJson(Map<String, dynamic> json) =>
    _LoginResponseModel(
      nextStep: json['nextStep'] as String,
      auth: json['auth'] == null
          ? null
          : AuthSessionModel.fromJson(json['auth'] as Map<String, dynamic>),
      challengeId: json['challengeId'] as String?,
      otp: json['otp'] == null
          ? null
          : OtpDispatchModel.fromJson(json['otp'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginResponseModelToJson(_LoginResponseModel instance) =>
    <String, dynamic>{
      'nextStep': instance.nextStep,
      'auth': instance.auth?.toJson(),
      'challengeId': instance.challengeId,
      'otp': instance.otp?.toJson(),
    };
