import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../config/design_tokens.dart';
import '../../config/theme.dart';
import '../../services/haptic_service.dart';
import '../../widgets/bento/bento_card.dart';
import '../../widgets/common/pill_button.dart';

/// Opal-style "Wins" recap after a focus session.
class SessionCompleteScreen extends StatefulWidget {
  const SessionCompleteScreen({
    super.key,
    required this.durationMin,
    required this.gemsEarned,
  });

  final int durationMin;
  final int gemsEarned;

  @override
  State<SessionCompleteScreen> createState() => _SessionCompleteScreenState();
}

class _SessionCompleteScreenState extends State<SessionCompleteScreen> {
  late final ConfettiController _confetti;

  @override
  void initState() {
    super.initState();
    _confetti = ConfettiController(duration: const Duration(seconds: 3));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _confetti.play();
      HapticService.success();
    });
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
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.s5),
              child: Column(
                children: [
                  const SizedBox(height: AppSpacing.s10),
                  const Text('🏆', style: TextStyle(fontSize: 80)),
                  const SizedBox(height: AppSpacing.s5),
                  const Text(
                    'Harika iş!',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -1,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.s2),
                  Text(
                    'Seansını tamamladın.',
                    style: AppType.caption.copyWith(fontSize: 15),
                  ),
                  const SizedBox(height: AppSpacing.s8),
                  Row(
                    children: [
                      Expanded(
                        child: BentoCard(
                          accent: AppColors.neonGreen,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('⏱️',
                                  style: TextStyle(fontSize: 28)),
                              const SizedBox(height: AppSpacing.s3),
                              Text('${widget.durationMin} dk',
                                  style: AppType.h1.copyWith(
                                      color: AppColors.neonGreen,
                                      letterSpacing: -1)),
                              const SizedBox(height: 2),
                              Text('Ekransız', style: AppType.caption),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.s3),
                      Expanded(
                        child: BentoCard(
                          accent: AppColors.gold,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('🍃',
                                  style: TextStyle(fontSize: 28)),
                              const SizedBox(height: AppSpacing.s3),
                              Text('+${widget.gemsEarned}',
                                  style: AppType.h1.copyWith(
                                      color: AppColors.gold,
                                      letterSpacing: -1)),
                              const SizedBox(height: 2),
                              Text('O₂ puanı', style: AppType.caption),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  PillButton(
                    label: 'Devam et',
                    expanded: true,
                    onTap: () => context.go('/'),
                  ),
                  const SizedBox(height: AppSpacing.s6),
                ],
              ),
            ),
            ConfettiWidget(
              confettiController: _confetti,
              blastDirectionality: BlastDirectionality.explosive,
              numberOfParticles: 30,
              maxBlastForce: 18,
              gravity: 0.25,
              colors: const [
                AppColors.neonGreen,
                AppColors.neonOrange,
                AppColors.gold,
                Colors.white,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
