import 'dart:math';

import 'package:gooffgrid/config/theme.dart';
import 'package:gooffgrid/models/app_usage_entry.dart';
import 'package:gooffgrid/models/screen_time_data.dart';

/// Formats minutes into human-readable Turkish duration.
/// Examples: 204 -> "3s 24dk", 45 -> "45dk", 120 -> "2s"
String formatMinutes(int minutes) {
  final h = minutes ~/ 60;
  final m = minutes % 60;
  if (h > 0 && m > 0) return '${h}s ${m}dk';
  if (h > 0) return '${h}s';
  return '${m}dk';
}

/// Mock data generators for screen time.
/// Replace with real platform channel / UsageStats API when ready.
class ScreenTimeService {
  ScreenTimeService._();
  static final instance = ScreenTimeService._();

  static final _rng = Random(42);

  static const _appPool = [
    ('Instagram', 'com.instagram.android', AppColors.instagram),
    ('YouTube', 'com.google.android.youtube', AppColors.youtube),
    ('TikTok', 'com.zhiliaoapp.musically', AppColors.tiktok),
    ('Twitter', 'com.twitter.android', AppColors.twitter),
    ('WhatsApp', 'com.whatsapp', AppColors.whatsapp),
    ('Snapchat', 'com.snapchat.android', AppColors.snapchat),
    ('Telegram', 'org.telegram.messenger', AppColors.telegram),
    ('Reddit', 'com.reddit.frontpage', AppColors.reddit),
  ];

  /// Generates a random day of screen time data.
  ScreenTimeData generateRandomDay(DateTime date) {
    final total = 100 + _rng.nextInt(250);
    final apps = _generateAppBreakdown(total);
    return ScreenTimeData(
      date: date,
      totalMinutes: total,
      apps: apps,
      phoneOpens: 20 + _rng.nextInt(60),
      longestOffScreenMinutes: 15 + _rng.nextInt(120),
    );
  }

  List<AppUsageEntry> _generateAppBreakdown(int totalMinutes) {
    final shuffled = List.of(_appPool)..shuffle(_rng);
    final count = 4 + _rng.nextInt(3);
    final picked = shuffled.take(count).toList();

    var remaining = totalMinutes;
    final entries = <AppUsageEntry>[];

    for (var i = 0; i < picked.length; i++) {
      final (name, pkg, color) = picked[i];
      final isLast = i == picked.length - 1;
      final minutes = isLast ? remaining : (remaining * (0.15 + _rng.nextDouble() * 0.35)).round();
      remaining -= minutes;
      if (minutes > 0) {
        entries.add(AppUsageEntry(name: name, packageName: pkg, minutes: minutes, iconColor: color));
      }
    }

    if (remaining > 0) {
      entries.add(AppUsageEntry(
        name: 'Diger',
        packageName: 'other',
        minutes: remaining,
        iconColor: AppColors.textTertiary,
      ));
    }

    entries.sort((a, b) => b.minutes.compareTo(a.minutes));
    return entries;
  }

  /// Generates a week of mock data ending today.
  List<ScreenTimeData> generateWeek() {
    final now = DateTime.now();
    return List.generate(7, (i) => generateRandomDay(now.subtract(Duration(days: 6 - i))));
  }
}
