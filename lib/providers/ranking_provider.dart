import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gooffgrid/models/ranking_entry.dart';

enum RankingScope { friends, city, country, global, age, season }

final _friends = [
  const RankingEntry(rank: 1, userId: 'u2', name: 'Aylin', avatarColor: Color(0xFFF093FB), level: 7, totalMinutes: 95, change: 2),
  const RankingEntry(rank: 2, userId: 'u3', name: 'Deniz', avatarColor: Color(0xFF4FACFE), level: 6, totalMinutes: 132, change: 1),
  const RankingEntry(rank: 3, userId: 'u4', name: 'Burak', avatarColor: Color(0xFFA8EB12), level: 5, totalMinutes: 156, change: -1),
  const RankingEntry(rank: 4, userId: 'user1', name: 'Eren (SEN)', avatarColor: Color(0xFF667EEA), level: 5, totalMinutes: 204, change: 0),
  const RankingEntry(rank: 5, userId: 'u5', name: 'Selin', avatarColor: Color(0xFFFF6B00), level: 4, totalMinutes: 210, change: -2),
  const RankingEntry(rank: 6, userId: 'u6', name: 'Mert', avatarColor: Color(0xFF30D158), level: 4, totalMinutes: 267, change: 1),
  const RankingEntry(rank: 7, userId: 'u7', name: 'Zeynep', avatarColor: Color(0xFFFF453A), level: 3, totalMinutes: 289, change: -1),
  const RankingEntry(rank: 8, userId: 'u8', name: 'Ozan', avatarColor: Color(0xFFFFD700), level: 2, totalMinutes: 358, change: 0),
];

final _city = [
  const RankingEntry(rank: 1, userId: 'c1', name: 'Cemre', avatarColor: Color(0xFF764BA2), level: 9, totalMinutes: 52, change: 0),
  const RankingEntry(rank: 2, userId: 'c2', name: 'Baran', avatarColor: Color(0xFF4FACFE), level: 8, totalMinutes: 68, change: 3),
  const RankingEntry(rank: 3, userId: 'c3', name: 'Elif', avatarColor: Color(0xFFF5576C), level: 8, totalMinutes: 74, change: -1),
  const RankingEntry(rank: 4, userId: 'c4', name: 'Kaan', avatarColor: Color(0xFFA8EB12), level: 7, totalMinutes: 89, change: 1),
  const RankingEntry(rank: 5, userId: 'u2', name: 'Aylin', avatarColor: Color(0xFFF093FB), level: 7, totalMinutes: 95, change: 2),
  const RankingEntry(rank: 6, userId: 'c5', name: 'Defne', avatarColor: Color(0xFF00F2FE), level: 7, totalMinutes: 101, change: -2),
  const RankingEntry(rank: 7, userId: 'c6', name: 'Arda', avatarColor: Color(0xFFFF9F0A), level: 6, totalMinutes: 118, change: 0),
  const RankingEntry(rank: 8, userId: 'u3', name: 'Deniz', avatarColor: Color(0xFF4FACFE), level: 6, totalMinutes: 132, change: 1),
  const RankingEntry(rank: 9, userId: 'c7', name: 'Pinar', avatarColor: Color(0xFF667EEA), level: 6, totalMinutes: 145, change: -1),
  const RankingEntry(rank: 10, userId: 'u4', name: 'Burak', avatarColor: Color(0xFFA8EB12), level: 5, totalMinutes: 156, change: -1),
  const RankingEntry(rank: 11, userId: 'c8', name: 'Yigit', avatarColor: Color(0xFF30D158), level: 5, totalMinutes: 178, change: 2),
  const RankingEntry(rank: 12, userId: 'c9', name: 'Irem', avatarColor: Color(0xFFF093FB), level: 5, totalMinutes: 192, change: 0),
  const RankingEntry(rank: 13, userId: 'user1', name: 'Eren (SEN)', avatarColor: Color(0xFF667EEA), level: 5, totalMinutes: 204, change: 3),
  const RankingEntry(rank: 14, userId: 'u5', name: 'Selin', avatarColor: Color(0xFFFF6B00), level: 4, totalMinutes: 210, change: -2),
  const RankingEntry(rank: 15, userId: 'c10', name: 'Ege', avatarColor: Color(0xFF1DA1F2), level: 4, totalMinutes: 235, change: 1),
  const RankingEntry(rank: 16, userId: 'c11', name: 'Naz', avatarColor: Color(0xFFE1306C), level: 4, totalMinutes: 248, change: -1),
  const RankingEntry(rank: 17, userId: 'u6', name: 'Mert', avatarColor: Color(0xFF30D158), level: 4, totalMinutes: 267, change: 1),
  const RankingEntry(rank: 18, userId: 'c12', name: 'Ceren', avatarColor: Color(0xFFFF453A), level: 3, totalMinutes: 280, change: 0),
  const RankingEntry(rank: 19, userId: 'u7', name: 'Zeynep', avatarColor: Color(0xFFFF453A), level: 3, totalMinutes: 289, change: -1),
  const RankingEntry(rank: 20, userId: 'u8', name: 'Ozan', avatarColor: Color(0xFFFFD700), level: 2, totalMinutes: 358, change: 0),
];

