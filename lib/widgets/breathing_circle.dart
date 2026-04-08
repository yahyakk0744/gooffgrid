import 'dart:math' as math;
import 'package:flutter/material.dart';


/// Nefes fazları
enum BreathPhase { inhale, holdIn, exhale, holdOut }

/// Nefes teknikleri — tümü klinik olarak doğrulanmış
enum BreathPattern {
  physiologicalSigh, // Cyclic Sighing (Stanford/Dr. Huberman) — Balban et al. 2023
  boxBreathing,      // Box Breathing (Navy SEAL) — Cleveland Clinic
  relaxing478,       // 4-7-8 (Dr. Andrew Weil) — Cleveland Clinic, Viada et al. 2022
  coherent,          // Coherent Breathing (Stephen Elliott) — Lin et al. 2014
  diaphragmatic,     // Diaphragmatic / Belly (Cleveland Clinic) — PMC7602530
  extendedExhale,    // Extended Exhale 4-2-6 — parasempatik aktivasyon
}

extension BreathPatternExt on BreathPattern {
  String get label => switch (this) {
    BreathPattern.physiologicalSigh => 'Fizyolojik İç Çekme',
    BreathPattern.boxBreathing => 'Kutu Nefesi',
    BreathPattern.relaxing478 => '4-7-8 Rahatlatıcı',
    BreathPattern.coherent => 'Tutarlı Nefes',
    BreathPattern.diaphragmatic => 'Diyafram Nefesi',
    BreathPattern.extendedExhale => 'Uzun Nefes Verme',
  };

  String get description => switch (this) {
    BreathPattern.physiologicalSigh => 'Anlık stres giderici — Stanford RCT ile kanıtlanmış',
    BreathPattern.boxBreathing => 'Odaklanma ve stres kontrolü — Navy SEAL tekniği',
    BreathPattern.relaxing478 => 'Derin rahatlama ve uyku öncesi — Dr. Andrew Weil',
    BreathPattern.coherent => 'Kalp ritmi uyumu (HRV) — Stephen Elliott',
    BreathPattern.diaphragmatic => 'Temel nefes eğitimi — yeni başlayanlar için ideal',
    BreathPattern.extendedExhale => 'Kaygı giderici — uzun nefes verme ile parasempatik aktivasyon',
  };

  String get emoji => switch (this) {
    BreathPattern.physiologicalSigh => '🧠',
    BreathPattern.boxBreathing => '🎯',
    BreathPattern.relaxing478 => '🌙',
    BreathPattern.coherent => '💚',
    BreathPattern.diaphragmatic => '🌱',
    BreathPattern.extendedExhale => '🌊',
  };

  String get source => switch (this) {
    BreathPattern.physiologicalSigh => 'Balban et al. 2023, Cell Reports Medicine (Stanford)',
    BreathPattern.boxBreathing => 'Cleveland Clinic, US Navy SEAL protokolü',
    BreathPattern.relaxing478 => 'Dr. Andrew Weil, Viada et al. 2022 (HRV)',
    BreathPattern.coherent => 'Stephen Elliott, Lin et al. 2014 (HRV)',
    BreathPattern.diaphragmatic => 'Cleveland Clinic, PMC7602530 meta-analiz',
    BreathPattern.extendedExhale => 'Parasempatik sinir sistemi araştırmaları',
  };

  /// (inhale, holdIn, exhale, holdOut) in seconds
  (double, double, double, double) get timing => switch (this) {
    BreathPattern.physiologicalSigh => (4.0, 0.0, 7.0, 0.0),
    BreathPattern.boxBreathing => (4.0, 4.0, 4.0, 4.0),
    BreathPattern.relaxing478 => (4.0, 7.0, 8.0, 0.0),
    BreathPattern.coherent => (5.5, 0.0, 5.5, 0.0),
    BreathPattern.diaphragmatic => (4.0, 2.0, 6.0, 0.0),
    BreathPattern.extendedExhale => (4.0, 2.0, 6.0, 0.0),
  };

  double get totalSeconds {
    final t = timing;
    return t.$1 + t.$2 + t.$3 + t.$4;
  }

