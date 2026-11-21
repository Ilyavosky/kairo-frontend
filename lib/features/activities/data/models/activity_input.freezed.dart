// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity_input.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ActivityInput {

@JsonKey(name: 'titulo') String get title;@JsonKey(name: 'prioridad') int get priority;@JsonKey(name: 'modalidad') ActivityModality get modality;@JsonKey(name: 'categoria_id') String get categoryId;@JsonKey(name: 'descripcion') String? get description;@JsonKey(name: 'vence_en') DateTime? get dueAt;@JsonKey(name: 'materia_id') String? get subjectId;
/// Create a copy of ActivityInput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActivityInputCopyWith<ActivityInput> get copyWith => _$ActivityInputCopyWithImpl<ActivityInput>(this as ActivityInput, _$identity);

  /// Serializes this ActivityInput to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActivityInput&&(identical(other.title, title) || other.title == title)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.modality, modality) || other.modality == modality)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.description, description) || other.description == description)&&(identical(other.dueAt, dueAt) || other.dueAt == dueAt)&&(identical(other.subjectId, subjectId) || other.subjectId == subjectId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,priority,modality,categoryId,description,dueAt,subjectId);

@override
String toString() {
  return 'ActivityInput(title: $title, priority: $priority, modality: $modality, categoryId: $categoryId, description: $description, dueAt: $dueAt, subjectId: $subjectId)';
}


}

