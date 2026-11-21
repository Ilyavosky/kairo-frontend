// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subject_input.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SubjectInput {

@JsonKey(name: 'nombre') String get name;@JsonKey(name: 'periodo') String get period;@JsonKey(name: 'docente') String? get teacher;@JsonKey(name: 'clave') String? get code;
/// Create a copy of SubjectInput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubjectInputCopyWith<SubjectInput> get copyWith => _$SubjectInputCopyWithImpl<SubjectInput>(this as SubjectInput, _$identity);

  /// Serializes this SubjectInput to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubjectInput&&(identical(other.name, name) || other.name == name)&&(identical(other.period, period) || other.period == period)&&(identical(other.teacher, teacher) || other.teacher == teacher)&&(identical(other.code, code) || other.code == code));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,period,teacher,code);

@override
String toString() {
  return 'SubjectInput(name: $name, period: $period, teacher: $teacher, code: $code)';
}


}

/// @nodoc
abstract mixin class $SubjectInputCopyWith<$Res>  {
  factory $SubjectInputCopyWith(SubjectInput value, $Res Function(SubjectInput) _then) = _$SubjectInputCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'nombre') String name,@JsonKey(name: 'periodo') String period,@JsonKey(name: 'docente') String? teacher,@JsonKey(name: 'clave') String? code
});




}
/// @nodoc
class _$SubjectInputCopyWithImpl<$Res>
    implements $SubjectInputCopyWith<$Res> {
  _$SubjectInputCopyWithImpl(this._self, this._then);

  final SubjectInput _self;
  final $Res Function(SubjectInput) _then;

/// Create a copy of SubjectInput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? period = null,Object? teacher = freezed,Object? code = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,teacher: freezed == teacher ? _self.teacher : teacher // ignore: cast_nullable_to_non_nullable
as String?,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SubjectInput].
extension SubjectInputPatterns on SubjectInput {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubjectInput value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubjectInput() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubjectInput value)  $default,){
final _that = this;
switch (_that) {
case _SubjectInput():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubjectInput value)?  $default,){
final _that = this;
switch (_that) {
case _SubjectInput() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'nombre')  String name, @JsonKey(name: 'periodo')  String period, @JsonKey(name: 'docente')  String? teacher, @JsonKey(name: 'clave')  String? code)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubjectInput() when $default != null:
return $default(_that.name,_that.period,_that.teacher,_that.code);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'nombre')  String name, @JsonKey(name: 'periodo')  String period, @JsonKey(name: 'docente')  String? teacher, @JsonKey(name: 'clave')  String? code)  $default,) {final _that = this;
switch (_that) {
case _SubjectInput():
return $default(_that.name,_that.period,_that.teacher,_that.code);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'nombre')  String name, @JsonKey(name: 'periodo')  String period, @JsonKey(name: 'docente')  String? teacher, @JsonKey(name: 'clave')  String? code)?  $default,) {final _that = this;
switch (_that) {
case _SubjectInput() when $default != null:
return $default(_that.name,_that.period,_that.teacher,_that.code);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubjectInput implements SubjectInput {
  const _SubjectInput({@JsonKey(name: 'nombre') required this.name, @JsonKey(name: 'periodo') required this.period, @JsonKey(name: 'docente') this.teacher, @JsonKey(name: 'clave') this.code});
  factory _SubjectInput.fromJson(Map<String, dynamic> json) => _$SubjectInputFromJson(json);

@override@JsonKey(name: 'nombre') final  String name;
@override@JsonKey(name: 'periodo') final  String period;
@override@JsonKey(name: 'docente') final  String? teacher;
@override@JsonKey(name: 'clave') final  String? code;

/// Create a copy of SubjectInput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubjectInputCopyWith<_SubjectInput> get copyWith => __$SubjectInputCopyWithImpl<_SubjectInput>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubjectInputToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubjectInput&&(identical(other.name, name) || other.name == name)&&(identical(other.period, period) || other.period == period)&&(identical(other.teacher, teacher) || other.teacher == teacher)&&(identical(other.code, code) || other.code == code));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,period,teacher,code);

@override
String toString() {
  return 'SubjectInput(name: $name, period: $period, teacher: $teacher, code: $code)';
}


}

/// @nodoc
abstract mixin class _$SubjectInputCopyWith<$Res> implements $SubjectInputCopyWith<$Res> {
  factory _$SubjectInputCopyWith(_SubjectInput value, $Res Function(_SubjectInput) _then) = __$SubjectInputCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'nombre') String name,@JsonKey(name: 'periodo') String period,@JsonKey(name: 'docente') String? teacher,@JsonKey(name: 'clave') String? code
});




}
/// @nodoc
class __$SubjectInputCopyWithImpl<$Res>
    implements _$SubjectInputCopyWith<$Res> {
  __$SubjectInputCopyWithImpl(this._self, this._then);

  final _SubjectInput _self;
  final $Res Function(_SubjectInput) _then;

/// Create a copy of SubjectInput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? period = null,Object? teacher = freezed,Object? code = freezed,}) {
  return _then(_SubjectInput(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,teacher: freezed == teacher ? _self.teacher : teacher // ignore: cast_nullable_to_non_nullable
as String?,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
