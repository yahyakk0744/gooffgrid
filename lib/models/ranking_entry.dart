import 'package:flutter/material.dart';

class RankingEntry {
  final int rank;
  final String userId;
  final String name;
  final Color avatarColor;
  final int level;
  final int totalMinutes;
  final int change;

  const RankingEntry({
    required this.rank,
    required this.userId,
    required this.name,
    required this.avatarColor,
    required this.level,
    required this.totalMinutes,
    required this.change,
  });

  bool get isUp => change > 0;
  bool get isDown => change < 0;
  bool get isStable => change == 0;

  String get formattedChange {
    if (isStable) return '-';
    if (isUp) return '+$change';
    return '$change';
  }

  factory RankingEntry.fromJson(Map<String, dynamic> json) => RankingEntry(
        rank: json['rank'] as int,
        userId: json['userId'] as String,
        name: json['name'] as String,
        avatarColor: Color(json['avatarColor'] as int),
        level: json['level'] as int,
        totalMinutes: json['totalMinutes'] as int,
        change: json['change'] as int,
      );

  Map<String, dynamic> toJson() => {
        'rank': rank,
        'userId': userId,
        'name': name,
        'avatarColor': avatarColor.toARGB32(),
        'level': level,
        'totalMinutes': totalMinutes,
        'change': change,
      };

  RankingEntry copyWith({
    int? rank,
    String? userId,
    String? name,
    Color? avatarColor,
    int? level,
    int? totalMinutes,
    int? change,
  }) =>
      RankingEntry(
        rank: rank ?? this.rank,
        userId: userId ?? this.userId,
        name: name ?? this.name,
        avatarColor: avatarColor ?? this.avatarColor,
        level: level ?? this.level,
        totalMinutes: totalMinutes ?? this.totalMinutes,
        change: change ?? this.change,
      );
}
