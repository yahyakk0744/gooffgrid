import 'package:flutter/material.dart';
import '../config/theme.dart';

class AppUsageBar extends StatelessWidget {
  const AppUsageBar({
    super.key,
    required this.appName,
    required this.minutes,
    required this.color,
    required this.maxMinutes,
  });

  final String appName;
  final int minutes;
  final Color color;
  final int maxMinutes;

  @override
  Widget build(BuildContext context) {
    final ratio = maxMinutes > 0 ? (minutes / maxMinutes).clamp(0.0, 1.0) : 0.0;

    return SizedBox(
      height: 36,
      child: Row(
        children: [
          // App color dot with glow
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.3),
                  blurRadius: 8,
                  spreadRadius: -2,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),

          // App name
          SizedBox(
            width: 80,
            child: Text(
              appName,
              style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),

          // Bar
          Expanded(
            child: Container(
              height: 6,
              decoration: BoxDecoration(
                color: AppColors.cardBorder,
                borderRadius: BorderRadius.circular(3),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: ratio,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [color.withOpacity(0.7), color],
                    ),
                    borderRadius: BorderRadius.circular(3),
                    boxShadow: [
                      BoxShadow(
                        color: color.withOpacity(0.3),
                        blurRadius: 6,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),

          // Time text
          SizedBox(
            width: 44,
            child: Text(
              '${minutes}dk',
              style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
