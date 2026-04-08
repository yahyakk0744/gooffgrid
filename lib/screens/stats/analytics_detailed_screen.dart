import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme.dart';
import '../../config/design_tokens.dart';
import '../../l10n/app_localizations.dart';
import '../../services/haptic_service.dart';
import '../../widgets/glassmorphic_card.dart';
import '../../widgets/premium_background.dart';

// ═══════════════════════════════════════════════
// DETAILED ANALYTICS
// ═══════════════════════════════════════════════
// Layout: Week/Day toggle → Chart → Total → Apps → Pickups → Notifications

class AnalyticsDetailedScreen extends ConsumerStatefulWidget {
  const AnalyticsDetailedScreen({super.key});

  @override
  ConsumerState<AnalyticsDetailedScreen> createState() =>
      _AnalyticsDetailedScreenState();
}

class _AnalyticsDetailedScreenState
    extends ConsumerState<AnalyticsDetailedScreen> {
  // 0 = Haftalık, 1 = Günlük
  int _viewMode = 1;
  int _selectedDay = 6; // which day selected in weekly view (0=Mon..6=Sun)

  late final List<_DayData> _weekData;

  @override
  void initState() {
    super.initState();
    _weekData = _generateWeekMock();
  }

  _DayData get _currentDay => _weekData[_selectedDay];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: PremiumBackground(
        child: SafeArea(
          child: Column(
            children: [
              // Fixed header
              _buildHeader(context),
              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      _buildSegmentedControl(AppLocalizations.of(context)!),
                      const SizedBox(height: 20),
                      _buildMainChart(),
                      const SizedBox(height: 6),
                      if (_viewMode == 0) _buildWeekDaySelector(),
                      const SizedBox(height: 20),
                      _buildTotalSection(AppLocalizations.of(context)!),
                      const SizedBox(height: 24),
                      _buildSectionHeader(AppLocalizations.of(context)!.mostUsedApps),
                      const SizedBox(height: 8),
                      _buildMostUsedApps(),
                      const SizedBox(height: 28),
                      _buildSectionHeader(AppLocalizations.of(context)!.unlockSection),
                      const SizedBox(height: 8),
                      _buildPickupsSection(AppLocalizations.of(context)!),
                      const SizedBox(height: 28),
                      _buildSectionHeader(AppLocalizations.of(context)!.notifications),
                      const SizedBox(height: 8),
                      _buildNotificationsSection(AppLocalizations.of(context)!),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── HEADER ──
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              HapticService.light();
              context.pop();
            },
            child: Row(
              children: [
                const Icon(Icons.arrow_back_ios_rounded,
                    color: AppColors.neonGreen, size: 18),
                const SizedBox(width: 2),
                Text(AppLocalizations.of(context)!.back,
                    style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.neonGreen,
                        fontWeight: FontWeight.w400)),
              ],
            ),
          ),
          const Spacer(),
          Text(AppLocalizations.of(context)!.screenTime,
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary)),
          const Spacer(),
          const SizedBox(width: 60), // balance
        ],
      ),
    );
  }

  // ── SEGMENTED CONTROL (Haftalık / Günlük) ──
  Widget _buildSegmentedControl(AppLocalizations l) {
    return Container(
      height: 32,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          _segmentButton(l.weekly, 0),
          _segmentButton(l.daily, 1),
        ],
      ),
    );
  }

  Widget _segmentButton(String label, int index) {
    final selected = _viewMode == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          HapticService.selection();
          setState(() => _viewMode = index);
        },
        child: Container(
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: selected ? Colors.white.withValues(alpha: 0.15) : Colors.transparent,
            borderRadius: BorderRadius.circular(7),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                color: selected ? AppColors.textPrimary : AppColors.textTertiary,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ── MAIN CHART ──
  Widget _buildMainChart() {
    if (_viewMode == 0) {
      return _buildWeeklyChart();
    } else {
      return _buildHourlyChart();
    }
  }

  // Weekly: 7 stacked bars (one per day), colored by category
  Widget _buildWeeklyChart() {
    final maxY = _weekData
            .map((d) => d.totalMinutes.toDouble())
            .reduce(max) *
        1.2;

    return SizedBox(
      height: 180,
      child: BarChart(
        BarChartData(
          maxY: maxY.clamp(60, 600),
          barTouchData: BarTouchData(
            touchCallback: (event, response) {
              if (event is FlTapUpEvent && response?.spot != null) {
                HapticService.light();
                setState(() {
                  _selectedDay = response!.spot!.touchedBarGroupIndex;
                });
              }
            },
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (_) =>
                  AppColors.cardGradientStart.withValues(alpha: 0.95),
              getTooltipItem: (group, gI, rod, rI) {
                final d = _weekData[group.x];
                return BarTooltipItem(
                  _formatMinutes(d.totalMinutes),
                  const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary),
                );
              },
            ),
          ),
          borderData: FlBorderData(show: false),
          gridData: const FlGridData(show: false),
          titlesData: FlTitlesData(
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (v, _) {
                  const days = ['Pzt', 'Sal', 'Çar', 'Per', 'Cum', 'Cmt', 'Paz'];
                  final i = v.toInt();
                  if (i < 0 || i > 6) return const SizedBox.shrink();
                  final selected = i == _selectedDay;
                  return Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      days[i],
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight:
                            selected ? FontWeight.w700 : FontWeight.w400,
                        color: selected
                            ? AppColors.neonGreen
                            : AppColors.textTertiary,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          barGroups: List.generate(7, (i) {
            final d = _weekData[i];
            final selected = i == _selectedDay;
            final cats = d.categories;
            final segments = <BarChartRodStackItem>[];
            double cum = 0;
            for (final c in cats) {
              segments.add(BarChartRodStackItem(
                  cum, cum + c.minutes.toDouble(), c.color));
              cum += c.minutes;
            }
            return BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: cum,
                  width: selected ? 24 : 16,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(4)),
                  rodStackItems: segments,
                  color: Colors.transparent,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  // Hourly: 24 stacked bars (one per hour), colored by app
  Widget _buildHourlyChart() {
    final hourly = _currentDay.hourlyApps;
    final maxY = hourly
        .map((h) => h.values.fold<double>(0, (s, v) => s + v))
        .reduce(max) *
        1.2;

    return SizedBox(
      height: 180,
      child: BarChart(
        BarChartData(
          maxY: maxY.clamp(5, 120),
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (_) =>
                  AppColors.cardGradientStart.withValues(alpha: 0.95),
              getTooltipItem: (group, gI, rod, rI) {
                final h = group.x;
                final total = _currentDay.hourlyApps[h]
                    .values
                    .fold<double>(0, (s, v) => s + v);
                return BarTooltipItem(
                  '${h.toString().padLeft(2, '0')}:00 — ${total.round()}dk',
                  const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary),
                );
              },
            ),
          ),
          borderData: FlBorderData(show: false),
          gridData: const FlGridData(show: false),
          titlesData: FlTitlesData(
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (v, _) {
                  final h = v.toInt();
                  if (h % 6 != 0) return const SizedBox.shrink();
                  final label = h == 0
                      ? '12GÖ'
                      : h == 6
                          ? '6ÖÖ'
                          : h == 12
                              ? '12ÖS'
                              : '6ÖS';
                  return Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(label,
                        style: const TextStyle(
                            fontSize: 9, color: AppColors.textTertiary)),
                  );
                },
              ),
            ),
          ),
          barGroups: List.generate(24, (i) {
            final appMins = hourly[i];
            final segments = <BarChartRodStackItem>[];
            double cum = 0;
            for (final entry in appMins.entries) {
              segments.add(BarChartRodStackItem(
                  cum, cum + entry.value, _appColor(entry.key)));
              cum += entry.value;
            }
            return BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: cum == 0 ? 0.2 : cum,
                  width: 8,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(2)),
                  rodStackItems: segments,
                  color: cum == 0 ? Colors.white.withValues(alpha: 0.03) : Colors.transparent,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  // ── WEEK DAY SELECTOR (only in weekly mode) ──
  Widget _buildWeekDaySelector() {
    const days = ['Pzt', 'Sal', 'Çar', 'Per', 'Cum', 'Cmt', 'Paz'];
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(7, (i) {
          final selected = _selectedDay == i;
          return GestureDetector(
            onTap: () {
              HapticService.selection();
              setState(() => _selectedDay = i);
            },
            child: Column(
              children: [
                Text(
                  days[i],
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: selected
                        ? AppColors.neonGreen
                        : AppColors.textTertiary,
                  ),
                ),
                const SizedBox(height: 4),
                if (selected)
                  Container(
                    width: 5,
                    height: 5,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.neonGreen,
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }

  // ── TOTAL SECTION ──
  Widget _buildTotalSection(AppLocalizations l) {
    final d = _currentDay;
    final h = d.totalMinutes ~/ 60;
    final m = d.totalMinutes % 60;

    // Weekly average
    final weekAvg =
        _weekData.fold<int>(0, (s, dd) => s + dd.totalMinutes) ~/ 7;
    final avgH = weekAvg ~/ 60;
    final avgM = weekAvg % 60;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Total time
        RichText(
          text: TextSpan(children: [
            TextSpan(
              text: '$h',
              style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  height: 1),
            ),
            const TextSpan(
              text: 'sa ',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textSecondary),
            ),
            TextSpan(
              text: '$m',
              style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  height: 1),
            ),
            const TextSpan(
              text: 'dk',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textSecondary),
            ),
          ]),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Text(
              _viewMode == 0 ? l.selectedDayLabel : l.todayLabel,
              style: const TextStyle(
                  fontSize: 12, color: AppColors.textTertiary),
            ),
            const SizedBox(width: 12),
            // Change indicator
            _changeChip(d.changePercent, l),
          ],
        ),
        if (_viewMode == 0) ...[
          const SizedBox(height: 8),
          Text(
            l.weeklyAvgLabel(avgH, avgM),
            style: const TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500),
          ),
        ],
        const SizedBox(height: 12),
        // Category legend (colored dots)
        Wrap(
          spacing: 14,
          runSpacing: 6,
          children: _currentDay.categories.map((c) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: c.color,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 4),
                Text(c.name,
                    style: const TextStyle(
                        fontSize: 11, color: AppColors.textSecondary)),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _changeChip(int percent, [AppLocalizations? l]) {
    final isUp = percent > 0;
    final color = isUp ? AppColors.ringDanger : AppColors.ringGood;
    final suffix = l?.comparedToLastWeek ?? 'geçen haftaya göre';
    return Text(
      '${isUp ? '▲' : '▼'} %${percent.abs()} $suffix',
      style: TextStyle(
          fontSize: 11, fontWeight: FontWeight.w500, color: color),
    );
  }

  // ── SECTION HEADER ──
  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      ),
    );
  }

  // ── MOST USED APPS ──
  Widget _buildMostUsedApps() {
    final apps = _currentDay.apps;
    final maxMin = apps.isEmpty ? 1 : apps.first.minutes;

    return GlassmorphicCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: List.generate(apps.length, (i) {
          final app = apps[i];
          final ratio =
              maxMin > 0 ? (app.minutes / maxMin).clamp(0.0, 1.0) : 0.0;
          return Column(
            children: [
              if (i > 0)
                Divider(
                    color: Colors.white.withValues(alpha: 0.06),
                    height: 1,
                    indent: 60),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    // App icon
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: app.color.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                          child: Text(app.emoji,
                              style: const TextStyle(fontSize: 18))),
                    ),
                    const SizedBox(width: 12),
                    // Name + category + bar
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(app.name,
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textPrimary)),
                          const SizedBox(height: 2),
                          Text(app.category,
                              style: const TextStyle(
                                  fontSize: 11,
                                  color: AppColors.textTertiary)),
                          const SizedBox(height: 6),
                          // Usage bar
                          ClipRRect(
                            borderRadius: BorderRadius.circular(2),
                            child: SizedBox(
                              height: 4,
                              child: LinearProgressIndicator(
                                value: ratio,
                                backgroundColor:
                                    Colors.white.withValues(alpha: 0.05),
                                valueColor:
                                    AlwaysStoppedAnimation(app.color),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Time
                    Text(
                      _formatMinutes(app.minutes),
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  // ── PICKUPS SECTION ──
  Widget _buildPickupsSection(AppLocalizations l) {
    final d = _currentDay;
    return GlassmorphicCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Big number
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('${d.pickups}',
                  style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary)),
              const SizedBox(width: 6),
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(l.timesUnit,
                    style: const TextStyle(
                        fontSize: 15, color: AppColors.textSecondary)),
              ),
              const Spacer(),
              _changeChip(d.pickupChange, l),
            ],
          ),
          const SizedBox(height: 12),
          // Hourly pickup mini chart
          SizedBox(
            height: 60,
            child: BarChart(
              BarChartData(
                maxY: d.hourlyPickups.reduce(max).clamp(1, 100) * 1.2,
                barTouchData: BarTouchData(enabled: false),
                borderData: FlBorderData(show: false),
                gridData: const FlGridData(show: false),
                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (v, _) {
                        final h = v.toInt();
                        if (h != 0 && h != 6 && h != 12 && h != 18) {
                          return const SizedBox.shrink();
                        }
                        return Text('${h}',
                            style: const TextStyle(
                                fontSize: 8, color: AppColors.textTertiary));
                      },
                    ),
                  ),
                ),
                barGroups: List.generate(24, (i) {
                  return BarChartGroupData(
                    x: i,
                    barRods: [
                      BarChartRodData(
                        toY: d.hourlyPickups[i],
                        width: 5,
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(2)),
                        color: AppColors.neonOrange.withValues(alpha: 0.7),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Divider(color: Colors.white.withValues(alpha: 0.06), height: 1),
          const SizedBox(height: 12),
          // First pickup + most opened app
          Row(
            children: [
              Expanded(
                child: Text(l.firstUnlock,
                    style: const TextStyle(
                        fontSize: 13, color: AppColors.textSecondary)),
              ),
              Text(d.firstPickup,
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Text(l.mostOpened,
                    style: const TextStyle(
                        fontSize: 13, color: AppColors.textSecondary)),
              ),
              Text(d.mostPickedApp,
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary)),
            ],
          ),
        ],
      ),
    );
  }

  // ── NOTIFICATIONS SECTION ──
  Widget _buildNotificationsSection(AppLocalizations l) {
    final d = _currentDay;
    return GlassmorphicCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Big number
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('${d.notifications}',
                  style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary)),
              const SizedBox(width: 6),
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(l.notificationUnit,
                    style: const TextStyle(
                        fontSize: 15, color: AppColors.textSecondary)),
              ),
              const Spacer(),
              _changeChip(d.notifChange, l),
            ],
          ),
          const SizedBox(height: 12),
          // Hourly notification mini chart
          SizedBox(
            height: 60,
            child: BarChart(
              BarChartData(
                maxY: d.hourlyNotifs.reduce(max).clamp(1, 100) * 1.2,
                barTouchData: BarTouchData(enabled: false),
                borderData: FlBorderData(show: false),
                gridData: const FlGridData(show: false),
                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (v, _) {
                        final h = v.toInt();
                        if (h != 0 && h != 6 && h != 12 && h != 18) {
                          return const SizedBox.shrink();
                        }
                        return Text('${h}',
                            style: const TextStyle(
                                fontSize: 8, color: AppColors.textTertiary));
                      },
                    ),
                  ),
                ),
                barGroups: List.generate(24, (i) {
                  return BarChartGroupData(
                    x: i,
                    barRods: [
                      BarChartRodData(
                        toY: d.hourlyNotifs[i],
                        width: 5,
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(2)),
                        color: const Color(0xFFAF52DE).withValues(alpha: 0.7),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Divider(color: Colors.white.withValues(alpha: 0.06), height: 1),
          const SizedBox(height: 12),
          // Top notification senders
          ...d.topNotifApps.map((app) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: app.color.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                          child: Text(app.emoji,
                              style: const TextStyle(fontSize: 14))),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(app.name,
                          style: const TextStyle(
                              fontSize: 14, color: AppColors.textPrimary)),
                    ),
                    Text('${app.count} ${l.notificationUnit}',
                        style: const TextStyle(
                            fontSize: 13, color: AppColors.textSecondary)),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  // ── HELPERS ──
  String _formatMinutes(int m) {
    if (m >= 60) {
      final h = m ~/ 60;
      final rem = m % 60;
      return rem > 0 ? '${h}sa ${rem}dk' : '${h}sa';
    }
    return '${m}dk';
  }

  Color _appColor(String app) {
    const map = {
      'Instagram': Color(0xFFE1306C),
      'YouTube': Color(0xFFFF0000),
      'TikTok': Color(0xFF69C9D0),
      'WhatsApp': Color(0xFF25D366),
      'Twitter': Color(0xFF1DA1F2),
      'Spotify': Color(0xFF1DB954),
      'Clash Royale': Color(0xFF8B5CF6),
      'Netflix': Color(0xFFE50914),
    };
    return map[app] ?? const Color(0xFF6B7280);
  }

  // ── MOCK DATA ──
  List<_DayData> _generateWeekMock() {
    final rng = Random(42);
    return List.generate(7, (day) {
      final base = 180 + rng.nextInt(150); // 3-5.5 hours
      final pickups = 35 + rng.nextInt(50);
      final notifs = 50 + rng.nextInt(100);

      final categories = [
        _CategoryData('Sosyal Medya', const Color(0xFFE1306C), (base * 0.35).round()),
        _CategoryData('Eğlence', const Color(0xFFFF0000), (base * 0.22).round()),
        _CategoryData('Oyunlar', const Color(0xFF8B5CF6), (base * 0.15).round()),
        _CategoryData('Mesajlaşma', const Color(0xFF25D366), (base * 0.12).round()),
        _CategoryData('Verimlilik', const Color(0xFF1DA1F2), (base * 0.09).round()),
        _CategoryData('Diğer', const Color(0xFF6B7280), (base * 0.07).round()),
      ];

      final hourlyApps = List.generate(24, (h) {
        final Map<String, double> apps = {};
        double budget;
        if (h < 7) {
          budget = rng.nextDouble() * 3;
        } else if (h < 9) {
          budget = 5 + rng.nextDouble() * 12;
        } else if (h < 12) {
          budget = 8 + rng.nextDouble() * 18;
        } else if (h == 12 || h == 13) {
          budget = 15 + rng.nextDouble() * 25;
        } else if (h < 17) {
          budget = 5 + rng.nextDouble() * 15;
        } else if (h < 21) {
          budget = 15 + rng.nextDouble() * 30;
        } else if (h < 23) {
          budget = 10 + rng.nextDouble() * 20;
        } else {
          budget = rng.nextDouble() * 5;
        }
        if (budget > 2) {
          apps['Instagram'] = budget * (0.25 + rng.nextDouble() * 0.1);
          apps['YouTube'] = budget * (0.15 + rng.nextDouble() * 0.1);
          apps['TikTok'] = budget * (0.1 + rng.nextDouble() * 0.1);
          apps['WhatsApp'] = budget * (0.08 + rng.nextDouble() * 0.05);
          if (rng.nextBool()) {
            apps['Spotify'] = budget * (0.05 + rng.nextDouble() * 0.05);
          }
        }
        return apps;
      });

      final hourlyPickups = List.generate(24, (h) {
        if (h < 7) return rng.nextDouble() * 2;
        if (h < 9) return 2 + rng.nextDouble() * 4;
        if (h < 21) return 1 + rng.nextDouble() * 5;
        return rng.nextDouble() * 2;
      });

      final hourlyNotifs = List.generate(24, (h) {
        if (h < 7) return rng.nextDouble() * 3;
        if (h < 9) return 4 + rng.nextDouble() * 8;
        if (h < 21) return 2 + rng.nextDouble() * 7;
        return rng.nextDouble() * 3;
      });

      final apps = [
        _AppData('Instagram', '📸', const Color(0xFFE1306C), (base * 0.24).round(), 'Sosyal Medya'),
        _AppData('YouTube', '▶️', const Color(0xFFFF0000), (base * 0.18).round(), 'Eğlence'),
        _AppData('TikTok', '🎵', const Color(0xFF69C9D0), (base * 0.14).round(), 'Eğlence'),
        _AppData('WhatsApp', '💬', const Color(0xFF25D366), (base * 0.10).round(), 'Mesajlaşma'),
        _AppData('Twitter', '🐦', const Color(0xFF1DA1F2), (base * 0.08).round(), 'Sosyal Medya'),
        _AppData('Clash Royale', '⚔️', const Color(0xFF8B5CF6), (base * 0.07).round(), 'Oyunlar'),
        _AppData('Netflix', '🎬', const Color(0xFFE50914), (base * 0.06).round(), 'Eğlence'),
        _AppData('Spotify', '🎧', const Color(0xFF1DB954), (base * 0.05).round(), 'Eğlence'),
        _AppData('Telegram', '✈️', const Color(0xFF0088CC), (base * 0.04).round(), 'Mesajlaşma'),
        _AppData('Safari', '🧭', const Color(0xFF0076FF), (base * 0.04).round(), 'Verimlilik'),
      ];

      return _DayData(
        totalMinutes: base,
        changePercent: -20 + rng.nextInt(40),
        pickups: pickups,
        pickupChange: -15 + rng.nextInt(30),
        notifications: notifs,
        notifChange: -10 + rng.nextInt(20),
        firstPickup: '0${6 + rng.nextInt(2)}:${rng.nextInt(5)}${rng.nextInt(10)}',
        mostPickedApp: 'Instagram',
        hourlyApps: hourlyApps,
        hourlyPickups: hourlyPickups,
        hourlyNotifs: hourlyNotifs,
        categories: categories,
        apps: apps,
        topNotifApps: [
          _NotifAppData('Instagram', '📸', const Color(0xFFE1306C), 18 + rng.nextInt(15)),
          _NotifAppData('WhatsApp', '💬', const Color(0xFF25D366), 12 + rng.nextInt(10)),
          _NotifAppData('Twitter', '🐦', const Color(0xFF1DA1F2), 5 + rng.nextInt(8)),
          _NotifAppData('YouTube', '▶️', const Color(0xFFFF0000), 3 + rng.nextInt(5)),
        ],
      );
    });
  }
}

// ── DATA CLASSES ──

class _DayData {
  final int totalMinutes;
  final int changePercent;
  final int pickups;
  final int pickupChange;
  final int notifications;
  final int notifChange;
  final String firstPickup;
  final String mostPickedApp;
  final List<Map<String, double>> hourlyApps;
  final List<double> hourlyPickups;
  final List<double> hourlyNotifs;
  final List<_CategoryData> categories;
  final List<_AppData> apps;
  final List<_NotifAppData> topNotifApps;

  const _DayData({
    required this.totalMinutes,
    required this.changePercent,
    required this.pickups,
    required this.pickupChange,
    required this.notifications,
    required this.notifChange,
    required this.firstPickup,
    required this.mostPickedApp,
    required this.hourlyApps,
    required this.hourlyPickups,
    required this.hourlyNotifs,
    required this.categories,
    required this.apps,
    required this.topNotifApps,
  });
}

class _CategoryData {
  final String name;
  final Color color;
  final int minutes;
  const _CategoryData(this.name, this.color, this.minutes);
}

class _AppData {
  final String name;
  final String emoji;
  final Color color;
  final int minutes;
  final String category;
  const _AppData(this.name, this.emoji, this.color, this.minutes, this.category);
}

class _NotifAppData {
  final String name;
  final String emoji;
  final Color color;
  final int count;
  const _NotifAppData(this.name, this.emoji, this.color, this.count);
}
