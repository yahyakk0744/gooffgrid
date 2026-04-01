import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/theme.dart';
import '../../widgets/premium_background.dart';
import '../../providers/duel_provider.dart';

class DuelActiveScreen extends ConsumerWidget {
  const DuelActiveScreen({super.key, required this.duelId});
  final String duelId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final duels = ref.watch(duelProvider);
    final duel = duels.firstWhere(
      (d) => d.id == duelId,
      orElse: () => duels.first,
    );

    final p1Winning = duel.player1.totalMinutes <= duel.player2.totalMinutes;
    final remaining = duel.startTime.add(Duration(minutes: duel.durationMinutes)).difference(DateTime.now());
    final remainHours = remaining.inHours;
    final remainMin = remaining.inMinutes % 60;
    final formattedRemaining = '${remainHours}s ${remainMin}dk';

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: PremiumBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 32),

                // Countdown
                Text(
                  'Kalan: $formattedRemaining',
                  style: AppTextStyles.heroNumber.copyWith(color: AppColors.neonGreen),
                ),
                const SizedBox(height: 48),

                // VS layout
                Row(
                  children: [
                    Expanded(
                      child: _PlayerSide(
                        name: duel.player1.name,
                        minutes: duel.player1.totalMinutes,
                        isWinning: p1Winning,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'VS',
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: AppColors.neonOrange),
                      ),
                    ),
                    Expanded(
                      child: _PlayerSide(
                        name: duel.player2.name,
                        minutes: duel.player2.totalMinutes,
                        isWinning: !p1Winning,
                      ),
                    ),
                  ],
                ),

                const Spacer(),
                Text(
                  'Telefonunu birak ve kazan',
                  style: AppTextStyles.bodySecondary,
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PlayerSide extends StatelessWidget {
  const _PlayerSide({required this.name, required this.minutes, required this.isWinning});
  final String name;
  final int minutes;
  final bool isWinning;

  @override
  Widget build(BuildContext context) {
    final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';
    final bgColor = isWinning
        ? AppColors.neonGreen.withOpacity(0.08)
        : AppColors.ringDanger.withOpacity(0.08);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.surface,
              shape: BoxShape.circle,
              border: Border.all(
                color: isWinning ? AppColors.neonGreen : AppColors.ringDanger,
                width: 2,
              ),
            ),
            child: Center(
              child: Text(initial, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
            ),
          ),
          const SizedBox(height: 8),
          Text(name, style: AppTextStyles.h3),
          const SizedBox(height: 4),
          Text(
            '${minutes}dk',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: isWinning ? AppColors.ringGood : AppColors.ringDanger,
            ),
          ),
        ],
      ),
    );
  }
}
