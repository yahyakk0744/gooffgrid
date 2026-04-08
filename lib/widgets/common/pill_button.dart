import 'package:flutter/material.dart';
import '../../config/app_shadows.dart';
import '../../config/design_tokens.dart';
import '../../config/theme.dart';

/// Opal-style pill button — tappable, scales on press.
class PillButton extends StatefulWidget {
  const PillButton({
    super.key,
    required this.label,
    required this.onTap,
    this.color = AppColors.neonGreen,
    this.textColor = Colors.black,
    this.icon,
    this.expanded = false,
  });

  final String label;
  final VoidCallback onTap;
  final Color color;
  final Color textColor;
  final IconData? icon;
  final bool expanded;

  @override
  State<PillButton> createState() => _PillButtonState();
}

class _PillButtonState extends State<PillButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final child = Row(
      mainAxisSize: widget.expanded ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.icon != null) ...[
          Icon(widget.icon, size: 18, color: widget.textColor),
          const SizedBox(width: 8),
        ],
        Text(
          widget.label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: widget.textColor,
          ),
        ),
      ],
    );

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _pressed ? 0.96 : 1.0,
        duration: AppMotion.fast,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.s5,
            vertical: AppSpacing.s3 + 2,
          ),
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: AppRadius.rPill,
            boxShadow: AppShadow.glow(widget.color, intensity: 0.35, blur: 24),
          ),
          child: child,
        ),
      ),
    );
  }
}
