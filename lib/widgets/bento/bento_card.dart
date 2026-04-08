import 'package:flutter/material.dart';
import '../../config/app_shadows.dart';
import '../../config/design_tokens.dart';
import '../../config/theme.dart';

/// Opal-style bento card — rounded, soft-bordered, tappable.
class BentoCard extends StatefulWidget {
  const BentoCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(AppSpacing.s5),
    this.gradient,
    this.color,
    this.borderColor,
    this.radius = AppRadius.l,
    this.height,
    this.accent,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final Gradient? gradient;
  final Color? color;
  final Color? borderColor;
  final double radius;
  final double? height;

  /// If set, a soft radial glow of this color is drawn behind the content.
  final Color? accent;

  @override
  State<BentoCard> createState() => _BentoCardState();
}

class _BentoCardState extends State<BentoCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final border = widget.borderColor ?? AppColors.cardBorder;

    return GestureDetector(
      onTapDown: widget.onTap == null ? null : (_) => setState(() => _pressed = true),
      onTapUp: widget.onTap == null ? null : (_) => setState(() => _pressed = false),
      onTapCancel: widget.onTap == null ? null : () => setState(() => _pressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1.0,
        duration: AppMotion.fast,
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: AppMotion.base,
          height: widget.height,
          padding: widget.padding,
          decoration: BoxDecoration(
            color: widget.gradient == null ? (widget.color ?? AppColors.cardBg) : null,
            gradient: widget.gradient,
            borderRadius: BorderRadius.circular(widget.radius),
            border: Border.all(color: border, width: 1),
            boxShadow: AppShadow.sm,
          ),
          child: widget.accent != null
              ? Stack(
                  children: [
                    Positioned(
                      right: -40,
                      top: -40,
                      child: Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: AppGradients.glow(widget.accent!, intensity: 0.22),
                        ),
                      ),
                    ),
                    widget.child,
                  ],
                )
              : widget.child,
        ),
      ),
    );
  }
}
