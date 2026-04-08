import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../config/theme.dart';
import '../../models/duel.dart';
import '../../providers/duel_provider.dart';
import '../../widgets/premium_background.dart';
import '../../services/haptic_service.dart';
import '../../l10n/app_localizations.dart';

class DuelActiveScreen extends ConsumerStatefulWidget {
  const DuelActiveScreen({super.key, this.duelId});
  final String? duelId;

  @override
  ConsumerState<DuelActiveScreen> createState() => _DuelActiveScreenState();
}

class _DuelActiveScreenState extends ConsumerState<DuelActiveScreen> {
  late Timer _timer;
  Duration _remaining = Duration.zero;

  @override
  void initState() {
    super.initState();
    _tick();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  void _tick() {
    final duel = _activeDuel;
    if (duel == null) return;
    final end = duel.startTime.add(Duration(minutes: duel.durationMinutes));
    final remaining = end.difference(DateTime.now());
    setState(() {
      _remaining = remaining.isNegative ? Duration.zero : remaining;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Duel? get _activeDuel {
    final duels = ref.read(duelProvider);
    if (widget.duelId != null) {
      try {
        return duels.firstWhere((d) => d.id == widget.duelId);
      } catch (_) {
        return null;
      }
    }
    // Fallback: first active duel
    try {
      return duels.firstWhere((d) => d.status == DuelStatus.active);
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final duels = ref.watch(duelProvider);

    Duel? duel;
    if (widget.duelId != null) {
      try {
        duel = duels.firstWhere((d) => d.id == widget.duelId);
      } catch (_) {}
    }
    duel ??= duels.where((d) => d.status == DuelStatus.active).firstOrNull;

    if (duel == null) {
      return Scaffold(
        backgroundColor: AppColors.bg,
        body: Center(
          child: Text(
            'Aktif düello bulunamadı.',
            style: AppType.body.copyWith(color: AppColors.textSecondary),
          ),
        ),
      );
    }

    final p1 = duel.player1;
    final p2 = duel.player2;

    // Lower screen time = winning (less phone use wins)
    final p1Winning = p1.totalMinutes <= p2.totalMinutes;

    final remainHours = _remaining.inHours;
    final remainMin = _remaining.inMinutes % 60;
    final remainSec = _remaining.inSeconds % 60;

    // Progress bar ratio: max minutes as denominator
    final maxMinutes =
        p1.totalMinutes > p2.totalMinutes ? p1.totalMinutes : p2.totalMinutes;
    final p1Progress = maxMinutes > 0 ? p1.totalMinutes / maxMinutes : 0.0;
    final p2Progress = maxMinutes > 0 ? p2.totalMinutes / maxMinutes : 0.0;

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: PremiumBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.s4),
            child: Column(
              children: [
                // ── Header ──────────────────────────────────────────────
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: const Icon(Icons.arrow_back_rounded,
                          color: AppColors.textPrimary),
                    ),
                    const SizedBox(width: AppSpacing.s3),
                    Text(l.duel, style: AppType.h2),
                    const Spacer(),
                    _RemainingBadge(
                      hours: remainHours,
                      minutes: remainMin,
                      l: l,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.s12),

                // ── VS Section ──────────────────────────────────────────
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          HapticService.light();
                          context.push('/user/${p1.userId}');
                        },
                        child: _PlayerSide(
                          player: p1,
                          isWinning: p1Winning,
                          isOnline: true,
                          progress: p1Progress,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.s3,
                          vertical: AppSpacing.s8),
                      child: Text(
                        'VS',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color: AppColors.neonOrange,
                          shadows: [
                            Shadow(
                              color: AppColors.neonOrange.withValues(alpha: 0.6),
                              blurRadius: 24,
                            ),
                            Shadow(
                              color: AppColors.neonOrange.withValues(alpha: 0.3),
                              blurRadius: 48,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          HapticService.light();
                          context.push('/user/${p2.userId}');
                        },
                        child: _PlayerSide(
                          player: p2,
                          isWinning: !p1Winning,
                          isOnline: false,
                          progress: p2Progress,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.s6),

                // ── Current winner banner ────────────────────────────────
                _WinnerBanner(
                  winnerName: p1Winning ? p1.name : p2.name,
                  isDraw: p1.totalMinutes == p2.totalMinutes,
                ),
                const SizedBox(height: AppSpacing.s8),

                // ── Live countdown ───────────────────────────────────────
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.s6, horizontal: AppSpacing.s4),
                  decoration: BoxDecoration(
                    color: AppColors.cardBg,
                    borderRadius: AppRadius.rM,
                    border: Border.all(color: AppColors.cardBorder),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '${remainHours.toString().padLeft(2, '0')}:'
                        '${remainMin.toString().padLeft(2, '0')}:'
                        '${remainSec.toString().padLeft(2, '0')}',
                        style: AppType.monoDisplay.copyWith(
                          fontSize: 48,
                          color: _remaining.inMinutes < 60
                              ? AppColors.ringDanger
                              : AppColors.neonGreen,
                          shadows: [
                            Shadow(
                              color: (_remaining.inMinutes < 60
                                      ? AppColors.ringDanger
                                      : AppColors.neonGreen)
                                  .withValues(alpha: 0.4),
                              blurRadius: 20,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSpacing.s2),
                      Text(
                        l.remainingTime,
                        style: AppType.caption,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.s4),

                // ── Screen time comparison bars ──────────────────────────
                _ScreenTimeComparison(
                  p1: p1,
                  p2: p2,
                  p1Winning: p1Winning,
                ),
                const SizedBox(height: AppSpacing.s4),

                // ── Viewer count ─────────────────────────────────────────
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.s4, vertical: AppSpacing.s2),
                  decoration: BoxDecoration(
                    color: AppColors.cardBg,
                    borderRadius: AppRadius.rPill,
                    border: Border.all(color: AppColors.cardBorder),
                  ),
                  child: Text(
                    l.watchersCount(23),
                    style: AppType.caption,
                  ),
                ),
                const SizedBox(height: AppSpacing.s10),

                // ── Pes Et button ─────────────────────────────────────────
                SizedBox(
                  width: 160,
                  height: 48,
                  child: OutlinedButton(
                    onPressed: () {
                      HapticService.warning();
                      _showGiveUpDialog(context, l);
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.ringDanger,
                      side: const BorderSide(color: AppColors.ringDanger),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.xs),
                      ),
                    ),
                    child: Text(
                      l.giveUp,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.s12),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showGiveUpDialog(BuildContext context, AppLocalizations l) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.cardBg,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.rM),
        title: Text('Düellodan çekil?',
            style: AppType.title.copyWith(color: AppColors.textPrimary)),
        content: Text(
          'Pes edersen düelloyu kaybetmiş sayılırsın.',
          style: AppType.body.copyWith(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => ctx.pop(),
            child: Text('İptal',
                style: TextStyle(color: AppColors.textSecondary)),
          ),
          TextButton(
            onPressed: () {
              ctx.pop();
              context.go('/duel/result');
            },
            child: Text(
              l.giveUp,
              style: const TextStyle(
                  color: AppColors.ringDanger, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}

// ── _RemainingBadge ──────────────────────────────────────────────────────────

class _RemainingBadge extends StatelessWidget {
  const _RemainingBadge({
    required this.hours,
    required this.minutes,
    required this.l,
  });

  final int hours;
  final int minutes;
  final AppLocalizations l;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.s3, vertical: AppSpacing.s1 + 1),
      decoration: BoxDecoration(
        color: AppColors.neonGreen.withValues(alpha: 0.15),
        borderRadius: AppRadius.rPill,
        border: Border.all(
          color: AppColors.neonGreen.withValues(alpha: 0.4),
        ),
      ),
      child: Text(
        l.duelRemaining(hours, minutes),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: AppColors.neonGreen,
        ),
      ),
    );
  }
}

// ── _PlayerSide ──────────────────────────────────────────────────────────────

class _PlayerSide extends StatelessWidget {
  const _PlayerSide({
    required this.player,
    required this.isWinning,
    required this.isOnline,
    required this.progress,
  });

  final DuelPlayer player;
  final bool isWinning;
  final bool isOnline;
  final double progress;

  @override
  Widget build(BuildContext context) {
    final initial =
        player.name.isNotEmpty ? player.name[0].toUpperCase() : '?';
    final hours = player.totalMinutes ~/ 60;
    final mins = player.totalMinutes % 60;
    final winColor = isWinning ? AppColors.ringGood : AppColors.ringDanger;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.s4),
      decoration: BoxDecoration(
        color: isWinning
            ? AppColors.neonGreen.withValues(alpha: 0.06)
            : AppColors.ringDanger.withValues(alpha: 0.06),
        borderRadius: AppRadius.rS,
        border: Border.all(
          color: isWinning
              ? AppColors.neonGreen.withValues(alpha: 0.25)
              : AppColors.ringDanger.withValues(alpha: 0.25),
        ),
      ),
      child: Column(
        children: [
          // Avatar
          Stack(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: player.avatarColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: winColor, width: 2),
                ),
                child: Center(
                  child: Text(
                    initial,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              if (isOnline)
                Positioned(
                  bottom: 2,
                  right: 2,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: AppColors.friendOnline,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.bg, width: 2),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.s2),
          Text(player.name, style: AppType.body),
          const SizedBox(height: AppSpacing.s1),
          // Screen time number
          Text(
            '${hours}s ${mins}dk',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: winColor,
            ),
          ),
          const SizedBox(height: AppSpacing.s3),
          // Progress bar (lower = better, so invert visually)
          ClipRRect(
            borderRadius: AppRadius.rPill,
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: AppColors.ringTrack,
              valueColor: AlwaysStoppedAnimation<Color>(
                isWinning ? AppColors.ringGood : AppColors.ringDanger,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.s2),
          // Winner crown / loser icon
          if (isWinning)
            const Text('👑', style: TextStyle(fontSize: 16))
          else
            const SizedBox(height: 20),
        ],
      ),
    );
  }
}

// ── _WinnerBanner ────────────────────────────────────────────────────────────

class _WinnerBanner extends StatelessWidget {
  const _WinnerBanner({
    required this.winnerName,
    required this.isDraw,
  });

  final String winnerName;
  final bool isDraw;

  @override
  Widget build(BuildContext context) {
    final label = isDraw ? 'Berabere gidiyorsunuz 🤝' : '$winnerName önde gidiyor 🏆';
    final color = isDraw ? AppColors.ringWarning : AppColors.neonGreen;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.s3, horizontal: AppSpacing.s4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: AppRadius.rS,
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}

// ── _ScreenTimeComparison ────────────────────────────────────────────────────

class _ScreenTimeComparison extends StatelessWidget {
  const _ScreenTimeComparison({
    required this.p1,
    required this.p2,
    required this.p1Winning,
  });

  final DuelPlayer p1;
  final DuelPlayer p2;
  final bool p1Winning;

  @override
  Widget build(BuildContext context) {
    final total = p1.totalMinutes + p2.totalMinutes;
    // p1 share of total minutes; if both 0 → 0.5 each
    final p1Share = total > 0 ? p1.totalMinutes / total : 0.5;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.s4),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: AppRadius.rM,
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ekran Süresi Karşılaştırması',
            style: AppType.caption.copyWith(
              letterSpacing: 0.5,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.s3),
          // Split bar
          ClipRRect(
            borderRadius: AppRadius.rPill,
            child: LayoutBuilder(
              builder: (ctx, constraints) {
                final fullWidth = constraints.maxWidth;
                final p1Width = fullWidth * p1Share;
                final p2Width = fullWidth * (1 - p1Share);
                return Row(
                  children: [
                    if (p1Width > 0)
                      AnimatedContainer(
                        duration: AppMotion.slow,
                        curve: AppMotion.emphasized,
                        width: p1Width,
                        height: 16,
                        color: p1Winning
                            ? AppColors.ringGood
                            : AppColors.ringDanger,
                      ),
                    if (p2Width > 0)
                      AnimatedContainer(
                        duration: AppMotion.slow,
                        curve: AppMotion.emphasized,
                        width: p2Width,
                        height: 16,
                        color: p1Winning
                            ? AppColors.ringDanger
                            : AppColors.ringGood,
                      ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: AppSpacing.s3),
          // Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _LegendItem(
                name: p1.name,
                minutes: p1.totalMinutes,
                color: p1Winning ? AppColors.ringGood : AppColors.ringDanger,
              ),
              _LegendItem(
                name: p2.name,
                minutes: p2.totalMinutes,
                color: p1Winning ? AppColors.ringDanger : AppColors.ringGood,
                alignRight: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({
    required this.name,
    required this.minutes,
    required this.color,
    this.alignRight = false,
  });

  final String name;
  final int minutes;
  final Color color;
  final bool alignRight;

  @override
  Widget build(BuildContext context) {
    final hours = minutes ~/ 60;
    final mins = minutes % 60;
    final timeStr = hours > 0 ? '${hours}s ${mins}dk' : '${mins}dk';

    final children = [
      Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
      const SizedBox(width: AppSpacing.s1),
      Column(
        crossAxisAlignment:
            alignRight ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(name,
              style: AppType.caption.copyWith(color: AppColors.textPrimary)),
          Text(timeStr, style: AppType.caption.copyWith(color: color)),
        ],
      ),
    ];

    return Row(
      children: alignRight ? children.reversed.toList() : children,
    );
  }
}
