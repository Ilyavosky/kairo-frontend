// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reminder_input.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReminderInput {

@JsonKey(name: 'momento') DateTime get moment;@JsonKey(name: 'actividad_id') String? get activityId;@JsonKey(name: 'evento_id') String? get eventId;@JsonKey(name: 'meta_id') String? get goalId;
/// Create a copy of ReminderInput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReminderInputCopyWith<ReminderInput> get copyWith => _$ReminderInputCopyWithImpl<ReminderInput>(this as ReminderInput, _$identity);

  /// Serializes this ReminderInput to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReminderInput&&(identical(other.moment, moment) || other.moment == moment)&&(identical(other.activityId, activityId) || other.activityId == activityId)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.goalId, goalId) || other.goalId == goalId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,moment,activityId,eventId,goalId);

@override
String toString() {
  return 'ReminderInput(moment: $moment, activityId: $activityId, eventId: $eventId, goalId: $goalId)';
}


}

/// @nodoc
abstract mixin class $ReminderInputCopyWith<$Res>  {
  factory $ReminderInputCopyWith(ReminderInput value, $Res Function(ReminderInput) _then) = _$ReminderInputCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'momento') DateTime moment,@JsonKey(name: 'actividad_id') String? activityId,@JsonKey(name: 'evento_id') String? eventId,@JsonKey(name: 'meta_id') String? goalId
});




}
/// @nodoc
class _$ReminderInputCopyWithImpl<$Res>
    implements $ReminderInputCopyWith<$Res> {
  _$ReminderInputCopyWithImpl(this._self, this._then);

  final ReminderInput _self;
  final $Res Function(ReminderInput) _then;

/// Create a copy of ReminderInput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? moment = null,Object? activityId = freezed,Object? eventId = freezed,Object? goalId = freezed,}) {
  return _then(_self.copyWith(
moment: null == moment ? _self.moment : moment // ignore: cast_nullable_to_non_nullable
as DateTime,activityId: freezed == activityId ? _self.activityId : activityId // ignore: cast_nullable_to_non_nullable
as String?,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String?,goalId: freezed == goalId ? _self.goalId : goalId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ReminderInput].
extension ReminderInputPatterns on ReminderInput {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReminderInput value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReminderInput() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReminderInput value)  $default,){
final _that = this;
switch (_that) {
case _ReminderInput():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReminderInput value)?  $default,){
final _that = this;
switch (_that) {
case _ReminderInput() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'momento')  DateTime moment, @JsonKey(name: 'actividad_id')  String? activityId, @JsonKey(name: 'evento_id')  String? eventId, @JsonKey(name: 'meta_id')  String? goalId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReminderInput() when $default != null:
return $default(_that.moment,_that.activityId,_that.eventId,_that.goalId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'momento')  DateTime moment, @JsonKey(name: 'actividad_id')  String? activityId, @JsonKey(name: 'evento_id')  String? eventId, @JsonKey(name: 'meta_id')  String? goalId)  $default,) {final _that = this;
switch (_that) {
case _ReminderInput():
return $default(_that.moment,_that.activityId,_that.eventId,_that.goalId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'momento')  DateTime moment, @JsonKey(name: 'actividad_id')  String? activityId, @JsonKey(name: 'evento_id')  String? eventId, @JsonKey(name: 'meta_id')  String? goalId)?  $default,) {final _that = this;
switch (_that) {
case _ReminderInput() when $default != null:
return $default(_that.moment,_that.activityId,_that.eventId,_that.goalId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReminderInput implements ReminderInput {
  const _ReminderInput({@JsonKey(name: 'momento') required this.moment, @JsonKey(name: 'actividad_id') this.activityId, @JsonKey(name: 'evento_id') this.eventId, @JsonKey(name: 'meta_id') this.goalId});
  factory _ReminderInput.fromJson(Map<String, dynamic> json) => _$ReminderInputFromJson(json);

@override@JsonKey(name: 'momento') final  DateTime moment;
@override@JsonKey(name: 'actividad_id') final  String? activityId;
@override@JsonKey(name: 'evento_id') final  String? eventId;
@override@JsonKey(name: 'meta_id') final  String? goalId;

/// Create a copy of ReminderInput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReminderInputCopyWith<_ReminderInput> get copyWith => __$ReminderInputCopyWithImpl<_ReminderInput>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReminderInputToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReminderInput&&(identical(other.moment, moment) || other.moment == moment)&&(identical(other.activityId, activityId) || other.activityId == activityId)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.goalId, goalId) || other.goalId == goalId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,moment,activityId,eventId,goalId);

@override
String toString() {
  return 'ReminderInput(moment: $moment, activityId: $activityId, eventId: $eventId, goalId: $goalId)';
}


}

/// @nodoc
abstract mixin class _$ReminderInputCopyWith<$Res> implements $ReminderInputCopyWith<$Res> {
  factory _$ReminderInputCopyWith(_ReminderInput value, $Res Function(_ReminderInput) _then) = __$ReminderInputCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'momento') DateTime moment,@JsonKey(name: 'actividad_id') String? activityId,@JsonKey(name: 'evento_id') String? eventId,@JsonKey(name: 'meta_id') String? goalId
});




}
/// @nodoc
class __$ReminderInputCopyWithImpl<$Res>
    implements _$ReminderInputCopyWith<$Res> {
  __$ReminderInputCopyWithImpl(this._self, this._then);

  final _ReminderInput _self;
  final $Res Function(_ReminderInput) _then;

/// Create a copy of ReminderInput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? moment = null,Object? activityId = freezed,Object? eventId = freezed,Object? goalId = freezed,}) {
  return _then(_ReminderInput(
moment: null == moment ? _self.moment : moment // ignore: cast_nullable_to_non_nullable
as DateTime,activityId: freezed == activityId ? _self.activityId : activityId // ignore: cast_nullable_to_non_nullable
as String?,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String?,goalId: freezed == goalId ? _self.goalId : goalId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
