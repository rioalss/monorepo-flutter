/// [Duration] formatting, comparison, and arithmetic helpers.
extension DurationExtensions on Duration {
  // ==================== Delays ====================

  /// Delay execution for this duration
  Future<void> get delay => Future.delayed(this);

  // ==================== Formatting ====================

  /// Format as HH:MM:SS
  String get formatted {
    final hours = inHours.toString().padLeft(2, '0');
    final minutes = (inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (inSeconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  /// Format as MM:SS (for short durations)
  String get shortFormatted {
    final minutes = inMinutes.toString().padLeft(2, '0');
    final seconds = (inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  /// Format as human-readable string
  String get humanReadable {
    if (inDays > 0) {
      return '${inDays}d ${inHours % 24}h';
    } else if (inHours > 0) {
      return '${inHours}h ${inMinutes % 60}m';
    } else if (inMinutes > 0) {
      return '${inMinutes}m ${inSeconds % 60}s';
    } else {
      return '${inSeconds}s';
    }
  }

  /// Format as compact string
  String get compact {
    if (inDays > 0) {
      return '${inDays}d';
    } else if (inHours > 0) {
      return '${inHours}h';
    } else if (inMinutes > 0) {
      return '${inMinutes}m';
    } else {
      return '${inSeconds}s';
    }
  }

  // ==================== Comparisons ====================

  /// Check if duration is zero
  bool get isZero => inMicroseconds == 0;

  /// Check if duration is positive
  bool get isPositive => inMicroseconds > 0;

  /// Check if duration is negative
  bool get isNegative => inMicroseconds < 0;

  // ==================== Operations ====================

  /// Multiply duration by factor
  Duration operator *(num factor) =>
      Duration(microseconds: (inMicroseconds * factor).round());

  /// Divide duration by factor
  Duration operator /(num divisor) =>
      Duration(microseconds: (inMicroseconds / divisor).round());

  /// Add percentage of duration
  Duration addPercent(double percent) => this + (this * (percent / 100));

  /// Half of this duration
  Duration get half => this ~/ 2;

  /// Double of this duration
  Duration get doubled => this * 2;
}
