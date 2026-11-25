// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'time_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TimeRecord {

 String get id;@JsonKey(name: 'categoria_id') String get categoryId;@JsonKey(name: 'inicio') DateTime get start;@JsonKey(name: 'fin') DateTime get end;@JsonKey(name: 'origen') String get origin;@JsonKey(name: 'actividad_id') String? get activityId;@JsonKey(name: 'nota') String? get note;
/// Create a copy of TimeRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimeRecordCopyWith<TimeRecord> get copyWith => _$TimeRecordCopyWithImpl<TimeRecord>(this as TimeRecord, _$identity);

  /// Serializes this TimeRecord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimeRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.origin, origin) || other.origin == origin)&&(identical(other.activityId, activityId) || other.activityId == activityId)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,categoryId,start,end,origin,activityId,note);

@override
String toString() {
  return 'TimeRecord(id: $id, categoryId: $categoryId, start: $start, end: $end, origin: $origin, activityId: $activityId, note: $note)';
}


}

/// @nodoc
abstract mixin class $TimeRecordCopyWith<$Res>  {
  factory $TimeRecordCopyWith(TimeRecord value, $Res Function(TimeRecord) _then) = _$TimeRecordCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'categoria_id') String categoryId,@JsonKey(name: 'inicio') DateTime start,@JsonKey(name: 'fin') DateTime end,@JsonKey(name: 'origen') String origin,@JsonKey(name: 'actividad_id') String? activityId,@JsonKey(name: 'nota') String? note
});




}
/// @nodoc
class _$TimeRecordCopyWithImpl<$Res>
    implements $TimeRecordCopyWith<$Res> {
  _$TimeRecordCopyWithImpl(this._self, this._then);

  final TimeRecord _self;
  final $Res Function(TimeRecord) _then;

/// Create a copy of TimeRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? categoryId = null,Object? start = null,Object? end = null,Object? origin = null,Object? activityId = freezed,Object? note = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as DateTime,origin: null == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as String,activityId: freezed == activityId ? _self.activityId : activityId // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TimeRecord].
extension TimeRecordPatterns on TimeRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TimeRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TimeRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TimeRecord value)  $default,){
final _that = this;
switch (_that) {
case _TimeRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TimeRecord value)?  $default,){
final _that = this;
switch (_that) {
case _TimeRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'categoria_id')  String categoryId, @JsonKey(name: 'inicio')  DateTime start, @JsonKey(name: 'fin')  DateTime end, @JsonKey(name: 'origen')  String origin, @JsonKey(name: 'actividad_id')  String? activityId, @JsonKey(name: 'nota')  String? note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TimeRecord() when $default != null:
return $default(_that.id,_that.categoryId,_that.start,_that.end,_that.origin,_that.activityId,_that.note);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'categoria_id')  String categoryId, @JsonKey(name: 'inicio')  DateTime start, @JsonKey(name: 'fin')  DateTime end, @JsonKey(name: 'origen')  String origin, @JsonKey(name: 'actividad_id')  String? activityId, @JsonKey(name: 'nota')  String? note)  $default,) {final _that = this;
switch (_that) {
case _TimeRecord():
return $default(_that.id,_that.categoryId,_that.start,_that.end,_that.origin,_that.activityId,_that.note);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'categoria_id')  String categoryId, @JsonKey(name: 'inicio')  DateTime start, @JsonKey(name: 'fin')  DateTime end, @JsonKey(name: 'origen')  String origin, @JsonKey(name: 'actividad_id')  String? activityId, @JsonKey(name: 'nota')  String? note)?  $default,) {final _that = this;
switch (_that) {
case _TimeRecord() when $default != null:
return $default(_that.id,_that.categoryId,_that.start,_that.end,_that.origin,_that.activityId,_that.note);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TimeRecord extends TimeRecord {
  const _TimeRecord({required this.id, @JsonKey(name: 'categoria_id') required this.categoryId, @JsonKey(name: 'inicio') required this.start, @JsonKey(name: 'fin') required this.end, @JsonKey(name: 'origen') required this.origin, @JsonKey(name: 'actividad_id') this.activityId, @JsonKey(name: 'nota') this.note}): super._();
  factory _TimeRecord.fromJson(Map<String, dynamic> json) => _$TimeRecordFromJson(json);

@override final  String id;
@override@JsonKey(name: 'categoria_id') final  String categoryId;
@override@JsonKey(name: 'inicio') final  DateTime start;
@override@JsonKey(name: 'fin') final  DateTime end;
@override@JsonKey(name: 'origen') final  String origin;
@override@JsonKey(name: 'actividad_id') final  String? activityId;
@override@JsonKey(name: 'nota') final  String? note;

/// Create a copy of TimeRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TimeRecordCopyWith<_TimeRecord> get copyWith => __$TimeRecordCopyWithImpl<_TimeRecord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TimeRecordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TimeRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.origin, origin) || other.origin == origin)&&(identical(other.activityId, activityId) || other.activityId == activityId)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,categoryId,start,end,origin,activityId,note);

@override
String toString() {
  return 'TimeRecord(id: $id, categoryId: $categoryId, start: $start, end: $end, origin: $origin, activityId: $activityId, note: $note)';
}


}

/// @nodoc
abstract mixin class _$TimeRecordCopyWith<$Res> implements $TimeRecordCopyWith<$Res> {
  factory _$TimeRecordCopyWith(_TimeRecord value, $Res Function(_TimeRecord) _then) = __$TimeRecordCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'categoria_id') String categoryId,@JsonKey(name: 'inicio') DateTime start,@JsonKey(name: 'fin') DateTime end,@JsonKey(name: 'origen') String origin,@JsonKey(name: 'actividad_id') String? activityId,@JsonKey(name: 'nota') String? note
});




}
/// @nodoc
class __$TimeRecordCopyWithImpl<$Res>
    implements _$TimeRecordCopyWith<$Res> {
  __$TimeRecordCopyWithImpl(this._self, this._then);

  final _TimeRecord _self;
  final $Res Function(_TimeRecord) _then;

/// Create a copy of TimeRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? categoryId = null,Object? start = null,Object? end = null,Object? origin = null,Object? activityId = freezed,Object? note = freezed,}) {
  return _then(_TimeRecord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as DateTime,origin: null == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as String,activityId: freezed == activityId ? _self.activityId : activityId // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
