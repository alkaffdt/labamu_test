// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_product_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AddProductState {

 SubmissionStatus get submissionStatus; String? get id; String? get name; int? get price; String? get description; String get status;
/// Create a copy of AddProductState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddProductStateCopyWith<AddProductState> get copyWith => _$AddProductStateCopyWithImpl<AddProductState>(this as AddProductState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddProductState&&(identical(other.submissionStatus, submissionStatus) || other.submissionStatus == submissionStatus)&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.price, price) || other.price == price)&&(identical(other.description, description) || other.description == description)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,submissionStatus,id,name,price,description,status);

@override
String toString() {
  return 'AddProductState(submissionStatus: $submissionStatus, id: $id, name: $name, price: $price, description: $description, status: $status)';
}


}

/// @nodoc
abstract mixin class $AddProductStateCopyWith<$Res>  {
  factory $AddProductStateCopyWith(AddProductState value, $Res Function(AddProductState) _then) = _$AddProductStateCopyWithImpl;
@useResult
$Res call({
 SubmissionStatus submissionStatus, String? id, String? name, int? price, String? description, String status
});




}
/// @nodoc
class _$AddProductStateCopyWithImpl<$Res>
    implements $AddProductStateCopyWith<$Res> {
  _$AddProductStateCopyWithImpl(this._self, this._then);

  final AddProductState _self;
  final $Res Function(AddProductState) _then;

/// Create a copy of AddProductState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? submissionStatus = null,Object? id = freezed,Object? name = freezed,Object? price = freezed,Object? description = freezed,Object? status = null,}) {
  return _then(_self.copyWith(
submissionStatus: null == submissionStatus ? _self.submissionStatus : submissionStatus // ignore: cast_nullable_to_non_nullable
as SubmissionStatus,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AddProductState].
extension AddProductStatePatterns on AddProductState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AddProductState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AddProductState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AddProductState value)  $default,){
final _that = this;
switch (_that) {
case _AddProductState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AddProductState value)?  $default,){
final _that = this;
switch (_that) {
case _AddProductState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SubmissionStatus submissionStatus,  String? id,  String? name,  int? price,  String? description,  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AddProductState() when $default != null:
return $default(_that.submissionStatus,_that.id,_that.name,_that.price,_that.description,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SubmissionStatus submissionStatus,  String? id,  String? name,  int? price,  String? description,  String status)  $default,) {final _that = this;
switch (_that) {
case _AddProductState():
return $default(_that.submissionStatus,_that.id,_that.name,_that.price,_that.description,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SubmissionStatus submissionStatus,  String? id,  String? name,  int? price,  String? description,  String status)?  $default,) {final _that = this;
switch (_that) {
case _AddProductState() when $default != null:
return $default(_that.submissionStatus,_that.id,_that.name,_that.price,_that.description,_that.status);case _:
  return null;

}
}

}

/// @nodoc


class _AddProductState implements AddProductState {
  const _AddProductState({this.submissionStatus = SubmissionStatus.initial, this.id, this.name, this.price, this.description, this.status = 'active'});
  

@override@JsonKey() final  SubmissionStatus submissionStatus;
@override final  String? id;
@override final  String? name;
@override final  int? price;
@override final  String? description;
@override@JsonKey() final  String status;

/// Create a copy of AddProductState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddProductStateCopyWith<_AddProductState> get copyWith => __$AddProductStateCopyWithImpl<_AddProductState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddProductState&&(identical(other.submissionStatus, submissionStatus) || other.submissionStatus == submissionStatus)&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.price, price) || other.price == price)&&(identical(other.description, description) || other.description == description)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,submissionStatus,id,name,price,description,status);

@override
String toString() {
  return 'AddProductState(submissionStatus: $submissionStatus, id: $id, name: $name, price: $price, description: $description, status: $status)';
}


}

/// @nodoc
abstract mixin class _$AddProductStateCopyWith<$Res> implements $AddProductStateCopyWith<$Res> {
  factory _$AddProductStateCopyWith(_AddProductState value, $Res Function(_AddProductState) _then) = __$AddProductStateCopyWithImpl;
@override @useResult
$Res call({
 SubmissionStatus submissionStatus, String? id, String? name, int? price, String? description, String status
});




}
/// @nodoc
class __$AddProductStateCopyWithImpl<$Res>
    implements _$AddProductStateCopyWith<$Res> {
  __$AddProductStateCopyWithImpl(this._self, this._then);

  final _AddProductState _self;
  final $Res Function(_AddProductState) _then;

/// Create a copy of AddProductState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? submissionStatus = null,Object? id = freezed,Object? name = freezed,Object? price = freezed,Object? description = freezed,Object? status = null,}) {
  return _then(_AddProductState(
submissionStatus: null == submissionStatus ? _self.submissionStatus : submissionStatus // ignore: cast_nullable_to_non_nullable
as SubmissionStatus,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
