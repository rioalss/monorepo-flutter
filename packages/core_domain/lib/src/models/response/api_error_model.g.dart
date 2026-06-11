// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_error_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ApiErrorModel _$ApiErrorModelFromJson(Map<String, dynamic> json) =>
    _ApiErrorModel(
      statusCode: const SafeNullableIntConverter().fromJson(json['statusCode']),
      message: const SafeNullableStringConverter().fromJson(json['message']),
      errors: (json['errors'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
      ),
    );

Map<String, dynamic> _$ApiErrorModelToJson(
  _ApiErrorModel instance,
) => <String, dynamic>{
  'statusCode': const SafeNullableIntConverter().toJson(instance.statusCode),
  'message': const SafeNullableStringConverter().toJson(instance.message),
  'errors': instance.errors,
};
