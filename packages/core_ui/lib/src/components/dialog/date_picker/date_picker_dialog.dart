import 'package:core_ui/src/components/dialog/base/base.dart';
import 'package:core_ui/src/components/dialog/date_picker/app_date_picker.dart';
import 'package:core_ui/src/components/dialog/date_picker/date_picker_bounds.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

/// Modal date picker dialog with confirm/cancel actions.
///
/// Entry points: [DatePickerDialog.showSingle] and [DatePickerDialog.showRange].
/// Confirm returns the selection; cancel or dismiss returns `null`.
/// Selection state lives in an internal [DateRangePickerController].
class DatePickerDialog extends StatefulWidget {
  /// Prefer [showSingle] or [showRange] instead of using this directly.
  const DatePickerDialog({
    required this.title,
    required this.selectionMode,
    super.key,
    this.confirmLabel,
    this.cancelLabel,
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
  });

  final String title;

  /// Determines single-date vs range behaviour and confirm validation rules.
  final DateRangePickerSelectionMode selectionMode;

  /// Falls back to [MaterialLocalizations.okButtonLabel] when null.
  final String? confirmLabel;

  /// Falls back to [MaterialLocalizations.cancelButtonLabel] when null.
  final String? cancelLabel;

  /// Pre-selected date for single mode. Defaults to today when null.
  final DateTime? initialDate;

  /// Pre-selected range for range mode. No selection when null.
  final DateTimeRange? initialDateRange;
  final DateTime? minDate;
  final DateTime? maxDate;

  /// When set, resolves bounds to future-only or past-only via [resolveDatePickerBounds].
  final bool? isFutureOnly;
  final int firstDayOfWeek;
  final Color sundayColor;
  final List<String>? weekdayLabels;
  final List<DateTime>? blackoutDates;
  final double pickerHeight;
  final String monthFormat;
  final DateRangePickerHeaderStyle? headerStyle;
  final DateRangePickerMonthCellStyle? monthCellStyle;

  /// Presents a single-date picker and returns the chosen [DateTime], or `null`.
  ///
  /// [initialDate] is clamped to resolved bounds before display.
  /// [isDismissible] and [useRootNavigator] are forwarded to [DialogParent.show].
  static Future<DateTime?> showSingle(
    BuildContext context, {
    required String title,
    String? confirmLabel,
    String? cancelLabel,
    DateTime? initialDate,
    DateTime? minDate,
    DateTime? maxDate,
    bool? isFutureOnly,
    int firstDayOfWeek = DateTime.monday,
    Color sundayColor = Colors.red,
    List<String>? weekdayLabels,
    List<DateTime>? blackoutDates,
    double pickerHeight = 320,
    String monthFormat = 'MMMM',
    DateRangePickerHeaderStyle? headerStyle,
    DateRangePickerMonthCellStyle? monthCellStyle,
    bool isDismissible = true,
    bool useRootNavigator = false,
  }) =>
      DialogParent.show<DateTime>(
        context,
        isDismissible: isDismissible,
        useRootNavigator: useRootNavigator,
        child: DatePickerDialog(
          title: title,
          selectionMode: DateRangePickerSelectionMode.single,
          confirmLabel: confirmLabel,
          cancelLabel: cancelLabel,
          initialDate: initialDate,
          minDate: minDate,
          maxDate: maxDate,
          isFutureOnly: isFutureOnly,
          firstDayOfWeek: firstDayOfWeek,
          sundayColor: sundayColor,
          weekdayLabels: weekdayLabels,
          blackoutDates: blackoutDates,
          pickerHeight: pickerHeight,
          monthFormat: monthFormat,
          headerStyle: headerStyle,
          monthCellStyle: monthCellStyle,
        ),
      );

  /// Presents a range picker and returns the chosen [DateTimeRange], or `null`.
  ///
  /// Confirm stays disabled until both start and end dates are selected.
  /// [initialDateRange] is clamped to resolved bounds when provided.
  static Future<DateTimeRange?> showRange(
    BuildContext context, {
    required String title,
    String? confirmLabel,
    String? cancelLabel,
    DateTimeRange? initialDateRange,
    DateTime? minDate,
    DateTime? maxDate,
    bool? isFutureOnly,
    int firstDayOfWeek = DateTime.monday,
    Color sundayColor = Colors.red,
    List<String>? weekdayLabels,
    List<DateTime>? blackoutDates,
    double pickerHeight = 320,
    String monthFormat = 'MMMM',
    DateRangePickerHeaderStyle? headerStyle,
    DateRangePickerMonthCellStyle? monthCellStyle,
    bool isDismissible = true,
    bool useRootNavigator = false,
  }) =>
      DialogParent.show<DateTimeRange>(
        context,
        isDismissible: isDismissible,
        useRootNavigator: useRootNavigator,
        child: DatePickerDialog(
          title: title,
          selectionMode: DateRangePickerSelectionMode.range,
          confirmLabel: confirmLabel,
          cancelLabel: cancelLabel,
          initialDateRange: initialDateRange,
          minDate: minDate,
          maxDate: maxDate,
          isFutureOnly: isFutureOnly,
          firstDayOfWeek: firstDayOfWeek,
          sundayColor: sundayColor,
          weekdayLabels: weekdayLabels,
          blackoutDates: blackoutDates,
          pickerHeight: pickerHeight,
          monthFormat: monthFormat,
          headerStyle: headerStyle,
          monthCellStyle: monthCellStyle,
        ),
      );

