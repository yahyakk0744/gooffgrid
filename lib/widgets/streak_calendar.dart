import 'package:flutter/material.dart';
import '../config/theme.dart';

enum StreakDay { success, partial, missed, upcoming }

class StreakCalendar extends StatelessWidget {
  const StreakCalendar({super.key, required this.days, this.todayIndex = -1});

  final List<StreakDay> days;
  final int todayIndex;

  static const _dayLabels = ['P', 'S', 'Ç', 'P', 'C', 'C', 'P'];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(7, (i) {
        final day = i < days.length ? days[i] : StreakDay.upcoming;
        final isToday = i == todayIndex;
        return _buildDay(day, _dayLabels[i], isToday);
      }),
    );
  }

  Widget _buildDay(StreakDay day, String label, bool isToday) {
    Color bgColor;
    Color borderColor;
    bool filled;

    switch (day) {
      case StreakDay.success:
        bgColor = AppColors.neonGreen;
        borderColor = AppColors.neonGreen;
        filled = true;
      case StreakDay.partial:
        bgColor = Colors.transparent;
        borderColor = AppColors.ringWarning;
        filled = false;
      case StreakDay.missed:
        bgColor = Colors.transparent;
        borderColor = AppColors.ringDanger;
        filled = false;
      case StreakDay.upcoming:
        bgColor = Colors.transparent;
        borderColor = AppColors.cardBorder;
        filled = false;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: AppTextStyles.labelSmall),
        const SizedBox(height: 4),
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: filled ? bgColor : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: borderColor, width: filled ? 0 : 1.5),
            boxShadow: isToday
                ? [BoxShadow(color: AppColors.neonGreen.withOpacity(0.3), blurRadius: 8, spreadRadius: 1)]
                : null,
          ),
        ),
      ],
    );
  }
}
