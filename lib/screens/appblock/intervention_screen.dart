import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme.dart';
import '../../config/design_tokens.dart';
import '../../providers/app_block_provider.dart';
import '../../l10n/app_localizations.dart';

class InterventionScreen extends ConsumerStatefulWidget {
  const InterventionScreen({
    super.key,
    this.appId,
    this.appName,
    this.appColor,
  });

  final String? appId;
  final String? appName;
  final Color? appColor;

  @override
  ConsumerState<InterventionScreen> createState() =>
      _InterventionScreenState();
}

class _InterventionScreenState extends ConsumerState<InterventionScreen>
    with TickerProviderStateMixin {
  // Breathing animation — 4s inhale / 4s exhale
  late AnimationController _breathController;
  late Animation<double> _breathScale;

  // Fade-in animation for title
  late AnimationController _fadeController;
  late Animation<double> _fadeAnim;

  // Whether one full breathing cycle is done
  bool _breathingComplete = false;
  int _cycleCount = 0;

  // Motivational counter (mock)
  final int _monthGiveUpCount = 12;

  // Mock weekly usage (hours)
  final int _weeklyHours = 3;

  @override
  void initState() {
    super.initState();

    _breathController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8), // 4s in + 4s out
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _cycleCount++;
            if (_cycleCount >= 1) _breathingComplete = true;
          });
          if (!_breathingComplete) {
            _breathController.forward(from: 0);
          }
        }
      });

    _breathScale = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _breathController, curve: Curves.easeInOut),
    );

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnim = CurvedAnimation(parent: _fadeController, curve: Curves.easeIn);

    _fadeController.forward();
    _breathController.forward();
  }

  @override
  void dispose() {
    _breathController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  String get _phaseLabel {
    final t = _breathController.value;
    return t < 0.5 ? 'Nefes Al' : 'Nefes Ver';
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final state = ref.watch(appBlockProvider);
    final appName = widget.appName ?? 'Uygulama';
    final appColor = widget.appColor ?? AppColors.instagram;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Full-screen blurred dark background
          Container(color: AppColors.bg),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
            child: Container(
              color: Colors.black.withValues(alpha: 0.75),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 32),

                // App icon
                FadeTransition(
                  opacity: _fadeAnim,
                  child: _AppIcon(appName: appName, appColor: appColor),
                ),

                const SizedBox(height: 20),

                // Title
                FadeTransition(
                  opacity: _fadeAnim,
                  child: Text(
                    l.appBlockInterventionTitle,
                    style: AppType.h1.copyWith(fontSize: 26),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 8),

                FadeTransition(
                  opacity: _fadeAnim,
                  child: Text(
                    l.appBlockInterventionSubtitle,
                    style: AppType.body.copyWith(color: AppColors.textSecondary),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 40),

                // Breathing circle
                Expanded(
                  child: _breathingComplete
                      ? _StatsCard(
                          appName: appName,
                          weeklyHours: _weeklyHours,
                          l: l,
                        )
                      : _BreathingWidget(
                          breathController: _breathController,
                          breathScale: _breathScale,
                          phaseLabel: _phaseLabel,
                          cycleCount: _cycleCount,
                        ),
                ),

                const SizedBox(height: 24),

                // Buttons
                if (_breathingComplete)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        // Primary: give up (go back)
                        _GlowButton(
                          label: l.appBlockInterventionGiveUp,
                          onTap: () => context.pop(),
                        ),
                        const SizedBox(height: 12),

                        // Secondary: open anyway (only if not strict mode)
                        if (!state.isStrictMode)
                          GestureDetector(
                            onTap: () => context.pop(),
                            child: Text(
                              l.appBlockInterventionOpenAnyway,
                              style: AppType.body.copyWith(
                                color: AppColors.textSecondary,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.textSecondary,
                              ),
                            ),
                          ),

                        if (state.isStrictMode)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColors.ringDanger.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.lock_rounded,
                                    size: 14, color: AppColors.ringDanger),
                                const SizedBox(width: 8),
                                Text(
                                  l.appBlockStrictModeActive,
                                  style: AppType.caption.copyWith(
                                      color: AppColors.ringDanger),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),

                const SizedBox(height: 12),

                // Motivational counter
                Text(
                  l.appBlockGaveUpCount(_monthGiveUpCount),
                  style: AppType.caption,
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── App Icon ───────────────────────────────────────────────────────────────────

class _AppIcon extends StatelessWidget {
  const _AppIcon({required this.appName, required this.appColor});
  final String appName;
  final Color appColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        color: appColor.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: appColor.withValues(alpha: 0.4), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: appColor.withValues(alpha: 0.3),
            blurRadius: 24,
            spreadRadius: -4,
          ),
        ],
      ),
      child: Center(
        child: Text(
          appName.isNotEmpty ? appName[0].toUpperCase() : '?',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: appColor,
          ),
        ),
      ),
    );
  }
}

