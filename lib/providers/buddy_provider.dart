import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Accountability Buddy — eş-kilit. Two users pair up; missing a day triggers
/// a nudge to the buddy. Also shared streak bonus (+25% O₂ during paired
/// streak).
///
/// This is a client-side stub: real backend pairing + push notifications
/// are TODO. UI can exercise the full state machine against SharedPreferences.
@immutable
class BuddyPair {
  const BuddyPair({
    required this.buddyId,
    required this.buddyName,
    required this.pairedAt,
    required this.sharedStreak,
    this.lastBuddyActiveAt,
    this.status = BuddyStatus.active,
  });

  final String buddyId;
  final String buddyName;
  final DateTime pairedAt;
  final int sharedStreak;
  final DateTime? lastBuddyActiveAt;
  final BuddyStatus status;

  BuddyPair copyWith({
    int? sharedStreak,
    DateTime? lastBuddyActiveAt,
    BuddyStatus? status,
  }) =>
      BuddyPair(
        buddyId: buddyId,
        buddyName: buddyName,
        pairedAt: pairedAt,
        sharedStreak: sharedStreak ?? this.sharedStreak,
        lastBuddyActiveAt: lastBuddyActiveAt ?? this.lastBuddyActiveAt,
        status: status ?? this.status,
      );

  Map<String, dynamic> toJson() => {
        'buddyId': buddyId,
        'buddyName': buddyName,
        'pairedAt': pairedAt.toIso8601String(),
        'sharedStreak': sharedStreak,
        'lastBuddyActiveAt': lastBuddyActiveAt?.toIso8601String(),
        'status': status.name,
      };

  factory BuddyPair.fromJson(Map<String, dynamic> j) => BuddyPair(
        buddyId: j['buddyId'] as String,
        buddyName: j['buddyName'] as String,
        pairedAt: DateTime.parse(j['pairedAt'] as String),
        sharedStreak: j['sharedStreak'] as int? ?? 0,
        lastBuddyActiveAt: j['lastBuddyActiveAt'] != null
            ? DateTime.parse(j['lastBuddyActiveAt'] as String)
            : null,
        status: BuddyStatus.values.firstWhere(
          (s) => s.name == j['status'],
          orElse: () => BuddyStatus.active,
        ),
      );
}

enum BuddyStatus { pendingInvite, active, broken }

class BuddyNotifier extends StateNotifier<BuddyPair?> {
  BuddyNotifier() : super(null) {
    _load();
  }

  static const _prefsKey = 'buddy_pair';

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_prefsKey);
    if (raw == null) return;
    try {
      // Deserialize
      final parts = raw.split('|');
      if (parts.length < 4) return;
      state = BuddyPair(
        buddyId: parts[0],
        buddyName: parts[1],
        pairedAt: DateTime.parse(parts[2]),
        sharedStreak: int.tryParse(parts[3]) ?? 0,
        status: BuddyStatus.active,
      );
    } catch (_) {
      // ignore malformed
    }
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    final pair = state;
    if (pair == null) {
      await prefs.remove(_prefsKey);
    } else {
      final encoded =
          '${pair.buddyId}|${pair.buddyName}|${pair.pairedAt.toIso8601String()}|${pair.sharedStreak}';
      await prefs.setString(_prefsKey, encoded);
    }
  }

  /// Send invite / instantly pair (stub — real flow needs server-side handshake).
  Future<void> pairWith(String friendId, String friendName) async {
    state = BuddyPair(
      buddyId: friendId,
      buddyName: friendName,
      pairedAt: DateTime.now(),
      sharedStreak: 0,
      status: BuddyStatus.active,
    );
    await _save();
  }

  Future<void> unpair() async {
    state = null;
    await _save();
  }

  Future<void> incrementSharedStreak() async {
    final current = state;
    if (current == null) return;
    state = current.copyWith(sharedStreak: current.sharedStreak + 1);
    await _save();
  }
}

final buddyProvider =
    StateNotifierProvider<BuddyNotifier, BuddyPair?>((ref) => BuddyNotifier());

/// Whether currently viewed friend is the active buddy.
final isBuddyProvider = Provider.family<bool, String>((ref, friendId) {
  final b = ref.watch(buddyProvider);
  return b?.buddyId == friendId;
});
