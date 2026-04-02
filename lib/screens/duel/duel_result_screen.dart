import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme.dart';
import '../../widgets/premium_background.dart';
import '../../services/haptic_service.dart';

class DuelResultScreen extends ConsumerStatefulWidget {
  const DuelResultScreen({super.key});

  @override
  ConsumerState<DuelResultScreen> createState() => _DuelResultScreenState();
}

class _DuelResultScreenState extends ConsumerState<DuelResultScreen> {
  late final ConfettiController _confetti;

  // Mock data — default "won" state
  static const _won = true;
  static const _playerName = 'Sen';
  static const _playerMinutes = 134;
  static const _opponentName = 'Mert';
  static const _opponentMinutes = 178;
  static const _o2Earned = 150;

  @override
  void initState() {
    super.initState();
    _confetti = ConfettiController(duration: const Duration(seconds: 3));
    if (_won) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _confetti.play();
        HapticService.success();
      });
    }
  }

  @override
  void dispose() {
    _confetti.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: PremiumBackground(
        child: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const SizedBox(height: 48),

                    // Result title
                    Text(
                      _won ? 'Kazandın! 🎉' : 'Kaybettin 😔',
                      style: AppTextStyles.heroNumber.copyWith(
                        fontSize: 36,
                        color:
                            _won ? AppColors.neonGreen : AppColors.ringDanger,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _won
                          ? 'Harika performans gösterdin!'
                          : 'Bir dahaki sefere daha iyi olacak!',
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Stats comparison
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.cardBg,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.cardBorder),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: _StatColumn(
                              name: _playerName,
                              minutes: _playerMinutes,
                              isWinner: _won,
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 80,
                            color: AppColors.cardBorder,
                          ),
                          Expanded(
                            child: _StatColumn(
                              name: _opponentName,
                              minutes: _opponentMinutes,
                              isWinner: !_won,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // O2 earned
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 14),
                      decoration: BoxDecoration(
                        color: AppColors.gold.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: AppColors.gold.withValues(alpha: 0.3),
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('🫁', style: TextStyle(fontSize: 24)),
                          SizedBox(width: 10),
                          Text(
                            '+$_o2Earned O₂',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: AppColors.gold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Spacer(),

                    // Buttons
                    if (!_won)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: OutlinedButton(
                            onPressed: () {
                              HapticService.medium();
                              context.go('/duel/create');
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.neonOrange,
                              side: const BorderSide(
                                  color: AppColors.neonOrange),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: const Text(
                              'İntikam Al 🔥',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () {
                          HapticService.light();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.neonGreen,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          textStyle: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        child: const Text('Paylaş'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () => context.go('/duel'),
                      child: const Text(
                        'Tamam',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),

              // Confetti
              Align(
                alignment: Alignment.topCenter,
                child: ConfettiWidget(
                  confettiController: _confetti,
                  blastDirectionality: BlastDirectionality.explosive,
                  shouldLoop: false,
                  colors: const [
                    AppColors.neonGreen,
                    AppColors.neonOrange,
                    AppColors.gold,
                    Colors.white,
                  ],
                  numberOfParticles: 30,
                  maxBlastForce: 20,
                  minBlastForce: 8,
                  gravity: 0.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  const _StatColumn({
    required this.name,
    required this.minutes,
    required this.isWinner,
  });

  final String name;
  final int minutes;
  final bool isWinner;

  @override
  Widget build(BuildContext context) {
    final hours = minutes ~/ 60;
    final mins = minutes % 60;

    return Column(
      children: [
        if (isWinner)
          const Text('👑', style: TextStyle(fontSize: 20)),
        const SizedBox(height: 4),
        Text(name, style: AppTextStyles.h3),
        const SizedBox(height: 8),
        Text(
          '${hours}s ${mins}dk',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: isWinner ? AppColors.ringGood : AppColors.ringDanger,
          ),
        ),
      ],
    );
  }
}
