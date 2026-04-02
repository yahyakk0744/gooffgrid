import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/xp_service.dart';

/// Current user's XP state.
final xpProvider = FutureProvider<XpState>((ref) async {
  try {
    final client = Supabase.instance.client;
    final userId = client.auth.currentUser?.id;
    if (userId == null) return XpState.demo();

    final profile = await client
        .from('profiles')
        .select('total_xp, level')
        .eq('id', userId)
        .single();

    return XpState(
      totalXp: profile['total_xp'] as int? ?? 0,
      level: profile['level'] as int? ?? 1,
    );
  } catch (_) {
    return XpState.demo();
  }
});

/// XP history (recent transactions).
final xpHistoryProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  return XpService.instance.getXpHistory();
});