  /// Her pattern'in kendine özgü renk paleti
  (Color, Color) get gradientColors => switch (this) {
    BreathPattern.physiologicalSigh => (const Color(0xFFE040FB), const Color(0xFF7C4DFF)),
    BreathPattern.boxBreathing => (const Color(0xFF4FACFE), const Color(0xFF00F2FE)),
    BreathPattern.relaxing478 => (const Color(0xFF667EEA), const Color(0xFF764BA2)),
    BreathPattern.coherent => (const Color(0xFF43E97B), const Color(0xFF38F9D7)),
    BreathPattern.diaphragmatic => (const Color(0xFFF6D365), const Color(0xFFFDA085)),
    BreathPattern.extendedExhale => (const Color(0xFF4FACFE), const Color(0xFF667EEA)),
  };
}

class BreathingCircle extends StatefulWidget {
  const BreathingCircle({
    super.key,
    this.isActive = false,
    this.pattern = BreathPattern.boxBreathing,
    this.onPhaseChange,
    this.onBreathComplete,
  });

  final bool isActive;
  final BreathPattern pattern;
  final ValueChanged<BreathPhase>? onPhaseChange;
  final VoidCallback? onBreathComplete;

  @override
  State<BreathingCircle> createState() => _BreathingCircleState();
}

