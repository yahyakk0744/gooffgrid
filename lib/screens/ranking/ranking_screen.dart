import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme.dart';
import '../../widgets/ranking_row.dart';
import '../../widgets/top_three_podium.dart';
import '../../providers/ranking_provider.dart';
import '../../widgets/premium_background.dart';
import '../../services/haptic_service.dart';

class RankingScreen extends ConsumerWidget {
  const RankingScreen({super.key});

  static const _tabLabels = ['Arkadaşlar', 'Şehir', 'Ülke', 'Global', 'Yaş', 'Sezon'];
  static const _freeTabCount = 2;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rankingState = ref.watch(rankingProvider);
    final entries = rankingState.entries;

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: PremiumBackground(
        child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text('Sıralama', style: AppTextStyles.h1),
            ),
            const SizedBox(height: 16),

            // Tabs
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: RankingTab.values.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, i) {
                  final tab = RankingTab.values[i];
                  final active = tab == rankingState.scope;
                  final locked = i >= _freeTabCount;
                  return GestureDetector(
                    onTap: locked ? null : () {
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
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (locked) ...[
                            const Icon(Icons.lock_rounded, size: 12, color: AppColors.textTertiary),
                            const SizedBox(width: 4),
                          ],
                          Text(
                            _tabLabels[i],
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: active ? Colors.black : (locked ? AppColors.textTertiary : AppColors.textSecondary),
                            ),
                          ),
                          if (locked) ...[
                            const SizedBox(width: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                              decoration: BoxDecoration(color: AppColors.neonOrange.withOpacity(0.2), borderRadius: BorderRadius.circular(4)),
                              child: const Text('Pro', style: TextStyle(fontSize: 8, fontWeight: FontWeight.w700, color: AppColors.neonOrange)),
                            ),
                          ],
                        ],
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
        ),
      ),
      ),
    );
  }
}
