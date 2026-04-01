import 'package:flutter/material.dart';

enum DuelStatus { waiting, active, completed }

class DuelPlayer {
  final String userId;
  final String name;
  final Color avatarColor;
  final int totalMinutes;

  const DuelPlayer({
    required this.userId,
    required this.name,
    required this.avatarColor,
    required this.totalMinutes,
  });

  factory DuelPlayer.fromJson(Map<String, dynamic> json) => DuelPlayer(
        userId: json['userId'] as String,
        name: json['name'] as String,
        avatarColor: Color(json['avatarColor'] as int),
        totalMinutes: json['totalMinutes'] as int,
      );

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'name': name,
        'avatarColor': avatarColor.value,
        'totalMinutes': totalMinutes,
      };

  DuelPlayer copyWith({
    String? userId,
    String? name,
    Color? avatarColor,
    int? totalMinutes,
  }) =>
      DuelPlayer(
        userId: userId ?? this.userId,
        name: name ?? this.name,
        avatarColor: avatarColor ?? this.avatarColor,
        totalMinutes: totalMinutes ?? this.totalMinutes,
      );
}

class Duel {
  final String id;
  final DuelPlayer player1;
  final DuelPlayer player2;
  final int durationMinutes;
  final DateTime startTime;
  final DateTime? endTime;
  final DuelStatus status;
  final String? winnerId;
  final String shareCode;

  const Duel({
    required this.id,
    required this.player1,
    required this.player2,
    required this.durationMinutes,
    required this.startTime,
    this.endTime,
    required this.status,
    this.winnerId,
    required this.shareCode,
  });

  factory Duel.fromJson(Map<String, dynamic> json) => Duel(
        id: json['id'] as String,
        player1: DuelPlayer.fromJson(json['player1'] as Map<String, dynamic>),
        player2: DuelPlayer.fromJson(json['player2'] as Map<String, dynamic>),
        durationMinutes: json['durationMinutes'] as int,
        startTime: DateTime.parse(json['startTime'] as String),
        endTime: json['endTime'] != null ? DateTime.parse(json['endTime'] as String) : null,
        status: DuelStatus.values.byName(json['status'] as String),
        winnerId: json['winnerId'] as String?,
        shareCode: json['shareCode'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'player1': player1.toJson(),
        'player2': player2.toJson(),
        'durationMinutes': durationMinutes,
        'startTime': startTime.toIso8601String(),
        'endTime': endTime?.toIso8601String(),
        'status': status.name,
        'winnerId': winnerId,
        'shareCode': shareCode,
      };

  Duel copyWith({
    String? id,
    DuelPlayer? player1,
    DuelPlayer? player2,
    int? durationMinutes,
    DateTime? startTime,
    DateTime? endTime,
    DuelStatus? status,
    String? winnerId,
    String? shareCode,
  }) =>
      Duel(
        id: id ?? this.id,
        player1: player1 ?? this.player1,
        player2: player2 ?? this.player2,
        durationMinutes: durationMinutes ?? this.durationMinutes,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        status: status ?? this.status,
        winnerId: winnerId ?? this.winnerId,
        shareCode: shareCode ?? this.shareCode,
      );
}
