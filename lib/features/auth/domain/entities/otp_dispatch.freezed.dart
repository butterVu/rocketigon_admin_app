// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'otp_dispatch.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OtpDispatch {

/// Time before another code may be requested.
 Duration get resendAfter;
/// Create a copy of OtpDispatch
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OtpDispatchCopyWith<OtpDispatch> get copyWith => _$OtpDispatchCopyWithImpl<OtpDispatch>(this as OtpDispatch, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OtpDispatch&&(identical(other.resendAfter, resendAfter) || other.resendAfter == resendAfter));
}


@override
int get hashCode => Object.hash(runtimeType,resendAfter);

@override
String toString() {
  return 'OtpDispatch(resendAfter: $resendAfter)';
}


}

/// @nodoc
abstract mixin class $OtpDispatchCopyWith<$Res>  {
  factory $OtpDispatchCopyWith(OtpDispatch value, $Res Function(OtpDispatch) _then) = _$OtpDispatchCopyWithImpl;
@useResult
$Res call({
 Duration resendAfter
});




}
/// @nodoc
class _$OtpDispatchCopyWithImpl<$Res>
    implements $OtpDispatchCopyWith<$Res> {
  _$OtpDispatchCopyWithImpl(this._self, this._then);

  final OtpDispatch _self;
  final $Res Function(OtpDispatch) _then;

/// Create a copy of OtpDispatch
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? resendAfter = null,}) {
  return _then(OtpDispatch(
resendAfter: null == resendAfter ? _self.resendAfter : resendAfter // ignore: cast_nullable_to_non_nullable
as Duration,
  ));
}

}


/// Adds pattern-matching-related methods to [OtpDispatch].
extension OtpDispatchPatterns on OtpDispatch {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OtpDispatch value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OtpDispatch() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OtpDispatch value)  $default,){
final _that = this;
switch (_that) {
case _OtpDispatch():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OtpDispatch value)?  $default,){
final _that = this;
switch (_that) {
case _OtpDispatch() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Duration resendAfter)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OtpDispatch() when $default != null:
return $default(_that.resendAfter);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Duration resendAfter)  $default,) {final _that = this;
switch (_that) {
case _OtpDispatch():
return $default(_that.resendAfter);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Duration resendAfter)?  $default,) {final _that = this;
switch (_that) {
case _OtpDispatch() when $default != null:
return $default(_that.resendAfter);case _:
  return null;

}
}

}

/// @nodoc


class _OtpDispatch implements OtpDispatch {
  const _OtpDispatch({required this.resendAfter});
  

/// Time before another code may be requested.
@override final  Duration resendAfter;

/// Create a copy of OtpDispatch
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OtpDispatchCopyWith<_OtpDispatch> get copyWith => __$OtpDispatchCopyWithImpl<_OtpDispatch>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OtpDispatch&&(identical(other.resendAfter, resendAfter) || other.resendAfter == resendAfter));
}


@override
int get hashCode => Object.hash(runtimeType,resendAfter);

@override
String toString() {
  return 'OtpDispatch(resendAfter: $resendAfter)';
}


}

/// @nodoc
abstract mixin class _$OtpDispatchCopyWith<$Res> implements $OtpDispatchCopyWith<$Res> {
  factory _$OtpDispatchCopyWith(_OtpDispatch value, $Res Function(_OtpDispatch) _then) = __$OtpDispatchCopyWithImpl;
@override @useResult
$Res call({
 Duration resendAfter
});




}
/// @nodoc
class __$OtpDispatchCopyWithImpl<$Res>
    implements _$OtpDispatchCopyWith<$Res> {
  __$OtpDispatchCopyWithImpl(this._self, this._then);

  final _OtpDispatch _self;
  final $Res Function(_OtpDispatch) _then;

/// Create a copy of OtpDispatch
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? resendAfter = null,}) {
  return _then(_OtpDispatch(
resendAfter: null == resendAfter ? _self.resendAfter : resendAfter // ignore: cast_nullable_to_non_nullable
as Duration,
  ));
}


}

// dart format on
