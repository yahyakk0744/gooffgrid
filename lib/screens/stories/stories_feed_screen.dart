import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme.dart';
import '../../models/story.dart';
import '../../providers/stories_provider.dart';
import '../../services/haptic_service.dart';
import '../../widgets/story_comments_sheet.dart';
import '../../l10n/app_localizations.dart';

/// TikTok/Reels tarzinda dikey swipe hikaye akisi.
class StoriesFeedScreen extends ConsumerStatefulWidget {
  const StoriesFeedScreen({super.key, this.embedded = false});

  final bool embedded;

  @override
  ConsumerState<StoriesFeedScreen> createState() => _StoriesFeedScreenState();
}

class _StoriesFeedScreenState extends ConsumerState<StoriesFeedScreen> {
  String _activeFilter = 'friends';
  final _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final storiesAsync = ref.watch(storiesFeedProvider(_activeFilter));

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          // Story pages
          storiesAsync.when(
            data: (stories) => stories.isEmpty
                ? _buildEmptyState(l)
                : PageView.builder(
                    controller: _pageController,
                    scrollDirection: Axis.vertical,
                    itemCount: stories.length,
                    itemBuilder: (_, i) => _StoryPage(
                      story: stories[i],
                      onCommentTap: () => _openComments(stories[i].id),
                    ),
                  ),
            loading: () => const Center(
              child: CircularProgressIndicator(color: AppColors.neonGreen),
            ),
            error: (_, __) => _buildEmptyState(l),
          ),

          // Top filter tabs
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    if (!widget.embedded)
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios_rounded,
                            color: Colors.white, size: 20),
                        onPressed: () => context.pop(),
                      ),
                    const Spacer(),
                    _FilterTab(
                      label: l.myFriends,
                      isSelected: _activeFilter == 'friends',
                      onTap: () => _switchFilter('friends'),
                    ),
                    const SizedBox(width: 8),
                    _FilterTab(
                      label: l.inMyCity,
                      isSelected: _activeFilter == 'city',
                      onTap: () => _switchFilter('city'),
                    ),
                    const Spacer(),
                    const SizedBox(width: 40), // balance back button
                  ],
                ),
              ),
            ),
          ),

          // FAB
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom + 80,
            left: 16,
            child: GestureDetector(
              onTap: () {
                HapticService.medium();
                context.go('/social/create-story');
              },
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.neonGreen,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.neonGreen.withValues(alpha: 0.4),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(Icons.add_rounded,
                    color: Colors.black, size: 28),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(AppLocalizations l) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.auto_stories_rounded,
              size: 64,
              color: AppColors.textTertiary.withValues(alpha: 0.4)),
          const SizedBox(height: 12),
          Text(l.noStories, style: AppTextStyles.bodySecondary),
          const SizedBox(height: 4),
          Text(
            l.shareFirstStory,
            style: TextStyle(fontSize: 12, color: AppColors.textTertiary),
          ),
        ],
      ),
    );
  }

  void _switchFilter(String filter) {
    if (_activeFilter == filter) return;
    HapticService.selection();
    setState(() => _activeFilter = filter);
    _pageController.jumpToPage(0);
  }

  void _openComments(String storyId) {
    HapticService.light();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => StoryCommentsSheet(storyId: storyId),
    );
  }
}

// ──────────────────────────────────────────────
// Filter Tab (glassmorphism)
// ──────────────────────────────────────────────

