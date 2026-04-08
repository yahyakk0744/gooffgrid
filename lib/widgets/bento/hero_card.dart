import 'package:flutter/material.dart';
import '../../config/app_shadows.dart';
import '../../config/design_tokens.dart';
import '../../config/theme.dart';
import 'bento_card.dart';

/// Full-width hero bento — large emoji, title, subtitle, CTA pill.
class HeroCard extends StatelessWidget {
  const HeroCard({
    super.key,
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.ctaLabel,
    required this.onTap,
    this.accent = AppColors.neonGreen,
    this.gradient,
  });

  final String emoji;
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
          Text(emoji, style: const TextStyle(fontSize: 44)),
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
