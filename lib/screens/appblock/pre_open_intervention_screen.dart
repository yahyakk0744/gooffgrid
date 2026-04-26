import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../config/app_shadows.dart';
import '../../config/design_tokens.dart';
import '../../config/theme.dart';
import '../../services/haptic_service.dart';
import '../../widgets/premium_background.dart';

/// one sec-style pre-open intervention.
///
/// Native bridge (Android Accessibility Service / iOS Shortcuts Automation)
/// calls `context.push('/pre-open?app=com.instagram.android')` when user
/// attempts to open a blocked app.
///
/// UX: 5-saniye zorunlu nefes → "Vazgeç" (hero) veya "Yine de aç" (secondary).
class PreOpenInterventionScreen extends ConsumerStatefulWidget {
  const PreOpenInterventionScreen({
    super.key,
    required this.appPackageOrLabel,
    this.appIcon,
    this.countdownSeconds = 5,
  });

  final String appPackageOrLabel;
  final Widget? appIcon;
  final int countdownSeconds;

  @override
  ConsumerState<PreOpenInterventionScreen> createState() =>
      _PreOpenInterventionScreenState();
}

class _PreOpenInterventionScreenState
    extends ConsumerState<PreOpenInterventionScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _breath;
  late int _secondsLeft;
  Timer? _tick;

  @override
  void initState() {
    super.initState();
    _secondsLeft = widget.countdownSeconds;
    _breath = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    HapticService.medium();
    _tick = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;
      setState(() {
        _secondsLeft--;
        if (_secondsLeft <= 0) {
          _secondsLeft = 0;
          t.cancel();
          HapticService.light();
        }
      });
    });
  }

  @override
  void dispose() {
    _tick?.cancel();
    _breath.dispose();
    super.dispose();
  }

  void _handleAbandon() {
    HapticService.success();
    // Kullanıcı vazgeçti — blok başarılı. O2 kristal ödülü burada verilebilir.
    if (mounted) context.pop(true); // true = abandoned
  }

  void _handleProceedAnyway() {
    HapticService.warning();
    // Yine de aç. Native katman bu return değerini alıp app'i açacak.
    if (mounted) context.pop(false); // false = proceed
  }

  @override
  Widget build(BuildContext context) {
    final canProceed = _secondsLeft == 0;
    final progress =
        1 - (_secondsLeft / widget.countdownSeconds).clamp(0.0, 1.0);

    return PopScope(
      canPop: false, // Back tuşu devre dışı — sadece CTA'larla çıkış
      child: Scaffold(
        backgroundColor: AppColors.bg,
        body: PremiumBackground(
          noiseOpacity: 0.04,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Breathing orb
                  SizedBox(
                    width: 240,
                    height: 240,
                    child: AnimatedBuilder(
                      animation: _breath,
                      builder: (context, _) {
                        final t = Curves.easeInOut.transform(_breath.value);
                        final scale = 0.75 + 0.25 * t;
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            // Progress ring
                            SizedBox(
                              width: 240,
                              height: 240,
                              child: CircularProgressIndicator(
                                value: progress,
                                strokeWidth: 3,
                                backgroundColor: Colors.white.withValues(alpha: 0.06),
                                valueColor: AlwaysStoppedAnimation(
                                  AppColors.accentBlue.withValues(alpha: 0.8),
                                ),
                              ),
                            ),
                            Transform.scale(
                              scale: scale,
                              child: Container(
                                width: 160,
                                height: 160,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: RadialGradient(
                                    colors: [
                                      AppColors.accentBlue.withValues(alpha: 0.4),
                                      AppColors.accentBlue.withValues(alpha: 0.1),
                                    ],
                                  ),
                                  boxShadow: AppShadow.glow(
                                    AppColors.accentBlue,
                                    intensity: 0.35,
                                    blur: 40,
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  canProceed ? 'Tamam' : 'Nefes al',
                                  style: AppType.caption.copyWith(
                                    color: Colors.white.withValues(alpha: 0.8),
                                    letterSpacing: 2,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  canProceed ? '0' : '$_secondsLeft',
                                  style: AppType.display.copyWith(
                                    fontSize: 72,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: AppSpacing.s8),

                  Text(
                    'Gerçekten açmak istiyor musun?',
                    textAlign: TextAlign.center,
                    style: AppType.h2,
                  ),
                  const SizedBox(height: AppSpacing.s3),
                  Text(
                    widget.appPackageOrLabel,
                    style: AppType.caption.copyWith(
                      color: Colors.white.withValues(alpha: 0.5),
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.s4),
                  Text(
                    'Son açılışın 12 dakika önceydi.\nBu zaman, sana geri gelmeyecek.',
                    textAlign: TextAlign.center,
                    style: AppType.body.copyWith(
                      color: Colors.white.withValues(alpha: 0.55),
                      height: 1.5,
                    ),
                  ),
                  const Spacer(),

                  // Primary CTA — vazgeç (hero)
                  SizedBox(
                    width: double.infinity,
                    child: GestureDetector(
                      onTap: _handleAbandon,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: AppSpacing.s5),
                        decoration: BoxDecoration(
                          color: AppColors.neonGreen,
                          borderRadius: AppRadius.rPill,
                          boxShadow: AppShadow.glow(
                            AppColors.neonGreen,
                            intensity: 0.4,
                            blur: 24,
                          ),
                        ),
                        child: const Text(
                          'Vazgeçtim · +5 O₂',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.s3),

                  // Secondary — proceed (disabled until countdown done)
                  SizedBox(
                    width: double.infinity,
                    child: GestureDetector(
                      onTap: canProceed ? _handleProceedAnyway : null,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: AppSpacing.s5),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: AppRadius.rPill,
                          border: Border.all(
                            color: Colors.white.withValues(
                              alpha: canProceed ? 0.2 : 0.08,
                            ),
                          ),
                        ),
                        child: Text(
                          canProceed
                              ? 'Yine de aç'
                              : '$_secondsLeft saniye sonra açılabilir',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withValues(
                              alpha: canProceed ? 0.75 : 0.35,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.s6),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
