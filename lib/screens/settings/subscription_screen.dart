import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme.dart';
import '../../services/haptic_service.dart';
import '../../services/revenue_cat_service.dart';
import '../../l10n/app_localizations.dart';

class SubscriptionScreen extends ConsumerStatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  ConsumerState<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends ConsumerState<SubscriptionScreen> {
  bool _yearly = true; // default yearly for better conversion

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          const _AnimatedMistBackground(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          HapticService.light();
                          context.pop();
                        },
                        child: const Icon(Icons.arrow_back_rounded, color: AppColors.textPrimary),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(l.offGridClub, style: AppTextStyles.h1),
                            Text(l.clubSubtitle, style: const TextStyle(fontSize: 12, color: AppColors.textTertiary)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Billing toggle
                  _BillingToggle(
                    yearly: _yearly,
                    onChanged: (v) {
                      HapticService.selection();
                      setState(() => _yearly = v);
                    },
                  ),
                  const SizedBox(height: 24),

                  // ═══ FREE PLAN ═══
                  _PlanCard(
                    name: l.planStarter,
                    nameColor: AppColors.textSecondary,
                    price: l.free,
                    priceColor: AppColors.textPrimary,
                    subtitle: l.planStarterSubtitle,
                    features: [
                      l.freeFeature1,
                      '2 ${l.breathTechniquesComp.toLowerCase()}',
                      l.freeFeature2,
                      l.freeFeature3,
                      l.storyPhoto,
                      l.weeklyReport,
                    ],
                    featureColor: AppColors.textTertiary,
                    borderColor: Colors.white.withValues(alpha: 0.08),
                    bgGradient: [
                      Colors.white.withValues(alpha: 0.04),
                      Colors.white.withValues(alpha: 0.02),
                    ],
                    buttonText: l.currentPlanBtn,
                    buttonEnabled: false,
                  ),
                  const SizedBox(height: 16),

                  // ═══ PRO PLAN ═══
                  _ProCard(yearly: _yearly),
                  const SizedBox(height: 24),

                  // Comparison table
                  const _ComparisonSection(),
                  const SizedBox(height: 24),

                  // Restore + legal
                  Center(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            HapticService.light();
                            final restored = await RevenueCatService.instance.restorePurchases();
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(restored ? l.restoreSuccess : l.restoreFailed)),
                              );
                            }
                          },
                          child: Text(
                            l.restorePurchases,
                            style: const TextStyle(fontSize: 13, color: AppColors.textTertiary, decoration: TextDecoration.underline),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () => context.push('/profile/settings/terms'),
                              child: Text(l.termsOfService, style: TextStyle(fontSize: 11, color: AppColors.textTertiary, decoration: TextDecoration.underline)),
                            ),
                            Text('  •  ', style: TextStyle(fontSize: 11, color: AppColors.textTertiary)),
                            GestureDetector(
                              onTap: () => context.push('/profile/settings/privacy'),
                              child: Text(l.privacyPolicy, style: TextStyle(fontSize: 11, color: AppColors.textTertiary, decoration: TextDecoration.underline)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          l.billingNote,
                          style: TextStyle(fontSize: 10, color: AppColors.textTertiary.withValues(alpha: 0.6)),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════
// BILLING TOGGLE — Aylık / Yıllık
// ═══════════════════════════════════════════════════

class _BillingToggle extends StatelessWidget {
  const _BillingToggle({required this.yearly, required this.onChanged});
  final bool yearly;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Row(
        children: [
          Expanded(child: _tab(l.billingMonthly, !yearly, () => onChanged(false))),
          Expanded(
            child: _tab(l.billingYearly, yearly, () => onChanged(true), badge: l.yearlySavings),
          ),
        ],
      ),
    );
  }

  Widget _tab(String label, bool active, VoidCallback onTap, {String? badge}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: active ? AppColors.neonGreen.withValues(alpha: 0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: active ? Border.all(color: AppColors.neonGreen.withValues(alpha: 0.3)) : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: active ? FontWeight.w700 : FontWeight.w400,
                color: active ? AppColors.neonGreen : AppColors.textSecondary,
              ),
            ),
            if (badge != null && active) ...[
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.neonGreen,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(badge, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: Colors.black)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════
// GENERIC PLAN CARD
// ═══════════════════════════════════════════════════

class _PlanCard extends StatelessWidget {
  const _PlanCard({
    required this.name,
    required this.nameColor,
    required this.price,
    required this.priceColor,
    required this.subtitle,
    required this.features,
    required this.featureColor,
    required this.borderColor,
    required this.bgGradient,
    required this.buttonText,
    this.buttonEnabled = true,
    this.buttonColor,
  });

  final String name;
  final Color nameColor;
  final String price;
  final Color priceColor;
  final String subtitle;
  final List<String> features;
  final Color featureColor;
  final Color borderColor;
  final List<Color> bgGradient;
  final String buttonText;
  final bool buttonEnabled;
  final Color? buttonColor;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: bgGradient,
            ),
            border: Border.all(color: borderColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: nameColor)),
              const SizedBox(height: 4),
              Text(price, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: priceColor, letterSpacing: -0.5)),
              const SizedBox(height: 2),
              Text(subtitle, style: TextStyle(fontSize: 11, color: AppColors.textTertiary)),
              const SizedBox(height: 14),
              ...features.map((f) => _featureRow(f, featureColor)),
              const SizedBox(height: 16),
              if (buttonEnabled)
                _ShimmerButton(text: buttonText, color: buttonColor ?? priceColor)
              else
                Container(
                  width: double.infinity,
                  height: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(buttonText, style: TextStyle(fontSize: 14, color: AppColors.textTertiary)),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _featureRow(String text, Color color) => Padding(
    padding: const EdgeInsets.only(bottom: 7),
    child: Row(
      children: [
        Container(
          width: 16, height: 16,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color.withValues(alpha: 0.15)),
          child: Icon(Icons.check_rounded, size: 10, color: color),
        ),
        const SizedBox(width: 10),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary))),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════
