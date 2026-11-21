// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Activity {

 String get id;@JsonKey(name: 'categoria_id') String get categoryId;@JsonKey(name: 'titulo') String get title;@JsonKey(name: 'prioridad') int get priority;@JsonKey(name: 'modalidad') ActivityModality get modality;@JsonKey(name: 'estado') ActivityStatus get status;@JsonKey(name: 'creada_en') DateTime get createdAt;@JsonKey(name: 'materia_id') String? get subjectId;@JsonKey(name: 'descripcion') String? get description;@JsonKey(name: 'vence_en') DateTime? get dueAt;@JsonKey(name: 'completada_en') DateTime? get completedAt;
/// Create a copy of Activity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActivityCopyWith<Activity> get copyWith => _$ActivityCopyWithImpl<Activity>(this as Activity, _$identity);

  /// Serializes this Activity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Activity&&(identical(other.id, id) || other.id == id)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.title, title) || other.title == title)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.modality, modality) || other.modality == modality)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.subjectId, subjectId) || other.subjectId == subjectId)&&(identical(other.description, description) || other.description == description)&&(identical(other.dueAt, dueAt) || other.dueAt == dueAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,categoryId,title,priority,modality,status,createdAt,subjectId,description,dueAt,completedAt);

@override
String toString() {
  return 'Activity(id: $id, categoryId: $categoryId, title: $title, priority: $priority, modality: $modality, status: $status, createdAt: $createdAt, subjectId: $subjectId, description: $description, dueAt: $dueAt, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class $ActivityCopyWith<$Res>  {
  factory $ActivityCopyWith(Activity value, $Res Function(Activity) _then) = _$ActivityCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'categoria_id') String categoryId,@JsonKey(name: 'titulo') String title,@JsonKey(name: 'prioridad') int priority,@JsonKey(name: 'modalidad') ActivityModality modality,@JsonKey(name: 'estado') ActivityStatus status,@JsonKey(name: 'creada_en') DateTime createdAt,@JsonKey(name: 'materia_id') String? subjectId,@JsonKey(name: 'descripcion') String? description,@JsonKey(name: 'vence_en') DateTime? dueAt,@JsonKey(name: 'completada_en') DateTime? completedAt
});




}
/// @nodoc
class _$ActivityCopyWithImpl<$Res>
    implements $ActivityCopyWith<$Res> {
  _$ActivityCopyWithImpl(this._self, this._then);

  final Activity _self;
  final $Res Function(Activity) _then;

/// Create a copy of Activity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? categoryId = null,Object? title = null,Object? priority = null,Object? modality = null,Object? status = null,Object? createdAt = null,Object? subjectId = freezed,Object? description = freezed,Object? dueAt = freezed,Object? completedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as int,modality: null == modality ? _self.modality : modality // ignore: cast_nullable_to_non_nullable
as ActivityModality,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ActivityStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,subjectId: freezed == subjectId ? _self.subjectId : subjectId // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,dueAt: freezed == dueAt ? _self.dueAt : dueAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Activity].
extension ActivityPatterns on Activity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Activity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Activity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Activity value)  $default,){
final _that = this;
switch (_that) {
case _Activity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Activity value)?  $default,){
final _that = this;
switch (_that) {
case _Activity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'categoria_id')  String categoryId, @JsonKey(name: 'titulo')  String title, @JsonKey(name: 'prioridad')  int priority, @JsonKey(name: 'modalidad')  ActivityModality modality, @JsonKey(name: 'estado')  ActivityStatus status, @JsonKey(name: 'creada_en')  DateTime createdAt, @JsonKey(name: 'materia_id')  String? subjectId, @JsonKey(name: 'descripcion')  String? description, @JsonKey(name: 'vence_en')  DateTime? dueAt, @JsonKey(name: 'completada_en')  DateTime? completedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Activity() when $default != null:
return $default(_that.id,_that.categoryId,_that.title,_that.priority,_that.modality,_that.status,_that.createdAt,_that.subjectId,_that.description,_that.dueAt,_that.completedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'categoria_id')  String categoryId, @JsonKey(name: 'titulo')  String title, @JsonKey(name: 'prioridad')  int priority, @JsonKey(name: 'modalidad')  ActivityModality modality, @JsonKey(name: 'estado')  ActivityStatus status, @JsonKey(name: 'creada_en')  DateTime createdAt, @JsonKey(name: 'materia_id')  String? subjectId, @JsonKey(name: 'descripcion')  String? description, @JsonKey(name: 'vence_en')  DateTime? dueAt, @JsonKey(name: 'completada_en')  DateTime? completedAt)  $default,) {final _that = this;
switch (_that) {
case _Activity():
return $default(_that.id,_that.categoryId,_that.title,_that.priority,_that.modality,_that.status,_that.createdAt,_that.subjectId,_that.description,_that.dueAt,_that.completedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'categoria_id')  String categoryId, @JsonKey(name: 'titulo')  String title, @JsonKey(name: 'prioridad')  int priority, @JsonKey(name: 'modalidad')  ActivityModality modality, @JsonKey(name: 'estado')  ActivityStatus status, @JsonKey(name: 'creada_en')  DateTime createdAt, @JsonKey(name: 'materia_id')  String? subjectId, @JsonKey(name: 'descripcion')  String? description, @JsonKey(name: 'vence_en')  DateTime? dueAt, @JsonKey(name: 'completada_en')  DateTime? completedAt)?  $default,) {final _that = this;
switch (_that) {
case _Activity() when $default != null:
return $default(_that.id,_that.categoryId,_that.title,_that.priority,_that.modality,_that.status,_that.createdAt,_that.subjectId,_that.description,_that.dueAt,_that.completedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Activity implements Activity {
  const _Activity({required this.id, @JsonKey(name: 'categoria_id') required this.categoryId, @JsonKey(name: 'titulo') required this.title, @JsonKey(name: 'prioridad') required this.priority, @JsonKey(name: 'modalidad') required this.modality, @JsonKey(name: 'estado') required this.status, @JsonKey(name: 'creada_en') required this.createdAt, @JsonKey(name: 'materia_id') this.subjectId, @JsonKey(name: 'descripcion') this.description, @JsonKey(name: 'vence_en') this.dueAt, @JsonKey(name: 'completada_en') this.completedAt});
  factory _Activity.fromJson(Map<String, dynamic> json) => _$ActivityFromJson(json);

@override final  String id;
@override@JsonKey(name: 'categoria_id') final  String categoryId;
@override@JsonKey(name: 'titulo') final  String title;
@override@JsonKey(name: 'prioridad') final  int priority;
@override@JsonKey(name: 'modalidad') final  ActivityModality modality;
@override@JsonKey(name: 'estado') final  ActivityStatus status;
@override@JsonKey(name: 'creada_en') final  DateTime createdAt;
@override@JsonKey(name: 'materia_id') final  String? subjectId;
@override@JsonKey(name: 'descripcion') final  String? description;
@override@JsonKey(name: 'vence_en') final  DateTime? dueAt;
@override@JsonKey(name: 'completada_en') final  DateTime? completedAt;

/// Create a copy of Activity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActivityCopyWith<_Activity> get copyWith => __$ActivityCopyWithImpl<_Activity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ActivityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Activity&&(identical(other.id, id) || other.id == id)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.title, title) || other.title == title)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.modality, modality) || other.modality == modality)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.subjectId, subjectId) || other.subjectId == subjectId)&&(identical(other.description, description) || other.description == description)&&(identical(other.dueAt, dueAt) || other.dueAt == dueAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,categoryId,title,priority,modality,status,createdAt,subjectId,description,dueAt,completedAt);

@override
String toString() {
  return 'Activity(id: $id, categoryId: $categoryId, title: $title, priority: $priority, modality: $modality, status: $status, createdAt: $createdAt, subjectId: $subjectId, description: $description, dueAt: $dueAt, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class _$ActivityCopyWith<$Res> implements $ActivityCopyWith<$Res> {
  factory _$ActivityCopyWith(_Activity value, $Res Function(_Activity) _then) = __$ActivityCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'categoria_id') String categoryId,@JsonKey(name: 'titulo') String title,@JsonKey(name: 'prioridad') int priority,@JsonKey(name: 'modalidad') ActivityModality modality,@JsonKey(name: 'estado') ActivityStatus status,@JsonKey(name: 'creada_en') DateTime createdAt,@JsonKey(name: 'materia_id') String? subjectId,@JsonKey(name: 'descripcion') String? description,@JsonKey(name: 'vence_en') DateTime? dueAt,@JsonKey(name: 'completada_en') DateTime? completedAt
});




}
/// @nodoc
class __$ActivityCopyWithImpl<$Res>
    implements _$ActivityCopyWith<$Res> {
  __$ActivityCopyWithImpl(this._self, this._then);

  final _Activity _self;
  final $Res Function(_Activity) _then;

/// Create a copy of Activity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? categoryId = null,Object? title = null,Object? priority = null,Object? modality = null,Object? status = null,Object? createdAt = null,Object? subjectId = freezed,Object? description = freezed,Object? dueAt = freezed,Object? completedAt = freezed,}) {
  return _then(_Activity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as int,modality: null == modality ? _self.modality : modality // ignore: cast_nullable_to_non_nullable
as ActivityModality,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ActivityStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,subjectId: freezed == subjectId ? _self.subjectId : subjectId // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,dueAt: freezed == dueAt ? _self.dueAt : dueAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
