// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weekly_load.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WeeklyLoad {

@JsonKey(name: 'semana_desde') DateTime get weekStart;@JsonKey(name: 'actividades_con_vencimiento') int get deliveries;@JsonKey(name: 'actividades_pendientes') int get pending;@JsonKey(name: 'minutos_registrados') double get minutes;@JsonKey(name: 'materia_id') String? get subjectId;@JsonKey(name: 'materia') String? get subject;
/// Create a copy of WeeklyLoad
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeeklyLoadCopyWith<WeeklyLoad> get copyWith => _$WeeklyLoadCopyWithImpl<WeeklyLoad>(this as WeeklyLoad, _$identity);

  /// Serializes this WeeklyLoad to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeeklyLoad&&(identical(other.weekStart, weekStart) || other.weekStart == weekStart)&&(identical(other.deliveries, deliveries) || other.deliveries == deliveries)&&(identical(other.pending, pending) || other.pending == pending)&&(identical(other.minutes, minutes) || other.minutes == minutes)&&(identical(other.subjectId, subjectId) || other.subjectId == subjectId)&&(identical(other.subject, subject) || other.subject == subject));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,weekStart,deliveries,pending,minutes,subjectId,subject);

@override
String toString() {
  return 'WeeklyLoad(weekStart: $weekStart, deliveries: $deliveries, pending: $pending, minutes: $minutes, subjectId: $subjectId, subject: $subject)';
}


}

/// @nodoc
abstract mixin class $WeeklyLoadCopyWith<$Res>  {
  factory $WeeklyLoadCopyWith(WeeklyLoad value, $Res Function(WeeklyLoad) _then) = _$WeeklyLoadCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'semana_desde') DateTime weekStart,@JsonKey(name: 'actividades_con_vencimiento') int deliveries,@JsonKey(name: 'actividades_pendientes') int pending,@JsonKey(name: 'minutos_registrados') double minutes,@JsonKey(name: 'materia_id') String? subjectId,@JsonKey(name: 'materia') String? subject
});




}
/// @nodoc
class _$WeeklyLoadCopyWithImpl<$Res>
    implements $WeeklyLoadCopyWith<$Res> {
  _$WeeklyLoadCopyWithImpl(this._self, this._then);

  final WeeklyLoad _self;
  final $Res Function(WeeklyLoad) _then;

/// Create a copy of WeeklyLoad
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? weekStart = null,Object? deliveries = null,Object? pending = null,Object? minutes = null,Object? subjectId = freezed,Object? subject = freezed,}) {
  return _then(_self.copyWith(
weekStart: null == weekStart ? _self.weekStart : weekStart // ignore: cast_nullable_to_non_nullable
as DateTime,deliveries: null == deliveries ? _self.deliveries : deliveries // ignore: cast_nullable_to_non_nullable
as int,pending: null == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as int,minutes: null == minutes ? _self.minutes : minutes // ignore: cast_nullable_to_non_nullable
as double,subjectId: freezed == subjectId ? _self.subjectId : subjectId // ignore: cast_nullable_to_non_nullable
as String?,subject: freezed == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [WeeklyLoad].
extension WeeklyLoadPatterns on WeeklyLoad {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WeeklyLoad value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WeeklyLoad() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WeeklyLoad value)  $default,){
final _that = this;
switch (_that) {
case _WeeklyLoad():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WeeklyLoad value)?  $default,){
final _that = this;
switch (_that) {
case _WeeklyLoad() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'semana_desde')  DateTime weekStart, @JsonKey(name: 'actividades_con_vencimiento')  int deliveries, @JsonKey(name: 'actividades_pendientes')  int pending, @JsonKey(name: 'minutos_registrados')  double minutes, @JsonKey(name: 'materia_id')  String? subjectId, @JsonKey(name: 'materia')  String? subject)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WeeklyLoad() when $default != null:
return $default(_that.weekStart,_that.deliveries,_that.pending,_that.minutes,_that.subjectId,_that.subject);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'semana_desde')  DateTime weekStart, @JsonKey(name: 'actividades_con_vencimiento')  int deliveries, @JsonKey(name: 'actividades_pendientes')  int pending, @JsonKey(name: 'minutos_registrados')  double minutes, @JsonKey(name: 'materia_id')  String? subjectId, @JsonKey(name: 'materia')  String? subject)  $default,) {final _that = this;
switch (_that) {
case _WeeklyLoad():
return $default(_that.weekStart,_that.deliveries,_that.pending,_that.minutes,_that.subjectId,_that.subject);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'semana_desde')  DateTime weekStart, @JsonKey(name: 'actividades_con_vencimiento')  int deliveries, @JsonKey(name: 'actividades_pendientes')  int pending, @JsonKey(name: 'minutos_registrados')  double minutes, @JsonKey(name: 'materia_id')  String? subjectId, @JsonKey(name: 'materia')  String? subject)?  $default,) {final _that = this;
switch (_that) {
case _WeeklyLoad() when $default != null:
return $default(_that.weekStart,_that.deliveries,_that.pending,_that.minutes,_that.subjectId,_that.subject);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WeeklyLoad implements WeeklyLoad {
  const _WeeklyLoad({@JsonKey(name: 'semana_desde') required this.weekStart, @JsonKey(name: 'actividades_con_vencimiento') required this.deliveries, @JsonKey(name: 'actividades_pendientes') required this.pending, @JsonKey(name: 'minutos_registrados') required this.minutes, @JsonKey(name: 'materia_id') this.subjectId, @JsonKey(name: 'materia') this.subject});
  factory _WeeklyLoad.fromJson(Map<String, dynamic> json) => _$WeeklyLoadFromJson(json);

@override@JsonKey(name: 'semana_desde') final  DateTime weekStart;
@override@JsonKey(name: 'actividades_con_vencimiento') final  int deliveries;
@override@JsonKey(name: 'actividades_pendientes') final  int pending;
@override@JsonKey(name: 'minutos_registrados') final  double minutes;
@override@JsonKey(name: 'materia_id') final  String? subjectId;
@override@JsonKey(name: 'materia') final  String? subject;

/// Create a copy of WeeklyLoad
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeeklyLoadCopyWith<_WeeklyLoad> get copyWith => __$WeeklyLoadCopyWithImpl<_WeeklyLoad>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WeeklyLoadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeeklyLoad&&(identical(other.weekStart, weekStart) || other.weekStart == weekStart)&&(identical(other.deliveries, deliveries) || other.deliveries == deliveries)&&(identical(other.pending, pending) || other.pending == pending)&&(identical(other.minutes, minutes) || other.minutes == minutes)&&(identical(other.subjectId, subjectId) || other.subjectId == subjectId)&&(identical(other.subject, subject) || other.subject == subject));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,weekStart,deliveries,pending,minutes,subjectId,subject);

@override
String toString() {
  return 'WeeklyLoad(weekStart: $weekStart, deliveries: $deliveries, pending: $pending, minutes: $minutes, subjectId: $subjectId, subject: $subject)';
}


}

