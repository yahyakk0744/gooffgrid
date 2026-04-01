import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:confetti/confetti.dart';
import '../../config/theme.dart';
import '../../providers/o2_provider.dart';
import '../../widgets/premium_background.dart';
import '../../widgets/breathing_circle.dart';
import '../../services/haptic_service.dart';

class FocusModeScreen extends ConsumerStatefulWidget {
  const FocusModeScreen({super.key});

  @override
  ConsumerState<FocusModeScreen> createState() => _FocusModeScreenState();
}

class _FocusModeScreenState extends ConsumerState<FocusModeScreen> {
  bool _isComplete = false;
  int _earnedO2 = 0;
  int _focusMinutes = 0;
  String? _error;
  late ConfettiController _confetti;

  bool _timeoutDialogShown = false;

  @override
  void initState() {
    super.initState();
    _confetti = ConfettiController(duration: const Duration(seconds: 3));
  }

  @override
  void dispose() {
    _confetti.dispose();
    super.dispose();
  }

  Future<void> _start() async {
    final notifier = ref.read(focusSessionProvider.notifier);
    final success = await notifier.start();
    if (!success) {
      setState(() => _error = 'O₂ sadece 08:00–00:00 arası kazanılır');
    } else {
      setState(() {
        _isComplete = false;
        _earnedO2 = 0;
        _error = null;
      });
    }
  }

  Future<void> _stop() async {
    final notifier = ref.read(focusSessionProvider.notifier);
    final result = await notifier.stop();
    setState(() {
      _isComplete = true;
      _earnedO2 = result.o2Earned;
      _focusMinutes = result.minutes;
    });
    if (result.success && result.o2Earned > 0) {
      HapticService.success();
      _confetti.play();
    }
  }

  String _formatTime(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  void _showTimeoutDialog() {
    if (_timeoutDialogShown) return;
    _timeoutDialogShown = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A2E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Hâlâ burada mısın?',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        content: const Text(
          '120 dakikalık odak limitine ulaştın. Oturum otomatik olarak sonlandırıldı.\n\nDinlenmek önemli! Kısa bir mola vermeyi düşün.',
          style: TextStyle(color: Colors.white70, fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              _timeoutDialogShown = false;
            },
            child: const Text('Tamam', style: TextStyle(color: AppColors.neonGreen)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(focusSessionProvider);
    final o2 = ref.watch(o2Provider);

    // Anti-cheat: 120dk timeout olunca onay dialogu goster
    ref.listen<FocusSessionState>(focusSessionProvider, (prev, next) {
      if (next.isTimeout && !(prev?.isTimeout ?? false)) {
        _showTimeoutDialog();
      }
    });

    return Scaffold(
      body: PremiumBackground(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF0D0D2B), Color(0xFF1A0D3B)],
            ),
          ),
          child: SafeArea(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                ConfettiWidget(
                  confettiController: _confetti,
                  blastDirectionality: BlastDirectionality.explosive,
                  colors: const [AppColors.neonGreen, AppColors.gold, AppColors.neonOrange],
                ),
                Column(
                  children: [
                    const SizedBox(height: 16),

                    // O2 Balance bar
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 24),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.06),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white.withOpacity(0.1)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('O₂', style: TextStyle(fontSize: 14, color: AppColors.neonGreen.withOpacity(0.7))),
                          const SizedBox(width: 6),
                          Text('${o2.balance}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.neonGreen)),
                          const SizedBox(width: 12),
                          Container(width: 1, height: 16, color: Colors.white.withOpacity(0.15)),
                          const SizedBox(width: 12),
                          Text('Kalan: ${o2.dailyRemaining}', style: TextStyle(fontSize: 12, color: AppColors.textTertiary)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Timer
                    Text(
                      _formatTime(session.elapsedSeconds),
                      style: const TextStyle(fontSize: 56, fontWeight: FontWeight.w200, color: Colors.white, letterSpacing: 6),
                    ),

                    // Anti-cheat: 120dk uyarısı
                    if (session.isActive && session.isNearTimeout)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.ringDanger.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '⚠️ ${session.remainingSeconds ~/ 60}dk kaldı (120dk limit)',
                            style: const TextStyle(fontSize: 12, color: AppColors.ringDanger),
                          ),
                        ),
                      ),

                    // Timeout warning
                    if (session.isTimeout)
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 32),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.ringDanger.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.ringDanger.withOpacity(0.3)),
                          ),
                          child: const Column(
                            children: [
                              Text('⏱️ Oturum Zaman Aşımı', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.ringDanger)),
                              SizedBox(height: 4),
                              Text('120 dakika limitine ulaştın.\nHâlâ orada mısın?', style: TextStyle(fontSize: 13, color: AppColors.textSecondary), textAlign: TextAlign.center),
                            ],
                          ),
                        ),
                      ),

                    const Spacer(),
                    BreathingCircle(isActive: session.isActive),
                    const SizedBox(height: 24),

                    if (session.isActive)
                      Column(
                        children: [
                          Text('Odaklanıyorsun...', style: AppTextStyles.bodySecondary.copyWith(color: Colors.white60)),
                          const SizedBox(height: 4),
                          Text(
                            '+${(session.elapsedMinutes * 3).clamp(0, 500)} O₂ (tahmini)',
                            style: TextStyle(fontSize: 13, color: AppColors.neonGreen.withOpacity(0.7)),
                          ),
                        ],
                      )
                    else if (_isComplete)
                      Column(
                        children: [
                          Text(
                            'Harika! $_focusMinutes dk odaklandın',
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.neonGreen),
                          ),
                          const SizedBox(height: 4),
                          Text('+$_earnedO2 O₂', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.gold, shadows: [Shadow(color: AppColors.gold.withOpacity(0.4), blurRadius: 8)])),
                        ],
                      ),

                    if (_error != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Text(_error!, style: const TextStyle(fontSize: 13, color: AppColors.ringDanger)),
                      ),

                    const Spacer(),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            HapticService.medium();
                            (session.isActive ? _stop : _start)();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: session.isActive ? AppColors.ringDanger : AppColors.neonGreen,
                            foregroundColor: session.isActive ? Colors.white : Colors.black,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          child: Text(session.isActive ? 'Bitir' : 'Odak Modunu Başlat'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
