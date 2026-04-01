import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/theme.dart';
import '../../models/story.dart';
import '../../providers/stories_provider.dart';
import '../../services/o2_service.dart';
import '../../widgets/premium_background.dart';

class StoriesFeedScreen extends ConsumerWidget {
  const StoriesFeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storiesState = ref.watch(storiesProvider);

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: PremiumBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Text('Hikayeler', style: AppTextStyles.h1),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => _showCreateStory(context, ref),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [AppColors.cardGradientStart, AppColors.cardGradientEnd],
                          ),
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.neonGreen.withOpacity(0.4)),
                        ),
                        child: const Icon(Icons.add_rounded, color: AppColors.neonGreen, size: 24),
                      ),
                    ),
                  ],
                ),
              ),

              // Story circles
              SizedBox(
                height: 100,
                child: storiesState.isLoading
                    ? const Center(child: CircularProgressIndicator(color: AppColors.neonGreen))
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        itemCount: storiesState.groups.length,
                        itemBuilder: (_, i) =>
                            _StoryCircle(group: storiesState.groups[i]),
                      ),
              ),

              const SizedBox(height: 16),

              // Story cards feed
              Expanded(
                child: storiesState.groups.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.auto_stories_rounded, size: 64, color: AppColors.textTertiary.withOpacity(0.4)),
                            const SizedBox(height: 12),
                            const Text('Henuz hikaye yok', style: AppTextStyles.bodySecondary),
                            const SizedBox(height: 4),
                            Text(
                              'Arkadaslarin off-grid anlarina paylasmaya baslasin!',
                              style: TextStyle(fontSize: 12, color: AppColors.textTertiary),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: _allStories(storiesState.groups).length,
                        itemBuilder: (_, i) {
                          final story = _allStories(storiesState.groups)[i];
                          return _StoryCard(story: story);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Story> _allStories(List<StoryGroup> groups) {
    return groups.expand((g) => g.stories).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  Future<void> _showCreateStory(BuildContext context, WidgetRef ref) async {
    // Server-side eligibility check: only users under daily goal can post
    final eligibility = await O2Service.instance.checkStoryEligibility();

    if (!context.mounted) return;

    if (!eligibility.eligible) {
      showModalBottomSheet(
        context: context,
        backgroundColor: AppColors.cardGradientStart,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (_) => Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40, height: 4,
                decoration: BoxDecoration(color: AppColors.cardBorder, borderRadius: BorderRadius.circular(2)),
              ),
              const SizedBox(height: 24),
              Container(
                width: 80, height: 80,
                decoration: BoxDecoration(
                  color: AppColors.ringDanger.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.block_rounded, color: AppColors.ringDanger, size: 40),
              ),
              const SizedBox(height: 16),
              const Text('Hikaye Paylasamazsin', style: AppTextStyles.h2),
              const SizedBox(height: 8),
              Text(
                eligibility.message ?? 'Gunluk ekran suresi hedefini astin. Hedefine sadik kalarak hikaye paylasma hakkini kazan!',
                style: const TextStyle(fontSize: 14, color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity, height: 48,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.cardBorder,
                    foregroundColor: AppColors.textPrimary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Tamam'),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.cardGradientStart,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _CreateStorySheet(ref: ref),
    );
  }
}

class _StoryCircle extends StatelessWidget {
  const _StoryCircle({required this.group});
  final StoryGroup group;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: group.hasUnviewed
                  ? const LinearGradient(
                      colors: [AppColors.neonGreen, Color(0xFF00C9DB)],
                    )
                  : null,
              color: group.hasUnviewed ? null : AppColors.cardBorder,
            ),
            padding: const EdgeInsets.all(2.5),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: group.avatarColor,
              ),
              child: Center(
                child: Text(
                  group.userName.isNotEmpty ? group.userName[0].toUpperCase() : '?',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          SizedBox(
            width: 64,
            child: Text(
              group.userName,
              style: const TextStyle(fontSize: 10, color: AppColors.textSecondary),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _StoryCard extends StatelessWidget {
  const _StoryCard({required this.story});
  final Story story;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.cardGradientStart, AppColors.cardGradientEnd],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User row
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: story.userAvatarColor ?? AppColors.textTertiary,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    (story.userName ?? '?')[0].toUpperCase(),
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(story.userName ?? 'Kullanici', style: AppTextStyles.body),
                    Text(story.remainingLabel, style: TextStyle(fontSize: 11, color: AppColors.textTertiary)),
                  ],
                ),
              ),
              if (story.activityType != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.neonGreen.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.neonGreen.withOpacity(0.3)),
                  ),
                  child: Text(
                    story.activityType!,
                    style: const TextStyle(fontSize: 10, color: AppColors.neonGreen, fontWeight: FontWeight.w500),
                  ),
                ),
            ],
          ),

          // Caption
          if (story.caption != null && story.caption!.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(story.caption!, style: AppTextStyles.body),
          ],

          // Image
          if (story.imageUrl != null) ...[
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                story.imageUrl!,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 200,
                  color: AppColors.cardBorder,
                  child: const Center(child: Icon(Icons.image_rounded, color: AppColors.textTertiary)),
                ),
              ),
            ),
          ],

          // Footer
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.visibility_rounded, size: 14, color: AppColors.textTertiary),
              const SizedBox(width: 4),
              Text('${story.viewCount}', style: TextStyle(fontSize: 11, color: AppColors.textTertiary)),
              const Spacer(),
              Icon(Icons.schedule_rounded, size: 14, color: AppColors.textTertiary),
              const SizedBox(width: 4),
              Text(story.remainingLabel, style: TextStyle(fontSize: 11, color: AppColors.textTertiary)),
            ],
          ),
        ],
      ),
    );
  }
}

