import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/story.dart';
import '../models/story_comment.dart';
import '../config/theme.dart';
import '../services/supabase_sync_service.dart';

// ──────────────────────────────────────────────
// STORIES STATE
// ──────────────────────────────────────────────

class StoriesState {
  final List<StoryGroup> groups;
  final bool isLoading;
  final String? error;

  const StoriesState({
    this.groups = const [],
    this.isLoading = false,
    this.error,
  });

  StoriesState copyWith({
    List<StoryGroup>? groups,
    bool? isLoading,
    String? error,
  }) =>
      StoriesState(
        groups: groups ?? this.groups,
        isLoading: isLoading ?? this.isLoading,
        error: error,
      );
}

class StoriesNotifier extends StateNotifier<StoriesState> {
  StoriesNotifier() : super(const StoriesState());

  final _sync = SupabaseSyncService.instance;

  Future<void> loadStories() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final stories = await _sync.getFriendStories();
      final grouped = _groupByUser(stories);
      state = state.copyWith(groups: grouped, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<Story?> createStory({
    String? caption,
    String? activityType,
    String visibility = 'friends',
    String storyType = 'photo',
    int durationHours = 24,
    List<int>? imageBytes,
    String? imageExtension,
  }) async {
    final story = await _sync.createStory(
      caption: caption,
      activityType: activityType,
      visibility: visibility,
      storyType: storyType,
      durationHours: durationHours,
      imageBytes: imageBytes,
      imageExtension: imageExtension,
    );
    if (story != null) {
      await loadStories();
    }
    return story;
  }

  Future<void> deleteStory(String storyId) async {
    await _sync.deleteStory(storyId);
    await loadStories();
  }

  Future<void> markViewed(String storyId) async {
    await _sync.markStoryViewed(storyId);
  }

  List<StoryGroup> _groupByUser(List<Story> stories) {
    final map = <String, List<Story>>{};
    for (final s in stories) {
      map.putIfAbsent(s.userId, () => []).add(s);
    }

    return map.entries.map((e) {
      final userStories = e.value;
      final first = userStories.first;
      return StoryGroup(
        userId: e.key,
        userName: first.userName ?? 'Kullanıcı',
        avatarUrl: first.userAvatarUrl,
        avatarColor: first.userAvatarColor ?? const Color(0xFF6B7280),
        stories: userStories,
        hasUnviewed: true,
      );
    }).toList();
  }
}

final storiesProvider =
    StateNotifierProvider<StoriesNotifier, StoriesState>((ref) {
  return StoriesNotifier()..loadStories();
});

// ──────────────────────────────────────────────
// STORY FEED (TikTok-style flat list)
// ──────────────────────────────────────────────

final _mockStories = [
  Story(
    id: 'mock-1',
    userId: 'u1',
    userName: 'Zeynep',
    userAvatarColor: const Color(0xFFF093FB),
    date: DateTime.now(),
    caption: 'Sahilde 3 saat telefonsuz yürüdüm. Dalga sesleri terapi gibi.',
    activityType: 'Yürüyüş',
    createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    expiresAt: DateTime.now().add(const Duration(hours: 4)),
    visibility: 'friends',
  ),
  Story(
    id: 'mock-2',
    userId: 'u2',
    userName: 'Burak',
    userAvatarColor: const Color(0xFF4FACFE),
    date: DateTime.now(),
    caption: 'Kitap okuyorum, telefon diğer odada. Huzur bu olmalı.',
    activityType: 'Kitap',
    createdAt: DateTime.now().subtract(const Duration(hours: 1)),
    expiresAt: DateTime.now().add(const Duration(hours: 5)),
    visibility: 'everyone',
  ),
  Story(
    id: 'mock-3',
    userId: 'u3',
    userName: 'Elif',
    userAvatarColor: const Color(0xFFA8EB12),
    date: DateTime.now(),
    caption: 'Sabah meditasyonu tamam. 20 dakika sessizlik.',
    activityType: 'Meditasyon',
    createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
    expiresAt: DateTime.now().add(const Duration(hours: 6)),
    visibility: 'friends',
  ),
  Story(
    id: 'mock-4',
    userId: 'u4',
    userName: 'Can',
    userAvatarColor: AppColors.neonOrange,
    date: DateTime.now(),
    caption: 'Parkta koşu, kulaklıkları evde bıraktım. Kuş sesleri > Spotify.',
    activityType: 'Koşu',
    createdAt: DateTime.now().subtract(const Duration(hours: 3)),
    expiresAt: DateTime.now().add(const Duration(hours: 3)),
    visibility: 'everyone',
  ),
  Story(
    id: 'mock-5',
    userId: 'u5',
    userName: 'Selin',
    userAvatarColor: const Color(0xFF667EEA),
    date: DateTime.now(),
    caption: 'Ailece aksam yemegi, telefonlar kutuya girdi.',
    activityType: 'Aile',
    createdAt: DateTime.now().subtract(const Duration(hours: 5)),
    expiresAt: DateTime.now().add(const Duration(hours: 1)),
    visibility: 'friends',
  ),
];

final storiesFeedProvider =
    FutureProvider.family<List<Story>, String>((ref, filter) async {
  try {
    final client = Supabase.instance.client;
    final userId = client.auth.currentUser?.id;

    if (userId == null) return _mockStories;

    if (filter == 'friends') {
      final data = await client
          .from('anti_social_posts')
          .select('*, profiles(display_name, avatar_url, avatar_color, city)')
          .eq('visibility', 'friends')
          .order('created_at', ascending: false)
          .limit(50);
      return (data as List).map((d) => Story.fromJson(d)).toList();
    } else {
      // city filter
      final profile = await client
          .from('profiles')
          .select('city')
          .eq('id', userId)
          .single();
      final city = profile['city'] as String?;

      if (city == null) return _mockStories;

      final data = await client
          .from('anti_social_posts')
          .select('*, profiles!inner(display_name, avatar_url, avatar_color, city)')
          .eq('profiles.city', city)
          .eq('visibility', 'everyone')
          .order('created_at', ascending: false)
          .limit(50);
      return (data as List).map((d) => Story.fromJson(d)).toList();
    }
  } catch (_) {
    return _mockStories;
  }
});

// ──────────────────────────────────────────────
// LIKES
// ──────────────────────────────────────────────

final storyLikesProvider =
    FutureProvider.family<StoryLikeInfo, String>((ref, storyId) async {
  try {
    final client = Supabase.instance.client;
    final userId = client.auth.currentUser?.id ?? 'demo-user';

    final countRes = await client
        .from('story_likes')
        .select()
        .eq('story_id', storyId);
    final count = (countRes as List).length;

    final likedRes = await client
        .from('story_likes')
        .select()
        .eq('story_id', storyId)
        .eq('user_id', userId)
        .maybeSingle();

    return StoryLikeInfo(count: count, isLiked: likedRes != null);
  } catch (_) {
    return const StoryLikeInfo(count: 0, isLiked: false);
  }
});

Future<void> toggleStoryLike(String storyId) async {
  try {
    final client = Supabase.instance.client;
    final userId = client.auth.currentUser?.id ?? 'demo-user';

    final existing = await client
        .from('story_likes')
        .select()
        .eq('story_id', storyId)
        .eq('user_id', userId)
        .maybeSingle();

    if (existing != null) {
      await client.from('story_likes').delete().eq('id', existing['id']);
    } else {
      await client
          .from('story_likes')
          .insert({'story_id': storyId, 'user_id': userId});
    }
  } catch (_) {
    // Demo mode — silently ignore
  }
}

// ──────────────────────────────────────────────
// COMMENTS
// ──────────────────────────────────────────────

final storyCommentsProvider =
    FutureProvider.family<List<StoryComment>, String>((ref, storyId) async {
  try {
    final data = await Supabase.instance.client
        .from('story_comments')
        .select('*, profiles(username, display_name, avatar_url, avatar_color)')
        .eq('story_id', storyId)
        .order('created_at');
    return (data as List).map((d) => StoryComment.fromJson(d)).toList();
  } catch (_) {
    return _mockComments;
  }
});

Future<void> addStoryComment(
  String storyId,
  String content, {
  String? parentId,
}) async {
  try {
    await Supabase.instance.client.from('story_comments').insert({
      'story_id': storyId,
      'user_id':
          Supabase.instance.client.auth.currentUser?.id ?? 'demo-user',
      'content': content,
      'parent_id': parentId,
    });
  } catch (_) {
    // Demo mode
  }
}

final _mockComments = [
  StoryComment(
    id: 'c1',
    storyId: 'mock-1',
    userId: 'u2',
    username: 'Burak',
    avatarColor: const Color(0xFF4FACFE),
    content: 'Harika bir fikir, ben de deneyecegim!',
    createdAt: DateTime.now().subtract(const Duration(hours: 1)),
  ),
  StoryComment(
    id: 'c2',
    storyId: 'mock-1',
    userId: 'u3',
    username: 'Elif',
    avatarColor: const Color(0xFFA8EB12),
    content: 'Sahil yuruyusu en iyisi.',
    createdAt: DateTime.now().subtract(const Duration(minutes: 45)),
  ),
];
