class Reaction {
  final String id;
  final String fromUserId;
  final String toUserId;
  final String emoji;
  final DateTime createdAt;

  const Reaction({
    required this.id,
    required this.fromUserId,
    required this.toUserId,
    required this.emoji,
    required this.createdAt,
  });

  factory Reaction.fromJson(Map<String, dynamic> json) => Reaction(
        id: json['id'] as String,
        fromUserId: json['fromUserId'] as String,
        toUserId: json['toUserId'] as String,
        emoji: json['emoji'] as String,
        createdAt: DateTime.parse(json['createdAt'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'fromUserId': fromUserId,
        'toUserId': toUserId,
        'emoji': emoji,
        'createdAt': createdAt.toIso8601String(),
      };

  Reaction copyWith({
    String? id,
    String? fromUserId,
    String? toUserId,
    String? emoji,
    DateTime? createdAt,
  }) =>
      Reaction(
        id: id ?? this.id,
        fromUserId: fromUserId ?? this.fromUserId,
        toUserId: toUserId ?? this.toUserId,
        emoji: emoji ?? this.emoji,
        createdAt: createdAt ?? this.createdAt,
      );
}
