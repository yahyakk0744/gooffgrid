import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme.dart';
import '../../config/design_tokens.dart';
import '../../config/app_shadows.dart';
import '../../widgets/interactive_gooffgrid_logo.dart';
import '../../l10n/app_localizations.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<double> _scale;
  bool _acceptedTerms = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _scale = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return GoOffGridEyeTracker(
      child: Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Stack(
          children: [
            // Mesh glow background layer
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: AppGradients.meshGlow.withOpacity(0.4),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  const Spacer(flex: 3),
                  FadeTransition(
                    opacity: _opacity,
                    child: ScaleTransition(
                      scale: _scale,
                      child: Column(
                        children: [
                          const InteractiveGoOffGridLogo(
                            fontSize: 32,
                            letterSpacing: 3,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            l.welcomeSlogan,
                            style: AppType.body.copyWith(
                              color: AppColors.textSecondary,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(flex: 3),
                  // KVKK / Terms consent
                  GestureDetector(
                    onTap: () => setState(() => _acceptedTerms = !_acceptedTerms),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          margin: const EdgeInsets.only(top: 2),
                          decoration: BoxDecoration(
                            color: _acceptedTerms ? AppColors.neonGreen : Colors.transparent,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: _acceptedTerms ? AppColors.neonGreen : AppColors.cardBorder,
                              width: 1.5,
                            ),
                          ),
                          child: _acceptedTerms
                              ? const Icon(Icons.check_rounded, size: 14, color: Colors.black)
                              : null,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text.rich(
                            TextSpan(
                              style: TextStyle(fontSize: 12, color: AppColors.textTertiary, height: 1.4),
                              children: [
                                TextSpan(text: '${l.continueConsent} '),
                                WidgetSpan(
                                  child: GestureDetector(
                                    onTap: () => context.push('/profile/settings/terms'),
                                    child: Text(l.termsOfService, style: TextStyle(fontSize: 12, color: AppColors.neonGreen, decoration: TextDecoration.underline)),
                                  ),
                                ),
                                const TextSpan(text: ', '),
                                WidgetSpan(
                                  child: GestureDetector(
                                    onTap: () => context.push('/profile/settings/privacy'),
                                    child: Text(l.privacyPolicy, style: TextStyle(fontSize: 12, color: AppColors.neonGreen, decoration: TextDecoration.underline)),
                                  ),
                                ),
                                const TextSpan(text: ' ve '),
                                WidgetSpan(
                                  child: GestureDetector(
                                    onTap: () => context.push('/profile/settings/kvkk'),
                                    child: Text(l.kvkkText, style: TextStyle(fontSize: 12, color: AppColors.neonGreen, decoration: TextDecoration.underline)),
                                  ),
                                ),
                                TextSpan(text: l.acceptTermsSuffix),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: _acceptedTerms
                          ? AppShadow.glow(AppColors.neonGreen)
                          : AppShadow.none,
                    ),
                    child: ElevatedButton(
                      onPressed: _acceptedTerms ? () => context.go('/onboarding/shock') : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.neonGreen,
                        foregroundColor: Colors.black,
                        disabledBackgroundColor: AppColors.cardBorder,
                        disabledForegroundColor: AppColors.textTertiary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      child: Text(l.start),
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () => context.go('/'),
                    child: Text(
                      l.alreadyHaveAccount,
                      style: AppType.bodySmall.copyWith(color: AppColors.textTertiary),
                    ),
                  ),
                  const SizedBox(height: 48),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }
}

/// Extension to create an opacity-adjusted RadialGradient.
extension _RadialGradientOpacity on RadialGradient {
  RadialGradient withOpacity(double opacity) {
    return RadialGradient(
      center: center,
      radius: radius,
      colors: colors.map((c) => c.withValues(alpha: c.a * opacity)).toList(),
      stops: stops,
    );
  }
}
