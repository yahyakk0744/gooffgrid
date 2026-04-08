import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme.dart';
import '../../config/design_tokens.dart';
import '../../config/app_shadows.dart';
import '../../widgets/premium_background.dart';
import '../../l10n/app_localizations.dart';

class GoalSetupScreen extends StatefulWidget {
  const GoalSetupScreen({super.key});

  @override
  State<GoalSetupScreen> createState() => _GoalSetupScreenState();
}

class _GoalSetupScreenState extends State<GoalSetupScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 2; // default 3sa

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  static const _hours = [1, 2, 3, 4, 5, 6];

  String _motivationalText(AppLocalizations l) {
    final hour = _hours[_selectedIndex];
    if (hour <= 2) return l.goalMotivational1;
    if (hour == 3) return l.goalMotivational2;
    if (hour <= 5) return l.goalMotivational3;
    return l.goalMotivational4;
  }

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: PremiumBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(flex: 2),

                  // Title
                  Text(
                    l.dailyGoalTitle,
                    style: AppType.h1,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),

                  // Subtitle
                  Text(
                    l.goalQuestion,
                    style: AppType.body.copyWith(color: AppColors.textSecondary),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),

                  // Large hour display
                  Text(
                    l.hourShort(_hours[_selectedIndex]),
                    style: AppType.monoDisplay.copyWith(
                      fontSize: 48,
                      color: AppColors.neonGreen,
                      shadows: [
                        Shadow(
                          color: AppColors.neonGreen.withValues(alpha: 0.4),
                          blurRadius: 24,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // CupertinoPicker
                  SizedBox(
                    height: 160,
                    child: CupertinoPicker(
                      scrollController: FixedExtentScrollController(
                        initialItem: _selectedIndex,
                      ),
                      itemExtent: 48,
                      diameterRatio: 1.2,
                      selectionOverlay: Container(
                        decoration: BoxDecoration(
                          border: Border.symmetric(
                            horizontal: BorderSide(
                              color: AppColors.neonGreen.withValues(alpha: 0.3),
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                      onSelectedItemChanged: (index) {
                        setState(() => _selectedIndex = index);
                      },
                      children: _hours.map((h) {
                        return Center(
                          child: Text(
                            l.hourShort(h),
                            style: AppType.h2.copyWith(
                              fontSize: 22,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Motivational text
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Container(
                      key: ValueKey(_motivationalText(l)),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.cardBg,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: AppColors.neonGreen.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Text(
                        _motivationalText(l),
                        style: AppType.body.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),

                  const Spacer(flex: 3),

                  // Ileri button
                  Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: AppShadow.glow(AppColors.neonGreen),
                    ),
                    child: ElevatedButton(
                      onPressed: () => context.go('/onboarding/profile'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.neonGreen,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      child: Text(l.next),
                    ),
                  ),
                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
