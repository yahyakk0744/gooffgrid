import 'dart:io';

import 'package:flutter/foundation.dart';
import 'supabase_sync_service.dart';

/// Push notification servisi.
/// FCM token'ı Supabase'e kaydet → Edge Function bildirim gönderir.
/// Firebase'e bağımlılık yok — sadece FCM REST API + Supabase Cron.
class NotificationService {
  NotificationService._();
  static final instance = NotificationService._();

  String? _fcmToken;

  Future<void> initialize() async {
    // TODO: firebase_messaging eklendiğinde aktifleşecek
    // final messaging = FirebaseMessaging.instance;
    // _fcmToken = await messaging.getToken();
    // messaging.onTokenRefresh.listen(_onTokenRefresh);
    debugPrint('[NotificationService] initialized');
  }

  /// FCM token'ı Supabase'e kaydet.
  Future<void> registerToken(String token) async {
    _fcmToken = token;
    final platform = Platform.isIOS ? 'ios' : 'android';
    await SupabaseSyncService.instance.registerDevice(
      fcmToken: token,
      platform: platform,
    );
  }

  String? get fcmToken => _fcmToken;

  /// Notify when a friend enters the shame wall.
  void sendShameNotification({required String userName, required int totalMinutes}) {
    debugPrint('[Notification] SHAME: $userName $totalMinutes dk ile utanc duvarinda!');
  }

  /// Notify duel invitation or result.
  void sendDuelNotification({required String type, required String opponentName, String? result}) {
    debugPrint('[Notification] DUEL ($type): $opponentName ${result ?? ""}');
  }

  /// Notify streak milestone.
  void sendStreakNotification({required int streak}) {
    debugPrint('[Notification] STREAK: $streak gun ust uste! Devam et!');
  }

  /// Notify incoming reaction.
  void sendReactionNotification({required String fromName, required String emoji}) {
    debugPrint('[Notification] REACTION: $fromName sana $emoji gonderdi');
  }

  /// Notify daily screen time warning.
  void sendScreenTimeWarning({required int currentMinutes, required int threshold}) {
    debugPrint('[Notification] WARNING: $currentMinutes dk — esik: $threshold dk');
  }

  /// Notify ranking change.
  void sendRankChangeNotification({required int oldRank, required int newRank, required String scope}) {
    debugPrint('[Notification] RANK: $scope siralamanda $oldRank -> $newRank');
  }
}
