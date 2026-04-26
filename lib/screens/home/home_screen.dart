import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme.dart';
import '../../widgets/floating_timer_overlay.dart';
import '../../providers/screen_time_provider.dart';
import '../../providers/user_provider.dart';
import '../../providers/o2_provider.dart';
import '../../providers/duel_provider.dart';
import '../../providers/session_log_provider.dart';
import '../../models/duel.dart';
import '../../models/app_usage_entry.dart';
import '../../models/screen_time_data.dart';
import '../../services/haptic_service.dart';
import '../../l10n/app_localizations.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final st = ref.watch(todayScreenTimeProvider);
    final user = ref.watch(userProvider);
    final o2 = ref.watch(o2Provider);
    final duels = ref.watch(duelProvider);
    final activeDuels =
        duels.where((d) => d.status == DuelStatus.active).toList();
    final sessionLog = ref.watch(sessionLogProvider.notifier);
    final streak = sessionLog.currentStreak > 0
        ? sessionLog.currentStreak
        : user.streak;
    final focusScore = sessionLog.focusScore;
    final last7 = sessionLog.last7Days;

    final offline = (1440 - st.totalMinutes).clamp(0, 1440);
    final screenRatio = st.totalMinutes > 0
        ? (st.totalMinutes / 1440).clamp(0.0, 1.0)
        : 0.0;
    // Ghost opacity: less phone = more visible
    final ghostOpacity = (1.0 - screenRatio).clamp(0.3, 1.0);

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          // Ambient glow behind hero ring
          Positioned(
            top: -80,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.neonGreen.withValues(alpha: 0.06),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),

                  // ── TOP BAR ──
                  Row(
                    children: [
                      // Ghost avatar
                      Opacity(
                        opacity: ghostOpacity,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                AppColors.neonGreen.withValues(alpha: 0.3),
                                AppColors.neonGreen.withValues(alpha: 0.1),
                              ],
                            ),
                            border: Border.all(
                              color:
                                  AppColors.neonGreen.withValues(alpha: 0.4),
                              width: 1.5,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              user.name.isNotEmpty
                                  ? user.name[0].toUpperCase()
                                  : '?',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColors.neonGreen
                                    .withValues(alpha: ghostOpacity),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l.hello(user.name),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              ghostOpacity > 0.7
                                  ? 'Güçlü görünüyorsun 💪'
                                  : ghostOpacity > 0.5
                                      ? 'Hayaletleşiyorsun 👻'
                                      : 'Telefonu bırak...',
                              style: TextStyle(
                                fontSize: 11,
                                color: AppColors.textTertiary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      _GlassIcon(
                        icon: Icons.notifications_none_rounded,
                        onTap: () => context.push('/notifications'),
                      ),
                      const SizedBox(width: 8),
                      _GlassIcon(
                        icon: Icons.settings_outlined,
                        onTap: () => context.push('/profile/settings'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),

                  // ── HERO: BREATHING RING ──
                  Center(
                    child: _BreathingRing(
                      progress: st.goalProgress.clamp(0.0, 1.0),
                      screenTime: st.formattedToday,
                      offlineMin: offline,
                      color: st.ringColor,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // ── STREAK + O₂ + RANK — glass row ──
                  _GlassStatsRow(
                    streak: streak,
                    o2: o2.balance,
                    focusScore: focusScore,
                    freezeTokens: user.freezeTokens,
                    last7: last7,
                    onStreakTap: () => context.push('/stats'),
                    onO2Tap: () => context.push('/o2'),
                  ),
                  const SizedBox(height: 20),

                  // ── FOCUS + NEFES BUTTONS ──
                  _PremiumFocusButton(
                    onTap: () {
                      HapticService.medium();
                      context.push('/sessions/setup');
                    },
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      HapticService.light();
                      context.push('/breathing');
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: const Color(0xFF667EEA).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color(0xFF667EEA).withValues(alpha: 0.2),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('🍃', style: TextStyle(fontSize: 20)),
                              SizedBox(width: 10),
                              Text(
                                'Nefes Egzersizi',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF667EEA),
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // ── ACTIVE DUELS ──
                  if (activeDuels.isNotEmpty) ...[
                    _SectionHeader(title: 'Aktif Düellolar', emoji: '⚔️'),
                    const SizedBox(height: 10),
                    ...activeDuels.take(3).map((d) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: _DuelCard(
                            duel: d,
                            onTap: () =>
                                context.push('/duel/${d.id}'),
                          ),
                        )),
                    const SizedBox(height: 14),
                  ],

                  // ── TODAY'S APPS ──
                  _SectionHeader(title: 'Bugünkü Kullanım', emoji: '📊'),
                  const SizedBox(height: 10),
                  _AppUsageStrip(st: st),
                  const SizedBox(height: 24),

                  // ── QUICK ACTIONS ──
                  _SectionHeader(title: 'Hızlı Erişim', emoji: '⚡'),
                  const SizedBox(height: 10),
                  _QuickActionsGrid(),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),

          const FloatingTimerOverlay(),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════
// GLASS ICON BUTTON
// ═══════════════════════════════════════════════

class _GlassIcon extends StatelessWidget {
  const _GlassIcon({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticService.light();
        onTap();
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: Colors.white.withValues(alpha: 0.08)),
            ),
            child: Icon(icon, color: AppColors.textSecondary, size: 18),
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════
// BREATHING RING — pulses like a heartbeat
// ═══════════════════════════════════════════════

class _BreathingRing extends StatefulWidget {
  const _BreathingRing({
    required this.progress,
    required this.screenTime,
    required this.offlineMin,
    required this.color,
  });

  final double progress;
  final String screenTime;
  final int offlineMin;
  final Color color;

  @override
  State<_BreathingRing> createState() => _BreathingRingState();
}

class _BreathingRingState extends State<_BreathingRing>
    with SingleTickerProviderStateMixin {
  late final AnimationController _breath;

  @override
  void initState() {
    super.initState();
    _breath = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _breath.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _breath,
      builder: (context, child) {
        final breathVal = Curves.easeInOut.transform(_breath.value);
        final scale = 0.96 + breathVal * 0.04;
        final glowAlpha = 0.15 + breathVal * 0.2;

        return Transform.scale(
          scale: scale,
          child: SizedBox(
            width: 220,
            height: 220,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Glow
                Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: widget.color.withValues(alpha: glowAlpha),
                        blurRadius: 40,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                ),
                // Ring
                CustomPaint(
                  size: const Size(200, 200),
                  painter: _RingPainter(
                    progress: widget.progress,
                    color: widget.color,
                    breathAlpha: glowAlpha,
                  ),
                ),
                // Center text
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.screenTime,
                      style: const TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: -2,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${_formatOffline(widget.offlineMin)} ekran dışı',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _formatOffline(int m) {
    if (m >= 60) return '${m ~/ 60}s ${m % 60}dk';
    return '${m}dk';
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({
    required this.progress,
    required this.color,
    required this.breathAlpha,
  });

  final double progress;
  final Color color;
  final double breathAlpha;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 8;
    const strokeWidth = 10.0;

    // Track
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..color = Colors.white.withValues(alpha: 0.06),
    );

    // Progress arc
    if (progress > 0) {
      final rect = Rect.fromCircle(center: center, radius: radius);
      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round
        ..shader = SweepGradient(
          startAngle: -math.pi / 2,
          endAngle: 3 * math.pi / 2,
          colors: [
            color.withValues(alpha: 0.4),
            color,
          ],
        ).createShader(rect)
        ..maskFilter =
            MaskFilter.blur(BlurStyle.solid, breathAlpha * 4);

      canvas.drawArc(
        rect,
        -math.pi / 2,
        2 * math.pi * progress,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _RingPainter old) =>
      old.progress != progress || old.breathAlpha != breathAlpha;
}

// ═══════════════════════════════════════════════
// GLASS STATS ROW — streak + O₂ + focus score
// ═══════════════════════════════════════════════

class _GlassStatsRow extends StatelessWidget {
  const _GlassStatsRow({
    required this.streak,
    required this.o2,
    required this.focusScore,
    required this.last7,
    required this.onStreakTap,
    required this.onO2Tap,
    this.freezeTokens = 0,
  });

  final int streak;
  final int o2;
  final double focusScore;
  final int freezeTokens;
  final List<bool> last7;
  final VoidCallback onStreakTap;
  final VoidCallback onO2Tap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  _GlassStat(
                    icon: '🔥',
                    value: '$streak',
                    label: freezeTokens > 0 ? 'Seri · 🧊$freezeTokens' : 'Seri',
                    color: AppColors.neonOrange,
                    onTap: onStreakTap,
                  ),
                  _GlassStat(
                    icon: '🍃',
                    value: '$o2',
                    label: 'O₂',
                    color: AppColors.neonGreen,
                    onTap: onO2Tap,
                  ),
                  _GlassStat(
                    icon: '⚡',
                    value: '${focusScore.round()}',
                    label: 'Odak',
                    color: focusScore >= 70
                        ? AppColors.neonGreen
                        : focusScore >= 40
                            ? AppColors.neonOrange
                            : AppColors.ringDanger,
                    onTap: onStreakTap,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // 7-day dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(7, (i) {
                  final active = i < last7.length && last7[i];
                  return Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: active
                          ? AppColors.neonGreen
                          : Colors.white.withValues(alpha: 0.1),
                      boxShadow: active
                          ? [
                              BoxShadow(
                                  color: AppColors.neonGreen
                                      .withValues(alpha: 0.5),
                                  blurRadius: 6)
                            ]
                          : null,
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GlassStat extends StatelessWidget {
  const _GlassStat({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final String icon;
  final String value;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Text(icon, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: color,
                letterSpacing: -1,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: AppColors.textTertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════
// PREMIUM FOCUS BUTTON — breathing glow
// ═══════════════════════════════════════════════

class _PremiumFocusButton extends StatefulWidget {
  const _PremiumFocusButton({required this.onTap});
  final VoidCallback onTap;

  @override
  State<_PremiumFocusButton> createState() => _PremiumFocusButtonState();
}

class _PremiumFocusButtonState extends State<_PremiumFocusButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _glow;

  @override
  void initState() {
    super.initState();
    _glow = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _glow.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _glow,
      builder: (_, _) {
        final val = Curves.easeInOut.transform(_glow.value);
        return GestureDetector(
          onTap: widget.onTap,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 18),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.neonGreen,
                  AppColors.neonGreen.withValues(alpha: 0.85),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColors.neonGreen
                      .withValues(alpha: 0.2 + val * 0.2),
                  blurRadius: 20 + val * 15,
                  spreadRadius: -2,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.self_improvement_rounded,
                    color: Colors.black, size: 24),
                SizedBox(width: 10),
                Text(
                  'Odak Modunu Başlat',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ═══════════════════════════════════════════════
// SECTION HEADER
// ═══════════════════════════════════════════════

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.emoji});
  final String title;
  final String emoji;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 16)),
        const SizedBox(width: 6),
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════
// DUEL CARD — glassmorphic
// ═══════════════════════════════════════════════

class _DuelCard extends StatelessWidget {
  const _DuelCard({required this.duel, required this.onTap});
  final Duel duel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.neonGreen.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                  color: AppColors.neonGreen.withValues(alpha: 0.15)),
            ),
            child: Row(
              children: [
                const Text('⚔️', style: TextStyle(fontSize: 24)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${duel.player1.name} vs ${duel.player2.name}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${(duel.durationMinutes / 60).ceil()}s • ${duel.player1.totalMinutes}dk vs ${duel.player2.totalMinutes}dk',
                        style: TextStyle(
                            fontSize: 11, color: AppColors.textTertiary),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right_rounded,
                    color: AppColors.textTertiary, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════
// APP USAGE STRIP
// ═══════════════════════════════════════════════

class _AppUsageStrip extends StatelessWidget {
  const _AppUsageStrip({required this.st});
  final ScreenTimeData st;

  @override
  Widget build(BuildContext context) {
    final topApps = st.appUsage;
    if (topApps.isEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.04),
              borderRadius: BorderRadius.circular(16),
              border:
                  Border.all(color: Colors.white.withValues(alpha: 0.06)),
            ),
            child: Center(
              child: Text(
                'Henüz veri yok — telefonu kullandıkça burada görünecek',
                style: TextStyle(
                    fontSize: 12, color: AppColors.textTertiary),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
          ),
          child: Column(
            children: [
              for (int i = 0; i < topApps.length && i < 5; i++)
                Padding(
                  padding: EdgeInsets.only(bottom: i < 4 ? 8.0 : 0),
                  child: _AppRow(app: topApps[i], maxMin: st.totalMinutes),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AppRow extends StatelessWidget {
  const _AppRow({required this.app, required this.maxMin});
  final AppUsageEntry app;
  final int maxMin;

  @override
  Widget build(BuildContext context) {
    final minutes = app.minutes;
    final ratio = maxMin > 0 ? (minutes / maxMin).clamp(0.0, 1.0) : 0.0;
    final color = minutes > 60
        ? AppColors.ringDanger
        : minutes > 30
            ? AppColors.ringWarning
            : AppColors.neonGreen;

    return Row(
      children: [
        SizedBox(
          width: 80,
          child: Text(
            app.name,
            style: const TextStyle(fontSize: 12, color: Colors.white),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: SizedBox(
              height: 6,
              child: LinearProgressIndicator(
                value: ratio,
                backgroundColor: Colors.white.withValues(alpha: 0.06),
                valueColor: AlwaysStoppedAnimation(color),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 35,
          child: Text(
            '${minutes}dk',
            style: TextStyle(fontSize: 10, color: AppColors.textTertiary),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════
// QUICK ACTIONS GRID — glass cards
// ═══════════════════════════════════════════════

class _QuickActionsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Column(
      children: [
        Row(
          children: [
            _GlassAction(
              icon: Icons.block_rounded,
              label: 'Engel Listeleri',
              color: const Color(0xFFFF4040),
              onTap: () => context.push('/sessions/blocklists'),
            ),
            const SizedBox(width: 10),
            _GlassAction(
              icon: Icons.timer_outlined,
              label: 'Günlük Limitler',
              color: const Color(0xFF667EEA),
              onTap: () => context.push('/limits'),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            _GlassAction(
              icon: Icons.eco_rounded,
              label: 'O₂ Market',
              color: AppColors.neonGreen,
              onTap: () => context.push('/o2'),
            ),
            const SizedBox(width: 10),
            _GlassAction(
              icon: Icons.people_outline_rounded,
              label: l.groups,
              color: const Color(0xFF4FACFE),
              onTap: () => context.push('/groups'),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            _GlassAction(
              icon: Icons.bolt_rounded,
              label: 'Düello',
              color: AppColors.neonOrange,
              onTap: () => context.push('/duel'),
            ),
            const SizedBox(width: 10),
            _GlassAction(
              icon: Icons.card_giftcard_rounded,
              label: 'Ganimetler',
              color: AppColors.gold,
              onTap: () => context.push('/ganimetler'),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            _GlassAction(
              icon: Icons.people_alt_rounded,
              label: 'Arkadaşlar',
              color: const Color(0xFF00D4AA),
              onTap: () => context.push('/friends'),
            ),
            const SizedBox(width: 10),
            _GlassAction(
              icon: Icons.auto_awesome_rounded,
              label: 'Haftalık Rapor',
              color: const Color(0xFFF5576C),
              onTap: () => context.push('/wrapped'),
            ),
          ],
        ),
      ],
    );
  }
}

class _GlassAction extends StatelessWidget {
  const _GlassAction({
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
    return Expanded(
      child: GestureDetector(
        onTap: () {
          HapticService.light();
          onTap();
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 14),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: color.withValues(alpha: 0.12)),
              ),
              child: Column(
                children: [
                  Icon(icon, color: color, size: 26),
                  const SizedBox(height: 8),
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
