import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../config/theme.dart';

class HeatmapWidget extends StatelessWidget {
  const HeatmapWidget({super.key});

  static const _dayLabels = ['Pzt', 'Sal', 'Çar', 'Per', 'Cum', 'Cmt', 'Paz'];

  // Mock heatmap: 7 rows x 24 columns
  List<List<int>> get _data {
    final rng = math.Random(42);
    return List.generate(7, (day) {
      return List.generate(24, (hour) {
        // Higher usage at 8-10, 12-13, 19-23
        if ((hour >= 8 && hour <= 10) || (hour >= 12 && hour <= 13) || (hour >= 19 && hour <= 23)) {
          return rng.nextInt(4) + 1; // 1-4
        }
        if (hour >= 0 && hour <= 6) return 0;
        return rng.nextInt(3); // 0-2
      });
    });
  }

  Color _cellColor(int value) {
    switch (value) {
      case 0: return AppColors.surface;
      case 1: return AppColors.ringGood.withValues(alpha: 0.3);
      case 2: return AppColors.ringGood;
      case 3: return AppColors.ringWarning;
      default: return AppColors.ringDanger;
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = _data;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(7, (day) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 2),
          child: Row(
            children: [
              SizedBox(
                width: 16,
                child: Text(_dayLabels[day], style: const TextStyle(fontSize: 9, color: AppColors.textTertiary)),
              ),
              ...List.generate(24, (hour) {
                return Container(
                  width: 12,
                  height: 12,
                  margin: const EdgeInsets.only(right: 2),
                  decoration: BoxDecoration(
                    color: _cellColor(data[day][hour]),
                    borderRadius: BorderRadius.circular(2),
                  ),
                );
              }),
            ],
          ),
        );
      }),
    );
  }
}
