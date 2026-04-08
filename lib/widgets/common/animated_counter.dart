import 'package:flutter/material.dart';
import '../../config/design_tokens.dart';

/// Smoothly animates between numeric values with count-up/down effect.
/// Tracks previous value so transitions always animate from old → new.
/// Uses JetBrains Mono ([AppType.mono]) by default for tabular alignment.
class AnimatedCounter extends StatefulWidget {
  final int value;
  final TextStyle? style;
  final String? prefix;
  final String? suffix;
  final Duration duration;
  final Curve curve;

  const AnimatedCounter({
    super.key,
    required this.value,
    this.style,
    this.prefix,
    this.suffix,
    this.duration = const Duration(milliseconds: 600),
    this.curve = Curves.easeOutCubic,
  });

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;
  int _previousValue = 0;

  @override
  void initState() {
    super.initState();
    _previousValue = widget.value;
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = AlwaysStoppedAnimation(widget.value);
  }

  @override
  void didUpdateWidget(AnimatedCounter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _previousValue = oldWidget.value;
      _controller.duration = widget.duration;
      _animation = IntTween(begin: _previousValue, end: widget.value)
          .animate(CurvedAnimation(parent: _controller, curve: widget.curve));
      _controller
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        final display = '${widget.prefix ?? ''}${_animation.value}${widget.suffix ?? ''}';
        return Text(display, style: widget.style ?? AppType.mono);
      },
    );
  }
}
