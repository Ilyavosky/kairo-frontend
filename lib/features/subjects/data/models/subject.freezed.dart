// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subject.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Subject {

 String get id;@JsonKey(name: 'nombre') String get name;@JsonKey(name: 'periodo') String get period;@JsonKey(name: 'activa') bool get active;@JsonKey(name: 'docente') String? get teacher;@JsonKey(name: 'clave') String? get code;
/// Create a copy of Subject
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubjectCopyWith<Subject> get copyWith => _$SubjectCopyWithImpl<Subject>(this as Subject, _$identity);

  /// Serializes this Subject to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Subject&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.period, period) || other.period == period)&&(identical(other.active, active) || other.active == active)&&(identical(other.teacher, teacher) || other.teacher == teacher)&&(identical(other.code, code) || other.code == code));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,period,active,teacher,code);

@override
String toString() {
  return 'Subject(id: $id, name: $name, period: $period, active: $active, teacher: $teacher, code: $code)';
}


}

/// @nodoc
abstract mixin class $SubjectCopyWith<$Res>  {
  factory $SubjectCopyWith(Subject value, $Res Function(Subject) _then) = _$SubjectCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'nombre') String name,@JsonKey(name: 'periodo') String period,@JsonKey(name: 'activa') bool active,@JsonKey(name: 'docente') String? teacher,@JsonKey(name: 'clave') String? code
});




}
/// @nodoc
class _$SubjectCopyWithImpl<$Res>
    implements $SubjectCopyWith<$Res> {
  _$SubjectCopyWithImpl(this._self, this._then);

  final Subject _self;
  final $Res Function(Subject) _then;

/// Create a copy of Subject
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? period = null,Object? active = null,Object? teacher = freezed,Object? code = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,teacher: freezed == teacher ? _self.teacher : teacher // ignore: cast_nullable_to_non_nullable
as String?,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Subject].
extension SubjectPatterns on Subject {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Subject value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Subject() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Subject value)  $default,){
final _that = this;
switch (_that) {
case _Subject():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Subject value)?  $default,){
final _that = this;
switch (_that) {
case _Subject() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'nombre')  String name, @JsonKey(name: 'periodo')  String period, @JsonKey(name: 'activa')  bool active, @JsonKey(name: 'docente')  String? teacher, @JsonKey(name: 'clave')  String? code)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Subject() when $default != null:
return $default(_that.id,_that.name,_that.period,_that.active,_that.teacher,_that.code);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'nombre')  String name, @JsonKey(name: 'periodo')  String period, @JsonKey(name: 'activa')  bool active, @JsonKey(name: 'docente')  String? teacher, @JsonKey(name: 'clave')  String? code)  $default,) {final _that = this;
switch (_that) {
case _Subject():
return $default(_that.id,_that.name,_that.period,_that.active,_that.teacher,_that.code);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'nombre')  String name, @JsonKey(name: 'periodo')  String period, @JsonKey(name: 'activa')  bool active, @JsonKey(name: 'docente')  String? teacher, @JsonKey(name: 'clave')  String? code)?  $default,) {final _that = this;
switch (_that) {
case _Subject() when $default != null:
return $default(_that.id,_that.name,_that.period,_that.active,_that.teacher,_that.code);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Subject implements Subject {
  const _Subject({required this.id, @JsonKey(name: 'nombre') required this.name, @JsonKey(name: 'periodo') required this.period, @JsonKey(name: 'activa') required this.active, @JsonKey(name: 'docente') this.teacher, @JsonKey(name: 'clave') this.code});
  factory _Subject.fromJson(Map<String, dynamic> json) => _$SubjectFromJson(json);

@override final  String id;
@override@JsonKey(name: 'nombre') final  String name;
@override@JsonKey(name: 'periodo') final  String period;
@override@JsonKey(name: 'activa') final  bool active;
@override@JsonKey(name: 'docente') final  String? teacher;
@override@JsonKey(name: 'clave') final  String? code;

/// Create a copy of Subject
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubjectCopyWith<_Subject> get copyWith => __$SubjectCopyWithImpl<_Subject>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubjectToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Subject&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.period, period) || other.period == period)&&(identical(other.active, active) || other.active == active)&&(identical(other.teacher, teacher) || other.teacher == teacher)&&(identical(other.code, code) || other.code == code));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,period,active,teacher,code);

@override
String toString() {
  return 'Subject(id: $id, name: $name, period: $period, active: $active, teacher: $teacher, code: $code)';
}


}

/// @nodoc
abstract mixin class _$SubjectCopyWith<$Res> implements $SubjectCopyWith<$Res> {
  factory _$SubjectCopyWith(_Subject value, $Res Function(_Subject) _then) = __$SubjectCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'nombre') String name,@JsonKey(name: 'periodo') String period,@JsonKey(name: 'activa') bool active,@JsonKey(name: 'docente') String? teacher,@JsonKey(name: 'clave') String? code
});




}
/// @nodoc
class __$SubjectCopyWithImpl<$Res>
    implements _$SubjectCopyWith<$Res> {
  __$SubjectCopyWithImpl(this._self, this._then);

  final _Subject _self;
  final $Res Function(_Subject) _then;

/// Create a copy of Subject
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? period = null,Object? active = null,Object? teacher = freezed,Object? code = freezed,}) {
  return _then(_Subject(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,teacher: freezed == teacher ? _self.teacher : teacher // ignore: cast_nullable_to_non_nullable
as String?,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
