import 'package:flutter/material.dart';
import '../config/theme.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.borderRadius = 16,
    this.borderColor,
    this.onTap,
    this.topAccentColor,
    this.glowIntensity = 0.0,
    this.glowColor,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final Color? borderColor;
  final VoidCallback? onTap;
  final Color? topAccentColor;
  final double glowIntensity;
  final Color? glowColor;

  @override
  Widget build(BuildContext context) {
    final hasGlow = glowIntensity > 0 || borderColor != null;
    final effectiveGlowColor = glowColor ?? borderColor ?? AppColors.neonGreen;
    final effectiveGlowIntensity = glowIntensity > 0 ? glowIntensity : (borderColor != null ? 0.15 : 0.0);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.cardGradientStart,
              AppColors.cardGradientEnd,
            ],
          ),
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: borderColor ?? AppColors.cardBorder.withOpacity(0.6),
            width: borderColor != null ? 1.5 : 1,
          ),
          boxShadow: [
            // Subtle elevation
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
            // Glow effect
            if (hasGlow)
              BoxShadow(
                color: effectiveGlowColor.withOpacity(effectiveGlowIntensity),
                blurRadius: 20,
                spreadRadius: -2,
              ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (topAccentColor != null)
              Container(
                height: 3,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      topAccentColor!.withOpacity(0.6),
                      topAccentColor!,
                      topAccentColor!.withOpacity(0.6),
                    ],
                  ),
                ),
              ),
            Padding(padding: padding, child: child),
          ],
        ),
      ),
    );
  }
}
