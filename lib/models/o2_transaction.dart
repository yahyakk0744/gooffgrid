class O2Transaction {
  final String id;
  final String userId;
  final int amount;
  final String type;
  final String? description;
  final Map<String, dynamic>? metadata;
  final DateTime date;
  final DateTime createdAt;

  const O2Transaction({
    required this.id,
    required this.userId,
    required this.amount,
    required this.type,
    this.description,
    this.metadata,
    required this.date,
    required this.createdAt,
  });

  bool get isEarning => amount > 0;
  bool get isSpending => amount < 0;

  String get typeLabel => switch (type) {
    'focus_earn' => 'Odak Modu',
    'offscreen_earn' => 'Ekran Tasarrufu',
    'streak_bonus' => 'Seri Bonus',
    'badge_bonus' => 'Rozet Bonus',
    'market_spend' => 'Market',
    'daily_bonus' => 'Günlük Bonus',
    _ => type,
  };

  String get typeEmoji => switch (type) {
    'focus_earn' => '🧘',
    'offscreen_earn' => '📴',
    'streak_bonus' => '🔥',
    'badge_bonus' => '🏅',
    'market_spend' => '🛒',
    'daily_bonus' => '🎁',
    _ => '💎',
  };

  factory O2Transaction.fromJson(Map<String, dynamic> json) => O2Transaction(
        id: json['id'] as String,
        userId: json['user_id'] as String,
        amount: json['amount'] as int,
        type: json['type'] as String,
        description: json['description'] as String?,
        metadata: json['metadata'] as Map<String, dynamic>?,
        date: DateTime.parse(json['date'] as String),
        createdAt: DateTime.parse(json['created_at'] as String),
      );
}

class MarketOffer {
  final String id;
  final String partnerName;
  final String? partnerLogo;
  final String title;
  final String? description;
  final int o2Cost;
  final String category;
  final String? city;
  final bool isActive;
  final DateTime? expiresAt;

  const MarketOffer({
    required this.id,
    required this.partnerName,
    this.partnerLogo,
    required this.title,
    this.description,
    required this.o2Cost,
    required this.category,
    this.city,
    this.isActive = true,
    this.expiresAt,
  });

  String get categoryEmoji => switch (category) {
    'cafe' => '☕',
    'bookstore' => '📚',
    'fitness' => '💪',
    'entertainment' => '🎵',
    'health' => '🥗',
    'outdoor' => '⛺',
    _ => '🎁',
  };

  factory MarketOffer.fromJson(Map<String, dynamic> json) => MarketOffer(
        id: json['id'] as String,
        partnerName: json['partner_name'] as String,
        partnerLogo: json['partner_logo'] as String?,
        title: json['title'] as String,
        description: json['description'] as String?,
        o2Cost: json['o2_cost'] as int,
        category: json['category'] as String? ?? 'other',
        city: json['city'] as String?,
        isActive: json['is_active'] as bool? ?? true,
        expiresAt: json['expires_at'] != null
            ? DateTime.parse(json['expires_at'] as String)
            : null,
      );
}

class MarketRedemption {
  final String id;
  final String offerId;
  final int o2Spent;
  final String redeemCode;
  final String status;
  final DateTime createdAt;

  const MarketRedemption({
    required this.id,
    required this.offerId,
    required this.o2Spent,
    required this.redeemCode,
    required this.status,
    required this.createdAt,
  });

  factory MarketRedemption.fromJson(Map<String, dynamic> json) => MarketRedemption(
        id: json['id'] as String,
        offerId: json['offer_id'] as String,
        o2Spent: json['o2_spent'] as int,
        redeemCode: json['redeem_code'] as String,
        status: json['status'] as String? ?? 'active',
        createdAt: DateTime.parse(json['created_at'] as String),
      );
}
