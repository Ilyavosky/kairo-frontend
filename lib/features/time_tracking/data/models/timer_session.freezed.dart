// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'timer_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TimerSession {

 String get id;@JsonKey(name: 'categoria_id') String get categoryId;@JsonKey(name: 'iniciada_en') DateTime get startedAt;@JsonKey(name: 'transcurrido_s') int get elapsedSeconds;@JsonKey(name: 'actividad_id') String? get activityId;
/// Create a copy of TimerSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimerSessionCopyWith<TimerSession> get copyWith => _$TimerSessionCopyWithImpl<TimerSession>(this as TimerSession, _$identity);

  /// Serializes this TimerSession to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimerSession&&(identical(other.id, id) || other.id == id)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.elapsedSeconds, elapsedSeconds) || other.elapsedSeconds == elapsedSeconds)&&(identical(other.activityId, activityId) || other.activityId == activityId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,categoryId,startedAt,elapsedSeconds,activityId);

@override
String toString() {
  return 'TimerSession(id: $id, categoryId: $categoryId, startedAt: $startedAt, elapsedSeconds: $elapsedSeconds, activityId: $activityId)';
}


}

/// @nodoc
abstract mixin class $TimerSessionCopyWith<$Res>  {
  factory $TimerSessionCopyWith(TimerSession value, $Res Function(TimerSession) _then) = _$TimerSessionCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'categoria_id') String categoryId,@JsonKey(name: 'iniciada_en') DateTime startedAt,@JsonKey(name: 'transcurrido_s') int elapsedSeconds,@JsonKey(name: 'actividad_id') String? activityId
});




}
/// @nodoc
class _$TimerSessionCopyWithImpl<$Res>
    implements $TimerSessionCopyWith<$Res> {
  _$TimerSessionCopyWithImpl(this._self, this._then);

  final TimerSession _self;
  final $Res Function(TimerSession) _then;

/// Create a copy of TimerSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? categoryId = null,Object? startedAt = null,Object? elapsedSeconds = null,Object? activityId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,elapsedSeconds: null == elapsedSeconds ? _self.elapsedSeconds : elapsedSeconds // ignore: cast_nullable_to_non_nullable
as int,activityId: freezed == activityId ? _self.activityId : activityId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TimerSession].
extension TimerSessionPatterns on TimerSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TimerSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TimerSession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TimerSession value)  $default,){
final _that = this;
switch (_that) {
case _TimerSession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TimerSession value)?  $default,){
final _that = this;
switch (_that) {
case _TimerSession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'categoria_id')  String categoryId, @JsonKey(name: 'iniciada_en')  DateTime startedAt, @JsonKey(name: 'transcurrido_s')  int elapsedSeconds, @JsonKey(name: 'actividad_id')  String? activityId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TimerSession() when $default != null:
return $default(_that.id,_that.categoryId,_that.startedAt,_that.elapsedSeconds,_that.activityId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'categoria_id')  String categoryId, @JsonKey(name: 'iniciada_en')  DateTime startedAt, @JsonKey(name: 'transcurrido_s')  int elapsedSeconds, @JsonKey(name: 'actividad_id')  String? activityId)  $default,) {final _that = this;
switch (_that) {
case _TimerSession():
return $default(_that.id,_that.categoryId,_that.startedAt,_that.elapsedSeconds,_that.activityId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'categoria_id')  String categoryId, @JsonKey(name: 'iniciada_en')  DateTime startedAt, @JsonKey(name: 'transcurrido_s')  int elapsedSeconds, @JsonKey(name: 'actividad_id')  String? activityId)?  $default,) {final _that = this;
switch (_that) {
case _TimerSession() when $default != null:
return $default(_that.id,_that.categoryId,_that.startedAt,_that.elapsedSeconds,_that.activityId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TimerSession implements TimerSession {
  const _TimerSession({required this.id, @JsonKey(name: 'categoria_id') required this.categoryId, @JsonKey(name: 'iniciada_en') required this.startedAt, @JsonKey(name: 'transcurrido_s') required this.elapsedSeconds, @JsonKey(name: 'actividad_id') this.activityId});
  factory _TimerSession.fromJson(Map<String, dynamic> json) => _$TimerSessionFromJson(json);

@override final  String id;
@override@JsonKey(name: 'categoria_id') final  String categoryId;
@override@JsonKey(name: 'iniciada_en') final  DateTime startedAt;
@override@JsonKey(name: 'transcurrido_s') final  int elapsedSeconds;
@override@JsonKey(name: 'actividad_id') final  String? activityId;

/// Create a copy of TimerSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TimerSessionCopyWith<_TimerSession> get copyWith => __$TimerSessionCopyWithImpl<_TimerSession>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TimerSessionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TimerSession&&(identical(other.id, id) || other.id == id)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.elapsedSeconds, elapsedSeconds) || other.elapsedSeconds == elapsedSeconds)&&(identical(other.activityId, activityId) || other.activityId == activityId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,categoryId,startedAt,elapsedSeconds,activityId);

@override
String toString() {
  return 'TimerSession(id: $id, categoryId: $categoryId, startedAt: $startedAt, elapsedSeconds: $elapsedSeconds, activityId: $activityId)';
}


}

/// @nodoc
abstract mixin class _$TimerSessionCopyWith<$Res> implements $TimerSessionCopyWith<$Res> {
  factory _$TimerSessionCopyWith(_TimerSession value, $Res Function(_TimerSession) _then) = __$TimerSessionCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'categoria_id') String categoryId,@JsonKey(name: 'iniciada_en') DateTime startedAt,@JsonKey(name: 'transcurrido_s') int elapsedSeconds,@JsonKey(name: 'actividad_id') String? activityId
});




}
/// @nodoc
class __$TimerSessionCopyWithImpl<$Res>
    implements _$TimerSessionCopyWith<$Res> {
  __$TimerSessionCopyWithImpl(this._self, this._then);

  final _TimerSession _self;
  final $Res Function(_TimerSession) _then;

/// Create a copy of TimerSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? categoryId = null,Object? startedAt = null,Object? elapsedSeconds = null,Object? activityId = freezed,}) {
  return _then(_TimerSession(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,elapsedSeconds: null == elapsedSeconds ? _self.elapsedSeconds : elapsedSeconds // ignore: cast_nullable_to_non_nullable
as int,activityId: freezed == activityId ? _self.activityId : activityId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
