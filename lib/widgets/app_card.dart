import 'package:flutter/material.dart';
import '../config/app_shadows.dart';
import '../config/design_tokens.dart';
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
          gradient: AppGradients.card,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: borderColor ?? AppColors.cardBorder.withValues(alpha: 0.6),
            width: borderColor != null ? 1.5 : 1,
          ),
          boxShadow: [
            ...AppShadow.sm,
            if (hasGlow)
              ...AppShadow.glow(effectiveGlowColor, intensity: effectiveGlowIntensity),
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
                      topAccentColor!.withValues(alpha: 0.6),
                      topAccentColor!,
                      topAccentColor!.withValues(alpha: 0.6),
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
