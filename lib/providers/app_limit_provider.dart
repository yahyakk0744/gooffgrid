import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/app_limit.dart';

/// In-memory daily app limits. MVP — no persistence yet.
class AppLimitNotifier extends StateNotifier<List<AppLimit>> {
  AppLimitNotifier() : super(_seed);

  static final _seed = <AppLimit>[
    const AppLimit(
        id: 'social', label: 'Sosyal Medya', emoji: '📱', dailyMinutes: 60, usedMinutes: 42),
    const AppLimit(
        id: 'video', label: 'Video', emoji: '🎬', dailyMinutes: 45, usedMinutes: 18),
    const AppLimit(
        id: 'games', label: 'Oyunlar', emoji: '🎮', dailyMinutes: 30, usedMinutes: 0),
  ];

  void add(AppLimit l) => state = [...state, l];

  void update(AppLimit l) =>
      state = [for (final x in state) if (x.id == l.id) l else x];

  void remove(String id) =>
      state = state.where((x) => x.id != id).toList();

  void toggle(String id) => state = [
        for (final x in state)
          if (x.id == id) x.copyWith(enabled: !x.enabled) else x
      ];
}

final appLimitProvider =
    StateNotifierProvider<AppLimitNotifier, List<AppLimit>>(
        (ref) => AppLimitNotifier());
