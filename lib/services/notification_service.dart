import 'package:flutter/foundation.dart';

/// Nudge/notification service — yerel bildirimlerle kullaniciyi uyarir.
/// flutter_local_notifications eklendiginde TODO yorumlarini kaldirabiliriz.
class NudgeService {
  NudgeService._();
  static final instance = NudgeService._();

  // Esikler (dakika)
  static const int _warnThreshold = 30;
  static const int _alertThreshold = 60;
  static const int _criticalThreshold = 90;

  // Son tetiklenen esik — ayni bildirimi tekrar gondermemek icin
  final Map<String, int> _lastNudge = {};

  /// Servisi baslatir. flutter_local_notifications eklendiginde
  /// buraya izin isteme ve kanal olusturma kodu gelecek.
  Future<void> initialize() async {
    // TODO: flutter_local_notifications eklendikten sonra:
    // final plugin = FlutterLocalNotificationsPlugin();
    // await plugin.initialize(InitializationSettings(...));
    debugPrint('[NudgeService] initialized');
  }

  /// Bir uygulama icin kullanim suresi kontrolu yapar ve
  /// esige gore bildirim gonderir.
  ///
  /// [appName]      — gosterilecek uygulama adi (orn. "Instagram")
  /// [minutesUsed]  — bugun o uygulamada gecirilen dakika
  void checkAndNudge(String appName, int minutesUsed) {
    final last = _lastNudge[appName] ?? 0;

    if (minutesUsed >= _criticalThreshold && last < _criticalThreshold) {
      _lastNudge[appName] = _criticalThreshold;
      _send(
        id: appName.hashCode + 3,
        title: 'Kritik Uyari',
        body: "$appName'da 1.5 saat! O2 puanlarin eriyor... 🫧",
      );
    } else if (minutesUsed >= _alertThreshold && last < _alertThreshold) {
      _lastNudge[appName] = _alertThreshold;
      _send(
        id: appName.hashCode + 2,
        title: 'Telefonu Birak!',
        body: "$appName'da 1 saat oldu. Telefonunu birak! 📵",
      );
    } else if (minutesUsed >= _warnThreshold && last < _warnThreshold) {
      _lastNudge[appName] = _warnThreshold;
      _send(
        id: appName.hashCode + 1,
        title: 'Mola Vakti',
        body: "$appName'da 30 dakika gectin. Mola ver! 🧘",
      );
    }
  }

  /// Sabah motivasyon bildirimi.
  Future<void> sendDailyReminder() async {
    _send(
      id: 9001,
      title: 'Gunun Basliyor!',
      body: 'Bugun telefona az bak, hayata cok bak. 🌅',
    );
  }

  /// Haftalik ozet bildirimi.
  Future<void> sendWeeklyReport() async {
    _send(
      id: 9002,
      title: 'Haftalik Rapor Hazir',
      body: 'Bu haftaki ekran suren seni bekliyor. Nasil gecti? 📊',
    );
  }

  // --- Eski metodlar (geriye donuk uyumluluk) ---

  void sendShameNotification({required String userName, required int totalMinutes}) {
    _send(
      id: userName.hashCode,
      title: 'Utanc Duvari',
      body: '$userName $totalMinutes dk ile utanc duvarinda!',
    );
  }

  void sendDuelNotification({required String type, required String opponentName, String? result}) {
    _send(
      id: opponentName.hashCode,
      title: 'Duello',
      body: 'Duello ($type): $opponentName ${result ?? ""}',
    );
  }

  void sendStreakNotification({required int streak}) {
    _send(
      id: 8000 + streak,
      title: 'Seri Devam!',
      body: '$streak gun ust uste! Devam et! 🔥',
    );
  }

  void sendReactionNotification({required String fromName, required String emoji}) {
    _send(
      id: fromName.hashCode,
      title: 'Yeni Reaksiyon',
      body: '$fromName sana $emoji gonderdi',
    );
  }

  void sendScreenTimeWarning({required int currentMinutes, required int threshold}) {
    _send(
      id: 7000,
      title: 'Ekran Suresi Uyarisi',
      body: '$currentMinutes dk kullandin — esik: $threshold dk',
    );
  }

  void sendRankChangeNotification({required int oldRank, required int newRank, required String scope}) {
    _send(
      id: 6000,
      title: 'Siralama Degisti',
      body: '$scope: $oldRank. siradan $newRank. siraya gectin',
    );
  }

  // --- Dahili gonderici ---

  void _send({required int id, required String title, required String body}) {
    // TODO: flutter_local_notifications eklendikten sonra:
    // await _plugin.show(id, title, body, notificationDetails);
    debugPrint('[NudgeService] #$id | $title | $body');
  }
}

// Geriye donuk uyumluluk alias
typedef NotificationService = NudgeService;
