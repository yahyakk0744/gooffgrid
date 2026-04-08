import 'package:flutter/material.dart';
import '../../config/theme.dart';
import '../../config/design_tokens.dart';
import '../../widgets/premium_background.dart';
import '../../widgets/app_card.dart';
import '../../widgets/progress_ring.dart';
import '../../l10n/app_localizations.dart';

class SeasonScreen extends StatelessWidget {
  const SeasonScreen({super.key});

  static const _tasks = [
    {'desc': '7 gün üst üste hedef tut', 'progress': 0.85, 'reward': '500 XP'},
    {'desc': '3 duel kazan', 'progress': 0.33, 'reward': '300 XP'},
    {'desc': '5 nefes egzersizi tamamla', 'progress': 0.6, 'reward': '200 XP'},
    {'desc': 'Günlük 1 saat altı kal', 'progress': 0.0, 'reward': 'Özel Rozet', 'premium': true},
    {'desc': 'Tüm arkadaşlarını yen', 'progress': 0.0, 'reward': 'Altın Çerçeve', 'premium': true},
  ];

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(l.season1Title, style: AppType.h1),
                        const SizedBox(height: 4),
                        Text(l.season1Subtitle, style: AppType.body.copyWith(color: AppColors.textSecondary)),
                      ],
                    ),
                  ),
                  const ProgressRing(progress: 0.45, size: 56, color: AppColors.neonGreen),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: const LinearProgressIndicator(
                  value: 0.45,
                  backgroundColor: AppColors.cardBorder,
                  color: AppColors.neonGreen,
                  minHeight: 6,
                ),
              ),
              const SizedBox(height: 24),

              ...List.generate(_tasks.length, (i) {
                final t = _tasks[i];
                final isPremium = t['premium'] == true;
                final progress = t['progress'] as double;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Stack(
                    children: [
                      AppCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(t['desc'] as String, style: AppType.h3),
                            const SizedBox(height: 8),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(3),
                              child: LinearProgressIndicator(
                                value: progress,
                                backgroundColor: AppColors.cardBorder,
                                color: AppColors.neonGreen,
                                minHeight: 6,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(t['reward'] as String, style: AppType.label.copyWith(color: AppColors.gold)),
                          ],
                        ),
                      ),
                      if (isPremium)
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.bg.withValues(alpha: 0.7),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.lock_rounded, color: AppColors.textTertiary, size: 24),
                                  const SizedBox(height: 4),
                                  Text(l.seasonPassLabel, style: const TextStyle(fontSize: 12, color: AppColors.textTertiary)),
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.neonOrange,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  child: Text(l.seasonPassBtn),
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
