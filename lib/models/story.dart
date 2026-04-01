import 'package:flutter/material.dart';

class Story {
  final String id;
  final String userId;
  final String? userName;
  final String? userAvatarUrl;
  final Color? userAvatarColor;
  final DateTime date;
  final String? imageUrl;
  final String? caption;
  final String? activityType;
  final DateTime createdAt;
  final DateTime? expiresAt;
  final String visibility; // 'friends', 'public'
  final int viewCount;
  final String storyType; // 'photo', 'achievement', 'milestone'
  final int durationHours;

  const Story({
    required this.id,
    required this.userId,
    this.userName,
    this.userAvatarUrl,
    this.userAvatarColor,
    required this.date,
    this.imageUrl,
    this.caption,
    this.activityType,
    required this.createdAt,
    this.expiresAt,
    this.visibility = 'friends',
    this.viewCount = 0,
    this.storyType = 'photo',
    this.durationHours = 24,
  });

  bool get isExpired {
    if (expiresAt == null) return false;
    return DateTime.now().isAfter(expiresAt!);
  }

  bool get isActive => !isExpired;

  Duration get remainingTime {
    if (expiresAt == null) return Duration.zero;
    final diff = expiresAt!.difference(DateTime.now());
    return diff.isNegative ? Duration.zero : diff;
  }

  String get remainingLabel {
    final r = remainingTime;
    if (r.inHours > 0) return '${r.inHours}s';
    if (r.inMinutes > 0) return '${r.inMinutes}dk';
    return 'Bitiyor';
  }

  factory Story.fromJson(Map<String, dynamic> json) => Story(
        id: json['id'] as String,
        userId: json['user_id'] as String,
        userName: json['profiles']?['display_name'] as String?,
        userAvatarUrl: json['profiles']?['avatar_url'] as String?,
        userAvatarColor: json['profiles']?['avatar_color'] != null
            ? _parseColor(json['profiles']['avatar_color'] as String)
            : null,
        date: DateTime.parse(json['date'] as String),
        imageUrl: json['image_url'] as String?,
        caption: json['caption'] as String?,
        activityType: json['activity_type'] as String?,
        createdAt: DateTime.parse(json['created_at'] as String),
        expiresAt: json['expires_at'] != null
            ? DateTime.parse(json['expires_at'] as String)
            : null,
        visibility: json['visibility'] as String? ?? 'friends',
        viewCount: json['view_count'] as int? ?? 0,
        storyType: json['story_type'] as String? ?? 'photo',
        durationHours: json['duration_hours'] as int? ?? 24,
      );

  Map<String, dynamic> toInsertJson() => {
        'user_id': userId,
        'date': date.toIso8601String().split('T').first,
        'image_url': imageUrl,
        'caption': caption,
        'activity_type': activityType,
        'visibility': visibility,
        'story_type': storyType,
        'duration_hours': durationHours,
      };

  static Color _parseColor(String hex) {
    final clean = hex.replaceFirst('#', '');
    return Color(int.parse('FF$clean', radix: 16));
  }
}

class StoryGroup {
  final String userId;
  final String userName;
  final String? avatarUrl;
  final Color avatarColor;
  final List<Story> stories;
  final bool hasUnviewed;

  const StoryGroup({
    required this.userId,
    required this.userName,
    this.avatarUrl,
    required this.avatarColor,
    required this.stories,
    this.hasUnviewed = true,
  });
}
