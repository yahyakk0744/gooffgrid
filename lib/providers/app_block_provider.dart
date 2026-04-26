import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/platform_screen_time_service.dart';

class TimeRange {
  const TimeRange({required this.start, required this.end});
  final TimeOfDay start;
  final TimeOfDay end;

  TimeRange copyWith({TimeOfDay? start, TimeOfDay? end}) => TimeRange(
        start: start ?? this.start,
        end: end ?? this.end,
      );

  int get startMinutes => start.hour * 60 + start.minute;
  int get endMinutes => end.hour * 60 + end.minute;

  String format() {
    String pad(int n) => n.toString().padLeft(2, '0');
    return '${pad(start.hour)}:${pad(start.minute)}–${pad(end.hour)}:${pad(end.minute)}';
  }

  Map<String, dynamic> toJson() => {
        'startH': start.hour,
        'startM': start.minute,
        'endH': end.hour,
        'endM': end.minute,
      };

  factory TimeRange.fromJson(Map<String, dynamic> json) => TimeRange(
        start: TimeOfDay(hour: json['startH'] as int, minute: json['startM'] as int),
        end: TimeOfDay(hour: json['endH'] as int, minute: json['endM'] as int),
      );
}

class AppBlockState {
  const AppBlockState({
    this.blockedApps = const [],
    this.isBlockingEnabled = false,
    this.isStrictMode = false,
    this.blockSchedule = const {},
    this.blockUntil,
  });

  final List<String> blockedApps;
  final bool isBlockingEnabled;
  final bool isStrictMode;
  final Map<int, List<TimeRange>> blockSchedule;
  final DateTime? blockUntil;

  AppBlockState copyWith({
    List<String>? blockedApps,
    bool? isBlockingEnabled,
    bool? isStrictMode,
    Map<int, List<TimeRange>>? blockSchedule,
    DateTime? blockUntil,
    bool clearBlockUntil = false,
  }) {
    return AppBlockState(
      blockedApps: blockedApps ?? this.blockedApps,
      isBlockingEnabled: isBlockingEnabled ?? this.isBlockingEnabled,
      isStrictMode: isStrictMode ?? this.isStrictMode,
      blockSchedule: blockSchedule ?? this.blockSchedule,
      blockUntil: clearBlockUntil ? null : (blockUntil ?? this.blockUntil),
    );
  }
}

class AppBlockNotifier extends StateNotifier<AppBlockState> {
  AppBlockNotifier() : super(const AppBlockState()) {
    _init();
  }

  final _service = PlatformScreenTimeService.instance;
  static const _prefsKey = 'app_block_state_v1';

  Future<void> _init() async {
    await _load();
    _syncNative();
  }

  /// SharedPreferences'tan state yükle.
  Future<void> _load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final json = prefs.getString(_prefsKey);
      if (json == null) return;

      final map = jsonDecode(json) as Map<String, dynamic>;
      final apps = (map['blockedApps'] as List?)?.cast<String>() ?? [];
      final enabled = map['isBlockingEnabled'] as bool? ?? false;
      final strict = map['isStrictMode'] as bool? ?? false;
      final untilStr = map['blockUntil'] as String?;
      DateTime? until;
      if (untilStr != null) {
        until = DateTime.tryParse(untilStr);
        // Süresi dolmuş strict mode'u temizle
        if (until != null && DateTime.now().isAfter(until)) {
          until = null;
        }
      }

      final scheduleRaw = map['blockSchedule'] as Map<String, dynamic>?;
      final schedule = <int, List<TimeRange>>{};
      if (scheduleRaw != null) {
        for (final entry in scheduleRaw.entries) {
          final weekday = int.tryParse(entry.key);
          if (weekday == null) continue;
          final ranges = (entry.value as List).map((r) =>
            TimeRange.fromJson(Map<String, dynamic>.from(r as Map))
          ).toList();
          schedule[weekday] = ranges;
        }
      }

      state = AppBlockState(
        blockedApps: apps,
        isBlockingEnabled: enabled,
        isStrictMode: strict && until != null,
        blockSchedule: schedule,
        blockUntil: until,
      );
    } catch (e) {
      debugPrint('AppBlock load error: $e');
    }
  }

  Future<void> _save() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final scheduleJson = <String, dynamic>{};
      for (final entry in state.blockSchedule.entries) {
        scheduleJson[entry.key.toString()] =
            entry.value.map((r) => r.toJson()).toList();
      }

      final json = jsonEncode({
        'blockedApps': state.blockedApps,
        'isBlockingEnabled': state.isBlockingEnabled,
        'isStrictMode': state.isStrictMode,
        'blockUntil': state.blockUntil?.toIso8601String(),
        'blockSchedule': scheduleJson,
      });
      await prefs.setString(_prefsKey, json);
    } catch (e) {
      debugPrint('AppBlock save error: $e');
    }
  }

  /// Native Accessibility Service'e engelli listeyi ve durumu senkronize et.
  void _syncNative() {
    _service.setBlockedApps(state.blockedApps);
    _service.setBlockingEnabled(state.isBlockingEnabled);
  }

  void addApp(String packageName) {
    if (state.blockedApps.contains(packageName)) return;
    state = state.copyWith(blockedApps: [...state.blockedApps, packageName]);
    _save();
    _syncNative();
  }

  void removeApp(String packageName) {
    state = state.copyWith(
      blockedApps: state.blockedApps.where((a) => a != packageName).toList(),
    );
    _save();
    _syncNative();
  }

  void toggleBlocking() {
    if (state.isStrictMode && state.isBlockingEnabled) return;
    state = state.copyWith(isBlockingEnabled: !state.isBlockingEnabled);
    _save();
    _syncNative();
  }

  void enableStrictMode(Duration duration) {
    final until = DateTime.now().add(duration);
    state = state.copyWith(
      isStrictMode: true,
      isBlockingEnabled: true,
      blockUntil: until,
    );
    _save();
    _syncNative();
  }

  void disableStrictMode() {
    final now = DateTime.now();
    final expired =
        state.blockUntil == null || now.isAfter(state.blockUntil!);
    if (!expired) return;
    state = state.copyWith(
      isStrictMode: false,
      clearBlockUntil: true,
    );
    _save();
    _syncNative();
  }

  bool isAppBlocked(String packageName) {
    return state.isBlockingEnabled && state.blockedApps.contains(packageName);
  }

  void addSchedule(int weekday, TimeOfDay start, TimeOfDay end) {
    final existing = Map<int, List<TimeRange>>.from(
      state.blockSchedule.map(
        (k, v) => MapEntry(k, List<TimeRange>.from(v)),
      ),
    );
    final list = existing[weekday] ?? [];
    list.add(TimeRange(start: start, end: end));
    existing[weekday] = list;
    state = state.copyWith(blockSchedule: existing);
    _save();
  }

  void removeSchedule(int weekday, int index) {
    final existing = Map<int, List<TimeRange>>.from(
      state.blockSchedule.map(
        (k, v) => MapEntry(k, List<TimeRange>.from(v)),
      ),
    );
    final list = existing[weekday];
    if (list == null || index >= list.length) return;
    list.removeAt(index);
    existing[weekday] = list;
    state = state.copyWith(blockSchedule: existing);
    _save();
  }
}

final appBlockProvider =
    StateNotifierProvider<AppBlockNotifier, AppBlockState>(
  (ref) => AppBlockNotifier(),
);
