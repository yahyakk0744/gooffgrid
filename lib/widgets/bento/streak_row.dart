import 'package:flutter/material.dart';

import '../../config/app_shadows.dart';
import '../../config/design_tokens.dart';
import '../../config/theme.dart';
import 'bento_card.dart';

/// Opal-style 7-day streak dot row.
/// Pass [activeDays] — a list of 7 bools (oldest→newest, today last).
class StreakRow extends StatelessWidget {
  const StreakRow({
    super.key,
    required this.currentStreak,
    required this.activeDays,
  });

  final int currentStreak;
  final List<bool> activeDays;

  static const _labels = ['P', 'S', 'Ç', 'P', 'C', 'C', 'P'];

  @override
  Widget build(BuildContext context) {
    return BentoCard(
      accent: AppColors.neonOrange,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('🔥', style: TextStyle(fontSize: 24)),
              const SizedBox(width: AppSpacing.s3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('$currentStreak gün',
                        style: AppType.h2.copyWith(
                            color: AppColors.neonOrange, letterSpacing: -1)),
                    Text('Seri', style: AppType.caption),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.s4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (i) {
              final active = i < activeDays.length && activeDays[i];
              final isToday = i == 6;
              return Column(
                children: [
                  AnimatedContainer(
                    duration: AppMotion.base,
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: active
                          ? AppColors.neonOrange
                          : AppColors.cardBorder.withValues(alpha: 0.3),
                      border: isToday
                          ? Border.all(color: Colors.white, width: 2)
                          : null,
                      boxShadow: active
                          ? AppShadow.glow(AppColors.neonOrange, intensity: 0.4, blur: 10)
                          : null,
                    ),
                    child: active
                        ? const Icon(Icons.check_rounded,
                            size: 16, color: Colors.black)
                        : null,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _labels[i],
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: active
                          ? Colors.white
                          : AppColors.textTertiary,
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
