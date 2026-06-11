// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ApiResponseModel<T> _$ApiResponseModelFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => _ApiResponseModel<T>(
  success: json['success'] == null
      ? false
      : const SafeBoolConverter().fromJson(json['success']),
  message: const SafeNullableStringConverter().fromJson(json['message']),
  data: _$nullableGenericFromJson(json['data'], fromJsonT),
  error: json['error'] == null
      ? null
      : ApiErrorModel.fromJson(json['error'] as Map<String, dynamic>),
  meta: json['meta'] == null
      ? null
      : PaginatedMetaModel.fromJson(json['meta'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ApiResponseModelToJson<T>(
  _ApiResponseModel<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'success': const SafeBoolConverter().toJson(instance.success),
  'message': const SafeNullableStringConverter().toJson(instance.message),
  'data': _$nullableGenericToJson(instance.data, toJsonT),
  'error': instance.error,
  'meta': instance.meta,
};

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) => input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) => input == null ? null : toJson(input);