/// @nodoc
abstract mixin class $ActivityInputCopyWith<$Res>  {
  factory $ActivityInputCopyWith(ActivityInput value, $Res Function(ActivityInput) _then) = _$ActivityInputCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'titulo') String title,@JsonKey(name: 'prioridad') int priority,@JsonKey(name: 'modalidad') ActivityModality modality,@JsonKey(name: 'categoria_id') String categoryId,@JsonKey(name: 'descripcion') String? description,@JsonKey(name: 'vence_en') DateTime? dueAt,@JsonKey(name: 'materia_id') String? subjectId
});




}
/// @nodoc
class _$ActivityInputCopyWithImpl<$Res>
    implements $ActivityInputCopyWith<$Res> {
  _$ActivityInputCopyWithImpl(this._self, this._then);

  final ActivityInput _self;
  final $Res Function(ActivityInput) _then;

/// Create a copy of ActivityInput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? priority = null,Object? modality = null,Object? categoryId = null,Object? description = freezed,Object? dueAt = freezed,Object? subjectId = freezed,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as int,modality: null == modality ? _self.modality : modality // ignore: cast_nullable_to_non_nullable
as ActivityModality,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,dueAt: freezed == dueAt ? _self.dueAt : dueAt // ignore: cast_nullable_to_non_nullable
as DateTime?,subjectId: freezed == subjectId ? _self.subjectId : subjectId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ActivityInput].
extension ActivityInputPatterns on ActivityInput {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActivityInput value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActivityInput() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActivityInput value)  $default,){
final _that = this;
switch (_that) {
case _ActivityInput():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActivityInput value)?  $default,){
final _that = this;
switch (_that) {
case _ActivityInput() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'titulo')  String title, @JsonKey(name: 'prioridad')  int priority, @JsonKey(name: 'modalidad')  ActivityModality modality, @JsonKey(name: 'categoria_id')  String categoryId, @JsonKey(name: 'descripcion')  String? description, @JsonKey(name: 'vence_en')  DateTime? dueAt, @JsonKey(name: 'materia_id')  String? subjectId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActivityInput() when $default != null:
return $default(_that.title,_that.priority,_that.modality,_that.categoryId,_that.description,_that.dueAt,_that.subjectId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'titulo')  String title, @JsonKey(name: 'prioridad')  int priority, @JsonKey(name: 'modalidad')  ActivityModality modality, @JsonKey(name: 'categoria_id')  String categoryId, @JsonKey(name: 'descripcion')  String? description, @JsonKey(name: 'vence_en')  DateTime? dueAt, @JsonKey(name: 'materia_id')  String? subjectId)  $default,) {final _that = this;
switch (_that) {
case _ActivityInput():
return $default(_that.title,_that.priority,_that.modality,_that.categoryId,_that.description,_that.dueAt,_that.subjectId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'titulo')  String title, @JsonKey(name: 'prioridad')  int priority, @JsonKey(name: 'modalidad')  ActivityModality modality, @JsonKey(name: 'categoria_id')  String categoryId, @JsonKey(name: 'descripcion')  String? description, @JsonKey(name: 'vence_en')  DateTime? dueAt, @JsonKey(name: 'materia_id')  String? subjectId)?  $default,) {final _that = this;
switch (_that) {
case _ActivityInput() when $default != null:
return $default(_that.title,_that.priority,_that.modality,_that.categoryId,_that.description,_that.dueAt,_that.subjectId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ActivityInput implements ActivityInput {
  const _ActivityInput({@JsonKey(name: 'titulo') required this.title, @JsonKey(name: 'prioridad') required this.priority, @JsonKey(name: 'modalidad') required this.modality, @JsonKey(name: 'categoria_id') required this.categoryId, @JsonKey(name: 'descripcion') this.description, @JsonKey(name: 'vence_en') this.dueAt, @JsonKey(name: 'materia_id') this.subjectId});
  factory _ActivityInput.fromJson(Map<String, dynamic> json) => _$ActivityInputFromJson(json);

@override@JsonKey(name: 'titulo') final  String title;
@override@JsonKey(name: 'prioridad') final  int priority;
@override@JsonKey(name: 'modalidad') final  ActivityModality modality;
@override@JsonKey(name: 'categoria_id') final  String categoryId;
@override@JsonKey(name: 'descripcion') final  String? description;
@override@JsonKey(name: 'vence_en') final  DateTime? dueAt;
@override@JsonKey(name: 'materia_id') final  String? subjectId;

/// Create a copy of ActivityInput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActivityInputCopyWith<_ActivityInput> get copyWith => __$ActivityInputCopyWithImpl<_ActivityInput>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ActivityInputToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActivityInput&&(identical(other.title, title) || other.title == title)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.modality, modality) || other.modality == modality)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.description, description) || other.description == description)&&(identical(other.dueAt, dueAt) || other.dueAt == dueAt)&&(identical(other.subjectId, subjectId) || other.subjectId == subjectId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,priority,modality,categoryId,description,dueAt,subjectId);

@override
String toString() {
  return 'ActivityInput(title: $title, priority: $priority, modality: $modality, categoryId: $categoryId, description: $description, dueAt: $dueAt, subjectId: $subjectId)';
}


}

/// @nodoc
abstract mixin class _$ActivityInputCopyWith<$Res> implements $ActivityInputCopyWith<$Res> {
  factory _$ActivityInputCopyWith(_ActivityInput value, $Res Function(_ActivityInput) _then) = __$ActivityInputCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'titulo') String title,@JsonKey(name: 'prioridad') int priority,@JsonKey(name: 'modalidad') ActivityModality modality,@JsonKey(name: 'categoria_id') String categoryId,@JsonKey(name: 'descripcion') String? description,@JsonKey(name: 'vence_en') DateTime? dueAt,@JsonKey(name: 'materia_id') String? subjectId
});




}
/// @nodoc
class __$ActivityInputCopyWithImpl<$Res>
    implements _$ActivityInputCopyWith<$Res> {
  __$ActivityInputCopyWithImpl(this._self, this._then);

  final _ActivityInput _self;
  final $Res Function(_ActivityInput) _then;

/// Create a copy of ActivityInput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? priority = null,Object? modality = null,Object? categoryId = null,Object? description = freezed,Object? dueAt = freezed,Object? subjectId = freezed,}) {
  return _then(_ActivityInput(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as int,modality: null == modality ? _self.modality : modality // ignore: cast_nullable_to_non_nullable
as ActivityModality,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,dueAt: freezed == dueAt ? _self.dueAt : dueAt // ignore: cast_nullable_to_non_nullable
as DateTime?,subjectId: freezed == subjectId ? _self.subjectId : subjectId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
