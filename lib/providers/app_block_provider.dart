import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimeRange {
  const TimeRange({required this.start, required this.end});
  final TimeOfDay start;
  final TimeOfDay end;

  TimeRange copyWith({TimeOfDay? start, TimeOfDay? end}) => TimeRange(
        start: start ?? this.start,
        end: end ?? this.end,
      );

  /// Minutes since midnight
  int get startMinutes => start.hour * 60 + start.minute;
  int get endMinutes => end.hour * 60 + end.minute;

  String format() {
    String _pad(int n) => n.toString().padLeft(2, '0');
    return '${_pad(start.hour)}:${_pad(start.minute)}–${_pad(end.hour)}:${_pad(end.minute)}';
  }
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
  AppBlockNotifier() : super(const AppBlockState());

  void addApp(String packageName) {
    if (state.blockedApps.contains(packageName)) return;
    state = state.copyWith(blockedApps: [...state.blockedApps, packageName]);
  }

  void removeApp(String packageName) {
    state = state.copyWith(
      blockedApps: state.blockedApps.where((a) => a != packageName).toList(),
    );
  }

  void toggleBlocking() {
    if (state.isStrictMode && state.isBlockingEnabled) return;
    state = state.copyWith(isBlockingEnabled: !state.isBlockingEnabled);
  }

  void enableStrictMode(Duration duration) {
    final until = DateTime.now().add(duration);
    state = state.copyWith(
      isStrictMode: true,
      isBlockingEnabled: true,
      blockUntil: until,
    );
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
  }
}

final appBlockProvider =
    StateNotifierProvider<AppBlockNotifier, AppBlockState>(
  (ref) => AppBlockNotifier(),
);
