import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../config/app_shadows.dart';
import '../../config/design_tokens.dart';
import '../../config/theme.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/o2_provider.dart';
import '../../providers/screen_time_provider.dart';
import '../../providers/user_provider.dart';
import '../../services/haptic_service.dart';
import '../../widgets/bento/bento_card.dart';
import '../../widgets/bento/hero_card.dart';
import '../../widgets/bento/preset_tile.dart';
import '../../widgets/bento/stat_tile.dart';
import '../../widgets/floating_timer_overlay.dart';

String _greeting() {
  final hour = DateTime.now().hour;
  if (hour < 6) return 'İyi geceler';
  if (hour < 12) return 'Günaydın';
  if (hour < 18) return 'İyi günler';
  return 'İyi akşamlar';
}

/// Opal-inspired bento home screen.
class HomeScreenBento extends ConsumerWidget {
  const HomeScreenBento({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final user = ref.watch(userProvider);
    final o2 = ref.watch(o2Provider);
    final st = ref.watch(todayScreenTimeProvider);

    final offline = (1440 - st.totalMinutes).clamp(0, 1440);
    final offlineStr = offline >= 60
        ? '${offline ~/ 60}s ${offline % 60}dk'
        : '${offline}dk';

    // Stagger delays for each section (ms)
    const staggerBase = 80;

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.s5,
                AppSpacing.s3,
                AppSpacing.s5,
                AppSpacing.s16 + AppSpacing.s10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top bar
                  _StaggerEntry(
                    delay: Duration.zero,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _greeting(),
                                style: AppType.caption.copyWith(
                                  color: AppColors.textTertiary,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                l.hello(user.name),
                                style: AppType.h2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        _IconBtn(
                          icon: Icons.notifications_none_rounded,
                          onTap: () => context.push('/notifications'),
                        ),
                        const SizedBox(width: AppSpacing.s2),
                        _IconBtn(
                          icon: Icons.settings_outlined,
                          onTap: () {
                            HapticService.light();
                            context.push('/profile/settings');
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.s6),

                  // Hero — Deep Focus with ambient glow
                  _StaggerEntry(
                    delay: const Duration(milliseconds: staggerBase),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // Ambient glow behind hero
                        Positioned.fill(
                          child: Container(
                            margin: const EdgeInsets.all(-12),
                            decoration: BoxDecoration(
                              gradient: AppGradients.meshGlow,
                              borderRadius: BorderRadius.circular(
                                AppRadius.l + 12,
                              ),
                            ),
                          ),
                        ),
                        HeroCard(
                          emoji: '🧘',
                          title: 'Deep Focus',
                          subtitle:
                              'Telefonu bırak, derin odaklanmaya gir. Seans süresince bildirimleri sustur.',
                          ctaLabel: 'Seans başlat',
                          onTap: () {
                            HapticService.medium();
                            context.push('/sessions/setup');
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.s3),

                  // Streak + Gems row
                  _StaggerEntry(
                    delay: const Duration(milliseconds: staggerBase * 2),
                    child: Row(
                      children: [
                        Expanded(
                          child: _withShadow(
                            child: StatTile(
                              emoji: '🔥',
                              value: '${user.streak}',
                              label: 'Gün serisi',
                              accent: AppColors.neonOrange,
                              onTap: () => context.push('/stats'),
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.s3),
                        Expanded(
                          child: _withShadow(
                            child: StatTile(
                              emoji: '💎',
                              value: '${o2.balance}',
                              label: 'O₂ kristali',
                              accent: AppColors.neonGreen,
                              onTap: () => context.push('/o2'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.s3),

                  // Today's wins strip
                  _StaggerEntry(
                    delay: const Duration(milliseconds: staggerBase * 3),
                    child: BentoCard(
                      padding: const EdgeInsets.all(AppSpacing.s5),
                      accent: const Color(0xFF4FACFE),
                      child: Row(
                        children: [
                          const Text('🏆', style: TextStyle(fontSize: 32)),
                          const SizedBox(width: AppSpacing.s4),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Bugünkü kazancın',
                                    style: AppType.caption),
                                const SizedBox(height: 2),
                                Text(
                                  '$offlineStr ekran dışı',
                                  style: AppType.title,
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.chevron_right_rounded,
                            color: Colors.white.withValues(alpha: 0.4),
                            size: 26,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.s6),

                  // Section title — MODLAR
                  _StaggerEntry(
                    delay: const Duration(milliseconds: staggerBase * 4),
                    child: Padding(
                      padding: const EdgeInsets.only(left: AppSpacing.s1),
                      child: Text(
                        'MODLAR',
                        style: AppType.label.copyWith(letterSpacing: 1.5),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.s3),

                  // Preset grid
                  _StaggerEntry(
                    delay: const Duration(milliseconds: staggerBase * 5),
                    child: GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: AppSpacing.s3,
                      crossAxisSpacing: AppSpacing.s3,
                      childAspectRatio: 1.1,
                      children: [
                        PresetTile(
                          emoji: '🎯',
                          title: 'Düello',
                          subtitle: 'Arkadaşınla yarış',
                          accent: AppColors.neonGreen,
                          onTap: () => context.push('/duel'),
                        ),
                        PresetTile(
                          emoji: '🎉',
                          title: 'Grup Modu',
                          subtitle: 'Birlikte odaklan',
                          accent: const Color(0xFFF093FB),
                          onTap: () => context.push('/groups'),
                        ),
                        PresetTile(
                          emoji: '😴',
                          title: 'Uyku Modu',
                          subtitle: 'Gece sessizliği',
                          accent: const Color(0xFF667EEA),
                          onTap: () => context.push('/breathing'),
                        ),
                        PresetTile(
                          emoji: '🏫',
                          title: 'Okul Modu',
                          subtitle: 'Ders zamanı',
                          accent: const Color(0xFFFFD700),
                          onTap: () => context.push('/appblock'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.s6),

                  // Quick actions — HIZLI ERİŞİM
                  _StaggerEntry(
                    delay: const Duration(milliseconds: staggerBase * 6),
                    child: Padding(
                      padding: const EdgeInsets.only(left: AppSpacing.s1),
                      child: Text(
                        'HIZLI ERİŞİM',
                        style: AppType.label.copyWith(letterSpacing: 1.5),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.s3),
                  _StaggerEntry(
                    delay: const Duration(milliseconds: staggerBase * 7),
                    child: Row(
                      children: [
                        Expanded(
                          child: PresetTile(
                            emoji: '📊',
                            title: 'İstatistik',
                            accent: const Color(0xFF4FACFE),
                            onTap: () => context.push('/stats'),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.s3),
                        Expanded(
                          child: PresetTile(
                            emoji: '🏆',
                            title: 'Sıralama',
                            accent: AppColors.gold,
                            onTap: () => context.push('/ranking'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.s3),
                  _StaggerEntry(
                    delay: const Duration(milliseconds: staggerBase * 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: PresetTile(
                            emoji: '👥',
                            title: 'Arkadaşlar',
                            accent: const Color(0xFFA8EB12),
                            onTap: () => context.push('/profile/friends'),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.s3),
                        Expanded(
                          child: PresetTile(
                            emoji: '🛒',
                            title: 'Market',
                            accent: AppColors.neonOrange,
                            onTap: () => context.push('/market'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const FloatingTimerOverlay(),
        ],
      ),
    );
  }

  static Widget _withShadow({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: AppShadow.sm,
        borderRadius: BorderRadius.circular(AppRadius.m),
      ),
      child: child,
    );
  }
}

class _IconBtn extends StatelessWidget {
  const _IconBtn({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(AppRadius.s),
          border: Border.all(color: AppColors.cardBorder),
        ),
        child: Icon(icon, color: AppColors.textSecondary, size: 20),
      ),
    );
  }
}

/// Fade-in + slide-up entrance with a stagger delay.
/// Uses [TweenAnimationBuilder] — no AnimationController needed.
class _StaggerEntry extends StatelessWidget {
  const _StaggerEntry({
    required this.delay,
    required this.child,
  });

  final Duration delay;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return _DelayedFadeSlide(delay: delay, child: child);
  }
}

class _DelayedFadeSlide extends StatefulWidget {
  const _DelayedFadeSlide({required this.delay, required this.child});
  final Duration delay;
  final Widget child;

  @override
  State<_DelayedFadeSlide> createState() => _DelayedFadeSlideState();
}

class _DelayedFadeSlideState extends State<_DelayedFadeSlide>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _opacity;
  late final Animation<Offset> _offset;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
    _opacity = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _offset = Tween<Offset>(
      begin: const Offset(0, 16),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));

    Future.delayed(widget.delay, () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, child) => Opacity(
        opacity: _opacity.value,
        child: Transform.translate(
          offset: _offset.value,
          child: child,
        ),
      ),
      child: widget.child,
    );
  }
}
