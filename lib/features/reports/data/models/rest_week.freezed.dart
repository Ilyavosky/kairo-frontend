// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rest_week.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RestWeek {

@JsonKey(name: 'semana_desde') DateTime get weekStart;@JsonKey(name: 'minutos_academicos') double get academicMinutes;@JsonKey(name: 'minutos_sueno') double get sleepMinutes;@JsonKey(name: 'minutos_ejercicio') double get exerciseMinutes;@JsonKey(name: 'estado_animo') int? get mood;@JsonKey(name: 'satisfaccion') int? get satisfaction;
/// Create a copy of RestWeek
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RestWeekCopyWith<RestWeek> get copyWith => _$RestWeekCopyWithImpl<RestWeek>(this as RestWeek, _$identity);

  /// Serializes this RestWeek to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RestWeek&&(identical(other.weekStart, weekStart) || other.weekStart == weekStart)&&(identical(other.academicMinutes, academicMinutes) || other.academicMinutes == academicMinutes)&&(identical(other.sleepMinutes, sleepMinutes) || other.sleepMinutes == sleepMinutes)&&(identical(other.exerciseMinutes, exerciseMinutes) || other.exerciseMinutes == exerciseMinutes)&&(identical(other.mood, mood) || other.mood == mood)&&(identical(other.satisfaction, satisfaction) || other.satisfaction == satisfaction));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,weekStart,academicMinutes,sleepMinutes,exerciseMinutes,mood,satisfaction);

@override
String toString() {
  return 'RestWeek(weekStart: $weekStart, academicMinutes: $academicMinutes, sleepMinutes: $sleepMinutes, exerciseMinutes: $exerciseMinutes, mood: $mood, satisfaction: $satisfaction)';
}


}

/// @nodoc
abstract mixin class $RestWeekCopyWith<$Res>  {
  factory $RestWeekCopyWith(RestWeek value, $Res Function(RestWeek) _then) = _$RestWeekCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'semana_desde') DateTime weekStart,@JsonKey(name: 'minutos_academicos') double academicMinutes,@JsonKey(name: 'minutos_sueno') double sleepMinutes,@JsonKey(name: 'minutos_ejercicio') double exerciseMinutes,@JsonKey(name: 'estado_animo') int? mood,@JsonKey(name: 'satisfaccion') int? satisfaction
});




}
/// @nodoc
class _$RestWeekCopyWithImpl<$Res>
    implements $RestWeekCopyWith<$Res> {
  _$RestWeekCopyWithImpl(this._self, this._then);

  final RestWeek _self;
  final $Res Function(RestWeek) _then;

/// Create a copy of RestWeek
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? weekStart = null,Object? academicMinutes = null,Object? sleepMinutes = null,Object? exerciseMinutes = null,Object? mood = freezed,Object? satisfaction = freezed,}) {
  return _then(_self.copyWith(
weekStart: null == weekStart ? _self.weekStart : weekStart // ignore: cast_nullable_to_non_nullable
as DateTime,academicMinutes: null == academicMinutes ? _self.academicMinutes : academicMinutes // ignore: cast_nullable_to_non_nullable
as double,sleepMinutes: null == sleepMinutes ? _self.sleepMinutes : sleepMinutes // ignore: cast_nullable_to_non_nullable
as double,exerciseMinutes: null == exerciseMinutes ? _self.exerciseMinutes : exerciseMinutes // ignore: cast_nullable_to_non_nullable
as double,mood: freezed == mood ? _self.mood : mood // ignore: cast_nullable_to_non_nullable
as int?,satisfaction: freezed == satisfaction ? _self.satisfaction : satisfaction // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [RestWeek].
extension RestWeekPatterns on RestWeek {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RestWeek value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RestWeek() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RestWeek value)  $default,){
final _that = this;
switch (_that) {
case _RestWeek():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RestWeek value)?  $default,){
final _that = this;
switch (_that) {
case _RestWeek() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'semana_desde')  DateTime weekStart, @JsonKey(name: 'minutos_academicos')  double academicMinutes, @JsonKey(name: 'minutos_sueno')  double sleepMinutes, @JsonKey(name: 'minutos_ejercicio')  double exerciseMinutes, @JsonKey(name: 'estado_animo')  int? mood, @JsonKey(name: 'satisfaccion')  int? satisfaction)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RestWeek() when $default != null:
return $default(_that.weekStart,_that.academicMinutes,_that.sleepMinutes,_that.exerciseMinutes,_that.mood,_that.satisfaction);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'semana_desde')  DateTime weekStart, @JsonKey(name: 'minutos_academicos')  double academicMinutes, @JsonKey(name: 'minutos_sueno')  double sleepMinutes, @JsonKey(name: 'minutos_ejercicio')  double exerciseMinutes, @JsonKey(name: 'estado_animo')  int? mood, @JsonKey(name: 'satisfaccion')  int? satisfaction)  $default,) {final _that = this;
switch (_that) {
case _RestWeek():
return $default(_that.weekStart,_that.academicMinutes,_that.sleepMinutes,_that.exerciseMinutes,_that.mood,_that.satisfaction);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'semana_desde')  DateTime weekStart, @JsonKey(name: 'minutos_academicos')  double academicMinutes, @JsonKey(name: 'minutos_sueno')  double sleepMinutes, @JsonKey(name: 'minutos_ejercicio')  double exerciseMinutes, @JsonKey(name: 'estado_animo')  int? mood, @JsonKey(name: 'satisfaccion')  int? satisfaction)?  $default,) {final _that = this;
switch (_that) {
case _RestWeek() when $default != null:
return $default(_that.weekStart,_that.academicMinutes,_that.sleepMinutes,_that.exerciseMinutes,_that.mood,_that.satisfaction);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RestWeek implements RestWeek {
  const _RestWeek({@JsonKey(name: 'semana_desde') required this.weekStart, @JsonKey(name: 'minutos_academicos') required this.academicMinutes, @JsonKey(name: 'minutos_sueno') required this.sleepMinutes, @JsonKey(name: 'minutos_ejercicio') required this.exerciseMinutes, @JsonKey(name: 'estado_animo') this.mood, @JsonKey(name: 'satisfaccion') this.satisfaction});
  factory _RestWeek.fromJson(Map<String, dynamic> json) => _$RestWeekFromJson(json);

@override@JsonKey(name: 'semana_desde') final  DateTime weekStart;
@override@JsonKey(name: 'minutos_academicos') final  double academicMinutes;
@override@JsonKey(name: 'minutos_sueno') final  double sleepMinutes;
@override@JsonKey(name: 'minutos_ejercicio') final  double exerciseMinutes;
@override@JsonKey(name: 'estado_animo') final  int? mood;
@override@JsonKey(name: 'satisfaccion') final  int? satisfaction;

/// Create a copy of RestWeek
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RestWeekCopyWith<_RestWeek> get copyWith => __$RestWeekCopyWithImpl<_RestWeek>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RestWeekToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RestWeek&&(identical(other.weekStart, weekStart) || other.weekStart == weekStart)&&(identical(other.academicMinutes, academicMinutes) || other.academicMinutes == academicMinutes)&&(identical(other.sleepMinutes, sleepMinutes) || other.sleepMinutes == sleepMinutes)&&(identical(other.exerciseMinutes, exerciseMinutes) || other.exerciseMinutes == exerciseMinutes)&&(identical(other.mood, mood) || other.mood == mood)&&(identical(other.satisfaction, satisfaction) || other.satisfaction == satisfaction));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,weekStart,academicMinutes,sleepMinutes,exerciseMinutes,mood,satisfaction);

@override
String toString() {
  return 'RestWeek(weekStart: $weekStart, academicMinutes: $academicMinutes, sleepMinutes: $sleepMinutes, exerciseMinutes: $exerciseMinutes, mood: $mood, satisfaction: $satisfaction)';
}


}

