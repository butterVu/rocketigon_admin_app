// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verify_otp_arguments.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VerifyOtpArguments {

 PhoneNumber get phoneNumber;/// Login challenge returned by the server for the new device.
 String get challengeId;/// Waiting time before the code may be resent, from the server.
 Duration get resendAfter; int get codeLength;
/// Create a copy of VerifyOtpArguments
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerifyOtpArgumentsCopyWith<VerifyOtpArguments> get copyWith => _$VerifyOtpArgumentsCopyWithImpl<VerifyOtpArguments>(this as VerifyOtpArguments, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyOtpArguments&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.challengeId, challengeId) || other.challengeId == challengeId)&&(identical(other.resendAfter, resendAfter) || other.resendAfter == resendAfter)&&(identical(other.codeLength, codeLength) || other.codeLength == codeLength));
}


@override
int get hashCode => Object.hash(runtimeType,phoneNumber,challengeId,resendAfter,codeLength);

@override
String toString() {
  return 'VerifyOtpArguments(phoneNumber: $phoneNumber, challengeId: $challengeId, resendAfter: $resendAfter, codeLength: $codeLength)';
}


}

/// @nodoc
abstract mixin class $VerifyOtpArgumentsCopyWith<$Res>  {
  factory $VerifyOtpArgumentsCopyWith(VerifyOtpArguments value, $Res Function(VerifyOtpArguments) _then) = _$VerifyOtpArgumentsCopyWithImpl;
@useResult
$Res call({
 PhoneNumber phoneNumber, String challengeId, Duration resendAfter, int codeLength
});


$PhoneNumberCopyWith<$Res> get phoneNumber;

}
/// @nodoc
class _$VerifyOtpArgumentsCopyWithImpl<$Res>
    implements $VerifyOtpArgumentsCopyWith<$Res> {
  _$VerifyOtpArgumentsCopyWithImpl(this._self, this._then);

  final VerifyOtpArguments _self;
  final $Res Function(VerifyOtpArguments) _then;

/// Create a copy of VerifyOtpArguments
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phoneNumber = null,Object? challengeId = null,Object? resendAfter = null,Object? codeLength = null,}) {
  return _then(VerifyOtpArguments(
phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as PhoneNumber,challengeId: null == challengeId ? _self.challengeId : challengeId // ignore: cast_nullable_to_non_nullable
as String,resendAfter: null == resendAfter ? _self.resendAfter : resendAfter // ignore: cast_nullable_to_non_nullable
as Duration,codeLength: null == codeLength ? _self.codeLength : codeLength // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of VerifyOtpArguments
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PhoneNumberCopyWith<$Res> get phoneNumber {
  
  return $PhoneNumberCopyWith<$Res>(_self.phoneNumber, (value) {
    return _then(_self.copyWith(phoneNumber: value));
  });
}
}


/// Adds pattern-matching-related methods to [VerifyOtpArguments].
extension VerifyOtpArgumentsPatterns on VerifyOtpArguments {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VerifyOtpArguments value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VerifyOtpArguments() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VerifyOtpArguments value)  $default,){
final _that = this;
switch (_that) {
case _VerifyOtpArguments():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VerifyOtpArguments value)?  $default,){
final _that = this;
switch (_that) {
case _VerifyOtpArguments() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PhoneNumber phoneNumber,  String challengeId,  Duration resendAfter,  int codeLength)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VerifyOtpArguments() when $default != null:
return $default(_that.phoneNumber,_that.challengeId,_that.resendAfter,_that.codeLength);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PhoneNumber phoneNumber,  String challengeId,  Duration resendAfter,  int codeLength)  $default,) {final _that = this;
switch (_that) {
case _VerifyOtpArguments():
return $default(_that.phoneNumber,_that.challengeId,_that.resendAfter,_that.codeLength);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PhoneNumber phoneNumber,  String challengeId,  Duration resendAfter,  int codeLength)?  $default,) {final _that = this;
switch (_that) {
case _VerifyOtpArguments() when $default != null:
return $default(_that.phoneNumber,_that.challengeId,_that.resendAfter,_that.codeLength);case _:
  return null;

}
}

}

/// @nodoc


class _VerifyOtpArguments extends VerifyOtpArguments {
  const _VerifyOtpArguments({required this.phoneNumber, required this.challengeId, this.resendAfter = const Duration(seconds: 60), this.codeLength = 4}): super._();
  

@override final  PhoneNumber phoneNumber;
/// Login challenge returned by the server for the new device.
@override final  String challengeId;
/// Waiting time before the code may be resent, from the server.
@override@JsonKey() final  Duration resendAfter;
@override@JsonKey() final  int codeLength;

/// Create a copy of VerifyOtpArguments
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerifyOtpArgumentsCopyWith<_VerifyOtpArguments> get copyWith => __$VerifyOtpArgumentsCopyWithImpl<_VerifyOtpArguments>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerifyOtpArguments&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.challengeId, challengeId) || other.challengeId == challengeId)&&(identical(other.resendAfter, resendAfter) || other.resendAfter == resendAfter)&&(identical(other.codeLength, codeLength) || other.codeLength == codeLength));
}


@override
int get hashCode => Object.hash(runtimeType,phoneNumber,challengeId,resendAfter,codeLength);

@override
String toString() {
  return 'VerifyOtpArguments(phoneNumber: $phoneNumber, challengeId: $challengeId, resendAfter: $resendAfter, codeLength: $codeLength)';
}


}

/// @nodoc
abstract mixin class _$VerifyOtpArgumentsCopyWith<$Res> implements $VerifyOtpArgumentsCopyWith<$Res> {
  factory _$VerifyOtpArgumentsCopyWith(_VerifyOtpArguments value, $Res Function(_VerifyOtpArguments) _then) = __$VerifyOtpArgumentsCopyWithImpl;
@override @useResult
$Res call({
 PhoneNumber phoneNumber, String challengeId, Duration resendAfter, int codeLength
});


@override $PhoneNumberCopyWith<$Res> get phoneNumber;

}
/// @nodoc
class __$VerifyOtpArgumentsCopyWithImpl<$Res>
    implements _$VerifyOtpArgumentsCopyWith<$Res> {
  __$VerifyOtpArgumentsCopyWithImpl(this._self, this._then);

  final _VerifyOtpArguments _self;
  final $Res Function(_VerifyOtpArguments) _then;

/// Create a copy of VerifyOtpArguments
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phoneNumber = null,Object? challengeId = null,Object? resendAfter = null,Object? codeLength = null,}) {
  return _then(_VerifyOtpArguments(
phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as PhoneNumber,challengeId: null == challengeId ? _self.challengeId : challengeId // ignore: cast_nullable_to_non_nullable
as String,resendAfter: null == resendAfter ? _self.resendAfter : resendAfter // ignore: cast_nullable_to_non_nullable
as Duration,codeLength: null == codeLength ? _self.codeLength : codeLength // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of VerifyOtpArguments
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PhoneNumberCopyWith<$Res> get phoneNumber {
  
  return $PhoneNumberCopyWith<$Res>(_self.phoneNumber, (value) {
    return _then(_self.copyWith(phoneNumber: value));
  });
}
}

// dart format on
