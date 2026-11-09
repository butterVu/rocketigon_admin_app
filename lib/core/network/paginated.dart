import 'package:freezed_annotation/freezed_annotation.dart';

part 'paginated.freezed.dart';
part 'paginated.g.dart';

/// Pagination info from the `meta` field of a list response.
@freezed
abstract class PaginationMeta with _$PaginationMeta {
  /// Creates a [PaginationMeta].
  const factory PaginationMeta({
    /// Current page, starting at 1.
    required int page,
    required int limit,

    /// Total number of items across all pages.
    required int total,
    required int totalPages,
  }) = _PaginationMeta;

  /// Parses a [PaginationMeta] from [json].
  factory PaginationMeta.fromJson(Map<String, dynamic> json) =>
      _$PaginationMetaFromJson(json);
}

/// One page of [items] returned by a paginated endpoint.
@freezed
abstract class Paginated<T> with _$Paginated<T> {
  const Paginated._();

  /// Creates a [Paginated].
  const factory Paginated({
    required List<T> items,
    required PaginationMeta meta,
  }) = _Paginated<T>;

  /// Whether a page after this one exists.
  bool get hasNextPage => meta.page < meta.totalPages;

  /// Converts every item, keeping [meta], e.g. from models to entities.
  Paginated<R> map<R>(R Function(T item) convert) =>
      Paginated(items: [for (final item in items) convert(item)], meta: meta);
}
