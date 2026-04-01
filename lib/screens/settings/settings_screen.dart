import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme.dart';
import '../../widgets/app_card.dart';
import '../../providers/user_provider.dart';
import '../../widgets/premium_background.dart';
import '../../services/haptic_service.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: PremiumBackground(
        child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Ayarlar', style: AppTextStyles.h1),
              const SizedBox(height: 24),

              // Profile summary
              AppCard(
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(color: user.avatarColor, shape: BoxShape.circle),
                      child: Center(child: Text(user.name[0].toUpperCase(), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white))),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(user.name, style: AppTextStyles.h3),
                          Text('${user.city}, ${user.country}', style: AppTextStyles.bodySecondary),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right_rounded, color: AppColors.textTertiary),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Subscription
              AppCard(
                onTap: () {
                  HapticService.light();
                  context.push('/settings/subscription');
                },
                child: Row(
                  children: [
                    const Icon(Icons.star_rounded, color: AppColors.gold, size: 24),
                    const SizedBox(width: 12),
                    const Expanded(child: Text('Abonelik', style: AppTextStyles.h3)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: AppColors.cardBorder, borderRadius: BorderRadius.circular(8)),
                      child: const Text('Ücretsiz', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.chevron_right_rounded, color: AppColors.textTertiary),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Toggles
              AppCard(
                child: Column(
                  children: [
                    _ToggleRow(label: 'Bildirimler', value: true, onChanged: (_) {}),
                    const Divider(color: AppColors.cardBorder, height: 1),
                    _ToggleRow(label: 'Günlük Hatırlatıcı', value: true, onChanged: (_) {}),
                    const Divider(color: AppColors.cardBorder, height: 1),
                    _ToggleRow(label: 'Düello Bildirimleri', value: false, onChanged: (_) {}),
                    const Divider(color: AppColors.cardBorder, height: 1),
                    _ToggleRow(label: 'Konum Paylaşımı', value: true, onChanged: (_) {}),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              Center(
                child: GestureDetector(
                  onTap: () {
                    HapticService.warning();
                    context.go('/onboarding');
                  },
                  child: const Text('Çıkış Yap', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.ringDanger)),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: Text('gooffgrid v1.0.0', style: AppTextStyles.labelSmall),
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

class _ToggleRow extends StatelessWidget {
  const _ToggleRow({required this.label, required this.value, required this.onChanged});
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(child: Text(label, style: AppTextStyles.body)),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.neonGreen,
            activeTrackColor: AppColors.neonGreen.withOpacity(0.3),
            inactiveThumbColor: AppColors.textTertiary,
            inactiveTrackColor: AppColors.cardBorder,
          ),
        ],
      ),
    );
  }
}
