// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'goal_report.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GoalReport {

@JsonKey(name: 'meta_id') String get goalId;@JsonKey(name: 'categoria') String get category;@JsonKey(name: 'tipo') GoalType get type;@JsonKey(name: 'periodo') GoalPeriod get period;@JsonKey(name: 'objetivo') int get target;@JsonKey(name: 'progreso') double get progress;@JsonKey(name: 'porcentaje') double get percent;@JsonKey(name: 'cumplida') bool get achieved;
/// Create a copy of GoalReport
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GoalReportCopyWith<GoalReport> get copyWith => _$GoalReportCopyWithImpl<GoalReport>(this as GoalReport, _$identity);

  /// Serializes this GoalReport to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GoalReport&&(identical(other.goalId, goalId) || other.goalId == goalId)&&(identical(other.category, category) || other.category == category)&&(identical(other.type, type) || other.type == type)&&(identical(other.period, period) || other.period == period)&&(identical(other.target, target) || other.target == target)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.percent, percent) || other.percent == percent)&&(identical(other.achieved, achieved) || other.achieved == achieved));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,goalId,category,type,period,target,progress,percent,achieved);

@override
String toString() {
  return 'GoalReport(goalId: $goalId, category: $category, type: $type, period: $period, target: $target, progress: $progress, percent: $percent, achieved: $achieved)';
}


}

