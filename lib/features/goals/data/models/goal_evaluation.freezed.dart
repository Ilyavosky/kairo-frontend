// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'goal_evaluation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GoalEvaluation {

 String get id;@JsonKey(name: 'meta_id') String get goalId;@JsonKey(name: 'periodo_desde') DateTime get periodStart;@JsonKey(name: 'periodo_hasta') DateTime get periodEnd;@JsonKey(name: 'objetivo') int get target;@JsonKey(name: 'valor_logrado') double get achievedValue;@JsonKey(name: 'cumplida') bool get achieved;
/// Create a copy of GoalEvaluation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GoalEvaluationCopyWith<GoalEvaluation> get copyWith => _$GoalEvaluationCopyWithImpl<GoalEvaluation>(this as GoalEvaluation, _$identity);

  /// Serializes this GoalEvaluation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GoalEvaluation&&(identical(other.id, id) || other.id == id)&&(identical(other.goalId, goalId) || other.goalId == goalId)&&(identical(other.periodStart, periodStart) || other.periodStart == periodStart)&&(identical(other.periodEnd, periodEnd) || other.periodEnd == periodEnd)&&(identical(other.target, target) || other.target == target)&&(identical(other.achievedValue, achievedValue) || other.achievedValue == achievedValue)&&(identical(other.achieved, achieved) || other.achieved == achieved));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,goalId,periodStart,periodEnd,target,achievedValue,achieved);

@override
String toString() {
  return 'GoalEvaluation(id: $id, goalId: $goalId, periodStart: $periodStart, periodEnd: $periodEnd, target: $target, achievedValue: $achievedValue, achieved: $achieved)';
}


}

