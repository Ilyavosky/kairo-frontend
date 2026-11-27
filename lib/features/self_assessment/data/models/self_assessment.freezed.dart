// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'self_assessment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SelfAssessment {

@JsonKey(name: 'semana_desde') DateTime get weekStart;@JsonKey(name: 'estado_animo') int get mood;@JsonKey(name: 'satisfaccion') int get satisfaction;@JsonKey(name: 'creada_en') DateTime get createdAt;@JsonKey(name: 'actualizada_en') DateTime get updatedAt;@JsonKey(name: 'nota') String? get note;
/// Create a copy of SelfAssessment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SelfAssessmentCopyWith<SelfAssessment> get copyWith => _$SelfAssessmentCopyWithImpl<SelfAssessment>(this as SelfAssessment, _$identity);

  /// Serializes this SelfAssessment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelfAssessment&&(identical(other.weekStart, weekStart) || other.weekStart == weekStart)&&(identical(other.mood, mood) || other.mood == mood)&&(identical(other.satisfaction, satisfaction) || other.satisfaction == satisfaction)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,weekStart,mood,satisfaction,createdAt,updatedAt,note);

@override
String toString() {
  return 'SelfAssessment(weekStart: $weekStart, mood: $mood, satisfaction: $satisfaction, createdAt: $createdAt, updatedAt: $updatedAt, note: $note)';
}


}

