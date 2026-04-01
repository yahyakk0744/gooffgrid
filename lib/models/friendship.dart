enum FriendshipStatus { pending, accepted }

class Friendship {
  final String id;
  final String user1Id;
  final String user2Id;
  final FriendshipStatus status;
  final DateTime createdAt;

  const Friendship({
    required this.id,
    required this.user1Id,
    required this.user2Id,
    required this.status,
    required this.createdAt,
  });

  factory Friendship.fromJson(Map<String, dynamic> json) => Friendship(
        id: json['id'] as String,
        user1Id: json['user1Id'] as String,
        user2Id: json['user2Id'] as String,
        status: FriendshipStatus.values.byName(json['status'] as String),
        createdAt: DateTime.parse(json['createdAt'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user1Id': user1Id,
        'user2Id': user2Id,
        'status': status.name,
        'createdAt': createdAt.toIso8601String(),
      };

  Friendship copyWith({
    String? id,
    String? user1Id,
    String? user2Id,
    FriendshipStatus? status,
    DateTime? createdAt,
  }) =>
      Friendship(
        id: id ?? this.id,
        user1Id: user1Id ?? this.user1Id,
        user2Id: user2Id ?? this.user2Id,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
      );
}
