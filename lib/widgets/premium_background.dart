import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../config/theme.dart';

/// Premium radial gradient background that replaces flat black.
/// Wraps any screen body with a subtle deep navy/purple center → dark edges gradient.
/// Includes procedural noise overlay for Arc-browser-like depth.
class PremiumBackground extends StatelessWidget {
  const PremiumBackground({
    super.key,
    required this.child,
    this.noiseOpacity = 0.025,
  });

  final Widget child;
  final double noiseOpacity;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Base radial gradient
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(0.0, -0.3),
                radius: 1.2,
                colors: [
                  AppColors.bgDeepCenter,
                  AppColors.surface,
                  AppColors.bg,
                ],
                stops: [0.0, 0.5, 1.0],
              ),
            ),
          ),
        ),

        // Procedural noise overlay — depth without asset bloat
        if (noiseOpacity > 0)
          Positioned.fill(
            child: IgnorePointer(
              child: RepaintBoundary(
                child: CustomPaint(
                  painter: _NoisePainter(opacity: noiseOpacity),
                ),
              ),
            ),
          ),

        child,
      ],
    );
  }
}

/// Stateless procedural noise — fixed seed → no repaint jitter.
class _NoisePainter extends CustomPainter {
  _NoisePainter({required this.opacity});

  final double opacity;

  @override
  void paint(Canvas canvas, Size size) {
    final rng = math.Random(1337);
    final paint = Paint()..color = Colors.white.withValues(alpha: opacity);

    // ~1 dot per 40px² — low density, high perceived depth
    final dotCount = (size.width * size.height / 40).round().clamp(500, 8000);

    for (int i = 0; i < dotCount; i++) {
      final x = rng.nextDouble() * size.width;
      final y = rng.nextDouble() * size.height;
      final r = rng.nextDouble() * 0.6 + 0.2;
      canvas.drawCircle(Offset(x, y), r, paint);
    }
  }

  @override
  bool shouldRepaint(_NoisePainter old) => old.opacity != opacity;
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
