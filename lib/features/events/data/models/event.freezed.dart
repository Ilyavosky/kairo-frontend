// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Event {

 String get id;@JsonKey(name: 'titulo') String get title;@JsonKey(name: 'inicio') DateTime get start;@JsonKey(name: 'fin') DateTime get end;@JsonKey(name: 'tipo', unknownEnumValue: EventType.personal) EventType get type;@JsonKey(name: 'actividad_id') String? get activityId;@JsonKey(name: 'materia_id') String? get subjectId;@JsonKey(name: 'lugar') String? get place;
/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventCopyWith<Event> get copyWith => _$EventCopyWithImpl<Event>(this as Event, _$identity);

  /// Serializes this Event to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Event&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.type, type) || other.type == type)&&(identical(other.activityId, activityId) || other.activityId == activityId)&&(identical(other.subjectId, subjectId) || other.subjectId == subjectId)&&(identical(other.place, place) || other.place == place));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,start,end,type,activityId,subjectId,place);

@override
String toString() {
  return 'Event(id: $id, title: $title, start: $start, end: $end, type: $type, activityId: $activityId, subjectId: $subjectId, place: $place)';
}


}

/// @nodoc
abstract mixin class $EventCopyWith<$Res>  {
  factory $EventCopyWith(Event value, $Res Function(Event) _then) = _$EventCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'titulo') String title,@JsonKey(name: 'inicio') DateTime start,@JsonKey(name: 'fin') DateTime end,@JsonKey(name: 'tipo', unknownEnumValue: EventType.personal) EventType type,@JsonKey(name: 'actividad_id') String? activityId,@JsonKey(name: 'materia_id') String? subjectId,@JsonKey(name: 'lugar') String? place
});




}
/// @nodoc
class _$EventCopyWithImpl<$Res>
    implements $EventCopyWith<$Res> {
  _$EventCopyWithImpl(this._self, this._then);

  final Event _self;
  final $Res Function(Event) _then;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? start = null,Object? end = null,Object? type = null,Object? activityId = freezed,Object? subjectId = freezed,Object? place = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as DateTime,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EventType,activityId: freezed == activityId ? _self.activityId : activityId // ignore: cast_nullable_to_non_nullable
as String?,subjectId: freezed == subjectId ? _self.subjectId : subjectId // ignore: cast_nullable_to_non_nullable
as String?,place: freezed == place ? _self.place : place // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Event].
extension EventPatterns on Event {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Event value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Event() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Event value)  $default,){
final _that = this;
switch (_that) {
case _Event():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Event value)?  $default,){
final _that = this;
switch (_that) {
case _Event() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'titulo')  String title, @JsonKey(name: 'inicio')  DateTime start, @JsonKey(name: 'fin')  DateTime end, @JsonKey(name: 'tipo', unknownEnumValue: EventType.personal)  EventType type, @JsonKey(name: 'actividad_id')  String? activityId, @JsonKey(name: 'materia_id')  String? subjectId, @JsonKey(name: 'lugar')  String? place)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Event() when $default != null:
return $default(_that.id,_that.title,_that.start,_that.end,_that.type,_that.activityId,_that.subjectId,_that.place);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'titulo')  String title, @JsonKey(name: 'inicio')  DateTime start, @JsonKey(name: 'fin')  DateTime end, @JsonKey(name: 'tipo', unknownEnumValue: EventType.personal)  EventType type, @JsonKey(name: 'actividad_id')  String? activityId, @JsonKey(name: 'materia_id')  String? subjectId, @JsonKey(name: 'lugar')  String? place)  $default,) {final _that = this;
switch (_that) {
case _Event():
return $default(_that.id,_that.title,_that.start,_that.end,_that.type,_that.activityId,_that.subjectId,_that.place);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'titulo')  String title, @JsonKey(name: 'inicio')  DateTime start, @JsonKey(name: 'fin')  DateTime end, @JsonKey(name: 'tipo', unknownEnumValue: EventType.personal)  EventType type, @JsonKey(name: 'actividad_id')  String? activityId, @JsonKey(name: 'materia_id')  String? subjectId, @JsonKey(name: 'lugar')  String? place)?  $default,) {final _that = this;
switch (_that) {
case _Event() when $default != null:
return $default(_that.id,_that.title,_that.start,_that.end,_that.type,_that.activityId,_that.subjectId,_that.place);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Event implements Event {
  const _Event({required this.id, @JsonKey(name: 'titulo') required this.title, @JsonKey(name: 'inicio') required this.start, @JsonKey(name: 'fin') required this.end, @JsonKey(name: 'tipo', unknownEnumValue: EventType.personal) this.type = EventType.personal, @JsonKey(name: 'actividad_id') this.activityId, @JsonKey(name: 'materia_id') this.subjectId, @JsonKey(name: 'lugar') this.place});
  factory _Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

@override final  String id;
@override@JsonKey(name: 'titulo') final  String title;
@override@JsonKey(name: 'inicio') final  DateTime start;
@override@JsonKey(name: 'fin') final  DateTime end;
@override@JsonKey(name: 'tipo', unknownEnumValue: EventType.personal) final  EventType type;
@override@JsonKey(name: 'actividad_id') final  String? activityId;
@override@JsonKey(name: 'materia_id') final  String? subjectId;
@override@JsonKey(name: 'lugar') final  String? place;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventCopyWith<_Event> get copyWith => __$EventCopyWithImpl<_Event>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Event&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.type, type) || other.type == type)&&(identical(other.activityId, activityId) || other.activityId == activityId)&&(identical(other.subjectId, subjectId) || other.subjectId == subjectId)&&(identical(other.place, place) || other.place == place));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,start,end,type,activityId,subjectId,place);

@override
String toString() {
  return 'Event(id: $id, title: $title, start: $start, end: $end, type: $type, activityId: $activityId, subjectId: $subjectId, place: $place)';
}


}

/// @nodoc
abstract mixin class _$EventCopyWith<$Res> implements $EventCopyWith<$Res> {
  factory _$EventCopyWith(_Event value, $Res Function(_Event) _then) = __$EventCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'titulo') String title,@JsonKey(name: 'inicio') DateTime start,@JsonKey(name: 'fin') DateTime end,@JsonKey(name: 'tipo', unknownEnumValue: EventType.personal) EventType type,@JsonKey(name: 'actividad_id') String? activityId,@JsonKey(name: 'materia_id') String? subjectId,@JsonKey(name: 'lugar') String? place
});




}
/// @nodoc
class __$EventCopyWithImpl<$Res>
    implements _$EventCopyWith<$Res> {
  __$EventCopyWithImpl(this._self, this._then);

  final _Event _self;
  final $Res Function(_Event) _then;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? start = null,Object? end = null,Object? type = null,Object? activityId = freezed,Object? subjectId = freezed,Object? place = freezed,}) {
  return _then(_Event(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as DateTime,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EventType,activityId: freezed == activityId ? _self.activityId : activityId // ignore: cast_nullable_to_non_nullable
as String?,subjectId: freezed == subjectId ? _self.subjectId : subjectId // ignore: cast_nullable_to_non_nullable
as String?,place: freezed == place ? _self.place : place // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
