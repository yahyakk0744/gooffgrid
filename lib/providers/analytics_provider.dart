import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/screen_time_data.dart';
import '../services/platform_screen_time_service.dart';
import 'screen_time_provider.dart';

/// Bugünün verisini native ikonlarla çeker (Android).
/// iOS'te ikonlar Platform View üzerinden gösterildiği için
/// normal detaylı veriyi döner.
final todayWithIconsProvider = FutureProvider<ScreenTimeData>((ref) async {
  final service = PlatformScreenTimeService.instance;
  final hasPermission = await service.hasPermission();

  if (!hasPermission) {
    // Fallback: mock data
    return ref.read(todayScreenTimeProvider);
  }

  final data = await service.getUsageWithIcons(0);
  return data ?? ref.read(todayScreenTimeProvider);
});

/// Kategori bazlı dakika toplamı.
/// Dönen map: { "social": 120, "game": 45, "video": 90, ... }
final categoryBreakdownProvider = Provider<Map<String, int>>((ref) {
  final today = ref.watch(todayScreenTimeProvider);
  final breakdown = <String, int>{};
  for (final app in today.apps) {
    final cat = app.category ?? 'other';
    breakdown[cat] = (breakdown[cat] ?? 0) + app.minutes;
  }
  return breakdown;
});

/// Kategori renk eşlemesi.
const categoryColors = {
  'social': 0xFF1DA1F2,
  'game': 0xFFFF6B00,
  'video': 0xFFFF0000,
  'audio': 0xFF1DB954,
  'productivity': 0xFF39FF14,
  'news': 0xFF636366,
  'maps': 0xFF4FACFE,
  'image': 0xFFE1306C,
  'other': 0xFF8E8E93,
};

/// Kategori Türkçe etiketleri.
const categoryLabels = {
  'social': 'Sosyal',
  'game': 'Oyun',
  'video': 'Video',
  'audio': 'Müzik',
  'productivity': 'Üretkenlik',
  'news': 'Haber',
  'maps': 'Harita',
  'image': 'Fotoğraf',
  'other': 'Diğer',
};
