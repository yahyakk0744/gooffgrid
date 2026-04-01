import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import '../config/theme.dart';
import '../models/app_usage_entry.dart';
import '../models/screen_time_data.dart';

/// Platform channel ile gercek ekran suresi verisini ceker.
/// Android: UsageStatsManager, iOS: henuz desteklenmiyor (mock fallback).
class PlatformScreenTimeService {
  PlatformScreenTimeService._();
  static final instance = PlatformScreenTimeService._();

  static const _channel = MethodChannel('com.gooffgrid/screen_time');

  /// Kullanim istatistikleri izni var mi?
  Future<bool> hasPermission() async {
    if (_isWeb) return false;
    if (!_isAndroid && !_isIOS) return false;
    try {
      final result = await _channel.invokeMethod<bool>('hasPermission');
      return result ?? false;
    } on PlatformException {
      return false;
    }
  }

  /// Kullanici ayarlar ekranina yonlendirir (Android) veya
  /// FamilyControls izni ister (iOS).
  Future<void> requestPermission() async {
    if (_isWeb) return;
    if (!_isAndroid && !_isIOS) return;
    try {
      await _channel.invokeMethod('requestPermission');
    } on PlatformException catch (e) {
      debugPrint('requestPermission error: $e');
    }
  }

  /// Belirli bir gunun ekran suresi verisini getirir.
  /// [daysAgo] = 0 bugun, 1 dun, vs.
  Future<ScreenTimeData?> getUsageForDay(int daysAgo) async {
    if (_isWeb) return null;
    if (!_isAndroid && !_isIOS) return null;
    try {
      final result = await _channel.invokeMethod<Map>('getUsageStats', {
        'daysAgo': daysAgo,
      });
      if (result == null) return null;
      return _parseResult(result, daysAgo);
    } on PlatformException catch (e) {
      debugPrint('getUsageForDay error: $e');
      return null;
    }
  }

  /// Bugunun verisini getirir.
  Future<ScreenTimeData?> getTodayStats() async {
    return getUsageForDay(0);
  }

  /// Detaylı günlük verisi (pickups, longest off, categories dahil).
  Future<ScreenTimeData?> getDetailedUsageForDay(int daysAgo) async {
    if (_isWeb) return null;
    if (!_isAndroid && !_isIOS) return null;
    try {
      final result = await _channel.invokeMethod<Map>('getDetailedStats', {
        'daysAgo': daysAgo,
      });
      if (result == null) return null;
      return _parseDetailedResult(result, daysAgo);
    } on PlatformException catch (e) {
      debugPrint('getDetailedUsageForDay error: $e');
      return null;
    }
  }

  /// Son 7 günün verisini toplu getirir (Supabase sync için optimize).
  Future<List<ScreenTimeData>> getWeekStats() async {
    if (_isWeb) return [];
    if (!_isAndroid && !_isIOS) return [];
    try {
      final result = await _channel.invokeMethod<Map>('getWeekStats');
      if (result == null) return [];
      final rawDays = (result['days'] as List?) ?? [];
      return rawDays.map((day) {
        final map = Map<String, dynamic>.from(day as Map);
        return _parseDetailedResult(map, 0, dateOverride: map['date'] as String?);
      }).toList();
    } on PlatformException {
      // Fallback: günlük çek
      final days = <ScreenTimeData>[];
      for (var i = 6; i >= 0; i--) {
        final day = await getUsageForDay(i);
        if (day != null) days.add(day);
      }
      return days;
    }
  }

  /// Detaylı veri + orijinal uygulama ikonları (Android only).
  /// iOS'te DeviceActivityReport Platform View kullanılır, bu metod iOS'te
  /// ikonlar olmadan normal detaylı veri döner.
  Future<ScreenTimeData?> getUsageWithIcons(int daysAgo) async {
    if (_isWeb) return null;
    if (_isIOS) return getDetailedUsageForDay(daysAgo); // iOS uses platform view
    if (!_isAndroid) return null;
    try {
      final result = await _channel.invokeMethod<Map>('getUsageWithIcons', {
        'daysAgo': daysAgo,
      });
      if (result == null) return null;
      return _parseResultWithIcons(result, daysAgo);
    } on PlatformException catch (e) {
      debugPrint('getUsageWithIcons error: $e');
      return getDetailedUsageForDay(daysAgo); // fallback
    }
  }

  /// Tek bir uygulamanın ikonunu byte[] olarak çeker (Android only).
  Future<Uint8List?> getAppIcon(String packageName) async {
    if (!_isAndroid) return null;
    try {
      final result = await _channel.invokeMethod<Uint8List>('getAppIcon', {
        'packageName': packageName,
      });
      return result;
    } on PlatformException {
      return null;
    }
  }

