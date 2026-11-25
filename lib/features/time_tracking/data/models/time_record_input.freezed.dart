// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'time_record_input.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TimeRecordInput {

@JsonKey(name: 'categoria_id') String get categoryId;@JsonKey(name: 'inicio') DateTime get start;@JsonKey(name: 'fin') DateTime get end;@JsonKey(name: 'actividad_id') String? get activityId;@JsonKey(name: 'nota') String? get note;
/// Create a copy of TimeRecordInput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimeRecordInputCopyWith<TimeRecordInput> get copyWith => _$TimeRecordInputCopyWithImpl<TimeRecordInput>(this as TimeRecordInput, _$identity);

  /// Serializes this TimeRecordInput to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimeRecordInput&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.activityId, activityId) || other.activityId == activityId)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,categoryId,start,end,activityId,note);

@override
String toString() {
  return 'TimeRecordInput(categoryId: $categoryId, start: $start, end: $end, activityId: $activityId, note: $note)';
}


}

/// @nodoc
abstract mixin class $TimeRecordInputCopyWith<$Res>  {
  factory $TimeRecordInputCopyWith(TimeRecordInput value, $Res Function(TimeRecordInput) _then) = _$TimeRecordInputCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'categoria_id') String categoryId,@JsonKey(name: 'inicio') DateTime start,@JsonKey(name: 'fin') DateTime end,@JsonKey(name: 'actividad_id') String? activityId,@JsonKey(name: 'nota') String? note
});




}
/// @nodoc
class _$TimeRecordInputCopyWithImpl<$Res>
    implements $TimeRecordInputCopyWith<$Res> {
  _$TimeRecordInputCopyWithImpl(this._self, this._then);

  final TimeRecordInput _self;
  final $Res Function(TimeRecordInput) _then;

/// Create a copy of TimeRecordInput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? categoryId = null,Object? start = null,Object? end = null,Object? activityId = freezed,Object? note = freezed,}) {
  return _then(_self.copyWith(
categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as DateTime,activityId: freezed == activityId ? _self.activityId : activityId // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TimeRecordInput].
extension TimeRecordInputPatterns on TimeRecordInput {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TimeRecordInput value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TimeRecordInput() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TimeRecordInput value)  $default,){
final _that = this;
switch (_that) {
case _TimeRecordInput():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TimeRecordInput value)?  $default,){
final _that = this;
switch (_that) {
case _TimeRecordInput() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'categoria_id')  String categoryId, @JsonKey(name: 'inicio')  DateTime start, @JsonKey(name: 'fin')  DateTime end, @JsonKey(name: 'actividad_id')  String? activityId, @JsonKey(name: 'nota')  String? note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TimeRecordInput() when $default != null:
return $default(_that.categoryId,_that.start,_that.end,_that.activityId,_that.note);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'categoria_id')  String categoryId, @JsonKey(name: 'inicio')  DateTime start, @JsonKey(name: 'fin')  DateTime end, @JsonKey(name: 'actividad_id')  String? activityId, @JsonKey(name: 'nota')  String? note)  $default,) {final _that = this;
switch (_that) {
case _TimeRecordInput():
return $default(_that.categoryId,_that.start,_that.end,_that.activityId,_that.note);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'categoria_id')  String categoryId, @JsonKey(name: 'inicio')  DateTime start, @JsonKey(name: 'fin')  DateTime end, @JsonKey(name: 'actividad_id')  String? activityId, @JsonKey(name: 'nota')  String? note)?  $default,) {final _that = this;
switch (_that) {
case _TimeRecordInput() when $default != null:
return $default(_that.categoryId,_that.start,_that.end,_that.activityId,_that.note);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TimeRecordInput implements TimeRecordInput {
  const _TimeRecordInput({@JsonKey(name: 'categoria_id') required this.categoryId, @JsonKey(name: 'inicio') required this.start, @JsonKey(name: 'fin') required this.end, @JsonKey(name: 'actividad_id') this.activityId, @JsonKey(name: 'nota') this.note});
  factory _TimeRecordInput.fromJson(Map<String, dynamic> json) => _$TimeRecordInputFromJson(json);

@override@JsonKey(name: 'categoria_id') final  String categoryId;
@override@JsonKey(name: 'inicio') final  DateTime start;
@override@JsonKey(name: 'fin') final  DateTime end;
@override@JsonKey(name: 'actividad_id') final  String? activityId;
@override@JsonKey(name: 'nota') final  String? note;

/// Create a copy of TimeRecordInput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TimeRecordInputCopyWith<_TimeRecordInput> get copyWith => __$TimeRecordInputCopyWithImpl<_TimeRecordInput>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TimeRecordInputToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TimeRecordInput&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.activityId, activityId) || other.activityId == activityId)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,categoryId,start,end,activityId,note);

@override
String toString() {
  return 'TimeRecordInput(categoryId: $categoryId, start: $start, end: $end, activityId: $activityId, note: $note)';
}


}

/// @nodoc
abstract mixin class _$TimeRecordInputCopyWith<$Res> implements $TimeRecordInputCopyWith<$Res> {
  factory _$TimeRecordInputCopyWith(_TimeRecordInput value, $Res Function(_TimeRecordInput) _then) = __$TimeRecordInputCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'categoria_id') String categoryId,@JsonKey(name: 'inicio') DateTime start,@JsonKey(name: 'fin') DateTime end,@JsonKey(name: 'actividad_id') String? activityId,@JsonKey(name: 'nota') String? note
});




}
/// @nodoc
class __$TimeRecordInputCopyWithImpl<$Res>
    implements _$TimeRecordInputCopyWith<$Res> {
  __$TimeRecordInputCopyWithImpl(this._self, this._then);

  final _TimeRecordInput _self;
  final $Res Function(_TimeRecordInput) _then;

/// Create a copy of TimeRecordInput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? categoryId = null,Object? start = null,Object? end = null,Object? activityId = freezed,Object? note = freezed,}) {
  return _then(_TimeRecordInput(
categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as DateTime,activityId: freezed == activityId ? _self.activityId : activityId // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
