import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gooffgrid/models/user_profile.dart';

class UserNotifier extends StateNotifier<UserProfile> {
  UserNotifier()
      : super(UserProfile(
          id: 'user1',
          name: 'Eren',
          avatarColor: const Color(0xFF667EEA),
          city: 'Adana',
          country: 'Turkiye',
          ageGroup: '18-24',
          level: 5,
          title: 'Dijital Diyetci',
          streak: 8,
          bestStreak: 14,
          totalPoints: 1200,
          createdAt: DateTime(2025, 1, 15),
        ));

  void update(UserProfile profile) {
    state = profile;
  }
}

final userProvider = StateNotifierProvider<UserNotifier, UserProfile>(
  (ref) => UserNotifier(),
);
