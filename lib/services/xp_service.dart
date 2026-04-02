import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// XP Engine — Level & Badge sistemi.
/// SQL tarafındaki calculate_level, xp_for_next_level, cumulative_xp_for_level
/// fonksiyonlarının client-side aynası.
class XpService {
  static final instance = XpService._();
  XpService._();

  SupabaseClient get _client => Supabase.instance.client;
  String? get _uid => _client.auth.currentUser?.id;

  // ── XP Amounts ──
  static const focusXpPerMinute = 1; // max 120/session
  static const duelWinXp = 50;
  static const duelParticipateXp = 15;
  static const dailyGoalXp = 30;
  static const storyXp = 10;
  static const reactionXp = 2;
  static const referralXp = 200;
  static const firstTimeXp = 50;

  /// Streak XP: 10 * day (capped at 100)
  static int streakXp(int streakDay) => (10 * streakDay).clamp(10, 100);

  // ── Grant XP ──

  /// Grant XP to current user via server RPC.
  Future<XpResult> grantXp(int amount, String source, {String? description}) async {
    try {
      final userId = _uid;
      if (userId == null) return XpResult.mock(amount);

      final result = await _client.rpc('grant_xp', params: {
        'target_user_id': userId,
        'xp_amount': amount,
        'xp_source': source,
        'xp_description': description,
      });

      final row = (result as List).first;
      return XpResult(
        totalXp: row['new_total_xp'] as int,
        level: row['new_level'] as int,
        leveledUp: row['leveled_up'] as bool,
      );
    } catch (e) {
      debugPrint('grantXp error: $e');
      return XpResult.mock(amount);
    }
  }

  /// Get XP history for current user.
  Future<List<Map<String, dynamic>>> getXpHistory({int limit = 50}) async {
    if (_uid == null) return [];
    try {
      final res = await _client
          .from('user_xp')
          .select()
          .eq('user_id', _uid!)
          .order('created_at', ascending: false)
          .limit(limit);
      return List<Map<String, dynamic>>.from(res as List);
    } catch (e) {
      debugPrint('getXpHistory error: $e');
      return [];
    }
  }

  // ── Level Calculations (client-side mirror of SQL) ──

  /// Calculate level from total XP.
  static int calculateLevel(int xp) {
    int lvl = 1;
    int cumulative = 0;
    while (lvl < 999) {
      final needed = (100 * math.pow(lvl.toDouble(), 1.2)).floor();
      cumulative += needed;
      if (xp < cumulative) return lvl;
      lvl++;
    }
    return 999;
  }

  /// XP needed for current level -> next level.
  static int xpForNextLevel(int level) {
    return (100 * math.pow(level.toDouble(), 1.2)).floor();
  }

  /// Cumulative XP needed to reach a level.
  static int cumulativeXpForLevel(int level) {
    int total = 0;
    for (int i = 1; i < level; i++) {
      total += (100 * math.pow(i.toDouble(), 1.2)).floor();
    }
    return total;
  }

  /// Progress within current level (0.0 to 1.0).
  static double levelProgress(int totalXp, int level) {
    final levelStart = cumulativeXpForLevel(level);
    final levelEnd = levelStart + xpForNextLevel(level);
    if (levelEnd <= levelStart) return 1.0;
    return ((totalXp - levelStart) / (levelEnd - levelStart)).clamp(0.0, 1.0);
  }
}

// ── Result Types ──

class XpResult {
  final int totalXp;
  final int level;
  final bool leveledUp;

  const XpResult({
    required this.totalXp,
    required this.level,
    required this.leveledUp,
  });

  factory XpResult.mock(int amount) =>
      XpResult(totalXp: amount, level: 1, leveledUp: false);
}

class XpState {
  final int totalXp;
  final int level;

  const XpState({required this.totalXp, required this.level});

  factory XpState.demo() => const XpState(totalXp: 0, level: 1);

  double get progress => XpService.levelProgress(totalXp, level);
  int get xpForNext => XpService.xpForNextLevel(level);
  int get xpInCurrentLevel => totalXp - XpService.cumulativeXpForLevel(level);
}
