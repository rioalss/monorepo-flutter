// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paginated_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PaginatedMetaModel {

@SafeIntConverter() int get page;@JsonKey(name: 'per_page')@SafeIntConverter() int get perPage;@JsonKey(name: 'total_items')@SafeIntConverter() int get totalItems;@JsonKey(name: 'total_pages')@SafeIntConverter() int get totalPages;@JsonKey(name: 'has_next')@SafeBoolConverter() bool get hasNext;@JsonKey(name: 'has_prev')@SafeBoolConverter() bool get hasPrev;
/// Create a copy of PaginatedMetaModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaginatedMetaModelCopyWith<PaginatedMetaModel> get copyWith => _$PaginatedMetaModelCopyWithImpl<PaginatedMetaModel>(this as PaginatedMetaModel, _$identity);

  /// Serializes this PaginatedMetaModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaginatedMetaModel&&(identical(other.page, page) || other.page == page)&&(identical(other.perPage, perPage) || other.perPage == perPage)&&(identical(other.totalItems, totalItems) || other.totalItems == totalItems)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.hasNext, hasNext) || other.hasNext == hasNext)&&(identical(other.hasPrev, hasPrev) || other.hasPrev == hasPrev));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,page,perPage,totalItems,totalPages,hasNext,hasPrev);

@override
String toString() {
  return 'PaginatedMetaModel(page: $page, perPage: $perPage, totalItems: $totalItems, totalPages: $totalPages, hasNext: $hasNext, hasPrev: $hasPrev)';
}


}

