import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme.dart';
import '../../widgets/premium_background.dart';
import '../../widgets/app_card.dart';
import '../../widgets/ranking_row.dart';
import '../../widgets/shame_wall_card.dart';
import '../../providers/groups_provider.dart';

class GroupDetailScreen extends ConsumerWidget {
  const GroupDetailScreen({super.key, required this.groupId});
  final String groupId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groups = ref.watch(groupProvider);
    final group = groups.firstWhere((g) => g.id == groupId, orElse: () => groups.first);
    final sorted = [...group.members]..sort((a, b) => a.weekMinutes.compareTo(b.weekMinutes));

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: PremiumBackground(
        child: SafeArea(
          child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(onTap: () => context.pop(), child: const Icon(Icons.arrow_back_rounded, color: AppColors.textPrimary)),
                  const SizedBox(width: 12),
                  Expanded(child: Text(group.name, style: AppTextStyles.h1)),
                ],
              ),
              const SizedBox(height: 8),
              Text('${group.memberCount} uye', style: AppTextStyles.bodySecondary),
              const SizedBox(height: 24),

              // Challenge
              AppCard(
                topAccentColor: AppColors.neonGreen,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Haftalık Hedef', style: AppTextStyles.label),
                    const SizedBox(height: 4),
                    Text(group.challengeDescription, style: AppTextStyles.h3),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: group.challengeProgress,
                        backgroundColor: AppColors.cardBorder,
                        color: AppColors.neonGreen,
                        minHeight: 8,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text('%${(group.challengeProgress * 100).round()} tamamlandi', style: AppTextStyles.labelSmall),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Member ranking
              const Text('Uyeler', style: AppTextStyles.h3),
              const SizedBox(height: 12),
              ...List.generate(sorted.length, (i) {
                final m = sorted[i];
                return RankingRow(
                  rank: i + 1,
                  name: m.name,
                  avatarColor: m.avatarColor,
                  level: m.level,
                  totalMinutes: m.weekMinutes,
                  isCurrentUser: m.name == 'Ege',
                );
              }),
              const SizedBox(height: 16),

              // Shame wall
              if (sorted.isNotEmpty)
                ShameWallCard(
                  name: sorted.last.name,
                  avatarColor: sorted.last.avatarColor,
                  totalMinutes: sorted.last.weekMinutes,
                  topApp: 'Instagram',
                  topAppMinutes: (sorted.last.weekMinutes * 0.4).round(),
                ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.person_add_rounded),
                  label: const Text('Davet Et'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.neonGreen,
                    side: const BorderSide(color: AppColors.neonGreen),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      ),
    );
  }
}
