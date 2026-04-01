import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/o2_transaction.dart';

/// O2 Ekonomisi Supabase servisi.
/// Anti-cheat kuralları sunucu tarafında uygulanır (earn_o2 fonksiyonu).
class O2Service {
  O2Service._();
  static final instance = O2Service._();

  SupabaseClient get _db => Supabase.instance.client;
  String? get _uid => _db.auth.currentUser?.id;

  // ──────────────────────────────────────────────
  // BAKİYE
  // ──────────────────────────────────────────────

  /// Mevcut O2 bakiyesi.
  Future<int> getBalance() async {
    if (_uid == null) return 0;
    final res = await _db.from('profiles').select('o2_balance').eq('id', _uid!).single();
    return res['o2_balance'] as int? ?? 0;
  }

  /// Toplam kazanılan O2 (lifetime).
  Future<int> getLifetimeO2() async {
    if (_uid == null) return 0;
    final res = await _db.from('profiles').select('o2_lifetime').eq('id', _uid!).single();
    return res['o2_lifetime'] as int? ?? 0;
  }

  /// Bugün kazanılan O2.
  Future<int> getTodayEarned() async {
    if (_uid == null) return 0;
    final res = await _db
        .from('o2_transactions')
        .select('amount')
        .eq('user_id', _uid!)
        .eq('date', _todayStr())
        .gt('amount', 0);
    return (res as List).fold<int>(0, (sum, r) => sum + (r['amount'] as int));
  }

  // ──────────────────────────────────────────────
  // O2 KAZANIM (Sunucu tarafı anti-cheat)
  // ──────────────────────────────────────────────

  /// O2 kazan — sunucudaki earn_o2 fonksiyonunu çağırır.
  /// Anti-cheat kuralları (saat, günlük tavan) sunucuda uygulanır.
  Future<O2EarnResult> earnO2({
    required int amount,
    required String type,
    String? description,
    Map<String, dynamic>? metadata,
  }) async {
    if (_uid == null) return O2EarnResult.error('not_logged_in');
    try {
      final res = await _db.rpc('earn_o2', params: {
        'p_user_id': _uid,
        'p_amount': amount,
        'p_type': type,
        'p_description': description,
        'p_metadata': metadata,
      });

      final data = Map<String, dynamic>.from(res as Map);
      if (data['success'] == true) {
        return O2EarnResult(
          success: true,
          earned: data['earned'] as int? ?? 0,
          newBalance: data['new_balance'] as int? ?? 0,
          dailyTotal: data['daily_total'] as int? ?? 0,
          dailyRemaining: data['daily_remaining'] as int? ?? 0,
        );
      } else {
        return O2EarnResult.error(data['error'] as String? ?? 'unknown');
      }
    } catch (e) {
      debugPrint('earnO2 error: $e');
      return O2EarnResult.error(e.toString());
    }
  }

  // ──────────────────────────────────────────────
  // FOCUS SESSIONS
  // ──────────────────────────────────────────────

  /// Odak oturumu başlat.
  Future<String?> startFocusSession() async {
    if (_uid == null) return null;

    // Anti-cheat: Saat kontrolü (client-side ön kontrol, sunucu da kontrol eder)
    final now = DateTime.now();
    if (now.hour < 8) return null; // 08:00 öncesi yasak

    try {
      final res = await _db.from('focus_sessions').insert({
        'user_id': _uid,
        'date': _todayStr(),
      }).select('id').single();
      return res['id'] as String;
    } catch (e) {
      debugPrint('startFocusSession error: $e');
      return null;
    }
  }

  /// Odak oturumu bitir — sunucu O2 hesaplar.
  Future<FocusResult> completeFocusSession(String sessionId) async {
    if (_uid == null) return FocusResult.error('not_logged_in');
    try {
      final res = await _db.rpc('complete_focus_session', params: {
        'p_session_id': sessionId,
        'p_user_id': _uid,
      });

      final data = Map<String, dynamic>.from(res as Map);
      if (data['success'] == true) {
        return FocusResult(
          success: true,
          minutes: data['minutes'] as int? ?? 0,
          o2Earned: data['o2_earned'] as int? ?? 0,
        );
      } else {
        return FocusResult(
          success: false,
          minutes: 0,
          o2Earned: 0,
          error: data['error'] as String?,
        );
      }
    } catch (e) {
      debugPrint('completeFocusSession error: $e');
      return FocusResult.error(e.toString());
    }
  }

  // ──────────────────────────────────────────────
  // MARKET
  // ──────────────────────────────────────────────

