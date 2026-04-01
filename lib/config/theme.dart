import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Background (Revolut)
  static const bg = Color(0xFF0A0A0A);
  static const bgDeepCenter = Color(0xFF0D0D1A); // koyu lacivert merkez
  static const bgDeepEdge = Color(0xFF0A0A0A);   // kenar
  static const cardBg = Color(0xFF1A1A1A);
  static const cardBorder = Color(0xFF2A2A2A);
  static const surface = Color(0xFF141414);

  // Premium gradients
  static const cardGradientStart = Color(0xFF1C1C2E); // koyu lacivert
  static const cardGradientEnd = Color(0xFF1A1A1A);   // standart koyu

  // Text
  static const textPrimary = Color(0xFFFFFFFF);
  static const textSecondary = Color(0xFF8E8E93);
  static const textTertiary = Color(0xFF636366);

  // Neon accents (Nike)
  static const neonGreen = Color(0xFF39FF14);
  static const neonOrange = Color(0xFFFF6B00);

  // Screen time rings (Apple Fitness)
  static const ringGood = Color(0xFF30D158);
  static const ringWarning = Color(0xFFFF9F0A);
  static const ringDanger = Color(0xFFFF453A);
  static const ringTrack = Color(0xFF2C2C2E);

  // Social
  static const friendOnline = Color(0xFF30D158);
  static const friendActive = Color(0xFFFF453A);

  // Ranking
  static const gold = Color(0xFFFFD700);
  static const silver = Color(0xFFC0C0C0);
  static const bronze = Color(0xFFCD7F32);

  // Wrapped gradients (Spotify)
  static const wrappedGradient1 = [Color(0xFF667EEA), Color(0xFF764BA2)];
  static const wrappedGradient2 = [Color(0xFFF093FB), Color(0xFFF5576C)];
  static const wrappedGradient3 = [Color(0xFF4FACFE), Color(0xFF00F2FE)];
  static const wrappedGradient4 = [Color(0xFFA8EB12), Color(0xFF39FF14)];
  static const wrappedGradient5 = [Color(0xFFFF6B00), Color(0xFFFFD700)];

  // App icon colors
  static const instagram = Color(0xFFE1306C);
  static const youtube = Color(0xFFFF0000);
  static const tiktok = Color(0xFF69C9D0);
  static const twitter = Color(0xFF1DA1F2);
  static const whatsapp = Color(0xFF25D366);
  static const snapchat = Color(0xFFFFFC00);
  static const telegram = Color(0xFF0088CC);
  static const reddit = Color(0xFFFF4500);
}

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

ThemeData buildAppTheme() => ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.bg,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.neonGreen,
        secondary: AppColors.neonOrange,
        surface: AppColors.surface,
      ),
      useMaterial3: true,
    );
