import 'package:flutter/material.dart';

enum _BreathPhase { inhale, hold, exhale }

class BreathingCircle extends StatefulWidget {
  const BreathingCircle({super.key, this.isActive = false});

  final bool isActive;

  @override
  State<BreathingCircle> createState() => _BreathingCircleState();
}

class _BreathingCircleState extends State<BreathingCircle> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  // Total cycle: 4s inhale + 7s hold + 8s exhale = 19s
  static const _inhaleDuration = 4.0;
  static const _holdDuration = 7.0;
  static const _exhaleDuration = 8.0;
  static const _totalDuration = _inhaleDuration + _holdDuration + _exhaleDuration;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (_totalDuration * 1000).round()),
    );
    if (widget.isActive) _controller.repeat();
  }

  @override
  void didUpdateWidget(BreathingCircle oldWidget) {
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

  _BreathPhase _getPhase(double t) {
    final seconds = t * _totalDuration;
    if (seconds < _inhaleDuration) return _BreathPhase.inhale;
    if (seconds < _inhaleDuration + _holdDuration) return _BreathPhase.hold;
    return _BreathPhase.exhale;
  }

  double _getSize(double t) {
    final seconds = t * _totalDuration;
    const minSize = 200.0;
    const maxSize = 280.0;
    const range = maxSize - minSize;

    if (seconds < _inhaleDuration) {
      // Expand
      final p = seconds / _inhaleDuration;
      return minSize + range * Curves.easeInOut.transform(p);
    } else if (seconds < _inhaleDuration + _holdDuration) {
      // Hold at max
      return maxSize;
    } else {
      // Contract
      final p = (seconds - _inhaleDuration - _holdDuration) / _exhaleDuration;
      return maxSize - range * Curves.easeInOut.transform(p);
    }
  }

  String _getLabel(_BreathPhase phase) {
    switch (phase) {
      case _BreathPhase.inhale: return 'Nefes al...';
      case _BreathPhase.hold: return 'Tut...';
      case _BreathPhase.exhale: return 'Nefes ver...';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final t = _controller.value;
        final size = widget.isActive ? _getSize(t) : 200.0;
        final phase = _getPhase(t);
        final opacity = widget.isActive ? 0.6 + 0.4 * (size - 200) / 80 : 0.4;

        return SizedBox(
          width: 280,
          height: 280,
          child: Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 50),
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF1A1A6E).withValues(alpha: opacity),
                    const Color(0xFF3D1A6E).withValues(alpha: opacity * 0.6),
                  ],
                ),
              ),
              child: Center(
                child: Text(
                  widget.isActive ? _getLabel(phase) : 'Başla',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

