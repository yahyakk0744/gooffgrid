import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme.dart';
import '../../providers/o2_provider.dart';
import '../../widgets/app_card.dart';
import '../../widgets/glassmorphic_card.dart';
import '../../widgets/premium_background.dart';
import '../../services/haptic_service.dart';
import '../../l10n/app_localizations.dart';

class O2DashboardScreen extends ConsumerWidget {
  const O2DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final o2 = ref.watch(o2Provider);
    final txAsync = ref.watch(o2TransactionsProvider);

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
                      onTap: () {
                        HapticService.light();
                        context.pop();
                      },
                      child: const Icon(Icons.arrow_back_rounded, color: AppColors.textPrimary),
                    ),
                    const SizedBox(width: 12),
                    Text(l.oxygenTitle, style: AppTextStyles.h1),
                  ],
                ),
                const SizedBox(height: 24),

                // O2 Balance — Hero card
                GlassmorphicCard(
                  glowColor: AppColors.neonGreen,
                  child: Column(
                    children: [
                      Text(l.o2Balance, style: AppTextStyles.label),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'O₂',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w300,
                              color: AppColors.neonGreen.withValues(alpha: 0.6),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${o2.balance}',
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.w700,
                              color: AppColors.neonGreen,
                              shadows: [Shadow(color: AppColors.neonGreen.withValues(alpha: 0.5), blurRadius: 20)],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Daily progress bar
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  l.o2Today(o2.todayEarned, 500),
                                  style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: AppColors.cardBorder,
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                  child: FractionallySizedBox(
                                    alignment: Alignment.centerLeft,
                                    widthFactor: (o2.todayEarned / 500).clamp(0.0, 1.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [AppColors.neonGreen, Color(0xFF00C9DB)],
                                        ),
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Quick stats
                Row(
                  children: [
                    Expanded(
                      child: AppCard(
                        child: Column(
                          children: [
                            Text('${o2.dailyRemaining}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                            Text(l.remainingShort, style: AppTextStyles.labelSmall),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: AppCard(
                        child: Column(
                          children: [
                            Text('${o2.lifetimeO2}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.gold)),
                            Text(l.totalO2, style: AppTextStyles.labelSmall),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Market CTA
                GestureDetector(
                  onTap: () {
                    HapticService.light();
                    context.push('/o2/market');
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.neonGreen.withValues(alpha: 0.15), AppColors.neonGreen.withValues(alpha: 0.05)],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.neonGreen.withValues(alpha: 0.3)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: AppColors.neonGreen.withValues(alpha: 0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Center(child: Text('🛒', style: TextStyle(fontSize: 24))),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(l.offGridMarket, style: AppTextStyles.h3),
                              Text(l.offGridMarketHint, style: AppTextStyles.bodySecondary),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right_rounded, color: AppColors.neonGreen),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Anti-cheat rules info
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l.o2Rules, style: AppTextStyles.h3),
                      const SizedBox(height: 12),
                      _RuleRow(emoji: '🕗', text: l.o2RuleTime),
                      _RuleRow(emoji: '📊', text: l.o2RuleDaily),
                      _RuleRow(emoji: '⏱️', text: l.o2RuleFocus),
                      _RuleRow(emoji: '🚫', text: l.o2RuleTransfer),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Transaction history
                Text(l.recentTransactions, style: AppTextStyles.h3),
                const SizedBox(height: 12),
                txAsync.when(
                  data: (txs) => txs.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Text(l.noTransactions, style: AppTextStyles.bodySecondary),
                          ),
                        )
                      : Column(
                          children: txs.take(20).map((tx) => _TransactionRow(tx: tx)).toList(),
                        ),
                  loading: () => const Center(child: CircularProgressIndicator(color: AppColors.neonGreen)),
                  error: (_, __) => Text(l.loadFailed, style: AppTextStyles.bodySecondary),
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

class _RuleRow extends StatelessWidget {
  const _RuleRow({required this.emoji, required this.text});
  final String emoji;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: AppTextStyles.bodySecondary)),
        ],
      ),
    );
  }
}

class _TransactionRow extends StatelessWidget {
  const _TransactionRow({required this.tx});
  final dynamic tx; // O2Transaction

  @override
  Widget build(BuildContext context) {
    final isEarning = (tx.amount as int) > 0;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.cardGradientStart, AppColors.cardGradientEnd],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.cardBorder.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Text(tx.typeEmoji as String, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tx.typeLabel as String, style: const TextStyle(fontSize: 13, color: AppColors.textPrimary, fontWeight: FontWeight.w500)),
                if (tx.description != null)
                  Text(tx.description as String, style: const TextStyle(fontSize: 11, color: AppColors.textTertiary)),
              ],
            ),
          ),
          Text(
            '${isEarning ? "+" : ""}${tx.amount}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: isEarning ? AppColors.neonGreen : AppColors.ringDanger,
            ),
          ),
          const SizedBox(width: 4),
          Text('O₂', style: TextStyle(fontSize: 11, color: isEarning ? AppColors.neonGreen : AppColors.ringDanger)),
        ],
      ),
    );
  }
}
