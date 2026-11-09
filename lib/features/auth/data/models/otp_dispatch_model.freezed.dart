// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'otp_dispatch_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OtpDispatchModel {

 int get resendAfterSeconds;
/// Create a copy of OtpDispatchModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OtpDispatchModelCopyWith<OtpDispatchModel> get copyWith => _$OtpDispatchModelCopyWithImpl<OtpDispatchModel>(this as OtpDispatchModel, _$identity);

  /// Serializes this OtpDispatchModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OtpDispatchModel&&(identical(other.resendAfterSeconds, resendAfterSeconds) || other.resendAfterSeconds == resendAfterSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,resendAfterSeconds);

@override
String toString() {
  return 'OtpDispatchModel(resendAfterSeconds: $resendAfterSeconds)';
}


}

/// @nodoc
abstract mixin class $OtpDispatchModelCopyWith<$Res>  {
  factory $OtpDispatchModelCopyWith(OtpDispatchModel value, $Res Function(OtpDispatchModel) _then) = _$OtpDispatchModelCopyWithImpl;
@useResult
$Res call({
 int resendAfterSeconds
});




}
/// @nodoc
class _$OtpDispatchModelCopyWithImpl<$Res>
    implements $OtpDispatchModelCopyWith<$Res> {
  _$OtpDispatchModelCopyWithImpl(this._self, this._then);

  final OtpDispatchModel _self;
  final $Res Function(OtpDispatchModel) _then;

/// Create a copy of OtpDispatchModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? resendAfterSeconds = null,}) {
  return _then(OtpDispatchModel(
resendAfterSeconds: null == resendAfterSeconds ? _self.resendAfterSeconds : resendAfterSeconds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [OtpDispatchModel].
extension OtpDispatchModelPatterns on OtpDispatchModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OtpDispatchModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OtpDispatchModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OtpDispatchModel value)  $default,){
final _that = this;
switch (_that) {
case _OtpDispatchModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OtpDispatchModel value)?  $default,){
final _that = this;
switch (_that) {
case _OtpDispatchModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int resendAfterSeconds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OtpDispatchModel() when $default != null:
return $default(_that.resendAfterSeconds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int resendAfterSeconds)  $default,) {final _that = this;
switch (_that) {
case _OtpDispatchModel():
return $default(_that.resendAfterSeconds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int resendAfterSeconds)?  $default,) {final _that = this;
switch (_that) {
case _OtpDispatchModel() when $default != null:
return $default(_that.resendAfterSeconds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OtpDispatchModel extends OtpDispatchModel {
  const _OtpDispatchModel({required this.resendAfterSeconds}): super._();
  factory _OtpDispatchModel.fromJson(Map<String, dynamic> json) => _$OtpDispatchModelFromJson(json);

@override final  int resendAfterSeconds;

/// Create a copy of OtpDispatchModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OtpDispatchModelCopyWith<_OtpDispatchModel> get copyWith => __$OtpDispatchModelCopyWithImpl<_OtpDispatchModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OtpDispatchModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OtpDispatchModel&&(identical(other.resendAfterSeconds, resendAfterSeconds) || other.resendAfterSeconds == resendAfterSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,resendAfterSeconds);

@override
String toString() {
  return 'OtpDispatchModel(resendAfterSeconds: $resendAfterSeconds)';
}


}

/// @nodoc
abstract mixin class _$OtpDispatchModelCopyWith<$Res> implements $OtpDispatchModelCopyWith<$Res> {
  factory _$OtpDispatchModelCopyWith(_OtpDispatchModel value, $Res Function(_OtpDispatchModel) _then) = __$OtpDispatchModelCopyWithImpl;
@override @useResult
$Res call({
 int resendAfterSeconds
});




}
/// @nodoc
class __$OtpDispatchModelCopyWithImpl<$Res>
    implements _$OtpDispatchModelCopyWith<$Res> {
  __$OtpDispatchModelCopyWithImpl(this._self, this._then);

  final _OtpDispatchModel _self;
  final $Res Function(_OtpDispatchModel) _then;

/// Create a copy of OtpDispatchModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? resendAfterSeconds = null,}) {
  return _then(_OtpDispatchModel(
resendAfterSeconds: null == resendAfterSeconds ? _self.resendAfterSeconds : resendAfterSeconds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
