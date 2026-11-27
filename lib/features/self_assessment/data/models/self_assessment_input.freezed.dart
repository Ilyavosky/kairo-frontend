// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'self_assessment_input.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SelfAssessmentInput {

@JsonKey(name: 'estado_animo') int get mood;@JsonKey(name: 'satisfaccion') int get satisfaction;@JsonKey(name: 'nota') String? get note;
/// Create a copy of SelfAssessmentInput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SelfAssessmentInputCopyWith<SelfAssessmentInput> get copyWith => _$SelfAssessmentInputCopyWithImpl<SelfAssessmentInput>(this as SelfAssessmentInput, _$identity);

  /// Serializes this SelfAssessmentInput to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelfAssessmentInput&&(identical(other.mood, mood) || other.mood == mood)&&(identical(other.satisfaction, satisfaction) || other.satisfaction == satisfaction)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mood,satisfaction,note);

@override
String toString() {
  return 'SelfAssessmentInput(mood: $mood, satisfaction: $satisfaction, note: $note)';
}


}

/// @nodoc
abstract mixin class $SelfAssessmentInputCopyWith<$Res>  {
  factory $SelfAssessmentInputCopyWith(SelfAssessmentInput value, $Res Function(SelfAssessmentInput) _then) = _$SelfAssessmentInputCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'estado_animo') int mood,@JsonKey(name: 'satisfaccion') int satisfaction,@JsonKey(name: 'nota') String? note
});




}
/// @nodoc
class _$SelfAssessmentInputCopyWithImpl<$Res>
    implements $SelfAssessmentInputCopyWith<$Res> {
  _$SelfAssessmentInputCopyWithImpl(this._self, this._then);

  final SelfAssessmentInput _self;
  final $Res Function(SelfAssessmentInput) _then;

/// Create a copy of SelfAssessmentInput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mood = null,Object? satisfaction = null,Object? note = freezed,}) {
  return _then(_self.copyWith(
mood: null == mood ? _self.mood : mood // ignore: cast_nullable_to_non_nullable
as int,satisfaction: null == satisfaction ? _self.satisfaction : satisfaction // ignore: cast_nullable_to_non_nullable
as int,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SelfAssessmentInput].
extension SelfAssessmentInputPatterns on SelfAssessmentInput {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SelfAssessmentInput value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SelfAssessmentInput() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SelfAssessmentInput value)  $default,){
final _that = this;
switch (_that) {
case _SelfAssessmentInput():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SelfAssessmentInput value)?  $default,){
final _that = this;
switch (_that) {
case _SelfAssessmentInput() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'estado_animo')  int mood, @JsonKey(name: 'satisfaccion')  int satisfaction, @JsonKey(name: 'nota')  String? note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SelfAssessmentInput() when $default != null:
return $default(_that.mood,_that.satisfaction,_that.note);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'estado_animo')  int mood, @JsonKey(name: 'satisfaccion')  int satisfaction, @JsonKey(name: 'nota')  String? note)  $default,) {final _that = this;
switch (_that) {
case _SelfAssessmentInput():
return $default(_that.mood,_that.satisfaction,_that.note);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'estado_animo')  int mood, @JsonKey(name: 'satisfaccion')  int satisfaction, @JsonKey(name: 'nota')  String? note)?  $default,) {final _that = this;
switch (_that) {
case _SelfAssessmentInput() when $default != null:
return $default(_that.mood,_that.satisfaction,_that.note);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SelfAssessmentInput implements SelfAssessmentInput {
  const _SelfAssessmentInput({@JsonKey(name: 'estado_animo') required this.mood, @JsonKey(name: 'satisfaccion') required this.satisfaction, @JsonKey(name: 'nota') this.note});
  factory _SelfAssessmentInput.fromJson(Map<String, dynamic> json) => _$SelfAssessmentInputFromJson(json);

@override@JsonKey(name: 'estado_animo') final  int mood;
@override@JsonKey(name: 'satisfaccion') final  int satisfaction;
@override@JsonKey(name: 'nota') final  String? note;

/// Create a copy of SelfAssessmentInput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelfAssessmentInputCopyWith<_SelfAssessmentInput> get copyWith => __$SelfAssessmentInputCopyWithImpl<_SelfAssessmentInput>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SelfAssessmentInputToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SelfAssessmentInput&&(identical(other.mood, mood) || other.mood == mood)&&(identical(other.satisfaction, satisfaction) || other.satisfaction == satisfaction)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mood,satisfaction,note);

@override
String toString() {
  return 'SelfAssessmentInput(mood: $mood, satisfaction: $satisfaction, note: $note)';
}


}

/// @nodoc
abstract mixin class _$SelfAssessmentInputCopyWith<$Res> implements $SelfAssessmentInputCopyWith<$Res> {
  factory _$SelfAssessmentInputCopyWith(_SelfAssessmentInput value, $Res Function(_SelfAssessmentInput) _then) = __$SelfAssessmentInputCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'estado_animo') int mood,@JsonKey(name: 'satisfaccion') int satisfaction,@JsonKey(name: 'nota') String? note
});




}
/// @nodoc
class __$SelfAssessmentInputCopyWithImpl<$Res>
    implements _$SelfAssessmentInputCopyWith<$Res> {
  __$SelfAssessmentInputCopyWithImpl(this._self, this._then);

  final _SelfAssessmentInput _self;
  final $Res Function(_SelfAssessmentInput) _then;

/// Create a copy of SelfAssessmentInput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mood = null,Object? satisfaction = null,Object? note = freezed,}) {
  return _then(_SelfAssessmentInput(
mood: null == mood ? _self.mood : mood // ignore: cast_nullable_to_non_nullable
as int,satisfaction: null == satisfaction ? _self.satisfaction : satisfaction // ignore: cast_nullable_to_non_nullable
as int,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
