// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'goal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Goal {

 String get id;@JsonKey(name: 'categoria_id') String get categoryId;@JsonKey(name: 'tipo') GoalType get type;@JsonKey(name: 'periodo') GoalPeriod get period;@JsonKey(name: 'objetivo') int get target;@JsonKey(name: 'vigente_desde') DateTime get validFrom;@JsonKey(name: 'activa') bool get active;@JsonKey(name: 'vigente_hasta') DateTime? get validUntil;
/// Create a copy of Goal
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GoalCopyWith<Goal> get copyWith => _$GoalCopyWithImpl<Goal>(this as Goal, _$identity);

  /// Serializes this Goal to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Goal&&(identical(other.id, id) || other.id == id)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.type, type) || other.type == type)&&(identical(other.period, period) || other.period == period)&&(identical(other.target, target) || other.target == target)&&(identical(other.validFrom, validFrom) || other.validFrom == validFrom)&&(identical(other.active, active) || other.active == active)&&(identical(other.validUntil, validUntil) || other.validUntil == validUntil));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,categoryId,type,period,target,validFrom,active,validUntil);

@override
String toString() {
  return 'Goal(id: $id, categoryId: $categoryId, type: $type, period: $period, target: $target, validFrom: $validFrom, active: $active, validUntil: $validUntil)';
}


}

/// @nodoc
abstract mixin class $GoalCopyWith<$Res>  {
  factory $GoalCopyWith(Goal value, $Res Function(Goal) _then) = _$GoalCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'categoria_id') String categoryId,@JsonKey(name: 'tipo') GoalType type,@JsonKey(name: 'periodo') GoalPeriod period,@JsonKey(name: 'objetivo') int target,@JsonKey(name: 'vigente_desde') DateTime validFrom,@JsonKey(name: 'activa') bool active,@JsonKey(name: 'vigente_hasta') DateTime? validUntil
});




}
/// @nodoc
class _$GoalCopyWithImpl<$Res>
    implements $GoalCopyWith<$Res> {
  _$GoalCopyWithImpl(this._self, this._then);

  final Goal _self;
  final $Res Function(Goal) _then;

/// Create a copy of Goal
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? categoryId = null,Object? type = null,Object? period = null,Object? target = null,Object? validFrom = null,Object? active = null,Object? validUntil = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as GoalType,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as GoalPeriod,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as int,validFrom: null == validFrom ? _self.validFrom : validFrom // ignore: cast_nullable_to_non_nullable
as DateTime,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,validUntil: freezed == validUntil ? _self.validUntil : validUntil // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Goal].
extension GoalPatterns on Goal {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Goal value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Goal() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Goal value)  $default,){
final _that = this;
switch (_that) {
case _Goal():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Goal value)?  $default,){
final _that = this;
switch (_that) {
case _Goal() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'categoria_id')  String categoryId, @JsonKey(name: 'tipo')  GoalType type, @JsonKey(name: 'periodo')  GoalPeriod period, @JsonKey(name: 'objetivo')  int target, @JsonKey(name: 'vigente_desde')  DateTime validFrom, @JsonKey(name: 'activa')  bool active, @JsonKey(name: 'vigente_hasta')  DateTime? validUntil)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Goal() when $default != null:
return $default(_that.id,_that.categoryId,_that.type,_that.period,_that.target,_that.validFrom,_that.active,_that.validUntil);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'categoria_id')  String categoryId, @JsonKey(name: 'tipo')  GoalType type, @JsonKey(name: 'periodo')  GoalPeriod period, @JsonKey(name: 'objetivo')  int target, @JsonKey(name: 'vigente_desde')  DateTime validFrom, @JsonKey(name: 'activa')  bool active, @JsonKey(name: 'vigente_hasta')  DateTime? validUntil)  $default,) {final _that = this;
switch (_that) {
case _Goal():
return $default(_that.id,_that.categoryId,_that.type,_that.period,_that.target,_that.validFrom,_that.active,_that.validUntil);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'categoria_id')  String categoryId, @JsonKey(name: 'tipo')  GoalType type, @JsonKey(name: 'periodo')  GoalPeriod period, @JsonKey(name: 'objetivo')  int target, @JsonKey(name: 'vigente_desde')  DateTime validFrom, @JsonKey(name: 'activa')  bool active, @JsonKey(name: 'vigente_hasta')  DateTime? validUntil)?  $default,) {final _that = this;
switch (_that) {
case _Goal() when $default != null:
return $default(_that.id,_that.categoryId,_that.type,_that.period,_that.target,_that.validFrom,_that.active,_that.validUntil);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Goal implements Goal {
  const _Goal({required this.id, @JsonKey(name: 'categoria_id') required this.categoryId, @JsonKey(name: 'tipo') required this.type, @JsonKey(name: 'periodo') required this.period, @JsonKey(name: 'objetivo') required this.target, @JsonKey(name: 'vigente_desde') required this.validFrom, @JsonKey(name: 'activa') required this.active, @JsonKey(name: 'vigente_hasta') this.validUntil});
  factory _Goal.fromJson(Map<String, dynamic> json) => _$GoalFromJson(json);

@override final  String id;
@override@JsonKey(name: 'categoria_id') final  String categoryId;
@override@JsonKey(name: 'tipo') final  GoalType type;
@override@JsonKey(name: 'periodo') final  GoalPeriod period;
@override@JsonKey(name: 'objetivo') final  int target;
@override@JsonKey(name: 'vigente_desde') final  DateTime validFrom;
@override@JsonKey(name: 'activa') final  bool active;
@override@JsonKey(name: 'vigente_hasta') final  DateTime? validUntil;

/// Create a copy of Goal
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GoalCopyWith<_Goal> get copyWith => __$GoalCopyWithImpl<_Goal>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GoalToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Goal&&(identical(other.id, id) || other.id == id)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.type, type) || other.type == type)&&(identical(other.period, period) || other.period == period)&&(identical(other.target, target) || other.target == target)&&(identical(other.validFrom, validFrom) || other.validFrom == validFrom)&&(identical(other.active, active) || other.active == active)&&(identical(other.validUntil, validUntil) || other.validUntil == validUntil));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,categoryId,type,period,target,validFrom,active,validUntil);

