import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme.dart';
import '../../config/design_tokens.dart';
import '../../l10n/app_localizations.dart';
import '../../services/haptic_service.dart';
import '../../models/app_usage_entry.dart';
import '../../models/screen_time_data.dart';
import '../../providers/analytics_provider.dart';
import '../../providers/screen_time_provider.dart' show screenTimeProvider;
import '../../widgets/app_icon_widget.dart';
import '../../widgets/premium_background.dart';

class AnalyticsScreen extends ConsumerStatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  ConsumerState<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends ConsumerState<AnalyticsScreen> {
  int _selectedDayIndex = 6; // today = last item

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final week = ref.watch(screenTimeProvider);
    final todayIcons = ref.watch(todayWithIconsProvider);
    final categories = ref.watch(categoryBreakdownProvider);

    final selectedDay = week[_selectedDayIndex.clamp(0, week.length - 1)];

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: PremiumBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(Icons.arrow_back_rounded, color: AppColors.textPrimary),
                    ),
                    const SizedBox(width: 12),
                    Text(l.analytics, style: AppType.h1),
                    const Spacer(),
                    // Neon badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.neonGreen, Color(0xFF00C9DB)],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'PRO',
                        style: AppType.label.copyWith(fontSize: 10, color: Colors.black),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Detaylı Analiz butonu (Apple Screen Time)
                GestureDetector(
                  onTap: () {
                    HapticService.light();
                    context.push('/profile/stats/detailed');
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      gradient: LinearGradient(
                        colors: [
                          AppColors.neonGreen.withValues(alpha: 0.12),
                          AppColors.neonGreen.withValues(alpha: 0.04),
                        ],
                      ),
                      border: Border.all(color: AppColors.neonGreen.withValues(alpha: 0.25)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.insights_rounded, color: AppColors.neonGreen, size: 20),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            l.detailedScreenTime,
                            style: AppType.body.copyWith(fontWeight: FontWeight.w600, color: AppColors.neonGreen),
                          ),
                        ),
                        Text(
                          'Apple tarzı',
                          style: AppType.caption.copyWith(fontSize: 11, color: AppColors.textTertiary),
                        ),
                        const SizedBox(width: 4),
                        Icon(Icons.chevron_right_rounded, color: AppColors.neonGreen.withValues(alpha: 0.6), size: 20),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // ═══════════════════════════════════════
                // WEEKLY BAR CHART — Kategorize, neon
                // ═══════════════════════════════════════
                _WeeklyBarChart(
                  weekData: week,
                  selectedIndex: _selectedDayIndex,
                  onBarTap: (i) => setState(() => _selectedDayIndex = i),
                ),
                const SizedBox(height: 24),

                // ═══════════════════════════════════════
                // CATEGORY BREAKDOWN — Radial gradient kartlar
                // ═══════════════════════════════════════
                Text(l.categories.toUpperCase(), style: AppType.label),
                const SizedBox(height: 12),
                _CategoryGrid(categories: categories, totalMinutes: selectedDay.totalMinutes),
                const SizedBox(height: 24),

                // ═══════════════════════════════════════
                // PICKUPS CARD — Glassmorphism hero
                // ═══════════════════════════════════════
                _PickupsHeroCard(
                  totalPickups: selectedDay.phoneOpens,
                  topPickupApps: _topPickupApps(selectedDay),
                ),
                const SizedBox(height: 24),

                // ═══════════════════════════════════════
                // APP USAGE LIST — Native ikonlarla
                // ═══════════════════════════════════════
                Text(l.appDetails.toUpperCase(), style: AppType.label),
                const SizedBox(height: 12),

                // iOS: Platform View | Android: Native icon list
                if (!kIsWeb && Platform.isIOS)
                  const IOSScreenTimeReportView(daysAgo: 0, height: 400)
                else
                  todayIcons.when(
                    data: (data) => _AppListWithIcons(apps: data.appUsage),
                    loading: () => const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32),
                        child: CircularProgressIndicator(color: AppColors.neonGreen),
                      ),
                    ),
                    error: (_, __) => _AppListWithIcons(apps: selectedDay.appUsage),
                  ),

                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<AppUsageEntry> _topPickupApps(ScreenTimeData day) {
    final sorted = List<AppUsageEntry>.from(day.apps)
      ..sort((a, b) => b.pickups.compareTo(a.pickups));
    return sorted.take(3).where((a) => a.pickups > 0).toList();
  }
}

