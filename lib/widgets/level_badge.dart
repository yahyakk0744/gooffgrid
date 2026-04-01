import 'package:flutter/material.dart';
import '../config/theme.dart';

class LevelBadge extends StatelessWidget {
  const LevelBadge({super.key, required this.level, this.size = 22});

  final int level;
  final double size;

  Color get _color {
    if (level <= 3) return AppColors.textTertiary;
    if (level <= 6) return AppColors.twitter;
    if (level <= 8) return AppColors.neonOrange;
    return AppColors.gold;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: _color, shape: BoxShape.circle),
      child: Center(
        child: Text(
          '$level',
          style: TextStyle(fontSize: size * 0.5, fontWeight: FontWeight.w700, color: Colors.white),
        ),
      ),
    );
  }
}
