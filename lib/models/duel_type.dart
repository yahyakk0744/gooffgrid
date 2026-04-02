class DuelType {
  final String id;
  final String name;
  final String description;
  final String emoji;
  final bool isPro;
  final List<Duration> availableDurations;

  const DuelType({
    required this.id,
    required this.name,
    required this.description,
    required this.emoji,
    this.isPro = false,
    required this.availableDurations,
  });

  static const _standard = [
    Duration(hours: 1),
    Duration(hours: 3),
    Duration(hours: 12),
    Duration(hours: 24),
    Duration(days: 7),
  ];

  static const classic = DuelType(
    id: 'classic',
    name: 'Klasik Düello',
    description: 'Kim daha az kullanırsa kazanır',
    emoji: '⚔️',
    availableDurations: _standard,
  );

  static const appBan = DuelType(
    id: 'app_ban',
    name: 'Uygulama Yasaklama',
    description: '24 saat seçili uygulamayı açma',
    emoji: '🚫',
    availableDurations: [Duration(hours: 24)],
  );

  static const nightDuel = DuelType(
    id: 'night',
    name: 'Gece Düellosu',
    description: '23:00-07:00 telefona bakmadan uyu',
    emoji: '🌙',
    availableDurations: [Duration(hours: 8)],
  );

  static const instant = DuelType(
    id: 'instant',
    name: 'Anlık Düello',
    description: 'Şu an 1 saat telefonunu bırak!',
    emoji: '⚡',
    availableDurations: [Duration(hours: 1)],
  );

  static const blind = DuelType(
    id: 'blind',
    name: 'Kör Düello',
    description: 'Karşı tarafın süresini göremezsin',
    emoji: '🙈',
    availableDurations: _standard,
  );

  static const category = DuelType(
    id: 'category',
    name: 'Kategori Düellosu',
    description: 'Sadece bir kategori sayılır',
    emoji: '📂',
    availableDurations: _standard,
  );

  static const dice = DuelType(
    id: 'dice',
    name: 'Zar Atma',
    description: 'Zar at, hedefini belirlesin',
    emoji: '🎲',
    isPro: true,
    availableDurations: _standard,
  );

  static const reverse = DuelType(
    id: 'reverse',
    name: 'Ters Düello',
    description: 'En çok kullanan ceza alır',
    emoji: '🔄',
    isPro: true,
    availableDurations: _standard,
  );

  static const penalty = DuelType(
    id: 'penalty',
    name: 'Ceza Seçmeli',
    description: 'Kaybeden ne yapacak?',
    emoji: '😈',
    availableDurations: _standard,
  );

  static const team = DuelType(
    id: 'team',
    name: 'Takım Düellosu',
    description: '2v2 veya 3v3 takım süresi',
    emoji: '👥',
    isPro: true,
    availableDurations: [
      Duration(hours: 12),
      Duration(hours: 24),
      Duration(days: 7),
    ],
  );

  static const elimination = DuelType(
    id: 'elimination',
    name: 'Eliminasyon',
    description: '8-16 kişi bracket, her tur 1 gün',
    emoji: '🏆',
    isPro: true,
    availableDurations: [Duration(days: 1), Duration(days: 3)],
  );

  static const battleRoyale = DuelType(
    id: 'battle_royale',
    name: 'Battle Royale',
    description: 'Her gün en çok kullanan elenir',
    emoji: '💀',
    isPro: true,
    availableDurations: [Duration(days: 7), Duration(days: 14)],
  );

  static const mystery = DuelType(
    id: 'mystery',
    name: 'Gizemli Görev',
    description: 'Rastgele görev açıklanır',
    emoji: '❓',
    isPro: true,
    availableDurations: _standard,
  );

  static const revenge = DuelType(
    id: 'revenge',
    name: 'İntikam Düellosu',
    description: 'Kaybettiğin kişiyi tekrar davet, 1.5x puan',
    emoji: '🔥',
    availableDurations: _standard,
  );

  static const all = [
    classic,
    appBan,
    nightDuel,
    instant,
    blind,
    category,
    dice,
    reverse,
    penalty,
    team,
    elimination,
    battleRoyale,
    mystery,
    revenge,
  ];

  static const penaltyTemplates = [
    'Kahve ısmarla ☕',
    'Profil foto değiştir 📸',
    'Story at 📱',
    'Özel yaz... ✏️',
  ];

  String formatDuration(Duration d) {
    if (d.inDays >= 7) return '${d.inDays ~/ 7} hafta';
    if (d.inDays >= 1) return '${d.inDays} gün';
    return '${d.inHours} saat';
  }
}