/// @nodoc
abstract mixin class $GoalEvaluationCopyWith<$Res>  {
  factory $GoalEvaluationCopyWith(GoalEvaluation value, $Res Function(GoalEvaluation) _then) = _$GoalEvaluationCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'meta_id') String goalId,@JsonKey(name: 'periodo_desde') DateTime periodStart,@JsonKey(name: 'periodo_hasta') DateTime periodEnd,@JsonKey(name: 'objetivo') int target,@JsonKey(name: 'valor_logrado') double achievedValue,@JsonKey(name: 'cumplida') bool achieved
});




}
/// @nodoc
class _$GoalEvaluationCopyWithImpl<$Res>
    implements $GoalEvaluationCopyWith<$Res> {
  _$GoalEvaluationCopyWithImpl(this._self, this._then);

  final GoalEvaluation _self;
  final $Res Function(GoalEvaluation) _then;

/// Create a copy of GoalEvaluation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? goalId = null,Object? periodStart = null,Object? periodEnd = null,Object? target = null,Object? achievedValue = null,Object? achieved = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,goalId: null == goalId ? _self.goalId : goalId // ignore: cast_nullable_to_non_nullable
as String,periodStart: null == periodStart ? _self.periodStart : periodStart // ignore: cast_nullable_to_non_nullable
as DateTime,periodEnd: null == periodEnd ? _self.periodEnd : periodEnd // ignore: cast_nullable_to_non_nullable
as DateTime,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as int,achievedValue: null == achievedValue ? _self.achievedValue : achievedValue // ignore: cast_nullable_to_non_nullable
as double,achieved: null == achieved ? _self.achieved : achieved // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [GoalEvaluation].
extension GoalEvaluationPatterns on GoalEvaluation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GoalEvaluation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GoalEvaluation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GoalEvaluation value)  $default,){
final _that = this;
switch (_that) {
case _GoalEvaluation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GoalEvaluation value)?  $default,){
final _that = this;
switch (_that) {
case _GoalEvaluation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'meta_id')  String goalId, @JsonKey(name: 'periodo_desde')  DateTime periodStart, @JsonKey(name: 'periodo_hasta')  DateTime periodEnd, @JsonKey(name: 'objetivo')  int target, @JsonKey(name: 'valor_logrado')  double achievedValue, @JsonKey(name: 'cumplida')  bool achieved)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GoalEvaluation() when $default != null:
return $default(_that.id,_that.goalId,_that.periodStart,_that.periodEnd,_that.target,_that.achievedValue,_that.achieved);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'meta_id')  String goalId, @JsonKey(name: 'periodo_desde')  DateTime periodStart, @JsonKey(name: 'periodo_hasta')  DateTime periodEnd, @JsonKey(name: 'objetivo')  int target, @JsonKey(name: 'valor_logrado')  double achievedValue, @JsonKey(name: 'cumplida')  bool achieved)  $default,) {final _that = this;
switch (_that) {
case _GoalEvaluation():
return $default(_that.id,_that.goalId,_that.periodStart,_that.periodEnd,_that.target,_that.achievedValue,_that.achieved);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'meta_id')  String goalId, @JsonKey(name: 'periodo_desde')  DateTime periodStart, @JsonKey(name: 'periodo_hasta')  DateTime periodEnd, @JsonKey(name: 'objetivo')  int target, @JsonKey(name: 'valor_logrado')  double achievedValue, @JsonKey(name: 'cumplida')  bool achieved)?  $default,) {final _that = this;
switch (_that) {
case _GoalEvaluation() when $default != null:
return $default(_that.id,_that.goalId,_that.periodStart,_that.periodEnd,_that.target,_that.achievedValue,_that.achieved);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GoalEvaluation implements GoalEvaluation {
  const _GoalEvaluation({required this.id, @JsonKey(name: 'meta_id') required this.goalId, @JsonKey(name: 'periodo_desde') required this.periodStart, @JsonKey(name: 'periodo_hasta') required this.periodEnd, @JsonKey(name: 'objetivo') required this.target, @JsonKey(name: 'valor_logrado') required this.achievedValue, @JsonKey(name: 'cumplida') required this.achieved});
  factory _GoalEvaluation.fromJson(Map<String, dynamic> json) => _$GoalEvaluationFromJson(json);

@override final  String id;
@override@JsonKey(name: 'meta_id') final  String goalId;
@override@JsonKey(name: 'periodo_desde') final  DateTime periodStart;
@override@JsonKey(name: 'periodo_hasta') final  DateTime periodEnd;
@override@JsonKey(name: 'objetivo') final  int target;
@override@JsonKey(name: 'valor_logrado') final  double achievedValue;
@override@JsonKey(name: 'cumplida') final  bool achieved;

/// Create a copy of GoalEvaluation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GoalEvaluationCopyWith<_GoalEvaluation> get copyWith => __$GoalEvaluationCopyWithImpl<_GoalEvaluation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GoalEvaluationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GoalEvaluation&&(identical(other.id, id) || other.id == id)&&(identical(other.goalId, goalId) || other.goalId == goalId)&&(identical(other.periodStart, periodStart) || other.periodStart == periodStart)&&(identical(other.periodEnd, periodEnd) || other.periodEnd == periodEnd)&&(identical(other.target, target) || other.target == target)&&(identical(other.achievedValue, achievedValue) || other.achievedValue == achievedValue)&&(identical(other.achieved, achieved) || other.achieved == achieved));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,goalId,periodStart,periodEnd,target,achievedValue,achieved);

@override
String toString() {
  return 'GoalEvaluation(id: $id, goalId: $goalId, periodStart: $periodStart, periodEnd: $periodEnd, target: $target, achievedValue: $achievedValue, achieved: $achieved)';
}


}

/// @nodoc
abstract mixin class _$GoalEvaluationCopyWith<$Res> implements $GoalEvaluationCopyWith<$Res> {
  factory _$GoalEvaluationCopyWith(_GoalEvaluation value, $Res Function(_GoalEvaluation) _then) = __$GoalEvaluationCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'meta_id') String goalId,@JsonKey(name: 'periodo_desde') DateTime periodStart,@JsonKey(name: 'periodo_hasta') DateTime periodEnd,@JsonKey(name: 'objetivo') int target,@JsonKey(name: 'valor_logrado') double achievedValue,@JsonKey(name: 'cumplida') bool achieved
});




}
/// @nodoc
class __$GoalEvaluationCopyWithImpl<$Res>
    implements _$GoalEvaluationCopyWith<$Res> {
  __$GoalEvaluationCopyWithImpl(this._self, this._then);

  final _GoalEvaluation _self;
  final $Res Function(_GoalEvaluation) _then;

/// Create a copy of GoalEvaluation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? goalId = null,Object? periodStart = null,Object? periodEnd = null,Object? target = null,Object? achievedValue = null,Object? achieved = null,}) {
  return _then(_GoalEvaluation(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,goalId: null == goalId ? _self.goalId : goalId // ignore: cast_nullable_to_non_nullable
as String,periodStart: null == periodStart ? _self.periodStart : periodStart // ignore: cast_nullable_to_non_nullable
as DateTime,periodEnd: null == periodEnd ? _self.periodEnd : periodEnd // ignore: cast_nullable_to_non_nullable
as DateTime,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as int,achievedValue: null == achievedValue ? _self.achievedValue : achievedValue // ignore: cast_nullable_to_non_nullable
as double,achieved: null == achieved ? _self.achieved : achieved // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
