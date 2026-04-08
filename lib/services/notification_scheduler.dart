import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'notification_service.dart';

/// Pattern from uhabits: re-schedule ALL notifications on any change.
/// Prevents stale/phantom reminders after timezone, settings, or skip changes.
class NotificationScheduler {
  NotificationScheduler._();
  static final instance = NotificationScheduler._();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static const String _channelId = 'gooffgrid_channel';
  static const String _channelName = 'GoOffGrid Bildirimler';
  static const String _channelDesc =
      'GoOffGrid uygulama bildirimleri — seri uyarilari, gunluk hatirlaticilar';

  bool _tzInitialized = false;

  Future<void> _ensureTimezone() async {
    if (_tzInitialized) return;
    tz.initializeTimeZones();
    final String timezoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timezoneName));
    _tzInitialized = true;
  }

  NotificationDetails get _details => const NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          _channelName,
          channelDescription: _channelDesc,
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      );

  /// Call after ANY setting/session/streak change.
  /// Cancels ALL pending, then re-creates only current ones.
  Future<void> rescheduleAll({
    required int currentStreak,
    required bool hasSessionToday,
    required int dailyGoalMin,
    required int completedMin,
  }) async {
    await _ensureTimezone();

    // NudgeService initialize edilmis olmali
    await NudgeService.instance.initialize();

    // 1. Cancel all existing scheduled notifications
    await _cancelAll();

    // 2. Streak warning — if streak > 0 and no session today, warn at 20:00
    if (currentStreak > 0 && !hasSessionToday) {
      await _scheduleStreakWarning(currentStreak);
    }

    // 3. Daily reminder — schedule for tomorrow morning
    await _scheduleDailyReminder();

    // 4. Goal progress — if midday and under 50% of goal, nudge
    if (completedMin < dailyGoalMin ~/ 2) {
      await _scheduleGoalNudge(dailyGoalMin, completedMin);
    }
  }

  Future<void> _cancelAll() async {
    await _plugin.cancelAll();
    debugPrint('[NotificationScheduler] Tum bekleyen bildirimler iptal edildi');
  }

  Future<void> _scheduleStreakWarning(int streak) async {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledTime = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      20, // 20:00
      0,
    );

    // Eger 20:00 gecmisse bugun artik zamanlanamaz, atliyoruz
    if (scheduledTime.isBefore(now)) {
      debugPrint(
          '[NotificationScheduler] Streak uyarisi: saat 20:00 gecmis, atlanıyor');
      return;
    }

    await _plugin.zonedSchedule(
      1001,
      'Serini Kaybetme! 🔥',
      '$streak gunluk seriniz tehlikede! Bugun bir seans yap.',
      scheduledTime,
      _details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: 'streak_warning',
    );

    debugPrint(
        '[NotificationScheduler] Streak uyarisi zamanlandı: ${scheduledTime.toIso8601String()}');
  }

  Future<void> _scheduleDailyReminder() async {
    final now = tz.TZDateTime.now(tz.local);
    // Yarin sabah 09:00
    final scheduledTime = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day + 1,
      9, // 09:00
      0,
    );

    await _plugin.zonedSchedule(
      1002,
      'Gunun Basliyor! 🌅',
      'Bugun telefona az bak, hayata cok bak. Basarilar!',
      scheduledTime,
      _details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: 'daily_reminder',
    );

    debugPrint(
        '[NotificationScheduler] Gunluk hatirlatici zamanlandı: ${scheduledTime.toIso8601String()}');
  }

  Future<void> _scheduleGoalNudge(int goalMin, int doneMin) async {
    final scheduledTime =
        tz.TZDateTime.now(tz.local).add(const Duration(minutes: 30));

    final remaining = goalMin - doneMin;

    await _plugin.zonedSchedule(
      1003,
      'Hedefe Devam Et! 🎯',
      'Gunluk hedefe $remaining dakika kaldi. Haydi, yapabilirsin!',
      scheduledTime,
      _details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: 'goal_nudge',
    );

    debugPrint(
        '[NotificationScheduler] Hedef nudge zamanlandı: ${scheduledTime.toIso8601String()} ($doneMin/$goalMin dk)');
  }
}
