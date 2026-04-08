import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Nudge/notification service — yerel bildirimlerle kullaniciyi uyarir.
class NudgeService {
  NudgeService._();
  static final instance = NudgeService._();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static const String _channelId = 'gooffgrid_channel';
  static const String _channelName = 'GoOffGrid Bildirimler';
  static const String _channelDesc =
      'GoOffGrid uygulama bildirimleri — seri uyarilari, gunluk hatirlaticilar';

  // Esikler (dakika)
  static const int _warnThreshold = 30;
  static const int _alertThreshold = 60;
  static const int _criticalThreshold = 90;

  // Son tetiklenen esik — ayni bildirimi tekrar gondermemek icin
  final Map<String, int> _lastNudge = {};

  bool _initialized = false;

  /// Servisi baslatir: Android + iOS ayarlari, kanal olusturma, izin isteme.
  Future<void> initialize() async {
    if (_initialized) return;

    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _plugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        debugPrint('[NudgeService] Bildirime tiklandi: ${response.payload}');
      },
    );

    // Android bildirim kanalini olustur
    const androidChannel = AndroidNotificationChannel(
      _channelId,
      _channelName,
      description: _channelDesc,
      importance: Importance.high,
    );

    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidChannel);

    // iOS izinleri iste
    await _plugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);

    _initialized = true;
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
    await _send(
      id: 9001,
      title: 'Gunun Basliyor!',
      body: 'Bugun telefona az bak, hayata cok bak. 🌅',
    );
  }

  /// Haftalik ozet bildirimi.
  Future<void> sendWeeklyReport() async {
    await _send(
      id: 9002,
      title: 'Haftalik Rapor Hazir',
      body: 'Bu haftaki ekran suren seni bekliyor. Nasil gecti? 📊',
    );
  }

  // --- Eski metodlar (geriye donuk uyumluluk) ---

  void sendShameNotification(
      {required String userName, required int totalMinutes}) {
    _send(
      id: userName.hashCode,
      title: 'Utanc Duvari',
      body: '$userName $totalMinutes dk ile utanc duvarinda!',
    );
  }

  void sendDuelNotification(
      {required String type,
      required String opponentName,
      String? result}) {
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

  void sendReactionNotification(
      {required String fromName, required String emoji}) {
    _send(
      id: fromName.hashCode,
      title: 'Yeni Reaksiyon',
      body: '$fromName sana $emoji gonderdi',
    );
  }

  void sendScreenTimeWarning(
      {required int currentMinutes, required int threshold}) {
    _send(
      id: 7000,
      title: 'Ekran Suresi Uyarisi',
      body: '$currentMinutes dk kullandin — esik: $threshold dk',
    );
  }

  void sendRankChangeNotification(
      {required int oldRank, required int newRank, required String scope}) {
    _send(
      id: 6000,
      title: 'Siralama Degisti',
      body: '$scope: $oldRank. siradan $newRank. siraya gectin',
    );
  }

  // --- Dahili gonderici ---

  Future<void> _send(
      {required int id, required String title, required String body}) async {
    if (!_initialized) {
      debugPrint('[NudgeService] Henuz baslatilmadi, initialize() cagir');
      return;
    }

    const androidDetails = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDesc,
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _plugin.show(id, title, body, details);
    debugPrint('[NudgeService] #$id | $title | $body');
  }
}

// Geriye donuk uyumluluk alias
typedef NotificationService = NudgeService;
