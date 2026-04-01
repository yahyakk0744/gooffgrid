import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/platform_screen_time_service.dart';
import '../services/supabase_sync_service.dart';

/// Ekran süresi verilerini Supabase'e senkronize eden provider.
/// Uygulama açıldığında ve periyodik olarak çalışır.
class SyncNotifier extends StateNotifier<SyncState> {
  SyncNotifier() : super(const SyncState());

  final _platform = PlatformScreenTimeService.instance;
  final _supabase = SupabaseSyncService.instance;

  /// Bugünün verisini sync et.
  Future<void> syncToday() async {
    if (state.isSyncing) return;
    state = state.copyWith(isSyncing: true);

    try {
      final today = await _platform.getDetailedUsageForDay(0);
      if (today != null) {
        await _supabase.syncDailyScreenTime(today);
      }
      state = state.copyWith(
        isSyncing: false,
        lastSync: DateTime.now(),
        error: null,
      );
    } catch (e) {
      debugPrint('syncToday error: $e');
      state = state.copyWith(isSyncing: false, error: e.toString());
    }
  }

  /// Son 7 günü toplu sync et (ilk açılışta).
  Future<void> syncWeek() async {
    if (state.isSyncing) return;
    state = state.copyWith(isSyncing: true);

    try {
      final days = await _platform.getWeekStats();
      if (days.isNotEmpty) {
        await _supabase.syncWeekData(days);
      }
      state = state.copyWith(
        isSyncing: false,
        lastSync: DateTime.now(),
        error: null,
      );
    } catch (e) {
      debugPrint('syncWeek error: $e');
      state = state.copyWith(isSyncing: false, error: e.toString());
    }
  }
}

class SyncState {
  final bool isSyncing;
  final DateTime? lastSync;
  final String? error;

  const SyncState({
    this.isSyncing = false,
    this.lastSync,
    this.error,
  });

  SyncState copyWith({
    bool? isSyncing,
    DateTime? lastSync,
    String? error,
  }) =>
      SyncState(
        isSyncing: isSyncing ?? this.isSyncing,
        lastSync: lastSync ?? this.lastSync,
        error: error,
      );
}

final syncProvider = StateNotifierProvider<SyncNotifier, SyncState>((ref) {
  return SyncNotifier();
});
