import 'package:flutter/material.dart';

class UserProfile {
  final String id;
  final String name;
  final Color avatarColor;
  final String city;
  final String country;
  final String ageGroup;
  final int level;
  final String title;
  final int streak;
  final int bestStreak;
  final int totalPoints;
  final DateTime createdAt;

  const UserProfile({
    required this.id,
    required this.name,
    required this.avatarColor,
    required this.city,
    required this.country,
    required this.ageGroup,
    required this.level,
    required this.title,
    required this.streak,
    required this.bestStreak,
    required this.totalPoints,
    required this.createdAt,
  });

  static const levelTitles = {
    1: 'Dijital Bebek',
    2: 'Ekran Kelebeği',
    3: 'Scroll Asistanı',
    4: 'Farkında Gezgin',
    5: 'Dijital Diyetçi',
    6: 'Ekran Savaşçısı',
    7: 'Off-Grid Çırağı',
    8: 'Dijital Detox Pro',
    9: 'Zaman Ustası',
    10: 'Off-Grid Efsanesi',
  };

  static const _pointsPerLevel = [
    0, 100, 300, 600, 1000, 1500, 2200, 3000, 4000, 5500, 7500,
  ];

  double get levelProgress {
    if (level >= 10) return 1.0;
    final current = _pointsPerLevel[level];
    final next = _pointsPerLevel[level + 1];
    final progress = (totalPoints - current) / (next - current);
    return progress.clamp(0.0, 1.0);
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        id: json['id'] as String,
        name: json['name'] as String,
        avatarColor: Color(json['avatarColor'] as int),
        city: json['city'] as String,
        country: json['country'] as String,
        ageGroup: json['ageGroup'] as String,
        level: json['level'] as int,
        title: json['title'] as String,
        streak: json['streak'] as int,
        bestStreak: json['bestStreak'] as int,
        totalPoints: json['totalPoints'] as int,
        createdAt: DateTime.parse(json['createdAt'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'avatarColor': avatarColor.value,
        'city': city,
        'country': country,
        'ageGroup': ageGroup,
        'level': level,
        'title': title,
        'streak': streak,
        'bestStreak': bestStreak,
        'totalPoints': totalPoints,
        'createdAt': createdAt.toIso8601String(),
      };

  UserProfile copyWith({
    String? id,
    String? name,
    Color? avatarColor,
    String? city,
    String? country,
    String? ageGroup,
    int? level,
    String? title,
    int? streak,
    int? bestStreak,
    int? totalPoints,
    DateTime? createdAt,
  }) =>
      UserProfile(
        id: id ?? this.id,
        name: name ?? this.name,
        avatarColor: avatarColor ?? this.avatarColor,
        city: city ?? this.city,
        country: country ?? this.country,
        ageGroup: ageGroup ?? this.ageGroup,
        level: level ?? this.level,
        title: title ?? this.title,
        streak: streak ?? this.streak,
        bestStreak: bestStreak ?? this.bestStreak,
        totalPoints: totalPoints ?? this.totalPoints,
        createdAt: createdAt ?? this.createdAt,
      );
}