// PRO PLAN — Animated neon border
// ═══════════════════════════════════════════════════

class _ProCard extends StatefulWidget {
  const _ProCard({required this.yearly});
  final bool yearly;

  @override
  State<_ProCard> createState() => _ProCardState();
}

class _ProCardState extends State<_ProCard> with SingleTickerProviderStateMixin {
  late AnimationController _borderCtrl;

  @override
  void initState() {
    super.initState();
    _borderCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 3))..repeat();
  }

  @override
  void dispose() {
    _borderCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final monthlyPrice = widget.yearly ? '₺100' : '₺150';
    final billingNote = widget.yearly ? '₺1.200/yıl olarak faturalanır' : 'aylık faturalanır';

    return AnimatedBuilder(
      animation: _borderCtrl,
      builder: (_, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.neonGreen.withValues(alpha: 0.12 + 0.04 * sin(_borderCtrl.value * pi * 2)),
                blurRadius: 40,
                spreadRadius: -8,
              ),
            ],
          ),
          child: CustomPaint(
            painter: _AnimatedBorderPainter(
              progress: _borderCtrl.value,
              color: AppColors.neonGreen,
              borderRadius: 20,
              strokeWidth: 1.8,
            ),
            child: child,
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF0F2A12), Color(0xFF0D1A2A), Color(0xFF121218)],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Pro',
                      style: TextStyle(
                        fontSize: 24, fontWeight: FontWeight.w800, color: AppColors.neonGreen,
                        shadows: [Shadow(color: AppColors.neonGreen.withValues(alpha: 0.5), blurRadius: 16)],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [AppColors.neonGreen.withValues(alpha: 0.2), AppColors.neonGreen.withValues(alpha: 0.08)]),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.neonGreen.withValues(alpha: 0.3)),
                      ),
                      child: Text(AppLocalizations.of(context)!.proMostPopular, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.neonGreen)),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '$monthlyPrice/ay',
                      style: TextStyle(
                        fontSize: 28, fontWeight: FontWeight.w800, color: AppColors.neonGreen,
                        letterSpacing: -1,
                        shadows: [Shadow(color: AppColors.neonGreen.withValues(alpha: 0.4), blurRadius: 12)],
                      ),
                    ),
                  ],
                ),
                Text(billingNote, style: TextStyle(fontSize: 11, color: Colors.white.withValues(alpha: 0.35))),
                const SizedBox(height: 18),
                _proFeature(l.proFeature1),
                _proFeature(l.proFeature2),
                _proFeature(l.proFeature3),
                _proFeature(l.proFeature4),
                _proFeature(l.proFeature5),
                _proFeature(l.heatMap),
                _proFeature(l.top10Report),
                _proFeature(l.exclusiveBadges),
                const SizedBox(height: 20),
                _ShimmerButton(
                  text: l.upgradeToPro,
                  color: AppColors.neonGreen,
                  onTap: () async {
                    final packages = await RevenueCatService.instance.getPackages();
                    if (packages.isEmpty) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(l.packagesLoadFailed)),
                        );
                      }
                      return;
                    }
                    final pkg = packages.firstWhere(
                      (p) => p.identifier.contains('pro') && !p.identifier.contains('plus'),
                      orElse: () => packages.first,
                    );
                    await RevenueCatService.instance.purchase(pkg);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _proFeature(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      children: [
        Container(
          width: 18, height: 18,
          decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.neonGreen.withValues(alpha: 0.15)),
          child: const Icon(Icons.check_rounded, size: 12, color: AppColors.neonGreen),
        ),
        const SizedBox(width: 10),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 13, color: AppColors.textPrimary))),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════
// COMPARISON TABLE
// ═══════════════════════════════════════════════════

