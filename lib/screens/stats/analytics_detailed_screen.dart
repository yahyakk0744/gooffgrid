import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme.dart';
import '../../services/haptic_service.dart';
import '../../widgets/glassmorphic_card.dart';
import '../../widgets/premium_background.dart';

class AnalyticsDetailedScreen extends ConsumerStatefulWidget {
  const AnalyticsDetailedScreen({super.key});

  @override
  ConsumerState<AnalyticsDetailedScreen> createState() =>
      _AnalyticsDetailedScreenState();
}

class _AnalyticsDetailedScreenState
    extends ConsumerState<AnalyticsDetailedScreen> {
  int _selectedDay = 6; // 0=Mon..6=Sun (today)
  int? _touchedBarIndex;

  // Mock 7-day data
  late final List<_DayData> _weekData;
  late final List<_TopAppData> _topApps;

  @override
  void initState() {
    super.initState();
    _weekData = _generateWeekMock();
    _topApps = _mockTopApps();
  }

  _DayData get _today => _weekData[_selectedDay];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: PremiumBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                _buildHeader(),
                const SizedBox(height: 20),
                _buildWeekSelector(),
                const SizedBox(height: 6),
                _buildTotalTime(),
                const SizedBox(height: 16),
                _buildStackedBarChart(),
                const SizedBox(height: 24),
                _buildDailyAverage(),
                const SizedBox(height: 20),
                _buildMostUsedHighlight(),
                const SizedBox(height: 20),
                _buildPickupsSection(),
                const SizedBox(height: 20),
                _buildNotificationsSection(),
                const SizedBox(height: 20),
                _buildAppList(),
                const SizedBox(height: 20),
                _buildCategoryBreakdown(),
                const SizedBox(height: 20),
                _buildFirstLastPickup(),
                const SizedBox(height: 20),
                _buildScreenTimeGoal(),
                const SizedBox(height: 20),
                _buildWhatCouldYouDo(),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── HEADER ──
  Widget _buildHeader() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            HapticService.light();
            context.pop();
          },
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.arrow_back_rounded,
                color: AppColors.textPrimary, size: 20),
          ),
        ),
        const SizedBox(width: 12),
        const Text('Ekran Süresi', style: AppTextStyles.h1),
      ],
    );
  }

  // ── WEEK DAY SELECTOR (Apple style) ──
  Widget _buildWeekSelector() {
    const days = ['Pzt', 'Sal', 'Çar', 'Per', 'Cum', 'Cmt', 'Paz'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(7, (i) {
        final selected = _selectedDay == i;
        return GestureDetector(
          onTap: () {
            HapticService.selection();
            setState(() => _selectedDay = i);
          },
          child: Container(
            width: 42,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: selected
                  ? AppColors.neonGreen.withValues(alpha: 0.15)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: selected
                  ? Border.all(
                      color: AppColors.neonGreen.withValues(alpha: 0.4))
                  : null,
            ),
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
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selected
                        ? AppColors.neonGreen
                        : (i == 6
                            ? AppColors.textTertiary
                            : Colors.transparent),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  // ── TOTAL TIME (big number) ──
  Widget _buildTotalTime() {
    final total = _today.totalMinutes;
    final h = total ~/ 60;
    final m = total % 60;

    return Center(
      child: Column(
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$h',
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                    height: 1.1,
                  ),
                ),
                const TextSpan(
                  text: ' sa ',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textSecondary,
                  ),
                ),
                TextSpan(
                  text: '$m',
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                    height: 1.1,
                  ),
                ),
                const TextSpan(
                  text: ' dk',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          _buildChangeIndicator(
            _today.changePercent,
            isIncrease: _today.changePercent > 0,
          ),
        ],
      ),
    );
  }

  Widget _buildChangeIndicator(int percent, {required bool isIncrease}) {
    final isGood = !isIncrease; // less screen time = good
    final color = isGood ? AppColors.ringGood : AppColors.ringDanger;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        '${isIncrease ? '▲' : '▼'} %${percent.abs()} düne göre',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  // ── STACKED BAR CHART (Apple-style 24h with colored segments per app) ──
  Widget _buildStackedBarChart() {
    final hourly = _today.hourlyApps;
    final maxY = hourly
            .map((h) => h.values.fold<double>(0, (s, v) => s + v))
            .reduce(max) *
        1.2;

    return SizedBox(
      height: 160,
      child: BarChart(
        BarChartData(
          maxY: maxY.clamp(10, 120),
          barTouchData: BarTouchData(
            touchCallback: (event, response) {
              if (event is FlTapUpEvent && response?.spot != null) {
                HapticService.light();
                setState(() {
                  _touchedBarIndex = response!.spot!.touchedBarGroupIndex;
                });
              }
            },
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (_) =>
                  AppColors.cardGradientStart.withValues(alpha: 0.95),
              getTooltipItem: (group, gI, rod, rI) {
                final h = group.x;
                final total = _today.hourlyApps[h]
                    .values
                    .fold<double>(0, (s, v) => s + v);
                return BarTooltipItem(
                  '${h.toString().padLeft(2, '0')}:00\n${total.round()} dk',
                  const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                );
              },
            ),
          ),
          borderData: FlBorderData(show: false),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 30,
            getDrawingHorizontalLine: (v) => FlLine(
              color: Colors.white.withValues(alpha: 0.04),
              strokeWidth: 0.5,
            ),
          ),
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
                  return Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      h == 0
                          ? '12 ÖÖ'
                          : h == 6
                              ? '6 ÖÖ'
                              : h == 12
                                  ? '12 ÖS'
                                  : '6 ÖS',
                      style: const TextStyle(
                          fontSize: 9,
                          color: AppColors.textTertiary,
                          fontWeight: FontWeight.w500),
                    ),
                  );
                },
              ),
            ),
          ),
          barGroups: List.generate(24, (i) {
            final appMins = hourly[i];
            final segments = <BarChartRodStackItem>[];
            double cumulative = 0;
            for (final entry in appMins.entries) {
              final appColor = _appColor(entry.key);
              segments.add(BarChartRodStackItem(
                  cumulative, cumulative + entry.value, appColor));
              cumulative += entry.value;
            }
            return BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: cumulative,
                  width: 7,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(3)),
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

  // ── DAILY AVERAGE ──
  Widget _buildDailyAverage() {
    final avg =
        _weekData.fold<int>(0, (s, d) => s + d.totalMinutes) ~/ _weekData.length;
    final h = avg ~/ 60;
    final m = avg % 60;

    return GlassmorphicCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.neonGreen.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.timeline_rounded,
                color: AppColors.neonGreen, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Günlük Ortalama',
                    style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textTertiary,
                        fontWeight: FontWeight.w500)),
                const SizedBox(height: 2),
                Text('${h}s ${m}dk',
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary)),
              ],
            ),
          ),
          // Mini week sparkline
          SizedBox(
            width: 80,
            height: 32,
            child: CustomPaint(
              painter: _SparklinePainter(
                values: _weekData.map((d) => d.totalMinutes.toDouble()).toList(),
                highlightIndex: _selectedDay,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── MOST USED APP HIGHLIGHT ──
  Widget _buildMostUsedHighlight() {
    final app = _topApps.first;
    return GlassmorphicCard(
      glowColor: app.color,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: app.color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: app.color.withValues(alpha: 0.3)),
            ),
            child:
                Center(child: Text(app.emoji, style: const TextStyle(fontSize: 24))),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('En Çok Kullanılan',
                    style: TextStyle(
                        fontSize: 11,
                        color: AppColors.textTertiary,
                        fontWeight: FontWeight.w500)),
                const SizedBox(height: 2),
                Text(app.name,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: app.color)),
                Text(_formatMinutes(app.minutes),
                    style: const TextStyle(
                        fontSize: 13, color: AppColors.textSecondary)),
              ],
            ),
          ),
          Column(
            children: [
              Text(
                '${(app.minutes / _today.totalMinutes * 100).round()}%',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: app.color),
              ),
              const Text('toplam',
                  style:
                      TextStyle(fontSize: 10, color: AppColors.textTertiary)),
            ],
          ),
        ],
      ),
    );
  }

  // ── PICKUPS ──
  Widget _buildPickupsSection() {
    return _StatSection(
      title: 'Kilit Açma',
      icon: Icons.phone_android_rounded,
      iconColor: AppColors.neonOrange,
      mainValue: '${_today.pickups}',
      mainUnit: 'kez',
      subtitle:
          'Ortalama: her ${(_today.totalMinutes ~/ max(_today.pickups, 1))} dk\'da bir',
      change: _today.pickupChange,
      hourlyData: _today.hourlyPickups,
    );
  }

  // ── NOTIFICATIONS ──
  Widget _buildNotificationsSection() {
    return _StatSection(
      title: 'Bildirimler',
      icon: Icons.notifications_rounded,
      iconColor: const Color(0xFFAF52DE),
      mainValue: '${_today.notifications}',
      mainUnit: 'bildirim',
      subtitle: 'En çok: ${_today.topNotifApp} (${_today.topNotifCount})',
      change: _today.notifChange,
      hourlyData: _today.hourlyNotifs,
    );
  }

  // ── APP LIST (Apple style: icon + name + bar + time) ──
  Widget _buildAppList() {
    final maxMin = _topApps.isEmpty ? 1 : _topApps.first.minutes;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('Uygulamalar', style: AppTextStyles.h3),
            const Spacer(),
            Text('${_topApps.length} uygulama',
                style: const TextStyle(
                    fontSize: 12, color: AppColors.textTertiary)),
          ],
        ),
        const SizedBox(height: 12),
        GlassmorphicCard(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            children: List.generate(_topApps.length, (i) {
              final app = _topApps[i];
              final ratio =
                  maxMin > 0 ? (app.minutes / maxMin).clamp(0.0, 1.0) : 0.0;
              return Column(
                children: [
                  if (i > 0)
                    Divider(
                        color: Colors.white.withValues(alpha: 0.05), height: 1),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: app.color.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(app.emoji,
                                style: const TextStyle(fontSize: 16)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(app.name,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.textPrimary)),
                                  ),
                                  Text(_formatMinutes(app.minutes),
                                      style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.textSecondary)),
                                ],
                              ),
                              const SizedBox(height: 6),
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
                      ],
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }

  // ── CATEGORY BREAKDOWN ──
  Widget _buildCategoryBreakdown() {
    final categories = _today.categories;
    final totalMin = categories.fold<int>(0, (s, c) => s + c.minutes);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Kategoriler', style: AppTextStyles.h3),
        const SizedBox(height: 12),
        GlassmorphicCard(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Stacked horizontal bar
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: SizedBox(
                  height: 10,
                  child: Row(
                    children: categories.map((c) {
                      final ratio = totalMin > 0 ? c.minutes / totalMin : 0.0;
                      return Expanded(
                        flex: (ratio * 1000).round().clamp(1, 1000),
                        child: Container(color: c.color),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ...categories.map((c) {
                final pct =
                    totalMin > 0 ? (c.minutes / totalMin * 100).round() : 0;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: c.color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(c.name,
                            style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textPrimary)),
                      ),
                      Text(_formatMinutes(c.minutes),
                          style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSecondary)),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: 36,
                        child: Text('%$pct',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontSize: 11,
                                color: c.color.withValues(alpha: 0.8))),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  // ── FIRST & LAST PICKUP ──
  Widget _buildFirstLastPickup() {
    return Row(
      children: [
        Expanded(
          child: GlassmorphicCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.wb_sunny_rounded,
                        size: 16,
                        color: AppColors.gold.withValues(alpha: 0.8)),
                    const SizedBox(width: 6),
                    const Text('İlk Açılış',
                        style: TextStyle(
                            fontSize: 11,
                            color: AppColors.textTertiary,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
                const SizedBox(height: 8),
                Text(_today.firstPickup,
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary)),
                Text('uyanınca',
                    style: TextStyle(
                        fontSize: 11, color: AppColors.textTertiary)),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: GlassmorphicCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.nightlight_rounded,
                        size: 16,
                        color: const Color(0xFF5E5CE6).withValues(alpha: 0.8)),
                    const SizedBox(width: 6),
                    const Text('Son Açılış',
                        style: TextStyle(
                            fontSize: 11,
                            color: AppColors.textTertiary,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
                const SizedBox(height: 8),
                Text(_today.lastPickup,
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary)),
                Text('yatmadan önce',
                    style: TextStyle(
                        fontSize: 11, color: AppColors.textTertiary)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ── SCREEN TIME GOAL ──
  Widget _buildScreenTimeGoal() {
    const goalMinutes = 180; // 3 hour goal
    final actual = _today.totalMinutes;
    final progress = (actual / goalMinutes).clamp(0.0, 2.0);
    final isOver = actual > goalMinutes;
    final overBy = actual - goalMinutes;

    return GlassmorphicCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.flag_rounded,
                  color: AppColors.neonGreen, size: 18),
              const SizedBox(width: 8),
              const Text('Günlük Hedef',
                  style: TextStyle(
                      fontSize: 13,
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600)),
              const Spacer(),
              Text('${goalMinutes ~/ 60}s ${goalMinutes % 60}dk',
                  style: const TextStyle(
                      fontSize: 12, color: AppColors.textTertiary)),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: SizedBox(
              height: 8,
              child: LinearProgressIndicator(
                value: progress.clamp(0.0, 1.0),
                backgroundColor: Colors.white.withValues(alpha: 0.06),
                valueColor: AlwaysStoppedAnimation(
                  isOver ? AppColors.ringDanger : AppColors.neonGreen,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            isOver
                ? 'Hedefi ${_formatMinutes(overBy)} aştın'
                : 'Hedefe ${_formatMinutes(goalMinutes - actual)} kaldı',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isOver ? AppColors.ringDanger : AppColors.neonGreen,
            ),
          ),
        ],
      ),
    );
  }

  // ── WHAT COULD YOU DO ──
  Widget _buildWhatCouldYouDo() {
    final totalH = _today.totalMinutes / 60;
    final items = [
      if (totalH >= 2) _MotivItem('📚', '${totalH.floor()} kitap bölümü okuyabilirdin'),
      if (totalH >= 1) _MotivItem('🏃', '${(totalH * 5).floor()} km yürüyebilirdin'),
      if (totalH >= 1.5) _MotivItem('🎸', 'Yeni bir enstrüman öğrenmeye başlayabilirdin'),
      if (totalH >= 3) _MotivItem('🎨', 'Bir tablo resmedebilirdin'),
    ];

    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Bu Sürede...', style: AppTextStyles.h3),
        const SizedBox(height: 12),
        ...items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Text(item.emoji, style: const TextStyle(fontSize: 22)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(item.text,
                        style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                            height: 1.3)),
                  ),
                ],
              ),
            )),
      ],
    );
  }

  // ── HELPERS ──
  String _formatMinutes(int m) {
    if (m >= 60) {
      final h = m ~/ 60;
      final rem = m % 60;
      return rem > 0 ? '${h}s ${rem}dk' : '${h}s';
    }
    return '${m}dk';
  }

  Color _appColor(String app) {
    switch (app) {
      case 'Instagram':
        return const Color(0xFFE1306C);
      case 'YouTube':
        return const Color(0xFFFF0000);
      case 'TikTok':
        return const Color(0xFF69C9D0);
      case 'WhatsApp':
        return const Color(0xFF25D366);
      case 'Twitter':
        return const Color(0xFF1DA1F2);
      case 'Spotify':
        return const Color(0xFF1DB954);
      default:
        return const Color(0xFF6B7280);
    }
  }

  // ── MOCK DATA ──
  List<_DayData> _generateWeekMock() {
    final rng = Random(42);
    return List.generate(7, (day) {
      final base = 180 + rng.nextInt(120); // 3-5 hours
      final pickups = 30 + rng.nextInt(40);
      final notifs = 60 + rng.nextInt(80);

      // Generate per-hour stacked app data
      final hourlyApps = List.generate(24, (h) {
        final Map<String, double> apps = {};
        double budget;
        if (h < 7) {
          budget = rng.nextDouble() * 3;
        } else if (h < 9) {
          budget = 5 + rng.nextDouble() * 10;
        } else if (h < 12) {
          budget = 10 + rng.nextDouble() * 20;
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
          apps['Instagram'] = budget * (0.2 + rng.nextDouble() * 0.15);
          apps['YouTube'] = budget * (0.15 + rng.nextDouble() * 0.15);
          apps['TikTok'] = budget * (0.1 + rng.nextDouble() * 0.1);
          apps['WhatsApp'] = budget * (0.05 + rng.nextDouble() * 0.1);
          if (rng.nextBool()) {
            apps['Twitter'] = budget * (0.05 + rng.nextDouble() * 0.05);
          }
        }
        return apps;
      });

      final hourlyPickups = List.generate(24, (h) {
        if (h < 7) return rng.nextInt(2).toDouble();
        if (h < 9) return 2 + rng.nextDouble() * 3;
        if (h < 21) return 1 + rng.nextDouble() * 4;
        return rng.nextDouble() * 2;
      });

      final hourlyNotifs = List.generate(24, (h) {
        if (h < 7) return rng.nextInt(3).toDouble();
        if (h < 9) return 5 + rng.nextDouble() * 8;
        if (h < 21) return 3 + rng.nextDouble() * 6;
        return rng.nextDouble() * 3;
      });

      return _DayData(
        totalMinutes: base,
        changePercent: -15 + rng.nextInt(30),
        pickups: pickups,
        pickupChange: -10 + rng.nextInt(20),
        notifications: notifs,
        notifChange: -10 + rng.nextInt(20),
        topNotifApp: 'Instagram',
        topNotifCount: 15 + rng.nextInt(30),
        firstPickup: '0${6 + rng.nextInt(2)}:${rng.nextInt(5)}${rng.nextInt(10)}',
        lastPickup: '${22 + rng.nextInt(2)}:${rng.nextInt(5)}${rng.nextInt(10)}',
        hourlyApps: hourlyApps,
        hourlyPickups: hourlyPickups,
        hourlyNotifs: hourlyNotifs,
        categories: [
          _CategoryData('Sosyal Medya', const Color(0xFFE1306C), (base * 0.38).round()),
          _CategoryData('Video', const Color(0xFFFF0000), (base * 0.25).round()),
          _CategoryData('Oyun', const Color(0xFF8B5CF6), (base * 0.12).round()),
          _CategoryData('İletişim', const Color(0xFF25D366), (base * 0.11).round()),
          _CategoryData('Verimlilik', const Color(0xFF1DA1F2), (base * 0.08).round()),
          _CategoryData('Diğer', const Color(0xFF6B7280), (base * 0.06).round()),
        ],
      );
    });
  }

  List<_TopAppData> _mockTopApps() => [
        _TopAppData('Instagram', '📸', const Color(0xFFE1306C), 72),
        _TopAppData('YouTube', '▶️', const Color(0xFFFF0000), 55),
        _TopAppData('TikTok', '🎵', const Color(0xFF69C9D0), 41),
        _TopAppData('WhatsApp', '💬', const Color(0xFF25D366), 28),
        _TopAppData('Twitter', '🐦', const Color(0xFF1DA1F2), 22),
        _TopAppData('Clash Royale', '⚔️', const Color(0xFF8B5CF6), 18),
        _TopAppData('Netflix', '🎬', const Color(0xFFE50914), 15),
        _TopAppData('Spotify', '🎧', const Color(0xFF1DB954), 12),
      ];
}

