import 'dart:ui';
import 'package:flutter/material.dart';
import '../config/app_shadows.dart';
import '../config/theme.dart';

/// Glassmorphism efektli kart.
/// Bulanık cam efekti — arkasındaki içeriği blur'lar.
class GlassmorphicCard extends StatelessWidget {
  const GlassmorphicCard({
    super.key,
    required this.child,
    this.borderRadius = 16,
    this.blurAmount = 20,
    this.opacity = 0.08,
    this.borderOpacity = 0.15,
    this.glowColor,
    this.onTap,
    this.padding = const EdgeInsets.all(16),
  });

  final Widget child;
  final double borderRadius;
  final double blurAmount;
  final double opacity;
  final double borderOpacity;
  final Color? glowColor;
  final VoidCallback? onTap;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurAmount, sigmaY: blurAmount),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withValues(alpha: opacity),
                  Colors.white.withValues(alpha: opacity * 0.4),
                ],
              ),
              border: Border.all(
                color: Colors.white.withValues(alpha: borderOpacity),
                width: 1,
              ),
              boxShadow: [
                ...AppShadow.md,
                if (glowColor != null)
                  ...AppShadow.glow(glowColor!, intensity: 0.15, blur: 24),
              ],
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// Daha hafif glassmorphism — üst barlarda, chip'lerde kullanılır.
class GlassChip extends StatelessWidget {
  const GlassChip({
    super.key,
    required this.label,
    this.isSelected = false,
    this.selectedColor,
    this.onTap,
  });

  final String label;
  final bool isSelected;
  final Color? selectedColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final color = selectedColor ?? AppColors.neonGreen;

    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: isSelected
                  ? color.withValues(alpha: 0.2)
                  : Colors.white.withValues(alpha: 0.06),
              border: Border.all(
                color: isSelected
                    ? color.withValues(alpha: 0.5)
                    : Colors.white.withValues(alpha: 0.1),
              ),
            ),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? color : AppColors.textSecondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