/// @nodoc
abstract mixin class _$WeeklyLoadCopyWith<$Res> implements $WeeklyLoadCopyWith<$Res> {
  factory _$WeeklyLoadCopyWith(_WeeklyLoad value, $Res Function(_WeeklyLoad) _then) = __$WeeklyLoadCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'semana_desde') DateTime weekStart,@JsonKey(name: 'actividades_con_vencimiento') int deliveries,@JsonKey(name: 'actividades_pendientes') int pending,@JsonKey(name: 'minutos_registrados') double minutes,@JsonKey(name: 'materia_id') String? subjectId,@JsonKey(name: 'materia') String? subject
});




}
/// @nodoc
class __$WeeklyLoadCopyWithImpl<$Res>
    implements _$WeeklyLoadCopyWith<$Res> {
  __$WeeklyLoadCopyWithImpl(this._self, this._then);

  final _WeeklyLoad _self;
  final $Res Function(_WeeklyLoad) _then;

/// Create a copy of WeeklyLoad
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? weekStart = null,Object? deliveries = null,Object? pending = null,Object? minutes = null,Object? subjectId = freezed,Object? subject = freezed,}) {
  return _then(_WeeklyLoad(
weekStart: null == weekStart ? _self.weekStart : weekStart // ignore: cast_nullable_to_non_nullable
as DateTime,deliveries: null == deliveries ? _self.deliveries : deliveries // ignore: cast_nullable_to_non_nullable
as int,pending: null == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as int,minutes: null == minutes ? _self.minutes : minutes // ignore: cast_nullable_to_non_nullable
as double,subjectId: freezed == subjectId ? _self.subjectId : subjectId // ignore: cast_nullable_to_non_nullable
as String?,subject: freezed == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
