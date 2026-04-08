import 'package:flutter/material.dart';
import '../../config/design_tokens.dart';
import '../../config/theme.dart';
import 'bento_card.dart';

/// Small square bento tile — emoji top, big number center, label bottom.
class StatTile extends StatelessWidget {
  const StatTile({
    super.key,
    required this.emoji,
    required this.value,
    required this.label,
    this.accent = AppColors.neonGreen,
    this.onTap,
  });

  final String emoji;
  final String value;
  final String label;
  final Color accent;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return BentoCard(
      onTap: onTap,
      accent: accent,
      padding: const EdgeInsets.all(AppSpacing.s5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 28)),
          const SizedBox(height: AppSpacing.s4),
          Text(
            value,
            style: AppType.h1.copyWith(color: accent, letterSpacing: -1.5),
          ),
          const SizedBox(height: AppSpacing.s1),
          Text(
            label,
            style: AppType.caption,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
