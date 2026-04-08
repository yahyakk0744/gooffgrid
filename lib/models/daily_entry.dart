/// Pattern from Loop Habit Tracker — track daily completion status.
/// Source of truth: session completion log. Never store streak as counter.
enum EntryStatus {
  /// User completed a focus session on this day.
  completed,

  /// User explicitly skipped (manual mark).
  skipped,

  /// Day passed with no activity — derived on read.
  missed,

  /// Future or today with no data yet.
  unknown,
}

/// One day's record — immutable value object.
class DailyEntry {
  const DailyEntry({
    required this.date,
    required this.status,
    this.totalMinutes = 0,
    this.sessionsCount = 0,
    this.o2Earned = 0,
  });

  final DateTime date;
  final EntryStatus status;
  final int totalMinutes;
  final int sessionsCount;
  final int o2Earned;

  /// Normalized to midnight UTC for comparison.
  DateTime get dateKey =>
      DateTime.utc(date.year, date.month, date.day);

  DailyEntry copyWith({
    DateTime? date,
    EntryStatus? status,
    int? totalMinutes,
    int? sessionsCount,
    int? o2Earned,
  }) =>
      DailyEntry(
        date: date ?? this.date,
        status: status ?? this.status,
        totalMinutes: totalMinutes ?? this.totalMinutes,
        sessionsCount: sessionsCount ?? this.sessionsCount,
        o2Earned: o2Earned ?? this.o2Earned,
      );
}
