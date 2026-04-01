import 'package:flutter/material.dart';
import '../config/theme.dart';

class BadgeItem {
  const BadgeItem({required this.name, required this.iconEmoji, required this.isEarned});
  final String name;
  final String iconEmoji;
  final bool isEarned;
}

class BadgeGrid extends StatelessWidget {
  const BadgeGrid({super.key, required this.badges});

  final List<BadgeItem> badges;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.85,
      ),
      itemCount: badges.length,
      itemBuilder: (context, index) => _buildBadge(badges[index]),
    );
  }

  Widget _buildBadge(BadgeItem badge) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: badge.isEarned
              ? [const Color(0xFF1A2A1A), const Color(0xFF1A1A2A)]
              : [AppColors.cardBg, AppColors.cardBg],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: badge.isEarned
              ? AppColors.neonGreen.withOpacity(0.3)
              : AppColors.cardBorder,
          width: badge.isEarned ? 1.2 : 1,
        ),
        boxShadow: badge.isEarned
            ? [
                BoxShadow(
                  color: AppColors.neonGreen.withOpacity(0.15),
                  blurRadius: 16,
                  spreadRadius: -2,
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Opacity(
        opacity: badge.isEarned ? 1.0 : 0.3,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(badge.iconEmoji, style: const TextStyle(fontSize: 32)),
                const SizedBox(height: 6),
                Text(
                  badge.name,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                    shadows: badge.isEarned
                        ? [Shadow(color: AppColors.neonGreen.withOpacity(0.3), blurRadius: 8)]
                        : null,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            if (!badge.isEarned)
              const Positioned(
                right: 0,
                bottom: 0,
                child: Icon(Icons.lock_rounded, size: 14, color: AppColors.textTertiary),
              ),
          ],
        ),
      ),
    );
  }
}
