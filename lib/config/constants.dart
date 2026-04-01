import 'package:flutter/material.dart';

class AppConstants {
  AppConstants._();

  // Level XP requirements
  static const Map<int, int> levelRequirements = {
    1: 0,
    2: 100,
    3: 300,
    4: 600,
    5: 1000,
    6: 1500,
    7: 2500,
    8: 4000,
    9: 6000,
    10: 10000,
  };

  // Level titles
  static const List<String> levelTitles = [
    'Çaylak',
    'Başlangıç',
    'Farkında',
    'Kararlı',
    'Dijital Diyetçi',
    'Odaklı',
    'Özgür',
    'Usta',
    'Efsane',
    'Off-Grid Tanrısı',
  ];

  // Badges
  static const List<Map<String, String>> badges = [
    {'id': 'first_hour', 'name': 'İlk Saat', 'description': '1 saat telefonsuz kal', 'iconEmoji': '⏰'},
    {'id': 'sunrise', 'name': 'Gün Doğumu', 'description': 'Sabah 6-9 arası telefona bakma', 'iconEmoji': '🌅'},
    {'id': 'night_owl', 'name': 'Gece Kuşu', 'description': 'Gece 22-06 arası telefonsuz', 'iconEmoji': '🦉'},
    {'id': 'social_detox', 'name': 'Sosyal Detox', 'description': '24 saat sosyal medyasız', 'iconEmoji': '🧘'},
    {'id': 'streak_3', 'name': '3 Gün Seri', 'description': '3 gün üst üste hedef tut', 'iconEmoji': '🔥'},
    {'id': 'streak_7', 'name': 'Haftalık Savaşçı', 'description': '7 gün üst üste hedef tut', 'iconEmoji': '⚔️'},
    {'id': 'streak_30', 'name': 'Ay Tanrısı', 'description': '30 gün üst üste hedef tut', 'iconEmoji': '🌙'},
    {'id': 'duel_winner', 'name': 'Düello Şampiyonu', 'description': 'İlk düelloyu kazan', 'iconEmoji': '🏆'},
    {'id': 'duel_5', 'name': 'Gladyatör', 'description': '5 düello kazan', 'iconEmoji': '🗡️'},
    {'id': 'under_2h', 'name': '2 Saat Altı', 'description': 'Günlük kullanımı 2 saat altında tut', 'iconEmoji': '✨'},
    {'id': 'under_1h', 'name': '1 Saat Altı', 'description': 'Günlük kullanımı 1 saat altında tut', 'iconEmoji': '💎'},
    {'id': 'invite_friend', 'name': 'Kurtarıcı', 'description': 'Bir arkadaşını davet et', 'iconEmoji': '🤝'},
    {'id': 'top_10', 'name': 'Top 10', 'description': 'Haftalık sıralamada ilk 10\'a gir', 'iconEmoji': '🏅'},
    {'id': 'breathing', 'name': 'Nefes Ustası', 'description': '10 nefes egzersizi tamamla', 'iconEmoji': '🌬️'},
    {'id': 'off_grid', 'name': 'Off-Grid', 'description': 'Tam bir gün telefonsuz geçir', 'iconEmoji': '🏔️'},
  ];

  // Avatar background colors
  static const List<Color> avatarColors = [
    Color(0xFF667EEA),
    Color(0xFFF093FB),
    Color(0xFF4FACFE),
    Color(0xFFA8EB12),
    Color(0xFFFF6B00),
    Color(0xFFFF453A),
    Color(0xFF30D158),
    Color(0xFF69C9D0),
  ];

  // Age groups
  static const List<String> ageGroups = [
    '13-17',
    '18-24',
    '25-34',
    '35-44',
    '45+',
  ];

  // Screen time thresholds (minutes)
  static const int goodMinutes = 120;
  static const int warningMinutes = 240;

  // Duel durations (minutes)
  static const List<int> duelDurations = [60, 180, 720, 1440, 10080];

  // Reactions
  static const List<String> reactions = ['🫣', '👏', '🔥', '💀'];
}
