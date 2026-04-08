import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme.dart';
import '../../config/design_tokens.dart';
import '../../models/o2_transaction.dart';
import '../../providers/o2_provider.dart';
import '../../services/o2_service.dart';
import '../../widgets/premium_background.dart';
import '../../services/haptic_service.dart';
import '../../l10n/app_localizations.dart';

class MarketScreen extends ConsumerWidget {
  const MarketScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
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
                    Text(l.offGridMarket, style: AppType.h2),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.neonGreen.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.neonGreen.withValues(alpha: 0.3)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('O₂', style: TextStyle(fontSize: 12, color: AppColors.neonGreen.withValues(alpha: 0.7))),
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
                  l.offGridMarketHint,
                  style: TextStyle(fontSize: 13, color: AppColors.textTertiary),
                ),
                const SizedBox(height: 24),

                // Offers
                offersAsync.when(
                  data: (offers) => offers.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(32),
                            child: Text(l.noOffersYet, style: AppType.bodySmall.copyWith(color: AppColors.textSecondary)),
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
                  error: (_, __) => Text(l.loadFailed, style: AppType.bodySmall.copyWith(color: AppColors.textSecondary)),
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
    final l = AppLocalizations.of(context)!;
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
          color: canAfford ? AppColors.neonGreen.withValues(alpha: 0.3) : AppColors.cardBorder.withValues(alpha: 0.3),
        ),
        boxShadow: canAfford
            ? [BoxShadow(color: AppColors.neonGreen.withValues(alpha: 0.08), blurRadius: 16)]
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
                    ? AppColors.neonGreen.withValues(alpha: 0.1)
                    : AppColors.cardBorder.withValues(alpha: 0.3),
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
                  Text(offer.title, style: AppType.body),
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
                      canAfford ? l.redeem : l.insufficient,
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
    final l = AppLocalizations.of(context)!;
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
          title: Text(l.redeemSuccess, style: const TextStyle(color: AppColors.neonGreen)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(l.couponCode, style: AppType.bodySmall.copyWith(color: AppColors.textSecondary)),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.neonGreen.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.neonGreen.withValues(alpha: 0.3)),
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
              Text(l.o2SpentMsg(result.o2Spent), style: AppType.bodySmall.copyWith(color: AppColors.textSecondary)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l.ok, style: const TextStyle(color: AppColors.neonGreen)),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result.error ?? l.error)),
      );
    }
  }
}
