import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme.dart';
import '../../models/o2_transaction.dart';
import '../../providers/o2_provider.dart';
import '../../services/o2_service.dart';
import '../../widgets/premium_background.dart';
import '../../services/haptic_service.dart';

class MarketScreen extends ConsumerWidget {
  const MarketScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final o2 = ref.watch(o2Provider);
    final offersAsync = ref.watch(marketOffersProvider);

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
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: const Icon(Icons.arrow_back_rounded, color: AppColors.textPrimary),
                    ),
                    const SizedBox(width: 12),
                    const Text('Ganimetler', style: AppTextStyles.h1),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.neonGreen.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.neonGreen.withOpacity(0.3)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('O₂', style: TextStyle(fontSize: 12, color: AppColors.neonGreen.withOpacity(0.7))),
                          const SizedBox(width: 4),
                          Text(
                            '${o2.balance}',
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.neonGreen),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'O₂ puanlarını gerçek dünya ganimetlerine dönüştür',
                  style: TextStyle(fontSize: 13, color: AppColors.textTertiary),
                ),
                const SizedBox(height: 24),

                // Offers
                offersAsync.when(
                  data: (offers) => offers.isEmpty
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.all(32),
                            child: Text('Henüz teklif yok', style: AppTextStyles.bodySecondary),
                          ),
                        )
                      : Column(
                          children: offers.map((offer) => _OfferCard(offer: offer, balance: o2.balance)).toList(),
                        ),
                  loading: () => const Center(
                    child: Padding(
                      padding: EdgeInsets.all(32),
                      child: CircularProgressIndicator(color: AppColors.neonGreen),
                    ),
                  ),
                  error: (_, __) => const Text('Yüklenemedi', style: AppTextStyles.bodySecondary),
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

class _OfferCard extends ConsumerWidget {
  const _OfferCard({required this.offer, required this.balance});
  final MarketOffer offer;
  final int balance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canAfford = balance >= offer.o2Cost;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.cardGradientStart, AppColors.cardGradientEnd],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: canAfford ? AppColors.neonGreen.withOpacity(0.3) : AppColors.cardBorder.withOpacity(0.3),
        ),
        boxShadow: canAfford
            ? [BoxShadow(color: AppColors.neonGreen.withOpacity(0.08), blurRadius: 16)]
            : null,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Emoji icon
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: canAfford
                    ? AppColors.neonGreen.withOpacity(0.1)
                    : AppColors.cardBorder.withOpacity(0.3),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Text(offer.categoryEmoji, style: const TextStyle(fontSize: 28)),
              ),
            ),
            const SizedBox(width: 12),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(offer.partnerName, style: const TextStyle(fontSize: 11, color: AppColors.textTertiary)),
                  Text(offer.title, style: AppTextStyles.h3),
                  if (offer.description != null)
                    Text(offer.description!, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                  if (offer.city != null)
                    Text(offer.city!, style: TextStyle(fontSize: 10, color: AppColors.textTertiary)),
                ],
              ),
            ),

            // Price + button
            Column(
              children: [
                Text(
                  '${offer.o2Cost}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: canAfford ? AppColors.neonGreen : AppColors.textTertiary,
                  ),
                ),
                Text('O₂', style: TextStyle(fontSize: 10, color: canAfford ? AppColors.neonGreen : AppColors.textTertiary)),
                const SizedBox(height: 6),
                GestureDetector(
                  onTap: canAfford ? () {
                    HapticService.heavy();
                    _redeem(context, ref);
                  } : () => HapticService.warning(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: canAfford ? AppColors.neonGreen : AppColors.cardBorder,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      canAfford ? 'Al' : 'Yetersiz',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: canAfford ? Colors.black : AppColors.textTertiary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _redeem(BuildContext context, WidgetRef ref) async {
    final result = await O2Service.instance.redeemOffer(offer.id);
    if (!context.mounted) return;

    if (result.success) {
      ref.read(o2Provider.notifier).refresh();
      ref.invalidate(marketOffersProvider);
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          backgroundColor: AppColors.cardGradientStart,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Tebrikler!', style: TextStyle(color: AppColors.neonGreen)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Kupon kodun:', style: AppTextStyles.bodySecondary),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.neonGreen.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.neonGreen.withOpacity(0.3)),
                ),
                child: Text(
                  result.redeemCode,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: AppColors.neonGreen,
                    letterSpacing: 3,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text('${result.o2Spent} O₂ harcandı', style: AppTextStyles.bodySecondary),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Tamam', style: TextStyle(color: AppColors.neonGreen)),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result.error ?? 'Hata oluştu')),
      );
    }
  }
}
