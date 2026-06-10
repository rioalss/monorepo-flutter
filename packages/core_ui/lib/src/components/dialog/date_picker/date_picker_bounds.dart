import 'package:flutter/material.dart';

/// Effective selectable range passed to the date picker.
typedef DatePickerBounds = ({DateTime? minDate, DateTime? maxDate});

/// Strips the time component so dates can be compared by day only.
///
/// Returns local midnight for the same calendar date as [date].
DateTime toDateOnly(DateTime date) => DateTime(date.year, date.month, date.day);

/// Resolves effective picker bounds from [isFutureOnly] and optional limits.
///
/// When [isFutureOnly] is:
/// - `null`: returns normalized [minDate]/[maxDate] without extra rules.
/// - `true`: [minDate] is at least [referenceDate] (defaults to today).
/// - `false`: [maxDate] is at most [referenceDate] (defaults to today).
///
/// [referenceDate] makes "today" deterministic in tests without mocking
/// the system clock.
///
/// If the resolved range is invalid, both bounds fall back to [referenceDate]
/// so exactly one day remains selectable.
DatePickerBounds resolveDatePickerBounds({
  required bool? isFutureOnly,
  DateTime? minDate,
  DateTime? maxDate,
  DateTime? referenceDate,
}) {
  final today = toDateOnly(referenceDate ?? DateTime.now());
  final normalizedMin = minDate != null ? toDateOnly(minDate) : null;
  final normalizedMax = maxDate != null ? toDateOnly(maxDate) : null;

  // No automatic constraint; caller controls the range entirely.
  if (isFutureOnly == null) {
    return (minDate: normalizedMin, maxDate: normalizedMax);
  }

  DateTime? resolvedMin;
  DateTime? resolvedMax;

  if (isFutureOnly) {
    resolvedMin = normalizedMin != null
        ? (normalizedMin.isAfter(today) ? normalizedMin : today)
        : today;
    resolvedMax = normalizedMax;
  } else {
    resolvedMin = normalizedMin;
    resolvedMax = normalizedMax != null
        ? (normalizedMax.isBefore(today) ? normalizedMax : today)
        : today;
  }

  // Conflicting bounds (e.g. future-only with maxDate in the past).
  if (resolvedMin != null &&
      resolvedMax != null &&
      resolvedMin.isAfter(resolvedMax)) {
    return (minDate: today, maxDate: today);
  }

  return (minDate: resolvedMin, maxDate: resolvedMax);
}

/// Clamps [date] to optional [min] and [max] bounds (inclusive).
///
/// [date] is normalized first. A null [min] or [max] means that bound
/// is not enforced. Expect [min] and [max] to come from
/// [resolveDatePickerBounds] so they are already date-only.
DateTime clampDate(DateTime date, DateTime? min, DateTime? max) {
  var result = toDateOnly(date);
  if (min != null && result.isBefore(min)) {
    result = min;
  }
  if (max != null && result.isAfter(max)) {
    result = max;
  }
  return result;
}

/// Clamps [range] start and end to optional [min] and [max] bounds.
///
/// Returns `null` when [range] is `null`. Start and end are clamped
/// independently; if that inverts the range, returns a single-day range
/// at the clamped end date.
DateTimeRange? clampDateRange(
  DateTimeRange? range,
  DateTime? min,
  DateTime? max,
) {
  if (range == null) return null;

  final start = clampDate(range.start, min, max);
  final end = clampDate(range.end, min, max);

  if (start.isAfter(end)) {
    // Independent clamping can invert the range; keep a valid selection.
    return DateTimeRange(start: end, end: end);
  }

  return DateTimeRange(start: start, end: end);
}
