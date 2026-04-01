import 'package:flutter/material.dart';
import '../../config/theme.dart';
import '../../widgets/premium_background.dart';
import '../../widgets/app_card.dart';
import '../../widgets/progress_ring.dart';

class SeasonScreen extends StatelessWidget {
  const SeasonScreen({super.key});

  static const _tasks = [
    {'desc': '7 gun ust uste hedef tut', 'progress': 0.85, 'reward': '500 XP'},
    {'desc': '3 duel kazan', 'progress': 0.33, 'reward': '300 XP'},
    {'desc': '5 nefes egzersizi tamamla', 'progress': 0.6, 'reward': '200 XP'},
    {'desc': 'Gunluk 1 saat alti kal', 'progress': 0.0, 'reward': 'Ozel Rozet', 'premium': true},
    {'desc': 'Tum arkadaslarini yen', 'progress': 0.0, 'reward': 'Altin Cerceve', 'premium': true},
  ];

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
              Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Sezon 1', style: AppTextStyles.h1),
                        SizedBox(height: 4),
                        Text('Bahar Uyanisi', style: AppTextStyles.bodySecondary),
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
                            Text(t['desc'] as String, style: AppTextStyles.h3),
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
                            Text(t['reward'] as String, style: AppTextStyles.labelSmall.copyWith(color: AppColors.gold)),
                          ],
                        ),
                      ),
                      if (isPremium)
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.bg.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.lock_rounded, color: AppColors.textTertiary, size: 24),
                                  SizedBox(height: 4),
                                  Text('Sezon Pass', style: TextStyle(fontSize: 12, color: AppColors.textTertiary)),
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
                  child: const Text('Sezon Pass (99TL)'),
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
