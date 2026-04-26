import 'dart:math';
import 'package:flutter/material.dart';
import '../config/theme.dart';

class GrowingTree extends StatefulWidget {
  final double progress; // 0.0 to 1.0
  final bool isComplete;
  final double height;

  const GrowingTree({
    super.key,
    required this.progress,
    this.isComplete = false,
    this.height = 200,
  });

  @override
  State<GrowingTree> createState() => _GrowingTreeState();
}

class _GrowingTreeState extends State<GrowingTree>
    with TickerProviderStateMixin {
  late AnimationController _swayController;
  late AnimationController _sparkleController;
  final _random = Random(42);
  late List<_Particle> _particles;

  @override
  void initState() {
    super.initState();
    _swayController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat(reverse: true);
    _sparkleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    )..repeat();
    _particles = List.generate(12, (_) => _Particle(_random));
  }

  @override
  void dispose() {
    _swayController.dispose();
    _sparkleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.height * 1.2,
      height: widget.height,
      child: AnimatedBuilder(
        animation: Listenable.merge([_swayController, _sparkleController]),
        builder: (context, _) {
          return CustomPaint(
            size: Size(widget.height * 1.2, widget.height),
            painter: _TreePainter(
              progress: widget.progress,
              isComplete: widget.isComplete,
              swayValue: _swayController.value,
              sparkleValue: _sparkleController.value,
              particles: _particles,
              random: _random,
            ),
          );
        },
      ),
    );
  }
}

class _Particle {
  late double x, y, speed, size, phase;
  _Particle(Random r) {
    x = r.nextDouble();
    y = r.nextDouble();
    speed = 0.3 + r.nextDouble() * 0.7;
    size = 1.5 + r.nextDouble() * 2.5;
    phase = r.nextDouble() * pi * 2;
  }
}

class _TreePainter extends CustomPainter {
  final double progress;
  final bool isComplete;
  final double swayValue;
  final double sparkleValue;
  final List<_Particle> particles;
  final Random random;