class _CreateStorySheet extends StatefulWidget {
  const _CreateStorySheet({required this.ref});
  final WidgetRef ref;

  @override
  State<_CreateStorySheet> createState() => _CreateStorySheetState();
}

class _CreateStorySheetState extends State<_CreateStorySheet> {
  final _captionController = TextEditingController();
  String _selectedActivity = 'Yuruyus';
  int _durationHours = 24;
  bool _isPosting = false;

  static const _activities = [
    'Yuruyus',
    'Kosu',
    'Kitap',
    'Meditasyon',
    'Dogada',
    'Spor',
    'Muzik',
    'Yemek',
    'Arkadas',
    'Aile',
  ];

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, MediaQuery.of(context).viewInsets.bottom + 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.cardBorder,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text('Anti-Sosyal An', style: AppTextStyles.h2),
          const SizedBox(height: 4),
          Text(
            'Telefonundan uzakta ne yapiyorsun?',
            style: TextStyle(fontSize: 13, color: AppColors.textTertiary),
          ),
          const SizedBox(height: 16),

          // Activity chips
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _activities.map((a) {
              final selected = a == _selectedActivity;
              return GestureDetector(
                onTap: () => setState(() => _selectedActivity = a),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: selected ? AppColors.neonGreen.withOpacity(0.15) : AppColors.cardBorder.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: selected ? AppColors.neonGreen : AppColors.cardBorder,
                    ),
                  ),
                  child: Text(
                    a,
                    style: TextStyle(
                      fontSize: 13,
                      color: selected ? AppColors.neonGreen : AppColors.textSecondary,
                      fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),

          // Caption
          TextField(
            controller: _captionController,
            style: const TextStyle(color: AppColors.textPrimary),
            maxLength: 140,
            decoration: InputDecoration(
              hintText: 'Ne yapiyorsun? (opsiyonel)',
              hintStyle: TextStyle(color: AppColors.textTertiary),
              filled: true,
              fillColor: AppColors.cardBorder.withOpacity(0.3),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              counterStyle: TextStyle(color: AppColors.textTertiary),
            ),
          ),
          const SizedBox(height: 12),

          // Duration selector
          Row(
            children: [
              Text('Sure: ', style: AppTextStyles.body),
              const SizedBox(width: 8),
              ...[1, 6, 12, 24].map((h) {
                final selected = h == _durationHours;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () => setState(() => _durationHours = h),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: selected ? AppColors.neonGreen : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: selected ? AppColors.neonGreen : AppColors.cardBorder),
                      ),
                      child: Text(
                        '${h}s',
                        style: TextStyle(
                          fontSize: 13,
                          color: selected ? Colors.black : AppColors.textSecondary,
                          fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
          const SizedBox(height: 20),

          // Post button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: _isPosting ? null : _post,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.neonGreen,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              child: _isPosting
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black))
                  : const Text('Paylas'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _post() async {
    setState(() => _isPosting = true);
    await widget.ref.read(storiesProvider.notifier).createStory(
          caption: _captionController.text.isEmpty ? null : _captionController.text,
          activityType: _selectedActivity,
          durationHours: _durationHours,
        );
    if (mounted) {
      Navigator.pop(context);
    }
  }
}
