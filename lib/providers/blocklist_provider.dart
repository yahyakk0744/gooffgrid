import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/theme.dart';
import '../models/blocklist.dart';

const _kPrefsKey = 'gooffgrid_blocklists';

// ---------------------------------------------------------------------------
// JSON helpers (Blocklist has no toJson/fromJson, so we handle it here)
// ---------------------------------------------------------------------------

Map<String, dynamic> _blocklistToJson(Blocklist b) => {
      'id': b.id,
      'name': b.name,
      'emoji': b.emoji,
      'color': b.color.toARGB32(),
      'appIds': b.appIds,
      'isDefault': b.isDefault,
    };

Blocklist _blocklistFromJson(Map<String, dynamic> m) => Blocklist(
      id: m['id'] as String,
      name: m['name'] as String,
      emoji: m['emoji'] as String,
      color: Color(m['color'] as int),
      appIds: List<String>.from(m['appIds'] as List),
      isDefault: (m['isDefault'] as bool?) ?? false,
    );

// ---------------------------------------------------------------------------
// Default seed blocklists (used when SharedPreferences is empty)
// ---------------------------------------------------------------------------

final _seed = <Blocklist>[
  const Blocklist(
    id: 'social',
    name: 'Sosyal Medya',
    emoji: '📱',
    color: AppColors.neonOrange,
    appIds: ['instagram', 'tiktok', 'twitter', 'facebook', 'snapchat'],
    isDefault: true,
  ),
  const Blocklist(
    id: 'entertainment',
    name: 'Eğlence',
    emoji: '🎬',
    color: Color(0xFF4FACFE),
    appIds: ['youtube', 'netflix', 'twitch', 'spotify'],
    isDefault: true,
  ),
  const Blocklist(
    id: 'games',
    name: 'Oyunlar',
    emoji: '🎮',
    color: Color(0xFFA8EB12),
    appIds: ['games'],
    isDefault: true,
  ),
  const Blocklist(
    id: 'all',
    name: 'Her Şey',
    emoji: '🔒',
    color: Color(0xFFFF4040),
    appIds: ['*'],
    isDefault: true,
  ),
];

// ---------------------------------------------------------------------------
// Notifier
// ---------------------------------------------------------------------------

class BlocklistNotifier extends StateNotifier<List<Blocklist>> {
  BlocklistNotifier(this._prefs) : super(_load(_prefs));

  final SharedPreferences _prefs;

  /// Load from SharedPreferences; fall back to seed defaults if nothing saved.
  static List<Blocklist> _load(SharedPreferences prefs) {
    final raw = prefs.getString(_kPrefsKey);
    if (raw == null || raw.isEmpty) return List.of(_seed);
    try {
      final list = jsonDecode(raw) as List<dynamic>;
      return list
          .map((e) => _blocklistFromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return List.of(_seed);
    }
  }

  Future<void> _persist() async {
    final encoded = jsonEncode(state.map(_blocklistToJson).toList());
    await _prefs.setString(_kPrefsKey, encoded);
  }

  Future<void> add(Blocklist b) async {
    state = [...state, b];
    await _persist();
  }

  Future<void> update(Blocklist b) async {
    state = [for (final x in state) if (x.id == b.id) b else x];
    await _persist();
  }

  Future<void> remove(String id) async {
    final target = state.firstWhere(
      (x) => x.id == id,
      orElse: () => const Blocklist(
        id: '',
        name: '',
        emoji: '',
        color: Colors.transparent,
        appIds: [],
      ),
    );
    if (target.isDefault) return; // default'lar silinmez
    state = state.where((x) => x.id != id).toList();
    await _persist();
  }

  Blocklist? byId(String? id) {
    if (id == null) return null;
    for (final b in state) {
      if (b.id == id) return b;
    }
    return null;
  }
}

// ---------------------------------------------------------------------------
// Provider
// ---------------------------------------------------------------------------

/// Must be overridden at app start after SharedPreferences is ready.
/// Use [blocklistProvider] for normal access.
final sharedPrefsProvider = Provider<SharedPreferences>(
  (_) => throw UnimplementedError('Override sharedPrefsProvider in ProviderScope'),
);

final blocklistProvider =
    StateNotifierProvider<BlocklistNotifier, List<Blocklist>>((ref) {
  final prefs = ref.watch(sharedPrefsProvider);
  return BlocklistNotifier(prefs);
});