/// @nodoc
abstract mixin class $PaginatedMetaModelCopyWith<$Res>  {
  factory $PaginatedMetaModelCopyWith(PaginatedMetaModel value, $Res Function(PaginatedMetaModel) _then) = _$PaginatedMetaModelCopyWithImpl;
@useResult
$Res call({
@SafeIntConverter() int page,@JsonKey(name: 'per_page')@SafeIntConverter() int perPage,@JsonKey(name: 'total_items')@SafeIntConverter() int totalItems,@JsonKey(name: 'total_pages')@SafeIntConverter() int totalPages,@JsonKey(name: 'has_next')@SafeBoolConverter() bool hasNext,@JsonKey(name: 'has_prev')@SafeBoolConverter() bool hasPrev
});




}
/// @nodoc
class _$PaginatedMetaModelCopyWithImpl<$Res>
    implements $PaginatedMetaModelCopyWith<$Res> {
  _$PaginatedMetaModelCopyWithImpl(this._self, this._then);

  final PaginatedMetaModel _self;
  final $Res Function(PaginatedMetaModel) _then;

/// Create a copy of PaginatedMetaModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? page = null,Object? perPage = null,Object? totalItems = null,Object? totalPages = null,Object? hasNext = null,Object? hasPrev = null,}) {
  return _then(_self.copyWith(
page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,perPage: null == perPage ? _self.perPage : perPage // ignore: cast_nullable_to_non_nullable
as int,totalItems: null == totalItems ? _self.totalItems : totalItems // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,hasNext: null == hasNext ? _self.hasNext : hasNext // ignore: cast_nullable_to_non_nullable
as bool,hasPrev: null == hasPrev ? _self.hasPrev : hasPrev // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PaginatedMetaModel].
extension PaginatedMetaModelPatterns on PaginatedMetaModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaginatedMetaModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaginatedMetaModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaginatedMetaModel value)  $default,){
final _that = this;
switch (_that) {
case _PaginatedMetaModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaginatedMetaModel value)?  $default,){
final _that = this;
switch (_that) {
case _PaginatedMetaModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@SafeIntConverter()  int page, @JsonKey(name: 'per_page')@SafeIntConverter()  int perPage, @JsonKey(name: 'total_items')@SafeIntConverter()  int totalItems, @JsonKey(name: 'total_pages')@SafeIntConverter()  int totalPages, @JsonKey(name: 'has_next')@SafeBoolConverter()  bool hasNext, @JsonKey(name: 'has_prev')@SafeBoolConverter()  bool hasPrev)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaginatedMetaModel() when $default != null:
return $default(_that.page,_that.perPage,_that.totalItems,_that.totalPages,_that.hasNext,_that.hasPrev);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@SafeIntConverter()  int page, @JsonKey(name: 'per_page')@SafeIntConverter()  int perPage, @JsonKey(name: 'total_items')@SafeIntConverter()  int totalItems, @JsonKey(name: 'total_pages')@SafeIntConverter()  int totalPages, @JsonKey(name: 'has_next')@SafeBoolConverter()  bool hasNext, @JsonKey(name: 'has_prev')@SafeBoolConverter()  bool hasPrev)  $default,) {final _that = this;
switch (_that) {
case _PaginatedMetaModel():
return $default(_that.page,_that.perPage,_that.totalItems,_that.totalPages,_that.hasNext,_that.hasPrev);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@SafeIntConverter()  int page, @JsonKey(name: 'per_page')@SafeIntConverter()  int perPage, @JsonKey(name: 'total_items')@SafeIntConverter()  int totalItems, @JsonKey(name: 'total_pages')@SafeIntConverter()  int totalPages, @JsonKey(name: 'has_next')@SafeBoolConverter()  bool hasNext, @JsonKey(name: 'has_prev')@SafeBoolConverter()  bool hasPrev)?  $default,) {final _that = this;
switch (_that) {
case _PaginatedMetaModel() when $default != null:
return $default(_that.page,_that.perPage,_that.totalItems,_that.totalPages,_that.hasNext,_that.hasPrev);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaginatedMetaModel implements PaginatedMetaModel {
  const _PaginatedMetaModel({@SafeIntConverter() this.page = 1, @JsonKey(name: 'per_page')@SafeIntConverter() this.perPage = 10, @JsonKey(name: 'total_items')@SafeIntConverter() this.totalItems = 0, @JsonKey(name: 'total_pages')@SafeIntConverter() this.totalPages = 0, @JsonKey(name: 'has_next')@SafeBoolConverter() this.hasNext = false, @JsonKey(name: 'has_prev')@SafeBoolConverter() this.hasPrev = false});
  factory _PaginatedMetaModel.fromJson(Map<String, dynamic> json) => _$PaginatedMetaModelFromJson(json);

@override@JsonKey()@SafeIntConverter() final  int page;
@override@JsonKey(name: 'per_page')@SafeIntConverter() final  int perPage;
@override@JsonKey(name: 'total_items')@SafeIntConverter() final  int totalItems;
@override@JsonKey(name: 'total_pages')@SafeIntConverter() final  int totalPages;
@override@JsonKey(name: 'has_next')@SafeBoolConverter() final  bool hasNext;
@override@JsonKey(name: 'has_prev')@SafeBoolConverter() final  bool hasPrev;

/// Create a copy of PaginatedMetaModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaginatedMetaModelCopyWith<_PaginatedMetaModel> get copyWith => __$PaginatedMetaModelCopyWithImpl<_PaginatedMetaModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaginatedMetaModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaginatedMetaModel&&(identical(other.page, page) || other.page == page)&&(identical(other.perPage, perPage) || other.perPage == perPage)&&(identical(other.totalItems, totalItems) || other.totalItems == totalItems)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.hasNext, hasNext) || other.hasNext == hasNext)&&(identical(other.hasPrev, hasPrev) || other.hasPrev == hasPrev));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,page,perPage,totalItems,totalPages,hasNext,hasPrev);

@override
String toString() {
  return 'PaginatedMetaModel(page: $page, perPage: $perPage, totalItems: $totalItems, totalPages: $totalPages, hasNext: $hasNext, hasPrev: $hasPrev)';
}


}

/// @nodoc
abstract mixin class _$PaginatedMetaModelCopyWith<$Res> implements $PaginatedMetaModelCopyWith<$Res> {
  factory _$PaginatedMetaModelCopyWith(_PaginatedMetaModel value, $Res Function(_PaginatedMetaModel) _then) = __$PaginatedMetaModelCopyWithImpl;
@override @useResult
$Res call({
@SafeIntConverter() int page,@JsonKey(name: 'per_page')@SafeIntConverter() int perPage,@JsonKey(name: 'total_items')@SafeIntConverter() int totalItems,@JsonKey(name: 'total_pages')@SafeIntConverter() int totalPages,@JsonKey(name: 'has_next')@SafeBoolConverter() bool hasNext,@JsonKey(name: 'has_prev')@SafeBoolConverter() bool hasPrev
});




}
/// @nodoc
class __$PaginatedMetaModelCopyWithImpl<$Res>
    implements _$PaginatedMetaModelCopyWith<$Res> {
  __$PaginatedMetaModelCopyWithImpl(this._self, this._then);

  final _PaginatedMetaModel _self;
  final $Res Function(_PaginatedMetaModel) _then;

/// Create a copy of PaginatedMetaModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? page = null,Object? perPage = null,Object? totalItems = null,Object? totalPages = null,Object? hasNext = null,Object? hasPrev = null,}) {
  return _then(_PaginatedMetaModel(
page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,perPage: null == perPage ? _self.perPage : perPage // ignore: cast_nullable_to_non_nullable
as int,totalItems: null == totalItems ? _self.totalItems : totalItems // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,hasNext: null == hasNext ? _self.hasNext : hasNext // ignore: cast_nullable_to_non_nullable
as bool,hasPrev: null == hasPrev ? _self.hasPrev : hasPrev // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$PaginatedResponseModel<T> {

 List<T> get items; PaginatedMetaModel get meta;
/// Create a copy of PaginatedResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaginatedResponseModelCopyWith<T, PaginatedResponseModel<T>> get copyWith => _$PaginatedResponseModelCopyWithImpl<T, PaginatedResponseModel<T>>(this as PaginatedResponseModel<T>, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaginatedResponseModel<T>&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.meta, meta) || other.meta == meta));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),meta);

@override
String toString() {
  return 'PaginatedResponseModel<$T>(items: $items, meta: $meta)';
}


}

/// @nodoc
abstract mixin class $PaginatedResponseModelCopyWith<T,$Res>  {
  factory $PaginatedResponseModelCopyWith(PaginatedResponseModel<T> value, $Res Function(PaginatedResponseModel<T>) _then) = _$PaginatedResponseModelCopyWithImpl;
@useResult
$Res call({
 List<T> items, PaginatedMetaModel meta
});


$PaginatedMetaModelCopyWith<$Res> get meta;

}
/// @nodoc
class _$PaginatedResponseModelCopyWithImpl<T,$Res>
    implements $PaginatedResponseModelCopyWith<T, $Res> {
  _$PaginatedResponseModelCopyWithImpl(this._self, this._then);

  final PaginatedResponseModel<T> _self;
  final $Res Function(PaginatedResponseModel<T>) _then;

/// Create a copy of PaginatedResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? meta = null,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<T>,meta: null == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as PaginatedMetaModel,
  ));
}
/// Create a copy of PaginatedResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaginatedMetaModelCopyWith<$Res> get meta {
  
  return $PaginatedMetaModelCopyWith<$Res>(_self.meta, (value) {
    return _then(_self.copyWith(meta: value));
  });
}
}


