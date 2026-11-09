// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LoginResponseModel {

/// [loginStepAuthenticated] or [loginStepDeviceVerification].
 String get nextStep;/// Session, set when [nextStep] is [loginStepAuthenticated].
 AuthSessionModel? get auth;/// Device verification id, set with [otp].
 String? get challengeId; OtpDispatchModel? get otp;
/// Create a copy of LoginResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginResponseModelCopyWith<LoginResponseModel> get copyWith => _$LoginResponseModelCopyWithImpl<LoginResponseModel>(this as LoginResponseModel, _$identity);

  /// Serializes this LoginResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginResponseModel&&(identical(other.nextStep, nextStep) || other.nextStep == nextStep)&&(identical(other.auth, auth) || other.auth == auth)&&(identical(other.challengeId, challengeId) || other.challengeId == challengeId)&&(identical(other.otp, otp) || other.otp == otp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,nextStep,auth,challengeId,otp);

@override
String toString() {
  return 'LoginResponseModel(nextStep: $nextStep, auth: $auth, challengeId: $challengeId, otp: $otp)';
}


}

/// @nodoc
abstract mixin class $LoginResponseModelCopyWith<$Res>  {
  factory $LoginResponseModelCopyWith(LoginResponseModel value, $Res Function(LoginResponseModel) _then) = _$LoginResponseModelCopyWithImpl;
@useResult
$Res call({
 String nextStep, AuthSessionModel? auth, String? challengeId, OtpDispatchModel? otp
});


$AuthSessionModelCopyWith<$Res>? get auth;$OtpDispatchModelCopyWith<$Res>? get otp;

}
/// @nodoc
class _$LoginResponseModelCopyWithImpl<$Res>
    implements $LoginResponseModelCopyWith<$Res> {
  _$LoginResponseModelCopyWithImpl(this._self, this._then);

  final LoginResponseModel _self;
  final $Res Function(LoginResponseModel) _then;

/// Create a copy of LoginResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? nextStep = null,Object? auth = freezed,Object? challengeId = freezed,Object? otp = freezed,}) {
  return _then(LoginResponseModel(
nextStep: null == nextStep ? _self.nextStep : nextStep // ignore: cast_nullable_to_non_nullable
as String,auth: freezed == auth ? _self.auth : auth // ignore: cast_nullable_to_non_nullable
as AuthSessionModel?,challengeId: freezed == challengeId ? _self.challengeId : challengeId // ignore: cast_nullable_to_non_nullable
as String?,otp: freezed == otp ? _self.otp : otp // ignore: cast_nullable_to_non_nullable
as OtpDispatchModel?,
  ));
}
/// Create a copy of LoginResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthSessionModelCopyWith<$Res>? get auth {
    if (_self.auth == null) {
    return null;
  }

  return $AuthSessionModelCopyWith<$Res>(_self.auth!, (value) {
    return _then(_self.copyWith(auth: value));
  });
}/// Create a copy of LoginResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OtpDispatchModelCopyWith<$Res>? get otp {
    if (_self.otp == null) {
    return null;
  }

  return $OtpDispatchModelCopyWith<$Res>(_self.otp!, (value) {
    return _then(_self.copyWith(otp: value));
  });
}
}


/// Adds pattern-matching-related methods to [LoginResponseModel].
extension LoginResponseModelPatterns on LoginResponseModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LoginResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoginResponseModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LoginResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _LoginResponseModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LoginResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _LoginResponseModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String nextStep,  AuthSessionModel? auth,  String? challengeId,  OtpDispatchModel? otp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoginResponseModel() when $default != null:
return $default(_that.nextStep,_that.auth,_that.challengeId,_that.otp);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String nextStep,  AuthSessionModel? auth,  String? challengeId,  OtpDispatchModel? otp)  $default,) {final _that = this;
switch (_that) {
case _LoginResponseModel():
return $default(_that.nextStep,_that.auth,_that.challengeId,_that.otp);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String nextStep,  AuthSessionModel? auth,  String? challengeId,  OtpDispatchModel? otp)?  $default,) {final _that = this;
switch (_that) {
case _LoginResponseModel() when $default != null:
return $default(_that.nextStep,_that.auth,_that.challengeId,_that.otp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LoginResponseModel implements LoginResponseModel {
  const _LoginResponseModel({required this.nextStep, this.auth, this.challengeId, this.otp});
  factory _LoginResponseModel.fromJson(Map<String, dynamic> json) => _$LoginResponseModelFromJson(json);

/// [loginStepAuthenticated] or [loginStepDeviceVerification].
@override final  String nextStep;
/// Session, set when [nextStep] is [loginStepAuthenticated].
@override final  AuthSessionModel? auth;
/// Device verification id, set with [otp].
@override final  String? challengeId;
@override final  OtpDispatchModel? otp;

/// Create a copy of LoginResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginResponseModelCopyWith<_LoginResponseModel> get copyWith => __$LoginResponseModelCopyWithImpl<_LoginResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LoginResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginResponseModel&&(identical(other.nextStep, nextStep) || other.nextStep == nextStep)&&(identical(other.auth, auth) || other.auth == auth)&&(identical(other.challengeId, challengeId) || other.challengeId == challengeId)&&(identical(other.otp, otp) || other.otp == otp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,nextStep,auth,challengeId,otp);

@override
String toString() {
  return 'LoginResponseModel(nextStep: $nextStep, auth: $auth, challengeId: $challengeId, otp: $otp)';
}


}

/// @nodoc
abstract mixin class _$LoginResponseModelCopyWith<$Res> implements $LoginResponseModelCopyWith<$Res> {
  factory _$LoginResponseModelCopyWith(_LoginResponseModel value, $Res Function(_LoginResponseModel) _then) = __$LoginResponseModelCopyWithImpl;
@override @useResult
$Res call({
 String nextStep, AuthSessionModel? auth, String? challengeId, OtpDispatchModel? otp
});


@override $AuthSessionModelCopyWith<$Res>? get auth;@override $OtpDispatchModelCopyWith<$Res>? get otp;

}
/// @nodoc
class __$LoginResponseModelCopyWithImpl<$Res>
    implements _$LoginResponseModelCopyWith<$Res> {
  __$LoginResponseModelCopyWithImpl(this._self, this._then);

  final _LoginResponseModel _self;
  final $Res Function(_LoginResponseModel) _then;

/// Create a copy of LoginResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nextStep = null,Object? auth = freezed,Object? challengeId = freezed,Object? otp = freezed,}) {
  return _then(_LoginResponseModel(
nextStep: null == nextStep ? _self.nextStep : nextStep // ignore: cast_nullable_to_non_nullable
as String,auth: freezed == auth ? _self.auth : auth // ignore: cast_nullable_to_non_nullable
as AuthSessionModel?,challengeId: freezed == challengeId ? _self.challengeId : challengeId // ignore: cast_nullable_to_non_nullable
as String?,otp: freezed == otp ? _self.otp : otp // ignore: cast_nullable_to_non_nullable
as OtpDispatchModel?,
  ));
}

/// Create a copy of LoginResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthSessionModelCopyWith<$Res>? get auth {
    if (_self.auth == null) {
    return null;
  }

  return $AuthSessionModelCopyWith<$Res>(_self.auth!, (value) {
    return _then(_self.copyWith(auth: value));
  });
}/// Create a copy of LoginResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OtpDispatchModelCopyWith<$Res>? get otp {
    if (_self.otp == null) {
    return null;
  }

  return $OtpDispatchModelCopyWith<$Res>(_self.otp!, (value) {
    return _then(_self.copyWith(otp: value));
  });
}
}

// dart format on
