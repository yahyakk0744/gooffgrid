import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/story.dart';
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
    int durationHours = 24,
    List<int>? imageBytes,
    String? imageExtension,
  }) async {
    final story = await _sync.createStory(
      caption: caption,
      activityType: activityType,
      visibility: visibility,
      durationHours: durationHours,
      imageBytes: imageBytes,
      imageExtension: imageExtension,
    );
    if (story != null) {
      await loadStories(); // Refresh
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
        userName: first.userName ?? 'Kullanici',
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
