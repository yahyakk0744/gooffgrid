import 'package:flutter/material.dart';
import '../config/theme.dart';

/// Premium radial gradient background that replaces flat black.
/// Wraps any screen body with a subtle deep navy/purple center → dark edges gradient.
class PremiumBackground extends StatelessWidget {
  const PremiumBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(0.0, -0.3),
          radius: 1.2,
          colors: [
            AppColors.bgDeepCenter, // koyu lacivert/mor merkez
            AppColors.surface, // geçiş
            AppColors.bg, // kenarlar
          ],
          stops: [0.0, 0.5, 1.0],
        ),
      ),
      child: child,
    );
  }
}

/// Subtle ambient glow effect behind content sections.
/// Creates a soft lens-flare-like light behind text/cards.
class AmbientGlow extends StatelessWidget {
  const AmbientGlow({
    super.key,
    required this.child,
    this.color,
    this.intensity = 0.08,
    this.radius = 120,
  });

  final Widget child;
  final Color? color;
  final double intensity;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Center(
            child: Container(
              width: radius * 2,
              height: radius * 2,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    (color ?? AppColors.neonGreen).withValues(alpha: intensity),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ),
        child,
      ],
    );
  }
}
