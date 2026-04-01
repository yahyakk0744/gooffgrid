import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gooffgrid/models/screen_time_data.dart';
import 'package:gooffgrid/services/platform_screen_time_service.dart';
import 'package:gooffgrid/services/screen_time_service.dart';

// ──────────────────────────────────────────────
// PERMISSION PROVIDER
// ──────────────────────────────────────────────

/// Ekran suresi izni durumu.
final screenTimePermissionProvider = StateNotifierProvider<_PermissionNotifier, bool>(
  (ref) => _PermissionNotifier(),
);

class _PermissionNotifier extends StateNotifier<bool> {
  _PermissionNotifier() : super(false) {
    _check();
  }

  Future<void> _check() async {
    state = await PlatformScreenTimeService.instance.hasPermission();
  }

  Future<void> refresh() async => _check();
}

// ──────────────────────────────────────────────
// SCREEN TIME PROVIDER (real + mock fallback)
// ──────────────────────────────────────────────

class ScreenTimeNotifier extends StateNotifier<List<ScreenTimeData>> {
  ScreenTimeNotifier(this._ref) : super(_buildMockWeek()) {
    _init();
  }

  // ignore: unused_field
  final Ref _ref;
  Timer? _refreshTimer;

  Future<void> _init() async {
    await fetchReal();

    // Her 5 dakikada bir guncelle
    _refreshTimer = Timer.periodic(const Duration(minutes: 5), (_) => fetchReal());
  }

  /// Gercek veriyi cekmeye calis, basarisizsa mock kalsin.
  Future<void> fetchReal() async {
    try {
      final hasPermission = await PlatformScreenTimeService.instance.hasPermission();
      if (!hasPermission) return; // Mock data ile devam

      final week = await PlatformScreenTimeService.instance.getWeekStats();
      if (week.isNotEmpty) {
        state = week;
      }
    } catch (e) {
      debugPrint('ScreenTime fetch error: $e');
    }
  }

  /// Manuel yenileme (pull-to-refresh vb.)
  Future<void> refresh() async => fetchReal();

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  static List<ScreenTimeData> _buildMockWeek() {
    return ScreenTimeService.instance.generateWeek();
  }
}

final screenTimeProvider = StateNotifierProvider<ScreenTimeNotifier, List<ScreenTimeData>>(
  (ref) => ScreenTimeNotifier(ref),
);

// ──────────────────────────────────────────────
// DERIVED PROVIDERS
// ──────────────────────────────────────────────

final todayScreenTimeProvider = Provider<ScreenTimeData>((ref) {
  final week = ref.watch(screenTimeProvider);
  return week.last;
});

/// Formatted week total string
final weekTotalProvider = Provider<String>((ref) {
  final week = ref.watch(screenTimeProvider);
  final total = week.fold(0, (sum, d) => sum + d.totalMinutes);
  final h = total ~/ 60;
  final m = total % 60;
  if (h > 0 && m > 0) return '${h}s ${m}dk';
  if (h > 0) return '${h}s';
  return '${m}dk';
});

/// Weekly minutes list (for charts)
final weeklyMinutesProvider = Provider<List<int>>((ref) {
  final week = ref.watch(screenTimeProvider);
  return week.map((d) => d.totalMinutes).toList();
});