class _BreathingCircleState extends State<BreathingCircle>
    with TickerProviderStateMixin {
  late AnimationController _breathController;
  late AnimationController _glowController;
  late AnimationController _fxController;
  BreathPhase _lastPhase = BreathPhase.inhale;

  @override
  void initState() {
    super.initState();
    _breathController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: (widget.pattern.totalSeconds * 1000).round(),
      ),
    );

    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    _fxController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();

    _breathController.addListener(_checkPhase);

    if (widget.isActive) _breathController.repeat();
  }

  @override
  void didUpdateWidget(BreathingCircle oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.pattern != oldWidget.pattern) {
      _breathController.duration = Duration(
        milliseconds: (widget.pattern.totalSeconds * 1000).round(),
      );
    }

    if (widget.isActive && !_breathController.isAnimating) {
      _breathController.repeat();
    } else if (!widget.isActive && _breathController.isAnimating) {
      _breathController.stop();
    }
  }

  void _checkPhase() {
    final phase = _getPhase(_breathController.value);
    if (phase != _lastPhase) {
      _lastPhase = phase;
      widget.onPhaseChange?.call(phase);
      if (phase == BreathPhase.inhale && _breathController.value > 0.01) {
        widget.onBreathComplete?.call();
      }
    }
  }

  @override
  void dispose() {
    _breathController.dispose();
    _glowController.dispose();
    _fxController.dispose();
    super.dispose();
  }

  BreathPhase _getPhase(double t) {
    final timing = widget.pattern.timing;
    final total = widget.pattern.totalSeconds;
    final sec = t * total;

    if (sec < timing.$1) return BreathPhase.inhale;
    if (sec < timing.$1 + timing.$2) return BreathPhase.holdIn;
    if (sec < timing.$1 + timing.$2 + timing.$3) return BreathPhase.exhale;
    return BreathPhase.holdOut;
  }

  double _getPhaseProgress(double t) {
    final timing = widget.pattern.timing;
    final total = widget.pattern.totalSeconds;
    final sec = t * total;

    if (sec < timing.$1) {
      return sec / timing.$1;
    } else if (sec < timing.$1 + timing.$2) {
      return timing.$2 > 0 ? (sec - timing.$1) / timing.$2 : 0;
    } else if (sec < timing.$1 + timing.$2 + timing.$3) {
      return (sec - timing.$1 - timing.$2) / timing.$3;
    } else {
      final holdOut = timing.$4;
      if (holdOut <= 0) return 0;
      return (sec - timing.$1 - timing.$2 - timing.$3) / holdOut;
    }
  }

  /// Scale 0.55→1.0 for inhale, hold at 1.0, 1.0→0.55 for exhale, hold at 0.55
  double _getScale(double t) {
    final timing = widget.pattern.timing;
    final total = widget.pattern.totalSeconds;
    final sec = t * total;

    const minScale = 0.55;
    const maxScale = 1.0;
    const range = maxScale - minScale;

    if (sec < timing.$1) {
      final p = sec / timing.$1;
      return minScale + range * Curves.easeInOut.transform(p);
    } else if (sec < timing.$1 + timing.$2) {
      return maxScale;
    } else if (sec < timing.$1 + timing.$2 + timing.$3) {
      final p = (sec - timing.$1 - timing.$2) / timing.$3;
      return maxScale - range * Curves.easeInOut.transform(p);
    } else {
      return minScale;
    }
  }

  Color _getPhaseColor(BreathPhase phase) {
    final colors = widget.pattern.gradientColors;
    return switch (phase) {
      BreathPhase.inhale => colors.$1,
      BreathPhase.holdIn => Color.lerp(colors.$1, colors.$2, 0.5)!,
      BreathPhase.exhale => colors.$2,
      BreathPhase.holdOut => Color.lerp(colors.$2, colors.$1, 0.5)!,
    };
  }

  String _getPhaseLabel(BreathPhase phase) => switch (phase) {
    BreathPhase.inhale => 'Nefes Al',
    BreathPhase.holdIn => 'Tut',
    BreathPhase.exhale => 'Nefes Ver',
    BreathPhase.holdOut => 'Bekle',
  };

  int _getPhaseSeconds(BreathPhase phase) {
    final timing = widget.pattern.timing;
    return switch (phase) {
      BreathPhase.inhale => timing.$1.round(),
      BreathPhase.holdIn => timing.$2.round(),
      BreathPhase.exhale => timing.$3.round(),
      BreathPhase.holdOut => timing.$4.round(),
    };
  }

  @override
  Widget build(BuildContext context) {
    const totalSize = 280.0;

    return SizedBox(
      width: totalSize,
      height: totalSize,
      child: AnimatedBuilder(
        animation: Listenable.merge([_breathController, _glowController, _fxController]),
        builder: (context, _) {
          final t = _breathController.value;
          final scale = widget.isActive ? _getScale(t) : 0.55;
          final phase = _getPhase(t);
          final phaseProgress = _getPhaseProgress(t);
          final phaseColor = widget.isActive ? _getPhaseColor(phase) : const Color(0xFF667EEA);
          final glowIntensity = _glowController.value;
          final currentSize = totalSize * scale;
          final fxT = _fxController.value;

          return Stack(
            alignment: Alignment.center,
            children: [
              // Pattern-specific background FX
              if (widget.isActive)
                _buildPatternFX(totalSize, t, phase, phaseProgress, phaseColor, fxT),

              // Phase progress arc
              if (widget.isActive)
                SizedBox(
                  width: totalSize - 8,
                  height: totalSize - 8,
                  child: CustomPaint(
                    painter: _ProgressArcPainter(
                      progress: phaseProgress,
                      color: phaseColor,
                      bgOpacity: 0.08,
                    ),
                  ),
                ),

              // Outer glow
              Container(
                width: currentSize + 40,
                height: currentSize + 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: phaseColor.withValues(alpha: 0.15 + glowIntensity * 0.1),
                      blurRadius: 50 + glowIntensity * 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
              ),

              // Secondary ring
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: currentSize + 20,
                height: currentSize + 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: phaseColor.withValues(alpha: 0.12 + glowIntensity * 0.08),
                    width: 1.5,
                  ),
                ),
              ),

              // Main circle — pattern-specific decoration
              _buildMainCircle(currentSize, phaseColor, glowIntensity, t, phase, phaseProgress),

              // Inner content
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.isActive) ...[
                    Text(
                      _getPhaseLabel(phase),
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: phaseColor,
                        letterSpacing: 1,
                        shadows: [Shadow(color: phaseColor.withValues(alpha: 0.5), blurRadius: 12)],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${(_getPhaseSeconds(phase) - (_getPhaseSeconds(phase) * phaseProgress).floor()).clamp(1, 99)}',
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.w200,
                        color: Colors.white.withValues(alpha: 0.9),
                        letterSpacing: 2,
                      ),
                    ),
                  ] else ...[
                    Icon(
                      Icons.self_improvement_rounded,
                      size: 36,
                      color: Colors.white.withValues(alpha: 0.6),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Başla',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  /// Her pattern'e özgü arka plan efekti
  Widget _buildPatternFX(double size, double t, BreathPhase phase,
      double phaseProgress, Color color, double fxT) {
    return switch (widget.pattern) {
      // 🧠 Fizyolojik İç Çekme: Çift dalga (double inhale efekti)
      BreathPattern.physiologicalSigh => CustomPaint(
        size: Size(size, size),
        painter: _SighWavePainter(
          breathT: t,
          fxT: fxT,
          color: color,
          phase: phase,
          phaseProgress: phaseProgress,
        ),
      ),

      // 🎯 Kutu Nefesi: Dönen kare köşeleri
      BreathPattern.boxBreathing => CustomPaint(
        size: Size(size, size),
        painter: _BoxCornersPainter(
          breathT: t,
          fxT: fxT,
          color: color,
          phase: phase,
          phaseProgress: phaseProgress,
        ),
      ),

      // 🌙 4-7-8: Yıldız parçacıkları + ay halesi
      BreathPattern.relaxing478 => CustomPaint(
        size: Size(size, size),
        painter: _MoonStarsPainter(
          breathT: t,
          fxT: fxT,
          color: color,
          phase: phase,
          phaseProgress: phaseProgress,
        ),
      ),

      // 💚 Tutarlı: Sinüs kalp atışı dalgası
      BreathPattern.coherent => CustomPaint(
        size: Size(size, size),
        painter: _HeartWavePainter(
          breathT: t,
          fxT: fxT,
          color: color,
          phase: phase,
          phaseProgress: phaseProgress,
        ),
      ),

      // 🌱 Diyafram: Büyüyen yaprak/çiçek deseni
      BreathPattern.diaphragmatic => CustomPaint(
        size: Size(size, size),
        painter: _BloomPainter(
          breathT: t,
          fxT: fxT,
          color: color,
          scale: _getScale(t),
        ),
      ),

      // 🌊 Uzun Nefes Verme: Okyanus dalgaları
      BreathPattern.extendedExhale => CustomPaint(
        size: Size(size, size),
        painter: _OceanWavePainter(
          breathT: t,
          fxT: fxT,
          color: color,
          phase: phase,
          phaseProgress: phaseProgress,
        ),
      ),
    };
  }

  /// Pattern'e göre farklılaşan ana daire
  Widget _buildMainCircle(double currentSize, Color phaseColor,
      double glowIntensity, double t, BreathPhase phase, double phaseProgress) {
    // Kutu Nefesi: köşeleri yuvarlatılmış kare morph
    if (widget.pattern == BreathPattern.boxBreathing && widget.isActive) {
      final cornerRatio = switch (phase) {
        BreathPhase.inhale => 1.0 - phaseProgress * 0.4,     // daire → kare
        BreathPhase.holdIn => 0.6,                             // kare tut
        BreathPhase.exhale => 0.6 + phaseProgress * 0.4,      // kare → daire
        BreathPhase.holdOut => 1.0,                            // daire tut
      };
      return AnimatedContainer(
        duration: const Duration(milliseconds: 80),
        width: currentSize,
        height: currentSize,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(currentSize * cornerRatio * 0.5),
          gradient: RadialGradient(
            center: const Alignment(-0.2, -0.3),
            colors: [
              phaseColor.withValues(alpha: 0.35),
              phaseColor.withValues(alpha: 0.15),
              const Color(0xFF0D0D2B).withValues(alpha: 0.8),
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
          border: Border.all(
            color: phaseColor.withValues(alpha: 0.3 + glowIntensity * 0.15),
            width: 2,
          ),
        ),
      );
    }

    // Fizyolojik İç Çekme: nefes alırken çift nabız efekti
    double extraScale = 1.0;
    if (widget.pattern == BreathPattern.physiologicalSigh &&
        widget.isActive &&
        phase == BreathPhase.inhale) {
      // İlk yarıda normal genişle, ikinci yarıda mini bir "sigh" çöküp tekrar genişle
      if (phaseProgress > 0.5 && phaseProgress < 0.7) {
        extraScale = 1.0 - 0.04 * math.sin((phaseProgress - 0.5) / 0.2 * math.pi);
      }
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 80),
      width: currentSize * extraScale,
      height: currentSize * extraScale,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          center: const Alignment(-0.2, -0.3),
          colors: [
            phaseColor.withValues(alpha: 0.35),
            phaseColor.withValues(alpha: 0.15),
            const Color(0xFF0D0D2B).withValues(alpha: 0.8),
          ],
          stops: const [0.0, 0.5, 1.0],
        ),
        border: Border.all(
          color: phaseColor.withValues(alpha: 0.3 + glowIntensity * 0.15),
          width: 2,
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════
// 🧠 PHYSIOLOGICAL SIGH — Double wave ripples
// ═══════════════════════════════════════════

class _SighWavePainter extends CustomPainter {
  _SighWavePainter({
    required this.breathT,
    required this.fxT,
    required this.color,
    required this.phase,
    required this.phaseProgress,
  });
  final double breathT, fxT;
  final Color color;
  final BreathPhase phase;
  final double phaseProgress;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxR = size.width / 2;
    final paint = Paint()..style = PaintingStyle.stroke..strokeWidth = 1.5;

    // İki halka yayılıyor — "çift nefes" efekti
    for (int wave = 0; wave < 2; wave++) {
      final delay = wave * 0.15;
      double radius;
      double alpha;

      if (phase == BreathPhase.inhale) {
        final p = (phaseProgress - delay).clamp(0.0, 1.0);
        radius = maxR * 0.4 + maxR * 0.45 * Curves.easeOut.transform(p);
        alpha = 0.4 * (1.0 - p);
      } else if (phase == BreathPhase.exhale) {
        final p = phaseProgress;
        radius = maxR * 0.85 - maxR * 0.35 * Curves.easeIn.transform(p);
        alpha = 0.15 + 0.15 * p;
      } else {
        radius = maxR * 0.85 + math.sin(fxT * 2 * math.pi + wave) * 3;
        alpha = 0.1;
      }

      paint.color = color.withValues(alpha: alpha);
      canvas.drawCircle(center, radius, paint);
    }
  }

  @override
  bool shouldRepaint(_SighWavePainter old) => true;
}

// ═══════════════════════════════════════════
// 🎯 BOX BREATHING — Rotating square corners
// ═══════════════════════════════════════════

class _BoxCornersPainter extends CustomPainter {
  _BoxCornersPainter({
    required this.breathT,
    required this.fxT,
    required this.color,
    required this.phase,
    required this.phaseProgress,
  });
  final double breathT, fxT;
  final Color color;
  final BreathPhase phase;
  final double phaseProgress;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final r = size.width / 2 - 12;

    // Breath cycle'ın 4 fazı → dönen kare'nin 4 köşesi ışıklandırılıyor
    final phaseIndex = switch (phase) {
      BreathPhase.inhale => 0,
      BreathPhase.holdIn => 1,
      BreathPhase.exhale => 2,
      BreathPhase.holdOut => 3,
    };

    // Yavaş dönen kare çerçeve
    final rotation = breathT * math.pi * 2 * 0.25; // Bir nefes = çeyrek tur

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);

    final corners = [
      Offset(-r * 0.7, -r * 0.7),
      Offset(r * 0.7, -r * 0.7),
      Offset(r * 0.7, r * 0.7),
      Offset(-r * 0.7, r * 0.7),
    ];

    // Kare kenarları
    final linePaint = Paint()
      ..color = color.withValues(alpha: 0.12)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final path = Path();
    for (int i = 0; i < 4; i++) {
      if (i == 0) {
        path.moveTo(corners[i].dx, corners[i].dy);
      } else {
        path.lineTo(corners[i].dx, corners[i].dy);
      }
    }
    path.close();
    canvas.drawPath(path, linePaint);

    // Aktif köşe parlar
    for (int i = 0; i < 4; i++) {
      final isActiveCorner = i == phaseIndex;
      final dotPaint = Paint()
        ..color = color.withValues(alpha: isActiveCorner ? 0.7 : 0.15)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(corners[i], isActiveCorner ? 5 : 3, dotPaint);

      if (isActiveCorner) {
        final glowPaint = Paint()
          ..color = color.withValues(alpha: 0.3)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
        canvas.drawCircle(corners[i], 8, glowPaint);
      }
    }

    // Aktif kenar boyunca ilerleyen ışık çizgisi
    final fromCorner = corners[phaseIndex];
    final toCorner = corners[(phaseIndex + 1) % 4];
    final progressPoint = Offset(
      fromCorner.dx + (toCorner.dx - fromCorner.dx) * phaseProgress,
      fromCorner.dy + (toCorner.dy - fromCorner.dy) * phaseProgress,
    );

    final trailPaint = Paint()
      ..color = color.withValues(alpha: 0.5)
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawLine(fromCorner, progressPoint, trailPaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(_BoxCornersPainter old) => true;
}

// ═══════════════════════════════════════════
// 🌙 RELAXING 4-7-8 — Moon halo + twinkling stars
// ═══════════════════════════════════════════

class _MoonStarsPainter extends CustomPainter {
  _MoonStarsPainter({
    required this.breathT,
    required this.fxT,
    required this.color,
    required this.phase,
    required this.phaseProgress,
  });
  final double breathT, fxT;
  final Color color;
  final BreathPhase phase;
  final double phaseProgress;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxR = size.width / 2;
    final rng = math.Random(42);

    // Yıldızlar — holdIn fazında parlıyor (7 saniye tutma)
    final starBrightness = phase == BreathPhase.holdIn
        ? 0.3 + 0.5 * math.sin(phaseProgress * math.pi)
        : 0.15;

    for (int i = 0; i < 20; i++) {
      final angle = rng.nextDouble() * 2 * math.pi;
      final dist = maxR * (0.5 + rng.nextDouble() * 0.45);
      final twinkle = math.sin(fxT * 2 * math.pi * 3 + i * 1.7).abs();
      final x = center.dx + dist * math.cos(angle);
      final y = center.dy + dist * math.sin(angle);
      final starSize = 1.0 + rng.nextDouble() * 1.5;

      final starPaint = Paint()
        ..color = color.withValues(alpha: starBrightness * twinkle)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(x, y), starSize, starPaint);
    }

    // Ay halesi — inhale'de büyüyor, exhale'de sönüyor
    final haloAlpha = switch (phase) {
      BreathPhase.inhale => 0.05 + 0.1 * phaseProgress,
      BreathPhase.holdIn => 0.15,
      BreathPhase.exhale => 0.15 - 0.1 * phaseProgress,
      BreathPhase.holdOut => 0.05,
    };

    final haloPaint = Paint()
      ..color = color.withValues(alpha: haloAlpha)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 30);
    canvas.drawCircle(center, maxR * 0.6, haloPaint);
  }

  @override
  bool shouldRepaint(_MoonStarsPainter old) => true;
}

// ═══════════════════════════════════════════
// 💚 COHERENT — Heart rate sine wave
// ═══════════════════════════════════════════

class _HeartWavePainter extends CustomPainter {
  _HeartWavePainter({
    required this.breathT,
    required this.fxT,
    required this.color,
    required this.phase,
    required this.phaseProgress,
  });
  final double breathT, fxT;
  final Color color;
  final BreathPhase phase;
  final double phaseProgress;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final r = size.width / 2 - 8;

    // Dairesel sinüs dalga — HRV ritmi simülasyonu
    final wavePath = Path();
    final wavePoints = 60;
    final amplitude = 6.0 + 6.0 * math.sin(breathT * 2 * math.pi);

    for (int i = 0; i <= wavePoints; i++) {
      final angle = 2 * math.pi * i / wavePoints;
      final wave = amplitude * math.sin(angle * 4 + breathT * 2 * math.pi * 2);
      final dist = r - 15 + wave;
      final x = center.dx + dist * math.cos(angle);
      final y = center.dy + dist * math.sin(angle);

      if (i == 0) {
        wavePath.moveTo(x, y);
      } else {
        wavePath.lineTo(x, y);
      }
    }
    wavePath.close();

    final wavePaint = Paint()
      ..color = color.withValues(alpha: 0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawPath(wavePath, wavePaint);

    // İkinci dalga — yarım faz kayık
    final wavePath2 = Path();
    for (int i = 0; i <= wavePoints; i++) {
      final angle = 2 * math.pi * i / wavePoints;
      final wave = amplitude * 0.6 * math.sin(angle * 4 + breathT * 2 * math.pi * 2 + math.pi);
      final dist = r - 8 + wave;
      final x = center.dx + dist * math.cos(angle);
      final y = center.dy + dist * math.sin(angle);

      if (i == 0) {
        wavePath2.moveTo(x, y);
      } else {
        wavePath2.lineTo(x, y);
      }
    }
    wavePath2.close();

    wavePaint.color = color.withValues(alpha: 0.08);
    canvas.drawPath(wavePath2, wavePaint);
  }

  @override
  bool shouldRepaint(_HeartWavePainter old) => true;
}

// ═══════════════════════════════════════════
// 🌱 DIAPHRAGMATIC — Blooming petals
// ═══════════════════════════════════════════

class _BloomPainter extends CustomPainter {
  _BloomPainter({
    required this.breathT,
    required this.fxT,
    required this.color,
    required this.scale,
  });
  final double breathT, fxT;
  final Color color;
  final double scale;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxR = size.width / 2 - 10;

    // 6 yaprak — nefesle büyüyüp küçülüyor
    const petalCount = 6;
    final petalLength = maxR * 0.6 * scale;
    final petalWidth = maxR * 0.18 * scale;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    // Çok yavaş dönüş
    canvas.rotate(fxT * math.pi * 0.5);

    for (int i = 0; i < petalCount; i++) {
      canvas.save();
      canvas.rotate(2 * math.pi * i / petalCount);

      final petalPath = Path();
      petalPath.moveTo(0, 0);
      petalPath.quadraticBezierTo(petalWidth, -petalLength * 0.4, 0, -petalLength);
      petalPath.quadraticBezierTo(-petalWidth, -petalLength * 0.4, 0, 0);

      final petalPaint = Paint()
        ..color = color.withValues(alpha: 0.08 + 0.07 * scale)
        ..style = PaintingStyle.fill;
      canvas.drawPath(petalPath, petalPaint);

      final borderPaint = Paint()
        ..color = color.withValues(alpha: 0.15 + 0.1 * scale)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1;
      canvas.drawPath(petalPath, borderPaint);

      canvas.restore();
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(_BloomPainter old) =>
      old.breathT != breathT || old.scale != scale;
}

// ═══════════════════════════════════════════
// 🌊 EXTENDED EXHALE — Ocean waves
// ═══════════════════════════════════════════

class _OceanWavePainter extends CustomPainter {
  _OceanWavePainter({
    required this.breathT,
    required this.fxT,
    required this.color,
    required this.phase,
    required this.phaseProgress,
  });
  final double breathT, fxT;
  final Color color;
  final BreathPhase phase;
  final double phaseProgress;

  @override
  void paint(Canvas canvas, Size size) {
    final centerY = size.height / 2;
    final w = size.width;

    // 3 dalga katmanı — exhale'de yükseliyor (uzun nefes verme vurgusu)
    final waveHeight = switch (phase) {
      BreathPhase.inhale => 4.0 + 8.0 * phaseProgress,
      BreathPhase.holdIn => 12.0,
      BreathPhase.exhale => 12.0 + 10.0 * phaseProgress,
      BreathPhase.holdOut => 4.0,
    };

    for (int layer = 0; layer < 3; layer++) {
      final layerOffset = layer * 4.0;
      final speed = 1.0 + layer * 0.5;
      final alpha = 0.12 - layer * 0.03;

      final wavePath = Path();
      wavePath.moveTo(0, centerY + layerOffset);

      for (double x = 0; x <= w; x += 2) {
        final normalX = x / w;
        final y = centerY + layerOffset +
            waveHeight * math.sin(normalX * 2 * math.pi * 2 + fxT * speed * 2 * math.pi) +
            (waveHeight * 0.5) * math.sin(normalX * 2 * math.pi * 3 + fxT * speed * 2 * math.pi * 1.5);
        wavePath.lineTo(x, y);
      }

      wavePath.lineTo(w, size.height);
      wavePath.lineTo(0, size.height);
      wavePath.close();

      final wavePaint = Paint()
        ..color = color.withValues(alpha: alpha)
        ..style = PaintingStyle.fill;

      // Daire clip — dalgalar dairenin içinde
      canvas.save();
      final clipPath = Path()
        ..addOval(Rect.fromCenter(
          center: Offset(size.width / 2, size.height / 2),
          width: size.width - 20,
          height: size.height - 20,
        ));
      canvas.clipPath(clipPath);
      canvas.drawPath(wavePath, wavePaint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_OceanWavePainter old) => true;
}

// ═══════════════════════════════════════════
// Progress Arc (shared across all patterns)
// ═══════════════════════════════════════════

class _ProgressArcPainter extends CustomPainter {
  _ProgressArcPainter({
    required this.progress,
    required this.color,
    required this.bgOpacity,
  });

  final double progress;
  final Color color;
  final double bgOpacity;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final bgPaint = Paint()
      ..color = Colors.white.withValues(alpha: bgOpacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, bgPaint);

    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(_ProgressArcPainter old) =>
      old.progress != progress || old.color != color;
}
