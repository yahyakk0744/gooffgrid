import 'package:flutter/material.dart';
import '../../config/design_tokens.dart';
import '../../config/theme.dart';
import 'bento_card.dart';

/// Preset session tile — emoji + title + optional subtitle.
class PresetTile extends StatelessWidget {
  const PresetTile({
    super.key,
    required this.emoji,
    required this.title,
    this.subtitle,
    this.accent = AppColors.neonGreen,
    this.onTap,
  });

  final String emoji;
  final String title;
  final String? subtitle;
  final Color accent;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return BentoCard(
      onTap: onTap,
      borderColor: accent.withValues(alpha: 0.18),
      accent: accent,
      padding: const EdgeInsets.all(AppSpacing.s5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 34)),
          const SizedBox(height: AppSpacing.s4),
          Text(
            title,
            style: AppType.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          if (subtitle != null) ...[
            const SizedBox(height: AppSpacing.s1),
            Text(
              subtitle!,
              style: AppType.caption,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }
}
