import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import '../config/theme.dart';

/// Gyroscope Parallax kartı.
/// Cihazın ivmeölçer verisini alıp, çocuk widget'ı ve neon shadow'ları
/// telefonun eğimine göre X/Y ekseninde hareket ettirir.
class ParallaxGlassCard extends StatefulWidget {
  const ParallaxGlassCard({
    super.key,
    required this.child,
    this.intensity = 12.0,
    this.glowColor,
    this.borderRadius = 20,
    this.blurAmount = 16,
    this.enableGlow = true,
  });

  final Widget child;

  /// Parallax hareket miktarı (piksel).
  final double intensity;

  /// Glow rengi. Null ise neonGreen kullanılır.
  final Color? glowColor;

  final double borderRadius;
  final double blurAmount;
  final bool enableGlow;

  @override
  State<ParallaxGlassCard> createState() => _ParallaxGlassCardState();
}

class _ParallaxGlassCardState extends State<ParallaxGlassCard> {
  double _offsetX = 0;
  double _offsetY = 0;
  StreamSubscription? _sub;

  @override
  void initState() {
    super.initState();
    _sub = accelerometerEventStream(
      samplingPeriod: const Duration(milliseconds: 50),
    ).listen((event) {
      if (!mounted) return;
      setState(() {
        // x: sola/sağa eğim, y: ileri/geri eğim
        // Clamp ile aşırı değerleri sınırla
        _offsetX = (event.x / 10 * widget.intensity).clamp(-widget.intensity, widget.intensity);
        _offsetY = ((event.y - 9.8) / 10 * widget.intensity).clamp(-widget.intensity, widget.intensity);
      });
    });
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final glow = widget.glowColor ?? AppColors.neonGreen;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 120),
      curve: Curves.easeOut,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001) // perspective
        ..rotateX(_offsetY * 0.003)
        ..rotateY(-_offsetX * 0.003),
      transformAlignment: Alignment.center,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: widget.blurAmount,
            sigmaY: widget.blurAmount,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withValues(alpha: 0.09),
                  Colors.white.withValues(alpha: 0.03),
                ],
              ),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.12),
                width: 1,
              ),
              boxShadow: widget.enableGlow
                  ? [
                      // Dynamik neon glow — açısı cihaz eğimine göre değişir
                      BoxShadow(
                        color: glow.withValues(alpha: 0.2),
                        blurRadius: 28,
                        spreadRadius: -6,
                        offset: Offset(_offsetX * 0.6, _offsetY * 0.6),
                      ),
                      BoxShadow(
                        color: glow.withValues(alpha: 0.08),
                        blurRadius: 50,
                        spreadRadius: -10,
                        offset: Offset(_offsetX * 0.3, _offsetY * 0.3),
                      ),
                      // Derinlik gölgesi
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.4),
                        blurRadius: 20,
                        offset: Offset(-_offsetX * 0.2, -_offsetY * 0.2 + 6),
                      ),
                    ]
                  : null,
            ),
            child: Transform.translate(
              offset: Offset(_offsetX * 0.3, _offsetY * 0.3),
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
