import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme.dart';
import '../../widgets/activity_ring.dart';
import '../../widgets/glassmorphic_card.dart';
import '../../widgets/premium_background.dart';
import '../../providers/screen_time_provider.dart';
import '../../providers/user_provider.dart';
import '../../providers/ranking_provider.dart';
import '../../providers/o2_provider.dart';
import '../../providers/duel_provider.dart';
import '../../models/duel.dart';
import '../../models/screen_time_data.dart';
import '../../services/haptic_service.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final st = ref.watch(todayScreenTimeProvider);
    final user = ref.watch(userProvider);
    final friendRank = ref.watch(userFriendRankProvider);
    final o2 = ref.watch(o2Provider);
    final duels = ref.watch(duelProvider);
    final activeDuels = duels.where((d) => d.status == DuelStatus.active).toList();

    final goalHours = st.goalMinutes ~/ 60;
    final isUnderGoal = st.goalProgress <= 1.0;

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: PremiumBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),

                // 1 — Top Bar
                _TopBar(userName: user.name),
                const SizedBox(height: 28),

                // 2 — Hero Ring
                Center(
                  child: ActivityRing(
                    value: st.goalProgress.clamp(0.0, 1.0),
                    size: 200,
                    strokeWidth: 16,
                    centerText: st.formattedToday,
                    subtitle: 'Bugün',
                    color: st.ringColor,
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isUnderGoal ? Icons.check_circle_rounded : Icons.warning_rounded,
                        size: 16,
                        color: isUnderGoal ? AppColors.ringGood : AppColors.ringDanger,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Günlük hedef: $goalHours saat',
                        style: AppTextStyles.label.copyWith(
                          color: isUnderGoal ? AppColors.ringGood : AppColors.ringDanger,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // 3 — Quick Stats Row
                Row(
                  children: [
                    Expanded(
                      child: _MiniStatCard(
                        emoji: '\u{1F525}',
                        value: '${user.streak} gün',
                        label: 'Streak',
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _MiniStatCard(
                        emoji: '\u{1FAE7}',
                        value: '${o2.balance}',
                        label: 'O\u2082 Puanı',
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _MiniStatCard(
                        emoji: '\u{1F3C6}',
                        value: '#$friendRank',
                        label: 'Sıralama',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // 4 — Big Focus Button
                _FocusButton(
                  onTap: () {
                    HapticService.medium();
                    context.push('/breathing');
                  },
                ),
                const SizedBox(height: 24),

                // 5 — Today's Apps
                _TodayAppsSection(st: st),
                const SizedBox(height: 24),

                // 6 — Active Duels
                _ActiveDuelsSection(activeDuels: activeDuels),
                const SizedBox(height: 24),

                // 7 — Quick Actions Grid
                const _QuickActionsGrid(),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// TOP BAR
// ─────────────────────────────────────────────

class _TopBar extends StatelessWidget {
  const _TopBar({required this.userName});
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Merhaba, $userName',
            style: AppTextStyles.h2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        IconButton(
          onPressed: () => context.push('/notifications'),
          icon: const Icon(Icons.notifications_none_rounded, color: AppColors.textSecondary, size: 24),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
        ),
        IconButton(
          onPressed: () {
            HapticService.light();
            context.push('/profile/settings');
          },
          icon: const Icon(Icons.settings_outlined, color: AppColors.textSecondary, size: 24),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// MINI STAT CARD
// ─────────────────────────────────────────────

class _MiniStatCard extends StatelessWidget {
  const _MiniStatCard({
    required this.emoji,
    required this.value,
    required this.label,
  });

  final String emoji;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return GlassmorphicCard(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      blurAmount: 15,
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 6),
          Text(value, style: AppTextStyles.h3.copyWith(fontSize: 16, fontWeight: FontWeight.w700)),
          const SizedBox(height: 2),
          Text(label, style: AppTextStyles.labelSmall),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// FOCUS BUTTON (breathing animation)
// ─────────────────────────────────────────────

class _FocusButton extends StatefulWidget {
  const _FocusButton({required this.onTap});
  final VoidCallback onTap;

  @override
  State<_FocusButton> createState() => _FocusButtonState();
}

class _FocusButtonState extends State<_FocusButton> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000))
      ..repeat(reverse: true);
    _scale = Tween(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scale,
      builder: (context, child) {
        return Transform.scale(
          scale: _scale.value,
          child: child,
        );
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            color: AppColors.neonGreen,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.neonGreen.withValues(alpha: 0.35),
                blurRadius: 24,
                spreadRadius: -4,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.self_improvement_rounded, color: Colors.black, size: 24),
              SizedBox(width: 10),
              Text(
                'Odaklan',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// TODAY'S APPS
// ─────────────────────────────────────────────

class _TodayAppsSection extends StatelessWidget {
  const _TodayAppsSection({required this.st});
  final ScreenTimeData st;

  @override
  Widget build(BuildContext context) {
    final apps = st.appUsage.take(3).toList();
    final maxMin = apps.isNotEmpty ? apps.first.minutes : 1;

    return GlassmorphicCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(child: Text('Bugünün Uygulamaları', style: AppTextStyles.h3)),
              GestureDetector(
                onTap: () {
                  HapticService.light();
                  context.push('/profile/stats/detailed');
                },
                child: Text(
                  'Tümünü Gör',
                  style: AppTextStyles.label.copyWith(color: AppColors.neonGreen),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          if (apps.isEmpty)
            const Text('Henüz veri yok', style: AppTextStyles.bodySecondary)
          else
            ...apps.map((app) {
              final fraction = (app.minutes / maxMin).clamp(0.0, 1.0);
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    SizedBox(
                      width: 80,
                      child: Text(
                        app.name,
                        style: AppTextStyles.label.copyWith(color: AppColors.textPrimary),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        height: 8,
                        decoration: BoxDecoration(
                          color: AppColors.cardBorder,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: fraction.toDouble(),
                          child: Container(
                            decoration: BoxDecoration(
                              color: app.iconColor,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 40,
                      child: Text(
                        '${app.minutes}dk',
                        style: AppTextStyles.labelSmall,
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              );
            }),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// ACTIVE DUELS
// ─────────────────────────────────────────────

class _ActiveDuelsSection extends StatelessWidget {
  const _ActiveDuelsSection({required this.activeDuels});
  final List<Duel> activeDuels;

  @override
  Widget build(BuildContext context) {
    if (activeDuels.isEmpty) {
      return GlassmorphicCard(
        glowColor: AppColors.neonOrange,
        onTap: () {
          HapticService.light();
          context.push('/duel/create');
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.bolt_rounded, color: AppColors.neonOrange, size: 22),
            const SizedBox(width: 8),
            Text(
              'Düello başlat!',
              style: AppTextStyles.h3.copyWith(color: AppColors.neonOrange),
            ),
          ],
        ),
      );
    }

    final duel = activeDuels.first;
    final isP1 = duel.player1.userId == 'user1';
    final you = isP1 ? duel.player1 : duel.player2;
    final opponent = isP1 ? duel.player2 : duel.player1;

    return GlassmorphicCard(
      glowColor: AppColors.neonOrange,
      onTap: () {
        HapticService.light();
        context.push('/duel/${duel.id}');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.bolt_rounded, color: AppColors.neonOrange, size: 18),
              const SizedBox(width: 6),
              Text('Aktif Düello', style: AppTextStyles.h3.copyWith(color: AppColors.neonOrange)),
              const Spacer(),
              if (activeDuels.length > 1)
                Text('+${activeDuels.length - 1} daha', style: AppTextStyles.labelSmall),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _DuelPlayerChip(name: 'Sen', minutes: you.totalMinutes, color: you.avatarColor),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text('vs', style: AppTextStyles.label),
              ),
              _DuelPlayerChip(name: opponent.name, minutes: opponent.totalMinutes, color: opponent.avatarColor),
            ],
          ),
        ],
      ),
    );
  }
}

class _DuelPlayerChip extends StatelessWidget {
  const _DuelPlayerChip({required this.name, required this.minutes, required this.color});
  final String name;
  final int minutes;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          CircleAvatar(radius: 12, backgroundColor: color, child: Text(name[0], style: const TextStyle(fontSize: 11, color: Colors.white))),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: AppTextStyles.label.copyWith(color: AppColors.textPrimary)),
              Text('${minutes}dk', style: AppTextStyles.labelSmall),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// QUICK ACTIONS GRID (2x2)
// ─────────────────────────────────────────────

class _QuickActionsGrid extends StatelessWidget {
  const _QuickActionsGrid();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _ActionCard(
                icon: Icons.diamond_outlined,
                label: 'Ganimetler',
                color: AppColors.gold,
                onTap: () => context.push('/ganimetler'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _ActionCard(
                icon: Icons.people_outline_rounded,
                label: 'Gruplar',
                color: AppColors.wrappedGradient3.first,
                onTap: () => context.push('/groups'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _ActionCard(
                icon: Icons.eco_outlined,
                label: 'O\u2082 Puanı',
                color: AppColors.neonGreen,
                onTap: () => context.push('/o2'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _ActionCard(
                icon: Icons.share_rounded,
                label: 'Havamı At',
                color: AppColors.neonOrange,
                onTap: () => context.push('/wrapped'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GlassmorphicCard(
      glowColor: color,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 14),
      onTap: () {
        HapticService.light();
        onTap();
      },
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(label, style: AppTextStyles.h3.copyWith(fontSize: 13)),
        ],
      ),
    );
  }
}