/// @nodoc
abstract mixin class $GoalReportCopyWith<$Res>  {
  factory $GoalReportCopyWith(GoalReport value, $Res Function(GoalReport) _then) = _$GoalReportCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'meta_id') String goalId,@JsonKey(name: 'categoria') String category,@JsonKey(name: 'tipo') GoalType type,@JsonKey(name: 'periodo') GoalPeriod period,@JsonKey(name: 'objetivo') int target,@JsonKey(name: 'progreso') double progress,@JsonKey(name: 'porcentaje') double percent,@JsonKey(name: 'cumplida') bool achieved
});




}
/// @nodoc
class _$GoalReportCopyWithImpl<$Res>
    implements $GoalReportCopyWith<$Res> {
  _$GoalReportCopyWithImpl(this._self, this._then);

  final GoalReport _self;
  final $Res Function(GoalReport) _then;

/// Create a copy of GoalReport
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? goalId = null,Object? category = null,Object? type = null,Object? period = null,Object? target = null,Object? progress = null,Object? percent = null,Object? achieved = null,}) {
  return _then(_self.copyWith(
goalId: null == goalId ? _self.goalId : goalId // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as GoalType,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as GoalPeriod,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as int,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,percent: null == percent ? _self.percent : percent // ignore: cast_nullable_to_non_nullable
as double,achieved: null == achieved ? _self.achieved : achieved // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [GoalReport].
extension GoalReportPatterns on GoalReport {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GoalReport value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GoalReport() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GoalReport value)  $default,){
final _that = this;
switch (_that) {
case _GoalReport():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GoalReport value)?  $default,){
final _that = this;
switch (_that) {
case _GoalReport() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'meta_id')  String goalId, @JsonKey(name: 'categoria')  String category, @JsonKey(name: 'tipo')  GoalType type, @JsonKey(name: 'periodo')  GoalPeriod period, @JsonKey(name: 'objetivo')  int target, @JsonKey(name: 'progreso')  double progress, @JsonKey(name: 'porcentaje')  double percent, @JsonKey(name: 'cumplida')  bool achieved)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GoalReport() when $default != null:
return $default(_that.goalId,_that.category,_that.type,_that.period,_that.target,_that.progress,_that.percent,_that.achieved);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'meta_id')  String goalId, @JsonKey(name: 'categoria')  String category, @JsonKey(name: 'tipo')  GoalType type, @JsonKey(name: 'periodo')  GoalPeriod period, @JsonKey(name: 'objetivo')  int target, @JsonKey(name: 'progreso')  double progress, @JsonKey(name: 'porcentaje')  double percent, @JsonKey(name: 'cumplida')  bool achieved)  $default,) {final _that = this;
switch (_that) {
case _GoalReport():
return $default(_that.goalId,_that.category,_that.type,_that.period,_that.target,_that.progress,_that.percent,_that.achieved);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'meta_id')  String goalId, @JsonKey(name: 'categoria')  String category, @JsonKey(name: 'tipo')  GoalType type, @JsonKey(name: 'periodo')  GoalPeriod period, @JsonKey(name: 'objetivo')  int target, @JsonKey(name: 'progreso')  double progress, @JsonKey(name: 'porcentaje')  double percent, @JsonKey(name: 'cumplida')  bool achieved)?  $default,) {final _that = this;
switch (_that) {
case _GoalReport() when $default != null:
return $default(_that.goalId,_that.category,_that.type,_that.period,_that.target,_that.progress,_that.percent,_that.achieved);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GoalReport implements GoalReport {
  const _GoalReport({@JsonKey(name: 'meta_id') required this.goalId, @JsonKey(name: 'categoria') required this.category, @JsonKey(name: 'tipo') required this.type, @JsonKey(name: 'periodo') required this.period, @JsonKey(name: 'objetivo') required this.target, @JsonKey(name: 'progreso') required this.progress, @JsonKey(name: 'porcentaje') required this.percent, @JsonKey(name: 'cumplida') required this.achieved});
  factory _GoalReport.fromJson(Map<String, dynamic> json) => _$GoalReportFromJson(json);

@override@JsonKey(name: 'meta_id') final  String goalId;
@override@JsonKey(name: 'categoria') final  String category;
@override@JsonKey(name: 'tipo') final  GoalType type;
@override@JsonKey(name: 'periodo') final  GoalPeriod period;
@override@JsonKey(name: 'objetivo') final  int target;
@override@JsonKey(name: 'progreso') final  double progress;
@override@JsonKey(name: 'porcentaje') final  double percent;
@override@JsonKey(name: 'cumplida') final  bool achieved;

/// Create a copy of GoalReport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GoalReportCopyWith<_GoalReport> get copyWith => __$GoalReportCopyWithImpl<_GoalReport>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GoalReportToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GoalReport&&(identical(other.goalId, goalId) || other.goalId == goalId)&&(identical(other.category, category) || other.category == category)&&(identical(other.type, type) || other.type == type)&&(identical(other.period, period) || other.period == period)&&(identical(other.target, target) || other.target == target)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.percent, percent) || other.percent == percent)&&(identical(other.achieved, achieved) || other.achieved == achieved));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,goalId,category,type,period,target,progress,percent,achieved);

@override
String toString() {
  return 'GoalReport(goalId: $goalId, category: $category, type: $type, period: $period, target: $target, progress: $progress, percent: $percent, achieved: $achieved)';
}


}

/// @nodoc
abstract mixin class _$GoalReportCopyWith<$Res> implements $GoalReportCopyWith<$Res> {
  factory _$GoalReportCopyWith(_GoalReport value, $Res Function(_GoalReport) _then) = __$GoalReportCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'meta_id') String goalId,@JsonKey(name: 'categoria') String category,@JsonKey(name: 'tipo') GoalType type,@JsonKey(name: 'periodo') GoalPeriod period,@JsonKey(name: 'objetivo') int target,@JsonKey(name: 'progreso') double progress,@JsonKey(name: 'porcentaje') double percent,@JsonKey(name: 'cumplida') bool achieved
});




}
/// @nodoc
class __$GoalReportCopyWithImpl<$Res>
    implements _$GoalReportCopyWith<$Res> {
  __$GoalReportCopyWithImpl(this._self, this._then);

  final _GoalReport _self;
  final $Res Function(_GoalReport) _then;

/// Create a copy of GoalReport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? goalId = null,Object? category = null,Object? type = null,Object? period = null,Object? target = null,Object? progress = null,Object? percent = null,Object? achieved = null,}) {
  return _then(_GoalReport(
goalId: null == goalId ? _self.goalId : goalId // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as GoalType,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as GoalPeriod,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as int,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,percent: null == percent ? _self.percent : percent // ignore: cast_nullable_to_non_nullable
as double,achieved: null == achieved ? _self.achieved : achieved // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
