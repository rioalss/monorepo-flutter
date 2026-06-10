// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PaginatedMetaModel _$PaginatedMetaModelFromJson(Map<String, dynamic> json) =>
    _PaginatedMetaModel(
      page: json['page'] == null
          ? 1
          : const SafeIntConverter().fromJson(json['page']),
      perPage: json['per_page'] == null
          ? 10
          : const SafeIntConverter().fromJson(json['per_page']),
      totalItems: json['total_items'] == null
          ? 0
          : const SafeIntConverter().fromJson(json['total_items']),
      totalPages: json['total_pages'] == null
          ? 0
          : const SafeIntConverter().fromJson(json['total_pages']),
      hasNext: json['has_next'] == null
          ? false
          : const SafeBoolConverter().fromJson(json['has_next']),
      hasPrev: json['has_prev'] == null
          ? false
          : const SafeBoolConverter().fromJson(json['has_prev']),
    );

Map<String, dynamic> _$PaginatedMetaModelToJson(_PaginatedMetaModel instance) =>
    <String, dynamic>{
      'page': const SafeIntConverter().toJson(instance.page),
      'per_page': const SafeIntConverter().toJson(instance.perPage),
      'total_items': const SafeIntConverter().toJson(instance.totalItems),
      'total_pages': const SafeIntConverter().toJson(instance.totalPages),
      'has_next': const SafeBoolConverter().toJson(instance.hasNext),
      'has_prev': const SafeBoolConverter().toJson(instance.hasPrev),
    };
