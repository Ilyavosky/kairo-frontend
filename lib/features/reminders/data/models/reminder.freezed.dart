// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reminder.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Reminder {

 String get id;@JsonKey(name: 'momento') DateTime get moment;@JsonKey(name: 'estado_envio') ReminderStatus get status;@JsonKey(name: 'creado_en') DateTime get createdAt;@JsonKey(name: 'actividad_id') String? get activityId;@JsonKey(name: 'evento_id') String? get eventId;@JsonKey(name: 'meta_id') String? get goalId;@JsonKey(name: 'intentos') int get attempts;@JsonKey(name: 'enviado_en') DateTime? get sentAt;
/// Create a copy of Reminder
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReminderCopyWith<Reminder> get copyWith => _$ReminderCopyWithImpl<Reminder>(this as Reminder, _$identity);

  /// Serializes this Reminder to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Reminder&&(identical(other.id, id) || other.id == id)&&(identical(other.moment, moment) || other.moment == moment)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.activityId, activityId) || other.activityId == activityId)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.goalId, goalId) || other.goalId == goalId)&&(identical(other.attempts, attempts) || other.attempts == attempts)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,moment,status,createdAt,activityId,eventId,goalId,attempts,sentAt);

@override
String toString() {
  return 'Reminder(id: $id, moment: $moment, status: $status, createdAt: $createdAt, activityId: $activityId, eventId: $eventId, goalId: $goalId, attempts: $attempts, sentAt: $sentAt)';
}


}

/// @nodoc
abstract mixin class $ReminderCopyWith<$Res>  {
  factory $ReminderCopyWith(Reminder value, $Res Function(Reminder) _then) = _$ReminderCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'momento') DateTime moment,@JsonKey(name: 'estado_envio') ReminderStatus status,@JsonKey(name: 'creado_en') DateTime createdAt,@JsonKey(name: 'actividad_id') String? activityId,@JsonKey(name: 'evento_id') String? eventId,@JsonKey(name: 'meta_id') String? goalId,@JsonKey(name: 'intentos') int attempts,@JsonKey(name: 'enviado_en') DateTime? sentAt
});




}
/// @nodoc
class _$ReminderCopyWithImpl<$Res>
    implements $ReminderCopyWith<$Res> {
  _$ReminderCopyWithImpl(this._self, this._then);

  final Reminder _self;
  final $Res Function(Reminder) _then;

/// Create a copy of Reminder
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? moment = null,Object? status = null,Object? createdAt = null,Object? activityId = freezed,Object? eventId = freezed,Object? goalId = freezed,Object? attempts = null,Object? sentAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,moment: null == moment ? _self.moment : moment // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ReminderStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,activityId: freezed == activityId ? _self.activityId : activityId // ignore: cast_nullable_to_non_nullable
as String?,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String?,goalId: freezed == goalId ? _self.goalId : goalId // ignore: cast_nullable_to_non_nullable
as String?,attempts: null == attempts ? _self.attempts : attempts // ignore: cast_nullable_to_non_nullable
as int,sentAt: freezed == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Reminder].
extension ReminderPatterns on Reminder {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Reminder value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Reminder() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Reminder value)  $default,){
final _that = this;
switch (_that) {
case _Reminder():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Reminder value)?  $default,){
final _that = this;
switch (_that) {
case _Reminder() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'momento')  DateTime moment, @JsonKey(name: 'estado_envio')  ReminderStatus status, @JsonKey(name: 'creado_en')  DateTime createdAt, @JsonKey(name: 'actividad_id')  String? activityId, @JsonKey(name: 'evento_id')  String? eventId, @JsonKey(name: 'meta_id')  String? goalId, @JsonKey(name: 'intentos')  int attempts, @JsonKey(name: 'enviado_en')  DateTime? sentAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Reminder() when $default != null:
return $default(_that.id,_that.moment,_that.status,_that.createdAt,_that.activityId,_that.eventId,_that.goalId,_that.attempts,_that.sentAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'momento')  DateTime moment, @JsonKey(name: 'estado_envio')  ReminderStatus status, @JsonKey(name: 'creado_en')  DateTime createdAt, @JsonKey(name: 'actividad_id')  String? activityId, @JsonKey(name: 'evento_id')  String? eventId, @JsonKey(name: 'meta_id')  String? goalId, @JsonKey(name: 'intentos')  int attempts, @JsonKey(name: 'enviado_en')  DateTime? sentAt)  $default,) {final _that = this;
switch (_that) {
case _Reminder():
return $default(_that.id,_that.moment,_that.status,_that.createdAt,_that.activityId,_that.eventId,_that.goalId,_that.attempts,_that.sentAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'momento')  DateTime moment, @JsonKey(name: 'estado_envio')  ReminderStatus status, @JsonKey(name: 'creado_en')  DateTime createdAt, @JsonKey(name: 'actividad_id')  String? activityId, @JsonKey(name: 'evento_id')  String? eventId, @JsonKey(name: 'meta_id')  String? goalId, @JsonKey(name: 'intentos')  int attempts, @JsonKey(name: 'enviado_en')  DateTime? sentAt)?  $default,) {final _that = this;
switch (_that) {
case _Reminder() when $default != null:
return $default(_that.id,_that.moment,_that.status,_that.createdAt,_that.activityId,_that.eventId,_that.goalId,_that.attempts,_that.sentAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Reminder implements Reminder {
  const _Reminder({required this.id, @JsonKey(name: 'momento') required this.moment, @JsonKey(name: 'estado_envio') required this.status, @JsonKey(name: 'creado_en') required this.createdAt, @JsonKey(name: 'actividad_id') this.activityId, @JsonKey(name: 'evento_id') this.eventId, @JsonKey(name: 'meta_id') this.goalId, @JsonKey(name: 'intentos') this.attempts = 0, @JsonKey(name: 'enviado_en') this.sentAt});
  factory _Reminder.fromJson(Map<String, dynamic> json) => _$ReminderFromJson(json);

@override final  String id;
@override@JsonKey(name: 'momento') final  DateTime moment;
@override@JsonKey(name: 'estado_envio') final  ReminderStatus status;
@override@JsonKey(name: 'creado_en') final  DateTime createdAt;
@override@JsonKey(name: 'actividad_id') final  String? activityId;
@override@JsonKey(name: 'evento_id') final  String? eventId;
@override@JsonKey(name: 'meta_id') final  String? goalId;
@override@JsonKey(name: 'intentos') final  int attempts;
@override@JsonKey(name: 'enviado_en') final  DateTime? sentAt;

/// Create a copy of Reminder
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReminderCopyWith<_Reminder> get copyWith => __$ReminderCopyWithImpl<_Reminder>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReminderToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Reminder&&(identical(other.id, id) || other.id == id)&&(identical(other.moment, moment) || other.moment == moment)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.activityId, activityId) || other.activityId == activityId)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.goalId, goalId) || other.goalId == goalId)&&(identical(other.attempts, attempts) || other.attempts == attempts)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,moment,status,createdAt,activityId,eventId,goalId,attempts,sentAt);

