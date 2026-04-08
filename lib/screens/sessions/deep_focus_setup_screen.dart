import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../config/design_tokens.dart';
import '../../config/theme.dart';
import '../../models/session_tag.dart';
import '../../providers/blocklist_provider.dart';
import '../../providers/session_provider.dart';
import '../../services/haptic_service.dart';
import '../../widgets/bento/bento_card.dart';
import '../../widgets/common/pill_button.dart';

/// Opal-style deep focus setup — choose duration + tag, then start.
class DeepFocusSetupScreen extends ConsumerStatefulWidget {
  const DeepFocusSetupScreen({super.key});

  @override
  ConsumerState<DeepFocusSetupScreen> createState() =>
      _DeepFocusSetupScreenState();
}

class _DeepFocusSetupScreenState extends ConsumerState<DeepFocusSetupScreen> {
  int _durationMin = 25;
  String _tagId = 'work';
  String? _blocklistId;
  bool _hardLock = false;

  static const _durations = [5, 15, 25, 45, 60, 90, 120];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: Text('Odak Modu', style: AppType.title),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
              AppSpacing.s5, 0, AppSpacing.s5, AppSpacing.s10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Süre', style: AppType.label),
              const SizedBox(height: AppSpacing.s3),
              Wrap(
                spacing: AppSpacing.s3,
                runSpacing: AppSpacing.s3,
                children: _durations
                    .map((d) => _DurationChip(
                          minutes: d,
                          selected: d == _durationMin,
                          onTap: () {
                            HapticService.light();
                            setState(() => _durationMin = d);
                          },
                        ))
                    .toList(),
              ),
              const SizedBox(height: AppSpacing.s6),
              Text('Ne için?', style: AppType.label),
              const SizedBox(height: AppSpacing.s3),
              Wrap(
                spacing: AppSpacing.s3,
                runSpacing: AppSpacing.s3,
                children: defaultSessionTags
                    .map((t) => _TagChip(
                          tag: t,
                          selected: t.id == _tagId,
                          onTap: () {
                            HapticService.light();
                            setState(() => _tagId = t.id);
                          },
                        ))
                    .toList(),
              ),
              const SizedBox(height: AppSpacing.s6),
              Text('Engelle', style: AppType.label),
              const SizedBox(height: AppSpacing.s3),
              Builder(builder: (context) {
                final lists = ref.watch(blocklistProvider);
                return Wrap(
                  spacing: AppSpacing.s3,
                  runSpacing: AppSpacing.s3,
                  children: [
                    // "Yok" seçeneği
                    GestureDetector(
                      onTap: () {
                        HapticService.light();
                        setState(() => _blocklistId = null);
                      },
                      child: AnimatedContainer(
                        duration: AppMotion.fast,
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.s4, vertical: AppSpacing.s3),
                        decoration: BoxDecoration(
                          color: _blocklistId == null
                              ? AppColors.neonGreen.withValues(alpha: 0.18)
                              : AppColors.cardBg,
                          borderRadius: AppRadius.rPill,
                          border: Border.all(
                            color: _blocklistId == null
                                ? AppColors.neonGreen
                                : AppColors.cardBorder,
                          ),
                        ),
                        child: Text('Yok',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: _blocklistId == null
                                    ? AppColors.neonGreen
                                    : Colors.white.withValues(alpha: 0.7))),
                      ),
                    ),
                    ...lists.map((b) => GestureDetector(
                          onTap: () {
                            HapticService.light();
                            setState(() => _blocklistId = b.id);
                          },
                          child: AnimatedContainer(
                            duration: AppMotion.fast,
                            padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.s4,
                                vertical: AppSpacing.s3),
                            decoration: BoxDecoration(
                              color: _blocklistId == b.id
                                  ? b.color.withValues(alpha: 0.18)
                                  : AppColors.cardBg,
                              borderRadius: AppRadius.rPill,
                              border: Border.all(
                                color: _blocklistId == b.id
                                    ? b.color
                                    : AppColors.cardBorder,
                                width: _blocklistId == b.id ? 2 : 1,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(b.emoji,
                                    style: const TextStyle(fontSize: 16)),
                                const SizedBox(width: 6),
                                Text(b.name,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: _blocklistId == b.id
                                            ? b.color
                                            : Colors.white
                                                .withValues(alpha: 0.7))),
                              ],
                            ),
                          ),
                        )),
                  ],
                );
              }),
              const SizedBox(height: AppSpacing.s6),
              BentoCard(
                padding: const EdgeInsets.all(AppSpacing.s5),
                child: Row(
                  children: [
                    const Text('🔒', style: TextStyle(fontSize: 26)),
                    const SizedBox(width: AppSpacing.s4),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Sıkı mod', style: AppType.title),
                          const SizedBox(height: 2),
                          Text(
                            'Seansı iptal edemezsin. Bitene kadar odaklı kal.',
                            style: AppType.caption,
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: _hardLock,
                      activeThumbColor: AppColors.neonGreen,
                      onChanged: (v) {
                        HapticService.light();
                        setState(() => _hardLock = v);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.s10),
              Center(
                child: PillButton(
                  label: 'Seansı başlat',
                  icon: Icons.play_arrow_rounded,
                  onTap: () {
                    HapticService.medium();
                    ref.read(sessionProvider.notifier).start(
                          durationMin: _durationMin,
                          tagId: _tagId,
                          blocklistId: _blocklistId,
                          isHardLock: _hardLock,
                        );
                    context.pushReplacement('/sessions/active');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DurationChip extends StatelessWidget {
  const _DurationChip({
    required this.minutes,
    required this.selected,
    required this.onTap,
  });

  final int minutes;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final label = minutes >= 60
        ? '${minutes ~/ 60}s${minutes % 60 > 0 ? ' ${minutes % 60}dk' : ''}'
        : '${minutes}dk';
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppMotion.fast,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.s5,
          vertical: AppSpacing.s3,
        ),
        decoration: BoxDecoration(
          color: selected ? AppColors.neonGreen : AppColors.cardBg,
          borderRadius: AppRadius.rPill,
          border: Border.all(
            color: selected ? AppColors.neonGreen : AppColors.cardBorder,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: selected ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  const _TagChip({
    required this.tag,
    required this.selected,
    required this.onTap,
  });

  final SessionTag tag;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppMotion.fast,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.s4,
          vertical: AppSpacing.s3,
        ),
        decoration: BoxDecoration(
          color: selected
              ? tag.color.withValues(alpha: 0.18)
              : AppColors.cardBg,
          borderRadius: AppRadius.rPill,
          border: Border.all(
            color: selected ? tag.color : AppColors.cardBorder,
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(tag.emoji, style: const TextStyle(fontSize: 16)),
            const SizedBox(width: 6),
            Text(
              tag.name,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: selected ? tag.color : Colors.white.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
