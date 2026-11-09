// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LoginResult {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginResult);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginResult()';
}


}

/// @nodoc
class $LoginResultCopyWith<$Res>  {
$LoginResultCopyWith(LoginResult _, $Res Function(LoginResult) __);
}


/// Adds pattern-matching-related methods to [LoginResult].
extension LoginResultPatterns on LoginResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoginAuthenticated value)?  authenticated,TResult Function( LoginDeviceVerificationRequired value)?  deviceVerificationRequired,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoginAuthenticated() when authenticated != null:
return authenticated(_that);case LoginDeviceVerificationRequired() when deviceVerificationRequired != null:
return deviceVerificationRequired(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoginAuthenticated value)  authenticated,required TResult Function( LoginDeviceVerificationRequired value)  deviceVerificationRequired,}){
final _that = this;
switch (_that) {
case LoginAuthenticated():
return authenticated(_that);case LoginDeviceVerificationRequired():
return deviceVerificationRequired(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoginAuthenticated value)?  authenticated,TResult? Function( LoginDeviceVerificationRequired value)?  deviceVerificationRequired,}){
final _that = this;
switch (_that) {
case LoginAuthenticated() when authenticated != null:
return authenticated(_that);case LoginDeviceVerificationRequired() when deviceVerificationRequired != null:
return deviceVerificationRequired(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  authenticated,TResult Function( String challengeId,  OtpDispatch otp)?  deviceVerificationRequired,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoginAuthenticated() when authenticated != null:
return authenticated();case LoginDeviceVerificationRequired() when deviceVerificationRequired != null:
return deviceVerificationRequired(_that.challengeId,_that.otp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  authenticated,required TResult Function( String challengeId,  OtpDispatch otp)  deviceVerificationRequired,}) {final _that = this;
switch (_that) {
case LoginAuthenticated():
return authenticated();case LoginDeviceVerificationRequired():
return deviceVerificationRequired(_that.challengeId,_that.otp);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  authenticated,TResult? Function( String challengeId,  OtpDispatch otp)?  deviceVerificationRequired,}) {final _that = this;
switch (_that) {
case LoginAuthenticated() when authenticated != null:
return authenticated();case LoginDeviceVerificationRequired() when deviceVerificationRequired != null:
return deviceVerificationRequired(_that.challengeId,_that.otp);case _:
  return null;

}
}

}

/// @nodoc


class LoginAuthenticated implements LoginResult {
  const LoginAuthenticated();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginAuthenticated);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginResult.authenticated()';
}


}




/// @nodoc


class LoginDeviceVerificationRequired implements LoginResult {
  const LoginDeviceVerificationRequired({required this.challengeId, required this.otp});
  

 final  String challengeId;
 final  OtpDispatch otp;

/// Create a copy of LoginResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginDeviceVerificationRequiredCopyWith<LoginDeviceVerificationRequired> get copyWith => _$LoginDeviceVerificationRequiredCopyWithImpl<LoginDeviceVerificationRequired>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginDeviceVerificationRequired&&(identical(other.challengeId, challengeId) || other.challengeId == challengeId)&&(identical(other.otp, otp) || other.otp == otp));
}


@override
int get hashCode => Object.hash(runtimeType,challengeId,otp);

@override
String toString() {
  return 'LoginResult.deviceVerificationRequired(challengeId: $challengeId, otp: $otp)';
}


}

/// @nodoc
abstract mixin class $LoginDeviceVerificationRequiredCopyWith<$Res> implements $LoginResultCopyWith<$Res> {
  factory $LoginDeviceVerificationRequiredCopyWith(LoginDeviceVerificationRequired value, $Res Function(LoginDeviceVerificationRequired) _then) = _$LoginDeviceVerificationRequiredCopyWithImpl;
@useResult
$Res call({
 String challengeId, OtpDispatch otp
});


$OtpDispatchCopyWith<$Res> get otp;

}
/// @nodoc
class _$LoginDeviceVerificationRequiredCopyWithImpl<$Res>
    implements $LoginDeviceVerificationRequiredCopyWith<$Res> {
  _$LoginDeviceVerificationRequiredCopyWithImpl(this._self, this._then);

  final LoginDeviceVerificationRequired _self;
  final $Res Function(LoginDeviceVerificationRequired) _then;

/// Create a copy of LoginResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? challengeId = null,Object? otp = null,}) {
  return _then(LoginDeviceVerificationRequired(
challengeId: null == challengeId ? _self.challengeId : challengeId // ignore: cast_nullable_to_non_nullable
as String,otp: null == otp ? _self.otp : otp // ignore: cast_nullable_to_non_nullable
as OtpDispatch,
  ));
}

/// Create a copy of LoginResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OtpDispatchCopyWith<$Res> get otp {
  
  return $OtpDispatchCopyWith<$Res>(_self.otp, (value) {
    return _then(_self.copyWith(otp: value));
  });
}
}

// dart format on