  @override
  State<DatePickerDialog> createState() => _DatePickerDialogState();
}

/// Manages picker controller lifecycle, confirm eligibility, and dialog layout.
class _DatePickerDialogState extends State<DatePickerDialog> {
  late final DateRangePickerController _controller;

  /// Avoids rebuilding the entire dialog when only confirm eligibility changes.
  late final ValueNotifier<bool> _canConfirmNotifier;

  @override
  void initState() {
    super.initState();
    _controller = DateRangePickerController();
    _canConfirmNotifier = ValueNotifier(false);
    _initializeControllerSelection();
    _syncCanConfirm();
  }

  /// Applies a clamped initial selection to [_controller] before the first frame.
  ///
  /// Single mode always selects a date (defaults to today). Range mode leaves
  /// the controller empty when [DatePickerDialog.initialDateRange] is null.
  /// The controller is authoritative; [AppDatePicker] initial props are a
  /// Syncfusion first-render fallback only.
  void _initializeControllerSelection() {
    final bounds = resolveDatePickerBounds(
      isFutureOnly: widget.isFutureOnly,
      minDate: widget.minDate,
      maxDate: widget.maxDate,
    );

    if (widget.selectionMode == DateRangePickerSelectionMode.single) {
      final initial = widget.initialDate ?? DateTime.now();
      _controller.selectedDate = clampDate(
        initial,
        bounds.minDate,
        bounds.maxDate,
      );
      return;
    }

    if (widget.initialDateRange == null) return;

    final clampedRange = clampDateRange(
      widget.initialDateRange,
      bounds.minDate,
      bounds.maxDate,
    );
    if (clampedRange == null) return;

    _controller.selectedRange = PickerDateRange(
      clampedRange.start,
      clampedRange.end,
    );
  }

  @override
  void dispose() {
    _canConfirmNotifier.dispose();
    _controller.dispose();
    super.dispose();
  }

  /// Returns whether the current selection is valid enough to confirm.
  ///
  /// Single mode: any non-null date. Range mode: both endpoints must be set.
  bool _computeCanConfirm() {
    if (widget.selectionMode == DateRangePickerSelectionMode.single) {
      return _controller.selectedDate != null;
    }

    final range = _controller.selectedRange;
    return range?.startDate != null && range?.endDate != null;
  }

  /// Writes to [_canConfirmNotifier] only when the value changes.
  void _syncCanConfirm() {
    final canConfirm = _computeCanConfirm();
    if (_canConfirmNotifier.value != canConfirm) {
      _canConfirmNotifier.value = canConfirm;
    }
  }

  /// Returns the selection via [Navigator.pop], or no-ops when confirm is disabled.
  void _handleConfirm() {
    if (!_canConfirmNotifier.value) return;

    if (widget.selectionMode == DateRangePickerSelectionMode.single) {
      Navigator.of(context).pop(_controller.selectedDate);
      return;
    }

    final range = _controller.selectedRange!;
    Navigator.of(context).pop(
      DateTimeRange(start: range.startDate!, end: range.endDate!),
    );
  }

  /// Wires widget configuration into [AppDatePicker] with shared controller state.
  AppDatePicker _buildDatePicker() => AppDatePicker(
        controller: _controller,
        selectionMode: widget.selectionMode,
        initialDate: widget.initialDate,
        initialDateRange: widget.initialDateRange,
        minDate: widget.minDate,
        maxDate: widget.maxDate,
        isFutureOnly: widget.isFutureOnly,
        firstDayOfWeek: widget.firstDayOfWeek,
        sundayColor: widget.sundayColor,
        weekdayLabels: widget.weekdayLabels,
        blackoutDates: widget.blackoutDates,
        pickerHeight: widget.pickerHeight,
        monthFormat: widget.monthFormat,
        headerStyle: widget.headerStyle,
        monthCellStyle: widget.monthCellStyle,
        onSelectionChanged: (_) => _syncCanConfirm(),
      );

  @override
  Widget build(BuildContext context) {
    final materialLocalizations = MaterialLocalizations.of(context);
    final confirmLabel =
        widget.confirmLabel ?? materialLocalizations.okButtonLabel;
    final cancelLabel =
        widget.cancelLabel ?? materialLocalizations.cancelButtonLabel;

    return DialogParent(
      header: DialogHeader(title: widget.title),
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        child: _buildDatePicker(),
      ),
      footer: DialogFooter(
        showDivider: true,
        secondaryAction: TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(cancelLabel),
        ),
        primaryAction: ValueListenableBuilder<bool>(
          valueListenable: _canConfirmNotifier,
          builder: (context, canConfirm, _) => FilledButton(
            onPressed: canConfirm ? _handleConfirm : null,
            child: Text(confirmLabel),
          ),
        ),
      ),
    );
  }
}