  _TreePainter({
    required this.progress,
    required this.isComplete,
    required this.swayValue,
    required this.sparkleValue,
    required this.particles,
    required this.random,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final ground = size.height * 0.92;

    if (progress < 0.01) return;

    // --- Phases ---
    // 0.0-0.1: seed
    // 0.1-0.3: sprout
    // 0.3-0.6: trunk + first branches
    // 0.6-0.85: full branches + leaves
    // 0.85-1.0: full tree + flowers

    final glowColor = isComplete ? AppColors.gold : AppColors.neonGreen;

    // Ground glow
    final groundGlow = Paint()
      ..shader = RadialGradient(
        colors: [
          glowColor.withValues(alpha: 0.08 * progress),
          glowColor.withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromCircle(
        center: Offset(cx, ground),
        radius: 60 * progress,
      ));
    canvas.drawCircle(Offset(cx, ground), 60 * progress, groundGlow);

    if (progress < 0.1) {
      // Seed phase
      _drawSeed(canvas, cx, ground, progress / 0.1);
      return;
    }

    if (progress < 0.3) {
      // Sprout phase
      _drawSeed(canvas, cx, ground, 1.0);
      _drawSprout(canvas, cx, ground, (progress - 0.1) / 0.2);
      return;
    }

    // Tree phase
    final treeProgress = ((progress - 0.3) / 0.7).clamp(0.0, 1.0);
    _drawTree(canvas, size, cx, ground, treeProgress, glowColor);

    // Particles (floating leaves/sparkles)
    if (progress > 0.5) {
      _drawParticles(canvas, size, cx, ground, glowColor);
    }
  }

  void _drawSeed(Canvas canvas, double cx, double ground, double t) {
    final seedPaint = Paint()
      ..color = const Color(0xFF5C3D2E).withValues(alpha: 0.6 + t * 0.4);
    final seedSize = 4.0 + t * 2.0;
    canvas.drawOval(
      Rect.fromCenter(center: Offset(cx, ground - seedSize / 2), width: seedSize * 1.3, height: seedSize),
      seedPaint,
    );
    // Tiny glow
    final glow = Paint()
      ..color = AppColors.neonGreen.withValues(alpha: t * 0.3);
    canvas.drawCircle(Offset(cx, ground - seedSize / 2), seedSize * 1.5, glow);
  }

  void _drawSprout(Canvas canvas, double cx, double ground, double t) {
    final stemHeight = 20.0 * t;
    final sway = sin(swayValue * pi * 2) * 2 * t;

    // Stem
    final stemPaint = Paint()
      ..color = const Color(0xFF2E7D32)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final stemPath = Path();
    stemPath.moveTo(cx, ground - 4);
    stemPath.quadraticBezierTo(cx + sway, ground - 4 - stemHeight / 2, cx + sway * 0.5, ground - 4 - stemHeight);
    canvas.drawPath(stemPath, stemPaint);

    if (t > 0.4) {
      // Two tiny leaves
      final leafT = ((t - 0.4) / 0.6).clamp(0.0, 1.0);
      final leafPaint = Paint()
        ..color = AppColors.neonGreen.withValues(alpha: 0.5 + leafT * 0.3);
      final tipX = cx + sway * 0.5;
      final tipY = ground - 4 - stemHeight;

      // Left leaf
      _drawSmallLeaf(canvas, tipX - 2, tipY + 4 * (1 - leafT), -0.5 + sway * 0.02, leafT * 6, leafPaint);
      // Right leaf
      _drawSmallLeaf(canvas, tipX + 2, tipY + 4 * (1 - leafT), 0.5 + sway * 0.02, leafT * 6, leafPaint);
    }
  }

  void _drawSmallLeaf(Canvas canvas, double x, double y, double angle, double leafSize, Paint paint) {
    canvas.save();
    canvas.translate(x, y);
    canvas.rotate(angle);
    final path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(-leafSize * 0.5, -leafSize * 0.6, 0, -leafSize);
    path.quadraticBezierTo(leafSize * 0.5, -leafSize * 0.6, 0, 0);
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  void _drawTree(Canvas canvas, Size size, double cx, double ground, double t, Color glowColor) {
    final trunkHeight = 40 + 60 * t;
    final trunkWidth = 3 + 4 * t;
    final sway = sin(swayValue * pi * 2) * (2 + t * 1.5);

    // Trunk
    final trunkPaint = Paint()
      ..color = const Color(0xFF4A3728)
      ..strokeWidth = trunkWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final trunkPath = Path();
    trunkPath.moveTo(cx, ground - 4);
    trunkPath.cubicTo(
      cx + sway * 0.2, ground - 4 - trunkHeight * 0.3,
      cx + sway * 0.5, ground - 4 - trunkHeight * 0.6,
      cx + sway * 0.3, ground - 4 - trunkHeight,
    );
    canvas.drawPath(trunkPath, trunkPaint);

    // Darker trunk outline
    final outlinePaint = Paint()
      ..color = const Color(0xFF2C1F15)
      ..strokeWidth = trunkWidth + 1.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(trunkPath, outlinePaint);
    canvas.drawPath(trunkPath, trunkPaint);

    if (t < 0.2) return;

    // Branches
    final branchT = ((t - 0.2) / 0.8).clamp(0.0, 1.0);
    final topX = cx + sway * 0.3;
    final topY = ground - 4 - trunkHeight;

    final branches = <_Branch>[
      _Branch(-35, 0.7, 0.0),
      _Branch(30, 0.65, 0.1),
      _Branch(-55, 0.5, 0.2),
      _Branch(50, 0.55, 0.25),
      _Branch(-15, 0.8, 0.35),
      _Branch(15, 0.75, 0.4),
    ];

    final branchPaint = Paint()
      ..color = const Color(0xFF5C4033)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    for (final b in branches) {
      if (branchT < b.threshold) continue;
      final bt = ((branchT - b.threshold) / (1.0 - b.threshold)).clamp(0.0, 1.0);
      final len = trunkHeight * b.lengthRatio * bt * 0.5;
      final angle = b.angle * pi / 180 + sway * 0.008;

      final branchStartY = topY + trunkHeight * (1 - b.lengthRatio) * 0.3;
      final endX = topX + cos(angle - pi / 2) * len;
      final endY = branchStartY + sin(angle - pi / 2) * len;

      branchPaint.strokeWidth = 1.5 + bt;
      final bp = Path();
      bp.moveTo(topX, branchStartY);
      bp.quadraticBezierTo(
        topX + (endX - topX) * 0.5 + sway * 0.3,
        branchStartY + (endY - branchStartY) * 0.3,
        endX, endY,
      );
      canvas.drawPath(bp, branchPaint);

      // Leaves on branch tips
      if (bt > 0.3) {
        final leafT = ((bt - 0.3) / 0.7).clamp(0.0, 1.0);
        _drawLeafCluster(canvas, endX, endY, leafT, sway, glowColor);
      }
    }

    // Crown (canopy)
    if (branchT > 0.3) {
      final canopyT = ((branchT - 0.3) / 0.7).clamp(0.0, 1.0);
      _drawCanopy(canvas, topX, topY, trunkHeight * 0.4 * canopyT, canopyT, sway, glowColor);
    }
  }

  void _drawLeafCluster(Canvas canvas, double x, double y, double t, double sway, Color glowColor) {
    final leafPaint = Paint()
      ..color = glowColor.withValues(alpha: 0.3 + t * 0.3);

    final count = 3 + (t * 4).round();
    for (int i = 0; i < count; i++) {
      final angle = (i / count) * pi * 2 + sway * 0.05;
      final dist = 4 + t * 8;
      final lx = x + cos(angle) * dist;
      final ly = y + sin(angle) * dist * 0.7;
      final leafSize = 3 + t * 5;

      canvas.save();
      canvas.translate(lx, ly);
      canvas.rotate(angle + sin(swayValue * pi * 2 + i) * 0.2);
      final path = Path();
      path.moveTo(0, 0);
      path.quadraticBezierTo(-leafSize * 0.4, -leafSize * 0.5, 0, -leafSize);
      path.quadraticBezierTo(leafSize * 0.4, -leafSize * 0.5, 0, 0);
      canvas.drawPath(path, leafPaint);
      canvas.restore();
    }

    // Glow
    final glow = Paint()
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12)
      ..color = glowColor.withValues(alpha: 0.07 * t);
    canvas.drawCircle(Offset(x, y), 12 + t * 10, glow);
  }

  void _drawCanopy(Canvas canvas, double cx, double cy, double radius, double t, double sway, Color glowColor) {
    if (radius < 5) return;

    // Soft glow behind canopy
    final glowPaint = Paint()
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 20)
      ..color = glowColor.withValues(alpha: 0.06 * t);
    canvas.drawCircle(Offset(cx, cy - radius * 0.3), radius * 1.3, glowPaint);

    // Canopy blobs
    final blobPaint = Paint()
      ..color = glowColor.withValues(alpha: 0.15 + t * 0.1);

    final blobs = [
      Offset(0, -0.5),
      Offset(-0.6, -0.1),
      Offset(0.6, -0.1),
      Offset(-0.3, -0.7),
      Offset(0.3, -0.7),
      Offset(0, 0.1),
    ];

    for (int i = 0; i < blobs.length; i++) {
      final b = blobs[i];
      final blobSway = sin(swayValue * pi * 2 + i * 0.8) * 2;
      final bx = cx + b.dx * radius + blobSway;
      final by = cy + b.dy * radius;
      final br = radius * (0.35 + (i % 3) * 0.05) * t;

      canvas.drawOval(
        Rect.fromCenter(center: Offset(bx, by), width: br * 2, height: br * 1.6),
        blobPaint,
      );
    }

    // Inner brighter glow
    final innerGlow = Paint()
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8)
      ..color = glowColor.withValues(alpha: 0.04 * t);
    canvas.drawCircle(Offset(cx, cy - radius * 0.4), radius * 0.6, innerGlow);
  }

  void _drawParticles(Canvas canvas, Size size, double cx, double ground, Color glowColor) {
    final particleT = ((progress - 0.5) / 0.5).clamp(0.0, 1.0);

    for (final p in particles) {
      final t = (sparkleValue + p.phase) % 1.0;
      final px = cx + (p.x - 0.5) * 120;
      final py = ground - 30 - p.y * 120 - t * 40 * p.speed;
      final alpha = sin(t * pi) * 0.6 * particleT;

      if (alpha <= 0) continue;

      final paint = Paint()
        ..color = glowColor.withValues(alpha: alpha)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);
      canvas.drawCircle(Offset(px, py), p.size * particleT, paint);
    }
  }

  @override
  bool shouldRepaint(_TreePainter oldDelegate) => true;
}

class _Branch {
  final double angle;
  final double lengthRatio;
  final double threshold;
  const _Branch(this.angle, this.lengthRatio, this.threshold);
}
