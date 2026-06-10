// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ApiResponseModel<T> {
  @SafeBoolConverter()
  bool get success;
  @SafeNullableStringConverter()
  String? get message;
  T? get data;
  ApiErrorModel? get error;
  PaginatedMetaModel? get meta;

  /// Create a copy of ApiResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ApiResponseModelCopyWith<T, ApiResponseModel<T>> get copyWith =>
      _$ApiResponseModelCopyWithImpl<T, ApiResponseModel<T>>(
          this as ApiResponseModel<T>, _$identity);

  /// Serializes this ApiResponseModel to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ApiResponseModel<T> &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.meta, meta) || other.meta == meta));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, message,
      const DeepCollectionEquality().hash(data), error, meta);

  @override
  String toString() {
    return 'ApiResponseModel<$T>(success: $success, message: $message, data: $data, error: $error, meta: $meta)';
  }
}

/// @nodoc
abstract mixin class $ApiResponseModelCopyWith<T, $Res> {
  factory $ApiResponseModelCopyWith(
          ApiResponseModel<T> value, $Res Function(ApiResponseModel<T>) _then) =
      _$ApiResponseModelCopyWithImpl;
  @useResult
  $Res call(
      {@SafeBoolConverter() bool success,
      @SafeNullableStringConverter() String? message,
      T? data,
      ApiErrorModel? error,
      PaginatedMetaModel? meta});

  $ApiErrorModelCopyWith<$Res>? get error;
  $PaginatedMetaModelCopyWith<$Res>? get meta;
}

/// @nodoc
class _$ApiResponseModelCopyWithImpl<T, $Res>
    implements $ApiResponseModelCopyWith<T, $Res> {
  _$ApiResponseModelCopyWithImpl(this._self, this._then);

  final ApiResponseModel<T> _self;
  final $Res Function(ApiResponseModel<T>) _then;

  /// Create a copy of ApiResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = freezed,
    Object? data = freezed,
    Object? error = freezed,
    Object? meta = freezed,
  }) {
    return _then(_self.copyWith(
      success: null == success
          ? _self.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: freezed == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as T?,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as ApiErrorModel?,
      meta: freezed == meta
          ? _self.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as PaginatedMetaModel?,
    ));
  }

  /// Create a copy of ApiResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ApiErrorModelCopyWith<$Res>? get error {
    if (_self.error == null) {
      return null;
    }

    return $ApiErrorModelCopyWith<$Res>(_self.error!, (value) {
      return _then(_self.copyWith(error: value));
    });
  }

  /// Create a copy of ApiResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PaginatedMetaModelCopyWith<$Res>? get meta {
    if (_self.meta == null) {
      return null;
    }

    return $PaginatedMetaModelCopyWith<$Res>(_self.meta!, (value) {
      return _then(_self.copyWith(meta: value));
    });
  }
}

/// Adds pattern-matching-related methods to [ApiResponseModel].
extension ApiResponseModelPatterns<T> on ApiResponseModel<T> {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ApiResponseModel<T> value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ApiResponseModel() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ApiResponseModel<T> value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ApiResponseModel():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ApiResponseModel<T> value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ApiResponseModel() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            @SafeBoolConverter() bool success,
            @SafeNullableStringConverter() String? message,
            T? data,
            ApiErrorModel? error,
            PaginatedMetaModel? meta)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ApiResponseModel() when $default != null:
        return $default(
            _that.success, _that.message, _that.data, _that.error, _that.meta);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            @SafeBoolConverter() bool success,
            @SafeNullableStringConverter() String? message,
            T? data,
            ApiErrorModel? error,
            PaginatedMetaModel? meta)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ApiResponseModel():
        return $default(
            _that.success, _that.message, _that.data, _that.error, _that.meta);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            @SafeBoolConverter() bool success,
            @SafeNullableStringConverter() String? message,
            T? data,
            ApiErrorModel? error,
            PaginatedMetaModel? meta)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ApiResponseModel() when $default != null:
        return $default(
            _that.success, _that.message, _that.data, _that.error, _that.meta);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)
class _ApiResponseModel<T> implements ApiResponseModel<T> {
  const _ApiResponseModel(
      {@SafeBoolConverter() this.success = false,
      @SafeNullableStringConverter() this.message,
      this.data,
      this.error,
      this.meta});
  factory _ApiResponseModel.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$ApiResponseModelFromJson(json, fromJsonT);

  @override
  @JsonKey()
  @SafeBoolConverter()
  final bool success;
  @override
  @SafeNullableStringConverter()
  final String? message;
  @override
  final T? data;
  @override
  final ApiErrorModel? error;
  @override
  final PaginatedMetaModel? meta;

  /// Create a copy of ApiResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ApiResponseModelCopyWith<T, _ApiResponseModel<T>> get copyWith =>
      __$ApiResponseModelCopyWithImpl<T, _ApiResponseModel<T>>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return _$ApiResponseModelToJson<T>(this, toJsonT);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ApiResponseModel<T> &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.meta, meta) || other.meta == meta));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, message,
      const DeepCollectionEquality().hash(data), error, meta);

  @override
  String toString() {
    return 'ApiResponseModel<$T>(success: $success, message: $message, data: $data, error: $error, meta: $meta)';
  }
}

/// @nodoc
abstract mixin class _$ApiResponseModelCopyWith<T, $Res>
    implements $ApiResponseModelCopyWith<T, $Res> {
  factory _$ApiResponseModelCopyWith(_ApiResponseModel<T> value,
          $Res Function(_ApiResponseModel<T>) _then) =
      __$ApiResponseModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@SafeBoolConverter() bool success,
      @SafeNullableStringConverter() String? message,
      T? data,
      ApiErrorModel? error,
      PaginatedMetaModel? meta});

  @override
  $ApiErrorModelCopyWith<$Res>? get error;
  @override
  $PaginatedMetaModelCopyWith<$Res>? get meta;
}

/// @nodoc
class __$ApiResponseModelCopyWithImpl<T, $Res>
    implements _$ApiResponseModelCopyWith<T, $Res> {
  __$ApiResponseModelCopyWithImpl(this._self, this._then);

  final _ApiResponseModel<T> _self;
  final $Res Function(_ApiResponseModel<T>) _then;

  /// Create a copy of ApiResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? success = null,
    Object? message = freezed,
    Object? data = freezed,
    Object? error = freezed,
    Object? meta = freezed,
  }) {
    return _then(_ApiResponseModel<T>(
      success: null == success
          ? _self.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: freezed == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as T?,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as ApiErrorModel?,
      meta: freezed == meta
          ? _self.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as PaginatedMetaModel?,
    ));
  }

  /// Create a copy of ApiResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ApiErrorModelCopyWith<$Res>? get error {
    if (_self.error == null) {
      return null;
    }

    return $ApiErrorModelCopyWith<$Res>(_self.error!, (value) {
      return _then(_self.copyWith(error: value));
    });
  }

  /// Create a copy of ApiResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PaginatedMetaModelCopyWith<$Res>? get meta {
    if (_self.meta == null) {
      return null;
    }

    return $PaginatedMetaModelCopyWith<$Res>(_self.meta!, (value) {
      return _then(_self.copyWith(meta: value));
    });
  }
}

// dart format on
