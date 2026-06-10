import 'package:core_ui/src/components/dialog/date_picker/date_picker_bounds.dart';
import 'package:core_ui/src/components/dialog/date_picker/date_picker_weekday_header.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

/// Themed Syncfusion calendar used by [DatePickerDialog] and standalone screens.
///
/// Wraps [SfDateRangePicker] with design-system colors/typography, a custom
/// weekday header, and Sunday weekend styling. Requires an external
/// [DateRangePickerController] so the parent owns selection state.
class AppDatePicker extends StatelessWidget {
  const AppDatePicker({
    required this.controller,
    super.key,
    this.selectionMode = DateRangePickerSelectionMode.single,
    this.initialDate,
    this.initialDateRange,
    this.minDate,
    this.maxDate,
    this.isFutureOnly,
    this.firstDayOfWeek = DateTime.monday,
    this.sundayColor = Colors.red,
    this.weekdayLabels,
    this.blackoutDates,
    this.pickerHeight = 320,
    this.monthFormat = 'MMMM',
    this.headerStyle,
    this.monthCellStyle,
    this.onSelectionChanged,
  });

  /// Drives the current selection; must be owned and disposed by the caller.
  final DateRangePickerController controller;

  final DateRangePickerSelectionMode selectionMode;
  final DateTime? initialDate;
  final DateTimeRange? initialDateRange;
  final DateTime? minDate;
  final DateTime? maxDate;

  /// When non-null, automatically constrains [minDate]/[maxDate] to future or past.
  final bool? isFutureOnly;

  /// Must match [DatePickerWeekdayHeader] and [DateRangePickerMonthViewSettings].
  final int firstDayOfWeek;

  /// Applied to Sunday in the weekday header and weekend cells.
  final Color sundayColor;
  final List<String>? weekdayLabels;

  /// Dates that cannot be selected.
  final List<DateTime>? blackoutDates;
  final double pickerHeight;
  final String monthFormat;
  final DateRangePickerHeaderStyle? headerStyle;
  final DateRangePickerMonthCellStyle? monthCellStyle;

  /// Called on every selection change; useful for enabling/disabling confirm actions.
  final DateRangePickerSelectionChangedCallback? onSelectionChanged;

  DateRangePickerMonthCellStyle _resolveMonthCellStyle(
    BuildContext context,
    ColorScheme colorScheme,
    AppColorTokens tokens,
  ) {
    if (monthCellStyle != null) return monthCellStyle!;

    final baseCellStyle = AppTypography.fs14.regular.color(tokens.onSurface);
    final variantCellStyle =
        AppTypography.fs14.regular.color(tokens.onSurfaceVariant);

    return DateRangePickerMonthCellStyle(
      textStyle: baseCellStyle,
      todayTextStyle: baseCellStyle.copyWith(
        fontWeight: FontWeight.w600,
        color: colorScheme.primary,
      ),
      disabledDatesTextStyle: variantCellStyle.copyWith(
        color: tokens.outlineVariant,
      ),
      trailingDatesTextStyle: variantCellStyle,
      leadingDatesTextStyle: variantCellStyle,
      weekendTextStyle: baseCellStyle.copyWith(color: sundayColor),
    );
  }

  DateRangePickerHeaderStyle _resolveHeaderStyle(AppColorTokens tokens) =>
      headerStyle ??
      DateRangePickerHeaderStyle(
        textAlign: TextAlign.center,
        textStyle: AppTypography.fs16.semibold.color(tokens.onSurface),
        backgroundColor: tokens.surface,
      );

  @override
  Widget build(BuildContext context) {
    final tokens = context.colorTokens;
    final colorScheme = Theme.of(context).colorScheme;

    final resolvedMonthCellStyle =
        _resolveMonthCellStyle(context, colorScheme, tokens);
    final resolvedHeaderStyle = _resolveHeaderStyle(tokens);

    final bounds = resolveDatePickerBounds(
      isFutureOnly: isFutureOnly,
      minDate: minDate,
      maxDate: maxDate,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DatePickerWeekdayHeader(
          firstDayOfWeek: firstDayOfWeek,
          sundayColor: sundayColor,
          weekdayLabels: weekdayLabels,
        ),
        SizedBox(
          height: pickerHeight,
          child: SfDateRangePicker(
            controller: controller,
            selectionMode: selectionMode,
            showNavigationArrow: true,
            monthFormat: monthFormat,
            minDate: bounds.minDate,
            maxDate: bounds.maxDate,
            initialSelectedDate: initialDate,
            initialSelectedRange: initialDateRange != null
                ? PickerDateRange(
                    initialDateRange!.start,
                    initialDateRange!.end,
                  )
                : null,
            headerStyle: resolvedHeaderStyle,
            monthCellStyle: resolvedMonthCellStyle,
            selectionColor: colorScheme.primary,
            startRangeSelectionColor: colorScheme.primary,
            endRangeSelectionColor: colorScheme.primary,
            rangeSelectionColor: colorScheme.primary.withValues(alpha: 0.2),
            selectionTextStyle: AppTypography.fs14.medium.color(
              colorScheme.onPrimary,
            ),
            rangeTextStyle: AppTypography.fs14.medium.color(
              colorScheme.onPrimary,
            ),
            todayHighlightColor: colorScheme.primary,
            backgroundColor: tokens.surface,
            onSelectionChanged: onSelectionChanged,
            monthViewSettings: DateRangePickerMonthViewSettings(
              firstDayOfWeek: firstDayOfWeek,
              // Built-in weekday row is hidden; [DatePickerWeekdayHeader] replaces it.
              viewHeaderHeight: 0,
              weekendDays: const [DateTime.sunday],
              blackoutDates: blackoutDates,
            ),
          ),
        ),
      ],
    );
  }
}
