// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'goal_input.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GoalInput {

@JsonKey(name: 'categoria_id') String get categoryId;@JsonKey(name: 'tipo') GoalType get type;@JsonKey(name: 'periodo') GoalPeriod get period;@JsonKey(name: 'objetivo') int get target;
/// Create a copy of GoalInput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GoalInputCopyWith<GoalInput> get copyWith => _$GoalInputCopyWithImpl<GoalInput>(this as GoalInput, _$identity);

  /// Serializes this GoalInput to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GoalInput&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.type, type) || other.type == type)&&(identical(other.period, period) || other.period == period)&&(identical(other.target, target) || other.target == target));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,categoryId,type,period,target);

@override
String toString() {
  return 'GoalInput(categoryId: $categoryId, type: $type, period: $period, target: $target)';
}


}

/// @nodoc
abstract mixin class $GoalInputCopyWith<$Res>  {
  factory $GoalInputCopyWith(GoalInput value, $Res Function(GoalInput) _then) = _$GoalInputCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'categoria_id') String categoryId,@JsonKey(name: 'tipo') GoalType type,@JsonKey(name: 'periodo') GoalPeriod period,@JsonKey(name: 'objetivo') int target
});




}
/// @nodoc
class _$GoalInputCopyWithImpl<$Res>
    implements $GoalInputCopyWith<$Res> {
  _$GoalInputCopyWithImpl(this._self, this._then);

  final GoalInput _self;
  final $Res Function(GoalInput) _then;

/// Create a copy of GoalInput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? categoryId = null,Object? type = null,Object? period = null,Object? target = null,}) {
  return _then(_self.copyWith(
categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as GoalType,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as GoalPeriod,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [GoalInput].
extension GoalInputPatterns on GoalInput {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GoalInput value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GoalInput() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GoalInput value)  $default,){
final _that = this;
switch (_that) {
case _GoalInput():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GoalInput value)?  $default,){
final _that = this;
switch (_that) {
case _GoalInput() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'categoria_id')  String categoryId, @JsonKey(name: 'tipo')  GoalType type, @JsonKey(name: 'periodo')  GoalPeriod period, @JsonKey(name: 'objetivo')  int target)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GoalInput() when $default != null:
return $default(_that.categoryId,_that.type,_that.period,_that.target);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'categoria_id')  String categoryId, @JsonKey(name: 'tipo')  GoalType type, @JsonKey(name: 'periodo')  GoalPeriod period, @JsonKey(name: 'objetivo')  int target)  $default,) {final _that = this;
switch (_that) {
case _GoalInput():
return $default(_that.categoryId,_that.type,_that.period,_that.target);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'categoria_id')  String categoryId, @JsonKey(name: 'tipo')  GoalType type, @JsonKey(name: 'periodo')  GoalPeriod period, @JsonKey(name: 'objetivo')  int target)?  $default,) {final _that = this;
switch (_that) {
case _GoalInput() when $default != null:
return $default(_that.categoryId,_that.type,_that.period,_that.target);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GoalInput implements GoalInput {
  const _GoalInput({@JsonKey(name: 'categoria_id') required this.categoryId, @JsonKey(name: 'tipo') required this.type, @JsonKey(name: 'periodo') required this.period, @JsonKey(name: 'objetivo') required this.target});
  factory _GoalInput.fromJson(Map<String, dynamic> json) => _$GoalInputFromJson(json);

@override@JsonKey(name: 'categoria_id') final  String categoryId;
@override@JsonKey(name: 'tipo') final  GoalType type;
@override@JsonKey(name: 'periodo') final  GoalPeriod period;
@override@JsonKey(name: 'objetivo') final  int target;

/// Create a copy of GoalInput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GoalInputCopyWith<_GoalInput> get copyWith => __$GoalInputCopyWithImpl<_GoalInput>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GoalInputToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GoalInput&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.type, type) || other.type == type)&&(identical(other.period, period) || other.period == period)&&(identical(other.target, target) || other.target == target));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,categoryId,type,period,target);

@override
String toString() {
  return 'GoalInput(categoryId: $categoryId, type: $type, period: $period, target: $target)';
}


}

/// @nodoc
abstract mixin class _$GoalInputCopyWith<$Res> implements $GoalInputCopyWith<$Res> {
  factory _$GoalInputCopyWith(_GoalInput value, $Res Function(_GoalInput) _then) = __$GoalInputCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'categoria_id') String categoryId,@JsonKey(name: 'tipo') GoalType type,@JsonKey(name: 'periodo') GoalPeriod period,@JsonKey(name: 'objetivo') int target
});




}
/// @nodoc
class __$GoalInputCopyWithImpl<$Res>
    implements _$GoalInputCopyWith<$Res> {
  __$GoalInputCopyWithImpl(this._self, this._then);

  final _GoalInput _self;
  final $Res Function(_GoalInput) _then;

/// Create a copy of GoalInput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? categoryId = null,Object? type = null,Object? period = null,Object? target = null,}) {
  return _then(_GoalInput(
categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as GoalType,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as GoalPeriod,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
