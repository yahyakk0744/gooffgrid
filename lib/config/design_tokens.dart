import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'theme.dart';

/// Opal-inspired design tokens for gooffgrid v2.
/// Refined dark palette with blue undertones, Plus Jakarta Sans typography,
/// and comprehensive spacing, radius, gradient, shadow and motion system.

class AppRadius {
  AppRadius._();
  static const double xs = 12;
  static const double s = 18;
  static const double m = 24;
  static const double l = 32;
  static const double xl = 40;
  static const double pill = 999;

  static const BorderRadius rXs = BorderRadius.all(Radius.circular(xs));
  static const BorderRadius rS = BorderRadius.all(Radius.circular(s));
  static const BorderRadius rM = BorderRadius.all(Radius.circular(m));
  static const BorderRadius rL = BorderRadius.all(Radius.circular(l));
  static const BorderRadius rXl = BorderRadius.all(Radius.circular(xl));
  static const BorderRadius rPill = BorderRadius.all(Radius.circular(pill));
}

class AppSpacing {
  AppSpacing._();
  static const double s1 = 4;
  static const double s2 = 8;
  static const double s3 = 12;
  static const double s4 = 16;
  static const double s5 = 20;
  static const double s6 = 24;
  static const double s7 = 28;
  static const double s8 = 32;
  static const double s10 = 40;
  static const double s12 = 48;
  static const double s16 = 64;
}

class AppGradients {
  AppGradients._();

  /// Hero card gradient — green tinted glow on dark.
  static const LinearGradient heroGreen = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0F2A14), Color(0xFF080810)],
  );

  /// Hero alt — orange tinted (streaks / gems).
  static const LinearGradient heroOrange = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF2A1508), Color(0xFF080810)],
  );

  /// Subtle card surface with faint glow.
  static const LinearGradient card = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1C1C2E), Color(0xFF12121E)],
  );

  /// Card with top-edge highlight (premium feel).
  static const LinearGradient cardHighlight = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF2A2A3A), Color(0xFF1A1A2A)],
    stops: [0.0, 0.15],
  );

  /// Ambient mesh glow for hero backgrounds (use with AnimationController).
  static const RadialGradient meshGlow = RadialGradient(
    center: Alignment(-0.3, -0.5),
    radius: 1.2,
    colors: [Color(0x1832E810), Color(0x084F8AFF), Color(0x00080810)],
    stops: [0.0, 0.5, 1.0],
  );

  /// Shimmer gradient for skeleton loaders.
  static const LinearGradient shimmer = LinearGradient(
    begin: Alignment(-1.5, 0),
    end: Alignment(1.5, 0),
    colors: [Color(0xFF1A1A2A), Color(0xFF2A2A3A), Color(0xFF1A1A2A)],
  );

  static RadialGradient glow(Color color, {double intensity = 0.25}) =>
      RadialGradient(
        colors: [color.withValues(alpha: intensity), Colors.transparent],
        stops: const [0, 1],
      );
}

class AppMotion {
  AppMotion._();
  static const Duration fast = Duration(milliseconds: 120);
  static const Duration base = Duration(milliseconds: 220);
  static const Duration slow = Duration(milliseconds: 320);
  static const Curve spring = Curves.easeOutBack;
  static const Curve emphasized = Curves.easeInOutCubicEmphasized;
}

/// Consolidated text scale — Plus Jakarta Sans (body) + JetBrains Mono (numbers).
/// Single source of truth; replaces both legacy AppTextStyles and old AppType.
class AppType {
  AppType._();

  static TextStyle display = GoogleFonts.plusJakartaSans(
    fontSize: 56,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
    letterSpacing: -2,
    height: 1.0,
  );

  static TextStyle h1 = GoogleFonts.plusJakartaSans(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -1,
    height: 1.1,
  );

  static TextStyle h2 = GoogleFonts.plusJakartaSans(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
    height: 1.2,
  );

  static TextStyle h3 = GoogleFonts.plusJakartaSans(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: -0.25,
    height: 1.25,
  );

  static TextStyle title = GoogleFonts.plusJakartaSans(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  static TextStyle body = GoogleFonts.plusJakartaSans(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static TextStyle bodySmall = GoogleFonts.plusJakartaSans(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 1.45,
  );

  static TextStyle caption = GoogleFonts.plusJakartaSans(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    height: 1.35,
  );

  static TextStyle label = GoogleFonts.plusJakartaSans(
    fontSize: 11,
    fontWeight: FontWeight.w700,
    color: AppColors.textSecondary,
    letterSpacing: 1.2,
  );

  /// Monospaced — for timers, stat numbers, countdowns.
  static TextStyle mono = GoogleFonts.jetBrainsMono(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  /// Large monospaced hero numbers (timer, big stats).
  static TextStyle monoDisplay = GoogleFonts.jetBrainsMono(
    fontSize: 48,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -1,
    height: 1.0,
  );
}
