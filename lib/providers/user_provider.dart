import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_profile.dart';
import 'auth_provider.dart';

class UserNotifier extends StateNotifier<UserProfile> {
  UserNotifier(this._ref)
      : super(UserProfile(
          id: 'demo-user',
          name: 'Kullanıcı',
          avatarColor: const Color(0xFF667EEA),
          city: '',
          country: '',
          ageGroup: '18-24',
          level: 1,
          title: 'Dijital Bebek',
          streak: 0,
          bestStreak: 0,
          totalPoints: 0,
          createdAt: DateTime.now(),
        )) {
    _loadProfile();
  }

  final Ref _ref;

  Future<void> _loadProfile() async {
    final auth = _ref.read(authProvider);
    final userId = auth.userId;
    if (userId == null || userId == 'demo-user') {
      // Demo modda varsayılan profil kullan
      state = UserProfile(
        id: 'demo-user',
        name: 'Eren',
        avatarColor: const Color(0xFF667EEA),
        city: 'Adana',
        country: 'Türkiye',
        ageGroup: '18-24',
        level: 5,
        title: 'Dijital Diyetçi',
        streak: 8,
        bestStreak: 14,
        totalPoints: 1200,
        createdAt: DateTime(2025, 1, 15),
        freezeTokens: 2,
      );
      return;
    }

    try {
      final data = await Supabase.instance.client
          .from('profiles')
          .select()
          .eq('id', userId)
          .maybeSingle();

      if (data != null) {
        state = UserProfile(
          id: userId,
          name: data['display_name'] as String? ??
              data['username'] as String? ??
              'Kullanıcı',
          avatarColor: Color(
            data['avatar_color'] as int? ?? 0xFF667EEA,
          ),
          city: data['city'] as String? ?? '',
          country: data['country'] as String? ?? '',
          ageGroup: data['age_group'] as String? ?? '18-24',
          level: data['level'] as int? ?? 1,
          title: UserProfile.levelTitles[data['level'] as int? ?? 1] ??
              'Dijital Bebek',
          streak: data['streak'] as int? ?? 0,
          bestStreak: data['best_streak'] as int? ?? 0,
          totalPoints: data['total_points'] as int? ?? 0,
          createdAt: data['created_at'] != null
              ? DateTime.parse(data['created_at'] as String)
              : DateTime.now(),
          freezeTokens: data['freeze_tokens'] as int? ?? 0,
          lastFreezeAwardedAt: data['last_freeze_awarded_at'] != null
              ? DateTime.parse(data['last_freeze_awarded_at'] as String)
              : null,
        );
      }
    } catch (_) {
      // Supabase bağlantısı yoksa varsayılan profil kalır
    }
  }

  Future<void> refresh() async => _loadProfile();

  void update(UserProfile profile) {
    state = profile;
  }

  /// 7 aktif günde 1 token kazandır. Daha önce verildiyse idempotent.
  void maybeAwardFreezeToken() {
    final now = DateTime.now();
    final last = state.lastFreezeAwardedAt;
    final eligible = state.streak > 0 && state.streak % 7 == 0;
    final alreadyAwardedToday = last != null &&
        last.year == now.year &&
        last.month == now.month &&
        last.day == now.day;

    if (!eligible || alreadyAwardedToday) return;
    if (state.freezeTokens >= UserProfile.maxFreezeTokens) return;

    state = state.copyWith(
      freezeTokens: state.freezeTokens + 1,
      lastFreezeAwardedAt: now,
    );
  }

  /// Streak kırılacakken token harca. Harcanırsa true döner.
  bool tryConsumeFreeze() {
    if (state.freezeTokens <= 0) return false;
    state = state.copyWith(freezeTokens: state.freezeTokens - 1);
    return true;
  }
}

final userProvider = StateNotifierProvider<UserNotifier, UserProfile>(
  (ref) => UserNotifier(ref),
);
