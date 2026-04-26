import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme.dart';
import '../../config/design_tokens.dart';
import '../../l10n/app_localizations.dart';
import '../../widgets/premium_background.dart';
import '../../widgets/app_card.dart';
import '../../widgets/level_badge.dart';
import '../../widgets/reaction_row.dart';
import '../../providers/friends_provider.dart';
import '../../providers/buddy_provider.dart';
import '../../services/haptic_service.dart';

class FriendProfileScreen extends ConsumerWidget {
  const FriendProfileScreen({super.key, required this.friendId});
  final String friendId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final friends = ref.watch(friendsProvider);
    final friend = friends.firstWhere(
      (f) => f.profile.id == friendId,
      orElse: () => friends.first,
    );
    final p = friend.profile;
    final isBuddy = ref.watch(isBuddyProvider(p.id));
    final buddy = ref.watch(buddyProvider);
    final hasOtherBuddy = buddy != null && buddy.buddyId != p.id;

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: PremiumBackground(
        child: SafeArea(
          child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Back
              Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: const Icon(Icons.arrow_back_rounded, color: AppColors.textPrimary),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Reactions
              const ReactionRow(counts: {'fire': 3, 'clap': 5}),
              const SizedBox(height: 16),

              // Avatar
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(color: p.avatarColor, shape: BoxShape.circle),
                child: Center(
                  child: Text(p.name[0].toUpperCase(), style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w600, color: Colors.white)),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(p.name, style: AppType.h1),
                  const SizedBox(width: 8),
                  LevelBadge(level: p.level),
                ],
              ),
              Text(p.title, style: AppType.body.copyWith(color: AppColors.textSecondary)),
              const SizedBox(height: 24),

              // Today
              AppCard(
                child: Center(
                  child: Column(
                    children: [
                      Text(l.today, style: AppType.caption),
                      const SizedBox(height: 4),
                      Text(
                        '${friend.todayMinutes}dk',
                        style: AppType.monoDisplay.copyWith(
                          color: friend.todayMinutes < 120 ? AppColors.ringGood : friend.todayMinutes < 240 ? AppColors.ringWarning : AppColors.ringDanger,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Stats
              AppCard(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _Stat(label: l.streak, value: '${p.streak}'),
                    _Stat(label: l.level, value: '${p.level}'),
                    _Stat(label: l.pointsLabel, value: '${p.totalPoints}'),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Top app
              AppCard(
                child: Row(
                  children: [
                    Text(l.mostUsedLabel, style: AppType.caption),
                    const SizedBox(width: 8),
                    Text(friend.topApp, style: AppType.h3),
                    const Spacer(),
                    Text('${friend.topAppMinutes}dk', style: AppType.body.copyWith(color: AppColors.textSecondary)),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Accountability Buddy CTA
              _BuddyCta(
                isBuddy: isBuddy,
                sharedStreak: isBuddy ? (buddy?.sharedStreak ?? 0) : 0,
                hasOtherBuddy: hasOtherBuddy,
                otherBuddyName: buddy?.buddyName,
                onPair: () async {
                  HapticService.success();
                  await ref
                      .read(buddyProvider.notifier)
                      .pairWith(p.id, p.name);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${p.name} artık buddy\'n — +%25 O₂ bonusu aktif'),
                        duration: const Duration(seconds: 3),
                      ),
                    );
                  }
                },
                onUnpair: () async {
                  HapticService.warning();
                  await ref.read(buddyProvider.notifier).unpair();
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Buddy bağlantın kesildi'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 12),

              // Duel button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.bolt_rounded),
                  label: Text(l.startDuelAction),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.neonOrange,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
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

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
        Text(label, style: AppType.label),
      ],
    );
  }
}

class _BuddyCta extends StatelessWidget {
  const _BuddyCta({
    required this.isBuddy,
    required this.sharedStreak,
    required this.hasOtherBuddy,
    required this.otherBuddyName,
    required this.onPair,
    required this.onUnpair,
  });

  final bool isBuddy;
  final int sharedStreak;
  final bool hasOtherBuddy;
  final String? otherBuddyName;
  final VoidCallback onPair;
  final VoidCallback onUnpair;

  @override
  Widget build(BuildContext context) {
    if (isBuddy) {
      return Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.neonGreen.withValues(alpha: 0.12),
              AppColors.accentBlue.withValues(alpha: 0.08),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.neonGreen.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.neonGreen.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.handshake_rounded,
                  color: AppColors.neonGreen, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Buddy',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.neonGreen,
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (sharedStreak > 0)
                        Text(
                          '🔥 $sharedStreak ortak gün',
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.textSecondary,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    '+%25 O₂ bonusu — birbirinizi koruyun',
                    style: TextStyle(fontSize: 11, color: AppColors.textTertiary),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: onUnpair,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Kes',
                  style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton.icon(
        onPressed: hasOtherBuddy
            ? () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Zaten ${otherBuddyName ?? ""} ile buddy\'sin. Önce onu kes.',
                    ),
                    duration: const Duration(seconds: 2),
                  ),
                );
              }
            : onPair,
        icon: Icon(
          Icons.handshake_rounded,
          color: hasOtherBuddy ? Colors.white38 : Colors.black,
        ),
        label: Text(hasOtherBuddy ? 'Başka buddy\'n var' : 'Buddy ol'),
        style: ElevatedButton.styleFrom(
          backgroundColor: hasOtherBuddy
              ? Colors.white.withValues(alpha: 0.06)
              : AppColors.neonGreen,
          foregroundColor: hasOtherBuddy ? Colors.white38 : Colors.black,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