/// @nodoc
abstract mixin class _$RestWeekCopyWith<$Res> implements $RestWeekCopyWith<$Res> {
  factory _$RestWeekCopyWith(_RestWeek value, $Res Function(_RestWeek) _then) = __$RestWeekCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'semana_desde') DateTime weekStart,@JsonKey(name: 'minutos_academicos') double academicMinutes,@JsonKey(name: 'minutos_sueno') double sleepMinutes,@JsonKey(name: 'minutos_ejercicio') double exerciseMinutes,@JsonKey(name: 'estado_animo') int? mood,@JsonKey(name: 'satisfaccion') int? satisfaction
});




}
/// @nodoc
class __$RestWeekCopyWithImpl<$Res>
    implements _$RestWeekCopyWith<$Res> {
  __$RestWeekCopyWithImpl(this._self, this._then);

  final _RestWeek _self;
  final $Res Function(_RestWeek) _then;

/// Create a copy of RestWeek
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? weekStart = null,Object? academicMinutes = null,Object? sleepMinutes = null,Object? exerciseMinutes = null,Object? mood = freezed,Object? satisfaction = freezed,}) {
  return _then(_RestWeek(
weekStart: null == weekStart ? _self.weekStart : weekStart // ignore: cast_nullable_to_non_nullable
as DateTime,academicMinutes: null == academicMinutes ? _self.academicMinutes : academicMinutes // ignore: cast_nullable_to_non_nullable
as double,sleepMinutes: null == sleepMinutes ? _self.sleepMinutes : sleepMinutes // ignore: cast_nullable_to_non_nullable
as double,exerciseMinutes: null == exerciseMinutes ? _self.exerciseMinutes : exerciseMinutes // ignore: cast_nullable_to_non_nullable
as double,mood: freezed == mood ? _self.mood : mood // ignore: cast_nullable_to_non_nullable
as int?,satisfaction: freezed == satisfaction ? _self.satisfaction : satisfaction // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
