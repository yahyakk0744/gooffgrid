import 'dart:math' as math;

import '../models/daily_entry.dart';

/// Stateless streak & score calculator.
/// Adapted from Loop Habit Tracker pattern: compute on demand from session log,
/// never store derived counters as source of truth.
class StreakCalculator {
  const StreakCalculator._();

  /// Current streak — number of consecutive completed days ending today/yesterday.
  static int currentStreak(List<DailyEntry> entries) {
    final sorted = _completedDays(entries);
    if (sorted.isEmpty) return 0;

    final today = _today();
    int streak = 0;

    // Start from today or yesterday (allow grace: today not yet done)
    DateTime check = today;
    if (!sorted.contains(check)) {
      check = check.subtract(const Duration(days: 1));
      if (!sorted.contains(check)) return 0;
    }

    while (sorted.contains(check)) {
      streak++;
      check = check.subtract(const Duration(days: 1));
    }
    return streak;
  }

  /// Best streak ever — longest consecutive run.
  static int bestStreak(List<DailyEntry> entries) {
    final sorted = _completedDays(entries);
    if (sorted.isEmpty) return 0;

    final days = sorted.toList()..sort();
    int best = 1;
    int current = 1;
    for (int i = 1; i < days.length; i++) {
      if (days[i].difference(days[i - 1]).inDays == 1) {
        current++;
        if (current > best) best = current;
      } else {
        current = 1;
      }
    }
    return best;
  }

  /// EMA focus score (0-100). Adapted from uhabits formula.
  /// More recent activity weighs heavier. Robust across gaps.
  static double focusScore(List<DailyEntry> entries, {int windowDays = 30}) {
    if (entries.isEmpty) return 0;

    final today = _today();
    double score = 0;
    const freq = 1.0; // daily habit

    for (int i = windowDays - 1; i >= 0; i--) {
      final day = today.subtract(Duration(days: i));
      final completed =
          entries.any((e) => e.dateKey == day && e.status == EntryStatus.completed);
      final mult = math.pow(0.5, math.sqrt(freq) / 13.0).toDouble();
      score = score * mult + (completed ? 1 : 0) * (1 - mult);
    }
    return (score * 100).clamp(0, 100);
  }

  /// 7-day active booleans for streak row widget (oldest→newest).
  static List<bool> last7Days(List<DailyEntry> entries) {
    final completed = _completedDays(entries);
    final today = _today();
    return List.generate(
      7,
      (i) => completed.contains(today.subtract(Duration(days: 6 - i))),
    );
  }

  // ── helpers ──

  static Set<DateTime> _completedDays(List<DailyEntry> entries) {
    return entries
        .where((e) => e.status == EntryStatus.completed)
        .map((e) => e.dateKey)
        .toSet();
  }

  static DateTime _today() {
    final n = DateTime.now();
    return DateTime.utc(n.year, n.month, n.day);
  }

}
