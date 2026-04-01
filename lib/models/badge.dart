class Badge {
  final String id;
  final String name;
  final String description;
  final String iconEmoji;
  final bool isEarned;
  final DateTime? earnedAt;

  const Badge({
    required this.id,
    required this.name,
    required this.description,
    required this.iconEmoji,
    required this.isEarned,
    this.earnedAt,
  });

  factory Badge.fromJson(Map<String, dynamic> json) => Badge(
        id: json['id'] as String,
        name: json['name'] as String,
        description: json['description'] as String,
        iconEmoji: json['iconEmoji'] as String,
        isEarned: json['isEarned'] as bool,
        earnedAt: json['earnedAt'] != null ? DateTime.parse(json['earnedAt'] as String) : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'iconEmoji': iconEmoji,
        'isEarned': isEarned,
        'earnedAt': earnedAt?.toIso8601String(),
      };

  Badge copyWith({
    String? id,
    String? name,
    String? description,
    String? iconEmoji,
    bool? isEarned,
    DateTime? earnedAt,
  }) =>
      Badge(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        iconEmoji: iconEmoji ?? this.iconEmoji,
        isEarned: isEarned ?? this.isEarned,
        earnedAt: earnedAt ?? this.earnedAt,
      );
}
