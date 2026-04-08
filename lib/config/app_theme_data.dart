import 'package:flutter/material.dart';

class GoOffGridTheme {
  const GoOffGridTheme({
    required this.id,
    required this.bg,
    required this.surface,
    required this.cardBg,
    required this.cardBgElevated,
    required this.cardBorder,
    required this.divider,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.accent,
    required this.accentSecondary,
    required this.primaryMuted,
    required this.secondaryMuted,
  });

  final String id;
  final Color bg;
  final Color surface;
  final Color cardBg;
  final Color cardBgElevated;
  final Color cardBorder;
  final Color divider;
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color accent;
  final Color accentSecondary;
  final Color primaryMuted;
  final Color secondaryMuted;

  // ── Presets ──

  static const defaultTheme = GoOffGridTheme(
    id: 'default',
    bg: Color(0xFF080810),
    surface: Color(0xFF12121E),
    cardBg: Color(0xFF1A1A2A),
    cardBgElevated: Color(0xFF222236),
    cardBorder: Color(0xFF2A2A3A),
    divider: Color(0xFF1E1E2E),
    textPrimary: Color(0xFFF5F5FF),
    textSecondary: Color(0xFF8B8BA0),
    textTertiary: Color(0xFF5A5A70),
    accent: Color(0xFF32E810),
    accentSecondary: Color(0xFFFF7A1A),
    primaryMuted: Color(0xFF1A3A14),
    secondaryMuted: Color(0xFF2A1A0A),
  );

  static const ocean = GoOffGridTheme(
    id: 'ocean',
    bg: Color(0xFF0A1628),
    surface: Color(0xFF0F1E34),
    cardBg: Color(0xFF152842),
    cardBgElevated: Color(0xFF1B3250),
    cardBorder: Color(0xFF1E3A5C),
    divider: Color(0xFF122340),
    textPrimary: Color(0xFFF0F4FF),
    textSecondary: Color(0xFF7B9CC0),
    textTertiary: Color(0xFF4A6A8A),
    accent: Color(0xFF4FACFE),
    accentSecondary: Color(0xFF00F2FE),
    primaryMuted: Color(0xFF0E2A4A),
    secondaryMuted: Color(0xFF0A2038),
  );

  static const aurora = GoOffGridTheme(
    id: 'aurora',
    bg: Color(0xFF0D1A14),
    surface: Color(0xFF122420),
    cardBg: Color(0xFF1A302A),
    cardBgElevated: Color(0xFF223C34),
    cardBorder: Color(0xFF2A4A40),
    divider: Color(0xFF162B24),
    textPrimary: Color(0xFFF0FFF8),
    textSecondary: Color(0xFF7BAFA0),
    textTertiary: Color(0xFF4A7A6A),
    accent: Color(0xFF00D4AA),
    accentSecondary: Color(0xFFA78BFA),
    primaryMuted: Color(0xFF0A2A20),
    secondaryMuted: Color(0xFF1A0D2A),
  );

  static const sunset = GoOffGridTheme(
    id: 'sunset',
    bg: Color(0xFF1A0D08),
    surface: Color(0xFF241510),
    cardBg: Color(0xFF301E18),
    cardBgElevated: Color(0xFF3A2820),
    cardBorder: Color(0xFF4A3228),
    divider: Color(0xFF281810),
    textPrimary: Color(0xFFFFF5F0),
    textSecondary: Color(0xFFB08A70),
    textTertiary: Color(0xFF7A5A44),
    accent: Color(0xFFFF7A1A),
    accentSecondary: Color(0xFFFFD700),
    primaryMuted: Color(0xFF2A1808),
    secondaryMuted: Color(0xFF2A2210),
  );

  static const lavender = GoOffGridTheme(
    id: 'lavender',
    bg: Color(0xFF0D0A1A),
    surface: Color(0xFF141024),
    cardBg: Color(0xFF1C1630),
    cardBgElevated: Color(0xFF241E3C),
    cardBorder: Color(0xFF2E264A),
    divider: Color(0xFF181228),
    textPrimary: Color(0xFFF5F0FF),
    textSecondary: Color(0xFF9A8AC0),
    textTertiary: Color(0xFF6A5A8A),
    accent: Color(0xFFA78BFA),
    accentSecondary: Color(0xFFF093FB),
    primaryMuted: Color(0xFF1A1030),
    secondaryMuted: Color(0xFF2A1040),
  );

  static const gold = GoOffGridTheme(
    id: 'gold',
    bg: Color(0xFF141208),
    surface: Color(0xFF1C1A10),
    cardBg: Color(0xFF26221A),
    cardBgElevated: Color(0xFF302C22),
    cardBorder: Color(0xFF3A362A),
    divider: Color(0xFF201E14),
    textPrimary: Color(0xFFFFF8F0),
    textSecondary: Color(0xFFB0A080),
    textTertiary: Color(0xFF7A7050),
    accent: Color(0xFFFFD700),
    accentSecondary: Color(0xFFFF7A1A),
    primaryMuted: Color(0xFF2A2410),
    secondaryMuted: Color(0xFF2A1A08),
  );

  static const _presets = <String, GoOffGridTheme>{
    'default': defaultTheme,
    'ocean': ocean,
    'aurora': aurora,
    'sunset': sunset,
    'lavender': lavender,
    'gold': gold,
  };

  static GoOffGridTheme fromId(String id) => _presets[id] ?? defaultTheme;
}
