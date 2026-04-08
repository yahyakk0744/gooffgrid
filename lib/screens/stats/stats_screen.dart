import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../config/theme.dart';
import '../../l10n/app_localizations.dart';
import '../../widgets/premium_background.dart';
import '../../widgets/app_card.dart';
import '../../widgets/stat_tile.dart';
import '../../providers/screen_time_provider.dart';
import '../../config/design_tokens.dart';
import 'heatmap_widget.dart';

class StatsScreen extends ConsumerWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final st = ref.watch(todayScreenTimeProvider);
    final weeklyMinutes = ref.watch(weeklyMinutesProvider);

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: PremiumBackground(
        child: SafeArea(
          child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(l.stats, style: AppType.h1),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.neonOrange.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(l.pro, style: AppType.label.copyWith(fontSize: 11, color: AppColors.neonOrange)),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Heatmap
              Text(l.focusCalendar.toUpperCase(), style: AppType.label),
              const SizedBox(height: 12),
              const AppCard(child: HeatmapWidget()),
              const SizedBox(height: 16),

              // Quick stats
              Row(
                children: [
                  Expanded(child: StatTile(value: '${st.phoneOpens}', label: l.phonePickups, icon: Icons.phone_android_rounded)),
                  const SizedBox(width: 8),
                  Expanded(child: StatTile(value: '${st.longestOffScreenMinutes}dk', label: l.longestOffScreen, icon: Icons.timer_off_rounded)),
                ],
              ),
              const SizedBox(height: 16),

              // Weekly trend
              Text(l.weeklyTrend.toUpperCase(), style: AppType.label),
              const SizedBox(height: 12),
              AppCard(
                child: SizedBox(
                  height: 180,
                  child: LineChart(
                    LineChartData(
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        getDrawingHorizontalLine: (v) => FlLine(
                          color: AppColors.divider,
                          strokeWidth: 0.5,
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      titlesData: FlTitlesData(
                        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (v, _) {
                              const days = ['Pzt', 'Sal', 'Çar', 'Per', 'Cum', 'Cmt', 'Paz'];
                              final i = v.toInt();
                              if (i < 0 || i >= days.length) return const SizedBox.shrink();
                              return Text(days[i], style: AppType.caption.copyWith(fontSize: 10, color: AppColors.textTertiary));
                            },
                          ),
                        ),
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          spots: List.generate(weeklyMinutes.length, (i) => FlSpot(i.toDouble(), weeklyMinutes[i].toDouble())),
                          isCurved: true,
                          color: AppColors.neonGreen,
                          barWidth: 3,
                          dotData: const FlDotData(show: false),
                          belowBarData: BarAreaData(show: true, color: AppColors.neonGreen.withValues(alpha: 0.1)),
                        ),
                        // Goal line
                        LineChartBarData(
                          spots: List.generate(7, (i) => FlSpot(i.toDouble(), st.goalMinutes.toDouble())),
                          isCurved: false,
                          color: AppColors.ringDanger.withValues(alpha: 0.5),
                          barWidth: 1,
                          dashArray: [6, 4],
                          dotData: const FlDotData(show: false),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Analytics deep dive
              GestureDetector(
                onTap: () => context.push('/profile/stats/analytics'),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.neonGreen.withValues(alpha: 0.12), AppColors.neonGreen.withValues(alpha: 0.04)],
                    ),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.neonGreen.withValues(alpha: 0.2)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.analytics_rounded, color: AppColors.neonGreen, size: 22),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(l.detailedAnalytics, style: AppType.body.copyWith(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.neonGreen)),
                            Text('Kategoriler, pickups, native ikonlar', style: AppType.caption.copyWith(fontSize: 11, color: AppColors.textTertiary)),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right_rounded, color: AppColors.neonGreen, size: 20),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // What if
              GestureDetector(
                onTap: () => context.push('/profile/stats/whatif'),
                child: Row(
                  children: [
                    Text(l.whatCouldYouDo, style: AppType.body.copyWith(fontSize: 14, color: AppColors.neonGreen)),
                    const SizedBox(width: 4),
                    const Icon(Icons.arrow_forward_rounded, size: 16, color: AppColors.neonGreen),
                  ],
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      ),
    );
  }
}
