import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../config/theme.dart';

class ActivityRing extends StatefulWidget {
  const ActivityRing({
    super.key,
    required this.value,
    this.size = 180,
    this.centerText,
    this.subtitle,
    this.color,
    this.strokeWidth = 14,
    this.animated = true,
  });

  final double value;
  final double size;
  final String? centerText;
  final String? subtitle;
  final Color? color;
  final double strokeWidth;
  final bool animated;

  @override
  State<ActivityRing> createState() => _ActivityRingState();
}

class _ActivityRingState extends State<ActivityRing> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _animation = Tween<double>(begin: 0, end: widget.value.clamp(0.0, 1.0)).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    // Pulse animation for neon glow
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.3, end: 0.7).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    if (widget.animated) {
      _controller.forward();
    } else {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(ActivityRing oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _animation = Tween<double>(begin: _animation.value, end: widget.value.clamp(0.0, 1.0)).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
      );
      _controller
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  Color get _ringColor {
    if (widget.color != null) return widget.color!;
    if (widget.value <= 0.5) return AppColors.ringGood;
    if (widget.value <= 0.8) return AppColors.ringWarning;
    return AppColors.ringDanger;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: Listenable.merge([_controller, _pulseController]),
        builder: (context, child) {
          return CustomPaint(
            painter: _RingTrackPainter(
              strokeWidth: widget.strokeWidth,
            ),
            foregroundPainter: _RingArcPainter(
              value: _animation.value,
              color: _ringColor,
              strokeWidth: widget.strokeWidth,
              glowIntensity: _pulseAnimation.value,
            ),
            child: child,
          );
        },
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.centerText != null)
                Text(
                  widget.centerText!,
                  style: AppTextStyles.heroNumber.copyWith(
                    shadows: [
                      Shadow(
                        color: _ringColor.withValues(alpha: 0.3),
                        blurRadius: 20,
                      ),
                    ],
                  ),
                ),
              if (widget.subtitle != null)
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(widget.subtitle!, style: AppTextStyles.labelSmall),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RingTrackPainter extends CustomPainter {
  _RingTrackPainter({required this.strokeWidth});
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    final paint = Paint()
      ..color = AppColors.ringTrack
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant _RingTrackPainter oldDelegate) => false;
}

class _RingArcPainter extends CustomPainter {
  _RingArcPainter({
    required this.value,
    required this.color,
    required this.strokeWidth,
    required this.glowIntensity,
  });

  final double value;
  final Color color;
  final double strokeWidth;
  final double glowIntensity;

  @override
  void paint(Canvas canvas, Size size) {
    if (value <= 0) return;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);
    final sweepAngle = value * 2 * math.pi;
    const startAngle = -math.pi / 2;

    // Outer ambient glow (pulsing)
    final ambientPaint = Paint()
      ..color = color.withValues(alpha: glowIntensity * 0.25)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth + 20
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 20);
    canvas.drawArc(rect, startAngle, sweepAngle, false, ambientPaint);

    // Inner glow (pulsing)
    final glowPaint = Paint()
      ..color = color.withValues(alpha: 0.3 + glowIntensity * 0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth + 8
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
    canvas.drawArc(rect, startAngle, sweepAngle, false, glowPaint);

    // Main arc with gradient
    final gradientPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(
        startAngle: startAngle,
        endAngle: startAngle + sweepAngle,
        colors: [
          color.withValues(alpha: 0.7),
          color,
          color,
        ],
        stops: const [0.0, 0.3, 1.0],
        transform: const GradientRotation(-math.pi / 2),
      ).createShader(rect);
    canvas.drawArc(rect, startAngle, sweepAngle, false, gradientPaint);

    // Bright tip at the end of the arc
    final tipAngle = startAngle + sweepAngle;
    final tipX = center.dx + radius * math.cos(tipAngle);
    final tipY = center.dy + radius * math.sin(tipAngle);
    final tipPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.8)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
    canvas.drawCircle(Offset(tipX, tipY), strokeWidth * 0.35, tipPaint);
  }

  @override
  bool shouldRepaint(covariant _RingArcPainter oldDelegate) =>
      oldDelegate.value != value ||
      oldDelegate.color != color ||
      oldDelegate.glowIntensity != glowIntensity;
}
