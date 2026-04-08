import 'dart:ui';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/theme.dart';
import '../providers/floating_timer_provider.dart';

/// YourHour-style draggable floating timer bubble.
///
/// Shows remaining screen time as a mini ring. Tap to expand details.
class FloatingTimerOverlay extends ConsumerStatefulWidget {
  const FloatingTimerOverlay({super.key});

  @override
  ConsumerState<FloatingTimerOverlay> createState() =>
      _FloatingTimerOverlayState();
}

class _FloatingTimerOverlayState extends ConsumerState<FloatingTimerOverlay>
    with SingleTickerProviderStateMixin {
  // Position
  double _dx = 0;
  double _dy = 0;
  bool _positioned = false;

  // Expand / collapse
  bool _expanded = false;

  // Pulse animation for red zone
  late final AnimationController _pulseCtrl;
  late final Animation<double> _pulseAnim;

  static const double _bubbleSize = 50;
  static const double _expandedWidth = 240;
  static const double _expandedHeight = 260;

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _pulseAnim = Tween(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    super.dispose();
  }

  void _initPosition(Size screen) {
    if (!_positioned) {
      _dx = screen.width - _bubbleSize - 16;
      _dy = screen.height - _bubbleSize - 140;
      _positioned = true;
    }
  }

  void _snapToEdge(Size screen) {
    final center = _dx + _bubbleSize / 2;
    setState(() {
      _dx = center < screen.width / 2 ? 8 : screen.width - _bubbleSize - 8;
    });
  }

  String _formatRemaining(int minutes) {
    final h = minutes ~/ 60;
    final m = minutes % 60;
    if (h > 0 && m > 0) return '${h}h ${m}m';
    if (h > 0) return '${h}h';
    return '${m}m';
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    _initPosition(screen);

    final pct = ref.watch(usagePercentProvider);
    final remaining = ref.watch(remainingMinutesProvider);
    final statusColor = ref.watch(timerStatusColorProvider);
    final topApps = ref.watch(topAppsProvider);
    final isRed = pct > 0.8;

    // Control pulse animation
    if (isRed && !_pulseCtrl.isAnimating) {
      _pulseCtrl.repeat(reverse: true);
    } else if (!isRed && _pulseCtrl.isAnimating) {
      _pulseCtrl.stop();
      _pulseCtrl.value = 0;
    }

    return Positioned(
      left: _dx,
      top: _dy,
      child: GestureDetector(
        onPanUpdate: (d) {
          setState(() {
            _dx = (_dx + d.delta.dx).clamp(0, screen.width - _bubbleSize);
            _dy = (_dy + d.delta.dy).clamp(0, screen.height - _bubbleSize);
          });
        },
        onPanEnd: (_) => _snapToEdge(screen),
        onTap: () => setState(() => _expanded = !_expanded),
        child: AnimatedBuilder(
          animation: _pulseAnim,
          builder: (context, child) {
            final scale = isRed ? _pulseAnim.value : 1.0;
            return Transform.scale(scale: scale, child: child);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            width: _expanded ? _expandedWidth : _bubbleSize,
            height: _expanded ? _expandedHeight : _bubbleSize,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(_expanded ? 20 : _bubbleSize / 2),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.bg.withValues(alpha: 0.85),
                    borderRadius: BorderRadius.circular(_expanded ? 20 : _bubbleSize / 2),
                    border: Border.all(
                      color: statusColor.withValues(alpha: 0.5),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: statusColor.withValues(alpha: 0.3),
                        blurRadius: 12,
                        spreadRadius: -2,
                      ),
                    ],
                  ),
                  child: _expanded
                      ? _ExpandedContent(
                          pct: pct,
                          remaining: remaining,
                          statusColor: statusColor,
                          topApps: topApps,
                          formatRemaining: _formatRemaining,
                          onClose: () => setState(() => _expanded = false),
                          onFocus: () {
                            setState(() => _expanded = false);
                            // Navigate to breathing / focus mode
                            Navigator.of(context).pushNamed('/breathing');
                          },
                        )
                      : _BubbleContent(
                          pct: pct,
                          remaining: remaining,
                          statusColor: statusColor,
                          formatRemaining: _formatRemaining,
                        ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Collapsed bubble ───────────────────────────

class _BubbleContent extends StatelessWidget {
  const _BubbleContent({
    required this.pct,
    required this.remaining,
    required this.statusColor,
    required this.formatRemaining,
  });

  final double pct;
  final int remaining;
  final Color statusColor;
  final String Function(int) formatRemaining;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 40,
        height: 40,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              size: const Size(40, 40),
              painter: _RingPainter(
                progress: pct,
                color: statusColor,
                trackColor: AppColors.ringTrack,
              ),
            ),
            Text(
              formatRemaining(remaining),
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w700,
                color: statusColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Expanded panel ─────────────────────────────

class _ExpandedContent extends StatelessWidget {
  const _ExpandedContent({
    required this.pct,
    required this.remaining,
    required this.statusColor,
    required this.topApps,
    required this.formatRemaining,
    required this.onClose,
    required this.onFocus,
  });

  final double pct;
  final int remaining;
  final Color statusColor;
  final List<({String name, int minutes, Color color})> topApps;
  final String Function(int) formatRemaining;
  final VoidCallback onClose;
  final VoidCallback onFocus;

  @override
  Widget build(BuildContext context) {
    final maxMin = topApps.isNotEmpty
        ? topApps.map((a) => a.minutes).reduce(math.max)
        : 1;

    return Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            children: [
              SizedBox(
                width: 32,
                height: 32,
                child: CustomPaint(
                  painter: _RingPainter(
                    progress: pct,
                    color: statusColor,
                    trackColor: AppColors.ringTrack,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${formatRemaining(remaining)} left',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: statusColor,
                      ),
                    ),
                    Text(
                      '${(pct * 100).round()}% used',
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: onClose,
                child: Icon(
                  Icons.close_rounded,
                  size: 18,
                  color: AppColors.textTertiary,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Mini bar chart
          if (topApps.isNotEmpty) ...[
            Text(
              'Top Apps',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: AppColors.textTertiary,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 8),
            ...topApps.map((app) {
              final fraction = (app.minutes / maxMin).clamp(0.0, 1.0);
              return Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  children: [
                    SizedBox(
                      width: 50,
                      child: Text(
                        app.name,
                        style: const TextStyle(
                          fontSize: 10,
                          color: AppColors.textSecondary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Container(
                        height: 6,
                        decoration: BoxDecoration(
                          color: AppColors.ringTrack,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: fraction,
                          child: Container(
                            decoration: BoxDecoration(
                              color: app.color,
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${app.minutes}m',
                      style: const TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],

          const Spacer(),

          // Focus button
          GestureDetector(
            onTap: onFocus,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.neonGreen.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.neonGreen.withValues(alpha: 0.3),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.self_improvement_rounded,
                      size: 16, color: AppColors.neonGreen),
                  SizedBox(width: 6),
                  Text(
                    'Focus Mode',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.neonGreen,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Ring painter ───────────────────────────────

class _RingPainter extends CustomPainter {
  _RingPainter({
    required this.progress,
    required this.color,
    required this.trackColor,
  });

  final double progress;
  final Color color;
  final Color trackColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 3;
    const strokeWidth = 3.5;

    // Track
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = trackColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth,
    );

    // Progress arc
    final rect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(
      rect,
      -math.pi / 2,
      2 * math.pi * progress.clamp(0.0, 1.0),
      false,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(covariant _RingPainter old) =>
      old.progress != progress || old.color != color;
}
