import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme.dart';
import '../../providers/subscription_provider.dart';
import '../../services/haptic_service.dart';
import '../../l10n/app_localizations.dart';

class ThemesScreen extends ConsumerWidget {
  const ThemesScreen({super.key});

  static const _themes = [
    _ThemeOption(
      id: 'default',
      name: 'Gece Karanlığı',
      description: 'Varsayılan koyu tema',
      colors: [Color(0xFF0D0D0D), Color(0xFF1A1A2E)],
      accent: AppColors.neonGreen,
      isFree: true,
    ),
    _ThemeOption(
      id: 'ocean',
      name: 'Okyanus Derinliği',
      description: 'Derin mavi tonları',
      colors: [Color(0xFF0A1628), Color(0xFF0D2137)],
      accent: Color(0xFF4FACFE),
      isFree: false,
    ),
    _ThemeOption(
      id: 'aurora',
      name: 'Kuzey Işıkları',
      description: 'Yeşil-mor geçişli',
      colors: [Color(0xFF0D2B1A), Color(0xFF1A0D3B)],
      accent: Color(0xFF00D4AA),
      isFree: false,
    ),
    _ThemeOption(
      id: 'sunset',
      name: 'Gün Batımı',
      description: 'Sıcak turuncu tonlar',
      colors: [Color(0xFF2A1A0D), Color(0xFF1A0D0D)],
      accent: Color(0xFFFF6B00),
      isFree: false,
    ),
    _ThemeOption(
      id: 'lavender',
      name: 'Lavanta Rüyası',
      description: 'Sakinleştirici mor',
      colors: [Color(0xFF1A0D2B), Color(0xFF0D0D1A)],
      accent: Color(0xFFA78BFA),
      isFree: false,
    ),
    _ThemeOption(
      id: 'gold',
      name: 'Altın Saat',
      description: 'Premium altın vurgular',
      colors: [Color(0xFF2A2210), Color(0xFF1A180E)],
      accent: AppColors.gold,
      isFree: false,
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final sub = ref.watch(subscriptionProvider);
    final selectedTheme = sub.selectedTheme;

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: const Icon(Icons.arrow_back_rounded, color: AppColors.textPrimary),
                  ),
                  const SizedBox(width: 12),
                  Text(l.themesTitle, style: AppTextStyles.h1),
                  const Spacer(),
                  if (!sub.isProPlus)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.gold.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.gold.withValues(alpha: 0.3)),
                      ),
                      child: const Text('Pro+', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.gold)),
                    ),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.85,
                ),
                itemCount: _themes.length,
                itemBuilder: (_, i) {
                  final theme = _themes[i];
                  final isSelected = theme.id == selectedTheme;
                  final isLocked = !theme.isFree && !sub.isProPlus;

                  return GestureDetector(
                    onTap: () {
                      if (isLocked) {
                        HapticService.light();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(l.themeLockedMsg)),
                        );
                        return;
                      }
                      HapticService.selection();
                      ref.read(subscriptionProvider.notifier).setTheme(theme.id);
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: theme.colors,
                            ),
                            border: Border.all(
                              color: isSelected ? theme.accent : Colors.white.withValues(alpha: 0.08),
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: Stack(
                            children: [
                              // Accent dot
                              Positioned(
                                top: 16,
                                right: 16,
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: theme.accent,
                                    shape: BoxShape.circle,
                                    boxShadow: [BoxShadow(color: theme.accent.withValues(alpha: 0.4), blurRadius: 8)],
                                  ),
                                ),
                              ),
                              // Lock
                              if (isLocked)
                                Positioned(
                                  top: 16,
                                  left: 16,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withValues(alpha: 0.5),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.lock_rounded, size: 14, color: AppColors.gold),
                                  ),
                                ),
                              // Check
                              if (isSelected)
                                Positioned(
                                  top: 16,
                                  left: 16,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: theme.accent,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.check_rounded, size: 14, color: Colors.black),
                                  ),
                                ),
                              // Info
                              Positioned(
                                bottom: 16,
                                left: 16,
                                right: 16,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      theme.name,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: isLocked ? Colors.white.withValues(alpha: 0.5) : Colors.white,
                                      ),
                                    ),
                                    Text(
                                      theme.description,
                                      style: TextStyle(fontSize: 10, color: Colors.white.withValues(alpha: 0.4)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ThemeOption {
  const _ThemeOption({
    required this.id,
    required this.name,
    required this.description,
    required this.colors,
    required this.accent,
    required this.isFree,
  });

  final String id;
  final String name;
  final String description;
  final List<Color> colors;
  final Color accent;
  final bool isFree;
}
