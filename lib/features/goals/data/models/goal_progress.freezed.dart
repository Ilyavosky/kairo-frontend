// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'goal_progress.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GoalProgress {

@JsonKey(name: 'meta_id') String get goalId;@JsonKey(name: 'objetivo') int get target;@JsonKey(name: 'periodo_desde') DateTime get periodStart;@JsonKey(name: 'periodo_hasta') DateTime get periodEnd;@JsonKey(name: 'progreso') double get progress;@JsonKey(name: 'porcentaje') double get percent;@JsonKey(name: 'cumplida') bool get achieved;
/// Create a copy of GoalProgress
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GoalProgressCopyWith<GoalProgress> get copyWith => _$GoalProgressCopyWithImpl<GoalProgress>(this as GoalProgress, _$identity);

  /// Serializes this GoalProgress to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GoalProgress&&(identical(other.goalId, goalId) || other.goalId == goalId)&&(identical(other.target, target) || other.target == target)&&(identical(other.periodStart, periodStart) || other.periodStart == periodStart)&&(identical(other.periodEnd, periodEnd) || other.periodEnd == periodEnd)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.percent, percent) || other.percent == percent)&&(identical(other.achieved, achieved) || other.achieved == achieved));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,goalId,target,periodStart,periodEnd,progress,percent,achieved);

@override
String toString() {
  return 'GoalProgress(goalId: $goalId, target: $target, periodStart: $periodStart, periodEnd: $periodEnd, progress: $progress, percent: $percent, achieved: $achieved)';
}


}

/// @nodoc
abstract mixin class $GoalProgressCopyWith<$Res>  {
  factory $GoalProgressCopyWith(GoalProgress value, $Res Function(GoalProgress) _then) = _$GoalProgressCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'meta_id') String goalId,@JsonKey(name: 'objetivo') int target,@JsonKey(name: 'periodo_desde') DateTime periodStart,@JsonKey(name: 'periodo_hasta') DateTime periodEnd,@JsonKey(name: 'progreso') double progress,@JsonKey(name: 'porcentaje') double percent,@JsonKey(name: 'cumplida') bool achieved
});




}
/// @nodoc
class _$GoalProgressCopyWithImpl<$Res>
    implements $GoalProgressCopyWith<$Res> {
  _$GoalProgressCopyWithImpl(this._self, this._then);

  final GoalProgress _self;
  final $Res Function(GoalProgress) _then;

/// Create a copy of GoalProgress
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? goalId = null,Object? target = null,Object? periodStart = null,Object? periodEnd = null,Object? progress = null,Object? percent = null,Object? achieved = null,}) {
  return _then(_self.copyWith(
goalId: null == goalId ? _self.goalId : goalId // ignore: cast_nullable_to_non_nullable
as String,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as int,periodStart: null == periodStart ? _self.periodStart : periodStart // ignore: cast_nullable_to_non_nullable
as DateTime,periodEnd: null == periodEnd ? _self.periodEnd : periodEnd // ignore: cast_nullable_to_non_nullable
as DateTime,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,percent: null == percent ? _self.percent : percent // ignore: cast_nullable_to_non_nullable
as double,achieved: null == achieved ? _self.achieved : achieved // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [GoalProgress].
extension GoalProgressPatterns on GoalProgress {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GoalProgress value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GoalProgress() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GoalProgress value)  $default,){
final _that = this;
switch (_that) {
case _GoalProgress():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GoalProgress value)?  $default,){
final _that = this;
switch (_that) {
case _GoalProgress() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'meta_id')  String goalId, @JsonKey(name: 'objetivo')  int target, @JsonKey(name: 'periodo_desde')  DateTime periodStart, @JsonKey(name: 'periodo_hasta')  DateTime periodEnd, @JsonKey(name: 'progreso')  double progress, @JsonKey(name: 'porcentaje')  double percent, @JsonKey(name: 'cumplida')  bool achieved)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GoalProgress() when $default != null:
return $default(_that.goalId,_that.target,_that.periodStart,_that.periodEnd,_that.progress,_that.percent,_that.achieved);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'meta_id')  String goalId, @JsonKey(name: 'objetivo')  int target, @JsonKey(name: 'periodo_desde')  DateTime periodStart, @JsonKey(name: 'periodo_hasta')  DateTime periodEnd, @JsonKey(name: 'progreso')  double progress, @JsonKey(name: 'porcentaje')  double percent, @JsonKey(name: 'cumplida')  bool achieved)  $default,) {final _that = this;
switch (_that) {
case _GoalProgress():
return $default(_that.goalId,_that.target,_that.periodStart,_that.periodEnd,_that.progress,_that.percent,_that.achieved);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'meta_id')  String goalId, @JsonKey(name: 'objetivo')  int target, @JsonKey(name: 'periodo_desde')  DateTime periodStart, @JsonKey(name: 'periodo_hasta')  DateTime periodEnd, @JsonKey(name: 'progreso')  double progress, @JsonKey(name: 'porcentaje')  double percent, @JsonKey(name: 'cumplida')  bool achieved)?  $default,) {final _that = this;
switch (_that) {
case _GoalProgress() when $default != null:
return $default(_that.goalId,_that.target,_that.periodStart,_that.periodEnd,_that.progress,_that.percent,_that.achieved);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GoalProgress implements GoalProgress {
  const _GoalProgress({@JsonKey(name: 'meta_id') required this.goalId, @JsonKey(name: 'objetivo') required this.target, @JsonKey(name: 'periodo_desde') required this.periodStart, @JsonKey(name: 'periodo_hasta') required this.periodEnd, @JsonKey(name: 'progreso') required this.progress, @JsonKey(name: 'porcentaje') required this.percent, @JsonKey(name: 'cumplida') required this.achieved});
  factory _GoalProgress.fromJson(Map<String, dynamic> json) => _$GoalProgressFromJson(json);

@override@JsonKey(name: 'meta_id') final  String goalId;
@override@JsonKey(name: 'objetivo') final  int target;
@override@JsonKey(name: 'periodo_desde') final  DateTime periodStart;
@override@JsonKey(name: 'periodo_hasta') final  DateTime periodEnd;
@override@JsonKey(name: 'progreso') final  double progress;
@override@JsonKey(name: 'porcentaje') final  double percent;
@override@JsonKey(name: 'cumplida') final  bool achieved;

/// Create a copy of GoalProgress
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GoalProgressCopyWith<_GoalProgress> get copyWith => __$GoalProgressCopyWithImpl<_GoalProgress>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GoalProgressToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GoalProgress&&(identical(other.goalId, goalId) || other.goalId == goalId)&&(identical(other.target, target) || other.target == target)&&(identical(other.periodStart, periodStart) || other.periodStart == periodStart)&&(identical(other.periodEnd, periodEnd) || other.periodEnd == periodEnd)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.percent, percent) || other.percent == percent)&&(identical(other.achieved, achieved) || other.achieved == achieved));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,goalId,target,periodStart,periodEnd,progress,percent,achieved);

