import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gooffgrid/models/badge.dart';

final _allBadges = [
  Badge(id: 'b1', name: 'İlk Adım', description: 'Uygulamayı ilk kez aç', iconEmoji: '👶', isEarned: true, earnedAt: DateTime(2025, 1, 15)),
  Badge(id: 'b2', name: '3 Gün Serisi', description: '3 gün üst üste hedefi tut', iconEmoji: '🔥', isEarned: true, earnedAt: DateTime(2025, 1, 18)),
  Badge(id: 'b3', name: 'Haftalık Savaşçı', description: '7 gün üst üste hedefi tut', iconEmoji: '⚔️', isEarned: true, earnedAt: DateTime(2025, 2, 5)),
  Badge(id: 'b4', name: 'Düello Kralı', description: 'İlk düellonu kazan', iconEmoji: '👑', isEarned: true, earnedAt: DateTime(2025, 2, 10)),
  Badge(id: 'b5', name: 'Sosyal Kelebek', description: '5 arkadaş ekle', iconEmoji: '🦋', isEarned: true, earnedAt: DateTime(2025, 2, 20)),
  Badge(id: 'b6', name: 'Erken Kuş', description: 'Sabah 6\'da telefonu açma', iconEmoji: '🐦', isEarned: true, earnedAt: DateTime(2025, 3, 1)),
  const Badge(id: 'b7', name: 'Dijital Diyetçi', description: 'Günlük 2 saatin altında kal', iconEmoji: '🥗', isEarned: false),
  const Badge(id: 'b8', name: 'Maratoncı', description: '30 gün üst üste hedef tut', iconEmoji: '🏃', isEarned: false),
  const Badge(id: 'b9', name: 'Grup Lideri', description: 'Bir grup oluştur', iconEmoji: '👥', isEarned: false),
  const Badge(id: 'b10', name: 'Şehir Şampiyonu', description: 'Şehrinde Top 3\'e gir', iconEmoji: '🏆', isEarned: false),
  const Badge(id: 'b11', name: 'Gece Baykuşu', description: 'Gece 12\'den sonra telefon kullanma', iconEmoji: '🦉', isEarned: false),
  const Badge(id: 'b12', name: 'Hafta Sonu Kahramanı', description: 'Hafta sonu toplam 2 saatten az kullan', iconEmoji: '🦸', isEarned: false),
  const Badge(id: 'b13', name: 'Uygulama Katili', description: 'En çok kullandığın uygulamayı 1 gün açma', iconEmoji: '💀', isEarned: false),
  const Badge(id: 'b14', name: '100 Puan', description: '100 puan topla', iconEmoji: '💯', isEarned: false),
  const Badge(id: 'b15', name: 'Off-Grid Efsanesi', description: 'Level 10\'a ulaş', iconEmoji: '🏔️', isEarned: false),
];

class BadgeNotifier extends StateNotifier<List<Badge>> {
  BadgeNotifier() : super(_allBadges);
}

final badgeProvider = StateNotifierProvider<BadgeNotifier, List<Badge>>(
  (ref) => BadgeNotifier(),
);
