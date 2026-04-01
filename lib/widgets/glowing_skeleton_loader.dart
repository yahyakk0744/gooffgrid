import 'package:flutter/material.dart';
import '../config/theme.dart';

/// Neon ışık dalgası geçen skeleton loader.
/// Veri yüklenirken uygulamanın şeklini alan placeholder widget'ları.
class GlowingSkeletonLoader extends StatefulWidget {
  const GlowingSkeletonLoader({
    super.key,
    this.width,
    this.height = 16,
    this.borderRadius = 8,
    this.glowColor,
  });

  final double? width;
  final double height;
  final double borderRadius;
  final Color? glowColor;

  @override
  State<GlowingSkeletonLoader> createState() => _GlowingSkeletonLoaderState();
}

class _GlowingSkeletonLoaderState extends State<GlowingSkeletonLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final glow = widget.glowColor ?? AppColors.neonGreen;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            gradient: LinearGradient(
              begin: Alignment(-1.0 + 2.0 * _controller.value, 0),
              end: Alignment(-0.5 + 2.0 * _controller.value, 0),
              colors: [
                AppColors.cardBorder.withOpacity(0.3),
                glow.withOpacity(0.15),
                glow.withOpacity(0.25),
                glow.withOpacity(0.15),
                AppColors.cardBorder.withOpacity(0.3),
              ],
              stops: const [0.0, 0.35, 0.5, 0.65, 1.0],
            ),
            boxShadow: [
              BoxShadow(
                color: glow.withOpacity(0.06 + 0.04 * _controller.value),
                blurRadius: 12,
                spreadRadius: -4,
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Bir uygulama kullanım satırı şeklinde skeleton.
class SkeletonAppUsageRow extends StatelessWidget {
  const SkeletonAppUsageRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          GlowingSkeletonLoader(width: 36, height: 36, borderRadius: 10),
          const SizedBox(width: 10),
          GlowingSkeletonLoader(width: 80, height: 14),
          const SizedBox(width: 8),
          Expanded(child: GlowingSkeletonLoader(height: 6, borderRadius: 3)),
          const SizedBox(width: 10),
          GlowingSkeletonLoader(width: 36, height: 12),
        ],
      ),
    );
  }
}

/// Kart şeklinde skeleton (stat tile, friend tile vb.)
class SkeletonCard extends StatelessWidget {
  const SkeletonCard({
    super.key,
    this.height = 80,
    this.width,
  });

  final double height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.cardGradientEnd,
        border: Border.all(color: AppColors.cardBorder.withOpacity(0.3)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GlowingSkeletonLoader(width: 60, height: 20),
            const SizedBox(height: 8),
            GlowingSkeletonLoader(width: 100, height: 12),
          ],
        ),
      ),
    );
  }
}

/// Arkadaş listesi skeleton
class SkeletonFriendRow extends StatelessWidget {
  const SkeletonFriendRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          GlowingSkeletonLoader(width: 44, height: 44, borderRadius: 22),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GlowingSkeletonLoader(width: 100, height: 14),
              const SizedBox(height: 6),
              GlowingSkeletonLoader(width: 60, height: 10),
            ],
          ),
          const Spacer(),
          GlowingSkeletonLoader(width: 48, height: 14),
        ],
      ),
    );
  }
}

/// Tam sayfa skeleton — home screen şekli
class SkeletonHomePage extends StatelessWidget {
  const SkeletonHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          // Top bar
          Row(
            children: [
              GlowingSkeletonLoader(width: 80, height: 16),
              const Spacer(),
              GlowingSkeletonLoader(width: 60, height: 24, borderRadius: 12),
              const SizedBox(width: 12),
              GlowingSkeletonLoader(width: 32, height: 32, borderRadius: 16),
            ],
          ),
          const SizedBox(height: 32),
          // Activity ring
          Center(child: GlowingSkeletonLoader(width: 180, height: 180, borderRadius: 90)),
          const SizedBox(height: 24),
          // Goal bar
          GlowingSkeletonLoader(height: 48, borderRadius: 16),
          const SizedBox(height: 16),
          // Stats row
          Row(
            children: [
              Expanded(child: SkeletonCard(height: 72)),
              const SizedBox(width: 8),
              Expanded(child: SkeletonCard(height: 72)),
              const SizedBox(width: 8),
              Expanded(child: SkeletonCard(height: 72)),
            ],
          ),
          const SizedBox(height: 24),
          // App usage
          GlowingSkeletonLoader(width: 140, height: 16),
          const SizedBox(height: 16),
          ...List.generate(4, (_) => const SkeletonAppUsageRow()),
        ],
      ),
    );
  }
}
