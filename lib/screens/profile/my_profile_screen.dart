import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/theme.dart';
import '../../widgets/app_card.dart';
import '../../widgets/app_usage_bar.dart';
import '../../widgets/level_badge.dart';
import '../../widgets/streak_calendar.dart';
import '../../widgets/badge_grid.dart' show BadgeGrid, BadgeItem;
import '../../providers/user_provider.dart';
import '../../providers/screen_time_provider.dart';
import '../../providers/ranking_provider.dart';
import '../../providers/badges_provider.dart';
import '../../widgets/premium_background.dart';

class MyProfileScreen extends ConsumerWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final st = ref.watch(todayScreenTimeProvider);
    final weekTotal = ref.watch(weekTotalProvider);
    final badges = ref.watch(badgeProvider);
    final friendRank = ref.watch(userFriendRankProvider);
    final cityRank = ref.watch(userCityRankProvider);
    final countryRank = ref.watch(userCountryRankProvider);

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: PremiumBackground(
        child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // Avatar + name
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(color: user.avatarColor, shape: BoxShape.circle),
                      child: Center(
                        child: Text(user.name[0].toUpperCase(), style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w600, color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(user.name, style: AppTextStyles.h1),
                        const SizedBox(width: 8),
                        LevelBadge(level: user.level),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(user.title, style: AppTextStyles.bodySecondary),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Week total
              AppCard(
                child: Center(
                  child: Column(
                    children: [
                      const Text('Bu Hafta', style: AppTextStyles.label),
                      const SizedBox(height: 4),
                      Text(weekTotal, style: AppTextStyles.heroNumber),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Rankings
              AppCard(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _RankItem(label: 'Arkadaslar', value: '$friendRank/8'),
                    _RankItem(label: user.city, value: '#$cityRank'),
                    _RankItem(label: 'Turkiye', value: '#$countryRank'),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // App usage
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Uygulama Kullanimi', style: AppTextStyles.h3),
                    const SizedBox(height: 12),
                    ...st.appUsage.map((app) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: AppUsageBar(appName: app.name, minutes: app.minutes, color: app.iconColor, maxMinutes: st.appUsage.first.minutes),
                    )),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Streak calendar
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${user.streak} gun streak', style: AppTextStyles.h3.copyWith(color: AppColors.neonGreen)),
                    const SizedBox(height: 12),
                    const StreakCalendar(
                      days: [StreakDay.success, StreakDay.success, StreakDay.success, StreakDay.partial, StreakDay.success, StreakDay.success, StreakDay.upcoming],
                      todayIndex: 5,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Badges
              const Text('Rozetler', style: AppTextStyles.h3),
              const SizedBox(height: 12),
              BadgeGrid(badges: badges.map((b) => BadgeItem(name: b.name, iconEmoji: b.iconEmoji, isEarned: b.isEarned)).toList()),
              const SizedBox(height: 24),

              // Share
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.share_rounded),
                  label: const Text('Profilimi Paylas'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.neonGreen,
                    foregroundColor: Colors.black,
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

class _RankItem extends StatelessWidget {
  const _RankItem({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
        const SizedBox(height: 2),
        Text(label, style: AppTextStyles.labelSmall),
      ],
    );
  }
}
