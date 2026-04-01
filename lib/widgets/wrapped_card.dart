import 'package:flutter/material.dart';

class WrappedCard extends StatelessWidget {
  const WrappedCard({
    super.key,
    required this.gradient,
    required this.child,
    this.aspectRatio = 9 / 16,
  });

  final List<Color> gradient;
  final Widget child;
  final double aspectRatio;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradient,
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        padding: const EdgeInsets.all(32),
        child: child,
      ),
    );
  }
}