// ═══════════════════════════════════════════════════
// WEEKLY BAR CHART
// ═══════════════════════════════════════════════════

class _WeeklyBarChart extends StatelessWidget {
  const _WeeklyBarChart({
    required this.weekData,
    required this.selectedIndex,
    required this.onBarTap,
  });

  final List<ScreenTimeData> weekData;
  final int selectedIndex;
  final void Function(int) onBarTap;

  @override
  Widget build(BuildContext context) {
    final maxMin = weekData.fold(0, (m, d) => max(m, d.totalMinutes));
    final goal = weekData.isNotEmpty ? weekData.first.goalMinutes : 180;

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withValues(alpha: 0.07),
                Colors.white.withValues(alpha: 0.02),
              ],
            ),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(AppLocalizations.of(context)!.weeklyUsage.toUpperCase(), style: AppType.label),
                  const Spacer(),
                  Text(
                    _selectedLabel(),
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.neonGreen.withValues(alpha: 0.8),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 200,
                child: BarChart(
                  BarChartData(
                    maxY: (maxMin * 1.2).toDouble(),
                    barTouchData: BarTouchData(
                      touchCallback: (event, response) {
                        if (response?.spot != null && event is FlTapUpEvent) {
                          onBarTap(response!.spot!.touchedBarGroupIndex);
                        }
                      },
                      touchTooltipData: BarTouchTooltipData(
                        getTooltipColor: (_) => AppColors.cardGradientStart.withValues(alpha: 0.9),
                        getTooltipItem: (group, gI, rod, rI) {
                          final d = weekData[group.x];
                          return BarTooltipItem(
                            d.formattedTotal,
                            const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.neonGreen),
                          );
                        },
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      horizontalInterval: goal.toDouble(),
                      getDrawingHorizontalLine: (v) => FlLine(
                        color: AppColors.ringDanger.withValues(alpha: 0.3),
                        strokeWidth: 1,
                        dashArray: [6, 4],
                      ),
                    ),
                    titlesData: FlTitlesData(
                      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 36,
                          getTitlesWidget: (v, _) => Text(
                            '${(v / 60).floor()}s',
                            style: AppType.label,
                          ),
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (v, _) {
                            const days = ['Pzt', 'Sal', 'Çar', 'Per', 'Cum', 'Cmt', 'Paz'];
                            final i = v.toInt();
                            if (i < 0 || i >= weekData.length) return const SizedBox.shrink();
                            final dayOfWeek = weekData[i].date.weekday - 1;
                            return Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                days[dayOfWeek.clamp(0, 6)],
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: i == selectedIndex ? FontWeight.w700 : FontWeight.w400,
                                  color: i == selectedIndex ? AppColors.neonGreen : AppColors.textTertiary,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    barGroups: List.generate(weekData.length, (i) {
                      final d = weekData[i];
                      final isSelected = i == selectedIndex;
                      return BarChartGroupData(
                        x: i,
                        barRods: [
                          BarChartRodData(
                            toY: d.totalMinutes.toDouble(),
                            width: isSelected ? 20 : 14,
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: _barColors(d),
                            ),
                            backDrawRodData: BackgroundBarChartRodData(
                              show: true,
                              toY: maxMin * 1.1,
                              color: Colors.white.withValues(alpha: 0.03),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _selectedLabel() {
    if (selectedIndex < 0 || selectedIndex >= weekData.length) return '';
    final d = weekData[selectedIndex];
    return '${d.formattedTotal} • ${d.phoneOpens} açma';
  }

  List<Color> _barColors(ScreenTimeData d) {
    if (d.totalMinutes <= d.goalMinutes * 0.5) {
      return [AppColors.neonGreen.withValues(alpha: 0.6), AppColors.neonGreen];
    }
    if (d.totalMinutes <= d.goalMinutes) {
      return [const Color(0xFFFFD60A).withValues(alpha: 0.6), const Color(0xFFFFD60A)];
    }
    return [AppColors.ringDanger.withValues(alpha: 0.6), AppColors.ringDanger];
  }
}

// ═══════════════════════════════════════════════════
// CATEGORY GRID — Radial gradient kartlar
// ═══════════════════════════════════════════════════

class _CategoryGrid extends StatelessWidget {
  const _CategoryGrid({required this.categories, required this.totalMinutes});

  final Map<String, int> categories;
  final int totalMinutes;

  @override
  Widget build(BuildContext context) {
    final sorted = categories.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: sorted.map((entry) {
        final color = Color(categoryColors[entry.key] ?? 0xFF8E8E93);
        final label = categoryLabels[entry.key] ?? entry.key;
        final pct = totalMinutes > 0 ? (entry.value / totalMinutes * 100).round() : 0;
        final h = entry.value ~/ 60;
        final m = entry.value % 60;
        final timeStr = h > 0 ? '${h}s ${m}dk' : '${m}dk';

        return Container(
          width: (MediaQuery.of(context).size.width - 42) / 2,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: RadialGradient(
              center: Alignment.topLeft,
              radius: 2.5,
              colors: [
                color.withValues(alpha: 0.15),
                AppColors.cardGradientEnd,
              ],
            ),
            border: Border.all(color: color.withValues(alpha: 0.2)),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.08),
                blurRadius: 12,
                spreadRadius: -4,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: color.withValues(alpha: 0.5), blurRadius: 6)],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: color)),
                  const Spacer(),
                  Text('%$pct', style: TextStyle(fontSize: 11, color: color.withValues(alpha: 0.7))),
                ],
              ),
              const SizedBox(height: 8),
              Text(timeStr, style: AppType.mono.copyWith(fontSize: 20, fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              // Mini progress bar
              Container(
                height: 3,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: totalMinutes > 0 ? (entry.value / totalMinutes).clamp(0.0, 1.0) : 0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [color.withValues(alpha: 0.5), color]),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

// ═══════════════════════════════════════════════════
// PICKUPS HERO CARD — Glassmorphism + neon glow
// ═══════════════════════════════════════════════════

class _PickupsHeroCard extends StatelessWidget {
  const _PickupsHeroCard({
    required this.totalPickups,
    required this.topPickupApps,
  });

  final int totalPickups;
  final List<AppUsageEntry> topPickupApps;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withValues(alpha: 0.1),
                Colors.white.withValues(alpha: 0.03),
              ],
            ),
            border: Border.all(color: Colors.white.withValues(alpha: 0.12), width: 1),
            boxShadow: [
              BoxShadow(
                color: AppColors.neonOrange.withValues(alpha: 0.08),
                blurRadius: 32,
                spreadRadius: -8,
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.4),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            children: [
              // Pickup icon with glow ring
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.neonOrange.withValues(alpha: 0.2),
                      AppColors.neonOrange.withValues(alpha: 0.02),
                    ],
                  ),
                  border: Border.all(color: AppColors.neonOrange.withValues(alpha: 0.3)),
                  boxShadow: [
                    BoxShadow(color: AppColors.neonOrange.withValues(alpha: 0.15), blurRadius: 24, spreadRadius: -4),
                  ],
                ),
                child: const Center(
                  child: Icon(Icons.phone_android_rounded, color: AppColors.neonOrange, size: 32),
                ),
              ),
              const SizedBox(height: 16),
              // Big number with glow
              Text(
                '$totalPickups',
                style: AppType.monoDisplay.copyWith(
                  color: AppColors.neonOrange,
                  shadows: [
                    Shadow(color: AppColors.neonOrange.withValues(alpha: 0.5), blurRadius: 20),
                    Shadow(color: AppColors.neonOrange.withValues(alpha: 0.2), blurRadius: 40),
                  ],
                ),
              ),
              Builder(builder: (ctx) => Text(
                AppLocalizations.of(ctx)!.timesPickedUp,
                style: const TextStyle(fontSize: 14, color: AppColors.textSecondary, fontWeight: FontWeight.w500),
              )),
              if (topPickupApps.isNotEmpty) ...[
                const SizedBox(height: 20),
                Container(
                  height: 1,
                  color: Colors.white.withValues(alpha: 0.06),
                ),
                const SizedBox(height: 16),
                Builder(builder: (ctx) => Text(
                  AppLocalizations.of(ctx)!.topTriggers,
                  style: const TextStyle(fontSize: 11, color: AppColors.textTertiary, fontWeight: FontWeight.w500, letterSpacing: 1),
                )),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: topPickupApps.map((app) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      children: [
                        AppIconWidget(
                          iconBytes: app.iconBytes,
                          packageName: app.packageName,
                          color: app.iconColor,
                          size: 44,
                          borderRadius: 12,
                          glowIntensity: 0.4,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          app.name,
                          style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '${app.pickups}x',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: app.iconColor,
                          ),
                        ),
                      ],
                    ),
                  )).toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════
// APP LIST WITH NATIVE ICONS — Premium kartlar
// ═══════════════════════════════════════════════════

class _AppListWithIcons extends StatelessWidget {
  const _AppListWithIcons({required this.apps});

  final List<AppUsageEntry> apps;

  @override
  Widget build(BuildContext context) {
    if (apps.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Builder(builder: (ctx) => Text(
            AppLocalizations.of(ctx)!.noDataYet,
            style: const TextStyle(fontSize: 14, color: AppColors.textTertiary),
          )),
        ),
      );
    }

    final maxMin = apps.first.minutes;

    return Column(
      children: apps.take(10).map((app) {
        final ratio = maxMin > 0 ? (app.minutes / maxMin).clamp(0.0, 1.0) : 0.0;

        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.cardGradientStart,
                AppColors.cardGradientEnd,
              ],
            ),
            border: Border.all(color: app.iconColor.withValues(alpha: 0.12)),
            boxShadow: [
              BoxShadow(
                color: app.iconColor.withValues(alpha: 0.06),
                blurRadius: 12,
                spreadRadius: -4,
              ),
            ],
          ),
          child: Row(
            children: [
              // Native icon — rounded + glow + glass
              AppIconWidget(
                iconBytes: app.iconBytes,
                packageName: app.packageName,
                color: app.iconColor,
                size: 42,
                borderRadius: 11,
                glowIntensity: 0.35,
              ),
              const SizedBox(width: 12),

              // Info column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            app.name,
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textPrimary),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          app.formattedDuration,
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: app.iconColor),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    // Progress bar
                    Container(
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: ratio,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [app.iconColor.withValues(alpha: 0.5), app.iconColor],
                            ),
                            borderRadius: BorderRadius.circular(2),
                            boxShadow: [
                              BoxShadow(color: app.iconColor.withValues(alpha: 0.3), blurRadius: 4),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (app.pickups > 0 || app.category != null) ...[
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          if (app.category != null)
                            Text(
                              categoryLabels[app.category] ?? app.category!,
                              style: const TextStyle(fontSize: 10, color: AppColors.textTertiary),
                            ),
                          if (app.pickups > 0) ...[
                            if (app.category != null)
                              Text(' • ', style: TextStyle(fontSize: 10, color: AppColors.textTertiary)),
                            Icon(Icons.touch_app_rounded, size: 10, color: AppColors.textTertiary),
                            const SizedBox(width: 2),
                            Builder(builder: (ctx) => Text(
                              '${app.pickups}x ${AppLocalizations.of(ctx)!.openingCount}',
                              style: const TextStyle(fontSize: 10, color: AppColors.textTertiary),
                            )),
                          ],
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
