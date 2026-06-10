import 'package:flutter/services.dart';

/// Formats phone input with spaces and strips a leading `0` trunk prefix.
///
/// Example: `081234567890` → `812 3456 7890`. Cursor jumps to end after format.
class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var digits = newValue.text.replaceAll(' ', '');
    if (digits.isEmpty) return newValue;

    final trimmed = digits.replaceFirst(RegExp('^0+'), '');
    if (trimmed.isEmpty) {
      return const TextEditingValue(
        selection: TextSelection.collapsed(offset: 0),
      );
    }
    digits = trimmed;

    final buffer = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      if (i == 3 || i == 7) buffer.write(' ');
      buffer.write(digits[i]);
    }

    final formatted = buffer.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

/// Strips leading zeros while preserving a single `0` and adjusting selection.
class FirstZeroFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final raw = newValue.text.replaceAll(' ', '');
    if (raw.isEmpty) return newValue;

    var leadingZeroCount = 0;
    while (leadingZeroCount < raw.length && raw[leadingZeroCount] == '0') {
      leadingZeroCount++;
    }

    if (leadingZeroCount == raw.length) {
      return const TextEditingValue(
        text: '0',
        selection: TextSelection.collapsed(offset: 1),
      );
    }

    if (leadingZeroCount == 0) return newValue;

    final trimmed = raw.substring(leadingZeroCount);
    final baseOffset = newValue.selection.baseOffset;
    final extentOffset = newValue.selection.extentOffset;

    int adjustOffset(int offset) {
      if (offset <= 0) return 0;
      final adjusted = offset - leadingZeroCount;
      if (adjusted < 0) return 0;
      if (adjusted > trimmed.length) return trimmed.length;
      return adjusted;
    }

    return TextEditingValue(
      text: trimmed,
      selection: TextSelection(
        baseOffset: adjustOffset(baseOffset),
        extentOffset: adjustOffset(extentOffset),
      ),
    );
  }
}
