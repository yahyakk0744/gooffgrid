import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme.dart';
import '../../l10n/app_localizations.dart';
import '../../services/haptic_service.dart';
import '../../widgets/app_card.dart';
import '../../widgets/app_usage_bar.dart';
import '../../widgets/level_badge.dart';
import '../../widgets/streak_calendar.dart';
import '../../providers/user_provider.dart';
import '../../providers/screen_time_provider.dart';
import '../../providers/ranking_provider.dart';
import '../../widgets/premium_background.dart';
import '../../config/app_shadows.dart';
import '../../config/design_tokens.dart';

class MyProfileScreen extends ConsumerWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final user = ref.watch(userProvider);
    final st = ref.watch(todayScreenTimeProvider);
    final weekTotal = ref.watch(weekTotalProvider);
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
                      decoration: BoxDecoration(
                        color: user.avatarColor,
                        shape: BoxShape.circle,
                        boxShadow: AppShadow.glow(user.avatarColor, intensity: 0.4, blur: 20),
                      ),
                      child: Center(
                        child: Text(user.name[0].toUpperCase(), style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w600, color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(user.name, style: AppType.h2),
                        const SizedBox(width: 8),
                        LevelBadge(level: user.level),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                            HapticService.light();
                            context.go('/profile/edit');
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: AppColors.cardBg,
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.cardBorder),
                            ),
                            child: const Icon(
                              Icons.edit_rounded,
                              size: 16,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(user.title, style: AppType.caption),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Week total
              AppCard(
                child: Center(
                  child: Column(
                    children: [
                      Text(l.thisWeek.toUpperCase(), style: AppType.label),
                      const SizedBox(height: 4),
                      Text(weekTotal, style: AppType.monoDisplay.copyWith(fontSize: 36)),
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
                    _RankItem(label: l.seriFriends, value: '$friendRank/8'),
                    _RankItem(label: user.city, value: '#$cityRank'),
                    _RankItem(label: l.turkey, value: '#$countryRank'),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // App usage
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l.appUsage.toUpperCase(), style: AppType.label),
                    const SizedBox(height: 12),
                    ...st.appUsage.map((app) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: AppUsageBar(appName: app.name, minutes: app.minutes, color: app.iconColor, maxMinutes: st.appUsage.first.minutes),
                    )),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Streak — premium design
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [AppColors.neonOrange, AppColors.neonOrange.withValues(alpha: 0.6)],
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(color: AppColors.neonOrange.withValues(alpha: 0.3), blurRadius: 12),
                            ],
                          ),
                          child: const Center(child: Text('🔥', style: TextStyle(fontSize: 22))),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text('${user.streak}', style: AppType.mono.copyWith(fontSize: 28, fontWeight: FontWeight.w800, color: AppColors.neonOrange)),
                                const SizedBox(width: 6),
                                Text(l.consecutiveDays, style: AppType.body),
                              ],
                            ),
                            Text(l.bestStreakLabel(user.bestStreak), style: AppType.caption.copyWith(color: AppColors.textTertiary)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const StreakCalendar(
                      days: [StreakDay.success, StreakDay.success, StreakDay.success, StreakDay.partial, StreakDay.success, StreakDay.success, StreakDay.upcoming],
                      todayIndex: 5,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Quick actions
              AppCard(
                child: Column(
                  children: [
                    _QuickAction(
                      icon: Icons.insights_rounded,
                      color: AppColors.neonGreen,
                      label: l.detailedScreenTime,
                      onTap: () {
                        HapticService.light();
                        context.push('/profile/stats/detailed');
                      },
                    ),
                    Divider(color: AppColors.divider, height: 1),
                    _QuickAction(
                      icon: Icons.bar_chart_rounded,
                      color: const Color(0xFF4FACFE),
                      label: l.stats,
                      onTap: () {
                        HapticService.light();
                        context.push('/profile/stats');
                      },
                    ),
                    Divider(color: AppColors.divider, height: 1),
                    _QuickAction(
                      icon: Icons.emoji_events_rounded,
                      color: AppColors.gold,
                      label: l.monthlyTop10,
                      onTap: () {
                        HapticService.light();
                        context.push('/profile/stats/monthly-top10');
                      },
                    ),
                    Divider(color: AppColors.divider, height: 1),
                    _QuickAction(
                      icon: Icons.settings_rounded,
                      color: AppColors.textSecondary,
                      label: l.settings,
                      onTap: () {
                        HapticService.light();
                        context.push('/profile/settings');
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Share
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.share_rounded),
                  label: Text(l.shareProfile),
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

class _QuickAction extends StatelessWidget {
  const _QuickAction({required this.icon, required this.color, required this.label, required this.onTap});
  final IconData icon;
  final Color color;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(width: 12),
            Expanded(child: Text(label, style: AppType.body)),
            const Icon(Icons.chevron_right_rounded, color: AppColors.textTertiary, size: 20),
          ],
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
        Text(value, style: AppType.mono.copyWith(fontSize: 18, fontWeight: FontWeight.w700)),
        const SizedBox(height: 2),
        Text(label, style: AppType.caption.copyWith(fontSize: 10, color: AppColors.textTertiary)),
      ],
    );
  }
}
