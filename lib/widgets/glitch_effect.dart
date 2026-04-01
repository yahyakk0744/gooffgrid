import 'dart:math';
import 'package:flutter/material.dart';
import '../config/theme.dart';

/// Cyberpunk / VHS glitch efekti.
/// Kullanıcı ekran hedefini aştığında tetiklenir.
/// CustomPainter + ShaderMask ile UI'ın kırmızı renkte
/// anlık olarak kayması (distortion) animasyonu.
class GlitchEffect extends StatefulWidget {
  const GlitchEffect({
    super.key,
    required this.child,
    this.isActive = false,
    this.intensity = 1.0,
    this.color,
  });

  final Widget child;

  /// Efekt aktif mi?
  final bool isActive;

  /// Efekt şiddeti (0.0 - 2.0).
  final double intensity;

  /// Glitch rengi. Null ise ringDanger.
  final Color? color;

  @override
  State<GlitchEffect> createState() => _GlitchEffectState();
}

class _GlitchEffectState extends State<GlitchEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    if (widget.isActive) _controller.repeat();
  }

  @override
  void didUpdateWidget(GlitchEffect oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && !_controller.isAnimating) {
      _controller.repeat();
    } else if (!widget.isActive && _controller.isAnimating) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isActive) return widget.child;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final glitchColor = widget.color ?? AppColors.ringDanger;
        final progress = _controller.value;

        // Glitch bursts: her 0.3-0.5 saniyede bir
        final isGlitching = (progress * 7).floor() % 3 == 0;

        if (!isGlitching) return child!;

        final offsetX = (_random.nextDouble() - 0.5) * 8 * widget.intensity;
        final sliceY = _random.nextDouble();
        final sliceHeight = 0.02 + _random.nextDouble() * 0.08;

        return Stack(
          children: [
            // Normal child
            child!,

            // Red channel shift — sola kayma
            Positioned.fill(
              child: ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                    glitchColor.withOpacity(0.6),
                    glitchColor.withOpacity(0.6),
                    Colors.transparent,
                    Colors.transparent,
                  ],
                  stops: [
                    0,
                    sliceY,
                    sliceY,
                    (sliceY + sliceHeight).clamp(0.0, 1.0),
                    (sliceY + sliceHeight).clamp(0.0, 1.0),
                    1.0,
                  ],
                ).createShader(bounds),
                blendMode: BlendMode.srcATop,
                child: Transform.translate(
                  offset: Offset(offsetX, 0),
                  child: Opacity(
                    opacity: 0.7,
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        glitchColor.withOpacity(0.3),
                        BlendMode.srcATop,
                      ),
                      child: child,
                    ),
                  ),
                ),
              ),
            ),

            // Scan line overlay
            Positioned.fill(
              child: CustomPaint(
                painter: _ScanLinePainter(
                  progress: progress,
                  color: glitchColor,
                  intensity: widget.intensity,
                ),
              ),
            ),
          ],
        );
      },
      child: widget.child,
    );
  }
}

class _ScanLinePainter extends CustomPainter {
  _ScanLinePainter({
    required this.progress,
    required this.color,
    required this.intensity,
  });

  final double progress;
  final Color color;
  final double intensity;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.04 * intensity)
      ..strokeWidth = 1;

    // Horizontal scan lines (VHS effect)
    for (double y = 0; y < size.height; y += 3) {
      if (y.toInt() % 2 == 0) {
        canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
      }
    }

    // Moving thick glitch bar
    final barY = (progress * size.height * 1.5) % size.height;
    final barPaint = Paint()
      ..color = color.withOpacity(0.08 * intensity)
      ..style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromLTWH(0, barY, size.width, 4 * intensity),
      barPaint,
    );
  }

  @override
  bool shouldRepaint(_ScanLinePainter oldDelegate) =>
      progress != oldDelegate.progress;
}

/// Convenience: Tek seferlik glitch burst animasyonu.
/// Hedef aşıldığında bir kez tetikle.
class GlitchBurst extends StatefulWidget {
  const GlitchBurst({
    super.key,
    required this.child,
    this.trigger = false,
    this.duration = const Duration(milliseconds: 800),
  });

  final Widget child;
  final bool trigger;
  final Duration duration;

  @override
  State<GlitchBurst> createState() => _GlitchBurstState();
}

class _GlitchBurstState extends State<GlitchBurst> {
  bool _active = false;

  @override
  void didUpdateWidget(GlitchBurst old) {
    super.didUpdateWidget(old);
    if (widget.trigger && !old.trigger) {
      _fire();
    }
  }

  Future<void> _fire() async {
    setState(() => _active = true);
    await Future.delayed(widget.duration);
    if (mounted) setState(() => _active = false);
  }

  @override
  Widget build(BuildContext context) {
    return GlitchEffect(
      isActive: _active,
      intensity: 1.5,
      child: widget.child,
    );
  }
}
