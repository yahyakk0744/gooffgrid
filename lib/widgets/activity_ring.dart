import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../config/theme.dart';

class ActivityRing extends StatefulWidget {
  const ActivityRing({
    super.key,
    required this.value,
    this.size = 220,
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
  late AnimationController _rotateController;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _animation = Tween<double>(begin: 0, end: widget.value.clamp(0.0, 1.0)).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.2, end: 0.6).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Slow ambient rotation for outer decorative ring
    _rotateController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..repeat();

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
    _rotateController.dispose();
    super.dispose();
  }

  Color get _ringColor {
    if (widget.color != null) return widget.color!;
    if (widget.value <= 0.5) return AppColors.ringGood;
    if (widget.value <= 0.8) return AppColors.ringWarning;
    return AppColors.ringDanger;
  }

  String get _statusEmoji {
    if (widget.value <= 0.3) return '🧘';
    if (widget.value <= 0.5) return '✨';
    if (widget.value <= 0.8) return '⚡';
    return '🔥';
  }

  String get _statusLabel {
    if (widget.value <= 0.3) return 'Harika gidiyorsun';
    if (widget.value <= 0.5) return 'İyi tempo';
    if (widget.value <= 0.8) return 'Dikkat et';
    return 'Hedefe yaklaşıyorsun';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: Listenable.merge([_controller, _pulseController, _rotateController]),
        builder: (context, child) {
          return CustomPaint(
            painter: _AmbientRingPainter(
              rotation: _rotateController.value * 2 * math.pi,
              color: _ringColor,
              pulseAlpha: _pulseAnimation.value,
            ),
            foregroundPainter: _MainRingPainter(
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
              Text(_statusEmoji, style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 4),
              if (widget.centerText != null)
                ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [
                      AppColors.textPrimary,
                      _ringColor.withValues(alpha: 0.8),
                    ],
                  ).createShader(bounds),
                  child: Text(
                    widget.centerText!,
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: -1,
                      height: 1,
                    ),
                  ),
                ),
              const SizedBox(height: 4),
              if (widget.subtitle != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    color: _ringColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _statusLabel,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: _ringColor,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// Outer decorative dots ring that slowly rotates
class _AmbientRingPainter extends CustomPainter {
  _AmbientRingPainter({
    required this.rotation,
    required this.color,
    required this.pulseAlpha,
  });

  final double rotation;
  final Color color;
  final double pulseAlpha;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 4;

    // Outer dotted ring
    const dotCount = 60;
    for (int i = 0; i < dotCount; i++) {
      final angle = rotation + (i * 2 * math.pi / dotCount);
      final x = center.dx + radius * math.cos(angle);
      final y = center.dy + radius * math.sin(angle);

      final isHighlight = i % 5 == 0;
      final dotRadius = isHighlight ? 1.5 : 0.8;
      final alpha = isHighlight
          ? 0.15 + pulseAlpha * 0.15
          : 0.06 + pulseAlpha * 0.04;

      canvas.drawCircle(
        Offset(x, y),
        dotRadius,
        Paint()..color = color.withValues(alpha: alpha),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _AmbientRingPainter old) => true;
}

class _MainRingPainter extends CustomPainter {
  _MainRingPainter({
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
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2 - 12;
    final rect = Rect.fromCircle(center: center, radius: radius);
    const startAngle = -math.pi / 2;

    // Track ring (dashed look with low alpha)
    final trackPaint = Paint()
      ..color = AppColors.ringTrack
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(center, radius, trackPaint);

    // Subtle tick marks on track
    const tickCount = 24;
    for (int i = 0; i < tickCount; i++) {
      final angle = startAngle + (i * 2 * math.pi / tickCount);
      final innerR = radius - strokeWidth / 2 - 2;
      final outerR = radius + strokeWidth / 2 + 2;
      final p1 = Offset(center.dx + innerR * math.cos(angle), center.dy + innerR * math.sin(angle));
      final p2 = Offset(center.dx + outerR * math.cos(angle), center.dy + outerR * math.sin(angle));
      canvas.drawLine(
        p1, p2,
        Paint()
          ..color = AppColors.ringTrack.withValues(alpha: 0.4)
          ..strokeWidth = 1,
      );
    }

    if (value <= 0) return;

    final sweepAngle = value * 2 * math.pi;

    // Deep glow layer
    canvas.drawArc(
      rect, startAngle, sweepAngle, false,
      Paint()
        ..color = color.withValues(alpha: glowIntensity * 0.2)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth + 24
        ..strokeCap = StrokeCap.round
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 24),
    );

    // Mid glow
    canvas.drawArc(
      rect, startAngle, sweepAngle, false,
      Paint()
        ..color = color.withValues(alpha: 0.25 + glowIntensity * 0.15)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth + 10
        ..strokeCap = StrokeCap.round
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12),
    );

    // Main arc with gradient
    final gradientPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(
        startAngle: startAngle,
        endAngle: startAngle + sweepAngle,
        colors: [
          color.withValues(alpha: 0.5),
          color.withValues(alpha: 0.8),
          color,
          Colors.white.withValues(alpha: 0.9),
        ],
        stops: const [0.0, 0.3, 0.7, 1.0],
        transform: const GradientRotation(-math.pi / 2),
      ).createShader(rect);
    canvas.drawArc(rect, startAngle, sweepAngle, false, gradientPaint);

    // Bright tip dot
    final tipAngle = startAngle + sweepAngle;
    final tipX = center.dx + radius * math.cos(tipAngle);
    final tipY = center.dy + radius * math.sin(tipAngle);

    // Tip outer glow
    canvas.drawCircle(
      Offset(tipX, tipY),
      strokeWidth * 0.8,
      Paint()
        ..color = color.withValues(alpha: 0.4)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8),
    );
    // Tip bright center
    canvas.drawCircle(
      Offset(tipX, tipY),
      strokeWidth * 0.3,
      Paint()..color = Colors.white,
    );
  }

  @override
  bool shouldRepaint(covariant _MainRingPainter old) =>
      old.value != value || old.color != color || old.glowIntensity != glowIntensity;
}
