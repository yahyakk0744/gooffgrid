import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/theme.dart';
import 'screen_time_provider.dart';

/// Daily limit in minutes (default 4 hours).
final dailyLimitMinutesProvider = StateProvider<int>((_) => 240);

/// Usage percentage (0.0 – 1.0).
final usagePercentProvider = Provider<double>((ref) {
  final used = ref.watch(todayScreenTimeProvider).totalMinutes;
  final limit = ref.watch(dailyLimitMinutesProvider);
  return (used / limit).clamp(0.0, 1.0);
});

/// Remaining minutes today.
final remainingMinutesProvider = Provider<int>((ref) {
  final used = ref.watch(todayScreenTimeProvider).totalMinutes;
  final limit = ref.watch(dailyLimitMinutesProvider);
  return (limit - used).clamp(0, limit);
});

/// Status color based on usage percentage.
final timerStatusColorProvider = Provider<Color>((ref) {
  final pct = ref.watch(usagePercentProvider);
  if (pct <= 0.5) return AppColors.ringGood;
  if (pct <= 0.8) return AppColors.ringWarning;
  return AppColors.ringDanger;
});

/// Top 3 apps with name, minutes, color for the mini bar chart.
final topAppsProvider = Provider<List<({String name, int minutes, Color color})>>((ref) {
  final st = ref.watch(todayScreenTimeProvider);
  final sorted = st.appUsage.take(3).toList();
  return sorted
      .map((a) => (name: a.name, minutes: a.minutes, color: a.iconColor))
      .toList();
});
