import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/theme.dart';
import '../../models/story.dart';
import '../../providers/stories_provider.dart';

/// Tam ekran story görüntüleyici (Instagram/Snapchat tarzı).
class StoryViewerScreen extends ConsumerStatefulWidget {
  const StoryViewerScreen({
    super.key,
    required this.group,
    this.initialIndex = 0,
  });

  final StoryGroup group;
  final int initialIndex;

  @override
  ConsumerState<StoryViewerScreen> createState() => _StoryViewerScreenState();
}

class _StoryViewerScreenState extends ConsumerState<StoryViewerScreen>
    with SingleTickerProviderStateMixin {
  late int _currentIndex;
  late AnimationController _progressController;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _nextStory();
        }
      });
    _startProgress();
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  void _startProgress() {
    _progressController.forward(from: 0);
    // Mark as viewed
    final story = widget.group.stories[_currentIndex];
    ref.read(storiesProvider.notifier).markViewed(story.id);
  }

  void _nextStory() {
    if (_currentIndex < widget.group.stories.length - 1) {
      setState(() => _currentIndex++);
      _startProgress();
    } else {
      Navigator.pop(context);
    }
  }

  void _prevStory() {
    if (_currentIndex > 0) {
      setState(() => _currentIndex--);
      _startProgress();
    }
  }

  @override
  Widget build(BuildContext context) {
    final story = widget.group.stories[_currentIndex];
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTapUp: (details) {
          if (details.globalPosition.dx < size.width / 3) {
            _prevStory();
          } else {
            _nextStory();
          }
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background
            if (story.imageUrl != null)
              Image.network(
                story.imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(color: AppColors.bg),
              )
            else
              Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.center,
                    radius: 1.2,
                    colors: [
                      AppColors.bgDeepCenter,
                      AppColors.bg,
                    ],
                  ),
                ),
              ),

            // Dark overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black.withOpacity(0.8),
                  ],
                  stops: const [0, 0.2, 0.7, 1],
                ),
              ),
            ),

            // Content
            SafeArea(
              child: Column(
                children: [
                  // Progress bars
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Row(
                      children: List.generate(widget.group.stories.length, (i) {
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: AnimatedBuilder(
                              animation: _progressController,
                              builder: (context, _) {
                                double value;
                                if (i < _currentIndex) {
                                  value = 1.0;
                                } else if (i == _currentIndex) {
                                  value = _progressController.value;
                                } else {
                                  value = 0.0;
                                }
                                return LinearProgressIndicator(
                                  value: value,
                                  backgroundColor: Colors.white.withOpacity(0.2),
                                  valueColor: const AlwaysStoppedAnimation(Colors.white),
                                  minHeight: 2.5,
                                  borderRadius: BorderRadius.circular(2),
                                );
                              },
                            ),
                          ),
                        );
                      }),
                    ),
                  ),

                  // User header
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: widget.group.avatarColor,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              widget.group.userName[0].toUpperCase(),
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.group.userName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
                            Text(story.remainingLabel, style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 11)),
                          ],
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.close_rounded, color: Colors.white, size: 28),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  // Caption + activity
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (story.activityType != null)
                          Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: AppColors.neonGreen.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              story.activityType!,
                              style: const TextStyle(color: AppColors.neonGreen, fontSize: 13, fontWeight: FontWeight.w500),
                            ),
                          ),
                        if (story.caption != null && story.caption!.isNotEmpty)
                          Text(
                            story.caption!,
                            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