  /// Aktif market tekliflerini getir.
  Future<List<MarketOffer>> getMarketOffers({String? city}) async {
    try {
      var query = _db.from('market_offers').select().eq('is_active', true);
      if (city != null) {
        query = query.or('city.eq.$city,city.is.null');
      }
      final res = await query.order('o2_cost');
      return (res as List).map((e) => MarketOffer.fromJson(e)).toList();
    } catch (e) {
      debugPrint('getMarketOffers error: $e');
      return [];
    }
  }

  /// Teklif satın al (redeem).
  Future<RedeemResult> redeemOffer(String offerId) async {
    if (_uid == null) return RedeemResult.error('not_logged_in');
    try {
      final res = await _db.rpc('redeem_offer', params: {
        'p_user_id': _uid,
        'p_offer_id': offerId,
      });

      final data = Map<String, dynamic>.from(res as Map);
      if (data['success'] == true) {
        return RedeemResult(
          success: true,
          redeemCode: data['redeem_code'] as String? ?? '',
          o2Spent: data['o2_spent'] as int? ?? 0,
          newBalance: data['new_balance'] as int? ?? 0,
        );
      } else {
        return RedeemResult.error(data['error'] as String? ?? 'unknown');
      }
    } catch (e) {
      debugPrint('redeemOffer error: $e');
      return RedeemResult.error(e.toString());
    }
  }

  /// Kuponlarımı getir.
  Future<List<MarketRedemption>> getMyRedemptions() async {
    if (_uid == null) return [];
    final res = await _db
        .from('market_redemptions')
        .select()
        .eq('user_id', _uid!)
        .order('created_at', ascending: false);
    return (res as List).map((e) => MarketRedemption.fromJson(e)).toList();
  }

  // ──────────────────────────────────────────────
  // STORY ELİGİBİLİTY
  // ──────────────────────────────────────────────

  /// Kullanıcı story paylaşabilir mi? (Hedef altında mı?)
  Future<StoryEligibility> checkStoryEligibility() async {
    if (_uid == null) return StoryEligibility(eligible: false, minutes: 0, goal: 120);
    try {
      final res = await _db.rpc('check_story_eligibility', params: {
        'p_user_id': _uid,
      });
      final data = Map<String, dynamic>.from(res as Map);
      return StoryEligibility(
        eligible: data['eligible'] as bool? ?? false,
        minutes: data['minutes'] as int? ?? 0,
        goal: data['goal'] as int? ?? 120,
        message: data['message'] as String?,
      );
    } catch (e) {
      return StoryEligibility(eligible: false, minutes: 0, goal: 120);
    }
  }

  // ──────────────────────────────────────────────
  // TRANSACTİON GEÇMİŞİ
  // ──────────────────────────────────────────────

  Future<List<O2Transaction>> getTransactions({int limit = 50}) async {
    if (_uid == null) return [];
    final res = await _db
        .from('o2_transactions')
        .select()
        .eq('user_id', _uid!)
        .order('created_at', ascending: false)
        .limit(limit);
    return (res as List).map((e) => O2Transaction.fromJson(e)).toList();
  }

  String _todayStr() {
    final d = DateTime.now();
    return '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
  }
}

// ──────────────────────────────────────────────
// RESULT TYPES
// ──────────────────────────────────────────────

class O2EarnResult {
  final bool success;
  final int earned;
  final int newBalance;
  final int dailyTotal;
  final int dailyRemaining;
  final String? error;

  const O2EarnResult({
    this.success = false,
    this.earned = 0,
    this.newBalance = 0,
    this.dailyTotal = 0,
    this.dailyRemaining = 0,
    this.error,
  });

  factory O2EarnResult.error(String err) => O2EarnResult(error: err);
}

class FocusResult {
  final bool success;
  final int minutes;
  final int o2Earned;
  final String? error;

  const FocusResult({
    this.success = false,
    this.minutes = 0,
    this.o2Earned = 0,
    this.error,
  });

  factory FocusResult.error(String err) => FocusResult(error: err);
}

class RedeemResult {
  final bool success;
  final String redeemCode;
  final int o2Spent;
  final int newBalance;
  final String? error;

  const RedeemResult({
    this.success = false,
    this.redeemCode = '',
    this.o2Spent = 0,
    this.newBalance = 0,
    this.error,
  });

  factory RedeemResult.error(String err) => RedeemResult(error: err);
}

class StoryEligibility {
  final bool eligible;
  final int minutes;
  final int goal;
  final String? message;

  const StoryEligibility({
    required this.eligible,
    required this.minutes,
    required this.goal,
    this.message,
  });
}
