import 'package:flutter/material.dart';

class NotificationBadge extends StatelessWidget {
  const NotificationBadge({
    super.key,
    required this.count,
    this.color = const Color(0xFFFF453A),
    this.child,
  });

  final int count;
  final Color color;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    if (count <= 0 && child != null) return child!;

    final badge = Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
      constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(9)),
      child: Center(
        child: Text(
          count > 99 ? '99+' : '$count',
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
    );

    if (child == null) return badge;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        child!,
        if (count > 0)
          Positioned(
            right: -6,
            top: -4,
            child: badge,
          ),
      ],
    );
  }
}
