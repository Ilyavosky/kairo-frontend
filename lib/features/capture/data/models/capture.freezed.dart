// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'capture.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Capture {

 String get id;@JsonKey(name: 'mensaje') String get message;@JsonKey(name: 'entidad_tipo') CaptureKind get kind;@JsonKey(name: 'estado') String get status;@JsonKey(name: 'campos') Map<String, dynamic> get fields;@JsonKey(name: 'pendientes') List<String> get pending;@JsonKey(name: 'confianza') double? get confidence;@JsonKey(name: 'resultado_id') String? get resultId;
/// Create a copy of Capture
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CaptureCopyWith<Capture> get copyWith => _$CaptureCopyWithImpl<Capture>(this as Capture, _$identity);

  /// Serializes this Capture to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Capture&&(identical(other.id, id) || other.id == id)&&(identical(other.message, message) || other.message == message)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.fields, fields)&&const DeepCollectionEquality().equals(other.pending, pending)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.resultId, resultId) || other.resultId == resultId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,message,kind,status,const DeepCollectionEquality().hash(fields),const DeepCollectionEquality().hash(pending),confidence,resultId);

@override
String toString() {
  return 'Capture(id: $id, message: $message, kind: $kind, status: $status, fields: $fields, pending: $pending, confidence: $confidence, resultId: $resultId)';
}


}

/// @nodoc
abstract mixin class $CaptureCopyWith<$Res>  {
  factory $CaptureCopyWith(Capture value, $Res Function(Capture) _then) = _$CaptureCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'mensaje') String message,@JsonKey(name: 'entidad_tipo') CaptureKind kind,@JsonKey(name: 'estado') String status,@JsonKey(name: 'campos') Map<String, dynamic> fields,@JsonKey(name: 'pendientes') List<String> pending,@JsonKey(name: 'confianza') double? confidence,@JsonKey(name: 'resultado_id') String? resultId
});




}
/// @nodoc
class _$CaptureCopyWithImpl<$Res>
    implements $CaptureCopyWith<$Res> {
  _$CaptureCopyWithImpl(this._self, this._then);

  final Capture _self;
  final $Res Function(Capture) _then;

/// Create a copy of Capture
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? message = null,Object? kind = null,Object? status = null,Object? fields = null,Object? pending = null,Object? confidence = freezed,Object? resultId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as CaptureKind,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,fields: null == fields ? _self.fields : fields // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,pending: null == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as List<String>,confidence: freezed == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double?,resultId: freezed == resultId ? _self.resultId : resultId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Capture].
extension CapturePatterns on Capture {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Capture value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Capture() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Capture value)  $default,){
final _that = this;
switch (_that) {
case _Capture():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Capture value)?  $default,){
final _that = this;
switch (_that) {
case _Capture() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'mensaje')  String message, @JsonKey(name: 'entidad_tipo')  CaptureKind kind, @JsonKey(name: 'estado')  String status, @JsonKey(name: 'campos')  Map<String, dynamic> fields, @JsonKey(name: 'pendientes')  List<String> pending, @JsonKey(name: 'confianza')  double? confidence, @JsonKey(name: 'resultado_id')  String? resultId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Capture() when $default != null:
return $default(_that.id,_that.message,_that.kind,_that.status,_that.fields,_that.pending,_that.confidence,_that.resultId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'mensaje')  String message, @JsonKey(name: 'entidad_tipo')  CaptureKind kind, @JsonKey(name: 'estado')  String status, @JsonKey(name: 'campos')  Map<String, dynamic> fields, @JsonKey(name: 'pendientes')  List<String> pending, @JsonKey(name: 'confianza')  double? confidence, @JsonKey(name: 'resultado_id')  String? resultId)  $default,) {final _that = this;
switch (_that) {
case _Capture():
return $default(_that.id,_that.message,_that.kind,_that.status,_that.fields,_that.pending,_that.confidence,_that.resultId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'mensaje')  String message, @JsonKey(name: 'entidad_tipo')  CaptureKind kind, @JsonKey(name: 'estado')  String status, @JsonKey(name: 'campos')  Map<String, dynamic> fields, @JsonKey(name: 'pendientes')  List<String> pending, @JsonKey(name: 'confianza')  double? confidence, @JsonKey(name: 'resultado_id')  String? resultId)?  $default,) {final _that = this;
switch (_that) {
case _Capture() when $default != null:
return $default(_that.id,_that.message,_that.kind,_that.status,_that.fields,_that.pending,_that.confidence,_that.resultId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Capture implements Capture {
  const _Capture({required this.id, @JsonKey(name: 'mensaje') required this.message, @JsonKey(name: 'entidad_tipo') required this.kind, @JsonKey(name: 'estado') required this.status, @JsonKey(name: 'campos') required this.fields, @JsonKey(name: 'pendientes') required this.pending, @JsonKey(name: 'confianza') this.confidence, @JsonKey(name: 'resultado_id') this.resultId});
  factory _Capture.fromJson(Map<String, dynamic> json) => _$CaptureFromJson(json);

@override final  String id;
@override@JsonKey(name: 'mensaje') final  String message;
@override@JsonKey(name: 'entidad_tipo') final  CaptureKind kind;
@override@JsonKey(name: 'estado') final  String status;
@override@JsonKey(name: 'campos') final  Map<String, dynamic> fields;
@override@JsonKey(name: 'pendientes') final  List<String> pending;
@override@JsonKey(name: 'confianza') final  double? confidence;
@override@JsonKey(name: 'resultado_id') final  String? resultId;

/// Create a copy of Capture
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CaptureCopyWith<_Capture> get copyWith => __$CaptureCopyWithImpl<_Capture>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CaptureToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Capture&&(identical(other.id, id) || other.id == id)&&(identical(other.message, message) || other.message == message)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.fields, fields)&&const DeepCollectionEquality().equals(other.pending, pending)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.resultId, resultId) || other.resultId == resultId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,message,kind,status,const DeepCollectionEquality().hash(fields),const DeepCollectionEquality().hash(pending),confidence,resultId);

@override
String toString() {
  return 'Capture(id: $id, message: $message, kind: $kind, status: $status, fields: $fields, pending: $pending, confidence: $confidence, resultId: $resultId)';
}


}

/// @nodoc
abstract mixin class _$CaptureCopyWith<$Res> implements $CaptureCopyWith<$Res> {
  factory _$CaptureCopyWith(_Capture value, $Res Function(_Capture) _then) = __$CaptureCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'mensaje') String message,@JsonKey(name: 'entidad_tipo') CaptureKind kind,@JsonKey(name: 'estado') String status,@JsonKey(name: 'campos') Map<String, dynamic> fields,@JsonKey(name: 'pendientes') List<String> pending,@JsonKey(name: 'confianza') double? confidence,@JsonKey(name: 'resultado_id') String? resultId
});




}
/// @nodoc
class __$CaptureCopyWithImpl<$Res>
    implements _$CaptureCopyWith<$Res> {
  __$CaptureCopyWithImpl(this._self, this._then);

  final _Capture _self;
  final $Res Function(_Capture) _then;

/// Create a copy of Capture
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? message = null,Object? kind = null,Object? status = null,Object? fields = null,Object? pending = null,Object? confidence = freezed,Object? resultId = freezed,}) {
  return _then(_Capture(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as CaptureKind,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,fields: null == fields ? _self.fields : fields // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,pending: null == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as List<String>,confidence: freezed == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double?,resultId: freezed == resultId ? _self.resultId : resultId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