class _FilterTab extends StatelessWidget {
  const _FilterTab({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: isSelected
                  ? AppColors.neonGreen.withValues(alpha: 0.2)
                  : Colors.white.withValues(alpha: 0.06),
              border: Border.all(
                color: isSelected
                    ? AppColors.neonGreen.withValues(alpha: 0.6)
                    : Colors.white.withValues(alpha: 0.12),
              ),
            ),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color:
                    isSelected ? AppColors.neonGreen : AppColors.textSecondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────
// Single Story Page (full screen)
// ──────────────────────────────────────────────

class _StoryPage extends ConsumerStatefulWidget {
  const _StoryPage({required this.story, required this.onCommentTap});

  final Story story;
  final VoidCallback onCommentTap;

  @override
  ConsumerState<_StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends ConsumerState<_StoryPage>
    with SingleTickerProviderStateMixin {
  bool _localLiked = false;
  int _localLikeCount = 0;
  late AnimationController _likeAnimController;
  late Animation<double> _likeScale;

  @override
  void initState() {
    super.initState();
    _likeAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _likeScale = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.4), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.4, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(
        parent: _likeAnimController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _likeAnimController.dispose();
    super.dispose();
  }

  // Story'ye ozel gradient renkleri
  List<Color> get _bgGradient {
    final base = widget.story.userAvatarColor ?? const Color(0xFF667EEA);
    return [
      base.withValues(alpha: 0.3),
      AppColors.bg,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final likesAsync = ref.watch(storyLikesProvider(widget.story.id));

    // Sync local state with server
    likesAsync.whenData((info) {
      if (_localLikeCount == 0 && !_localLiked) {
        _localLikeCount = info.count;
        _localLiked = info.isLiked;
      }
    });

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: _bgGradient,
        ),
      ),
      child: Stack(
        children: [
          // Center content
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                widget.story.caption ?? '',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          // Bottom-left: user info
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom + 24,
            left: 16,
            right: 80,
            child: GestureDetector(
              onTap: () {
                HapticService.light();
                context.push('/user/${widget.story.userId}');
              },
              behavior: HitTestBehavior.opaque,
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: widget.story.userAvatarColor ??
                          AppColors.textTertiary,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        (widget.story.userName ?? '?')[0].toUpperCase(),
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.story.userName ?? l.loading,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                        Text(
                          widget.story.remainingLabel,
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.white.withValues(alpha: 0.6)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom-right: action buttons
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom + 24,
            right: 12,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Like
                _ActionButton(
                  icon: _localLiked
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                  color: _localLiked ? AppColors.ringDanger : Colors.white,
                  label: '$_localLikeCount',
                  scaleAnimation: _likeScale,
                  onTap: _toggleLike,
                ),
                const SizedBox(height: 20),

                // Comment
                _ActionButton(
                  icon: Icons.chat_bubble_outline_rounded,
                  color: Colors.white,
                  label: '0',
                  onTap: widget.onCommentTap,
                ),
                const SizedBox(height: 20),

                // Share
                _ActionButton(
                  icon: Icons.share_outlined,
                  color: Colors.white,
                  label: '',
                  onTap: () => HapticService.light(),
                ),
                const SizedBox(height: 20),

                // Views
                _ActionButton(
                  icon: Icons.visibility_outlined,
                  color: Colors.white,
                  label: '${widget.story.viewCount}',
                  onTap: () {
                    HapticService.light();
                    _showViewers(context, l);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showViewers(BuildContext context, AppLocalizations l) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.cardBg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.visibility_rounded, color: AppColors.textSecondary, size: 20),
                const SizedBox(width: 8),
                Text(l.viewsCount(widget.story.viewCount), style: AppTextStyles.h3),
              ],
            ),
            const SizedBox(height: 16),
            // Mock viewers list
            ..._mockViewers.map((v) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  CircleAvatar(radius: 18, backgroundColor: v.$2, child: Text(v.$1[0], style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600))),
                  const SizedBox(width: 12),
                  Expanded(child: Text(v.$1, style: AppTextStyles.body)),
                  Text(v.$3, style: AppTextStyles.labelSmall),
                ],
              ),
            )),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  static const _mockViewers = [
    ('Zeynep', Color(0xFFF093FB), '2s önce'),
    ('Burak', Color(0xFF4FACFE), '3s önce'),
    ('Can', Color(0xFFFF6B00), '5s önce'),
    ('Selin', Color(0xFF667EEA), '6s önce'),
  ];

  Future<void> _toggleLike() async {
    HapticService.medium();
    _likeAnimController.forward(from: 0);

    setState(() {
      _localLiked = !_localLiked;
      _localLikeCount += _localLiked ? 1 : -1;
      if (_localLikeCount < 0) _localLikeCount = 0;
    });

    await toggleStoryLike(widget.story.id);
    ref.invalidate(storyLikesProvider(widget.story.id));
  }
}

// ──────────────────────────────────────────────
// Action Button (like, comment, share)
// ──────────────────────────────────────────────

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.color,
    required this.label,
    required this.onTap,
    this.scaleAnimation,
  });

  final IconData icon;
  final Color color;
  final String label;
  final VoidCallback onTap;
  final Animation<double>? scaleAnimation;

  @override
  Widget build(BuildContext context) {
    final iconWidget = Icon(icon, color: color, size: 28);

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          scaleAnimation != null
              ? AnimatedBuilder(
                  animation: scaleAnimation!,
                  builder: (_, child) => Transform.scale(
                    scale: scaleAnimation!.value,
                    child: child,
                  ),
                  child: iconWidget,
                )
              : iconWidget,
          if (label.isNotEmpty) ...[
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                  fontSize: 11,
                  color: Colors.white.withValues(alpha: 0.8),
                  fontWeight: FontWeight.w500),
            ),
          ],
        ],
      ),
    );
  }
}
