// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'telegram_link.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TelegramLink {

@JsonKey(name: 'codigo') String get code;@JsonKey(name: 'comando') String get command;@JsonKey(name: 'expira_en') DateTime get expiresAt;
/// Create a copy of TelegramLink
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TelegramLinkCopyWith<TelegramLink> get copyWith => _$TelegramLinkCopyWithImpl<TelegramLink>(this as TelegramLink, _$identity);

  /// Serializes this TelegramLink to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TelegramLink&&(identical(other.code, code) || other.code == code)&&(identical(other.command, command) || other.command == command)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,command,expiresAt);

@override
String toString() {
  return 'TelegramLink(code: $code, command: $command, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class $TelegramLinkCopyWith<$Res>  {
  factory $TelegramLinkCopyWith(TelegramLink value, $Res Function(TelegramLink) _then) = _$TelegramLinkCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'codigo') String code,@JsonKey(name: 'comando') String command,@JsonKey(name: 'expira_en') DateTime expiresAt
});




}
/// @nodoc
class _$TelegramLinkCopyWithImpl<$Res>
    implements $TelegramLinkCopyWith<$Res> {
  _$TelegramLinkCopyWithImpl(this._self, this._then);

  final TelegramLink _self;
  final $Res Function(TelegramLink) _then;

/// Create a copy of TelegramLink
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? command = null,Object? expiresAt = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,command: null == command ? _self.command : command // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [TelegramLink].
extension TelegramLinkPatterns on TelegramLink {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TelegramLink value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TelegramLink() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TelegramLink value)  $default,){
final _that = this;
switch (_that) {
case _TelegramLink():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TelegramLink value)?  $default,){
final _that = this;
switch (_that) {
case _TelegramLink() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'codigo')  String code, @JsonKey(name: 'comando')  String command, @JsonKey(name: 'expira_en')  DateTime expiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TelegramLink() when $default != null:
return $default(_that.code,_that.command,_that.expiresAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'codigo')  String code, @JsonKey(name: 'comando')  String command, @JsonKey(name: 'expira_en')  DateTime expiresAt)  $default,) {final _that = this;
switch (_that) {
case _TelegramLink():
return $default(_that.code,_that.command,_that.expiresAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'codigo')  String code, @JsonKey(name: 'comando')  String command, @JsonKey(name: 'expira_en')  DateTime expiresAt)?  $default,) {final _that = this;
switch (_that) {
case _TelegramLink() when $default != null:
return $default(_that.code,_that.command,_that.expiresAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TelegramLink implements TelegramLink {
  const _TelegramLink({@JsonKey(name: 'codigo') required this.code, @JsonKey(name: 'comando') required this.command, @JsonKey(name: 'expira_en') required this.expiresAt});
  factory _TelegramLink.fromJson(Map<String, dynamic> json) => _$TelegramLinkFromJson(json);

@override@JsonKey(name: 'codigo') final  String code;
@override@JsonKey(name: 'comando') final  String command;
@override@JsonKey(name: 'expira_en') final  DateTime expiresAt;

/// Create a copy of TelegramLink
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TelegramLinkCopyWith<_TelegramLink> get copyWith => __$TelegramLinkCopyWithImpl<_TelegramLink>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TelegramLinkToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TelegramLink&&(identical(other.code, code) || other.code == code)&&(identical(other.command, command) || other.command == command)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,command,expiresAt);

@override
String toString() {
  return 'TelegramLink(code: $code, command: $command, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class _$TelegramLinkCopyWith<$Res> implements $TelegramLinkCopyWith<$Res> {
  factory _$TelegramLinkCopyWith(_TelegramLink value, $Res Function(_TelegramLink) _then) = __$TelegramLinkCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'codigo') String code,@JsonKey(name: 'comando') String command,@JsonKey(name: 'expira_en') DateTime expiresAt
});




}
/// @nodoc
class __$TelegramLinkCopyWithImpl<$Res>
    implements _$TelegramLinkCopyWith<$Res> {
  __$TelegramLinkCopyWithImpl(this._self, this._then);

  final _TelegramLink _self;
  final $Res Function(_TelegramLink) _then;

/// Create a copy of TelegramLink
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? command = null,Object? expiresAt = null,}) {
  return _then(_TelegramLink(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,command: null == command ? _self.command : command // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