final _country = [
  const RankingEntry(rank: 1, userId: 't1', name: 'Alp', avatarColor: Color(0xFFA8EB12), level: 10, totalMinutes: 28, change: 0),
  const RankingEntry(rank: 2, userId: 't2', name: 'Hazal', avatarColor: Color(0xFFF093FB), level: 10, totalMinutes: 35, change: 1),
  const RankingEntry(rank: 3, userId: 't3', name: 'Kerem', avatarColor: Color(0xFF4FACFE), level: 9, totalMinutes: 41, change: -1),
  const RankingEntry(rank: 4, userId: 't4', name: 'Dilan', avatarColor: Color(0xFFFF6B00), level: 9, totalMinutes: 49, change: 2),
  const RankingEntry(rank: 5, userId: 'c1', name: 'Cemre', avatarColor: Color(0xFF764BA2), level: 9, totalMinutes: 52, change: 0),
  const RankingEntry(rank: 6, userId: 't5', name: 'Toprak', avatarColor: Color(0xFF30D158), level: 9, totalMinutes: 58, change: -2),
  const RankingEntry(rank: 7, userId: 't6', name: 'Asya', avatarColor: Color(0xFFF5576C), level: 8, totalMinutes: 63, change: 1),
  const RankingEntry(rank: 8, userId: 't7', name: 'Doruk', avatarColor: Color(0xFF00F2FE), level: 8, totalMinutes: 70, change: 0),
  const RankingEntry(rank: 9, userId: 't8', name: 'Melisa', avatarColor: Color(0xFFE1306C), level: 8, totalMinutes: 76, change: -1),
  const RankingEntry(rank: 10, userId: 't9', name: 'Atlas', avatarColor: Color(0xFF1DA1F2), level: 8, totalMinutes: 82, change: 3),
  const RankingEntry(rank: 11, userId: 't10', name: 'Lina', avatarColor: Color(0xFFFF9F0A), level: 7, totalMinutes: 91, change: 0),
  const RankingEntry(rank: 12, userId: 't11', name: 'Ruzgar', avatarColor: Color(0xFF667EEA), level: 7, totalMinutes: 98, change: 1),
  const RankingEntry(rank: 13, userId: 't12', name: 'Nehir', avatarColor: Color(0xFFA8EB12), level: 7, totalMinutes: 105, change: -1),
  const RankingEntry(rank: 14, userId: 't13', name: 'Cinar', avatarColor: Color(0xFF764BA2), level: 6, totalMinutes: 120, change: 2),
  const RankingEntry(rank: 15, userId: 't14', name: 'Ada', avatarColor: Color(0xFFF093FB), level: 6, totalMinutes: 135, change: 0),
  const RankingEntry(rank: 16, userId: 't15', name: 'Aras', avatarColor: Color(0xFF4FACFE), level: 6, totalMinutes: 148, change: -2),
  const RankingEntry(rank: 17, userId: 't16', name: 'Masal', avatarColor: Color(0xFFFF453A), level: 5, totalMinutes: 165, change: 1),
  const RankingEntry(rank: 18, userId: 't17', name: 'Eylul', avatarColor: Color(0xFF30D158), level: 5, totalMinutes: 182, change: 0),
  const RankingEntry(rank: 19, userId: 'user1', name: 'Eren (SEN)', avatarColor: Color(0xFF667EEA), level: 5, totalMinutes: 204, change: 5),
  const RankingEntry(rank: 20, userId: 't18', name: 'Demir', avatarColor: Color(0xFFFF6B00), level: 5, totalMinutes: 215, change: -1),
];

