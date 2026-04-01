import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme.dart';
import '../../services/haptic_service.dart';

class SubscriptionScreen extends ConsumerWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          // Animated glow mist background
          const _AnimatedMistBackground(),
          // Content
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
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Off-Grid Kulübü', style: AppTextStyles.h1),
                          Text('Ekranından kopmanın ödülünü al.', style: TextStyle(fontSize: 12, color: AppColors.textTertiary)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // ═══ FREE PLAN ═══
                  _FreePlanCard(),
                  const SizedBox(height: 20),

                  // ═══ PRO PLAN — Hero card ═══
                  const _ProPlanCard(),
                  const SizedBox(height: 20),

                  // ═══ PRO+ PLAN — Gold VIP ═══
                  const _ProPlusPlanCard(),
                  const SizedBox(height: 24),

                  // Restore purchases
                  Center(
                    child: GestureDetector(
                      onTap: () => HapticService.light(),
                      child: Text(
                        'Satın Alımları Geri Yükle',
                        style: TextStyle(fontSize: 13, color: AppColors.textTertiary, decoration: TextDecoration.underline),
                      ),
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
// ANIMATED MIST BACKGROUND — Yavaşça hareket eden neon sis
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
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat(reverse: true);
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
              center: Alignment(
                -0.3 + 0.6 * t,
                -0.5 + 0.3 * sin(t * pi * 2),
              ),
              radius: 1.5,
              colors: [
                AppColors.neonGreen.withOpacity(0.04 + 0.02 * t),
                const Color(0xFF1A0D3B).withOpacity(0.03),
                AppColors.bg,
              ],
              stops: const [0.0, 0.4, 1.0],
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(
                  0.4 - 0.5 * t,
                  0.3 + 0.2 * cos(t * pi * 2),
                ),
                radius: 1.2,
                colors: [
                  const Color(0xFF7B2FBE).withOpacity(0.03 + 0.015 * (1 - t)),
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
// FREE PLAN CARD
// ═══════════════════════════════════════════════════

class _FreePlanCard extends StatelessWidget {
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
              colors: [
                Colors.white.withOpacity(0.05),
                Colors.white.withOpacity(0.02),
              ],
            ),
            border: Border.all(color: Colors.white.withOpacity(0.08)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Ücretsiz', style: AppTextStyles.h2),
              const SizedBox(height: 12),
              _feature('Günlük ekran süresi takibi'),
              _feature('Arkadaş sıralamaları'),
              _feature('3 aktif düello'),
              _feature('Temel rozetler'),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text('Mevcut Plan', style: TextStyle(fontSize: 12, color: AppColors.textTertiary)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _feature(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      children: [
        const Icon(Icons.check_rounded, size: 15, color: AppColors.textTertiary),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════
// PRO PLAN — Glassmorphism + animated neon border
// ═══════════════════════════════════════════════════

class _ProPlanCard extends StatefulWidget {
  const _ProPlanCard();

  @override
  State<_ProPlanCard> createState() => _ProPlanCardState();
}

class _ProPlanCardState extends State<_ProPlanCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _borderCtrl;

  @override
  void initState() {
    super.initState();
    _borderCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _borderCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _borderCtrl,
      builder: (_, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.neonGreen.withOpacity(0.15 + 0.05 * sin(_borderCtrl.value * pi * 2)),
                blurRadius: 40,
                spreadRadius: -8,
              ),
              BoxShadow(
                color: AppColors.neonGreen.withOpacity(0.06),
                blurRadius: 80,
                spreadRadius: -16,
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
                colors: [
                  Color(0xFF0F2A12),
                  Color(0xFF0D1A2A),
                  Color(0xFF121218),
                ],
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
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: AppColors.neonGreen,
                        shadows: [Shadow(color: AppColors.neonGreen.withOpacity(0.5), blurRadius: 16)],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColors.neonGreen.withOpacity(0.2), AppColors.neonGreen.withOpacity(0.08)],
                        ),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.neonGreen.withOpacity(0.3)),
                      ),
                      child: const Text('Önerilen', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.neonGreen)),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '₺149/ay',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: AppColors.neonGreen,
                    letterSpacing: -1,
                    shadows: [Shadow(color: AppColors.neonGreen.withOpacity(0.4), blurRadius: 12)],
                  ),
                ),
                const SizedBox(height: 16),
                _proFeature('Tüm sıralamalar (şehir, ülke, global)'),
                _proFeature('Detaylı istatistikler & odak takvimi'),
                _proFeature('Sınırsız düello'),
                _proFeature('Off-Grid Biletleri dahil'),
                _proFeature('Reklamsız deneyim'),
                const SizedBox(height: 20),
                // Shimmer CTA button
                const _ShimmerButton(
                  text: "Pro'ya Yükselt",
                  color: AppColors.neonGreen,
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
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.neonGreen.withOpacity(0.15),
          ),
          child: const Icon(Icons.check_rounded, size: 12, color: AppColors.neonGreen),
        ),
        const SizedBox(width: 10),
        Text(text, style: const TextStyle(fontSize: 13, color: AppColors.textPrimary)),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════
// PRO+ PLAN — Gold VIP glassmorphism
// ═══════════════════════════════════════════════════

class _ProPlusPlanCard extends StatefulWidget {
  const _ProPlusPlanCard();

  @override
  State<_ProPlusPlanCard> createState() => _ProPlusPlanCardState();
}

class _ProPlusPlanCardState extends State<_ProPlusPlanCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _borderCtrl;

  @override
  void initState() {
    super.initState();
    _borderCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _borderCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _borderCtrl,
      builder: (_, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.gold.withOpacity(0.12 + 0.04 * sin(_borderCtrl.value * pi * 2)),
                blurRadius: 32,
                spreadRadius: -8,
              ),
            ],
          ),
          child: CustomPaint(
            painter: _AnimatedBorderPainter(
              progress: _borderCtrl.value,
              color: AppColors.gold,
              borderRadius: 20,
              strokeWidth: 1.5,
            ),
            child: child,
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF2A2210),
                  Color(0xFF1A180E),
                  Color(0xFF121210),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Pro+',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: AppColors.gold,
                        shadows: [Shadow(color: AppColors.gold.withOpacity(0.5), blurRadius: 16)],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColors.gold.withOpacity(0.2), AppColors.gold.withOpacity(0.08)],
                        ),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.gold.withOpacity(0.3)),
                      ),
                      child: const Text('VIP', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.gold, letterSpacing: 1)),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '₺299/ay',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: AppColors.gold,
                    letterSpacing: -1,
                    shadows: [Shadow(color: AppColors.gold.withOpacity(0.4), blurRadius: 12)],
                  ),
                ),
                const SizedBox(height: 16),
                _goldFeature('Pro içeriklerin tamamı'),
                _goldFeature('Aile planı (5 kişi)'),
                _goldFeature('Öncelikli destek'),
                _goldFeature('Özel rozetler & temalar'),
                _goldFeature('Beta özelliklere erken erişim'),
                const SizedBox(height: 20),
                const _ShimmerButton(
                  text: "Pro+'ya Yükselt",
                  color: AppColors.gold,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _goldFeature(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      children: [
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.gold.withOpacity(0.15),
          ),
          child: const Icon(Icons.check_rounded, size: 12, color: AppColors.gold),
        ),
        const SizedBox(width: 10),
        Text(text, style: const TextStyle(fontSize: 13, color: AppColors.textPrimary)),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════
// ANIMATED BORDER PAINTER — Dönen neon gradient çizgi
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

    // Sweep gradient — dönen parlama efekti
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..shader = SweepGradient(
        startAngle: 0,
        endAngle: pi * 2,
        transform: GradientRotation(progress * pi * 2),
        colors: [
          Colors.transparent,
          color.withOpacity(0.1),
          color.withOpacity(0.6),
          color,
          color.withOpacity(0.6),
          color.withOpacity(0.1),
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
// SHIMMER BUTTON — Üzerinden ışık geçen premium buton
// ═══════════════════════════════════════════════════

class _ShimmerButton extends StatefulWidget {
  const _ShimmerButton({
    required this.text,
    required this.color,
  });

  final String text;
  final Color color;

  @override
  State<_ShimmerButton> createState() => _ShimmerButtonState();
}

class _ShimmerButtonState extends State<_ShimmerButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _shimmerCtrl;

  @override
  void initState() {
    super.initState();
    _shimmerCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat();
  }

  @override
  void dispose() {
    _shimmerCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => HapticService.heavy(),
      child: AnimatedBuilder(
        animation: _shimmerCtrl,
        builder: (_, __) {
          final shimmerPos = -1.0 + 3.0 * _shimmerCtrl.value;
          return Container(
            width: double.infinity,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: widget.color,
              boxShadow: [
                BoxShadow(
                  color: widget.color.withOpacity(0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 6),
                ),
                BoxShadow(
                  color: widget.color.withOpacity(0.15),
                  blurRadius: 40,
                  spreadRadius: -8,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Shimmer light streak
                  Positioned.fill(
                    child: ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        begin: Alignment(shimmerPos, 0),
                        end: Alignment(shimmerPos + 0.5, 0),
                        colors: [
                          Colors.transparent,
                          Colors.white.withOpacity(0.25),
                          Colors.transparent,
                        ],
                      ).createShader(bounds),
                      blendMode: BlendMode.srcATop,
                      child: Container(color: widget.color),
                    ),
                  ),
                  // Text
                  Text(
                    widget.text,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
