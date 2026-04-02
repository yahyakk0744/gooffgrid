import 'dart:math';
import 'dart:ui';

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
  int _selectedPeriod = 0; // 0=today, 1=week, 2=month
  int? _touchedBarIndex;

  // Mock hourly data
  late final List<int> _hourlyMinutes;
  late final List<_AppCategoryData> _categories;
  late final List<_TopAppData> _topApps;

  @override
  void initState() {
    super.initState();
    _hourlyMinutes = _generateHourlyMock();
    _categories = _mockCategories();
    _topApps = _mockTopApps();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: PremiumBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 20),
                _buildPeriodChips(),
                const SizedBox(height: 24),
                _buildHourlyChart(),
                const SizedBox(height: 24),
                _buildPickupsCard(),
                const SizedBox(height: 24),
                _buildCategorySection(),
                const SizedBox(height: 24),
                _buildTopApps(),
                const SizedBox(height: 24),
                _buildComparison(),
                const SizedBox(height: 24),
                _buildMotivational(),
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
          child: const Icon(Icons.arrow_back_rounded,
              color: AppColors.textPrimary),
        ),
        const SizedBox(width: 12),
        const Text('Detaylı Analiz', style: AppTextStyles.h1),
      ],
    );
  }

  // ── PERIOD CHIPS ──
  Widget _buildPeriodChips() {
    const labels = ['Bugün', 'Bu Hafta', 'Bu Ay'];
    return Row(
      children: List.generate(3, (i) {
        final selected = _selectedPeriod == i;
        return Padding(
          padding: const EdgeInsets.only(right: 8),
          child: GlassChip(
            label: labels[i],
            isSelected: selected,
            onTap: () {
              HapticService.selection();
              setState(() => _selectedPeriod = i);
            },
          ),
        );
      }),
    );
  }

  // ── 24-HOUR BAR CHART ──
  Widget _buildHourlyChart() {
    final maxY =
        (_hourlyMinutes.reduce(max) * 1.3).clamp(10.0, 120.0);

    return GlassmorphicCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Saatlik Kullanım', style: AppTextStyles.h3),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: BarChart(
              BarChartData(
                maxY: maxY,
                barTouchData: BarTouchData(
                  touchCallback: (event, response) {
                    if (event is FlTapUpEvent && response?.spot != null) {
                      HapticService.light();
                      setState(() {
                        _touchedBarIndex =
                            response!.spot!.touchedBarGroupIndex;
                      });
                    }
                  },
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (_) =>
                        AppColors.cardGradientStart.withValues(alpha: 0.95),
                    getTooltipItem: (group, gI, rod, rI) {
                      final h = group.x;
                      final m = _hourlyMinutes[h];
                      return BarTooltipItem(
                        '${h.toString().padLeft(2, '0')}:00 — ${m}dk',
                        const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.neonGreen,
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
                    color: Colors.white.withValues(alpha: 0.06),
                    strokeWidth: 1,
                  ),
                ),
                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 32,
                      interval: 30,
                      getTitlesWidget: (v, _) => Text(
                        '${v.toInt()}dk',
                        style: AppTextStyles.labelSmall,
                      ),
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (v, _) {
                        final h = v.toInt();
                        if (h % 3 != 0) return const SizedBox.shrink();
                        return Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            '$h',
                            style: AppTextStyles.labelSmall,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                barGroups: List.generate(24, (i) {
                  final m = _hourlyMinutes[i].toDouble();
                  return BarChartGroupData(
                    x: i,
                    barRods: [
                      BarChartRodData(
                        toY: m,
                        width: 8,
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(4)),
                        color: _barColor(m.toInt()),
                        backDrawRodData: BackgroundBarChartRodData(
                          show: true,
                          toY: maxY,
                          color: Colors.white.withValues(alpha: 0.02),
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
    );
  }

  Color _barColor(int minutes) {
    if (minutes < 10) return AppColors.neonGreen;
    if (minutes <= 30) return AppColors.gold;
    return AppColors.ringDanger;
  }

  // ── PICKUPS CARD ──
  Widget _buildPickupsCard() {
    const pickups = 47;
    const avgInterval = 18;
    const changePercent = 12;
    const isUp = true;

    return GlassmorphicCard(
      glowColor: AppColors.neonOrange,
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.neonOrange.withValues(alpha: 0.2),
                  AppColors.neonOrange.withValues(alpha: 0.02),
                ],
              ),
              border: Border.all(
                  color: AppColors.neonOrange.withValues(alpha: 0.3)),
            ),
            child: const Center(
              child: Text('📱', style: TextStyle(fontSize: 24)),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Kilit Açma',
                    style: TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      '$pickups kez',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: AppColors.neonOrange,
                        shadows: [
                          Shadow(
                            color:
                                AppColors.neonOrange.withValues(alpha: 0.4),
                            blurRadius: 16,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: (isUp
                                ? AppColors.ringDanger
                                : AppColors.ringGood)
                            .withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${isUp ? '▲' : '▼'}$changePercent%',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: isUp
                              ? AppColors.ringDanger
                              : AppColors.ringGood,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  'Ortalama: Her $avgInterval dakikada bir',
                  style: AppTextStyles.labelSmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── CATEGORY SECTION ──
  Widget _buildCategorySection() {
    final totalMin =
        _categories.fold<int>(0, (s, c) => s + c.minutes);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Kategori Dağılımı', style: AppTextStyles.h3),
        const SizedBox(height: 12),
        // Stacked bar
        GlassmorphicCard(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: SizedBox(
                  height: 12,
                  child: Row(
                    children: _categories.map((c) {
                      final ratio =
                          totalMin > 0 ? c.minutes / totalMin : 0.0;
                      return Expanded(
                        flex: (ratio * 1000).round().clamp(1, 1000),
                        child: Container(color: c.color),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ...List.generate(_categories.length, (i) {
                final c = _categories[i];
                final pct =
                    totalMin > 0 ? (c.minutes / totalMin * 100).round() : 0;
                return _CategoryRow(
                  name: c.name,
                  icon: c.icon,
                  color: c.color,
                  time: _formatMinutes(c.minutes),
                  percentage: pct,
                  apps: c.apps,
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  // ── TOP APPS ──
  Widget _buildTopApps() {
    final maxMin =
        _topApps.isEmpty ? 1 : _topApps.first.minutes;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('En Çok Kullanılan', style: AppTextStyles.h3),
        const SizedBox(height: 12),
        GlassmorphicCard(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Column(
            children: List.generate(_topApps.length, (i) {
              final app = _topApps[i];
              final ratio =
                  maxMin > 0 ? (app.minutes / maxMin).clamp(0.0, 1.0) : 0.0;
              return Padding(
                padding: EdgeInsets.only(bottom: i < _topApps.length - 1 ? 14 : 0),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: app.color.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(color: app.color.withValues(alpha: 0.3)),
                      ),
                      child: Center(
                        child: Text(app.emoji,
                            style: const TextStyle(fontSize: 18)),
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
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: app.color)),
                            ],
                          ),
                          const SizedBox(height: 6),
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
                                  gradient: LinearGradient(colors: [
                                    app.color.withValues(alpha: 0.5),
                                    app.color
                                  ]),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  // ── COMPARISON ──
  Widget _buildComparison() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Karşılaştırma', style: AppTextStyles.h3),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _ComparisonCard(
                label: 'Dün',
                value: '4s 12dk',
                change: -18,
                isGood: true,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _ComparisonCard(
                label: 'Geçen Hafta Ort.',
                value: '3s 45dk',
                change: 8,
                isGood: false,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ── MOTIVATIONAL ──
  Widget _buildMotivational() {
    final items = [
      _MotivItem(
          '📚', 'Bu hafta Instagram\'da 8 saat = 2 kitap okuyabilirdin'),
      _MotivItem(
          '🏃', 'YouTube\'da 5 saat = 10 km koşabilirdin'),
      _MotivItem(
          '🎸', 'TikTok\'ta 6 saat = Gitar öğrenmeye başlayabilirdin'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Ne Yapabilirdin?', style: AppTextStyles.h3),
        const SizedBox(height: 12),
        ...items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: GlassmorphicCard(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Row(
                  children: [
                    Text(item.emoji, style: const TextStyle(fontSize: 28)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        item.text,
                        style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                            height: 1.4),
                      ),
                    ),
                  ],
                ),
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

  List<int> _generateHourlyMock() {
    final rng = Random(42);
    return List.generate(24, (h) {
      if (h < 7) return rng.nextInt(3);
      if (h < 9) return 5 + rng.nextInt(15);
      if (h < 12) return 10 + rng.nextInt(25);
      if (h == 12) return 20 + rng.nextInt(20);
      if (h < 17) return 8 + rng.nextInt(20);
      if (h < 20) return 15 + rng.nextInt(30);
      if (h < 23) return 20 + rng.nextInt(35);
      return 5 + rng.nextInt(10);
    });
  }

  List<_AppCategoryData> _mockCategories() => [
        _AppCategoryData('Sosyal Medya', Icons.people_rounded,
            const Color(0xFFE1306C), 128,
            apps: ['Instagram', 'Twitter', 'TikTok']),
        _AppCategoryData(
            'Video', Icons.play_circle_rounded, const Color(0xFFFF0000), 95,
            apps: ['YouTube', 'Netflix']),
        _AppCategoryData(
            'Oyun', Icons.sports_esports_rounded, const Color(0xFF8B5CF6), 42,
            apps: ['Clash Royale', 'Brawl Stars']),
        _AppCategoryData('İletişim', Icons.chat_rounded,
            const Color(0xFF25D366), 38,
            apps: ['WhatsApp', 'Telegram']),
        _AppCategoryData('Verimlilik', Icons.work_rounded,
            const Color(0xFF1DA1F2), 22,
            apps: ['Notion', 'Calendar']),
        _AppCategoryData(
            'Diğer', Icons.apps_rounded, const Color(0xFF6B7280), 15,
            apps: ['Ayarlar', 'Dosyalar']),
      ];

  List<_TopAppData> _mockTopApps() => [
        _TopAppData('Instagram', '📸', const Color(0xFFE1306C), 65),
        _TopAppData('YouTube', '▶️', const Color(0xFFFF0000), 52),
        _TopAppData('TikTok', '🎵', const Color(0xFF69C9D0), 41),
        _TopAppData('WhatsApp', '💬', const Color(0xFF25D366), 28),
        _TopAppData('Twitter', '🐦', const Color(0xFF1DA1F2), 22),
        _TopAppData('Clash Royale', '⚔️', const Color(0xFF8B5CF6), 18),
        _TopAppData('Netflix', '🎬', const Color(0xFFE50914), 15),
        _TopAppData('Telegram', '✈️', const Color(0xFF0088CC), 10),
        _TopAppData('Spotify', '🎧', const Color(0xFF1DB954), 8),
        _TopAppData('Reddit', '🔴', const Color(0xFFFF4500), 6),
      ];
}

// ── PRIVATE DATA CLASSES ──

class _AppCategoryData {
  final String name;
  final IconData icon;
  final Color color;
  final int minutes;
  final List<String> apps;

  const _AppCategoryData(this.name, this.icon, this.color, this.minutes,
      {this.apps = const []});
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

// ── CATEGORY ROW (expandable) ──

class _CategoryRow extends StatefulWidget {
  final String name;
  final IconData icon;
  final Color color;
  final String time;
  final int percentage;
  final List<String> apps;

  const _CategoryRow({
    required this.name,
    required this.icon,
    required this.color,
    required this.time,
    required this.percentage,
    required this.apps,
  });

  @override
  State<_CategoryRow> createState() => _CategoryRowState();
}

class _CategoryRowState extends State<_CategoryRow> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            HapticService.light();
            setState(() => _expanded = !_expanded);
          },
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: widget.color,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: widget.color.withValues(alpha: 0.5),
                          blurRadius: 4),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Icon(widget.icon, size: 16, color: widget.color),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(widget.name,
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: widget.color)),
                ),
                Text(widget.time,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary)),
                const SizedBox(width: 8),
                Text('%${widget.percentage}',
                    style: TextStyle(
                        fontSize: 11,
                        color: widget.color.withValues(alpha: 0.7))),
                const SizedBox(width: 4),
                Icon(
                  _expanded
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  size: 16,
                  color: AppColors.textTertiary,
                ),
              ],
            ),
          ),
        ),
        if (_expanded)
          Padding(
            padding: const EdgeInsets.only(left: 28, bottom: 8),
            child: Column(
              children: widget.apps
                  .map((app) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        child: Row(
                          children: [
                            Container(
                              width: 4,
                              height: 4,
                              decoration: BoxDecoration(
                                color: AppColors.textTertiary,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(app,
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textSecondary)),
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ),
      ],
    );
  }
}

// ── COMPARISON CARD ──

class _ComparisonCard extends StatelessWidget {
  final String label;
  final String value;
  final int change;
  final bool isGood;

  const _ComparisonCard({
    required this.label,
    required this.value,
    required this.change,
    required this.isGood,
  });

  @override
  Widget build(BuildContext context) {
    final arrowColor = isGood ? AppColors.ringGood : AppColors.ringDanger;
    final arrow = isGood ? '▼' : '▲';

    return GlassmorphicCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyles.label),
          const SizedBox(height: 8),
          Text(value,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary)),
          const SizedBox(height: 4),
          Row(
            children: [
              Text('$arrow${change.abs()}%',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: arrowColor)),
              const SizedBox(width: 4),
              Text(isGood ? 'daha az' : 'daha fazla',
                  style: AppTextStyles.labelSmall),
            ],
          ),
        ],
      ),
    );
  }
}
