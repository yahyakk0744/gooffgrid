import 'package:flutter/material.dart';
import '../../config/theme.dart';
import '../../services/focus_sound_service.dart';
import '../../services/haptic_service.dart';

/// Horizontal chip row — pick an ambient sound for the focus session.
/// Tapping a chip immediately starts/stops playback via [FocusSoundService].
class FocusSoundPicker extends StatefulWidget {
  const FocusSoundPicker({super.key, this.onChanged});

  final ValueChanged<FocusSound>? onChanged;

  @override
  State<FocusSoundPicker> createState() => _FocusSoundPickerState();
}

class _FocusSoundPickerState extends State<FocusSoundPicker> {
  FocusSound _selected = FocusSound.none;

  @override
  void initState() {
    super.initState();
    _selected = FocusSoundService.instance.current;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemCount: FocusSound.values.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final s = FocusSound.values[i];
          final isSelected = s == _selected;
          return GestureDetector(
            onTap: () async {
              HapticService.selection();
              await FocusSoundService.instance.play(s);
              if (!mounted) return;
              setState(() => _selected = s);
              widget.onChanged?.call(s);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.neonGreen.withValues(alpha: 0.12)
                    : Colors.white.withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? AppColors.neonGreen.withValues(alpha: 0.35)
                      : Colors.white.withValues(alpha: 0.08),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(s.emoji, style: const TextStyle(fontSize: 16)),
                  const SizedBox(width: 6),
                  Text(
                    s.label,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                      color: isSelected
                          ? AppColors.neonGreen
                          : Colors.white.withValues(alpha: 0.7),
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
