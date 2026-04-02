import 'package:flutter/material.dart';

class StoryComment {
  final String id;
  final String storyId;
  final String userId;
  final String username;
  final String? avatarUrl;
  final Color? avatarColor;
  final String content;
  final String? parentId;
  final String? parentUsername;
  final int likeCount;
  final DateTime createdAt;

  const StoryComment({
    required this.id,
    required this.storyId,
    required this.userId,
    required this.username,
    this.avatarUrl,
    this.avatarColor,
    required this.content,
    this.parentId,
    this.parentUsername,
    this.likeCount = 0,
    required this.createdAt,
  });

  factory StoryComment.fromJson(Map<String, dynamic> json) => StoryComment(
        id: json['id'] as String,
        storyId: json['story_id'] as String,
        userId: json['user_id'] as String,
        username: json['profiles']?['username'] as String? ??
            json['profiles']?['display_name'] as String? ??
            'Kullanıcı',
        avatarUrl: json['profiles']?['avatar_url'] as String?,
        avatarColor: json['profiles']?['avatar_color'] != null
            ? _parseColor(json['profiles']['avatar_color'] as String)
            : null,
        content: json['content'] as String,
        parentId: json['parent_id'] as String?,
        parentUsername: json['parent']?['profiles']?['username'] as String?,
        likeCount: json['like_count'] as int? ?? 0,
        createdAt: DateTime.parse(json['created_at'] as String),
      );

  String get timeAgo {
    final diff = DateTime.now().difference(createdAt);
    if (diff.inDays > 0) return '${diff.inDays}g';
    if (diff.inHours > 0) return '${diff.inHours}s';
    if (diff.inMinutes > 0) return '${diff.inMinutes}dk';
    return 'az once';
  }

  static Color _parseColor(String hex) {
    final clean = hex.replaceFirst('#', '');
    return Color(int.parse('FF$clean', radix: 16));
  }
}

class StoryLikeInfo {
  final int count;
  final bool isLiked;

  const StoryLikeInfo({required this.count, required this.isLiked});
}
