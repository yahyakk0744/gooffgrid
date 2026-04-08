import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../config/design_tokens.dart';
import '../../config/theme.dart';
import '../../models/focus_session.dart';
import '../../providers/session_log_provider.dart';
import '../../providers/session_provider.dart';
import '../../services/haptic_service.dart';
import '../../widgets/common/pill_button.dart';
import '../../widgets/common/ring_timer.dart';

class ActiveSessionScreen extends ConsumerWidget {
  const ActiveSessionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionProvider);

    // If no session (already finished / aborted), bounce out.
    if (session == null) {
      final completed = ref.read(sessionProvider.notifier).lastCompleted;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!context.mounted) return;
        if (completed != null &&
            completed.state == SessionState.completed) {
          // Log completed session → streak + score auto-update
          ref.read(sessionLogProvider.notifier).recordSession(completed);
          ref.read(sessionProvider.notifier).lastCompleted = null;
          context.pushReplacement('/sessions/complete', extra: {
            'durationMin': completed.durationMin,
            'gemsEarned': completed.gemsEarned,
          });
        } else {
          context.go('/');
        }
      });
      return const Scaffold(backgroundColor: AppColors.bg);
    }

    final remaining = session.remainingSeconds;
    final mm = (remaining ~/ 60).toString().padLeft(2, '0');
    final ss = (remaining % 60).toString().padLeft(2, '0');
    final isPaused = session.state == SessionState.paused;
    final isRunning = session.state == SessionState.running;

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.s5),
          child: Column(
            children: [
              // Top bar — close (if allowed)
              Row(
                children: [
                  if (!session.isHardLock)
                    IconButton(
                      icon: const Icon(Icons.close_rounded, color: Colors.white),
                      onPressed: () => _confirmAbort(context, ref),
                    )
                  else
                    const SizedBox(width: 48),
                  const Spacer(),
                  if (session.isHardLock)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.ringDanger.withValues(alpha: 0.15),
                        borderRadius: AppRadius.rPill,
                        border: Border.all(
                          color: AppColors.ringDanger.withValues(alpha: 0.4),
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.lock_rounded,
                              size: 14, color: AppColors.ringDanger),
                          SizedBox(width: 6),
                          Text(
                            'SIKI MOD',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: AppColors.ringDanger,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              const Spacer(),
              RingTimer(
                progress: session.progress,
                label: '$mm:$ss',
                sublabel: isPaused ? 'DURAKLATILDI' : 'ODAK MODU',
                color: isPaused ? AppColors.neonOrange : AppColors.neonGreen,
              ),
              const SizedBox(height: AppSpacing.s8),
              Text(
                'Telefonu bırak. Kendine ver bu anı.',
                style: AppType.caption,
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              // Controls
              if (!session.isHardLock)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (isRunning)
                      PillButton(
                        label: 'Duraklat',
                        icon: Icons.pause_rounded,
                        color: AppColors.cardBg,
                        textColor: Colors.white,
                        onTap: () {
                          HapticService.light();
                          ref.read(sessionProvider.notifier).pause();
                        },
                      ),
                    if (isPaused)
                      PillButton(
                        label: 'Devam',
                        icon: Icons.play_arrow_rounded,
                        onTap: () {
                          HapticService.medium();
                          ref.read(sessionProvider.notifier).resume();
                        },
                      ),
                  ],
                ),
              const SizedBox(height: AppSpacing.s6),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmAbort(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.cardBg,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.rM),
        title: Text('Seansı bitir?', style: AppType.title),
        content: Text(
          'Şimdi bitirirsen O₂ kazanmayacaksın.',
          style: AppType.caption,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Vazgeç',
                style: TextStyle(color: AppColors.textSecondary)),
          ),
          TextButton(
            onPressed: () {
              ref.read(sessionProvider.notifier).abort();
              Navigator.of(ctx).pop();
              if (context.mounted) context.go('/');
            },
            child: const Text('Bitir',
                style: TextStyle(color: AppColors.ringDanger)),
          ),
        ],
      ),
    );
  }
}
