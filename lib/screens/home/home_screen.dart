import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme.dart';
import '../../widgets/activity_ring.dart';
import '../../widgets/app_card.dart';
import '../../widgets/app_icon_widget.dart';
import '../../widgets/friend_tile.dart';
import '../../widgets/stat_tile.dart';
import '../../widgets/glitch_effect.dart';
import '../../providers/screen_time_provider.dart';
import '../../providers/user_provider.dart';
import '../../providers/friends_provider.dart';
import '../../providers/ranking_provider.dart';
import '../../providers/o2_provider.dart';
import '../../widgets/premium_background.dart';
import '../../services/haptic_service.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final st = ref.watch(todayScreenTimeProvider);
    final user = ref.watch(userProvider);
    final friends = ref.watch(friendsProvider);
    final friendRank = ref.watch(userFriendRankProvider);
    final cityRank = ref.watch(userCityRankProvider);
    final o2 = ref.watch(o2Provider);

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: PremiumBackground(
        child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // Top bar
              Row(
                children: [
                  const Text(
                    'gooffgrid',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const Spacer(),
                  // O2 Balance chip
                  GestureDetector(
                    onTap: () {
                      HapticService.light();
                      context.push('/o2');
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.neonGreen.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.neonGreen.withOpacity(0.25)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('O₂', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.neonGreen.withOpacity(0.7))),
                          const SizedBox(width: 4),
                          Text('${o2.balance}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.neonGreen)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.notifications_none_rounded, color: AppColors.textSecondary, size: 24),
                  const SizedBox(width: 12),
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: user.avatarColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Activity Ring — hedef aşımında glitch efekti
              Center(
                child: GlitchBurst(
                  trigger: st.goalProgress > 1.0,
                  child: ActivityRing(
                    value: st.goalProgress.clamp(0.0, 1.0),
                    size: 180,
                    centerText: st.formattedToday,
                    subtitle: 'Bugün',
                    color: st.ringColor,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Goal bar
              AppCard(
                child: Row(
                  children: [
                    Text('Hedef: ${st.goalMinutes ~/ 60} saat', style: AppTextStyles.label),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        height: 6,
                        decoration: BoxDecoration(
                          color: AppColors.cardBorder,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: st.goalProgress.clamp(0.0, 1.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: st.ringColor,
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text('%${st.goalPercentage}', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: st.ringColor)),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Quick stats
              Row(
                children: [
                  Expanded(child: StatTile(value: '${user.streak} gün', label: 'streak', color: AppColors.neonGreen)),
                  const SizedBox(width: 8),
                  Expanded(child: StatTile(value: '#$cityRank', label: user.city, color: AppColors.textSecondary)),
                  const SizedBox(width: 8),
                  Expanded(child: StatTile(value: '$friendRank/8', label: 'arkadaş', color: AppColors.textSecondary)),
                ],
              ),
              const SizedBox(height: 24),

              // Friends feed
              Row(
                children: [
                  const Text('Arkadaşların', style: AppTextStyles.h3),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      HapticService.light();
                      context.push('/friends');
                    },
                    child: Text('Tumu >', style: AppTextStyles.bodySecondary.copyWith(color: AppColors.neonGreen, fontSize: 13)),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 180,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: friends.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemBuilder: (context, i) {
                    final f = friends[i];
                    return GestureDetector(
                      onTap: () => context.push('/friend/${f.profile.id}'),
                      child: FriendTile(
                        name: f.profile.name,
                        avatarColor: f.profile.avatarColor,
                        todayMinutes: f.todayMinutes,
                        isOnline: f.isOnline,
                        topApps: [
                          FriendTileApp(name: f.topApp, color: AppColors.instagram, minutes: f.topAppMinutes),
                          FriendTileApp(name: 'Diger', color: AppColors.cardBorder, minutes: f.todayMinutes - f.topAppMinutes),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),

              // App usage — native ikonlarla
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Bugün ne kullandın?', style: AppTextStyles.h3),
                    const SizedBox(height: 16),
                    PlatformAppUsageList(
                      apps: st.appUsage,
                      maxMinutes: st.appUsage.isNotEmpty ? st.appUsage.first.minutes : 1,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Action buttons — 2 rows
              Row(
                children: [
                  Expanded(
                    child: AppCard(
                      borderColor: AppColors.neonGreen,
                      onTap: () {
                        HapticService.light();
                        context.push('/breathing');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.self_improvement_rounded, color: AppColors.neonGreen, size: 20),
                          const SizedBox(width: 8),
                          Text('Odak Modu', style: AppTextStyles.h3.copyWith(color: AppColors.neonGreen, fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppCard(
                      borderColor: AppColors.neonOrange,
                      onTap: () {
                        HapticService.light();
                        context.push('/duel/create');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.bolt_rounded, color: AppColors.neonOrange, size: 20),
                          const SizedBox(width: 8),
                          Text('Düello', style: AppTextStyles.h3.copyWith(color: AppColors.neonOrange, fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: AppCard(
                      onTap: () {
                        HapticService.light();
                        context.push('/stories');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.auto_stories_rounded, color: AppColors.textSecondary, size: 20),
                          const SizedBox(width: 8),
                          Text('Hikayeler', style: AppTextStyles.h3.copyWith(fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        HapticService.medium();
                        context.push('/wrapped');
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.neonGreen,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.share_rounded, color: Colors.black, size: 20),
                            SizedBox(width: 8),
                            Text('Havamı At', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
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