// ── STAT SECTION (reusable for pickups & notifications) ──

class _StatSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final String mainValue;
  final String mainUnit;
  final String subtitle;
  final int change;
  final List<double> hourlyData;

  const _StatSection({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.mainValue,
    required this.mainUnit,
    required this.subtitle,
    required this.change,
    required this.hourlyData,
  });

  @override
  Widget build(BuildContext context) {
    final isUp = change > 0;
    final isGood = !isUp;
    final color = isGood ? AppColors.ringGood : AppColors.ringDanger;

    return GlassmorphicCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 18),
              const SizedBox(width: 8),
              Text(title,
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary)),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${isUp ? '▲' : '▼'} %${change.abs()}',
                  style: TextStyle(
                      fontSize: 11, fontWeight: FontWeight.w600, color: color),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(mainValue,
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: iconColor)),
              const SizedBox(width: 4),
              Text(mainUnit,
                  style: const TextStyle(
                      fontSize: 14, color: AppColors.textSecondary)),
            ],
          ),
          const SizedBox(height: 4),
          Text(subtitle, style: AppTextStyles.labelSmall),
          const SizedBox(height: 12),
          // Mini hourly bar chart
          SizedBox(
            height: 32,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(24, (i) {
                final maxVal =
                    hourlyData.reduce(max).clamp(1.0, double.infinity);
                final ratio = hourlyData[i] / maxVal;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.5),
                    child: FractionallySizedBox(
                      heightFactor: ratio.clamp(0.05, 1.0),
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        decoration: BoxDecoration(
                          color: iconColor.withValues(alpha: 0.5),
                          borderRadius:
                              const BorderRadius.vertical(top: Radius.circular(1)),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

// ── SPARKLINE PAINTER ──

class _SparklinePainter extends CustomPainter {
  final List<double> values;
  final int highlightIndex;

  _SparklinePainter({required this.values, required this.highlightIndex});

  @override
  void paint(Canvas canvas, Size size) {
    if (values.isEmpty) return;
    final maxV = values.reduce(max);
    final minV = values.reduce(min);
    final range = maxV - minV;

    final paint = Paint()
      ..color = AppColors.neonGreen.withValues(alpha: 0.6)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    for (int i = 0; i < values.length; i++) {
      final x = i / (values.length - 1) * size.width;
      final y = range > 0
          ? size.height - ((values[i] - minV) / range) * size.height
          : size.height / 2;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    canvas.drawPath(path, paint);

    // Highlight dot
    final hx = highlightIndex / (values.length - 1) * size.width;
    final hy = range > 0
        ? size.height -
            ((values[highlightIndex] - minV) / range) * size.height
        : size.height / 2;
    canvas.drawCircle(
      Offset(hx, hy),
      3,
      Paint()..color = AppColors.neonGreen,
    );
  }

  @override
  bool shouldRepaint(covariant _SparklinePainter old) =>
      old.highlightIndex != highlightIndex;
}

// ── DATA CLASSES ──

class _DayData {
  final int totalMinutes;
  final int changePercent;
  final int pickups;
  final int pickupChange;
  final int notifications;
  final int notifChange;
  final String topNotifApp;
  final int topNotifCount;
  final String firstPickup;
  final String lastPickup;
  final List<Map<String, double>> hourlyApps;
  final List<double> hourlyPickups;
  final List<double> hourlyNotifs;
  final List<_CategoryData> categories;

  const _DayData({
    required this.totalMinutes,
    required this.changePercent,
    required this.pickups,
    required this.pickupChange,
    required this.notifications,
    required this.notifChange,
    required this.topNotifApp,
    required this.topNotifCount,
    required this.firstPickup,
    required this.lastPickup,
    required this.hourlyApps,
    required this.hourlyPickups,
    required this.hourlyNotifs,
    required this.categories,
  });
}

class _CategoryData {
  final String name;
  final Color color;
  final int minutes;
  const _CategoryData(this.name, this.color, this.minutes);
}

class _TopAppData {
  final String name;
  final String emoji;
  final Color color;
  final int minutes;
  const _TopAppData(this.name, this.emoji, this.color, this.minutes);
}

class _MotivItem {
  final String emoji;
  final String text;
  const _MotivItem(this.emoji, this.text);
}
