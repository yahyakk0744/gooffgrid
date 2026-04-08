import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme.dart';
import '../../config/design_tokens.dart';
import '../../providers/app_block_provider.dart';
import '../../l10n/app_localizations.dart';

class BlockScheduleScreen extends ConsumerStatefulWidget {
  const BlockScheduleScreen({super.key});

  @override
  ConsumerState<BlockScheduleScreen> createState() =>
      _BlockScheduleScreenState();
}

class _BlockScheduleScreenState extends ConsumerState<BlockScheduleScreen> {
  final Set<int> _expanded = {};

  static const _days = [
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
    final l = AppLocalizations.of(context)!;
    final state = ref.watch(appBlockProvider);
    final notifier = ref.read(appBlockProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context, l),
            _buildPresets(notifier, l),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
                itemCount: 7,
                itemBuilder: (_, i) {
                  final weekday = i + 1;
                  final ranges = state.blockSchedule[weekday] ?? [];
                  final isExpanded = _expanded.contains(weekday);
                  return _DayCard(
                    day: _days[i],
                    weekday: weekday,
                    ranges: ranges,
                    isExpanded: isExpanded,
                    onToggle: () => setState(() {
                      if (isExpanded) {
                        _expanded.remove(weekday);
                      } else {
                        _expanded.add(weekday);
                      }
                    }),
                    onAddRange: () => _showTimePicker(
                        context, weekday, notifier),
                    onRemoveRange: (idx) =>
                        notifier.removeSchedule(weekday, idx),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AppLocalizations l) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.cardBg,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.cardBorder),
              ),
              child: const Icon(Icons.arrow_back_ios_new_rounded,
                  size: 16, color: AppColors.textSecondary),
            ),
          ),
          const SizedBox(width: 12),
          Text(l.appBlockScheduleTitle, style: AppType.h1),
        ],
      ),
    );
  }

  Widget _buildPresets(AppBlockNotifier notifier, AppLocalizations l) {
    return SizedBox(
      height: 44,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _PresetChip(
            label: l.appBlockPresetWork,
            onTap: () => _applyWorkPreset(notifier),
          ),
          const SizedBox(width: 8),
          _PresetChip(
            label: l.appBlockPresetSleep,
            onTap: () => _applySleepPreset(notifier),
          ),
          const SizedBox(width: 8),
          _PresetChip(
            label: l.appBlockPresetAllDay,
            onTap: () => _applyAllDayPreset(notifier),
          ),
        ],
      ),
    );
  }

  void _applyWorkPreset(AppBlockNotifier notifier) {
    for (int d = 1; d <= 5; d++) {
      notifier.addSchedule(
          d, const TimeOfDay(hour: 9, minute: 0), const TimeOfDay(hour: 18, minute: 0));
    }
  }

  void _applySleepPreset(AppBlockNotifier notifier) {
    for (int d = 1; d <= 7; d++) {
      notifier.addSchedule(
          d, const TimeOfDay(hour: 23, minute: 0), const TimeOfDay(hour: 7, minute: 0));
    }
  }

  void _applyAllDayPreset(AppBlockNotifier notifier) {
    for (int d = 1; d <= 7; d++) {
      notifier.addSchedule(
          d, const TimeOfDay(hour: 0, minute: 0), const TimeOfDay(hour: 23, minute: 59));
    }
  }

  Future<void> _showTimePicker(
      BuildContext context, int weekday, AppBlockNotifier notifier) async {
    TimeOfDay? start = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 9, minute: 0),
      helpText: 'Başlangıç saati',
    );
    if (start == null || !context.mounted) return;

    TimeOfDay? end = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 18, minute: 0),
      helpText: 'Bitiş saati',
    );
    if (end == null) return;

    notifier.addSchedule(weekday, start, end);
  }
}

// ── Preset Chip ────────────────────────────────────────────────────────────────

class _PresetChip extends StatelessWidget {
  const _PresetChip({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.neonGreen.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: AppColors.neonGreen.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.auto_fix_high_rounded,
                size: 13, color: AppColors.neonGreen),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.neonGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Day Card ───────────────────────────────────────────────────────────────────

class _DayCard extends StatelessWidget {
  const _DayCard({
    required this.day,
    required this.weekday,
    required this.ranges,
    required this.isExpanded,
    required this.onToggle,
    required this.onAddRange,
    required this.onRemoveRange,
  });

  final String day;
  final int weekday;
  final List<TimeRange> ranges;
  final bool isExpanded;
  final VoidCallback onToggle;
  final VoidCallback onAddRange;
  final void Function(int index) onRemoveRange;

  @override
  Widget build(BuildContext context) {
    final hasRanges = ranges.isNotEmpty;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: hasRanges
              ? AppColors.neonGreen.withValues(alpha: 0.25)
              : AppColors.cardBorder,
        ),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: onToggle,
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: hasRanges
                          ? AppColors.neonGreen.withValues(alpha: 0.15)
                          : AppColors.surface,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        day.substring(0, 2),
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: hasRanges
                              ? AppColors.neonGreen
                              : AppColors.textTertiary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(day, style: AppType.h3),
                        if (hasRanges)
                          Text(
                            '${ranges.length} blok',
                            style: AppType.caption.copyWith(
                                color: AppColors.neonGreen),
                          ),
                      ],
                    ),
                  ),
                  if (hasRanges) _buildTimeline(ranges),
                  const SizedBox(width: 8),
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color: AppColors.textTertiary,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded) ...[
            const Divider(height: 1, color: AppColors.cardBorder),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: Column(
                children: [
                  ...List.generate(ranges.length, (i) {
                    return _RangeTile(
                      range: ranges[i],
                      onRemove: () => onRemoveRange(i),
                    );
                  }),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: onAddRange,
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.neonGreen.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color:
                              AppColors.neonGreen.withValues(alpha: 0.25),
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.add_rounded,
                              size: 16, color: AppColors.neonGreen),
                          const SizedBox(width: 6),
                          Text(
                            'Zaman Aralığı Ekle',
                            style: AppType.caption.copyWith(
                                color: AppColors.neonGreen),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTimeline(List<TimeRange> ranges) {
    return SizedBox(
      width: 60,
      height: 6,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(3),
        child: Stack(
          children: [
            Container(color: AppColors.ringTrack),
            ...ranges.map((r) {
              final start = r.startMinutes / (24 * 60);
              final end = r.endMinutes / (24 * 60);
              final width = (end - start).clamp(0.05, 1.0);
              return Positioned(
                left: start * 60,
                width: width * 60,
                top: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.neonGreen,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

// ── Range Tile ─────────────────────────────────────────────────────────────────

class _RangeTile extends StatelessWidget {
  const _RangeTile({required this.range, required this.onRemove});
  final TimeRange range;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const Icon(Icons.access_time_rounded,
              size: 14, color: AppColors.neonGreen),
          const SizedBox(width: 8),
          Text(range.format(), style: AppType.body),
          const Spacer(),
          GestureDetector(
            onTap: onRemove,
            child: const Icon(Icons.remove_circle_outline_rounded,
                size: 18, color: AppColors.ringDanger),
          ),
        ],
      ),
    );
  }
}
