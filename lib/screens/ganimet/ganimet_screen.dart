import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/theme.dart';
import '../../widgets/glassmorphic_card.dart';
import '../../widgets/premium_background.dart';
import '../../services/haptic_service.dart';
import '../../providers/o2_provider.dart';

final _mockGanimetler = [
  {'mekan': 'Starbucks Caddebostan', 'odul': '%20 İndirim', 'o2': 150, 'mesafe': '250m'},
  {'mekan': 'D&R Bağdat Caddesi', 'odul': '50₺ Kitap Kuponu', 'o2': 300, 'mesafe': '400m'},
  {'mekan': 'MacFit Ataşehir', 'odul': '1 Günlük Ücretsiz Giriş', 'o2': 200, 'mesafe': '1.2km'},
  {'mekan': 'Kahve Dünyası Kadıköy', 'odul': 'Bedava Türk Kahvesi', 'o2': 100, 'mesafe': '1.8km'},
  {'mekan': 'Decathlon Maltepe', 'odul': '%15 Spor Ekipmanı', 'o2': 250, 'mesafe': '3.5km'},
];

class GanimetScreen extends ConsumerWidget {
  const GanimetScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final o2 = ref.watch(o2Provider);

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: PremiumBackground(
        child: Stack(
          children: [
            // Top half: Map placeholder
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: SafeArea(
                    bottom: false,
                    child: Column(
                      children: [
                        // Header
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  HapticService.light();
                                  Navigator.of(context).pop();
                                },
                                child: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textSecondary, size: 20),
                              ),
                              const SizedBox(width: 12),
                              const Text('Ganimetler', style: AppTextStyles.h1),
                              const Spacer(),
                              // O2 badge
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.neonGreen.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: AppColors.neonGreen.withOpacity(0.25)),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('O\u2082', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.neonGreen.withOpacity(0.7))),
                                    const SizedBox(width: 4),
                                    Text('${o2.balance}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.neonGreen)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Map placeholder
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: const Color(0xFF0D0D1A),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: AppColors.cardBorder),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.map_rounded, size: 48, color: AppColors.neonGreen.withOpacity(0.3)),
                                  const SizedBox(height: 12),
                                  Text(
                                    'Harita y\u00fckleniyor...',
                                    style: AppTextStyles.bodySecondary.copyWith(color: AppColors.textTertiary),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'google_maps_flutter gerekli',
                                    style: AppTextStyles.labelSmall,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Bottom half: DraggableScrollableSheet
            DraggableScrollableSheet(
              initialChildSize: 0.52,
              minChildSize: 0.35,
              maxChildSize: 0.85,
              builder: (context, scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: AppColors.bg.withOpacity(0.95),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                    border: Border(top: BorderSide(color: AppColors.neonGreen.withOpacity(0.15))),
                    boxShadow: [
                      BoxShadow(color: AppColors.neonGreen.withOpacity(0.05), blurRadius: 30, offset: const Offset(0, -8)),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Drag handle
                      Padding(
                        padding: const EdgeInsets.only(top: 12, bottom: 8),
                        child: Container(
                          width: 36,
                          height: 4,
                          decoration: BoxDecoration(
                            color: AppColors.textTertiary,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                        child: Row(
                          children: [
                            Icon(CupertinoIcons.gift_fill, color: AppColors.neonGreen, size: 18,
                              shadows: [Shadow(color: AppColors.neonGreen.withOpacity(0.5), blurRadius: 12)],
                            ),
                            const SizedBox(width: 8),
                            const Text('Yakındaki Ganimetler', style: AppTextStyles.h2),
                            const Spacer(),
                            Text('${_mockGanimetler.length} yer', style: AppTextStyles.label),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      // List
                      Expanded(
                        child: ListView.separated(
                          controller: scrollController,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          itemCount: _mockGanimetler.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 10),
                          itemBuilder: (context, i) {
                            final item = _mockGanimetler[i];
                            final cost = item['o2'] as int;
                            final canAfford = o2.balance >= cost;

                            return GlassmorphicCard(
                              glowColor: AppColors.neonGreen,
                              onTap: () => HapticService.light(),
                              child: Row(
                                children: [
                                  // Icon with glow
                                  Container(
                                    width: 48,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color: AppColors.neonGreen.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(14),
                                      boxShadow: [
                                        BoxShadow(color: AppColors.neonGreen.withOpacity(0.15), blurRadius: 12),
                                      ],
                                    ),
                                    child: Icon(
                                      CupertinoIcons.gift_fill,
                                      color: AppColors.neonGreen,
                                      size: 22,
                                      shadows: [Shadow(color: AppColors.neonGreen.withOpacity(0.6), blurRadius: 8)],
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  // Info
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(item['mekan'] as String, style: AppTextStyles.h3),
                                        const SizedBox(height: 2),
                                        Text(item['odul'] as String, style: AppTextStyles.bodySecondary.copyWith(fontSize: 13)),
                                        const SizedBox(height: 4),
                                        Text(item['mesafe'] as String, style: AppTextStyles.labelSmall),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  // O2 cost + Al button
                                  Column(
                                    children: [
                                      // Neon O2 badge
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: AppColors.neonGreen.withOpacity(0.12),
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(color: AppColors.neonGreen.withOpacity(0.3)),
                                          boxShadow: [
                                            BoxShadow(color: AppColors.neonGreen.withOpacity(0.1), blurRadius: 8),
                                          ],
                                        ),
                                        child: Text(
                                          '$cost O\u2082',
                                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.neonGreen),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      // Al button
                                      GestureDetector(
                                        onTap: () {
                                          if (!canAfford) {
                                            HapticService.warning();
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text('Yetersiz O\u2082. $cost O\u2082 gerekli.'),
                                                backgroundColor: AppColors.ringDanger,
                                                behavior: SnackBarBehavior.floating,
                                              ),
                                            );
                                            return;
                                          }
                                          HapticService.heavy();
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text('${item['odul']} al\u0131nd\u0131!'),
                                              backgroundColor: AppColors.neonGreen,
                                              behavior: SnackBarBehavior.floating,
                                            ),
                                          );
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                          decoration: BoxDecoration(
                                            color: canAfford ? AppColors.neonGreen : AppColors.textTertiary,
                                            borderRadius: BorderRadius.circular(10),
                                            boxShadow: canAfford
                                                ? [BoxShadow(color: AppColors.neonGreen.withOpacity(0.3), blurRadius: 8)]
                                                : null,
                                          ),
                                          child: Text(
                                            'Al',
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w700,
                                              color: canAfford ? Colors.black : AppColors.textSecondary,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
