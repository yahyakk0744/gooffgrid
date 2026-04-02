import 'package:flutter/material.dart';
import '../config/theme.dart';

class ShameWallCard extends StatelessWidget {
  const ShameWallCard({
    super.key,
    required this.name,
    required this.avatarColor,
    required this.totalMinutes,
    required this.topApp,
    required this.topAppMinutes,
  });

  final String name;
  final Color avatarColor;
  final int totalMinutes;
  final String topApp;
  final int topAppMinutes;

  @override
  Widget build(BuildContext context) {
    final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color.alphaBlend(Colors.red.withValues(alpha: 0.05), AppColors.cardBg),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Bu haftanın şampiyonu 🏆',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.ringDanger),
          ),
          const SizedBox(height: 12),

          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(color: avatarColor, shape: BoxShape.circle),
                child: Center(
                  child: Text(initial, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: AppTextStyles.h3),
                    const SizedBox(height: 2),
                    Text(
                      '${totalMinutes}dk',
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.ringDanger),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          Text(
            'En çok: $topApp (${topAppMinutes}dk)',
            style: AppTextStyles.bodySecondary,
          ),
        ],
      ),
    );
  }
}