/// Adds pattern-matching-related methods to [PaginatedResponseModel].
extension PaginatedResponseModelPatterns<T> on PaginatedResponseModel<T> {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaginatedResponseModel<T> value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaginatedResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaginatedResponseModel<T> value)  $default,){
final _that = this;
switch (_that) {
case _PaginatedResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaginatedResponseModel<T> value)?  $default,){
final _that = this;
switch (_that) {
case _PaginatedResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<T> items,  PaginatedMetaModel meta)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaginatedResponseModel() when $default != null:
return $default(_that.items,_that.meta);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<T> items,  PaginatedMetaModel meta)  $default,) {final _that = this;
switch (_that) {
case _PaginatedResponseModel():
return $default(_that.items,_that.meta);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<T> items,  PaginatedMetaModel meta)?  $default,) {final _that = this;
switch (_that) {
case _PaginatedResponseModel() when $default != null:
return $default(_that.items,_that.meta);case _:
  return null;

}
}

}

/// @nodoc


class _PaginatedResponseModel<T> implements PaginatedResponseModel<T> {
  const _PaginatedResponseModel({required final  List<T> items, required this.meta}): _items = items;
  

 final  List<T> _items;
@override List<T> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  PaginatedMetaModel meta;

/// Create a copy of PaginatedResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaginatedResponseModelCopyWith<T, _PaginatedResponseModel<T>> get copyWith => __$PaginatedResponseModelCopyWithImpl<T, _PaginatedResponseModel<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaginatedResponseModel<T>&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.meta, meta) || other.meta == meta));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),meta);

@override
String toString() {
  return 'PaginatedResponseModel<$T>(items: $items, meta: $meta)';
}


}

/// @nodoc
abstract mixin class _$PaginatedResponseModelCopyWith<T,$Res> implements $PaginatedResponseModelCopyWith<T, $Res> {
  factory _$PaginatedResponseModelCopyWith(_PaginatedResponseModel<T> value, $Res Function(_PaginatedResponseModel<T>) _then) = __$PaginatedResponseModelCopyWithImpl;
@override @useResult
$Res call({
 List<T> items, PaginatedMetaModel meta
});


@override $PaginatedMetaModelCopyWith<$Res> get meta;

}
/// @nodoc
class __$PaginatedResponseModelCopyWithImpl<T,$Res>
    implements _$PaginatedResponseModelCopyWith<T, $Res> {
  __$PaginatedResponseModelCopyWithImpl(this._self, this._then);

  final _PaginatedResponseModel<T> _self;
  final $Res Function(_PaginatedResponseModel<T>) _then;

/// Create a copy of PaginatedResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? meta = null,}) {
  return _then(_PaginatedResponseModel<T>(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<T>,meta: null == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as PaginatedMetaModel,
  ));
}

/// Create a copy of PaginatedResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaginatedMetaModelCopyWith<$Res> get meta {
  
  return $PaginatedMetaModelCopyWith<$Res>(_self.meta, (value) {
    return _then(_self.copyWith(meta: value));
  });
}
}

// dart format on
