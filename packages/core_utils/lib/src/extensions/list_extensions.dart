// ignore_for_file: document_ignores, omit_local_variable_types, strict_raw_type

import 'dart:math';

/// [List] safe access, grouping, sorting, and aggregation helpers.
extension ListExtensions<T> on List<T> {
  // ==================== Safe Access ====================

  /// Get element at index or null
  T? getOrNull(int index) =>
      (index >= 0 && index < length) ? this[index] : null;

  /// Get element at index or default value
  T getOrDefault(int index, T defaultValue) => getOrNull(index) ?? defaultValue;

  /// Get first element or null
  T? get firstOrNull => isEmpty ? null : first;

  /// Get last element or null
  T? get lastOrNull => isEmpty ? null : last;

  /// Get random element
  T? get random => isEmpty ? null : this[Random().nextInt(length)];

  // ==================== Manipulation ====================

  /// Remove duplicates
  List<T> get unique => toSet().toList();

  /// Remove duplicates by key
  List<T> uniqueBy<K>(K Function(T) keyOf) {
    final keys = <K>{};
    return where((element) => keys.add(keyOf(element))).toList();
  }

  /// Separate list with item
  List<T> separatedBy(T separator) {
    if (isEmpty) return [];
    final result = <T>[];
    for (var i = 0; i < length; i++) {
      result.add(this[i]);
      if (i < length - 1) {
        result.add(separator);
      }
    }
    return result;
  }

  /// Chunk list into smaller lists
  List<List<T>> chunked(int chunkSize) {
    final chunks = <List<T>>[];
    for (var i = 0; i < length; i += chunkSize) {
      chunks.add(sublist(i, min(i + chunkSize, length)));
    }
    return chunks;
  }

  /// Rotate list by n positions
  List<T> rotated(int n) {
    if (isEmpty) return [];
    final normalized = n % length;
    return [...sublist(normalized), ...sublist(0, normalized)];
  }

  /// Shuffle and return new list
  List<T> get shuffled => [...this]..shuffle();

  /// Sorted with comparator (returns new list)
  List<T> sortedBy(Comparable Function(T) keyOf) =>
      [...this]..sort((a, b) => keyOf(a).compareTo(keyOf(b)));

  /// Sorted descending
  List<T> sortedByDescending(Comparable Function(T) keyOf) =>
      [...this]..sort((a, b) => keyOf(b).compareTo(keyOf(a)));

  // ==================== Searching ====================

  /// Find first matching element or null
  T? firstWhereOrNull(bool Function(T) test) {
    for (final element in this) {
      if (test(element)) return element;
    }
    return null;
  }

  /// Find last matching element or null
  T? lastWhereOrNull(bool Function(T) test) {
    for (var i = length - 1; i >= 0; i--) {
      if (test(this[i])) return this[i];
    }
    return null;
  }

  /// Count elements matching predicate
  int count(bool Function(T) test) => where(test).length;

  /// Check if any element matches
  bool any(bool Function(T) test) {
    for (final element in this) {
      if (test(element)) return true;
    }
    return false;
  }

  /// Check if all elements match
  bool all(bool Function(T) test) {
    for (final element in this) {
      if (!test(element)) return false;
    }
    return true;
  }

  /// Check if none match
  bool none(bool Function(T) test) => !any(test);

  // ==================== Transformation ====================

  /// Map with index
  List<R> mapIndexed<R>(R Function(int index, T element) transform) {
    final result = <R>[];
    for (var i = 0; i < length; i++) {
      result.add(transform(i, this[i]));
    }
    return result;
  }

  /// Where with index
  List<T> whereIndexed(bool Function(int index, T element) test) {
    final result = <T>[];
    for (var i = 0; i < length; i++) {
      if (test(i, this[i])) {
        result.add(this[i]);
      }
    }
    return result;
  }

  /// ForEach with index
  void forEachIndexed(void Function(int index, T element) action) {
    for (var i = 0; i < length; i++) {
      action(i, this[i]);
    }
  }

  // ==================== Grouping ====================

  /// Group by key
  Map<K, List<T>> groupBy<K>(K Function(T) keyOf) {
    final result = <K, List<T>>{};
    for (final element in this) {
      final key = keyOf(element);
      (result[key] ??= []).add(element);
    }
    return result;
  }

  /// Associate by key (last wins for duplicate keys)
  Map<K, T> associateBy<K>(K Function(T) keyOf) {
    final result = <K, T>{};
    for (final element in this) {
      result[keyOf(element)] = element;
    }
    return result;
  }

  // ==================== Math Operations ====================

  /// Sum of numeric list
  T? sumBy<R extends num>(R Function(T) selector) {
    if (isEmpty) return null;
    num sum = 0;
    for (final element in this) {
      sum += selector(element);
    }
    return sum as T?;
  }

  /// Average of numeric list
  double? averageBy(num Function(T) selector) {
    if (isEmpty) return null;
    num sum = 0;
    for (final element in this) {
      sum += selector(element);
    }
    return sum / length;
  }

  /// Max by selector
  T? maxBy(Comparable Function(T) selector) {
    if (isEmpty) return null;
    T max = first;
    Comparable maxValue = selector(first);
    for (final element in skip(1)) {
      final value = selector(element);
      if (value.compareTo(maxValue) > 0) {
        max = element;
        maxValue = value;
      }
    }
    return max;
  }

  /// Min by selector
  T? minBy(Comparable Function(T) selector) {
    if (isEmpty) return null;
    T min = first;
    Comparable minValue = selector(first);
    for (final element in skip(1)) {
      final value = selector(element);
      if (value.compareTo(minValue) < 0) {
        min = element;
        minValue = value;
      }
    }
    return min;
  }
}

/// Nullable [List] empty checks and fallbacks.
extension NullableListExtensions<T> on List<T>? {
  /// Check if null or empty
  bool get isNullOrEmpty => this?.isEmpty ?? true;

  /// Check if not null and not empty
  bool get isNotNullOrEmpty => !isNullOrEmpty;

  /// Return empty list if null
  List<T> get orEmpty => this ?? [];
}
