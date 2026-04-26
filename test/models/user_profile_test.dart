import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gooffgrid/models/user_profile.dart';

void main() {
  group('UserProfile', () {
    final fixed = DateTime.utc(2026, 4, 26, 12, 0, 0);

    UserProfile sample({int level = 5, int totalPoints = 1200}) => UserProfile(
          id: 'u1',
          name: 'Hizir',
          avatarColor: const Color(0xFF00FF88),
          city: 'Istanbul',
          country: 'TR',
          ageGroup: '25-34',
          level: level,
          title: 'Dijital Diyetçi',
          streak: 7,
          bestStreak: 14,
          totalPoints: totalPoints,
          createdAt: fixed,
          freezeTokens: 2,
          lastFreezeAwardedAt: fixed,
        );

    test('toJson/fromJson round-trip preserves all fields', () {
      final original = sample();
      final json = original.toJson();
      final decoded = UserProfile.fromJson(json);

      expect(decoded.id, original.id);
      expect(decoded.name, original.name);
      expect(decoded.avatarColor.toARGB32(), original.avatarColor.toARGB32());
      expect(decoded.city, original.city);
      expect(decoded.country, original.country);
      expect(decoded.ageGroup, original.ageGroup);
      expect(decoded.level, original.level);
      expect(decoded.title, original.title);
      expect(decoded.streak, original.streak);
      expect(decoded.bestStreak, original.bestStreak);
      expect(decoded.totalPoints, original.totalPoints);
      expect(decoded.createdAt, original.createdAt);
      expect(decoded.freezeTokens, original.freezeTokens);
      expect(decoded.lastFreezeAwardedAt, original.lastFreezeAwardedAt);
    });

    test('levelProgress is 0 at threshold start', () {
      // level 5 starts at 1500 points (per _pointsPerLevel[5] table)
      final p = sample(level: 5, totalPoints: 1500);
      expect(p.levelProgress, 0.0);
    });

    test('levelProgress is mid-range between thresholds', () {
      // level 5 -> 6 spans 1500..2200; 1850 is exactly halfway
      final p = sample(level: 5, totalPoints: 1850);
      expect(p.levelProgress, closeTo(0.5, 0.001));
    });

    test('levelProgress is clamped to 1.0 at max level', () {
      final p = sample(level: 10, totalPoints: 99999);
      expect(p.levelProgress, 1.0);
    });

    test('levelProgress is clamped (cannot go below 0)', () {
      // edge case: totalPoints below current level threshold (data drift)
      final p = sample(level: 5, totalPoints: 500);
      expect(p.levelProgress, 0.0);
    });

    test('copyWith updates only provided fields', () {
      final original = sample();
      final updated = original.copyWith(streak: 30);

      expect(updated.streak, 30);
      expect(updated.bestStreak, original.bestStreak);
      expect(updated.id, original.id);
      expect(updated.totalPoints, original.totalPoints);
    });

    test('freezeTokens defaults to 0 when missing in JSON', () {
      final json = sample().toJson()..remove('freezeTokens');
      final decoded = UserProfile.fromJson(json);
      expect(decoded.freezeTokens, 0);
    });

    test('lastFreezeAwardedAt is nullable in JSON', () {
      final json = sample().toJson()..['lastFreezeAwardedAt'] = null;
      final decoded = UserProfile.fromJson(json);
      expect(decoded.lastFreezeAwardedAt, null);
    });

    test('maxFreezeTokens constant is 3', () {
      expect(UserProfile.maxFreezeTokens, 3);
    });

    test('levelTitles maps level 5 to "Dijital Diyetçi"', () {
      expect(UserProfile.levelTitles[5], 'Dijital Diyetçi');
    });

    test('levelTitles covers all 10 levels', () {
      for (var i = 1; i <= 10; i++) {
        expect(UserProfile.levelTitles[i], isNotNull, reason: 'level $i missing');
      }
    });
  });
}
