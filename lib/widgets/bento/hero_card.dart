import 'package:flutter/material.dart';
import '../../config/app_shadows.dart';
import '../../config/design_tokens.dart';
import '../../config/theme.dart';
import 'bento_card.dart';

/// Full-width hero bento — pulsing orb icon, title, subtitle, CTA pill.
///
/// Hero card THE accent of the viewport — glow only lives here.
/// Other tiles on the same screen should use *Soft variants.
class HeroCard extends StatelessWidget {
  const HeroCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.ctaLabel,
    required this.onTap,
    this.icon = Icons.self_improvement_rounded,
    this.emoji,
    this.accent = AppColors.neonGreen,
    this.gradient,
  });

  /// Optional — prefer [icon] for modern feel. [emoji] kept for legacy call-sites.
  final String? emoji;
  final IconData icon;
  final String title;
  final String subtitle;
  final String ctaLabel;
  final VoidCallback onTap;
  final Color accent;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    return BentoCard(
      onTap: onTap,
      gradient: gradient ?? AppGradients.heroGreen,
      borderColor: accent.withValues(alpha: 0.25),
      radius: AppRadius.xl,
      accent: accent,
      padding: const EdgeInsets.all(AppSpacing.s6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _PulsingOrb(accent: accent, icon: icon, emoji: emoji),
          const SizedBox(height: AppSpacing.s4),
          Text(title, style: AppType.h1),
          const SizedBox(height: AppSpacing.s2),
          Text(
            subtitle,
            style: AppType.caption.copyWith(color: Colors.white.withValues(alpha: 0.65)),
          ),
          const SizedBox(height: AppSpacing.s5),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.s5,
                vertical: AppSpacing.s3,
              ),
              decoration: BoxDecoration(
                color: accent,
                borderRadius: AppRadius.rPill,
                boxShadow: AppShadow.glow(accent, intensity: 0.4, blur: 24),
              ),
              child: Text(
                ctaLabel,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Pulsing orb with icon — replaces static emoji on hero cards.
/// Breathing scale + halo; subtle, not distracting.
class _PulsingOrb extends StatefulWidget {
  const _PulsingOrb({
    required this.accent,
    required this.icon,
    this.emoji,
  });

  final Color accent;
  final IconData icon;
  final String? emoji;

  @override
  State<_PulsingOrb> createState() => _PulsingOrbState();
}

class _PulsingOrbState extends State<_PulsingOrb>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    )..repeat(reverse: true);
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
      builder: (context, _) {
        final t = Curves.easeInOut.transform(_ctrl.value);
        final scale = 0.92 + 0.08 * t;
        final haloAlpha = 0.12 + 0.10 * t;
        final coreAlpha = 0.22 + 0.08 * t;

        return SizedBox(
          width: 72,
          height: 72,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Halo
              Transform.scale(
                scale: scale * 1.25,
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.accent.withValues(alpha: haloAlpha),
                    boxShadow: [
                      BoxShadow(
                        color: widget.accent.withValues(alpha: 0.3 * t),
                        blurRadius: 24,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
              ),
              // Core
              Transform.scale(
                scale: scale,
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      center: const Alignment(-0.3, -0.3),
                      colors: [
                        widget.accent.withValues(alpha: 0.35),
                        widget.accent.withValues(alpha: coreAlpha),
                      ],
                    ),
                    border: Border.all(
                      color: widget.accent.withValues(alpha: 0.5),
                      width: 1.2,
                    ),
                  ),
                  child: widget.emoji != null
                      ? Center(
                          child: Text(widget.emoji!, style: const TextStyle(fontSize: 22)),
                        )
                      : Icon(widget.icon, color: Colors.white, size: 22),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
