import 'package:flutter/material.dart';
import '../config/theme.dart';

/// Instagram Stories paylaşımı için RepaintBoundary ile sarılmış stats kartı.
/// [shareKey] ile ekran görüntüsü alınır.
class ShareableStatsCard extends StatelessWidget {
  const ShareableStatsCard({
    super.key,
    required this.shareKey,
    required this.userName,
    required this.totalMinutes,
    required this.streak,
    required this.rank,
    required this.level,
    this.avatarColor = AppColors.neonGreen,
  });

  final GlobalKey shareKey;
  final String userName;
  final int totalMinutes;
  final int streak;
  final int rank;
  final int level;
  final Color avatarColor;

  String get _formatted {
    final h = totalMinutes ~/ 60;
    final m = totalMinutes % 60;
    if (h > 0 && m > 0) return '${h}s ${m}dk';
    if (h > 0) return '${h}s';
    return '${m}dk';
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: shareKey,
      child: Container(
        width: 360,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: const RadialGradient(
            center: Alignment(0, -0.3),
            radius: 1.4,
            colors: [
              Color(0xFF0F0F24),
              Color(0xFF0C0C18),
              Color(0xFF0A0A0A),
            ],
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: AppColors.neonGreen.withOpacity(0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.neonGreen.withOpacity(0.15),
              blurRadius: 40,
              spreadRadius: -8,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Logo
            Text(
              'gooffgrid',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.neonGreen,
                letterSpacing: 2,
                shadows: [Shadow(color: AppColors.neonGreen.withOpacity(0.5), blurRadius: 12)],
              ),
            ),
            const SizedBox(height: 20),

            // Avatar
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: avatarColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: avatarColor.withOpacity(0.4), blurRadius: 16),
                ],
              ),
              child: Center(
                child: Text(
                  userName.isNotEmpty ? userName[0].toUpperCase() : '?',
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(userName, style: AppTextStyles.h2),
            const SizedBox(height: 4),
            Text('Seviye $level', style: AppTextStyles.bodySecondary),
            const SizedBox(height: 24),

            // Stats grid
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _StatColumn(label: 'Bugun', value: _formatted, color: _ringColor),
                _StatColumn(label: 'Streak', value: '$streak gun', color: AppColors.neonGreen),
                _StatColumn(label: 'Siralama', value: '#$rank', color: AppColors.gold),
              ],
            ),
            const SizedBox(height: 20),

            // CTA
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.neonGreen.withOpacity(0.3)),
              ),
              child: const Text(
                'Sen de katil → gooffgrid.app',
                style: TextStyle(fontSize: 12, color: AppColors.neonGreen, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color get _ringColor {
    if (totalMinutes <= 90) return const Color(0xFF30D158);
    if (totalMinutes <= 180) return const Color(0xFFFFD60A);
    return const Color(0xFFFF453A);
  }
}

class _StatColumn extends StatelessWidget {
  const _StatColumn({required this.label, required this.value, required this.color});
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: color,
            shadows: [Shadow(color: color.withOpacity(0.4), blurRadius: 8)],
          ),
        ),
        const SizedBox(height: 2),
        Text(label, style: AppTextStyles.labelSmall),
      ],
    );
  }
}
