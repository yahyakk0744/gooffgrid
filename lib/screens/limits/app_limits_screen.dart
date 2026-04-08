import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../config/design_tokens.dart';
import '../../config/theme.dart';
import '../../models/app_limit.dart';
import '../../providers/app_limit_provider.dart';
import '../../widgets/bento/bento_card.dart';

/// Opal-style daily app-limit screen.
class AppLimitsScreen extends ConsumerWidget {
  const AppLimitsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final limits = ref.watch(appLimitProvider);

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: Text('Günlük Limitler', style: AppType.title),
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(AppSpacing.s5),
          itemCount: limits.length,
          separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.s3),
          itemBuilder: (_, i) => _LimitTile(limit: limits[i]),
        ),
      ),
    );
  }
}

class _LimitTile extends ConsumerWidget {
  const _LimitTile({required this.limit});
  final AppLimit limit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = limit.exceeded
        ? AppColors.ringDanger
        : (limit.progress > 0.75
            ? AppColors.neonOrange
            : AppColors.neonGreen);
    return BentoCard(
      accent: color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(limit.emoji, style: const TextStyle(fontSize: 26)),
              const SizedBox(width: AppSpacing.s3),
              Expanded(
                child: Text(limit.label, style: AppType.title),
              ),
              Switch(
                value: limit.enabled,
                activeThumbColor: AppColors.neonGreen,
                onChanged: (_) =>
                    ref.read(appLimitProvider.notifier).toggle(limit.id),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.s3),
          ClipRRect(
            borderRadius: AppRadius.rPill,
            child: LinearProgressIndicator(
              value: limit.progress,
              minHeight: 10,
              backgroundColor: AppColors.cardBorder.withValues(alpha: 0.3),
              valueColor: AlwaysStoppedAnimation(color),
            ),
          ),
          const SizedBox(height: AppSpacing.s2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${limit.usedMinutes} / ${limit.dailyMinutes} dk',
                  style: AppType.caption),
              Text(
                limit.exceeded
                    ? 'Limit doldu'
                    : '${limit.remainingMinutes} dk kaldı',
                style: AppType.caption.copyWith(color: color),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
