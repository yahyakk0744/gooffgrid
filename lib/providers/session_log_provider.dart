import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/daily_entry.dart';
import '../models/focus_session.dart';
import '../services/streak_calculator.dart';

/// Completed session log — source of truth for streaks & scores.
/// Pattern: compute derived values on demand, never store counters.
class SessionLogNotifier extends StateNotifier<List<DailyEntry>> {
  SessionLogNotifier() : super([]);

  /// Record a completed session into the daily log.
  void recordSession(FocusSession session) {
    if (session.state != SessionState.completed) return;

    final dateKey = DateTime.utc(
        session.startedAt.year, session.startedAt.month, session.startedAt.day);
    final existing = state.indexWhere((e) => e.dateKey == dateKey);

    if (existing >= 0) {
      // Merge into existing day
      final old = state[existing];
      final updated = old.copyWith(
        status: EntryStatus.completed,
        totalMinutes: old.totalMinutes + session.durationMin,
        sessionsCount: old.sessionsCount + 1,
        o2Earned: old.o2Earned + session.gemsEarned,
      );
      state = [...state]
        ..[existing] = updated;
    } else {
      state = [
        ...state,
        DailyEntry(
          date: dateKey,
          status: EntryStatus.completed,
          totalMinutes: session.durationMin,
          sessionsCount: 1,
          o2Earned: session.gemsEarned,
        ),
      ];
    }
  }

  /// Current streak computed on demand.
  int get currentStreak => StreakCalculator.currentStreak(state);

  /// Best streak ever computed on demand.
  int get bestStreak => StreakCalculator.bestStreak(state);

  /// EMA focus score (0-100).
  double get focusScore => StreakCalculator.focusScore(state);

  /// Last 7 days for StreakRow widget.
  List<bool> get last7Days => StreakCalculator.last7Days(state);
}

final sessionLogProvider =
    StateNotifierProvider<SessionLogNotifier, List<DailyEntry>>(
        (ref) => SessionLogNotifier());
