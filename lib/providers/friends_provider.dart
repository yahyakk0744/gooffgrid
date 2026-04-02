import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_profile.dart';

class FriendData {
  final UserProfile profile;
  final int todayMinutes;
  final bool isOnline;
  final String topApp;
  final int topAppMinutes;

  const FriendData({
    required this.profile,
    required this.todayMinutes,
    this.isOnline = false,
    required this.topApp,
    required this.topAppMinutes,
  });
}

final friendsProvider = Provider<List<FriendData>>((ref) {
  return [
    FriendData(
      profile: UserProfile(id: 'f1', name: 'Deniz', avatarColor: const Color(0xFFF093FB), city: 'Adana', country: 'Türkiye', ageGroup: '18-24', level: 7, title: 'Off-Grid Çırağı', streak: 12, bestStreak: 20, totalPoints: 2800, createdAt: DateTime(2025, 1, 10)),
      todayMinutes: 95, isOnline: true, topApp: 'Instagram', topAppMinutes: 30,
    ),
    FriendData(
      profile: UserProfile(id: 'f2', name: 'Berk', avatarColor: const Color(0xFF4FACFE), city: 'Adana', country: 'Türkiye', ageGroup: '18-24', level: 3, title: 'Scroll Asistanı', streak: 2, bestStreak: 5, totalPoints: 420, createdAt: DateTime(2025, 2, 1)),
      todayMinutes: 312, isOnline: false, topApp: 'TikTok', topAppMinutes: 120,
    ),
    FriendData(
      profile: UserProfile(id: 'f3', name: 'Selin', avatarColor: const Color(0xFFA8EB12), city: 'Istanbul', country: 'Türkiye', ageGroup: '25-34', level: 8, title: 'Dijital Detox Pro', streak: 21, bestStreak: 30, totalPoints: 3500, createdAt: DateTime(2024, 12, 1)),
      todayMinutes: 48, isOnline: true, topApp: 'WhatsApp', topAppMinutes: 20,
    ),
    FriendData(
      profile: UserProfile(id: 'f4', name: 'Can', avatarColor: const Color(0xFFFF6B00), city: 'Ankara', country: 'Türkiye', ageGroup: '18-24', level: 4, title: 'Farkında Gezgin', streak: 5, bestStreak: 9, totalPoints: 750, createdAt: DateTime(2025, 1, 20)),
      todayMinutes: 178, isOnline: false, topApp: 'YouTube', topAppMinutes: 65,
    ),
    FriendData(
      profile: UserProfile(id: 'f5', name: 'Elif', avatarColor: const Color(0xFFFF453A), city: 'İzmir', country: 'Türkiye', ageGroup: '25-34', level: 6, title: 'Ekran Savaşçısı', streak: 10, bestStreak: 15, totalPoints: 1800, createdAt: DateTime(2025, 1, 5)),
      todayMinutes: 110, isOnline: true, topApp: 'Twitter', topAppMinutes: 40,
    ),
    FriendData(
      profile: UserProfile(id: 'f6', name: 'Mert', avatarColor: const Color(0xFF30D158), city: 'Adana', country: 'Türkiye', ageGroup: '18-24', level: 2, title: 'Ekran Kelebeği', streak: 1, bestStreak: 3, totalPoints: 180, createdAt: DateTime(2025, 3, 1)),
      todayMinutes: 380, isOnline: false, topApp: 'Instagram', topAppMinutes: 150,
    ),
    FriendData(
      profile: UserProfile(id: 'f7', name: 'Zeynep', avatarColor: const Color(0xFF69C9D0), city: 'Bursa', country: 'Türkiye', ageGroup: '18-24', level: 5, title: 'Dijital Diyetçi', streak: 7, bestStreak: 12, totalPoints: 1100, createdAt: DateTime(2025, 1, 25)),
      todayMinutes: 145, isOnline: true, topApp: 'Reddit', topAppMinutes: 55,
    ),
    FriendData(
      profile: UserProfile(id: 'f8', name: 'Kaan', avatarColor: const Color(0xFFFFD700), city: 'Adana', country: 'Türkiye', ageGroup: '25-34', level: 9, title: 'Zaman Ustası', streak: 28, bestStreak: 45, totalPoints: 4800, createdAt: DateTime(2024, 11, 1)),
      todayMinutes: 32, isOnline: false, topApp: 'WhatsApp', topAppMinutes: 15,
    ),
  ];
});
