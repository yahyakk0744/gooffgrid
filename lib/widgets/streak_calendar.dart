import 'package:flutter/material.dart';
import '../config/theme.dart';

enum StreakDay { success, partial, missed, upcoming }

class StreakCalendar extends StatelessWidget {
  const StreakCalendar({super.key, required this.days, this.todayIndex = -1});

  final List<StreakDay> days;
  final int todayIndex;

  static const _dayLabels = [
    'Pazartesi',
    'Salı',
    'Çarşamba',
    'Perşembe',
    'Cuma',
    'Cumartesi',
    'Pazar',
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(7, (i) {
        final day = i < days.length ? days[i] : StreakDay.upcoming;
        final isToday = i == todayIndex;
        return Expanded(
          child: _buildDay(day, _dayLabels[i], isToday),
        );
      }),
    );
  }

  Widget _buildDay(StreakDay day, String label, bool isToday) {
    Color bgColor;
    Color borderColor;
    bool filled;
    IconData? icon;

    switch (day) {
      case StreakDay.success:
        bgColor = AppColors.neonGreen;
        borderColor = AppColors.neonGreen;
        filled = true;
        icon = Icons.check_rounded;
      case StreakDay.partial:
        bgColor = AppColors.ringWarning.withValues(alpha: 0.1);
        borderColor = AppColors.ringWarning;
        filled = false;
      case StreakDay.missed:
        bgColor = AppColors.ringDanger.withValues(alpha: 0.1);
        borderColor = AppColors.ringDanger;
        filled = false;
        icon = Icons.close_rounded;
      case StreakDay.upcoming:
        bgColor = Colors.transparent;
        borderColor = AppColors.cardBorder;
        filled = false;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 9,
              fontWeight: isToday ? FontWeight.w700 : FontWeight.w400,
              color: isToday ? AppColors.neonGreen : AppColors.textTertiary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: filled ? bgColor : bgColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isToday ? AppColors.neonGreen : borderColor,
                width: isToday ? 2 : 1.5,
              ),
              boxShadow: isToday
                  ? [BoxShadow(color: AppColors.neonGreen.withValues(alpha: 0.3), blurRadius: 8, spreadRadius: 1)]
                  : null,
            ),
            child: icon != null
                ? Icon(
                    icon,
                    size: 16,
                    color: filled ? Colors.black : (day == StreakDay.missed ? AppColors.ringDanger : AppColors.ringWarning),
                  )
                : null,
          ),
        ],
      ),
    );
  }
}