final _global = [
  const RankingEntry(rank: 1, userId: 'g1', name: 'Sakura', avatarColor: Color(0xFFF093FB), level: 10, totalMinutes: 18, change: 0),
  const RankingEntry(rank: 2, userId: 'g2', name: 'Finn', avatarColor: Color(0xFF4FACFE), level: 10, totalMinutes: 22, change: 1),
  const RankingEntry(rank: 3, userId: 'g3', name: 'Priya', avatarColor: Color(0xFFFF6B00), level: 10, totalMinutes: 25, change: -1),
  const RankingEntry(rank: 4, userId: 'g4', name: 'Mateo', avatarColor: Color(0xFFA8EB12), level: 10, totalMinutes: 29, change: 0),
  const RankingEntry(rank: 5, userId: 'g5', name: 'Yuki', avatarColor: Color(0xFF764BA2), level: 10, totalMinutes: 31, change: 2),
  const RankingEntry(rank: 6, userId: 'g6', name: 'Liam', avatarColor: Color(0xFF30D158), level: 9, totalMinutes: 38, change: -1),
  const RankingEntry(rank: 7, userId: 'g7', name: 'Zara', avatarColor: Color(0xFFF5576C), level: 9, totalMinutes: 42, change: 0),
  const RankingEntry(rank: 8, userId: 'g8', name: 'Noah', avatarColor: Color(0xFF00F2FE), level: 9, totalMinutes: 47, change: 1),
  const RankingEntry(rank: 9, userId: 'g9', name: 'Aiko', avatarColor: Color(0xFFE1306C), level: 9, totalMinutes: 50, change: -2),
  const RankingEntry(rank: 10, userId: 'g10', name: 'Leo', avatarColor: Color(0xFF1DA1F2), level: 9, totalMinutes: 55, change: 3),
  const RankingEntry(rank: 11, userId: 'g11', name: 'Mia', avatarColor: Color(0xFFFF9F0A), level: 8, totalMinutes: 62, change: 0),
  const RankingEntry(rank: 12, userId: 'g12', name: 'Kai', avatarColor: Color(0xFF667EEA), level: 8, totalMinutes: 70, change: 1),
  const RankingEntry(rank: 13, userId: 'g13', name: 'Sofia', avatarColor: Color(0xFFA8EB12), level: 8, totalMinutes: 78, change: -1),
  const RankingEntry(rank: 14, userId: 'g14', name: 'Omar', avatarColor: Color(0xFF764BA2), level: 8, totalMinutes: 85, change: 0),
  const RankingEntry(rank: 15, userId: 'g15', name: 'Elena', avatarColor: Color(0xFFF093FB), level: 7, totalMinutes: 95, change: 2),
  const RankingEntry(rank: 16, userId: 'g16', name: 'Ravi', avatarColor: Color(0xFF4FACFE), level: 7, totalMinutes: 110, change: -1),
  const RankingEntry(rank: 17, userId: 'g17', name: 'Hana', avatarColor: Color(0xFFFF453A), level: 7, totalMinutes: 125, change: 1),
  const RankingEntry(rank: 18, userId: 'g18', name: 'Lucas', avatarColor: Color(0xFF30D158), level: 6, totalMinutes: 145, change: 0),
  const RankingEntry(rank: 19, userId: 'g19', name: 'Mei', avatarColor: Color(0xFFFF6B00), level: 6, totalMinutes: 170, change: -2),
  const RankingEntry(rank: 20, userId: 'user1', name: 'Eren (SEN)', avatarColor: Color(0xFF667EEA), level: 5, totalMinutes: 204, change: 8),
];