class _ComparisonSection extends StatelessWidget {
  const _ComparisonSection();

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white.withValues(alpha: 0.03),
            border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l.planComparison, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
              const SizedBox(height: 14),
              // Header
              _compRow('', l.free, l.pro, isHeader: true),
              const Divider(color: Colors.white10, height: 1),
              _compRow(l.breathTechniquesComp, '2', '6'),
              _compRow(l.activeDuelsComp, '3', '∞'),
              _compRow(l.storyPhoto, '—', '✓'),
              _compRow(l.detailedAnalytics, '—', '✓'),
              _compRow(l.heatMap, '—', '✓'),
              _compRow(l.top10Report, '—', '✓'),
              _compRow(l.exclusiveBadges, '—', '✓'),
              _compRow(l.familyPlanComp, '—', '✓'),
              _compRow(l.familyReport, '—', '✓'),
              _compRow(l.exclusiveThemes, '—', '✓'),
              _compRow(l.prioritySupport, '—', '✓'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _compRow(String feature, String free, String pro, {bool isHeader = false}) {
    final style = TextStyle(
      fontSize: isHeader ? 11 : 12,
      fontWeight: isHeader ? FontWeight.w700 : FontWeight.w400,
      color: isHeader ? AppColors.textSecondary : AppColors.textTertiary,
    );
    final proStyle = style.copyWith(color: isHeader ? AppColors.neonGreen : AppColors.textPrimary);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(flex: 3, child: Text(feature, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary))),
          Expanded(flex: 2, child: Text(free, style: style, textAlign: TextAlign.center)),
          Expanded(flex: 2, child: Text(pro, style: proStyle, textAlign: TextAlign.center)),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════
// ANIMATED MIST BACKGROUND
// ═══════════════════════════════════════════════════

class _AnimatedMistBackground extends StatefulWidget {
  const _AnimatedMistBackground();

  @override
  State<_AnimatedMistBackground> createState() => _AnimatedMistBackgroundState();
}

class _AnimatedMistBackgroundState extends State<_AnimatedMistBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(seconds: 8))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) {
        final t = _ctrl.value;
        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment(-0.3 + 0.6 * t, -0.5 + 0.3 * sin(t * pi * 2)),
              radius: 1.5,
              colors: [
                AppColors.neonGreen.withValues(alpha: 0.04 + 0.02 * t),
                const Color(0xFF1A0D3B).withValues(alpha: 0.03),
                AppColors.bg,
              ],
              stops: const [0.0, 0.4, 1.0],
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(0.4 - 0.5 * t, 0.3 + 0.2 * cos(t * pi * 2)),
                radius: 1.2,
                colors: [
                  const Color(0xFF7B2FBE).withValues(alpha: 0.03 + 0.015 * (1 - t)),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// ═══════════════════════════════════════════════════
// ANIMATED BORDER PAINTER
// ═══════════════════════════════════════════════════

class _AnimatedBorderPainter extends CustomPainter {
  _AnimatedBorderPainter({
    required this.progress,
    required this.color,
    required this.borderRadius,
    required this.strokeWidth,
  });

  final double progress;
  final Color color;
  final double borderRadius;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..shader = SweepGradient(
        transform: GradientRotation(progress * pi * 2),
        colors: [
          Colors.transparent,
          color.withValues(alpha: 0.1),
          color.withValues(alpha: 0.6),
          color,
          color.withValues(alpha: 0.6),
          color.withValues(alpha: 0.1),
          Colors.transparent,
        ],
        stops: const [0.0, 0.15, 0.35, 0.5, 0.65, 0.85, 1.0],
      ).createShader(rect);

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(_AnimatedBorderPainter old) => progress != old.progress;
}

// ═══════════════════════════════════════════════════
// SHIMMER BUTTON
// ═══════════════════════════════════════════════════

class _ShimmerButton extends StatefulWidget {
  const _ShimmerButton({required this.text, required this.color, this.onTap});

  final String text;
  final Color color;
  final VoidCallback? onTap;

  @override
  State<_ShimmerButton> createState() => _ShimmerButtonState();
}

class _ShimmerButtonState extends State<_ShimmerButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _shimmerCtrl;

  @override
  void initState() {
    super.initState();
    _shimmerCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 2500))..repeat();
  }

  @override
  void dispose() {
    _shimmerCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticService.heavy();
        widget.onTap?.call();
      },
      child: AnimatedBuilder(
        animation: _shimmerCtrl,
        builder: (_, __) {
          final shimmerPos = -1.0 + 3.0 * _shimmerCtrl.value;
          return Container(
            width: double.infinity,
            height: 52,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: widget.color,
              boxShadow: [
                BoxShadow(color: widget.color.withValues(alpha: 0.35), blurRadius: 20, offset: const Offset(0, 6)),
                BoxShadow(color: widget.color.withValues(alpha: 0.12), blurRadius: 40, spreadRadius: -8, offset: const Offset(0, 12)),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned.fill(
                    child: ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        begin: Alignment(shimmerPos, 0),
                        end: Alignment(shimmerPos + 0.5, 0),
                        colors: [Colors.transparent, Colors.white.withValues(alpha: 0.25), Colors.transparent],
                      ).createShader(bounds),
                      blendMode: BlendMode.srcATop,
                      child: Container(color: widget.color),
                    ),
                  ),
                  Text(widget.text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black, letterSpacing: 0.5)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
