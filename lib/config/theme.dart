import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_theme_data.dart';

class AppColors {
  AppColors._();

  // ── Backgrounds (blue-shifted dark for depth) ──
  static const bg = Color(0xFF080810);
  static const bgDeepCenter = Color(0xFF0A0A1A);
  static const bgDeepEdge = Color(0xFF080810);
  static const surface = Color(0xFF12121E);
  static const cardBg = Color(0xFF1A1A2A);
  static const cardBgElevated = Color(0xFF222236);
  static const cardBorder = Color(0xFF2A2A3A);
  static const divider = Color(0xFF1E1E2E);

  // Premium gradients
  static const cardGradientStart = Color(0xFF1C1C2E);
  static const cardGradientEnd = Color(0xFF1A1A2A);

  // ── Text (warm-white with blue tint) ──
  static const textPrimary = Color(0xFFF5F5FF);
  static const textSecondary = Color(0xFF8B8BA0);
  static const textTertiary = Color(0xFF5A5A70);

  // ── Primary accents (refined neon) ──
  static const neonGreen = Color(0xFF32E810);
  static const neonOrange = Color(0xFFFF7A1A);
  static const primaryMuted = Color(0xFF1A3A14);
  static const secondaryMuted = Color(0xFF2A1A0A);

  // ── New accent colors ──
  static const accentBlue = Color(0xFF4F8AFF);
  static const accentPurple = Color(0xFFA78BFA);

  // ── Screen time rings (Apple Fitness) ──
  static const ringGood = Color(0xFF30D158);
  static const ringWarning = Color(0xFFFF9F0A);
  static const ringDanger = Color(0xFFFF453A);
  static const ringTrack = Color(0xFF1E1E2E);

  // ── Social ──
  static const friendOnline = Color(0xFF30D158);
  static const friendActive = Color(0xFFFF453A);

  // ── Ranking ──
  static const gold = Color(0xFFFFD700);
  static const silver = Color(0xFFC0C0C0);
  static const bronze = Color(0xFFCD7F32);

  // ── Wrapped gradients (Spotify-inspired) ──
  static const wrappedGradient1 = [Color(0xFF667EEA), Color(0xFF764BA2)];
  static const wrappedGradient2 = [Color(0xFFF093FB), Color(0xFFF5576C)];
  static const wrappedGradient3 = [Color(0xFF4FACFE), Color(0xFF00F2FE)];
  static const wrappedGradient4 = [Color(0xFFA8EB12), Color(0xFF32E810)];
  static const wrappedGradient5 = [Color(0xFFFF7A1A), Color(0xFFFFD700)];

  // ── App icon colors ──
  static const instagram = Color(0xFFE1306C);
  static const youtube = Color(0xFFFF0000);
  static const tiktok = Color(0xFF69C9D0);
  static const twitter = Color(0xFF1DA1F2);
  static const whatsapp = Color(0xFF25D366);
  static const snapchat = Color(0xFFFFFC00);
  static const telegram = Color(0xFF0088CC);
  static const reddit = Color(0xFFFF4500);
}

/// Legacy text styles — use [AppType] from design_tokens.dart instead.
@Deprecated('Use AppType from design_tokens.dart')
class AppTextStyles {
  AppTextStyles._();

  static const heroNumber = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -1,
  );

  static const h1 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const h2 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const h3 = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  static const body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static const bodySecondary = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static const label = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    letterSpacing: 0.5,
  );

  static const labelSmall = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: AppColors.textTertiary,
  );

  static const wrappedHero = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.w800,
    color: Colors.white,
    letterSpacing: -2,
  );

  static const wrappedSub = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: Colors.white70,
  );
}

ThemeData buildAppTheme([GoOffGridTheme? theme]) {
  final baseText = GoogleFonts.plusJakartaSansTextTheme(
    ThemeData.dark().textTheme,
  );

  final t = theme;

  return ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: t?.bg ?? AppColors.bg,
    colorScheme: ColorScheme.dark(
      primary: t?.accent ?? AppColors.neonGreen,
      secondary: t?.accentSecondary ?? AppColors.neonOrange,
      surface: t?.surface ?? AppColors.surface,
    ),
    textTheme: baseText.apply(
      bodyColor: t?.textPrimary ?? AppColors.textPrimary,
      displayColor: t?.textPrimary ?? AppColors.textPrimary,
    ),
    useMaterial3: true,
  );
}
