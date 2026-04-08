import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import '../../config/theme.dart';
import '../../widgets/glassmorphic_card.dart';
import '../../widgets/premium_background.dart';
import '../../services/haptic_service.dart';
import '../../providers/screen_time_provider.dart';
import '../../providers/user_provider.dart';
import '../../providers/ranking_provider.dart';
import '../../providers/o2_provider.dart';
import '../../l10n/app_localizations.dart';

class ReportCardScreen extends ConsumerWidget {
  const ReportCardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final st = ref.watch(todayScreenTimeProvider);
    final weekTotal = ref.watch(weekTotalProvider);
    final user = ref.watch(userProvider);
    final friendRank = ref.watch(userFriendRankProvider);
    final cityRank = ref.watch(userCityRankProvider);
    final o2 = ref.watch(o2Provider);
    final cardKey = GlobalKey();

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: PremiumBackground(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 16),
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        HapticService.light();
                        Navigator.of(context).pop();
                      },
                      child: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textSecondary, size: 20),
                    ),
                    const Spacer(),
                    Text(l.shareReportCard, style: AppTextStyles.h1),
                    const Spacer(),
                    const SizedBox(width: 20),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Shareable card
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: RepaintBoundary(
                    key: cardKey,
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF0F0F2A),
                            Color(0xFF1A0A2E),
                            Color(0xFF0A0A14),
                          ],
                        ),
                        border: Border.all(
                          width: 1.5,
                          color: AppColors.neonGreen.withValues(alpha: 0.25),
                        ),
                        boxShadow: [
                          BoxShadow(color: AppColors.neonGreen.withValues(alpha: 0.08), blurRadius: 40, spreadRadius: -8),
                          BoxShadow(color: Colors.black.withValues(alpha: 0.5), blurRadius: 20),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Branding
                          const Text(
                            'gooffgrid',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textTertiary,
                              letterSpacing: 3,
                            ),
                          ),
                          const SizedBox(height: 4),
                          ShaderMask(
                            shaderCallback: (bounds) => LinearGradient(
                              colors: [AppColors.neonGreen, AppColors.neonGreen.withValues(alpha: 0.6)],
                            ).createShader(bounds),
                            child: Text(
                              l.weeklyReport,
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white, letterSpacing: 1),
                            ),
                          ),
                          const SizedBox(height: 28),

                          // Week total hero
                          Text(weekTotal, style: AppTextStyles.wrappedHero.copyWith(
                            fontSize: 52,
                            shadows: [Shadow(color: AppColors.neonGreen.withValues(alpha: 0.3), blurRadius: 20)],
                          )),
                          const SizedBox(height: 4),
                          Text(l.screenTimeLower, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.ringGood.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: AppColors.ringGood.withValues(alpha: 0.25)),
                            ),
                            child: Text(
                              l.improvedFromLastWeek,
                              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: AppColors.ringGood),
                            ),
                          ),
                          const SizedBox(height: 28),

                          // Stats grid
                          Row(
                            children: [
                              Expanded(child: _StatBox(
                                label: l.o2Earned,
                                value: '${o2.todayEarned * 7}',
                                icon: Icons.eco_rounded,
                                color: AppColors.neonGreen,
                              )),
                              const SizedBox(width: 12),
                              Expanded(child: _StatBox(
                                label: l.streak,
                                value: l.streakDays(user.streak),
                                icon: Icons.local_fire_department_rounded,
                                color: AppColors.neonOrange,
                              )),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(child: _StatBox(
                                label: l.friendRank,
                                value: '#$friendRank',
                                icon: Icons.people_rounded,
                                color: AppColors.wrappedGradient3[0],
                              )),
                              const SizedBox(width: 12),
                              Expanded(child: _StatBox(
                                label: l.cityRankLabel(user.city),
                                value: '#$cityRank',
                                icon: Icons.location_city_rounded,
                                color: AppColors.wrappedGradient1[0],
                              )),
                            ],
                          ),
                          const SizedBox(height: 28),

                          // Top app
                          if (st.appUsage.isNotEmpty) ...[
                            GlassmorphicCard(
                              opacity: 0.05,
                              borderOpacity: 0.1,
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              child: Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: st.appUsage.first.iconColor.withValues(alpha: 0.2),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Icon(Icons.apps_rounded, color: st.appUsage.first.iconColor, size: 20),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(l.mostUsed, style: const TextStyle(fontSize: 10, color: AppColors.textTertiary)),
                                        Text(st.appUsage.first.name, style: AppTextStyles.h3),
                                      ],
                                    ),
                                  ),
                                  Text(st.appUsage.first.formattedDuration, style: const TextStyle(fontSize: 14, color: AppColors.textSecondary)),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],

                          // Footer branding
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: AppColors.neonGreen,
                                  shape: BoxShape.circle,
                                  boxShadow: [BoxShadow(color: AppColors.neonGreen.withValues(alpha: 0.5), blurRadius: 6)],
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'gooffgrid.app',
                                style: TextStyle(fontSize: 11, color: AppColors.textTertiary, letterSpacing: 1),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Share button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GestureDetector(
                  onTap: () async {
                    await HapticService.success();
                    await _captureAndShare(cardKey, context);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: AppColors.neonGreen,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(color: AppColors.neonGreen.withValues(alpha: 0.3), blurRadius: 16, offset: const Offset(0, 4)),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.share_rounded, color: Colors.black, size: 20),
                        const SizedBox(width: 10),
                        Text(
                          l.shareReportCard,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black, letterSpacing: 0.5),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _captureAndShare(GlobalKey key, BuildContext context) async {
    final l = AppLocalizations.of(context)!;
    try {
      final boundary = key.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) return;

      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) return;

      final pngBytes = byteData.buffer.asUint8List();

      await Share.shareXFiles(
        [XFile.fromData(pngBytes, mimeType: 'image/png', name: 'gooffgrid-havami-at.png')],
        text: 'Bu hafta ekran s\u00fcremi d\u00fc\u015f\u00fcrd\u00fcm! #gooffgrid',
      );
    } catch (e) {
      debugPrint('Share error: $e');
    }
  }
}

class _StatBox extends StatelessWidget {
  const _StatBox({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: color.withValues(alpha: 0.06),
        border: Border.all(color: color.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 18,
            shadows: [Shadow(color: color.withValues(alpha: 0.5), blurRadius: 8)],
          ),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(fontSize: 10, color: AppColors.textTertiary)),
        ],
      ),
    );
  }
}