// ── Breathing Widget ───────────────────────────────────────────────────────────

class _BreathingWidget extends StatelessWidget {
  const _BreathingWidget({
    required this.breathController,
    required this.breathScale,
    required this.phaseLabel,
    required this.cycleCount,
  });

  final AnimationController breathController;
  final Animation<double> breathScale;
  final String phaseLabel;
  final int cycleCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedBuilder(
          animation: breathController,
          builder: (_, _) {
            final scale = breathScale.value;
            final size = 160.0 * scale;
            final isInhale = breathController.value < 0.5;
            final color = isInhale
                ? const Color(0xFF4FACFE)
                : AppColors.neonGreen;

            return SizedBox(
              width: 200,
              height: 200,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Outer glow
                  Container(
                    width: size + 40,
                    height: size + 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: color.withValues(alpha: 0.15),
                          blurRadius: 40,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                  ),
                  // Main circle
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          color.withValues(alpha: 0.4),
                          color.withValues(alpha: 0.1),
                          Colors.transparent,
                        ],
                      ),
                      border: Border.all(
                        color: color.withValues(alpha: 0.5),
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        phaseLabel,
                        style: TextStyle(
                          color: color,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        Text(
          'Tam 1 döngü nef al / ver',
          style: AppType.body.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }
}

// ── Stats Card ─────────────────────────────────────────────────────────────────

class _StatsCard extends StatelessWidget {
  const _StatsCard({
    required this.appName,
    required this.weeklyHours,
    required this.l,
  });
  final String appName;
  final int weeklyHours;
  final AppLocalizations l;

  @override
  Widget build(BuildContext context) {
    // Mock daily usage data (minutes)
    const mockData = [45, 30, 60, 20, 75, 50, 40];
    const days = ['Pt', 'Sa', 'Ça', 'Pe', 'Cu', 'Ct', 'Pz'];
    final maxVal = mockData.reduce(math.max).toDouble();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withValues(alpha: 0.08),
                  Colors.white.withValues(alpha: 0.02),
                ],
              ),
              border: Border.all(
                  color: Colors.white.withValues(alpha: 0.12)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l.appBlockStatsTitle(appName, weeklyHours),
                  style: AppType.h3,
                ),
                const SizedBox(height: 16),
                // Bar chart
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: List.generate(7, (i) {
                    final ratio = mockData[i] / maxVal;
                    final isToday = i == 6;
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              height: 60 * ratio,
                              decoration: BoxDecoration(
                                color: isToday
                                    ? AppColors.neonGreen
                                    : AppColors.neonGreen
                                        .withValues(alpha: 0.3),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              days[i],
                              style: AppType.label.copyWith(
                                color: isToday
                                    ? AppColors.neonGreen
                                    : AppColors.textTertiary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Glow Button ────────────────────────────────────────────────────────────────

class _GlowButton extends StatelessWidget {
  const _GlowButton({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 54,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.neonGreen,
              AppColors.neonGreen.withValues(alpha: 0.7),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.neonGreen.withValues(alpha: 0.4),
              blurRadius: 24,
              spreadRadius: -4,
            ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
