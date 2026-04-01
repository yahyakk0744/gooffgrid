import 'package:flutter/material.dart';

class GroupMember {
  final String userId;
  final String name;
  final Color avatarColor;
  final int level;
  final int weekMinutes;

  const GroupMember({
    required this.userId,
    required this.name,
    required this.avatarColor,
    required this.level,
    required this.weekMinutes,
  });
}

class Group {
  final String id;
  final String name;
  final List<String> memberIds;
  final List<GroupMember> members;
  final int challengeTargetMinutes;
  final String challengeDescription;
  final String? shameWallUserId;
  final DateTime createdAt;

  const Group({
    required this.id,
    required this.name,
    required this.memberIds,
    this.members = const [],
    required this.challengeTargetMinutes,
    this.challengeDescription = '',
    this.shameWallUserId,
    required this.createdAt,
  });

  int get memberCount => memberIds.length;

  int get weekTotalMinutes =>
      members.isEmpty ? 0 : members.fold(0, (sum, m) => sum + m.weekMinutes);

  double get challengeProgress {
    if (challengeTargetMinutes <= 0) return 0;
    // Progress = how much under target (lower is better)
    final total = weekTotalMinutes;
    if (total >= challengeTargetMinutes) return 0;
    return 1.0 - (total / challengeTargetMinutes);
  }

  factory Group.fromJson(Map<String, dynamic> json) => Group(
        id: json['id'] as String,
        name: json['name'] as String,
        memberIds: List<String>.from(json['memberIds'] as List),
        challengeTargetMinutes: json['challengeTargetMinutes'] as int,
        shameWallUserId: json['shameWallUserId'] as String?,
        createdAt: DateTime.parse(json['createdAt'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'memberIds': memberIds,
        'challengeTargetMinutes': challengeTargetMinutes,
        'shameWallUserId': shameWallUserId,
        'createdAt': createdAt.toIso8601String(),
      };

  Group copyWith({
    String? id,
    String? name,
    List<String>? memberIds,
    List<GroupMember>? members,
    int? challengeTargetMinutes,
    String? challengeDescription,
    String? shameWallUserId,
    DateTime? createdAt,
  }) =>
      Group(
        id: id ?? this.id,
        name: name ?? this.name,
        memberIds: memberIds ?? this.memberIds,
        members: members ?? this.members,
        challengeTargetMinutes: challengeTargetMinutes ?? this.challengeTargetMinutes,
        challengeDescription: challengeDescription ?? this.challengeDescription,
        shameWallUserId: shameWallUserId ?? this.shameWallUserId,
        createdAt: createdAt ?? this.createdAt,
      );
}
