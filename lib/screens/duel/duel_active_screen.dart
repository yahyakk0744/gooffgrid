import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme.dart';
import '../../widgets/premium_background.dart';
import '../../services/haptic_service.dart';

class DuelActiveScreen extends ConsumerWidget {
  const DuelActiveScreen({super.key, this.duelId});
  final String? duelId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Mock data
    const p1Name = 'Sen';
    const p2Name = 'Mert';
    const p1Minutes = 134;
    const p2Minutes = 178;
    const p1Winning = p1Minutes <= p2Minutes;
    const remainHours = 9;
    const remainMin = 42;

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: PremiumBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Header
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: const Icon(Icons.arrow_back_rounded,
                          color: AppColors.textPrimary),
                    ),
                    const SizedBox(width: 12),
                    const Text('Düello', style: AppTextStyles.h1),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppColors.neonGreen.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.neonGreen.withValues(alpha: 0.4),
                        ),
                      ),
                      child: const Text(
                        '${remainHours}s ${remainMin}dk kaldı',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.neonGreen,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 48),

                // VS Section
                Row(
                  children: [
                    Expanded(
                      child: _PlayerSide(
                        name: p1Name,
                        minutes: p1Minutes,
                        isWinning: p1Winning,
                        isOnline: true,
                        avatarColor: const Color(0xFF667EEA),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'VS',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color: AppColors.neonOrange,
                          shadows: [
                            Shadow(
                              color:
                                  AppColors.neonOrange.withValues(alpha: 0.6),
                              blurRadius: 24,
                            ),
                            Shadow(
                              color:
                                  AppColors.neonOrange.withValues(alpha: 0.3),
                              blurRadius: 48,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: _PlayerSide(
                        name: p2Name,
                        minutes: p2Minutes,
                        isWinning: !p1Winning,
                        isOnline: false,
                        avatarColor: const Color(0xFF30D158),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),

                // Countdown
                Text(
                  '${remainHours.toString().padLeft(2, '0')}:${remainMin.toString().padLeft(2, '0')}:17',
                  style: AppTextStyles.heroNumber.copyWith(
                    fontSize: 48,
                    color: AppColors.neonGreen,
                    shadows: [
                      Shadow(
                        color: AppColors.neonGreen.withValues(alpha: 0.4),
                        blurRadius: 20,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Kalan Süre',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 32),

                // Viewer count
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.cardBg,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.cardBorder),
                  ),
                  child: const Text(
                    '23 kişi izliyor 👀',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),

                const Spacer(),

                // Pes Et button
                SizedBox(
                  width: 140,
                  height: 44,
                  child: OutlinedButton(
                    onPressed: () {
                      HapticService.warning();
                      context.go('/duel/result');
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.ringDanger,
                      side: const BorderSide(color: AppColors.ringDanger),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Pes Et',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
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
  const _PlayerSide({
    required this.name,
    required this.minutes,
    required this.isWinning,
    required this.isOnline,
    required this.avatarColor,
  });

  final String name;
  final int minutes;
  final bool isWinning;
  final bool isOnline;
  final Color avatarColor;

  @override
  Widget build(BuildContext context) {
    final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';
    final hours = minutes ~/ 60;
    final mins = minutes % 60;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isWinning
            ? AppColors.neonGreen.withValues(alpha: 0.06)
            : AppColors.ringDanger.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: avatarColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color:
                        isWinning ? AppColors.neonGreen : AppColors.ringDanger,
                    width: 2,
                  ),
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
          const SizedBox(height: 8),
          Text(name, style: AppTextStyles.h3),
          const SizedBox(height: 4),
          Text(
            '${hours}s ${mins}dk',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: isWinning ? AppColors.ringGood : AppColors.ringDanger,
            ),
          ),
        ],
      ),
    );
  }
}
