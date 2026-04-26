import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme.dart';
import '../../config/design_tokens.dart';
import '../../config/app_shadows.dart';
import '../../l10n/app_localizations.dart';

class ShockScreen extends ConsumerStatefulWidget {
  const ShockScreen({super.key});

  @override
  ConsumerState<ShockScreen> createState() => _ShockScreenState();
}

class _ShockScreenState extends ConsumerState<ShockScreen>
    with TickerProviderStateMixin {
  // Sliders
  double _age = 25;
  double _dailyHours = 5;

  // State
  bool _showResults = false;
  int _revealedStats = 0;
  bool _showHope = false;

  // Count-up animation
  late AnimationController _countController;
  late Animation<double> _countAnimation;

  // Fade controllers for each stat
  late List<AnimationController> _fadeControllers;
  late List<Animation<double>> _fadeAnimations;

  // Hope message
  late AnimationController _hopeController;
  late Animation<double> _hopeAnimation;

  int get _lifetimeHours =>
      ((_age - 10).clamp(0, 70) * 365 * _dailyHours).round();
  int get _lifetimeDays => (_lifetimeHours / 24).round();
  int get _movies => (_lifetimeHours / 2).round(); // ~2h per movie
  int get _books => (_lifetimeHours / 6).round(); // ~6h per book

  @override
  void initState() {
    super.initState();

    _countController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );
    _countAnimation = CurvedAnimation(
      parent: _countController,
      curve: Curves.easeOut,
    );

    _fadeControllers = List.generate(4, (i) {
      return AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 600),
      );
    });
    _fadeAnimations = _fadeControllers
        .map((c) => CurvedAnimation(parent: c, curve: Curves.easeIn))
        .toList();

    _hopeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _hopeAnimation = CurvedAnimation(
      parent: _hopeController,
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _countController.dispose();
    for (final c in _fadeControllers) {
      c.dispose();
    }
    _hopeController.dispose();
    super.dispose();
  }

  Future<void> _revealResults() async {
    setState(() => _showResults = true);

    // Start count-up
    _countController.forward();

    // Reveal stats one by one
    for (int i = 0; i < 4; i++) {
      await Future.delayed(const Duration(milliseconds: 700));
      if (!mounted) return;
      setState(() => _revealedStats = i + 1);
      _fadeControllers[i].forward();
    }

    // Show hope message
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    setState(() => _showHope = true);
    _hopeController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: _showResults ? _buildResults(l) : _buildSliders(l),
      ),
    );
  }

  Widget _buildSliders(AppLocalizations l) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(flex: 2),
          Text(
            l.localeName == 'tr'
                ? 'Bir ger\u00e7ekle y\u00fczle\u015felim.'
                : "Let's face a reality.",
            style: AppType.h1.copyWith(fontSize: 26),
          ),
          const SizedBox(height: 8),
          Text(
            l.localeName == 'tr'
                ? 'Telefonuna ne kadar \u00f6mr\u00fcn\u00fc harcad\u0131\u011f\u0131n\u0131 hesaplayal\u0131m.'
                : "Let's calculate how much of your life you've spent on your phone.",
            style: AppType.body.copyWith(color: AppColors.textSecondary),
          ),
          const Spacer(),

          // Age slider
          Text(
            l.localeName == 'tr' ? 'Ya\u015f\u0131n' : 'Your Age',
            style: AppType.label.copyWith(
              letterSpacing: 1.5,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                '${_age.round()}',
                style: AppType.monoDisplay.copyWith(
                  color: AppColors.neonGreen,
                  fontSize: 32,
                ),
              ),
              Expanded(
                child: SliderTheme(
                  data: SliderThemeData(
                    activeTrackColor: AppColors.neonGreen,
                    inactiveTrackColor:
                        AppColors.cardBorder.withValues(alpha: 0.5),
                    thumbColor: AppColors.neonGreen,
                    overlayColor: AppColors.neonGreen.withValues(alpha: 0.15),
                    trackHeight: 3,
                    thumbShape:
                        const RoundSliderThumbShape(enabledThumbRadius: 8),
                  ),
                  child: Slider(
                    value: _age,
                    min: 13,
                    max: 80,
                    onChanged: (v) => setState(() => _age = v),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Daily screen time slider
          Text(
            l.localeName == 'tr'
                ? 'G\u00fcnl\u00fck Ekran S\u00fcresi'
                : 'Daily Screen Time',
            style: AppType.label.copyWith(
              letterSpacing: 1.5,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                '${_dailyHours.round()}h',
                style: AppType.monoDisplay.copyWith(
                  color: AppColors.neonGreen,
                  fontSize: 32,
                ),
              ),
              Expanded(
                child: SliderTheme(
                  data: SliderThemeData(
                    activeTrackColor: AppColors.neonGreen,
                    inactiveTrackColor:
                        AppColors.cardBorder.withValues(alpha: 0.5),
                    thumbColor: AppColors.neonGreen,
                    overlayColor: AppColors.neonGreen.withValues(alpha: 0.15),
                    trackHeight: 3,
                    thumbShape:
                        const RoundSliderThumbShape(enabledThumbRadius: 8),
                  ),
                  child: Slider(
                    value: _dailyHours,
                    min: 1,
                    max: 16,
                    onChanged: (v) => setState(() => _dailyHours = v),
                  ),
                ),
              ),
            ],
          ),

          const Spacer(flex: 2),

          // Calculate button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: _revealResults,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.ringDanger,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                textStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              child: Text(
                l.localeName == 'tr'
                    ? 'Ger\u00e7e\u011fi G\u00f6ster'
                    : 'Show Me The Truth',
              ),
            ),
          ),
          const SizedBox(height: 48),
        ],
      ),
    );
  }

  Widget _buildResults(AppLocalizations l) {
    final isTr = l.localeName == 'tr';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          const Spacer(flex: 2),

          // Big number with count-up
          AnimatedBuilder(
            animation: _countAnimation,
            builder: (context, child) {
              final current =
                  (_lifetimeHours * _countAnimation.value).round();
              return Column(
                children: [
                  Text(
                    _formatNumber(current),
                    style: AppType.monoDisplay.copyWith(
                      fontSize: 56,
                      color: _showHope ? AppColors.neonGreen : AppColors.ringDanger,
                      shadows: [
                        Shadow(
                          color: (_showHope ? AppColors.neonGreen : AppColors.ringDanger)
                              .withValues(alpha: 0.5),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isTr
                        ? 'saat telefonunda harcad\u0131n'
                        : 'hours spent on your phone',
                    style: AppType.body.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 40),

          // Stats revealed one by one
          _buildStatRow(
            0,
            isTr ? 'G\u00fcn\u00fcn\u00fcn' : "That's",
            '$_lifetimeDays',
            isTr ? 'g\u00fcn\u00fc' : 'days of your life',
            Icons.calendar_today_rounded,
          ),
          const SizedBox(height: 16),
          _buildStatRow(
            1,
            isTr ? 'Yani' : 'Or',
            '$_movies',
            isTr ? 'film izleyebilirdin' : 'movies you could\'ve watched',
            Icons.movie_rounded,
          ),
          const SizedBox(height: 16),
          _buildStatRow(
            2,
            isTr ? 'Ya da' : 'Or',
            '$_books',
            isTr ? 'kitap okuyabilirdin' : 'books you could\'ve read',
            Icons.menu_book_rounded,
          ),
          const SizedBox(height: 16),
          _buildStatRow(
            3,
            '',
            (_lifetimeDays / 365).toStringAsFixed(1),
            isTr ? 'y\u0131l sadece ekrana bakarak' : 'years just staring at a screen',
            Icons.hourglass_bottom_rounded,
          ),

          const Spacer(),

          // Hope message
          if (_showHope)
            FadeTransition(
              opacity: _hopeAnimation,
              child: Column(
                children: [
                  Text(
                    isTr
                        ? 'Ama hen\u00fcz ge\u00e7 de\u011fil.'
                        : "But it's not too late.",
                    style: AppType.h1.copyWith(
                      color: AppColors.neonGreen,
                      fontSize: 22,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isTr
                        ? 'Bunu birlikte de\u011fi\u015ftirelim.'
                        : "Let's change that together.",
                    style: AppType.body.copyWith(color: AppColors.textSecondary),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: AppShadow.glow(AppColors.neonGreen),
                    ),
                    child: ElevatedButton(
                      onPressed: () => context.go('/onboarding/permissions'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.neonGreen,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                        textStyle: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      child: Text(
                        isTr ? 'Haydi Ba\u015flayal\u0131m' : "Let's Go",
                      ),
                    ),
                  ),
                ],
              ),
            ),

          if (!_showHope) const Spacer(),

          const SizedBox(height: 48),
        ],
      ),
    );
  }

  Widget _buildStatRow(
    int index,
    String prefix,
    String value,
    String suffix,
    IconData icon,
  ) {
    if (_revealedStats <= index) return const SizedBox(height: 24);

    return FadeTransition(
      opacity: _fadeAnimations[index],
      child: Row(
        children: [
          Icon(icon, color: AppColors.textTertiary, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: AppType.body.copyWith(fontSize: 15),
                children: [
                  if (prefix.isNotEmpty)
                    TextSpan(
                      text: '$prefix ',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  TextSpan(
                    text: value,
                    style: AppType.monoDisplay.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: _showHope ? AppColors.neonGreen : AppColors.ringDanger,
                    ),
                  ),
                  TextSpan(
                    text: ' $suffix',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatNumber(int n) {
    if (n >= 1000) {
      final s = n.toString();
      final result = StringBuffer();
      int count = 0;
      for (int i = s.length - 1; i >= 0; i--) {
        result.write(s[i]);
        count++;
        if (count % 3 == 0 && i > 0) result.write(',');
      }
      return result.toString().split('').reversed.join();
    }
    return n.toString();
  }
}
