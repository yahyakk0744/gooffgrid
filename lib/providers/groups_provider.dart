import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gooffgrid/models/group.dart';

final _mockGroups = [
  Group(
    id: 'g1',
    name: 'Orman Kurtlari',
    memberIds: const ['user1', 'u2', 'u3', 'u4', 'u5', 'u6'],
    members: const [
      GroupMember(userId: 'user1', name: 'Ege', avatarColor: Color(0xFF667EEA), level: 5, weekMinutes: 204),
      GroupMember(userId: 'u2', name: 'Aylin', avatarColor: Color(0xFFF093FB), level: 7, weekMinutes: 95),
      GroupMember(userId: 'u3', name: 'Deniz', avatarColor: Color(0xFF4FACFE), level: 6, weekMinutes: 132),
      GroupMember(userId: 'u4', name: 'Burak', avatarColor: Color(0xFFA8EB12), level: 5, weekMinutes: 156),
      GroupMember(userId: 'u5', name: 'Selin', avatarColor: Color(0xFFFF6B00), level: 4, weekMinutes: 210),
      GroupMember(userId: 'u6', name: 'Mert', avatarColor: Color(0xFF30D158), level: 4, weekMinutes: 267),
    ],
    challengeTargetMinutes: 2400,
    challengeDescription: 'Toplam 40 saatin altinda kal',
    shameWallUserId: 'u6',
    createdAt: DateTime(2025, 2, 1),
  ),
  Group(
    id: 'g2',
    name: 'Dijital Detox Tayfa',
    memberIds: const ['user1', 'u2', 'u7', 'u8'],
    members: const [
      GroupMember(userId: 'user1', name: 'Ege', avatarColor: Color(0xFF667EEA), level: 5, weekMinutes: 204),
      GroupMember(userId: 'u2', name: 'Aylin', avatarColor: Color(0xFFF093FB), level: 7, weekMinutes: 95),
      GroupMember(userId: 'u7', name: 'Zeynep', avatarColor: Color(0xFFFF453A), level: 3, weekMinutes: 289),
      GroupMember(userId: 'u8', name: 'Ozan', avatarColor: Color(0xFFFFD700), level: 2, weekMinutes: 358),
    ],
    challengeTargetMinutes: 1680,
    challengeDescription: 'Haftalik 28 saatin altinda kal',
    shameWallUserId: 'u8',
    createdAt: DateTime(2025, 3, 10),
  ),
];

class GroupNotifier extends StateNotifier<List<Group>> {
  GroupNotifier() : super(_mockGroups);
}

final groupProvider = StateNotifierProvider<GroupNotifier, List<Group>>(
  (ref) => GroupNotifier(),
);
