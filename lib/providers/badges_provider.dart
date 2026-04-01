import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gooffgrid/models/badge.dart';

final _allBadges = [
  Badge(id: 'b1', name: 'Ilk Adim', description: 'Uygulamayi ilk kez ac', iconEmoji: '👶', isEarned: true, earnedAt: DateTime(2025, 1, 15)),
  Badge(id: 'b2', name: '3 Gun Serisi', description: '3 gun ust uste hedefi tut', iconEmoji: '🔥', isEarned: true, earnedAt: DateTime(2025, 1, 18)),
  Badge(id: 'b3', name: 'Haftalik Savasci', description: '7 gun ust uste hedefi tut', iconEmoji: '⚔️', isEarned: true, earnedAt: DateTime(2025, 2, 5)),
  Badge(id: 'b4', name: 'Duello Krali', description: 'Ilk duelini kazan', iconEmoji: '👑', isEarned: true, earnedAt: DateTime(2025, 2, 10)),
  Badge(id: 'b5', name: 'Sosyal Kelebek', description: '5 arkadas ekle', iconEmoji: '🦋', isEarned: true, earnedAt: DateTime(2025, 2, 20)),
  Badge(id: 'b6', name: 'Erken Kus', description: 'Sabah 6da telefonu acma', iconEmoji: '🐦', isEarned: true, earnedAt: DateTime(2025, 3, 1)),
  const Badge(id: 'b7', name: 'Dijital Diyetci', description: 'Gunluk 2 saatin altinda kal', iconEmoji: '🥗', isEarned: false),
  const Badge(id: 'b8', name: 'Maratoncı', description: '30 gun ust uste hedef tut', iconEmoji: '🏃', isEarned: false),
  const Badge(id: 'b9', name: 'Grup Lideri', description: 'Bir grup olustur', iconEmoji: '👥', isEarned: false),
  const Badge(id: 'b10', name: 'Sehir Sampiyonu', description: 'Sehrinde Top 3 gir', iconEmoji: '🏆', isEarned: false),
  const Badge(id: 'b11', name: 'Gece Baykusu', description: 'Gece 12den sonra telefon kullanma', iconEmoji: '🦉', isEarned: false),
  const Badge(id: 'b12', name: 'Hafta Sonu Kahramani', description: 'Hafta sonu toplam 2 saatten az kullan', iconEmoji: '🦸', isEarned: false),
  const Badge(id: 'b13', name: 'Uygulama Katili', description: 'En cok kullandigin uygulamayi 1 gün acma', iconEmoji: '💀', isEarned: false),
  const Badge(id: 'b14', name: '100 Puan', description: '100 puan topla', iconEmoji: '💯', isEarned: false),
  const Badge(id: 'b15', name: 'Off-Grid Efsanesi', description: 'Level 10 a ulas', iconEmoji: '🏔️', isEarned: false),
];

class BadgeNotifier extends StateNotifier<List<Badge>> {
  BadgeNotifier() : super(_allBadges);
}

final badgeProvider = StateNotifierProvider<BadgeNotifier, List<Badge>>(
  (ref) => BadgeNotifier(),
);
