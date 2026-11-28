// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_input.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EventInput {

@JsonKey(name: 'titulo') String get title;@JsonKey(name: 'tipo') EventType get type;@JsonKey(name: 'inicio') DateTime get start;@JsonKey(name: 'fin') DateTime get end;@JsonKey(name: 'lugar') String? get place;@JsonKey(name: 'descripcion') String? get description;@JsonKey(name: 'materia_id') String? get subjectId;@JsonKey(name: 'actividad_id') String? get activityId;
/// Create a copy of EventInput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventInputCopyWith<EventInput> get copyWith => _$EventInputCopyWithImpl<EventInput>(this as EventInput, _$identity);

  /// Serializes this EventInput to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventInput&&(identical(other.title, title) || other.title == title)&&(identical(other.type, type) || other.type == type)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.place, place) || other.place == place)&&(identical(other.description, description) || other.description == description)&&(identical(other.subjectId, subjectId) || other.subjectId == subjectId)&&(identical(other.activityId, activityId) || other.activityId == activityId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,type,start,end,place,description,subjectId,activityId);

@override
String toString() {
  return 'EventInput(title: $title, type: $type, start: $start, end: $end, place: $place, description: $description, subjectId: $subjectId, activityId: $activityId)';
}


}

/// @nodoc
abstract mixin class $EventInputCopyWith<$Res>  {
  factory $EventInputCopyWith(EventInput value, $Res Function(EventInput) _then) = _$EventInputCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'titulo') String title,@JsonKey(name: 'tipo') EventType type,@JsonKey(name: 'inicio') DateTime start,@JsonKey(name: 'fin') DateTime end,@JsonKey(name: 'lugar') String? place,@JsonKey(name: 'descripcion') String? description,@JsonKey(name: 'materia_id') String? subjectId,@JsonKey(name: 'actividad_id') String? activityId
});




}
/// @nodoc
class _$EventInputCopyWithImpl<$Res>
    implements $EventInputCopyWith<$Res> {
  _$EventInputCopyWithImpl(this._self, this._then);

  final EventInput _self;
  final $Res Function(EventInput) _then;

/// Create a copy of EventInput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? type = null,Object? start = null,Object? end = null,Object? place = freezed,Object? description = freezed,Object? subjectId = freezed,Object? activityId = freezed,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EventType,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as DateTime,place: freezed == place ? _self.place : place // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,subjectId: freezed == subjectId ? _self.subjectId : subjectId // ignore: cast_nullable_to_non_nullable
as String?,activityId: freezed == activityId ? _self.activityId : activityId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [EventInput].
extension EventInputPatterns on EventInput {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventInput value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventInput() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventInput value)  $default,){
final _that = this;
switch (_that) {
case _EventInput():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventInput value)?  $default,){
final _that = this;
switch (_that) {
case _EventInput() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'titulo')  String title, @JsonKey(name: 'tipo')  EventType type, @JsonKey(name: 'inicio')  DateTime start, @JsonKey(name: 'fin')  DateTime end, @JsonKey(name: 'lugar')  String? place, @JsonKey(name: 'descripcion')  String? description, @JsonKey(name: 'materia_id')  String? subjectId, @JsonKey(name: 'actividad_id')  String? activityId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventInput() when $default != null:
return $default(_that.title,_that.type,_that.start,_that.end,_that.place,_that.description,_that.subjectId,_that.activityId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'titulo')  String title, @JsonKey(name: 'tipo')  EventType type, @JsonKey(name: 'inicio')  DateTime start, @JsonKey(name: 'fin')  DateTime end, @JsonKey(name: 'lugar')  String? place, @JsonKey(name: 'descripcion')  String? description, @JsonKey(name: 'materia_id')  String? subjectId, @JsonKey(name: 'actividad_id')  String? activityId)  $default,) {final _that = this;
switch (_that) {
case _EventInput():
return $default(_that.title,_that.type,_that.start,_that.end,_that.place,_that.description,_that.subjectId,_that.activityId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'titulo')  String title, @JsonKey(name: 'tipo')  EventType type, @JsonKey(name: 'inicio')  DateTime start, @JsonKey(name: 'fin')  DateTime end, @JsonKey(name: 'lugar')  String? place, @JsonKey(name: 'descripcion')  String? description, @JsonKey(name: 'materia_id')  String? subjectId, @JsonKey(name: 'actividad_id')  String? activityId)?  $default,) {final _that = this;
switch (_that) {
case _EventInput() when $default != null:
return $default(_that.title,_that.type,_that.start,_that.end,_that.place,_that.description,_that.subjectId,_that.activityId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EventInput implements EventInput {
  const _EventInput({@JsonKey(name: 'titulo') required this.title, @JsonKey(name: 'tipo') required this.type, @JsonKey(name: 'inicio') required this.start, @JsonKey(name: 'fin') required this.end, @JsonKey(name: 'lugar') this.place, @JsonKey(name: 'descripcion') this.description, @JsonKey(name: 'materia_id') this.subjectId, @JsonKey(name: 'actividad_id') this.activityId});
  factory _EventInput.fromJson(Map<String, dynamic> json) => _$EventInputFromJson(json);

@override@JsonKey(name: 'titulo') final  String title;
@override@JsonKey(name: 'tipo') final  EventType type;
@override@JsonKey(name: 'inicio') final  DateTime start;
@override@JsonKey(name: 'fin') final  DateTime end;
@override@JsonKey(name: 'lugar') final  String? place;
@override@JsonKey(name: 'descripcion') final  String? description;
@override@JsonKey(name: 'materia_id') final  String? subjectId;
@override@JsonKey(name: 'actividad_id') final  String? activityId;

/// Create a copy of EventInput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventInputCopyWith<_EventInput> get copyWith => __$EventInputCopyWithImpl<_EventInput>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventInputToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventInput&&(identical(other.title, title) || other.title == title)&&(identical(other.type, type) || other.type == type)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.place, place) || other.place == place)&&(identical(other.description, description) || other.description == description)&&(identical(other.subjectId, subjectId) || other.subjectId == subjectId)&&(identical(other.activityId, activityId) || other.activityId == activityId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,type,start,end,place,description,subjectId,activityId);

@override
String toString() {
  return 'EventInput(title: $title, type: $type, start: $start, end: $end, place: $place, description: $description, subjectId: $subjectId, activityId: $activityId)';
}


}

/// @nodoc
abstract mixin class _$EventInputCopyWith<$Res> implements $EventInputCopyWith<$Res> {
  factory _$EventInputCopyWith(_EventInput value, $Res Function(_EventInput) _then) = __$EventInputCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'titulo') String title,@JsonKey(name: 'tipo') EventType type,@JsonKey(name: 'inicio') DateTime start,@JsonKey(name: 'fin') DateTime end,@JsonKey(name: 'lugar') String? place,@JsonKey(name: 'descripcion') String? description,@JsonKey(name: 'materia_id') String? subjectId,@JsonKey(name: 'actividad_id') String? activityId
});




}
/// @nodoc
class __$EventInputCopyWithImpl<$Res>
    implements _$EventInputCopyWith<$Res> {
  __$EventInputCopyWithImpl(this._self, this._then);

  final _EventInput _self;
  final $Res Function(_EventInput) _then;

/// Create a copy of EventInput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? type = null,Object? start = null,Object? end = null,Object? place = freezed,Object? description = freezed,Object? subjectId = freezed,Object? activityId = freezed,}) {
  return _then(_EventInput(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EventType,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as DateTime,place: freezed == place ? _self.place : place // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,subjectId: freezed == subjectId ? _self.subjectId : subjectId // ignore: cast_nullable_to_non_nullable
as String?,activityId: freezed == activityId ? _self.activityId : activityId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