final _age = [
  const RankingEntry(rank: 1, userId: 'a1', name: 'Ilayda', avatarColor: Color(0xFFF093FB), level: 9, totalMinutes: 38, change: 1),
  const RankingEntry(rank: 2, userId: 'a2', name: 'Berk', avatarColor: Color(0xFF4FACFE), level: 8, totalMinutes: 52, change: 0),
  const RankingEntry(rank: 3, userId: 'a3', name: 'Beril', avatarColor: Color(0xFFA8EB12), level: 8, totalMinutes: 65, change: 2),
  const RankingEntry(rank: 4, userId: 'a4', name: 'Emre', avatarColor: Color(0xFF764BA2), level: 7, totalMinutes: 78, change: -1),
  const RankingEntry(rank: 5, userId: 'a5', name: 'Melis', avatarColor: Color(0xFFFF6B00), level: 7, totalMinutes: 88, change: 0),
  const RankingEntry(rank: 6, userId: 'u2', name: 'Aylin', avatarColor: Color(0xFFF093FB), level: 7, totalMinutes: 95, change: 2),
  const RankingEntry(rank: 7, userId: 'a6', name: 'Tuna', avatarColor: Color(0xFF30D158), level: 6, totalMinutes: 108, change: -2),
  const RankingEntry(rank: 8, userId: 'a7', name: 'Nil', avatarColor: Color(0xFFF5576C), level: 6, totalMinutes: 122, change: 1),
  const RankingEntry(rank: 9, userId: 'u3', name: 'Deniz', avatarColor: Color(0xFF4FACFE), level: 6, totalMinutes: 132, change: 1),
  const RankingEntry(rank: 10, userId: 'a8', name: 'Can', avatarColor: Color(0xFF00F2FE), level: 6, totalMinutes: 142, change: -1),
  const RankingEntry(rank: 11, userId: 'u4', name: 'Burak', avatarColor: Color(0xFFA8EB12), level: 5, totalMinutes: 156, change: -1),
  const RankingEntry(rank: 12, userId: 'a9', name: 'Duru', avatarColor: Color(0xFFE1306C), level: 5, totalMinutes: 170, change: 0),
  const RankingEntry(rank: 13, userId: 'a10', name: 'Utku', avatarColor: Color(0xFF1DA1F2), level: 5, totalMinutes: 185, change: 2),
  const RankingEntry(rank: 14, userId: 'user1', name: 'Eren (SEN)', avatarColor: Color(0xFF667EEA), level: 5, totalMinutes: 204, change: 4),
  const RankingEntry(rank: 15, userId: 'u5', name: 'Selin', avatarColor: Color(0xFFFF6B00), level: 4, totalMinutes: 210, change: -2),
  const RankingEntry(rank: 16, userId: 'a11', name: 'Yaren', avatarColor: Color(0xFFFF9F0A), level: 4, totalMinutes: 230, change: 1),
  const RankingEntry(rank: 17, userId: 'a12', name: 'Efe', avatarColor: Color(0xFF667EEA), level: 4, totalMinutes: 252, change: 0),
  const RankingEntry(rank: 18, userId: 'u6', name: 'Mert', avatarColor: Color(0xFF30D158), level: 4, totalMinutes: 267, change: 1),
  const RankingEntry(rank: 19, userId: 'u7', name: 'Zeynep', avatarColor: Color(0xFFFF453A), level: 3, totalMinutes: 289, change: -1),
  const RankingEntry(rank: 20, userId: 'u8', name: 'Ozan', avatarColor: Color(0xFFFFD700), level: 2, totalMinutes: 358, change: 0),
];

final _rankingData = {
  RankingScope.friends: _friends,
  RankingScope.city: _city,
  RankingScope.country: _country,
  RankingScope.global: _global,
  RankingScope.age: _age,
  RankingScope.season: _friends, // placeholder: reuse friends data for season
};

class RankingScopeState {
  final RankingScope scope;
  final List<RankingEntry> entries;

  const RankingScopeState({required this.scope, required this.entries});
}

class RankingNotifier extends StateNotifier<RankingScopeState> {
  RankingNotifier()
      : super(RankingScopeState(
          scope: RankingScope.friends,
          entries: _rankingData[RankingScope.friends]!,
        ));

  void setScope(RankingScope scope) {
    state = RankingScopeState(scope: scope, entries: _rankingData[scope]!);
  }
}

final rankingProvider = StateNotifierProvider<RankingNotifier, RankingScopeState>(
  (ref) => RankingNotifier(),
);

/// Alias for screens that reference RankingTab
typedef RankingTab = RankingScope;

/// State provider for active ranking tab
final rankingTabProvider = StateProvider<RankingScope>((ref) => RankingScope.friends);

/// Derived provider: user's rank among friends
final userFriendRankProvider = Provider<int>((ref) {
  final idx = _friends.indexWhere((e) => e.userId == 'user1');
  return idx >= 0 ? idx + 1 : _friends.length;
});

/// Derived provider: user's rank in city
final userCityRankProvider = Provider<int>((ref) {
  final idx = _city.indexWhere((e) => e.userId == 'user1');
  return idx >= 0 ? idx + 1 : _city.length;
});

/// Derived provider: user's rank in country
final userCountryRankProvider = Provider<int>((ref) {
  final idx = _country.indexWhere((e) => e.userId == 'user1');
  return idx >= 0 ? idx + 1 : _country.length;
});
