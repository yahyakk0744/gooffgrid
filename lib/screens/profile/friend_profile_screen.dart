import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme.dart';
import '../../widgets/premium_background.dart';
import '../../widgets/app_card.dart';
import '../../widgets/level_badge.dart';
import '../../widgets/reaction_row.dart';
import '../../providers/friends_provider.dart';

class FriendProfileScreen extends ConsumerWidget {
  const FriendProfileScreen({super.key, required this.friendId});
  final String friendId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final friends = ref.watch(friendsProvider);
    final friend = friends.firstWhere(
      (f) => f.profile.id == friendId,
      orElse: () => friends.first,
    );
    final p = friend.profile;

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: PremiumBackground(
        child: SafeArea(
          child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Back
              Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: const Icon(Icons.arrow_back_rounded, color: AppColors.textPrimary),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Reactions
              const ReactionRow(counts: {'fire': 3, 'clap': 5}),
              const SizedBox(height: 16),

              // Avatar
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(color: p.avatarColor, shape: BoxShape.circle),
                child: Center(
                  child: Text(p.name[0].toUpperCase(), style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w600, color: Colors.white)),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(p.name, style: AppTextStyles.h1),
                  const SizedBox(width: 8),
                  LevelBadge(level: p.level),
                ],
              ),
              Text(p.title, style: AppTextStyles.bodySecondary),
              const SizedBox(height: 24),

              // Today
              AppCard(
                child: Center(
                  child: Column(
                    children: [
                      const Text('Bugün', style: AppTextStyles.label),
                      const SizedBox(height: 4),
                      Text(
                        '${friend.todayMinutes}dk',
                        style: AppTextStyles.heroNumber.copyWith(
                          color: friend.todayMinutes < 120 ? AppColors.ringGood : friend.todayMinutes < 240 ? AppColors.ringWarning : AppColors.ringDanger,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Stats
              AppCard(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _Stat(label: 'Streak', value: '${p.streak}'),
                    _Stat(label: 'Level', value: '${p.level}'),
                    _Stat(label: 'Puan', value: '${p.totalPoints}'),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Top app
              AppCard(
                child: Row(
                  children: [
                    const Text('En cok:', style: AppTextStyles.label),
                    const SizedBox(width: 8),
                    Text(friend.topApp, style: AppTextStyles.h3),
                    const Spacer(),
                    Text('${friend.topAppMinutes}dk', style: AppTextStyles.bodySecondary),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Duel button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.bolt_rounded),
                  label: const Text('Duel Baslat'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.neonOrange,
                    foregroundColor: Colors.white,
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

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
        Text(label, style: AppTextStyles.labelSmall),
      ],
    );
  }
}