@override
String toString() {
  return 'GoalProgress(goalId: $goalId, target: $target, periodStart: $periodStart, periodEnd: $periodEnd, progress: $progress, percent: $percent, achieved: $achieved)';
}


}

/// @nodoc
abstract mixin class _$GoalProgressCopyWith<$Res> implements $GoalProgressCopyWith<$Res> {
  factory _$GoalProgressCopyWith(_GoalProgress value, $Res Function(_GoalProgress) _then) = __$GoalProgressCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'meta_id') String goalId,@JsonKey(name: 'objetivo') int target,@JsonKey(name: 'periodo_desde') DateTime periodStart,@JsonKey(name: 'periodo_hasta') DateTime periodEnd,@JsonKey(name: 'progreso') double progress,@JsonKey(name: 'porcentaje') double percent,@JsonKey(name: 'cumplida') bool achieved
});




}
/// @nodoc
class __$GoalProgressCopyWithImpl<$Res>
    implements _$GoalProgressCopyWith<$Res> {
  __$GoalProgressCopyWithImpl(this._self, this._then);

  final _GoalProgress _self;
  final $Res Function(_GoalProgress) _then;

/// Create a copy of GoalProgress
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? goalId = null,Object? target = null,Object? periodStart = null,Object? periodEnd = null,Object? progress = null,Object? percent = null,Object? achieved = null,}) {
  return _then(_GoalProgress(
goalId: null == goalId ? _self.goalId : goalId // ignore: cast_nullable_to_non_nullable
as String,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as int,periodStart: null == periodStart ? _self.periodStart : periodStart // ignore: cast_nullable_to_non_nullable
as DateTime,periodEnd: null == periodEnd ? _self.periodEnd : periodEnd // ignore: cast_nullable_to_non_nullable
as DateTime,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,percent: null == percent ? _self.percent : percent // ignore: cast_nullable_to_non_nullable
as double,achieved: null == achieved ? _self.achieved : achieved // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