@override
String toString() {
  return 'Reminder(id: $id, moment: $moment, status: $status, createdAt: $createdAt, activityId: $activityId, eventId: $eventId, goalId: $goalId, attempts: $attempts, sentAt: $sentAt)';
}


}

/// @nodoc
abstract mixin class _$ReminderCopyWith<$Res> implements $ReminderCopyWith<$Res> {
  factory _$ReminderCopyWith(_Reminder value, $Res Function(_Reminder) _then) = __$ReminderCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'momento') DateTime moment,@JsonKey(name: 'estado_envio') ReminderStatus status,@JsonKey(name: 'creado_en') DateTime createdAt,@JsonKey(name: 'actividad_id') String? activityId,@JsonKey(name: 'evento_id') String? eventId,@JsonKey(name: 'meta_id') String? goalId,@JsonKey(name: 'intentos') int attempts,@JsonKey(name: 'enviado_en') DateTime? sentAt
});




}
/// @nodoc
class __$ReminderCopyWithImpl<$Res>
    implements _$ReminderCopyWith<$Res> {
  __$ReminderCopyWithImpl(this._self, this._then);

  final _Reminder _self;
  final $Res Function(_Reminder) _then;

/// Create a copy of Reminder
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? moment = null,Object? status = null,Object? createdAt = null,Object? activityId = freezed,Object? eventId = freezed,Object? goalId = freezed,Object? attempts = null,Object? sentAt = freezed,}) {
  return _then(_Reminder(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,moment: null == moment ? _self.moment : moment // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ReminderStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,activityId: freezed == activityId ? _self.activityId : activityId // ignore: cast_nullable_to_non_nullable
as String?,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String?,goalId: freezed == goalId ? _self.goalId : goalId // ignore: cast_nullable_to_non_nullable
as String?,attempts: null == attempts ? _self.attempts : attempts // ignore: cast_nullable_to_non_nullable
as int,sentAt: freezed == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
