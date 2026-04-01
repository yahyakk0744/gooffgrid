import 'package:flutter/material.dart';
import '../config/theme.dart';
import 'level_badge.dart';

class RankingRow extends StatelessWidget {
  const RankingRow({
    super.key,
    required this.rank,
    required this.name,
    required this.avatarColor,
    required this.level,
    required this.totalMinutes,
    this.change = 0,
    this.isCurrentUser = false,
  });

  final int rank;
  final String name;
  final Color avatarColor;
  final int level;
  final int totalMinutes;
  final int change;
  final bool isCurrentUser;

  Color get _rankColor {
    switch (rank) {
      case 1: return AppColors.gold;
      case 2: return AppColors.silver;
      case 3: return AppColors.bronze;
      default: return AppColors.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      margin: isCurrentUser ? const EdgeInsets.symmetric(horizontal: 8, vertical: 2) : EdgeInsets.zero,
      decoration: BoxDecoration(
        gradient: isCurrentUser
            ? const LinearGradient(
                colors: [Color(0xFF142014), Color(0xFF0F0F1A)],
              )
            : null,
        borderRadius: isCurrentUser ? BorderRadius.circular(12) : null,
        border: isCurrentUser
            ? Border.all(color: AppColors.neonGreen.withOpacity(0.3), width: 1)
            : null,
        boxShadow: isCurrentUser
            ? [
                BoxShadow(color: AppColors.neonGreen.withOpacity(0.1), blurRadius: 12, spreadRadius: -4),
              ]
            : null,
      ),
      child: Row(
        children: [
          // Rank number
          SizedBox(
            width: 32,
            child: Text(
              '#$rank',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _rankColor),
            ),
          ),
          const SizedBox(width: 12),

          // Avatar
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(color: avatarColor, shape: BoxShape.circle),
            child: Center(
              child: Text(initial, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
            ),
          ),
          const SizedBox(width: 12),

          // Name + level
          Expanded(
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    name,
                    style: AppTextStyles.h3,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 6),
                LevelBadge(level: level),
                if (isCurrentUser) ...[
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.neonGreen.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text('Sen', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.neonGreen)),
                  ),
                ],
              ],
            ),
          ),

          // Time
          Text(
            '${totalMinutes}dk',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textPrimary),
          ),
          const SizedBox(width: 8),

          // Change indicator
          SizedBox(
            width: 36,
            child: _buildChange(),
          ),
        ],
      ),
    );
  }

  Widget _buildChange() {
    if (change == 0) {
      return const Text('—', style: TextStyle(fontSize: 12, color: AppColors.textTertiary), textAlign: TextAlign.center);
    }
    final isUp = change > 0;
    return Text(
      '${isUp ? '↑' : '↓'}${change.abs()}',
      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: isUp ? AppColors.ringGood : AppColors.ringDanger),
      textAlign: TextAlign.center,
    );
  }
}
