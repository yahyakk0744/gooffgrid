import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/app_limit.dart';
import '../services/platform_screen_time_service.dart';

/// Günlük uygulama limitleri — kategoriye göre gerçek UsageStats verisi.
/// Limit ayarları SharedPreferences ile persist edilir.
/// Kullanım verileri her 5 dakikada bir platform channel'dan güncellenir.
class AppLimitNotifier extends StateNotifier<List<AppLimit>> {
  AppLimitNotifier() : super(_defaultLimits) {
    _init();
  }

  final _service = PlatformScreenTimeService.instance;
  Timer? _refreshTimer;

  static final _defaultLimits = <AppLimit>[
    const AppLimit(id: 'social', label: 'Sosyal Medya', emoji: '📱', dailyMinutes: 60),
    const AppLimit(id: 'video', label: 'Video', emoji: '🎬', dailyMinutes: 45),
    const AppLimit(id: 'game', label: 'Oyunlar', emoji: '🎮', dailyMinutes: 30),
  ];

  static const _prefsKey = 'app_limits_v1';

  // Kategori ID → UsageStats kategori string'leri mapping
  static const _categoryMapping = {
    'social': ['social'],
    'video': ['video'],
    'game': ['game'],
    'audio': ['audio'],
    'news': ['news'],
    'productivity': ['productivity'],
  };

  Future<void> _init() async {
    await _loadSavedLimits();
    await _fetchRealUsage();
    _refreshTimer = Timer.periodic(const Duration(minutes: 5), (_) => _fetchRealUsage());
  }

  /// SharedPreferences'tan kaydedilmiş limitleri yükle.
  Future<void> _loadSavedLimits() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final json = prefs.getString(_prefsKey);
      if (json != null) {
        final list = (jsonDecode(json) as List).map((item) {
          final map = item as Map<String, dynamic>;
          return AppLimit(
            id: map['id'] as String,
            label: map['label'] as String,
            emoji: map['emoji'] as String,
            dailyMinutes: map['dailyMinutes'] as int,
            enabled: map['enabled'] as bool? ?? true,
          );
        }).toList();
        if (list.isNotEmpty) {
          state = list;
        }
      }
    } catch (e) {
      debugPrint('AppLimit load error: $e');
    }
  }

  /// Gerçek kullanım verisini platform channel'dan çek.
  Future<void> _fetchRealUsage() async {
    try {
      final hasPermission = await _service.hasPermission();
      if (!hasPermission) return;

      final categoryUsage = await _service.getCategoryUsage(0);
      if (categoryUsage.isEmpty) return;

      state = state.map((limit) {
        final mappedCategories = _categoryMapping[limit.id] ?? [limit.id];
        int totalMinutes = 0;
        for (final cat in mappedCategories) {
          totalMinutes += categoryUsage[cat] ?? 0;
        }
        return limit.copyWith(usedMinutes: totalMinutes);
      }).toList();
    } catch (e) {
      debugPrint('AppLimit fetch error: $e');
    }
  }

  Future<void> refresh() async => _fetchRealUsage();

  void add(AppLimit l) {
    state = [...state, l];
    _save();
  }

  void update(AppLimit l) {
    state = [for (final x in state) if (x.id == l.id) l else x];
    _save();
  }

  void remove(String id) {
    state = state.where((x) => x.id != id).toList();
    _save();
  }

  void toggle(String id) {
    state = [
      for (final x in state)
        if (x.id == id) x.copyWith(enabled: !x.enabled) else x
    ];
    _save();
  }

  /// Limit süresini değiştir.
  void setDailyMinutes(String id, int minutes) {
    state = [
      for (final x in state)
        if (x.id == id) x.copyWith(dailyMinutes: minutes) else x
    ];
    _save();
  }

  Future<void> _save() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final json = jsonEncode(state.map((item) => <String, dynamic>{
        'id': item.id,
        'label': item.label,
        'emoji': item.emoji,
        'dailyMinutes': item.dailyMinutes,
        'enabled': item.enabled,
      }).toList());
      await prefs.setString(_prefsKey, json);
    } catch (e) {
      debugPrint('AppLimit save error: $e');
    }
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }
}

final appLimitProvider =
    StateNotifierProvider<AppLimitNotifier, List<AppLimit>>(
        (ref) => AppLimitNotifier());
