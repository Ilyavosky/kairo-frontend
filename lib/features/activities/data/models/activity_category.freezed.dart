// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity_category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ActivityCategory {

 String get id;@JsonKey(name: 'nombre') String get name;@JsonKey(name: 'ambito') String get scope;@JsonKey(name: 'del_sistema') bool get system;
/// Create a copy of ActivityCategory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActivityCategoryCopyWith<ActivityCategory> get copyWith => _$ActivityCategoryCopyWithImpl<ActivityCategory>(this as ActivityCategory, _$identity);

  /// Serializes this ActivityCategory to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActivityCategory&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.scope, scope) || other.scope == scope)&&(identical(other.system, system) || other.system == system));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,scope,system);

@override
String toString() {
  return 'ActivityCategory(id: $id, name: $name, scope: $scope, system: $system)';
}


}

/// @nodoc
abstract mixin class $ActivityCategoryCopyWith<$Res>  {
  factory $ActivityCategoryCopyWith(ActivityCategory value, $Res Function(ActivityCategory) _then) = _$ActivityCategoryCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'nombre') String name,@JsonKey(name: 'ambito') String scope,@JsonKey(name: 'del_sistema') bool system
});




}
/// @nodoc
class _$ActivityCategoryCopyWithImpl<$Res>
    implements $ActivityCategoryCopyWith<$Res> {
  _$ActivityCategoryCopyWithImpl(this._self, this._then);

  final ActivityCategory _self;
  final $Res Function(ActivityCategory) _then;

/// Create a copy of ActivityCategory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? scope = null,Object? system = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,scope: null == scope ? _self.scope : scope // ignore: cast_nullable_to_non_nullable
as String,system: null == system ? _self.system : system // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ActivityCategory].
extension ActivityCategoryPatterns on ActivityCategory {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActivityCategory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActivityCategory() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActivityCategory value)  $default,){
final _that = this;
switch (_that) {
case _ActivityCategory():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActivityCategory value)?  $default,){
final _that = this;
switch (_that) {
case _ActivityCategory() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'nombre')  String name, @JsonKey(name: 'ambito')  String scope, @JsonKey(name: 'del_sistema')  bool system)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActivityCategory() when $default != null:
return $default(_that.id,_that.name,_that.scope,_that.system);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'nombre')  String name, @JsonKey(name: 'ambito')  String scope, @JsonKey(name: 'del_sistema')  bool system)  $default,) {final _that = this;
switch (_that) {
case _ActivityCategory():
return $default(_that.id,_that.name,_that.scope,_that.system);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'nombre')  String name, @JsonKey(name: 'ambito')  String scope, @JsonKey(name: 'del_sistema')  bool system)?  $default,) {final _that = this;
switch (_that) {
case _ActivityCategory() when $default != null:
return $default(_that.id,_that.name,_that.scope,_that.system);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ActivityCategory implements ActivityCategory {
  const _ActivityCategory({required this.id, @JsonKey(name: 'nombre') required this.name, @JsonKey(name: 'ambito') required this.scope, @JsonKey(name: 'del_sistema') required this.system});
  factory _ActivityCategory.fromJson(Map<String, dynamic> json) => _$ActivityCategoryFromJson(json);

@override final  String id;
@override@JsonKey(name: 'nombre') final  String name;
@override@JsonKey(name: 'ambito') final  String scope;
@override@JsonKey(name: 'del_sistema') final  bool system;

/// Create a copy of ActivityCategory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActivityCategoryCopyWith<_ActivityCategory> get copyWith => __$ActivityCategoryCopyWithImpl<_ActivityCategory>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ActivityCategoryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActivityCategory&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.scope, scope) || other.scope == scope)&&(identical(other.system, system) || other.system == system));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,scope,system);

@override
String toString() {
  return 'ActivityCategory(id: $id, name: $name, scope: $scope, system: $system)';
}


}

/// @nodoc
abstract mixin class _$ActivityCategoryCopyWith<$Res> implements $ActivityCategoryCopyWith<$Res> {
  factory _$ActivityCategoryCopyWith(_ActivityCategory value, $Res Function(_ActivityCategory) _then) = __$ActivityCategoryCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'nombre') String name,@JsonKey(name: 'ambito') String scope,@JsonKey(name: 'del_sistema') bool system
});




}
/// @nodoc
class __$ActivityCategoryCopyWithImpl<$Res>
    implements _$ActivityCategoryCopyWith<$Res> {
  __$ActivityCategoryCopyWithImpl(this._self, this._then);

  final _ActivityCategory _self;
  final $Res Function(_ActivityCategory) _then;

/// Create a copy of ActivityCategory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? scope = null,Object? system = null,}) {
  return _then(_ActivityCategory(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,scope: null == scope ? _self.scope : scope // ignore: cast_nullable_to_non_nullable
as String,system: null == system ? _self.system : system // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
