import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme.dart';
import '../../widgets/premium_background.dart';
import '../../widgets/app_card.dart';
import '../../providers/friends_provider.dart';

class DuelInviteScreen extends ConsumerStatefulWidget {
  const DuelInviteScreen({super.key});

  @override
  ConsumerState<DuelInviteScreen> createState() => _DuelInviteScreenState();
}

class _DuelInviteScreenState extends ConsumerState<DuelInviteScreen> {
  int _selectedDuration = 3;
  String? _selectedFriend;

  static const _durationLabels = ['1s', '3s', '12s', '24s', '1 hafta'];

  @override
  Widget build(BuildContext context) {
    final friends = ref.watch(friendsProvider);

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
                  const Text('Yeni Duel', style: AppTextStyles.h1),
                ],
              ),
              const SizedBox(height: 24),

              const Text('Sure', style: AppTextStyles.label),
              const SizedBox(height: 12),
              Row(
                children: List.generate(5, (i) {
                  final selected = _selectedDuration == i;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedDuration = i),
                      child: Container(
                        margin: EdgeInsets.only(right: i < 4 ? 8 : 0),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: selected ? AppColors.neonGreen : AppColors.cardBg,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: selected ? AppColors.neonGreen : AppColors.cardBorder),
                        ),
                        child: Center(
                          child: Text(
                            _durationLabels[i],
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: selected ? Colors.black : AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 24),

              const Text('Arkadas Sec', style: AppTextStyles.label),
              const SizedBox(height: 12),
              ...friends.map((f) {
                final selected = _selectedFriend == f.profile.id;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: AppCard(
                    borderColor: selected ? AppColors.neonGreen : null,
                    onTap: () => setState(() => _selectedFriend = f.profile.id),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(color: f.profile.avatarColor, shape: BoxShape.circle),
                          child: Center(
                            child: Text(f.profile.name[0], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(child: Text(f.profile.name, style: AppTextStyles.h3)),
                        Text('${f.todayMinutes}dk', style: AppTextStyles.bodySecondary),
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(height: 16),

              AppCard(
                child: Column(
                  children: [
                    const Icon(Icons.link_rounded, color: AppColors.textSecondary, size: 32),
                    const SizedBox(height: 8),
                    Text('veya Link Gonder', style: AppTextStyles.bodySecondary),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _selectedFriend != null ? () => context.pop() : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.neonGreen,
                    foregroundColor: Colors.black,
                    disabledBackgroundColor: AppColors.cardBg,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  child: const Text('Baslat'),
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
