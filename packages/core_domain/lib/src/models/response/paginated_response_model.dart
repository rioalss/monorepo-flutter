/// Paginated list models for API and repository layers.
///
/// [PaginatedMetaModel] holds page metadata; [PaginatedResponseModel] pairs
/// typed items with that metadata for list endpoints.
library;

import 'package:core_domain/src/converters/safe_json_converters.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'paginated_response_model.freezed.dart';
part 'paginated_response_model.g.dart';

/// Pagination metadata returned by list API endpoints.
@freezed
abstract class PaginatedMetaModel with _$PaginatedMetaModel {
  /// Creates pagination meta with safe JSON defaults for all fields.
  const factory PaginatedMetaModel({
    @SafeIntConverter() @Default(1) int page,
    @JsonKey(name: 'per_page') @SafeIntConverter() @Default(10) int perPage,
    @JsonKey(name: 'total_items') @SafeIntConverter() @Default(0) int totalItems,
    @JsonKey(name: 'total_pages') @SafeIntConverter() @Default(0) int totalPages,
    @JsonKey(name: 'has_next') @SafeBoolConverter() @Default(false) bool hasNext,
    @JsonKey(name: 'has_prev') @SafeBoolConverter() @Default(false) bool hasPrev,
  }) = _PaginatedMetaModel;

  /// Deserializes meta from a JSON map.
  factory PaginatedMetaModel.fromJson(Map<String, dynamic> json) =>
      _$PaginatedMetaModelFromJson(json);

  /// Builds pagination meta from DummyJSON list responses (`total`, `skip`, `limit`).
  ///
  /// Treats [limit] ≤ 0 as 1 to avoid division by zero. [hasNext] and [hasPrev]
  /// are derived from skip/limit relative to [total].
  factory PaginatedMetaModel.fromDummyJson({
    required int total,
    required int skip,
    required int limit,
  }) {
    final perPage = limit > 0 ? limit : 1;
    final page = (skip ~/ perPage) + 1;
    final totalPages = total == 0 ? 0 : (total + perPage - 1) ~/ perPage;
    return PaginatedMetaModel(
      page: page,
      perPage: perPage,
      totalItems: total,
      totalPages: totalPages,
      hasNext: skip + limit < total,
      hasPrev: skip > 0,
    );
  }
}

/// Paginated list payload for repository and UI layers.
@Freezed(genericArgumentFactories: true)
abstract class PaginatedResponseModel<T> with _$PaginatedResponseModel<T> {
  /// Creates a paginated response with [items] and [meta].
  const factory PaginatedResponseModel({
    required List<T> items,
    required PaginatedMetaModel meta,
  }) = _PaginatedResponseModel<T>;
}
