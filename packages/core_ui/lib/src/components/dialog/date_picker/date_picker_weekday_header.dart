import 'package:core_ui/core_ui.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

/// Weekday header row shown above [AppDatePicker]'s calendar grid.
///
/// Syncfusion's built-in header is hidden (`viewHeaderHeight: 0`); this widget
/// replaces it so column order and Sunday styling stay in sync with the picker.
class DatePickerWeekdayHeader extends StatelessWidget {
  const DatePickerWeekdayHeader({
    required this.firstDayOfWeek,
    required this.sundayColor,
    super.key,
    this.textStyle,
    this.weekdayLabels,
    this.height = 28,
  }) : assert(
          firstDayOfWeek >= DateTime.monday &&
              firstDayOfWeek <= DateTime.sunday,
          'firstDayOfWeek must be between DateTime.monday (1) and '
          'DateTime.sunday (7).',
        );

  /// First column weekday (1 = Monday … 7 = Sunday). Must match the picker.
  final int firstDayOfWeek;

  /// Text color for the Sunday column; aligns with picker weekend styling.
  final Color sundayColor;

  /// When null, falls back to design-system typography and tokens.
  final TextStyle? textStyle;

  /// Custom labels in [firstDayOfWeek] order. When null, locale labels are used.
  final List<String>? weekdayLabels;

  /// Fixed row height; increase if [textStyle] uses a larger font size.
  final double height;

  /// Returns weekday numbers (1 = Monday … 7 = Sunday) in column order.
  ///
  /// Output length is always 7. Used to align labels and Sunday highlighting
  /// with the calendar grid below.
  static List<int> orderedWeekdays(int firstDayOfWeek) =>
      List.generate(7, (index) => (firstDayOfWeek + index - 1) % 7 + 1);

  /// Builds weekday labels in column order starting from [firstDayOfWeek].
  ///
  /// Returns [weekdayLabels] as-is when provided (exactly 7 items required).
  /// Otherwise reads [MaterialLocalizations.narrowWeekdays] for the locale.
  ///
  /// Pass [weekdayOrder] to reuse a precomputed order and avoid recomputing it.
  static List<String> buildLabels(
    BuildContext context, {
    required int firstDayOfWeek,
    List<String>? weekdayLabels,
    List<int>? weekdayOrder,
  }) {
    if (weekdayLabels != null) {
      assert(
        weekdayLabels.length == 7,
        'weekdayLabels must contain exactly 7 items.',
      );
      return weekdayLabels;
    }

    // Indexed Sunday (0) through Saturday (6), regardless of [firstDayOfWeek].
    final labelsFromSunday = MaterialLocalizations.of(context).narrowWeekdays;
    final order = weekdayOrder ?? orderedWeekdays(firstDayOfWeek);

    return order.map((weekday) => labelsFromSunday[weekday % 7]).toList();
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.colorTokens;
    final baseStyle =
        textStyle ?? AppTypography.fs12.medium.color(tokens.onSurfaceVariant);

    // Compute once; shared by label resolution and Sunday styling.
    final weekdays = orderedWeekdays(firstDayOfWeek);
    final labels = buildLabels(
      context,
      firstDayOfWeek: firstDayOfWeek,
      weekdayLabels: weekdayLabels,
      weekdayOrder: weekdays,
    );

    return SizedBox(
      height: height,
      child: Row(
        children: List.generate(7, (index) {
          final isSunday = weekdays[index] == DateTime.sunday;
          return Expanded(
            child: Center(
              child: Text(
                labels[index],
                style: isSunday
                    ? baseStyle.copyWith(color: sundayColor)
                    : baseStyle,
                textAlign: TextAlign.center,
              ),
            ),
          );
        }),
      ),
    );
  }
}