  /// iOS cihaz mı?
  bool get isIOS => _isIOS;

  /// Android cihaz mı?
  bool get isAndroid => _isAndroid;

  ScreenTimeData _parseResultWithIcons(Map<dynamic, dynamic> result, int daysAgo) {
    final rawApps = (result['apps'] as List?) ?? [];
    final totalMinutes = (result['totalMinutes'] as int?) ?? 0;
    final phonePickups = (result['phonePickups'] as int?) ?? 0;
    final longestOff = (result['longestOffMinutes'] as int?) ?? 0;

    final apps = rawApps.map((app) {
      final map = Map<String, dynamic>.from(app as Map);
      final pkg = map['packageName'] as String;
      Uint8List? iconBytes;
      if (map['iconBytes'] != null) {
        iconBytes = Uint8List.fromList(List<int>.from(map['iconBytes'] as List));
      }
      return AppUsageEntry(
        name: map['name'] as String,
        packageName: pkg,
        minutes: map['minutes'] as int,
        iconColor: _appColor(pkg),
        category: map['category'] as String?,
        iconBytes: iconBytes,
        pickups: (map['pickups'] as int?) ?? 0,
      );
    }).toList();

    final date = DateTime.now().subtract(Duration(days: daysAgo));

    return ScreenTimeData(
      date: date,
      totalMinutes: totalMinutes,
      apps: apps,
      phoneOpens: phonePickups,
      longestOffScreenMinutes: longestOff,
    );
  }

  ScreenTimeData _parseResult(Map<dynamic, dynamic> result, int daysAgo) {
    final rawApps = (result['apps'] as List?) ?? [];
    final totalMinutes = (result['totalMinutes'] as int?) ?? 0;

    final apps = rawApps.map((app) {
      final map = Map<String, dynamic>.from(app as Map);
      final pkg = map['packageName'] as String;
      return AppUsageEntry(
        name: map['name'] as String,
        packageName: pkg,
        minutes: map['minutes'] as int,
        iconColor: _appColor(pkg),
      );
    }).toList();

    final date = DateTime.now().subtract(Duration(days: daysAgo));

    return ScreenTimeData(
      date: date,
      totalMinutes: totalMinutes,
      apps: apps,
      phoneOpens: 0,
      longestOffScreenMinutes: 0,
    );
  }

  ScreenTimeData _parseDetailedResult(Map<dynamic, dynamic> result, int daysAgo, {String? dateOverride}) {
    final rawApps = (result['apps'] as List?) ?? [];
    final totalMinutes = (result['totalMinutes'] as int?) ?? 0;
    final phonePickups = (result['phonePickups'] as int?) ?? 0;
    final longestOff = (result['longestOffMinutes'] as int?) ?? 0;

    final apps = rawApps.map((app) {
      final map = Map<String, dynamic>.from(app as Map);
      final pkg = map['packageName'] as String;
      return AppUsageEntry(
        name: map['name'] as String,
        packageName: pkg,
        minutes: map['minutes'] as int,
        iconColor: _appColor(pkg),
        category: map['category'] as String?,
      );
    }).toList();

    final date = dateOverride != null
        ? DateTime.parse(dateOverride)
        : DateTime.now().subtract(Duration(days: daysAgo));

    return ScreenTimeData(
      date: date,
      totalMinutes: totalMinutes,
      apps: apps,
      phoneOpens: phonePickups,
      longestOffScreenMinutes: longestOff,
    );
  }

  bool get _isWeb => kIsWeb;
  bool get _isAndroid => !kIsWeb && Platform.isAndroid;
  bool get _isIOS => !kIsWeb && Platform.isIOS;

  /// Bilinen uygulamalara renk atar.
  static Color _appColor(String packageName) {
    const colorMap = {
      'com.instagram.android': AppColors.instagram,
      'com.google.android.youtube': AppColors.youtube,
      'com.zhiliaoapp.musically': AppColors.tiktok,
      'com.twitter.android': AppColors.twitter,
      'com.whatsapp': AppColors.whatsapp,
      'com.snapchat.android': AppColors.snapchat,
      'org.telegram.messenger': AppColors.telegram,
      'com.reddit.frontpage': AppColors.reddit,
      'com.spotify.music': AppColors.neonGreen,
      'com.discord': AppColors.textSecondary,
    };
    return colorMap[packageName] ?? AppColors.textTertiary;
  }
}
