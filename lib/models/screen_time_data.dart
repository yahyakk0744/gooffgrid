import 'package:flutter/material.dart';
import 'package:gooffgrid/models/app_usage_entry.dart';

class ScreenTimeData {
  final DateTime date;
  final int totalMinutes;
  final List<AppUsageEntry> apps;
  final int phoneOpens;
  final int longestOffScreenMinutes;

  const ScreenTimeData({
    required this.date,
    required this.totalMinutes,
    required this.apps,
    required this.phoneOpens,
    required this.longestOffScreenMinutes,
  });

  String get formattedTotal {
    final h = totalMinutes ~/ 60;
    final m = totalMinutes % 60;
    if (h > 0 && m > 0) return '${h}s ${m}dk';
    if (h > 0) return '${h}s';
    return '${m}dk';
  }

  AppUsageEntry? get topApp =>
      apps.isEmpty ? null : (List.of(apps)..sort((a, b) => b.minutes.compareTo(a.minutes))).first;

  bool get isGoodDay => totalMinutes < 120;

  bool get isWarningDay => totalMinutes < 240;

  /// Default daily goal in minutes (3 hours)
  int get goalMinutes => 180;

  /// Progress toward daily goal (0.0 to 1.0+)
  double get goalProgress => goalMinutes > 0 ? totalMinutes / goalMinutes : 0;

  /// Percentage string for display
  int get goalPercentage => (goalProgress * 100).round();

  /// Formatted today total (alias for formattedTotal)
  String get formattedToday => formattedTotal;

  /// Ring color based on goal progress
  Color get ringColor {
    if (totalMinutes <= goalMinutes * 0.5) return const Color(0xFF30D158); // green
    if (totalMinutes <= goalMinutes) return const Color(0xFFFFD60A); // yellow
    return const Color(0xFFFF453A); // red
  }

  /// App usage sorted by minutes descending
  List<AppUsageEntry> get appUsage =>
      List.of(apps)..sort((a, b) => b.minutes.compareTo(a.minutes));

  factory ScreenTimeData.fromJson(Map<String, dynamic> json) => ScreenTimeData(
        date: DateTime.parse(json['date'] as String),
        totalMinutes: json['totalMinutes'] as int,
        apps: (json['apps'] as List).map((e) => AppUsageEntry.fromJson(e as Map<String, dynamic>)).toList(),
        phoneOpens: json['phoneOpens'] as int,
        longestOffScreenMinutes: json['longestOffScreenMinutes'] as int,
      );

  Map<String, dynamic> toJson() => {
        'date': date.toIso8601String(),
        'totalMinutes': totalMinutes,
        'apps': apps.map((e) => e.toJson()).toList(),
        'phoneOpens': phoneOpens,
        'longestOffScreenMinutes': longestOffScreenMinutes,
      };

  ScreenTimeData copyWith({
    DateTime? date,
    int? totalMinutes,
    List<AppUsageEntry>? apps,
    int? phoneOpens,
    int? longestOffScreenMinutes,
  }) =>
      ScreenTimeData(
        date: date ?? this.date,
        totalMinutes: totalMinutes ?? this.totalMinutes,
        apps: apps ?? this.apps,
        phoneOpens: phoneOpens ?? this.phoneOpens,
        longestOffScreenMinutes: longestOffScreenMinutes ?? this.longestOffScreenMinutes,
      );
}
