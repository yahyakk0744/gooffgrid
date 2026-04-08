import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gooffgrid/config/theme.dart';
import 'package:gooffgrid/models/duel.dart';

final _now = DateTime.now();

final _mockDuels = [
  Duel(
    id: 'd1',
    player1: const DuelPlayer(userId: 'user1', name: 'Eren', avatarColor: Color(0xFF667EEA), totalMinutes: 84),
    player2: const DuelPlayer(userId: 'u2', name: 'Aylin', avatarColor: Color(0xFFF093FB), totalMinutes: 42),
    durationMinutes: 1440,
    startTime: _now.subtract(const Duration(hours: 14)),
    status: DuelStatus.active,
    shareCode: 'DUEL-AY7K',
  ),
  Duel(
    id: 'd2',
    player1: const DuelPlayer(userId: 'user1', name: 'Eren', avatarColor: Color(0xFF667EEA), totalMinutes: 156),
    player2: const DuelPlayer(userId: 'u4', name: 'Burak', avatarColor: Color(0xFFA8EB12), totalMinutes: 178),
    durationMinutes: 4320,
    startTime: _now.subtract(const Duration(days: 2)),
    status: DuelStatus.active,
    shareCode: 'DUEL-BK3M',
  ),
  Duel(
    id: 'd3',
    player1: const DuelPlayer(userId: 'user1', name: 'Eren', avatarColor: Color(0xFF667EEA), totalMinutes: 195),
    player2: const DuelPlayer(userId: 'u3', name: 'Deniz', avatarColor: Color(0xFF4FACFE), totalMinutes: 230),
    durationMinutes: 1440,
    startTime: _now.subtract(const Duration(days: 5)),
    endTime: _now.subtract(const Duration(days: 4)),
    status: DuelStatus.completed,
    winnerId: 'user1',
    shareCode: 'DUEL-DN9P',
  ),
  Duel(
    id: 'd4',
    player1: const DuelPlayer(userId: 'u6', name: 'Mert', avatarColor: Color(0xFF30D158), totalMinutes: 145),
    player2: const DuelPlayer(userId: 'user1', name: 'Eren', avatarColor: Color(0xFF667EEA), totalMinutes: 210),
    durationMinutes: 4320,
    startTime: _now.subtract(const Duration(days: 10)),
    endTime: _now.subtract(const Duration(days: 7)),
    status: DuelStatus.completed,
    winnerId: 'u6',
    shareCode: 'DUEL-MR2T',
  ),
  Duel(
    id: 'd5',
    player1: const DuelPlayer(userId: 'user1', name: 'Eren', avatarColor: Color(0xFF667EEA), totalMinutes: 120),
    player2: const DuelPlayer(userId: 'u5', name: 'Selin', avatarColor: AppColors.neonOrange, totalMinutes: 185),
    durationMinutes: 1440,
    startTime: _now.subtract(const Duration(days: 14)),
    endTime: _now.subtract(const Duration(days: 13)),
    status: DuelStatus.completed,
    winnerId: 'user1',
    shareCode: 'DUEL-SL5W',
  ),
];

class DuelNotifier extends StateNotifier<List<Duel>> {
  DuelNotifier() : super(_mockDuels);

  List<Duel> get activeDuels => state.where((d) => d.status == DuelStatus.active).toList();
  List<Duel> get completedDuels => state.where((d) => d.status == DuelStatus.completed).toList();
}

final duelProvider = StateNotifierProvider<DuelNotifier, List<Duel>>(
  (ref) => DuelNotifier(),
);
