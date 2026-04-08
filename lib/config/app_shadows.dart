import 'package:flutter/material.dart';

/// Shadow & elevation tokens for consistent depth across the app.
class AppShadow {
  AppShadow._();

  static const List<BoxShadow> none = [];

  static const List<BoxShadow> sm = [
    BoxShadow(
      color: Color(0x20000000),
      blurRadius: 4,
      offset: Offset(0, 2),
    ),
  ];

  static const List<BoxShadow> md = [
    BoxShadow(
      color: Color(0x30000000),
      blurRadius: 12,
      offset: Offset(0, 4),
    ),
  ];

  static const List<BoxShadow> lg = [
    BoxShadow(
      color: Color(0x40000000),
      blurRadius: 24,
      offset: Offset(0, 8),
    ),
  ];

  /// Colored glow — for accent highlights behind cards, rings, CTAs.
  static List<BoxShadow> glow(Color color, {double intensity = 0.3, double blur = 16}) => [
    BoxShadow(
      color: color.withValues(alpha: intensity),
      blurRadius: blur,
      spreadRadius: 0,
    ),
  ];

  /// Subtle inner glow for premium card top edge.
  static List<BoxShadow> innerGlow(Color color, {double intensity = 0.15}) => [
    BoxShadow(
      color: color.withValues(alpha: intensity),
      blurRadius: 8,
      offset: const Offset(0, 1),
      blurStyle: BlurStyle.inner,
    ),
  ];
}