@override
String toString() {
  return 'Goal(id: $id, categoryId: $categoryId, type: $type, period: $period, target: $target, validFrom: $validFrom, active: $active, validUntil: $validUntil)';
}


}

/// @nodoc
abstract mixin class _$GoalCopyWith<$Res> implements $GoalCopyWith<$Res> {
  factory _$GoalCopyWith(_Goal value, $Res Function(_Goal) _then) = __$GoalCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'categoria_id') String categoryId,@JsonKey(name: 'tipo') GoalType type,@JsonKey(name: 'periodo') GoalPeriod period,@JsonKey(name: 'objetivo') int target,@JsonKey(name: 'vigente_desde') DateTime validFrom,@JsonKey(name: 'activa') bool active,@JsonKey(name: 'vigente_hasta') DateTime? validUntil
});




}
/// @nodoc
class __$GoalCopyWithImpl<$Res>
    implements _$GoalCopyWith<$Res> {
  __$GoalCopyWithImpl(this._self, this._then);

  final _Goal _self;
  final $Res Function(_Goal) _then;

/// Create a copy of Goal
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? categoryId = null,Object? type = null,Object? period = null,Object? target = null,Object? validFrom = null,Object? active = null,Object? validUntil = freezed,}) {
  return _then(_Goal(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as GoalType,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as GoalPeriod,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as int,validFrom: null == validFrom ? _self.validFrom : validFrom // ignore: cast_nullable_to_non_nullable
as DateTime,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,validUntil: freezed == validUntil ? _self.validUntil : validUntil // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
