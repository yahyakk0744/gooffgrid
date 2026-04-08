import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme.dart';
import '../../config/design_tokens.dart';
import '../../l10n/app_localizations.dart';
import '../../widgets/ranking_row.dart';
import '../../widgets/top_three_podium.dart';
import '../../providers/ranking_provider.dart';
import '../../widgets/premium_background.dart';
import '../../services/haptic_service.dart';

class RankingScreen extends ConsumerWidget {
  const RankingScreen({super.key, this.embedded = false});

  final bool embedded;

  static const _tabLabels = <String>[]; // populated in build via l10n
  static const _visibleTabs = [RankingTab.friends, RankingTab.city, RankingTab.country, RankingTab.global];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final tabLabels = [l.friends, l.city, l.country, l.global];
    final rankingState = ref.watch(rankingProvider);
    final entries = rankingState.entries;

    final content = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!embedded) ...[
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(l.ranking, style: AppType.h1),
              ),
            ],
            const SizedBox(height: 16),

            // Tabs
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _visibleTabs.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, i) {
                  final tab = _visibleTabs[i];
                  final active = tab == rankingState.scope;
                  return GestureDetector(
                    onTap: () {
                      HapticService.selection();
                      ref.read(rankingTabProvider.notifier).state = tab;
                      ref.read(rankingProvider.notifier).setScope(tab);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: active ? AppColors.neonGreen : AppColors.cardBg,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: active ? AppColors.neonGreen : AppColors.cardBorder),
                      ),
                      child: Text(
                        tabLabels[i],
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: active ? Colors.black : AppColors.textSecondary,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            // Podium
            if (entries.length >= 3)
              TopThreePodium(
                entries: entries.take(3).map((e) => PodiumEntry(
                  name: e.name,
                  avatarColor: e.avatarColor,
                  totalMinutes: e.totalMinutes,
                )).toList(),
              ),
            const SizedBox(height: 16),

            // Ranking list
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 100),
                itemCount: entries.length,
                itemBuilder: (context, i) {
                  final e = entries[i];
                  return GestureDetector(
                    onTap: () {
                      HapticService.light();
                      context.push('/user/${e.userId}');
                    },
                    child: RankingRow(
                      rank: i + 1,
                      name: e.name,
                      avatarColor: e.avatarColor,
                      level: e.level,
                      totalMinutes: e.totalMinutes,
                      change: e.change,
                      isCurrentUser: e.userId == 'user1',
                    ),
                  );
                },
              ),
            ),
          ],
        );

    if (embedded) return content;

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: PremiumBackground(
        child: SafeArea(child: content),
      ),
    );
  }
}