/// @nodoc
abstract mixin class $SelfAssessmentCopyWith<$Res>  {
  factory $SelfAssessmentCopyWith(SelfAssessment value, $Res Function(SelfAssessment) _then) = _$SelfAssessmentCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'semana_desde') DateTime weekStart,@JsonKey(name: 'estado_animo') int mood,@JsonKey(name: 'satisfaccion') int satisfaction,@JsonKey(name: 'creada_en') DateTime createdAt,@JsonKey(name: 'actualizada_en') DateTime updatedAt,@JsonKey(name: 'nota') String? note
});




}
/// @nodoc
class _$SelfAssessmentCopyWithImpl<$Res>
    implements $SelfAssessmentCopyWith<$Res> {
  _$SelfAssessmentCopyWithImpl(this._self, this._then);

  final SelfAssessment _self;
  final $Res Function(SelfAssessment) _then;

/// Create a copy of SelfAssessment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? weekStart = null,Object? mood = null,Object? satisfaction = null,Object? createdAt = null,Object? updatedAt = null,Object? note = freezed,}) {
  return _then(_self.copyWith(
weekStart: null == weekStart ? _self.weekStart : weekStart // ignore: cast_nullable_to_non_nullable
as DateTime,mood: null == mood ? _self.mood : mood // ignore: cast_nullable_to_non_nullable
as int,satisfaction: null == satisfaction ? _self.satisfaction : satisfaction // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SelfAssessment].
extension SelfAssessmentPatterns on SelfAssessment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SelfAssessment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SelfAssessment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SelfAssessment value)  $default,){
final _that = this;
switch (_that) {
case _SelfAssessment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SelfAssessment value)?  $default,){
final _that = this;
switch (_that) {
case _SelfAssessment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'semana_desde')  DateTime weekStart, @JsonKey(name: 'estado_animo')  int mood, @JsonKey(name: 'satisfaccion')  int satisfaction, @JsonKey(name: 'creada_en')  DateTime createdAt, @JsonKey(name: 'actualizada_en')  DateTime updatedAt, @JsonKey(name: 'nota')  String? note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SelfAssessment() when $default != null:
return $default(_that.weekStart,_that.mood,_that.satisfaction,_that.createdAt,_that.updatedAt,_that.note);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'semana_desde')  DateTime weekStart, @JsonKey(name: 'estado_animo')  int mood, @JsonKey(name: 'satisfaccion')  int satisfaction, @JsonKey(name: 'creada_en')  DateTime createdAt, @JsonKey(name: 'actualizada_en')  DateTime updatedAt, @JsonKey(name: 'nota')  String? note)  $default,) {final _that = this;
switch (_that) {
case _SelfAssessment():
return $default(_that.weekStart,_that.mood,_that.satisfaction,_that.createdAt,_that.updatedAt,_that.note);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'semana_desde')  DateTime weekStart, @JsonKey(name: 'estado_animo')  int mood, @JsonKey(name: 'satisfaccion')  int satisfaction, @JsonKey(name: 'creada_en')  DateTime createdAt, @JsonKey(name: 'actualizada_en')  DateTime updatedAt, @JsonKey(name: 'nota')  String? note)?  $default,) {final _that = this;
switch (_that) {
case _SelfAssessment() when $default != null:
return $default(_that.weekStart,_that.mood,_that.satisfaction,_that.createdAt,_that.updatedAt,_that.note);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SelfAssessment implements SelfAssessment {
  const _SelfAssessment({@JsonKey(name: 'semana_desde') required this.weekStart, @JsonKey(name: 'estado_animo') required this.mood, @JsonKey(name: 'satisfaccion') required this.satisfaction, @JsonKey(name: 'creada_en') required this.createdAt, @JsonKey(name: 'actualizada_en') required this.updatedAt, @JsonKey(name: 'nota') this.note});
  factory _SelfAssessment.fromJson(Map<String, dynamic> json) => _$SelfAssessmentFromJson(json);

@override@JsonKey(name: 'semana_desde') final  DateTime weekStart;
@override@JsonKey(name: 'estado_animo') final  int mood;
@override@JsonKey(name: 'satisfaccion') final  int satisfaction;
@override@JsonKey(name: 'creada_en') final  DateTime createdAt;
@override@JsonKey(name: 'actualizada_en') final  DateTime updatedAt;
@override@JsonKey(name: 'nota') final  String? note;

/// Create a copy of SelfAssessment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelfAssessmentCopyWith<_SelfAssessment> get copyWith => __$SelfAssessmentCopyWithImpl<_SelfAssessment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SelfAssessmentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SelfAssessment&&(identical(other.weekStart, weekStart) || other.weekStart == weekStart)&&(identical(other.mood, mood) || other.mood == mood)&&(identical(other.satisfaction, satisfaction) || other.satisfaction == satisfaction)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,weekStart,mood,satisfaction,createdAt,updatedAt,note);

@override
String toString() {
  return 'SelfAssessment(weekStart: $weekStart, mood: $mood, satisfaction: $satisfaction, createdAt: $createdAt, updatedAt: $updatedAt, note: $note)';
}


}

/// @nodoc
abstract mixin class _$SelfAssessmentCopyWith<$Res> implements $SelfAssessmentCopyWith<$Res> {
  factory _$SelfAssessmentCopyWith(_SelfAssessment value, $Res Function(_SelfAssessment) _then) = __$SelfAssessmentCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'semana_desde') DateTime weekStart,@JsonKey(name: 'estado_animo') int mood,@JsonKey(name: 'satisfaccion') int satisfaction,@JsonKey(name: 'creada_en') DateTime createdAt,@JsonKey(name: 'actualizada_en') DateTime updatedAt,@JsonKey(name: 'nota') String? note
});




}
/// @nodoc
class __$SelfAssessmentCopyWithImpl<$Res>
    implements _$SelfAssessmentCopyWith<$Res> {
  __$SelfAssessmentCopyWithImpl(this._self, this._then);

  final _SelfAssessment _self;
  final $Res Function(_SelfAssessment) _then;

/// Create a copy of SelfAssessment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? weekStart = null,Object? mood = null,Object? satisfaction = null,Object? createdAt = null,Object? updatedAt = null,Object? note = freezed,}) {
  return _then(_SelfAssessment(
weekStart: null == weekStart ? _self.weekStart : weekStart // ignore: cast_nullable_to_non_nullable
as DateTime,mood: null == mood ? _self.mood : mood // ignore: cast_nullable_to_non_nullable
as int,satisfaction: null == satisfaction ? _self.satisfaction : satisfaction // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
